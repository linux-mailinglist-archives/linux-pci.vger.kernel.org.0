Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9896D5B8531
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 11:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiINJjA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 05:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231631AbiINJii (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 05:38:38 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCEF1EAEF
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 02:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663148300; x=1694684300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPqFXkvv1d37aLSCEha7O82gxUqqYai5MoBm4CuQTJ4=;
  b=T9pjxrcUiyZYPfU5zWKnat8FkNCfsm4KQekGsmKlmHiXuw8tJHwkvO8w
   vEdb6hnDXGCqgVGHJYD/BqbuAJoHTpDFLrLQyGKQ6Ky92GdSiykoutRB8
   sfW5ednEBwc5sDd6Y0fqHnZEYh5GesHPmQN84TQtss0V4soL4ftzSOtnZ
   jRB22FTfCGpNRJzaIu+6pukLom3Ym+15mJ5RkYpxQmNfgDJqprQuQm2A4
   20ztKJ63Pyw3S6syryQ/CoR7Q8lsO4fU1NmekO0WOfIIT1shDWxooOsR0
   eXKUVzEb8cC0sARsMGXiNGtBPE6QWAtHIEdDzz3eQLbxPewzIj84sQv2W
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10469"; a="285425099"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="285425099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 02:38:19 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="567944358"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 02:38:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1oYOoP-0028Zc-2v;
        Wed, 14 Sep 2022 12:36:05 +0300
Date:   Wed, 14 Sep 2022 12:36:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     kbuild-all@lists.01.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: Re: [lpieralisi-pci:pci/dwc 3/3]
 drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration
 of function 'gpiod_count'
Message-ID: <YyGghUdcrOdrR0ep@smile.fi.intel.com>
References: <202209130205.CPp5dG1q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202209130205.CPp5dG1q-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 02:45:12AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
> head:   2023f9c9190e657b9853a442899a52b14253aea3
> commit: 2023f9c9190e657b9853a442899a52b14253aea3 [3/3] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
> config: xtensa-randconfig-r023-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130205.CPp5dG1q-lkp@intel.com/config)
> compiler: xtensa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=2023f9c9190e657b9853a442899a52b14253aea3
>         git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
>         git fetch --no-tags lpieralisi-pci pci/dwc
>         git checkout 2023f9c9190e657b9853a442899a52b14253aea3
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/pci/controller/dwc/
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/pci/controller/dwc/pcie-kirin.c: In function 'kirin_pcie_get_gpio_enable':
> >> drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration of function 'gpiod_count' [-Werror=implicit-function-declaration]
>      373 |         ret = gpiod_count(dev, "hisilicon,clken");
>          |               ^~~~~~~~~~~
>    cc1: some warnings being treated as errors


It's only possible if we miss to include gpio/consumer.h which is the case here
(at least on some architectures).

Lorenzo, what do you want me to do? I can add the missed include, but looking
at the code it needs conversion to GPIO descriptors altogether.

Linus, don't you have a patch for this driver already? (I don't remember
if I have seen a branch in your tree regarding this long-standing conversion
to GPIO descriptors all over the kernel.)

-- 
With Best Regards,
Andy Shevchenko


