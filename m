Return-Path: <linux-pci+bounces-15192-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4CD9AE2DE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 12:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 102291F23196
	for <lists+linux-pci@lfdr.de>; Thu, 24 Oct 2024 10:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8BD1C8FB5;
	Thu, 24 Oct 2024 10:42:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D103F1C7B6D
	for <linux-pci@vger.kernel.org>; Thu, 24 Oct 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729766554; cv=none; b=ZeCW1kwmc6Mra8xJjngh1psB3NNY2qsC0E1G/RjOTuG9fyn2d5fmO91G+GEv8JYygNU+z1H4IdskmzoF9eTUih5gZZUCJHTsm6wQCPmEHJRga3JM4FoBTdw5RZOgaKI5ExTqarcdJKwd9g5ncoFLhAyO2UxsJB5E5VxT6LzDUlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729766554; c=relaxed/simple;
	bh=sTc5tqVVtSrVkKf0tyuL0UDlunBMKpNJdKFckebZOTM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r/Wnje5vKG3MTYfMFuZ0Mab5hx4tKb4wG9e83rZIrvAwvLnd5Z00UKD2SPW7W/0eoY/u4dwhSS4Bg7Twx8bCqc/If1TNHFGfXN+xDGgEkT/8WFNHfVdzZWp1CjfXPr6CvPqK1+aHM6BxbBuCPb50BixUPKmsyl4PfnFq1+LibWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t3vI7-0005ly-UW; Thu, 24 Oct 2024 12:42:07 +0200
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e] helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t3vI5-000BPM-0K;
	Thu, 24 Oct 2024 12:42:05 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1t3vI4-0007P8-3B;
	Thu, 24 Oct 2024 12:42:04 +0200
Message-ID: <7512cbb7911b8395d926e9e9e390fbb55ce3aea9.camel@pengutronix.de>
Subject: Re: [PATCH v10 0/6] Add support for the LAN966x PCI device using a
 DT overlay
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
Date: Thu, 24 Oct 2024 12:42:04 +0200
In-Reply-To: <20241014124636.24221-1-herve.codina@bootlin.com>
References: <20241014124636.24221-1-herve.codina@bootlin.com>
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

On Mo, 2024-10-14 at 14:46 +0200, Herve Codina wrote:
> Hi,
>=20
> This series adds support for the LAN966x chip when used as a PCI
> device.
[...]

Applied to reset/next, thanks!

[1/6] misc: Add support for LAN966x PCI device
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D185686beb464
[2/6] MAINTAINERS: Add the Microchip LAN966x PCI driver entry
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D86f134941a4b
[3/6] reset: mchp: sparx5: Map cpu-syscon locally in case of LAN966x
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D0426a920d626
[4/6] reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3Deba0dedd27f9
[5/6] reset: mchp: sparx5: Allow building as a module
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D996737ef676f
[6/6] reset: mchp: sparx5: set the dev member of the reset controller
      https://git.pengutronix.de/cgit/pza/linux/commit/?id=3D37b395c2c489

regards
Philipp

