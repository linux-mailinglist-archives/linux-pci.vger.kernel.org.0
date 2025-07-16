Return-Path: <linux-pci+bounces-32253-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E380B0718D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 11:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E15465015E6
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 09:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD9C28A1D1;
	Wed, 16 Jul 2025 09:23:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81132BFC85;
	Wed, 16 Jul 2025 09:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752657815; cv=none; b=FnSBJKHAk+8t4IZfZmcfloOinkpMa2qWyZmhzZNvqSJEB8JRP81tT22bLWMm27uRETvRBkeKR4+6+iHjYGfEyErxMlEtb3Q5i2W+aYP+4OEJ4UROUQk68tBOIOXUH1eesnTD1njurF0ccd2z7yniiz2ebwdrDvA3YwQcxN6PQc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752657815; c=relaxed/simple;
	bh=nIw50wvMBSzzyxFwSsDu5oFDKjklXIKlkflt+XNJNAc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nBnRbxnuPxxRT+YdD6GJiGrRG++UT5l6MlkQ/vecvIBXyXIsuqF1Jc7xACRcG7bwecSGBf4W8PwWqRnE1j5oNiWwLca8+GYbaJ4HsEwW9s0ogUvqTNJK+GW7nJkYBvV/LpfeqVlHwZv165AjisesB0rsIQjsrkJUaXAai4dADkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bhr9n1MDkz6L50s;
	Wed, 16 Jul 2025 17:19:57 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BF4F1400D7;
	Wed, 16 Jul 2025 17:23:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 16 Jul
 2025 11:23:29 +0200
Date: Wed, 16 Jul 2025 10:23:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Matthew Wood <thepacketgeek@gmail.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH pci-next v1 0/1] PCI/sysfs: Expose PCIe device serial
 number
Message-ID: <20250716102327.00004dd7@huawei.com>
In-Reply-To: <CADvopvZZKCdwT=XfaJzgFRgH=eXcTmjsdA8-86hJaki5PDjx=A@mail.gmail.com>
References: <20250713011714.384621-1-thepacketgeek@gmail.com>
	<20250715121929.00007ef2@huawei.com>
	<CADvopvZZKCdwT=XfaJzgFRgH=eXcTmjsdA8-86hJaki5PDjx=A@mail.gmail.com>
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

On Tue, 15 Jul 2025 08:59:42 -0700
Matthew Wood <thepacketgeek@gmail.com> wrote:

> On Tue, Jul 15, 2025 at 4:19=E2=80=AFAM Jonathan Cameron
> <Jonathan.Cameron@huawei.com> wrote:
> >
> > On Sat, 12 Jul 2025 18:17:12 -0700
> > Matthew Wood <thepacketgeek@gmail.com> wrote:
> > =20
> > > Add a single sysfs read-only interface for reading PCIe device serial
> > > numbers from userspace in a programmatic way. This device attribute
> > > uses the same 2-byte dashed formatting as lspci serial number capabil=
ity
> > > output:
> > >
> > >     more /sys/devices/pci0000:c0/0000:c0:01.1/0000:c1:00.0/0000:c2:1f=
.0/0000:cc:00.0/device_serial_number
> > >     00-80-ee-00-00-00-41-80
> > > =20
> >
> > What is the use case for this? I can think of some possibilities but go=
od to
> > see why you care here. =20
>=20
> Two primary use cases we have are for inventory tooling and health
> check tooling; being able to
> reliably collect device serial numbers for tracking unique devices
> whose BDFs could change is
> critical. Sometimes in the process of hardware troubleshooting, cards
> are swapped and BDF idents
> change but we want to track devices by serial number without possibly
> fragile regexps.

Ok.  So you want to avoid having pull this from lspci output which
makes sense to me. Not sure what Bjorn and others think about this
though.


>=20
> >
> > =20
> > > Accompanying lspci output:
> > >
> > >     sudo lspci -vvv -s cc:00.0
> > >         cc:00.0 Serial Attached SCSI controller: Broadcom / LSI PCIe =
Switch management endpoint (rev b0)
> > >             Subsystem: Broadcom / LSI Device 0144
> > >             ...
> > >             Capabilities: [100 v1] Device Serial Number 00-80-ee-00-0=
0-00-41-80
> > >             ...
> > >
> > > If a device doesn't support the serial number capability, userspace w=
ill receive
> > > an empty read: =20
> >
> > Better if possible to not expose the sysfs attribute if no such capabil=
ity.
> > We already have pcie_dev_attrs_are_visible() so easy to extend that. =20
>=20
> That's a great point, it looks like I could match on the attribute
> name to specifically hide device_serial_number
> if the device does not support the cap, but I can't find any precedent
> for matching on a->name in pci-sysfs.c.
> Would something like this be alright after the check for pci_is_pcie(dev):
>=20
>     if (a->name =3D=3D "device_serial_number") {
>         // check if device has serial, if not return 0
>     }

if (a =3D=3D &dev_attr_device_serial_number.attr)
or something like that.

No need for string matching.

Jonathan


>=20
> >
> > =20
> > >
> > >     more /sys/devices/pci0000:00/0000:00:07.1/device_serial_number
> > >     echo $?
> > >     0
> > >
> > >
> > > Matthew Wood (1):
> > >   PCI/sysfs: Expose PCIe device serial number
> > >
> > >  drivers/pci/pci-sysfs.c | 17 +++++++++++++++++
> > >  1 file changed, 17 insertions(+)
> > > =20
> > =20


