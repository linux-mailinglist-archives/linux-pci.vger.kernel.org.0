Return-Path: <linux-pci+bounces-43828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9556CE8F9C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 09:08:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B9AEA300B69A
	for <lists+linux-pci@lfdr.de>; Tue, 30 Dec 2025 08:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 191D22FDC35;
	Tue, 30 Dec 2025 08:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kOHCLkeX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D302F7AD0;
	Tue, 30 Dec 2025 08:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767082089; cv=none; b=h52I++pA0so+1Ke63M5mUlWzjvz3IHEiPJHzpiX20rUiIKHHd4IOITWxN2ilQ/N1n8zxYvUbNDsQkD33eHMbiBxbSSuLPEFoSCqflD1VGVQVWqbJpdf2yBLNrUtN/T836gZWpFPKpmZPCKt8UTVIcIaYDIV1MluLVDzICTXxvZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767082089; c=relaxed/simple;
	bh=MAuT6kX2skfD9THyyWJ8LQ+yulvGn9NW41sVqxts1yU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8XMcJmtcYKmHuZnSsFciQgXE1C/tzoNPdsbyQ7dPQx83iDUFDUbQoa7uv5z0cpA8G5pcaYUHdZjl1F0e7YxiVoarc+n7MVo4yIo0MTCezcnu/4F+5exd9Ykk4QACmIKmNKu9Pvfgu3j7Q5LnoRfBaVdy8dxmUEb/k7sQZCUFWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kOHCLkeX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8A6C4CEFB;
	Tue, 30 Dec 2025 08:07:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767082087;
	bh=MAuT6kX2skfD9THyyWJ8LQ+yulvGn9NW41sVqxts1yU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kOHCLkeXIr4bMGx1yxcUVL5o1PBdStGGwyn2LajtcvnSSeXgcRcHOR7Zdava2vEtv
	 J25tvmXiD8azlKs/HBLeJVvEyUmOSYVejGKK/RxBCmiR87kHQ9rHo4xFVjsBjvakHY
	 j5gFGpc+bQnN3A9ZlyfVH38tejNsIYtM4kpKTX/ccoZK0fgfpltEJPzsWxVKBRkJZh
	 YDT6LUGXTzRQ1Vj1lJtcvoBgY/NpxwfkaUHXvqabhW7o/S4/S3WHFz97ex/XlhTCMB
	 gR2a+BkIDRFsx213PKYRZ43IZyM1MVx8TgDyEBqCqBljxDTlj74sfHE8SzgBMxJHM4
	 uxsPVfOvCxfUg==
Date: Tue, 30 Dec 2025 13:37:56 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v2 08/10] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Message-ID: <2fyzwqr5cvkzkkgu5dk6qbc6o2dhnrtt22lf37rv6jzwtmbrek@yhedhlvzpzw7>
References: <20251125-pci-m2-e-v2-0-32826de07cc5@oss.qualcomm.com>
 <20251125-pci-m2-e-v2-8-32826de07cc5@oss.qualcomm.com>
 <20251208202803.GA2541017-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251208202803.GA2541017-robh@kernel.org>

On Mon, Dec 08, 2025 at 02:28:03PM -0600, Rob Herring wrote:
> On Tue, Nov 25, 2025 at 08:15:12PM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > devices along with additional interfaces like I2C for NFC solution. At any
> > point of time, the connector can only support either PCIe or SDIO as the
> > WiFi interface and USB or UART as the BT interface.
> 
> AFAICT, there's no muxing of interfaces. Maybe that's a defacto 
> limitation on x86 systems? There's no reason to encode that into the 
> binding if the pins aren't mux'ed on the connector.
> 

Ok. If you prefer not to describe the MUX (if one exists outside of the
connector) in the binding, then having one endpoint sounds reasonable.

You did raise this point in the other series, but the conversation was not
concluded: https://lore.kernel.org/linux-pci/20251119235614.GA3566558-robh@kernel.org/

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
> >  .../bindings/connector/pcie-m2-e-connector.yaml    | 178 +++++++++++++++++++++
> >  MAINTAINERS                                        |   1 +
> >  2 files changed, 179 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > new file mode 100644
> > index 000000000000..fe2c9a943a21
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > @@ -0,0 +1,178 @@
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
> 
> Does this work with any existing DAI bindings? Or conflict with the 
> audio graph card binding?
> 

I haven't verified with any sound card, but it looks to be compatible with the
existing audio graph card binding.

> > +
> > +      port@3:
> > +        $ref: /schemas/graph.yaml#/properties/port
> > +        description: I2C interface
> 
> Like the other one, use i2c-parent.
> 

Ack.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

