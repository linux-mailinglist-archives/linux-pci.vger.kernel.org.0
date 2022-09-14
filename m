Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06A35B85E9
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 12:05:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbiINKFd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 06:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiINKFc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 06:05:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C0313D4E
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 03:05:28 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id d64-20020a17090a6f4600b00202ce056566so8981509pjk.4
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 03:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=7ApQnmnGgngQkYs6FqhcOwcqbYmtpf1EMY0nmMLvjVw=;
        b=cqqXnm77nkgBpng8Mh6s57i6yiO0nQ5Nh74Cordf/S2V4yUTUmajG3BpivksAQjEn1
         hvPq3MB2RfQQmDOoZGTFXBhGpKEmRCan3QKnu+zcHDLbrTkVIJ3HUCy9AYy7WUIji8Em
         c49lZcUNTOenaNPdA25YW1KT+JhZdZfY22DeaJqvrh+K2dO3P6mIn7Q6B6XuVSgHk/g3
         F9nbstKubKf2kEdCXXISGjUxxQfY19FAxeXr06i0kbS422BJ+AaX+Qf/puZfBkEwP4lo
         IWZPHPm47Ky+cJxO+Ck6M3nao8uLokwlGsQXTycKr8PmyeMbbe7w3bLLtOniYsT/vkcP
         7e4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=7ApQnmnGgngQkYs6FqhcOwcqbYmtpf1EMY0nmMLvjVw=;
        b=Jg4YfvOtxBDTLw4VqQpmkKNquHMLOWoogJ4Eduq2PHkcZZNbmob4KlyJkGJgfj7j7p
         AJ7fnMaxP8CyykJszWugMoCBnyrbdSA9YWeFkbHFfD/n64syFQWqh5wJCeAvpqP4gyqH
         tUoATBRALVMddtchloiI+DpFHY1QcKn5VsAN0jJIPM0CjnadJ/zv0cjr9KHS2XcJKoaz
         iZu1GhQwJ9FtuVjefQsIyoZc6PXlwCSTQKgaYG7aDGXU9Bg+kv29ZxRLQk3qQRTr96L3
         UmGmA0MrhdR2FA+ieNydxJYjFqbUhZZqm1XmPvK58yECRp0dmA8zqO+axAOie4oG/EFt
         XjrA==
X-Gm-Message-State: ACrzQf0GDG6q+ypII98fjzTYPKF/eeQG32lDNbIZ0fvpbMqMbufNRtO0
        KgOuGcvlUpu+o/53nbCJSPI=
X-Google-Smtp-Source: AMsMyM6PWdQTLpLiNI9KX/KVZTNKBKcS2fXCwxEsOsv11W9BQhoPMUKfYAiGCbNJQP7CxmxtqfUiAw==
X-Received: by 2002:a17:90b:1b50:b0:202:f495:6b43 with SMTP id nv16-20020a17090b1b5000b00202f4956b43mr3969807pjb.85.1663149927812;
        Wed, 14 Sep 2022 03:05:27 -0700 (PDT)
Received: from google.com ([2620:15c:202:201:2f68:fe7:a2e6:7595])
        by smtp.gmail.com with ESMTPSA id n16-20020a170902e55000b0016c1a1c1405sm10238330plf.222.2022.09.14.03.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 03:05:27 -0700 (PDT)
Date:   Wed, 14 Sep 2022 03:05:24 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [lpieralisi-pci:pci/dwc 3/3]
 drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration
 of function 'gpiod_count'
Message-ID: <YyGnZCscvI4eoePt@google.com>
References: <202209130205.CPp5dG1q-lkp@intel.com>
 <YyGghUdcrOdrR0ep@smile.fi.intel.com>
 <CACRpkdYfLNr04Y_YUFeuerGokxB0GCqQeEQEgQB=OR3k8N9Jbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdYfLNr04Y_YUFeuerGokxB0GCqQeEQEgQB=OR3k8N9Jbw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 11:42:29AM +0200, Linus Walleij wrote:
> On Wed, Sep 14, 2022 at 11:38 AM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Sep 13, 2022 at 02:45:12AM +0800, kernel test robot wrote:
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
> > > head:   2023f9c9190e657b9853a442899a52b14253aea3
> > > commit: 2023f9c9190e657b9853a442899a52b14253aea3 [3/3] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
> > > config: xtensa-randconfig-r023-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130205.CPp5dG1q-lkp@intel.com/config)
> > > compiler: xtensa-linux-gcc (GCC) 12.1.0
> > > reproduce (this is a W=1 build):
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=2023f9c9190e657b9853a442899a52b14253aea3
> > >         git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> > >         git fetch --no-tags lpieralisi-pci pci/dwc
> > >         git checkout 2023f9c9190e657b9853a442899a52b14253aea3
> > >         # save the config file
> > >         mkdir build_dir && cp config build_dir/.config
> > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/pci/controller/dwc/
> > >
> > > If you fix the issue, kindly add following tag where applicable
> > > Reported-by: kernel test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > >    drivers/pci/controller/dwc/pcie-kirin.c: In function 'kirin_pcie_get_gpio_enable':
> > > >> drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration of function 'gpiod_count' [-Werror=implicit-function-declaration]
> > >      373 |         ret = gpiod_count(dev, "hisilicon,clken");
> > >          |               ^~~~~~~~~~~
> > >    cc1: some warnings being treated as errors
> >
> >
> > It's only possible if we miss to include gpio/consumer.h which is the case here
> > (at least on some architectures).
> >
> > Lorenzo, what do you want me to do? I can add the missed include, but looking
> > at the code it needs conversion to GPIO descriptors altogether.
> >
> > Linus, don't you have a patch for this driver already? (I don't remember
> > if I have seen a branch in your tree regarding this long-standing conversion
> > to GPIO descriptors all over the kernel.)
> 
> Not me, by Dmitry T sent some really nice PCI host GPIOD conversions
> recently, not this one though.

No, I do not have any outstanding changes for this driver. Maybe Andy
can finish the conversion to gpiod?

Thanks.

-- 
Dmitry
