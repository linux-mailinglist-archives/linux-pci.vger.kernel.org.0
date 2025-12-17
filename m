Return-Path: <linux-pci+bounces-43163-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D36E3CC7387
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:04:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B547930B6750
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6441037833C;
	Wed, 17 Dec 2025 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jL1ugtv7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34B9378302;
	Wed, 17 Dec 2025 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765966799; cv=none; b=esxlfOcCFpeIhhXCOxU/YcdtoRrv4O/qOxcYUU7casUc+bWc6CZ7mQ68GdeGt2e1OpTog3YoH5Yv8TSn0Ru1viMxr7ERFdbmTTr2gRYxF5J36DUAWClOSMTdYx7X4VzVNROnuAvvqZYaahExOMnt7zcG6U3eCk8sYFec5cKlscA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765966799; c=relaxed/simple;
	bh=Ha0UKmUus3+i52rpzt3FHrv+inSomUC0mMlneHC86r8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=QRaTq98+1buKpVBItWp0ifxVC/IRIU8ZP8MBEi8Fu8XlKOBFR0d9MvnzHuKMNHsAN+whmDypRC4/QCSVftlpam2fwvnxbVSr9OjYYDJjlcBeTLAu4qCCf9vl0SYsuqREH00EojuVta5y1/Ot6gCzLwEMa5qgDx00SezGoxCpEtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jL1ugtv7; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765966794; x=1797502794;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Ha0UKmUus3+i52rpzt3FHrv+inSomUC0mMlneHC86r8=;
  b=jL1ugtv7mjZ64GOksf8noX7m47acYX7nsKUuQJJfnxwuHQKUBRgV1NMs
   knIc2lG7USqkNoj35zYT9GEb6J62TUS2X6bbRsmMoFgJRCx+x3KK2dCZt
   7il1uOBn2TtrtPWThLTMBbS/y8Br8tpxuP90b4riEEvbih+NySuY+L9sY
   vHlSLyx8coCjDE2IaAAqJxc7vbrmIVKfG9X1tk7ro7641Ap0QMEWT9A6v
   YJsv3hEKEgNku3SbSr0S4msngewGjdEu5vEUmvUpljZjz1BJeRvSLNAEw
   U9W4oX8egbsZepaB7uPS3KkhOuqdquORYz2sAOAD6Bil8XFtM2kXGxyx4
   g==;
X-CSE-ConnectionGUID: vdF9K1o0QnCvphRyfdvKeg==
X-CSE-MsgGUID: OeskzE4lSwC6KsoXoM++hA==
X-IronPort-AV: E=McAfee;i="6800,10657,11644"; a="55473983"
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="55473983"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:19:52 -0800
X-CSE-ConnectionGUID: aYDrkVNWRQGqN6txxpPlfg==
X-CSE-MsgGUID: cJ6eg/tjT1y0cvWiP2Yr+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,155,1763452800"; 
   d="scan'208";a="203171489"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.187])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2025 02:19:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 17 Dec 2025 12:19:45 +0200 (EET)
To: duziming <duziming2@huawei.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, chrisw@redhat.com, 
    jbarnes@virtuousgeek.org, alex.williamson@redhat.com, 
    liuyongqiang13@huawei.com
