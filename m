Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B5FF570D1A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 00:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232080AbiGKWCs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jul 2022 18:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbiGKWCr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Jul 2022 18:02:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C7251A3C
        for <linux-pci@vger.kernel.org>; Mon, 11 Jul 2022 15:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657576966; x=1689112966;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=EoS9EQ1HBZx8ue10hTZ82XLKJa65kYvQ+Z3CDlOGXkY=;
  b=U1OROIPiL4AB6Wg0RHLaG4zWlsh/VRtj7A5XN6tceHHd0K0ZAGjuaAZ6
   4s/u2L6l1hHI3YnXfo7D868T3IS//LxoRH9AmORWX7x+di3EaEvJcHih0
   YQqOYfeGG1ydWIAhaEJAQR/6rcrWUOf7x94aQhu0Kupbuxq2dZpA3f5PV
   gGfUxmGbbQlEXuU38M9Aq32NM/1UwIyfnibrDaSQOpvvIuLsNXM/jbseK
   L6lemZ1MhQUHjcnxOW7dokrxWqYfY7KzCuDO0CuexHcqriAxB95oFL3zs
   ReWGbkUYuF2qWKYRtr2fvXSZYg5oNa0uEX2JOxR/l96EshxpVTUV9kWH6
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10405"; a="282329896"
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="282329896"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2022 15:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,263,1650956400"; 
   d="scan'208";a="595048361"
Received: from lkp-server02.sh.intel.com (HELO 8708c84be1ad) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Jul 2022 15:02:44 -0700
Received: from kbuild by 8708c84be1ad with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oB1UJ-0001II-Lv;
        Mon, 11 Jul 2022 22:02:43 +0000
Date:   Tue, 12 Jul 2022 06:02:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Robert Marko <robimarko@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: [helgaas-pci:pci/ctrl/qcom-pending 3/8]
 drivers/pci/controller/dwc/pcie-qcom.c:410:9: error: 'ret' undeclared; did
 you mean 'net'?
