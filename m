Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF1B35B6140
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiILSp3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 14:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiILSp2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 14:45:28 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6193020BE1
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 11:45:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663008327; x=1694544327;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=/pbWiI69DvSPYXp1aeVlBCfp5yZ+Lmp+avJfk2jUYNA=;
  b=G5mcuyu9xJLp8NPYJVdofImsA3lC8AnwyqWtrZYS6/f/x2662ZUQEhlh
   4DYTVynGLWwhJKKMFR2gPO0r/Fxk0/J9AklOYnPYXCeujZiy6JzCwA06T
   1ui7QSLpar3BpX5YeoMHh90TFpvqlN9iq/UU0Xw0XohXoGFSbm8dvToLc
   tPHIZuQ71wdRcDn+NjY+7ewhnSKTBGkFDf1t6oeuLDu0eoazwUXXx6WZU
   ZpmnVrVFUV9O51EBEqpOrs+7MbWtzrhZW0IdamX0TO+OfHQ4GNs1vrnWS
   tqtTtQYdam3CL5f3VPqQ5mPvPK2aDs4eqkSLozuV4GO2S7AODVTbzFwE0
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="284962078"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="284962078"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 11:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="567278712"
Received: from lkp-server02.sh.intel.com (HELO 4011df4f4fd3) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 12 Sep 2022 11:45:25 -0700
Received: from kbuild by 4011df4f4fd3 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oXoQu-0002kD-2X;
        Mon, 12 Sep 2022 18:45:24 +0000
Date:   Tue, 13 Sep 2022 02:45:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: [lpieralisi-pci:pci/dwc 3/3]
 drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration
 of function 'gpiod_count'
Message-ID: <202209130205.CPp5dG1q-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/dwc
head:   2023f9c9190e657b9853a442899a52b14253aea3
commit: 2023f9c9190e657b9853a442899a52b14253aea3 [3/3] PCI: dwc: Replace of_gpio_named_count() by gpiod_count()
config: xtensa-randconfig-r023-20220911 (https://download.01.org/0day-ci/archive/20220913/202209130205.CPp5dG1q-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=2023f9c9190e657b9853a442899a52b14253aea3
        git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
        git fetch --no-tags lpieralisi-pci pci/dwc
        git checkout 2023f9c9190e657b9853a442899a52b14253aea3
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=xtensa SHELL=/bin/bash drivers/pci/controller/dwc/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-kirin.c: In function 'kirin_pcie_get_gpio_enable':
>> drivers/pci/controller/dwc/pcie-kirin.c:373:15: error: implicit declaration of function 'gpiod_count' [-Werror=implicit-function-declaration]
     373 |         ret = gpiod_count(dev, "hisilicon,clken");
         |               ^~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/gpiod_count +373 drivers/pci/controller/dwc/pcie-kirin.c

   364	
   365	static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
   366					      struct platform_device *pdev)
   367	{
   368		struct device *dev = &pdev->dev;
   369		char name[32];
   370		int ret, i;
   371	
   372		/* This is an optional property */
 > 373		ret = gpiod_count(dev, "hisilicon,clken");
   374		if (ret < 0)
   375			return 0;
   376	
   377		if (ret > MAX_PCI_SLOTS) {
   378			dev_err(dev, "Too many GPIO clock requests!\n");
   379			return -EINVAL;
   380		}
   381	
   382		pcie->n_gpio_clkreq = ret;
   383	
   384		for (i = 0; i < pcie->n_gpio_clkreq; i++) {
   385			pcie->gpio_id_clkreq[i] = of_get_named_gpio(dev->of_node,
   386							    "hisilicon,clken-gpios", i);
   387			if (pcie->gpio_id_clkreq[i] < 0)
   388				return pcie->gpio_id_clkreq[i];
   389	
   390			sprintf(name, "pcie_clkreq_%d", i);
   391			pcie->clkreq_names[i] = devm_kstrdup_const(dev, name,
   392								    GFP_KERNEL);
   393			if (!pcie->clkreq_names[i])
   394				return -ENOMEM;
   395		}
   396	
   397		return 0;
   398	}
   399	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
