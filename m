Return-Path: <linux-pci+bounces-39422-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499C0C0DA26
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 13:43:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4690219C10D9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 12:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 317AF3016FD;
	Mon, 27 Oct 2025 12:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzzw1vjO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E44C2F692F;
	Mon, 27 Oct 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761568775; cv=none; b=MluuOwUS8wG0zKKwiYuXFiDkXvTBFQCLtKl1IFWbDyPoP+Zo/hmdTw/Fo1OPx7o61ra+aqaec9ztsa5girp0I6a1DhNrPHfyhVDUTXERZ8sd/9UNjVXW2CQzt7Nn0bKTu/rXbxDi8gAnJjCCXgRS8Lt9jnbR57rGcMu4p0IrmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761568775; c=relaxed/simple;
	bh=yecWNA4wwbIRwYTkZaHccVrAfGqGyJNVVjd0Nl0ezqI=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pMzCbcWkQATMW7mEDjIpjdcNbHRceySWH7zl9Q8n8XGQqQnu3prZeOyp+VA1iiASWJBQGogxmkZ2+swRf1a4xr09vjElftQmX7u8qybHYuSWTKRhEsNfmVpYq+bPFMDx1hwrp9AqGB/1IRwUtl1Wfliznj7WUSVXJtyTczUqzkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzzw1vjO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761568773; x=1793104773;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=yecWNA4wwbIRwYTkZaHccVrAfGqGyJNVVjd0Nl0ezqI=;
  b=kzzw1vjOguKeH7t8znItpOhZNkol0wTHbQQfGiiKQskIGe7H4IppQo8K
   EBro3w4/tntfYvsbuQVMTQUYTi1ThMKJcNzyfoOEyOibg2upyhPyaZBpJ
   myq43xApGwQ593QAEqs4UpkGhK+vk8JWdWPRrxgBPxHDP5Gs/FUyx5Xhn
   +dSMrInc+32VVOKVajIalfiF9l2ZWdydts/v6FX6od9u3z4Lwv9P2vlhq
   HevD9q1tVl3+dA9hKhnXhK12LW89zcCNjy6apAvgQTpLuB1E89fRlUnf4
   L3AoL3vyWGtqdiSIg4uhz62uDjHtiGleOL8Bx4AOFl+zOJ9T6vQD4+VOi
   w==;
X-CSE-ConnectionGUID: I/A6WfjHQImYW85NTnXOMw==
X-CSE-MsgGUID: zmR8185wSgaGR7hyK12YAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63545274"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63545274"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:39:33 -0700
X-CSE-ConnectionGUID: AfKdF+xtQ1qvXv7IYHj5gQ==
X-CSE-MsgGUID: IwRhMD4yQpeHU9lAlDwbfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="184259452"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.41])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 05:39:31 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 27 Oct 2025 14:39:27 +0200 (EET)
To: Sasha Levin <sashal@kernel.org>
cc: patches@lists.linux.dev, stable@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.17-6.12] PCI: Set up bridge resources earlier
In-Reply-To: <20251025160905.3857885-86-sashal@kernel.org>
Message-ID: <4b5020d1-51c1-a556-175b-a4c4e1995c61@linux.intel.com>
References: <20251025160905.3857885-1-sashal@kernel.org> <20251025160905.3857885-86-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-1686847934-1761568758=:970"
Content-ID: <e73c78d0-09b7-c25a-0213-7ad3643b78bb@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1686847934-1761568758=:970
Content-Type: text/plain; CHARSET=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <52d35f17-b4f8-7315-e5bb-d31a6e9aa655@linux.intel.com>

On Sat, 25 Oct 2025, Sasha Levin wrote:

> From: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> [ Upstream commit a43ac325c7cbbfe72bdf9178059b3ee9f5a2c7dd ]
>=20
> Bridge windows are read twice from PCI Config Space, the first time from
> pci_read_bridge_windows(), which does not set up the device's resources.
> This causes problems down the road as child resources of the bridge canno=
t
> check whether they reside within the bridge window or not.
>=20
> Set up the bridge windows already in pci_read_bridge_windows().
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/20250924134228.1663-2-ilpo.jarvinen@linux.=
intel.com
> Signed-off-by: Sasha Levin <sashal@kernel.org>

