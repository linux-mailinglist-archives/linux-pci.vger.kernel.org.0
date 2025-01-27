Return-Path: <linux-pci+bounces-20421-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD5A1DC9B
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 20:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1B3E1885448
	for <lists+linux-pci@lfdr.de>; Mon, 27 Jan 2025 19:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0F6618B470;
	Mon, 27 Jan 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BJtK6kBZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735B517B50A;
	Mon, 27 Jan 2025 19:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738005548; cv=none; b=aRFLr4BYkSPz4TJb11IwIAMrrb+P37BAYUypdpcKpPnY1La9JIBYU6dOn41Eh+fM4MybHTxQVjLQ701gHdgfnbtYV4k4otMrpXqH1Zm7TAXZM4iVE4IeRBdr9Sc+2f/ohLZFvbkddzVODdWqPTwInpvoT/iRctyYZeO73H11iXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738005548; c=relaxed/simple;
	bh=SqI1KbVFdalLEwk0SH3vc66dMLl3ElqNrXqEzL5h/HM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N+MJ9auLEuVO+XYmDa2BVqimJVo+ZjUTmQQnNedlAzWQhFR1/mf4EUZFHac1f8zLLFbtwga84uhEm/PWY8Utv83Ftrnm/2UqcIgLSxCtqy+HHQQ5QBCZ7tBE/lJYYgSUBr5ggwpjFWMFXCXWlFaMkFfs2vWhEWEht2F/xGc3ap0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BJtK6kBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ACEC4CED2;
	Mon, 27 Jan 2025 19:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738005547;
	bh=SqI1KbVFdalLEwk0SH3vc66dMLl3ElqNrXqEzL5h/HM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BJtK6kBZpRiUGZfqgbJTc/udEd1XWuf9oMolAVnW/3MUyzr/VpFnPVC5/7Z+C2ZW5
	 H4xZFEKHvEL65IT298wqlKAk3od1QxNgzouDgBSEeezkJbzO8kmxz9+NxJTx6B4tW7
	 sMPLHejjRK8U2J4OwZ61VrWD9wWrOA2NfkU2kByBK8PffuDP1uFcznH4clbYjJEZx/
	 F6I1dI+eNv6P4r5ejps4HQ4IN2q8nzIcnt32TPj5Rhf8JOwkT2YqxGvad8PCYYksIz
	 xXMPOS3cEykoIugGXphW0ZcZhtLKSzPkYBsstJiJq7GcxhKdNyYUseaBsC3ASg/OlG
	 zRQSVTyOCzqiQ==
Date: Mon, 27 Jan 2025 13:19:06 -0600
From: Rob Herring <robh@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	vkoul@kernel.org, kishon@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, p.zabel@pengutronix.de,
	dmitry.baryshkov@linaro.org, quic_nsekar@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org
Subject: Re: [PATCH v8 5/7] dt-bindings: PCI: qcom: Document the IPQ5332 PCIe
 controller
Message-ID: <20250127191906.GA704182-robh@kernel.org>
References: <20250127072850.3777975-1-quic_varada@quicinc.com>
 <20250127072850.3777975-6-quic_varada@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250127072850.3777975-6-quic_varada@quicinc.com>

On Mon, Jan 27, 2025 at 12:58:48PM +0530, Varadarajan Narayanan wrote:
> Document the PCIe controller on IPQ5332 platform. IPQ5332 will
> use IPQ9574 as the fall back compatible.
> 
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v8: Use ipq9574 as fallback compatible for ipq5332 along with ipq5424
> 
> v7: Moved ipq9574 related changes to a separate patch
>     Add 'global' interrupt
> 
> v6: Commit message update only. Add info regarding the moving of
>     ipq9574 from 5 "reg" definition to 5 or 6 reg definition.
> 
> v5: Re-arrange 5332 and 9574 compatibles to handle fallback usage in dts
> 
> v4: * v3 reused ipq9574 bindings for ipq5332. Instead add one for ipq5332
>     * DTS uses ipq9574 compatible as fallback. Hence move ipq9574 to be able
>       to use the 'reg' section for both ipq5332 and ipq9574. Else, dtbs_check
>       and dt_binding_check flag errors.
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie.yaml | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 4b4927178abc..2ffa8480a665 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -33,6 +33,7 @@ properties:
>            - qcom,pcie-sdx55
>        - items:
>            - enum:
> +              - qcom,pcie-ipq5332
>                - qcom,pcie-ipq5424
>            - const: qcom,pcie-ipq9574
>        - items:
> @@ -49,11 +50,11 @@ properties:
>  
>    interrupts:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 9
>  
>    interrupt-names:
>      minItems: 1
> -    maxItems: 8
> +    maxItems: 9
>  
>    iommu-map:
>      minItems: 1
> @@ -209,6 +210,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-ipq5332
>                - qcom,pcie-ipq9574

As both of these compatibles will be present, you don't need to add 
ipq5332 here.

>                - qcom,pcie-sdx55
>      then:
> @@ -411,6 +413,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - qcom,pcie-ipq5332
>                - qcom,pcie-ipq9574

Same here.

>      then:
>        properties:
> @@ -443,6 +446,7 @@ allOf:
>          interrupts:
>            minItems: 8
>          interrupt-names:
> +          minItems: 8
>            items:
>              - const: msi0
>              - const: msi1
> @@ -452,6 +456,7 @@ allOf:
>              - const: msi5
>              - const: msi6
>              - const: msi7
> +            - const: global
>  
>    - if:
>        properties:
> @@ -559,6 +564,7 @@ allOf:
>                enum:
>                  - qcom,pcie-apq8064
>                  - qcom,pcie-ipq4019
> +                - qcom,pcie-ipq5332
>                  - qcom,pcie-ipq8064
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
> -- 
> 2.34.1
> 

