Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7FE773126
	for <lists+linux-pci@lfdr.de>; Mon,  7 Aug 2023 23:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjHGVXe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Aug 2023 17:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbjHGVXd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Aug 2023 17:23:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24C70E74;
        Mon,  7 Aug 2023 14:23:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82C476223E;
        Mon,  7 Aug 2023 21:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 973D8C433C8;
        Mon,  7 Aug 2023 21:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691443410;
        bh=fmH6Kdyq4qEkTpKz/sfZWAf/z5YO3URGjEZfriKv3/k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cmmPnPoQLs9LAC+mZ6R6FOm60WDwQudsdo56n1PGDasuOeWEgaUBqgVfRlB0TKOhw
         i2AbMX/QPuA9FgvwC2mLMjhDW4zmMRfccVvdXcgMpGvnbteP4OP7v+SaTvUPk7NBhU
         FRiQsRrFgZZmT8Nkb6naoKF9NqFrM4U6vQ1z/E40LIQB0FAnrI18UfU9227zoAuqnI
         nGXS+4WiLXuZoRyZ66V6zo4ZGv9X/OGBScJynLne5GW1bHbQ06BnJ2/3+HN3y1hpJx
         SiJDsAIYtyRdpvux7IthUGjxYFH0KG4TrrsqWKmuQGfP9XAlZGKVwaf+ooXMXQ6aTF
         Nl32gLh1Jbh7w==
Date:   Mon, 7 Aug 2023 16:23:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, bharat.kumar.gogada@amd.com,
        michal.simek@amd.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v1 1/2] PCI: xilinx-nwl: Update ECAM default value and
 remove unnecessary code.
Message-ID: <20230807212328.GA272179@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807110733.77364-2-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Ideally the subject would include useful information about *why*
you're changing the ECAM value.  Drop the period at the end of the
subject.  E.g., something like:

  PCI: xilinx-nwl: Increase ECAM size to accommodate 256 buses

On Mon, Aug 07, 2023 at 04:37:32PM +0530, Thippeswamy Havalige wrote:
> Our controller is expecting ECAM size to be programmed by software.
> By programming "NWL_ECAM_VALUE_DEFAULT  12" controller can access up to
> 16MB ECAM region which is used to detect 16 buses, so by updating
> "NWL_ECAM_VALUE_DEFAULT " to 16 so that controller can access up to 256MB
> ECAM region to detect 256 buses.

Rob needs to ack this because it sounds like this change might make
the driver incompatible with DTs in the field, i.e., the user might be
forced to update the DT at the same time as picking up this driver
change.

> E_ECAM_CONTROL register from bit 16 to 20 uses this value as input
> to calculate ECAM Size.
> 
> The primary,secondary and sub-ordinate bus number registers are updated
> by Linux PCI core, so removing code which is updating primary,secondary
> and sub-ordinate bus numbers of type 1 header 18th offset of ECAM.

This code removal sounds like a separate logical change that could be
a separate patch.

s/primary,secondary/primary, secondary/ (twice)
s/removing/remove/

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> | https://lore.kernel.org/oe-kbuild-all/202308040330.eMTjX3tF-lkp@intel.
> | com/
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 18 +++---------------
>  1 file changed, 3 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 176686b..b515019 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -126,7 +126,7 @@
>  #define E_ECAM_CR_ENABLE		BIT(0)
>  #define E_ECAM_SIZE_LOC			GENMASK(20, 16)
>  #define E_ECAM_SIZE_SHIFT		16
> -#define NWL_ECAM_VALUE_DEFAULT		12
> +#define NWL_ECAM_VALUE_DEFAULT		16
>  
>  #define CFG_DMA_REG_BAR			GENMASK(2, 0)
>  #define CFG_PCIE_CACHE			GENMASK(7, 0)
> @@ -165,8 +165,6 @@ struct nwl_pcie {
>  	u32 ecam_size;
>  	int irq_intx;
>  	int irq_misc;
> -	u32 ecam_value;
> -	u8 last_busno;
>  	struct nwl_msi msi;
>  	struct irq_domain *legacy_irq_domain;
>  	struct clk *clk;
> @@ -625,7 +623,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	u32 breg_val, ecam_val, first_busno = 0;
> +	u32 breg_val, ecam_val;
>  	int err;
>  
>  	breg_val = nwl_bridge_readl(pcie, E_BREG_CAPABILITIES) & BREG_PRESENT;
> @@ -675,7 +673,7 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  			  E_ECAM_CR_ENABLE, E_ECAM_CONTROL);
>  
>  	nwl_bridge_writel(pcie, nwl_bridge_readl(pcie, E_ECAM_CONTROL) |
> -			  (pcie->ecam_value << E_ECAM_SIZE_SHIFT),
> +			  (NWL_ECAM_VALUE_DEFAULT << E_ECAM_SIZE_SHIFT),
>  			  E_ECAM_CONTROL);
>  
>  	nwl_bridge_writel(pcie, lower_32_bits(pcie->phys_ecam_base),
> @@ -683,15 +681,6 @@ static int nwl_pcie_bridge_init(struct nwl_pcie *pcie)
>  	nwl_bridge_writel(pcie, upper_32_bits(pcie->phys_ecam_base),
>  			  E_ECAM_BASE_HI);
>  
> -	/* Get bus range */
> -	ecam_val = nwl_bridge_readl(pcie, E_ECAM_CONTROL);
> -	pcie->last_busno = (ecam_val & E_ECAM_SIZE_LOC) >> E_ECAM_SIZE_SHIFT;
> -	/* Write primary, secondary and subordinate bus numbers */
> -	ecam_val = first_busno;
> -	ecam_val |= (first_busno + 1) << 8;
> -	ecam_val |= (pcie->last_busno << E_ECAM_SIZE_SHIFT);
> -	writel(ecam_val, (pcie->ecam_base + PCI_PRIMARY_BUS));
> -
>  	if (nwl_pcie_link_up(pcie))
>  		dev_info(dev, "Link is UP\n");
>  	else
> @@ -792,7 +781,6 @@ static int nwl_pcie_probe(struct platform_device *pdev)
>  	pcie = pci_host_bridge_priv(bridge);
>  
>  	pcie->dev = dev;
> -	pcie->ecam_value = NWL_ECAM_VALUE_DEFAULT;
>  
>  	err = nwl_pcie_parse_dt(pcie, pdev);
>  	if (err) {
> -- 
> 1.8.3.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
