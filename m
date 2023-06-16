Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E05373349B
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 17:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231772AbjFPPVT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 11:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjFPPVS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 11:21:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BDDB359E;
        Fri, 16 Jun 2023 08:21:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 27186625B9;
        Fri, 16 Jun 2023 15:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194DEC433CA;
        Fri, 16 Jun 2023 15:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686928874;
        bh=I2J3TfKfw0KbmKhAvN4x6gXOdCm+sLoYTy4d6M0UgYg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Im9aBa4xcR8gQ6dmW9Xxz5aoqBqjyxRplkHfMhEvD4QjzYI4DrhpGWP4YPN1uazDZ
         qq5yNgeRZkMCs/EBZaTRitycXMfcL2GoxKP1FitXhb4zOEaQpYgLbsyKYctIUSoK1i
         91rVQ9Rq4uiAIrTiTIb/62YYzXyo3GCFfJHRNHfvmkQ+jMi/tE/uTalJM/KshKhxpT
         IPMlKk34ulVtPtrTT3+15Bzn/dNzXdpBCC5zIew3VdddtWG4thE2BPJZsW33GCVm53
         XEv0tE4diFx4eVa2elrM9TA48UaJSmch7z5LhtszNz1Opjh5PTxqUsuYAErmmD5Xjg
         XiMqVhG7rrPmw==
Date:   Fri, 16 Jun 2023 10:21:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     sharath.kumar.d.m@intel.com
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        dinguyen@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] pci: agilex_pci: add pcie rootport support for agilex
Message-ID: <20230616152112.GA1534746@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616063313.862996-2-sharath.kumar.d.m@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thanks for your patch.  If/when you revise it, run "git log --oneline
drivers/pci/controller/pcie-altera.c" and match the style of subject
lines, e.g.,

  PCI: altera: Add Intel Agilex support

On Fri, Jun 16, 2023 at 12:03:13PM +0530, sharath.kumar.d.m@intel.com wrote:
> From: D M Sharath Kumar <sharath.kumar.d.m@intel.com>

Also, please include a commit log.

Probably should also update the Kconfig help text to mention Agilex in
addition to Altera.

> +#include <linux/bitops.h>

I don't think this is needed.

