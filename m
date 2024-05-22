Return-Path: <linux-pci+bounces-7747-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9028CC32D
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 16:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD761C23222
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 14:24:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BD8E1411FA;
	Wed, 22 May 2024 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dv2LkrXL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFD81411CA;
	Wed, 22 May 2024 14:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387851; cv=none; b=ZsSWhM9mBjBO9m2OlPlChSGAym5xZzBRIwIcN1XIW0tW5Rv3bVa2tsxpyUklq4FQiIbm6FBdhcSiriWHf2kzh0o0dlD6nRzfVqCH8IfpEPDAVng8BcD2HM8re/b7zASSK4p11tTBfB63Ii4iEjpe5xi2U6xtOnjXTXxltAJmvdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387851; c=relaxed/simple;
	bh=hzLC77vGkl4FctqkHWbXtIKuE74mwnfPPg5UFrTyRQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fs5EYYUct4ng+jszLoSFrmNUn9A7G8j9cfZp1IIzQhkijz88VvoyibeCta76M/EOTnyT9Ds8+C7DKz4TDCR3x1woX7mi/OrLLiLMUCpf8bpLlSchBGyc9QcMuPsqpxI5AO0faJGbBUDWYLR/E83U0rh6s5PDDfF9HFfxmGItEnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dv2LkrXL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424CCC2BBFC;
	Wed, 22 May 2024 14:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716387850;
	bh=hzLC77vGkl4FctqkHWbXtIKuE74mwnfPPg5UFrTyRQ4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dv2LkrXLNDZSCQhHTyPf/MTF5oJ580HsuWU4Xfd3cUhVT+MOou+G0hM1q7UzqqXCg
	 XCMprz0GuUBE8N73oCx3fqSPYpREYXZulTts068qsUZPUmqzxqrGTLCMgSSnNpfDGz
	 jx0eDiqy0gzDyXWtxiFf1K2PT6hhBTFm8qHC8evePXj2zr9kdlAIf6K8EW16S4WmNf
	 bnKN+7cEjCzsvIZLXJhW7mQ76CjlvN1UCy+dKaQbgF2WgPk8/Sx6DWpvY5B4i9Xp4Y
	 XiOzbjOUAlogktu9i/bYaVqjWA6nbZCg9X6Qloi5p61Olr6h6SpUBeqHEGGLIhYYmG
	 f8V8onoGcibYg==
Date: Wed, 22 May 2024 09:24:09 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: UNGLinuxDriver@microchip.com,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	devicetree@vger.kernel.org,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	linux-pci@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Lars Povlsen <lars.povlsen@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Lee Jones <lee@kernel.org>, linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Saravana Kannan <saravanak@google.com>
Subject: Re: [PATCH 09/17] dt-bindings: interrupt-controller: Add support for
 Microchip LAN966x OIC
Message-ID: <171638784589.3244704.2938848620402694008.robh@kernel.org>
References: <20240430083730.134918-1-herve.codina@bootlin.com>
 <20240430083730.134918-10-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430083730.134918-10-herve.codina@bootlin.com>


On Tue, 30 Apr 2024 10:37:18 +0200, Herve Codina wrote:
> The Microchip LAN966x outband interrupt controller (OIC) maps the
> internal interrupt sources of the LAN966x device to an external
> interrupt.
> When the LAN966x device is used as a PCI device, the external interrupt
> is routed to the PCI interrupt.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  .../microchip,lan966x-oic.yaml                | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


