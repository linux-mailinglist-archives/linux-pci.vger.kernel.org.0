Return-Path: <linux-pci+bounces-34264-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7ACDB2BC40
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 10:54:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19159562ED1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Aug 2025 08:52:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E673E311C07;
	Tue, 19 Aug 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Owd2CS/t"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A852C1DC9B1;
	Tue, 19 Aug 2025 08:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755593540; cv=none; b=s6sYOdxruOd7AQlPIUyD3QR1up9caAzMPH9jXUg1NWaCJdIP7DRgm7SQxFJWq8ZtZAZIoqW+1s3ExPL8UBaDKAxLv/Wlsfd/OhEb5Ir3C9CwUhjWQpsFKI1NPFvLxOOb81TcxiDTgnsaAlXZxgJIW4uh0VeIZ+oW/ixrSFEE7Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755593540; c=relaxed/simple;
	bh=yzUkQzaP8F8D4nlS0lE6qnZ/t2S0zQtHX8F4G8zhxvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jrc3JSwMMtGvb6oXX6om5I0v/NLX0UwlA1ULncjucg2m8YgyNjTVK9u20fhpD1mOhxFpHSAncrY9KMh9zn+JRf5vf1s0mA4DlKgMFtsb4v0uVIMh0idS8qUuKtnlWuenpjQayTrijdPS4zVP86O7FAMvx6aCI//Z+/UdOz6PgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Owd2CS/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CD24C4CEF1;
	Tue, 19 Aug 2025 08:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755593540;
	bh=yzUkQzaP8F8D4nlS0lE6qnZ/t2S0zQtHX8F4G8zhxvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Owd2CS/tHxduX/DRfTXQQ6NLQfGPqcoWJ0ErrWILlOh6P2+vTaCCEvr9K4XA7Tl8R
	 JS87cjbZFpr1Xk5rneTmVQ/jXCmFghpCuNzmBHKs4aXWBLKkhav2REL5xQ7Gv0knS2
	 PWe6iZFPj/yUDzPLcBDVp0MR7IbpcVzq2uAV3WxgP1P3A56FQsTUAmeJdF/CNe/NEa
	 dJdSoH2g2dN+p6eFqDgfpkunRVS7Vb5Wn8vT0i27mG7nNFaldi9J5Q9MT4lhQ0Hv7+
	 ud8eJVzDjQi5yuFCcFwyI6oGy2J5unLCnZJEo4XDDWibZxNRBUgkxcnSC4XmxDJHn8
	 ofODF2P7as1/g==
Date: Tue, 19 Aug 2025 14:22:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] PCI: imx6: Enable the vaux regulator when fetch it
Message-ID: <kvvluy56sdg6khv33cowseog4ujuebxzotlxm3hvm35slbenc5@rf3wttsd2niz>
References: <20250819071630.1813134-1-hongxing.zhu@nxp.com>
 <20250819071630.1813134-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250819071630.1813134-3-hongxing.zhu@nxp.com>

On Tue, Aug 19, 2025 at 03:16:30PM GMT, Richard Zhu wrote:
> Enable the vaux regulator at probe time and keep it enabled for the
> entire PCIe controller lifecycle. This ensures support for outbound
> wake-up mechanism such as WAKE# signaling.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 5a38cfaf989b1..1c1dce2d87e44 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -159,6 +159,7 @@ struct imx_pcie {
>  	u32			tx_deemph_gen2_6db;
>  	u32			tx_swing_full;
>  	u32			tx_swing_low;
> +	struct regulator	*vaux;
>  	struct regulator	*vpcie;
>  	struct regulator	*vph;
>  	void __iomem		*phy_base;
> @@ -1739,6 +1740,20 @@ static int imx_pcie_probe(struct platform_device *pdev)
>  	pci->max_link_speed = 1;
>  	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
>  
> +	/*
> +	 * Refer to PCIe CEM r6.0, sec 2.3 WAKE# Signal, WAKE# signal is only
> +	 * asserted by the Add-in Card when all its functions are in D3Cold
> +	 * state and at least one of its functions is enabled for wakeup
> +	 * generation. The 3.3V auxiliary power (+3.3Vaux) must be present and
> +	 * used for wakeup process. Since the main power supply would be gated
> +	 * off to let Add-in Card to be in D3Cold, get the vaux and keep it
> +	 * enabled to power up WAKE# circuit for the entire PCIe controller
> +	 * lifecycle when WAKE# is supported.
> +	 */

This comment implies that the presence of Vaux is dependent on WAKE#. But there
is no such check present in the code. Maybe you are referring to the fact that
the platform will only supply Vaux if it intends to support WAKE#?

But I guess you can just drop the comment altogether and move it to patch
description.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

