Return-Path: <linux-pci+bounces-13564-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C5B49874EC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 15:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205B11C21ACC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Sep 2024 13:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B52688248C;
	Thu, 26 Sep 2024 13:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+Rr1JOc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227915FEED
	for <linux-pci@vger.kernel.org>; Thu, 26 Sep 2024 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727359095; cv=none; b=DgcyzelnDCouA0mkf0AqOs5YYmlC/huBt1DTkmta7oDCMdV99AX0UfRbXM6HD/HsPIpYTOCHvZA9ScItrZgQ9nWeDKdYT06IonMsoRUboCF1Ck2hjzi9spXQdsUcx+gV3AMIV6i89fYYUDgXoFJ0HU9d4QU+whInXaGkF/i7VfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727359095; c=relaxed/simple;
	bh=q8kiP3/JkCqTTzdUCq/E8UStOdAxqIgvBuQ1LUlYdrU=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DMB1ypVN96rOV4j/C0ykyOttuqIMQCDwUJzXhUTy11G+ZlEakbJEWLNy61W451abJ+pcP9hN7BqF3VfGDYwKpv33Yz/0GEF9eqB+izle2ksN481Kg0Auh8G2yEWTHsekyiHdATrHyrO8ntRgeZqodufBF434Wx7/tqWdCBa/xF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+Rr1JOc; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727359095; x=1758895095;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=q8kiP3/JkCqTTzdUCq/E8UStOdAxqIgvBuQ1LUlYdrU=;
  b=V+Rr1JOcftnjua9s4E1ckjypGTDxNJ8b6apmcoggo4YhwN4PPNL1z0/F
   CfWQ83fZN26RZHfCk+Og9oWQf5Jvs7fbjSZbqM3EgoyxVvObCMBrZNmpm
   3D90KoHhrfcbrd6885SvuQtb/S4+Egi5BHXjjEGLdI17wmoY4BE7mHM0I
   K0mkwhZz79XNvTlw+qkHWLsY1CLleT0kwgrAivV0AK/yUkU0yvy/5iWP6
   BV8g8lJOnFJjetVNi/2ZFE4LcOy8I68JBC9Mk2kUEQVGqH5NIsdNkMyDT
   AwJGZ1RboodCq14KUC6WILAhn5VEnD6HDPKNpBpCMsvNQd9t5Llkd0Xz0
   w==;
X-CSE-ConnectionGUID: WnLivGvgQDCQdDKeDu25ww==
X-CSE-MsgGUID: AYY1mECkQvaEcHnDlSxnkA==
X-IronPort-AV: E=McAfee;i="6700,10204,11207"; a="26592181"
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="26592181"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:58:14 -0700
X-CSE-ConnectionGUID: fHbO5WjKTKicEq7I2dV8iA==
X-CSE-MsgGUID: gYqrMMydTZOC3726iozXdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,155,1725346800"; 
   d="scan'208";a="76936894"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.208])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2024 06:58:10 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Sep 2024 16:58:06 +0300 (EEST)
To: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>
cc: "kbusch@kernel.org" <kbusch@kernel.org>, 
    "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>, 
    "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, 
    "mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>, 
    "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>, 
    "minipli@grsecurity.net" <minipli@grsecurity.net>, 
    "lukas@wunner.de" <lukas@wunner.de>
Subject: Re: UAF during boot on MTL based devices with attached dock
In-Reply-To: <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
Message-ID: <289bcd4d-099a-810b-0854-b11223f50a9c@linux.intel.com>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>  <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>  <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com> <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1234761268-1727352184=:1148"
Content-ID: <a0d20f3d-0837-d8d6-84e2-7006ed785a9e@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1234761268-1727352184=:1148
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <8a7d9395-1a2f-774e-8e77-398b76ad0516@linux.intel.com>

