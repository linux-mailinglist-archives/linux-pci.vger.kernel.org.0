Return-Path: <linux-pci+bounces-12617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CBC9683F0
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 12:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F32721C224B6
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 10:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51CCB137C37;
	Mon,  2 Sep 2024 10:01:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C7E86126
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 10:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271294; cv=none; b=e64uddABcE+4ejgPknfHeXeLOtrb7OdjyRbvmKFjVgYQXAdmG8OmfYOP4g6PXWWUXvb3sQZgKLYUzk7LQe0tKo8phklMRvEq+uoTaeon4ZDzPB3GZh9Eom6iL8uo4Lqk1T4cvqk7XJKnP4USMai4+j4CdlLXxMVPC8BD39dWzxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271294; c=relaxed/simple;
	bh=DLwcNSQz8RWmdGdVUt99mUKMNZeOYDfKI+/lFn9dl2Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=s4N28wvnu434zTk5tPmLfrvO1OQ9EUak8s5bOSc1/Z0514Oponf90XuocowpAshhTlwUp0hk1nTyrDOwGzTYb6IGZYxO2/jbI+M4BGtUui+QmOKWQTZhqxJV/GFK46xXxKLS5wCXEkaTADMCUgqTqZU+hyz1hd2W5n4O/juDz54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3rr-00071B-ST; Mon, 02 Sep 2024 12:01:03 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3rp-004sA6-MO; Mon, 02 Sep 2024 12:01:01 +0200
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1sl3rp-000gII-1q;
	Mon, 02 Sep 2024 12:01:01 +0200
Message-ID: <0676fcf89ca07dde911b8759b8e8b10df4bcf6cd.camel@pengutronix.de>
Subject: Re: [PATCH v5 7/8] reset: core: add get_device()/put_device on rcdev
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
 <robh@kernel.org>,  Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>,  Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Horatiu Vultur <horatiu.vultur@microchip.com>, Andrew
 Lunn <andrew@lunn.ch>,  linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, Allan
 Nielsen <allan.nielsen@microchip.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>,  Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, =?ISO-8859-1?Q?Cl=E9ment_L=E9ger?=
 <clement.leger@bootlin.com>
Date: Mon, 02 Sep 2024 12:01:01 +0200
In-Reply-To: <20240808154658.247873-8-herve.codina@bootlin.com>
References: <20240808154658.247873-1-herve.codina@bootlin.com>
	 <20240808154658.247873-8-herve.codina@bootlin.com>
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

On Do, 2024-08-08 at 17:46 +0200, Herve Codina wrote:
> From: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
>=20
> Since the rcdev structure is allocated by the reset controller drivers
> themselves, they need to exists as long as there is a consumer. A call to
> module_get() is already existing but that does not work when using
> device-tree overlays. In order to guarantee that the underlying reset
> controller device does not vanish while using it, add a get_device() call
> when retrieving a reset control from a reset controller device and a
> put_device() when releasing that control.
>=20
> Signed-off-by: Cl=C3=A9ment L=C3=A9ger <clement.leger@bootlin.com>
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/reset/core.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index dba74e857be6..999c3c41cf21 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -812,6 +812,7 @@ __reset_control_get_internal(struct reset_controller_=
dev *rcdev,
>  	kref_init(&rstc->refcnt);
>  	rstc->acquired =3D acquired;
>  	rstc->shared =3D shared;
> +	get_device(rcdev->dev);
> =20
>  	return rstc;
>  }
> @@ -826,6 +827,7 @@ static void __reset_control_release(struct kref *kref=
)
>  	module_put(rstc->rcdev->owner);
> =20
>  	list_del(&rstc->list);
> +	put_device(rstc->rcdev->dev);
>  	kfree(rstc);
>  }

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp

