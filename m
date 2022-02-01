Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3147C4A559C
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 04:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232972AbiBAD1R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 22:27:17 -0500
Received: from mga18.intel.com ([134.134.136.126]:16888 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232970AbiBAD1Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 22:27:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643686036; x=1675222036;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=uvfPs006VLHlDm78FLdP2UhYjxVDqA3qOwYrLqfzp+M=;
  b=UlZX9GtfvrEBs2zbeGQwyUlXMEnAz9GOM2tTtfObecoFxhtqsapw6rqS
   Nq/664lZ/ZZQQwfl+FaZZZ/bZq6AvykSt73N95hQGYTlJfg9n0xNqjHBX
   UBwQDxpB0r95+DQfrVM1INrSbHGEtDYwCEZWiMHy9XQO7+q9QjesKbafS
   Z+7I976FhqOzhmG5/AsqrySSHOX/YMtJQGwDTfLn8uPDOkyYCWQyziw3w
   dBCwVfxNK9TiEb3ssIF0iYWPJc7cU/XrlS4XgfhVyXkjgoSwcWdtwLKsO
   RLu3nhkN4J1KV/kAhgGnhiR9unGzX7A1NUkjsGdChL6iN63Myxp2XAU9E
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="231183777"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="231183777"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 19:27:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="698260533"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 31 Jan 2022 19:27:14 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEjp4-000SiV-81; Tue, 01 Feb 2022 03:27:14 +0000
Date:   Tue, 1 Feb 2022 11:26:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org
Subject: [helgaas-pci:for-linus 1/1]
 drivers/pci/controller/cadence/pci-j721e.c:510:30: warning: variable 'rc' is
 uninitialized when used here
Message-ID: <202202011117.2J6tELXm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git for-linus
head:   a00908f9feb6a654adbc2b08241a61e491cfddd4
commit: a00908f9feb6a654adbc2b08241a61e491cfddd4 [1/1] PCI: j721e: Initialize pcie->cdns_pcie before using it
config: x86_64-randconfig-a011-20220131 (https://download.01.org/0day-ci/archive/20220201/202202011117.2J6tELXm-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 2cdbaca3943a4d6259119f185656328bd3805b68)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=a00908f9feb6a654adbc2b08241a61e491cfddd4
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci for-linus
        git checkout a00908f9feb6a654adbc2b08241a61e491cfddd4
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pci/controller/cadence/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pci-j721e.c:510:30: warning: variable 'rc' is uninitialized when used here [-Wuninitialized]
                   ret = cdns_pcie_host_setup(rc);
                                              ^~
   drivers/pci/controller/cadence/pci-j721e.c:359:25: note: initialize the variable 'rc' to silence this warning
           struct cdns_pcie_rc *rc;
                                  ^
                                   = NULL
   1 warning generated.


vim +/rc +510 drivers/pci/controller/cadence/pci-j721e.c

f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  350  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  351  static int j721e_pcie_probe(struct platform_device *pdev)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  352  {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  353  	struct device *dev = &pdev->dev;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  354  	struct device_node *node = dev->of_node;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  355  	struct pci_host_bridge *bridge;
72de208f2bda3c Bjorn Helgaas          2021-12-22  356  	const struct j721e_pcie_data *data;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  357  	struct cdns_pcie *cdns_pcie;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  358  	struct j721e_pcie *pcie;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  359  	struct cdns_pcie_rc *rc;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  360  	struct cdns_pcie_ep *ep;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  361  	struct gpio_desc *gpiod;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  362  	void __iomem *base;
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  363  	struct clk *clk;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  364  	u32 num_lanes;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  365  	u32 mode;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  366  	int ret;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  367  	int irq;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  368  
72de208f2bda3c Bjorn Helgaas          2021-12-22  369  	data = of_device_get_match_data(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  370  	if (!data)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  371  		return -EINVAL;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  372  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  373  	mode = (u32)data->mode;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  374  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  375  	pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  376  	if (!pcie)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  377  		return -ENOMEM;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  378  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  379  	switch (mode) {
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  380  	case PCI_MODE_RC:
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  381  		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  382  			return -ENODEV;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  383  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  384  		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  385  		if (!bridge)
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  386  			return -ENOMEM;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  387  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  388  		if (!data->byte_access_allowed)
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  389  			bridge->ops = &cdns_ti_pcie_host_ops;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  390  		rc = pci_host_bridge_priv(bridge);
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  391  		rc->quirk_retrain_flag = data->quirk_retrain_flag;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  392  		rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  393  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  394  		cdns_pcie = &rc->pcie;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  395  		cdns_pcie->dev = dev;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  396  		cdns_pcie->ops = &j721e_pcie_ops;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  397  		pcie->cdns_pcie = cdns_pcie;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  398  		break;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  399  	case PCI_MODE_EP:
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  400  		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP))
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  401  			return -ENODEV;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  402  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  403  		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  404  		if (!ep)
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  405  			return -ENOMEM;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  406  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  407  		ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  408  
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  409  		cdns_pcie = &ep->pcie;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  410  		cdns_pcie->dev = dev;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  411  		cdns_pcie->ops = &j721e_pcie_ops;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  412  		pcie->cdns_pcie = cdns_pcie;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  413  		break;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  414  	default:
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  415  		dev_err(dev, "INVALID device type %d\n", mode);
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  416  		return 0;
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  417  	}
a00908f9feb6a6 Bjorn Helgaas          2022-01-27  418  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  419  	pcie->mode = mode;
f1de58802f0fff Kishon Vijay Abraham I 2021-08-11  420  	pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  421  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  422  	base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  423  	if (IS_ERR(base))
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  424  		return PTR_ERR(base);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  425  	pcie->intd_cfg_base = base;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  426  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  427  	base = devm_platform_ioremap_resource_byname(pdev, "user_cfg");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  428  	if (IS_ERR(base))
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  429  		return PTR_ERR(base);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  430  	pcie->user_cfg_base = base;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  431  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  432  	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  433  	if (ret || num_lanes > MAX_LANES)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  434  		num_lanes = 1;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  435  	pcie->num_lanes = num_lanes;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  436  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  437  	if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  438  		return -EINVAL;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  439  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  440  	irq = platform_get_irq_byname(pdev, "link_state");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  441  	if (irq < 0)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  442  		return irq;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  443  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  444  	dev_set_drvdata(dev, pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  445  	pm_runtime_enable(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  446  	ret = pm_runtime_get_sync(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  447  	if (ret < 0) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  448  		dev_err(dev, "pm_runtime_get_sync failed\n");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  449  		goto err_get_sync;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  450  	}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  451  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  452  	ret = j721e_pcie_ctrl_init(pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  453  	if (ret < 0) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  454  		dev_err(dev, "pm_runtime_get_sync failed\n");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  455  		goto err_get_sync;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  456  	}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  457  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  458  	ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  459  			       "j721e-pcie-link-down-irq", pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  460  	if (ret < 0) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  461  		dev_err(dev, "failed to request link state IRQ %d\n", irq);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  462  		goto err_get_sync;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  463  	}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  464  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  465  	j721e_pcie_config_link_irq(pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  466  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  467  	switch (mode) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  468  	case PCI_MODE_RC:
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  469  		gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  470  		if (IS_ERR(gpiod)) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  471  			ret = PTR_ERR(gpiod);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  472  			if (ret != -EPROBE_DEFER)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  473  				dev_err(dev, "Failed to get reset GPIO\n");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  474  			goto err_get_sync;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  475  		}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  476  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  477  		ret = cdns_pcie_init_phy(dev, cdns_pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  478  		if (ret) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  479  			dev_err(dev, "Failed to init phy\n");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  480  			goto err_get_sync;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  481  		}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  482  
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  483  		clk = devm_clk_get_optional(dev, "pcie_refclk");
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  484  		if (IS_ERR(clk)) {
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  485  			ret = PTR_ERR(clk);
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  486  			dev_err(dev, "failed to get pcie_refclk\n");
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  487  			goto err_pcie_setup;
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  488  		}
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  489  
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  490  		ret = clk_prepare_enable(clk);
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  491  		if (ret) {
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  492  			dev_err(dev, "failed to enable pcie_refclk\n");
496bb18483cc04 Christophe JAILLET     2021-06-27  493  			goto err_pcie_setup;
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  494  		}
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  495  		pcie->refclk = clk;
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  496  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  497  		/*
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  498  		 * "Power Sequencing and Reset Signal Timings" table in
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  499  		 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  500  		 * indicates PERST# should be deasserted after minimum of 100us
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  501  		 * once REFCLK is stable. The REFCLK to the connector in RC
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  502  		 * mode is selected while enabling the PHY. So deassert PERST#
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  503  		 * after 100 us.
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  504  		 */
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  505  		if (gpiod) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  506  			usleep_range(100, 200);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  507  			gpiod_set_value_cansleep(gpiod, 1);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  508  		}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  509  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22 @510  		ret = cdns_pcie_host_setup(rc);
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  511  		if (ret < 0) {
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  512  			clk_disable_unprepare(pcie->refclk);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  513  			goto err_pcie_setup;
49e0efdce79125 Kishon Vijay Abraham I 2021-03-08  514  		}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  515  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  516  		break;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  517  	case PCI_MODE_EP:
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  518  		ret = cdns_pcie_init_phy(dev, cdns_pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  519  		if (ret) {
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  520  			dev_err(dev, "Failed to init phy\n");
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  521  			goto err_get_sync;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  522  		}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  523  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  524  		ret = cdns_pcie_ep_setup(ep);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  525  		if (ret < 0)
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  526  			goto err_pcie_setup;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  527  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  528  		break;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  529  	}
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  530  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  531  	return 0;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  532  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  533  err_pcie_setup:
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  534  	cdns_pcie_disable_phy(cdns_pcie);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  535  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  536  err_get_sync:
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  537  	pm_runtime_put(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  538  	pm_runtime_disable(dev);
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  539  
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  540  	return ret;
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  541  }
f3e25911a430ed Kishon Vijay Abraham I 2020-07-22  542  

:::::: The code at line 510 was first introduced by commit
:::::: f3e25911a430ed16ec209929183df762fe9c785b PCI: j721e: Add TI J721E PCIe driver

:::::: TO: Kishon Vijay Abraham I <kishon@ti.com>
:::::: CC: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
