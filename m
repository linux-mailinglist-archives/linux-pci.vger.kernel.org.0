Return-Path: <linux-pci+bounces-38807-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 54554BF39CD
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 23:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8CB0188945C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 21:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15861334C3E;
	Mon, 20 Oct 2025 21:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXaAfJlA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2F2EB87F;
	Mon, 20 Oct 2025 21:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760994004; cv=none; b=TPyZfoTZLVD0bPIDGVIPbs80UvaeE9oL4QgQgAywpJ+RxrLISYMaQqzz7DKzU3uTZ7X8wAUHlourgqr7sXo1lLi9PCZD7fMPRMhzGfQDOnTPrz80Qt+wlGcvA9ogq8PwyiovHRyqO+JU3PX+y/w+DzxkATGONoaVYu1a+WgpRqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760994004; c=relaxed/simple;
	bh=/LZcJJRPVP3eFE1ecANAOSgixAXIk4StHRr4bpii2GY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gX5KGp5CHDpQaR57eEwYFjiZ4QlhsOWLyQ19TFALg7q/FUxHulE3F9BjmWsn1OS4bSpX+I+80zsE8z20/wCFu1XkqkH6q8uFn7M97PKPZ4HRo8TEXe/KZL4+yXL06tXP/eaVlDj4pErbIglDhZbEz3oyDz+104ytGJVbndcPM3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXaAfJlA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100C0C113D0;
	Mon, 20 Oct 2025 21:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760994003;
	bh=/LZcJJRPVP3eFE1ecANAOSgixAXIk4StHRr4bpii2GY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nXaAfJlAW5OJIVavpJS9PVvzhr/gsU/4BsqEO61ogsn+/mc83QgqVMI/PaqdNlsw7
	 uHAtBWRkXlzkPR8c0GBH5jLr+FBRdZD4SO5wXAniJuV+fA8MHutaoRV5TxIcREvC+Q
	 GeWd80jSwayMO9L6qWN/XMNz5mrK3uhJLo9IB0e6JcWqnqSrMnTsxFzzEfYbO6fXnj
	 zkXPLBRdKqm4G5yhgLEFZ3X5eerk7KrxspQoH6BbalRvy6m6YELQgjMJc3cP97sP+A
	 zS77KUb/mPR+8JlGv5E8O5pIl2e2WFBXksZv3bPqj5LGRT75JJ/UU2AcFHOO2PU2Qh
	 euBeoY0R7wHXg==
Date: Mon, 20 Oct 2025 16:00:01 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	dlan@gentoo.org, guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
Message-ID: <20251020210001.GA1764520-robh@kernel.org>
References: <20251017190740.306780-1-elder@riscstar.com>
 <20251017190740.306780-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017190740.306780-4-elder@riscstar.com>

On Fri, Oct 17, 2025 at 02:07:35PM -0500, Alex Elder wrote:
> Add the Device Tree binding for the PCIe root complex found on the
> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> typically used to support a USB 3 port.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
> v3: - Remove the "num-viewport" property
>     - A "phy" reset is no longer required
> 
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   | 147 ++++++++++++++++++
>  1 file changed, 147 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> new file mode 100644
> index 0000000000000..89f8b6b579c6e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> @@ -0,0 +1,147 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/spacemit,k1-pcie-host.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: SpacemiT K1 PCI Express Host Controller
> +
> +maintainers:
> +  - Alex Elder <elder@riscstar.com>
> +
> +description: >
> +  The SpacemiT K1 SoC PCIe host controller is based on the Synopsys
> +  DesignWare PCIe IP.  The controller uses the DesignWare built-in
> +  MSI interrupt controller, and supports 256 MSIs.
> +
> +allOf:
> +  - $ref: /schemas/pci/snps,dw-pcie.yaml#
> +
> +properties:
> +  compatible:
> +    const: spacemit,k1-pcie
> +
> +  reg:
> +    items:
> +      - description: DesignWare PCIe registers
> +      - description: ATU address space
> +      - description: PCIe configuration space
> +      - description: Link control registers
> +
> +  reg-names:
> +    items:
> +      - const: dbi
> +      - const: atu
> +      - const: config
> +      - const: link
> +
> +  spacemit,apmu:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    description:
> +      A phandle that refers to the APMU system controller, whose
> +      regmap is used in managing resets and link state, along with
> +      and offset of its reset control register.
> +    items:
> +      - items:
> +          - description: phandle to APMU system controller
> +          - description: register offset
> +
> +  clocks:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) clock
> +      - description: DWC PCIe application AXI-bus master interface clock
> +      - description: DWC PCIe application AXI-bus slave interface clock
> +
> +  clock-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  resets:
> +    items:
> +      - description: DWC PCIe Data Bus Interface (DBI) reset
> +      - description: DWC PCIe application AXI-bus master interface reset
> +      - description: DWC PCIe application AXI-bus slave interface reset
> +
> +  reset-names:
> +    items:
> +      - const: dbi
> +      - const: mstr
> +      - const: slv
> +
> +  interrupts:
> +    items:
> +      - description: Interrupt used for MSIs
> +
> +  interrupt-names:
> +    const: msi
> +
> +  phys:
> +    maxItems: 1
> +

> +  vpcie3v3-supply:
> +    description:
> +      A phandle for 3.3v regulator to use for PCIe
> +
> +  device_type:
> +    const: pci

Both of these are part of pci-bus-common.yaml and can be dropped from 
here.

> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - spacemit,apmu

> +  - "#address-cells"
> +  - "#size-cells"
> +  - ranges

Always required by pci-bus-common.yaml. Drop.

> +  - clocks
> +  - clock-names
> +  - resets
> +  - reset-names
> +  - interrupts
> +  - interrupt-names
> +  - phys
> +  - vpcie3v3-supply

> +  - device_type

Always required by pci-bus-common.yaml. Drop.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

