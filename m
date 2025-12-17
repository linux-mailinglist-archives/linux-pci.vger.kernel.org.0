Return-Path: <linux-pci+bounces-43162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70C23CC7314
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 11:58:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 12E6631B7230
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 10:48:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F5635CBA9;
	Wed, 17 Dec 2025 10:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lRYSJfnF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C72435CBA0;
	Wed, 17 Dec 2025 10:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966542; cv=none; b=f+Ky8HQARtobNvdTPNNu2TaSTa8rObbHJaV4x4JTOQUobqjcTv4gVW2xIlRgDwidm6abFtrFIXrPkEsJPACtqXkXuILSX9y33fy9dHE2u8cck4slqX/bBmHYvRGMMarcNE5+mLboxnEKR9puzBoMQc5t2U6A0wYhyCl/xVd2yKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966542; c=relaxed/simple;
	bh=QeoZgiNpFpChGlOl6gHgb6QuxzGC4zMkBab9Wtkluw0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Dj/xtokJP7zXaDVPwhkqtUwdRxT0R+Qeyu0jKLiIjtGrK4RforSVLad1opBWNc3ALx+F4NJEPJ6k9JWpbhap03a1Ui2J2Gf89GA4CHdSQW0C1Foy2Z85xRKUfgyPBBnWULooVVl3bsM8mt2A3E3TN4jncq5MJHN5DswG3qHyFfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lRYSJfnF; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765966539; x=1797502539;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QeoZgiNpFpChGlOl6gHgb6QuxzGC4zMkBab9Wtkluw0=;
  b=lRYSJfnFKdAdklbEUUXxVqB5kcVSOzxk2BfYWw3tEeyApxt37zxnNajX
   nOguEh/UVOlYaa2913d2XwKCwi0bcf11yBTqhgLcZ2rWFb4rwByePYzrL
   i0TsCDduBb/jw9JedZOoXU4Kv913dcY6vJXacEJArHDfDViSJSjYorwYt
   vbVyP9dNgoF3tr5cN7xqeRMWLmyqIHI5o2eZJTlUxYn3JQ+uiH1P4in+W
   Q9GgMrpCWLu2ccS+UkKWHj1zZUZjiQvts7tD6uR/qvtI89sIYJYhXuhNG
   wuwKwTO/upVftwxe5CD0ntBZaa0ehJ/h/ky9CPbr/ikrcEFNW7fKrApYn
   Q==;
X-CSE-ConnectionGUID: +iimuEoZTS6CLRkBnorJVw==
X-CSE-MsgGUID: n99/1OuEQYuMyrm6zinsNg==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="55473719"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="55473719"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:15:39 -0800
X-CSE-ConnectionGUID: 6wIFnSCLSW+eJmgC9n5Tbg==
X-CSE-MsgGUID: XUvc2FzMQVuRnB1pZle3fQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="203170997"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:15:29 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Dec 2025 12:15:26 +0200 (EET)
To: duziming <duziming2@huawei.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, chrisw@redhat.com, 
    jbarnes@virtuousgeek.org, alex.williamson@redhat.com, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH 2/3] PCI/sysfs: Prohibit unaligned access to I/O port on
 non-x86
In-Reply-To: <e954fe32-4a6b-458f-97a7-d9fbefc48144@huawei.com>
Message-ID: <f099dd63-ad76-bc55-2e20-89462593a12e@linux.intel.com>
References: <20251216083912.758219-1-duziming2@huawei.com> <20251216083912.758219-3-duziming2@huawei.com> <43e40c50-e23b-0ebc-9f82-986b2ea55943@linux.intel.com> <e954fe32-4a6b-458f-97a7-d9fbefc48144@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1408250814-1765966526=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1408250814-1765966526=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Dec 2025, duziming wrote:

