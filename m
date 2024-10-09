Return-Path: <linux-pci+bounces-14078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC79966DC
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 12:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA9291F224B3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Oct 2024 10:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E629F190072;
	Wed,  9 Oct 2024 10:16:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9AA183CC9
	for <linux-pci@vger.kernel.org>; Wed,  9 Oct 2024 10:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728468985; cv=none; b=SWBA0/wkVZ0H551YhwX4LxoZTvK0rnPjB+j+vWt/6bTHeZlR61bdO+HJWPOzAQwFKfM6FG/XOwDYuynrgB0ekKDQjFO2QcOxyGNIAslZJSIDYOxiYJiGjFu8Ofbde89C1RJdGjXZFeWvmE82+nYypi7uDpsVxz+JE7YKloebjqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728468985; c=relaxed/simple;
	bh=AyNi6kz1dtLK9KT0flyMxn2iebZ96GLBi6jR1ZKjEA4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eDoWok6tVOl3b68o0Gka4bNFmUZ+1u/ofxOpmJ5zoxzJAa0t5H2LbgHOvBIcQ6UjLLF/SaPYWGmiLn5F6xoDn1TzbmgHOL5KjDwtCLypQ4HwVGRc8msvgMFDSif2nBSiKGg3t851eX19P94h5cnyYUoq027FsdwEoRYbOD8Vhv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTjV-00081A-8w; Wed, 09 Oct 2024 12:15:53 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTjU-000a12-PY; Wed, 09 Oct 2024 12:15:52 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1syTjU-0006xv-2E;
	Wed, 09 Oct 2024 12:15:52 +0200
Message-ID: <7ddcb4e6d3eafd3b2cf40710882b6491c73dba9e.camel@pengutronix.de>
Subject: Re: [PATCH v7 5/6] reset: mchp: sparx5: Allow building as a module
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
 <thomas.petazzoni@bootlin.com>, =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?=
 <clement.leger@bootlin.com>
Date: Wed, 09 Oct 2024 12:15:52 +0200
In-Reply-To: <20241003081647.642468-6-herve.codina@bootlin.com>
References: <20241003081647.642468-1-herve.codina@bootlin.com>
	 <20241003081647.642468-6-herve.codina@bootlin.com>
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
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>=20
> This reset controller can be used by the LAN966x PCI device.
>=20
> The LAN966x PCI device driver can be built as a module and this reset
> controller driver has no reason to be a builtin driver in that case.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

