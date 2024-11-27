Return-Path: <linux-pci+bounces-17396-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234F9DA322
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 08:34:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E109284C91
	for <lists+linux-pci@lfdr.de>; Wed, 27 Nov 2024 07:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688AE14F9F4;
	Wed, 27 Nov 2024 07:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BANtjcXC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3951547C0;
	Wed, 27 Nov 2024 07:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732692855; cv=none; b=LUAu9CVURK25kkRj61AizdZikPzsuJF2DxaDWuDIMKTA59ZWr3MtmPSaNUeleuwULpjVYfwA6qskPjvOmJFn8SDLtTr0Z0aITPLuJI4cH6M/lpL4NbyaALAHqZUO7H33ICBG8VmGvgwsktPsZpL8HqZ15n144pBoivSsROcOTLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732692855; c=relaxed/simple;
	bh=VyKDTECmg6WLZHeNxnqNh1HqtV5odSlywr88UUgZP/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMtS9zYNGOfoPBkv8NQj+puGtmi703QQvucgMdpmnwYv6c5GaS47zHFj9re73vGZHuEFb3yLMs++BNWozcWy6f+tDcb6QZ2oGby4PplufiW+Y1wO0rnq3ttG+8zYrGBRMgVROMR+fSOWHWTlMgv6qyEhkPGK02jnGxj0G2wlLPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BANtjcXC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D675BC4CECC;
	Wed, 27 Nov 2024 07:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732692854;
	bh=VyKDTECmg6WLZHeNxnqNh1HqtV5odSlywr88UUgZP/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BANtjcXCIjz9nsgBTkbT9sSmDjq8N9sGA9+mq7BFdpo14YU1boFoP9KHQvH8fuQQy
	 TAGCMS1IrQsXzgf+wv56F0K/UswmPJVaGCfqqdkrMOx6F4zdIKnK88wnAAxpttda26
	 Fn+WsH7DqKqiWdI5Pz6W2WWNF7Z0n3aEHviUorCn6EB9C3kmB3Ozr73aFLi3sRO4e2
	 ELlfB4Y58ijuxAUxKVdPcS1xkX+XFx5fAN2qdSmRwo2PC7DB8cC3RH1K0B21nBblYa
	 0P8pzlZ8sGTyq4eyub3BEjkB82vSxEaiySrLdciq9yd7uqHaePyHdZkWwiEfkLR31w
	 iVDcJsaao6qrg==
Date: Wed, 27 Nov 2024 08:34:11 +0100
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
Subject: Re: [PATCH v4 01/10] dt-bindings: clock: Add RaspberryPi RP1 clock
 bindings
Message-ID: <leeeqocyjme2sbjbwsw6whisyu6aeq7vfypdi4arktpowzxvek@ejjyxx4iliap>
References: <cover.1732444746.git.andrea.porta@suse.com>
 <5281e7b5aeb1cfc2f80c3234d9c3178c13b3b5b4.1732444746.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5281e7b5aeb1cfc2f80c3234d9c3178c13b3b5b4.1732444746.git.andrea.porta@suse.com>

On Sun, Nov 24, 2024 at 11:51:38AM +0100, Andrea della Porta wrote:
> Add device tree bindings for the clock generator found in RP1 multi
> function device, and relative entries in MAINTAINERS file.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  .../clock/raspberrypi,rp1-clocks.yaml         | 58 ++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  .../clock/raspberrypi,rp1-clocks.h            | 61 +++++++++++++++++++
>  3 files changed, 125 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/raspberrypi,rp1-clocks.yaml
>  create mode 100644 include/dt-bindings/clock/raspberrypi,rp1-clocks.h

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


