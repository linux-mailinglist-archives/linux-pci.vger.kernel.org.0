Return-Path: <linux-pci+bounces-41783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 82958C740EE
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:57:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EE93635A918
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 12:57:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE1D337B90;
	Thu, 20 Nov 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U6dAjwAN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5682DD60F;
	Thu, 20 Nov 2025 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763643454; cv=none; b=m2mUAPJ3vYnGYESM0Uyj+mUuQtU+kTNijvjfkJua/+ciXW3fShrMHK07rYXZdwaaHjxUed8zNcAPmYcxbwXWY4znDxpiVCIcKNC32xQqFrIs18aAuMcyCpCsUysRo9Re+w0HTKIXjYApwwCN6zfmO1tufSvkRmF++nUltAmQdec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763643454; c=relaxed/simple;
	bh=BSAJnV6hGwIlrdf26TVWYrTtWavqRfw5o5IS/pX+paY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Agz7etuS7gI0daIhRzKUf+hysz9lnjEdi8VozmiOlKQLNI7AHGn/SJsWE5D/YObVYIkzjvGlRPknXw4wDi3SIiDTivCcYA/UL9Hk9XC2iG+uxjL0+KExfgtWRaEhp96ZPhvJTO3pC7N1e5YrMha8FWQb03Mg22Ff7d3Ern18Qy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U6dAjwAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35235C4CEF1;
	Thu, 20 Nov 2025 12:57:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763643454;
	bh=BSAJnV6hGwIlrdf26TVWYrTtWavqRfw5o5IS/pX+paY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U6dAjwANw4n/6ZVjJ+Seqdabz28l0Onx7duGdEvU7ZZtHs5Hc8Ggfu7Z0js38Nx86
	 diRyJUNdPGO+7TgPQMXk/o6MQigTi+HXCP5LV7yM4EqH8cQCrWMB1ZLvS2ZCjul6G5
	 Lms68eWAqPWHkzqprGdEz+wxr/CwjlnDd9HyU0Ehj9fPavXce0DbENY3r53MXvia8p
	 8cKtJTZFsjfNItIpdoD8iPrfj/ikp/MKUNpbzbfjmPUGTMC6ggVjznVJbNbc0MS3Lj
	 zzsNZ78ijnO+25UNbWxxvGaLb9H4AMxQNir5Xr5f3xShPNl56yyA9ajVlBr1ROb2SZ
	 M1kOF05OwM0wQ==
Date: Thu, 20 Nov 2025 18:27:06 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Rob Herring <robh@kernel.org>
Cc: Frank Li <Frank.li@nxp.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Mark Pearson <mpearson-lenovo@squebb.ca>, 
	"Derek J. Clark" <derekjohn.clark@gmail.com>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH 7/9] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 E connector
Message-ID: <2dtqb5cpuhb4ln3vfuudortjesrcamwpokkcwoih6gz7u25rxr@mgtdturwyhq3>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com>
 <aRS/3OTerCBGlmBm@lizhi-Precision-Tower-5810>
 <qiwgnela4b6gbwuuq7xaqjong47c2ix6caagjl6ryqukzqkswn@6l7rvkf4dfyx>
 <20251119235905.GA3575788-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119235905.GA3575788-robh@kernel.org>

