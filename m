Return-Path: <linux-pci+bounces-16567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A17329C5CFB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60F382816D9
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7756F2038B0;
	Tue, 12 Nov 2024 16:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="X1IvGOUu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F164D200C82;
	Tue, 12 Nov 2024 16:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428210; cv=none; b=Q/Dz0yQcEISBaMVyF+SVAXx8H1qHEbNZrgl/9ckTH58Q1iColEscIsBqmzcjXMfsZ3rFIGKpF9SEICsCzMfl/ipLXJpOxE7NW+3ND5b7uvLqbGGlVntqBMDkPzR/AvZ4X0n1U+MsGwB2D/xRpdmLPkRA4fxj/SxgSoj6na+LuRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428210; c=relaxed/simple;
	bh=xiGLaR6s5tScsDovvjCdd16Pe39oJDYnOIa7LeChxRc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=HtEymY7ZA/uMdNtr3GLa8+ZOlWy2ravtCEWfVXXjJ/SZL/qTsPBPPhPomWAEuxIHiSQl2g7of78q6EdK1NKWYTjiJ1PCTSZgHV5YC/ikJIKqFSg3Oade/ZpvrKBJ4xual6WkprtmS/crGsbIVTtWAdg0dLnLC7pz3cGRlcp7VRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=X1IvGOUu; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731428208; x=1762964208;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=xiGLaR6s5tScsDovvjCdd16Pe39oJDYnOIa7LeChxRc=;
  b=X1IvGOUusrh0AclVaeUY4wB6y2eHKWsFOCKQggo5V8x/A4oKAQoobDnX
   XwPfuKA7Bo2/oXZCPpdP4H05TcnKgiN1K5KwneQQK4et43xHUiAq63SGA
   3wVRaiPIjX+dYe2MLM6QmauQGr8p4bhzTYTYHnNpRThhKLwughge1tFK0
   2MoT2e+VGUmSeBngYpZVR13/r/VqqBSUXxKx2hy9dOXOBuN22GReEGdiw
   NohHIQ0BYtgBxzg0+T1vORTh4Q1NszJMzZeeICi2cQ8cw/5tOYcCABVSw
   ffm6Sp+MqoWLNaF0jrbLEIoI+ur5ht68lqWWVmPWZbecqOanwNKcArHm9
   A==;
X-CSE-ConnectionGUID: PWRCae1ITsep5q14hhwZ9w==
X-CSE-MsgGUID: xpP4W2QDSe2Dtpd5BASPLQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="34976708"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="34976708"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:16:47 -0800
X-CSE-ConnectionGUID: UevQ1+sOSk+GzPsJtfgI3w==
X-CSE-MsgGUID: ZwgLARPZSkGMj6ZpfZNZcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="87700355"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 08:16:46 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 18:16:41 +0200 (EET)
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix BAR resizing when VF BARs are assigned
In-Reply-To: <9e3b6a38-6f23-45cc-ac3d-d0ebc929dee3@amd.com>
Message-ID: <965c4c84-be1a-ba30-400a-62481ae7400a@linux.intel.com>
References: <20241112134225.9837-1-ilpo.jarvinen@linux.intel.com> <a22a321a-0e60-474b-971c-8512189a69ca@amd.com> <c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com> <9e3b6a38-6f23-45cc-ac3d-d0ebc929dee3@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-839605812-1731425866=:13135"
Content-ID: <7e1a46b8-5363-59dd-f9b5-297d734337a3@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-839605812-1731425866=:13135
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <834106cb-5bed-0b65-33fa-99b8cd44f04b@linux.intel.com>

On Tue, 12 Nov 2024, Christian K=F6nig wrote:

