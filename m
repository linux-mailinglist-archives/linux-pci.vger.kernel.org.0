Return-Path: <linux-pci+bounces-19097-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C83FC9FE98B
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 18:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 189A23A2301
	for <lists+linux-pci@lfdr.de>; Mon, 30 Dec 2024 17:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41521ACEC6;
	Mon, 30 Dec 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ABrWQIbX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861CE19DFAB;
	Mon, 30 Dec 2024 17:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735581476; cv=none; b=e0LPrMh8uZzTdUpiMWrmAef1q3ySu/hdTuSn6pDRCa/Lexl37CKfCkbOzGXGfv0L4tZXObOU6oSPhVV7Iu7x/kCsYPEM81Ly/kXtlY2tX7YR2pC9R3XfJe+2IYKtaq7GlJZG7BmjIJjs22SobLFuFdYXfvML6MK5ghsTUYNJzAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735581476; c=relaxed/simple;
	bh=dzPrHdZM0//31eEZr1bEj6ShwlM5NON8mv2BEY16joc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Shac5bEPipQNt8VtzNIlUObWEeET9+ijotTa+P/YZbjZ3oPsKu5oRu7+JMg193kyXGJC2Z2oYTzP2TbMRuLWal9nWCtasNPkdP9ZR3D1j9fzfRMsLSMxFo9P3Q2qo/htDAokOEAXsjKHGCegPVAuUXsXqaMP36Oc6Ob1P7G4/Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ABrWQIbX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D7EC4CED2;
	Mon, 30 Dec 2024 17:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735581476;
	bh=dzPrHdZM0//31eEZr1bEj6ShwlM5NON8mv2BEY16joc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ABrWQIbXDRX/AAW+l2q3veDwIBQYYxj92TiTOPKiZoIzsYEhg0YUfXEjzs3/PLv9i
	 ipVPop8B7ACEYwqM1eGKMMMC8tK5vzS78vuuwS1To5vBvb6rqE307YtsW889IjSJPN
	 4EYuMfL+Um7ZTS2LyB96X9yocftLVufxNCVbEG1zrJNxETd8YbRRC8vCqRjUkAi3IV
	 XbtUwh0dMMQPvcN3rbaNu1prZSyr4BcANtlShv4j85nYPP/NbDen3w7a4O8AWj2yCI
	 LIbSYdCe+8hhMWkVwexRW+6w9qzlPDmbwd9CfRUdjl8pwFpWgTY0jC3Kt+OxVK8GPw
	 1TDPp/ofG+KXA==
Date: Mon, 30 Dec 2024 11:57:54 -0600
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 1/6] PCI: mediatek-gen3: Add missing
 reset_control_deassert() for mac_rst in mtk_pcie_en7581_power_up()
Message-ID: <20241230175754.GA3958277@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241130-pcie-en7581-fixes-v5-1-dbffe41566b3@kernel.org>

On Sat, Nov 30, 2024 at 12:20:10AM +0100, Lorenzo Bianconi wrote:
> Even if this is not a real issue since Airoha EN7581 SoC does not require
> the mac reset line, add missing reset_control_deassert() for mac reset
> line in mtk_pcie_en7581_power_up() callback.

s/mac/MAC/ in English text since "mac" is an acronym, not a real word

This doesn't really say why we need this patch.

This adds both assert and deassert, so it doesn't really look like
adding a *missing* deassert.

On EN7581, is mac_reset optional or always absent?

If mac_reset is always absent for EN7581, why add this patch at all?
If it's optional, say so.

> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 64ef8ff71b0357b9bf9ad8484095b7aa60c22271..4d1c797a32c236faf79428eb8a83708e9c4f21d8 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -942,6 +942,9 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	 */
>  	mdelay(PCIE_EN7581_RESET_TIME_MS);
>  
> +	/* MAC power on and enable transaction layer clocks */
> +	reset_control_deassert(pcie->mac_reset);
> +
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> @@ -976,6 +979,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  err_clk_prepare:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
> +	reset_control_assert(pcie->mac_reset);
>  	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  err_phy_deassert:
>  	phy_power_off(pcie->phy);
> 
> -- 
> 2.47.0
> 

