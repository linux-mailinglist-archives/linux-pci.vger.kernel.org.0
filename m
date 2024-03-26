Return-Path: <linux-pci+bounces-5204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46D6088CE32
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 21:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 693451C65A7B
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 20:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203AF13D299;
	Tue, 26 Mar 2024 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8DWXsdd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5DC013D250;
	Tue, 26 Mar 2024 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484479; cv=none; b=D4eFRcRicasH8n59usSNd43qc40JvCPmU3idAo8e6dAkZZ52u6ZNlTXMAOhHHhubhpxQuCTemVaowzCjHZFHZ63Z0Bsd/hVDxDKr6Huw9zPi4Qo35KWEjzMIMVzElnp+XY8Hv/9ZXTtnWxlHt2zFU9d8w1idEHdK2X46Wow5iVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484479; c=relaxed/simple;
	bh=DKZdM9njkjBXtCvH6zuIqfP67yzAUkND2R8WjVveF+A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V4/7BcL1vMN0lmP3wewi806fVRHOmoQCddCXKEqAa+bQf0jBpFIqCh5sws1RrzD9Bex54dgtt11y3sL5o5lEprwvGqoR37vjTJ4iev3CnCiQEeMEd6AxhUgCIUjlQE2+P6CTCHDMI1hjmf8ZFvE6KLl8jExmTU0Z3Y/8GCBsLsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8DWXsdd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BAEC433C7;
	Tue, 26 Mar 2024 20:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711484478;
	bh=DKZdM9njkjBXtCvH6zuIqfP67yzAUkND2R8WjVveF+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=u8DWXsddT8c621kDqyxDAHRqxQq4Ke56H2ptu1ZzuOfTIDjyZxqRhDE0g58w2WF63
	 LNQRLfdRpNrcelyV37lsA2/sptYb0PEhZAROX21/XWVU3Ah3IITZ8JdPxn+YmFycep
	 UQiXvzEqSjpoJLe/SxD8XSSCuceCWbxqJ07arWBJriTAO+D4JYOH8BoxzpEMRPyvD9
	 xFth5nPj9QWSzkAdFvi9hgiYYbs1ltRXZJPWduQiFLi4lw8OjRgnlrMraRLHGg5WkQ
	 YtrRE1p6vgjJJmVEfsP79coyO5FKdn/AhNDLiL021aPveArbgHPoMNzIOdzSI368A+
	 G+LhoZahs4S/A==
Date: Tue, 26 Mar 2024 15:21:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com,
	gustavo.pimentel@synopsys.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 4/6] PCI: dwc: rcar-gen4: Add a new function pointer
 for other SoC support
Message-ID: <20240326202116.GA1492492@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326024540.2336155-5-yoshihiro.shimoda.uh@renesas.com>

Include the function pointer name in the subject so it's a little more
specific.

On Tue, Mar 26, 2024 at 11:45:38AM +0900, Yoshihiro Shimoda wrote:
> This driver can reuse other R-Car Gen4 SoC support. However, some
> initializing settings differs between r8a779f0 and others. So, add
> a new function pointer start_link_enable() to support other R-Car
> Gen4 SoC in the future. No behavior changes.

Make it clear here what the new SoC is.  I think it's r8a779f0, but
you have to read the patch and look for the new .compatible string to
figure that out.

> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> ---
>  drivers/pci/controller/dwc/pcie-rcar-gen4.c | 57 +++++++++++++++++++--
>  1 file changed, 52 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> index 0be760ed420b..a37613dd9ff4 100644
> --- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> +++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
> @@ -53,9 +53,16 @@ struct rcar_gen4_pcie {
>  	void __iomem *base;
>  	struct platform_device *pdev;
>  	enum dw_pcie_device_mode mode;
> +
> +	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);
>  };
>  #define to_rcar_gen4_pcie(_dw)	container_of(_dw, struct rcar_gen4_pcie, dw)
>  
> +struct rcar_gen4_pcie_platdata {
> +	enum dw_pcie_device_mode mode;
> +	int (*start_link_enable)(struct rcar_gen4_pcie *rcar);

I think it's confusing to repeat "mode" and "start_link_enable" in
both rcar_gen4_pcie and rcar_gen4_pcie_platdata.  I know several other
drivers use this pattern, but I think it is simpler overall to just
save the pointer directly, e.g.,

  imx6_pcie_probe
    imx6_pcie->drvdata = of_device_get_match_data(dev);

  ls_pcie_probe
    pcie->drvdata = of_device_get_match_data(dev);

  tegra_pcie_dw_probe
    data = of_device_get_match_data(dev);
    pcie->of_data = (struct tegra_pcie_dw_of_data *)data;

So I think the best thing would be to add struct
rcar_gen4_pcie_platdata, *move* rcar_gen4_pcie.mode there, and save a
pointer to the rcar_gen4_pcie_platdata in struct rcar_gen4_pcie.

That could be its own separate patch, which is nice on its own because
it gets rid of the (void *) casts in rcar_gen4_pcie_of_match[].

Then add .start_link_enable() (or .ltssm_enable(), see below) and the
r8a779f0 bits in another patch.

> +};
> +
>  /* Common */
>  static void rcar_gen4_pcie_ltssm_enable(struct rcar_gen4_pcie *rcar,
>  					bool enable)
> @@ -123,9 +130,13 @@ static int rcar_gen4_pcie_speed_change(struct dw_pcie *dw)
>  static int rcar_gen4_pcie_start_link(struct dw_pcie *dw)
>  {
>  	struct rcar_gen4_pcie *rcar = to_rcar_gen4_pcie(dw);
> -	int i, changes;
> +	int i, changes, ret;
>  
> -	rcar_gen4_pcie_ltssm_enable(rcar, true);
> +	if (rcar->start_link_enable) {
> +		ret = rcar->start_link_enable(rcar);

This looks basically like what qcom does:

  qcom_pcie_start_link
    if (pcie->cfg->ops->ltssm_enable)
      pcie->cfg->ops->ltssm_enable(pcie)

Can you copy that and use the same name for the pointer and function
name (.ltssm_enable, .*_ltssm_enable())?

> +		if (ret)
> +			return ret;
> +	}
>  
>  	/*
>  	 * Require direct speed change with retrying here if the link_gen is
> @@ -437,7 +448,10 @@ static void rcar_gen4_remove_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
>  /* Common */
>  static int rcar_gen4_add_dw_pcie(struct rcar_gen4_pcie *rcar)
>  {
> -	rcar->mode = (uintptr_t)of_device_get_match_data(&rcar->pdev->dev);
> +	const struct rcar_gen4_pcie_platdata *pd = of_device_get_match_data(&rcar->pdev->dev);
> +
> +	rcar->mode = pd->mode;
> +	rcar->start_link_enable = pd->start_link_enable;
>  
>  	switch (rcar->mode) {
>  	case DW_PCIE_RC_TYPE:
> @@ -500,14 +514,47 @@ static void rcar_gen4_pcie_remove(struct platform_device *pdev)
>  	rcar_gen4_pcie_unprepare(rcar);
>  }
>  
> +static int r8a779f0_pcie_start_link_enable(struct rcar_gen4_pcie *rcar)
> +{
> +	rcar_gen4_pcie_ltssm_enable(rcar, true);

Previously we called rcar_gen4_pcie_ltssm_enable() for
"renesas,rcar-gen4-pcie" and "renesas,rcar-gen4-pcie-ep".  But after
this patch, it looks like we only call it for "renesas,r8a779f0-pcie"
and "renesas,r8a779f0-pcie-ep"?

> +
> +	return 0;
> +}
> +
> +static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie = {
> +	.mode = DW_PCIE_RC_TYPE,
> +	.start_link_enable = r8a779f0_pcie_start_link_enable,
> +};
> +
> +static struct rcar_gen4_pcie_platdata platdata_r8a779f0_pcie_ep = {
> +	.mode = DW_PCIE_EP_TYPE,
> +	.start_link_enable = r8a779f0_pcie_start_link_enable,
> +};
> +
> +static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie = {
> +	.mode = DW_PCIE_RC_TYPE,
> +};
> +
> +static struct rcar_gen4_pcie_platdata platdata_rcar_gen4_pcie_ep = {
> +	.mode = DW_PCIE_EP_TYPE,
> +};
> +
>  static const struct of_device_id rcar_gen4_pcie_of_match[] = {
> +	{
> +		.compatible = "renesas,r8a779f0-pcie",
> +		.data = &platdata_r8a779f0_pcie,
> +	},
> +	{
> +		.compatible = "renesas,r8a779f0-pcie-ep",
> +		.data = &platdata_r8a779f0_pcie_ep,
> +	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie",
> -		.data = (void *)DW_PCIE_RC_TYPE,
> +		.data = &platdata_rcar_gen4_pcie,
>  	},
>  	{
>  		.compatible = "renesas,rcar-gen4-pcie-ep",
> -		.data = (void *)DW_PCIE_EP_TYPE,
> +		.data = &platdata_rcar_gen4_pcie_ep,
>  	},
>  	{},
>  };
> -- 
> 2.25.1
> 

