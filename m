Return-Path: <linux-pci+bounces-25926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E537CA8A1F4
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 16:55:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D27190096A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0792A29A3C7;
	Tue, 15 Apr 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NeGlLIav"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0384C297A68;
	Tue, 15 Apr 2025 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744728913; cv=none; b=e/pHuXCMn3Xub00d/F+BKj3rq/1ab+yH/aQ6dopHRI3SqwBnijm+wACRnT9W0m/mN9z3IuSR2fiw3CGR8ESM2DaVgr4zcAcP1/iHVz1l1zezRaFqKsUtmOdwDvx7OlLyjOC+yqRM28S2+QadDatAz2JAM6KyT94qCZxLPFV9CpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744728913; c=relaxed/simple;
	bh=+flNzZtjn1M/5D89HSQUpcWv0OrCTQQNyIqgrpPpkW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W62okntvqTwa5rrhm1kvZ6UU6b3N6GCsM0LYVQKfDF9hQdQmaYYn+p2BvG5LyqnS+Che4GySW78oxwghgt0buI09D0Lh2m05QlPhQjk1Kb+mrZM0wYH9mPhCcK7IzsYaldAgV3pw4H+oAV4lVXcA3uyEcGpdmmiI1VzMvsH9tQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NeGlLIav; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 9C049439AC;
	Tue, 15 Apr 2025 14:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1744728909;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=02LK9pHroELAh3qGOo82hLnNoi/5dDABLv647P77RhE=;
	b=NeGlLIavf8r3+95C7G3xorvF32BXXKG3930EBRZhay4vBBBBnXJOU6PYCjReX1a+1648w8
	wcxk6gJwXWocATV016xQa3TUEro4dECD/Jshf1oOhOi+hSfVlsMTBnjRi8Vn9LJoMeyCIw
	weCSHqCMw+Ks+PEiOcnBsUZbSooI7JGRglPjy+QgCo9JobYsih5tijLHIjodfc/uvkBZhw
	ZjyNEUq/D889sqajEC02nuUhI5QcBC/KrZwFMkZ8pOn9TrtKpvthgKofdbvs6HaxLK795N
	pqVg7/VtLffvI+hLHk+H0vauo7A3s0yNXcethhI6BMc/V8yoP2uQXUjdxceU9w==
Date: Tue, 15 Apr 2025 16:55:05 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrea della Porta <andrea.porta@suse.com>, Michael Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof Wilczynski <kw@linux.com>, Manivannan
 Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Linus Walleij <linus.walleij@linaro.org>, Catalin
 Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Bartosz
 Golaszewski <brgl@bgdev.pl>, Derek Kiernan <derek.kiernan@amd.com>, Dragan
 Cvetic <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>, Saravana
 Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>, Stefan
 Wahren <wahrenst@gmx.net>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>, Dave Stevenson
 <dave.stevenson@raspberrypi.com>, kernel-list@raspberrypi.com
Subject: Re: [PATCH v8 08/13] misc: rp1: RaspberryPi RP1 misc driver
Message-ID: <20250415165505.0c05bc61@bootlin.com>
In-Reply-To: <2025041557-masculine-abrasive-c372@gregkh>
References: <cover.1742418429.git.andrea.porta@suse.com>
	<3fbc487bc0e4b855ffbee8ed62cfb6bf3b0592e8.1742418429.git.andrea.porta@suse.com>
	<2025041557-masculine-abrasive-c372@gregkh>
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
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdefjeekucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfgjfhhoofggtgfgsehtkeertdertdejnecuhfhrohhmpefjvghrvhgvucevohguihhnrgcuoehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomheqnecuggftrfgrthhtvghrnhepvdfhleejtdeftdejveffgedtuddtgefhtedtudfhuefhtddtffeiueeigfdvhfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepvdgrtddumegvtdgrmedvgeeimeejjeeltdemvdeitgegmegvvddvmeeitdefugemheekrgenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtudemvgdtrgemvdegieemjeejledtmedviegtgeemvgdvvdemiedtfegumeehkegrpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehhvghrvhgvrdgtohguihhnrgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepfeehpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheprghnughrvggrrdhpohhrthgrsehsuhhsvgdrtghomhdprhgtphhtthhopehmthhurhhquhgvthhtvgessggrhihlihgsr
 hgvrdgtohhmpdhrtghpthhtohepshgsohihugeskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhhosghhsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhiikhdoughtsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohhnohhrodgutheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhlohhrihgrnhdrfhgrihhnvghllhhisegsrhhorggutghomhdrtghomh
X-GND-Sasl: herve.codina@bootlin.com

Hi Greg,

On Tue, 15 Apr 2025 16:06:43 +0200
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Mar 19, 2025 at 10:52:29PM +0100, Andrea della Porta wrote:
> > The RaspberryPi RP1 is a PCI multi function device containing
> > peripherals ranging from Ethernet to USB controller, I2C, SPI
> > and others.  
> 
> So shouldn't this be using the auxbus code?  That's designed to "split
> up" PCI devices such that you can share them this way.
> 
> Or did that get rejected somewhere previously?
> 

It doesn't use auxbus probably for the exact same reason that the
one given for the LAN966x PCI device driver [0] and [1].

Avoid all boiler plate needed with auxbus whereas drivers already exist
as platform drivers. Internal devices are handled by those platform drivers.
Those devi just need to be described as platform devices and device-tree is
fully relevant for that description.

[0] https://lore.kernel.org/all/CAL_Jsq+1r3SSaXupdNAcXO-4rcV-_3_hwh0XJaBsB9fuX5nBCQ@mail.gmail.com/
[1] https://lore.kernel.org/all/Y9kuxrL3XaCG+blk@kroah.com/

Best regards,
Hervé

