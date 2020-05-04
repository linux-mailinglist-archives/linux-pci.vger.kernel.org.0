Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 764D21C3CAA
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 16:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728498AbgEDOPY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 10:15:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:58708 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728486AbgEDOPY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 May 2020 10:15:24 -0400
Received: from localhost (mobile-166-175-184-168.mycingular.net [166.175.184.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5B49D20721;
        Mon,  4 May 2020 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588601723;
        bh=4OTUs88V5+gAe8AdiZH5K55ttinyK7tBrbq3axVmxJQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fGXiVH0q/KUvrxK42bzRAxzmJOFAsOoDQVM38AWNfJBALZLc6EFTe+Fe5E4YxQxLC
         f5aeCU1VezyuosRVGtnSe1nhjeuYQM7ict83sr0OXOz5TppI0T7qY/88eBLQgy7E1n
         BYytZM4Q9+JVCfY6MH/isb5D9FyARpgyuF0TPBfI=
Date:   Mon, 4 May 2020 09:15:21 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Enable ASPM L1 on TI PCIe-to-PCI bridge
Message-ID: <20200504141521.GA265122@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504070259.6034-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 04, 2020 at 03:02:59PM +0800, Kai-Heng Feng wrote:
> The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
> state deeper than PC3, consumes lots of unnecessary power.
> 
> On Windows ASPM L1 is enabled on the device and its upstream bridge,
> so it can make the Intel SoC reach PC8 or PC10 to save lots of power.

Does this work around some kind of hardware or firmware defect?  If
ASPM on this device works correctly, the generic code in aspm.c should
enable L1 automatically as it does for all other devices.

I don't think we should add quirks to set the ASPM configuration
directly for random devices.

> So enable ASPM L1 like Windows does, to save additional power.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/pci/quirks.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index ca9ed5774eb1..ac7eccf34f87 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -2330,6 +2330,27 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
>  
> +static void quirk_enable_aspm_l1(struct pci_dev *dev)
> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(dev);
> +	u16 lnkctl;
> +
> +	pci_info(dev, "Enabling L1\n");
> +	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
> +	if (!(lnkctl & PCI_EXP_LNKCTL_ASPM_L1))
> +		pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
> +					   lnkctl | PCI_EXP_LNKCTL_ASPM_L1);
> +
> +	if (!bridge)
> +		return;
> +
> +	pcie_capability_read_word(bridge, PCI_EXP_LNKCTL, &lnkctl);
> +	if (!(lnkctl & PCI_EXP_LNKCTL_ASPM_L1))
> +		pcie_capability_write_word(bridge, PCI_EXP_LNKCTL,
> +					   lnkctl | PCI_EXP_LNKCTL_ASPM_L1);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, 0x8240, quirk_enable_aspm_l1);
> +
>  /*
>   * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>   * Link bit cleared after starting the link retrain process to allow this
> -- 
> 2.17.1
> 
