Return-Path: <linux-pci+bounces-43873-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 949E7CEBB16
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 10:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 88A16300E7A1
	for <lists+linux-pci@lfdr.de>; Wed, 31 Dec 2025 09:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EEA1A9F84;
	Wed, 31 Dec 2025 09:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XolYBTwt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B58381A3154;
	Wed, 31 Dec 2025 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767173517; cv=none; b=R6CMr+C0+tSUQqXxSaQMZyDlVypFGMwpaz/u8CuvAcboaMskQ5fJ80ChW5rctIBB1RDFppzLmk6dpeB3hNepNrTq5wmpc7pb12hOWM2sEwrxp0dXhjqWzStHHJ0eVER+klMDdKFwQJa1PGjxNBIoER2FF/uN9DiiBDA1oBcU/Pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767173517; c=relaxed/simple;
	bh=Cm8AKkvcpJMoNVw9C4YN/wpCsSs5XCQtRr1DqMBlmwI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=otNUXlPQ7QcSSz+Q0JrHUvfGHJK2MAxmDtgq1QFjigtS3CdH0PsZ1SZbN50LNWJbVpSCP1L2DbqgDa76P2nJ4LSfrlDsNZVOeiCJwYb8bKZ+kuxqRHYtTI7pK63f8hUyAtBk8vI39Z6UFcl/C8B9Wmzb/Qbi4mo5eILCTlwx8dA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XolYBTwt; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767173516; x=1798709516;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Cm8AKkvcpJMoNVw9C4YN/wpCsSs5XCQtRr1DqMBlmwI=;
  b=XolYBTwtkntCpezeGFZpeEXmclfu08avcAnPEk2HGebBpjLDnDmRBWfU
   5kDUBNWfOwIeOX9FZFxDrwwf3sJqJmQQTVGyjJGgk7mQ819nfmmZVc9Wc
   hcZqyMOv5LUpAlBvACNKphbAgCwW5XHr7B5xgFT0KD2gayjSN22c1KKwy
   TOxFkjyLtWb/2rza/C0Teayi0IJHwjxrsEalumyhbo2ztqNRSH8GuqY5+
   bT54S9/WANZgUI3rfbg34sQyEfRy7m09QW6L9gYWtYpWKvS8tvccsOXFX
   CZna7fh7va/n5vWtNM2gUPssc5SBWIW068dK7MtQ2Iv7oHQIiKfsyAfev
   Q==;
X-CSE-ConnectionGUID: EmKsdChwTTC7/MCgommwcA==
X-CSE-MsgGUID: SyPdRBCrQ6imQISjYBK3Pw==
X-IronPort-AV: E=McAfee;i="6800,10657,11657"; a="68905822"
X-IronPort-AV: E=Sophos;i="6.21,191,1763452800"; 
   d="scan'208";a="68905822"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 01:31:56 -0800
X-CSE-ConnectionGUID: NthBinKCQ/GUylTn8dfbOQ==
X-CSE-MsgGUID: XBhhdhAgQmyXyAGYNr8xLQ==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.186])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2025 01:31:51 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 31 Dec 2025 11:31:47 +0200 (EET)
To: duziming <duziming2@huawei.com>, Bjorn Helgaas <helgaas@kernel.org>
cc: bhelgaas@google.com, jbarnes@virtuousgeek.org, chrisw@redhat.com, 
    alex.williamson@redhat.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, liuyongqiang13@huawei.com, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kwilczynski@kernel.org>
