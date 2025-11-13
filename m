Return-Path: <linux-pci+bounces-41079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A9C572CC
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 12:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6671934A621
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 11:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5559433ADAF;
	Thu, 13 Nov 2025 11:26:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD82D5C6C;
	Thu, 13 Nov 2025 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763033178; cv=none; b=bdbcI4YDpLDPpCNu0ghCKmKbxZemk4NqSDLWIQhwHhL5RZvIEq8WXnj6fv2fwNEXbvZgXs2YGFZsYz7mrSWDsy3Si5XQmVimSZqF2s16Xxj7ghQGjyaTyBVcbXhxU6fUV8j5+HGL3XEcRQ0HoxevbFbV3QX6zq/Pk+f0zjRJyOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763033178; c=relaxed/simple;
	bh=/FJmqLMHLv/MBteuHFWGYx6Eqd8rC4+Vxc9u9W0jJPk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W3/Rf5tEgvc0STNhfyV/FD+IyUeYyAVBf1F+83Jn44GPOcGAoZLKQvRuDnfttUDd6ss1PYpfHnEAYW78aoKgW5W4/LNf46INnJPA35K7ok6VpQYgD9oBE2dyua8NVN+pj3XAc8UA5kbE8Vz8PDUxiUPaUhTtyjmhSTr782hPl+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d6dHg5CqlzHnGcw;
	Thu, 13 Nov 2025 19:25:51 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id 9CE331402F5;
	Thu, 13 Nov 2025 19:26:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 13 Nov
 2025 11:26:11 +0000
Date: Thu, 13 Nov 2025 11:26:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
CC: <dan.j.williams@intel.com>, Dhruva Gole <d-gole@ti.com>, Frank Li
	<Frank.Li@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux ACPI
	<linux-acpi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, LKML
	<linux-kernel@vger.kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>, Linux
 PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>, Alex
 Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH v1 0/3] PM: runtime: Wrapper macros for usage counter
 guards
Message-ID: <20251113112610.000071df@huawei.com>
In-Reply-To: <CAJZ5v0i0U=BYFH+QmeVjSpcyrVhVR0zjke3Vve3wxnpNzcDcoQ@mail.gmail.com>
References: <13883374.uLZWGnKmhe@rafael.j.wysocki>
	<20251112063941.kbg44srt5f7rfkjb@lcpd911>
	<5068916.31r3eYUQgx@rafael.j.wysocki>
	<6914fbb5a6ce_1d911001b@dwillia2-mobl4.notmuch>
	<CAJZ5v0i0U=BYFH+QmeVjSpcyrVhVR0zjke3Vve3wxnpNzcDcoQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Wed, 12 Nov 2025 22:38:14 +0100
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Wed, Nov 12, 2025 at 10:27=E2=80=AFPM <dan.j.williams@intel.com> wrote:
> >
> > Rafael J. Wysocki wrote: =20
> > > On Wednesday, November 12, 2025 7:39:41 AM CET Dhruva Gole wrote: =20
> > > > On Nov 07, 2025 at 19:35:09 +0100, Rafael J. Wysocki wrote: =20
> > > > > Hi All,
> > > > >
> > > > > The runtime PM usage counter guards introduced recently:
> > > > >
> > > > > https://lore.kernel.org/linux-pm/6196611.lOV4Wx5bFT@rafael.j.wyso=
cki/
> > > > >
> > > > > and then fixed:
> > > > >
> > > > > https://lore.kernel.org/linux-pm/5943878.DvuYhMxLoT@rafael.j.wyso=
cki/
> > > > >
> > > > > should generally work, but using them feels sort of arcane and cr=
yptic
> > > > > even though the underlying concept is relatively straightforward.
> > > > >
> > > > > For this reason, runtime PM wrapper macros around ACQUIRE() and
> > > > > ACQUIRE_ERR() involving the new guards are introduced in this ser=
ies
> > > > > (patch [1/3]) and then used in the code already using the guards =
(patches
> > > > > [2/3] and [3/3]) to make it look more straightforward. =20
> > > >
> > > > The patches look okay to me,
> > > > Reviewed-by: Dhruva Gole <d-gole@ti.com> =20
> > >
> > > Thank you and Jonathan for the tags, but since Frank is not convinced=
, let me
> > > bounce one more idea off all of you.
> > >
> > > Namely, I think that Frank has a point when he wonders if PM_RUNTIME_=
ACQUIRE_ERR
> > > hides too much information and I agree with Jonathan that may be misu=
nderstood,
> > > so what about defining the wrapper macros so they don't hide the guar=
d variable
> > > name, like in the patch below? =20
> >
> > I had been reluctant about offering an enthusiastic tag on this series
> > given that information hiding, but with this change:
> >
> > Reviewed-by: Dan Williams <dan.j.williams@intel.com> =20
>=20
> Thanks!
>=20
> > However, I prefer that the scope variable declaration vs usage
> > (reference) cases should maintain visual separation with an operator,
> > i.e.:
> >
> >         PM_RUNTIME_ACQUIRE(dev, pm);
> >         if (PM_RUNTIME_ACQUIRE_ERR(&pm))
> >                 return -ENXIO;
> >
> > Otherwise we have a case of different flavors of *_ACQUIRE_ERR
> > implementing various styles. I initially looked at hiding the '&':
> >
> > http://lore.kernel.org/681ea7d5ea04b_2a2bb100cf@dwillia2-mobl4.notmuch
> >
> > ...but it grew on me precisely because it provides a clue about how this
> > magic operates. =20
>=20
> Fair enough.
>=20
> I'll resend the series with this change then.
This new option is much nicer and not too verbose.

>=20
> Thank you!
>=20


