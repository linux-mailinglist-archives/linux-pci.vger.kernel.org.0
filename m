Return-Path: <linux-pci+bounces-33123-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F44B1501F
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 17:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20596189F825
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 15:23:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11C6292B5F;
	Tue, 29 Jul 2025 15:23:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADEA3292B59;
	Tue, 29 Jul 2025 15:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753802597; cv=none; b=EnWHBe0FniyPieSiUyur3Qyo0pR2qn7EsaJtNmUYuUHbN59o2La+sykaxIyFJ7Znvz5nRv7kvpqPmcBIUxmWXI0ctQSBnaoReYVmaFMQlwTuhFm3EklNfqpKwGb55fJR1KkVHc8KKL4TVaJAp6CFmuY7ru7TKp4HsM+VHK/KNGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753802597; c=relaxed/simple;
	bh=UdF7+MyEQN4lowG4g1QHvKAmtAPL0t7ARw6Hx2CJGp8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cRKNR50n6iFKbxnKO9JnzXtDA5OVxWSfTaI54N8+hU3Yu5MiZ8xnCB46wglojuBjSDjKTrqjVs7v0SWKzxH5va60lB8v72/NYLx19vUMfk8F1/Zwds8UJOoiuFHPW9kmTANcoeCJ2xW+qMhKDDwufHkavrqhnBCiS2ZFEm9JXvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brzX63S5fz6JB0Y;
	Tue, 29 Jul 2025 23:19:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D34D1140372;
	Tue, 29 Jul 2025 23:23:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 17:23:12 +0200
Date: Tue, 29 Jul 2025 16:23:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "Xu
 Yilun" <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v4 06/10] PCI: Add PCIe Device 3 Extended Capability
 enumeration
Message-ID: <20250729162310.00001fbb@huawei.com>
In-Reply-To: <20250717183358.1332417-7-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-7-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:54 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> PCIe 6.2 Section 7.7.9 Device 3 Extended Capability Structure,
> enumerates new link capabilities and status added for Gen 6 devices. One
> of the link details enumerated in that register block is the "Segment
> Captured" status in the Device Status 3 register. That status is
> relevant for enabling IDE (Integrity & Data Encryption) whereby
> Selective IDE streams can be limited to a given Requester ID range
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

Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>


> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1b991a88c19c..2d49a4786a9f 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -751,6 +751,7 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_DEV3	0x2F	/* Device 3 Capability/Control/Status */
>  #define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
>  #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
> @@ -1227,6 +1228,12 @@
>  /* Deprecated old name, replaced with PCI_DOE_DATA_OBJECT_DISC_RSP_3_TYP=
E */
>  #define PCI_DOE_DATA_OBJECT_DISC_RSP_3_PROTOCOL		PCI_DOE_DATA_OBJECT_DIS=
C_RSP_3_TYPE
> =20
> +/* Device 3 Extended Capability */
> +#define PCI_DEV3_CAP		0x4	/* Device 3 Capabilities Register */

Similar to earlier cases I'd make these 0x04 etc just to copy local style +=
 match spec.


> +#define PCI_DEV3_CTL		0x8	/* Device 3 Control Register */
> +#define PCI_DEV3_STA		0xc	/* Device 3 Status Register */
> +#define  PCI_DEV3_STA_SEGMENT	0x8	/* Segment Captured (end-to-end flit-m=
ode detected) */
> +
>  /* Compute Express Link (CXL r3.1, sec 8.1.5) */
>  #define PCI_DVSEC_CXL_PORT				3
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c


