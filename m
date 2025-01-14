Return-Path: <linux-pci+bounces-19752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62684A11043
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 19:36:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFFBE3A17CE
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jan 2025 18:36:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0783F18952C;
	Tue, 14 Jan 2025 18:36:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E65C1D5145;
	Tue, 14 Jan 2025 18:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736879772; cv=none; b=dP3akPRepEWwsjH1LL+iiC5zhOdMmUiWnvSFkH8LtFx9YCAVsnCRCAGvyq0jv1kNSoS7VogqGk9szhB0UeVWlOQRBKp6e/OqhEEi0gx5QIt7iATAhrzRoRKJITzM3jIhh5aHVtU76tByRRsvJ/u72EDhUv2jOTKV5FGbhDVHBGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736879772; c=relaxed/simple;
	bh=SVUkcGtN3ZI2lcs3S7vVYuEqrU62/LlK+Q38K0VQPc4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g9JyyjXpJ7v1+FkAbVhL0W6N3LaTyZ/mNM/9I+RVz1ft+Z4uz/KIpuucI4+2QdMqPhqeCduSesii0kXrUG0iCD+AZLfP/NHoX5ciRsETSqwcVM0z1EMbJQnQ4TpV5teohMXIXKLGlp8IwdN4v7TY1zejZC2ZWvrdqI6yzLQfS1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXd7y0YLDz6M4NF;
	Wed, 15 Jan 2025 02:34:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 05A4814022E;
	Wed, 15 Jan 2025 02:36:06 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 19:36:05 +0100
Date: Tue, 14 Jan 2025 18:36:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>, "Yazen
 Ghannam" <yazen.ghannam@amd.com>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, Lukas Wunner <lukas@wunner.de>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 3/8] PCI: Add defines for TLP Header/Prefix log sizes
Message-ID: <20250114183603.00001df8@huawei.com>
In-Reply-To: <20250114170840.1633-4-ilpo.jarvinen@linux.intel.com>
References: <20250114170840.1633-1-ilpo.jarvinen@linux.intel.com>
	<20250114170840.1633-4-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 14 Jan 2025 19:08:35 +0200
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

> Add defines for AER and DPC capabilities TLP Header Logging register
> sizes (PCIe r6.2, sec 7.8.4 / 7.9.14) and replace literals with them.
>=20
> Suggested-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Hi Ilpo,

Where it is simply the number of entries I think the changes make sense.

Where it is about whether the log reaches a defined register I'd be more
tempted to use the register addresses to figure it out + length for the last
one.  That avoids a rather magic +- 1 in various places.

Jonathan


> ---
>  drivers/pci/pcie/dpc.c | 10 ++++++----
>  drivers/pci/pcie/tlp.c |  2 +-
>  drivers/pci/quirks.c   |  6 ++++--
>  include/linux/aer.h    |  9 ++++++++-
>  4 files changed, 19 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 2b6ef7efa3c1..0674d8c89bfa 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -215,18 +215,18 @@ static void dpc_process_rp_pio_error(struct pci_dev=
 *pdev)
>  				first_error =3D=3D i ? " (First)" : "");
>  	}
> =20
> -	if (pdev->dpc_rp_log_size < 4)
> +	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG)

This I'm fine with.

>  		goto clear_status;
>  	pcie_read_tlp_log(pdev, cap + PCI_EXP_DPC_RP_PIO_HEADER_LOG, &tlp_log);
>  	pci_err(pdev, "TLP Header: %#010x %#010x %#010x %#010x\n",
>  		tlp_log.dw[0], tlp_log.dw[1], tlp_log.dw[2], tlp_log.dw[3]);
> =20
> -	if (pdev->dpc_rp_log_size < 5)
> +	if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG + 1)

As below. Can we build this from difference in register instead so somethin=
g like

	if (pdev->dpc_rpc_log_size <=3D
            (PCIE_EXP_DPC_RP_PIO_IMPSPEC_LOG - PCIE_EXP_DPC_RP_PIO_HEADER_L=
OG) / 4)

