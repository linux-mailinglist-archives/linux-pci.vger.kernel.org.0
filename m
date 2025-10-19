Return-Path: <linux-pci+bounces-38664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4475ABEDFAD
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 09:32:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C932F4E29CE
	for <lists+linux-pci@lfdr.de>; Sun, 19 Oct 2025 07:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98771F5825;
	Sun, 19 Oct 2025 07:32:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oysZ12Tn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF1FF9E8;
	Sun, 19 Oct 2025 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760859125; cv=none; b=DcoE8VyAIuYQlv76wpFsDMaxnw1mGJ7UYj9kZnPTz8Ih3E9VU/4RWAnEoIrLA3C5MBJrp7dMQmvzK6cB0NlArE9QMqvXqM/vJMw1MkuSqsDaoAgLZZUTv4/Z6PwwOEZtYXle6vAuejBpF43lM2ncIC3DKMptN1e+PQ3mU8BWNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760859125; c=relaxed/simple;
	bh=Q5WZijcRsjXr1RWFkwdQADczeQBWeDR34cnzsxqPN0o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EIzsBiwk5ptVzzTeEBK0joHG0SP/rF0BIRHa97nCcb+06HYPNerzBVyBIkfP/RohCRqwGZ4RelPEwFonCrQDOIpSF9lajFLUIblKqTH1KwrEzztNDnV+qRDSt2XUQ/O/jSMHyCgYHGCnF+dLSZV8K9WeI23QeKBolzPVy6YDcJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oysZ12Tn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF52DC4CEE7;
	Sun, 19 Oct 2025 07:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760859123;
	bh=Q5WZijcRsjXr1RWFkwdQADczeQBWeDR34cnzsxqPN0o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oysZ12Tnrxw8qCzJaaW5FvHJsX9RECC9QhUHD4trdla7ylQC1SGPQ9dxBvbwfh4AB
	 EZuq9TNoFGZKeRbBH5MmkMv3fcI3RkZjkGjXSDd3+cdi4WsjG0b2rv96lVjbHCAhko
	 KmEaHXcJCviGKhdxY00RrIu2XmkcpgHioxyHCVaYgG7yjyq+cuSpKV6+xGOI73Pm/g
	 lyAcuHPLAav9ye31NNhcKtGXM8Y4UMZvwgwXL7b2aMfSzjNPIpxbseiRy60DFPUNlb
	 ktnUvzx6DG1m9szD4Ci9xy3LYv/BIuwrz+O+2qj57v5bPxfRwJ+1CXFQ4bTuhKnZ4Z
	 aDQTsk24cusQQ==
Date: Sun, 19 Oct 2025 13:01:44 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, 
	Jianjun Wang <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, upstream@airoha.com
Subject: Re: [PATCH v5 5/5] PCI: mediatek: add support for Airoha AN7583 SoC
Message-ID: <hjyhso2sqgyq4ymzqg6pmjfrfncla24zwsev2mfinolmclm3ih@sol2yoapbykq>
References: <20251012205900.5948-1-ansuelsmth@gmail.com>
 <20251012205900.5948-6-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251012205900.5948-6-ansuelsmth@gmail.com>

On Sun, Oct 12, 2025 at 10:56:59PM +0200, Christian Marangi wrote:
> Add support for the second PCIe Root Complex present on Airoha AN7583
> SoC.
> 
> This is based on the Mediatek Gen1/2 PCIe driver and similar to Gen3
> also require workaround for the reset signals.
> 
> Introduce a new flag to skip having to reset signals and also introduce
> some additional logic to configure the PBUS registers required for
> Airoha SoC.
> 
> While at it, also add additional info on the PERST# Signal delay
> comments and use dedicated macro.
> 

This belongs to a separate patch which should come before this one.

> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/pcie-mediatek.c | 92 ++++++++++++++++++++------
>  1 file changed, 70 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 1678461e56d3..3340c005da4b 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -148,6 +148,7 @@ enum mtk_pcie_flags {
>  	NO_MSI = BIT(2), /* Bridge has no MSI support, and relies on an
>  			  * external block
>  			  */
> +	SKIP_PCIE_RSTB	= BIT(3), /* Skip calling RSTB bits on PCIe probe */
>  };
>  
>  /**
> @@ -684,28 +685,32 @@ static int mtk_pcie_startup_port_v2(struct mtk_pcie_port *port)
>  		regmap_update_bits(pcie->cfg, PCIE_SYS_CFG_V2, val, val);
>  	}
>  
> -	/* Assert all reset signals */
> -	writel(0, port->base + PCIE_RST_CTRL);
> -
> -	/*
> -	 * Enable PCIe link down reset, if link status changed from link up to
> -	 * link down, this will reset MAC control registers and configuration
> -	 * space.
> -	 */
> -	writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> -
> -	/*
> -	 * Described in PCIe CEM specification sections 2.2 (PERST# Signal) and
> -	 * 2.2.1 (Initial Power-Up (G3 to S0)). The deassertion of PERST# should
> -	 * be delayed 100ms (TPVPERL) for the power and clock to become stable.
> -	 */
> -	msleep(100);
> -
> -	/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> -	val = readl(port->base + PCIE_RST_CTRL);
> -	val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> -	       PCIE_MAC_SRSTB | PCIE_CRSTB;
> -	writel(val, port->base + PCIE_RST_CTRL);
> +	if (!(soc->flags & SKIP_PCIE_RSTB)) {
> +		/* Assert all reset signals */
> +		writel(0, port->base + PCIE_RST_CTRL);
> +
> +		/*
> +		 * Enable PCIe link down reset, if link status changed from
> +		 * link up to link down, this will reset MAC control registers
> +		 * and configuration space.
> +		 */
> +		writel(PCIE_LINKDOWN_RST_EN, port->base + PCIE_RST_CTRL);
> +
> +		/*
> +		 * Described in PCIe CEM specification revision 3.0 sections
> +		 * 2.2 (PERST# Signal) and 2.2.1 (Initial Power-Up (G3 to S0)).
> +		 *
> +		 * The deassertion of PERST# should be delayed 100ms (TPVPERL)
> +		 * for the power and clock to become stable.

You can drop the comments since PCIE_T_PVPERL_MS definition has them.

> +		 */
> +		msleep(PCIE_T_PVPERL_MS);
> +
> +		/* De-assert PHY, PE, PIPE, MAC and configuration reset	*/
> +		val = readl(port->base + PCIE_RST_CTRL);
> +		val |= PCIE_PHY_RSTB | PCIE_PERSTB | PCIE_PIPE_SRSTB |
> +		       PCIE_MAC_SRSTB | PCIE_CRSTB;
> +		writel(val, port->base + PCIE_RST_CTRL);

If PCIE_LINKDOWN_RST_EN corresponds to PERST# signal, then it should be
deasserted only after the power and REFCLK are stable. But I'm not sure what the
above PCIE_RST_CTRL setting is doing. If it somehow affects either power or
REFCLK, then it should come before PCIE_LINKDOWN_RST_EN.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

