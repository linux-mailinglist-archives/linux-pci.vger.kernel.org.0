Return-Path: <linux-pci+bounces-8343-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1749A8FD424
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 19:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4D931F24CE9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 17:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7D613A3F1;
	Wed,  5 Jun 2024 17:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1ZRK6Zu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C8B139D0A;
	Wed,  5 Jun 2024 17:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717608562; cv=none; b=fcqob7FHB/GoPm6xKJU22Jx453YP6MxmJZjtmHcrPG16e9zLuCaQk0JP5iFlzE+W1+o7oRTaTzzJFNjdGreVM3/BEsIC+toEpUW0ePD+d5pflT5KI1PNxCCg94PUz2bMJ6cAOxF08VJi/2ckcGKvFaFHIZxyjU6h6NLT+WVkgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717608562; c=relaxed/simple;
	bh=DppWMKejR5gl9spYkpC8sVMolKcne6gchjDJGX49qOA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s7O7sxhoQlpo8rRusFoC0IWYl7oc5v8pJEltYhIeNZjlNvUu9/pNjcy8v/ElauQlp/TrexhHTCQxiWQeWYTTeZ9uGcEkUr9YdBgQN7BJnxbx0dim/6bEBZE4S94avrU4F/tk1bszqloHk8NY8YrK5tEZ7l5Y0xUtuJR1L2a0Nu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1ZRK6Zu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9732EC2BD11;
	Wed,  5 Jun 2024 17:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717608561;
	bh=DppWMKejR5gl9spYkpC8sVMolKcne6gchjDJGX49qOA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=g1ZRK6ZuC7uKvLxwzMs+SDawv2cKX98UEa8SkiywkKY0CV4c0lYjXtQbOf74pfspo
	 NetdiTq46Cz0mYFs5Qly6jKNNog+anCsfgTq54DWYkhEso097vEmuIJKUKuATnYKBm
	 MddOze3SmHLM67cdvDeE8yE+KKeYNJlhp4gD457IxUltn3g7iWa56TIXHFD33z34fG
	 tzT0o2flSoFhFvhRd+74b4bkPdgvwRKm44yX2p9C4RUBLnuJZA7M4uF/HrHCxuTj5+
	 iPGfIVU+2aWjqgemTe/6r+0k5bzhJxy1Jr9H2wUUK+2EksF1dVx1D+Jcda36LzkIRB
	 g5AkjyX20H6dA==
Date: Wed, 5 Jun 2024 12:29:19 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: Re: [PATCH v8 2/5] PCI: rcar-gen4: Add rcar_gen4_pcie_drvdata
Message-ID: <20240605172919.GA766124@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520074300.125969-3-yoshihiro.shimoda.uh@renesas.com>

On Mon, May 20, 2024 at 04:42:57PM +0900, Yoshihiro Shimoda wrote:
> In other to support future SoCs such as r8a779g0 and r8a779h0 that
> require different initialization settings, let's introduce SoC
> specific driver data with the initial member being the device mode.
> No functional change.

s/In other to/To/ or s/In other/In order/ if you prefer.
s/let's//

Whoever applies this can tweak it, no need to repost for this.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 32 +++++++++++++++------
>  1 file changed, 23 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 0be760ed420b..b11e09505b0b 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -48,11 +48,15 @@
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI_OFFSET	0x1000
>  #define RCAR_GEN4_PCIE_EP_FUNC_DBI2_OFFSET	0x800
>  
> +struct rcar_gen4_pcie_drvdata {
> +	enum dw_pcie_device_mode mode;
> +};
> +
>  struct rcar_gen4_pcie {
>  	struct dw_pcie dw;
>  	void __iomem *base;
>  	struct platform_device *pdev;
> -	enum dw_pcie_device_mode mode;
> +	const struct rcar_gen4_pcie_drvdata *drvdata;
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
> @@ -137,7 +141,7 @@ static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  	 * Since dw_pcie_setup_rc() sets it once, PCIe Gen2 will be trained.
>  	 * So, this needs remaining times for up to PCIe Gen4 if RC mode.
>  	 */
> -	if (changes && rcar->mode == DW_PCIE_RC_TYPE)
> +	if (changes && rcar->drvdata->mode == DW_PCIE_RC_TYPE)
>  		changes--;
>  
>  	for (i = 0; i < changes; i++) {
> @@ -172,9 +176,9 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
>  		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
>  
>  	val = readl(rcar->base + PCIEMSR0);
> -	if (rcar->mode == DW_PCIE_RC_TYPE) {
> +	if (rcar->drvdata->mode == DW_PCIE_RC_TYPE) {
>  		val |= DEVICE_TYPE_RC;
> -	} else if (rcar->mode == DW_PCIE_EP_TYPE) {
> +	} else if (rcar->drvdata->mode == DW_PCIE_EP_TYPE) {
>  		val |= DEVICE_TYPE_EP;
>  	} else {
>  		ret = -EINVAL;
> @@ -437,9 +441,11 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  /* Common */
>  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
> +	rcar->drvdata = of_device_get_match_data(&rcar->pdev->dev);
> +	if (!rcar->drvdata)
> +		return -EINVAL;
>  
> -	switch (rcar->mode) {
> +	switch (rcar->drvdata->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		return rcar_gen4_add_dw_pcie_rp(rcar);
>  	case DW_PCIE_EP_TYPE:
> @@ -480,7 +486,7 @@ static int rcar_gen4_pcie_probe(struct platform_device *pdev)
>  
>  static void rcar_gen4_remove_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	switch (rcar->mode) {
> +	switch (rcar->drvdata->mode) {
>  	case DW_PCIE_RC_TYPE:
>  		rcar_gen4_remove_dw_pcie_rp(rcar);
>  		break;
> @@ -500,14 +506,22 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
> +static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static struct rcar_gen4_pcie_drvdata drvdata_rcar_gen4_pcie_ep = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie",
> -		.data = (void *)DW_PCIE_RC_TYPE,
> +		.data = &drvdata_rcar_gen4_pcie,
>  	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie-ep",
> -		.data = (void *)DW_PCIE_EP_TYPE,
> +		.data = &drvdata_rcar_gen4_pcie_ep,
>  	},
>  	{},
>  };
> -- 
> 2.25.1
> 

