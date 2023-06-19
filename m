Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45213734AB0
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jun 2023 05:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjFSDnN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 18 Jun 2023 23:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFSDnM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 18 Jun 2023 23:43:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81C95FC;
        Sun, 18 Jun 2023 20:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687146186; x=1718682186;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t5NJVxXP5HMKsYrQDJqtpkg7zu4vWzJYowr7YxRo3qA=;
  b=EzloyZKGFw5yHDK4/YjwvbD7nikbXg/MY0+DdimPzGB4L/wkT4b7zl25
   6v8oA4N++6FTzk1hKTz5ybPTheBXEg+a1ElVaEDA7OtKWcgVQVIt+qbUw
   EL2IAm2EFa01AFyAxdMacObiUkt0gz0UybjjRtU1snRfSPHaBD6ZjAM5T
   AT33nFKJP4krz1NW5O1g8Ehfu+QkeMwaikf1uoREuPCxOGO03CJkMqxna
   M63s9cZCP7sNFOBJ8HNFW84+vY6ibBSmfLbSHKAMcSN451KRbORfdQ7Qt
   mbagVgcofST5wa8VDOi6N7HfFWYNfP9+sqMVN0ZCY5/efAC7vnpkOhksO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="425486593"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="425486593"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2023 20:43:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10745"; a="707741632"
X-IronPort-AV: E=Sophos;i="6.00,253,1681196400"; 
   d="scan'208";a="707741632"
Received: from lkp-server01.sh.intel.com (HELO 783282924a45) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 18 Jun 2023 20:43:02 -0700
Received: from kbuild by 783282924a45 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qB5nB-0004II-16;
        Mon, 19 Jun 2023 03:43:01 +0000
Date:   Mon, 19 Jun 2023 11:42:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Vidya Sagar <vidyas@nvidia.com>, lpieralisi@kernel.org,
        kw@linux.com, robh@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        Sergey.Semin@baikalelectronics.ru
Cc:     oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, vidyas@nvidia.com,
        sagar.tv@gmail.com
Subject: Re: [PATCH V2] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <202306191113.M2RDKBvQ-lkp@intel.com>
References: <20230619014218.1970846-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619014218.1970846-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Vidya,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.4-rc7 next-20230616]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Vidya-Sagar/Revert-PCI-tegra194-Enable-support-for-256-Byte-payload/20230619-094403
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/20230619014218.1970846-1-vidyas%40nvidia.com
patch subject: [PATCH V2] Revert "PCI: tegra194: Enable support for 256 Byte payload"
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20230619/202306191113.M2RDKBvQ-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230619/202306191113.M2RDKBvQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202306191113.M2RDKBvQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'tegra_pcie_dw_host_init':
>> drivers/pci/controller/dwc/pcie-tegra194.c:906:17: error: 'val_16' undeclared (first use in this function)
     906 |                 val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
         |                 ^~~~~~
   drivers/pci/controller/dwc/pcie-tegra194.c:906:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/pci/controller/dwc/pcie-tegra194.c: In function 'pex_ep_event_pex_rst_deassert':
   drivers/pci/controller/dwc/pcie-tegra194.c:1865:17: error: 'val_16' undeclared (first use in this function)
    1865 |                 val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
         |                 ^~~~~~


vim +/val_16 +906 drivers/pci/controller/dwc/pcie-tegra194.c