Subject: Re: [PATCH v2 2/3] PCI: Prevent overflow in proc_bus_pci_write()
In-Reply-To: <6c63e3b4-c542-4a9f-bc9f-fa214a139039@huawei.com>
Message-ID: <b5cc94da-23e7-0185-0b5a-b35125234af4@linux.intel.com>
References: <20251229180742.GA69587@bhelgaas> <6c63e3b4-c542-4a9f-bc9f-fa214a139039@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-439192124-1767173507=:1053"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-439192124-1767173507=:1053
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 30 Dec 2025, duziming wrote:
> =E5=9C=A8 2025/12/30 2:07, Bjorn Helgaas =E5=86=99=E9=81=93:
> > [+cc Krzysztof; I thought we looked at this long ago?]
> >=20
> > On Wed, Dec 24, 2025 at 05:27:18PM +0800, Ziming Du wrote:
> > > From: Yongqiang Liu <liuyongqiang13@huawei.com>
> > >=20
> > > When the value of ppos over the INT_MAX, the pos is over set to a neg=
tive
> > > value which will be passed to get_user() or pci_user_write_config_dwo=
rd().
> > > Unexpected behavior such as a softlock will happen as follows:
> > s/negtive/negative/
> > s/softlock/soft lockup/ to match message below
> Thanks for pointing out the ambiguous parts.
> > s/ppos/pos/ (or fix this to refer to "*ppos", which I think is what
> > you're referring to)
> >=20
> > I guess the point is that proc_bus_pci_write() takes a "loff_t *ppos",
> > loff_t is a signed type, and negative read/write offsets are invalid.
>=20
> Actually, the *loff_t *ppos *passed in is not a negative value. The root =
cause
> of the issue
>=20
> lies in the cast *int* *pos =3D *ppos*. When the value of **ppos* over th=
e
> INT_MAX, the pos is over set
>=20
> to a negative value. This negative *pos* then propagates through subseque=
nt
> logic, leading to the observed errors.
>=20
> > If this is easily reproducible with "dd" or similar, could maybe
> > include a sample command line?
>=20
> We reproduced the issue using the following POC:
>=20
> =C2=A0 =C2=A0 #include <stdio.h>
>=20
> =C2=A0 =C2=A0 #include <string.h>
> =C2=A0 =C2=A0 #include <unistd.h>
> =C2=A0 =C2=A0 #include <fcntl.h>
> =C2=A0 =C2=A0 #include <sys/uio.h>
>=20
> =C2=A0 =C2=A0 int main() {
> =C2=A0 =C2=A0 int fd =3D open("/proc/bus/pci/00/02.0", O_RDWR);
> =C2=A0 =C2=A0 if (fd < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 perror("open failed");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> =C2=A0 =C2=A0 }
> =C2=A0 =C2=A0 char data[] =3D "926b7719201054f37a1d9d391e862c";
> =C2=A0 =C2=A0 off_t offset =3D 0x80800001;
> =C2=A0 =C2=A0 struct iovec iov =3D {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .iov_base =3D data,
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 .iov_len =3D 0xf
> =C2=A0 =C2=A0 };
> =C2=A0 =C2=A0 pwritev(fd, &iov, 1, offset);
> =C2=A0 =C2=A0 return 0;
> }
>=20
> > >   watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
> > >   RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
> > >   Call Trace:
> > >    <TASK>
> > >    pci_user_write_config_dword+0x126/0x1f0
> > >    proc_bus_pci_write+0x273/0x470
> > >    proc_reg_write+0x1b6/0x280
> > >    do_iter_write+0x48e/0x790
> > >    vfs_writev+0x125/0x4a0
> > >    __x64_sys_pwritev+0x1e2/0x2a0
> > >    do_syscall_64+0x59/0x110
> > >    entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > >=20
> > > Fix this by add check for the pos.
> > >=20
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > Signed-off-by: Ziming Du <duziming2@huawei.com>
> > > ---
> > >   drivers/pci/proc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> > > index 9348a0fb8084..200d42feafd8 100644
> > > --- a/drivers/pci/proc.c
> > > +++ b/drivers/pci/proc.c
> > > @@ -121,7 +121,7 @@ static ssize_t proc_bus_pci_write(struct file *fi=
le,
> > > const char __user *buf,
> > >   =09if (ret)
> > >   =09=09return ret;
> > >   -=09if (pos >=3D size)
> > > +=09if (pos >=3D size || pos < 0)
> > >   =09=09return 0;
> > I see a few similar cases that look like this; maybe we should do the
> > same?
> >=20
> >    if (pos < 0)
> >      return -EINVAL;
> >=20
> > Looks like proc_bus_pci_read() has the same issue?
>=20
> proc_bus_pci_read() may also trigger similar issue as mentioned by Ilpo
> J=C3=A4rvinen in
>=20
> https://lore.kernel.org/linux-pci/e5a91378-4a41-32fb-00c6-2810084581bd@li=
nux.intel.com/
>=20
> However, it does not result in an overflow to a negative number.

Why does the cast has to happen first here?

This would ensure _correctness_ without any false alignment issues for=20
large numbers:

=09int pos;
=09int size =3D dev->cfg_size;

=09...
=09if (*ppos > INT_MAX)
=09=09return -EINVAL;
=09pos =3D *ppos;

(I'm not sure though if this should return 0 or -EINVAL when *ppos >=3D=20
size as it currently returns 0 for non-overflowing values when pos >=3D=20
size.)

--=20
 i.


> > What about pci_read_config(), pci_write_config(),
> > pci_llseek_resource(), pci_read_legacy_io(), pci_write_legacy_io(),
> > pci_read_resource_io(), pci_write_resource_io(), pci_read_rom()?
> > These are all sysfs things; does the sysfs infrastructure take care of
> > negative offsets before we get to these?
>=20
> In do_pwritev(), the following check has been performed:
>=20
> =C2=A0 =C2=A0if (pos < 0)
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return -EINVAL;
>=20
> Theoretically, a negative offset should not occur.
>=20
> > >   =09if (nbytes >=3D size)
> > >   =09=09nbytes =3D size;

--8323328-439192124-1767173507=:1053--