On Wed, Nov 19, 2025 at 05:59:05PM -0600, Rob Herring wrote:
> On Thu, Nov 13, 2025 at 10:30:42AM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Nov 12, 2025 at 12:11:56PM -0500, Frank Li wrote:
> > > On Wed, Nov 12, 2025 at 08:15:19PM +0530, Manivannan Sadhasivam wrote:
> > > > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > > > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > > > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > > > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > > > devices along with additional interfaces like I2C for NFC solution. At any
> > > > point of time, the connector can only support either PCIe or SDIO as the
> > > > WiFi interface and USB or UART as the BT interface.
> > > >
> > > > The connector provides a primary power supply of 3.3v, along with an
> > > > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > > > 1.8v sideband signaling.
> > > >
> > > > The connector also supplies optional signals in the form of GPIOs for fine
> > > > grained power management.
> > > >
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > ---
> > > >  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
> > > >  MAINTAINERS                                        |   1 +
> > > >  2 files changed, 155 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > > > new file mode 100644
> > > > index 0000000000000000000000000000000000000000..91cb56b1a75b7e3de3b9fe9a7537089f96875746
> > > > --- /dev/null
> > > > +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> > > > @@ -0,0 +1,154 @@
> > > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > > +%YAML 1.2
> > > > +---
> > > > +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> > > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > > +
> > > > +title: PCIe M.2 Mechanical Key E Connector
> > > > +
> > > > +maintainers:
> > > > +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > > > +
> > > > +description:
> > > > +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> > > > +  connector. Mechanical Key E connectors are used to connect Wireless
> > > > +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> > > > +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> > > > +
> > > > +properties:
> > > > +  compatible:
> > > > +    const: pcie-m2-e-connector
> > > > +
> > > > +  vpcie3v3-supply:
> > > > +    description: A phandle to the regulator for 3.3v supply.
> > > > +
> > > > +  vpcie1v8-supply:
> > > > +    description: A phandle to the regulator for VIO 1.8v supply.
> > > > +
> > > > +  ports:
> > > > +    $ref: /schemas/graph.yaml#/properties/ports
> > > > +    description: OF graph bindings modeling the interfaces exposed on the
> > > > +      connector. Since a single connector can have multiple interfaces, every
> > > > +      interface has an assigned OF graph port number as described below.
> > > > +
> > > > +    properties:
> > > > +      port@0:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: PCIe/SDIO interface
> > > 
> > > 
> > > PCIe and SDIO is difference signal at key E. why combine to one port? The
> > > similar case is USB2.0/UART
> > > 
> > 
> > They will be defined as separate endpoints in the next version.
> > 
> > > > +
> > > > +      port@1:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: USB 2.0/UART interface
> > > > +
> > > > +      port@2:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: PCM/I2S interface
> > > > +
> > > > +      port@3:
> > > > +        $ref: /schemas/graph.yaml#/properties/port
> > > > +        description: I2C interface
> > > > +
> > > > +    oneOf:
> > > > +      - required:
> > > > +          - port@0
> > > > +
> > > > +  clocks:
> > > > +    description: 32.768 KHz Suspend Clock (SUSCLK) input from the host system to
> > > > +      the M.2 card. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.1 for
> > > > +      more details.
> > > > +    maxItems: 1
> > > 
> > > Do we need add pciref clock here?
> > > 
> > > > +
> > > > +  w_disable1-gpios:
> > > 
> > > use "-"
> > > 
> > > w-disable1-gpios
> > > 
> > 
> > I just went with the spec that defines the signal as W_DISABLE.
> > 
> > > > +    description: GPIO controlled connection to W_DISABLE1# signal. This signal
> > > > +      is used by the system to disable WiFi radio in the M.2 card. Refer, PCI
> > > > +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> > > > +    maxItems: 1
> > > > +
> > > > +  w_disable2-gpios:
> > > > +    description: GPIO controlled connection to W_DISABLE2# signal. This signal
> > > > +      is used by the system to disable BT radio in the M.2 card. Refer, PCI
> > > > +      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
> > > > +    maxItems: 1
> > > > +
> > > > +  led1-gpios:
> > > > +    description: GPIO controlled connection to LED_1# signal. This signal is
> > > > +      used by the M.2 card to indicate the card status via the system mounted
> > > > +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> > > > +      details.
> > > > +    maxItems: 1
> > > > +
> > > > +  led2-gpios:
> > > > +    description: GPIO controlled connection to LED_2# signal. This signal is
> > > > +      used by the M.2 card to indicate the card status via the system mounted
> > > > +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> > > > +      details.
> > > > +    maxItems: 1
> > > > +
> > > > +  viocfg-gpios:
> > > > +    description: GPIO controlled connection to IO voltage configuration
> > > > +      (VIO_CFG) signal. This signal is used by the M.2 card to indicate to the
> > > > +      host system that the card supports an independent IO voltage domain for
> > > > +      the sideband signals. Refer, PCI Express M.2 Specification r4.0, sec
> > > > +      3.1.15.1 for more details.
> > > > +    maxItems: 1
> > > > +
> > > > +  uim_power_src-gpios:
> > > 
> > > property use -
> > > 
> > 
> > Again, this is as per the spec. If DT maintainers object to it, I'll change it.
> 
> Use '-'.
> 

OK!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