> +static int aglx_rp_read_cfg(struct altera_pcie *pcie, int where,
> +			   int size, u32 *value)
> +{
> +	void __iomem *addr = AGLX_RP_CFG_ADDR(pcie, where);
> +
> +	switch (size) {
> +	case 1:
> +		*value = readb(addr);
> +		break;
> +	case 2:
> +		*value = readw(addr);
> +		break;
> +	default:
> +		*value = readl(addr);
> +		break;
> +	}
> +
> +	if (where == 0x3d)
> +		*value = 0x01;
> +	if (where == 0x3c)
> +		*value |= 0x0100;

This magic needs a comment.  Apparently it works around some hardware
defect?  What happens if this is a single byte read?  Looks like it
may set more than one byte of *value.

> +static int aglx_ep_write_cfg(struct altera_pcie *pcie, u8 busno,
> +		unsigned int devfn, int where, int size, u32 value)
> +{
> +	cs_writel(pcie, ((busno << 8) | devfn), AGLX_BDF_REG);
> +	if (busno > AGLX_RP_SECONDARY(pcie)) {
> +		/* type 1 */
> +		switch (size) {
> +		case 1:
> +			cs_writeb(pcie, value, ((1 << 12) | where));
> +			break;
> +		case 2:
> +			cs_writew(pcie, value, ((1 << 12) | where));
> +			break;
> +		default:
> +			cs_writel(pcie, value, ((1 << 12) | where));
> +			break;
> +		}
> +	} else {
> +		/* type 0 */
> +		switch (size) {
> +		case 1:
> +			cs_writeb(pcie, value, where);
> +			break;
> +		case 2:
> +			cs_writew(pcie, value, where);
> +			break;
> +		default:
> +			cs_writel(pcie, value, where);
> +				break;
> +		}
> +	}

These switches could be combined, e.g.,

  if (busno > AGLX_RP_SECONDARY(pcie))
    where |= 1 << 12;

> +	if (status & CFG_AER) {
> +		ret = generic_handle_domain_irq(pcie->irq_domain, 0);
> +		if (ret)
> +			dev_err_ratelimited(dev, "unexpected IRQ,\n");

Spurious "," at end of line.

> @@ -692,11 +904,27 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>  {
>  	struct platform_device *pdev = pcie->pdev;
>  
> -	pcie->cra_base = devm_platform_ioremap_resource_byname(pdev, "Cra");
> -	if (IS_ERR(pcie->cra_base))
> -		return PTR_ERR(pcie->cra_base);
> +	if ((pcie->pcie_data->version == ALTERA_PCIE_V1) ||
> +		(pcie->pcie_data->version == ALTERA_PCIE_V2)) {
> +		pcie->cra_base =
> +			devm_platform_ioremap_resource_byname(pdev, "Cra");
> +		if (IS_ERR(pcie->cra_base))
> +			return PTR_ERR(pcie->cra_base);
> +	}

Should be a separate introductory patch since it's not directly
related to Agilex.

> -	if (pcie->pcie_data->version == ALTERA_PCIE_V2) {
> +	if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
> +		pcie->cs_base =
> +			devm_platform_ioremap_resource_byname(pdev, "Cs");
> +		if (IS_ERR(pcie->cs_base))
> +			return PTR_ERR(pcie->cs_base);
> +		of_property_read_u32(pcie->pdev->dev.of_node, "port_conf_stat",
> +				&port_conf_off);
> +		dev_info(&pcie->pdev->dev, "port_conf_stat_off =%x\n",
> +			port_conf_off);
> +	}
> +
> +	if ((pcie->pcie_data->version == ALTERA_PCIE_V2) ||
> +		(pcie->pcie_data->version == ALTERA_PCIE_V3)) {

Ditto.

>  		pcie->hip_base =
>  			devm_platform_ioremap_resource_byname(pdev, "Hip");
>  		if (IS_ERR(pcie->hip_base))
> @@ -708,7 +936,8 @@ static int altera_pcie_parse_dt(struct altera_pcie *pcie)
>  	if (pcie->irq < 0)
>  		return pcie->irq;
>  
> -	irq_set_chained_handler_and_data(pcie->irq, altera_pcie_isr, pcie);
> +	irq_set_chained_handler_and_data(pcie->irq,
> +		pcie->pcie_data->ops->rp_isr, pcie);

Ditto (including the new .rp_isr initializations below).

> @@ -721,6 +950,7 @@ static const struct altera_pcie_ops altera_pcie_ops_1_0 = {
>  	.tlp_read_pkt = tlp_read_packet,
>  	.tlp_write_pkt = tlp_write_packet,
>  	.get_link_status = altera_pcie_link_up,
> +	.rp_isr = altera_pcie_isr,
>  };

> @@ -793,11 +1045,17 @@ static int altera_pcie_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> -	/* clear all interrupts */
> -	cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> -	/* enable all interrupts */
> -	cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> -	altera_pcie_host_init(pcie);
> +	if ((pcie->pcie_data->version == ALTERA_PCIE_V1) ||
> +		(pcie->pcie_data->version == ALTERA_PCIE_V2)) {
> +		/* clear all interrupts */
> +		cra_writel(pcie, P2A_INT_STS_ALL, P2A_INT_STATUS);
> +		/* enable all interrupts */
> +		cra_writel(pcie, P2A_INT_ENA_ALL, P2A_INT_ENABLE);
> +		altera_pcie_host_init(pcie);

Ditto.

> +	} else if (pcie->pcie_data->version == ALTERA_PCIE_V3) {
> +		writel(CFG_AER, (pcie->hip_base + port_conf_off
> +			+ AGLX_ROOT_PORT_IRQ_ENABLE));
> +	}
>  
>  	bridge->sysdata = pcie;
>  	bridge->busnr = pcie->root_bus_nr;
> -- 
> 2.34.1
> 
