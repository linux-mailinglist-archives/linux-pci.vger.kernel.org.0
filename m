Return-Path: <linux-pci+bounces-30748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B534EAE9D1A
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC2247A26CE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 12:01:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAD861CFBA;
	Thu, 26 Jun 2025 11:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZsGyhV+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26864277C96
	for <linux-pci@vger.kernel.org>; Thu, 26 Jun 2025 11:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939157; cv=none; b=qHT0KLTwVRVDU5JQjorMIJQuAs54hScBsRCDe8EANrpVPHsdGHhuey8h3YWU9svgfprPUvEiam8RbC+1Kho9xnixUUVHDLhdHyz8cIju5p3rJoaOT0bzaP1OOXcPMhZLwjcQKm+XBVuGu2rwoPYTUWVXCGW1u02aqQ0LOmnDimo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939157; c=relaxed/simple;
	bh=WlLK/1M7deDK9+SoWalG07eIYKYtUdhHrUU9wQpGM7g=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=DzqaJoRFufin2O8T2j01VXYEO1nGfoPdJKuY+lwNJwC+1Yo0Eij8aqBQ/TFqMkmZFvj8g+OfGT0E8iSR+zXcUxrmM5fi0fSTaJWzy4s0wLUYTk/e/IG00lUwEjkmMkneC0pc0U/Iwb5/vT65z3OQ9jHnYL6ZiSKxW/ofuyv97gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZsGyhV+; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750939156; x=1782475156;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=WlLK/1M7deDK9+SoWalG07eIYKYtUdhHrUU9wQpGM7g=;
  b=aZsGyhV+AgxzgubIXI8HDZAN/5NbxAuz0jOHXgzrfnpNVpGDPZAFIz2v
   TBYQKhSp2RwERPRZsSrVC3nH8tOApbtYA2wRN0jAiyK8kcerBTOF1B5xI
   X2zxzthFVkXnvruDo2LLkR1cApYAhG+D/xoh5Do+RCVyeavOcdI5t0jz9
   bkJEsWeUAaWqM4oSe+ClG8Iaz6zPwzgfYdRpI17O6ib58ZqNPOUPeJ59N
   jdpWwfqKSqEZhOr8CUx2sNxyvUUcoFUK0w8o90mZy67ZGBfnrwChbER+s
   xo4MyT9DUOP1j92S2Q9SWzdv6RFeJGjGU5yCOIPDjinUDOziRDGGh6Eqk
   w==;
X-CSE-ConnectionGUID: 0vkr6MxnRHave+E4+8kq1Q==
X-CSE-MsgGUID: gYgG/PdxT86xdDtJQCp60w==
X-IronPort-AV: E=McAfee;i="6800,10657,11475"; a="53375016"
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="53375016"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 04:59:15 -0700
X-CSE-ConnectionGUID: /2B2vIbyRC699lZuuS9K8g==
X-CSE-MsgGUID: 6Kh8o3MwS4e1EIy/IB8pDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,267,1744095600"; 
   d="scan'208";a="156775882"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.144])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jun 2025 04:59:12 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 26 Jun 2025 14:59:08 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Laurent Bigonville <bigon@bigon.be>, 
    Mario Limonciello <mario.limonciello@amd.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, 
    Mika Westerberg <westeri@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/ACPI: Fix runtime PM ref imbalance on hot-plug
 capable ports
In-Reply-To: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
Message-ID: <15cd2ea9-3ab9-04ae-2881-9459ec85c18d@linux.intel.com>
References: <86c3bd52bda4552d63ffb48f8a30343167e85271.1750698221.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-2083449483-1750938816=:930"
Content-ID: <66119a1b-d384-d559-99a3-8742dd40478c@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2083449483-1750938816=:930
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <68c820c1-b4a5-8242-887d-cd8a2350d689@linux.intel.com>

On Mon, 23 Jun 2025, Lukas Wunner wrote:

