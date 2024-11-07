Return-Path: <linux-pci+bounces-16248-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 902B69C09EF
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 16:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 477DC1F21F8F
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 15:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E09F20EA5E;
	Thu,  7 Nov 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WTV9NgC9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E737DA9C
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730992795; cv=none; b=uGvTRoFiL6Nzp37yxGaLnlNGUaTd1g5+j1zdmL4jkqKFHQ+5Of9whgoSrDnxJFDgF8f5kLMJaSZYNmQNyl/MabV1Q2RPyN6SQeMoErZad1AF3ba1OXXKlxUbD/HCMYTphgLvAVPXDzgqVl0cKNB7xprVYCd45W7DIFkTsVPWBRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730992795; c=relaxed/simple;
	bh=A8YzchHkB7DFLxQ1pkz4RahkI6OHG7kU5FDQKVKsZYs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Qdvxdl0gsvh2J9JPsJdkJ+kuBeK9imiPpnJpkLbikKpvbO/h5lVuyA543AL4G8mOgfwVBnfhxPbajGyasBQdQqZ72NbaUiKfLSu72ucDyfoTY7yuSVmG5L0fadEV0wQParrVL15sKh40dU3tQWZgp01XvaqQRsWZY20DtnSau+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WTV9NgC9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0946C4CECD;
	Thu,  7 Nov 2024 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730992795;
	bh=A8YzchHkB7DFLxQ1pkz4RahkI6OHG7kU5FDQKVKsZYs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=WTV9NgC98AZVB9z8/2hlOTj3wjF8lh+yzQtX3pGqSqq4CoSyLlgU5D5xe4UeW5bS4
	 rDlwj18jamA1MUpzkGLEW6ZxJBlo6/5UyqekHUlttGTYzJ/oOp74PSzfMqujpcC8zt
	 /v3BheXuFcnWjmoMT9/uU5UuLFWj/pbeG0j0Cwt2peiMqe5bDWz9hUQZuBCHYuIL3B
	 hToK8XpEHoigZRoiQc0GJ5+vYefqaBirBmMJQRq3Mm2IARKOD4+yWCeNu39EoXLrBb
	 XCPQZLdZfA6T8tdZC4iQeMt94g4/f9ZcD07meUFv+i7EuhkAzXAqZRACmVPRjDe//X
	 zbFbcZ5lFMdkA==
Date: Thu, 7 Nov 2024 09:19:53 -0600
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
Subject: Re: [PATCH 2/3] PCI: mediatek-gen3: rely on clk_bulk_prepare_enable
 in mtk_pcie_en7581_power_up
Message-ID: <20241107151953.GA1614560@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107-pcie-en7581-fixes-v1-2-af0c872323c7@kernel.org>

On Thu, Nov 07, 2024 at 02:50:54PM +0100, Lorenzo Bianconi wrote:
> Squash clk_bulk_prepare and clk_bulk_enable in
> clk_bulk_prepare_enable in mtk_pcie_en7581_power_up routine

Thank you, this is much better.

Can you add "()" after function names in subject and commit logs here
and in other patches?

> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 0fac0b9fd785e463d26d29d695b923db41eef9cc..8c8c733a145634cdbfefd339f4a692f25a6e24de 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -903,12 +903,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> -	if (err) {
> -		dev_err(dev, "failed to prepare clock\n");
> -		goto err_clk_prepare;
> -	}
> -
>  	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
>  	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
>  	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> @@ -921,17 +915,15 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
>  	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
>  
> -	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
> +	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (err) {
>  		dev_err(dev, "failed to prepare clock\n");
> -		goto err_clk_enable;
> +		goto err_clk_init;
>  	}
>  
>  	return 0;
>  
> -err_clk_enable:
> -	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
> -err_clk_prepare:
> +err_clk_init:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	reset_control_assert(pcie->mac_reset);
> 
> -- 
> 2.47.0
> 

