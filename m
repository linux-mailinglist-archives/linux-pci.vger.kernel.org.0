Return-Path: <linux-pci+bounces-29921-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF90ADCAED
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A543BD1C8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 12:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85E2E2EED;
	Tue, 17 Jun 2025 12:16:18 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD892D9EF1
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750162578; cv=none; b=Z9Mp992e+Vvqm4q7gM9eehaoHPdd9pJa7YSIKDVZ18Q7m1uGZUO2Pf2YGFJ1NJj7blb7TRCQN58hWeHJxhNGgYGbqQVv+AqLt63YU2FU4q/rCFWFJlKcsAUDZJBr8/2y9eCWLgLWm04jPYKM4HNBrFbq9n8Y23JyDbvUwdyBwwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750162578; c=relaxed/simple;
	bh=7LOS33t8HpBzuuMpONGgrG1dYRpzYu+bhZJc3X90F70=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3FUOLux68T9W9pbaiEjKAD+TXpppcVqZOFLLkFziOlIuzs0GQ1NzuRuLbj/aq0Him1OwLgAdkh13eRHHUtxrgoKplpjSnW3DdOLp/pK49t8+eIQvOAlwM49vNBC+APb8ucMS9ahV7VFYcO07ztodgpAY2icfaXrTiG0AgRnHHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM5M36Lzrz67ZPP;
	Tue, 17 Jun 2025 20:11:27 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BC117140276;
	Tue, 17 Jun 2025 20:16:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 17 Jun
 2025 14:16:04 +0200
Date: Tue, 17 Jun 2025 13:16:02 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<gregkh@linuxfoundation.org>, <lukas@wunner.de>, <aneesh.kumar@kernel.org>,
	<suzuki.poulose@arm.com>, <sameo@rivosinc.com>, <aik@amd.com>,
	<jgg@nvidia.com>, <zhiw@nvidia.com>, Yilun Xu <yilun.xu@intel.com>
Subject: Re: [PATCH v3 02/13] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250617131602.00001957@huawei.com>
In-Reply-To: <20250516054732.2055093-3-dan.j.williams@intel.com>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
	<20250516054732.2055093-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 15 May 2025 22:47:21 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Link encryption is a new PCIe feature enumerated by "PCIe 6.2 section
> 7.9.26 IDE Extended Capability".
> 
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe 6.2 section 11 TEE Device
> Interface Security Protocol (TDISP)". That protocol coordinates device
> security setup between a platform TSM (TEE Security Manager) and a
> device DSM (Device Security Manager). While the platform TSM can
> allocate resources like Stream ID and manage keys, it still requires
> system software to manage the IDE capability register block.
> 
> Add register definitions and basic enumeration in preparation for
> Selective IDE Stream establishment. A follow on change selects the new
> CONFIG_PCI_IDE symbol. Note that while the IDE specification defines
> both a point-to-point "Link Stream" and a Root Port to endpoint
> "Selective Stream", only "Selective Stream" is considered for Linux as
> that is the predominant mode expected by Trusted Execution Environment
> Security Managers (TSMs), and it is the security model that limits the
> number of PCI components within the TCB in a PCIe topology with
> switches.
> 
> Cc: Yilun Xu <yilun.xu@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Yilun Xu <yilun.xu@intel.com>
> Signed-off-by: Yilun Xu <yilun.xu@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

This has been sat in my to read list for too long. Sorry about that!

A few trivial things inline.

Jonathan

> ---
>  drivers/pci/Kconfig           |  14 +++++
>  drivers/pci/Makefile          |   1 +
>  drivers/pci/ide.c             | 100 ++++++++++++++++++++++++++++++++++
>  drivers/pci/pci.h             |   6 ++
>  drivers/pci/probe.c           |   1 +
>  include/linux/pci.h           |   7 +++
>  include/uapi/linux/pci_regs.h |  81 ++++++++++++++++++++++++++-
>  7 files changed, 209 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/ide.c
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index da28295b4aac..0c662f9813eb 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -121,6 +121,20 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_IDE
> +	bool
> +
> +config PCI_IDE_STREAM_MAX
> +	int "Maximum number of Selective IDE Streams supported per host bridge" if EXPERT
> +	depends on PCI_IDE
> +	range 1 256
> +	default 64
> +	help
> +	  Set a kernel limit for the number of streams. The expectation
> +	  is that the platform limit is 4 to 8, so the kernel need not
> +	  track the maximum possibility of 256 streams per host bridge
> +	  in the typical case.

Maybe suggest why a kernel might want to limit this?  Testing only?

> +
>  config PCI_DOE
>  	bool "Enable PCI Data Object Exchange (DOE) support"
>  	help

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..98a51596e329
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,100 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024 Intel Corporation. All rights reserved. */
> +
> +/* PCIe 6.2 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +#include "pci.h"
> +
> +static int __sel_ide_offset(int ide_cap, int nr_link_ide, int stream_index,
> +			    int nr_ide_mem)
> +{
> +	int offset;
> +
> +	offset = ide_cap + PCI_IDE_LINK_STREAM_0 + nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +	/*
> +	 * Assume a constant number of address association resources per
> +	 * stream index
> +	 */
> +	if (stream_index > 0)
> +		offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);

