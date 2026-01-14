Return-Path: <linux-pci+bounces-44771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 128A8D20205
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 17:16:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6994230621D5
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 16:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3BE3A1E64;
	Wed, 14 Jan 2026 16:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKQ511Jr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CE939E6DB;
	Wed, 14 Jan 2026 16:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768407290; cv=none; b=VF4iR9EXqBs4+vGtWLkQp+ZdXmV61fKrbHQto4bM5NSC+KZzBwqLXm/mMT1O6Y/tOwJne4mbq+pS3R+Czse2JKHkTQSsZanx8iA5I0lXTIeNr6UPRrVL9rSYWqdtnaPXE8QK7r3KpztWmmV90ZGVz7I5czL4LrF82d0/O4FB0oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768407290; c=relaxed/simple;
	bh=GhwmK4FZnhVlKOisYnJ/xfW9wiiV6ZkLJ6q2UyKhx9U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AosAfNUy5JvNTXgs+z8F4vFxGLAR87+HJn9ZsE/1wrcMH3wlGv8eDeV/XeJZu+zw6uDv+YzVSVPatSVMSt6LV2GW4Slf2l/TnvTz8A/VllU7QjXAgBUWFNeGDymUS6qSRTPT64u0+gTQUpdrs/yozCXuRl3DVyW7J50DRyBH0QU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKQ511Jr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838E6C16AAE;
	Wed, 14 Jan 2026 16:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768407289;
	bh=GhwmK4FZnhVlKOisYnJ/xfW9wiiV6ZkLJ6q2UyKhx9U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bKQ511Jr8hxW3LfytH59Yr+E9WefLkWV+CausWBDOm+LAo+t7tHRoHnvv4LJQATsb
	 2T5ZlbgRQkIpS+ejYatUCVVwpZ6QumKRr5w2l58DRwsiyQkkYeGiiPjHH+QYt87SFQ
	 ssxy6VxI1xrxQDFIPxtTDLrVp71ENOiY+Z2e1NhfhOstOVPH2sLvQlIZz9fg2VqmQQ
	 LiIS8OxNJzYNab8i8slpo2vQz6KLhlnqCteaSz6+7xHDriSw0trxyxvY2esu8X1vTp
	 v8IKkdFlsQbzXpWbe+VtYWBC/6VDjEzW25hRiIAZN2uzEA/HtQ3kHM/Ue9U4qJ3zLa
	 uB3kQNRl7/iVQ==
Date: Wed, 14 Jan 2026 21:44:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Message-ID: <xyttom64ht5hrrp5hecjqehnyfgsv4mfl2t36e2sveu44ccpjl@lkzquse2kqsx>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>
 <20260113171424.GA3925312-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113171424.GA3925312-robh@kernel.org>

On Tue, Jan 13, 2026 at 11:14:24AM -0600, Rob Herring wrote:
> On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > devices. Spec also provides an optional interface to connect the UIM card,
> > but that is not covered in this binding.
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
> >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 155 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > new file mode 100644
> > index 000000000000..b65b39ddfd19
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > @@ -0,0 +1,154 @@
> > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: PCIe M.2 Mechanical Key E Connector
> > +
> > +maintainers:
> > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > +
> > +description:
> > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> > +  connector. Mechanical Key E connectors are used to connect Wireless
> > +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > +
> > +properties:
> > +  compatible:
> > +    const: pcie-m2-e-connector
> > +
> > +  vpcie3v3-supply:
> > +    description: A phandle to the regulator for 3.3v supply.
> > +
> > +  vpcie1v8-supply:
> > +    description: A phandle to the regulator for VIO 1.8v supply.
> 
> I don't see any 1.8V supply on the connector. There are 1.8V IOs and you 
> may need something in DT to ensure those are powered. However, there's 
> no guarantee that it's a single supply.
> 

1.8v VIO supply is an optional supply and is only required if the platform
supports 1.8v for sideband signals such as PERST#, WAKE#... I can include it in
the example for completeness.

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
> > +        description: Connector interfaces for Wi-Fi
> > +
> > +        properties:
> > +          endpoint@0:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: PCIe interface
> > +
> > +          endpoint@1:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: SDIO interface
> 
> I think I already said this, but multiple endpoints are generally for 
> something that's muxed. Looking at the connector pinout, PCIe and SDIO 
> are not muxed. So these 2 should be 2 port nodes.
> 

Sorry, I didn't know that you were asking for 2 port nodes. Will switch to it.

> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
> > +          - required:
> > +              - endpoint@1
> > +
> > +      port@1:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: Connector interfaces for BT
> > +
> > +        properties:
> > +          endpoint@0:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: USB 2.0 interface
> > +
> > +          endpoint@1:
> > +            $ref: /schemas/graph.yaml#/properties/endpoint
> > +            description: UART interface
> 
> And UART and USB are not muxed either.
> 

Ack.

> 
> > +
> > +        anyOf:
> > +          - required:
> > +              - endpoint@0
> > +          - required:
> > +              - endpoint@1
> > +
> > +      port@2:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: PCM/I2S interface
> > +
> > +      i2c-parent:
> > +        $ref: /schemas/types.yaml#/definitions/phandle
> > +        description: I2C interface
> 
> Move out of 'ports'.
> 

Ack.

> > +
> > +    oneOf:
> > +      - required:
> > +          - port@0
> > +
> > +  clocks:
> > +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> > +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> > +      more details.
> > +    maxItems: 1
> > +
> > +  w-disable1-gpios:
> > +    description: GPIO input to W_DISABLE1# signal. This signal is used by the
> > +      system to disable WiFi radio in the M.2 card. Refer, PCI Express M.2
> > +      Specification r4.0, sec 3.1.12.3 for more details.
> > +    maxItems: 1
> > +
> > +  w-disable2-gpios:
> > +    description: GPIO input to W_DISABLE2# signal. This signal is used by the
> > +      system to disable WiFi radio in the M.2 card. Refer, PCI Express M.2
> > +      Specification r4.0, sec 3.1.12.3 for more details.
> > +    maxItems: 1
> > +
> > +  viocfg-gpios:
> > +    description: GPIO output to IO voltage configuration (VIO_CFG) signal. This
> > +      signal is used by the M.2 card to indicate to the host system that the
> > +      card supports an independent IO voltage domain for the sideband signals.
> > +      Refer, PCI Express M.2 Specification r4.0, sec 3.1.15.1 for more details.
> > +    maxItems: 1
> 
> What about SDIO and UART WAKE, SDIO RESET, and vendor defined signals?
> 

Not sure about vendor defined signals as they can be either GPIO or interface
signals. How should them be defined?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

