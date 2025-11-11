Return-Path: <linux-pci+bounces-40910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B46A2C4E1D9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 913C41898355
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963593370FE;
	Tue, 11 Nov 2025 13:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k5HHy5nt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC079328277;
	Tue, 11 Nov 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762867867; cv=none; b=WNB9YG/uKpHWqwP+XDq8Zv4horO5UFFV3cmDm85I02lh340lnrqreQ1abfsuQZQgu2w7QbevXWYxb7VNj9FJS1S2JU4WKB/Ww8FIt8DBsUCQ7cAR+2az5ZSVUaw+b43nZluyXGOKcsu2t76veMUgdaj+Dws0uAtIlFm6OQNyLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762867867; c=relaxed/simple;
	bh=ZN7ilIPCvm1ED39/18OAcpT6wbPgwA+407V2M/i4Nuk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uUq8S5/G7PYZv80IPUUf6rWa6JOuYp0pipagTDGkEgbEX1nBgRxDlm3/ru++8SEtaQ43rLZXp48pnQi7dXZaZbjz4xQDCUur//XYv3uPjSrkb+Il/TII39werO2ivDdiRiHgJthvDpoLKG5JirFzuxfxenFDcjOZYcXMDT0yP4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k5HHy5nt; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762867866; x=1794403866;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ZN7ilIPCvm1ED39/18OAcpT6wbPgwA+407V2M/i4Nuk=;
  b=k5HHy5ntZnEcVowuzDVXwthgjT6bSQ5rDMgbDiVV/gi7qpvNkrBMw134
   wgSBrfXaHSjKL02pr0uwFYiY2RmZmkYwHBDVg/f73Wr5fe7pw3MW9k9U8
   v+Huf/tU8DSRWwtzErCNLFIUWLhKreD6kZJXTb71aedz7RjeLExIGaDjb
   VbnKIVAVmtMnF+XOnUNNUAvz6KJi0NZW1I/EQnDy+uoXjgQ1wGWYVxPLU
   IlhKZDgUJOVLsS0+V9Tsn8aN4kO6x04Y/F3EzMSvRm+zJ765oNLVjEcvt
   kDVm5tVs2SchiCvjgSPiIreold71a90Voy7u5aK7KaGv50MZemUEm96P2
   w==;
X-CSE-ConnectionGUID: vGzsgCXtSuqv81LuWdnB4A==
X-CSE-MsgGUID: 3dGoK7P9Q/SpSkq/XDqDEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="68776232"
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="68776232"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:30:57 -0800
X-CSE-ConnectionGUID: g74Wvx2uRIK5WbjK9OJ2cw==
X-CSE-MsgGUID: 0bViU1sPRQKPBMIty2HMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,296,1754982000"; 
   d="scan'208";a="194162513"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.132])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2025 05:30:54 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 11 Nov 2025 15:30:50 +0200 (EET)
To: =?ISO-8859-15?Q?H=E5kon_Bugge?= <haakon.bugge@oracle.com>
cc: Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@codeaurora.org>, 
    linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Do not attempt to set ExtTag for VFs
In-Reply-To: <20251111132401.1827922-1-haakon.bugge@oracle.com>
Message-ID: <dc6f1dc8-a2e7-d48f-49a2-ee6e0288e672@linux.intel.com>
References: <20251111132401.1827922-1-haakon.bugge@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-955354008-1762867850=:1002"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-955354008-1762867850=:1002
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 11 Nov 2025, H=C3=A5kon Bugge wrote:

> The bit for enabling extended tags is Reserved and Preserved (RsvdP)
> for VFs.

Please add a PCIe spec reference.

> Hence, bail out early from pci_configure_extended_tags() if
> the device is a VF.
>=20
> Otherwise, we may see incorrect log messages such as:
>=20
> =09   kernel: pci 0000:af:00.2: enabling Extended Tags
>=20
> (af:00.2 is a VF)
>=20
> Fixes: 60db3a4d8cc9 ("PCI: Enable PCIe Extended Tags if supported")
> Signed-off-by: H=C3=A5kon Bugge <haakon.bugge@oracle.com>
> ---
>  drivers/pci/probe.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a87..014017e15bcc8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2244,7 +2244,8 @@ int pci_configure_extended_tags(struct pci_dev *dev=
, void *ign)
>  =09u16 ctl;
>  =09int ret;
> =20
> -=09if (!pci_is_pcie(dev))
> +=09/* PCI_EXP_DEVCTL_EXT_TAG is RsvdP in VFs */
> +=09if (!pci_is_pcie(dev) || dev->is_virtfn)
>  =09=09return 0;
> =20
>  =09ret =3D pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
>=20

--=20
 i.

--8323328-955354008-1762867850=:1002--

