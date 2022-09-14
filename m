Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECC25B8B29
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 17:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbiINPBP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 11:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiINPBO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 11:01:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DEA67160
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 08:01:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7429B8191F
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 15:01:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35B3C433C1;
        Wed, 14 Sep 2022 15:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663167670;
        bh=GbRrJRSNYjdStOkdBgyVLVPdjNY5TO4UZrlZ/bHDvw4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YZXUhkDrKluovukPheFWfYTI5TkxTOVKR5riymAlYSzA8yW9zqrjSfbcniOpmgnNX
         507GuRni9pk2DUGY4GS+TJ9KilB09TH/WF0in/XTEn3QuU3oRcAaU//3OgKzf8Hmdn
         DLwBBkCOIH+VsHdynOOdtOD2yvuChN8ko0/bYdevCiXDg5JSREhCSNj4XB3OxIWj+I
         7CU95IMapuxwVhxjuAN3uuGgEp2pGVLe+ltm8wps7vFJjFHJhZvbbsTfMi7qPKxCen
         yBPtEQALuNyJdws2vlRCWO9OQ9awhUu4meI0PIuDa3CBIAq7guH0MlfKPddsFbIYdY
         9/EtpW7MbsQDQ==
Date:   Wed, 14 Sep 2022 17:01:05 +0200
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [lpieralisi-pci:pci/dwc 3/3]
 drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration
 of function 'gpiod_count'
Message-ID: <YyHssS+jZ9NlQdo+@lpieralisi>
References: <202209130205.CPp5dG1q-lkp@intel.com>
 <YyGghUdcrOdrR0ep@smile.fi.intel.com>
 <CACRpkdYfLNr04Y_YUFeuerGokxB0GCqQeEQEgQB=OR3k8N9Jbw@mail.gmail.com>
 <YyGnZCscvI4eoePt@google.com>
 <YyGpkSMaRKcav1C7@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyGpkSMaRKcav1C7@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 01:14:41PM +0300, Andy Shevchenko wrote:
> On Wed, Sep 14, 2022 at 03:05:24AM -0700, Dmitry Torokhov wrote:
> > On Wed, Sep 14, 2022 at 11:42:29AM +0200, Linus Walleij wrote:
> > > On Wed, Sep 14, 2022 at 11:38 AM Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > On Tue, Sep 13, 2022 at 02:45:12AM +0800, kernel test robot wrote:
> > > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
> > > > > head:   2023f9c9190e657b9853a442899a52b14253aea3
> > > > > commit: 2023f9c9190e657b9853a442899a52b14253aea3 [3/3] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
> > > > > config: xtensa-randconfig-r023-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130205.CPp5dG1q-lkp@intel.com/config)
> > > > > compiler: xtensa-linux-gcc (GCC) 12.1.0
> > > > > reproduce (this is a W=1 build):
> > > > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > > >         chmod +x ~/bin/make.cross
> > > > >         # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=2023f9c9190e657b9853a442899a52b14253aea3
> > > > >         git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> > > > >         git fetch --no-tags lpieralisi-pci pci/dwc
> > > > >         git checkout 2023f9c9190e657b9853a442899a52b14253aea3
> > > > >         # save the config file
> > > > >         mkdir build_dir && cp config build_dir/.config
> > > > >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/pci/controller/dwc/
> > > > >
> > > > > If you fix the issue, kindly add following tag where applicable
> > > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > >
> > > > > All errors (new ones prefixed by >>):
> > > > >
> > > > >    drivers/pci/controller/dwc/pcie-kirin.c: In function 'kirin_pcie_get_gpio_enable':
> > > > > >> drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration of function 'gpiod_count' [-Werror=implicit-function-declaration]
> > > > >      373 |         ret = gpiod_count(dev, "hisilicon,clken");
> > > > >          |               ^~~~~~~~~~~
> > > > >    cc1: some warnings being treated as errors
> > > >
> > > >
> > > > It's only possible if we miss to include gpio/consumer.h which is the case here
> > > > (at least on some architectures).
> > > >
> > > > Lorenzo, what do you want me to do? I can add the missed include, but looking
> > > > at the code it needs conversion to GPIO descriptors altogether.
> > > >
> > > > Linus, don't you have a patch for this driver already? (I don't remember
> > > > if I have seen a branch in your tree regarding this long-standing conversion
> > > > to GPIO descriptors all over the kernel.)
> > > 
> > > Not me, by Dmitry T sent some really nice PCI host GPIOD conversions
> > > recently, not this one though.
> > 
> > No, I do not have any outstanding changes for this driver. Maybe Andy
> > can finish the conversion to gpiod?
> 
> I can, but want to hear maintainer what is the best approach here.
> My scope of the changes is to get rid of of_gpio_named_count() in
> the exported namespace.

I can add the missed include to fix it and then you can apply the gpiod
changes on top of it.

Lorenzo
