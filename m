Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD83A2F3D8E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Jan 2021 01:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbhALVnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 16:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405566AbhALVhR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 16:37:17 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 730C723102;
        Tue, 12 Jan 2021 21:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610487396;
        bh=nkb3u9pf9yQMGIPyswxyCO0Px53gLOaH0dhJ7L6TPkM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NcxiiEOfWj9HOVrCBrp9VtkT1NBUCvdlN+dgVvFpPWW9JEqRa347v2mhU/bYXNEPK
         FrxjuQozMo3c8tknVEpGisVTHnEMndS2YwIS4Epj9RZCPea7omsE3sp7U25k5Qaixe
         TN/51ORUcfLwlkBfQhkEcUpkJ5uaPksPjDTWTgB6TavTcEItBqbIGNvJX0mbuvZPjB
         NcJzBN1bj3HW7mRP+VRtf18x9+XAIrJ0TCxqPAV47zCiDOUOvU+xuetqxUTJnnF2vI
         bdGjoxulwev2XK5zlCDYAXoLBCnwhKOz3g2Edjka5fFl4Xwr1Ea6yjxy/Z0nwH0PB/
         8Lj70ePoqniLA==
Date:   Tue, 12 Jan 2021 15:36:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     mingchuang.qiao@mediatek.com
Cc:     bhelgaas@google.com, matthias.bgg@gmail.com,
        kerun.zhu@mediatek.com, linux-pci@vger.kernel.org,
        lambert.wang@mediatek.com, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, haijun.liu@mediatek.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] pci: avoid unsync of LTR mechanism configuration
Message-ID: <20210112213635.GA1854447@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112072739.31624-1-mingchuang.qiao@mediatek.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Note subject line tips at https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com

On Tue, Jan 12, 2021 at 03:27:39PM +0800, mingchuang.qiao@mediatek.com wrote:
> From: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> 
> In pci bus scan flow, the LTR mechanism enable bit of DEVCTL2 register
> is configured in pci_configure_ltr(). If device and it's bridge both
> support LTR mechanism, LTR mechanism of device and it's bridge will
> be enabled in DEVCTL2 register. And the flag pci_dev->ltr_path will
> be set as 1.

s/it's/its/ twice above.
It's == It is.
Its == belonging to 'it'.
Weird, I know, but that's English for you :)

> For some pcie products, pcie link becomes down when device reset. And then
> the LTR mechanism enable bit of bridge will become 0 based on description
> in PCIE r4.0, sec 7.8.16. However, the pci_dev->ltr_path value of bridge
> is still 1. Remove and rescan flow could be triggered to recover after
> device reset. In the bus rescan flow, the LTR mechanism of device will be
> enabled in pci_configure_ltr() due to ltr_path of its bridge is still 1.

s/pcie/PCIe/ twice above.
s/PCIE/PCIe/; also reference r5.0 instead of r4.0 if possible.

This sounds like a general problem of most device config bits being
cleared by reset.  Usually these are restored by pci_restore_state().
Is that function missing a restore for PCI_EXP_DEVCTL2?  I'd rather
have a general-purpose way of restoring all the config state than
little pieces scattered all over.

> When device's LTR mechanism is enabled, device will send LTR message to
> bridge. Bridge receives the device's LTR message and found bridge's LTR
> mechanism is disabled. Then the bridge will generate unsupported request
> and other error handling flow will be triggered such as AER Non-Fatal
> error handling.
> 
> This patch is used to avoid this unsupported request and make the bridge's
> ltr_path value is aligned with DEVCTL2 register value. Check bridge
> register value if aligned with ltr_path in pci_configure_ltr(). If
> register value is disable and the ltr_path is 1, we need configure
> the register value as enable.
> 
> Signed-off-by: Mingchuang Qiao <mingchuang.qiao@mediatek.com>
> ---
>  drivers/pci/probe.c | 18 +++++++++++++++---
>  1 file changed, 15 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..49355cf4af54 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2132,9 +2132,21 @@ static void pci_configure_ltr(struct pci_dev *dev)
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
> +			pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
> +						 PCI_EXP_DEVCTL2_LTR_EN);
> +		}
> +
>  		pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
>  					 PCI_EXP_DEVCTL2_LTR_EN);
>  		dev->ltr_path = 1;
> -- 
> 2.18.0
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
