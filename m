Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A540C434062
	for <lists+linux-pci@lfdr.de>; Tue, 19 Oct 2021 23:19:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhJSVWK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 17:22:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:33220 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJSVWK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 17:22:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D0AC8611B0;
        Tue, 19 Oct 2021 21:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634678397;
        bh=epkVDp/bgEDm+bVqpoBVX3hB3fAbtLC2h6cSZU5ltYk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iNsRZai+xVGVtWVA6Yd/+UrA6KyiRnBTpsrECzZW7CIUT5xugp7Ph72cbRh6dpQBW
         K9ri5fa7om4G8BSt42QoJGggBINWX3tjs6bOTYYEjambebbcwwbfmMZ1kBMF54Gvy1
         m17i64ZZFDdx+BhwGwkqfIgZ+kYAfrlAU9zg/rEpqnkmB0ekcsSbZG/MOqJuZ0iejk
         ew21Krx34RYCOt56XGXoxnE6bPwMm3RMvhiUPLOkfNsVqKZEMoztV+z+p9fjmWMFzL
         e0oczSplreeP0uGK8UUB/8i8mlMVmauRd/ybXnVv/lOESfsyUcbtvTcHJALgueEZrF
         JLDW7pFOVtF2w==
Date:   Tue, 19 Oct 2021 16:19:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     mingchuang.qiao@mediatek.com
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        lambert.wang@mediatek.com, kerun.zhu@mediatek.com,
        rjw@rjwysocki.net, alex.williamson@redhat.com,
        utkarsh.h.patel@intel.com, mika.westerberg@linux.intel.com,
        rajatja@google.com
Subject: Re: [v5] PCI: Avoid unsync of LTR mechanism configuration
Message-ID: <20211019211955.GA2403055@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012075614.54576-1-mingchuang.qiao@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 12, 2021 at 03:56:14PM +0800, mingchuang.qiao@mediatek.com wrote:
> From: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> 
> In bus scan flow, the "LTR Mechanism Enable" bit of DEVCTL2 register is
> configured in pci_configure_ltr(). If device and bridge both support LTR
> mechanism, the "LTR Mechanism Enable" bit of device and bridge will be
> enabled in DEVCTL2 register. And pci_dev->ltr_path will be set as 1.
> 
> If PCIe link goes down, the "LTR Mechanism Enable" bit of bridge will 
> change to 0 according to PCIe r5.0, sec 7.5.3.16. However, the ->ltr_path 
> of bridge is still set.
> 
> Following shows two scenarios of this LTR issue:
> 
> -scenario of device restore
>  -- bridge LTR enabled
>  -- device LTR enabled
>  -- reset device
>  -- link goes down, bridge disables LTR
>  -- link comes back up, LTR disabled in both bridge and device
>  -- restore device state, including LTR enable
>  -- device sends LTR message
>  -- bridge reports Unsupported Request
> 
> -scenario of device hot-remove/hot-add
>  -- bridge LTR enabled
>  -- device LTR enabled
>  -- hot-remove device
>  -- link goes down, bridge disables LTR
>  -- hot-add device and link comes back up
>  -- scan device, set LTR enable bit of device
>  -- device sends LTR message
>  -- bridge reports Unsupported Request
> 
> This issue was noticed by AER log as following shows:
> pcieport 0000:00:1d.0: AER: Uncorrected (Non-Fatal) error received: id=00e8
> pcieport 0000:00:1d.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), 
> type=Transaction Layer, id=00e8(Requester ID)
> pcieport 0000:00:1d.0:   device [8086:9d18] error 
> status/mask=00100000/00010000
> pcieport 0000:00:1d.0:    [20] Unsupported Request    (First)
> 
> It was also noticed when PCIe devices (thunderbolt docks) were hot removed 
> from chromebooks, and then hot-plugged back again. Once hotplugged back, 
> the newer Intel chromebooks fail to go into S0ix low power state because 
> of this LTR issue.(https://patchwork.kernel.org/project/linux-pci/patch/
> 20210204095125.9212-1-mingchuang.qiao@mediatek.com/)
> 
> To resolve this issue, check and re-configure "LTR Mechanism Enable" bit
> of bridge to make "LTR Mechanism Enable" bit match ltr_path value in
> following conditions.
>    -before configuring device's LTR for hot-remove/hot-add
>    -before restoring device's DEVCTL2 register when restore device state
> 
> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>

Applied to pci/aspm for v5.16, thanks!

> ---
> changes of v5
>  -add more details in commit message
> changes of v4
>  -fix typo of commit message
>  -rename: pci_reconfigure_bridge_ltr()->pci_bridge_reconfigure_ltr()
> changes of v3
>  -call pci_reconfigure_bridge_ltr() in probe.c
> changes of v2
>  -modify patch description
>  -reconfigure bridge's LTR before restoring device DEVCTL2 register
> ---
>  drivers/pci/pci.c   | 25 +++++++++++++++++++++++++
>  drivers/pci/pci.h   |  1 +
>  drivers/pci/probe.c | 13 ++++++++++---
>  3 files changed, 36 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b9fecc25d213..6bf65d295331 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1437,6 +1437,24 @@ static int pci_save_pcie_state(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +void pci_bridge_reconfigure_ltr(struct pci_dev *dev)
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
> +	pci_bridge_reconfigure_ltr(dev);
> +
>  	cap = (u16 *)&save_state->cap.data[0];
>  	pcie_capability_write_word(dev, PCI_EXP_DEVCTL, cap[i++]);
>  	pcie_capability_write_word(dev, PCI_EXP_LNKCTL, cap[i++]);
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 5c59365092fa..b3a5e5287cb7 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -111,6 +111,7 @@ void pci_free_cap_save_buffers(struct pci_dev *dev);
>  bool pci_bridge_d3_possible(struct pci_dev *dev);
>  void pci_bridge_d3_update(struct pci_dev *dev);
>  void pci_bridge_wait_for_secondary_bus(struct pci_dev *dev);
> +void pci_bridge_reconfigure_ltr(struct pci_dev *dev);
>  
>  static inline void pci_wakeup_event(struct pci_dev *dev)
>  {
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..ade055e9fb58 100644
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
> +		pci_bridge_reconfigure_ltr(dev);
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_LTR_EN);
>  		dev->ltr_path = 1;
> -- 
> 2.18.0
