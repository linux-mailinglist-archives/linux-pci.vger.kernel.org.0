Return-Path: <linux-pci+bounces-16542-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52749C5B55
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:07:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34026B2CC37
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 14:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FEF11FCC56;
	Tue, 12 Nov 2024 14:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DjcAexex"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8B61FF034;
	Tue, 12 Nov 2024 14:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731421744; cv=none; b=szzShjyPNF3hsQE5Vr0Av/pYFaKTIL+N2Roovt88m/Xi67hKnxs+uhw+H+AUx7fe/eUvjMI/QVAekH2zj6abo+yUUBLROUkEw7XHD7F6LRnfqZvYSEPSoc6CQ/rYF3GIyY2KVApNY4Td70bQxSZoDQTgqbIB853w3iGVrckXngY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731421744; c=relaxed/simple;
	bh=L4cRSTZJjIOJHNCSoBcliNQV4OpjqFUqJAWhfjHttHI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=WCA/gZZuzCPrYTUadyYjF20skuh6cn3JbqxiLUEMis9kK85XjC/qPjDBMcqzHVLVPkzKevCIilgP5dLDAb3gkvBUE9n8gbw9WDTayKyJWN8uTVM3uO5oSoPEZyWguiXKNSSCvaycZmKOAFVoWXd0WkiBnmbphxnqxSQI3SOnWmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DjcAexex; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731421743; x=1762957743;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=L4cRSTZJjIOJHNCSoBcliNQV4OpjqFUqJAWhfjHttHI=;
  b=DjcAexexQKIshlNMHmejsn0+IbwfoACH8nF1cioPPJcY85dxt6DyoUTg
   KJTwKRYkhH77h45nxniLa+QySjHk1GrGQjta0jk3W1bVM/5oUjRl48uOu
   hooto+vt1hnk9S0JAj+WSNruLoNrcSIR791tzV/QTwtxYPqNvzNVjop5S
   ae2UTp735prKQcGT5I37esYQn5AM4z2OphfVkABLgkO3bJjPKRb7ZDXYo
   eEfje9UwN0QXqyp/n3J8aT3BMSvV3W8jlg6qsNrO1ZwIduOjHFQdF5UXi
   xMKni9KNfw1d5GbGpkCGRqDmkJUwJ0B/BbXDdIvr+sSG7nlkYnLeYI7va
   Q==;
X-CSE-ConnectionGUID: YhW8pnpCSq+BS4BrRIjs2w==
X-CSE-MsgGUID: KGIVFixISo2VW6i0nVQC0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11254"; a="41883194"
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="41883194"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 06:29:00 -0800
X-CSE-ConnectionGUID: 88GsC4YLQoG0inf2dZGqzA==
X-CSE-MsgGUID: SBUmkFKMQheLbv92y7VyHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,148,1728975600"; 
   d="scan'208";a="91521989"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.234])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2024 06:28:57 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Nov 2024 16:28:55 +0200 (EET)
To: =?ISO-8859-15?Q?Christian_K=F6nig?= <christian.koenig@amd.com>
cc: =?ISO-8859-2?Q?Micha=B3_Winiarski?= <michal.winiarski@intel.com>, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Fix BAR resizing when VF BARs are assigned
In-Reply-To: <a22a321a-0e60-474b-971c-8512189a69ca@amd.com>
Message-ID: <c5d1b5d8-8669-5572-75a7-0b480f581ac1@linux.intel.com>
References: <20241112134225.9837-1-ilpo.jarvinen@linux.intel.com> <a22a321a-0e60-474b-971c-8512189a69ca@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-120525138-1731421735=:13135"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-120525138-1731421735=:13135
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 12 Nov 2024, Christian K=C3=B6nig wrote:

> Am 12.11.24 um 14:42 schrieb Ilpo J=C3=A4rvinen:
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
>
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

Thanks for taking a look!

This is not about resizing 32bit BARs.

Is that somehow enforced so they cannot end up into the same bridge=20
window? Because we can only resize a bridge window if we release all its=20
child resources.

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

Oh right. I don't know why I ended up picking that other commit (sure, I=20
was also looking that other diff but maybe it was just a copy-paste=20
error).

--=20
 i.

> Regards,
> Christian.
>=20
> Reported-by: Micha=C5=82 Winiarski <michal.winiarski@intel.com>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci-sysfs.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5d0f4db1cab7..80b01087d3ef 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1440,7 +1440,7 @@ static ssize_t __resource_resize_store(struct devic=
e *dev, int=20
> n,
> =20
>  =09pci_remove_resource_files(pdev);
> =20
> -=09for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
> +=09for (i =3D 0; i < PCI_BRIDGE_RESOURCES; i++) {
>  =09=09if (pci_resource_len(pdev, i) &&
>  =09=09    pci_resource_flags(pdev, i) =3D=3D flags)
>  =09=09=09pci_release_resource(pdev, i);
>=20
>=20
>=20
>=20
--8323328-120525138-1731421735=:13135--

