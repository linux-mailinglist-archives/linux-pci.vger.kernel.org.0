Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA65B30780B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 15:29:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229840AbhA1O3f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 09:29:35 -0500
Received: from mga17.intel.com ([192.55.52.151]:46518 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231586AbhA1O3e (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 28 Jan 2021 09:29:34 -0500
IronPort-SDR: TiWbAe8k6q2U7d3uPWM4lSyp+yrMTMsx9986JilPAGwQ3owBNfQSPO2wB88gv4g1SZAGFnq4BC
 p2Yx656S6ybA==
X-IronPort-AV: E=McAfee;i="6000,8403,9877"; a="160012376"
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="160012376"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:27:48 -0800
IronPort-SDR: +PFPIvlRjek6MWrX9uP9iaFFhGEDkOin/OloFocOFfpB2UombOfcu9lElfPgCPSR9ahsCgLNZN
 pBm+PFjtZHqw==
X-IronPort-AV: E=Sophos;i="5.79,382,1602572400"; 
   d="scan'208";a="363775047"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2021 06:27:44 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 28 Jan 2021 16:27:42 +0200
Date:   Thu, 28 Jan 2021 16:27:42 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     mingchuang.qiao@mediatek.com
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        lambert.wang@mediatek.com, kerun.zhu@mediatek.com,
        alex.williamson@redhat.com, rjw@rjwysocki.net,
        utkarsh.h.patel@intel.com
Subject: Re: [v2] PCI: Avoid unsync of LTR mechanism configuration
Message-ID: <20210128142742.GV2542@lahna.fi.intel.com>
References: <20210128100531.2694-1-mingchuang.qiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210128100531.2694-1-mingchuang.qiao@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jan 28, 2021 at 06:05:31PM +0800, mingchuang.qiao@mediatek.com wrote:
> From: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> 
> In bus scan flow, the "LTR Mechanism Enable" bit of DEVCTL2 register is
> configured in pci_configure_ltr(). If device and bridge both support LTR
> mechanism, the "LTR Mechanism Enable" bit of device and bridge will be
> enabled in DEVCTL2 register. And pci_dev->ltr_path will be set as 1.
> 
> If PCIe link goes down when device resets, the "LTR Mechanism Enable" bit
> of bridge will change to 0 according to PCIe r5.0, sec 7.5.3.16. However,
> the pci_dev->ltr_path value of bridge is still 1.
> 
> For following conditions, check and re-configure "LTR Mechanism Enable" bit
> of bridge to make "LTR Mechanism Enable" bit mtach ltr_path value.
>    -before configuring device's LTR for hot-remove/hot-add
>    -before restoring device's DEVCTL2 register when restore device state
> 
> Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> ---
> changes of v2
>  -modify patch description
>  -reconfigure bridge's LTR before restoring device DEVCTL2 register
> ---
>  drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
>  drivers/pci/probe.c | 19 ++++++++++++++++---
>  2 files changed, 41 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc25d213..88b4eb70c252 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1437,6 +1437,24 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static void pci_reconfigure_bridge_ltr(struct pci_dev *dev)
> +{
> +#ifdef CONFIG_PCIEASPM
> +	struct pci_dev *bridge;
> +	u32 ctl;
> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (bridge && bridge->ltr_path) {
> +		pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
> +		if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
> +			pci_dbg(bridge, "re-enabling LTR\n");
> +			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> +						 PCI_EXP_DEVCTL2_LTR_EN);
> +		}
> +	}
> +#endif
> +}
> +
>  static void pci_restore_pcie_state(struct pci_dev *dev)
>  {
>  	int i = 0;
> @@ -1447,6 +1465,13 @@ static void pci_restore_pcie_state(struct pci_dev *dev)
>  	if (!save_state)
>  		return;
>  
> +	/*
> +	 * Downstream ports reset the LTR enable bit when link goes down.
> +	 * Check and re-configure the bit here before restoring device.
> +	 * PCIe r5.0, sec 7.5.3.16.
> +	 */
> +	pci_reconfigure_bridge_ltr(dev);
> +
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..4ad172517fd2 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2132,9 +2132,22 @@ static void pci_configure_ltr(struct pci_dev *dev)
>  	 * Complex and all intermediate Switches indicate support for LTR.
>  	 * PCIe r4.0, sec 6.18.
>  	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> -	    ((bridge = pci_upstream_bridge(dev)) &&
> -	      bridge->ltr_path)) {
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
> +		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
> +					 PCI_EXP_DEVCTL2_LTR_EN);
> +		dev->ltr_path = 1;
> +		return;
> +	}
> +
> +	bridge = pci_upstream_bridge(dev);
> +	if (bridge && bridge->ltr_path) {
> +		pcie_capability_read_dword(bridge, PCI_EXP_DEVCTL2, &ctl);
> +		if (!(ctl & PCI_EXP_DEVCTL2_LTR_EN)) {
> +			pci_dbg(bridge, "re-enabling LTR\n");
> +			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> +						 PCI_EXP_DEVCTL2_LTR_EN);
> +		}
> +

Can't you use pci_reconfigure_bridge_ltr() here too?

Otherwise looks good.
