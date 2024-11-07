Return-Path: <linux-pci+bounces-16249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C27209C0A13
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B2441F2656B
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA17212F13;
	Thu,  7 Nov 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S6ufIbl/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 785A6212F09
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 15:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730993229; cv=none; b=c549PLf4A4SJFVAJ0W0UL9aXJ5m9Bm1hmEQxrAxFQQYKeUWtyVWaVr5D+63onAjVn/rWOjkvcNfRGTgQSQmY1+CeSMy2u48SBtQa+gPdxbYjH+6ZY93/lNHP+x0xdl2MshDmSvW1CIifjT195Z5A66vnndHV2PAkHCBHMDBNPPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730993229; c=relaxed/simple;
	bh=dXituCL6gut0fSFPiXLwjg5t14g6zYP1Ea17MJMPgz4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Whtn9Jrj691J1Zhb4I3QKyIQt/Lez9aHxlO/7McsDrAyN2fNSlb28NUyo3iCtfbbbMYnouucPQN4mrGX3a9+hVqCUqW87VNlN2m9fRU2/ElBdAzUNTfYC7nHV4WwwJi9RH7DHhRFYaj9D9llmNnxq8Vvn8xWFqVvXzPQjQA3tZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S6ufIbl/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE479C4CECC;
	Thu,  7 Nov 2024 15:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730993228;
	bh=dXituCL6gut0fSFPiXLwjg5t14g6zYP1Ea17MJMPgz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=S6ufIbl/aTbis6ExmtWtZVMDUBioE4lSpL6WbJuTOaYbUyel0lIwRHhzHK+1UNv3L
	 Yifn3xFWnNahmjrVpeboMBpfkOSxMLpVY7uLWnvPdkm7vcVuP4mbFuL9o4Th/gKVth
	 fn4Xi+LwYky+wQPaLhbx6WzNJC4Iu5/yGWxJTvCdsnBS8pWEjR0UADUhM4ONDCtewM
	 yQ7QA7QE78xdMb1uaQIqG1X55kHNlJrrlkixTgRbvb0rRWk4uIGbyj+Url35VYjENi
	 efIheSQVwoDwwsND0x3GWvESf0eL1hnYjPit/K6tVqU2Bz3SK93zmbT/rtuMu2x4T4
	 SSzN7tpQk0tJQ==
Date: Thu, 7 Nov 2024 09:27:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Message-ID: <20241107152705.GA1614612@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-pcie-en7581-fixes-v1-3-af0c872323c7@kernel.org>

On Thu, Nov 07, 2024 at 02:50:55PM +0100, Lorenzo Bianconi wrote:
> In order to make the code more readable, move phy and mac reset lines
> assert/de-assert configuration in .power_up callback
> (mtk_pcie_en7581_power_up/mtk_pcie_power_up).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 8c8c733a145634cdbfefd339f4a692f25a6e24de..c0127d0fb4f059b9f9e816360130e183e8f0e990 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -867,6 +867,13 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	int err;
>  	u32 val;
>  
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);

Add blank line here.

>  	/*
>  	 * Wait for the time needed to complete the bulk assert in
>  	 * mtk_pcie_setup for EN7581 SoC.
> @@ -941,6 +948,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	int err;
>  
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);
> +	usleep_range(10, 20);

Unrelated to this patch, but since you're moving it, do you know what
this delay is for?  Can we add a #define and a spec citation for it?

Is there a requirement that the PHY and MAC reset ordering be
different for EN7581 vs other chips?

EN7581:

  assert PHY reset
  assert MAC reset
  power on PHY
  deassert PHY reset
  deassert MAC reset

others:

  assert PHY reset
  assert MAC reset
  deassert PHY reset
  power on PHY
  deassert MAC reset

Is there one order that would work for both?

>  	/* PHY power on and enable pipe clock */
>  	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  	if (err) {
> @@ -1013,14 +1029,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	 * counter since the bulk is shared.
>  	 */
>  	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> -	/*
> -	 * The controller may have been left out of reset by the bootloader
> -	 * so make sure that we get a clean start by asserting resets here.
> -	 */
> -	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> -
> -	reset_control_assert(pcie->mac_reset);
> -	usleep_range(10, 20);
>  
>  	/* Don't touch the hardware registers before power up */
>  	err = pcie->soc->power_up(pcie);
> 
> -- 
> 2.47.0
> 

