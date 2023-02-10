Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3FCF692A93
	for <lists+linux-pci@lfdr.de>; Fri, 10 Feb 2023 23:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229476AbjBJWw3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Feb 2023 17:52:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjBJWw2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Feb 2023 17:52:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A99123D88;
        Fri, 10 Feb 2023 14:52:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0566AB82614;
        Fri, 10 Feb 2023 22:52:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 782EAC433EF;
        Fri, 10 Feb 2023 22:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676069544;
        bh=0drzW3eRMsgM82W+lr4/tR/Q3NADcNKLhfSlEmcCJDs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bht0gaip4fHLGiLfKra/qZTULokTOwpet8N8LQlDvvLVp8HLS3mYsqYu8xIRYK8u6
         Yx36Kb0Upj3C3mJDH9DtfxkMSNBXwCF0ZEMUzWjP9zMY9wx2rGBARATcMDak966PZR
         50j7kEsTEocXoKJ6Ipe2mvuFR5buWu6gsJV0LSkFyGllrKr40TpjHhkM4Ogjd5U3KP
         DZEAYXsRnK/D2uPVShchB78MAg6Byd94f543U/jtfFGHaAFmk0pWFKKXcH0aiVmVez
         UYH5Hnek6zoONO/kG7vU+CQD9ETZGzI5f1plkxcpw07ZYU9Jiwb6yNl3kK2S2fhlTb
         KhVwBRwIgM//A==
Date:   Fri, 10 Feb 2023 16:52:23 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        dan.j.williams@intel.com, ira.weiny@intel.com, bhelgaas@google.com,
        Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v6] cxl: add RAS status unmasking for CXL
Message-ID: <20230210225223.GA2706583@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167604864163.2392965.5102660329807283871.stgit@djiang5-mobl3.local>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 10, 2023 at 10:04:03AM -0700, Dave Jiang wrote:
> By default the CXL RAS mask registers bits are defaulted to 1's and
> suppress all error reporting. If the kernel has negotiated ownership
> of error handling for CXL then unmask the mask registers by writing 0s.
> 
> PCI_EXP_AER_FLAGS moved to linux/pci.h header to expose to driver. It
> allows exposure of system enabled PCI error flags for the driver to decide
> which error bits to toggle. Bjorn suggested that the error enabling should
> be controlled from the system policy rather than a driver level choice[1].
> 
> CXL RAS CE and UE masks are checked against PCI_EXP_AER_FLAGS before
> unmasking.
> 
> [1]: https://lore.kernel.org/linux-cxl/20230210122952.00006999@Huawei.com/T/#me8c7f39d43029c64ccff5c950b78a2cee8e885af

> +static int cxl_pci_ras_unmask(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	void __iomem *addr;
> +	u32 orig_val, val, mask;
> +
> +	if (!cxlds->regs.ras)
> +		return -ENODEV;
> +
> +	/* BIOS has CXL error control */
> +	if (!host_bridge->native_cxl_error)
> +		return -EOPNOTSUPP;
> +
> +	if (PCI_EXP_AER_FLAGS & PCI_EXP_DEVCTL_URRE) {

1) I don't really want to expose PCI_EXP_AER_FLAGS in linux/pci.h.
It's basically a convenience part of the AER implementation.

2) I think your intent here is to configure the CXL RAS masking based
on what PCIe error reporting is enabled, but doing it by looking at
PCI_EXP_AER_FLAGS doesn't seem right.  This expression is a
compile-time constant that is always true, but we can't rely on
devices always being configured that way.

We call pci_aer_init() for every device during enumeration, but we
only write PCI_EXP_AER_FLAGS if pci_aer_available() and if
pcie_aer_is_native().  And there are a bunch of drivers that call
pci_disable_pcie_error_reporting(), which *clears* those flags.  I'm
not sure those drivers *should* be doing that, but they do today.

I'm not sure why this needs to be conditional at all, but if it does,
maybe you want to read PCI_EXP_DEVCTL and base it on that?

> +		addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_MASK_OFFSET;
> +		orig_val = readl(addr);
> +
> +		mask = CXL_RAS_UNCORRECTABLE_MASK_MASK;

Weird name ("_MASK_MASK"), but I assume there's a good reason ;)

> +		if (!cxl_pci_flit_256(pdev))
> +			mask &= ~CXL_RAS_UNCORRECTABLE_MASK_F256B_MASK;
> +		val = orig_val & ~mask;
> +		writel(val, addr);
> +		dev_dbg(&pdev->dev,
> +			"Uncorrectable RAS Errors Mask: %#x -> %#x\n",
> +			orig_val, val);
> +	}

>  	if (cxlds->regs.ras) {
> -		pci_enable_pcie_error_reporting(pdev);
> -		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
> -		if (rc)
> -			return rc;
> +		rc = pci_enable_pcie_error_reporting(pdev);

I see you're just adding a check of return value here, but I'm not
sure you need to call pci_enable_pcie_error_reporting() in the first
place.  Isn't the call in the pci_aer_init() path enough?

> +++ b/include/uapi/linux/pci_regs.h
> @@ -693,6 +693,7 @@
>  #define  PCI_EXP_LNKCTL2_TX_MARGIN	0x0380 /* Transmit Margin */
>  #define  PCI_EXP_LNKCTL2_HASD		0x0020 /* HW Autonomous Speed Disable */
>  #define PCI_EXP_LNKSTA2		0x32	/* Link Status 2 */
> +#define  PCI_EXP_LNKSTA2_FLIT		BIT(10) /* Flit Mode Status */

Please spell out the hex constant.  This is to match the style of the
surrounding code, and it also gives a hint about the size of the
register.

Bjorn
