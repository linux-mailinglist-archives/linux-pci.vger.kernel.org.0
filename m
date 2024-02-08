Return-Path: <linux-pci+bounces-3233-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E302A84E04A
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 13:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684451F2DEB1
	for <lists+linux-pci@lfdr.de>; Thu,  8 Feb 2024 12:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3AC06F525;
	Thu,  8 Feb 2024 12:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bpG0u926"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BBD5427E;
	Thu,  8 Feb 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707393719; cv=none; b=uL+d/OQFxL7F3f/ln2lrehzPmcROT6d2O7tCLHVsBYBm+dRxksXd7/VpnO0jWeaAqbvfkGwofwEzhyJ2Ff28zZWyZi8TdO1i8vWKQQcILUE+0UXfPjvlLMuHxATBfH8vwg7nEA5BTyAiVBUbIgSMKBSygKji9NG89L92yTOJpIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707393719; c=relaxed/simple;
	bh=Bp2axIzpydbDdzx7rIR662PM0ZeEAlhqHzC3pxDKkJc=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Z3QXvi9dvWtzaCMJSmJJ+j8xL82RVkMWtbNcJUJFVx/00Yf06knXiXeWF8zYCL2sZ658chiC2glxbR2+EUeE4rrAUkcoC2d6MZO8OYVqbFC/dFnhosYda7BppQtzwYYDsdaOCq2EkmBJiPVyfarVWWI8bv5NJZUo22XgxUAlEGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bpG0u926; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707393718; x=1738929718;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Bp2axIzpydbDdzx7rIR662PM0ZeEAlhqHzC3pxDKkJc=;
  b=bpG0u926YOglxvMhvWgFZHwJzVDFmEcICdESJp9d2C8Dif0iOeh5nvCF
   o7hejSfRqLpFEtWL1WeIOcL1P2xadDrtJR0Y3uPpps5f0sVLMZN35Vu5a
   LtLFZ72jsTiC753N7KJ4zyh8eSMewZpobrzI474mxbvWduBRXYUjXKgAJ
   kBIDwZwD+vf1a9J9XKgnuZIgDwG7GepilNiODsfRtKK4bgDMWknOj1fmd
   dLwTUBrCjX9bsMeq9nnby3RuzYkBlC50d2jJJUAR6FaQH+jLaAETtxGFA
   OBqWpXMfDdpl9Z2NgW6YN/I6ExoCmP/2tlynWKi0PIMaR6O0VFGqZIYu7
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="1101908"
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="1101908"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:01:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,253,1701158400"; 
   d="scan'208";a="6405159"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.52.95])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2024 04:01:52 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 8 Feb 2024 14:01:49 +0200 (EET)
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, 
    Yazen Ghannam <yazen.ghannam@amd.com>
Subject: Re: [PATCH v9] PCI/DPC: Ignore Surprise Down error on hot removal
In-Reply-To: <20240207181854.121335-1-Smita.KoralahalliChannabasappa@amd.com>
Message-ID: <3c5da397-6d72-26cd-7204-4388ff3da1dd@linux.intel.com>
References: <20240207181854.121335-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1029937450-1707393709=:1104"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1029937450-1707393709=:1104
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 7 Feb 2024, Smita Koralahalli wrote:

> According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result i=
n
> surprise down error. This error is expected and is just a side-effect of
> async remove.
>=20
> Ignore surprise down error generated as a side-effect of async remove.
> Typically, this error is benign as the pciehp handler invoked by PDC
> or/and DLLSC alongside DPC, de-enumerates and brings down the device
> appropriately. But the error messages might confuse users. Get rid of
> these irritating log messages with a 1s delay while pciehp waits for
> dpc recovery.
>=20
> The implementation is as follows: On an async remove a DPC is triggered
> along with a Presence Detect State change and/or DLL State Change.
> Determine it's an async remove by checking for DPC Trigger Status in DPC
> Status Register and Surprise Down Error Status in AER Uncorrected Error
> Status to be non-zero. If true, treat the DPC event as a side-effect of
> async remove, clear the error status registers and continue with hot-plug
> tear down routines. If not, follow the existing routine to handle AER and
> DPC errors.
>=20
> Please note that, masking Surprise Down Errors was explored as an
> alternative approach, but left due to the odd behavior that masking only
> avoids the interrupt, but still records an error per PCIe r6.0.1 Section
> 6.2.3.2.2. That stale error is going to be reported the next time some
> error other than Surprise Down is handled.
>=20
> Dmesg before:
>=20
>   pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0=
000
>   pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
>   pcieport 0000:00:01.4: PCIe Bus Error: severity=3DUncorrected (Fatal), =
type=3DTransaction Layer, (Receiver ID)
>   pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=3D0000002=
0/04004000
>   pcieport 0000:00:01.4:    [ 5] SDES (First)
>   nvme nvme2: frozen state error detected, reset controller
>   pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000=
 msec
>   pcieport 0000:00:01.4: AER: subordinate device reset failed
>   pcieport 0000:00:01.4: AER: device recovery failed
>   pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>   nvme2n1: detected capacity change from 1953525168 to 0
>   pci 0000:04:00.0: Removing from iommu group 49
>=20
> Dmesg after:
>=20
>  pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
>  nvme1n1: detected capacity change from 1953525168 to 0
>  pci 0000:04:00.0: Removing from iommu group 37
>=20
> [1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
>     https://members.pcisig.com/wg/PCI-SIG/document/16609
>=20
> Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
> Reviewed-by: Lukas Wunner <lukas@wunner.de>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux=
=2Eintel.com>

> +static void pci_clear_surpdn_errors(struct pci_dev *pdev)
> +{
> +=09if (pdev->dpc_rp_extensions)
> +=09=09pci_write_config_dword(pdev, pdev->dpc_cap +
> +=09=09=09=09       PCI_EXP_DPC_RP_PIO_STATUS, ~0);
> +
> +=09/*
> +=09 * In practice, Surprise Down errors have been observed to also set
> +=09 * error bits in the Status Register as well as the Fatal Error
> +=09 * Detected bit in the Device Status Register.
> +=09 */
> +=09pci_write_config_word(pdev, PCI_STATUS, 0xffff);

Nit: one of these is using ~0 and the other 0xffff which is a bit=20
inconsistent.

> +static bool dpc_is_surprise_removal(struct pci_dev *pdev)
> +{
> +=09u16 status;
> +
> +=09if (!pdev->is_hotplug_bridge)
> +=09=09return false;
> +
> +=09if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
> +=09=09=09=09 &status))
> +=09=09return false;

Since you need a line split, I'd have used:
=09ret =3D pci_read_config_word(...
=09=09=09=09   ...);
=09if (ret !=3D PCIBIOS_SUCCESSFUL)
=09=09return false;

Reviewed-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>


--=20
 i.

--8323328-1029937450-1707393709=:1104--

