Return-Path: <linux-pci+bounces-20571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F08A2A22BDF
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 11:45:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 026F43A9219
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jan 2025 10:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F1319F120;
	Thu, 30 Jan 2025 10:45:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C2A1A2543
	for <linux-pci@vger.kernel.org>; Thu, 30 Jan 2025 10:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738233917; cv=none; b=Qcm6KXZuEUZa85Nmwtj1q5zmWgJRwZJMex8p1UkWR8J9w0FXU9lXntShdzZiTqiv+8pUVagaCPq+SgSTV9jh/d5YScxrplq21za/tw5BjXbOs+xdM5KcCXhEfOEn3oWUBnRuF7d8SZx3QUNz3We4ZLw9GOdVJEaLgz51MO495Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738233917; c=relaxed/simple;
	bh=7zvxYvULpwgEd7FkEy0S6Y7wjqzcEy81A0/ncR+cIhE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L19JZm2lscPos4qMD6xx94BDRIRaRM26uM47dGRw74fn4qDHy2NFJiKPtakBraS2uBibwAb5oRyAlzSTp7ViX/88N799ozlxk6H5lbT2WRB6S8tRFUbEbnHQ+TvqvmWMBUIeAkQ/WujLGhAHkbG4G0OxeHZ029usl2/HMakDmwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YkFyS2vDnz6K9BZ;
	Thu, 30 Jan 2025 18:44:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D93781400DB;
	Thu, 30 Jan 2025 18:45:10 +0800 (CST)
Received: from localhost (10.47.30.69) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 30 Jan
 2025 11:45:10 +0100
Date: Thu, 30 Jan 2025 10:45:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, Alexey Kardashevskiy <aik@amd.com>,
	<linux-pci@vger.kernel.org>, <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 04/11] PCI/IDE: Selective Stream IDE enumeration
Message-ID: <20250130104507.00004446@huawei.com>
In-Reply-To: <173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
	<173343741936.1074769.17093052628585780785.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100012.china.huawei.com (7.191.174.184) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 05 Dec 2024 14:23:39 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Link encryption is a new PCIe capability defined by "PCIe 6.2 section
> 6.33 Integrity & Data Encryption (IDE)". While it is a standalone port
> and endpoint capability, it is also a building block for device security
> defined by "PCIe 6.2 section 11 TEE Device Interface Security Protocol
> (TDISP)". That protocol coordinates device security setup between the
> platform TSM (TEE Security Manager) and device DSM (Device Security
> Manager). While the platform TSM can allocate resources like stream-ids
> and manage keys, it still requires system software to manage the IDE
> capability register block.
> 
> Add register definitions and basic enumeration for a "selective-stream"
> IDE capability, a follow on change will select the new CONFIG_PCI_IDE
> symbol. Note that while the IDE specifications defines both a
> point-to-point "Link" stream and a root-port-to-endpoint "Selective"
> stream, only "Selective" is considered for now for platform TSM
> coordination.
> 
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Some overlap in here with other reviews probably...

Jonathan

