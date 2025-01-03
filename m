Return-Path: <linux-pci+bounces-19255-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98A68A00E63
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 20:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DBF3164846
	for <lists+linux-pci@lfdr.de>; Fri,  3 Jan 2025 19:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3941D61AC;
	Fri,  3 Jan 2025 19:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c+Deeg9V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD321A8F80;
	Fri,  3 Jan 2025 19:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735931991; cv=none; b=acOQFoaGEMP3AnBYU3Vd/4GSn/3Hk/oNY66mYURNSW2ShDSsV/2NSbz3VBxL8PikFpBOT4n33qI4050gc3WM8NsEqNKf3xg0WpKCsPkzO2YofGag6tIelFHgM0dv3wadHInTtUegFt1khPwtyISE2ZWqQbucg/m95M49JXS1Tbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735931991; c=relaxed/simple;
	bh=UXGyxRlGmAmUaGZwDyufZzkZnBt8bnaVeYMR/tdNg+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gylnud1M8CQigqkpowdCuXuhmSIlnoTZrNftjcj2nRsMTJ6nam/noBwTBpqKYyp1zg1LLncENH7bfX4t4luXOfcUlPVWGOF02OID3mdPG+aROhveQOr8TcDlkn39uTLhpi+BfbvGTYJIXii0OO0iicfMFdObDc0qe8TMugJcC1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c+Deeg9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8723DC4CECE;
	Fri,  3 Jan 2025 19:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735931990;
	bh=UXGyxRlGmAmUaGZwDyufZzkZnBt8bnaVeYMR/tdNg+Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=c+Deeg9V8VcFyWomkmsle9ozLucizmwJO5Gutz9vBqoQwXoCxuL8loK/x7obZvHEk
	 uHTo34zns+QN8AkiNsG7P+CS+Mvegxcq45X3iIPUO01K38zjW06iDv7iWC0lEdOOJs
	 LMGswkom9/wF+1cjL0RVIGvrV7OsvC8V6MgTeoNEHdIXdCVLGr/kacYmm2m9hLNbjg
	 YVw8AE6wINCaMy5MgoHSrDv8zWlck9GfZclIMh6cTY/N4OE+44l2RTDit1BiYL2Y9l
	 3MXb7vQx+pyFTev750QKolFs5hoi5ClshqRaToxvYoMrCg/MaHFu4WNzJCQsII+h1g
	 TuuddzAxEwQjA==
Date: Fri, 3 Jan 2025 13:19:48 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jianjun Wang <jianjun.wang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Xavier Chang <Xavier.Chang@mediatek.com>
Subject: Re: [PATCH 4/5] PCI: mediatek-gen3: Don't reply AXI slave error
Message-ID: <20250103191948.GA4190995@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103060035.30688-5-jianjun.wang@mediatek.com>

On Fri, Jan 03, 2025 at 02:00:14PM +0800, Jianjun Wang wrote:
> There are some circumstances where the EP device will not respond to
> non-posted access from the root port (e.g., MMIO read). In such cases,
> the root port will reply with an AXI slave error, which will be treated
> as a System Error (SError), causing a kernel panic and preventing us
> from obtaining any useful information for further debugging.
> 
> We have added a new bit in the PCIE_AXI_IF_CTRL_REG register to prevent
> PCIe AXI0 from replying with a slave error. Setting this bit on an older
> platform that does not support this feature will have no effect.
> 
> By preventing AXI0 from replying with a slave error, we can keep the
> kernel alive and debug using the information from AER.
> 
> Signed-off-by: Jianjun Wang <jianjun.wang@mediatek.com>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 4bd3b39eebe2..48f83c2d91f7 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -87,6 +87,9 @@
>  #define PCIE_LOW_POWER_CTRL_REG		0x194
>  #define PCIE_FORCE_DIS_L0S		BIT(8)
>  
> +#define PCIE_AXI_IF_CTRL_REG		0x1a8
> +#define PCIE_AXI0_SLV_RESP_MASK		BIT(12)
> +
>  #define PCIE_PIPE4_PIE8_REG		0x338
>  #define PCIE_K_FINETUNE_MAX		GENMASK(5, 0)
>  #define PCIE_K_FINETUNE_ERR		GENMASK(7, 6)
> @@ -469,6 +472,15 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  	val |= PCIE_FORCE_DIS_L0S;
>  	writel_relaxed(val, pcie->base + PCIE_LOW_POWER_CTRL_REG);
>  
> +	/*
> +	 * Prevent PCIe AXI0 from replying a slave error, as it will cause kernel panic
> +	 * and prevent us from getting useful information.
> +	 * Keep the kernel alive and debug using the information from AER.

Wrap to fit in 80 columns like the rest of the file

Add blank lines between paragraphs.

AER is an asynchronous mechanism, so if you disable the SError,
whoever issued the MMIO read to the PCIe device will receive some kind
of data.

I hope/assume that data is ~0 as on other platforms?  If so, please
confirm this in the comment and commit log.  Otherwise, the caller
will received corrupted data with no way to know that it's corrupted.

> +	 */
> +	val = readl_relaxed(pcie->base + PCIE_AXI_IF_CTRL_REG);
> +	val |= PCIE_AXI0_SLV_RESP_MASK;
> +	writel_relaxed(val, pcie->base + PCIE_AXI_IF_CTRL_REG);
> +
>  	/* Disable DVFSRC voltage request */
>  	val = readl_relaxed(pcie->base + PCIE_MISC_CTRL_REG);
>  	val |= PCIE_DISABLE_DVFSRC_VLT_REQ;
> -- 
> 2.46.0
> 

