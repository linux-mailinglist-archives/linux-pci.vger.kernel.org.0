Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF2030A6A4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 12:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbhBALeP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 06:34:15 -0500
Received: from mga14.intel.com ([192.55.52.115]:32651 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhBALeL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Feb 2021 06:34:11 -0500
IronPort-SDR: B9NYTBIXfFOB2yzS3wD6VUrdX4jxYOfWgXYK4K+wtW7fr7aT/xCvuRxlItVsrVto1npyJO5zpT
 dWfh2ptSH8rw==
X-IronPort-AV: E=McAfee;i="6000,8403,9881"; a="179893342"
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="179893342"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 03:32:24 -0800
IronPort-SDR: uDBPuBlI6lww5J63dNZScwPZj5Wp4O3+ZRJ32zypyNKkFRd/SLkGKImhOrVRGJNs0b+p9g+lGo
 5sw3ScHdaGDQ==
X-IronPort-AV: E=Sophos;i="5.79,392,1602572400"; 
   d="scan'208";a="390865226"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 03:32:19 -0800
Received: by lahna (sSMTP sendmail emulation); Mon, 01 Feb 2021 13:32:17 +0200
Date:   Mon, 1 Feb 2021 13:32:17 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     mingchuang.qiao@mediatek.com
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        lambert.wang@mediatek.com, kerun.zhu@mediatek.com,
        alex.williamson@redhat.com, rjw@rjwysocki.net,
        utkarsh.h.patel@intel.com
Subject: Re: [v3] PCI: Avoid unsync of LTR mechanism configuration
Message-ID: <20210201113217.GL2542@lahna.fi.intel.com>
References: <20210129071137.8743-1-mingchuang.qiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129071137.8743-1-mingchuang.qiao@mediatek.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Fri, Jan 29, 2021 at 03:11:37PM +0800, mingchuang.qiao@mediatek.com wrote:
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

Typo mtach -> match.

>    -before configuring device's LTR for hot-remove/hot-add
>    -before restoring device's DEVCTL2 register when restore device state
> 
> Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> ---
> changes of v2
>  -modify patch description
>  -reconfigure bridge's LTR before restoring device DEVCTL2 register
> changes of v3
>  -call pci_reconfigure_bridge_ltr() in probe.c

Hmm, which part of this patch takes care of the reset path? It is not
entirely clear to me at least.

> ---
>  drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 13 ++++++++++---
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc25d213..12b557c8f062 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1437,6 +1437,24 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +void pci_reconfigure_bridge_ltr(struct pci_dev *dev)
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
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5c59365092fa..a660a01358c5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -111,6 +111,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> +void pci_reconfigure_bridge_ltr(struct pci_dev *dev);

Nit: calling it pci_bridge_reconfigure_ltr() would match better with the
other function names.

>  
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..fa6075093f3b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2132,9 +2132,16 @@ static void pci_configure_ltr(struct pci_dev *dev)
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
> +		pci_reconfigure_bridge_ltr(dev);
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_LTR_EN);
>  		dev->ltr_path = 1;
> -- 
> 2.18.0
