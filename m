Return-Path: <linux-pci+bounces-20496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EDBCA2106E
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 19:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F891882A60
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 18:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7F01DE4D0;
	Tue, 28 Jan 2025 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jgUY2lPK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B1C1DE4C8;
	Tue, 28 Jan 2025 18:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738087247; cv=none; b=cC8CItS3GG0S8xOpnazL/xEwewOBul5I9v25KDzsW1tBfzewCNntlbKF2ZazjVR6EoCfiHZh2NqQQ+5QXjjWaBzXMPW7oNW++oGK8u2fkKguGX92Fr/zpqBBQQFp/ER6OfZoutZ2bBfXYNflweHHw3RqE5EszoeKsmkHx0ZNiy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738087247; c=relaxed/simple;
	bh=VXAfVuETim54AIO9RvnU7S5vrBW08hU1VDFbFRd4JRc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=G95gR7QJEzTKsT7KHUfzbQJXw/0F/Y73IOL9y4IVYz1aZw87whfaPxK7rzFiXSWWYY6s0nRu+EP9w+99bwo+v+YsiTE89gONdIkkPC73AyPILRGJ+uYwqoQe0JV3Qixl21a5b++l00tG8cnaR/HcHUKq9Sjt93ghGbwRlZ2u98Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jgUY2lPK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738087245; x=1769623245;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=VXAfVuETim54AIO9RvnU7S5vrBW08hU1VDFbFRd4JRc=;
  b=jgUY2lPKKBmPctezYEsJAtXA6yGlu737w3RR+jmAZnE6Bjq9mfsTeOxx
   MfweXt9nSo7jGsNkwRFriZ428787bP7zG12KrTjELJnySNMI/6Km781kz
   pk8moPtK7MfCxDe7VM1G+CwjjPdQul1AIAvLS++CKPXdnl4AUg5DklMMV
   sZISB5Dq9R+18zWdfOfRRd9lCIbxY7KoPS8P/lptvEueItS/Is+6vgzxa
   cSRP8eKUIseqbLoBTLL98blzQcc6VIH+JvgFbJHnnIyq5nXY/EfA1d0b2
   60roHvtYUdjb7i+r5fqfAZPKuIQTe2mcQo7H2gPWL/IkifPhth1S8+G1w
   A==;
X-CSE-ConnectionGUID: 479O+8cySUGkDpJ387lW3A==
X-CSE-MsgGUID: 0LVMiuzHR3mORNMjeJohJA==
X-IronPort-AV: E=McAfee;i="6700,10204,11329"; a="49568476"
X-IronPort-AV: E=Sophos;i="6.13,241,1732608000"; 
   d="scan'208";a="49568476"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:00:44 -0800
X-CSE-ConnectionGUID: VcNpFGWUSPuran+Rp+sfMg==
X-CSE-MsgGUID: 8ySRey2DSlaqZyOBOwS7dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109727772"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.65])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2025 10:00:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 28 Jan 2025 20:00:39 +0200 (EET)
To: Sasha Levin <sashal@kernel.org>
cc: LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Yazen Ghannam <yazen.ghannam@amd.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH AUTOSEL 6.13 13/15] PCI: Store number of supported End-End
 TLP Prefixes
In-Reply-To: <20250128175346.1197097-13-sashal@kernel.org>
Message-ID: <19475994-b606-604e-f17d-a5251026c4df@linux.intel.com>
References: <20250128175346.1197097-1-sashal@kernel.org> <20250128175346.1197097-13-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-125273046-1738087063=:943"
Content-ID: <a454467e-f70e-ab10-5504-a40b0a0459fb@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-125273046-1738087063=:943
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <82fe2192-25e5-7250-8d48-307f2f8ebcd3@linux.intel.com>

On Tue, 28 Jan 2025, Sasha Levin wrote:

> From: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
>=20
> [ Upstream commit e5321ae10e1323359a5067a26dfe98b5f44cc5e6 ]
>=20
> eetlp_prefix_path in the struct pci_dev tells if End-End TLP Prefixes
> are supported by the path or not, and the value is only calculated if
> CONFIG_PCI_PASID is set.
>=20
> The Max End-End TLP Prefixes field in the Device Capabilities Register 2
> also tells how many (1-4) End-End TLP Prefixes are supported (PCIe r6.2 s=
ec
> 7.5.3.15). The number of supported End-End Prefixes is useful for reading
> correct number of DWORDs from TLP Prefix Log register in AER capability
> (PCIe r6.2 sec 7.8.4.12).
>=20
> Replace eetlp_prefix_path with eetlp_prefix_max and determine the number =
of
> supported End-End Prefixes regardless of CONFIG_PCI_PASID so that an
> upcoming commit generalizing TLP Prefix Log register reading does not hav=
e
> to read extra DWORDs for End-End Prefixes that never will be there.
>=20
> The value stored into eetlp_prefix_max is directly derived from device's
> Max End-End TLP Prefixes and does not consider limitations imposed by
> bridges or the Root Port beyond supported/not supported flags. This is
> intentional for two reasons:
>=20
>   1) PCIe r6.2 spec sections 2.2.10.4 & 6.2.4.4 indicate that a TLP is
>      malformed only if the number of prefixes exceed the number of Max
>      End-End TLP Prefixes, which seems to be the case even if the device
>      could never receive that many prefixes due to smaller maximum impose=
d
>      by a bridge or the Root Port. If TLP parsing is later added, this
>      distinction is significant in interpreting what is logged by the TLP
>      Prefix Log registers and the value matching to the Malformed TLP
>      threshold is going to be more useful.
>=20
>   2) TLP Prefix handling happens autonomously on a low layer and the valu=
e
>      in eetlp_prefix_max is not programmed anywhere by the kernel (i.e.,
>      there is no limiter OS can control to prevent sending more than N TL=
P
>      Prefixes).
>=20
> Link: https://lore.kernel.org/r/20250114170840.1633-7-ilpo.jarvinen@linux=
=2Eintel.com
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Hi,