> ---
>  drivers/pci/Kconfig           |    3 +
>  drivers/pci/Makefile          |    1 
>  drivers/pci/ide.c             |   73 ++++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |    6 +++
>  drivers/pci/probe.c           |    1 
>  include/linux/pci.h           |    5 ++
>  include/uapi/linux/pci_regs.h |   84 +++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 172 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/ide.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index 2fbd379923fd..4e5236c456f5 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,9 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_IDE
> +	bool
> +
>  config PCI_DOE
>  	bool
>  
> diff --git a/drivers/pci/Makefile b/drivers/pci/Makefile
> index 67647f1880fb..6612256fd37d 100644
> --- a/drivers/pci/Makefile
> +++ b/drivers/pci/Makefile
> @@ -34,6 +34,7 @@ obj-$(CONFIG_PCI_P2PDMA)	+= p2pdma.o
>  obj-$(CONFIG_XEN_PCIDEV_FRONTEND) += xen-pcifront.o
>  obj-$(CONFIG_VGA_ARB)		+= vgaarb.o
>  obj-$(CONFIG_PCI_DOE)		+= doe.o
> +obj-$(CONFIG_PCI_IDE)		+= ide.o
>  obj-$(CONFIG_PCI_DYNAMIC_OF_NODES) += of_property.o
>  obj-$(CONFIG_PCI_NPEM)		+= npem.o
>  obj-$(CONFIG_PCIE_TPH)		+= tph.o
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..a0c09d9e0b75
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/pci.h>
> +#include "pci.h"
> +
> +static int sel_ide_offset(u16 cap, int stream_id, int nr_ide_mem)
> +{
> +	return cap + stream_id * PCI_IDE_SELECTIVE_BLOCK_SIZE(nr_ide_mem);

I'd be tempted to have a define to go from base of the IDE extended cap
directly to the sel_ide_offset rather than this use of a block based
offset.  Maybe it ends up too complex though.

> +}
> +
> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u16 ide_cap, sel_ide_cap;
> +	int nr_ide_mem = 0;
> +	u32 val = 0;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	/*
> +	 * Check for selective stream capability from endpoint to root-port, and
> +	 * require consistent number of address association blocks

on the EP.
(for avoidance of confusion).

Also, from here just seems to mean at the RP and the EP.  Not seting a bus
walk here to check anything else.  Note I'm not sure we need to but this
comment is implying a 'from/to' aspect that this code doesn't seem to check.

> +	 */
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_LINK)
> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
> +			      (PCI_IDE_CAP_LINK_TC_NUM(val) + 1) *
> +				      PCI_IDE_LINK_BLOCK_SIZE;
> +	else
> +		sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM;
Maybe cleaner as
	int link_tc_count = 0;
	if (val & PCI_IDE_CAP_LINK)
		//see suggestion in header to make macro include +1.
		link_tc_count = PCI_IDE_CAP_LINK_TC_NUM(val) + 1;

	sel_ide_cap = ide_cap + PCI_IDE_LINK_STREAM +
		      link_tc_count * PCI_IDE_LINK_BLOCK_SIZE;
I'm not that bothered either way. Just didn't like that
ide_cap + PIC_IDE_LINK_STREAM is in both legs.

Or have a macro that always gets you to the selective part without
using a zero length PCI_IDE_LINK_STREAM block.


> +
> +	for (int i = 0; i < PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val); i++) {
> +		if (i == 0) {
> +			pci_read_config_dword(pdev, sel_ide_cap, &val);
> +			nr_ide_mem = PCI_IDE_SEL_CAP_ASSOC_NUM(val);

Yank out and index from 1 for the loop?
Note though that PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(val) of 1
means 2 streams so you want <= or just +1 in the macro so the PCI
header gets to deal with that!


> +		} else {
> +			int offset = sel_ide_offset(sel_ide_cap, i, nr_ide_mem);
> +
> +			pci_read_config_dword(pdev, offset, &val);
> +
> +			/*
> +			 * lets not entertain devices that do not have a
> +			 * constant number of address association blocks
> +			 */
> +			if (PCI_IDE_SEL_CAP_ASSOC_NUM(val) != nr_ide_mem) {
> +				pci_info(pdev, "Unsupported Selective Stream %d capability\n", i);
> +				return;
> +			}
> +		}
> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->sel_ide_cap = sel_ide_cap;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}



> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index db9b47ce3eef..50811b7655dd 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -530,6 +530,11 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
> +#endif
> +#ifdef CONFIG_PCI_IDE
> +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> +	u16		sel_ide_cap;	/* - Selective Stream register block */

I'd not call it cap as people will go looking for a selective IDE extended capability.
I'm a little dubious about it being necessary vs a helper function that grabs
the necessary count info directly from the device.

> +	int		nr_ide_mem;	/* - Address range limits for streams */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 1601c7ed5fab..9635b27d2485 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -748,7 +748,8 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1213,4 +1214,85 @@
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>  
> +/* Integrity and Data Encryption Extended Capability */
> +#define PCI_IDE_CAP			0x4
> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */

Looks like 3.2 has a bit 7 defined as well.  Selective IDE for configuration requests supported.
Probably worth adding that.

> +#define  PCI_IDE_CAP_ALG(x)		(((x) >> 8) & 0x1f) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM(x)	(((x) >> 13) & 0x7) /* Link IDE TCs */
Maybe add 1 here as the macro name kind of implies it is returning the number of link IDE TCs
rather than 1 less that that. It is a little tricky given the spec calls this field "Number of"

> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_NUM(x)	(((x) >> 16) & 0xff) /* Selective IDE Streams */

Similar here. I'm not sure what precedence we have int his file. I can't immediately see any
either way. 

> +#define  PCI_IDE_CAP_SELECTIVE_STREAMS_MASK	0xff0000
Why have the mask if you are providing the macro above to get the value?

> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> +#define PCI_IDE_CTL			0x8
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4	/* Flow-Through IDE Stream Enabled */
> +#define PCI_IDE_LINK_STREAM		0xc
I couldn't find specific precedence for this but my gut would say add a _0 postfix
to indicate it's the first of a number of these.
All the similar cases seem to explicitly enumerate _0, _1 etc which makes little
sense here.

> +#define PCI_IDE_LINK_BLOCK_SIZE		8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +/* Link IDE Stream Control Register */
I'd expect a _0 define for the first ctrl and one for the first status.

Then index each register via
PCI_IDE_LINK_CTL_0 + i * PCIE_IDE_LINK_BLOCK_SIZE
PCI_IDE_LINK_STS_0 + i * PCIE_IDE_LINK_BLOCK_SIZE

Again, not immediately seeing precedence, but having register field defines without
a register address define (even a constructed one as will be relevant
for the selective IDE stream blocks) seems odd to me.

> +#define  PCI_IDE_LINK_CTL_EN		 0x1	/* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
Perhaps nice to throw in a reference to the supported algs list above.

> +#define  PCI_IDE_LINK_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID(x)		 (((x) >> 24) & 0xff) /* Stream ID */
> +#define  PCI_IDE_LINK_CTL_ID_MASK	 0xff000000
> +
> +
> +/* Link IDE Stream Status Register */
> +#define  PCI_IDE_LINK_STS_STATUS(x)	((x) & 0xf) /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */


I'd put some white space here.

> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +#define PCI_IDE_SELECTIVE_BLOCK_SIZE(x)  (20 + 12 * (x))

Probably want a better name than 'x' for that parameter as it's not
immediately obvious what it is. (number of IDE address association
register blocks).
Also that 12 probably wants a define. It's used a few times.

> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		 0
> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM(x)	 ((x) & 0xf) /* Address Association Register Blocks Number */
> +#define  PCI_IDE_SEL_CAP_ASSOC_MASK	 0xf

If the mask make sense to keep at all would be good to build
the macro above using it.

> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL		 4
> +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR(x) (((x) >> 2) & 0x3) /* Tx Aggregation Mode NPR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR(x)	 (((x) >> 4) & 0x3) /* Tx Aggregation Mode PR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL(x) (((x) >> 6) & 0x3) /* Tx Aggregation Mode CPL */
> +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> +#define   PCI_IDE_SEL_CTL_PART_ENC(x)	 (((x) >> 10) & 0xf)  /* Partial Header Encryption Mode */
This is a control register. Seems likely we'll mostly be writing these.
So how useful is it to provide just a read macro?
Maybe I'm missing something!
> +#define   PCI_IDE_SEL_CTL_ALG(x)	 (((x) >> 14) & 0x1f) /* Selected Algorithm */
> +#define   PCI_IDE_SEL_CTL_TC(x)		 (((x) >> 19) & 0x7)  /* Traffic Class */
> +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 (1 << 23) /* TEE-Limited Stream */

Why this one as a shift and all the rest as explicit hex values?

> +#define   PCI_IDE_SEL_CTL_ID_MASK	 0xff000000
> +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS		 8
> +#define   PCI_IDE_SEL_STS_STATUS(x)	((x) & 0xf) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1		 12
> +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 0xffff00
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2		 16
> +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 0x00ffff00

Why leading zeros on this one?

> +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 0xff000000
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> +#define  PCI_IDE_SEL_ADDR_1(x)		     (20 + (x) * 12)
> +#define   PCI_IDE_SEL_ADDR_1_VALID	     0x1
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK   0x000fff0

more leading zeros which doesn't seem consistent. Also, as Alexey
pointed out value is wrong as that's 4 bits in not 8.


> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_SHIFT  20
8?

> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK  0xfff0000
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_SHIFT 20
Also missing a zero (Alexey got this one as well I see)

> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * 12)
> +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * 12)
> +
>  #endif /* LINUX_PCI_REGS_H */
> 
> 


