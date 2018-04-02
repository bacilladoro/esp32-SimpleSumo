sumomoves = {
    attack={
        both={
            [1]={ -- Forward Fast
                left=180,
                right=0,
                duration=100
            }
        },
        left={
            [1]={ -- Pivot Left
                left=90+15,
                right=90-70,
                duration=100
            }
        },
        right={
            [1]={ -- Pivot Right
                left=90+70,
                right=90-15,
                duration=100
            }
        }
    },
    persue={
        [1]={ -- Forward Fast
            left=180,
            right=0,
            duration=100
        }
    },
    stayinring={
        both={
            [1]={ -- Move Backward
                left=90-25,
                right=90+25,
                duration={
                    min=300,
                    max=700
                }
            },
            [2]={ -- Rotate Right
                left=90+25,
                right=90+25,
                duration={
                    min=10,
                    max=550
                }
            }
        },
        right={
            [1]={ -- Backward Right
                left=90-45,
                right=90+20,
                duration={
                    min=300,
                    max=700
                }
            },
            [2]={ -- Rotate Left
                left=90-25,
                right=90-25,
                duration={
                    min=10,
                    max=550
                }
            }
        },
        left={
            [1]={ -- Backward Left
                left=90-20,
                right=90+45,
                duration={
                    min=300,
                    max=700
                }
            },
            [2]={ -- Rotate Right
                left=90+25,
                right=90+25,
                duration={
                    min=10,
                    max=550
                }
            }
        },
        back={
            [1]={ -- Forward Fast
                left=180,
                right=0,
                duration=1000
            }
        }
    },
    search={
        right={
            [1]={ -- Pivot Right
                left=90+70,
                right=90-15,
                duration=50
            },
            [2]={--Forward slow
                left=90+15,
                right=90-15,
                duration=50
            }
        },
        left={
            [1]={ -- Pivot Right
                left=90+15,
                right=90-70,
                duration=50
            },
            [2]={--Forward slow
                left=90+15,
                right=90-15,
                duration=50
            }
        }

    }
}