Why is this being auto selected? It's not a fix nor do I see any=20
dependency related tags. Unless the entire TLP consolidation would be=20
going into stable, I don't see much value for this change in stable=20
kernels.

--=20
 i.

> ---
>  drivers/pci/ats.c             |  2 +-
>  drivers/pci/probe.c           | 14 +++++++++-----
>  include/linux/pci.h           |  2 +-
>  include/uapi/linux/pci_regs.h |  1 +
>  4 files changed, 12 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pci/ats.c b/drivers/pci/ats.c
> index 6afff1f1b1430..c6b266c772c81 100644
> --- a/drivers/pci/ats.c
> +++ b/drivers/pci/ats.c
> @@ -410,7 +410,7 @@ int pci_enable_pasid(struct pci_dev *pdev, int featur=
es)
>  =09if (WARN_ON(pdev->pasid_enabled))
>  =09=09return -EBUSY;
> =20
> -=09if (!pdev->eetlp_prefix_path && !pdev->pasid_no_tlp)
> +=09if (!pdev->eetlp_prefix_max && !pdev->pasid_no_tlp)
>  =09=09return -EINVAL;
> =20
>  =09if (!pasid)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e81ab0f5a25c..381c22e3ccdbf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2251,8 +2251,8 @@ static void pci_configure_relaxed_ordering(struct p=
ci_dev *dev)
> =20
>  static void pci_configure_eetlp_prefix(struct pci_dev *dev)
>  {
> -#ifdef CONFIG_PCI_PASID
>  =09struct pci_dev *bridge;
> +=09unsigned int eetlp_max;
>  =09int pcie_type;
>  =09u32 cap;
> =20
> @@ -2264,15 +2264,19 @@ static void pci_configure_eetlp_prefix(struct pci=
_dev *dev)
>  =09=09return;
> =20
>  =09pcie_type =3D pci_pcie_type(dev);
> +
> +=09eetlp_max =3D FIELD_GET(PCI_EXP_DEVCAP2_EE_PREFIX_MAX, cap);
> +=09/* 00b means 4 */
> +=09eetlp_max =3D eetlp_max ?: 4;
> +
>  =09if (pcie_type =3D=3D PCI_EXP_TYPE_ROOT_PORT ||
>  =09    pcie_type =3D=3D PCI_EXP_TYPE_RC_END)
> -=09=09dev->eetlp_prefix_path =3D 1;
> +=09=09dev->eetlp_prefix_max =3D eetlp_max;
>  =09else {
>  =09=09bridge =3D pci_upstream_bridge(dev);
> -=09=09if (bridge && bridge->eetlp_prefix_path)
> -=09=09=09dev->eetlp_prefix_path =3D 1;
> +=09=09if (bridge && bridge->eetlp_prefix_max)
> +=09=09=09dev->eetlp_prefix_max =3D eetlp_max;
>  =09}
> -#endif
>  }
> =20
>  static void pci_configure_serr(struct pci_dev *dev)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eefd..21be5a1edf1ad 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -407,7 +407,7 @@ struct pci_dev {
>  =09=09=09=09=09   supported from root to here */
>  #endif
>  =09unsigned int=09pasid_no_tlp:1;=09=09/* PASID works without TLP Prefix=
 */
> -=09unsigned int=09eetlp_prefix_path:1;=09/* End-to-End TLP Prefix */
> +=09unsigned int=09eetlp_prefix_max:3;=09/* Max # of End-End TLP Prefixes=
, 0=3Dnot supported */
> =20
>  =09pci_channel_state_t error_state;=09/* Current connectivity state */
>  =09struct device=09dev;=09=09=09/* Generic device interface */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 1601c7ed5fab7..14a6306c4ce18 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -665,6 +665,7 @@
>  #define  PCI_EXP_DEVCAP2_OBFF_MSG=090x00040000 /* New message signaling =
*/
>  #define  PCI_EXP_DEVCAP2_OBFF_WAKE=090x00080000 /* Re-use WAKE# for OBFF=
 */
>  #define  PCI_EXP_DEVCAP2_EE_PREFIX=090x00200000 /* End-End TLP Prefix */
> +#define  PCI_EXP_DEVCAP2_EE_PREFIX_MAX=090x00c00000 /* Max End-End TLP P=
refixes */
>  #define PCI_EXP_DEVCTL2=09=090x28=09/* Device Control 2 */
>  #define  PCI_EXP_DEVCTL2_COMP_TIMEOUT=090x000f=09/* Completion Timeout V=
alue */
>  #define  PCI_EXP_DEVCTL2_COMP_TMOUT_DIS=090x0010=09/* Completion Timeout=
 Disable */
>=20
--8323328-125273046-1738087063=:943--

