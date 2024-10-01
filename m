Return-Path: <linux-pci+bounces-13691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3DED98C243
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 18:06:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5BB541F261DD
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2024 16:06:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2F21CB317;
	Tue,  1 Oct 2024 16:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="LCTKsXvn"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB75F1C9EB3;
	Tue,  1 Oct 2024 16:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798791; cv=none; b=u5jPDJCe3ZwytreLWrDnjurpGeReZDpobr9RpJikTQpWOfEo/aJzCNQ0MilMgB3uLWXUsV2tiaNGYMzWXhUxUfZFdbNjOujKHJUvKO2Kv4ttZXPjdpJjLA5XnwGGoWfbHNUXpV1wqO3jADRvEYhaEgN25nbpy5Y9YrL6XwatN+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798791; c=relaxed/simple;
	bh=yolmBkz3ljbf7antDyyquX8zhL5x+7PHzQi1hzQFCW8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onbCrgmAJZbpp2nn6m3iNz819tRMCv2t/tn7LTGC0hdIBMGYqMNq55RgNZjmele3xh5B098UVyl+twujZE9XB7h5WFnRlakiRZRN31qKcKJrpZLxg0WrRZqG/89FlqkNz75TQ2W6J1F9JgdKAfAuU0on5KVbNK0WdxbJLULejNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=LCTKsXvn; arc=none smtp.client-ip=217.70.183.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 841EE240007;
	Tue,  1 Oct 2024 16:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1727798784;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s11bFBgMBVIa6r2QYg0pEn8AS/G0E8C5GTuxI/JostY=;
	b=LCTKsXvny5ow713Z5B9P3m5gIl1LomlDIIFV4K4NhG9ZBLcsrZszohOY8EoNbHzDZENz7t
	AiRVmpztdPYhIurAa72idPmj68cfoPNQUSVmMsITFbBMe75bUtPgbyeIVWZ9Yns014jdfH
	KitzdWIyWXPGVzSdIaInKLapGSt6HIRaYZRqRpmehSGsYezMV6WjVeHyAiEFdx5YV7qSwR
	B2c0TLSHUKM2eRPTlrAOr3ZqhV7JKhIC1BQa7roOZq8tU1ze9EzTVw3TvDukjKcQZCsD4H
	usFRtN1AkfU1B1P1FgtxtN6l1cU3iVZD3AlFyXhqXqGdrYDoJDSWkk5CyoEqKA==
Date: Tue, 1 Oct 2024 18:06:21 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Lee Jones
 <lee@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Derek Kiernan
 <derek.kiernan@amd.com>, Dragan Cvetic <dragan.cvetic@amd.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Bjorn Helgaas
 <bhelgaas@google.com>, Philipp Zabel <p.zabel@pengutronix.de>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>, Daniel Machon
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
Subject: Re: [PATCH v6 1/7] dt-bindings: reset: microchip,rst: Allow to
 replace cpu-syscon by an additional reg item
Message-ID: <20241001180621.76e497d0@bootlin.com>
In-Reply-To: <emcl3vfclrmy273kknsakpqpzolvo5vohrjnw64ml3op4dwzvu@lwqfgc7jxxzq>
References: <20240930121601.172216-1-herve.codina@bootlin.com>
	<20240930121601.172216-2-herve.codina@bootlin.com>
	<emcl3vfclrmy273kknsakpqpzolvo5vohrjnw64ml3op4dwzvu@lwqfgc7jxxzq>
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

Hi Krystoff,

On Tue, 1 Oct 2024 08:43:23 +0200
Krzysztof Kozlowski <krzk@kernel.org> wrote:

> On Mon, Sep 30, 2024 at 02:15:41PM +0200, Herve Codina wrote:
> > In the LAN966x PCI device use case, syscon cannot be used as syscon
> > devices do not support removal [1]. A syscon device is a core "system"
> > device and not a device available in some addon boards and so, it is not
> > supposed to be removed.  
> 
> That's not accurate. syscon is our own, Linux term which means also
> anything exposing set of registers.
> 
> If you need to unload syscons, implement it. syscon is the same resource
> as all others so should be handled same way.
> 
> > 
> > In order to remove the syscon device usage, allow the reset controller
> > to have a direct access to the address range it needs to use.  
> 
> So you map same address twice? That's not good, because you have no
> locking over concurrent register accesses.
> 

I will remove this patch and keep using the syscon node in the next
iteration.

Best regards,
Hervé

