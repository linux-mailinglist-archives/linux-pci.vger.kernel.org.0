Return-Path: <linux-pci+bounces-41056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F77C55C30
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 06:07:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0A1284E2B5D
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 05:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 298A82C0F71;
	Thu, 13 Nov 2025 05:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IKFnmi8k"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A892206B1;
	Thu, 13 Nov 2025 05:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763010367; cv=none; b=g3IYUbLzry7Y2Qnhr0fXo+bTL5u9dBDs/Jq3Llr+BZo3UDgygLqfSbU/lXWZA9Vm5SPX7s7lg7Z3CGhOUiXQBgjY1PxdbWlk9JtLfrKNM6fRXGKZ1pA6v/2gkp1pTPe8CpoHxzHmTxFM3kYGimvXs2uxZnj3Gr/+lbVWNMSOofY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763010367; c=relaxed/simple;
	bh=lmFEIO+FTlALqETVG4s9zKtGVmA3KisKqKNts7GmV/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=atetdWvuEc8SNxcSozP6YYWI3+KYpV7X7MwclMxX+PMpsaRqWe9NCRufqME8f11uX7fCpq2FefSqwFrAq8G/04b3zgyp1U4Eje5W4+T2mVEDEuCnx0r2awqYN+jhL7bUwqnCReP5GzWLOCXoVoH+/z/mzDM26LiNpvGVmpABQ1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IKFnmi8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB1AFC19421;
	Thu, 13 Nov 2025 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763010364;
	bh=lmFEIO+FTlALqETVG4s9zKtGVmA3KisKqKNts7GmV/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IKFnmi8krDCishqGq+XkYTFxcp1Ltwc2ixWwd/VwE6mo/oy3F9TQipbl2enEDj9vz
	 WtgRLq3n3jwX3y8fEWutGtpCWdwC4A5Y0dsJNClcChJTQa6JWdojqqa1dhW7SWlyiw
	 WLv1gJvFj2HroeByWrsRHYHDJmoFAZ7faVi7S5OMl7RT0tOSH63EZErA8++H8b2E98
	 nA2Zwpal40DC0QWP8EB9sDq44Of+dqArF1Wtx9842iGGTcbuCshLutyZ1CprzALfXN
	 llJfproSgc/Y9v+FT3nneBRtKiPyMh7HCIs8de7k+IegQAMfL10o0JwuaPFmwIYTKu
	 /KpAQ80zqhBNA==
Date: Thu, 13 Nov 2025 10:35:38 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>
Subject: Re: [PATCH 7/9] dt-bindings: connector: Add PCIe M.2 Mechanical Key
 E connector
Message-ID: <dpemyc5l44alocdtbntnocwzfx3hdrppcf2dwhwasxx5v7zfku@hr6whu6siapm>
References: <20251112-pci-m2-e-v1-0-97413d6bf824@oss.qualcomm.com>
 <20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com>
 <t45yq2cqj2t7lv4ifnvv556ewznjtzhdvvmofzgb5kcsarydqe@hxtonnejw6t7>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <t45yq2cqj2t7lv4ifnvv556ewznjtzhdvvmofzgb5kcsarydqe@hxtonnejw6t7>

On Wed, Nov 12, 2025 at 10:08:57PM +0200, Dmitry Baryshkov wrote:
> On Wed, Nov 12, 2025 at 08:15:19PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> > provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> > host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> > devices along with additional interfaces like I2C for NFC solution. At any
> > point of time, the connector can only support either PCIe or SDIO as the
> > WiFi interface and USB or UART as the BT interface.
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
> > index 0000000000000000000000000000000000000000..91cb56b1a75b7e3de3b9fe9a7537089f96875746
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
> > +        description: PCIe/SDIO interface
> 
> The same comment as for the M-key bindings: please describe endpoints.
> 

Sure.

> > +  led1-gpios:
> > +    description: GPIO controlled connection to LED_1# signal. This signal is
> > +      used by the M.2 card to indicate the card status via the system mounted
> > +      LED. Refer, PCI Express M.2 Specification r4.0, sec 3.1.12.2 for more
> > +      details.
> 
> How are we supposed to handle these LEDs? I have been assuming that
> these pins should go striaght to the LED driver.
> 

Yes. I should just drop these.

> > +    maxItems: 1
> > +
> > +  led2-gpios:
> > +    description: GPIO controlled connection to LED_2# signal. This signal is
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
> 
> This more looks like viocfg-supply. Looking at this one and several
> other pins, it's more like a GPIO controller, providing those pins for
> the system, rather than a GPIO consumer.
> 

It is not a supply, but rather an indicator to the host. If it is low, then it
indicates that the card supports 3.3V on the sideband IO signals.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

