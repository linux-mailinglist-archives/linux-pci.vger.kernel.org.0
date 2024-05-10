Return-Path: <linux-pci+bounces-7355-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 256B98C2494
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 14:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26BD281B1D
	for <lists+linux-pci@lfdr.de>; Fri, 10 May 2024 12:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702616E87D;
	Fri, 10 May 2024 12:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AuN1cc7P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F7C21340;
	Fri, 10 May 2024 12:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715343175; cv=none; b=QGr2145De/9gwvIEA7IRD7hbhrMBznv2GYAT3I7k7/DHRhzWeLOPNq2GxjchrtALu9jNCR3UlHQByOjAKcFRcn/u2dDOV6ndpQMGWMUpYIgKvnLG32xBgFX9y73h65EHfOZ691lmxX0ms4PHMF/RnC1Dod4vSaj60YkN8JXtuu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715343175; c=relaxed/simple;
	bh=kpZQw+P2vcgkj+W1Iz5jlQU7T5p0A1MbKo7EuUSjcAY=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=iiBcsOgK/awgGBT+AZFTIjV7mVUX0CkCScewlS/Xf7Mnbwf87mu3s2qypO931DRCviABwkoBQTvyOKZAGtWgqTGKes3R2lqB2WDT/3fk9knxl4BDehQbY/bRak4ndZOSs+ZOycNL8x821bDh3Z8aE/LrospC7yT+ThCaqubI5fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AuN1cc7P; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715343174; x=1746879174;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=kpZQw+P2vcgkj+W1Iz5jlQU7T5p0A1MbKo7EuUSjcAY=;
  b=AuN1cc7PbX8KxaaG+KseWAoHl2I1l7iUTIQoRHfo+rz8P7FRzgXsKa0O
   jD4RrrCCmGolrfHh38tm2/ifd1s9SjCRBTi/Opb3enhXxH4FkIX7odmXi
   2n67tsWBIPMtXZ4JGfJaGhm2cJIGAirJELSHBQrv/0gIkVTqhaAJmfvsI
   G+sX9K1DQqhsjArllyZwYVUWo3KMRLIqP3X8/1rvnS1f1s9E2eKRaU9Jn
   jJp1BnZ6ZW601MglTlHYxtho7DIU9g36otnWWax4udpZhFcb9IyhhOA0v
   pZTiXueC6/huQfVUvgBuxWqXdmsLFSls2cnYLXS3FKCQo9NcxmBaTxWyp
   A==;
X-CSE-ConnectionGUID: TlSi32ayQb6yPJd9Ds6agA==
X-CSE-MsgGUID: MA8gz5jmQ9m6fIk0PiJ9PQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="33832756"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="33832756"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:12:54 -0700
X-CSE-ConnectionGUID: 0utjR1UFRM63Xx1lpDbLTw==
X-CSE-MsgGUID: Ogl5fA/MQ0uTVQyLsYV8Vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="29546609"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.85])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 05:12:51 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Fri, 10 May 2024 15:12:47 +0300 (EEST)
To: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Lukas Wunner <lukas@wunner.de>, 
    LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 6/7] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
In-Reply-To: <20240510100730.18805-7-ilpo.jarvinen@linux.intel.com>
Message-ID: <7d69ae9f-9d2f-2482-eaa7-d3e31037c8d1@linux.intel.com>
References: <20240510100730.18805-1-ilpo.jarvinen@linux.intel.com> <20240510100730.18805-7-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-204770702-1715343167=:1562"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-204770702-1715343167=:1562
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Fri, 10 May 2024, Ilpo J=C3=A4rvinen wrote:

> pcie_read_tlp_log() handles only 4 Header Log DWORDs but TLP Prefix Log
> (PCIe r6.1 secs 7.8.4.12 & 7.9.14.13) may also be present.
>=20
> Generalize pcie_read_tlp_log() and struct pcie_tlp_log to handle also
> TLP Prefix Log. The relevant registers are formatted identically in AER
> and DPC Capability, but has these variations:
>=20
> a) The offsets of TLP Prefix Log registers vary.
> b) DPC RP PIO TLP Prefix Log register can be < 4 DWORDs.
>=20
> Therefore callers must pass the offset of the TLP Prefix Log register
> and the entire length to pcie_read_tlp_log() to be able to read the
> correct number of TLP Prefix DWORDs from the correct offset.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/pci/pci.h             |  5 +++-
>  drivers/pci/pcie/aer.c        |  4 ++-
>  drivers/pci/pcie/dpc.c        | 13 +++++-----
>  drivers/pci/pcie/tlp.c        | 47 +++++++++++++++++++++++++++++++----
>  include/linux/aer.h           |  1 +
>  include/uapi/linux/pci_regs.h |  1 +
>  6 files changed, 57 insertions(+), 14 deletions(-)
>=20
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 0e9917f8bf3f..3d9034d89be8 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -420,7 +420,10 @@ struct aer_err_info {
>  int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *=
info);
>  void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> =20
> -int pcie_read_tlp_log(struct pci_dev *dev, int where, struct pcie_tlp_lo=
g *log);
> +int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> +=09=09      unsigned int tlp_len, struct pcie_tlp_log *log);
> +unsigned int aer_tlp_log_len(struct pci_dev *dev);
> +unsigned int dpc_tlp_log_len(struct pci_dev *dev);
>  #endif=09/* CONFIG_PCIEAER */
> =20
>  #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 65ac7b5d8a87..3615ca520c9a 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -11,26 +11,63 @@
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
> +unsigned int aer_tlp_log_len(struct pci_dev *dev)
> +{
> +=09return 4 + dev->eetlp_prefix_max;
> +}
> +
> +/**
> + * dpc_tlp_log_len - Calculates DPC RP PIO TLP Header/Prefix Log length
> + * @dev: PCIe device
> + *
> + * Return: TLP Header/Prefix Log length
> + */
> +unsigned int dpc_tlp_log_len(struct pci_dev *pdev)
> +{
> +=09/* Remove ImpSpec Log register from the count */
> +=09if (pdev->dpc_rp_log_size >=3D 5)

Scratch this. LKP's randconfig build seems to have caught this failing to=
=20
build when AER is enabled but DPC is not because this member doesn't exist=
=20
w/o DPC.

> +=09=09return pdev->dpc_rp_log_size - 1;
> +
> +=09return pdev->dpc_rp_log_size;
> +}


--=20
 i.

--8323328-204770702-1715343167=:1562--