56e15a238d9278 Vidya Sagar   2019-08-13  867  
64451ac83fe6ab Bjorn Helgaas 2022-08-04  868  static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
56e15a238d9278 Vidya Sagar   2019-08-13  869  {
56e15a238d9278 Vidya Sagar   2019-08-13  870  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
f1ab409d578752 Vidya Sagar   2022-07-21  871  	struct tegra_pcie_dw *pcie = to_tegra_pcie(pci);
56e15a238d9278 Vidya Sagar   2019-08-13  872  	u32 val;
56e15a238d9278 Vidya Sagar   2019-08-13  873  
275e88b06a277c Rob Herring   2020-12-18  874  	pp->bridge->ops = &tegra_pci_ops;
275e88b06a277c Rob Herring   2020-12-18  875  
369b868f4a2ef8 Vidya Sagar   2020-11-26  876  	if (!pcie->pcie_cap_base)
369b868f4a2ef8 Vidya Sagar   2020-11-26  877  		pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
369b868f4a2ef8 Vidya Sagar   2020-11-26  878  							      PCI_CAP_ID_EXP);
369b868f4a2ef8 Vidya Sagar   2020-11-26  879  
56e15a238d9278 Vidya Sagar   2019-08-13  880  	val = dw_pcie_readl_dbi(pci, PCI_IO_BASE);
56e15a238d9278 Vidya Sagar   2019-08-13  881  	val &= ~(IO_BASE_IO_DECODE | IO_BASE_IO_DECODE_BIT8);
56e15a238d9278 Vidya Sagar   2019-08-13  882  	dw_pcie_writel_dbi(pci, PCI_IO_BASE, val);
56e15a238d9278 Vidya Sagar   2019-08-13  883  
56e15a238d9278 Vidya Sagar   2019-08-13  884  	val = dw_pcie_readl_dbi(pci, PCI_PREF_MEMORY_BASE);
56e15a238d9278 Vidya Sagar   2019-08-13  885  	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_DECODE;
56e15a238d9278 Vidya Sagar   2019-08-13  886  	val |= CFG_PREF_MEM_LIMIT_BASE_MEM_LIMIT_DECODE;
56e15a238d9278 Vidya Sagar   2019-08-13  887  	dw_pcie_writel_dbi(pci, PCI_PREF_MEMORY_BASE, val);
56e15a238d9278 Vidya Sagar   2019-08-13  888  
56e15a238d9278 Vidya Sagar   2019-08-13  889  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
56e15a238d9278 Vidya Sagar   2019-08-13  890  
56e15a238d9278 Vidya Sagar   2019-08-13  891  	/* Enable as 0xFFFF0001 response for CRS */
56e15a238d9278 Vidya Sagar   2019-08-13  892  	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
56e15a238d9278 Vidya Sagar   2019-08-13  893  	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
56e15a238d9278 Vidya Sagar   2019-08-13  894  	val |= (AMBA_ERROR_RESPONSE_CRS_OKAY_FFFF0001 <<
56e15a238d9278 Vidya Sagar   2019-08-13  895  		AMBA_ERROR_RESPONSE_CRS_SHIFT);
56e15a238d9278 Vidya Sagar   2019-08-13  896  	dw_pcie_writel_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT, val);
56e15a238d9278 Vidya Sagar   2019-08-13  897  
56e15a238d9278 Vidya Sagar   2019-08-13  898  	/* Configure Max lane width from DT */
56e15a238d9278 Vidya Sagar   2019-08-13  899  	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
56e15a238d9278 Vidya Sagar   2019-08-13  900  	val &= ~PCI_EXP_LNKCAP_MLW;
56e15a238d9278 Vidya Sagar   2019-08-13  901  	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
56e15a238d9278 Vidya Sagar   2019-08-13  902  	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
56e15a238d9278 Vidya Sagar   2019-08-13  903  
a54e190737181c Vidya Sagar   2022-07-21  904  	/* Clear Slot Clock Configuration bit if SRNS configuration */
a54e190737181c Vidya Sagar   2022-07-21  905  	if (pcie->enable_srns) {
a54e190737181c Vidya Sagar   2022-07-21 @906  		val_16 = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
a54e190737181c Vidya Sagar   2022-07-21  907  					   PCI_EXP_LNKSTA);
a54e190737181c Vidya Sagar   2022-07-21  908  		val_16 &= ~PCI_EXP_LNKSTA_SLC;
a54e190737181c Vidya Sagar   2022-07-21  909  		dw_pcie_writew_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA,
a54e190737181c Vidya Sagar   2022-07-21  910  				   val_16);
a54e190737181c Vidya Sagar   2022-07-21  911  	}
a54e190737181c Vidya Sagar   2022-07-21  912  
56e15a238d9278 Vidya Sagar   2019-08-13  913  	config_gen3_gen4_eq_presets(pcie);
56e15a238d9278 Vidya Sagar   2019-08-13  914  
56e15a238d9278 Vidya Sagar   2019-08-13  915  	init_host_aspm(pcie);
56e15a238d9278 Vidya Sagar   2019-08-13  916  
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  917  	/* Disable ASPM-L1SS advertisement if there is no CLKREQ routing */
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  918  	if (!pcie->supports_clkreq) {
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  919  		disable_aspm_l11(pcie);
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  920  		disable_aspm_l12(pcie);
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  921  	}
6b6fafc1abc7c0 Vidya Sagar   2020-12-03  922  
a54e190737181c Vidya Sagar   2022-07-21  923  	if (!pcie->of_data->has_l1ss_exit_fix) {
56e15a238d9278 Vidya Sagar   2019-08-13  924  		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
56e15a238d9278 Vidya Sagar   2019-08-13  925  		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
56e15a238d9278 Vidya Sagar   2019-08-13  926  		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
a54e190737181c Vidya Sagar   2022-07-21  927  	}
56e15a238d9278 Vidya Sagar   2019-08-13  928  
56e15a238d9278 Vidya Sagar   2019-08-13  929  	if (pcie->update_fc_fixup) {
56e15a238d9278 Vidya Sagar   2019-08-13  930  		val = dw_pcie_readl_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF);
56e15a238d9278 Vidya Sagar   2019-08-13  931  		val |= 0x1 << CFG_TIMER_CTRL_ACK_NAK_SHIFT;
56e15a238d9278 Vidya Sagar   2019-08-13  932  		dw_pcie_writel_dbi(pci, CFG_TIMER_CTRL_MAX_FUNC_NUM_OFF, val);
56e15a238d9278 Vidya Sagar   2019-08-13  933  	}
56e15a238d9278 Vidya Sagar   2019-08-13  934  
56e15a238d9278 Vidya Sagar   2019-08-13  935  	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
56e15a238d9278 Vidya Sagar   2019-08-13  936  
275e88b06a277c Rob Herring   2020-12-18  937  	return 0;
275e88b06a277c Rob Herring   2020-12-18  938  }
275e88b06a277c Rob Herring   2020-12-18  939  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
