Return-Path: <linux-pci+bounces-33952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7A0B24E3B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 17:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F221606CF
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 15:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89CE27AC34;
	Wed, 13 Aug 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+NwJ5hq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B78E276058;
	Wed, 13 Aug 2025 15:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755099851; cv=none; b=KP/6fIwx/IneH3szRqFm4cgAN2/sz8JFOdoKgE+6Rh8ZIJdBdgSVsjdG019GHu1X+En2NGpWqRC9mZU8/o74wUy9yqmC54rv+SqVttmairpOwoQ7y7u57Nn3hlcHyuBK7YSElsq6nFWCwDsyJXR80CZ+waJiBuwytA06evhvD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755099851; c=relaxed/simple;
	bh=O2hl/hlVCOc1FdbV0cQBKJVYbqIwGltINMJ91/7CsDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hLHbi1dIcfLEBHMdJv42U61QWUHMfYgldFKy0+QH7PKNrRbsTj1bIncPhpiT3snbgUB8LDjDKNCjja8aTJi2B61ecQQ0WV1o5SxRWoefmuKJvxayjlDodXydgkVpL/Xdre4WBIkkeuz15ylG3d2F3EWZqEqb+4A577H0Q3GAqDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+NwJ5hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 017D7C4CEEB;
	Wed, 13 Aug 2025 15:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755099851;
	bh=O2hl/hlVCOc1FdbV0cQBKJVYbqIwGltINMJ91/7CsDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O+NwJ5hq6eoz0kZJJvysgjZN9eqWQYocqHLJbc++4LHC0hEKirRnUNqU/xk6Fm7vw
	 /27BzGwp1799XXCZPxUwx12cv4y39Apt4zWq6UyjreNomnIGgtOHvm/xyC+JxuivXI
	 K5Pxvh3gQKj/8INsYwxjNwKuZoye2GVolnonH9+cY0NLFnUl9SzR8uIeMTsH60o8oa
	 zdCu3ij0xIHPlILeDgKOpOWqdffbQQB+vKdjMYqNOCjYdcNh2AoD9rRvGQx+FrQgMV
	 JdGoTpBP3W32C5QdF7nWuCYlgwmEUUHmZAxOxeFdrerd4QzjK3joNwb0cUeNmW539Y
	 bdvV7TpMHoRXQ==
Date: Wed, 13 Aug 2025 10:44:10 -0500
From: Rob Herring <robh@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
	mani@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com,
	guoyin.chen@cixtech.com, peter.chen@cixtech.com,
	cix-kernel-upstream@cixtech.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 08/13] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings
Message-ID: <20250813154410.GB114155-robh@kernel.org>
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-9-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813042331.1258272-9-hans.zhang@cixtech.com>

On Wed, Aug 13, 2025 at 12:23:26PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Document the bindings for CIX Sky1 PCIe Controller configured in
> root complex mode with five root port.
> 
> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> ---
>  .../bindings/pci/cix,sky1-pcie-host.yaml      | 79 +++++++++++++++++++
>  1 file changed, 79 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> new file mode 100644
> index 000000000000..2bd66603ac24
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> @@ -0,0 +1,79 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/cix,sky1-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: CIX Sky1 PCIe Root Complex
> +
> +maintainers:
> +  - Hans Zhang <hans.zhang@cixtech.com>
> +
> +description:
> +  PCIe root complex controller based on the Cadence PCIe core.
> +
> +allOf:
> +  - $ref: /schemas/pci/pci-host-bridge.yaml#
> +
> +properties:
> +  compatible:
> +    const: cix,sky1-pcie-host
> +
> +  reg:
> +    items:
> +      - description: PCIe controller registers.
> +      - description: ECAM registers.
> +      - description: Remote CIX System Unit registers.
> +      - description: Region for sending messages registers.
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: cfg
> +      - const: rcsu
> +      - const: msg
> +
> +  ranges:
> +    maxItems: 3
> +
> +required:
> +  - compatible
> +  - ranges
> +  - bus-range
> +  - device_type
> +  - interrupt-map
> +  - interrupt-map-mask
> +  - msi-map
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    / {

bus {

> +      #address-cells = <2>;
> +      #size-cells = <2>;
> +
> +      pcie@a010000 {
> +          compatible = "cix,sky1-pcie-host";
> +          reg = <0x00 0x0a010000 0x00 0x10000>,
> +                <0x00 0x2c000000 0x00 0x4000000>,
> +                <0x00 0x0a000000 0x00 0x10000>,
> +                <0x00 0x60000000 0x00 0x00100000>;
> +          reg-names = "reg", "cfg", "rcsu", "msg";
> +          ranges = <0x01000000 0x00 0x60100000 0x00 0x60100000 0x00 0x00100000>,
> +                  <0x02000000 0x00 0x60200000 0x00 0x60200000 0x00 0x1fe00000>,
> +                  <0x43000000 0x18 0x00000000 0x18 0x00000000 0x04 0x00000000>;
> +          #address-cells = <3>;
> +          #size-cells = <2>;
> +          bus-range = <0xc0 0xff>;
> +          device_type = "pci";
> +          #interrupt-cells = <1>;
> +          interrupt-map-mask = <0 0 0 0x7>;
> +          interrupt-map = <0 0 0 1 &gic 0 0 GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH 0>,
> +                          <0 0 0 2 &gic 0 0 GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH 0>,
> +                          <0 0 0 3 &gic 0 0 GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH 0>,
> +                          <0 0 0 4 &gic 0 0 GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH 0>;
> +          msi-map = <0xc000 &gic_its 0xc000 0x4000>;
> +      };
> +    };
> -- 
> 2.49.0
> 

