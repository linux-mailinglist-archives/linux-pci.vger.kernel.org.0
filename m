Return-Path: <linux-pci+bounces-12650-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A709696CC
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 10:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4E5B1F26D9D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E271205E32;
	Tue,  3 Sep 2024 08:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="N3NnP+NE"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7FC205E2E;
	Tue,  3 Sep 2024 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725351455; cv=none; b=mbtGYzI8kwZL931ZEMWpczZilVoDQaamha3S8nQtS278VQ63WPMbBnmqaC1agsLF9+/WBBH/E/I6gSoqv5DHtFFE+KXyDzJ9E97AYPPlslw8C8WVi5GqlbzzsWcTENYOeAWTJKh9GUuofRndOqK3+3IFtCupx4n4fSL4HrzKgZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725351455; c=relaxed/simple;
	bh=mEX9tnWXR3cFtbYXouRT5ym7a1wznmHwUZEiyP3DrSo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bt+IdAiHBrmUCaSD8SQd11mtKr9Nvu0zgCALfK1BMqd0CHUlX5ieEYFigqnmIOtvamcLbsjNKqd1TshD1CQfwK3NDzsw+TH+KX1gTMtQxTpIrdcPqudAhjs3AxebnoXu8Wjx+TjBg4ttS/Z+Pu/nlXWRX9ToydVlZiEdvwl52TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=N3NnP+NE; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 14F6420005;
	Tue,  3 Sep 2024 08:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725351447;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zmIXjpJKzCn9i7GqnQZIA4OaYjs0BIH0eFIXR+EDLa4=;
	b=N3NnP+NEASy/fL3DgTJHSr+WS4uuGObddxciJCx/iFaHtQtqzUJOVUSisDYvke3jaHiGjB
	RltDyu0W+ALqfsWF4T7wOUr8EXZB+rY3FDe1donYKWZxkVX1p6yymzzl7F1eUlV2HhP4Ti
	BSpLvEiicIgD+A0SOPj9shH3Rbd9EVhVAY/fN6blxUm0TsjTSCdj8KCzxAc0+/MBIlPeys
	ngFsv3OE8mIGeHimaANoTzI1JAF73pF1SvKhTCkHCYMsbqq0uApKKg1x2NrEIwSFDLF/7b
	JRFBNwFjF96hXLz9lngtkD0zTNEbXCJJpRA1GnSjB/74yu0T4wPUtDzQsS0Kaw==
Date: Tue, 3 Sep 2024 10:17:24 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Herve Codina
 <herve.codina@bootlin.com>, Bjorn Helgaas <bhelgaas@google.com>, Philipp
 Zabel <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew
 Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v5 0/8] Add support for the LAN966x PCI device using a
 DT overlay
Message-ID: <20240903101724.291ad0f7@bootlin.com>
In-Reply-To: <20240808154658.247873-1-herve.codina@bootlin.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
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

Hi,

On Thu,  8 Aug 2024 17:46:49 +0200
Herve Codina <herve.codina@bootlin.com> wrote:

...

> In order to add this PCI driver, a number of preparation changes are
> needed:
>  - Patches 1, 2 introduce the LAN996x PCI driver itself, together with
>    its DT overlay and the related MAINTAINTER entry.
> 
>  - Patches 3 to 8 allow the reset driver used for the LAN996x to be
>    built as a module. Indeed, in the case where Linux runs on the ARM
>    cores, it is common to have the reset driver built-in. However, when
>    the LAN996x is used as a PCI device, it makes sense that all its
>    drivers can be loaded as modules.
> 

Patch 7 was applied my Philipp and patch 1 was acked by Greg.

No feedback received on other patches.
What can I do to move forward on this series and have it applied ?

Best regards,
Hervé

