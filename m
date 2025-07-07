Return-Path: <linux-pci+bounces-31638-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C73EAFBBC2
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 21:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 721DC3B9E5C
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 19:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264B926462B;
	Mon,  7 Jul 2025 19:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="olvyWCrK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFB01D6187;
	Mon,  7 Jul 2025 19:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751916859; cv=none; b=kaJWLYcqj6cjc7Pyk+0ng5TbOJcAha43mONcC39IW41iQbW0ifTMpIVuPrE1sbqSFDz+yEmaRFzgOP/cfT93FOvDC2uD2yhyKXQ6suG1/H3WAvGhhiAgWzqsGEzwh1jHyYqj+t0f0qz7eYLHXsdz2fW7xjB3WQniIOIviysVBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751916859; c=relaxed/simple;
	bh=q4Un9UMyAO/m5V5UCHaW8IYs1wCaLRO9F9XqUTWH3xE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iSaquByRJ/1cpConJZtVqBIGYuoCydkq6j6oHv+X3hjeAc9hgmeC6f24BFtjnI8uCM7BVYkMwcUZqrV/ujlaqVNPNHFqor63GbF8Dim/ITxB4hHTv/WjX/KScJ68Jgp4cS9eVMC4aUR7Q5v0x0nxmyksTA7puJNPqOCNnh5Lqp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=olvyWCrK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CF8EC4CEE3;
	Mon,  7 Jul 2025 19:34:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751916857;
	bh=q4Un9UMyAO/m5V5UCHaW8IYs1wCaLRO9F9XqUTWH3xE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=olvyWCrKA61vFemOq86pVptJUU70apmXkO1jxlJM/MIPixuIzFTpCaEOnxAvPAIN+
	 XPZ+T0AMf1zFyP5Ax8dCgixUzT+l4ErYyinB5XaNIvo2oUvj3bj3OHQV0Hu8v4Aacd
	 rki8Y/zvnAsFt9rAzExc2W8ZCKotFSsp4ETOJGnaffLAN8NtX/c6AIgv9mTT4xnU1i
	 fbWMeRaoNbYy2H5JcYaIngnm7EwkZGqU9HoRjwOPsXehuh4GHnfb2t7srYQkNzxpn7
	 sTneFKW+7gU2MCU33a6o5cMT3X8OQezYF97b0Mtf0xYjRDj2PwGuR/oHxuopGppRxw
	 /Tbcb0SDmJ7dw==
Date: Mon, 7 Jul 2025 14:34:15 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Message-ID: <20250707193415.GA2095765@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617073441.3228400-1-hongxing.zhu@nxp.com>

On Tue, Jun 17, 2025 at 03:34:41PM +0800, Richard Zhu wrote:
> i.MX8MQ PCIes have three 64-bit BAR0/2/4 capable and programmable BARs.
> But i.MX8MM and i.MX8MP PCIes only have BAR0/BAR2 64bit programmable
> BARs, and one 256 bytes size fixed BAR4.
> 
> Correct the epc_features for i.MX8MM and i.MX8MP PCIes here. i.MX8MQ is
> the same as i.MX8QXP, so set i.MX8MQ's epc_features to
> imx8q_pcie_epc_features.
> 
> Fixes: 75c2f26da03f ("PCI: imx6: Add i.MX PCIe EP mode support")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

"Correct the epc_features" doesn't include any specific information,
and it's hard to extract the changes for a device from the commit log.

This is really two fixes that should be separated so the commit logs
can be specific:

  - For IMX8MQ_EP, use imx8q_pcie_epc_features (64-bit BARs 0, 2, 4)
    instead of imx8m_pcie_epc_features (64-bit BARs 0, 2).

  - For IMX8MM_EP and IMX8MP_EP, add fixed 256-byte BAR 4 in
    imx8m_pcie_epc_features.

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b..9754cc6e09b9 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1385,6 +1385,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
>  	.msix_capable = false,
>  	.bar[BAR_1] = { .type = BAR_RESERVED, },
>  	.bar[BAR_3] = { .type = BAR_RESERVED, },
> +	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = SZ_256, },
> +	.bar[BAR_5] = { .type = BAR_RESERVED, },
>  	.align = SZ_64K,
>  };
>  
> @@ -1912,7 +1914,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
>  		.mode_off[1] = IOMUXC_GPR12,
>  		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
> -		.epc_features = &imx8m_pcie_epc_features,
> +		.epc_features = &imx8q_pcie_epc_features,
>  		.init_phy = imx8mq_pcie_init_phy,
>  		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
>  	},
> -- 
> 2.37.1
> 

