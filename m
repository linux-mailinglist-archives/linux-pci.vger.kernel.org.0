Return-Path: <linux-pci+bounces-25748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ABEDA872F2
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9597A1EDC
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9931F150D;
	Sun, 13 Apr 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AQncs9AL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD70D1F1525
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 17:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744564988; cv=none; b=ag2WxWAv1HX+DiKxokGwn64wfNNamOi44xKrXah9ZO6WW2F1vYZcxK4PG91kgPIT/gitsVzL25HMHuogiMGfQsLDbADy9zX9ptPs9doKMcZUDMkd9U1W8fbrjr+aIOc+iwJp0CsqPD/SsQ8+nBNt0PSrZgDuIHoDcdU5A7U/QUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744564988; c=relaxed/simple;
	bh=+3rXgyYwnpGLLiDASVXR4Gp/bWkwXQqmC3/UYTJemow=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kepqL3MucryfHyTLnPOlUlyGr583d+fHw3LVK/6sB+hLBiGgIb0+YTy6X/OpuqKenAgda+nmQT4470nFhKijVJ3VAmlVVS/I8dxEY2xlT2/I1F5ThEL+1PEVkFJxbiWWd3iqAIIp6UwAwUbKN1zdYulSqXdJAkYjWmRnpuGGLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AQncs9AL; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-af590aea813so4216485a12.0
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 10:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744564985; x=1745169785; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=WMLqGtdJ/lNZg2u+SzDoYr1T8Gc3psQxwhxeVe0bA0Y=;
        b=AQncs9ALeCy8FBmQgaPeLCrg0l0RVyIGY3cOJvay/l3Csn4BZmVVX4kBtUU6GMlXXx
         kmw9fQiBuxtDXa+jPrS7+f+tJbcfAOSEHPpI9XoBGJbEsDFNAFScbiK5vbuZ+0iUtDbR
         as18yZed9qzxfafK0yMK+nPhtBl3azD2QN4SHwg6cl4aNTiKdRY3I9FYcWDkbWFB/Hms
         z5uXI9tWtZBZmUYciH4329CT2GnJGHEuXfC2w8nyW7WzqwcZhwFpjMrOM8qFbRaeqXZy
         h/pjqfIDzmncXgWRM2IzJJECE/LN0lbCVr4aRlvuYaaPl3EfqiO6vBAM2jnayna8G2zl
         GTNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744564985; x=1745169785;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WMLqGtdJ/lNZg2u+SzDoYr1T8Gc3psQxwhxeVe0bA0Y=;
        b=sSSNczjyjNqPy6djyCxKVqhoT3aT5JyHblS8hG1irfxCVX4kYu0BmMhZqTW8QhEzwp
         4d69fMQ96c2REUCo3NwSAgwO94PPaHEkCZu1No7Aw/7MNYKVlZabC548UrWVXwFxFsLc
         56Hf2COq0aDStpGQRqiumyD6+GOp/wA/wxtyKDV35YF6mjrQoBam1+9Ap7Leh4yPPrXE
         39/jPB5JSVx9HO6sRGtayXQe4/6m4H9/0nBfnivqU9LZn75plS67U7AHtGeqWTtIrtFY
         frZTeZ3JhWtVoxUiWMTD4borohfMhshzNSE2AOm+PT3prId9mu5aEbY69QPUb3YgRNaT
         7AgQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8A/mONuyOWNAZy1qrB6grTVF4txJzCjPT5wsT9oTDdk4UTc7kxNJFeZdjdGfAAY6JSezxA6plVp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJlG9m0p7AnI1juL8kA68mRIpu8slS8CKMn1AEybGgq+axRsZ8
	rV1lb81QVQPxqxKGLqVuNOx8Dzw3OARu4xRSBbTW9/oaWhMvAclJWBFftK93og==
