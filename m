Return-Path: <linux-pci+bounces-39763-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7D4C1F00F
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DBEC19C4AE4
	for <lists+linux-pci@lfdr.de>; Thu, 30 Oct 2025 08:35:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913D31064B;
	Thu, 30 Oct 2025 08:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgxcE7Bp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52D306B3D;
	Thu, 30 Oct 2025 08:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761813306; cv=none; b=m5WPG6HienejNZFYrJA43UWU/Y2+qhoZ67+QHcK9E70mmLMoQ+kGxNYOTnjnXOIRbdXIShYsyt37BshG7okN11HrjDlvumu+WlZ58ylVc8U/xX60C5Vw+1ulvuSvc9vL6Ffdd0stsLP8nlafcGTKnb62YS3IcdaohiSY7kv1vcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761813306; c=relaxed/simple;
	bh=lV/kfV+8KtWWo+OcgFzAr3BnJemtdi/k2ikyJ7xUQQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MeT4KkIeWHZp3kMzrd1dnVUjdc5uNzRSV2KRy5/6fluO0qa80H0Bm8fNNyfET+Pi6TdvuNQVfTIKdL8QmBbPADO1BlJ4MY6jyPPwNGuqG9YJ+4cLLnK6v+LyMrNg8Qg5f9VKPpEt5enXiuGiojynNUL/gH22YmJOc+Z2tP4zs/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cgxcE7Bp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA52C4CEF1;
	Thu, 30 Oct 2025 08:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761813305;
	bh=lV/kfV+8KtWWo+OcgFzAr3BnJemtdi/k2ikyJ7xUQQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=cgxcE7BpHyPCY9pkrNs5MEHtJW3mQyb7pmXWxowk3W/tAkP4F0UusGm6vbWYdXIgR
	 crfUXzBYJ5Zg1LGSRcKrGfCD46Wcj6Tv+YUfOoZL1b3r7JIdhqax6SzjhMyKBA0Eem
	 xanwRhn56BB8E9+c+8cGRCTNi11i/JoZvs+/xskrvGmd+ntFlUBAE05ffhKgOvWy0v
	 EPBE4tkDrkFux/h6E2DiyVfaA4CgMrZbjGMdZM6tk/Fsh/Sni73E+IHP3zk1ltXeAV
	 hWp8dVBhvMiBlnEFAtl0ktcVRhqujW8UZ0tYDE+637mT3PierUjdbiZr2gpZeCrCE6
	 2AjSiJODcp75g==
X-Mailer: emacs 30.2 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org
Cc: aik@amd.com, yilun.xu@linux.intel.com, bhelgaas@google.com,
	gregkh@linuxfoundation.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v7 2/9] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
In-Reply-To: <20251024020418.1366664-3-dan.j.williams@intel.com>
References: <20251024020418.1366664-1-dan.j.williams@intel.com>
 <20251024020418.1366664-3-dan.j.williams@intel.com>
Date: Thu, 30 Oct 2025 14:04:59 +0530
Message-ID: <yq5a8qgseqj0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> Link encryption is a new PCIe feature enumerated by "PCIe r7.0 section
> 7.9.26 IDE Extended Capability".
>
> It is both a standalone port + endpoint capability, and a building block
> for the security protocol defined by "PCIe r7.0 section 11 TEE Device
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

Reviewed-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

