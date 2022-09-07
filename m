Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5345AFAF9
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 06:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbiIGEMI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 00:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbiIGEMH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 00:12:07 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0DC18001D;
        Tue,  6 Sep 2022 21:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662523925; x=1694059925;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=hF9VFjE5o4x272E7lgnZ7qAL5DuPlyB3SKdoJPydg8I=;
  b=cf/YUZIX4cLiUuQrv0R4CPAgIjNDexB08qLNeJRYS/2lcaxI+/WI5bFU
   kYDyBg6wS0bX5vfj0LoOY/161QcX4awy9Ou6+wqHmukRcU3cnWgXjoQIq
   ZI16owiV8wdgtJlkU2s2rRfkZXwpiD/k35mWsc2wx8v+mDYEQoFMfpBnd
   9UDKahjb6yMFn9xhTqpsO7WWzCxEBOcaxb2E/avdHqXkAGjRGKUqqpOk3
   cRrb2gDsNytKvn6xBNmYrN0BANG6P2po5ATzdQddaeqnrl4AZZg9IyBMa
   ssqVT2RRhteAkeLd5FHejlRPNs6UNdX8K7mz7xkZ91TAZTtGkF4BxWfE5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10462"; a="283771319"
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="283771319"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2022 21:12:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,295,1654585200"; 
   d="scan'208";a="942729143"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 06 Sep 2022 21:12:02 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oVmPx-00065l-1e;
        Wed, 07 Sep 2022 04:12:01 +0000
Date:   Wed, 7 Sep 2022 12:11:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI: mvebu: switch to using gpiod API
Message-ID: <202209071255.xlxq6qnE-lkp@intel.com>
References: <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906204301.3736813-2-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Dmitry,

I love your patch! Yet something to improve:

[auto build test ERROR on helgaas-pci/next]
[also build test ERROR on linus/master v6.0-rc4 next-20220906]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Dmitry-Torokhov/PCI-histb-switch-to-using-gpiod-API/20220907-044417
base:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220907/202209071255.xlxq6qnE-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/90d5c7ec598d196395d3a5934099b56d1c8e071a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Dmitry-Torokhov/PCI-histb-switch-to-using-gpiod-API/20220907-044417
        git checkout 90d5c7ec598d196395d3a5934099b56d1c8e071a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/pci-mvebu.c: In function 'mvebu_pcie_irq_handler':
>> drivers/pci/controller/pci-mvebu.c:1100:9: error: implicit declaration of function 'chained_irq_enter'; did you mean 'ct_irq_enter'? [-Werror=implicit-function-declaration]
    1100 |         chained_irq_enter(chip, desc);
         |         ^~~~~~~~~~~~~~~~~
         |         ct_irq_enter
>> drivers/pci/controller/pci-mvebu.c:1115:9: error: implicit declaration of function 'chained_irq_exit'; did you mean 'ct_irq_exit'? [-Werror=implicit-function-declaration]
    1115 |         chained_irq_exit(chip, desc);
         |         ^~~~~~~~~~~~~~~~
         |         ct_irq_exit
   cc1: some warnings being treated as errors


vim +1100 drivers/pci/controller/pci-mvebu.c

ec075262648f39 Pali Rohár 2022-02-22  1091  
ec075262648f39 Pali Rohár 2022-02-22  1092  static void mvebu_pcie_irq_handler(struct irq_desc *desc)
ec075262648f39 Pali Rohár 2022-02-22  1093  {
ec075262648f39 Pali Rohár 2022-02-22  1094  	struct mvebu_pcie_port *port = irq_desc_get_handler_data(desc);
ec075262648f39 Pali Rohár 2022-02-22  1095  	struct irq_chip *chip = irq_desc_get_chip(desc);
ec075262648f39 Pali Rohár 2022-02-22  1096  	struct device *dev = &port->pcie->pdev->dev;
ec075262648f39 Pali Rohár 2022-02-22  1097  	u32 cause, unmask, status;
ec075262648f39 Pali Rohár 2022-02-22  1098  	int i;
ec075262648f39 Pali Rohár 2022-02-22  1099  
ec075262648f39 Pali Rohár 2022-02-22 @1100  	chained_irq_enter(chip, desc);
ec075262648f39 Pali Rohár 2022-02-22  1101  
ec075262648f39 Pali Rohár 2022-02-22  1102  	cause = mvebu_readl(port, PCIE_INT_CAUSE_OFF);
ec075262648f39 Pali Rohár 2022-02-22  1103  	unmask = mvebu_readl(port, PCIE_INT_UNMASK_OFF);
ec075262648f39 Pali Rohár 2022-02-22  1104  	status = cause & unmask;
ec075262648f39 Pali Rohár 2022-02-22  1105  
ec075262648f39 Pali Rohár 2022-02-22  1106  	/* Process legacy INTx interrupts */
ec075262648f39 Pali Rohár 2022-02-22  1107  	for (i = 0; i < PCI_NUM_INTX; i++) {
ec075262648f39 Pali Rohár 2022-02-22  1108  		if (!(status & PCIE_INT_INTX(i)))
ec075262648f39 Pali Rohár 2022-02-22  1109  			continue;
ec075262648f39 Pali Rohár 2022-02-22  1110  
ec075262648f39 Pali Rohár 2022-02-22  1111  		if (generic_handle_domain_irq(port->intx_irq_domain, i) == -EINVAL)
ec075262648f39 Pali Rohár 2022-02-22  1112  			dev_err_ratelimited(dev, "unexpected INT%c IRQ\n", (char)i+'A');
ec075262648f39 Pali Rohár 2022-02-22  1113  	}
ec075262648f39 Pali Rohár 2022-02-22  1114  
ec075262648f39 Pali Rohár 2022-02-22 @1115  	chained_irq_exit(chip, desc);
ec075262648f39 Pali Rohár 2022-02-22  1116  }
ec075262648f39 Pali Rohár 2022-02-22  1117  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
