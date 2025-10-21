Return-Path: <linux-pci+bounces-38898-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DFECBF6C88
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 15:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 30559503D4D
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 13:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19A7334C26;
	Tue, 21 Oct 2025 13:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrCDX60S"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1C122B8CB;
	Tue, 21 Oct 2025 13:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053422; cv=none; b=YlMBejXTEijw+UchkEi3loMG0bKmj5GhFAUo1URUfPYNe8MseObu/8VHNqxsbAAn24LZYkqX1dWYI3fRPk2iB4nOFD6gkFTCmChvoq/vBMXkYivFKIOqRcoL2J74KMwWf8m+KKrxtP1oOnqjQBfGCQbq3ja8y3WBbI+vRhxsNrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053422; c=relaxed/simple;
	bh=TYwNPmQgCPJl15/tu+lF46PWA2zAyxHpdfqlwEfJl4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tCDDKJQV1N8/lKzPCwgJ0bqT/2dlfsIJrAx8UQ/BzF4wSEPP/8Ny++5yIOuludmvbuHYINwAnCC0Aj1N3WUhH+RzP06i9N58V4smRVl2X1gH2bywyb9xs2Iw/Jxc5Mdk6MMWsXGDtffah0PjqFHzwDp5riGIuS9iy9rbfSOwjGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrCDX60S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F2ACC4CEF1;
	Tue, 21 Oct 2025 13:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761053420;
	bh=TYwNPmQgCPJl15/tu+lF46PWA2zAyxHpdfqlwEfJl4Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PrCDX60SgwFPULyfPpayppmJ0fqejs4Do7UsqATkShfhF5rxG1k4uEylrzMJm+m3B
	 1l688jkyk/D8vvN+0J1fS70ZtplBnD7m/I/eLqBJ1mCaNYoIW9Np7Q+/p4NEBekV4c
	 +D9gWhjlve317aEJdKadfeUwvydjCYfXsMNssAnL5q3ECMvINcKZW8poc5bO5oioT4
	 TE/n9HHwauOHVcE31U4zSyp8hmg2zM6RqXKViYYX8nq/pL+3ePslNhzfY4bK1jHtQ7
	 MOrTN4U3P0C07h+IgOj5nJMhJKYljKbxG+ESXMcFBVrwlOqu9gmfve50I89KsCxQ4C
	 zcE7dmx7mfG7A==
Date: Tue, 21 Oct 2025 08:30:18 -0500
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
Subject: Re: [PATCH v8 2/5] dt-bindings: PCI: Add Andes QiLai PCIe support
Message-ID: <20251021133018.GA13337-robh@kernel.org>
References: <20251014120349.656553-1-randolph@andestech.com>
 <20251014120349.656553-3-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014120349.656553-3-randolph@andestech.com>

On Tue, Oct 14, 2025 at 08:03:46PM +0800, Randolph Lin wrote:
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> Only one example is required in the DTS bindings YAML file.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  .../bindings/pci/andestech,qilai-pcie.yaml    | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> new file mode 100644
> index 000000000000..ca444e4766ec
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> @@ -0,0 +1,84 @@
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

Drop the 2nd sentence as the schema says the same thing with the $ref.

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

interrupt-names:
  const: msi

> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-names
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
> +      pcie@80000000 {
> +        compatible = "andestech,qilai-pcie";
> +        device_type = "pci";
> +        reg = <0x0 0x80000000 0x0 0x20000000>,
> +              <0x0 0x04000000 0x0 0x00001000>,
> +              <0x0 0x00000000 0x0 0x00010000>;
> +        reg-names = "dbi", "apb", "config";
> +
> +        linux,pci-domain = <0>;
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +        ranges = <0x02000000 0x00 0x10000000 0x00 0x10000000 0x0 0xf0000000>,
> +                 <0x43000000 0x01 0x00000000 0x01 0x0000000 0x1f 0x00000000>;
> +
> +        #interrupt-cells = <1>;
> +        interrupts = <0xf>;
> +        interrupt-names = "msi";
> +        interrupt-parent = <&plic0>;
> +        interrupt-map-mask = <0 0 0 7>;
> +        interrupt-map = <0 0 0 1 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 2 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 3 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>,
> +                        <0 0 0 4 &plic0 0xf IRQ_TYPE_LEVEL_HIGH>;
> +      };
> +    };
> +...
> -- 
> 2.34.1
> 

