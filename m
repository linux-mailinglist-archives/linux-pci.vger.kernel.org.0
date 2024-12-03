Return-Path: <linux-pci+bounces-17577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8989E1FB7
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 15:41:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF3E42837DB
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 14:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C941F7074;
	Tue,  3 Dec 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DNqdqGBl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB911F471B;
	Tue,  3 Dec 2024 14:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236863; cv=none; b=sOG5N2cD4Ee8ANpiOWM85PWMwt1i8yr7Xe4xQ7WQU/6KZzArqrwVPsh9YWaA4YKtUYdiL9dwfMkWmP0TPEUcfam6NK5l2MJf+b10qC7T6e8/5jJh73DDd1zpHgHWp6dt9z1aqh/5bdyNqm2+wEeuycJiQfNHl8BC5btI/0ckrFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236863; c=relaxed/simple;
	bh=ctU4KmvHpTQaD8qF7NkLw7BW76DUfHNWlBh/UL+aC+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kONV2sYG+GSTh5k1/GNeCPuQQH6/EUN3kSwihx4HeAhV9fLrtF2Dqx/SJ0SoiRKXNp+v4SYgTb9e3D6luI5/NQ/VXemm3GrSncpdissYyuAXshEl8aGEeYxX1DH+rbMesoO9JOTnftUkCmfIBjxr/ypl4HPkuNoiDf4wMTv5LiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DNqdqGBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6619C4CED6;
	Tue,  3 Dec 2024 14:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733236863;
	bh=ctU4KmvHpTQaD8qF7NkLw7BW76DUfHNWlBh/UL+aC+I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DNqdqGBlGmVkId3Vx2EZCIgv63wTOjQdDccfJAO1RddjRXdIWavlcVYb+WWWC9vFd
	 9ilwiPVZWLmrA8wJf7mKe6nSJ/MfWc8NclJGXdaNLkk8L0cAMdeqWKT7EwUJLuWCSg
	 W488elV9+ay6MFoUJEU51ctZANCJqCjBcQfT0XucpNKUdMM37HEicfV2P639zpmCgv
	 axXzU2GCT0omZXrLvPcw06/I4/stMqp9cVMf97gsTSyev/6CUzkaEsgkL4h5VYmZj3
	 50JE5WEpxy9Q4B3IDu/OnqZj7CTTCzwrtXzKW77ys/1Y2apKyvW97NDF3nFwYrU1KD
	 3oIzonk8Ta1XQ==
Date: Tue, 3 Dec 2024 08:41:01 -0600
From: Rob Herring <robh@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	manivannan.sadhasivam@linaro.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	jingoohan1@gmail.com, michal.simek@amd.com,
	bharat.kumar.gogada@amd.com
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: amd-mdb: Add AMD Versal2 MDB
 PCIe Root Port Bridge
Message-ID: <20241203144101.GA1756254-robh@kernel.org>
References: <20241203123608.2944662-1-thippeswamy.havalige@amd.com>
 <20241203123608.2944662-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203123608.2944662-2-thippeswamy.havalige@amd.com>

On Tue, Dec 03, 2024 at 06:06:07PM +0530, Thippeswamy Havalige wrote:
> Add AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root Port Bridge.
> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
> Changes in v2:
> -------------
> - Modify patch subject.
> - Add pcie host bridge reference.
> - Modify filename as per compatible string.
> - Remove standard PCI properties.
> - Modify interrupt controller description.
> - Indentation
> ---
>  .../bindings/pci/amd,versal2-mdb-host.yaml    | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> new file mode 100644
> index 000000000000..75795bab8254
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amd,versal2-mdb-host.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD Versal2 MDB(Multimedia DMA Bridge) Host Controller
> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: amd,versal2-mdb-host
> +
> +  reg:
> +    items:
> +      - description: MDB PCIe controller 0 SLCR

SLCR is not defined anywhere.

> +      - description: configuration region
> +      - description: data bus interface
> +      - description: address translation unit register
> +
> +  reg-names:
> +    items:
> +      - const: mdb_pcie_slcr
> +      - const: config
> +      - const: dbi
> +      - const: atu

DWC based it seems. You need to reference the DWC schema.

> +
> +  ranges:
> +    maxItems: 2
> +
> +  msi-map:
> +    maxItems: 1
> +
> +  bus-range:
> +    maxItems: 1

Already defined in the common schema. Plus you obviously didn't test 
anything with this because bus-range must be exactly 2 entries. 1 is not 
valid.

> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2

Both of these are also already defined in the pci-host-bridge.yaml.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +  interrupt-map-mask:
> +    items:
> +      - const: 0
> +      - const: 0
> +      - const: 0
> +      - const: 7
> +
> +  interrupt-map:
> +    maxItems: 4
> +
> +  "#interrupt-cells":
> +    const: 1
> +
> +  interrupt-controller:
> +    description: identifies the node as an interrupt controller
> +    type: object
> +    properties:
> +      interrupt-controller: true
> +
> +      "#address-cells":
> +        const: 0
> +
> +      "#interrupt-cells":
> +        const: 1
> +
> +    required:
> +      - interrupt-controller
> +      - "#address-cells"
> +      - "#interrupt-cells"
> +
> +    additionalProperties: false

Move this before 'properties'.

> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - msi-map
> +  - ranges

Already required by common schema.

> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false
> +
> +examples:
> +

Drop blank line.

> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pci@ed931000 {

pcie@...

> +            compatible = "amd,versal2-mdb-host";
> +            reg = <0x0 0xed931000 0x0 0x2000>,
> +                  <0x1000 0x100000 0x0 0xff00000>,
> +                  <0x1000 0x0 0x0 0x100000>,
> +                  <0x0 0xed860000 0x0 0x2000>;
> +            reg-names = "mdb_pcie_slcr", "config", "dbi", "atu";
> +            ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x10000000>,
> +                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x1000000>;
> +            interrupts = <GIC_SPI 198 IRQ_TYPE_LEVEL_HIGH>;
> +            interrupt-parent = <&gic>;
> +            interrupt-map-mask = <0 0 0 7>;
> +            interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> +                            <0 0 0 2 &pcie_intc_0 1>,
> +                            <0 0 0 3 &pcie_intc_0 2>,
> +                            <0 0 0 4 &pcie_intc_0 3>;
> +            msi-map = <0x0 &gic_its 0x00 0x10000>;
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            #interrupt-cells = <1>;
> +            device_type = "pci";
> +            pcie_intc_0: interrupt-controller {
> +                #address-cells = <0>;
> +                #interrupt-cells = <1>;
> +                interrupt-controller;
> +           };
> +        };
> +    };
> -- 
> 2.34.1
> 

