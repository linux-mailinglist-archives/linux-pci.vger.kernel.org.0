Return-Path: <linux-pci+bounces-14076-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A139966D1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 565861C20B0F
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:16:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E39E18CBF5;
	Wed,  9 Oct 2024 10:15:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CF318FC7E
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 10:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468958; cv=none; b=snfZ+nL+AZMye1wiYiz23KhJYro6FnBsTWnfGsyWWnWEBbgiPcMUqCPFBBK1l4gfleMXbbNlz66Rxnvu4HmKuI0ja8kE+sAxEpI0nwlxHECBYFmB6thwTwKlRLxiiNZvjFolC+EmH0r9Y8br6fhR73+GJzPFxF8mW2+jGtI52Pc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468958; c=relaxed/simple;
	bh=yRYz0Zsqxya1VheS4IuNYc94S2kSLleMvc7LIeAdnm4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LCmhSUdJrXO4guVB92g9mzEO+AIaTb6+qPYWKiugIRdwiqBrtLGXcrK/Oc4XJw8SQMNfxkxgOmuJ9VYUJFyjuFlqXSmanj7bo1GSTiKiIj3YzBZb8rBFJe+mLqK3DoI6QmoTYMotYvHn9W9oBLuqnozhHd6nnC8dMiJy4FcWTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTj3-0007zK-PU; Wed, 09 Oct 2024 12:15:25 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTj1-000a0s-NJ; Wed, 09 Oct 2024 12:15:23 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTiw-0006sP-1q;
	Wed, 09 Oct 2024 12:15:18 +0200
Message-ID: <7c9f8ccc145bc9f62d3e5baaab24d1e4f6378436.camel@pengutronix.de>
Subject: Re: [PATCH v7 3/6] reset: mchp: sparx5: Map cpu-syscon locally in
 case of LAN966x
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Herve Codina <herve.codina@bootlin.com>, Geert Uytterhoeven
 <geert@linux-m68k.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Simon
 Horman <horms@kernel.org>, Lee Jones <lee@kernel.org>, Arnd Bergmann
 <arnd@arndb.de>, Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Lars Povlsen
 <lars.povlsen@microchip.com>, Steen Hegelund
 <Steen.Hegelund@microchip.com>,  Daniel Machon
 <daniel.machon@microchip.com>, UNGLinuxDriver@microchip.com, Rob Herring
 <robh@kernel.org>,  Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew
 Lunn <andrew@lunn.ch>,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>
Date: Wed, 09 Oct 2024 12:15:18 +0200
In-Reply-To: <20241003081647.642468-4-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
	 <20241003081647.642468-4-herve.codina@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-pci@vger.kernel.org

On Do, 2024-10-03 at 10:16 +0200, Herve Codina wrote:
> In the LAN966x PCI device use case, the syscon API cannot be used as
> it does not support device removal [1]. A syscon device is a core
> "system" device and not a device available in some addon boards and so,
> it is not supposed to be removed. The syscon API follows this assumption
> but this assumption is no longer valid in the LAN966x use case.
>=20
> In order to avoid the use of the syscon API and so, support for removal,
> use a local mapping of the syscon device.
>=20
> Link: https://lore.kernel.org/all/20240923100741.11277439@bootlin.com/ [1=
]
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

