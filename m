Return-Path: <linux-pci+bounces-7820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9F0E8CED09
	for <lists+linux-pci@lfdr.de>; Sat, 25 May 2024 01:52:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27BD91F218AC
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 23:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824DA5C5F3;
	Fri, 24 May 2024 23:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CfZMWSpy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A3F57CB8
	for <linux-pci@vger.kernel.org>; Fri, 24 May 2024 23:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716594716; cv=none; b=j4/YZ/rdRASfSkhNtcdKoBm7bQt991AQ1JzCikMml3tFyLOLmJRXNggIWnouZIwpY+yicZGUIJq7mi8GsINiWnMClfO3IP+E20jRjRe31WZ87SxuVt3PjmpnXMaGOVsw60e+C99pGHKNNyos9fuTt7sZO+8gMyn3eBawUwlRoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716594716; c=relaxed/simple;
	bh=slUGVXzE8eGH+1xOAEIRndp11Y6yAeI8Oi2pMQd6DhI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BCY15lL32EepqSVbRGurAcsffKLofMRPvorlPZqoXtDaMbQjXDFkrXHVPE47f0k9EwbOe9suMWhmYDtunUuzVYQcBjs4NywWN/mc5Sn/TGC9qWZkyiCg26AW6zscUKK0WXmQJCh3y9D3fifx1XzRUMxKb3eb/sHxalrN/hsSI7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CfZMWSpy; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716594714; x=1748130714;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=slUGVXzE8eGH+1xOAEIRndp11Y6yAeI8Oi2pMQd6DhI=;
  b=CfZMWSpyQXCXADsKxTCLWncgkhhXTLR6A76grdiTz8Ki6/46PjRSFgo9
   dH4or2m+bVi2eKl+EzDO+4CQD1Wu1/ThGvNEE6zMOBsILcQNsPXLfXMDn
   MoWoUFTjWLy+cQ0lHyZnFKKvYC8pcTGD+iLoCBh00YYlq4uJsRpvtPfT9
   vZPelfUhjXRWDqbakzgqGivvUnGWdyWBNfllC+Y3ywpbftZ6S2kl09/+j
   Rq+doy178p5Ilsxx36JmNkDaXc+N3MeRfwgoQg3OzOl2bADzG3lXLwYso
   xLOu3nZTGwHO/lRjnRInA767Qf7RXISWB0oWepORARNtPs4Z5c+JQftNw
   A==;
X-CSE-ConnectionGUID: 05iZNXZ1Tp22qejxP/rkdA==
X-CSE-MsgGUID: Tr+LATJ9SsecIRKjYpMCfw==
X-IronPort-AV: E=McAfee;i="6600,9927,11082"; a="12771340"
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="12771340"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2024 16:51:54 -0700
X-CSE-ConnectionGUID: wcLjbRtxQaWqbk/SYb3nMQ==
X-CSE-MsgGUID: ZttNLpEUQCiWcM3EV/ZxSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,186,1712646000"; 
   d="scan'208";a="71581863"
Received: from unknown (HELO 0610945e7d16) ([10.239.97.151])
  by orviesa001.jf.intel.com with ESMTP; 24 May 2024 16:51:53 -0700
Received: from kbuild by 0610945e7d16 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1sAehP-000623-1P;
	Fri, 24 May 2024 23:51:48 +0000
Date: Sat, 25 May 2024 07:51:04 +0800
From: kernel test robot <lkp@intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: oe-kbuild-all@lists.linux.dev, linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Niklas Cassel <cassel@kernel.org>
Subject: [pci:controller/qcom 12/12]
 drivers/pci/controller/dwc/pcie-qcom-ep.c:658:17: error: implicit
 declaration of function 'dw_pcie_ep_linkdown'; did you mean
 'dw_pcie_ep_linkup'?
Message-ID: <202405250716.lpmrTGyQ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git controller/qcom
head:   1b36cee89f5f82bd04538b231e4261ed517ae174
commit: 1b36cee89f5f82bd04538b231e4261ed517ae174 [12/12] PCI: qcom-ep: Use the generic dw_pcie_ep_linkdown() API to handle Link Down event
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20240525/202405250716.lpmrTGyQ-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 13.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20240525/202405250716.lpmrTGyQ-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405250716.lpmrTGyQ-lkp@intel.com/

All errors (new ones prefixed by >>):

   drivers/pci/controller/dwc/pcie-qcom-ep.c: In function 'qcom_pcie_ep_global_irq_thread':
>> drivers/pci/controller/dwc/pcie-qcom-ep.c:658:17: error: implicit declaration of function 'dw_pcie_ep_linkdown'; did you mean 'dw_pcie_ep_linkup'? [-Werror=implicit-function-declaration]
     658 |                 dw_pcie_ep_linkdown(&pci->ep);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 dw_pcie_ep_linkup
   cc1: some warnings being treated as errors


vim +658 drivers/pci/controller/dwc/pcie-qcom-ep.c

   641	
   642	/* TODO: Notify clients about PCIe state change */
   643	static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
   644	{
   645		struct qcom_pcie_ep *pcie_ep = data;
   646		struct dw_pcie *pci = &pcie_ep->pci;
   647		struct device *dev = pci->dev;
   648		u32 status = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_STATUS);
   649		u32 mask = readl_relaxed(pcie_ep->parf + PARF_INT_ALL_MASK);
   650		u32 dstate, val;
   651	
   652		writel_relaxed(status, pcie_ep->parf + PARF_INT_ALL_CLEAR);
   653		status &= mask;
   654	
   655		if (FIELD_GET(PARF_INT_ALL_LINK_DOWN, status)) {
   656			dev_dbg(dev, "Received Linkdown event\n");
   657			pcie_ep->link_status = QCOM_PCIE_EP_LINK_DOWN;
 > 658			dw_pcie_ep_linkdown(&pci->ep);
   659		} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
   660			dev_dbg(dev, "Received BME event. Link is enabled!\n");
   661			pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
   662			qcom_pcie_ep_icc_update(pcie_ep);
   663			pci_epc_bme_notify(pci->ep.epc);
   664		} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
   665			dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
   666			val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
   667			val |= PARF_PM_CTRL_READY_ENTR_L23;
   668			writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
   669		} else if (FIELD_GET(PARF_INT_ALL_DSTATE_CHANGE, status)) {
   670			dstate = dw_pcie_readl_dbi(pci, DBI_CON_STATUS) &
   671						   DBI_CON_STATUS_POWER_STATE_MASK;
   672			dev_dbg(dev, "Received D%d state event\n", dstate);
   673			if (dstate == 3) {
   674				val = readl_relaxed(pcie_ep->parf + PARF_PM_CTRL);
   675				val |= PARF_PM_CTRL_REQ_EXIT_L1;
   676				writel_relaxed(val, pcie_ep->parf + PARF_PM_CTRL);
   677			}
   678		} else if (FIELD_GET(PARF_INT_ALL_LINK_UP, status)) {
   679			dev_dbg(dev, "Received Linkup event. Enumeration complete!\n");
   680			dw_pcie_ep_linkup(&pci->ep);
   681			pcie_ep->link_status = QCOM_PCIE_EP_LINK_UP;
   682		} else {
   683			dev_err(dev, "Received unknown event: %d\n", status);
   684		}
   685	
   686		return IRQ_HANDLED;
   687	}
   688	

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

