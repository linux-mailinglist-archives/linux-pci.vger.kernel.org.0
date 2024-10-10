Return-Path: <linux-pci+bounces-14123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FEA997AAE
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:47:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6175E1C218B6
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 02:47:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C4F17DE2D;
	Thu, 10 Oct 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdr2eS+T"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7A3716D;
	Thu, 10 Oct 2024 02:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528467; cv=none; b=JvSGTqoyCAtYBrU94uE5rjS4xA6LieEnrBnHzDORhDXdI3GCwPrTt3ugLOHOtxRJXrseP2E5c+PCCqLCK+HrsQTpgAdPR42Um/X4ZXPhvbUMqj5oT2VBsVwals1oBSg0sxT26GR/H6ogbn0nqq//yWRyAal8IEzJS/DkVZHr/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528467; c=relaxed/simple;
	bh=6WLgWNCrCh4822VnUA7GiiBuo+86qYoquXQRf55qHZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1Nl52z2R1mNRhoIobmHRyY9P8gkh40cjTFKLX+Vqc2SgrZH6vsoJAtUz0rSXwVrgzbkpD2UYAMnwdXujlyu+536egiM2NIqZyrE305jA5hgQTNSw9nv+cJD2i53WQ6I6adwWIdLj8wNfgc8xLvsE3o/SgsEC+pf6zFyn/CN/DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdr2eS+T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF519C4CEC3;
	Thu, 10 Oct 2024 02:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528467;
	bh=6WLgWNCrCh4822VnUA7GiiBuo+86qYoquXQRf55qHZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sdr2eS+Tty9SXjErOKfQ05zgJjyr219MwPcl9eOnrYlZOOLAF9aORakcj6JrrAj3E
	 JQAQ9K8b2KF11qCiTlgTfQsDFTUdgX2tB7mK+9qBImyMsyHWUsW/ZqVS0vN+1D0o4K
	 Ew5NKXUQUElp4tVek+nowptRnZs8OsEerDbVTK4/ziO/LA1XyRtBX2NQs5JMdtyRra
	 rI1IXPNAsqeYG7aYD/x63vtrBqDepXyiwMqTZnrtEwoFaTS/BIJSQ+5qnQnEjoN21I
	 ncs2Jn2b0+UYvGaypJCwPGChwUneHt3YnfEnVoYkPsnLyn5xrLbZoiZq6YCSiTExwQ
	 l/0QwZCD0JfLA==
Date: Wed, 9 Oct 2024 21:47:46 -0500
From: Rob Herring <robh@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 03/14] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <20241010024746.GA978628-robh@kernel.org>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:46PM +0200, Andrea della Porta wrote:
> Common YAML schema for devices that exports internal peripherals through
> PCI BARs. The BARs are exposed as simple-buses through which the
> peripherals can be accessed.
> 
> This is not intended to be used as a standalone binding, but should be
> included by device specific bindings.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/pci/pci-ep-bus.yaml   | 69 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 70 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> new file mode 100644
> index 000000000000..9d7a784b866a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> @@ -0,0 +1,69 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common properties for PCI MFD endpoints with peripherals addressable from BARs.
> +
> +maintainers:
> +  - Andrea della Porta  <andrea.porta@suse.com>
> +
> +description:
> +  Define a generic node representing a PCI endpoint which contains several sub-
> +  peripherals. The peripherals can be accessed through one or more BARs.
> +  This common schema is intended to be referenced from device tree bindings, and
> +  does not represent a device tree binding by itself.
> +
> +properties:
> +  "#address-cells":
> +    const: 3
> +
> +  "#size-cells":
> +    const: 2
> +
> +  ranges:
> +    minItems: 1
> +    maxItems: 6
> +    items:
> +      maxItems: 8
> +      additionalItems: true
> +      items:
> +        - maximum: 5  # The BAR number
> +        - const: 0
> +        - const: 0
> +
> +patternProperties:
> +  "^pci-ep-bus@[0-5]$":
> +    $ref: '#/$defs/pci-ep-bus'

This should just be:

additionalProperties: true

properties:
  compatible:
    const: simple-bus

required:
  - compatible

Then the compatible will cause simple-bus.yaml to be applied to this 
node.

> +    description:
> +      One node for each BAR used by peripherals contained in the PCI endpoint.
> +      Each node represent a bus on which peripherals are connected.
> +      This allows for some segmentation, e.g. one peripheral is accessible
> +      through BAR0 and another through BAR1, and you don't want the two
> +      peripherals to be able to act on the other BAR. Alternatively, when
> +      different peripherals need to share BARs, you can define only one node
> +      and use 'ranges' property to map all the used BARs.
> +
> +required:
> +  - ranges
> +  - '#address-cells'
> +  - '#size-cells'
> +
> +$defs:
> +  pci-ep-bus:
> +    type: object
> +    additionalProperties: true
> +    properties:
> +      compatible:
> +        const: simple-bus
> +      dma-ranges: true
> +      ranges: true
> +      "#address-cells": true
> +      "#size-cells": true
> +    required:
> +      - compatible
> +      - ranges
> +      - '#address-cells'
> +      - '#size-cells'

All this should be covered by simple-bus.yaml.

Rob

