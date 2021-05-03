Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEC937101B
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 02:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232766AbhECAc7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 20:32:59 -0400
Received: from mail-dm6nam10on2079.outbound.protection.outlook.com ([40.107.93.79]:42311
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232758AbhECAc7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 20:32:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nibO9lZGAskms4ckgT67UvoljRzBsZWiQ5mc8MBlFja3IfaWZMuNmqAhS6sYvp7Fjrqzem2KCOEYYey7DVhxMnImD+lwFGY4QvTGCxEbM0ECFG3rGY7e3zCJXYQ8/51mo4m5kPOAIUR2iOqG5kagofQ6lji7K7wW5JQtixDul6+h1hp06BH4NWe7+MbALPbfF81UiTpNVVFubBB16kFkqg4OxequNXFQpTENC8vnAFPkRTb0t0HTnrjxlkBCA0pgj8wF8+mRqL3OKROZ5UnWPXRscX+1n0B1gBUT3c8N1PtF2BfhTdsbfTgBmEBeVTyvlvLSaCnsj8Nv5y9tmcnDEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAjVISce5fbgZVJc6vuZYSKILz+pVQUOL/mkdrVUxUI=;
 b=RB6/c+Cq/xWMcoGAon6En9nlNSUYYp5F2FYTlOQ3cEz1Su2rTgLkkeJCIsT9EZszJ3lCKmb7gfv+ncztTEME6in9i0E+KahYIib++aXGyh8c1KO7UsdZVTAZfQ0RxxFB+9hEuJn1ffLxcmTf5kYZKhj+d5tSjJLmI37uU/hJikBCpNy63VHln3Jy45GzIFOMuBLDgiURkpm+3fKFnWpE8nyVW1543LWQlX6sJiIfpxemfY94WjrecqvF5kUm6htw4eN7uC8bTSDpMnOaBW1TBsh9qoLTiqtm6qyN4PGRNgNK9ZEw4L1NQxDyMj2oj8oix9pD47hiWhdP2H0DguINiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAjVISce5fbgZVJc6vuZYSKILz+pVQUOL/mkdrVUxUI=;
 b=dCRsDXEnXMzNIodtw0n6VbJuXwPrkDG2AQb+mXp3UE242z3Sa10zWPbFLdoF50OaASER6LbfFFvC6Y8I9O79XIpiJGKinnEZhOMLLbfDqOqHEhgY4RPNI/+3HhGI4kkg3FrGvu0ZIqtb/k+Zmsqv+mDbk/bo0T08HImdxY+kNWKlFleyF7xY2jTVLlEqVtYSLtpSCObRNkOwN2Xh1sKT5AvVQeqVGv4+2zDJdSXKfSSBmBKYothTkL9ZPpo9C2miXRedzOK5elVn8vGgYEmIh89aBVCf1RxQi9GzBDt1qiwRfb877JF/XnocI6L3BJRdLpEEk4vXEja3GBhpXLKLaw==
Received: from DM5PR19CA0018.namprd19.prod.outlook.com (2603:10b6:3:151::28)
 by MN2PR12MB3232.namprd12.prod.outlook.com (2603:10b6:208:ab::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25; Mon, 3 May
 2021 00:32:04 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:151:cafe::90) by DM5PR19CA0018.outlook.office365.com
 (2603:10b6:3:151::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.30 via Frontend
 Transport; Mon, 3 May 2021 00:32:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Mon, 3 May 2021 00:32:04 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 3 May
 2021 00:32:02 +0000
Subject: Re: [PATCH 10/16] dma-mapping: Add flags to dma_map_ops to indicate
 PCI P2PDMA support
To:     Logan Gunthorpe <logang@deltatee.com>,
        <linux-kernel@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <linux-block@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-mm@kvack.org>, <iommu@lists.linux-foundation.org>
CC:     Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Robin Murphy <robin.murphy@arm.com>
References: <20210408170123.8788-1-logang@deltatee.com>
 <20210408170123.8788-11-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <85bd104b-2816-f803-44d4-d5623d4f81af@nvidia.com>
Date:   Sun, 2 May 2021 17:32:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-11-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 82c61071-4fbe-4bb0-1a41-08d90dcae049
X-MS-TrafficTypeDiagnostic: MN2PR12MB3232:
X-Microsoft-Antispam-PRVS: <MN2PR12MB32327997FF5F114566B052BDA85B9@MN2PR12MB3232.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9J6GQ9QB+km0ohN+YrB70n1v1vjclXJTehJBNY3tNru63qR+Yi9cP9Q5ImVrYROL3a/GB38L7bTxufre6GRThRoQVRqq+tP2rcH0KG5XBzqbVyn0E1cL36Qy4ipcBx7s4qpLFRJnqiLirLs6hsAD4kqNLiBcUs1Vq0hjdJqofWHXNgHEO8yKEK+Y3LGm87i5j1gBBd2lmS2jHCPrgVYzx0s5CwVM02apxKS8tw6x1b3GZFdJvAEvlfjWpgkPGyMJe83ff5eUbd6QyQQ+Q1EnFQMHbf9wZi1vNcgDkEKbL3mTVorGIa0Yj7oZCzS9o0BWvVBFqozMKSLBVQFQYXhsf/sOxs/kF4W94yXEm1kN/BIyyE9U2XmSpoGosnUmFZlq972ib6BmCtPVDQGTwfm2qzi3GaYDIqMnZ++AdskHtxUwWc6r1ZDkR53+MaCOIoiZGEbK1jrpnD+ZW9TVRwOerF7Jbvbqrg42dH4t7Dd918t8Oxsnlt9tFHkpcxW2JbXN9L8AtPXWGwET+HSxInZ1qYAwIosryvxZ0DPcecgrjgJAU0PHVy9W7muTDa9L64CL7oVjsqcM5+9BvbXX8zjb1bMdkLsTJfuTB7WmTf0aQrxu78kRMpR7m8gePtjH3t4YHDX35KgbahhF6rgiEaDT0xSoGeR600dtHLEydSUY6x1if1Z9gCw4FJsJ1xXfKer5xB4JWCDbDJgH2K55vDuRFQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(136003)(376002)(39860400002)(346002)(396003)(46966006)(36840700001)(7636003)(426003)(2906002)(7416002)(316002)(47076005)(83380400001)(26005)(110136005)(86362001)(336012)(31696002)(8936002)(5660300002)(82310400003)(8676002)(70206006)(53546011)(82740400003)(36756003)(70586007)(186003)(16526019)(478600001)(31686004)(36906005)(356005)(2616005)(54906003)(16576012)(36860700001)(4326008)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2021 00:32:04.5866
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82c61071-4fbe-4bb0-1a41-08d90dcae049
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3232
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> Add a flags member to the dma_map_ops structure with one flag to
> indicate support for PCI P2PDMA.
> 
> Also, add a helper to check if a device supports PCI P2PDMA.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   include/linux/dma-map-ops.h |  3 +++
>   include/linux/dma-mapping.h |  5 +++++
>   kernel/dma/mapping.c        | 18 ++++++++++++++++++
>   3 files changed, 26 insertions(+)
> 
> diff --git a/include/linux/dma-map-ops.h b/include/linux/dma-map-ops.h
> index 51872e736e7b..481892822104 100644
> --- a/include/linux/dma-map-ops.h
> +++ b/include/linux/dma-map-ops.h
> @@ -12,6 +12,9 @@
>   struct cma;
>   
>   struct dma_map_ops {
> +	unsigned int flags;
> +#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)
> +

Can we move this up and out of the struct member area, so that it looks
more like this:

/*
  * Values for struct dma_map_ops.flags:
  *
  * DMA_F_PCI_P2PDMA_SUPPORTED: <documentation here...this is a good place to
  * explain exactly what this flag is for.>
  */
#define DMA_F_PCI_P2PDMA_SUPPORTED     (1 << 0)

struct dma_map_ops {
	unsigned int flags;


>   	void *(*alloc)(struct device *dev, size_t size,
>   			dma_addr_t *dma_handle, gfp_t gfp,
>   			unsigned long attrs);
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 50b8f586cf59..c31980ecca62 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -146,6 +146,7 @@ int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
>   		unsigned long attrs);
>   bool dma_can_mmap(struct device *dev);
>   int dma_supported(struct device *dev, u64 mask);
> +bool dma_pci_p2pdma_supported(struct device *dev);
>   int dma_set_mask(struct device *dev, u64 mask);
>   int dma_set_coherent_mask(struct device *dev, u64 mask);
>   u64 dma_get_required_mask(struct device *dev);
> @@ -247,6 +248,10 @@ static inline int dma_supported(struct device *dev, u64 mask)
>   {
>   	return 0;
>   }
> +static inline bool dma_pci_p2pdma_supported(struct device *dev)
> +{
> +	return 0;

Should be:
	
	return false;

> +}
>   static inline int dma_set_mask(struct device *dev, u64 mask)
>   {
>   	return -EIO;
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index 923089c4267b..ce44a0fcc4e5 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -573,6 +573,24 @@ int dma_supported(struct device *dev, u64 mask)
>   }
>   EXPORT_SYMBOL(dma_supported);
>   
> +bool dma_pci_p2pdma_supported(struct device *dev)
> +{
> +	const struct dma_map_ops *ops = get_dma_ops(dev);
> +
> +	/* if ops is not set, dma direct will be used which supports P2PDMA */
> +	if (!ops)
> +		return true;
> +
> +	/*
> +	 * Note: dma_ops_bypass is not checked here because P2PDMA should
> +	 * not be used with dma mapping ops that do not have support even
> +	 * if the specific device is bypassing them.
> +	 */
> +
> +	return ops->flags & DMA_F_PCI_P2PDMA_SUPPORTED;

Wow, rather unusual combination of things in order decide this. It feels
a bit over-complicated to have flags and ops and a bool function all
dealing with the same 1-bit answer, but there is no caller shown here,
so I'll have to come back to this after reviewing subsequent patches.

thanks,
-- 
John Hubbard
NVIDIA

> +}
> +EXPORT_SYMBOL_GPL(dma_pci_p2pdma_supported);
> +
>   #ifdef CONFIG_ARCH_HAS_DMA_SET_MASK
>   void arch_dma_set_mask(struct device *dev, u64 mask);
>   #else
> 


