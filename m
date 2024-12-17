Return-Path: <linux-pci+bounces-18645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 277B69F4FA2
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1F551883DC9
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 15:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3C1F7545;
	Tue, 17 Dec 2024 15:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fTHeZfZ0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88C61F755A;
	Tue, 17 Dec 2024 15:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734449821; cv=none; b=QPFNQ+CLjCwu6hSNX4fbKxlrEDPithuFH0Qz2vjXLYnoGfZFUYA4n46s/1XEyxKhPy1VeJDRdj1eSiIyOg8LBCCk3yj/ocxlqFgQ+YdUp8a+dI5yREiKxfjA3UC/baAgZaHBKTecEDEoM8xUeCAZ40Bq65OGEJ/aZxrw3tfxv40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734449821; c=relaxed/simple;
	bh=7khA5JcW71av4ThxWlBfqu2rJHa/l8SiGW54wOk9rwk=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=Enu8sBEWrAMurzvI8S/ozXLexrJ0ljwWpqqSQAo0BjLm/a0HKLDXksUCIDLHwqXERF522YTosfFT78dKm76A74UOCrPd9Vl8KNZr0bAi6Toj5yZPiF+flgacvAaEwNVISTZbJC6u0ggML3QpaVV4KJRMQNf5HAAwDqWwFAPbBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fTHeZfZ0; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734449819; x=1765985819;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7khA5JcW71av4ThxWlBfqu2rJHa/l8SiGW54wOk9rwk=;
  b=fTHeZfZ0N9FTINozhz8VYuNpeLduDCJx9SslvjxNS2rHYeWYGLYRuSO/
   q3p6lvIjmv3bchNp9xlkZtRrSbseiuY4PESGmSbOyr0/V4jBhePTkKjPn
   cJgN8FebbBiimyN3AXApXGEJV8WpVimeUTl83hubQlP1sbJMtf6JLvSGH
   9C6IGAMzDa/2utKKPBtx/c1Kukljmr4KvuX+V7WTp5GbstpkEnifgTCCh
   jURNws+43qs5nwEh6Crz++xHEenqUtXyD9K0b4gbhSSmzXnTh9YoH8nUa
   9d9sXEpIFli1UukrrCBdDCtMZ/7rJwAnDLy4ZLMNVPnx3HQwtQ2lRwG/+
   A==;
X-CSE-ConnectionGUID: mjLerT0eSdKMquSFyDJrrQ==
X-CSE-MsgGUID: oLQfZGteR2GgeH5htaMFqQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11288"; a="34610194"
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="34610194"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:36:59 -0800
X-CSE-ConnectionGUID: d6hHN4FZStOIlMxhNlCMqQ==
X-CSE-MsgGUID: wtU0e46sQ9m3H9Ev2SV1bA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,242,1728975600"; 
   d="scan'208";a="97457037"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.192])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 07:36:56 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 17 Dec 2024 17:36:51 +0200 (EET)
To: Bjorn Helgaas <bhelgaas@google.com>
cc: linux-pci@vger.kernel.org, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v7 6/8] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
In-Reply-To: <20241217135358.9345-7-ilpo.jarvinen@linux.intel.com>
Message-ID: <9fa49c5d-4939-db48-c815-ccb496c82d0b@linux.intel.com>
References: <20241217135358.9345-1-ilpo.jarvinen@linux.intel.com> <20241217135358.9345-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-798945083-1734449811=:924"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-798945083-1734449811=:924
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 17 Dec 2024, Ilpo J=C3=A4rvinen wrote:

> pcie_read_tlp_log() handles only 4 Header Log DWORDs but TLP Prefix Log
> (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
>=20
> Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> TLP Prefix Log. The relevant registers are formatted identically in AER
> and DPC Capability, but has these variations:
>=20
> a) The offsets of TLP Prefix Log registers vary.
> b) DPC RP PIO TLP Prefix Log register can be < 4 DWORDs.
> c) AER TLP Prefix Log Present (PCIe r6.1 sec 7.8.4.7) can indicate
>    Prefix Log is not present.
>=20
> Therefore callers must pass the offset of the TLP Prefix Log register
> and the entire length to pcie_read_tlp_log() to be able to read the
> correct number of TLP Prefix DWORDs from the correct offset.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/pci.h             |  5 +++-
>  drivers/pci/pcie/aer.c        |  5 +++-
>  drivers/pci/pcie/dpc.c        | 13 +++++----
>  drivers/pci/pcie/tlp.c        | 50 +++++++++++++++++++++++++++++++----
>  include/linux/aer.h           |  1 +
>  include/uapi/linux/pci_regs.h | 10 ++++---
>  6 files changed, 66 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 55fcf3bac4f7..7797b2544d00 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -550,7 +550,9 @@ struct aer_err_info {
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *=
info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> =20
> -int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_lo=
g *log);
> +int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> +=09=09      unsigned int tlp_len, struct pcie_tlp_log *log);
> +unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc);
>  #endif=09/* CONFIG_PCIEAER */
> =20
>  #ifdef CONFIG_PCIEPORTBUS
> @@ -569,6 +571,7 @@ void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
>  bool pci_dpc_recovered(struct pci_dev *pdev);
> +unsigned int dpc_tlp_log_len(struct pci_dev *dev);
>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) { }
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) { }
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 80c5ba8d8296..656dbf1ac45b 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -1248,7 +1248,10 @@ int aer_get_device_error_info(struct pci_dev *dev,=
 struct aer_err_info *info)
> =20
>  =09=09if (info->status & AER_LOG_TLP_MASKS) {
>  =09=09=09info->tlp_header_valid =3D 1;
> -=09=09=09pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG, &info->tlp);
> +=09=09=09pcie_read_tlp_log(dev, aer + PCI_ERR_HEADER_LOG,
> +=09=09=09=09=09  aer + PCI_ERR_PREFIX_LOG,
> +=09=09=09=09=09  aer_tlp_log_len(dev, aercc),
> +=09=09=09=09=09  &info->tlp);
>  =09=09}
>  =09}
> =20
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b6ef7efa3c1..7933b3cedb59 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -190,7 +190,7 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  static void dpc_process_rp_pio_error(struct pci_dev *pdev)
>  {
>  =09u16 cap =3D pdev->dpc_cap, dpc_status, first_error;
> -=09u32 status, mask, sev, syserr, exc, log, prefix;
> +=09u32 status, mask, sev, syserr, exc, log;
>  =09struct pcie_tlp_log tlp_log;
>  =09int i;
> =20
> @@ -217,20 +217,19 @@ static void dpc_process_rp_pio_error(struct pci_dev=
 *pdev)
> =20
>  =09if (pdev->dpc_rp_log_size < 4)
>  =09=09goto clear_status;
> -=09pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG, &tlp_log=
);
> +=09pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG,
> +=09=09=09  cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG,
> +=09=09=09  dpc_tlp_log_len(pdev), &tlp_log);
>  =09pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
>  =09=09tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
> +=09for (i =3D 0; i < pdev->dpc_rp_log_size - 5; i++)
> +=09=09pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, tlp_log.pref=
ix[i]);
> =20
>  =09if (pdev->dpc_rp_log_size < 5)
>  =09=09goto clear_status;
>  =09pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &lo=
g);
>  =09pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
> =20
> -=09for (i =3D 0; i < pdev->dpc_rp_log_size - 5; i++) {
> -=09=09pci_read_config_dword(pdev,
> -=09=09=09cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
> -=09=09pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
> -=09}
>   clear_status:
>  =09pci_write_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_STATUS, status)=
;
>  }
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 65ac7b5d8a87..0c4bf6a50d7e 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -11,26 +11,66 @@
> =20
>  #include "../pci.h"
> =20
> +/**
> + * aer_tlp_log_len - Calculates AER Capability TLP Header/Prefix Log len=
gth
> + * @dev: PCIe device
> + *
> + * Return: TLP Header/Prefix Log length
> + */
> +unsigned int aer_tlp_log_len(struct pci_dev *dev, u32 aercc)

Hmpf, it seems I forgot to move the @aercc kerneldoc from Flit mode series=
=20
patch were it was originally added to here when I needed aercc to the
PCI_ERR_CAP_PREFIX_LOG_PRESENT check.

I'll send an update in a day or two.

> +{
> +=09return 4 + (aercc & PCI_ERR_CAP_PREFIX_LOG_PRESENT) ?
> +=09=09   dev->eetlp_prefix_max : 0;
> +}

--
 i.
--8323328-798945083-1734449811=:924--

