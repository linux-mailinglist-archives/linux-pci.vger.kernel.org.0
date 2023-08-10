Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58BAC778292
	for <lists+linux-pci@lfdr.de>; Thu, 10 Aug 2023 23:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229967AbjHJVRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Aug 2023 17:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjHJVRR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Aug 2023 17:17:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392A92D4B;
        Thu, 10 Aug 2023 14:17:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDD6A65957;
        Thu, 10 Aug 2023 21:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FBCC433C7;
        Thu, 10 Aug 2023 21:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691702231;
        bh=3LqS9/KtuFBGW+687dYBLh6mzgQ9YDkrvb8IVmwzM3Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HyTWT51uLddJo7JMJG3HL14nmIbE7bBJrQSfOqhuFIyNUnrFzvPrf6A7+jkXmYaTB
         dalwTR8XEgk+6PBWcPVgEH9l1y4Hkf7yUOKuO9exI1dfUDzkTlltzOfnnDqmP6Z72k
         E8hLjV2zXGgfgXW5YlxLCETtT0x68jnNRP4KrFB1+qbaKZlOvn3Ddyo8h3FTte/hXC
         vEpujBUQq71bJ/sKbiNi2wPR0J/3/mRZ9jDq1I4XPRC7o9KS0IuuGvVKfQtyax6FmV
         34VtWBT9LnDR3vu82T/AqjB5tpe1i1J4d0o/tuURzqulU1YL4GlzIIrv0lZH0zHBFb
         fdOsSuyOQoqpw==
Received: (nullmailer pid 1202818 invoked by uid 1000);
        Thu, 10 Aug 2023 21:17:09 -0000
Date:   Thu, 10 Aug 2023 15:17:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, bhelgaas@google.com,
        krzysztof.kozlowski@linaro.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, conor+dt@kernel.org,
        lpieralisi@kernel.org, bharat.kumar.gogada@amd.com,
        michal.simek@amd.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/2] PCI: xilinx-nwl: Increase ECAM size to
 accommodate 256 buses
Message-ID: <20230810211709.GA1192858-robh@kernel.org>
References: <20230810122002.133531-1-thippeswamy.havalige@amd.com>
 <20230810122002.133531-4-thippeswamy.havalige@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810122002.133531-4-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 10, 2023 at 05:50:02PM +0530, Thippeswamy Havalige wrote:
> Our controller is expecting ECAM size to be programmed by software. By
> programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to 16MB
> ECAM region which is used to detect 16 buses, so by updating
> "NWL_ECAM_VALUE_DEFAULT" to 16 so that controller can access up to 256MB
> ECAM region to detect 256 buses.

What happens when your DT has the smaller size and the kernel configures 
the larger size? Seems like you could have an ABI issue.

> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v3:
> - Remove unnecessary period at end of subject line.
> changes in v2:
> - Update this changes in a seperate patch.
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index d8a3a08be1d5..b51501921d3b 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -126,7 +126,7 @@
>  #define E_ECAM_CR_ENABLE		BIT(0)
>  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
>  #define E_ECAM_SIZE_SHIFT		16
> -#define NWL_ECAM_VALUE_DEFAULT		12
> +#define NWL_ECAM_VALUE_DEFAULT		16

Not really a meaningful name. It doesn't explain what '16' means.

>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
>  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> @@ -165,7 +165,6 @@ struct nwl_pcie {
>  	u32 ecam_size;
>  	int irq_intx;
>  	int irq_misc;
> -	u32 ecam_value;
>  	struct nwl_msi msi;
>  	struct irq_domain *legacy_irq_domain;
>  	struct clk *clk;
> @@ -674,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
>  
>  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> -			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> +			  (NWL_ECAM_VALUE_DEFAULT << E_ECAM_SIZE_SHIFT),
>  			  E_ECAM_CONTROL);
>  
>  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
> @@ -782,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(bridge);
>  
>  	pcie->dev = dev;
> -	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
>  
>  	err = nwl_pcie_parse_dt(pcie, pdev);
>  	if (err) {
> -- 
> 2.17.1
> 
