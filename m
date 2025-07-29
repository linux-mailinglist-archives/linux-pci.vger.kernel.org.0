Return-Path: <linux-pci+bounces-33108-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24167B14D5A
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 14:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5115917C0AB
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 12:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4481E28F53B;
	Tue, 29 Jul 2025 12:03:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCD27A914;
	Tue, 29 Jul 2025 12:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753790615; cv=none; b=pet8tq3IIaEv0b8dmhMchuN5dDpTZUw6VnneD02yz0Z3rsOqKr0m7dZOKKU+2VkeBN2UKPQnlGbCtyGm7Hp1GIlIjAiWDgPKIiwimd3Jq0QK3Iai4qgzuNhXMWm5vfjPchgd9CTvUhva/bUOTrNvWSLDexBmNbl4zbv3wBTQVjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753790615; c=relaxed/simple;
	bh=ZTbXRgaGJW2XWJm4M6TWmnAxNNiya+NdURKLPZa20QY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYBJd62eQu2kFW1q5nkDL5OvREv/zbnzrAhjNSKoejP7ia6gpVtoF8RUppBPIPr9rT9fCQOurdEgoM95YtI3X8LsvsPJN+3UL+3ySrcrdb/KZn060hdAaYtm1VnkJoLF43tu9MG00NnzN7OkRUeDDjv9kEOQFKzTKHNMjzPGZDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4brv8K13qRz6L5Q6;
	Tue, 29 Jul 2025 20:01:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 9088E1400E3;
	Tue, 29 Jul 2025 20:03:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 29 Jul
 2025 14:03:28 +0200
Date: Tue, 29 Jul 2025 13:03:27 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-coco@lists.linux.dev>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <bhelgaas@google.com>, <aik@amd.com>,
	<lukas@wunner.de>, Yilun Xu <yilun.xu@intel.com>, Aneesh Kumar K.V
	<aneesh.kumar@kernel.org>
Subject: Re: [PATCH v4 02/10] PCI/IDE: Enumerate Selective Stream IDE
 capabilities
Message-ID: <20250729130327.00005fc2@huawei.com>
In-Reply-To: <20250717183358.1332417-3-dan.j.williams@intel.com>
References: <20250717183358.1332417-1-dan.j.williams@intel.com>
	<20250717183358.1332417-3-dan.j.williams@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 17 Jul 2025 11:33:50 -0700
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

Seems that one field has changed naming and gained broader meaning
between 6.0 and 6.2 (which I was checking against).
I guess resolving that will require some digging into whether it
was an errata an intentional change.  Definitely wants a comment
though.

Other than that and a few trivial things LGTM.

> diff --git a/drivers/pci/ide.c b/drivers/pci/ide.c
> new file mode 100644
> index 000000000000..e15937cdb2a4
> --- /dev/null
> +++ b/drivers/pci/ide.c
> @@ -0,0 +1,93 @@

> +static int __sel_ide_offset(u16 ide_cap, u8 nr_link_ide, u8 stream_index,
> +			    u8 nr_ide_mem)
> +{
> +	u32 offset;
> +
> +	offset = ide_cap + PCI_IDE_LINK_STREAM_0 +
> +		 nr_link_ide * PCI_IDE_LINK_BLOCK_SIZE;
> +
> +	/*
> +	 * Assume a constant number of address association resources per
> +	 * stream index
> +	 */
> +	offset += stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);
> +	return offset;

	return offset + stream_index * PCI_IDE_SEL_BLOCK_SIZE(nr_ide_mem);

is perhaps a little bit neater?

> +}

> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index a3a3e942dedf..ab4ebf0f8a46 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> +/* Integrity and Data Encryption Extended Capability */
> +#define PCI_IDE_CAP			0x4

Spec uses two digits. Things are a bit inconsistent in this file but
0x04 looks like the most common syntax if hex.  Curiously some are
not in hex.  Anyhow, I'd go with 0x04 etc for all register offsets
unless Bjorn or someone else shouts otherwise!


