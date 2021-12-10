Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5E74709BA
	for <lists+linux-pci@lfdr.de>; Fri, 10 Dec 2021 20:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343524AbhLJTIy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Dec 2021 14:08:54 -0500
Received: from mga05.intel.com ([192.55.52.43]:11323 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244771AbhLJTIx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Dec 2021 14:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639163118; x=1670699118;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=4QDWu/RjloXmKRMUHsT2Ng7s0gnpZwjAqRoUzFZc3kQ=;
  b=YKCI7ky246wkD085NddnYdbPNDOchpIzK8wtRbJCK3IYvRwYENClf5/U
   ehgoZAlu2wf0WCl4tn/3ROQNgB2spxe8IK+p6PT32fc/nJFu4/WFG1I4z
   cBHdHpiEcBrINgVVqWIwlKp77fIwqIBg/WwWFzOM2CtOffsqCNqVOELZH
   c+Cc6IlAg4u9a3qglcXIsr6lGZxIr3Sm5iXmnoykIBksQI83jIarpYCgZ
   8kCWVSDRn7CipzHpxTBPhvMhw2jdsH4LWFPXKipjeB+vVFMORpu7H3Qnx
   wRfeYCdayzxYALjVjVnJ8eG29VmsMq6gU14YGlJQ91f6iIV6M1gxuPw4S
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="324685467"
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="324685467"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 11:05:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,196,1635231600"; 
   d="scan'208";a="544072951"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 10 Dec 2021 11:05:16 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvlCl-0003aL-IS; Fri, 10 Dec 2021 19:05:15 +0000
Date:   Sat, 11 Dec 2021 03:04:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-pci@vger.kernel.org
Subject: [helgaas-pci:pci/driver-cleanup 8/27]
 drivers/pci/controller/cadence/pci-j721e.c:370:7: error: assigning to
 'struct j721e_pcie_data *' from 'const void *' discards qualifiers
Message-ID: <202112110238.rZl7p5gE-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/driver-cleanup
head:   24d25dd0ddf8c2b924a1fafc51dd0e578d304c3a
commit: 667c60afad253791929991b2dc2ed5417bba2787 [8/27] PCI: j721e: Drop pointless of_device_get_match_data() cast
config: arm64-randconfig-r014-20211210 (https://download.01.org/0day-ci/archive/20211211/202112110238.rZl7p5gE-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=667c60afad253791929991b2dc2ed5417bba2787
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/driver-cleanup
        git checkout 667c60afad253791929991b2dc2ed5417bba2787
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/pci/controller/cadence/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pci-j721e.c:370:7: error: assigning to 'struct j721e_pcie_data *' from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
           data = of_device_get_match_data(dev);
                ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   1 error generated.


vim +370 drivers/pci/controller/cadence/pci-j721e.c

   351	
   352	static int j721e_pcie_probe(struct platform_device *pdev)
   353	{
   354		struct device *dev = &pdev->dev;
   355		struct device_node *node = dev->of_node;
   356		struct pci_host_bridge *bridge;
   357		struct j721e_pcie_data *data;
   358		struct cdns_pcie *cdns_pcie;
   359		struct j721e_pcie *pcie;
   360		struct cdns_pcie_rc *rc;
   361		struct cdns_pcie_ep *ep;
   362		struct gpio_desc *gpiod;
   363		void __iomem *base;
   364		struct clk *clk;
   365		u32 num_lanes;
   366		u32 mode;
   367		int ret;
   368		int irq;
   369	
 > 370		data = of_device_get_match_data(dev);
   371		if (!data)
   372			return -EINVAL;
   373	
   374		mode = (u32)data->mode;
   375	
   376		pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
   377		if (!pcie)
   378			return -ENOMEM;
   379	
   380		pcie->dev = dev;
   381		pcie->mode = mode;
   382		pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
   383	
   384		base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
   385		if (IS_ERR(base))
   386			return PTR_ERR(base);
   387		pcie->intd_cfg_base = base;
   388	
   389		base = devm_platform_ioremap_resource_byname(pdev, "user_cfg");
   390		if (IS_ERR(base))
   391			return PTR_ERR(base);
   392		pcie->user_cfg_base = base;
   393	
   394		ret = of_property_read_u32(node, "num-lanes", &num_lanes);
   395		if (ret || num_lanes > MAX_LANES)
   396			num_lanes = 1;
   397		pcie->num_lanes = num_lanes;
   398	
   399		if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
   400			return -EINVAL;
   401	
   402		irq = platform_get_irq_byname(pdev, "link_state");
   403		if (irq < 0)
   404			return irq;
   405	
   406		dev_set_drvdata(dev, pcie);
   407		pm_runtime_enable(dev);
   408		ret = pm_runtime_get_sync(dev);
   409		if (ret < 0) {
   410			dev_err(dev, "pm_runtime_get_sync failed\n");
   411			goto err_get_sync;
   412		}
   413	
   414		ret = j721e_pcie_ctrl_init(pcie);
   415		if (ret < 0) {
   416			dev_err(dev, "pm_runtime_get_sync failed\n");
   417			goto err_get_sync;
   418		}
   419	
   420		ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
   421				       "j721e-pcie-link-down-irq", pcie);
   422		if (ret < 0) {
   423			dev_err(dev, "failed to request link state IRQ %d\n", irq);
   424			goto err_get_sync;
   425		}
   426	
   427		j721e_pcie_config_link_irq(pcie);
   428	
   429		switch (mode) {
   430		case PCI_MODE_RC:
   431			if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST)) {
   432				ret = -ENODEV;
   433				goto err_get_sync;
   434			}
   435	
   436			bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
   437			if (!bridge) {
   438				ret = -ENOMEM;
   439				goto err_get_sync;
   440			}
   441	
   442			if (!data->byte_access_allowed)
   443				bridge->ops = &cdns_ti_pcie_host_ops;
   444			rc = pci_host_bridge_priv(bridge);
   445			rc->quirk_retrain_flag = data->quirk_retrain_flag;
   446			rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
   447	
   448			cdns_pcie = &rc->pcie;
   449			cdns_pcie->dev = dev;
   450			cdns_pcie->ops = &j721e_pcie_ops;
   451			pcie->cdns_pcie = cdns_pcie;
   452	
   453			gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
   454			if (IS_ERR(gpiod)) {
   455				ret = PTR_ERR(gpiod);
   456				if (ret != -EPROBE_DEFER)
   457					dev_err(dev, "Failed to get reset GPIO\n");
   458				goto err_get_sync;
   459			}
   460	
   461			ret = cdns_pcie_init_phy(dev, cdns_pcie);
   462			if (ret) {
   463				dev_err(dev, "Failed to init phy\n");
   464				goto err_get_sync;
   465			}
   466	
   467			clk = devm_clk_get_optional(dev, "pcie_refclk");
   468			if (IS_ERR(clk)) {
   469				ret = PTR_ERR(clk);
   470				dev_err(dev, "failed to get pcie_refclk\n");
   471				goto err_pcie_setup;
   472			}
   473	
   474			ret = clk_prepare_enable(clk);
   475			if (ret) {
   476				dev_err(dev, "failed to enable pcie_refclk\n");
   477				goto err_pcie_setup;
   478			}
   479			pcie->refclk = clk;
   480	
   481			/*
   482			 * "Power Sequencing and Reset Signal Timings" table in
   483			 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
   484			 * indicates PERST# should be deasserted after minimum of 100us
   485			 * once REFCLK is stable. The REFCLK to the connector in RC
   486			 * mode is selected while enabling the PHY. So deassert PERST#
   487			 * after 100 us.
   488			 */
   489			if (gpiod) {
   490				usleep_range(100, 200);
   491				gpiod_set_value_cansleep(gpiod, 1);
   492			}
   493	
   494			ret = cdns_pcie_host_setup(rc);
   495			if (ret < 0) {
   496				clk_disable_unprepare(pcie->refclk);
   497				goto err_pcie_setup;
   498			}
   499	
   500			break;
   501		case PCI_MODE_EP:
   502			if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP)) {
   503				ret = -ENODEV;
   504				goto err_get_sync;
   505			}
   506	
   507			ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
   508			if (!ep) {
   509				ret = -ENOMEM;
   510				goto err_get_sync;
   511			}
   512			ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
   513	
   514			cdns_pcie = &ep->pcie;
   515			cdns_pcie->dev = dev;
   516			cdns_pcie->ops = &j721e_pcie_ops;
   517			pcie->cdns_pcie = cdns_pcie;
   518	
   519			ret = cdns_pcie_init_phy(dev, cdns_pcie);
   520			if (ret) {
   521				dev_err(dev, "Failed to init phy\n");
   522				goto err_get_sync;
   523			}
   524	
   525			ret = cdns_pcie_ep_setup(ep);
   526			if (ret < 0)
   527				goto err_pcie_setup;
   528	
   529			break;
   530		default:
   531			dev_err(dev, "INVALID device type %d\n", mode);
   532		}
   533	
   534		return 0;
   535	
   536	err_pcie_setup:
   537		cdns_pcie_disable_phy(cdns_pcie);
   538	
   539	err_get_sync:
   540		pm_runtime_put(dev);
   541		pm_runtime_disable(dev);
   542	
   543		return ret;
   544	}
   545	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
