Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E04D35B855C
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 11:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiINJnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 05:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiINJmv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 05:42:51 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4C854667
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 02:42:42 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id gh9so33400923ejc.8
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 02:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=EsIWv+wTCRVqrb044S2FPqgJBngBno6ELwQQ8lFS5uo=;
        b=HOI5LQoaJ050954GMmqfckcPIGPk8gBmKpXKtqu+ZEv/AXb0eDPEu2Iwt4dVRwUz8G
         83EVP6XHCVPQVIKCpZhdxCS0ZDqOX9VLO4aJK5CM5bmPv9VaYqnw5KYoDQTcKS998pA+
         0X3YB1ZgL3STr0S4fiZCpA+My1tvddLMPHVGIS/6HyKvYa+Sf0g/j5msAaBoSI31uEj2
         suFbuupGlEYBep+I7wFtog34ipNFe2ACCpbQ0haZ8KCfDGy290Lbct18XNMeUAKo8xIM
         D+Z8FrQknJgFRWmfFfwifLUGOa2PKC2sc3qg0US6TUuwf5chW6sRW5rlQ+3MNEYBRiht
         miHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=EsIWv+wTCRVqrb044S2FPqgJBngBno6ELwQQ8lFS5uo=;
        b=dFE0ZcwSGy3w8h3AAoFgnuEHUJ+7DoRtBOR12nTCWQwKOoXFQfO3+sPOIwL064O9+b
         /xJfngNZvY36fKAEUAncE+1Ctle1BvN41zGj5hI/3cHd+xcYVASF8NYLBwzsVZore9lD
         pMBakZFI5Plx+Nf+obHkcDaYx3pmDaqfDG42aHMQzkwrM/mlkxDkPp6d+HWJfWrnojhC
         QuJJ1HZe5Jjz4ofGDyYDjpSVd+CCz/+CKHoyPJZwxkPHxTOy7bi8NLgFR8LwiDFcz9az
         +Qoux1L5otyw9mo4hdD++gIEd4RykVwtaYEcLG3oWSFthzi6d9ysFUIolmq/dZXbsHaJ
         rNsQ==
X-Gm-Message-State: ACgBeo28Gk4DeTq42zIiOBquDcE5NsXAOxYvUweBmLRXirf3EHy4V8bj
        lOnNBG1yvM+vZ3eEOYFDFTsmVDEbXKU1RkDPSQKhXQ==
X-Google-Smtp-Source: AA6agR6GniJLIqAT83Fz7sc1hxWo4j7+A9oGkzWtcsCwPilgzkciv0/jPBnpwQlM2w4OT/aUKfi0hdb0JHDvfceJhSk=
X-Received: by 2002:a17:906:5d04:b0:77f:ca9f:33d1 with SMTP id
 g4-20020a1709065d0400b0077fca9f33d1mr6271100ejt.526.1663148560891; Wed, 14
 Sep 2022 02:42:40 -0700 (PDT)
MIME-Version: 1.0
References: <202209130205.CPp5dG1q-lkp@intel.com> <YyGghUdcrOdrR0ep@smile.fi.intel.com>
In-Reply-To: <YyGghUdcrOdrR0ep@smile.fi.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 14 Sep 2022 11:42:29 +0200
Message-ID: <CACRpkdYfLNr04Y_YUFeuerGokxB0GCqQeEQEgQB=OR3k8N9Jbw@mail.gmail.com>
Subject: Re: [lpieralisi-pci:pci/dwc 3/3] drivers/pci/controller/dwc/pcie-kirin.c:373:15:
 error: implicit declaration of function 'gpiod_count'
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 11:38 AM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> On Tue, Sep 13, 2022 at 02:45:12AM +0800, kernel test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
> > head:   2023f9c9190e657b9853a442899a52b14253aea3
> > commit: 2023f9c9190e657b9853a442899a52b14253aea3 [3/3] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
> > config: xtensa-randconfig-r023-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130205.CPp5dG1q-lkp@intel.com/config)
> > compiler: xtensa-linux-gcc (GCC) 12.1.0
> > reproduce (this is a W=1 build):
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=2023f9c9190e657b9853a442899a52b14253aea3
> >         git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> >         git fetch --no-tags lpieralisi-pci pci/dwc
> >         git checkout 2023f9c9190e657b9853a442899a52b14253aea3
> >         # save the config file
> >         mkdir build_dir && cp config build_dir/.config
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/pci/controller/dwc/
> >
> > If you fix the issue, kindly add following tag where applicable
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/pci/controller/dwc/pcie-kirin.c: In function 'kirin_pcie_get_gpio_enable':
> > >> drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration of function 'gpiod_count' [-Werror=implicit-function-declaration]
> >      373 |         ret = gpiod_count(dev, "hisilicon,clken");
> >          |               ^~~~~~~~~~~
> >    cc1: some warnings being treated as errors
>
>
> It's only possible if we miss to include gpio/consumer.h which is the case here
> (at least on some architectures).
>
> Lorenzo, what do you want me to do? I can add the missed include, but looking
> at the code it needs conversion to GPIO descriptors altogether.
>
> Linus, don't you have a patch for this driver already? (I don't remember
> if I have seen a branch in your tree regarding this long-standing conversion
> to GPIO descriptors all over the kernel.)

Not me, by Dmitry T sent some really nice PCI host GPIOD conversions
recently, not this one though.

Yours,
Linus Walleij