Message-ID: <202207120610.HglByhl1-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git pci/ctrl/qcom-pending
head:   1a88605a3efd70bcd01aeb02494386f05f5dce8f
commit: cdb32283bcf202d0db512abb80794056d44e7e9f [3/8] PCI: qcom: Move all DBI register accesses after phy_power_on()
config: riscv-randconfig-r016-20220710 (https://download.01.org/0day-ci/archive/20220712/202207120610.HglByhl1-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git/commit/?id=cdb32283bcf202d0db512abb80794056d44e7e9f
        git remote add helgaas-pci https://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci.git
        git fetch --no-tags helgaas-pci pci/ctrl/qcom-pending
        git checkout cdb32283bcf202d0db512abb80794056d44e7e9f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom.c: In function 'qcom_pcie_post_init_2_1_0':
>> drivers/pci/controller/dwc/pcie-qcom.c:410:9: error: 'ret' undeclared (first use in this function); did you mean 'net'?
     410 |         ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
         |         ^~~
         |         net
   drivers/pci/controller/dwc/pcie-qcom.c:410:9: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/clk.h:13,
                    from drivers/pci/controller/dwc/pcie-qcom.c:11:
>> drivers/pci/controller/dwc/pcie-qcom.c:410:50: error: 'res' undeclared (first use in this function)
     410 |         ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
         |                                                  ^~~
   include/linux/kernel.h:55:33: note: in definition of macro 'ARRAY_SIZE'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                 ^~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from include/linux/clk.h:13,
                    from drivers/pci/controller/dwc/pcie-qcom.c:11:
   include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:240:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     240 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/pci/controller/dwc/pcie-qcom.c:410:39: note: in expansion of macro 'ARRAY_SIZE'
     410 |         ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
         |                                       ^~~~~~~~~~


vim +410 drivers/pci/controller/dwc/pcie-qcom.c

cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  397  
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  398  static int qcom_pcie_post_init_2_1_0(struct qcom_pcie *pcie)
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  399  {
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  400  	struct dw_pcie *pci = pcie->pci;
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  401  	struct device *dev = pci->dev;
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  402  	struct device_node *node = dev->of_node;
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  403  	u32 val;
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  404  
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  405  	/* enable PCIe clocks and resets */
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  406  	val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  407  	val &= ~BIT(0);
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  408  	writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  409  
31f7db67ccf27a7 drivers/pci/controller/dwc/pcie-qcom.c Christian Marangi   2022-07-09 @410  	ret = clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
31f7db67ccf27a7 drivers/pci/controller/dwc/pcie-qcom.c Christian Marangi   2022-07-09  411  	if (ret)
cdb32283bcf202d drivers/pci/controller/dwc/pcie-qcom.c Robert Marko        2022-06-23  412  		return ret;
31f7db67ccf27a7 drivers/pci/controller/dwc/pcie-qcom.c Christian Marangi   2022-07-09  413  
8df093fe2ae1717 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  414  	if (of_device_is_compatible(node, "qcom,pcie-ipq8064") ||
8df093fe2ae1717 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  415  	    of_device_is_compatible(node, "qcom,pcie-ipq8064-v2")) {
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  416  		writel(PCS_DEEMPH_TX_DEEMPH_GEN1(24) |
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  417  			       PCS_DEEMPH_TX_DEEMPH_GEN2_3_5DB(24) |
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  418  			       PCS_DEEMPH_TX_DEEMPH_GEN2_6DB(34),
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  419  		       pcie->parf + PCIE20_PARF_PCS_DEEMPH);
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  420  		writel(PCS_SWING_TX_SWING_FULL(120) |
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  421  			       PCS_SWING_TX_SWING_LOW(120),
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  422  		       pcie->parf + PCIE20_PARF_PCS_SWING);
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  423  		writel(PHY_RX0_EQ(4), pcie->parf + PCIE20_PARF_CONFIG_BITS);
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  424  	}
5149901e9e6deca drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  425  
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  426  	if (of_device_is_compatible(node, "qcom,pcie-ipq8064")) {
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  427  		/* set TX termination offset */
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  428  		val = readl(pcie->parf + PCIE20_PARF_PHY_CTRL);
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  429  		val &= ~PHY_CTRL_PHY_TX0_TERM_OFFSET_MASK;
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  430  		val |= PHY_CTRL_PHY_TX0_TERM_OFFSET(7);
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  431  		writel(val, pcie->parf + PCIE20_PARF_PHY_CTRL);
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  432  	}
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  433  
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  434  	/* enable external reference clock */
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  435  	val = readl(pcie->parf + PCIE20_PARF_PHY_REFCLK);
2cfef1971aea611 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-10-19  436  	/* USE_PAD is required only for ipq806x */
2cfef1971aea611 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-10-19  437  	if (!of_device_is_compatible(node, "qcom,pcie-apq8064"))
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  438  		val &= ~PHY_REFCLK_USE_PAD;
de3c4bf648975ea drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  439  	val |= PHY_REFCLK_SSP_EN;
6a114526af46899 drivers/pci/controller/dwc/pcie-qcom.c Ansuel Smith        2020-06-15  440  	writel(val, pcie->parf + PCIE20_PARF_PHY_REFCLK);
dd58318c019f10b drivers/pci/controller/dwc/pcie-qcom.c Abhishek Sahu       2020-06-15  441  
82a823833f4e376 drivers/pci/host/pcie-qcom.c           Stanimir Varbanov   2015-12-18  442  	/* wait for clock acquisition */
82a823833f4e376 drivers/pci/host/pcie-qcom.c           Stanimir Varbanov   2015-12-18  443  	usleep_range(1000, 1500);
82a823833f4e376 drivers/pci/host/pcie-qcom.c           Stanimir Varbanov   2015-12-18  444  
b8f2a8565603617 drivers/pci/dwc/pcie-qcom.c            Srinivas Kandagatla 2017-06-29  445  	/* Set the Max TLP size to 2K, instead of using default of 4K */
b8f2a8565603617 drivers/pci/dwc/pcie-qcom.c            Srinivas Kandagatla 2017-06-29  446  	writel(CFG_REMOTE_RD_REQ_BRIDGE_SIZE_2K,
b8f2a8565603617 drivers/pci/dwc/pcie-qcom.c            Srinivas Kandagatla 2017-06-29  447  	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL0);
b8f2a8565603617 drivers/pci/dwc/pcie-qcom.c            Srinivas Kandagatla 2017-06-29  448  	writel(CFG_BRIDGE_SB_INIT,
b8f2a8565603617 drivers/pci/dwc/pcie-qcom.c            Srinivas Kandagatla 2017-06-29  449  	       pci->dbi_base + PCIE20_AXI_MSTR_RESP_COMP_CTRL1);
b8f2a8565603617 drivers/pci/dwc/pcie-qcom.c            Srinivas Kandagatla 2017-06-29  450  
82a823833f4e376 drivers/pci/host/pcie-qcom.c           Stanimir Varbanov   2015-12-18  451  	return 0;
82a823833f4e376 drivers/pci/host/pcie-qcom.c           Stanimir Varbanov   2015-12-18  452  }
82a823833f4e376 drivers/pci/host/pcie-qcom.c           Stanimir Varbanov   2015-12-18  453  

:::::: The code at line 410 was first introduced by commit
:::::: 31f7db67ccf27a7416850496622eb3084413ee2a PCI: qcom: Enable clocks only after PARF_PHY setup for rev 2.1.0

:::::: TO: Christian Marangi <ansuelsmth@gmail.com>
:::::: CC: Bjorn Helgaas <bhelgaas@google.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
