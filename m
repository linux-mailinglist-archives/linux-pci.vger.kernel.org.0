Return-Path: <linux-pci+bounces-30494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B3AE6382
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 13:23:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECB3A17B4D5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 11:23:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B97FD248F6F;
	Tue, 24 Jun 2025 11:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GVgcU9KG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA54B289E3F
	for <linux-pci@vger.kernel.org>; Tue, 24 Jun 2025 11:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750764221; cv=none; b=DVUI3rh4WT18GEzUUuA/5asE0ROSPOoJd6ljvjg8AwRcbG3DVefwTyaPvMXgzW9sZW4t6Z+CMegfuUMrU0FN9AqAbekH5V3OwQoeRHpdQ+uBuHPCq5sycp4zOL6zk9oI7T3RT23rq3f1cTYJf7O26qFLkgCVZ0fOJ/2JPj2Vu7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750764221; c=relaxed/simple;
	bh=Pdd2IqOay3tUA/o6SLZEbrS+Ws8JwXxYI2q35gKztm0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=oQAHK6+M9NcRl6fKn3N5eGN31XZfh4+4FLFsDWvUFGxXChCotwIc3Qzg0jJd81oNTSHMPRk8F6q6DN8/Mmdn0C7pLvbmIYdQ4peec8k4vxR+eAD8EPCtsxBReFPr4e60hzO0mCzFbdZRM+shfJ3IWREpe8UVFehYMpMFuQ9caWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GVgcU9KG; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750764220; x=1782300220;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Pdd2IqOay3tUA/o6SLZEbrS+Ws8JwXxYI2q35gKztm0=;
  b=GVgcU9KG/bTIZgiO5RHD7GESNOKXxHmU9UrAxdGoSp4M0/8sdAb006qk
   Z2M0uMVvQFdg43RtGjLQtUMrVd+zEsEjRh/TFfLfk0fFMcfKWCGLS1v6X
   fwZ5tSe7S7sTset0pxve+VHzF8HfrnsDo778+I4gpHlkKCQ8isRQpGk7D
   ymUCJjOO+5YtCbDtWe9CsTrzJAzc1hqb48YJoRMXLZQfw7CL5r6OszkFX
   LF5jS1B2yDkpluJSkqqmYDiYxEwR1ofQOhhVaicNhfJgpaf+4+rmpI+wg
   r23fuCkb5+mZENlOkIZRzjPCAEG2DDMGj+gmWIjoUqpMA/C0+gjUKB45u
   g==;
X-CSE-ConnectionGUID: ULNf8607TyuZiMfHAROhwg==
X-CSE-MsgGUID: gAzneI/oQ02HirpzTzKQyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="52867902"
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="52867902"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:23:39 -0700
X-CSE-ConnectionGUID: Qo3RS344QTOuVthfYWpYuA==
X-CSE-MsgGUID: aAGp3UH2TE+hUeJfPIj1FA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,261,1744095600"; 
   d="scan'208";a="157386992"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.16])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2025 04:23:36 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 24 Jun 2025 14:23:33 +0300 (EEST)
To: Lukas Wunner <lukas@wunner.de>
cc: Bjorn Helgaas <helgaas@kernel.org>, Andrew <andreasx0@protonmail.com>, 
    "Maciej W. Rozycki" <macro@orcam.me.uk>, 
    Matthew W Carlis <mattc@purestorage.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: Fix link speed calculation on retrain failure
In-Reply-To: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>
Message-ID: <78b87a33-3e46-aabd-3f88-db5c1130c20c@linux.intel.com>
References: <1c92ef6bcb314ee6977839b46b393282e4f52e74.1750684771.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-880527929-1750764213=:943"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-880527929-1750764213=:943
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Mon, 23 Jun 2025, Lukas Wunner wrote:

> When pcie_failed_link_retrain() fails to retrain, it tries to revert to
> the previous link speed.  However it calculates that speed from the Link
> Control 2 register without masking out non-speed bits first.
>=20
> PCIE_LNKCTL2_TLS2SPEED() converts such incorrect values to
> PCI_SPEED_UNKNOWN, which in turn causes a WARN splat in
> pcie_set_target_speed():
>=20
>   pci 0000:00:01.1: [1022:14ed] type 01 class 0x060400 PCIe Root Port
>   pci 0000:00:01.1: broken device, retraining non-functional downstream l=
ink at 2.5GT/s
>   pci 0000:00:01.1: retraining failed
>   WARNING: CPU: 1 PID: 1 at drivers/pci/pcie/bwctrl.c:168 pcie_set_target=
_speed
>   RDX: 0000000000000001 RSI: 00000000000000ff RDI: ffff9acd82efa000
>   pcie_failed_link_retrain
>   pci_device_add
>   pci_scan_single_device
>   pci_scan_slot
>   pci_scan_child_bus_extend
>   acpi_pci_root_create
>   pci_acpi_scan_root
>   acpi_pci_root_add
>   acpi_bus_attach
>   device_for_each_child
>   acpi_dev_for_each_child
>   acpi_bus_attach
>   device_for_each_child
>   acpi_dev_for_each_child
>   acpi_bus_attach
>   acpi_bus_scan
>   acpi_scan_init
>   acpi_init
>=20
> Per the calling convention of the System V AMD64 ABI, the arguments to
> pcie_set_target_speed(struct pci_dev *, enum pci_bus_speed, bool) are
> stored in RDI, RSI, RDX.  As visible above, RSI contains 0xff, i.e.
> PCI_SPEED_UNKNOWN.
>=20
> Fixes: f68dea13405c ("PCI: Revert to the original speed after PCIe failed=
 link retraining")
> Reported-by: Andrew <andreasx0@protonmail.com>
> Closes: https://lore.kernel.org/r/7iNzXbCGpf8yUMJZBQjLdbjPcXrEJqBxy5-bHfp=
pz0ek-h4_-G93b1KUrm106r2VNF2FV_sSq0nENv4RsRIUGnlYZMlQr2ZD2NyB5sdj5aU=3D@pro=
tonmail.com/
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: stable@vger.kernel.org # v6.12+
> ---
>  drivers/pci/quirks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index d7f4ee6..deaaf4f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -108,7 +108,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKCTL2, &lnkctl2);
>  =09pcie_capability_read_word(dev, PCI_EXP_LNKSTA, &lnksta);
>  =09if (!(lnksta & PCI_EXP_LNKSTA_DLLLA) && pcie_lbms_seen(dev, lnksta)) =
{
> -=09=09u16 oldlnkctl2 =3D lnkctl2;
> +=09=09u16 oldlnkctl2 =3D lnkctl2 & PCI_EXP_LNKCTL2_TLS;
> =20
>  =09=09pci_info(dev, "broken device, retraining non-functional downstream=
 link at 2.5GT/s\n");

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

IIRC, there was a patch from somebody else which fixed this a bit=20
differently but never got applied (many months ago by now).

--=20
 i.

--8323328-880527929-1750764213=:943--

