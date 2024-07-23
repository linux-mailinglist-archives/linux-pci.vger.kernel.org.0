Return-Path: <linux-pci+bounces-10630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E72FE939855
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 04:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2A2D282A0A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jul 2024 02:36:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7AD94595B;
	Tue, 23 Jul 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b1l7T1ea"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92A01E868;
	Tue, 23 Jul 2024 02:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721702156; cv=none; b=a8SDbQFkSp/9JoYdsuqLP5h2C4MCfJYx12TCMzp8r9RHUxcfUrVjXps7phV+27mH+swdJDDC54cN9EqilOc14vRXmMeJmbGIckmBh0GKFjPoBc1srck0tpic4e7903iL6nTZ6gGY2LpOuLsq4b+0/OZyn7miGC3iN3FpH8xhQ9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721702156; c=relaxed/simple;
	bh=16LCIdlyIRk2mL5fMS67SQiKz0m4J4uE1MW6Vbgvl/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2zk/KvjBPMyyE9HYharXDR5pDq+EbRABib91frSUVj4BygG65LjjOEqwJeg8qp/1PJQMRDHEUjoGQzHYrsePbkaGx7es1H03ve8ts/ZA/pIRGu1rJbLiHZJETBa6Gd0pPNKPDgI1RNDHy1oRUR3uZR5IlR6ToI7ouQYgpT2Jf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b1l7T1ea; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CFD3C116B1;
	Tue, 23 Jul 2024 02:35:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721702156;
	bh=16LCIdlyIRk2mL5fMS67SQiKz0m4J4uE1MW6Vbgvl/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b1l7T1ea46MAvhrJ+X0HQGbKdBz1V94vZLMNsIJgimE98xvBLTMDyMDlw9xEcR0EX
	 CoQQpRoEXzsKu5RwKs5Li8u37QALwPqjl+sdLh9LsTrfVw+b0QKOXGaUj7+UxLlgcA
	 9lZyg+vUvgH/Bn+NDlyCIe0JauExJ+DLA//wU54Lj/TY/fqllI8xuJ0zyu0wzovMj7
	 zbDH8qIBGveqceNP+DDZGKWGx7bSM+GhyBVChSNi2aFBQqEY7pLr2DQiPtZbo9orWz
	 r4njHIqFFsOhaQ2GhJAuMgvEp4q7XfbC1NtpQMj1q61pu25J31zObe81ASDcnTk3o6
	 Fy0m9ch0mtEQw==
Date: Mon, 22 Jul 2024 20:35:53 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 11/13] dt-bindings: PCI: qcom,pcie-sm8450: Add
 'global' interrupt
Message-ID: <20240723023553.GA181687-robh@kernel.org>
References: <20240717-pci-qcom-hotplug-v2-0-71d304b817f8@linaro.org>
 <20240717-pci-qcom-hotplug-v2-11-71d304b817f8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240717-pci-qcom-hotplug-v2-11-71d304b817f8@linaro.org>

On Wed, Jul 17, 2024 at 10:33:16PM +0530, Manivannan Sadhasivam wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPU. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, document it in the binding along with the existing MSI interrupts.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> index d8c0afaa4b19..0d68ce073383 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> @@ -55,11 +55,12 @@ properties:
>        - const: aggre1 # Aggre NoC PCIe1 AXI clock
>  
>    interrupts:
> -    minItems: 8
> -    maxItems: 8
> +    minItems: 9

ABI break

> +    maxItems: 9
>  
>    interrupt-names:
>      items:
> +      - const: global

ABI break. You can't add a new entry at the beginning of the list.

>        - const: msi0
>        - const: msi1
>        - const: msi2
> @@ -142,7 +143,8 @@ examples:
>                            "aggre0",
>                            "aggre1";
>  
> -            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
> +            interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
> +                         <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
> @@ -150,7 +152,7 @@ examples:
>                           <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
>                           <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
> -            interrupt-names = "msi0", "msi1", "msi2", "msi3",
> +            interrupt-names = "global", "msi0", "msi1", "msi2", "msi3",
>                                "msi4", "msi5", "msi6", "msi7";
>              #interrupt-cells = <1>;
>              interrupt-map-mask = <0 0 0 0x7>;
> 
> -- 
> 2.25.1
> 

