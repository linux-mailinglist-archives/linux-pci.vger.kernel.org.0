Return-Path: <linux-pci+bounces-43771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C5B5CE51C0
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 16:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0584230079DB
	for <lists+linux-pci@lfdr.de>; Sun, 28 Dec 2025 15:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5532C375E;
	Sun, 28 Dec 2025 15:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQZooQVx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A771D9346;
	Sun, 28 Dec 2025 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766934773; cv=none; b=fXUc4lIi8LJ/TuTMS6ZgYUW724q5QeZHeFk9gMfqyaNAdu9KjZFwF8bOO/dsEw9H9xiPnTFNUEe+veiMDWrRlkcW70soHx5rmQGbnOoC75WUuIFxaEPQrZeJJNY0tPLEO4n+dF2tdMc0nGMaAD6Z882sWQBf577oaPpKR8HdTqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766934773; c=relaxed/simple;
	bh=EDu/GDrPT0wUm4p/vTK1dNE20NpwGpBmbNK9l0wcXMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cUTwKDmyQfBTYiY00QlXzao+VncqOdf6/yvivYeZo/MR5eO8nMuMD+8xkQMO3d34iXbjDT4NTsZ46rnszmqvTEI9ui+VJ7X3xDtbowTxaV8u/AkTMve0hd4dz9prCkzYkTfw0xzXuCs1L55jXezDTzeh/o4JulajZkyKdyffrEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQZooQVx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D612C4CEFB;
	Sun, 28 Dec 2025 15:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766934773;
	bh=EDu/GDrPT0wUm4p/vTK1dNE20NpwGpBmbNK9l0wcXMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQZooQVx2hYhrsl11ZcpKJn7DTOSn6S330pTqIASskge1EAaB9lXt/CV9+GXRur1t
	 0R6ouhU30pyKoUpIikUNE4MF+MlwNU/JqmWKdZY785lciUUrefsmFsmdgFuxqW4RyR
	 twdZ2RneWhNgz5HRKIwRV4VtM7zfIh9Tg1oXjP7DiyjhRUByhqr3boxoueK9tmQLj6
	 JX27OEwt8ae8Swksf+pTW+ABx8U1DPpGXMVwMxeZfKfi/8/4Us8mhnREYl5YkCBtmL
	 8zWLaq2H/j9xd6uQf6kFIuxycHt7GLz6CDJCEnYpwefB4z/uc6WCNE8s7xynChZkMH
	 7TdxBUKaGl0rw==
Date: Sun, 28 Dec 2025 20:42:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-pm@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <w773lfwggdemfitkwc2goh3odyzqo3vxbajzjlulum7i6trdsh@6izf6ajlr2ss>
References: <20251125-pci-m2-v3-0-c528042aea47@oss.qualcomm.com>
 <20251125-pci-m2-v3-1-c528042aea47@oss.qualcomm.com>
 <20251208191110.GA2473021-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208191110.GA2473021-robh@kernel.org>

On Mon, Dec 08, 2025 at 01:11:10PM -0600, Rob Herring wrote:
> On Tue, Nov 25, 2025 at 04:42:26PM +0530, Manivannan Sadhasivam wrote:
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
> > Reviewed-by: Frank Li <Frank.Li@nxp.com>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-m-connector.yaml    | 141 +++++++++++++++++++++
> >  1 file changed, 141 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > new file mode 100644
> > index 000000000000..f65a05d93735
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-m-connector.yaml
> > @@ -0,0 +1,141 @@
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
> 
> 
> Where's the binding changes to allow graph nodes on SATA and PCIe 
> bindings? I suppose Thunderbolt/USB4 on USB-C connectors will need that 
> too.
> 

Raised dtschema PR for PCI [1] and added SATA binding change in v4. For
Thunderbolt/USB4, there is no schema as of now. So skipping it until one gets
added.

[1] https://github.com/devicetree-org/dt-schema/pull/180

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
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: SMB interface
> 
> SMB is SMBus? There's no graph support for I2C either. For that, we use 
> 'i2c-parent'.
> 

Ack.

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
> 
> Instead of 'controlled connection' use just input or output. Arguably an 
> input isn't GPIO controlled.
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

