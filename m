Return-Path: <linux-pci+bounces-44276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 01657D029BF
	for <lists+linux-pci@lfdr.de>; Thu, 08 Jan 2026 13:26:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 790883041AD1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Jan 2026 12:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249884963BC;
	Thu,  8 Jan 2026 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Clq8uWc1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4468048AE38;
	Thu,  8 Jan 2026 11:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767872132; cv=none; b=Mz+Lz/HGa/FqUGY8f8/HC8b/REiJH/PmRs14kGSQHkYi+TjRquhySHzE5/I6yiA6Vy+z1B+5KDrjLwra7S+78Fyn918pH4z+ZjKIlMmG03XGtBEO1oS6XB3Ce+F33XJtRlmiKuXKVzQinb+/VJYhWd7pYjJVQ0TbRBjEOhh90No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767872132; c=relaxed/simple;
	bh=/t/t0xWzaLPEOnffO8QGzZJ9rfz7bSg6Q9EPioQBphI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cnWnbjjHPPnMbBIYyEdSqxaGJAPYtHuKZeeyWe1JRPyqQ3TTzDaZ3JwxxweTtRaJ2GYqk2QASpKktNlySu7n27LEjTJl4iicjEwfmDIyvF1UxXoGrOLlG1jT9FGK1Hq7+R6Lqc9Yiu+LrfaBHhwNSBx3zmCFxxuArET6KkKu8ao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Clq8uWc1; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767872130; x=1799408130;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/t/t0xWzaLPEOnffO8QGzZJ9rfz7bSg6Q9EPioQBphI=;
  b=Clq8uWc1f5ZdFVmV9QhmzXncxw9WcxM0k/AtFPf4yjiDuba79coFctai
   /0hSOImy/SIISJ7gVKZF5Jwq0yjFHZfZ5DAj52epkbmje4yrL3gQmwFiV
   LgK7dN9vKQCXUb8TvA7MiBigYJpPpfMGk4fMS5Xp0zSIxTnVYj5ik7Z7T
   Uz6ei1/koywWq5HE8npMcH9gbXFis3Q2do/wuZzfxBUDKdEOnrzY5F3Ta
   M8HyG9SqpPiM0HpfWWu17El7K+DbBMQPDUqLwfw4gKCKCfLaivKrg44G0
   2Fju9BSphV59vMnfWQ5ax4t6mDM0AKjGPEMu7XjngppM+c3K+XXm1/oIb
   w==;
X-CSE-ConnectionGUID: +Wu5NLUpSqGg77Zsu1s2tw==
X-CSE-MsgGUID: gJvr4t88SsyGqcLHcQu0eQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73101531"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73101531"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 03:35:27 -0800
X-CSE-ConnectionGUID: VX9xFO0TRNmx1bZm6Va6fw==
X-CSE-MsgGUID: uOyidQFmS3S5gGj5vspZxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="240667694"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.14])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 03:35:26 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Jan 2026 13:35:22 +0200 (EET)
To: Ziming Du <duziming2@huawei.com>
cc: bhelgaas@google.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, liuyongqiang13@huawei.com
Subject: Re: [PATCH v3 2/3] PCI: Prevent overflow in proc_bus_pci_write()
In-Reply-To: <20260108015944.3520719-3-duziming2@huawei.com>
Message-ID: <edf5fbdb-d7ee-6cc5-84b8-458bef59a0c5@linux.intel.com>
References: <20260108015944.3520719-1-duziming2@huawei.com> <20260108015944.3520719-3-duziming2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-915059543-1767872122=:1132"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-915059543-1767872122=:1132
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Thu, 8 Jan 2026, Ziming Du wrote:

> From: Yongqiang Liu <liuyongqiang13@huawei.com>
>=20
> When the value of *ppos over the INT_MAX, the pos is over set to a
> negative value which will be passed to get_user() or
> pci_user_write_config_dword(). Unexpected behavior such as a soft lockup
> will happen as follows:
>=20
>  watchdog: BUG: soft lockup - CPU#0 stuck for 130s! [syz.3.109:3444]
>  RIP: 0010:_raw_spin_unlock_irq+0x17/0x30
>  Call Trace:
>   <TASK>
>   pci_user_write_config_dword+0x126/0x1f0
>   proc_bus_pci_write+0x273/0x470
>   proc_reg_write+0x1b6/0x280
>   do_iter_write+0x48e/0x790
>   vfs_writev+0x125/0x4a0
>   __x64_sys_pwritev+0x1e2/0x2a0
>   do_syscall_64+0x59/0x110
>   entry_SYSCALL_64_after_hwframe+0x78/0xe2
>=20
> Fix this by using unsigned int for the pos.
>=20
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Yongqiang Liu <liuyongqiang13@huawei.com>
> Signed-off-by: Ziming Du <duziming2@huawei.com>
> ---
>  drivers/pci/proc.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
> index 9348a0fb8084..2d51b26edbe7 100644
> --- a/drivers/pci/proc.c
> +++ b/drivers/pci/proc.c
> @@ -113,10 +113,14 @@ static ssize_t proc_bus_pci_write(struct file *file=
, const char __user *buf,
>  {
>  =09struct inode *ino =3D file_inode(file);
>  =09struct pci_dev *dev =3D pde_data(ino);
> -=09int pos =3D *ppos;
> +=09int pos;
>  =09int size =3D dev->cfg_size;
>  =09int cnt, ret;
> =20
> +=09if (*ppos > INT_MAX)
> +=09=09return -EINVAL;
> +=09pos =3D *ppos;
> +
>  =09ret =3D security_locked_down(LOCKDOWN_PCI_ACCESS);
>  =09if (ret)
>  =09=09return ret;
>=20

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

With the note that proc_bus_pci_read() and proc_bus_pci_write() diverge in=
=20
handling > INT_MAX values and that feels unjustified (but there's not this
same problem on the read side I guess so if the read side is made the same=
=20
as the write side, it would be better to do that in another patch).

--=20
 i.

--8323328-915059543-1767872122=:1132--

