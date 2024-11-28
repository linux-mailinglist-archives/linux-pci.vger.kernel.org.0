Return-Path: <linux-pci+bounces-17431-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4669DB32B
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 08:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA02CB21B79
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62B0146D6E;
	Thu, 28 Nov 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMF41s3q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784FA53E23;
	Thu, 28 Nov 2024 07:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732778930; cv=none; b=t1IJQnvl3XGMXCXGW/5+EshhCwJF69e+QEfXQGAThT+8gzgchHxpOdbwmk4h9Qk2YIZin5qXOdrk0O46Y9sOYASK5Oat0qFd5z18WA205z8xFZYNbgeCZFYkBpmqEZDyNZM8LOmh42OvLTSY8doOD/cIaMYoZ2wFZpVu0l60S7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732778930; c=relaxed/simple;
	bh=7nC3Qu7oNJoNbqqmKfTwtHQvRJAGNMIxUaRM0PEe6Eo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ko8FiJEjtbopE3z7jZvZCH19akNe2u9hv4JcNHbm963PzqIHlq2oMo2BBHazKLxzZLr43/U/PuHUFsWVlzObifIsoBg2bAF/JlHxhfbfYlRovJAxOIuHcn0ydWvyFYLcSU3jpFokJoiHzcwIgXIDlXaJ4cIS594ZknX5LyPNrNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMF41s3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1FAC4CECE;
	Thu, 28 Nov 2024 07:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732778930;
	bh=7nC3Qu7oNJoNbqqmKfTwtHQvRJAGNMIxUaRM0PEe6Eo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMF41s3qUyfejrQPEU6XB2C+L3XdPU3isX/Wt3jcT41/hsJOOLOL9Nb14+rF5pxS2
	 43Zthc+OmGfCo4tgJq6A74CBS1zDS+uRB3Z5ZRRGnti1HTO6nPi+7vhCLW5s/1um18
	 fpYHvrerUPXUq3lb2r/7LqTCgaOLqkyNERNl91ZK6pln6RECWTsgBIxdA+EB/5xPTM
	 lFZzNl4j8cbmgj2r9U7Q+cnl5VKLZ4/5PnqaiTFodYtQcO7e5/PBYxArbJ3v6CKVlQ
	 noh1ZRa3Ky6/BOpdWwgo0BecE9J47jpFx/1ljBQuKOKoBBH32ubN318YK2/KqjWR7Z
	 oM6Dtam7xueaQ==
Date: Thu, 28 Nov 2024 08:28:46 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jingoohan1@gmail.com, michal.simek@amd.com, bharat.kumar.gogada@amd.com
Subject: Re: [PATCH 1/2] dt-bindings: PCI: amd-mdb: Add YAML schemas for AMD
 Versal2 MDB PCIe Root Port Bridge
Message-ID: <3xbfuwqxwflmnonziwgnt4rmdlquqmpyrvzzqvvogv6j64y3as@zuppsixhsd52>
References: <20241127115804.2046576-1-thippeswamy.havalige@amd.com>
 <20241127115804.2046576-2-thippeswamy.havalige@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241127115804.2046576-2-thippeswamy.havalige@amd.com>

On Wed, Nov 27, 2024 at 05:28:03PM +0530, Thippeswamy Havalige wrote:
> Add YAML dtschemas of AMD Versal2 MDB (Multimedia DMA Bridge) PCIe Root
> Port Bridge dt binding.

A nit, subject: drop second/last, redundant "YAML schemas for". The
"dt-bindings" prefix is already stating that these are schemas, cannot
be anything else.
See also:
https://elixir.bootlin.com/linux/v6.7-rc8/source/Documentation/devicetree/bindings/submitting-patches.rst#L18


> 
> Signed-off-by: Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> ---
>  .../devicetree/bindings/pci/amd,mdb-pcie.yaml | 132 ++++++++++++++++++
>  1 file changed, 132 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml

Nope, use compatible as filename.

> 
> diff --git a/Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml b/Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml
> new file mode 100644
> index 000000000000..ad9e447e87f2
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/amd,mdb-pcie.yaml
> @@ -0,0 +1,132 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/amd,mdb-pcie.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: AMD versal2 MDB(Multimedia DMA Bridge) Host Controller device tree

Drop "device tree". This is about hardware. Also, "versal2" or
"Versal2"? Just keep *consistent* in all AMD patchsets.

> +
> +maintainers:
> +  - Thippeswamy Havalige <thippeswamy.havalige@amd.com>
> +
> +properties:
> +  compatible:
> +    const: amd,versal2-mdb-host
> +
> +  reg:
> +    items:
> +      - description: MDB PCIe controller 0 SLCR
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
> +
> +  ranges:
> +    maxItems: 2
> +
> +  msi-map:
> +    maxItems: 1
> +
> +  bus-range:
> +    maxItems: 1
> +
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  device_type:
> +    const: pci

I think you miss referencing schema. Why standard PCI properties are
here?

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
> +    description: Interrupt controller node for handling legacy PCI interrupts.

Why the legacy is needed? This is a new binding and new device.

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
> +
> +required:
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - msi-map
> +  - ranges
> +  - "#interrupt-cells"
> +  - interrupt-controller
> +
> +unevaluatedProperties: false

You do not have any $ref, so this would not be correct, but OTOH this
points exactly to missing $ref.

> +
> +examples:
> +
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/interrupt-controller/irq.h>
> +
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +        pci@ed931000 {
> +            compatible = "amd,versal2-mdb-host";
> +            reg = <0x0 0xed931000 0x0 0x2000>,
> +                  <0x1000 0x100000 0x0 0xff00000>,
> +                  <0x1000 0x0 0x0 0x100000>,
> +                  <0x0 0xed860000 0x0 0x2000>;
> +            reg-names = "mdb_pcie_slcr", "config", "dbi", "atu";
> +            ranges = <0x2000000 0x00 0xa8000000 0x00 0xa8000000 0x00 0x10000000>,
> +                     <0x43000000 0x1100 0x00 0x1100 0x00 0x00 0x1000000>;
> +            interrupts = <0 198 4>;

You included headers so use them.

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
> +                    #address-cells = <0>;

Messed indentation.

Best regards,
Krzysztof