> Am 12.11.24 um 15:28 schrieb Ilpo J=E4rvinen:
>=20
> On Tue, 12 Nov 2024, Christian K=F6nig wrote:
>=20
> Am 12.11.24 um 14:42 schrieb Ilpo J=E4rvinen:
>=20
> __resource_resize_store() attempts to release all resources of the
> device before attempting the resize. The loop, however, only covers
> standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> assigned, pci_reassign_bridge_resources() finds the bridge window still
> has some assigned child resources and returns -NOENT which makes
> pci_resize_resource() to detect an error and abort the resize.
>=20
>=20
> Looks good in general, but a couple of comments.
>=20
> Similarly, an assigned Expansion ROM resource prevents the resize.
>=20
>=20
> Expansion ROMs were intentionally left untouched by the initial patch sin=
ce those are
> usually 32bit resources and the resize was implemented only for 64bit BAR=
s.
>=20
> Change the release loop to cover both the VF BARs and Expansion ROM
> which allows the resize operation to release the bridge windows and
> attempt to assigned them again with the different size.
>=20
>=20
> I'm not sure if Expansion ROMs should be touched here. Those are 32bit re=
sources
> usually and notoriously broken in the ACPI tables.
>=20
> What I've seen multiple times that after releasing them you can't move no=
r assign
> them again to their original position.
>=20
> Background is that some ACPI table denotes the location of the ROM as res=
erved and we
> only accept the Expansion ROM at that location because of a quirk (which =
is of course
> not applied when you resize).
>=20
> On the other hand do we have use cases for resizing 32bit BARs? So far we=
 resized
> those only by accident.
>=20
> Thanks for taking a look!
>=20
> This is not about resizing 32bit BARs.
>=20
> Is that somehow enforced so they cannot end up into the same bridge=20
> window? Because we can only resize a bridge window if we release all its=
=20
> child resources.
>=20
>=20
> Good question, I'm not 100% sure either.
>=20
> IIRC the PCI subsystem has a fallback which tries to squeeze 64bit BARs i=
nto 32bit
> windows of bridges if nothing else works.

Yes, as far as I understand the code, that can happen.

> But the PCI subsystem never does that the other way around. Simply becaus=
e a 32bit
> BAR doesn't necessary work in a 64bit window.
>
> So you should never need to free up a 32bit BAR to resize and/or move a 6=
4bit BAR
> because that operation should move the 64bit BAR into the 64bit window an=
yway.

I fail to follow your logic here. Why exactly the 64bit resizable BAR=20
couldn't end up into a bridge window that is shared with Expansion ROM=20
(and perhaps other 32-bit resources) consider the fallbacks? And why=20
couldn't the resize be attempted there?

> That we only free up resources with the same flags is taken care of this =
code here:
>=20
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (pci_resource_len(pdev, =
i) &&
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci_resource_fl=
ags(pdev, i) =3D=3D flags)
> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pci=
_release_resource(pdev, i);
>=20
> The flags should contain IORESOURCE_MEM_64 for 64bit BARs. So we most lik=
ely don't
> need a special handling for Expansion ROMs or 32bit BARs.

Most likely true, neither would get released and the resize ends up=20
failing.

However, now that you brought it up, I question if that flags check there=
=20
is correct at all. I think it would simply want to check if the resource=20
to be resized shares the bridge window with the i'th resource? Do you=20
agree? (And that check has nothing to do with 32/64bit.)

This is far from the only inconsistency I've come across while recently=20
trying to address a number of issues in the resource fitting and=20
assignment logic. I'm slowly trying to come into understanding of mess=20
this ->flags and resource fitting & allocation is and hopefully=20
eventually make it something that is actually tractable (yeah, wish me=20
luck :-/).

So I don't want to accept "we most likely don't need a special handling=20
for Expansion ROMs or 32bit BARs" just because it happens to work, I'd=20
want that check to make sense too.

It would always be possible to explicitly do something if we detect=20
Expansion ROM resource that is assigned (and perhaps not disabled?) but=20
even then, preventing resize from proceeding just because something bad=20
might happen to the Expansion ROM seems a bit big hammer to me (but=20
could certainly e.g. print a warning if that gets attempted for ROM).

--=20
 i.

> Regards,
> Christian.
>=20
> As __resource_resize_store() checks first that no driver is bound to
> the PCI device before resizing is allowed, SR-IOV cannot be enabled
> during resize so it is safe to release also the IOV resources.
>=20
> Fixes: 8bb705e3e79d ("PCI: Add pci_resize_resource() for resizing BARs")
>=20
>=20
> The code in question was added by 91fa127794ac ("PCI: Expose PCIe Resizab=
le BAR
> support via sysfs").
>=20
> Oh right. I don't know why I ended up picking that other commit (sure, I=
=20
> was also looking that other diff but maybe it was just a copy-paste=20
> error).
>=20
>=20
>=20
>=20
--8323328-839605812-1731425866=:13135--