Is stream_index ever < 0?  Doesn't look like it.  So why not do this unconditionally
as it doesn't do anything if stream_index == 0?

Better yet, why not make all the parameters unsigned given I don' think any of
them can be < 0



> +	return offset;
> +}


> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index ba326710f9c8..90affa69edb0 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -750,7 +750,8 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> -#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_DOE
> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
> +#define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_IDE
>  
>  #define PCI_EXT_CAP_DSN_SIZEOF	12
>  #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
> @@ -1220,4 +1221,82 @@
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
> +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Cycles Support */

Not sure we care but it's called Requests Support in the 6.2 spec at at least rather than
Cycles.


> +#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */
> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */

If we are going to start using __GENMASK in here (which I'm in favour of) maybe we
could use _BIT()/ _BITUL() from uapi/linux/const.h as well.  Counting zeros is annoying given
the spec is all by bit number.

> +#define PCI_IDE_CTL			0x8
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
> +
> +#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
> +#define  PCI_IDE_LINK_BLOCK_SIZE	8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +#define PCI_IDE_LINK_CTL_0		   0x0               /* First Link Control Register Offset in block */
> +#define  PCI_IDE_LINK_CTL_EN		   0x1               /* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2)   /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4)   /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6)   /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	   0x100	     /* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC_MASK	   __GENMASK(13, 10) /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG_MASK	   __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> +#define  PCI_IDE_LINK_CTL_TC_MASK	   __GENMASK(21, 19) /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID_MASK	   __GENMASK(31, 24) /* Stream ID */
> +#define PCI_IDE_LINK_STS_0		   0x4               /* First Link Status Register Offset in block */
> +#define  PCI_IDE_LINK_STS_STATE		   __GENMASK(3, 0)   /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_RECVD_INTEGRITY_CHECK	0x80000000   /* Received Integrity Check Fail Msg */
> +
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		 0
> +#define  PCI_IDE_SEL_CAP_ASSOC_NUM_MASK	 __GENMASK(3, 0)
> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL		 4
> +#define   PCI_IDE_SEL_CTL_EN		 0x1	/* Selective IDE Stream Enable */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR_MASK __GENMASK(3, 2) /* Tx Aggregation Mode NPR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR_MASK  __GENMASK(5, 4) /* Tx Aggregation Mode PR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL_MASK __GENMASK(7, 6) /* Tx Aggregation Mode CPL */
> +#define   PCI_IDE_SEL_CTL_PCRC_EN	 0x100	/* PCRC Enable */
> +#define   PCI_IDE_SEL_CTL_CFG_EN	 0x200	/* Selective IDE for Configuration Requests */
> +#define   PCI_IDE_SEL_CTL_PART_ENC_MASK	 __GENMASK(13, 10) /* Partial Header Encryption Mode */
> +#define   PCI_IDE_SEL_CTL_ALG_MASK	 __GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> +#define   PCI_IDE_SEL_CTL_TC_MASK	 __GENMASK(21, 19) /* Traffic Class */
> +#define   PCI_IDE_SEL_CTL_DEFAULT	 0x400000 /* Default Stream */
> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	 0x800000 /* TEE-Limited Stream */
> +#define   PCI_IDE_SEL_CTL_ID_MASK	 __GENMASK(31, 24) /* Stream ID */
> +#define   PCI_IDE_SEL_CTL_ID_MAX	 255
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS		 8
> +#define   PCI_IDE_SEL_STS_STATE_MASK	 __GENMASK(3, 0) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1		 0xc
> +#define   PCI_IDE_SEL_RID_1_LIMIT_MASK	 __GENMASK(23, 8)
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2		 0x10
> +#define   PCI_IDE_SEL_RID_2_VALID	 0x1
> +#define   PCI_IDE_SEL_RID_2_BASE_MASK	 __GENMASK(23, 8)
> +#define   PCI_IDE_SEL_RID_2_SEG_MASK	 __GENMASK(31, 24)
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> +#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	    12
> +#define  PCI_IDE_SEL_ADDR_1(x)		    (20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define   PCI_IDE_SEL_ADDR_1_VALID	    0x1
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW_MASK  __GENMASK(19, 8)
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW_MASK __GENMASK(31, 20)
> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +/* IDE Address Association Register 3 is "Memory Base Upper" */

Why not move this comment down one line? Match where the def is.

> +#define  PCI_IDE_SEL_ADDR_2(x)		    (24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define  PCI_IDE_SEL_ADDR_3(x)		    (28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
> +
>  #endif /* LINUX_PCI_REGS_H */