>  		goto clear_status;
>  	pci_read_config_dword(pdev, cap + PCI_EXP_DPC_RP_PIO_IMPSPEC_LOG, &log);
>  	pci_err(pdev, "RP PIO ImpSpec Log %#010x\n", log);
> =20
> -	for (i =3D 0; i < pdev->dpc_rp_log_size - 5; i++) {
> +	for (i =3D 0; i < pdev->dpc_rp_log_size - PCIE_STD_NUM_TLP_HEADERLOG - =
1; i++) {

This is a bit ugly.  Can we instead build it based on difference in registe=
rs and
avoid the mysterious +-1?
(PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG - PCI_EXP_DPC_RPIO_HEADER_LOG) / 4 ?

>  		pci_read_config_dword(pdev,
>  			cap + PCI_EXP_DPC_RP_PIO_TLPPREFIX_LOG + i * 4, &prefix);
>  		pci_err(pdev, "TLP Prefix Header: dw%d, %#010x\n", i, prefix);
> @@ -404,7 +404,9 @@ void pci_dpc_init(struct pci_dev *pdev)
>  	if (!pdev->dpc_rp_log_size) {
>  		pdev->dpc_rp_log_size =3D
>  				FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, cap);
> -		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
> +		if (pdev->dpc_rp_log_size < PCIE_STD_NUM_TLP_HEADERLOG ||
> +		    pdev->dpc_rp_log_size > PCIE_STD_NUM_TLP_HEADERLOG + 1 +
> +					    PCIE_STD_MAX_TLP_PREFIXLOG) {
Could also construct this one from register offset and the max size of the =
log.

>  			pci_err(pdev, "RP PIO log size %u is invalid\n",
>  				pdev->dpc_rp_log_size);
>  			pdev->dpc_rp_log_size =3D 0;
> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 3f053cc62290..4cc76bd1867a 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -28,7 +28,7 @@ int pcie_read_tlp_log(struct pci_dev *dev, int where,
> =20
>  	memset(tlp_log, 0, sizeof(*tlp_log));
> =20
> -	for (i =3D 0; i < 4; i++) {
> +	for (i =3D 0; i < PCIE_STD_NUM_TLP_HEADERLOG; i++) {
>  		ret =3D pci_read_config_dword(dev, where + i * 4,
>  					    &tlp_log->dw[i]);
>  		if (ret)
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 76f4df75b08a..84487615e1d1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -12,6 +12,7 @@
>   * file, where their drivers can use them.
>   */
> =20
> +#include <linux/aer.h>
>  #include <linux/align.h>
>  #include <linux/bitfield.h>
>  #include <linux/types.h>
> @@ -6233,8 +6234,9 @@ static void dpc_log_size(struct pci_dev *dev)
>  		return;
> =20
>  	if (FIELD_GET(PCI_EXP_DPC_RP_PIO_LOG_SIZE, val) =3D=3D 0) {
> -		pci_info(dev, "Overriding RP PIO Log Size to 4\n");
> -		dev->dpc_rp_log_size =3D 4;
> +		pci_info(dev, "Overriding RP PIO Log Size to %d\n",
> +			 PCIE_STD_NUM_TLP_HEADERLOG);
> +		dev->dpc_rp_log_size =3D PCIE_STD_NUM_TLP_HEADERLOG;
>  	}
>  }
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 190a0a2061cd..4ef6515c3205 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -16,10 +16,17 @@
>  #define AER_CORRECTABLE			2
>  #define DPC_FATAL			3
> =20
> +/*
> + * AER and DPC capabilities TLP Logging register sizes (PCIe r6.2, sec 7=
.8.4
> + * & 7.9.14).
> + */
> +#define PCIE_STD_NUM_TLP_HEADERLOG     4
> +#define PCIE_STD_MAX_TLP_PREFIXLOG     4
> +
>  struct pci_dev;
> =20
>  struct pcie_tlp_log {
> -	u32 dw[4];
> +	u32 dw[PCIE_STD_NUM_TLP_HEADERLOG];
>  };
> =20
>  struct aer_capability_regs {


