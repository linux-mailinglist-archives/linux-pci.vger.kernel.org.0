Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8E7D76E5E7
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 12:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjHCKyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 06:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjHCKya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 06:54:30 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6502230DB;
        Thu,  3 Aug 2023 03:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691060068; x=1722596068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rHqfW8v9zgYkB3pcJ59lEKKAgJ+bnwqxiHp7+qUhM7U=;
  b=FK/0E+VsQuNcD+4PNSX9Ix2TpoJ6SP8/B335AQb8ozGSmrFPPyiaZiro
   0OEUGavfNonQ+TI2rdbNNLrTm2ySZvs8v6YtaPFtNN0C0zCkTT06vt2QP
   nm6j3T+FOO+CDTYWvEJz2kOBHodZw7lbeGIKoIscMBWtpzCA2wdxd3tPZ
   wYFOlRSYyzIymqlzwLIgFbW9HxRsDniX8Y+vUwu3nGmiP9XBFvU/uMVWi
   hXiq7LMrwMmn20oq8k4S5eFp86vQwfy94ZAJGg0stC/DmUKamN07eITtK
   nZExrzcNMZ/UJf3oeKJnweqxD6Ienxyke0KxzHWr1FsAdaM1lv1Fkcnjq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="359880535"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="359880535"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 03:54:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="732718341"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="732718341"
Received: from lkp-server01.sh.intel.com (HELO d1ccc7e87e8f) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 03 Aug 2023 03:54:23 -0700
Received: from kbuild by d1ccc7e87e8f with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1qRVyI-00023f-2F;
        Thu, 03 Aug 2023 10:54:22 +0000
Date:   Thu, 3 Aug 2023 18:53:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        manivannan.sadhasivam@linaro.org
Cc:     oe-kbuild-all@lists.linux.dev, helgaas@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, quic_parass@quicinc.com,
        krzysztof.kozlowski@linaro.org,
        Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v5 2/4] PCI: qcom-ep: Add support for D-state change
 notification
Message-ID: <202308031857.u3v2s0bm-lkp@intel.com>
References: <1690948281-2143-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1690948281-2143-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

kernel test robot noticed the following build errors:

[auto build test ERROR on pci/next]
[also build test ERROR on pci/for-linus linus/master v6.5-rc4 next-20230803]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-chaitanya-chundru/PCI-endpoint-Add-D-state-change-notifier-support/20230802-115309
base:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
patch link:    https://lore.kernel.org/r/1690948281-2143-3-git-send-email-quic_krichai%40quicinc.com
patch subject: [PATCH v5 2/4] PCI: qcom-ep: Add support for D-state change notification
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20230803/202308031857.u3v2s0bm-lkp@intel.com/config)
compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
reproduce: (https://download.01.org/0day-ci/archive/20230803/202308031857.u3v2s0bm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202308031857.u3v2s0bm-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom-ep.c: In function 'qcom_pcie_ep_global_irq_thread':
>> drivers/pci/controller/dwc/pcie-qcom-ep.c:597:17: error: implicit declaration of function 'pci_epc_dstate_notify'; did you mean 'pci_epc_bme_notify'? [-Werror=implicit-function-declaration]
     597 |                 pci_epc_dstate_notify(pci->ep.epc, state);
         |                 ^~~~~~~~~~~~~~~~~~~~~
         |                 pci_epc_bme_notify
   cc1: some warnings being treated as errors


vim +597 drivers/pci/controller/dwc/pcie-qcom-ep.c

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
   587			state = dstate;
   588			if (dstate == 3) {
   589				val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
   590				val |= PARF_PM_CTRL_REQ_EXIT_L1;
   591				writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
   592	
   593				state = PCI_D3hot;
   594				if (gpiod_get_value(pcie_ep->reset))
   595					state = PCI_D3cold;
   596			}
 > 597			pci_epc_dstate_notify(pci->ep.epc, state);
   598		} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
   599			dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
   600			dw_pcie_ep_linkup(&pci->ep);
   601			pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
   602		} else {
   603			dev_dbg(dev, "Received unknown event: %d\n", status);
   604		}
   605	
   606		return IRQ_HANDLED;
   607	}
   608	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
