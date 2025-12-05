Return-Path: <linux-pci+bounces-42687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CA5BCA6DE0
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 10:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABA8F313DBF5
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 09:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B766730FF28;
	Fri,  5 Dec 2025 09:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uG0ULiwA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC94302CCD;
	Fri,  5 Dec 2025 09:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764925808; cv=none; b=I9mzBq0JjaTm2uMB3Vrh/RnC9Q1gX2AUnMKvxsWcL9tgliF7V23DVENA+kHoxDUSNMRv03uNZIu1C7YoqMpjEOUTiNi5OyJ+elzN6uuilRhOR0hvTJg03dGt9fkeSkAHKhp06S6+ksM4SMH6hq6DSrLy5tF9LgpWGv0Wst6AP4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764925808; c=relaxed/simple;
	bh=Bd62zbHU2BePIz0Xlc1pmmWFKrZ7qs2n6x+uksr8tnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bac7zQztbaE2xyQLuyV6kWdUv6slx+RvkKk403iRuiwMDDwFCvSRmZFMv5JhAH92FH7E6POXSKOLEo74Sc0nHBX57QfWdxmQcrYzjbg6ESeIGG9RDmY48T81b4p9wP3GpUAbexuGc9izLHTkYhkD0YSxsJiuXwIJu5PYqrVOt6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uG0ULiwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25920C4CEF1;
	Fri,  5 Dec 2025 09:10:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764925805;
	bh=Bd62zbHU2BePIz0Xlc1pmmWFKrZ7qs2n6x+uksr8tnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uG0ULiwAIiTZ/5qcf5gv9N5g+TOi1hSWKarFbirpGYMwHqIdObod7U1rHcsp0E59N
	 T8W7mYKgZZXF6EU+YG8qd11G2pJggGSNbGqECuqjrkdVq0peYDTydBL3fnu7cjulQ9
	 gCC9way2rX2c2FcVomDKneLZ6PgcvOEf92H700hmPS4ny5JbH1k6WRDBbd3Jw3gUUc
	 R7InTnQnWzPGz7PEZbgn0lXAvJDfTeIq2chIukhMQ9heS/1HG4i5sa7XfcBMC3GBmc
	 EtVLQNXDOcybtP1Yvz7BmHOj5Bu286CpUEiOQywgS8GzYgMomIlyb41mKmFIRsq6q5
	 Y50VlBGz9NNtw==
Date: Fri, 5 Dec 2025 10:10:03 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@oss.qualcomm.com, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	quic_vbadigan@quicinc.com, quic_shazhuss@quicinc.com, konrad.dybcio@oss.qualcomm.com, 
	Rama Krishna <quic_ramkri@quicinc.com>, Ayiluri Naga Rashmi <quic_nayiluri@quicinc.com>, 
	Nitesh Gupta <quic_nitegupt@quicinc.com>
Subject: Re: [PATCH 1/2] dt-bindings: PCI: qcom,pcie-ep-sa8255p: Document
 firmware managed PCIe endpoint
Message-ID: <20251205-majestic-guillemot-of-criticism-80c18b@quoll>
References: <20251203-firmware_managed_ep-v1-0-295977600fa5@oss.qualcomm.com>
 <20251203-firmware_managed_ep-v1-1-295977600fa5@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251203-firmware_managed_ep-v1-1-295977600fa5@oss.qualcomm.com>

On Wed, Dec 03, 2025 at 06:56:47PM +0530, Mrinmay Sarkar wrote:
> Document the required configuration to enable the PCIe Endpoint controller
> on SA8255p which is managed by firmware using power-domain based handling.
> 
> Signed-off-by: Mrinmay Sarkar <mrinmay.sarkar@oss.qualcomm.com>
> ---
>  .../bindings/pci/qcom,pcie-ep-sa8255p.yaml         | 114 +++++++++++++++++++++

Filename must match the compatible. In your case, the filename is
correct but you wanted old format for the compatible (so compatible
should be rewritten to match filename).

>  1 file changed, 114 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
> new file mode 100644
> index 0000000000000000000000000000000000000000..970f65d46c8e2fa4c44665cb7a346dea1dc9e06a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep-sa8255p.yaml
> @@ -0,0 +1,114 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/qcom,pcie-ep-sa8255p.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm firmware managed PCIe Endpoint Controller
> +
> +description:
> +  Qualcomm SA8255p SoC PCIe endpoint controller is based on the Synopsys
> +  DesignWare PCIe IP which is managed by firmware.
> +
> +maintainers:
> +  - Manivannan Sadhasivam <mani@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: qcom,sa8255p-pcie-ep
> +
> +  reg:
> +    minItems: 6

Why is this flexible?

> +    items:
> +      - description: Qualcomm-specific PARF configuration registers
> +      - description: DesignWare PCIe registers
> +      - description: External local bus interface registers
> +      - description: Address Translation Unit (ATU) registers
> +      - description: Memory region used to map remote RC address space
> +      - description: BAR memory region
> +      - description: DMA register space
> +
> +  reg-names:
> +    minItems: 6
> +    items:
> +      - const: parf
> +      - const: dbi
> +      - const: elbi
> +      - const: atu
> +      - const: addr_space
> +      - const: mmio
> +      - const: dma
> +
> +  interrupts:
> +    minItems: 2

And this/

> +    items:
> +      - description: PCIe Global interrupt
> +      - description: PCIe Doorbell interrupt
> +      - description: DMA interrupt
> +
> +  interrupt-names:
> +    minItems: 2
> +    items:
> +      - const: global
> +      - const: doorbell
> +      - const: dma
> +
> +  iommus:
> +    maxItems: 1
> +
> +  reset-gpios:
> +    description: GPIO used as PERST# input signal
> +    maxItems: 1
> +
> +  wake-gpios:
> +    description: GPIO used as WAKE# output signal
> +    maxItems: 1
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  dma-coherent: true
> +
> +  num-lanes:
> +    default: 2

Isn't this deducible from the compatible? Do you have have different
PCIe controllers with different lanes?


> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
> +  - reset-gpios
> +  - power-domains
> +
> +additionalProperties: false

Best regards,
Krzysztof


