Return-Path: <linux-pci+bounces-39879-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD2C22D57
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 01:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 224BA3B1FC2
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 00:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 028DE21146C;
	Fri, 31 Oct 2025 00:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P/HU3a2m"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5C5620298D;
	Fri, 31 Oct 2025 00:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761872330; cv=none; b=cBLSOLu+5SPMl8cRZhiVWiR6SwulwQaMcXEsepxW0plR2IMQjWJ+Gkrn/GPHKma72Wf6rJ09eUMNWdo4EgHj8eZ8yHk/7BCB0W1+tXRzOB6W+KXO3nTN2QNaUfTV8r4dhv3MLwmrx5J9YOJLKjHLEXJw1mhn6D/F3MFCnTpIr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761872330; c=relaxed/simple;
	bh=dZXI+oZRfP0rR7K4/bP1MqGbDMPf4gEQFxOrKrsv6OM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XbLs7J8R3VGpC3LT36DuJYQLwwPh4U9SVkU00ugdSz7TrfNdaMF0mikFMCdQB4X83Mojo/a724oHLZoDkJyWIsE8I0M8J1SP9d9xlGK+LHs8aTfL3fIUH65X9JqMgdpEvL6ywJrIeASNKXu0P2PmnrnVT0LJoTz57smhJm4oLbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P/HU3a2m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DD7C4CEF1;
	Fri, 31 Oct 2025 00:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761872330;
	bh=dZXI+oZRfP0rR7K4/bP1MqGbDMPf4gEQFxOrKrsv6OM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P/HU3a2mhbVziJUtzHmXZzdjh5QOrPCUZ7utnBrU2gidZ/OA1iOQMiJVlzmNYHDSx
	 6v4tCSZk0ybeKwAEAIDvPv2kbZ+XcM6sGVdInqoi0Fklfj84aJQNivzQnpNBVS/OBf
	 FbtsGjbcOYuZKY6TkHzhvCu0EdQ6Z5dzVvgXiIa/JwbCLYDrZXAn3zkQDdPXeLjEkf
	 YWNjk3mDWKyWPJfXGfaX5dvUOegQa+vObESs73ndlyKliMeS0/2E2UmXz9pJlOPz02
	 QtNxOaQUHGikyZ5EuTogPfInOiWsn7nVkjRtd9FXim7DagIlxnNEdGqTr5EHqn8zy2
	 B8OwCq+hhLdNg==
Date: Thu, 30 Oct 2025 19:58:46 -0500
From: Rob Herring <robh@kernel.org>
To: Alex Elder <elder@riscstar.com>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org, bhelgaas@google.com,
	lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	dlan@gentoo.org, guodong@riscstar.com, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org, spacemit@lists.linux.dev,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] dt-bindings: pci: spacemit: introduce PCIe host
 controller
Message-ID: <20251031005718.GA539812-robh@kernel.org>
References: <20251030220259.1063792-1-elder@riscstar.com>
 <20251030220259.1063792-4-elder@riscstar.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251030220259.1063792-4-elder@riscstar.com>

On Thu, Oct 30, 2025 at 05:02:54PM -0500, Alex Elder wrote:
> Add the Device Tree binding for the PCIe root complex found on the
> SpacemiT K1 SoC.  This device is derived from the Synopsys Designware
> PCIe IP.  It supports up to three PCIe ports operating at PCIe gen 2
> link speeds (5 GT/sec).  One of the ports uses a combo PHY, which is
> typically used to support a USB 3 port.
> 
> Signed-off-by: Alex Elder <elder@riscstar.com>
> ---
>  .../bindings/pci/spacemit,k1-pcie-host.yaml   | 157 ++++++++++++++++++
>  1 file changed, 157 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> new file mode 100644
> index 0000000000000..58239a155ecc0
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/spacemit,k1-pcie-host.yaml
> @@ -0,0 +1,157 @@
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

Wrap lines at 80.

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
> +patternProperties:
> +  '^pcie?@':

It's always PCIe, so drop the '?'.

With that,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

