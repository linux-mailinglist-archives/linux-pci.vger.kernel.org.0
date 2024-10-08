Return-Path: <linux-pci+bounces-13989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3215993FC1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 09:39:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8DE62867C2
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22FE3185B5D;
	Tue,  8 Oct 2024 06:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZOgA1URd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38CA16132E;
	Tue,  8 Oct 2024 06:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728369174; cv=none; b=eTdzzNpCmCBsX/PSSEPUtTkZESF1mPMK+ILTOxg+h3AZGgyqgZvwoYwjLWYenvCarJOZeG/pEJk6IS0j7gbEy6Y9FnsrSUMTkUDwTjJd3VSNKV7WvJDHWcgSD4HT2AAUMmDo/aN3xTX3vIx8QoEI2kle606d9zgbxOcmVSilSj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728369174; c=relaxed/simple;
	bh=yQK0RMfo+TSViKU2KPmCcU/7mF+5ynxcxIuuloy3MHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uGZI0rzhOCOBvirojOy0t+RChcJ6bPnI2GPr1pqBeET+ysiZuluBeEpHntSViNgVrEJhDHyeQlk3bJ63Y+c/7Iw+RzM1O/kXxvDuo0shMJyJ6Blij8WxCR0vwKrF9IuhZ/bFVsZ8a2jZ/9sQgrn3SpbqGSYuDkzoGDvVhpI49P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZOgA1URd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EA82C4CEC7;
	Tue,  8 Oct 2024 06:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728369173;
	bh=yQK0RMfo+TSViKU2KPmCcU/7mF+5ynxcxIuuloy3MHo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZOgA1URdaNskre+harX8yhZHdZieZOiQbOYw0+hMj6LVzrqgotEgLZgM3PnQHrP+f
	 LvEL5L1GMjcvgjZpC5Bugw3p8Aa11MsymaIThS2pY59e0dINfP2o+Q1siphCiXDmwf
	 3lof9BOvuSmZVjkoqeBmDNf+kzT9jIj61DP0PaggfFS/Hmz9ObWccjdn/jX2tddsC6
	 ZgRvMgvYWf1Y0f3cv6WtE1iP1ufIs5XcPl7CE17om8cijCmHKM2gCbvQGW2ODXA2fe
	 ZLhtJoOnm5Cj6qrEj2i91flkfFZpMdIpKwX9TIqfo4g4Zi3fAesXe14QTZ30oI+i8W
	 kKD6oq5NkpA7w==
Date: Tue, 8 Oct 2024 08:32:49 +0200
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
Subject: Re: [PATCH v2 14/14] arm64: defconfig: Enable RP1 misc/clock/gpio
 drivers
Message-ID: <7y4rgefxfst5y7xgvtwhv6dulxjd7ieou5jlqi3waqwyw6vpuq@xken3govscld>
References: <cover.1728300189.git.andrea.porta@suse.com>
 <6964b1728d155b85c9c97fe26726e8ee2c04abf8.1728300190.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6964b1728d155b85c9c97fe26726e8ee2c04abf8.1728300190.git.andrea.porta@suse.com>

On Mon, Oct 07, 2024 at 02:39:57PM +0200, Andrea della Porta wrote:
> Select the RP1 drivers needed to operate the PCI endpoint containing
> several peripherals such as Ethernet and USB Controller. This chip is
> present on RaspberryPi 5.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> ---
>  arch/arm64/configs/defconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 5fdbfea7a5b2..5fcd9ae0d373 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -609,6 +609,7 @@ CONFIG_PINCTRL_QCM2290=y
>  CONFIG_PINCTRL_QCS404=y
>  CONFIG_PINCTRL_QDF2XXX=y
>  CONFIG_PINCTRL_QDU1000=y
> +CONFIG_PINCTRL_RP1=y

Module, that's not a SoC component.

>  CONFIG_PINCTRL_SA8775P=y
>  CONFIG_PINCTRL_SC7180=y

Best regards,
Krzysztof


