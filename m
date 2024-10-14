Return-Path: <linux-pci+bounces-14493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E4BC99D56D
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34D671F2452E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E87551BDABD;
	Mon, 14 Oct 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKA7pD6Y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B236029A0;
	Mon, 14 Oct 2024 17:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728926289; cv=none; b=h4mbvzMbTt3fSqWRlDjer7oY2ynofYH2vAlMTGf61BFQDGensZWv37P8TG+r6bh56oi++LVS0SDc/CKryhHFpVU/D9r4k+HsWXwHfIiMCen2Jj5oVu6biC45rxNuyY5Ko61kBmzaT5LY/ZLdvzCPf38pev85irRshKcRnmRM57o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728926289; c=relaxed/simple;
	bh=1ziApFauYenoCS9MtS1B+tDzb5Mh3mm1sv1noAcTU6k=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=iU7wtcXUxGokl0WIHv1YNj/DGx4wCVyTmAvHDumvrYxrENmOm/3xynALI7bis79KYVuy66bQ8MvW2yDSJQ0DtvgxEACxjDupDnsgaxMmXPJgv21cpPGJKT2vLibejXNEcG78pagFxWyXnyUEVyUH5iNOcQLVPa+F6H63r0GD3Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKA7pD6Y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7772C4CEC3;
	Mon, 14 Oct 2024 17:18:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728926289;
	bh=1ziApFauYenoCS9MtS1B+tDzb5Mh3mm1sv1noAcTU6k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VKA7pD6YIgstOPFxjDhROkqhZWnVeMgAJlI+6imU3n58/Pf8OdDY+M8/RVlGnN/0S
	 GBw9tyJBa4EOkMthReck7N7DDx2hSJwVrmewZ9A2OwVw1I7T4kJigLyIkKz7V6CZlE
	 TFy4aq/E0//kuoMkq6ccVSFCg6Vqm2tTIQco3BIH5akm1ByJQI8i5vobR+9r/jsTOg
	 FV5g66HvbV8K6kE4VZ1mTj951cIxhXPwCFPO8jrSQvrvA6KkchM6G6JsKDCyMpk6BY
	 qHUKn3Ng+C/0cicrNKDC6yJ+YMgmFWiU4l4MlnWIaTbMWDgUA5rSn339wwhcj/LmTZ
	 pDYKkCWYKRbNA==
Date: Mon, 14 Oct 2024 12:18:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org,
	kw@linux.com, lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH v6 6/8] PCI: qcom: Fix the ops for SC8280X family SoC
Message-ID: <20241014171807.GA612411@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241011104142.1181773-7-quic_qianyu@quicinc.com>

[+cc Johan; if you tag a commit with Fixes:, please cc the author of
that commit!]

On Fri, Oct 11, 2024 at 03:41:40AM -0700, Qiang Yu wrote:
> On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
> they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
> introducing a new ops struct, namely ops_1_21_0, so that BDF2SID mapping
> won't be configured during init.

Can you make the subject line say something specific about what this
patch does?  "Fix the ops" really doesn't include any useful
information.

Based on the Fixes: below, this has to do with ASPM, so the subject
line (and the commit log) should probably say something about ASPM.

I don't see the connection between your mention of SMMUv3 and ASPM.
Are there two logical changes here that should be two separate
patches?

> Fixes: d1997c987814 ("PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p")
> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 88a98be930e3..468bd4242e61 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1367,6 +1367,16 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
>  	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
>  };
>  
> +/* Qcom IP rev.: 1.21.0 */
> +static const struct qcom_pcie_ops ops_1_21_0 = {
> +	.get_resources = qcom_pcie_get_resources_2_7_0,
> +	.init = qcom_pcie_init_2_7_0,
> +	.post_init = qcom_pcie_post_init_2_7_0,
> +	.host_post_init = qcom_pcie_host_post_init_2_7_0,
> +	.deinit = qcom_pcie_deinit_2_7_0,
> +	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
> +};
> +
>  static const struct qcom_pcie_cfg cfg_1_0_0 = {
>  	.ops = &ops_1_0_0,
>  };
> @@ -1405,7 +1415,7 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
>  };
>  
>  static const struct qcom_pcie_cfg cfg_sc8280xp = {
> -	.ops = &ops_1_9_0,
> +	.ops = &ops_1_21_0,
>  	.no_l0s = true,
>  };
>  
> -- 
> 2.34.1
> 

