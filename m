Return-Path: <linux-pci+bounces-18161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA8049ED29D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 17:49:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00271882012
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 16:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A66139CF2;
	Wed, 11 Dec 2024 16:49:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD71DDC14;
	Wed, 11 Dec 2024 16:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733935753; cv=none; b=SroBEeyH3BGnirXawMxTlbHNIWDqVjTh9kKnVfUKd7r7Jj5zx17SXMcaT9JLxx6fx9sBC0vIZ0BoJx2biRtaHlQPD3CRgTHza4+Y1kKQXDZTNY/SR37AChH/UHzcPYJRksyyMzUKSD3iOvYI25tfm052hnMqjURUgB6Z0sjU2x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733935753; c=relaxed/simple;
	bh=QRfqYs/Bz2y1ugQ6cO19JvxaYmwqaDfxGLNSefZmqAg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RPxXldRJ3/dD9RB+8htjZ1Rt8Ba2Y8/AcSPDSEngFVqxo99sd66+VyJzmxYpbvoed7BYA9D9U4HecvPRYcAlHIqUJRF1oYegJlOxJLf4CY60gdBApExo4Q3SzuTbeNfnPJNTiXJtCnEcnZCcpjinXOW065LgyRdsZb6XVxYi8as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Y7hJs0Zmqz6K5t9;
	Thu, 12 Dec 2024 00:44:29 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id F0FBD1403A2;
	Thu, 12 Dec 2024 00:49:06 +0800 (CST)
Received: from localhost (10.48.145.145) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 11 Dec
 2024 17:49:06 +0100
Date: Wed, 11 Dec 2024 16:49:04 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Mahesh
 J Salgaonkar" <mahesh@linux.ibm.com>, Oliver O'Halloran <oohall@gmail.com>,
	Lukas Wunner <lukas@wunner.de>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
	<kw@linux.com>, <linux-kernel@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v6 6/8] PCI: Add TLP Prefix reading into
 pcie_read_tlp_log()
Message-ID: <20241211164904.00007a02@huawei.com>
In-Reply-To: <20240913143632.5277-7-ilpo.jarvinen@linux.intel.com>
References: <20240913143632.5277-1-ilpo.jarvinen@linux.intel.com>
	<20240913143632.5277-7-ilpo.jarvinen@linux.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Fri, 13 Sep 2024 17:36:30 +0300
Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com> wrote:

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
> Signed-off-by: Ilpo J=E4rvinen <ilpo.jarvinen@linux.intel.com>

Trivial comments below
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Would have been nice if they'd just made the formats have the
same sized holes etc!

> diff --git a/drivers/pci/pcie/tlp.c b/drivers/pci/pcie/tlp.c
> index 65ac7b5d8a87..def9dd7b73e8 100644
> --- a/drivers/pci/pcie/tlp.c
> +++ b/drivers/pci/pcie/tlp.c
> @@ -11,26 +11,65 @@

>  /**
>   * pcie_read_tlp_log - read TLP Header Log
Maybe update this to read TLP Header and Prefix Logs
>   * @dev: PCIe device
>   * @where: PCI Config offset of TLP Header Log
> + * @where2: PCI Config offset of TLP Prefix Log

Is it worth giving it a more specific name than where2?
Possibly renaming where as well!

> + * @tlp_len: TLP Log length (Header Log + TLP Prefix Log in DWORDs)
>   * @log: TLP Log structure to fill
>   *
>   * Fill @log from TLP Header Log registers, e.g., AER or DPC.
>   *
>   * Return: 0 on success and filled TLP Log structure, <0 on error.
>   */
> -int pcie_read_tlp_log(struct pci_dev *dev, int where,
> -		      struct pcie_tlp_log *log)
> +int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> +		      unsigned int tlp_len, struct pcie_tlp_log *log)
>  {



