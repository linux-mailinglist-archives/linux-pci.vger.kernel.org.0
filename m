Return-Path: <linux-pci+bounces-32633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E24B0C0A4
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F054E07D6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:48:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 936B11C32FF;
	Mon, 21 Jul 2025 09:48:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668F7224254;
	Mon, 21 Jul 2025 09:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753091308; cv=none; b=ccO40Vv3w7I4fxPJT8RG2iHyhp1Hymq4L3gOvyNXy2Ox/McQR18FlQWi70ED0ILTuKwQbGvq878G6O3s7sMnKeJdfnBogPTSeNFtoTMUDQQ30OeIfWemU64bJp3ZnvTjxgMJ00Ui+rIGL4ixPRWwPE9QA+rO786qJQ9XsHNk2vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753091308; c=relaxed/simple;
	bh=VD8dX6xKkJvFwhWE/+3tcU+thqZCccdxaLH0Hg2g770=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DCLLYkiOQf8d57Iv74KCgrdjAySUrTY/Kv8kQE/zhEzYv8IN/PUPFdfJE6G59ZZRqtnZgfA1RpBpcePe+uTrF2MEDv9Yg7Mna0aHoUmAHHclA0zseXM6YysObxE/Y7y1ymeLI6p4vSE2y4i52fMqj6YTtdhdnYq/EPGeeIgM8r0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4blwXW2mncz6L5QP;
	Mon, 21 Jul 2025 17:46:51 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B6E9214038F;
	Mon, 21 Jul 2025 17:48:17 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 21 Jul
 2025 11:48:17 +0200
Date: Mon, 21 Jul 2025 10:48:16 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Thomas =?ISO-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
CC: Matthew Wood <thepacketgeek@gmail.com>, Bjorn Helgaas
	<bhelgaas@google.com>, Mario Limonciello <superm1@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5 1/1] PCI/sysfs: Expose PCIe device serial number
Message-ID: <20250721104816.00003feb@huawei.com>
In-Reply-To: <20250718125935-75fa0343-af78-42be-bc3f-e8f806a4aee5@linutronix.de>
References: <20250717165056.562728-1-thepacketgeek@gmail.com>
	<20250717165056.562728-2-thepacketgeek@gmail.com>
	<20250718113611.00003c78@huawei.com>
	<20250718125935-75fa0343-af78-42be-bc3f-e8f806a4aee5@linutronix.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 18 Jul 2025 13:02:00 +0200
Thomas Wei=DFschuh <thomas.weissschuh@linutronix.de> wrote:

> On Fri, Jul 18, 2025 at 11:36:11AM +0100, Jonathan Cameron wrote:
> > On Thu, 17 Jul 2025 09:50:54 -0700
> > Matthew Wood <thepacketgeek@gmail.com> wrote: =20
>=20
> (...)
>=20
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 268c69daa4d5..bc0e0add15d1 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -239,6 +239,22 @@ static ssize_t current_link_width_show(struct de=
vice *dev,
> > >  }
> > >  static DEVICE_ATTR_RO(current_link_width);
> > > =20
> > > +static ssize_t serial_number_show(struct device *dev,
> > > +				       struct device_attribute *attr, char *buf)
> > > +{
> > > +	struct pci_dev *pci_dev =3D to_pci_dev(dev);
> > > +	u64 dsn;
> > > +
> > > +	dsn =3D pci_get_dsn(pci_dev);
> > > +	if (!dsn)
> > > +		return -EIO;
> > > +
> > > +	return sysfs_emit(buf, "%02llx-%02llx-%02llx-%02llx-%02llx-%02llx-%=
02llx-%02llx\n",
> > > +		dsn >> 56, (dsn >> 48) & 0xff, (dsn >> 40) & 0xff, (dsn >> 32) & 0=
xff,
> > > +		(dsn >> 24) & 0xff, (dsn >> 16) & 0xff, (dsn >> 8) & 0xff, dsn & 0=
xff); =20
> >=20
> > I wonder if doing the following i too esoteric. Eyeballing those shifts=
 is painful.
> >=20
> > 	u8 bytewise[8]; /* naming hard... */
> >=20
> > 	put_unaligned_u64(dsn, bytewise);
> >=20
> > 	return sysfs_emit(buf, "%02x-%02x-%02x-%02x-%02x-%02x-%02x-%02x\n",
> > 		bytewise[0], bytewise[1], bytewise[2], bytewise[3],
> > 		bytewise[4], bytewise[5], bytewise[6], bytewise[7]); =20
>=20
> This looks endianess-unsafe.
>=20
> Maybe just do what some drivers are doing:
>=20
> 	u8 bytes[8];
>=20
> 	put_unaligned_be64(dsn, bytes);
Absolutely. Typo :(  I don't think there is a put_unaligned_u64()

>=20
> 	return sysfs_emit(buf, "%8phD");
>=20
> >=20
> >  =20
> > > +}
> > > +static DEVICE_ATTR_ADMIN_RO(serial_number); =20
> >=20
> >  =20
>=20


