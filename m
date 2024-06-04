Return-Path: <linux-pci+bounces-8266-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BA38FBC06
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 21:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E69CF2871A6
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F4A14A62F;
	Tue,  4 Jun 2024 19:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hb0BpmH5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BwP54sH+"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0B2D14A61E;
	Tue,  4 Jun 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717527746; cv=none; b=qFeKWpj+Z8ppvVqdS8G10oH3Vuepnn+TNoFRjGZs6Ko/rjzIVU29GAZjvZ5ynST57SkTU3s1TAO8C6fPIcR7umFc7RGSRRcpRT7t4evcy1TX0SpP4rC4hvzCiIYf+N5OPQQSvm6zwqSzS01e6j7BaYRVkfVdxRh3smZ/Xf0Gx78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717527746; c=relaxed/simple;
	bh=uMSkJk+dg2LQhDExTLD4gnvTBLV3WzNCYPdVHfzYj30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GeiLamy02+FlCpsXMK/hvKoPGQRLH0WwWgr603jlHQ5l00YRk/HvBxnN21TYMZZ2JIth4vMtvBzfhsZRJLWCNKoFHkiqki1fyJ3Hf2NqWvTb6xk/x4t8QliphUmPgVajIZV8rH45XX/k26BYwafMapU9gr2qK96sPAp3YLh8lMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hb0BpmH5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BwP54sH+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717527742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl9qr7709UaFfhmIja99nnTUkZ499nGLto2FNA0uIZM=;
	b=hb0BpmH5b+ZVhpGp4TCKwC5yHotiztytRSO9V3WGSPbH1IZz6BUNqnb6N6SePJ2p6DQzTX
	3Dy9aqAMjrAk9uCOMVK9h22D9c31na8bTAf8liWiwaeuv0EYU3JaRncaN7mR68w79pVRjw
	AXvs2XUTvEoz2s00117MAGBslsnt/oB9dZMHQuCmyW9FAMsd5mRI9GKmiqdHrMcKo3+H/g
	J/GoUnc2RP6ALi7EbT40ZD3seQXI4WaYogYhuqmBTNE4bOwiFReAZJ9qa4jONEnlCsjJ+P
	ssyWqesiO15U2rYyZcF3WKp0Yvhv+Py6jwZBEwz85/n7Bws4qV+qNQrUnEDjBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717527742;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Pl9qr7709UaFfhmIja99nnTUkZ499nGLto2FNA0uIZM=;
	b=BwP54sH+bWPx8hCny5NetHZnXQZU/QaHTApPp9/H5JcQbMvk7BrA4oJ7b3VxrvyeqOxXaa
	bxGw/FNs+kzBtUBw==
To: Herve Codina <herve.codina@bootlin.com>, Simon Horman
 <horms@kernel.org>, Sai Krishna Gajula <saikrishnag@marvell.com>, Herve
 Codina <herve.codina@bootlin.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Horatiu Vultur <horatiu.vultur@microchip.com>,
 UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>,
 Saravana Kannan <saravanak@google.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars
 Povlsen <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, Alexandre Belloni
 <alexandre.belloni@bootlin.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Steen Hegelund
 <steen.hegelund@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 09/19] irqdomain: Add missing parameter descriptions
 in docs
In-Reply-To: <20240527161450.326615-10-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-10-herve.codina@bootlin.com>
Date: Tue, 04 Jun 2024 21:02:22 +0200
Message-ID: <87a5k05y69.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, May 27 2024 at 18:14, Herve Codina wrote:
> During compilation, several warning of the following form were raised:
>   Function parameter or struct member 'x' not described in 'yyy'
>
> Add the missing function parameter descriptions.

Sigh. Why is such a cleanup burried in the middle of patch series which
tries to add a network driver?

