Return-Path: <linux-pci+bounces-40990-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A530C52DC6
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 16:00:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECD9242099D
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B585E2BE629;
	Wed, 12 Nov 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dw0VKRkz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80AEE29BD8C;
	Wed, 12 Nov 2025 14:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762957995; cv=none; b=nn+35eYLJ/3VJGxKBDQ15PjmWIhDFdkE3H354CUBljgmsj4lfjXQYhtZDkve7LSiREdNV8xZKeDe30boND2GC4gcfKS/OU19ZvZ7J93p9zzougUz7rHBZ013xWLdwZ2/vNK7vFpC+RodpATrnOQPsvJ1TwEBA23OaMjPwU/LGm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762957995; c=relaxed/simple;
	bh=xNPujgryql6NE1nmuYqPQclc1RsNGksmNqPxvx+Dxc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eq4H/0cY8Ea5PHHBQOUNCGABFqfdngvhar+GX5oZPAwIhTchtGXdZNdkJzdBK1y5gk4Ff/buUvkegSCKVOWc0EhCWyAjWzBb/5uleNjroDmn5u641IjSi+1CfKHXgYwuBNc/3ls1rbvhf+RJYyqzIouIGF2DQJazOp7E9k9eXqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dw0VKRkz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42BE2C4CEF5;
	Wed, 12 Nov 2025 14:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762957995;
	bh=xNPujgryql6NE1nmuYqPQclc1RsNGksmNqPxvx+Dxc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Dw0VKRkzEeyOVmyCldKX8cSronjdlWxII80P9zpYOTsoFn8LHlx1DO4/NYJ6cch3J
	 W+cuBeIXQSAmUFFZTm2c2D/noiKkuJrp48Z9U8tQB4B378K17ZNgbTBN5rvuPVGoQh
	 oIJYsqrnpPvtRwd/e8uYoqsy0uNlZoNX2PAQXiNb1FGgnErJ9qrBBcxVgKsgKyrfDq
	 01oLCCwk9EYIJ/h4Wzj0yA3D1u7RJQXoLz16h5E9asw80Q+6p0RWpqW7KP1wAFuAXf
	 8KJaKSFOG38bgg0yLTDepBuwf+Xa1SODwPL1os4c3hNjmRIEZf1QeqOO20Dc7pHATv
	 IOigkjYvZtDAQ==
Date: Wed, 12 Nov 2025 20:03:01 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <aj4u7j5pvm4aebyn66lq5yt3e7myvybbp7cyr22jukr4eh4lzf@d356d4b26mjm>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
 <20251112035717.GA3363355@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251112035717.GA3363355@google.com>

On Wed, Nov 12, 2025 at 11:57:17AM +0800, Chen-Yu Tsai wrote:
> On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> > provides interfaces like PCIe and SATA to attach the Solid State Drives
> > (SSDs) to the host machine along with additional interfaces like USB, and
> > SMB for debugging and supplementary features. At any point of time, the
> > connector can only support either PCIe or SATA as the primary host
> > interface.
> > 
> > The connector provides a primary power supply of 3.3v, along with an
> > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > 1.8v sideband signaling.
> > 
> > The connector also supplies optional signals in the form of GPIOs for fine
> > grained power management.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > new file mode 100644
> > index 0000000000000000000000000000000000000000..be0a3b43e8fd2a2a3b76cad4808ddde79dceaa21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > @@ -0,0 +1,122 @@
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
> > +  interfaces like USB, SMB.
> > +
> > +properties:
> > +  compatible:
> > +    const: pcie-m2-m-connector
> > +
> > +  vpcie3v3-supply:
> > +    description: A phandle to the regulator for 3.3v supply.
> > +
> > +  vio1v8-supply:
> > +    description: A phandle to the regulator for VIO 1.8v supply.
> 
> FYI I just added vpcie1v8-supply to the core DT schema [1]. vpcie1v8
> instead of vio1v8 was requested by Rob.
> 

Ok, thanks for doing it. I will change the property name in v3 and in the
follow-up series.

- Mani

> [1] https://github.com/devicetree-org/dt-schema/pull/176
> 
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
> > +        description: PCIe/SATA interface
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: USB interface
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: SMB interface
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
> > +    description: GPIO controlled connection to PEDET signal. This signal is used
> > +      by the host systems to determine the communication protocol that the M.2
> > +      card uses; SATA signaling (low) or PCIe signaling (high). Refer, PCI
> > +      Express M.2 Specification r4.0, sec 3.3.4.2 for more details.
> > +    maxItems: 1
> > +
> > +  led1-gpios:
> > +    description: GPIO controlled connection to LED_1# signal. This signal is
> > +      used by the M.2 card to indicate the card status via the system mounted
> > +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> > +      details.
> > +    maxItems: 1
> > +
> > +  viocfg-gpios:
> > +    description: GPIO controlled connection to IO voltage configuration
> > +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> > +      host system that the card supports an independent IO voltage domain for
> > +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> > +      3.1.15.1 for more details.
> > +    maxItems: 1
> > +
> > +  pwrdis-gpios:
> > +    description: GPIO controlled connection to Power Disable (PWRDIS) signal.
> > +      This signal is used by the host system to disable power on the M.2 card.
> > +      Refer, PCI Express M.2 Specification r4.0, sec 3.3.5.2 for more details.
> > +    maxItems: 1
> > +
> > +  pln-gpios:
> > +    description: GPIO controlled connection to Power Loss Notification (PLN#)
> > +      signal. This signal is use to notify the M.2 card by the host system that
> > +      the power loss event is expected to occur. Refer, PCI Express M.2
> > +      Specification r4.0, sec 3.2.17.1 for more details.
> > +    maxItems: 1
> > +
> > +  plas3-gpios:
> > +    description: GPIO controlled connection to Power Loss Acknowledge (PLA_S3#)
> > +      signal. This signal is used by the M.2 card to notify the host system, the
> > +      status of the M.2 card's preparation for power loss.
> > +    maxItems: 1
> > +
> > +required:
> > +  - compatible
> > +  - vpcie3v3-supply
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
> > +                reg = <0>;
> > +
> > +                endpoint {
> > +                    remote-endpoint = <&pcie6_port0_ep>;
> > +                };
> > +            };
> > +        };
> > +    };
> > 
> > -- 
> > 2.48.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

