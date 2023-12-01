Return-Path: <linux-pci+bounces-318-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FFC800352
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 06:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E669B2102D
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 05:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9957D8BFE;
	Fri,  1 Dec 2023 05:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hiur9O1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453A883B;
	Fri,  1 Dec 2023 05:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4416C433C7;
	Fri,  1 Dec 2023 05:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701409882;
	bh=+VnGs6Seo0e7jvF3XvNq79ffhry+pZ72obFBhYKEFHA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hiur9O1H+pALNUUYUIxgg42umh9EA0kMeqOXgI22vNjkNhwE0LRnzxIbwiIMtlkyM
	 DmK3zm2nq99QGQ6iDu9c5Gw5Oxdpx0Z9oMf/NFku18SKqTGAJWUt6fU3qRqImnnMCv
	 p0yYyLwWzRpbfHn/ZXPJnrHW6DoNKYITR/gXQ01m3fBb5Pj+yisdH5VPRKnNzC76Ff
	 i8T6oFZSr/jBnJwdz6GFjhCY9ONCD0Q85EuV3Cy7soLFCT0WwunhwLPcZO+q8NqPSX
	 pXCA0+x71uQalT3G/fvcO08AnJGDzSYTbDZFxfcCXvh8Hyl0vk1L1vSka9cySo29CZ
	 gv7FgqlCZYdOA==
Date: Fri, 1 Dec 2023 11:21:03 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: agross@kernel.org, andersson@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, robh@kernel.org,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_parass@quicinc.com, quic_schintav@quicinc.com,
	quic_shijjose@quicinc.com, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v8 1/5] dt-bindings: PCI: qcom-ep: Add support for
 SA8775P SoC
Message-ID: <20231201055103.GG4009@thinkpad>
References: <1699669982-7691-1-git-send-email-quic_msarkar@quicinc.com>
 <1699669982-7691-2-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1699669982-7691-2-git-send-email-quic_msarkar@quicinc.com>

On Sat, Nov 11, 2023 at 08:02:57AM +0530, Mrinmay Sarkar wrote:
> Add devicetree bindings support for SA8775P SoC. It has DMA register
> space and dma interrupt to support HDMA.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-ep.yaml      | 64 +++++++++++++++++++++-
>  1 file changed, 62 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> index a223ce0..46802f7 100644
> --- a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
> @@ -13,6 +13,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - qcom,sa8775p-pcie-ep
>            - qcom,sdx55-pcie-ep
>            - qcom,sm8450-pcie-ep
>        - items:
> @@ -20,6 +21,7 @@ properties:
>            - const: qcom,sdx55-pcie-ep
>  
>    reg:
> +    minItems: 6
>      items:
>        - description: Qualcomm-specific PARF configuration registers
>        - description: DesignWare PCIe registers
> @@ -27,8 +29,10 @@ properties:
>        - description: Address Translation Unit (ATU) registers
>        - description: Memory region used to map remote RC address space
>        - description: BAR memory region
> +      - description: DMA register space
>  
>    reg-names:
> +    minItems: 6
>      items:
>        - const: parf
>        - const: dbi
> @@ -36,13 +40,14 @@ properties:
>        - const: atu
>        - const: addr_space
>        - const: mmio
> +      - const: dma
>  
>    clocks:
> -    minItems: 7
> +    minItems: 5
>      maxItems: 8
>  
>    clock-names:
> -    minItems: 7
> +    minItems: 5
>      maxItems: 8
>  
>    qcom,perst-regs:
> @@ -57,14 +62,18 @@ properties:
>            - description: Perst separation enable offset
>  
>    interrupts:
> +    minItems: 2
>      items:
>        - description: PCIe Global interrupt
>        - description: PCIe Doorbell interrupt
> +      - description: DMA interrupt
>  
>    interrupt-names:
> +    minItems: 2
>      items:
>        - const: global
>        - const: doorbell
> +      - const: dma
>  
>    reset-gpios:
>      description: GPIO used as PERST# input signal
> @@ -125,6 +134,10 @@ allOf:
>                - qcom,sdx55-pcie-ep
>      then:
>        properties:
> +        reg:
> +          maxItems: 6
> +        reg-names:
> +          maxItems: 6
>          clocks:
>            items:
>              - description: PCIe Auxiliary clock
> @@ -143,6 +156,10 @@ allOf:
>              - const: slave_q2a
>              - const: sleep
>              - const: ref
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          maxItems: 2
>  
>    - if:
>        properties:
> @@ -152,6 +169,10 @@ allOf:
>                - qcom,sm8450-pcie-ep
>      then:
>        properties:
> +        reg:
> +          maxItems: 6
> +        reg-names:
> +          maxItems: 6
>          clocks:
>            items:
>              - description: PCIe Auxiliary clock
> @@ -172,6 +193,45 @@ allOf:
>              - const: ref
>              - const: ddrss_sf_tbu
>              - const: aggre_noc_axi
> +        interrupts:
> +          maxItems: 2
> +        interrupt-names:
> +          maxItems: 2
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,sa8775p-pcie-ep
> +    then:
> +      properties:
> +        reg:
> +          minItems: 7
> +          maxItems: 7
> +        reg-names:
> +          minItems: 7
> +          maxItems: 7
> +        clocks:
> +          items:
> +            - description: PCIe Auxiliary clock
> +            - description: PCIe CFG AHB clock
> +            - description: PCIe Master AXI clock
> +            - description: PCIe Slave AXI clock
> +            - description: PCIe Slave Q2A AXI clock
> +        clock-names:
> +          items:
> +            - const: aux
> +            - const: cfg
> +            - const: bus_master
> +            - const: bus_slave
> +            - const: slave_q2a
> +        interrupts:
> +          minItems: 3
> +          maxItems: 3
> +        interrupt-names:
> +          minItems: 3
> +          maxItems: 3
>  
>  unevaluatedProperties: false
>  
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