X-Gm-Gg: ASbGncs3Hi43Ox6hd2do8n1HEJ/7tOa1lIjkPNRtY9Gw8H5Foqq7tE4ewSu5xNZLam0
	9/6RKX6skv8idu39TxyG2DZxaEhuPc2Y6svWnJLK+5V28YKZoVmHt4zuLjV5dpnXfzCb05tdklh
	BfGqU5hhiAOWPZlXjVTu1z9p0Grkv1Hr5Ih5Pf+vuIoo8kAzHYdM7Aqmvxo95oZK7eRJUwNXb5f
	4F25PihiM5FfzkTlZFzSddHIJndALQaA8vzH/fPWXzXDKXYDxxZ6a25OiTOgWVKhWBanv2QxRDL
	xFxmHST0vS3aH80GKyGYlCXjGSosn1JNStwrMnRdicvyVnZfzLEn
X-Google-Smtp-Source: AGHT+IFlRjD7Fra8KN0FhMq7Q6pK28kTkoPIZ2LALF6SUFBEuRkY8x4yld7mrcxkPzz2Bbxo02/hmw==
X-Received: by 2002:a17:902:ccce:b0:221:1497:7b08 with SMTP id d9443c01a7336-22b7f91d901mr213900565ad.23.1744564984871;
        Sun, 13 Apr 2025 10:23:04 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7ccb7b5sm84346255ad.237.2025.04.13.10.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:23:04 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:52:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 12/13] PCI: apple: Abstract register offsets via a
 SoC-specific structure
