Return-Path: <linux-pci+bounces-17943-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386039E96B2
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:27:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34FD916AFA8
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DCBE1A238E;
	Mon,  9 Dec 2024 13:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoZtRIx4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBF1A238B
	for <linux-pci@vger.kernel.org>; Mon,  9 Dec 2024 13:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750281; cv=none; b=IJfq6BTGw5RL6iDfYm16HdzPU8OKng2OFRUO0gquBxXYlaQ3bUxUhjOoB1OjKX2Mdb3U/S+LdL+B8qiI9cG6Nin70YFTaiSQrvDVqvS2fEifA39N72g7qlH6+QhxEcZcW6eOId8uuzXNKc8z79t1OFlX7ADUe6GE5s4eTD2Ql48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750281; c=relaxed/simple;
	bh=egUvmeqdvJCr5g8oulskcCn2sZFvteUTk5ZmehLR4FM=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=VJgFVzio4tH32cTlL0YQdF19X3n+Y7BuU75z33zQyb96zCbeqgd9jZ//DH0vcSL/DNHgB3K67Y/JU5/JJjaAVnK39qcuCf/zm0uOX9Dq0ZgevNkdRLu7lxpMkSMrt4q5F8v5Wbr+ThRqSIC6RrP0PZt79vbqBv3194kP6IIz7mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoZtRIx4; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733750279; x=1765286279;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=egUvmeqdvJCr5g8oulskcCn2sZFvteUTk5ZmehLR4FM=;
  b=OoZtRIx4VzPGSjZaZReSAinZe2Nldz9UP6gD7lRs7tMmmkf2WmOdwYKm
   OQ6EMHJyGWjSU12/FlAZp7u7oEDp7MBtvmEPjxtNbDDfvFNzmELqVaxEG
   qoi5Sp9oCRW2gi1guPRhqX088o/DSrWH4TM7vaqUSN0+uM+YTa4q0UqO+
   VliaKRDuOnN9HsRl6MSVrbS5sfVI/C68r3WXJxlr4Xfv9njiTvotgb7oO
   4nQuVDyGKeK34iT+UhllMvCnJYQrHzcQD5pQFkcKFwqpwpaokZjMnMzas
   HQMxRFqPU3Jwj3Y1BPxGKDwgYi5zPAyW4b6z4gH/PhnBBY0VBYJdXkgv9
   w==;
X-CSE-ConnectionGUID: fqVp3a2NQNKrUa0yTLn1Ig==
X-CSE-MsgGUID: vABXKwmiSHK55KdZwfc61Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33386005"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33386005"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:17:59 -0800
X-CSE-ConnectionGUID: H3ILv4LURieifk7HT9h/Yw==
X-CSE-MsgGUID: PA8JQkFTS/WQfTMLmQ11Ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="95272993"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.121])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:17:55 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Mon, 9 Dec 2024 15:17:52 +0200 (EET)
To: Dan Williams <dan.j.williams@intel.com>
cc: linux-coco@lists.linux.dev, Lukas Wunner <lukas@wunner.de>, 
    Bjorn Helgaas <bhelgaas@google.com>, Samuel Ortiz <sameo@rivosinc.com>, 
    Alexey Kardashevskiy <aik@amd.com>, Xu Yilun <yilun.xu@linux.intel.com>, 
    linux-pci@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 07/11] PCI: Add PCIe Device 3 Extended Capability
 enumeration
In-Reply-To: <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
Message-ID: <37f7c14e-e104-0508-4a41-e62d9e36ec47@linux.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com> <173343743678.1074769.15403889527436764173.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-173094615-1733745290=:938"
Content-ID: <ae22ced4-ba35-463b-883c-5fe8fe5858d2@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-173094615-1733745290=:938
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <939dd909-ea12-2d0f-d147-3ab3448a46f2@linux.intel.com>

On Thu, 5 Dec 2024, Dan Williams wrote:

> PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> enumerates new link capabilities and status added for Gen 6 devices. One
> of the link details enumerated in that register block is the "Segment
> Captured" status in the Device Status 3 register. That status is
> relevant for enabling IDE (Integrity & Data Encryption) whereby
> Selective IDE streams can be limited to a given requester id range
> within a given segment.
>=20
> If a device has captured its Segment value then it knows that PCIe Flit
> Mode is enabled via all links in the path that a configuration write
> traversed. IDE establishment requires that "Segment Base" in
> IDE RID Association Register 2 (PCIe 6.2 Section 7.9.26.5.4.2) be
> programmed if the RID association mechanism is in effect.
>=20
> When / if IDE + Flit Mode capable devices arrive, the PCI core needs to
> setup the segment base when using the RID association facility, but no
> known deployments today depend on this.
>=20
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Cc: Alexey Kardashevskiy <aik@amd.com>
> Cc: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/pci.h             |   11 +++++++++++
>  drivers/pci/probe.c           |    1 +
>  include/linux/pci.h           |    1 +
>  include/uapi/linux/pci_regs.h |    7 +++++++
>  4 files changed, 20 insertions(+)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0537fc72d5be..6565eb72ded2 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -444,6 +444,17 @@ static inline void pci_doe_destroy(struct pci_dev *p=
dev) { }
>  static inline void pci_doe_disconnected(struct pci_dev *pdev) { }
>  #endif
> =20
> +static inline void pci_dev3_init(struct pci_dev *pdev)
> +{
> +=09u16 cap =3D pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DEV3);
> +=09u32 val =3D 0;
> +
> +=09if (!cap)
> +=09=09return;
> +=09pci_read_config_dword(pdev, cap + PCI_DEV3_STA, &val);
> +=09pdev->fm_enabled =3D !!(val & PCI_DEV3_STA_SEGMENT);
> +}
> +
>  #ifdef CONFIG_PCI_NPEM
>  void pci_npem_create(struct pci_dev *dev);
>  void pci_npem_remove(struct pci_dev *dev);
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 7cddde3cb0ed..6c1fe6354d26 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2517,6 +2517,7 @@ static void pci_init_capabilities(struct pci_dev *d=
ev)
>  =09pci_rcec_init(dev);=09=09/* Root Complex Event Collector */
>  =09pci_doe_init(dev);=09=09/* Data Object Exchange */
>  =09pci_tph_init(dev);=09=09/* TLP Processing Hints */
> +=09pci_dev3_init(dev);=09=09/* Device 3 capabilities */
>  =09pci_ide_init(dev);=09=09/* Link Integrity and Data Encryption */
>  =09pci_tsm_init(dev);=09=09/* TEE Security Manager connection */
> =20
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index a0900e7d2012..10d035395a43 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -443,6 +443,7 @@ struct pci_dev {
>  =09unsigned int=09pasid_enabled:1;=09/* Process Address Space ID */
>  =09unsigned int=09pri_enabled:1;=09=09/* Page Request Interface */
>  =09unsigned int=09tph_enabled:1;=09=09/* TLP Processing Hints */
> +=09unsigned int=09fm_enabled:1;=09=09/* Flit Mode (segment captured) */
>  =09unsigned int=09is_managed:1;=09=09/* Managed via devres */
>  =09unsigned int=09is_msi_managed:1;=09/* MSI release via devres installe=
d */
>  =09unsigned int=09needs_freset:1;=09=09/* Requires fundamental reset */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.=
h
> index 19bba65a262c..c61231861b51 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -749,6 +749,7 @@
>  #define PCI_EXT_CAP_ID_NPEM=090x29=09/* Native PCIe Enclosure Management=
 */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE=090x2E=09/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_DEV3=090x2F=09/* Device 3 Capability/Control/Stat=
us */
>  #define PCI_EXT_CAP_ID_IDE=090x30    /* Integrity and Data Encryption */
>  #define PCI_EXT_CAP_ID_MAX=09PCI_EXT_CAP_ID_IDE
> =20
> @@ -1210,6 +1211,12 @@
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL=09=090x00ff0000
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_NEXT_INDEX=090xff000000
> =20
> +/* Device 3 Extended Capability */
> +#define PCI_DEV3_CAP=09=090x4=09/* Device 3 Capabilities Register */
> +#define PCI_DEV3_CTL=09=090x8=09/* Device 3 Control Register */

Should save/restore too be added for DEV3_CTL?

--=20
 i.

> +#define PCI_DEV3_STA=09=090xc=09/* Device 3 Status Register */
> +#define  PCI_DEV3_STA_SEGMENT=090x8=09/* Segment Captured (end-to-end fl=
it-mode detected) */
> +
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
>  #define PCI_DVSEC_CXL_PORT=09=09=09=093
>  #define PCI_DVSEC_CXL_PORT_CTL=09=09=09=090x0c
>=20
--8323328-173094615-1733745290=:938--