This change was reverted by the commit 469276c06aff ("PCI: Revert early=20
bridge resource set up").

--
 i.


> ---
>=20
> LLM Generated explanations, may be completely bogus:
>=20
> YES
> - `pci_alloc_child_bus()` copies each subordinate bus window to
>   `child->resource[i] =3D &bridge->resource[PCI_BRIDGE_RESOURCES+i]`
>   before any child is scanned (`drivers/pci/probe.c:1245-1248`). Without
>   this patch, those `bridge->resource[...]` entries are still zeroed;
>   the first call to `pci_read_bridge_windows()` only logged with a
>   stack-local `struct resource`.
> - Child drivers often probe immediately (device_add =E2=86=92 bus_probe_d=
evice)
>   while the bus scan is still in progress. During their
>   `pci_enable_device()` they hit `pci_claim_resource()`
>   (`drivers/pci/setup-res.c:154-169`), which calls
>   `pci_find_parent_resource()` to make sure the BAR sits inside an
>   upstream bridge window (`drivers/pci/pci.c:737-767`). Because
>   `pcibios_fixup_bus()` (the point where `pci_read_bridge_bases()` re-
>   reads the window into the real resource) runs only after the entire
>   bus has been scanned (`drivers/pci/probe.c:3091-3106`), the parent
>   window is still zero and the containment test fails. Result:
>   `pci_enable_device()` reports =E2=80=9Ccan't claim; no compatible bridg=
e
>   window=E2=80=9D and the device never comes up behind that bridge.
> - The patch fixes that race by writing the values directly into the
>   bridge=E2=80=99s real resources the first time we read config space
>   (`drivers/pci/probe.c:540-588`). When the subordinate bus is created,
>   the copied pointers already describe the real aperture, so drivers can
>   claim their BARs successfully even if they probe before the later
>   fixup.
> - Behavioural risk is negligible: we still populate the same resource
>   structures with the same data, only earlier; the later
>   `pci_read_bridge_bases()` call simply refreshes them with `log=3Dfalse`=
=2E
>   No new dependencies or behavioural changes outside this bug fix path,
>   making it safe for stable.
>=20
> Natural next step: consider tagging with a `Fixes` reference upstream to
> ease stable selection.
>
>  drivers/pci/probe.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a56dfa1c9b6ff..0b8c82c610baa 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -524,10 +524,14 @@ static void pci_read_bridge_windows(struct pci_dev =
*bridge)
>  =09}
>  =09if (io) {
>  =09=09bridge->io_window =3D 1;
> -=09=09pci_read_bridge_io(bridge, &res, true);
> +=09=09pci_read_bridge_io(bridge,
> +=09=09=09=09   pci_resource_n(bridge, PCI_BRIDGE_IO_WINDOW),
> +=09=09=09=09   true);
>  =09}
> =20
> -=09pci_read_bridge_mmio(bridge, &res, true);
> +=09pci_read_bridge_mmio(bridge,
> +=09=09=09     pci_resource_n(bridge, PCI_BRIDGE_MEM_WINDOW),
> +=09=09=09     true);
> =20
>  =09/*
>  =09 * DECchip 21050 pass 2 errata: the bridge may miss an address
> @@ -565,7 +569,10 @@ static void pci_read_bridge_windows(struct pci_dev *=
bridge)
>  =09=09=09bridge->pref_64_window =3D 1;
>  =09}
> =20
> -=09pci_read_bridge_mmio_pref(bridge, &res, true);
> +=09pci_read_bridge_mmio_pref(bridge,
> +=09=09=09=09  pci_resource_n(bridge,
> +=09=09=09=09=09=09 PCI_BRIDGE_PREF_MEM_WINDOW),
> +=09=09=09=09  true);
>  }
> =20
>  void pci_read_bridge_bases(struct pci_bus *child)
>=20

--8323328-1686847934-1761568758=:970--

