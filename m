Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD987AB303
	for <lists+linux-pci@lfdr.de>; Fri, 22 Sep 2023 15:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234180AbjIVNrl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Sep 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234147AbjIVNrk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Sep 2023 09:47:40 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B68CE8;
        Fri, 22 Sep 2023 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695390453; x=1726926453;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GgIL7Exn3jx6iwe7BlNdp1jFiIlg0zgq62barbXZvBQ=;
  b=TYfCmyUgT/PAxEj2wjms89J6aMYTVA0MPUVxtTT4K6hc3KdXDI6HGDsi
   sUcu06F8zf3Kmt6oWGUv8X6RR3dkBAq2pdr4ntOFMYnLLZT6LMfKvgDtR
   nmB5UQoJhtqJNx0GV68ba/v+Zfp8xcWIcC+v5wBRiRI4nm6rXwL3a7NFx
   mzHdmAuEFFkVCwGWF/VF3Muziel8A3gUni+80wbFKr9pfHLPMMqzY35Vq
   v53J+OAhEoJaQxdW0CgHKog2Sc8/ihtY0V/PvsGxDfa8uXYNXzMTnI0QP
   diVoRDpMp1g//h9WIyv1EszrQxeVsxW2qHSEqd5Wc37gN1x9ydFL8r/HR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="447307611"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="447307611"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 06:47:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10841"; a="890814520"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="890814520"
Received: from lkp-server02.sh.intel.com (HELO 493f6c7fed5d) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 22 Sep 2023 06:46:31 -0700
Received: from kbuild by 493f6c7fed5d with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qjgV9-0000n5-0D;
        Fri, 22 Sep 2023 13:47:23 +0000
Date:   Fri, 22 Sep 2023 21:47:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, jingoohan1@gmail.com,
        gustavo.pimentel@synopsys.com, mani@kernel.org
Cc:     oe-kbuild-all@lists.linux.dev, marek.vasut+renesas@gmail.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>
Subject: Re: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe
 controller support
Message-ID: <202309222125.KiN4nFhD-lkp@intel.com>
References: <20230922065331.3806925-14-yoshihiro.shimoda.uh@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922065331.3806925-14-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Yoshihiro,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.6-rc2 next-20230921]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yoshihiro-Shimoda/PCI-dwc-endpoint-Add-multiple-PFs-support-for-dbi2/20230922-145529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230922065331.3806925-14-yoshihiro.shimoda.uh%40renesas.com
patch subject: [PATCH v21 13/16] PCI: dwc: rcar-gen4: Add R-Car Gen4 PCIe controller support
config: sparc-allyesconfig (https://download.01.org/0day-ci/archive/20230922/202309222125.KiN4nFhD-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20230922/202309222125.KiN4nFhD-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202309222125.KiN4nFhD-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:155:5: warning: no previous prototype for 'rcar_gen4_pcie_common_init' [-Wmissing-prototypes]
     155 | int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:197:6: warning: no previous prototype for 'rcar_gen4_pcie_common_deinit' [-Wmissing-prototypes]
     197 | void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:205:5: warning: no previous prototype for 'rcar_gen4_pcie_prepare' [-Wmissing-prototypes]
     205 | int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
         |     ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:220:6: warning: no previous prototype for 'rcar_gen4_pcie_unprepare' [-Wmissing-prototypes]
     220 | void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:228:5: warning: no previous prototype for 'rcar_gen4_pcie_get_resources' [-Wmissing-prototypes]
     228 | int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/pci/controller/dwc/pcie-rcar-gen4.c:242:24: warning: no previous prototype for 'rcar_gen4_pcie_devm_alloc' [-Wmissing-prototypes]
     242 | struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_device *pdev)
         |                        ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/rcar_gen4_pcie_common_init +155 drivers/pci/controller/dwc/pcie-rcar-gen4.c

   154	
 > 155	int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
   156	{
   157		struct dw_pcie *dw = &rcar->dw;
   158		u32 val;
   159		int ret;
   160	
   161		ret = clk_bulk_prepare_enable(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
   162		if (ret) {
   163			dev_err(dw->dev, "Failed to enable ref clocks\n");
   164			return ret;
   165		}
   166	
   167		if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
   168			reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
   169	
   170		val = readl(rcar->base + PCIEMSR0);
   171		if (rcar->mode == DW_PCIE_RC_TYPE) {
   172			val |= DEVICE_TYPE_RC;
   173		} else if (rcar->mode == DW_PCIE_EP_TYPE) {
   174			val |= DEVICE_TYPE_EP;
   175		} else {
   176			ret = -EINVAL;
   177			goto err_unprepare;
   178		}
   179	
   180		if (dw->num_lanes < 4)
   181			val |= BIFUR_MOD_SET_ON;
   182	
   183		writel(val, rcar->base + PCIEMSR0);
   184	
   185		ret = reset_control_deassert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
   186		if (ret)
   187			goto err_unprepare;
   188	
   189		return 0;
   190	
   191	err_unprepare:
   192		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
   193	
   194		return ret;
   195	}
   196	
 > 197	void rcar_gen4_pcie_common_deinit(struct rcar_gen4_pcie *rcar)
   198	{
   199		struct dw_pcie *dw = &rcar->dw;
   200	
   201		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
   202		clk_bulk_disable_unprepare(DW_PCIE_NUM_CORE_CLKS, dw->core_clks);
   203	}
   204	
 > 205	int rcar_gen4_pcie_prepare(struct rcar_gen4_pcie *rcar)
   206	{
   207		struct device *dev = rcar->dw.dev;
   208		int err;
   209	
   210		pm_runtime_enable(dev);
   211		err = pm_runtime_resume_and_get(dev);
   212		if (err < 0) {
   213			dev_err(dev, "Failed to resume/get Runtime PM\n");
   214			pm_runtime_disable(dev);
   215		}
   216	
   217		return err;
   218	}
   219	
 > 220	void rcar_gen4_pcie_unprepare(struct rcar_gen4_pcie *rcar)
   221	{
   222		struct device *dev = rcar->dw.dev;
   223	
   224		pm_runtime_put(dev);
   225		pm_runtime_disable(dev);
   226	}
   227	
 > 228	int rcar_gen4_pcie_get_resources(struct rcar_gen4_pcie *rcar)
   229	{
   230		/* Renesas-specific registers */
   231		rcar->base = devm_platform_ioremap_resource_byname(rcar->pdev, "app");
   232	
   233		return PTR_ERR_OR_ZERO(rcar->base);
   234	}
   235	
   236	static const struct dw_pcie_ops dw_pcie_ops = {
   237		.start_link = rcar_gen4_pcie_start_link,
   238		.stop_link = rcar_gen4_pcie_stop_link,
   239		.link_up = rcar_gen4_pcie_link_up,
   240	};
   241	
 > 242	struct rcar_gen4_pcie *rcar_gen4_pcie_devm_alloc(struct platform_device *pdev)
   243	{
   244		struct device *dev = &pdev->dev;
   245		struct rcar_gen4_pcie *rcar;
   246	
   247		rcar = devm_kzalloc(dev, sizeof(*rcar), GFP_KERNEL);
   248		if (!rcar)
   249			return ERR_PTR(-ENOMEM);
   250	
   251		rcar->dw.ops = &dw_pcie_ops;
   252		rcar->dw.dev = dev;
   253		rcar->pdev = pdev;
   254		dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
   255		dw_pcie_cap_set(&rcar->dw, REQ_RES);
   256		platform_set_drvdata(pdev, rcar);
   257	
   258		return rcar;
   259	}
   260	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
