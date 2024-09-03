Return-Path: <linux-pci+bounces-12675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3770196A387
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9799282DC4
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2024 16:01:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E922F1891B9;
	Tue,  3 Sep 2024 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="c+Fmen+1"
X-Original-To: linux-pci@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3F188903;
	Tue,  3 Sep 2024 16:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725379290; cv=none; b=Yn5Yq+NwPeIZRy1Bw3T0gasA3VH+1LsXF7qSjJU4eCnRmLq4CRD7+SYar2NBDb2VVTUQVW6b9HUI2ZZnDAMGWKPi2Nsy1tYH7Hv3PwfagPE7gJI6dUdy2Ejny0izUBd9IWgTaV4w8raR7SV6C67V/4Nd5ABhuRc/85Iy51NnVz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725379290; c=relaxed/simple;
	bh=JHkZaHTyZr8FrXiNtLB8ONHDQXBeymJgLt3plAsYQ9U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GcFl7jV40vwN7D2LHgHnufBSk8/V3u3WVHBSeENDWPGWPIq8ul+4EYB6q97otQDgjAPGVhWoV2UA2LDWfsT4dE9VcgBEFuout2utDhn463YVO45AyAIoON4KDNf0UKv2BL2W5jhGPGo2AS4xUoH5IsyqOpgGSxRzNY4usmdjRyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=c+Fmen+1; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 1695160003;
	Tue,  3 Sep 2024 16:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725379280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TOEHRL0jTkqVJGqC1aF4rVCGmks2TS1OH/JK8xFsn/A=;
	b=c+Fmen+107aZTxRPesX1RF0jOVv9G1jUVeZALqhujtGQggZXA7w9Up9m2Q8ybdjodWqpK/
	WM+uKhy6OpKV6HrweUA8FA5wjh1QA4ljeH5VoAYJufX0f/z2nnBTXwYrToXqs1C6F+bImD
	5sTuQ+ub2E9GLdELHmZb3HsAWADILFlGNR7iAqLPdUT8Op+8sURREaOQMQUB+pVoRnomcC
	9AFaVAkqVi6FG/bVN/dETRKnJQslq7jw3IMydXJa50GsULYLzKRSh2TZ+KTyDH+JPYbZ+X
	O8MRC1YafAcQsnU92sLa/Cw2YKVTqNXq6U/J/ePSLIaPIRFXW8NdkjdTCbAoFg==
Date: Tue, 3 Sep 2024 18:01:16 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Lee Jones <lee@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Simon Horman <horms@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Philipp Zabel
 <p.zabel@pengutronix.de>, Lars Povlsen <lars.povlsen@microchip.com>, Steen
 Hegelund <Steen.Hegelund@microchip.com>, Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Horatiu Vultur
 <horatiu.vultur@microchip.com>, Andrew Lunn <andrew@lunn.ch>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, Allan Nielsen <allan.nielsen@microchip.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?=
 <clement.leger@bootlin.com>
Subject: Re: [PATCH v5 3/8] mfd: syscon: Add reference counting and device
 managed support
Message-ID: <20240903180116.717a499b@bootlin.com>
In-Reply-To: <20240903153839.GB6858@google.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
	<20240808154658.247873-4-herve.codina@bootlin.com>
	<20240903153839.GB6858@google.com>
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

Hi Lee,

On Tue, 3 Sep 2024 16:38:39 +0100
Lee Jones <lee@kernel.org> wrote:

> On Thu, 08 Aug 2024, Herve Codina wrote:
> 
> > From: Clément Léger <clement.leger@bootlin.com>
> > 
> > Syscon releasing is not supported.
> > Without release function, unbinding a driver that uses syscon whether
> > explicitly or due to a module removal left the used syscon in a in-use
> > state.
> > 
> > For instance a syscon_node_to_regmap() call from a consumer retrieves a
> > syscon regmap instance. Internally, syscon_node_to_regmap() can create
> > syscon instance and add it to the existing syscon list. No API is
> > available to release this syscon instance, remove it from the list and
> > free it when it is not used anymore.
> > 
> > Introduce reference counting in syscon in order to keep track of syscon
> > usage using syscon_{get,put}() and add a device managed version of
> > syscon_regmap_lookup_by_phandle(), to automatically release the syscon
> > instance on the consumer removal.
> > 
> > Signed-off-by: Clément Léger <clement.leger@bootlin.com>
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/mfd/syscon.c       | 138 ++++++++++++++++++++++++++++++++++---
> >  include/linux/mfd/syscon.h |  16 +++++
> >  2 files changed, 144 insertions(+), 10 deletions(-)  
> 
> This doesn't look very popular.
> 
> What are the potential ramifications for existing users?
> 

Existing user don't use devm_syscon_regmap_lookup_by_phandle() nor
syscon_put_regmap().

So refcount is incremented but never decremented. syscon is never
released. Exactly the same as current implementation.
Nothing change for existing users.

Best regards,
Hervé

