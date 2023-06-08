Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 557967289AE
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jun 2023 22:52:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233008AbjFHUwO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Jun 2023 16:52:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjFHUwN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Jun 2023 16:52:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7942119;
        Thu,  8 Jun 2023 13:52:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9CDE860B14;
        Thu,  8 Jun 2023 20:52:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73D1C433D2;
        Thu,  8 Jun 2023 20:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686257530;
        bh=dZRF0wu4p8bFAXmnVVu+7pXv++o6TuoR/UAe4rtPADA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=kydLsX4FK+/GlVwJwgrTWO+uQisApyThlieEqq2y/E1IZewKB9VmsQp35KAwMls/n
         thQohIYKhutjOfbq/aTGeVZZ5lOI7VvHI/Qt9v+QgKXyJGVvTOlmN6Tifb1dxvTiez
         OhM6WQuU/38O2/xKwbvPgikTPY3EVfGMWtPxyzx/dcXiKMLDgDMoI/zwr+fM3jgfbo
         LBHmK7Bt6U+CXDZZkZJSMc2RB+Ulwphz8XmmpCBFJTqo0Cp591M3TmZFU4oIzBAvxf
         Tmcu/hEuvl28hkK/v6qPJkNk47VB1d58oPnP9TI4IEoh172Uy+FNZoC2fMipLCR3dk
         SWXQBQjvRwbrg==
Date:   Thu, 8 Jun 2023 15:52:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     ville.syrjala@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [Intel-gfx] [PATCH V2] PCI: Move VMD ASPM/LTR fix to PCI quirk
Message-ID: <20230608205208.GA1214785@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411213323.1362300-1-david.e.box@linux.intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 11, 2023 at 02:33:23PM -0700, David E. Box wrote:
> In commit f492edb40b54 ("PCI: vmd: Add quirk to configure PCIe ASPM and
> LTR") the VMD driver calls pci_enabled_link_state as a callback from
> pci_bus_walk. Both will acquire the pci_bus_sem lock leading to a lockdep
> warning. Instead of doing the pci_bus_walk, move the fix to quirks.c using
> DECLARE_PCI_FIXUP_FINAL.

s/pci_enabled_link_state/pci_enable_link_state/

Add "()" after pci_enable_link_state() and pci_bus_walk() to make it
obvious they're functions.

> ...
> +++ b/drivers/pci/quirks.c
> @@ -6023,3 +6023,75 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
>  #endif
> +
> +#ifdef CONFIG_VMD
> +/*
> + * Enable ASPM on the PCIE root ports under VMD and set the default LTR of the
> + * storage devices on platforms where these values are not configured by BIOS.
> + * This is needed for laptops, which require these settings for proper power
> + * management of the SoC.

s/PCIE/PCIe/ to match spec usage.

> + */
> +#define VMD_DEVICE_LTR	0x1003	/* 3145728 ns */

It would be nice to know how this value was derived.  But I know we
had this hard-coded value before, so it's not new with this patch.

> +static void quirk_intel_vmd(struct pci_dev *pdev)

I think this quirk could possibly stay in
drivers/pci/controller/vmd.c, couldn't it?  It has a lot of
VMD-specific knowledge that it would nice to contain in vmd.c.

> +{
> +	struct pci_dev *parent;
> +	u16 ltr = VMD_DEVICE_LTR;

I don't think "ltr" is an improvement over using "VMD_DEVICE_LTR"
below.

> +	u32 ltr_reg;
> +	int pos;
> +
> +	/* Check in VMD domain */
> +	if (pci_domain_nr(pdev->bus) < 0x10000)
> +		return;

If in vmd.c, maybe could identify devices under a VMD by checking
pdev->bus->ops as vmd_acpi_find_companion() does?

> +	/* Get Root Port */
> +	parent = pci_upstream_bridge(pdev);
> +	if (!parent || parent->vendor != PCI_VENDOR_ID_INTEL)
> +		return;
> +
> +	/* Get VMD Host Bridge */
> +	parent = to_pci_dev(parent->dev.parent);
> +	if (!parent)
> +		return;
> +
> +	/* Get RAID controller */
> +	parent = to_pci_dev(parent->dev.parent);
> +	if (!parent)
> +		return;
> +
> +	switch (parent->device) {
> +	case 0x467f:
> +	case 0x4c3d:
> +	case 0xa77f:
> +	case 0x7d0b:
> +	case 0xad0b:
> +	case 0x9a0b:
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	pci_enable_link_state(pdev, PCIE_LINK_STATE_ALL);

Seems like you would want to set LTR *before* enabling the link
states?

> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_LTR);
> +	if (!pos)
> +		return;
> +
> +	/* Skip if the max snoop LTR is non-zero, indicating BIOS has set it */
> +	pci_read_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, &ltr_reg);
> +	if (!!(ltr_reg & (PCI_LTR_VALUE_MASK | PCI_LTR_SCALE_MASK)))
> +		return;
> +
> +	/*
> +	 * Set the LTR values to the maximum required by the platform to
> +	 * allow the deepest power management savings. Write as a DWORD where
> +	 * the lower word is the max snoop latency and the upper word is the
> +	 * max non-snoop latency.

This comment suggests that the LTR value is platform-dependent, which
is what I would expect, but the code and the hard-coded VMD_DEVICE_LTR
value don't have any platform dependencies.  Again, nothing new in
*this* patch; that's true in the current tree, too.

> +	ltr_reg = (ltr << 16) | ltr;
> +	pci_write_config_dword(pdev, pos + PCI_LTR_MAX_SNOOP_LAT, ltr_reg);
> +	pci_info(pdev, "LTR set by VMD PCI quick\n");

s/quick/quirk/

> +
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_ANY_ID, PCI_ANY_ID,
> +			      PCI_CLASS_STORAGE_EXPRESS, 0, quirk_intel_vmd);
> +#endif
> -- 
> 2.34.1
> 
