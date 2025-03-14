Return-Path: <linux-pci+bounces-23719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26732A60B2F
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 09:22:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B656C19C44F0
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B41E5213;
	Fri, 14 Mar 2025 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s/6CT7dr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B931AA1FF;
	Fri, 14 Mar 2025 08:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741940459; cv=none; b=ZGFSp4Y3fpGNAdMn83iw6OdLbpLN1P3AiqrxusAYC60gOh+PCjxL1Sg8gBnWTIx2I27nj/rNWdVpuAU53rkSb6X0Ckpz+0cO8aD8MunK99sLqT6UrEY/dapDFeIgYz2Y9fH0OuLZxL+GABpiTQjr2Eebk18Fv/oyrd1dXXiOiso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741940459; c=relaxed/simple;
	bh=/9Cg9kqhR9YMfKzyRY8A1lAV2O/WdaBXMSuS45Wh5Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eri2Y1zdr68P1U7cxiCPbOb8n7QwV3Pb9EQGNV7nLJDiLU6AJXaAMGXc+uE6n8Inc/TuQI/hSBIht6i6ny5asSgly0bOIm6KloUIQxzkpklvlyw+65XhwIOwK/eKwIHyhKRkHP54mNTiZLPTJHJd30eghp8A2oxxqpjqvxd+FCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s/6CT7dr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE206C4CEE5;
	Fri, 14 Mar 2025 08:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741940458;
	bh=/9Cg9kqhR9YMfKzyRY8A1lAV2O/WdaBXMSuS45Wh5Hk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s/6CT7drnf2lyr/FUF5clP+re7piIqacdm0sZqSXxngUmPHKA9slQIPMJwnMP7v9f
	 nZbwvG+9hwb8fX1Jz9urzyit16vewMSGTKW4rgzYEqVzpb7HUtvVmC/ET/XyTwBVgx
	 dOEB/VkmXustLdncKq5je8upSBdt/S2eHshFlfB6hpnCd1KTq0j0yNV3rOaWQKuhHi
	 c61D9XkfItQ4hb7rXWehQQdgQudDfabAIEAEglm7RScuL4XKaUKiuKRktp7kX1QwvI
	 W19dV6oHGGRMzUfFWtwwqyMF0VMBsmOGiIyP6jB5RDMPTQng+jbn8C8gMUN6HiO+eP
	 50+ZYXwhkj0kQ==
Date: Fri, 14 Mar 2025 09:20:54 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: George Moussalem <george.moussalem@outlook.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-phy@lists.infradead.org, andersson@kernel.org, 
	bhelgaas@google.com, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	lumag@kernel.org, kishon@kernel.org, konradybcio@kernel.org, krzk+dt@kernel.org, 
	kw@linux.com, lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org, 
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com, robh@kernel.org, robimarko@gmail.com, 
	vkoul@kernel.org, quic_srichara@quicinc.com
Subject: Re: [PATCH v4 3/6] dt-bindings: PCI: qcom: Add IPQ5018 SoC
Message-ID: <20250314-greedy-tested-flamingo-59ae28@krzk-bin>
References: <DS7PR19MB8883F2538AA7D047E13C102B9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
 <20250314055644.32705-1-george.moussalem@outlook.com>
 <DS7PR19MB88834CAC414A0C2B4D71D57C9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DS7PR19MB88834CAC414A0C2B4D71D57C9DD22@DS7PR19MB8883.namprd19.prod.outlook.com>

On Fri, Mar 14, 2025 at 09:56:41AM +0400, George Moussalem wrote:
> From: Nitheesh Sekar <quic_nsekar@quicinc.com>
> 
> Add support for the PCIe controller on the Qualcomm
> IPQ5108 SoC to the bindings.
> 
> Signed-off-by: Nitheesh Sekar <quic_nsekar@quicinc.com>
> Signed-off-by: Sricharan Ramabadhran <quic_srichara@quicinc.com>
> Signed-off-by: George Moussalem <george.moussalem@outlook.com>
> ---
>  .../devicetree/bindings/pci/qcom,pcie.yaml    | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> index 8f628939209e..d8befaa558e2 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
> @@ -21,6 +21,7 @@ properties:
>            - qcom,pcie-apq8064
>            - qcom,pcie-apq8084
>            - qcom,pcie-ipq4019
> +          - qcom,pcie-ipq5018
>            - qcom,pcie-ipq6018
>            - qcom,pcie-ipq8064
>            - qcom,pcie-ipq8064-v2
> @@ -322,6 +323,63 @@ allOf:
>              - const: ahb # AHB reset
>              - const: phy_ahb # PHY AHB reset
>  
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-ipq5018
> +    then:
> +      properties:
> +        reg:
> +          minItems: 5
> +          maxItems: 5
> +        reg-names:
> +          items:
> +            - const: parf # Qualcomm specific registers
> +            - const: dbi # DesignWare PCIe registers
> +            - const: elbi # External local bus interface registers
> +            - const: atu # ATU address space
> +            - const: config # PCIe configuration space

Keep the same order as other IPQ, so dbi+elbi+atu+parf+config. Same for
everything else, so standard rule applies: devices are supposed to use
ordering from existing variants.

There is some huge mess with IPQ PCI bindings, including things on the
list. Apparently it became my job to oversee Qualcomm PCI work... well,
I do not have time for that, so rather I expect contributors to
cooperate in this matter.

Don't throw your patches over the wall.

If you need to rework the patch, take the ownership and rework it.





> +        clocks:
> +          minItems: 6
> +          maxItems: 6
> +        clock-names:
> +          items:
> +            - const: iface # PCIe to SysNOC BIU clock
> +            - const: axi_m # AXI Master clock
> +            - const: axi_s # AXI Slave clock
> +            - const: ahb # AHB clock
> +            - const: aux # Auxiliary clock
> +            - const: axi_bridge # AXI bridge clock
> +        resets:
> +          minItems: 8
> +          maxItems: 8
> +        reset-names:
> +          items:
> +            - const: pipe # PIPE reset
> +            - const: sleep # Sleep reset
> +            - const: sticky # Core sticky reset
> +            - const: axi_m # AXI master reset
> +            - const: axi_s # AXI slave reset
> +            - const: ahb # AHB reset
> +            - const: axi_m_sticky # AXI master sticky reset
> +            - const: axi_s_sticky # AXI slave sticky reset
> +        interrupts:
> +          minItems: 8
> +          maxItems: 8

8 items...

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
> +            - const: global

And here 9 items. You got comment on this. What's more, I doubt that DTS
was tsted.

Best regards,
Krzysztof


