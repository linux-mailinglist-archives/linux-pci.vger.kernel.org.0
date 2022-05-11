Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E493524106
	for <lists+linux-pci@lfdr.de>; Thu, 12 May 2022 01:27:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349297AbiEKX1k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 May 2022 19:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347660AbiEKX1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 May 2022 19:27:34 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39D8692A5
        for <linux-pci@vger.kernel.org>; Wed, 11 May 2022 16:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652311653; x=1683847653;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1u/OieTs7o6idhQjyLMTZY6k3oNV8yXPSQyJqYdByC0=;
  b=RDmnhlJL5D1zef6K2Q4G+ONEYhVEsgyjmAz3RMIKSxBTfvlA9ZbmqWZj
   GlNOFHsLqxVcysQLkIsWBVON5Xr0/Z/XKUJ9g33wM4D1vcxvqBG5HYoAX
   FSMA4isbyZ1mya0COSlFoN7VVyK11KCW87XcdfLfD+s9zKm/nDHq9c8IF
   8E6TyK9Kna0cY2r+eMqmLgKG1AI7BlgpFrBaTICZS4OMxlKzhxuwC0ymj
   E66aoetJnnEtW7F/o3QNFDfhIMbXsZw5hZjvN60vIwiKP+VSVqNg4nfcB
   5J7Sa9viqpzfU64t90sBisRQ3nIAd4SMqOyTmxj0tX/A0j2mOv81IQ9vy
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="295084686"
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="295084686"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 16:27:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,218,1647327600"; 
   d="scan'208";a="553531812"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 May 2022 16:27:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1novju-000Jg6-JL;
        Wed, 11 May 2022 23:27:30 +0000
Date:   Thu, 12 May 2022 07:27:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Parshuram Thombare <pthombar@cadence.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: [lpieralisi-pci:pci/cadence 2/2]
 drivers/pci/controller/cadence/pci-j721e.c:408:7: error: no member named
 'quirk_disable_flr' in 'struct cdns_pcie_ep'
Message-ID: <202205120700.X76G7aC2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git pci/cadence
head:   d3dbd4d862f46ae8f3f3c9e9284ba357e5891e46
commit: d3dbd4d862f46ae8f3f3c9e9284ba357e5891e46 [2/2] PCI: cadence: Clear FLR in device capabilities register
config: x86_64-randconfig-a002-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120700.X76G7aC2-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 18dd123c56754edf62c7042dcf23185c3727610f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/commit/?id=d3dbd4d862f46ae8f3f3c9e9284ba357e5891e46
        git remote add lpieralisi-pci https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
        git fetch --no-tags lpieralisi-pci pci/cadence
        git checkout d3dbd4d862f46ae8f3f3c9e9284ba357e5891e46
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pci/controller/cadence/pci-j721e.c:408:7: error: no member named 'quirk_disable_flr' in 'struct cdns_pcie_ep'
                   ep->quirk_disable_flr = data->quirk_disable_flr;
                   ~~  ^
>> drivers/pci/controller/cadence/pci-j721e.c:408:33: error: no member named 'quirk_disable_flr' in 'struct j721e_pcie_data'
                   ep->quirk_disable_flr = data->quirk_disable_flr;
                                           ~~~~  ^
   2 errors generated.


