Return-Path: <linux-pci+bounces-15508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D162B9B431D
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 08:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9769628390B
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 07:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6D020262A;
	Tue, 29 Oct 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j7/pDNwm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674A31D7994;
	Tue, 29 Oct 2024 07:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730186929; cv=none; b=fpsD+tz17e12FpHVFBzhiSXK0Z7/VjyWlG6ZrBeGGYhTjtEYxOMlqDKu7AL/5dl3x98ir8ZoODeAqIKwlZhEiXRoY1/+rv5Xep+AYMF+dbuuZ0RmKGg4s4BqBS03oye5XMoaujRYQyszrzKkYXdhU/tKQS5kRcYSYJa8ijMT2Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730186929; c=relaxed/simple;
	bh=4OezFKJ8MU5/YXoAOGFAMmcNkpVGOILX+5gHrcEYsAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lb7ataV1D6+YHqlyCBR/IgnnkzEwot0CWsnhoJWqewTuViR30QUb46yJ5JuIS555vlRUN3wNibrvi1NuMu7fCx82G+Y4mh3VbqkA7gBJAdtdTftYxgGFY9/jl0HuE3VLX3a/AkcaTauoIpfgIVIfEQ6bFj4UivibdgqKoGo/PkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7/pDNwm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5953C4CEE3;
	Tue, 29 Oct 2024 07:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730186929;
	bh=4OezFKJ8MU5/YXoAOGFAMmcNkpVGOILX+5gHrcEYsAY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j7/pDNwmoBcuZ8ZUxAatEvL+iCSnS31nAHnZdra4shS2g+rY6tNpIPTxMpjwlrkQn
	 Hmr5F7fHufGJnn0xpuYts4DvVN9iwtfodTPg6ghbovmkMGm2SJWBe5fCU8ZwNwV532
	 Ge8b6DSbcOpsxoaY5a1Pjf8eiZcR/YMZJWypSUqbnrSwVSOaPEu+jM6SoZq2ov32vB
	 iQbT+gj+uJlRjtKA3SjQk/8HV/vTCM12bAbC4I6gIlI3cN/muOER+6HxW4zaDuIgMo
	 QfQ4yxFxrfwYDppaPjpMd1rA8QxbbjYDBMCwX+3O4FQdJpSDyNQnVGm7gN8spKY087
	 nG57VuL6Ra4Ew==
Date: Tue, 29 Oct 2024 08:28:45 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof Wilczynski <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
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
Subject: Re: [PATCH v3 03/12] dt-bindings: pci: Add common schema for devices
 accessible through PCI BARs
Message-ID: <fwqcbnub36fk4abmhbtuwsoxdlf64mx4v65mxahsxmiv2sz6er@bfjddapvb75v>
References: <cover.1730123575.git.andrea.porta@suse.com>
 <2948fdf8ccf8d83f59814d0b2a85ce8dac938764.1730123575.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2948fdf8ccf8d83f59814d0b2a85ce8dac938764.1730123575.git.andrea.porta@suse.com>

On Mon, Oct 28, 2024 at 03:07:20PM +0100, Andrea della Porta wrote:
> Common YAML schema for devices that exports internal peripherals through
> PCI BARs. The BARs are exposed as simple-buses through which the
> peripherals can be accessed.
> 
> This is not intended to be used as a standalone binding, but should be
> included by device specific bindings.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../devicetree/bindings/pci/pci-ep-bus.yaml   | 58 +++++++++++++++++++
>  MAINTAINERS                                   |  1 +
>  2 files changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> new file mode 100644
> index 000000000000..e532621f226b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pci/pci-ep-bus.yaml
> @@ -0,0 +1,58 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pci/pci-ep-bus.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Common Properties for PCI MFD Endpoints with Peripherals Addressable from BARs
> +
> +maintainers:
> +  - Andrea della Porta  <andrea.porta@suse.com>
> +
> +description:
> +  Define a generic node representing a PCI endpoint which contains several sub-
> +  peripherals. The peripherals can be accessed through one or more BARs.
> +  This common schema is intended to be referenced from device tree bindings, and

Please wrap code according to coding style (checkpatch is not a coding
style description but only a tool).

Above applies to all places here and other bindings.

Best regards,
Krzysztof


