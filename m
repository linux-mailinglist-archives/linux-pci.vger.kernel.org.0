Return-Path: <linux-pci+bounces-14944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 880089A6E30
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 17:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 336581F213C7
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 15:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BB61C3F01;
	Mon, 21 Oct 2024 15:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BpWe5frt"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13B121C32EC;
	Mon, 21 Oct 2024 15:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729524777; cv=none; b=DTla6Hl18sOEJqhCWsAr7bEs6XFWil9FeNNzoQBX6zBnhpQfWE19Urx56SqnQ5tC2tQKRJmu48PL/1xI38Bvzm8M3uYDvMHlL3OSmAL6NZdqa73XsyT5yvqigmycQ6speIdmF8gw47TDBfx4oQBIrqKLulREUGIrQ8gBdd5wMhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729524777; c=relaxed/simple;
	bh=6KqBrAM2rowiy+BRqWdxd75yZdcwS8oxbQCE1r36X+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=APQL3a+q1LiHpo5H08emFtPSRIdepKUmxjV4FJohST32fYGxBrt0R4UzUnEx6YFbxQ1NGbBC4WZmC5D4rzVBFnCaJ7k/JMRNyE16CK2tCjz614oh/sIaPklmbbRN01Y4FjQv1YrcDQMClVDDnkbMllot5BdHlnBXi7d3eIDLzN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BpWe5frt; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 51BF540003;
	Mon, 21 Oct 2024 15:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1729524772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2JM1lkviEBAN8knYxaV/WvdX5AeMGlXwcLME1sHr2g4=;
	b=BpWe5frtyig2XRBNqfPwnq9QVM+wy3y7O2efHsExuA29kSKCLycPh84p3K0OV/5XXWKsfo
	9HgJG1JK0nGXO9c1u7Fag9dU6EfxgjCVbcZ8mz1N6Oqlgl62gTciU09OrzPl63iQJFV0rP
	3CTtMxw6ZGp04d5l+r9V5DCjKYj3ClDO7VZk1wDc2hp4BPG7xJreYeyjgSsjQk+WMMZmln
	fWJFOWNLrlOb+M153tPMpQ7eT/yT6ruVO6WWW8N9aFJi+ZkuepI5jKCfAJrIUK9wZZSCGj
	7BKt9C+6hRotH+tz8XI1+RjBKzxXMGkBrBK8KOCb/jT0s0A8tfdNhvXNCYSevA==
Date: Mon, 21 Oct 2024 17:32:49 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Allan Nielsen
 <allan.nielsen@microchip.com>, Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v10 0/6] Add support for the LAN966x PCI device using a
 DT overlay
Message-ID: <20241021173249.297c3ad5@bootlin.com>
In-Reply-To: <f85a263ed5290fc999d04521f4e70f4c698d9bd3.camel@pengutronix.de>
References: <20241014124636.24221-1-herve.codina@bootlin.com>
	<20241021164135.494c8ff6@bootlin.com>
	<f85a263ed5290fc999d04521f4e70f4c698d9bd3.camel@pengutronix.de>
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

Hi Philipp,

On Mon, 21 Oct 2024 17:02:24 +0200
Philipp Zabel <p.zabel@pengutronix.de> wrote:

...

> > All patches have received an 'Acked-by' and I didn't receive any
> > feedback on this v10.
> >
> > Is there anything that blocks the whole series merge?
> > 
> > Let me know if I need to do something else to have the series applied.  
> 
> Not that I am aware of. If there are no objections, I'll interpret the
> Acked-bys on patch 1 as permission to merge the whole series into
> reset/next.

Seems consistent.

Thanks Philipp.

Best regards,
Hervé