vim +408 drivers/pci/controller/cadence/pci-j721e.c

   350	
   351	static int j721e_pcie_probe(struct platform_device *pdev)
   352	{
   353		struct device *dev = &pdev->dev;
   354		struct device_node *node = dev->of_node;
   355		struct pci_host_bridge *bridge;
   356		const struct j721e_pcie_data *data;
   357		struct cdns_pcie *cdns_pcie;
   358		struct j721e_pcie *pcie;
   359		struct cdns_pcie_rc *rc = NULL;
   360		struct cdns_pcie_ep *ep = NULL;
   361		struct gpio_desc *gpiod;
   362		void __iomem *base;
   363		struct clk *clk;
   364		u32 num_lanes;
   365		u32 mode;
   366		int ret;
   367		int irq;
   368	
   369		data = of_device_get_match_data(dev);
   370		if (!data)
   371			return -EINVAL;
   372	
   373		mode = (u32)data->mode;
   374	
   375		pcie = devm_kzalloc(dev, sizeof(*pcie), GFP_KERNEL);
   376		if (!pcie)
   377			return -ENOMEM;
   378	
   379		switch (mode) {
   380		case PCI_MODE_RC:
   381			if (!IS_ENABLED(CONFIG_PCIE_CADENCE_HOST))
   382				return -ENODEV;
   383	
   384			bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
   385			if (!bridge)
   386				return -ENOMEM;
   387	
   388			if (!data->byte_access_allowed)
   389				bridge->ops = &cdns_ti_pcie_host_ops;
   390			rc = pci_host_bridge_priv(bridge);
   391			rc->quirk_retrain_flag = data->quirk_retrain_flag;
   392			rc->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
   393	
   394			cdns_pcie = &rc->pcie;
   395			cdns_pcie->dev = dev;
   396			cdns_pcie->ops = &j721e_pcie_ops;
   397			pcie->cdns_pcie = cdns_pcie;
   398			break;
   399		case PCI_MODE_EP:
   400			if (!IS_ENABLED(CONFIG_PCIE_CADENCE_EP))
   401				return -ENODEV;
   402	
   403			ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
   404			if (!ep)
   405				return -ENOMEM;
   406	
   407			ep->quirk_detect_quiet_flag = data->quirk_detect_quiet_flag;
 > 408			ep->quirk_disable_flr = data->quirk_disable_flr;
   409	
   410			cdns_pcie = &ep->pcie;
   411			cdns_pcie->dev = dev;
   412			cdns_pcie->ops = &j721e_pcie_ops;
   413			pcie->cdns_pcie = cdns_pcie;
   414			break;
   415		default:
   416			dev_err(dev, "INVALID device type %d\n", mode);
   417			return 0;
   418		}
   419	
   420		pcie->mode = mode;
   421		pcie->linkdown_irq_regfield = data->linkdown_irq_regfield;
   422	
   423		base = devm_platform_ioremap_resource_byname(pdev, "intd_cfg");
   424		if (IS_ERR(base))
   425			return PTR_ERR(base);
   426		pcie->intd_cfg_base = base;
   427	
   428		base = devm_platform_ioremap_resource_byname(pdev, "user_cfg");
   429		if (IS_ERR(base))
   430			return PTR_ERR(base);
   431		pcie->user_cfg_base = base;
   432	
   433		ret = of_property_read_u32(node, "num-lanes", &num_lanes);
   434		if (ret || num_lanes > MAX_LANES)
   435			num_lanes = 1;
   436		pcie->num_lanes = num_lanes;
   437	
   438		if (dma_set_mask_and_coherent(dev, DMA_BIT_MASK(48)))
   439			return -EINVAL;
   440	
   441		irq = platform_get_irq_byname(pdev, "link_state");
   442		if (irq < 0)
   443			return irq;
   444	
   445		dev_set_drvdata(dev, pcie);
   446		pm_runtime_enable(dev);
   447		ret = pm_runtime_get_sync(dev);
   448		if (ret < 0) {
   449			dev_err(dev, "pm_runtime_get_sync failed\n");
   450			goto err_get_sync;
   451		}
   452	
   453		ret = j721e_pcie_ctrl_init(pcie);
   454		if (ret < 0) {
   455			dev_err(dev, "pm_runtime_get_sync failed\n");
   456			goto err_get_sync;
   457		}
   458	
   459		ret = devm_request_irq(dev, irq, j721e_pcie_link_irq_handler, 0,
   460				       "j721e-pcie-link-down-irq", pcie);
   461		if (ret < 0) {
   462			dev_err(dev, "failed to request link state IRQ %d\n", irq);
   463			goto err_get_sync;
   464		}
   465	
   466		j721e_pcie_config_link_irq(pcie);
   467	
   468		switch (mode) {
   469		case PCI_MODE_RC:
   470			gpiod = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
   471			if (IS_ERR(gpiod)) {
   472				ret = PTR_ERR(gpiod);
   473				if (ret != -EPROBE_DEFER)
   474					dev_err(dev, "Failed to get reset GPIO\n");
   475				goto err_get_sync;
   476			}
   477	
   478			ret = cdns_pcie_init_phy(dev, cdns_pcie);
   479			if (ret) {
   480				dev_err(dev, "Failed to init phy\n");
   481				goto err_get_sync;
   482			}
   483	
   484			clk = devm_clk_get_optional(dev, "pcie_refclk");
   485			if (IS_ERR(clk)) {
   486				ret = PTR_ERR(clk);
   487				dev_err(dev, "failed to get pcie_refclk\n");
   488				goto err_pcie_setup;
   489			}
   490	
   491			ret = clk_prepare_enable(clk);
   492			if (ret) {
   493				dev_err(dev, "failed to enable pcie_refclk\n");
   494				goto err_pcie_setup;
   495			}
   496			pcie->refclk = clk;
   497	
   498			/*
   499			 * "Power Sequencing and Reset Signal Timings" table in
   500			 * PCI EXPRESS CARD ELECTROMECHANICAL SPECIFICATION, REV. 3.0
   501			 * indicates PERST# should be deasserted after minimum of 100us
   502			 * once REFCLK is stable. The REFCLK to the connector in RC
   503			 * mode is selected while enabling the PHY. So deassert PERST#
   504			 * after 100 us.
   505			 */
   506			if (gpiod) {
   507				usleep_range(100, 200);
   508				gpiod_set_value_cansleep(gpiod, 1);
   509			}
   510	
   511			ret = cdns_pcie_host_setup(rc);
   512			if (ret < 0) {
   513				clk_disable_unprepare(pcie->refclk);
   514				goto err_pcie_setup;
   515			}
   516	
   517			break;
   518		case PCI_MODE_EP:
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
   530		}
   531	
   532		return 0;
   533	
   534	err_pcie_setup:
   535		cdns_pcie_disable_phy(cdns_pcie);
   536	
   537	err_get_sync:
   538		pm_runtime_put(dev);
   539		pm_runtime_disable(dev);
   540	
   541		return ret;
   542	}
   543	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