On Wed, 25 Sep 2024, Wassenberg, Dennis wrote:
> On Tue, 2024-09-24 at 13:51 +0300, Ilpo J=E4rvinen wrote:
> > On Mon, 23 Sep 2024, Wassenberg, Dennis wrote:
> >=20
> > > Hi together,
> > >=20
> > > we did some further analysis on this:
> > >=20
> > > Because we are working on kernel 6.8.12, I will use some logs from th=
is kernel version, just for demonstration. The
> > > initial report was based on 6.11.
> > >=20
> > > After we tried a KASAN build (dmesg-ramoops-kasan) it looks like it i=
s exactly the same pciehp flow which leads to
> > > the
> > > UAF.
> > > Both going through pciehp_ist -> pciehp_disable_slot -> pciehp_unconf=
igure_device -> pci_remove_bus_device -> ...
> > > This means there are two consecutive interrupts, running on CPU 12 an=
d both will execute the same flow.
> > > At the latest the pci_lock_rescan_remove should be taken in pciehp_un=
configure_device to prevent accessing the
> > > pci/bus
> > > structures in parallel.
> > >=20
> > > I had a look if there are shared data structures accessed in this cod=
e path:
> > > For me the access to "*parent =3D ctrl->pcie->port->subordinate;" loo=
ks fishy in pciehp_unconfigure_device. The parent
> > > ptr
> > > will be obtained before getting the lock (pci_lock_rescan_remove). No=
w, if there are two concurrent/consecutive
> > > flows
> > > come into this function, both will get the pointer to the parent brid=
ge/subordinate. One thread will enter the lock
> > > and
> > > the other one is waiting until the lock is gone. The thread which ent=
ers the lock at first will completely remove
> > > the
> > > bridge and the subordinate: pciehp_unconfigure_device -> pci_stop_and=
_remove_bus_device -> pci_remove_bus_device ->
> > > pci_destroy_dev: This will destroy the pci_dev and the subordinate is=
 a part the this structure as well. Now
> > > everything
> > > is gone below this pci_bus (childs included). In pci_remove_bus_devic=
e there is a loop which iterates over all child
> > > devices and call pci_remove_bus_device again. This means even the chi=
ld bridges of the current bridge will be
> > > deleted.
> > > In the end: everything is gone below the bridge which is regarded her=
e at first.
> >=20
> > Doesn't that end up removing portdrv/hotplug too so pciehp_remove() doe=
s=20
> > release ctrl? I'm not sure if ctrl can be safely accessed even if the=
=20
> > lock is taken first?
>
> Yes, it looks like it ends up in removing portdrv/hotplug too. I am not s=
ure if this can be safely accessed. For testing
> I added "set_service_data(dev, NULL);" at the end of pciehp_remove. This =
should make sure that it is not possible to
> access freed ctrl. If there is a flow which accesses this, it should resu=
lt in a null-ptr instead of UAF. I did some
> runs with this change but I always ran into the UAF.

Okay, perhaps it doesn't occur for some reason. I suppose the reason is=20
that the concurrent pciehp_ist() waits for the lock in=20
pciehp_unconfigure_device() and since it has not yet returned,
free_irq() is what keeps the hotplug & ctrl getting removed.
So it seems to me your change is fine.

> For me it looks more related to the slot object. If I compare two runs (o=
ne with dyndbg enabled for pci and one without)
> it will access the failing address in the __dynamic_dev_dbg portion at pc=
i_destroy_slot in case of the dyndbg enabled
> run. In case of the non dyndbg run it will fail while accessing
> "kobject_put(&slot->kobj);" in pci_destroy_slot.

The first error is

<3>[   10.244423] BUG: KASAN: slab-use-after-free in pci_slot_release+0x36e=
/0x3e0

so how you inferred it occurs in pci_destroy_slot()?

> Unfortunately I have currently no clue about how can this slot object=20
> ever been destroyed prematurely.=20

There are dev_dbg()s on the paths that lead to destruction of the slot=20
object. I don't see any of those lines in your logs so I don't believe=20
that has occurred here.

> I attach the logs of both runs. I know, one is based on an other kernel v=
ersion but there it is more easy to reproduce
> with KASAN enabled.

What in these logs indicate to you it would be slot access which fails? To=
=20
me it looks in both cases access to ->bus is the culprit (it also explains=
=20
why dyndbg on/off matters because pci_destroy_slot() will not access ->bus=
=20
otherwise so it can get all the way into pci_slot_release() before=20
blowing up).

--=20
 i.
--8323328-1234761268-1727352184=:1148--