> pcie_portdrv_probe() and pcie_portdrv_remove() both call
> pci_bridge_d3_possible() to determine whether to use runtime power
> management.  The underlying assumption is that pci_bridge_d3_possible()
> always returns the same value because otherwise a runtime PM reference
> imbalance occurs.
>=20
> That assumption falls apart if the device is inaccessible on ->remove()
> due to hot-unplug:  pci_bridge_d3_possible() calls pciehp_is_native(),
> which accesses Config Space to determine whether the device is Hot-Plug
> Capable.   An inaccessible device returns "all ones", which is converted
> to "all zeroes" by pcie_capability_read_dword().  Hence the device no
> longer seems Hot-Plug Capable on ->remove() even though it was on
> ->probe().
>=20
> The resulting runtime PM ref imbalance causes errors such as:
>=20
>   pcieport 0000:02:04.0: Runtime PM usage count underflow!
>=20
> The Hot-Plug Capable bit is cached in pci_dev->is_hotplug_bridge.
> pci_bridge_d3_possible() only calls pciehp_is_native() if that flag is
> set.  Re-checking the bit in pciehp_is_native() is thus unnecessary.
>=20
> However pciehp_is_native() is also called from hotplug_is_native().  Move
> the Config Space access to that function.  The function is only invoked
> from acpiphp_glue.c, so move it there instead of keeping it in a publicly
> visible header.
>=20
> Fixes: 5352a44a561d ("PCI: pciehp: Make pciehp_is_native() stricter")
> Reported-by: Laurent Bigonville <bigon@bigon.be>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220216
> Reported-by: Mario Limonciello <mario.limonciello@amd.com>
> Closes: https://lore.kernel.org/r/20250609020223.269407-3-superm1@kernel.=
org/
> Link: https://lore.kernel.org/all/20250620025535.3425049-3-superm1@kernel=
=2Eorg/T/#u
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v4.18+

Hmm, I suspect this fixes the root cause for TB unplug while suspended=20
which did have these RPM underflows. I saw them in logs while we were=20
looking into LBMS interactions with the Target Speed quirk (that most=20
visibly caused extra 60s delay, which was solved).

Back then, I briefly tried find solution to the underflow problem too but=
=20
couldn't come up anything useful and as it looked relatively harmless I=20
ended up postponing looking deeper into it.

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

> ---
>  drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++++++
>  drivers/pci/pci-acpi.c             |  5 -----
>  include/linux/pci_hotplug.h        |  4 ----
>  3 files changed, 15 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acp=
iphp_glue.c
> index 5b1f271c6034..ae2bb8970f63 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -50,6 +50,21 @@ static void acpiphp_sanitize_bus(struct pci_bus *bus);
>  static void hotplug_event(u32 type, struct acpiphp_context *context);
>  static void free_bridge(struct kref *kref);
> =20
> +static bool hotplug_is_native(struct pci_dev *bridge)
> +{
> +=09u32 slot_cap;
> +
> +=09pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> +
> +=09if (slot_cap & PCI_EXP_SLTCAP_HPC && pciehp_is_native(bridge))
> +=09=09return true;
> +
> +=09if (shpchp_is_native(bridge))
> +=09=09return true;
> +
> +=09return false;
> +}
> +
>  /**
>   * acpiphp_init_context - Create hotplug context and grab a reference to=
 it.
>   * @adev: ACPI device object to create the context for.
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index b78e0e417324..57bce9cc8a38 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -816,15 +816,10 @@ int pci_acpi_program_hp_params(struct pci_dev *dev)
>  bool pciehp_is_native(struct pci_dev *bridge)
>  {
>  =09const struct pci_host_bridge *host;
> -=09u32 slot_cap;
> =20
>  =09if (!IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
>  =09=09return false;
> =20
> -=09pcie_capability_read_dword(bridge, PCI_EXP_SLTCAP, &slot_cap);
> -=09if (!(slot_cap & PCI_EXP_SLTCAP_HPC))
> -=09=09return false;
> -
>  =09if (pcie_ports_native)
>  =09=09return true;
> =20
> diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
> index ec77ccf1fc4d..02efeea62b25 100644
> --- a/include/linux/pci_hotplug.h
> +++ b/include/linux/pci_hotplug.h
> @@ -102,8 +102,4 @@ static inline bool pciehp_is_native(struct pci_dev *b=
ridge) { return true; }
>  static inline bool shpchp_is_native(struct pci_dev *bridge) { return tru=
e; }
>  #endif
> =20
> -static inline bool hotplug_is_native(struct pci_dev *bridge)
> -{
> -=09return pciehp_is_native(bridge) || shpchp_is_native(bridge);
> -}
>  #endif
>=20
--8323328-2083449483-1750938816=:930--

