Return-Path: <linux-pci+bounces-29927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89CDADCED0
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 16:08:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E96493B9D2D
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61C572E7191;
	Tue, 17 Jun 2025 14:04:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7A5215787
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750169083; cv=none; b=EV/ijtgopYSscANfFYVjQKG3pC1oB6QWZn/n91r8vx3Kc05YC1d0fUNc7ALA00PqA4apFc6PFqeJZjjzRpnGqArK3oRyzMMUGSjcouXwYy3VRR87CThxEO2dsxB0moWGO0BeO3be0c81MDkrrcybZfvUxPEL8ieGVxRQzpyGOgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750169083; c=relaxed/simple;
	bh=VC6NFBICn/9Fnlsg8dmM0a3+vIJghZl+N/kZp8lTNyg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSxiDSyA3gVj31xyQasYu2dyDoTOz6XqDQCHZi2aVas6S9eR/OiLjEqw5o+et6yqSodZ3QynzC9U3jjPPdjfCto1kVESFfTP1cM09I3S0h00u/thkiRELq19CvfNW0k4i9SmNUgUVZmT0ZQoEcxBXBAuhtMB+IK/wAx5f2BQFWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM7mH66pSz6L5jD;
	Tue, 17 Jun 2025 21:59:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id EEF9C140119;
	Tue, 17 Jun 2025 22:04:36 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 16:04:36 +0200
Date: Tue, 17 Jun 2025 15:04:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Bjorn Helgaas <bhelgaas@google.com>,
	Yilun Xu <yilun.xu@linux.intel.com>
Subject: Re: [PATCH v3 08/13] PCI/IDE: Add IDE establishment helpers
Message-ID: <20250617150434.00003a91@huawei.com>
In-Reply-To: <20250516054732.2055093-9-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-9-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:27 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> There are two components to establishing an encrypted link, provisioning
> the stream in Partner Port config-space, and programming the keys into
> the link layer via IDE_KM (IDE Key Management). This new library,
> drivers/pci/ide.c, enables the former. IDE_KM, via a TSM low-level
> driver, is saved for later.
> 
> With the platform TSM implementations of SEV-TIO and TDX Connect in mind
> this library abstracts small differences in those implementations. For
> example, TDX Connect handles Root Port register setup while SEV-TIO
> expects System Software to update the Root Port registers. This is the
> rationale for fine-grained 'setup' + 'enable' verbs.
> 
> The other design detail for TSM-coordinated IDE establishment is that
> the TSM may manage allocation of Stream IDs, this is why the Stream ID
> value is passed in to pci_ide_stream_setup().
> 
> The flow is:
> 
> pci_ide_stream_alloc()
>   Allocate a Selective IDE Stream Register Block in each Partner Port
>   (Endpoint + Root Port), and reserve a host bridge / platform stream
>   slot. Gather Partner Port specific stream settings like Requester ID.
> pci_ide_stream_register()
>   Publish the stream in sysfs after allocating a Stream ID. In the TSM
>   case the TSM allocates the Stream ID for the Partner Port pair.
> pci_ide_stream_setup()
>   Program the stream settings to a Partner Port. Caller is responsible
>   for optionally calling this for the Root Port as well if the TSM
>   implementation requires it.
> pci_ide_stream_enable()
>   Try to run the stream after IDE_KM.
> 
> In support of system administrators auditing where platform, Root Port,
> and Endpoint IDE stream resources are being spent, the allocated stream
> is reflected as a symlink from the host bridge to the endpoint with the
> name:
> 
>     stream%d.%d.%d:%s
> 
> Where the tuple of integers reflects the allocated platform, Root Port,
> and Endpoint stream index (Selective IDE Stream Register Block) values,
> and the %s is the endpoint device name.
> 
> Thanks to Wu Hao for a draft implementation of this infrastructure.
> 
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lukas Wunner <lukas@wunner.de>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Yilun Xu <yilun.xu@linux.intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few little comments inline.

Thanks,

Jonathan

> ---
>  .../ABI/testing/sysfs-devices-pci-host-bridge |  38 ++
>  MAINTAINERS                                   |   1 +
>  drivers/pci/ide.c                             | 366 ++++++++++++++++++
>  include/linux/pci-ide.h                       |  76 ++++
>  include/linux/pci.h                           |   6 +
>  include/uapi/linux/pci_regs.h                 |   2 +
>  6 files changed, 489 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-devices-pci-host-bridge
>  create mode 100644 include/linux/pci-ide.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-devices-pci-host-bridge b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> new file mode 100644
> index 000000000000..d592b68c7333
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-devices-pci-host-bridge
> @@ -0,0 +1,38 @@
> +What:		/sys/devices/pciDDDD:BB
> +		/sys/devices/.../pciDDDD:BB
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		A PCI host bridge device parents a PCI bus device topology. PCI
> +		controllers may also parent host bridges. The DDDD:BB format
> +		conveys the PCI domain (ACPI segment) number and root bus number
> +		(in hexadecimal) of the host bridge. Note that the domain number
> +		may be larger than the 16-bits that the "DDDD" format implies
> +		for emulated host-bridges.
> +
> +What:		pciDDDD:BB/firmware_node
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) Symlink to the platform firmware device object "companion"
> +		of the host bridge. For example, an ACPI device with an _HID of
> +		PNP0A08 (/sys/devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00). See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.

