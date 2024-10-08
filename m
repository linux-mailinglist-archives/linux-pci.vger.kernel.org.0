Return-Path: <linux-pci+bounces-13985-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C66993F01
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 08:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 633271C215CB
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 06:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9281D043A;
	Tue,  8 Oct 2024 06:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ipZHQFGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C20513BC0C;
	Tue,  8 Oct 2024 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728368651; cv=none; b=QeLWJa1KmPvbl97RWf/FpmiIvxe6t5BTrylDbSQPTFXKzAeaNC7M8U1VhjPOoy/D5zbldHWERdvgClsEyAw95ZsJOS6WXQfuSIE1kSL8bYX0QEVUQbxb+dm9RbiO/3pTDhea52w+xboB8UE0cVSXNiW/8F4GHJTRKt0USSq2Drk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728368651; c=relaxed/simple;
	bh=ZCmpVIO4mKb6ac9euGG9tBUheFL5NjNdMiYA28D1doA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z286YmbRaW0vqM0s2vUAFjYZQ8+vuXbubXDh/y7BUbahFNFBeNSleftcO1R0tVTrjbuag7cQkPgfMdBjK6dyM9gqeUs80Buw91mjKMIrAoo23V5Rt38YAnRqfOwXLLrd7T25uylE6ItawWBvmfTpx9nx1FUyOY9B8fsFowLmVS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ipZHQFGf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EB5C4CECF;
	Tue,  8 Oct 2024 06:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728368650;
	bh=ZCmpVIO4mKb6ac9euGG9tBUheFL5NjNdMiYA28D1doA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ipZHQFGfZ1XnYJN4WRfrcd3MzdHHcJ41yv1KeJtYWb+UPOsHVpzBo6/wzTXOB8P6j
	 qjqRXJBig/73KLYDPllA3NK9ahabtnWKkPJgN3SfPqFUlDco53dMepnMo4uj8uhKeJ
	 bbPecTaZTCXhWGPQ3e63AuUk/0RHmiXztV0EBElkZxxXQsM/vdbJ5FTGeYv2H0u5Fi
	 OTYsJKf6Pp/AOals/2GWJifJcQ8a2SEEN1kKihBLVXVfY6nyVe9LRXwKHbYUIotcB6
	 kY/jFwWek8Z8m6nbyjCXzP6nd/KsxgH/Wa6WNTdRo9OAB1c9tvGbWzOHefG+nbcGB0
	 N85D/7iJluoow==
Date: Tue, 8 Oct 2024 08:24:06 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, 
	Dragan Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>, 
	linux-clk@vger.kernel.org, devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, 
	Stefan Wahren <wahrenst@gmx.net>, Herve Codina <herve.codina@bootlin.com>, 
	Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v2 03/14] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <flxm3zap4opsjf2s4wfjwdj6idf7p6errgtiru4xgbgkfx4ves@xxiz42cghgvr>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e1d6c72d9f41218e755b615b9a985db075ce9c28.1728300189.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:46PM +0200, Andrea della Porta wrote:
> Common YAML schema for devices that exports internal peripherals through
> PCI BARs. The BARs are exposed as simple-buses through which the
> peripherals can be accessed.
> 
> This is not intended to be used as a standalone binding, but should be
> included by device specific bindings.

It still has to be tested before posting... Mailing list is not a
testing service. My and Rob's machines are not a testing service.

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

Drop full stop and capitalize it.

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

Use consistent quotes, either ' or ".

Best regards,
Krzysztof


