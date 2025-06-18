Return-Path: <linux-pci+bounces-30023-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6446DADE709
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 11:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA792189EACF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 09:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2F283FFD;
	Wed, 18 Jun 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h5MsZdyw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1293D283159;
	Wed, 18 Jun 2025 09:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239145; cv=none; b=YAuT1uRBiRaK3Uqe+D0cM1XXg0rMukc/y5W/HaJi8b+T1wBJA/dooMK/NpxYDG7FQzZMkZ0rqdLur/anYhg0+x7YrgrH4Ke4UJXka6Adu/S/Bzv7xJ0zUjcJDhXpTHP1HICJlgJQlIjIVnWaVxEXUEBYO/1SQuqWpoqJlrhwXRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239145; c=relaxed/simple;
	bh=KrQ0onIb+7NFb9sUoQzwdd/17n68FZWwYwr631AwQWY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=E9nsLqtK3MTy0l60CsAq/9LPwN9YErW6PTQYVtZ9W2i+c+NVkYJc/YoSFdqLk+2lYy5OpvTDQbQ63vW1ciyID9m5/JvNtVtwd9QyIVxxDgfQg1PNQAP1CsXoN8t/ay5J586IoS+NDucR7cmoAw1x4LRrRgzRQKQGP40Eh2nh5pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=h5MsZdyw; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750239144; x=1781775144;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KrQ0onIb+7NFb9sUoQzwdd/17n68FZWwYwr631AwQWY=;
  b=h5MsZdywbk2FKIqXn5APi8IDk3XyS3FWD0avqjcs5GVof8gH/O1m22er
   ew0anYgVQ2toSbfH4x+VXc1CeDhIJP+8BqnmvWxA9js2QWgwzMa628Czr
   Ibfv0tMZH2UAwwObKZ2y6OV6rzzWVOo+KkwuIe5FZfRpHkScirVvRe+bz
   Hlbd2bXM3tYpnQsVbIx0ge6Mf+opDeZcVwTyvcMuLSKuh08KrD0rbeObw
   q7XgjlDLer/0GuqLZNfdyQBGthrPvTKhI5fKmP6nnXZbU4FCXy56WeU7x
   p/HJ6HQ99ErnqJyCznfOxZjlFSyRpmAIbs2Rfirr5FYfGuFXujvwIUOlT
   w==;
X-CSE-ConnectionGUID: PmXeGDRVSniVBF4yHCkoTA==
X-CSE-MsgGUID: GJSnyGhaSeWTifRKxNma1A==
X-IronPort-AV: E=McAfee;i="6800,10657,11467"; a="52591273"
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="52591273"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 02:31:15 -0700
X-CSE-ConnectionGUID: GWlbSQDjQc+KbcqnqSmX5g==
X-CSE-MsgGUID: DGM5gtY7TOqB5B0Mfp9Dug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,245,1744095600"; 
   d="scan'208";a="149221935"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.62])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jun 2025 02:31:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 18 Jun 2025 12:31:08 +0300 (EEST)
To: Chris Li <chrisl@kernel.org>
cc: Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
    linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI/MSI: Remove duplicated to_pci_dev() conversion
In-Reply-To: <20250617-pci-msi-avoid-dup-pcidev-v1-1-ed75b0419023@kernel.org>
Message-ID: <90e3f84d-860e-74dc-139e-6dc39775e888@linux.intel.com>
References: <20250617-pci-msi-avoid-dup-pcidev-v1-1-ed75b0419023@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-469012803-1750239068=:963"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-469012803-1750239068=:963
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Jun 2025, Chris Li wrote:

> In the pci_msi_update_mask() function, "lock =3D &to_pci_dev()" does the
> "to_pci_dev()" lookup, and there's another one buried inside
> "msi_desc_to_pci_dev()"
>=20
> Introduce a local variable to remove that duplication.
>=20
> Signed-off-by: Chris Li <chrisl@kernel.org>
> ---
>  drivers/pci/msi/msi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 6ede55a7c5e652c80b51b10e58f0290eb6556430..78bed2def9d870d6457514367=
93238ef2bc8b3ed 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *dev)
> =20
>  void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
>  {
> -=09raw_spinlock_t *lock =3D &to_pci_dev(desc->dev)->msi_lock;
> +=09struct pci_dev *dev =3D msi_desc_to_pci_dev(desc);
> +=09raw_spinlock_t *lock =3D &dev->msi_lock;
>  =09unsigned long flags;
> =20
>  =09if (!desc->pci.msi_attrib.can_mask)
> @@ -122,8 +123,7 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 c=
lear, u32 set)
>  =09raw_spin_lock_irqsave(lock, flags);
>  =09desc->pci.msi_mask &=3D ~clear;
>  =09desc->pci.msi_mask |=3D set;
> -=09pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
> -=09=09=09       desc->pci.msi_mask);
> +=09pci_write_config_dword(dev, desc->pci.mask_pos, desc->pci.msi_mask);
>  =09raw_spin_unlock_irqrestore(lock, flags);
>  }

Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-469012803-1750239068=:963--

