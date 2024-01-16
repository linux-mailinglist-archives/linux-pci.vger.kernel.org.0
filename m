Return-Path: <linux-pci+bounces-2210-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F01F82F0D2
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 15:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 806D11C2356A
	for <lists+linux-pci@lfdr.de>; Tue, 16 Jan 2024 14:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584FF1BF30;
	Tue, 16 Jan 2024 14:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qen+nHYN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313171BDEC;
	Tue, 16 Jan 2024 14:48:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85FC5C433F1;
	Tue, 16 Jan 2024 14:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705416514;
	bh=QsOUfpw0sKNyK82N25qTzsWt9o3KXn2BtArWY/psjWo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qen+nHYN1z0V6Sos/d1MsGN9VEwHv/7Tid1I6otH+DimQ6gUgSaS5u4AHnvopHR3u
	 laYyH0scL8JIYY/NDbvQKDJEvWbpzwuF2DusabswVidysBabjPuYwhGXLKxtZYumdi
	 iWONeaPMwucp3vFiGHuCMqv4EPkvMcoWJWh0ZYRGpaxRz9Ay+11AIAmS+pDCRd6Eru
	 pQbYrv8a7+Ss0shfBpg4FVOP8bH7Q4Ru0eMus64iq0bZ/mLvCBr0RVLh9cZFWdLMkL
	 YLaurjShTGch/Iu0VNY7HFjtlCLH1IsaqYiEuG5z9UaewtZ5Bbaj9Nuz+DESEb1PMb
	 8DEt7CLB/WUVQ==
Date: Tue, 16 Jan 2024 08:48:32 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to
 dedicated schema
Message-ID: <20240116144832.GA3862516-robh@kernel.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
 <20240108-dt-bindings-pci-qcom-split-v1-2-d541f05f4de0@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-2-d541f05f4de0@linaro.org>

On Mon, Jan 08, 2024 at 03:19:15PM +0100, Krzysztof Kozlowski wrote:
> Move SM8450 PCIe devices from qcom,pcie.yaml binding to a dedicated file
> to make reviewing easier.
> 
> This creates equivalent schema file, except missing required compatible
> which is actually redundant.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 215 +++++++++++++++++++++
>  .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 -------
>  2 files changed, 215 insertions(+), 67 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> new file mode 100644
> index 000000000000..59ba809b6204
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
> @@ -0,0 +1,215 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8450.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM8450 PCI Express Root Complex
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> +
> +description:
> +  Qualcomm SM8450 SoC PCIe root complex controller is based on the Synopsys
> +  DesignWare PCIe IP.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,pcie-sm8450-pcie0
> +      - qcom,pcie-sm8450-pcie1
> +
> +  reg:
> +    minItems: 5
> +    maxItems: 6
> +
> +  reg-names:
> +    minItems: 5
> +    items:
> +      - const: parf # Qualcomm specific registers
> +      - const: dbi # DesignWare PCIe registers
> +      - const: elbi # External local bus interface registers
> +      - const: atu # ATU address space
> +      - const: config # PCIe configuration space
> +      - const: mhi # MHI registers
> +
> +  clocks:
> +    minItems: 11
> +    maxItems: 12
> +
> +  clock-names:
> +    minItems: 11
> +    maxItems: 12
> +
> +  resets:
> +    maxItems: 1
> +
> +  reset-names:
> +    items:
> +      - const: pci
> +
> +oneOf:
> +  - properties:
> +      interrupts:
> +        maxItems: 1
> +      interrupt-names:
> +        items:
> +          - const: msi
> +
> +  - properties:
> +      interrupts:
> +        minItems: 8
> +      interrupt-names:
> +        items:
> +          - const: msi0
> +          - const: msi1
> +          - const: msi2
> +          - const: msi3
> +          - const: msi4
> +          - const: msi5
> +          - const: msi6
> +          - const: msi7
> +
> +allOf:
> +  - $ref: qcom,pcie-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8450-pcie0
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 12
> +          maxItems: 12
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre0 # Aggre NoC PCIe0 AXI clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - qcom,pcie-sm8450-pcie1
> +    then:
> +      properties:
> +        clocks:
> +          minItems: 11
> +          maxItems: 11
> +        clock-names:
> +          items:
> +            - const: pipe # PIPE clock
> +            - const: pipe_mux # PIPE MUX
> +            - const: phy_pipe # PIPE output clock
> +            - const: ref # REFERENCE clock
> +            - const: aux # Auxiliary clock
> +            - const: cfg # Configuration clock
> +            - const: bus_master # Master AXI clock
> +            - const: bus_slave # Slave AXI clock
> +            - const: slave_q2a # Slave Q2A clock
> +            - const: ddrss_sf_tbu # PCIe SF TBU clock
> +            - const: aggre1 # Aggre NoC PCIe1 AXI clock

Almost the same list. Combine them and just make the 11th entry "enum: 
[aggre0, aggre1]".

Rob

