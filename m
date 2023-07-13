Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C97F1752B52
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jul 2023 22:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjGMUFP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jul 2023 16:05:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbjGMUFO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jul 2023 16:05:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860AA2D4B;
        Thu, 13 Jul 2023 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689278713; x=1720814713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9JiUrZtZsTMA2CpeUkSmTHTXxe2GKMdio7QpaLZNZ3w=;
  b=OZHrf/hSTRluFbQYiOPjIjDC3CHRU2TVjHaYYDG8PhkT3FNw8xYwxulh
   gQmHpXDA5ZUFDVFcczusTvt/rfDgVtCRJOpSryhVLY3+2k0nusUfaWQlN
   RwsUQIJgDtpDx0V4PvE8VAEGngtEN/5c6Pqr8PSSgnn/rCf9FDg9Lxt9b
   /0zK3rlIKWEGPYjL8zBoH/Lm3GpEWzrxRgnK8HcuOjo6vFxOX0gYJDiiF
   jVKabNNx5Hd7f4EaSLWeZ6gFNCSi81s4huAb5H1dbspPSn2mit4/EMHW8
   yAuhHxz026hT3i8L8gc2UlmZrR++i0AKZaqIFv9IrtmRgcm5TCIqQU8oC
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364177164"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="364177164"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 13:05:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757307678"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="757307678"
Received: from lkp-server01.sh.intel.com (HELO c544d7fc5005) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 13:05:08 -0700
Received: from kbuild by c544d7fc5005 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qK2Yl-0006sX-2T;
        Thu, 13 Jul 2023 20:05:07 +0000
Date:   Fri, 14 Jul 2023 04:04:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 2/8] PCI: qcom-ep: Add support for D-state change
 notification
Message-ID: <202307140321.wjx00mop-lkp@intel.com>
References: <1688122331-25478-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1688122331-25478-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build warnings:

[auto build test WARNING on pci/next]
[also build test WARNING on pci/for-linus linus/master v6.5-rc1 next-20230713]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-endpoint-Add-dstate-change-notifier-support/20230630-190228
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1688122331-25478-3-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v2 2/8] PCI: qcom-ep: Add support for D-state change notification
config: arm-randconfig-r081-20230713 (https://download.01.org/0day-ci/archive/20230714/202307140321.wjx00mop-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.3.0
reproduce: (https://download.01.org/0day-ci/archive/20230714/202307140321.wjx00mop-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202307140321.wjx00mop-lkp@intel.com/

sparse warnings: (new ones prefixed by >>)
>> drivers/pci/controller/dwc/pcie-qcom-ep.c:587:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted pci_power_t [usertype] state @@     got unsigned int [assigned] [usertype] dstate @@
   drivers/pci/controller/dwc/pcie-qcom-ep.c:587:23: sparse:     expected restricted pci_power_t [usertype] state
   drivers/pci/controller/dwc/pcie-qcom-ep.c:587:23: sparse:     got unsigned int [assigned] [usertype] dstate

vim +587 drivers/pci/controller/dwc/pcie-qcom-ep.c

   555	
   556	/* TODO: Notify clients about PCIe state change */
   557	static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
   558	{
   559		struct qcom_pcie_ep *pcie_ep = data;
   560		struct dw_pcie *pci = &pcie_ep->pci;
   561		struct device *dev = pci->dev;
   562		u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
   563		u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
   564		pci_power_t state;
   565		u32 dstate, val;
   566	
   567		writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
   568		status &= mask;
   569	
   570		if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
   571			dev_dbg(dev, "Received Linkdown event\n");
   572			pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
   573			pci_epc_linkdown(pci->ep.epc);
   574		} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
   575			dev_dbg(dev, "Received BME event. Link is enabled!\n");
   576			pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
   577			pci_epc_bme_notify(pci->ep.epc);
   578		} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
   579			dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
   580			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
   581			val |= PARF_PM_CTRL_READY_ENTR_L23;
   582			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
   583		} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
   584			dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
   585						   DBI_CON_STATUS_POWER_STATE_MASK;
   586			dev_dbg(dev, "Received D%d state event\n", dstate);
 > 587			state = dstate;
   588			if (dstate == 3) {
   589				val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
   590				val |= PARF_PM_CTRL_REQ_EXIT_L1;
   591				writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
   592				state = PCI_D3hot;
   593				if (gpiod_get_value(pcie_ep->reset))
   594					state = PCI_D3cold;
   595			}
   596			pci_epc_dstate_change(pci->ep.epc, state);
   597		} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
   598			dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
   599			dw_pcie_ep_linkup(&pci->ep);
   600			pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
   601		} else {
   602			dev_dbg(dev, "Received unknown event: %d\n", status);
   603		}
   604	
   605		return IRQ_HANDLED;
   606	}
   607	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
