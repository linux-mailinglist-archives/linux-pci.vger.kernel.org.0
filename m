Return-Path: <linux-pci+bounces-44644-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A83D3D1A523
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC2B33006E18
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9098730F921;
	Tue, 13 Jan 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+GGbsJG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BD29AB02;
	Tue, 13 Jan 2026 16:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322254; cv=none; b=h4bXZxJl+B8uhC7MTyX+XPgkXQRVO4C+Q0NR73/cxIZsGaXv8lekrxDN8CE5aJ325C3qolTnJ9IpUPtqOI5Dl5kxOpErABNka44x/PyzymS8EhQTVeR+vYWFwXcwSbIyrtFe8rl1n5SmDhe/1e5zf8889K7CiYAbmVGNB5rdfpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322254; c=relaxed/simple;
	bh=3QTGYpy44w4JkHrLydY3liUet43oqMawt7YyQR076Nc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ff8SBq+2kZ6vFVR+frD1xyWM9E/KCJfgvPAwkZ+l7tie/cSNcB3njZiYLKORSeMI/UAkY0dc1/z+jC79qc6xSlCbi5qwIBnyvh5U3SqUqJeqpDupvLwnqoyjOz76nO5ksQO5fSWmMjt9pHm7zHtwZUyUO+yGQK6N74SVP4PUoRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+GGbsJG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E85E0C116C6;
	Tue, 13 Jan 2026 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322254;
	bh=3QTGYpy44w4JkHrLydY3liUet43oqMawt7YyQR076Nc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S+GGbsJGTqSm/Px0II9ynY8ovloneoybXouP4iAVkH1zaFIXah6LNLq4zBwiUg0f7
	 wceIiUt8C5870u4fZzTS6by5xCuhXRPzyWSGe8Hhb7Am+rOpOKxXj6pcwfk2OrMNmv
	 tddjUeUOZWZr0r/yExvtNLg9huyMDpI23rgH2kLVlg/EM8u3ilizBhyHd6RaqvKY7A
	 j4vCfhxKSbCgELYAAF7PjaTdA4DPvs0e8lhUzW1p/VFowTSVeOoVaL05xfIP3vBG5R
	 kFPaBVlwf9iw3Tn1sadOROEsqaOgAJbkOf+QI5Ryx91r17qyE6I+NHJ1TVfzvzErWU
	 l7iz21KjP9iCw==
Date: Tue, 13 Jan 2026 10:37:33 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-pm@vger.kernel.org, linux-ide@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <20260113163733.GA3743579-robh@kernel.org>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-2-8173d8a72641@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260107-pci-m2-v5-2-8173d8a72641@oss.qualcomm.com>

On Wed, Jan 07, 2026 at 07:41:24PM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> provides interfaces like PCIe and SATA to attach the Solid State Drives
> (SSDs) to the host machine along with additional interfaces like USB, and
> SMBus for debugging and supplementary features.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-m-connector.yaml    | 133 +++++++++++++++++++++
>  1 file changed, 133 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> new file mode 100644
> index 000000000000..e912ee6f6a59
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> @@ -0,0 +1,133 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key M Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> +  host system over PCIe/SATA interfaces. These connectors also offer optional
> +  interfaces like USB, SMBus.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-m-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.
> +
> +    properties:
> +      port@0:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: Host interfaces of the connector
> +
> +        properties:
> +          endpoint@0:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: PCIe interface
> +
> +          endpoint@1:
> +            $ref: /schemas/graph.yaml#/properties/endpoint
> +            description: SATA interface
> +
> +        anyOf:
> +          - required:
> +              - endpoint@0
> +          - required:
> +              - endpoint@1
> +
> +      port@1:
> +        $ref: /schemas/graph.yaml#/properties/port
> +        description: USB 2.0 interface
> +
> +      i2c-parent:
> +        $ref: /schemas/types.yaml#/definitions/phandle
> +        description: SMBus interface

This belongs outside of 'ports'. I would expect you'd get an error if 
you tried to put it here as '/schemas/graph.yaml#/properties/ports' 
shouldn't allow it. Please include the property in the example.

> +
> +    required:
> +      - port@0
> +
> +  clocks:
> +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> +      more details.
> +    maxItems: 1
> +
> +  pedet-gpios:
> +    description: GPIO input to PEDET signal. This signal is used by the host
> +      systems to determine the communication protocol that the M.2 card uses;
> +      SATA signaling (low) or PCIe signaling (high). Refer, PCI Express M.2
> +      Specification r4.0, sec 3.3.4.2 for more details.
> +    maxItems: 1
> +
> +  viocfg-gpios:
> +    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
> +      signal is used by the M.2 card to indicate to the host system that the
> +      card supports an independent IO voltage domain for the sideband signals.
> +      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
> +    maxItems: 1
> +
> +  pwrdis-gpios:
> +    description: GPIO input to Power Disable (PWRDIS) signal. This signal is
> +      used by the host system to disable power on the M.2 card. Refer, PCI
> +      Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> +    maxItems: 1
> +
> +  pln-gpios:
> +    description: GPIO output to Power Loss Notification (PLN#) signal. This
> +      signal is use to notify the M.2 card by the host system that the power
> +      loss event is expected to occur. Refer, PCI Express M.2 Specification
> +      r4.0, sec 3.2.17.1 for more details.
> +    maxItems: 1
> +
> +  plas3-gpios:
> +    description: GPIO output to Power Loss Acknowledge (PLA_S3#) signal. This

GPIO input?

> +      signal is used by the M.2 card to notify the host system, the status of
> +      the M.2 card's preparation for power loss.
> +    maxItems: 1
> +
> +required:
> +  - compatible
> +  - vpcie3v3-supply

All the GPIOs are really optional?

> +
> +additionalProperties: false
> +
> +examples:
> +  # PCI M.2 Key M connector for SSDs with PCIe interface
> +  - |
> +    connector {
> +        compatible = "pcie-m2-m-connector";
> +        vpcie3v3-supply = <&vreg_nvme>;
> +
> +        ports {
> +            #address-cells = <1>;
> +            #size-cells = <0>;
> +
> +            port@0 {
> +                #address-cells = <1>;
> +                #size-cells = <0>;
> +
> +                reg = <0>;
> +
> +                endpoint@0 {
> +                    reg = <0>;
> +                    remote-endpoint = <&pcie6_port0_ep>;
> +                };

Please make the example as complete as possible.

> +            };
> +        };
> +    };
> 
> -- 
> 2.48.1
> 