> Cc: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
> Co-developed-by: Alexey Kardashevskiy <aik@amd.com>
> Signed-off-by: Alexey Kardashevskiy <aik@amd.com>
> Co-developed-by: Xu Yilun <yilun.xu@linux.intel.com>
> Signed-off-by: Xu Yilun <yilun.xu@linux.intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/pci/Kconfig           |  3 ++
>  drivers/pci/Makefile          |  1 +
>  drivers/pci/pci.h             |  6 +++
>  include/linux/pci.h           |  7 +++
>  include/uapi/linux/pci_regs.h | 81 +++++++++++++++++++++++++++++++
>  drivers/pci/ide.c             | 91 +++++++++++++++++++++++++++++++++++
>  drivers/pci/probe.c           |  1 +
>  7 files changed, 190 insertions(+)
>  create mode 100644 drivers/pci/ide.c
>
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index f94f5d384362..b28423e2057f 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -122,6 +122,9 @@ config XEN_PCIDEV_FRONTEND
>  config PCI_ATS
>  	bool
>  
> +config PCI_IDE
> +	bool
> +
>  config PCI_DOE
>  	bool "Enable PCI Data Object Exchange (DOE) support"
>  	help
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
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 4492b809094b..86ef13e7cece 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -613,6 +613,12 @@ static inline void pci_doe_sysfs_init(struct pci_dev *pdev) { }
>  static inline void pci_doe_sysfs_teardown(struct pci_dev *pdev) { }
>  #endif
>  
> +#ifdef CONFIG_PCI_IDE
> +void pci_ide_init(struct pci_dev *dev);
> +#else
> +static inline void pci_ide_init(struct pci_dev *dev) { }
> +#endif
> +
>  /**
>   * pci_dev_set_io_state - Set the new error state if possible.
>   *
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d1fdf81fbe1e..4402ca931124 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -539,6 +539,13 @@ struct pci_dev {
>  #endif
>  #ifdef CONFIG_PCI_NPEM
>  	struct npem	*npem;		/* Native PCIe Enclosure Management */
> +#endif
> +#ifdef CONFIG_PCI_IDE
> +	u16		ide_cap;	/* Link Integrity & Data Encryption */
> +	u8		nr_ide_mem;	/* Address association resources for streams */
> +	u8		nr_link_ide;	/* Link Stream count (Selective Stream offset) */
> +	unsigned int	ide_cfg:1;	/* Config cycles over IDE */
> +	unsigned int	ide_tee_limit:1; /* Disallow T=0 traffic over IDE */
>  #endif
>  	u16		acs_cap;	/* ACS Capability offset */
>  	u8		supported_speeds; /* Supported Link Speeds Vector */
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 07e06aafec50..05bd22d9e352 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -754,6 +754,7 @@
>  #define PCI_EXT_CAP_ID_NPEM	0x29	/* Native PCIe Enclosure Management */
>  #define PCI_EXT_CAP_ID_PL_32GT  0x2A    /* Physical Layer 32.0 GT/s */
>  #define PCI_EXT_CAP_ID_DOE	0x2E	/* Data Object Exchange */
> +#define PCI_EXT_CAP_ID_IDE	0x30    /* Integrity and Data Encryption */
>  #define PCI_EXT_CAP_ID_PL_64GT	0x31	/* Physical Layer 64.0 GT/s */
>  #define PCI_EXT_CAP_ID_MAX	PCI_EXT_CAP_ID_PL_64GT
>  
> @@ -1249,4 +1250,84 @@
>  #define PCI_DVSEC_CXL_PORT_CTL				0x0c
>  #define PCI_DVSEC_CXL_PORT_CTL_UNMASK_SBR		0x00000001
>  
> +/* Integrity and Data Encryption Extended Capability */
> +#define PCI_IDE_CAP			0x04
> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> +#define  PCI_IDE_CAP_ALG		__GENMASK(12, 8) /* Supported Algorithms */
> +#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
> +#define  PCI_IDE_CAP_LINK_TC_NUM	__GENMASK(15, 13) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SEL_NUM		__GENMASK(23, 16) /* Supported Selective IDE Streams */
> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> +#define PCI_IDE_CTL			0x08
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
> +
> +#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
> +#define  PCI_IDE_LINK_BLOCK_SIZE	8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +#define PCI_IDE_LINK_CTL_0		0x00		  /* First Link Control Register Offset in block */
> +#define  PCI_IDE_LINK_CTL_EN		0x1		  /* Link IDE Stream Enable */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_PR	__GENMASK(5, 4)	  /* Tx Aggregation Mode PR */
> +#define  PCI_IDE_LINK_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
> +#define  PCI_IDE_LINK_CTL_PCRC_EN	0x100		  /* PCRC Enable */
> +#define  PCI_IDE_LINK_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
> +#define  PCI_IDE_LINK_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> +#define  PCI_IDE_LINK_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
> +#define  PCI_IDE_LINK_CTL_ID		__GENMASK(31, 24) /* Stream ID */
> +#define PCI_IDE_LINK_STS_0		0x4               /* First Link Status Register Offset in block */
> +#define  PCI_IDE_LINK_STS_STATE		__GENMASK(3, 0)   /* Link IDE Stream State */
> +#define  PCI_IDE_LINK_STS_IDE_FAIL	0x80000000	  /* IDE fail message received */
> +
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		0x00
> +#define   PCI_IDE_SEL_CAP_ASSOC_NUM	__GENMASK(3, 0)
> +/* Selective IDE Stream Control Register */
> +#define  PCI_IDE_SEL_CTL		0x04
> +#define   PCI_IDE_SEL_CTL_EN		0x1		  /* Selective IDE Stream Enable */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_NPR	__GENMASK(3, 2)	  /* Tx Aggregation Mode NPR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_PR	__GENMASK(5, 4)   /* Tx Aggregation Mode PR */
> +#define   PCI_IDE_SEL_CTL_TX_AGGR_CPL	__GENMASK(7, 6)	  /* Tx Aggregation Mode CPL */
> +#define   PCI_IDE_SEL_CTL_PCRC_EN	0x100		  /* PCRC Enable */
> +#define   PCI_IDE_SEL_CTL_CFG_EN	0x200		  /* Selective IDE for Configuration Requests */
> +#define   PCI_IDE_SEL_CTL_PART_ENC	__GENMASK(13, 10) /* Partial Header Encryption Mode */
> +#define   PCI_IDE_SEL_CTL_ALG		__GENMASK(18, 14) /* Selection from PCI_IDE_CAP_ALG */
> +#define   PCI_IDE_SEL_CTL_TC		__GENMASK(21, 19) /* Traffic Class */
> +#define   PCI_IDE_SEL_CTL_DEFAULT	0x400000	  /* Default Stream */
> +#define   PCI_IDE_SEL_CTL_TEE_LIMITED	0x800000	  /* TEE-Limited Stream */
> +#define   PCI_IDE_SEL_CTL_ID		__GENMASK(31, 24) /* Stream ID */
> +#define   PCI_IDE_SEL_CTL_ID_MAX	255
> +/* Selective IDE Stream Status Register */
> +#define  PCI_IDE_SEL_STS		 0x08
> +#define   PCI_IDE_SEL_STS_STATE		 __GENMASK(3, 0) /* Selective IDE Stream State */
> +#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
> +#define   PCI_IDE_SEL_STS_STATE_SECURE	 2
> +#define   PCI_IDE_SEL_STS_IDE_FAIL	 0x80000000	 /* IDE fail message received */
> +/* IDE RID Association Register 1 */
> +#define  PCI_IDE_SEL_RID_1		 0x0c
> +#define   PCI_IDE_SEL_RID_1_LIMIT	 __GENMASK(23, 8)
> +/* IDE RID Association Register 2 */
> +#define  PCI_IDE_SEL_RID_2		0x10
> +#define   PCI_IDE_SEL_RID_2_VALID	0x1
> +#define   PCI_IDE_SEL_RID_2_BASE	__GENMASK(23, 8)
> +#define   PCI_IDE_SEL_RID_2_SEG		__GENMASK(31, 24)
> +/* Selective IDE Address Association Register Block, up to PCI_IDE_SEL_CAP_ASSOC_NUM */
> +#define PCI_IDE_SEL_ADDR_BLOCK_SIZE	12
> +#define  PCI_IDE_SEL_ADDR_1(x)		(20 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define   PCI_IDE_SEL_ADDR_1_VALID	0x1
> +#define   PCI_IDE_SEL_ADDR_1_BASE_LOW	__GENMASK(19, 8)
> +#define   PCI_IDE_SEL_ADDR_1_LIMIT_LOW	__GENMASK(31, 20)
> +/* IDE Address Association Register 2 is "Memory Limit Upper" */
> +#define  PCI_IDE_SEL_ADDR_2(x)		(24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +#define  PCI_IDE_SEL_ADDR_3(x)		(28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
> +
>  #endif /* LINUX_PCI_REGS_H */
> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..aa54d088129d
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,91 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
> +
> +/* PCIe r7.0 section 6.33 Integrity & Data Encryption (IDE) */
> +
> +#define dev_fmt(fmt) "PCI/IDE: " fmt
> +#include <linux/bitfield.h>
> +#include <linux/pci.h>
> +#include <linux/pci_regs.h>
> +
> +#include "pci.h"
> +
> +static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
> +			    u8 nr_ide_mem)
> +{
> +	u32 offset = ide_cap + PCI_IDE_LINK_STREAM_0 +
> +		     nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +	/*
> +	 * Assume a constant number of address association resources per stream
> +	 * index
> +	 */
> +	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> +}
> +
> +void pci_ide_init(struct pci_dev *pdev)
> +{
> +	u16 nr_link_ide, nr_ide_mem, nr_streams;
> +	u16 ide_cap;
> +	u32 val;
> +
> +	if (!pci_is_pcie(pdev))
> +		return;
> +
> +	ide_cap = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_IDE);
> +	if (!ide_cap)
> +		return;
> +
> +	pci_read_config_dword(pdev, ide_cap + PCI_IDE_CAP, &val);
> +	if ((val & PCI_IDE_CAP_SELECTIVE) == 0)
> +		return;
> +
> +	/*
> +	 * Require endpoint IDE capability to be paired with IDE Root Port IDE
> +	 * capability.
> +	 */
> +	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ENDPOINT) {
> +		struct pci_dev *rp = pcie_find_root_port(pdev);
> +
> +		if (!rp->ide_cap)
> +			return;
> +	}
> +
> +	if (val & PCI_IDE_CAP_SEL_CFG)
> +		pdev->ide_cfg = 1;
> +
> +	if (val & PCI_IDE_CAP_TEE_LIMITED)
> +		pdev->ide_tee_limit = 1;
> +
> +	if (val & PCI_IDE_CAP_LINK)
> +		nr_link_ide = 1 + FIELD_GET(PCI_IDE_CAP_LINK_TC_NUM, val);
> +	else
> +		nr_link_ide = 0;
> +
> +	nr_ide_mem = 0;
> +	nr_streams = 1 + FIELD_GET(PCI_IDE_CAP_SEL_NUM, val);
> +	for (u16 i = 0; i < nr_streams; i++) {
> +		int pos = __sel_ide_offset(ide_cap, nr_link_ide, i, nr_ide_mem);
> +		int nr_assoc;
> +		u32 val;
> +
> +		pci_read_config_dword(pdev, pos + PCI_IDE_SEL_CAP, &val);
> +
> +		/*
> +		 * Let's not entertain streams that do not have a constant
> +		 * number of address association blocks
> +		 */
> +		nr_assoc = FIELD_GET(PCI_IDE_SEL_CAP_ASSOC_NUM, val);
> +		if (i && (nr_assoc != nr_ide_mem)) {
> +			pci_info(pdev, "Unsupported Selective Stream %d capability, SKIP the rest\n", i);
> +			nr_streams = i;
> +			break;
> +		}
> +
> +		nr_ide_mem = nr_assoc;
> +	}
> +
> +	pdev->ide_cap = ide_cap;
> +	pdev->nr_link_ide = nr_link_ide;
> +	pdev->nr_ide_mem = nr_ide_mem;
> +}
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..4c55020f3ddf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2667,6 +2667,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
>  	pci_doe_init(dev);		/* Data Object Exchange */
>  	pci_tph_init(dev);		/* TLP Processing Hints */
>  	pci_rebar_init(dev);		/* Resizable BAR */
> +	pci_ide_init(dev);		/* Link Integrity and Data Encryption */
>  
>  	pcie_report_downtraining(dev);
>  	pci_init_reset_methods(dev);
> -- 
> 2.51.0

