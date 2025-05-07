Return-Path: <linux-pci+bounces-27324-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D82AAD52B
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 07:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EB1A1C21D78
	for <lists+linux-pci@lfdr.de>; Wed,  7 May 2025 05:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D6F51DF749;
	Wed,  7 May 2025 05:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="px+PTsjA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283E01DF269;
	Wed,  7 May 2025 05:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746595116; cv=none; b=HV9EV329KskzHuyrj+bQSr3YrCZuNkgUnzBQ9dfD+qEUfNnajyG9ZlkJEoL6K+zGcrIl3uVOIGp3be+2C+mu1ACTAOg5tECiAjaoDIrlDR/p/Oe7whwAg3FoFWYt1oOzxHKwKOaMIl0bXO7TGCZGFkem0d8m/1Clzb71SDEDoEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746595116; c=relaxed/simple;
	bh=z17b354Y/3F4nMLFkj3Aypodoceoi0WNTpzaRaaXSiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6SFr3RWJU/38exj/FR93o4eKihx7LwJz1v32xO4XCe8Qg+GZlQgrMdiKP8/a1nXp2ro7kAdJ8giwDvmVSXv7MiidA/EqyK/FTVfIXbsXIruJCRTyFqBPsSl/DOlNRA2E2Epqr1r9ftjd6uuT8baER1E3hWT0aDm1in0WZck+0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=px+PTsjA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AC25C4CEE7;
	Wed,  7 May 2025 05:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746595115;
	bh=z17b354Y/3F4nMLFkj3Aypodoceoi0WNTpzaRaaXSiU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=px+PTsjA+ze8bEa8qE6u5Sbm0pz9Z+soy5jTqa15f5DdUk++Kt7wUPQtNehn/zPug
	 aIoVDwDvPpKNY6VKpfZhAgr1I8Zx0t3ZTMFOkRillBtzXBdZ6Q2A2UQ52PxX4QQDEv
	 aDUDPlAk2AXQU1qGaEbQebbXnfOu6eyyHBT6OYqg8M0w6N1ezOqZcq3Vr77JgC1VhY
	 lPODFYI5Ro/e25Ht2GXfq9BGIepA8Ibruvjvg+FbUS+511OKBcNGmOYy6G6IXwn004
	 hzsd5U/GRMsHDF5qv8NPAYIZ9v1wXMURC4gAWw95W6IH1hLjR36eYl6bNHvMeEzxgU
	 QqCIDVEqgbWfw==
Date: Wed, 7 May 2025 07:18:33 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
Cc: vkoul@kernel.org, kishon@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, dmitry.baryshkov@linaro.org, 
	neil.armstrong@linaro.org, abel.vesa@linaro.org, manivannan.sadhasivam@linaro.org, 
	lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, andersson@kernel.org, 
	konradybcio@kernel.org, linux-phy@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_qianyu@quicinc.com, quic_krichai@quicinc.com, quic_vbadigan@quicinc.com
Subject: Re: [PATCH v4 5/5] PCI: qcom: Add support for QCS615 SoC
Message-ID: <20250507-competent-meek-prawn-72badf@kuoka>
References: <20250507031559.4085159-1-quic_ziyuzhan@quicinc.com>
 <20250507031559.4085159-6-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250507031559.4085159-6-quic_ziyuzhan@quicinc.com>

On Wed, May 07, 2025 at 11:15:59AM GMT, Ziyue Zhang wrote:
> Add the compatible and the driver data for QCS615 PCIe controller.
> There is only one controller instance found on this platform, which
> is capable of up to 8.0GT/s.
> The version of the controller is 1.38.0 which is compatible with 1.9.0
> config.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index dc98ae63362d..0ed934b0d1be 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1862,6 +1862,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
>  	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
> +	{ .compatible = "qcom,qcs615-pcie", .data = &cfg_1_9_0 },

Why? It's compatible with other entries, so why adding redundant entry
here?

Best regards,
Krzysztof