> +#define  PCI_IDE_CAP_LINK		0x1  /* Link IDE Stream Supported */
> +#define  PCI_IDE_CAP_SELECTIVE		0x2  /* Selective IDE Streams Supported */
> +#define  PCI_IDE_CAP_FLOWTHROUGH	0x4  /* Flow-Through IDE Stream Supported */
> +#define  PCI_IDE_CAP_PARTIAL_HEADER_ENC 0x8  /* Partial Header Encryption Supported */
> +#define  PCI_IDE_CAP_AGGREGATION	0x10 /* Aggregation Supported */
> +#define  PCI_IDE_CAP_PCRC		0x20 /* PCRC Supported */
> +#define  PCI_IDE_CAP_IDE_KM		0x40 /* IDE_KM Protocol Supported */
> +#define  PCI_IDE_CAP_SEL_CFG		0x80 /* Selective IDE for Config Request Support */
> +#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
> +#define  PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */
Looking at the rest of this file I think this should be.
#define  PCI_IDE_CAP_ALG_MASK		__GENMASK(12, 8) /* Supported Algorithms */
#define   PCI_IDE_CAP_ALG_AES_GCM_256	0    /* AES-GCM 256 key size, 96b MAC */

So indent one more space. Example being PCI_LPH_LOC_NONE

> +#define  PCI_IDE_CAP_LINK_TC_NUM_MASK	__GENMASK(15, 13) /* Link IDE TCs */
> +#define  PCI_IDE_CAP_SEL_NUM_MASK	__GENMASK(23, 16)/* Supported Selective IDE Streams */

Space before comment missing?

> +#define  PCI_IDE_CAP_TEE_LIMITED	0x1000000 /* TEE-Limited Stream Supported */
> +#define PCI_IDE_CTL			0x8
As above 0x08 more consistent with rest of the file.  Same for remaining cases.
> +#define  PCI_IDE_CTL_FLOWTHROUGH_IDE	0x4  /* Flow-Through IDE Stream Enabled */
> +
> +#define PCI_IDE_LINK_STREAM_0		0xc  /* First Link Stream Register Block */
> +#define  PCI_IDE_LINK_BLOCK_SIZE	8
> +/* Link IDE Stream block, up to PCI_IDE_CAP_LINK_TC_NUM */
> +#define PCI_IDE_LINK_CTL_0		   0x0               /* First Link Control Register Offset in block */

Event this I think should be 0x01 for consistency

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
Naming here is drawing on stuff not in the Status register description (in 6.2 anyway which is what I'm
checking against).  That just calls this Received IDE Fail Message.
The text else where calls it out 'Upon transition from Secure to Insecure for any reason, other than
corresponding Link/Selective IDE Stream Enable bit is Cleared, for a given Stream, the Port must transmit an
IDE Fail Message indicating the Stream ID to the Partner port'

To me the integrity check naming doesn't really cover that.

I did some minimal digging. Your text matches 6.0. 


> +
> +/* Selective IDE Stream block, up to PCI_IDE_CAP_SELECTIVE_STREAMS_NUM */
> +/* Selective IDE Stream Capability Register */
> +#define  PCI_IDE_SEL_CAP		 0

0x00

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
> +#define   PCI_IDE_SEL_STS_STATE_INSECURE 0
> +#define   PCI_IDE_SEL_STS_STATE_SECURE   2
> +#define   PCI_IDE_SEL_STS_RECVD_INTEGRITY_CHECK	0x80000000 /* Received Integrity Check Fail Msg */

Same thing.

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
> +#define  PCI_IDE_SEL_ADDR_2(x)		    (24 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +/* IDE Address Association Register 3 is "Memory Base Upper" */
> +#define  PCI_IDE_SEL_ADDR_3(x)		    (28 + (x) * PCI_IDE_SEL_ADDR_BLOCK_SIZE)
> +#define PCI_IDE_SEL_BLOCK_SIZE(nr_assoc)  (20 + PCI_IDE_SEL_ADDR_BLOCK_SIZE * (nr_assoc))
> +
>  #endif /* LINUX_PCI_REGS_H */


