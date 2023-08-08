Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E75773FA3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Aug 2023 18:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233575AbjHHQui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Aug 2023 12:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233542AbjHHQtf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Aug 2023 12:49:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499D017A83;
        Tue,  8 Aug 2023 08:57:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1067862129;
        Tue,  8 Aug 2023 15:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D403C433C7;
        Tue,  8 Aug 2023 15:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691510200;
        bh=CYAIN+hBluNNXel12E9YVQxbYaxz9CVWUE5nfKL6+7k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HU3OlAtQ4k5a78DUGRFzHViT3BFA0n8uq26wIwdKsK8JoV0uKMiVMfwATnthIPWKR
         AGQKAOsCr9glJ92tHpxRKk7UtjG+jfg5byfGwtCjoziA/Asjss9FOHndgXyDEBBXGF
         bQ76F9cnbgFF1GQLncbdCjulv/b0RskJKgM8miGw4/8kEL7iF/lgyeuqnaC8XUzARz
         XMVyi+k6Lfyhs2SU/xKvhoh76SxsP2UYtSTInLUzJxXHwYjiG5y/6IbLd2hPeRmd/R
         hlbwugFanGIyJnWfxDeSetdMU8QbEFFmwwBuKYg2V85akWu8m87NuJt71TvGRArL3z
         3IdLh5Q/0gwJQ==
Date:   Tue, 8 Aug 2023 10:56:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc:     linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski@linaro.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        lpieralisi@kernel.org, bharat.kumar.gogada@amd.com,
        michal.simek@amd.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] PCI: xilinx-nwl: Remove unnecessary code which
 updates primary,secondary and sub-ordinate bus numbers.
Message-ID: <20230808155638.GA313716@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808103733.93707-1-thippeswamy.havalige@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 08, 2023 at 04:07:30PM +0530, Thippeswamy Havalige wrote:
> The primary,secondary and sub-ordinate bus number registers are updated by
> Linux PCI core, so remove code which updates repective fields of type 1
> header 18th offset of Root Port configuration space.

Whoever applies this, please:

  - Drop period from subject line
  - Add space after comma
  - s/repective/respective/
  - Fix up "18th"; I suppose this refers to the 18h offset, but the
    reference is too low-level and probably unnecessary since we
    already listed the affected registers

> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@amd.com>
> ---
> changes in v2:
> - Code increasing ECAM Size value is added into a seperate patch.
> - Modified commit messages.
> changes in v1:
> - Modified commit messages.
> ---
>  drivers/pci/controller/pcie-xilinx-nwl.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
> index 176686b..a73554e 100644
> --- a/drivers/pci/controller/pcie-xilinx-nwl.c
> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
> @@ -165,8 +165,6 @@ struct nwl_pcie {
>  	u32 ecam_size;
>  	int irq_intx;
>  	int irq_misc;
> -	u32 ecam_value;

The removal of "ecam_value" has nothing to do with the PCI core; it
seems more related to the NWL_ECAM_VALUE_DEFAULT change, and I would
either squash it into that patch or make it a separate "no functional
change" cleanup patch.

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
