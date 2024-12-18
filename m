Return-Path: <linux-pci+bounces-18684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D2269F62FD
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 11:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AF0216A511
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E321ACEDD;
	Wed, 18 Dec 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YgycJBKN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465419CC34;
	Wed, 18 Dec 2024 10:28:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734517702; cv=none; b=XUGTdzKdawyOEphORnTN0fxVwf5ZKG5zdI8kzLN4wTZXrFxLu800pcB3u8DBMW11wifwN7vgE8Y2AX+HuYr04J3bcVasrj2zcD0Q+0NZxnsA5d6ptcuYZ5AZk/nsvcuyYhBukhA4fw9k+pTxVo/ZbtzIK754kjwQKQGZnBxPxWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734517702; c=relaxed/simple;
	bh=ZyNEU8QU2txiWxFgL+CfpQh+6WZpOy7/8BMkAj3HqDY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FwciTNzncLvr1+S+eavjCo0avsgr8jqbz5fudp9A4n3+/gU2oDsgwLhepXKPYRwWnGQx8t4DO1SzJvAiKgVWoqpN3fHpxES//jpnr2g+06ktsvGwN1zufWWvKvcpfm1BbLNG8sA/JGTxk523hHUtLq93P4pOQV/pMvOqIvnqT8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YgycJBKN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45A7EC4CEDE;
	Wed, 18 Dec 2024 10:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734517700;
	bh=ZyNEU8QU2txiWxFgL+CfpQh+6WZpOy7/8BMkAj3HqDY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YgycJBKNg4T2v+Y4Htiiso4uOPnn6obIjcqs4DxZAqjeuxZS6JdfZcyOE0NN7KKyj
	 Ni3+dJ/MdOe7KK/t4WRmATJ6RGShXbclE8erM2+AmqwrdSrAM/S2VKJIQ1bf/yblwd
	 J+HdEEVq5gUIncG6CFklUGzHVHfthQ4vUiMekuNhmuHdRWQOFeTCOKCpO7ksO2kxDv
	 RtSU4xsUId6tCiTdmrOxdEXqf2PFf3SAvjnbt2XyoEFJZs1J2F9vT6W8Nk58ZfL/4f
	 eTEiWs1h7AY94CeLmCwvmCJSX/AK/4d3Exn/fON3PLNKzNcg3M45LJ+QZDgYUhGL1g
	 lzSs4DAQh3DOQ==
Date: Wed, 18 Dec 2024 11:28:18 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, dmitry.baryshkov@linaro.org, 
	quic_srichara@quicinc.com, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org
Subject: Re: [PATCH v3 1/5] dt-bindings: phy: qcom,uniphy-pcie: Document PCIe
 uniphy
Message-ID: <nhzbr4knneo5k3zxvjy2ozx6ciqg2hivwyr2qxdld2x63vlzeb@mjrlqeqiykzp>
References: <20241217100359.4017214-1-quic_varada@quicinc.com>
 <20241217100359.4017214-2-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241217100359.4017214-2-quic_varada@quicinc.com>

On Tue, Dec 17, 2024 at 03:33:55PM +0530, Varadarajan Narayanan wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Document the Qualcomm UNIPHY PCIe 28LP present in IPQ5332.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v3: Fix compatible string to be similar to other phys and rename file accordingly
>     Fix clocks minItems -> maxItems

I think there was just one clock, so you increased it to two.

>     Change one of the maintainer from Sricharan to Varadarajan
> 
> v2: Rename the file to match the compatible
>     Drop 'driver' from title
>     Dropped 'clock-names'
>     Fixed 'reset-names'
> --
>  .../phy/qcom,ipq5332-uniphy-pcie-phy.yaml     | 82 +++++++++++++++++++
>  1 file changed, 82 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
> 
> diff --git a/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
> new file mode 100644
> index 000000000000..0634d4fb85d1
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/phy/qcom,ipq5332-uniphy-pcie-phy.yaml
> @@ -0,0 +1,82 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/phy/qcom,ipq5332-uniphy-pcie-phy.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm UNIPHY PCIe 28LP PHY
> +
> +maintainers:
> +  - Nitheesh Sekar <quic_nsekar@quicinc.com>
> +  - Varadarajan Narayanan <quic_varada@quicinc.com>
> +
> +description:
> +  PCIe and USB combo PHY found in Qualcomm IPQ5332 SoC
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,ipq5332-uniphy-gen3x1-pcie-phy
> +      - qcom,ipq5332-uniphy-gen3x2-pcie-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 2

I should have been more specific last time, but I assumed you will take
other bindings as example.  well, so now proper review: you need to list
tiems.

> +
> +  resets:
> +    minItems: 2
> +    maxItems: 3

No answer to my previous question. Question stands.

> +
> +  reset-names:
> +    minItems: 2
> +    items:
> +      - const: phy
> +      - const: phy_ahb
> +      - const: phy_cfg
> +
> +  "#phy-cells":
> +    const: 0
> +
> +  "#clock-cells":
> +    const: 0
> +
> +  clock-output-names:
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - reg
> +  - resets
> +  - reset-names
> +  - clocks

Keep the same order as in properties block.

Best regards,
Krzysztof


