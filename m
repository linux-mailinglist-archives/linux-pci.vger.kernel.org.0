Return-Path: <linux-pci+bounces-44647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B5DD1A63D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1040B302D384
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 16:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AA334D38C;
	Tue, 13 Jan 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSQDeeEP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E37334CFCC;
	Tue, 13 Jan 2026 16:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768322928; cv=none; b=YwpEUiRArKOuQ7ChbOp74vNLWTkE0MvcBTrHvhEjy4pVh6FCATQfVxmHKvWRz8+cDUqzlXQBUOJBuqEC8vStuyuRugAvTE54vG8kPYlTEuJI63zcQjHzmyDiYW6ts3DnTYNmYNQf5LLSR5+gtkxoNRmXIkAhzFdllrRP5LizDT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768322928; c=relaxed/simple;
	bh=9Xi4F4hDVlUXQAZiuT7/skN/sMa6mBICWxabbaie9bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ea8kLLyJHb/lw9JTuX/EunMvusO+ShAE9zAVr2ASEdiZsbbLWn72Wwz+QgdhIJh4Soxq67YY7t9gTqa9T9cU2d6FqqTLDYkVb4LalAUTaUjKyMFEMj5zyNyZC1LQI3UBkjLDTwDqXO7h3MeJSKsSKO1vaMD+d3qth8OLBsjJBUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSQDeeEP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD37BC19422;
	Tue, 13 Jan 2026 16:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768322928;
	bh=9Xi4F4hDVlUXQAZiuT7/skN/sMa6mBICWxabbaie9bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DSQDeeEP3Ac1HUW7ML9da+hYHgxI5RJ0f2MMfzbJSzVBZpioIAiqG/Pa2edk5MH+p
	 dT2ipZcgIeS2csLEFvgScSCMgNs+IAcz3aPxnwbJbM9EnZiq4Pw4ccK6TdlIQkjs8W
	 bUo2LRvT3QM05Hv1i2wadPMsgM6fphmlmkLzNk+iNVqq0f8LkDdep8fMEtT+a4zlgu
	 nZUBWI3g6RI9ptg0W8y2FL7QjzvRtE0msLoP5CmEHbxzcFYMRwHiKJhTAIBlRMXO6E
	 uoPOwnpgyG0RyC31amahaWSekoj+C/gWrcSwHbCzE/WTT9DQfoZM5GCIpPq3MnZpH5
	 hY9xmI13JIiqA==
Date: Tue, 13 Jan 2026 22:18:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, linux-ide@vger.kernel.org, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 2/5] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <mlgfs2v4eoovrdjba5l72yceudut5fa3xvi57s6cxukyfkyau4@7oo3dfohn2z3>
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-2-8173d8a72641@oss.qualcomm.com>
 <20260113163733.GA3743579-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113163733.GA3743579-robh@kernel.org>

