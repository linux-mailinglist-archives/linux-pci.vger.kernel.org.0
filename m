Return-Path: <linux-pci+bounces-8267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 612248FBCDE
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 22:00:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA4DDB23BD4
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 20:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BBB14B943;
	Tue,  4 Jun 2024 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sGO+0nFC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Pc1GDIb"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6F113DB96;
	Tue,  4 Jun 2024 19:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717531196; cv=none; b=J9mP3kgpGyaAyqWXyXa4+2Yltxlhvrpd2E5x0PYWguwXmwm7rsMX0Pr34WlfDwZNhy5SJFEUd1a1TBu/I9bZorh4W5LKbqgGgMPzImbONHkZVra4rAOyLry7YdnbcFG5XTYV0SFdJLvYSghF86MiWA6BZH0lg+EBiK8zGr/1Drw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717531196; c=relaxed/simple;
	bh=3Sta6cOjka9v0Q5VHFmH5CpIjRsDhmO9KXLxIkVNMV0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hjJKeQAqqzr5aqS0L1Gd0Mj3Pufdnag/g7d5YyFOYC1Fbe9w/WTin260itLcV2Tp1aaFPfVfnmNgMndsQQJ7zT1ag6ZCPo2sY0jNPdAlte1BINzPs+4PQeY9Lua3B20OkC78y6cKQwd8jWKIFFmp2rd7q0rtGXlVB1VimTYRqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sGO+0nFC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Pc1GDIb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717531193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn3nqXw0Cg/J2A4K/eHlNOvzJphsW1V9FDvcZWtVIO4=;
	b=sGO+0nFC8gr4gxOC/FbLE1kbKBWZLj/1xNL37h/19tZmgTAdsfDE0WT+1T2u+7jvxT56ZE
	0k1WiL2QEKlFYt1QenHPkyzIYjdtrWPTWjUXvATZcrSO9j631WJ2VpxTYeLK2+u7ngA1ne
	KjuMJ2rkPxWJPrDikeO0V1Ua0IOgOTlX1WMiQRmt1CHf3GphdQChwRiv219nHskXLcDcVf
	VNEA/rn/AiaxT//j1zEfiB1GSH4fNjKdKqrB82zpE/Sutqbxbwb+SwD68CT8p9tPWXe7H5
	WcRFCWFONwxX6RqAx/HbehvshYnDF1ci5LlcRc6u7lpivs0Zdest8psQN7ncFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717531193;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Yn3nqXw0Cg/J2A4K/eHlNOvzJphsW1V9FDvcZWtVIO4=;
	b=0Pc1GDIbnzVMM3oKUxEzOd1L8/FT0ifsdoepunlGqbDlFQAxdqTnogI8xkvZr6fssa57n4
	iDNzcjQIkbaG09Aw==
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
Subject: Re: [PATCH v2 10/19] irqdomain: Introduce irq_domain_alloc() and
 irq_domain_publish()
In-Reply-To: <20240527161450.326615-11-herve.codina@bootlin.com>
References: <20240527161450.326615-1-herve.codina@bootlin.com>
 <20240527161450.326615-11-herve.codina@bootlin.com>
Date: Tue, 04 Jun 2024 21:59:52 +0200
Message-ID: <878qzk5vif.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Herve!

On Mon, May 27 2024 at 18:14, Herve Codina wrote:

Sorry I missed V1 somehow. I'll review this tomorrow.

Thanks,

        tglx

