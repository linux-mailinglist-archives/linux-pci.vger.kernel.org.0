Return-Path: <linux-pci+bounces-36260-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C90B5984C
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 15:55:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 289B23A6C31
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 13:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72E63203B4;
	Tue, 16 Sep 2025 13:54:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13AD831A05B;
	Tue, 16 Sep 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758030852; cv=none; b=ILZUBfiIIeu4rsqoPiZ0CQrZp0JrN5VA+gDpzdlb9juMsay4hiDr56d200sCqe6+JQWX6MPVzYd7euFgK84eRlT/0fVxxjz0LorySiXJi+PiHQLqhs6HLPraSj26NsP8gthifJ/ExcfFO6pDWT+kzqfIwAoTEu5NVWLZBQhi1wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758030852; c=relaxed/simple;
	bh=vQX07VrDvNZ54F535FxdtJdQJ6Lebbt7jbH1jt8/C9A=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ev0/EPrlzO/xOAQ20g5Mll64hMZgVmXYwB/4LV2FSbDM10/tFXqX/Y9HSYW/LzEP93TycOtRI1FB7Pf5eeb3Hx6L1Xk1usQHEK+9fWcZotUiqFrAL49yW6+DmsJ2t4+TG2Gkd1lkJZ+GXkaORCOnSytrqQ+vui+++32okX1yZdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cR3DB1L80z6L51n;
	Tue, 16 Sep 2025 21:49:30 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 768191402FC;
	Tue, 16 Sep 2025 21:53:59 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 16 Sep
 2025 15:53:58 +0200
Date: Tue, 16 Sep 2025 14:53:57 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Keith Busch <kbusch@kernel.org>
CC: Krzysztof =?ISO-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>, Matthew Wood
	<thepacketgeek@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, "Mario
 Limonciello" <superm1@kernel.org>, Thomas =?ISO-8859-1?Q?Wei=DFschuh?=
	<thomas.weissschuh@linutronix.de>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [RESEND PATCH v7 1/1] PCI/sysfs: Expose PCIe device serial
 number
Message-ID: <20250916145357.00007ebb@huawei.com>
In-Reply-To: <aMiRy_gJ4MQjgaS7@kbusch-mbp>
References: <20250821232239.599523-1-thepacketgeek@gmail.com>
	<20250821232239.599523-2-thepacketgeek@gmail.com>
	<20250913062041.GB1992308@rocinante>
	<aMiRy_gJ4MQjgaS7@kbusch-mbp>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 15 Sep 2025 16:23:07 -0600
Keith Busch <kbusch@kernel.org> wrote:

> On Sat, Sep 13, 2025 at 03:20:41PM +0900, Krzysztof Wilczy=B4nski wrote:
> > Hello,
> >  =20
> > > @@ -1749,10 +1767,13 @@ static umode_t pcie_dev_attrs_are_visible(str=
uct kobject *kobj,
> > >  	struct device *dev =3D kobj_to_dev(kobj);
> > >  	struct pci_dev *pdev =3D to_pci_dev(dev);
> > > =20
> > > -	if (pci_is_pcie(pdev))
> > > -		return a->mode;
> > > +	if (!pci_is_pcie(pdev))
> > > +		return 0;
> > > =20
> > > -	return 0;
> > > +	if (a =3D=3D &dev_attr_serial_number.attr && !pci_get_dsn(pdev))
> > > +		return 0;
> > > +
> > > +	return a->mode; =20
> >=20
> > It would be fine to have this sysfs attribute present all the time, and
> > simply return error when the serial number is not available.  Not sure =
if
> > hiding it adds a lot of value.  This is how some of the existing attrib=
utes
> > currently behave.
> >=20
> > But it does add extra code to pcie_dev_attrs_are_visible() where it is =
now
> > a special case, somewhat. =20
>=20
> You bring up a good point, but I think it seems odd that the existing
> pcie attributes are visible even if we know reading it will fail.

Perhaps historical. The is_visible infrastructure is I think somewhat
newer than a lot of that ABI.

> Perhaps the pcie link status visibility should be changed to follow this
> patch's example to hide when they don't exist. Applications might notice
> a different error, ENOENT vs EINVAL, if the device doesn't support the
> capability, but that is a more accurate errno.

As it is sysfs we can never be sure someone hasn't assumed existing files
are present even when they aren't useful.

So I doubt we can improve the existing cases without something breaking.
If we want to give it a go and see who screams I'm fine with that :)

Jonathan




