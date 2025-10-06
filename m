Return-Path: <linux-pci+bounces-37626-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F4113BBF054
	for <lists+linux-pci@lfdr.de>; Mon, 06 Oct 2025 20:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B66E94ED6CE
	for <lists+linux-pci@lfdr.de>; Mon,  6 Oct 2025 18:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB992D7DF1;
	Mon,  6 Oct 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dQr/WvAh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47B1B042E;
	Mon,  6 Oct 2025 18:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759776734; cv=none; b=OIdA9/XLxHfp1WHR1jVcp0A4Vsm6Nm3vBy8bTBTurco6Tyv2KnD6Py5//yAu5kGmQDRO6ZBescsXQH5Bkm1HkUKSrPkfjfEk2qPSU3eqzVCNqr4q48XIOZOxgNlnepGVfO7MVNGrb0Vm44b0gd6yZW/fuEgrzbyoubH8xh1nOOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759776734; c=relaxed/simple;
	bh=ZWvIVGXtiM/1nsG2Z8koPrcNspjPo3e9IYnBwDXQV30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V8jhfpcnuvKQFhzaEX/hNg+JzRU0YULemUfxHMlW+asXgK8lJ+olugzN1bID13K4Hc3zqcjlRr8CXM4tL6pSDLH3ESfOaT8Lgujprm8emHxVSMQcNAu0NgUsh+YhOAJ3BfivgTSJ8uko1Ps5ZpIlQiONq4UDv7mDCDZ+6+TZJ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dQr/WvAh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7F48C4CEF5;
	Mon,  6 Oct 2025 18:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759776734;
	bh=ZWvIVGXtiM/1nsG2Z8koPrcNspjPo3e9IYnBwDXQV30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dQr/WvAh+y+d0RJDvIqzaEvsC4+YqkpNRMZegn/9RhfuEcXIP6vbZ2lCb3vhMACbv
	 SbnNR3Zi8ly3zOl0WSV0C2aIWTKEImCE2awKQfcOc23+bRjW/F5KrZpkRD1vErunSF
	 okbn6i9YHOzA+dMm3dQVE8km3I9EpbAcnB+Ys7BptD8Ku9sVRbwDG37QBs20F2Zu2N
	 +2OAy063JaSuqbW6dXkezvxfSujipaTFr5jR7crcFntRQI5pD5b5B6LuKz0enfW7hz
	 Ey7Y94ARuIdrWNtG47GlzfclMUmYmJ5taDoIK3UlOOVOThML9BM5gsCXmxJTUbOtti
	 t/Y7HONM29MvA==
Date: Mon, 6 Oct 2025 13:52:13 -0500
From: Rob Herring <robh@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
	palmer@dabbelt.com, paul.walmsley@sifive.com, ben717@andestech.com,
	inochiama@gmail.com, thippeswamy.havalige@amd.com,
	namcao@linutronix.de, shradha.t@samsung.com, pjw@kernel.org,
	randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH v6 2/5] dt-bindings: PCI: Add Andes QiLai PCIe support
Message-ID: <20251006185213.GA61386-robh@kernel.org>
References: <20251003023527.3284787-1-randolph@andestech.com>
 <20251003023527.3284787-3-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251003023527.3284787-3-randolph@andestech.com>

On Fri, Oct 03, 2025 at 10:35:24AM +0800, Randolph Lin wrote:
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> Only one example is required in the DTS bindings YAML file.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  .../bindings/pci/andestech,qilai-pcie.yaml    | 97 +++++++++++++++++++
>  1 file changed, 97 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> new file mode 100644
> index 000000000000..419468430e7e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> @@ -0,0 +1,97 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/andestech,qilai-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes QiLai PCIe host controller
> +
> +description:
> +  Andes QiLai PCIe host controller is based on the Synopsys DesignWare
> +  PCI core. It shares common features with the PCIe DesignWare core and
> +  inherits common properties defined in
> +  Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
> +
> +maintainers:
> +  - Randolph Lin <randolph@andestech.com>
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: andestech,qilai-pcie
> +
> +  reg:
> +    items:
> +      - description: Data Bus Interface (DBI) registers.
> +      - description: APB registers.
> +      - description: PCIe configuration space region.
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: apb
> +      - const: config
> +
> +  ranges:
> +    maxItems: 2
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  "#interrupt-cells":
> +    const: 1

You can drop this. #interrupt-cells is already defined in 
pci-bus-common.yaml.

> +
> +  interrupt-map: true
> +
> +required:
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupts
> +  - interrupt-names
> +  - interrupt-map-mask
> +  - interrupt-map
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      bus@80000000 {
> +        compatible = "simple-bus";
> +        #address-cells = <2>;
> +        #size-cells = <2>;

Drop this node. No reason to show "simple-bus" in this example. Also it 
fails checks:

Documentation/devicetree/bindings/pci/andestech,qilai-pcie.example.dts:30.24-59.13: Warning (unit_address_vs_reg): /example-0/soc/bus@80000000: node has a unit name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.example.dtb: bus@80000000 (simple-bus): 'ranges' is a required property
	from schema $id: http://devicetree.org/schemas/simple-bus.yaml#

> +
> +        pcie@80000000 {
> +          compatible = "andestech,qilai-pcie";
> +          device_type = "pci";
> +          reg = <0x0 0x80000000 0x0 0x20000000>,
> +                <0x0 0x04000000 0x0 0x00001000>,
> +                <0x0 0x00000000 0x0 0x00010000>;
> +          reg-names = "dbi", "apb", "config";
> +
> +          linux,pci-domain = <0>;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
> +                   <0x43000000 0x01 0x00000000 0x01 0x0000000 0x1f 0x00000000>;
> +
> +          #interrupt-cells = <1>;
> +          interrupts = <0xf>;
> +          interrupt-names = "msi";
> +          interrupt-parent = <&plic0>;
> +          interrupt-map-mask = <0 0 0 7>;
> +          interrupt-map = <0 0 0 1 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                          <0 0 0 2 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                          <0 0 0 3 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                          <0 0 0 4 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>;
> +        };
> +      };
> +    };
> -- 
> 2.34.1
> 

