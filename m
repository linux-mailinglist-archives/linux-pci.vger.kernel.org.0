Return-Path: <linux-pci+bounces-10427-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0755493393C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 10:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCF9D282897
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jul 2024 08:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3EB538DD1;
	Wed, 17 Jul 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ci+gn/eb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8841138396;
	Wed, 17 Jul 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721205611; cv=none; b=h0+DseTGEln3YFwCaLj27jVl90XgE1hd4QQiSW1yW+M7+cUGY6BWAIVKCXkk0NwQBeB5NQgda16IZSrxYpihT2iVskRE8r0cXWyBp9KHfObmEeg195ocijn2qOkY8VehAnVu3Z74TtiNLUKIl/R0JcbAEP7+jkYQ6ftY03wVMGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721205611; c=relaxed/simple;
	bh=8xefbxae26ImZXEFu8mWeuTLfw1+nQRCp2j3fD277D4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NyCDyrVz1cLJaq/ijPfgZuoGnrgfoBBSpMr/0VPWw+w0Lq9iTaOKmBXTssgmAjTy0ngOW36inGxgOCAh1IBzh6wuPj253Ww6vTiQdhW3sjzrYB4NW0pM3EgRJeYo2EIJVYQszFErvJdrYQ/cNR9kNmzzTJWlmLM/UxuTCwhiJZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ci+gn/eb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02103C32782;
	Wed, 17 Jul 2024 08:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721205611;
	bh=8xefbxae26ImZXEFu8mWeuTLfw1+nQRCp2j3fD277D4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ci+gn/ebvzbBXsdHGmIliOqvlXvt3Gsa4m+7NDuIlTvbeR5XCkPryS77LKm9EG1tX
	 qBF4rAYV+x6aNaoYph7R/AzrOpYPlC0mx2GiDfuKh7OSwDujv+uGsbP3FwKezQoxcM
	 8vjnvyptb8L6ridPVSfNesI1iKn9ki9jGcz4HqoXLUPXIjoOpmruYr83XLJarDnQKJ
	 29higQw9BPUlvec8fB6Wp49ojrZerrhJGsnbb4JfhJCDn5+ZYeEhXE1/q1mKQpTwrg
	 yYeFlP33pwbKFRR+l7Q2ELeZ5G082zrvW8oegq1HTnYIT17WK6xrLl9lMcTVD/YImu
	 rdQPniiEGIMOg==
Date: Wed, 17 Jul 2024 14:10:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sricharan R <quic_srichara@quicinc.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devi priya <quic_devipriy@quicinc.com>
Subject: Re: [PATCH V6 1/4] dt-bindings: PCI: qcom: Document the IPQ9574 PCIe
 controller.
Message-ID: <20240717084003.GE2574@thinkpad>
References: <20240716092347.2177153-1-quic_srichara@quicinc.com>
 <20240716092347.2177153-2-quic_srichara@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240716092347.2177153-2-quic_srichara@quicinc.com>

On Tue, Jul 16, 2024 at 02:53:44PM +0530, Sricharan R wrote:
> From: devi priya <quic_devipriy@quicinc.com>
> 
> Document the PCIe controller on IPQ9574 platform.
> 
> Signed-off-by: devi priya <quic_devipriy@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  [V6] Fixed the clocks order and dropped unnessecary names as per
>       Krzysztof's comments.
>       Changed the interrupt numbers/msi to '8'.
> 
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 50 +++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index f867746b1ae5..2d61fb9f206d 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,pcie-ipq8064-v2
>            - qcom,pcie-ipq8074
>            - qcom,pcie-ipq8074-gen3
> +          - qcom,pcie-ipq9574
>            - qcom,pcie-msm8996
>            - qcom,pcie-qcs404
>            - qcom,pcie-sdm845
> @@ -161,6 +162,7 @@ allOf:
>              enum:
>                - qcom,pcie-ipq6018
>                - qcom,pcie-ipq8074-gen3
> +              - qcom,pcie-ipq9574
>      then:
>        properties:
>          reg:
> @@ -397,6 +399,53 @@ allOf:
>              - const: axi_m_sticky # AXI Master Sticky reset
>              - const: axi_s_sticky # AXI Slave Sticky reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq9574
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: axi_bridge
> +            - const: rchng
> +            - const: ahb
> +            - const: aux
> +
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sticky # Core Sticky reset
> +            - const: axi_s_sticky # AXI Slave Sticky reset
> +            - const: axi_s # AXI Slave reset
> +            - const: axi_m_sticky # AXI Master Sticky reset
> +            - const: axi_m # AXI Master reset
> +            - const: aux # AUX Reset
> +            - const: ahb # AHB Reset
> +
> +        interrupts:
> +          minItems: 8
> +        interrupt-names:
> +          items:
> +            - const: msi0
> +            - const: msi1
> +            - const: msi2
> +            - const: msi3
> +            - const: msi4
> +            - const: msi5
> +            - const: msi6
> +            - const: msi7
> +
>    - if:
>        properties:
>          compatible:
> @@ -507,6 +556,7 @@ allOf:
>                  - qcom,pcie-ipq8064v2
>                  - qcom,pcie-ipq8074
>                  - qcom,pcie-ipq8074-gen3
> +                - qcom,pcie-ipq9574
>                  - qcom,pcie-qcs404
>      then:
>        required:
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