Message-ID: <vhmf25kseqbyt4nikec5i3aqb57kmjb6d3aenstuvflfl3xslp@66aclligtyoy>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-13-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-13-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:12AM +0100, Marc Zyngier wrote:
> From: Hector Martin <marcan@marcan.st>
> 
> Newer versions of the Apple PCIe block have a bunch of small, but
> annoying differences.
> 
> In order to embrace this diversity of implementations, move the
> currently hardcoded offsets into a hw_info structure. Future SoCs
> will provide their own structure describing the applicable offsets.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Hector Martin <marcan@marcan.st>
> Signed-off-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> [maz: split from original patch to only address T8103]
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-apple.c | 89 +++++++++++++++++++++++------
>  1 file changed, 72 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index 505adf64bd66d..847cba753d28d 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -18,6 +18,7 @@
>   * Author: Marc Zyngier <maz@kernel.org>
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/iopoll.h>
> @@ -29,6 +30,7 @@
>  #include <linux/of_irq.h>
>  #include <linux/pci-ecam.h>
>  
> +/* T8103 (original M1) and related SoCs */
>  #define CORE_RC_PHYIF_CTL		0x00024
>  #define   CORE_RC_PHYIF_CTL_RUN		BIT(0)
>  #define CORE_RC_PHYIF_STAT		0x00028
> @@ -104,7 +106,7 @@
>  #define   PORT_REFCLK_CGDIS		BIT(8)
>  #define PORT_PERST			0x00814
>  #define   PORT_PERST_OFF		BIT(0)
> -#define PORT_RID2SID(i16)		(0x00828 + 4 * (i16))
> +#define PORT_RID2SID			0x00828
>  #define   PORT_RID2SID_VALID		BIT(31)
>  #define   PORT_RID2SID_SID_SHIFT	16
>  #define   PORT_RID2SID_BUS_SHIFT	8
> @@ -122,7 +124,8 @@
>  #define   PORT_TUNSTAT_PERST_ACK_PEND	BIT(1)
>  #define PORT_PREFMEM_ENABLE		0x00994
>  
> -#define MAX_RID2SID			64
> +#define PORT_MSIMAP_ENABLE	BIT(31)
> +#define PORT_MSIMAP_TARGET	GENMASK(7, 0)
>  
>  /*
>   * The doorbell address is set to 0xfffff000, which by convention
> @@ -133,10 +136,33 @@
>   */
>  #define DOORBELL_ADDR		CONFIG_PCIE_APPLE_MSI_DOORBELL_ADDR
>  
> +struct hw_info {
> +	u32 phy_lane_ctl;
> +	u32 port_msiaddr;
> +	u32 port_msiaddr_hi;
> +	u32 port_refclk;
> +	u32 port_perst;
> +	u32 port_rid2sid;
> +	u32 port_msimap;
> +	u32 max_rid2sid;
> +};
> +
> +static const struct hw_info t8103_hw = {
> +	.phy_lane_ctl		= PHY_LANE_CTL,
> +	.port_msiaddr		= PORT_MSIADDR,
> +	.port_msiaddr_hi	= 0,
> +	.port_refclk		= PORT_REFCLK,
> +	.port_perst		= PORT_PERST,
> +	.port_rid2sid		= PORT_RID2SID,
> +	.port_msimap		= 0,
> +	.max_rid2sid		= 64,
> +};
> +
>  struct apple_pcie {
>  	struct mutex		lock;
>  	struct device		*dev;
>  	void __iomem            *base;
> +	const struct hw_info	*hw;
>  	struct irq_domain	*domain;
>  	unsigned long		*bitmap;
>  	struct list_head	ports;
> @@ -380,7 +406,9 @@ static void apple_port_irq_handler(struct irq_desc *desc)
>  static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
>  {
>  	struct fwnode_handle *fwnode = &port->np->fwnode;
> +	struct apple_pcie *pcie = port->pcie;
>  	unsigned int irq;
> +	u32 val = 0;
>  
>  	/* FIXME: consider moving each interrupt under each port */
>  	irq = irq_of_parse_and_map(to_of_node(dev_fwnode(port->pcie->dev)),
> @@ -402,13 +430,23 @@ static int apple_pcie_port_setup_irq(struct apple_pcie_port *port)
>  
>  	/* Configure MSI base address */
>  	BUILD_BUG_ON(upper_32_bits(DOORBELL_ADDR));
> -	writel_relaxed(lower_32_bits(DOORBELL_ADDR), port->base + PORT_MSIADDR);
> +	writel_relaxed(lower_32_bits(DOORBELL_ADDR),
> +		       port->base + pcie->hw->port_msiaddr);
> +	if (pcie->hw->port_msiaddr_hi)
> +		writel_relaxed(0, port->base + pcie->hw->port_msiaddr_hi);
>  
>  	/* Enable MSIs, shared between all ports */
> -	writel_relaxed(0, port->base + PORT_MSIBASE);
> -	writel_relaxed((ilog2(port->pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT) |
> -		       PORT_MSICFG_EN, port->base + PORT_MSICFG);
> +	if (pcie->hw->port_msimap) {
> +		for (int i = 0; i < pcie->nvecs; i++)
> +			writel_relaxed(FIELD_PREP(PORT_MSIMAP_TARGET, i) |
> +				       PORT_MSIMAP_ENABLE,
> +				       port->base + pcie->hw->port_msimap + 4 * i);
> +	} else {
> +		writel_relaxed(0, port->base + PORT_MSIBASE);
> +		val = ilog2(pcie->nvecs) << PORT_MSICFG_L2MSINUM_SHIFT;
> +	}
>  
> +	writel_relaxed(val | PORT_MSICFG_EN, port->base + PORT_MSICFG);
>  	return 0;
>  }
>  
> @@ -475,7 +513,9 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
>  	u32 stat;
>  	int res;
>  
> -	rmw_set(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
> +	if (pcie->hw->phy_lane_ctl)
> +		rmw_set(PHY_LANE_CTL_CFGACC, port->phy + pcie->hw->phy_lane_ctl);
> +
>  	rmw_set(PHY_LANE_CFG_REFCLK0REQ, port->phy + PHY_LANE_CFG);
>  
>  	res = readl_relaxed_poll_timeout(port->phy + PHY_LANE_CFG,
> @@ -492,20 +532,28 @@ static int apple_pcie_setup_refclk(struct apple_pcie *pcie,
>  	if (res < 0)
>  		return res;
>  
> -	rmw_clear(PHY_LANE_CTL_CFGACC, port->phy + PHY_LANE_CTL);
> +	if (pcie->hw->phy_lane_ctl)
> +		rmw_clear(PHY_LANE_CTL_CFGACC, port->phy + pcie->hw->phy_lane_ctl);
>  
>  	rmw_set(PHY_LANE_CFG_REFCLKEN, port->phy + PHY_LANE_CFG);
> -	rmw_set(PORT_REFCLK_EN, port->base + PORT_REFCLK);
> +
> +	if (pcie->hw->port_refclk)
> +		rmw_set(PORT_REFCLK_EN, port->base + pcie->hw->port_refclk);
>  
>  	return 0;
>  }
>  
> +static void __iomem *port_rid2sid_addr(struct apple_pcie_port *port, int idx)
> +{
> +	return port->base + port->pcie->hw->port_rid2sid + 4 * idx;
> +}
> +
>  static u32 apple_pcie_rid2sid_write(struct apple_pcie_port *port,
>  				    int idx, u32 val)
>  {
> -	writel_relaxed(val, port->base + PORT_RID2SID(idx));
> +	writel_relaxed(val, port_rid2sid_addr(port, idx));
>  	/* Read back to ensure completion of the write */
> -	return readl_relaxed(port->base + PORT_RID2SID(idx));
> +	return readl_relaxed(port_rid2sid_addr(port, idx));
>  }
>  
>  static int apple_pcie_setup_port(struct apple_pcie *pcie,
> @@ -528,7 +576,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	if (!port)
>  		return -ENOMEM;
>  
> -	port->sid_map = devm_bitmap_zalloc(pcie->dev, MAX_RID2SID, GFP_KERNEL);
> +	port->sid_map = devm_bitmap_zalloc(pcie->dev, pcie->hw->max_rid2sid, GFP_KERNEL);
>  	if (!port->sid_map)
>  		return -ENOMEM;
>  
> @@ -572,7 +620,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  	usleep_range(100, 200);
>  
>  	/* Deassert PERST# */
> -	rmw_set(PORT_PERST_OFF, port->base + PORT_PERST);
> +	rmw_set(PORT_PERST_OFF, port->base + pcie->hw->port_perst);
>  	gpiod_set_value_cansleep(reset, 0);
>  
>  	/* Wait for 100ms after PERST# deassertion (PCIe r5.0, 6.6.1) */
> @@ -585,7 +633,11 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  		return ret;
>  	}
>  
> -	rmw_clear(PORT_REFCLK_CGDIS, port->base + PORT_REFCLK);
> +	if (pcie->hw->port_refclk)
> +		rmw_clear(PORT_REFCLK_CGDIS, port->base + pcie->hw->port_refclk);
> +	else
> +		rmw_set(PHY_LANE_CFG_REFCLKCGEN, port->phy + PHY_LANE_CFG);
> +
>  	rmw_clear(PORT_APPCLK_CGDIS, port->base + PORT_APPCLK);
>  
>  	ret = apple_pcie_port_setup_irq(port);
> @@ -593,7 +645,7 @@ static int apple_pcie_setup_port(struct apple_pcie *pcie,
>  		return ret;
>  
>  	/* Reset all RID/SID mappings, and check for RAZ/WI registers */
> -	for (i = 0; i < MAX_RID2SID; i++) {
> +	for (i = 0; i < pcie->hw->max_rid2sid; i++) {
>  		if (apple_pcie_rid2sid_write(port, i, 0xbad1d) != 0xbad1d)
>  			break;
>  		apple_pcie_rid2sid_write(port, i, 0);
> @@ -741,7 +793,7 @@ static void apple_pcie_disable_device(struct pci_host_bridge *bridge, struct pci
>  	for_each_set_bit(idx, port->sid_map, port->sid_map_sz) {
>  		u32 val;
>  
> -		val = readl_relaxed(port->base + PORT_RID2SID(idx));
> +		val = readl_relaxed(port_rid2sid_addr(port, idx));
>  		if ((val & 0xffff) == rid) {
>  			apple_pcie_rid2sid_write(port, idx, 0);
>  			bitmap_release_region(port->sid_map, idx, 0);
> @@ -794,6 +846,9 @@ static int apple_pcie_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	pcie->dev = dev;
> +	pcie->hw = of_device_get_match_data(dev);
> +	if (!pcie->hw)
> +		return -ENODEV;
>  	pcie->base = devm_platform_ioremap_resource(pdev, 1);
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
> @@ -810,7 +865,7 @@ static int apple_pcie_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id apple_pcie_of_match[] = {
> -	{ .compatible = "apple,pcie" },
> +	{ .compatible = "apple,pcie",		.data = &t8103_hw },
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, apple_pcie_of_match);
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

