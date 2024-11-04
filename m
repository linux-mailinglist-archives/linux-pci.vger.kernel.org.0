Return-Path: <linux-pci+bounces-15913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275049BADB2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 09:08:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58F6B1C2132D
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 08:08:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E21A4F2F;
	Mon,  4 Nov 2024 08:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SIdWyorj"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3F61A265B;
	Mon,  4 Nov 2024 08:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730707733; cv=none; b=dsTLTTtch0q3KiACS0kMJRueB/AQw9jWVw4eEAjACjRSYFKb3Q/bC1ujf5mgW3XfL/DEXtUWjpV7KxQqUGUgwLx0w3SX+MRWpkcaMEXCNHuwj2mwki2ZHIVj8va6cyJIr3F3ibZKO1jF0T7R/fNHUvzLBFIStGF0MP0GLbG6fRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730707733; c=relaxed/simple;
	bh=HBYtum1Ynsn4iu51DsI1XEnzBgbV3hzsfpO6QgW+HNs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxXQvXRUTTqaMJef9E1mrYE76cngT6ncY3V7ZuOSN6JLMnCjtJkOXSgRtWAwqzzFCjIaT1PIK8FZbhuvlKPT5ux9U96kC0WgJBDeV4n3Fb1QMm2DPZNpgy1zGg1TsIbfPcyqVbN3FegvCKZ/xNugmXqJTM1EVOhHe3V16UDdOzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SIdWyorj; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0275320004;
	Mon,  4 Nov 2024 08:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1730707723;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zv8rMTk3N7pFqyJ5F+rYbHLRRYuoS1UjcvDvJw/Onhk=;
	b=SIdWyorjKqnlPI7Gzi6+hxmova0tlKlf/AzdxmIej8e10BPvpHz9k0pmcOiTRH7mBA214H
	yw4Ai9P2CVM0ErItdQLx+D5B8btJqj1D7q2ENmdxMjGMFLicikAe47i4RUceWPmGDlofRv
	foQ5UIcIGXQrmEaHgfN0dAiv+V7RkWAbkOdj6CGW+C0Pyvx7sNMVHzoWVnTLZgIvJwFijo
	+rTYEWtjvgmX1jMOC4c9z9p0RYanCXFEJJg+vGagwzSG5lxqa1hYgxED26UqENW1xgyRm9
	lNq/wMMqiX4U24QFgPQaKPV6Tv13jObGJuNZ+OHC00gRio8n272H9ub0jqOvkg==
Date: Mon, 4 Nov 2024 09:08:39 +0100
From: Herve Codina <herve.codina@bootlin.com>
To: Andrea della Porta <andrea.porta@suse.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Florian Fainelli
 <florian.fainelli@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Saravana Kannan
 <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-gpio@vger.kernel.org, Masahiro Yamada
 <masahiroy@kernel.org>, Stefan Wahren <wahrenst@gmx.net>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 06/12] of: address: Preserve the flags portion on 1:1
 dma-ranges mapping
Message-ID: <20241104090839.5b9b4bdd@bootlin.com>
In-Reply-To: <3029857353c9499659369c1540ba887d7860670f.1730123575.git.andrea.porta@suse.com>
References: <cover.1730123575.git.andrea.porta@suse.com>
	<3029857353c9499659369c1540ba887d7860670f.1730123575.git.andrea.porta@suse.com>
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

On Mon, 28 Oct 2024 15:07:23 +0100
Andrea della Porta <andrea.porta@suse.com> wrote:

> A missing or empty dma-ranges in a DT node implies a 1:1 mapping for dma
> translations. In this specific case, the current behaviour is to zero out
> the entire specifier so that the translation could be carried on as an
> offset from zero.  This includes address specifier that has flags (e.g.
> PCI ranges).
> Once the flags portion has been zeroed, the translation chain is broken
> since the mapping functions will check the upcoming address specifier
> against mismatching flags, always failing the 1:1 mapping and its entire
> purpose of always succeeding.
> Set to zero only the address portion while passing the flags through.
> 
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Tested ok with my LAN966x PCI device.

Tested-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

