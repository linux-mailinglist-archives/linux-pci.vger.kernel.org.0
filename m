Return-Path: <linux-pci+bounces-21349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C788A340DE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 14:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D7DA16A7CE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2025 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEAE12E7F;
	Thu, 13 Feb 2025 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M3ntzWuX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D6924BC15;
	Thu, 13 Feb 2025 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454886; cv=none; b=UtyCLM7hOATlLMb+Z3QdFVSngUOHJrWcd4HJWFzhls4k9aaqdtE+5DdpDs9VJ4L8kjx1Rz7/+oRu3hGkxgIR3+j9wlxm5Fnp4TBpek/1XiVIY2FLe6BxxkB2KJhrtPQ6d047v7Yd37ld5nE+/qg++R781C8TqR3CeGyepaQRRuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454886; c=relaxed/simple;
	bh=cJI7jSGBeMlBar7+EWkFpZ1IplMJwWUEjiBSpKW+aD0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=upokSkebtIE841HypjqzYlY07J/3bjxiu4235k5deF/0cfI3jFqJcd6/S/JiOjvJlZr+PoFYZdCp/cqKTd08l1t4LnX3HMnCIWcJq1PVA3piG37RVaKj9zTRtiiAuerS78Zp/7jsh/LDu7Ia5lHEjvQ/jIv1BfXpLIJzmPtNBS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M3ntzWuX; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739454885; x=1770990885;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=cJI7jSGBeMlBar7+EWkFpZ1IplMJwWUEjiBSpKW+aD0=;
  b=M3ntzWuXKsu0Lsw78cFz5n0az1tE4psH0GMz1CFXZcRkqXSXFGpGt/nS
   qgpUCL/KQVpdDNVgm7H8ezrAsXwNPlmyyKYo5C2zeeAspFEkayoivdnhf
   nizNMqqI6GeWiMg6vcNpNGTPDdu7dFkGdLqadV8v92j0lrjEZYUmPbiA9
   Wiy0hn24i8lktTiHEII58o0ZpfR3rAK93sp5MnWluyYwrFIEsKywl+NJ/
   AxcWTlIHv6pkFav9X3CXQoyajwkv6aT5GsinP02pBzK+1zIoPibut9EVK
   u17HG3QCHX2IUpiQagx+Ph8xjEfyuxFbk9ApFmbdQ55H6BSVHI9FtLm6S
   g==;
X-CSE-ConnectionGUID: oDUTqKLhTjWZXVuYcxoYVw==
X-CSE-MsgGUID: 3NcqEwsgQUKDo4vN05Od0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11344"; a="51554182"
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="51554182"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:54:45 -0800
X-CSE-ConnectionGUID: q185DkdGTQyur7kuyCwDkw==
X-CSE-MsgGUID: vNmTYbuhT/Klxw9nmHksTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,282,1732608000"; 
   d="scan'208";a="113020022"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.48])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 05:54:42 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 13 Feb 2025 15:54:39 +0200 (EET)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: Alex Williamson <alex.williamson@redhat.com>, 
    =?ISO-8859-15?Q?Christian_K=F6nig?= <ckoenig.leichtzumerken@gmail.com>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/2] PCI: Cache offset of Resizable BAR capability
In-Reply-To: <20250208050329.1092214-3-helgaas@kernel.org>
Message-ID: <75bb62bd-7944-1d74-ad84-fd676c8bfb91@linux.intel.com>
References: <20250208050329.1092214-1-helgaas@kernel.org> <20250208050329.1092214-3-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-264264680-1739454879=:12944"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-264264680-1739454879=:12944
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 7 Feb 2025, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
>=20
> Previously most resizable BAR interfaces (pci_rebar_get_possible_sizes(),
> pci_rebar_set_size(), etc) as well as pci_restore_state() searched config
> space for a Resizable BAR capability.  Most devices don't have such a
> capability, so this is wasted effort, especially for pci_restore_state().
>=20
> Search for a Resizable BAR capability once at enumeration-time and cache
> the offset so we don't have to search every time we need it.  No function=
al
> change intended.
>=20
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c   | 9 +++++++--
>  drivers/pci/pci.h   | 1 +
>  drivers/pci/probe.c | 1 +
>  include/linux/pci.h | 1 +
>  4 files changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 503376bf7e75..cf2632080a94 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -1872,7 +1872,7 @@ static void pci_restore_rebar_state(struct pci_dev =
*pdev)
>  =09unsigned int pos, nbars, i;
>  =09u32 ctrl;
> =20
> -=09pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +=09pos =3D pdev->rebar_cap;
>  =09if (!pos)
>  =09=09return;
> =20
> @@ -3719,6 +3719,11 @@ void pci_acs_init(struct pci_dev *dev)
>  =09pci_enable_acs(dev);
>  }
> =20
> +void pci_rebar_init(struct pci_dev *pdev)
> +{
> +=09pdev->rebar_cap =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBA=
R);
> +}
> +
>  /**
>   * pci_rebar_find_pos - find position of resize ctrl reg for BAR
>   * @pdev: PCI device
> @@ -3733,7 +3738,7 @@ static int pci_rebar_find_pos(struct pci_dev *pdev,=
 int bar)
>  =09unsigned int pos, nbars, i;
>  =09u32 ctrl;
> =20
> -=09pos =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_REBAR);
> +=09pos =3D pdev->rebar_cap;
>  =09if (!pos)
>  =09=09return -ENOTSUPP;
> =20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 01e51db8d285..d7b46ddfd6d2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -799,6 +799,7 @@ static inline int acpi_get_rc_resources(struct device=
 *dev, const char *hid,
>  }
>  #endif
> =20
> +void pci_rebar_init(struct pci_dev *pdev);
>  int pci_rebar_get_current_size(struct pci_dev *pdev, int bar);
>  int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size);
>  static inline u64 pci_rebar_size_to_bytes(int size)
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index b6536ed599c3..24dd3dcfd223 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2564,6 +2564,7 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)
>  =09pci_rcec_init(dev);=09=09/* Root Complex Event Collector */
>  =09pci_doe_init(dev);=09=09/* Data Object Exchange */
>  =09pci_tph_init(dev);=09=09/* TLP Processing Hints */
> +=09pci_rebar_init(dev);=09=09/* Resizable BAR */
> =20
>  =09pcie_report_downtraining(dev);
>  =09pci_init_reset_methods(dev);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 47b31ad724fa..9e5bbd996c83 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -353,6 +353,7 @@ struct pci_dev {
>  =09struct pci_dev  *rcec;          /* Associated RCEC device */
>  #endif
>  =09u32=09=09devcap;=09=09/* PCIe Device Capabilities */
> +=09u16=09=09rebar_cap;=09/* Resizable BAR capability offset */
>  =09u8=09=09pcie_cap;=09/* PCIe capability offset */
>  =09u8=09=09msi_cap;=09/* MSI capability offset */
>  =09u8=09=09msix_cap;=09/* MSI-X capability offset */

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

--=20
 i.

--8323328-264264680-1739454879=:12944--

