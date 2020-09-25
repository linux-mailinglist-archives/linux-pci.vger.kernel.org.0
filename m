Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 345592785B8
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 13:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbgIYLZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 07:25:59 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:45371 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgIYLZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Sep 2020 07:25:58 -0400
Received: from mail-qk1-f179.google.com ([209.85.222.179]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MgRYd-1kwCLc1vFX-00hvjC; Fri, 25 Sep 2020 13:25:55 +0200
Received: by mail-qk1-f179.google.com with SMTP id c2so2336103qkf.10;
        Fri, 25 Sep 2020 04:25:55 -0700 (PDT)
X-Gm-Message-State: AOAM5334jI9lUYdfqrX8c/lihGQjzVpaGFwoxlem6D/vZ2S3FuglYzFR
        7yrp8bmhO5GM3o/uSMd7SjmDENLgJlU8scQMdtg=
X-Google-Smtp-Source: ABdhPJwWQvaM6Vz+GqP/QiHN8MWCzHaGRxzRTsvYnBX59Ke/YE3u+ANi9IHrX2XXPEGJOp/WEQFkuy3Z7sPF8uMEWds=
X-Received: by 2002:a05:620a:15a7:: with SMTP id f7mr3352274qkk.3.1601033154195;
 Fri, 25 Sep 2020 04:25:54 -0700 (PDT)
MIME-Version: 1.0
References: <20200925072630.8157-1-sherry.sun@nxp.com>
In-Reply-To: <20200925072630.8157-1-sherry.sun@nxp.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 25 Sep 2020 13:25:38 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3fog3jE_cPUTELDkFKoO2FbCJufQiDZhfL2FsZ5s5q3Q@mail.gmail.com>
Message-ID: <CAK8P3a3fog3jE_cPUTELDkFKoO2FbCJufQiDZhfL2FsZ5s5q3Q@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add noncoherent platform support for vop driver
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     Sudeep Dutt <sudeep.dutt@intel.com>,
        Ashutosh Dixit <ashutosh.dixit@intel.com>,
        gregkh <gregkh@linuxfoundation.org>, wang.yi59@zte.com.cn,
        huang.zijiang@zte.com.cn,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-ntb@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:A6CRrB5zADy/SfDsnagYcP4KiTRZHOWhi5jsw46kMTQLTD9LZoa
 miVJV6TDFMsKOBdW+oSqjGdw5Bxin/aZnpnbwg5Q83hbZsKtU+kk8qpoW1SAB+m7u5okmdu
 e3ppY2o/qiG+O1ee0d0fkDOdqBSwWHv2C7JQZI7mcQklaOZJHv1Xy+uaBixsFMP/cVDF06u
 pXTeAFTOHiv1NejEzwVog==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:qejb5m8lqS8=:mMH7eS+fWs0JkVVhR0qGRf
 sT7Mc9xxLi0CnF3X8oh8qfaNL1FaZK64iZZLv51WHF1VuY0qPvStbjdSVqWP/GYZXrFgGq/OO
 vr/zXUs6reodSYicJNU/W8ZbgCfUmhBgMfuN2C/7dV+CPIGp3HmwSo5YZ+g+CAlG7JU5SCiu9
 nMwqXRM8yNJBSSsSyyMsPw7EmFhlQTAw+iBbhjwRxdjAcbwOvdY95hYYQjOR52NLNcalniSgx
 BzLmxon65EhN5SCDXYiNlzgDZBEcnZ9MjeWFUXMxLHMILYh4U4P+qigQN6t6TwC9s1HArgDHL
 8InZQN3DAO7pP+7C7aCuNNw7ft5gEky3UDxaNWrVfhKQYK4KvXh06t0crSYut476uABgurZFW
 URcafM0ylGHZBNrgJmj/8pEvrsM8Sa6E6PVNFmLHJ7Jkw/bHIPvCpqNfhgiS0K0X6oMvi5/67
 P3LDkmTp+kuAXiPXGfkJxySVF9yCqVm+IMs/SYuou2E076bCDWkKbcnrlhihXWEx1SIamHHYM
 A2b/oe4qi4VLhPEB33xsOKfi+p9qoRuO5ItqOAacox8q69pd73xOJsQm/PHe2U2skOBrPmtxc
 bBkU5gUYkcB40LVAAPAdPUMCfoQkJA0v7942tf9AGvvAXcvgtrCaMjfVl2dpdueM2E/78GREB
 vSQtQ9PYNSGH+t3aIn+arkiIBfeYKphsNxK/KmYq9rFOuJ5wSl084C5rCpTalyY2ievW513kT
 Pvu74Ix3vurWYDPUtWmtG3M+XV3yMeSKfXBar0HtCDzWJbSM7hh1PqIsQEzg8RxQyOREqdIOU
 xHQnR/YLzGNN9cIrCzMPnaYZqwsw3jbj0tNb6bWh1gmCassMEaQTjXNond3zrMELqCWBYbvEj
 HxNKkIBtspuD/4mvMEpMsiaIB7Jx2PBP3D6CYPAxWPRBvOcLLu4rqpf/glYpFCgVImf57P0Oo
 eVJQSoyqDNjfrfaLuFweTr4eoeznWCPA062nq8KOXQBCJ2h4x+LXX
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 9:27 AM Sherry Sun <sherry.sun@nxp.com> wrote:
>
> Change the way of allocating vring to support noncoherent platform for vop
> driver, and add some related dma changes to make sure noncoherent platform works
> well.

Could you describe why you are doing this? Are you using Intel MIC
devices on Arm hosts, or trying to reuse the code for other add-on
cards?

Note that we have a couple of frameworks in the kernel that try to
do some of the same things here, notably the NTB drivers and the
PCI endpoint support, both of which are designed to be somewhat
more generic than the MIC driver.

Have you considered using that instead?

         Arnd

> Sherry Sun (5):
>   misc: vop: change the way of allocating vring for noncoherent platform
>   misc: vop: change the way of allocating used ring
>   misc: vop: simply return the saved dma address instead of virt_to_phys
>   misc: vop: set VIRTIO_F_ACCESS_PLATFORM for nocoherent platform
>   misc: vop: mapping kernel memory to user space as noncached
>
>  drivers/misc/mic/bus/vop_bus.h    |   2 +
>  drivers/misc/mic/host/mic_boot.c  |   8 ++
>  drivers/misc/mic/vop/vop_main.c   |  51 +++++++++----
>  drivers/misc/mic/vop/vop_vringh.c | 117 ++++++++++++++++++++----------
>  4 files changed, 125 insertions(+), 53 deletions(-)
>
> --
> 2.17.1
>
