Return-Path: <linux-pci+bounces-44653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 175EBD1A91C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D0A6B306526C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87515350D52;
	Tue, 13 Jan 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ceqS5wOJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A702E9749;
	Tue, 13 Jan 2026 17:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768324562; cv=none; b=V7ob23fv6HLs2EF74dt+DS+wIiD/d24Drs/JbAszUFQ10ZRty1JOJkxqNLQ4FomGaxlzB5tYi3bC08V7kgMtTji3VEP7BxlMh+YJoV51YGsFP+KMAyyg1EOikY30gsNVwJXuT7gkhlx93UJHvsHcXp9QD274Dr0jMLTnV7R4FAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768324562; c=relaxed/simple;
	bh=sBc6VAi4e2uXwVmEHe+k/tZ/kE1s+VqQvdAg/NmnaE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PCaYV/FmwqumryvhKom+KxIftHnCeZLmeMRX7lU+1CjdkzQks95wLdPaQS+Eif1u3vwOYkN4cpfNl2GKk3LFLhspVQC65ToZWPb6zFVRGoyf8AuX+saEeA4xJX8u2SK1FT44rVF9SkGwzabqXSPtunpVPV0HG1idd3eYrgyAfw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceqS5wOJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA8C116C6;
	Tue, 13 Jan 2026 17:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768324562;
	bh=sBc6VAi4e2uXwVmEHe+k/tZ/kE1s+VqQvdAg/NmnaE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ceqS5wOJhyhHKTzNPr1OEjs7fqfGGIs7pzNIjMVapws6zbIGxavQvGAtw2l2qde36
	 h2F37eL7yNqGjI+mmdISQDml2pETMveJehHQUrolcajvhFGjdn4DG5iri0084G8MaV
	 qaaE3/fg+y5VXZvUZRCdZXZwk2YrLFOVa/ozNZdxOo1ahh5AdklyNoEKRITwnD35v4
	 kvTpumKpjV02yoCp+c9kyZEu0kFp3bUdPNYbuYd6EYsZ9ZZ9ubmZxU3lsOkxsrhMNF
	 c18Y+97gwM8TnjQpUZbzO9mzXoefBUZLdlbycP7Yw7Ovs28JVjRtiCS9QFBIls6mXS
	 V54v/GeMHL4FQ==
Date: Tue, 13 Jan 2026 11:16:01 -0600
From: Rob Herring <robh@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Hans de Goede <hansg@kernel.org>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	"Derek J. Clark" <derekjohn.clark@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
	linux-acpi@vger.kernel.org
Subject: Re: [PATCH v4 5/9] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key E connector
Message-ID: <20260113171601.GB3925312-robh@kernel.org>
References: <20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qualcomm.com>
 <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-pci-m2-e-v4-5-eff84d2c6d26@oss.qualcomm.com>

On Mon, Jan 12, 2026 at 09:56:04PM +0530, Manivannan Sadhasivam wrote:
> Add the devicetree binding for PCIe M.2 Mechanical Key E connector defined
> in the PCI Express M.2 Specification, r4.0, sec 5.1.2. This connector
> provides interfaces like PCIe or SDIO to attach the WiFi devices to the
> host machine, USB or UART+PCM interfaces to attach the Bluetooth (BT)
> devices. Spec also provides an optional interface to connect the UIM card,
> but that is not covered in this binding.
> 
> The connector provides a primary power supply of 3.3v, along with an
> optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> 1.8v sideband signaling.
> 
> The connector also supplies optional signals in the form of GPIOs for fine
> grained power management.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  .../bindings/connector/pcie-m2-e-connector.yaml    | 154 +++++++++++++++++++++
>  MAINTAINERS                                        |   1 +
>  2 files changed, 155 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> new file mode 100644
> index 000000000000..b65b39ddfd19
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/connector/pcie-m2-e-connector.yaml
> @@ -0,0 +1,154 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/connector/pcie-m2-e-connector.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: PCIe M.2 Mechanical Key E Connector
> +
> +maintainers:
> +  - Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> +
> +description:
> +  A PCIe M.2 E connector node represents a physical PCIe M.2 Mechanical Key E
> +  connector. Mechanical Key E connectors are used to connect Wireless
> +  Connectivity devices including combinations of Wi-Fi, BT, NFC to the host
> +  machine over interfaces like PCIe/SDIO, USB/UART+PCM, and I2C.
> +
> +properties:
> +  compatible:
> +    const: pcie-m2-e-connector
> +
> +  vpcie3v3-supply:
> +    description: A phandle to the regulator for 3.3v supply.
> +
> +  vpcie1v8-supply:
> +    description: A phandle to the regulator for VIO 1.8v supply.
> +
> +  ports:

Also, nodes go after all properties.

> +    $ref: /schemas/graph.yaml#/properties/ports
> +    description: OF graph bindings modeling the interfaces exposed on the
> +      connector. Since a single connector can have multiple interfaces, every
> +      interface has an assigned OF graph port number as described below.

