Return-Path: <linux-pci+bounces-13966-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DBC993039
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE2551F23F45
	for <lists+linux-pci@lfdr.de>; Mon,  7 Oct 2024 14:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C531D79A5;
	Mon,  7 Oct 2024 14:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UaEgwyuE"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1A481D4353;
	Mon,  7 Oct 2024 14:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728313069; cv=none; b=CPsCW2/PRbmEX/weHmKw68v0+dj6aEBB9CWSwGs71J8vhUOPDpq7iJcn3RfbwPVmMgcHGXXGpHoK2q6eRS3iVcjUbTubn7Y91VXq7j/GzP708qDjeP+WBG5wyXuIaZgzz/ctwN6XmaoBJyPub+0fjWhuEWBj2bdQOuctdRN6zd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728313069; c=relaxed/simple;
	bh=VZlt15A8ZzETo+SM/d3aO345eBdq3CKAUbyzP15QZlM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U8N92zkdeEv6cDFV1ojLmHqd+fJ8S4WAMiDj33lv2pKyrSYPbL9dZVcJCdmpEsMFdP4McB28iIa3CPodEJO7ZNK+w4V2+6lnCf0c8+5wumYeOpsrFLIDbqMo4ezJU6FRcoFGr5Jk3szohTUWFgj66x+YSHPkclBQxYDzhUn87Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UaEgwyuE; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6F031E0005;
	Mon,  7 Oct 2024 14:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1728313064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dL9aA540mEeufB7thObWnGoJTxtAhjB5yU/T3BfooEs=;
	b=UaEgwyuEu6gLwU9JDdC4Jv0egiVcXYuwXu/pXA5cjTNEz/7NzGS+Du+W7aej+hzJrl/6mm
	q5QSUK1eG2zCEzIYjpAwjyL5OXr0tlA9fz+Bg4zjNkHLlNFjZUTv1OawpSt5TVQVjCkDN9
	jRhOPeSpxQe2UQiy5ApnWobz0leWTq/yqHt/v9ccAN42PolVqSlXjibhxbesAUT+rR0Yz3
	sFGQAt16VsCYJ5WKvxmt245F6w+olonniYKNtULjCnKQUvJ6xmY29C51lcFeQM7bXS9zSl
	jHy+g/KhX5EuzuxAWgId7ivmZhrpGyuFNIS/04ypczA+8DOfKAIvS4QzYFdGlg==
Date: Mon, 7 Oct 2024 16:57:40 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?=
 <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, Derek
 Kiernan <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Saravana Kannan <saravanak@google.com>,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Stefan
 Wahren <wahrenst@gmx.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH v2 10/14] arm64: dts: rp1: Add support for RaspberryPi's
 RP1 device
Message-ID: <20241007165740.14d372f5@bootlin.com>
In-Reply-To: <3f6f38c06b065f5f6034ad4ed3a24902ee59f378.1728300190.git.andrea.porta@suse.com>
References: <cover.1728300189.git.andrea.porta@suse.com>
	<3f6f38c06b065f5f6034ad4ed3a24902ee59f378.1728300190.git.andrea.porta@suse.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi Andrea,

On Mon,  7 Oct 2024 14:39:53 +0200
Andrea della Porta <andrea.porta@suse.com> wrote:

> RaspberryPi RP1 is a multi function PCI endpoint device that
> exposes several subperipherals via PCI BAR.
> Add a dtb overlay that will be compiled into a binary blob
> and linked in the RP1 driver.
> This overlay offers just minimal support to represent the
> RP1 device itself, the sub-peripherals will be added by
> future patches.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---

...
> +/ {
> +	fragment@0 {
> +		target-path="";
> +		__overlay__ {
> +			compatible = "pci1de4,1";

The compatible is not needed here. Indeed, it will be added by the PCI core
when it scans the bus and adds the missing nodes.
  https://elixir.bootlin.com/linux/v6.12-rc2/source/drivers/pci/of_property.c#L383

> +			#address-cells = <3>;
> +			#size-cells = <2>;
> +
> +			pci_ep_bus: pci-ep-bus@1 {
> +				compatible = "simple-bus";
> +				ranges = <0xc0 0x40000000
> +					  0x01 0x00 0x00000000
> +					  0x00 0x00400000>;
> +				dma-ranges = <0x10 0x00000000
> +					      0x43000000 0x10 0x00000000
> +					      0x10 0x00000000>;
> +				#address-cells = <2>;
> +				#size-cells = <2>;
> +				interrupt-controller;
> +				interrupt-parent = <&pci_ep_bus>;
> +				#interrupt-cells = <2>;

Not sure this node should be an interrupt controller.
The interrupt controller is the PCI device itself (i.e.the node
where the overlay is applied).

Best regards,
Hervé


