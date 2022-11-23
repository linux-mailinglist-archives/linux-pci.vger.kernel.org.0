Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7095F636E0F
	for <lists+linux-pci@lfdr.de>; Thu, 24 Nov 2022 00:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiKWXGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Nov 2022 18:06:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiKWXFx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Nov 2022 18:05:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 854A717024D;
        Wed, 23 Nov 2022 15:05:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3A766B82503;
        Wed, 23 Nov 2022 23:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58E2FC433C1;
        Wed, 23 Nov 2022 23:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669244740;
        bh=WvDBwfjaVvOEQHGt0bchNUrMTBCVHmD1JG+lP6VucLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jh9kNXFSMAKzWA+V3l4fe4QxYCWzFE2/GBMio9EPM0YfsF8DbM14ZMv0oVoQovCL+
         8jsErEyb3HKVHH6463oP5BCN+aV0cHmDUXhHdTE7oTTthQeFO1y38j9JBVrELF4zL7
         HaWrOPTVIrw509rg/c+4eDYOUDVNhQshxtw8QZdizkbYnPw71eBHzpWYoSxbB72Biw
         Al4grabUH4nFdMcovOtUTCVHaFvHRENFkfoBy0muARkd6n5DIP+nEmkI5hbns/vYEn
         DGmHpHPGLifdqRT919caaHGq1usKRKXV66wsyureNun8pPaHRR61SqbQoez/cyiInk
         QJtxtP5JRVI0w==
Date:   Wed, 23 Nov 2022 23:05:34 +0000
From:   Conor Dooley <conor@kernel.org>
To:     daire.mcnamara@microchip.com
Cc:     conor.dooley@microchip.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, paul.walmsley@sifive.com,
        palmer@dabbelt.com, aou@eecs.berkeley.edu, lpieralisi@kernel.org,
        kw@linux.com, bhelgaas@google.com, linux-riscv@lists.infradead.org,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 8/9] PCI: microchip: Partition inbound address
 translation
Message-ID: <Y36nPubPl08F/nag@spud>
References: <20221116135504.258687-1-daire.mcnamara@microchip.com>
 <20221116135504.258687-9-daire.mcnamara@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221116135504.258687-9-daire.mcnamara@microchip.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 16, 2022 at 01:55:03PM +0000, daire.mcnamara@microchip.com wrote:
> From: Daire McNamara <daire.mcnamara@microchip.com>
> 
> On Microchip PolarFire SoC the PCIe rootport is behind a set of fabric
> inter connect (fic) busses that encapsulate busses like ABP/AHP, AXI-S
> and AXI-M. Depending on which fic(s) the rootport is wired through to
> cpu space, the rootport driver needs to take account of the address
> translation done by a parent (e.g. fabric) node before setting up its
> own inbound address translation tables from attached devices.
> 
> Parse the dma-range properties to determine how much address translation
> to perform in the root port and how much is being provided by the
> fabric.
> 
> Signed-off-by: Daire McNamara <daire.mcnamara@microchip.com>
> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/pcie-microchip-host.c | 184 ++++++++++++++++++-
>  1 file changed, 178 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-microchip-host.c b/drivers/pci/controller/pcie-microchip-host.c
> index 62f8c5edfd0e..a90a0a675f14 100644
> --- a/drivers/pci/controller/pcie-microchip-host.c
> +++ b/drivers/pci/controller/pcie-microchip-host.c

> @@ -940,6 +954,46 @@ static int mc_pcie_init_irq_domains(struct mc_pcie *port)
>  	return mc_allocate_msi_domains(port);
>  }
>  
> +static int mc_pcie_setup_inbound_ranges(struct platform_device *pdev, struct mc_pcie *port)
> +{
> +	void __iomem *bridge_base_addr = port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
> +	phys_addr_t pcie_addr;
> +	phys_addr_t axi_addr;
> +	u32 atr_size;
> +	u32 val;
> +	int i;
> +
> +	for (i = 0; i < port->num_inbound_windows; i++) {
> +		atr_size = ilog2(port->inbound_windows[i].size) - 1;
> +		atr_size &= GENMASK(5, 0);
> +
> +		pcie_addr = port->inbound_windows[i].pci_addr;
> +
> +		val = lower_32_bits(pcie_addr) & GENMASK(31, 12);
> +		val |= (atr_size << ATR_SIZE_SHIFT);
> +		val |= ATR_IMPL_ENABLE;
> +		writel(val, bridge_base_addr +
> +		       ATR0_PCIE_WIN0_SRCADDR_PARAM + (i * ATR_WINDOW_DESC_SIZE));
> +		writel(upper_32_bits(pcie_addr), bridge_base_addr +
> +		       ATR0_PCIE_WIN0_SRC_ADDR + (i * ATR_WINDOW_DESC_SIZE));
> +
> +		axi_addr = port->inbound_windows[i].axi_addr;
> +
> +		writel(lower_32_bits(axi_addr), bridge_base_addr +
> +		       ATR0_PCIE_WIN0_TRSL_ADDR_LSB + (i * ATR_WINDOW_DESC_SIZE));
> +		writel(upper_32_bits(axi_addr), bridge_base_addr +
> +		       ATR0_PCIE_WIN0_TRSL_ADDR_UDW + (i * ATR_WINDOW_DESC_SIZE));
> +
> +		writel(TRSL_ID_AXI4_MASTER_0, bridge_base_addr +
> +		       ATR0_PCIE_WIN0_TRSL_PARAM + (i * ATR_WINDOW_DESC_SIZE));
> +
> +		dev_dbg(&pdev->dev, "0x%010llx..0x%010llx -> 0x%010llx\n",
> +			pcie_addr, pcie_addr + port->inbound_windows[i].size - 1, axi_addr);

If you're going to leave the dbg print in, can you make it more verbose
so that the log message stands on its own?

Other than that, I made most of my comments before submission so LGTM..
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

