Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92CEE633FC6
	for <lists+linux-pci@lfdr.de>; Tue, 22 Nov 2022 16:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbiKVPEo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Nov 2022 10:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233217AbiKVPEn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Nov 2022 10:04:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021A365F6;
        Tue, 22 Nov 2022 07:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A293FB81AF2;
        Tue, 22 Nov 2022 15:04:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41550C433C1;
        Tue, 22 Nov 2022 15:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669129479;
        bh=P9fA7ZwQiyLuOSFN0uBsRJicIpWm5a1d+ko8TW2gN8Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HDQdFxxyOEjTZRPW3tZdRQQAYijhdaM7D0xV4PtCL0x+8eTD7VBCxwTxnsrhBujYZ
         P0C0UIzBYUjE3wnGmLHZOZAgbM/MtG6L13XRhqtUDgQITVRwkb0f+MK7I4tJS79cCd
         ZYWF+2ROiGDJwzLrR89zbq+ayiFZoYJqWLBxwgMED8gJME13I4wa02ekb4MVtxYeHr
         jriPHtW8fHvJ7SZjwVsKiazwBpibVf8zg7vEsbkDCNHDIQb3Is+o0Ijtv8kajNhi+F
         //C+Z9zzji3DOZymzFuEgjvdEqX67jrfXIaD3z1vAiRx6JyYxnkSLsf/GymIvujVId
         WrUiVUCTSllDw==
Date:   Tue, 22 Nov 2022 09:04:37 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     lpieralisi@kernel.org, robh+dt@kernel.org, kw@linux.com,
        bhelgaas@google.com, krzk+dt@kernel.org,
        marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v7 7/9] PCI: rcar-gen4: Add R-Car Gen4 PCIe Host support
Message-ID: <20221122150437.GA187129@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221121124400.1282768-8-yoshihiro.shimoda.uh@renesas.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 21, 2022 at 09:43:58PM +0900, Yoshihiro Shimoda wrote:
> Add R-Car Gen4 PCIe Host support. This controller is based on
> Synopsys DesignWare PCIe.
> 
> This controller doesn't support MSI-X interrupt. So, introduce
> no_msix flag in struct dw_pcie_host_ops to clear MSI_FLAG_PCI_MSIX
> from dw_pcie_msi_domain_info.

> +	/* Enable L1 Substates */
> +	val = dw_pcie_readl_dbi(dw, L1PSCAP(PCI_L1SS_CTL1));
> +	val &= ~PCI_L1SS_CTL1_L1SS_MASK;
> +	val |= PCI_L1SS_CTL1_PCIPM_L1_2 | PCI_L1SS_CTL1_PCIPM_L1_1 |
> +	       PCI_L1SS_CTL1_ASPM_L1_2 | PCI_L1SS_CTL1_ASPM_L1_1;
> +	dw_pcie_writel_dbi(dw, L1PSCAP(PCI_L1SS_CTL1), val);

This seems like something that ought to be done by the PCI core in
pcie/aspm.c.  L1.2 also depends on LTR being supported and configured.

If it needs to be enabled here, can you expand the comment to say why
and how LTR is being configured?

> +	rcar_gen4_pcie_disable_bar(dw, BAR0MASKF);
> +	rcar_gen4_pcie_disable_bar(dw, BAR1MASKF);
> +
> +	/* Set Root Control */
> +	val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_RTCTL));
> +	val |= PCI_EXP_RTCTL_SECEE | PCI_EXP_RTCTL_SENFEE |
> +	       PCI_EXP_RTCTL_SEFEE | PCI_EXP_RTCTL_PMEIE |
> +	       PCI_EXP_RTCTL_CRSSVE;
> +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_RTCTL), val);
> +
> +	/* Set Interrupt Disable, SERR# Enable, Parity Error Response */
> +	val = dw_pcie_readl_dbi(dw, PCI_COMMAND);
> +	val |= PCI_COMMAND_PARITY | PCI_COMMAND_SERR |
> +	       PCI_COMMAND_INTX_DISABLE;
> +	dw_pcie_writel_dbi(dw, PCI_COMMAND, val);
> +
> +	/* Enable SERR */
> +	val = dw_pcie_readb_dbi(dw, PCI_BRIDGE_CONTROL);
> +	val |= PCI_BRIDGE_CTL_SERR;
> +	dw_pcie_writeb_dbi(dw, PCI_BRIDGE_CONTROL, val);
> +
> +	/* Device control */
> +	val = dw_pcie_readl_dbi(dw, EXPCAP(PCI_EXP_DEVCTL));
> +	val |= PCI_EXP_DEVCTL_CERE | PCI_EXP_DEVCTL_NFERE |
> +	       PCI_EXP_DEVCTL_FERE | PCI_EXP_DEVCTL_URRE;
> +	dw_pcie_writel_dbi(dw, EXPCAP(PCI_EXP_DEVCTL), val);

The above also looks like things that should be configured by the PCI
core.

> +		dev_err(&pdev->dev, "Failed to initialize host\n");
> +		dev_err(dev, "failed to request resource: %d\n", err);

Pick a capitalization style.

> +		dev_err(dev, "%s: failed to resume/get Runtime PM\n", __func__);

The driver name + device ID + message text printed by dev_err() should
be enough that __func__ isn't needed.

Bjorn
