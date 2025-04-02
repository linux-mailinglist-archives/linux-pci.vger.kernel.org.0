Return-Path: <linux-pci+bounces-25177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96CBA79081
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 15:59:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2AE188837B
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 13:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 561D2239089;
	Wed,  2 Apr 2025 13:54:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011A1F0E2C;
	Wed,  2 Apr 2025 13:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743602040; cv=none; b=JPA0sXKoPSrYjW5+MQfH6UDNgtlAULQkrBFPTzOdCPMOtIbn9m8fZZkreR1Srap3bZCbiZwVGCcVUM7z+CXdCojYHvgnwnnN+eFEsneDz54z6refH3eVS487PLvgbNX9voq8UYVwiTpEvCjwNMry9CeEUaUsVomvBGmu0KEVMxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743602040; c=relaxed/simple;
	bh=aOZNgvVLBoypuzGsbqohzl0A1wyP5ZOeZNvJPxVLBI8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mI/g+c4BJILsxfCgeer4GMPsWXABGjkpoX7V7xQ+OloBa3zVYe4gEHitmIomt8OyKGNg1UPg0E9UDjMWLgv1oKZw3As/QM06kOJPFSnhwKyODnADEuCqg6CtLoniVPQ8lA3dSne5dopGE/pS0/XNPcX/rFxqFoZq2wvf+L89iSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZSRCg0QHcz6L4vn;
	Wed,  2 Apr 2025 21:53:19 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 377B11400D7;
	Wed,  2 Apr 2025 21:53:55 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 2 Apr
 2025 15:53:54 +0200
Date: Wed, 2 Apr 2025 14:53:52 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Philipp Stanner <pstanner@redhat.com>
CC: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Philipp Stanner
	<phasta@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Jens Axboe
	<axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, Mark Brown
	<broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Damien Le Moal
	<dlemoal@kernel.org>, Yang Yingliang <yangyingliang@huawei.com>, Zijun Hu
	<quic_zijuhu@quicinc.com>, Hannes Reinecke <hare@suse.de>, Al Viro
	<viro@zeniv.linux.org.uk>, Li Zetao <lizetao1@huawei.com>, Anuj Gupta
	<anuj20.g@samsung.com>, <linux-doc@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-block@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 0/2] PCI: Remove pcim_iounmap_regions()
Message-ID: <20250402145352.00007531@huawei.com>
In-Reply-To: <323da53fe2ec06c9cc5d1939a9e003c5bd2a0716.camel@redhat.com>
References: <20250327110707.20025-2-phasta@kernel.org>
	<Z-U5vIbVDZLe9QnM@smile.fi.intel.com>
	<323da53fe2ec06c9cc5d1939a9e003c5bd2a0716.camel@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 02 Apr 2025 09:58:24 +0200
Philipp Stanner <pstanner@redhat.com> wrote:

> On Thu, 2025-03-27 at 13:42 +0200, Andy Shevchenko wrote:
> > On Thu, Mar 27, 2025 at 12:07:06PM +0100, Philipp Stanner wrote: =20
> > > The last remaining user of pcim_iounmap_regions() is mtip32 (in
> > > Linus's
> > > current master)
> > >=20
> > > So we could finally remove this deprecated API. I suggest that this
> > > gets
> > > merged through the PCI tree. =20
> >=20
> > Good god! One API less, +1 to support this move.
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >  =20
> > > (I also suggest we watch with an eagle's
> > > eyes for folks who want to re-add calls to that function before the
> > > next
> > > merge window opens). =20
> >=20
> > Instead of this I suggest that PCI can take this before merge window
> > finishes
> > and cooks the (second) PR with it. In such a case we wouldn't need to
> > care,
> > the developers will got broken builds.
> >  =20
>=20
> Normally Bjorn / PCI lets changes settle on a branch for >1 week before
> throwing them at mainline =E2=80=93 but if we ask him very very nicely, m=
aybe
> he would make an exception for this special case? :)
>=20
linux-next should deal with any new users anyway so I wouldn't worry
about it.  Anyone who still has trees destined for the next merge window
that aren't in next gets to deal with Linus being very grumpy at them.

Jonathan

> P.
>=20
>=20
>=20


