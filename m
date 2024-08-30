Return-Path: <linux-pci+bounces-12501-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47506965A30
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 10:23:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C361F2409A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 08:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBE6516BE2B;
	Fri, 30 Aug 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agb3mJpH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87FC116726E;
	Fri, 30 Aug 2024 08:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725006227; cv=none; b=u5OQi1v7Bh4pfMoentWPokTfln8kIHEWlhn8wGY3oATPFBt0MZGO/czxktEcRjxE75TYRZ9enLoU7gQkqgaaY0x/AiJeaXkBoCTSrA482G2n+9AT5W6HD70vadqrNWT2A4Vz2mdaHc3d0W8/DWLYW/YVISCqjXRLlu3dDRtIRrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725006227; c=relaxed/simple;
	bh=3Y9mMq3/KBsce91Bb2CDzhvN2+J+/hQB5/+wKDGtYzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oy7CtjTkB00BF6utjjayv5fBUegCPjKyZHXQpOfAJVVn2jYrazWFxP44C9Zo5E4+XpAceSKy4v+b4bX/Hoo73jvNGHjxz2HT1eS3UCB+u77v86zhMTBJNHPzoc+oyt8MFKkuUm6R+Hc2jbm1qiO7a6i5Oz3zwwxUwEwK6bklzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agb3mJpH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94914C4CEC2;
	Fri, 30 Aug 2024 08:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725006227;
	bh=3Y9mMq3/KBsce91Bb2CDzhvN2+J+/hQB5/+wKDGtYzw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=agb3mJpHsKBiXBBdsw3MLK1eOD5wm1M0YQCjOdirZwfj4JOS6W9nuCLKAe9oRZToo
	 UFpENv9l2Ej+SlyWHrVTPicbbf+iKligkNhJ6l0m2Z1hR/5tA+RAy+MvrmhY0ST0VP
	 huMgtsNGHkuOS2SUKU28kN1vJ6l+rrJ1gS8yoR4bFmTyPN0xcKNcpF/6sxf7N9ev92
	 0se7wu82ZBQKXhejuWr233rXiJTOmQgIKV7sSboPcQ44cOph+a6TPdHzrytLThLAo0
	 N2eAYW376rP2/zWP0t0UKDpAj3FdPoRUSp8dowoUzS/LM8GYmCnabaPh6CIf8Pvtns
	 qqbXacVbJq0+A==
Date: Fri, 30 Aug 2024 10:23:44 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org, robimarko@gmail.com
Subject: Re: [PATCH V3 1/6] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <e2qgpvfccpo2sd4mbrynxruvt5attqmtd5oik26of7tv7u4lq6@kvb63sglwa5b>
References: <20240830081132.4016860-1-quic_srichara@quicinc.com>
 <20240830081132.4016860-2-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830081132.4016860-2-quic_srichara@quicinc.com>

On Fri, Aug 30, 2024 at 01:41:27PM +0530, Sricharan R wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5018.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> ---
>  [v3] Added reviewed-by tags
> 
>  .../phy/qcom,ipq5018-uniphy-pcie.yaml         | 70 +++++++++++++++++++
>  1 file changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
> new file mode 100644
> index 000000000000..c04dd179eb8b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5018-uniphy-pcie.yaml
> @@ -0,0 +1,70 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,ipq5018-uniphy-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm UNIPHY PCIe 28LP PHY controller for genx1, genx2
> +
> +maintainers:
> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> +  - Sricharan Ramabadhran <quic_srichara@quicinc.com>
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5018-uniphy-pcie-gen2x1
> +      - qcom,ipq5018-uniphy-pcie-gen2x2

... and now I wonder why there are two compatibles. Isn't the phy the
same? We talk about the same hardware?

Best regards,
Krzysztof