>=20
> =E5=9C=A8 2025/12/16 18:43, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Tue, 16 Dec 2025, Ziming Du wrote:
> >=20
> > > From: Yongqiang Liu <liuyongqiang13@huawei.com>
> > >=20
> > > Unaligned access is harmful for non-x86 archs such as arm64. When we
> > > use pwrite or pread to access the I/O port resources with unaligned
> > > offset, system will crash as follows:
> > >=20
> > > Unable to handle kernel paging request at virtual address fffffbfffe8=
010c1
> > > Internal error: Oops: 0000000096000061 [#1] SMP
> > > Modules linked in:
> > > CPU: 1 PID: 44230 Comm: syz.1.10955 Not tainted 6.6.0+ #1
> > > Hardware name: linux,dummy-virt (DT)
> > > pstate: 20000005 (nzCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > > pc : __raw_writew arch/arm64/include/asm/io.h:33 [inline]
> > > pc : _outw include/asm-generic/io.h:594 [inline]
> > > pc : logic_outw+0x54/0x218 lib/logic_pio.c:305
> > > lr : _outw include/asm-generic/io.h:593 [inline]
> > > lr : logic_outw+0x40/0x218 lib/logic_pio.c:305
> > > sp : ffff800083097a30
> > > x29: ffff800083097a30 x28: ffffba71ba86e130 x27: 1ffff00010612f93
> > > x26: ffff3bae63b3a420 x25: ffffba71bbf585d0 x24: 0000000000005ac1
> > > x23: 00000000000010c1 x22: ffff3baf0deb6488 x21: 0000000000000002
> > > x20: 00000000000010c1 x19: 0000000000ffbffe x18: 0000000000000000
> > > x17: 0000000000000000 x16: ffffba71b9f44b48 x15: 00000000200002c0
> > > x14: 0000000000000000 x13: 0000000000000000 x12: ffff6775ca80451f
> > > x11: 1fffe775ca80451e x10: ffff6775ca80451e x9 : ffffba71bb78cf2c
> > > x8 : 0000988a357fbae2 x7 : ffff3bae540228f7 x6 : 0000000000000001
> > > x5 : 1fffe775e2b43c78 x4 : dfff800000000000 x3 : ffffba71b9a00000
> > > x2 : ffff80008d22a000 x1 : ffffc58ec6600000 x0 : fffffbfffe8010c1
> > > Call trace:
> > >   _outw include/asm-generic/io.h:594 [inline]
> > >   logic_outw+0x54/0x218 lib/logic_pio.c:305
> > >   pci_resource_io drivers/pci/pci-sysfs.c:1157 [inline]
> > >   pci_write_resource_io drivers/pci/pci-sysfs.c:1191 [inline]
> > >   pci_write_resource_io+0x208/0x260 drivers/pci/pci-sysfs.c:1181
> > >   sysfs_kf_bin_write+0x188/0x210 fs/sysfs/file.c:158
> > >   kernfs_fop_write_iter+0x2e8/0x4b0 fs/kernfs/file.c:338
> > >   call_write_iter include/linux/fs.h:2085 [inline]
> > >   new_sync_write fs/read_write.c:493 [inline]
> > >   vfs_write+0x7bc/0xac8 fs/read_write.c:586
> > >   ksys_write+0x12c/0x270 fs/read_write.c:639
> > >   __do_sys_write fs/read_write.c:651 [inline]
> > >   __se_sys_write fs/read_write.c:648 [inline]
> > >   __arm64_sys_write+0x78/0xb8 fs/read_write.c:648
> > >   __invoke_syscall arch/arm64/kernel/syscall.c:37 [inline]
> > >   invoke_syscall+0x8c/0x2e0 arch/arm64/kernel/syscall.c:51
> > >   el0_svc_common.constprop.0+0x200/0x2a8 arch/arm64/kernel/syscall.c:=
134
> > >   do_el0_svc+0x4c/0x70 arch/arm64/kernel/syscall.c:176
> > >   el0_svc+0x44/0x1d8 arch/arm64/kernel/entry-common.c:806
> > >   el0t_64_sync_handler+0x100/0x130 arch/arm64/kernel/entry-common.c:8=
44
> > >   el0t_64_sync+0x3c8/0x3d0 arch/arm64/kernel/entry.S:757
> > >=20
> > > Powerpc seems affected as well, so prohibit the unaligned access
> > > on non-x86 archs.
> > >=20
> > > Fixes: 8633328be242 ("PCI: Allow read/write access to sysfs I/O port
> > > resources")
> > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > Signed-off-by: Ziming Du <duziming2@huawei.com>
> > > ---
> > >   drivers/pci/pci-sysfs.c | 12 ++++++++++++
> > >   1 file changed, 12 insertions(+)
> > >=20
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 7e697b82c5e1..6fa3c9d0e97e 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -1141,6 +1141,13 @@ static int pci_mmap_resource_wc(struct file *f=
ilp,
> > > struct kobject *kobj,
> > >   =09return pci_mmap_resource(kobj, attr, vma, 1);
> > >   }
> > >   +#if !defined(CONFIG_X86)
> > > +static bool is_unaligned(unsigned long port, size_t size)
> > > +{
> > > +=09return port & (size - 1);
> > > +}
> > > +#endif
> > > +
> > >   static ssize_t pci_resource_io(struct file *filp, struct kobject *k=
obj,
> > >   =09=09=09       const struct bin_attribute *attr, char *buf,
> > >   =09=09=09       loff_t off, size_t count, bool write)
> > > @@ -1158,6 +1165,11 @@ static ssize_t pci_resource_io(struct file *fi=
lp,
> > > struct kobject *kobj,
> > >   =09if (port + count - 1 > pci_resource_end(pdev, bar))
> > >   =09=09return -EINVAL;
> > >   +#if !defined(CONFIG_X86)
> > > +=09if (is_unaligned(port, count))
> > > +=09=09return -EFAULT;
> > > +#endif
> > > +
> > This changes return value from -EINVAL -> -EFAULT for some values of co=
unt
> > which seems not justified.
> >=20
> > To me it's not clear why even x86 should allow unaligned access. This
> > interface is very much geared towards natural alignment and sizing of t=
he
> > reads (e.g. count =3D 3 leads to -EINVAL), so it feels somewhat artific=
ial
> > to make x86 behave different here from the others.
>=20
> Thanks for your review! We verify that when count =3D 3, the return value=
 will
> not be
>=20
> -EFAULT; It will only return -EFAULT in cases of unaligned access.

Oh, then there's even worse problem in your code as your is_aligned()=20
assumes size is a power of two value.

Also, is_aligned() seems to be duplicating IS_ALIGNED() (your naming is=20
very misleading as it's a prefixless name that overlaps with a generic=20
macro with the very same name).

> We conduct a POC on QEMU with the ARM architecture as follows:
>=20
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
>=20
> int main()
> {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 int fd =3D open("/sys/bus/pci/devices/0000:00=
:01.0/resource0", O_RDWR);
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 char buf[] =3D "1233333";
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (fd < 0) {
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 printf("open fail=
ed\n");
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 1;
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 }
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 pwrite(fd, buf, 2, 1);
>=20
> =C2=A0 =C2=A0 =C2=A0 =C2=A0 return 0;
> }
>=20
> On x86, this does not trigger a kernel panic.
>=20
> > >   =09switch (count) {
> > >   =09case 1:
> > >   =09=09if (write)
> > >=20
>=20

--=20
 i.

--8323328-1408250814-1765966526=:968--