On Tue, Jan 13, 2026 at 10:37:33AM -0600, Rob Herring wrote:
> On Wed, Jan 07, 2026 at 07:41:24PM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> > provides interfaces like PCIe and SATA to attach the Solid State Drives
> > (SSDs) to the host machine along with additional interfaces like USB, and
> > SMBus for debugging and supplementary features.
> > 
> > The connector provides a primary power supply of 3.3v, along with an
> > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > 1.8v sideband signaling.
> > 
> > The connector also supplies optional signals in the form of GPIOs for fine
> > grained power management.
> > 
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-m-connector.yaml    | 133 +++++++++++++++++++++
> >  1 file changed, 133 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > new file mode 100644
> > index 000000000000..e912ee6f6a59
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > @@ -0,0 +1,133 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/pcie-m2-m-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PCIe M.2 Mechanical Key M Connector
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > +
> > +description:
> > +  A PCIe M.2 M connector node represents a physical PCIe M.2 Mechanical Key M
> > +  connector. The Mechanical Key M connectors are used to connect SSDs to the
> > +  host system over PCIe/SATA interfaces. These connectors also offer optional
> > +  interfaces like USB, SMBus.
> > +
> > +properties:
> > +  compatible:
> > +    const: pcie-m2-m-connector
> > +
> > +  vpcie3v3-supply:
> > +    description: A phandle to the regulator for 3.3v supply.
> > +
> > +  vpcie1v8-supply:
> > +    description: A phandle to the regulator for VIO 1.8v supply.
> > +
> > +  ports:
> > +    $ref: /schemas/graph.yaml#/properties/ports
> > +    description: OF graph bindings modeling the interfaces exposed on the
> > +      connector. Since a single connector can have multiple interfaces, every
> > +      interface has an assigned OF graph port number as described below.
> > +
> > +    properties:
> > +      port@0:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Host interfaces of the connector
> > +
> > +        properties:
> > +          endpoint@0:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: PCIe interface
> > +
> > +          endpoint@1:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: SATA interface
> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
> > +          - required:
> > +              - endpoint@1
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: USB 2.0 interface
> > +
> > +      i2c-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: SMBus interface
> 
> This belongs outside of 'ports'. I would expect you'd get an error if 
> you tried to put it here as '/schemas/graph.yaml#/properties/ports' 
> shouldn't allow it. Please include the property in the example.
> 

Okay.

> > +
> > +    required:
> > +      - port@0
> > +
> > +  clocks:
> > +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> > +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> > +      more details.
> > +    maxItems: 1
> > +
> > +  pedet-gpios:
> > +    description: GPIO input to PEDET signal. This signal is used by the host
> > +      systems to determine the communication protocol that the M.2 card uses;
> > +      SATA signaling (low) or PCIe signaling (high). Refer, PCI Express M.2
> > +      Specification r4.0, sec 3.3.4.2 for more details.
> > +    maxItems: 1
> > +
> > +  viocfg-gpios:
> > +    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
> > +      signal is used by the M.2 card to indicate to the host system that the
> > +      card supports an independent IO voltage domain for the sideband signals.
> > +      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
> > +    maxItems: 1
> > +
> > +  pwrdis-gpios:
> > +    description: GPIO input to Power Disable (PWRDIS) signal. This signal is
> > +      used by the host system to disable power on the M.2 card. Refer, PCI
> > +      Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> > +    maxItems: 1
> > +
> > +  pln-gpios:
> > +    description: GPIO output to Power Loss Notification (PLN#) signal. This
> > +      signal is use to notify the M.2 card by the host system that the power
> > +      loss event is expected to occur. Refer, PCI Express M.2 Specification
> > +      r4.0, sec 3.2.17.1 for more details.
> > +    maxItems: 1
> > +
> > +  plas3-gpios:
> > +    description: GPIO output to Power Loss Acknowledge (PLA_S3#) signal. This
> 
> GPIO input?
> 

I defined the role from a card PoV, but it should be the other way around, from
the connector/host PoV. In that case, this will become input. I will change
others also.

> > +      signal is used by the M.2 card to notify the host system, the status of
> > +      the M.2 card's preparation for power loss.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - vpcie3v3-supply
> 
> All the GPIOs are really optional?
> 

Yes.

> > +
> > +additionalProperties: false
> > +
> > +examples:
> > +  # PCI M.2 Key M connector for SSDs with PCIe interface
> > +  - |
> > +    connector {
> > +        compatible = "pcie-m2-m-connector";
> > +        vpcie3v3-supply = <&vreg_nvme>;
> > +
> > +        ports {
> > +            #address-cells = <1>;
> > +            #size-cells = <0>;
> > +
> > +            port@0 {
> > +                #address-cells = <1>;
> > +                #size-cells = <0>;
> > +
> > +                reg = <0>;
> > +
> > +                endpoint@0 {
> > +                    reg = <0>;
> > +                    remote-endpoint = <&pcie6_port0_ep>;
> > +                };
> 
> Please make the example as complete as possible.
> 

Okay.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

