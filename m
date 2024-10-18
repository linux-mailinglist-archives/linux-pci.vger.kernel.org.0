Return-Path: <linux-pci+bounces-14857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D508E9A406F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 15:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1008C1C21556
	for <lists+linux-pci@lfdr.de>; Fri, 18 Oct 2024 13:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87D91D79B3;
	Fri, 18 Oct 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgDX+vTq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32D41A84;
	Fri, 18 Oct 2024 13:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729259541; cv=none; b=gWKLc9wwU2XlfR2gXKQrSIZBEFTTK1eUyngNg/+Bx9VN0XbyT612mGg89dj+Hqt8JQG/pliqALUk5GxMGPlOCBzl/osISFzf1WMCe1AEeuYLlHk5uZGh+KV/hvOcLodXRmK8To/uwaNghJAfTzqfHA1u6QCB4JemYS9TohV1+1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729259541; c=relaxed/simple;
	bh=ZM4EDtbQIRuZYDRskOrejqQI6sGJWvB8V8K3e9Fncdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y0mzklMg4d3GofRy2TMtvnryvsQGLDlfsGf0zhZA3zXxzc3uA5Bgp5LKye8WKF9ujtFOrEKDWBEmo8O6ckKFKdIVaE4t/zT6xg93bWM3XswIiRY/jzM4+BXJtXJbexka+KinZEIFN64G2Cl0Q3gp1Qfnzm0oH6e8aH/0TxaoFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgDX+vTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0279C4CEC3;
	Fri, 18 Oct 2024 13:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729259540;
	bh=ZM4EDtbQIRuZYDRskOrejqQI6sGJWvB8V8K3e9Fncdc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgDX+vTqqkFga5WU8i8c3F/ctmp7ocpvgizN+L8I9kjsLnNX/2UTfv5w5Dm04vOqb
	 zDWSSzoLxJeFzLSqzvUkJCjnejljiJ0qy5nd//5aSYDGTPJX3cusTlLLvd3tWOopVg
	 eXQxOy+2Nc50uxE+b/s4Sqdfhckc+tlz1nDngmYCIol8zzvOXloWN9Mr89Sar2C2/6
	 tTrUc9XLJhyOkZdi2rAQNs/nyfO/gtj78WUybeO2iyDQyvldfyCUJXCZoWVHYkvfnw
	 DnjiNuWfDoDaQMd+I4NBMwQJtDLy+YQhsGEjjWH56Z2i7qT2rrPFoVvHX29xo0+HAJ
	 PwGiMaoo6ENhA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t1nOX-0000000072J-0XfD;
	Fri, 18 Oct 2024 15:51:57 +0200
Date: Fri, 18 Oct 2024 15:51:57 +0200
From: Johan Hovold <johan@kernel.org>
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
	johan+linaro@kernel.org
Subject: Re: [PATCH v7 5/7] PCI: qcom: Remove BDF2SID mapping config for
 SC8280X family SoC
Message-ID: <ZxJn_Xf4NO3eAfey@hovoldconsulting.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
 <20241017030412.265000-6-quic_qianyu@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017030412.265000-6-quic_qianyu@quicinc.com>

On Wed, Oct 16, 2024 at 08:04:10PM -0700, Qiang Yu wrote:
> On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
> they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
> introducing a new ops struct, namely ops_1_21_0 which is same as ops_1_9_0
> without config_sid() callback so that BDF2SID mapping won't be configured
> during init.

The sc8280xp PCIe devicetree nodes do not specify an 'iommu-map' so the
config_sid() callback is effectively a no-op. Please rephrase this so
that it becomes obvious that this is a clean up rather than fix.

> Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")

And drop the Fixes tag.

> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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

Is this the actual IP revision on sc8280xp (and not just the revision
used on x1e80100)?

Please also provide the Synopsis IP rev like the other configs do.

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

And try to keep these structs sorted by revision. At least put this one
after ops_1_9_0.

Johan

