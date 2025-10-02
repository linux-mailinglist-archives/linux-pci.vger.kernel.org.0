Return-Path: <linux-pci+bounces-37383-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7B4BB2241
	for <lists+linux-pci@lfdr.de>; Thu, 02 Oct 2025 02:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BBA5171DF5
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 00:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BD62C187;
	Thu,  2 Oct 2025 00:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVncy673"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D1D1CAA4;
	Thu,  2 Oct 2025 00:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759364635; cv=none; b=VR1hTtgbtFEO2QylYozIaf7lsuBiI0F517tehqpNw4C1xF01GirYugj5uypLtPcY1Nd/Ea+zauCeTacc09jX4390JpDxFndhcuGI04IVo7XBAwiyUjVpnZ3B5+aMxOCj7fkvFeblV6Y2f6uVjERAKhbF4jnc9c9InSdz1hla5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759364635; c=relaxed/simple;
	bh=nLP9fhz32gTFEWdtwpsj7W9ND021HfhNxyofKluho6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HwvrR++lQ+dif8Pd7iBeBg8gbbP9SfOX1SZ30M3GkCHdmh1Z5/sCqaEx1sT20K7mwKe7w5umrPJlAUO8Ud9hBRHangQyPx6HcyNgTV68kfgaX9bIBCrjyerTVHMUWwhARsf7felTTkyC4j/N1OENSOFE84uo4nF1Wv6w+f/fd4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVncy673; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D677C4CEF5;
	Thu,  2 Oct 2025 00:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759364634;
	bh=nLP9fhz32gTFEWdtwpsj7W9ND021HfhNxyofKluho6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hVncy673Ouc6oDlymJrlJBYVllMJPVo9qRPxUCmt7wiJFH5+Sb4PBeeRmIbadcjMZ
	 IRNL+Qgm310d/brridU3WBuserJwTUDJGoPt48MemO+bxadoXwctLeWP2biFyIZQ9o
	 ds0+MUCbh4xckpMv72ksV0abLBftwcd4UUUiTAbvB5K8zhjLYZGIRb7mmzrNgB6xLU
	 LOZRu+h0k+mvsdGM1U14VjlD99qh7QKqHhr8/j4gVrkM0zP2AGxBK2gFuUhRctvhxg
	 4TKkPNahRkz1SuEyX1XyoBywuPGAOdRRW1DxuMgzZinlR5L+BXzkPHNE5dwzZxP5Dw
	 17rdW+LczJGXA==
Date: Wed, 1 Oct 2025 19:23:47 -0500
From: Rob Herring <robh@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, alex@ghiti.fr, aou@eecs.berkeley.edu,
	palmer@dabbelt.com, paul.walmsley@sifive.com, ben717@andestech.com,
	inochiama@gmail.com, thippeswamy.havalige@amd.com,
	namcao@linutronix.de, shradha.t@samsung.com,
	randolph.sklin@gmail.com, tim609@andestech.com
Subject: Re: [PATCH v4 2/5] dt-bindings: PCI: Add Andes QiLai PCIe support
Message-ID: <20251002002347.GA2629882-robh@kernel.org>
References: <20250924112820.2003675-1-randolph@andestech.com>
 <20250924112820.2003675-3-randolph@andestech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250924112820.2003675-3-randolph@andestech.com>

On Wed, Sep 24, 2025 at 07:28:17PM +0800, Randolph Lin wrote:
> Add the Andes QiLai PCIe node, which includes 3 Root Complexes.
> Only one example is required in the DTS bindings YAML file.
> 
> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  .../bindings/pci/andestech,qilai-pcie.yaml    | 103 ++++++++++++++++++
>  1 file changed, 103 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> new file mode 100644
> index 000000000000..8effe6ebd9d7
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/andestech,qilai-pcie.yaml
> @@ -0,0 +1,103 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/andestech,qilai-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Andes QiLai PCIe host controller
> +
> +description: |+

Don't need '|+'.

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
> +        dma-ranges = <0x44 0x00000000 0x04 0x00000000 0x04 0x00000000>;
> +        ranges = <0x00 0x80000000 0x00 0x80000000 0x00 0x20000000>,
> +                 <0x00 0x04000000 0x00 0x04000000 0x00 0x00001000>,
> +                 <0x00 0x00000000 0x20 0x00000000 0x20 0x00000000>;

Drop ranges and dma-ranges. Not relevant to the example.

> +
> +        pci@80000000 {

pcie

> +          compatible = "andestech,qilai-pcie";
> +          device_type = "pci";
> +          reg = <0x0 0x80000000 0x0 0x20000000>,
> +                <0x0 0x04000000 0x0 0x00001000>,
> +                <0x0 0x00000000 0x0 0x00010000>;
> +          reg-names = "dbi", "apb", "config";
> +
> +          linux,pci-domain = <0>;
> +          bus-range = <0x0 0xff>;

You don't need this if 0-0xff is supported. That's the default.

> +          num-viewport = <4>;

Deprecated...

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

