Return-Path: <linux-pci+bounces-31056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0970DAED57C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 09:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE3616B8FF
	for <lists+linux-pci@lfdr.de>; Mon, 30 Jun 2025 07:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01DD21A452;
	Mon, 30 Jun 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FK0xHS5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D1419A2A3;
	Mon, 30 Jun 2025 07:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751268367; cv=none; b=eTzu8XBWCnIOEI80qF6Z0eehYwbZJH0uvbagqba2eYOt2oize6GKRXMakLrjV0c2SRgMSAx8EUvpG5lZq+oa1j1eAm9IHgjHVfPQvI0F/w0uUJbuIu6hynIy7QC4c1Nrp4psFMwdQFk8hkVUzH8szDu9iU0NmpUx6ab8v1EEN+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751268367; c=relaxed/simple;
	bh=N63MVrwXeESZ4gdhfhs/nJSmcaNTprtwSWNzBFpzojA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mvCaX61/FDMMQLH/XacWbDyBOQDmRuDxusD2drWaEb1Ch78ALmRQjQp7rm8Vm6CnonHwzVOYutpsgFTWYPA//91rEF7zWVUgojZ1MRsesyPXcZxcoFuU248Fy/pYDmdTNFAbrwANWSjXneGCHeQEOW7z47Nwv6F4qoeLvMI//OA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FK0xHS5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AD54C4CEE3;
	Mon, 30 Jun 2025 07:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751268367;
	bh=N63MVrwXeESZ4gdhfhs/nJSmcaNTprtwSWNzBFpzojA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FK0xHS5yiaHjPn3OXM/rCBwtkD+DqBQnjE4kT8a6iBeeF6lqM2QSKIO6skrDcFT09
	 aH7pbIzR1Y7JsJpgg+HibtZkWAE/2KF2VbJl+S8wu5/i2IsT0XZAIUWBMU3wGKdj10
	 FQrNaw3PO28qjPXD2xiI7dbj1ZqWvRq0IZP9L3rigEnsKzJnMZJnl7uZOXLxgMFIvy
	 QMMBVii0vN/m9BdYl0ZlquM65WGZ0m+jH8VGfN+EfJFpnhlQUdr9hcsGm1iU9apScw
	 GJo3yKvO4pmPLyuB7MHsEqkbXpZ4GAu+kColxE2tbosgUhGiVCdJ7AW9i8A5ULJpND
	 xBNd/ieJGpcdw==
Date: Mon, 30 Jun 2025 09:26:03 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: hans.zhang@cixtech.com
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, mpillai@cadence.com, fugang.duan@cixtech.com, 
	guoyin.chen@cixtech.com, peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/14] dt-bindings: PCI: Add CIX Sky1 PCIe Root
 Complex bindings
Message-ID: <20250630-graceful-horse-of-science-eecc53@krzk-bin>
References: <20250630041601.399921-1-hans.zhang@cixtech.com>
 <20250630041601.399921-11-hans.zhang@cixtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250630041601.399921-11-hans.zhang@cixtech.com>

On Mon, Jun 30, 2025 at 12:15:57PM +0800, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> Document the bindings for CIX Sky1 PCIe Controller configured in
> root complex mode with five root port.
> 
> Supports 4 INTx, MSI and MSI-x interrupts from the ARM GICv3 controller.
> 
> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
> Reviewed-by: Manikandan K Pillai <mpillai@cadence.com>
> ---
>  .../bindings/pci/cix,sky1-pcie-host.yaml      | 133 ++++++++++++++++++
>  1 file changed, 133 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> new file mode 100644
> index 000000000000..b4395bc06f2f
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/cix,sky1-pcie-host.yaml
> @@ -0,0 +1,133 @@
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
> +  - $ref: /schemas/pci/cdns-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - const: cix,sky1-pcie-host
> +
> +  reg:
> +    items:
> +      - description: PCIe controller registers.
> +      - description: Remote CIX System Unit registers.
> +      - description: ECAM registers.
> +      - description: Region for sending messages registers.
> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: rcsu
> +      - const: cfg

cfg is the second, look at cdns bindings.

> +      - const: msg
> +
> +  "#interrupt-cells":
> +    const: 1
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
> +  max-link-speed:
> +    maximum: 4

Why are you redefining core properties?

> +
> +  num-lanes:
> +    maximum: 8
> +
> +  ranges:
> +    maxItems: 3
> +
> +  msi-map:
> +    maxItems: 1
> +
> +  vendor-id:
> +    const: 0x1f6c

Why? This is implied by compatible.

> +
> +  device-id:
> +    enum:
> +      - 0x0001

Why? This is implied by compatible.

> +
> +  cdns,no-inbound-bar:

That's not a cdns binding, so wrong prefix.

> +    description: |

Do not need '|' unless you need to preserve formatting.

> +      Indicates the PCIe controller does not require an inbound BAR region.

And anyway this is implied by compatible, drop.

> +    type: boolean
> +
> +  sky1,pcie-ctrl-id:
> +    description: |
> +      Specifies the PCIe controller instance identifier (0-4).

No, you don't get an instance ID. Drop the property and look how other
bindings encoded it (not sure about the purpose and you did not explain
it, so cannot advise).

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    minimum: 0
> +    maximum: 4
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - "#interrupt-cells"
> +  - interrupt-map-mask
> +  - interrupt-map
> +  - max-link-speed
> +  - num-lanes
> +  - bus-range
> +  - device_type
> +  - ranges
> +  - msi-map
> +  - vendor-id
> +  - device-id
> +  - cdns,no-inbound-bar
> +  - sky1,pcie-ctrl-id
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    pcie_x8_rc: pcie@a010000 {

Drop unused label.


Best regards,
Krzysztof


