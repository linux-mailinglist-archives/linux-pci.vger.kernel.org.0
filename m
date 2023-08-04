Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C56967703BB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 16:58:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjHDO6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Aug 2023 10:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjHDO6p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Aug 2023 10:58:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CAFDAC;
        Fri,  4 Aug 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691161124; x=1722697124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=k4cqc2uFUvykatWv/bI5oB09e9fHPN3dIPVE6GY6Krc=;
  b=htGAfylN1JsCVBMkgoNjJTl8uu/iaqnewVsc+ZL9kVhc6HE41uydUsSr
   ygrG0DXti9SoUPLwRq9yZF/wUggfmJB0k3FSAvg0iA0tv6ObQqiJryq3/
   c0+mC4yXSTuKxi/qGD2XuYpxuflloBO08i+EvNNjkRfbppZ3jky0aSm9D
   6zlA1ncipY+XWdkZQq9mVdmZZjS5r35BWxRtlgSN+S1kEcSM2Yyd4qXLA
   1r5M2ptgOQkXbXycG5iyzRjuezjCqBJ84BOTS0/B8SSVi+FPRumTOpe2d
   o45RROSYjeu1RENaHGV+mvsRK5mE2rTaVnfRD9zQMAJevRLZcLdjtU+Mp
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="369069845"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="369069845"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 07:58:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="765144192"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="765144192"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 04 Aug 2023 07:58:37 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRwGC-0002uX-2f;
        Fri, 04 Aug 2023 14:58:36 +0000
Date:   Fri, 4 Aug 2023 22:57:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frank Li <Frank.Li@nxp.com>, helgaas@kernel.org
Cc:     llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
        Frank.li@nxp.com, bhelgaas@google.com, devicetree@vger.kernel.org,
        gustavo.pimentel@synopsys.com, imx@lists.linux.dev, kw@linux.com,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, lorenzo.pieralisi@arm.com,
        lpieralisi@kernel.org, mani@kernel.org,
        manivannan.sadhasivam@linaro.org, minghuan.lian@nxp.com,
        mingkai.hu@nxp.com, robh+dt@kernel.org, roy.zang@nxp.com,
        shawnguo@kernel.org, zhiqiang.hou@nxp.com
Subject: Re: [PATCH v8 2/3] PCI: dwc: Implement general suspend/resume
 functionality for L2/L3 transitions
Message-ID: <202308042251.yGAFqeDw-lkp@intel.com>
References: <20230803150409.271155-3-Frank.Li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803150409.271155-3-Frank.Li@nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Frank,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/for-linus]
[also build test ERROR on linus/master v6.5-rc4 next-20230804]
[cannot apply to pci/next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Frank-Li/PCI-Add-macro-PCIE_PME_TO_L2_TIMEOUT_US/20230803-230808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git for-linus
patch link:    https://lore.kernel.org/r/20230803150409.271155-3-Frank.Li%40nxp.com
patch subject: [PATCH v8 2/3] PCI: dwc: Implement general suspend/resume functionality for L2/L3 transitions
config: x86_64-randconfig-x005-20230731 (https://download.01.org/0day-ci/archive/20230804/202308042251.yGAFqeDw-lkp@intel.com/config)
compiler: clang version 16.0.4 (https://github.com/llvm/llvm-project.git ae42196bc493ffe877a7e3dff8be32035dea4d07)
reproduce: (https://download.01.org/0day-ci/archive/20230804/202308042251.yGAFqeDw-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308042251.yGAFqeDw-lkp@intel.com/

All errors (new ones prefixed by >>):

>> drivers/pci/controller/dwc/pcie-designware-host.c:835:5: error: use of undeclared identifier 'PCIE_PME_TO_L2_TIMEOUT_US'
                                   PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
                                   ^
   drivers/pci/controller/dwc/pcie-designware-host.c:834:5: error: use of undeclared identifier 'PCIE_PME_TO_L2_TIMEOUT_US'
                                   PCIE_PME_TO_L2_TIMEOUT_US/10,
                                   ^
   2 errors generated.


vim +/PCIE_PME_TO_L2_TIMEOUT_US +835 drivers/pci/controller/dwc/pcie-designware-host.c

   811	
   812	int dw_pcie_suspend_noirq(struct dw_pcie *pci)
   813	{
   814		u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
   815		u32 val;
   816		int ret;
   817	
   818		/*
   819		 * If L1SS is supported, then do not put the link into L2 as some
   820		 * devices such as NVMe expect low resume latency.
   821		 */
   822		if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
   823			return 0;
   824	
   825		if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
   826			return 0;
   827	
   828		if (!pci->pp.ops->pme_turn_off)
   829			return 0;
   830	
   831		pci->pp.ops->pme_turn_off(&pci->pp);
   832	
   833		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
   834					PCIE_PME_TO_L2_TIMEOUT_US/10,
 > 835					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
   836		if (ret) {
   837			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
   838			return ret;
   839		}
   840	
   841		if (pci->pp.ops->host_deinit)
   842			pci->pp.ops->host_deinit(&pci->pp);
   843	
   844		pci->suspended = true;
   845	
   846		return ret;
   847	}
   848	EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
   849	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
