Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB63370F53
	for <lists+linux-pci@lfdr.de>; Sun,  2 May 2021 23:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhEBVY1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 2 May 2021 17:24:27 -0400
Received: from mail-bn8nam11on2057.outbound.protection.outlook.com ([40.107.236.57]:8271
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232338AbhEBVY1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 2 May 2021 17:24:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JRfjfGYcZSbYa0GEy7I7S4qwh+24xr5mN7n/BgrwadocLDMwXur54abiaPtlGIHLxtSuRC/3uYePaE/3jQGZCAuADn9mqE7VOvzSOvgvtNGm6vtQsC5oV2DbyKU6dB57nA1M6JRB078UXKwQB2WvnCDpiAdgNE2EdfRXAwRJuFGUQJV9/kYz5sDD/IHRxn5rYRSYnpxHcHYeP0OXyoPDQYm1KspftG3WYWQLPMUiSC5PvBweX+XwIaE/aDvfCsZQE4Sm5AHV96oOr47fD8g/Z7bem9R5dFqykiGHUv/C89WlMBOnwPwdVvcDiKZ8l10GeeXS3bvtjKvbIOxir4tRnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqWc/Fmqc3x2DHIOX4HmWT614fBv4WGNqMlsP+t+3jw=;
 b=LXF6ckKHWhD9UgFB09MboXVzHF0mLz/+S24fQGvPvmSeaem8rIt5ewohA7YO5nimDLnuQhZYea3/tUb5C9Bqyb3CA/olKYI3D2o+pwKAViT2UcGnT1G7sga85Do2yJnfRoYZ3oXPPGy20hUiI7sWIOpyeeBpLWU1U5oXixbYFMjlc5bXD0Ys//JidzZjlV0/ABI1fqH42xBvMDZhJVExuqrlrBB7boyNkN3hFX3VCQdOyoG11Uno2gDFmL5Tjqev2S+Y8wP9pOgsf/+U4VZO+/wLZ/R1Wbghp1h/iT7YKd2ludC3HNdm4vC2QWHdKATqM6YMH8eY2V1NC/reVpDkdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=raithlin.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FqWc/Fmqc3x2DHIOX4HmWT614fBv4WGNqMlsP+t+3jw=;
 b=mCROHdTzy91pY/E9y+ql7glf2EnJVgz2HGEF2tjUM45VdWKOHu/Nq+E0+IsXo/Fyl9JUa0w2OmO6vlW66xyY055E9gkcAFmi78tyam7kHdigF+ExSSHUeAIaot/igcXJV1lhO3RCt/3VT9A9VuFZQZm6XF+Lv5Y/iuuGN6SWUxtxBQtg+rm4upfBZ3SPbfpFT/+NBI18qI9RzjqjogYg/WlHH6MxJ1opY0FhQuZHYO9kkfp6ErYUtCwmTvqKb586cLSqkU6glroY7B9wExoZK+4K36aBSIBX5OSKuMO6Ry+4OBMtBNVAS7nCRNJ3LQRFXBa5Uo/5gAiVCu1SmseSeg==
Received: from MWHPR2001CA0018.namprd20.prod.outlook.com
 (2603:10b6:301:15::28) by BN9PR12MB5132.namprd12.prod.outlook.com
 (2603:10b6:408:119::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.40; Sun, 2 May
 2021 21:23:33 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:15:cafe::93) by MWHPR2001CA0018.outlook.office365.com
 (2603:10b6:301:15::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.27 via Frontend
 Transport; Sun, 2 May 2021 21:23:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; raithlin.com; dkim=none (message not signed)
 header.d=none;raithlin.com; dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4087.27 via Frontend Transport; Sun, 2 May 2021 21:23:32 +0000
Received: from [10.2.50.162] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 2 May
 2021 21:23:32 +0000
Subject: Re: [PATCH 05/16] dma-mapping: Introduce dma_map_sg_p2pdma()
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
 <20210408170123.8788-6-logang@deltatee.com>
From:   John Hubbard <jhubbard@nvidia.com>
Message-ID: <c050bcae-e223-bb41-021f-b1fda572647b@nvidia.com>
Date:   Sun, 2 May 2021 14:23:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210408170123.8788-6-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d18f1d0a-90ab-4e66-ff3f-08d90db089ec
X-MS-TrafficTypeDiagnostic: BN9PR12MB5132:
X-Microsoft-Antispam-PRVS: <BN9PR12MB513257D878BB2B784D36A1CFA85C9@BN9PR12MB5132.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hpoK98tsJ+Bisp80khBTiZMoA3850+t8Z1L3UQl5d0mtze9Vd7leYkiuhbt/Xo4QXA7RDp3kD1/CubzarFmsFmBI7sHWSobvDw6Wny3QGFfF3oDKmhVOkTnSQAQDU3BaO9mjtUQjHjHk86yA9OVF/FDcxPl+GvkJkkPhEcdArtbh9uG/PyYhe0yPvH4KnmYFl8WmJLn1mXxfDxfcf2eOdgR+ES3f+WH6g4rWFve64D1e1T/iW4oY0Di5y3XIV9DufXOD4AB6Iz+aH7XhTJLrdaKfYsYV1LonpHZAvn8C0p/wB8srCtPgJQE1z76pZJFlV7psGI5WvqReIrexDSWIGJNGqEV0BXF4OhEt0lKny/SdA7T+YdkTXbU5iPvXYkK2QN6rmNekiTRTJU0EUA0bJ1g+INFW9VSLD4MudzpvXOQGTIgby8RKNwyaPnBKU/HoiuU7Qh0VkMZFFucSwM9Lpp3r2vmeMqwR5ALBHe70etbfSsqsp4D58LDhS/iIaVOqMoMbU09yKApRy1fDk7EpKPg9+Su+/UhwjjIyIqIEgYqu61KXzBiIDydBQTzCakCgaQbTMTIhWVEhb/AOElvnAZbUXvw1Bs8l19B3KquTXURwAcI3UQ+v4VF2PeojKyGR+gEAJDHXFLQMlMiM4g5QQ0eo8Wu6paEiPGAoFnixEDclNnSDtYy98QpcvcLlhSjdmh5lctEGYre1Gvw1MTNLzQ==
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(136003)(396003)(46966006)(36840700001)(70586007)(53546011)(31686004)(356005)(70206006)(7636003)(2906002)(82740400003)(5660300002)(4326008)(8936002)(83380400001)(82310400003)(478600001)(8676002)(54906003)(16526019)(36860700001)(186003)(36756003)(47076005)(7416002)(316002)(26005)(36906005)(31696002)(426003)(86362001)(16576012)(110136005)(336012)(2616005)(43740500002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2021 21:23:32.8082
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d18f1d0a-90ab-4e66-ff3f-08d90db089ec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR12MB5132
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 4/8/21 10:01 AM, Logan Gunthorpe wrote:
> dma_map_sg() either returns a positive number indicating the number
> of entries mapped or zero indicating that resources were not available
> to create the mapping. When zero is returned, it is always safe to retry
> the mapping later once resources have been freed.
> 
> Once P2PDMA pages are mixed into the SGL there may be pages that may
> never be successfully mapped with a given device because that device may
> not actually be able to access those pages. Thus, multiple error
> conditions will need to be distinguished to determine weather a retry
> is safe.
> 
> Introduce dma_map_sg_p2pdma[_attrs]() with a different calling
> convention from dma_map_sg(). The function will return a positive
> integer on success or a negative errno on failure.
> 
> ENOMEM will be used to indicate a resource failure and EREMOTEIO to
> indicate that a P2PDMA page is not mappable.
> 
> The __DMA_ATTR_PCI_P2PDMA attribute is introduced to inform the lower
> level implementations that P2PDMA pages are allowed and to warn if a
> caller introduces them into the regular dma_map_sg() interface.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> ---
>   include/linux/dma-mapping.h | 15 +++++++++++
>   kernel/dma/mapping.c        | 52 ++++++++++++++++++++++++++++++++-----
>   2 files changed, 61 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 2a984cb4d1e0..50b8f586cf59 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -60,6 +60,12 @@
>    * at least read-only at lesser-privileged levels).
>    */
>   #define DMA_ATTR_PRIVILEGED		(1UL << 9)
> +/*
> + * __DMA_ATTR_PCI_P2PDMA: This should not be used directly, use
> + * dma_map_sg_p2pdma() instead. Used internally to indicate that the
> + * caller is using the dma_map_sg_p2pdma() interface.
> + */
> +#define __DMA_ATTR_PCI_P2PDMA		(1UL << 10)
>

As mentioned near the top of this file,
Documentation/core-api/dma-attributes.rst also needs to be updated, for
this new item.


>   /*
>    * A dma_addr_t can hold any valid DMA or bus address for the platform.  It can
> @@ -107,6 +113,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   		enum dma_data_direction dir, unsigned long attrs);
>   int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		enum dma_data_direction dir, unsigned long attrs);
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs);
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs);
> @@ -160,6 +168,12 @@ static inline int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
>   {
>   	return 0;
>   }
> +static inline int dma_map_sg_p2pdma_attrs(struct device *dev,
> +		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> +		unsigned long attrs)
> +{
> +	return 0;
> +}
>   static inline void dma_unmap_sg_attrs(struct device *dev,
>   		struct scatterlist *sg, int nents, enum dma_data_direction dir,
>   		unsigned long attrs)
> @@ -392,6 +406,7 @@ static inline void dma_sync_sgtable_for_device(struct device *dev,
>   #define dma_map_single(d, a, s, r) dma_map_single_attrs(d, a, s, r, 0)
>   #define dma_unmap_single(d, a, s, r) dma_unmap_single_attrs(d, a, s, r, 0)
>   #define dma_map_sg(d, s, n, r) dma_map_sg_attrs(d, s, n, r, 0)
> +#define dma_map_sg_p2pdma(d, s, n, r) dma_map_sg_p2pdma_attrs(d, s, n, r, 0)

This hunk is fine, of course.

But, about pre-existing issues: note to self, or to anyone: send a patch to turn
these into inline functions. The macro redirection here is not adding value, but
it does make things just a little bit worse.


>   #define dma_unmap_sg(d, s, n, r) dma_unmap_sg_attrs(d, s, n, r, 0)
>   #define dma_map_page(d, p, o, s, r) dma_map_page_attrs(d, p, o, s, r, 0)
>   #define dma_unmap_page(d, a, s, r) dma_unmap_page_attrs(d, a, s, r, 0)
> diff --git a/kernel/dma/mapping.c b/kernel/dma/mapping.c
> index b6a633679933..923089c4267b 100644
> --- a/kernel/dma/mapping.c
> +++ b/kernel/dma/mapping.c
> @@ -177,12 +177,8 @@ void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr, size_t size,
>   }
>   EXPORT_SYMBOL(dma_unmap_page_attrs);
>   
> -/*
> - * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> - * It should never return a value < 0.
> - */

It would be better to leave the comment in place, given the non-standard
return values. However, looking around here, it would be better if we go
with the standard -ERRNO for error, and >0 for sucess.

There are pre-existing BUG_ON() and WARN_ON_ONCE() items that are partly
an attempt to compensate for not being able to return proper -ERRNO
codes. For example, this:

	    BUG_ON(!valid_dma_direction(dir));

...arguably should be more like this:

         if(WARN_ON_ONCE(!valid_dma_direction(dir)))
                 return -EINVAL;


> -int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> -		enum dma_data_direction dir, unsigned long attrs)
> +static int __dma_map_sg_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
>   {
>   	const struct dma_map_ops *ops = get_dma_ops(dev);
>   	int ents;
> @@ -197,6 +193,20 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   		ents = dma_direct_map_sg(dev, sg, nents, dir, attrs);
>   	else
>   		ents = ops->map_sg(dev, sg, nents, dir, attrs);
> +
> +	return ents;
> +}
> +
> +/*
> + * dma_maps_sg_attrs returns 0 on error and > 0 on success.
> + * It should never return a value < 0.
> + */
> +int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
> +		enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;

Pre-existing note, feel free to ignore: the ents and nents in the same
routines together, are way too close to the each other in naming. Maybe
using "requested_nents", or "nents_arg", for the incoming value, would
help.

> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir, attrs);
>   	BUG_ON(ents < 0);
>   	debug_dma_map_sg(dev, sg, nents, ents, dir);
>   
> @@ -204,6 +214,36 @@ int dma_map_sg_attrs(struct device *dev, struct scatterlist *sg, int nents,
>   }
>   EXPORT_SYMBOL(dma_map_sg_attrs);
>   
> +/*
> + * like dma_map_sg_attrs, but returns a negative errno on error (and > 0
> + * on success). This function must be used if PCI P2PDMA pages might
> + * be in the scatterlist.

Let's turn this into a kernel doc comment block, seeing as how it clearly
wants to be--you're almost there already. You've even reinvented @Return,
below. :)

> + *
> + * On error this function may return:
> + *    -ENOMEM indicating that there was not enough resources available and
> + *      the transfer may be retried later
> + *    -EREMOTEIO indicating that P2PDMA pages were included but cannot
> + *      be mapped by the specified device, retries will always fail
> + *
> + * The scatterlist should be unmapped with the regular dma_unmap_sg[_attrs]().

How about:

"The scatterlist should be unmapped via dma_unmap_sg[_attrs]()."

> + */
> +int dma_map_sg_p2pdma_attrs(struct device *dev, struct scatterlist *sg,
> +		int nents, enum dma_data_direction dir, unsigned long attrs)
> +{
> +	int ents;
> +
> +	ents = __dma_map_sg_attrs(dev, sg, nents, dir,
> +				  attrs | __DMA_ATTR_PCI_P2PDMA);
> +	if (!ents)
> +		ents = -ENOMEM;
> +
> +	if (ents > 0)
> +		debug_dma_map_sg(dev, sg, nents, ents, dir);
> +
> +	return ents;
> +}
> +EXPORT_SYMBOL_GPL(dma_map_sg_p2pdma_attrs);
> +
>   void dma_unmap_sg_attrs(struct device *dev, struct scatterlist *sg,
>   				      int nents, enum dma_data_direction dir,
>   				      unsigned long attrs)
> 

thanks,
-- 
John Hubbard
NVIDIA
