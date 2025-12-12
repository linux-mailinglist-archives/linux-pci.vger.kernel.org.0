Return-Path: <linux-pci+bounces-43000-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4213FCB8F59
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 15:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E8BC3007DB9
	for <lists+linux-pci@lfdr.de>; Fri, 12 Dec 2025 14:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D75602DF707;
	Fri, 12 Dec 2025 14:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MLB5DR1R"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0682D24A7;
	Fri, 12 Dec 2025 14:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765549913; cv=none; b=XASYlNuSKA5SgiVOUpXiiWbzRtX6ABuRBQic8MIDKPErbOxk0uR4VYMfwumdGIoCP2z1EXGAVmMlZTVejgvLJf46kFeAhyftKEN9PDjUrVTEnYqrwdD8TrZrZUIDgizNC82u81wBDYH3jT/01UR5mO6UxcFtXgqGOiQO4c810zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765549913; c=relaxed/simple;
	bh=MgxXIa1BDqTTAMf9DtXmVXKosN8yKd7Oo66kn65jge8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=T2q7YAEY78dOPKGM8Q/HB3pGnDNCCyeriq9DCW0kuq4otcfRsXt6mW7jFWpeee2KCk9+0GK8YfffAEbJ/lP961DbDYBnv2WvIfV08o206eoJtKuoNkQl0IPBMxIZuEI8dx70rp5XwhWbM3nJMFBYEPsX/ido4F26et0+GNPD2/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MLB5DR1R; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765549912; x=1797085912;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=MgxXIa1BDqTTAMf9DtXmVXKosN8yKd7Oo66kn65jge8=;
  b=MLB5DR1RH61CKLH4UJ8lZleyMDI74Qx5YrngbI29Iq8qWnow0vzc8YtB
   /S7bzDGAZ+sOzAgNojKl3pseOyrzgAYXQOzJE/4FNGSFqGie60ImLgGN8
   RO/yf/N+nz/dLbaGxEMKrZjBr0ZU8Tx/W4B1BW5WopFTCZcC9vHcy6XUt
   PbmFI9k82Wph6L6ux2KD7XYz+TSodOYMg1X6K4D9DQC4v2p+PFnfGOg5s
   JPsR94JjwSF66L9852JjwgCSvfBSmGVVqGPe+MFOEllSGErhEWrkzyKgi
   lZYYXKloPxUTVhEhQus0p9NE0TZ+1+BkKgdj4MYJu96HGH3UXEYQ3LwI7
   w==;
X-CSE-ConnectionGUID: 2dw+PFOJShijMrcZo6qNFg==
X-CSE-MsgGUID: Nv0kwXqTTxywpKnLj7taLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="67494709"
X-IronPort-AV: E=Sophos;i="6.20,256,1758610800"; 
   d="scan'208";a="67494709"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 06:31:52 -0800
X-CSE-ConnectionGUID: mlnkK/wbRW+MGldG/Y9M4A==
X-CSE-MsgGUID: fC+YLh/6T2+gJyrew5jtZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,143,1763452800"; 
   d="scan'208";a="196177881"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.141])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2025 06:31:49 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 12 Dec 2025 16:31:45 +0200 (EET)
To: Jinhui Guo <guojinhui.liam@bytedance.com>
cc: bhelgaas@google.com, kbusch@kernel.org, dave.jiang@intel.com, 
    dan.j.williams@intel.com, linux-pci@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: Re: [PATCH v2] PCI: Fix incorrect unlocking in pci_slot_trylock()
In-Reply-To: <20251212133737.2367-1-guojinhui.liam@bytedance.com>
Message-ID: <7bb24dc0-8aac-dc32-8cad-d885282c34ec@linux.intel.com>
References: <20251212133737.2367-1-guojinhui.liam@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-41678387-1765549137=:1531"
Content-ID: <0df7a5f5-7357-4233-e1ee-10137bbdeb00@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-41678387-1765549137=:1531
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <e51834d2-2f13-054b-a6db-48fbf78c7904@linux.intel.com>

On Fri, 12 Dec 2025, Jinhui Guo wrote:

> Commit a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> delegates the bridge device's pci_dev_trylock() to pci_bus_trylock() in
> pci_slot_trylock(), but it forgets to remove the corresponding
> pci_dev_unlock() when pci_bus_trylock() fails.
>=20
> Before the commit, the code did:
>=20
>   if (!pci_dev_trylock(dev)) /* <- lock bridge device */
>     goto unlock;
>   if (dev->subordinate) {
>     if (!pci_bus_trylock(dev->subordinate)) {
>       pci_dev_unlock(dev);   /* <- unlock bridge device */
>       goto unlock;
>     }
>   }
>=20
> After the commit the bridge-device lock is no longer taken, but the
> pci_dev_unlock(dev) on the failure path was left in place, leading to
> the bug.
>=20
> This yields one of two errors:
> 1. A warning that the lock is being unlocked when no one holds it.
> 2. An incorrect unlock of a lock that belongs to another thread.
>=20
> Fix it by removing the now-redundant pci_dev_unlock(dev) on the failure
> path.
>=20
> Fixes: a4e772898f8b ("PCI: Add missing bridge lock to pci_bus_lock()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jinhui Guo <guojinhui.liam@bytedance.com>
> Acked-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

Please don't make tags like this unless the other people explicitly give=20
them to the patch.

Other than that, this looks okay to me.

--=20
 i.

> ---
>=20
> Hi, all
>=20
> v1: https://lore.kernel.org/all/20251211123635.2215-1-guojinhui.liam@byte=
dance.com/
>=20
> Changelog in v1 -> v2
>  - The v1 commit message was too brief, so I=E2=80=99ve sent v2 with more=
 detail.
>  - Remove the braces from the if (!pci_bus_trylock(dev->subordinate)) sta=
tement.
>=20
> Sorry for the noise.
>=20
> Best Regards,
> Jinhui
>=20
>  drivers/pci/pci.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 13dbb405dc31..59319e08fca6 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5346,10 +5346,8 @@ static int pci_slot_trylock(struct pci_slot *slot)
>  =09=09if (!dev->slot || dev->slot !=3D slot)
>  =09=09=09continue;
>  =09=09if (dev->subordinate) {
> -=09=09=09if (!pci_bus_trylock(dev->subordinate)) {
> -=09=09=09=09pci_dev_unlock(dev);
> +=09=09=09if (!pci_bus_trylock(dev->subordinate))
>  =09=09=09=09goto unlock;
> -=09=09=09}
>  =09=09} else if (!pci_dev_trylock(dev))
>  =09=09=09goto unlock;
>  =09}
>=20
--8323328-41678387-1765549137=:1531--