No problem with this documentation but not I think related to this patch and
could go upstream before this?

> +
> +What:		pciDDDD:BB/streamH.R.E:DDDD:BB:DD:F
> +Date:		December, 2024
> +Contact:	linux-pci@vger.kernel.org
> +Description:
> +		(RO) When a platform has established a secure connection, PCIe
> +		IDE, between two Partner Ports, this symlink appears. The
> +		primary function is to account the stream slot / resources
> +		consumed in each of the (H)ost bridge, (R)oot Port and
> +		(E)ndpoint that will be freed when invoking the tsm/disconnect
> +		flow. The link points to the endpoint PCI device at domain:DDDD
> +		bus:BB device:DD function:F. Where R and E represent the
> +		assigned Selective IDE Stream Register Block in the Root Port
> +		and Endpoint, and H represents a platform specific pool of
> +		stream resources shared by the Root Ports in a host bridge.  See
> +		/sys/devices/pciDDDD:BB entry for details about the DDDD:BB
> +		format.

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> index 98a51596e329..a529926647f4 100644
> --- a/drivers/pci/ide.c
> +++ b/drivers/pci/ide.c

> +/**
> + * pci_ide_stream_enable() - after setup, enable the stream
> + * @pdev: PCIe device object for either a Root Port or Endpoint Partner Port
> + * @ide: registered and setup IDE settings descriptor
> + *
> + * Activate the stream by writing to the Selective IDE Stream Control Register.
> + */
> +int pci_ide_stream_enable(struct pci_dev *pdev, struct pci_ide *ide)
> +{
> +	struct pci_ide_partner *settings = pci_ide_to_settings(pdev, ide);
> +	int pos;
> +	u32 val;
> +
> +	if (!settings)
> +		return -ENXIO;
> +
> +	pos = sel_ide_offset(pdev, settings);
> +
> +	set_ide_sel_ctl(pdev, ide, pos, true);
> +
> +	pci_read_config_dword(pdev, pos + PCI_IDE_SEL_STS, &val);
> +	if (FIELD_GET(PCI_IDE_SEL_STS_STATE_MASK, val) !=
> +	    PCI_IDE_SEL_STS_STATE_SECURE)
> +		return -ENXIO;

Trivial but blank line here would I think help readability a tiny bit.

> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(pci_ide_stream_enable);

> diff --git a/include/linux/pci-ide.h b/include/linux/pci-ide.h
> new file mode 100644
> index 000000000000..0753c3cd752a
> --- /dev/null
> +++ b/include/linux/pci-ide.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#ifndef __PCI_IDE_H__
> +#define __PCI_IDE_H__
> +
> +#include <linux/range.h>

Needed?  I'm guessing it was and isn't any more.

> +
> +#define SEL_ADDR1_LOWER_MASK GENMASK(31, 20)
> +#define SEL_ADDR_UPPER_MASK GENMASK_ULL(63, 32)
> +#define PREP_PCI_IDE_SEL_ADDR1(base, limit)                    \

ADDR_1 would be more consistent.

However, unless we are going to see a lot of these I'd personally prefer
to see this lot inline in the code.

> +	(FIELD_PREP(PCI_IDE_SEL_ADDR_1_VALID, 1) |             \
> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK,          \
> +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (base))) | \

This is a case I'd just not use FIELD_PREP / GET for. Just ends up
confusing and needs definitions that make little sense on their own.
	lower_32_bits(base) & PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK
perhaps.

> +	 FIELD_PREP(PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK,         \
> +		    FIELD_GET(SEL_ADDR1_LOWER_MASK, (limit))))

Maybe use upper_32_bits() for this one.

However it is an odd macro and I can't immediately find where it is used
so maybe just drop it?

> +
> +#define PREP_PCI_IDE_SEL_RID_2(base, domain)               \
> +	(FIELD_PREP(PCI_IDE_SEL_RID_2_VALID, 1) |          \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_BASE_MASK, (base)) | \
> +	 FIELD_PREP(PCI_IDE_SEL_RID_2_SEG_MASK, (domain)))
This one I'd prefer to see inline.

> +/**
> + * struct pci_ide_partner - Per port IDE Stream settings
> + * @rid_start: Partner Port Requester ID range start
> + * @rid_start: Partner Port Requester ID range end
> + * @stream_index: Selective IDE Stream Register Block selection
> + */
> +struct pci_ide_partner {
> +	u16 rid_start;
> +	u16 rid_end;
> +	u8 stream_index;
> +};
> +
> +/**
> + * struct pci_ide - PCIe Selective IDE Stream descriptor
> + * @pdev: PCIe Endpoint for the stream
> + * @partner: settings for both partner ports in a stream
> + * @host_bridge_stream: track platform Stream index

Why the capital S?  Seems a little inconsistent across different comments.


> + * @stream_id: unique id (within Partner Port pairing) for the stream
> + * @name: name of the stream in sysfs
> + *
> + * Negative @stream_id values indicate "uninitialized" on the
> + * expectation that with TSM established IDE the TSM owns the stream_id
> + * allocation.
> + */
> +struct pci_ide {
> +	struct pci_dev *pdev;
> +	struct pci_ide_partner partner[PCI_IDE_PARTNER_MAX];
> +	u8 host_bridge_stream;
> +	int stream_id;
> +	const char *name;
> +};