Subject: Re: [PATCH 3/3] PCI: Prevent overflow in proc_bus_pci_write()
In-Reply-To: <df3dba86-e6c3-484a-b384-6c6197afcfe3@huawei.com>
Message-ID: <e5a91378-4a41-32fb-00c6-2810084581bd@linux.intel.com>
References: <20251216083912.758219-1-duziming2@huawei.com> <20251216083912.758219-4-duziming2@huawei.com> <47ccdb75-7134-b86a-e8bb-eebb9f1e0b47@linux.intel.com> <df3dba86-e6c3-484a-b384-6c6197afcfe3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-155063931-1765966785=:968"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-155063931-1765966785=:968
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Dec 2025, duziming wrote:
> =E5=9C=A8 2025/12/16 18:57, Ilpo J=C3=A4rvinen =E5=86=99=E9=81=93:
> > On Tue, 16 Dec 2025, Ziming Du wrote:
> >=20
> > > When the value of ppos over the INT_MAX, the pos will be
> > is over
> >=20
> > > set a negtive value which will be pass to get_user() or
> > set to a negative value which will be passed
> >=20
> > > pci_user_write_config_dword(). And unexpected behavior
> > Please start the sentence with something else than And.
> >=20
> > Hmm, the lines look rather short too, can you please reflow the changel=
og
> > paragraphs to 75 characters.
>=20
> Thanks for the review. I'll reflow the changelog to 75-character lines an=
d
> avoid
>=20
> starting sentences with 'And' in the next revision.
>=20
> > > such as a softlock happens:
> > >=20
> > >   watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
> > >   Modules linked in:
> > >   CPU: 0 PID: 3444 Comm: syz.3.109 Not tainted 6.6.0+ #33
> > >   Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> > > rel-1.16.3-0-ga6ed6b701f0a-prebuilt.qemu.org 04/01/2014
> > >   RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
> > >   Code: cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0=
f 1e
> > > fa 0f 1f 44 00 00 e8 52 12 00 00 90 fb 65 ff 0d b1 a1 86 6d <74> 05 e=
9 42
> > > 52 00 00 0f 1f 44 00 00 c3 cc cc cc cc 0f 1f 84 00 00
> > >   RSP: 0018:ffff88816851fb50 EFLAGS: 00000246
> > >   RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff927daf9b
> > >   RDX: 0000000000000cfc RSI: 0000000000000046 RDI: ffffffff9a7c7400
> > >   RBP: 00000000818bb9dc R08: 0000000000000001 R09: ffffed102d0a3f59
> > >   R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000000
> > >   R13: ffff888102220000 R14: ffffffff926d3b10 R15: 00000000210bbb5f
> > >   FS:  00007ff2d4e56640(0000) GS:ffff8881f5c00000(0000)
> > > knlGS:0000000000000000
> > >   CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > >   CR2: 00000000210bbb5b CR3: 0000000147374002 CR4: 0000000000772ef0
> > >   PKRU: 00000000
> > >   Call Trace:
> > >    <TASK>
> > >    pci_user_write_config_dword+0x126/0x1f0
> > >    ? __get_user_nocheck_8+0x20/0x20
> > >    proc_bus_pci_write+0x273/0x470
> > >    proc_reg_write+0x1b6/0x280
> > >    do_iter_write+0x48e/0x790
> > >    ? import_iovec+0x47/0x90
> > >    vfs_writev+0x125/0x4a0
> > >    ? futex_wake+0xed/0x500
> > >    ? __pfx_vfs_writev+0x10/0x10
> > >    ? userfaultfd_ioctl+0x131/0x1ae0
> > >    ? userfaultfd_ioctl+0x131/0x1ae0
> > >    ? do_futex+0x17e/0x220
> > >    ? __pfx_do_futex+0x10/0x10
> > >    ? __fget_files+0x193/0x2b0
> > >    __x64_sys_pwritev+0x1e2/0x2a0
> > >    ? __pfx___x64_sys_pwritev+0x10/0x10
> > >    do_syscall_64+0x59/0x110
> > >    entry_SYSCALL_64_after_hwframe+0x78/0xe2
> > Could you please trim the dump so it only contains things relevant to t=
his
> > issue () (also check trimming in the other patches).
> Thanks for pointing that out, we'll make sure to only keep the relevant s=
tacks
> in future patches.
> > > Fix this by use unsigned int for the pos.
> > >=20
> > > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > > Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> > > Signed-off-by: Ziming Du <duziming2@huawei.com>
> > > ---
> > >   drivers/pci/proc.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> > > index 9348a0fb8084..dbec1d4209c9 100644
> > > --- a/drivers/pci/proc.c
> > > +++ b/drivers/pci/proc.c
> > > @@ -113,7 +113,7 @@ static ssize_t proc_bus_pci_write(struct file *fi=
le,
> > > const char __user *buf,
> > >   {
> > >   =09struct inode *ino =3D file_inode(file);
> > >   =09struct pci_dev *dev =3D pde_data(ino);
> > > -=09int pos =3D *ppos;
> > > +=09unsigned int pos =3D *ppos;
> > >   =09int size =3D dev->cfg_size;
> > >   =09int cnt, ret;
> > So this still throws away some bits compared with the original ppos ?
>=20
> The current approach may lose some precision compared to the original ppo=
s,
> but a later check ensures=C2=A0 pos
>=20
> remains valid=E2=80=94so any potential information loss is handled safely=
=2E

That's somewhat odd definition of "valid" if a big ppos results in=20
a smaller number after the precision loss that is smaller than size.=20

--=20
 i.

--8323328-155063931-1765966785=:968--

