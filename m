Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4537831E7
	for <lists+linux-pci@lfdr.de>; Mon, 21 Aug 2023 22:21:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbjHUUOH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Aug 2023 16:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjHUUOF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Aug 2023 16:14:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A6DE3;
        Mon, 21 Aug 2023 13:14:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3526C64838;
        Mon, 21 Aug 2023 20:14:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473B8C433C9;
        Mon, 21 Aug 2023 20:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692648842;
        bh=JhMi2+GzkL/Eutsnn0WRkJmqRV/RT+NL9pChlj1qKxg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pFML8CHrMw2oGOkdn9OVZjl55kwjR+o5S9LOycl7oWvHoW2IVsKCDNnYbEZg8JxG8
         pqlwWlBITKbPT/TgHfiIPCLERXTm4AedvP04nB51oir6EjYC7uBPEDGzg/EwufW5IJ
         +IqN9vm8M9QXfta87NvEXP0yLRPeufnGDF+DaWQVNfhgrC3UblLDFKfxEStv2mfboi
         apQUDBSc1HL82SziZzJe4Wx6qook+z5rtIeUt4j6bjBXDjovI2bP/toa+SMwQcO9pk
         D0wrUUaufDSBnabOIXvxU57pLmV2SrkIbHMbxPNz9iHlb5KpFUj/7XYhkNYYQGL9FD
         Th2PuvUlLhkhw==
Date:   Mon, 21 Aug 2023 15:14:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        bhelgaas@google.com, lpieralisi@kernel.org, robh@kernel.org,
        kw@linux.com, michal.simek@amd.com,
        krzysztof.kozlowski+dt@linaro.org, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v6 3/3] PCI: xilinx-xdma: Add Xilinx XDMA Root Port driver
Message-ID: <20230821201400.GA367570@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818093507.24435-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 18, 2023 at 03:05:07PM +0530, Thippeswamy Havalige wrote:
> Add support for Xilinx XDMA Soft IP core as Root Port.
> 
> The Zynq UltraScale+ MPSoCs devices support XDMA soft IP module in
> programmable logic.
> 
> The integrated XDMA soft IP block has integrated bridge function that
> can act as PCIe Root Port.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v6:
> - Replaced chained irq's with regular interrupts.

Thanks a million for working this out!

Trivial comments below, wait a couple days before reposting in case
there are other comments.

> +static inline bool xilinx_pl_dma_pcie_link_up(struct pl_dma_pcie *port)
> +{
> +	return (pcie_read(port, XILINX_PCIE_DMA_REG_PSCR) &
> +		XILINX_PCIE_DMA_REG_PSCR_LNKUP) ? 1 : 0;

This function returns bool, so I think true/false would be more
appropriate than 1/0.

> +static bool xilinx_pl_dma_pcie_valid_device(struct pci_bus *bus,
> +					    unsigned int devfn)
> +{
> +	struct pl_dma_pcie *port = bus->sysdata;
> +
> +	/* Check if link is up when trying to access downstream ports */
> +	if (!pci_is_root_bus(bus)) {
> +		/*
> +		 * Checking whether link is up here is a last line of defence,
> +		 * if the link goes down after we check for link-up, we have a
> +		 * problem: if a PIO request is initiated while link-down, the
> +		 * whole controller hangs, and even after link comes up again,
> +		 * previous PIO requests won't work, and a reset of the whole
> +		 * PCIe controller is needed. Henceforth we need link-up check
> +		 * here to avoid sending PIO request when link is down. This
> +		 * check is racy by definition and does not make controller hang
> +		 * if the link goes down after this check is performed.

This comment doesn't make sense to me.  "If PIO request initiated
while link-down, controller hangs ... This check is racy and does not
make controller hang if link goes down."  Which is it?

My *guess* is that this check narrows the window but doesn't close it,
so if xilinx_pl_dma_pcie_link_up() finds the link up, but the link
goes down before pci_generic_config_read() initiates the PIO request,
the controller hangs, and a reset is required.

> +		 */
> +		if (!xilinx_pl_dma_pcie_link_up(port))
> +			return false;
> +	} else if (devfn > 0)
> +		/* Only one device down on each root port */
> +		return false;
> +
> +	return true;
> +}

> +/* INTx error interrupts are Xilinx controller specific interrupt, used to
> + * notify user about error's such as cfg timeout, slave unsupported requests,

s/error's/errors/

> + * fatal and non fatal error etc.

> +		err = devm_request_irq(dev, irq, xilinx_pl_dma_pcie_intr_handler,
> +				       IRQF_SHARED | IRQF_NO_THREAD, intr_cause[i].sym, port);

Rewrap to fit in 80 columns.

> +	/* Needed for MSI DECODE MODE */
> +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_LOW_MASK);
> +	pcie_write(port, XILINX_PCIE_DMA_IDR_ALL_MASK, XILINX_PCIE_DMA_REG_MSI_HI_MASK);

Rewrap.

Bjorn
