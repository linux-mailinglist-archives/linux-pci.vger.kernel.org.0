Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D23285A2A11
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231315AbiHZOxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZOxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:53:20 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2062.outbound.protection.outlook.com [40.107.212.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BF3BD8B3E;
        Fri, 26 Aug 2022 07:53:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ib0z0ENvbdLgOIyW3iHtzWk2JrhsIVq5CGZLwk1+u+r+5GXrPNv9SLmFF6RdWG+z1Dj1COb1ihEDPagCyAl4YWqt7n5qvnMxTRRZ5CNDx44LSGOR0dbcd0wUggm3W5jThQWd1xRMNfD24SEpziMrJjMYnPp9pTZzMcdRSXgvwpwnhzQ9DyMjxI/1maY0zFRMJHcpowPyihSy0r3M5Wu9ce9S32NFSJZayPuS0om1XYLVg7CinpNQwDoVUWyUi2KFxxWRizMiZrh3FBjC9joe7A5nBa+9b5mAtlxmsFbtdnapT8ySfHeGWVHKX09BBJJxq0lVc1sARw+Ztxp8jKKySw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0Vvqi0Rtz1nOxu5LGJUVmUezMCYClXzNaoUNFk5g2NY=;
 b=PrMHu/EO+Qu2E0mulXBO6fZxSjLmamX5Fr9qSgtl2vMxXwgQnt976/ATD2PTXE7nV3ovVEtGtGeAGxiPl8njNbLC5Vg32cQOxRVXLGqsEkCKDpkncgD8gRo7YssnU/nEEQfxdcgbjTZhnF8BzTqRrHQiCOfeEk7WaWMv2Gzebtr0zoGo3Z81keUUGUwhVZ3aKZbuh5t8kjYaCPHHMOkELD00/MLF0PLVhE4+I8JIMDX2AUfUkWh3sreAIvBe14MAfqVAzwdHhg1JRFDZiT4uy4sMKCwg9G+UNsaTOq751/V7JI3a4BicNpHtySzRSLplSIoj1p9CgODKlRODxNcPKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0Vvqi0Rtz1nOxu5LGJUVmUezMCYClXzNaoUNFk5g2NY=;
 b=Y9O5FeWOM1tBA9icmb7bA3fVaBxjYJM5DBP5Up6QqoyyFuRJ2y5/r/jszvP/pKX4W34jFplZY2lWiFzaLVZJYED72ruB7fNRO7s/eTfitK/m3jHYA+YGb17k2mRzy7YHtXt2/efq9OasbF+zPYH6li6FKvjyjQiTjPE29JrnqWV2Ej7zdiO+a3F+t3TlKu4IcYwlbI0XjAaw3laHpUPtc55dvah2B7w3wFeU2ZVvcj2FlHRbXHd2T3wEW4EXttLPgof+vVsgh08XnApnXQYdXQJthKt6N95ZKdZsqpQJ+MwWCyl0002tigxPsOGrNKqHiqETb5bdef1KYXHNiHrKNw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA1PR12MB6797.namprd12.prod.outlook.com (2603:10b6:806:259::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:53:17 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:53:17 +0000
Date:   Fri, 26 Aug 2022 11:53:15 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v12 08/17] iommu: Make free of iommu_domain_ops optional
Message-ID: <YwjeW+nSIDkmmggd@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0031.namprd05.prod.outlook.com
 (2603:10b6:208:335::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5eec7a03-10d2-48b1-cdda-08da8772b5b0
X-MS-TrafficTypeDiagnostic: SA1PR12MB6797:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FDKljWMct+1Qe2THzWx7UFKAPRie8fUe11boAZogrwG3yNv57ktos9WI3u4Mfqr7hY6dWGIBc8m8pMqcCf/mg5eu0DfU/Ff9veFqUKQJi++xr1HLtW7xg86Hp0jyCflonucwRugPjZG/I+PWQQ1+1Q+8hn48SQDYDVAOutLaDYvcEfGmByApSSmk2K1TI09dbvbrPF0RlKMAY610B2h7ULJhF6rK1LdmzT3LiBjnSoyGwHrLbjCrtODht10qLdUj01uKxVUoLt85L4yJ9beQokFcG8IFqXzK4Pwf1LjNkuebF6xo6J6igegFbNsi4xtIO2yVI+ls+S8eEuJUZGlcMQ7Cfe7vKFbE6SP/nJyduVG5Tj52zlQt/JLzxeERa7ntlFzj6X998KeY2Z7WzKYf6/Svk8nAEXASt+WudmBiF0b8Ri+WdLDDK//Y5t3y/gfuXYVi6l6lbykDtYpwHT+DQGFk7AYkHwk6G7A23gqfqVlXdjWlfgq5XNrWsqGdfs8Z4VpVGAjktpEkqqp1hJtaToHrnwnIyCu8+91GSONMlrZFtM5dQnYkLw++BG+/s4R+gF1RTsILtUco2hxuRIMBMP/kwtlqMtoGxmYlkWYVNKaHAGBp/Y3384gNJO8t6vBGWI4xD+lIZCdwPEGV7oznwK0N6ChJLTt2MJRF43YB1VKMLUfoO3+G7IzDrsEtPX7KSx6zdlFdtXHHZvWhbTWk0MgYB/Chd3OArA00NnhTKb8+65r2KpB8eLHTBNVvuIzj
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(376002)(396003)(366004)(39860400002)(8676002)(38100700002)(2616005)(186003)(83380400001)(66946007)(8936002)(7416002)(66556008)(5660300002)(66476007)(6486002)(4326008)(6512007)(2906002)(41300700001)(6506007)(478600001)(26005)(86362001)(54906003)(6916009)(36756003)(316002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tpsp76ggvKreP/Z01GV6fjfNNUe2uLiQZNytQwGGes2xyh7l5HypnFP87e2o?=
 =?us-ascii?Q?stWQZpNIv343wwGfs38vX2KaF4idSiROBPrUS3cwI87sKF0x4ctg98K8m5tN?=
 =?us-ascii?Q?yGO4AhpnqV/E6SW2h0Q6DKm1iBdlccAyQqyKB03DWyqtNrVczZE49mo1y8sw?=
 =?us-ascii?Q?ItpDuc55CxaRsFRNX92+alkuTVBiDVdkX2uHC+f49OXGvTPjOv7LhIoSKnr3?=
 =?us-ascii?Q?rLqRNwwL2SSPVV7Xp/i6AQYrdm+RhTBwS7kVdcDN9bC4rD6FGdBLJHfCo+ft?=
 =?us-ascii?Q?Yc+eaBYV1AQwMBnYWMp3kjgw3rwdTPH2Q6wBlpWfWFZ3dzOVLRSonQFH/NSk?=
 =?us-ascii?Q?6Z0bQlOnaVPfzq1t99TVRSRbFmB2avILMmbfkZj8S4mHAwTzPA5vVgyW8w3u?=
 =?us-ascii?Q?ZVJ9WVihA0Rp1v3uyPEH8lbu+5t7MH9ipUOXQmoyi3zXaF3c0U2U6nRL7rbW?=
 =?us-ascii?Q?bSiZSShcQnvEg1Iwhxj0whFuUE5Rq2gm0BTPywyshK66/iO55NM31loZqudO?=
 =?us-ascii?Q?ZiZFcc19Ztw4LJwyK1Og1jl5WkcOiM9L4a5dDJqyfTnH/e8Q7ed/QjLr0CqT?=
 =?us-ascii?Q?W0BLT/sxtBP+vOxjmb0pUgZY9LyfQwLYudzecE2kcFTGsKIFyI5VhbswHwTv?=
 =?us-ascii?Q?bXj7aqlVfJv2rL6WYSfBr+aYX175IIzIEXF/PadfL/Y32KY0T9Vf/wtPc7X+?=
 =?us-ascii?Q?A4msNzZ0Mcb8dgeTgkLQi/huk2nWkuhq3VEDqxnTPL1Ocusdl2MPSFcKO6Hd?=
 =?us-ascii?Q?HLZgcOAKNlQuVqJxIjYsvDT3r61xkCIU55ybXs1RUUwf+Eb04BOjihDxwcEU?=
 =?us-ascii?Q?X8H4GhXsJbFU/NFEz6UNhS0LtwHXpNnBW2mfUZma6cEkXcFLuwV+jedBx0RK?=
 =?us-ascii?Q?4YxAy5U0x8QihCN3S1VIJg1+sTpWJ61y1V88pHSRzw9BvKJZuhWo98BisrKf?=
 =?us-ascii?Q?z3qLS+5cWg6PdRviUWzQpZQIvItYQ3Qy+avPa+4oUe85vbZuCIhofv5uRCN9?=
 =?us-ascii?Q?4fWloCYWd8CnWu7tSeRAprN8YaG+YqjWtZYB8XT/+kXXm/znoKTZmWX7CaX+?=
 =?us-ascii?Q?4RoHIQx1bgi0gAyEm2q2t1RD7zSTQFaw4EjV1tcf5iK88ZOBYt7LwZnRIFlZ?=
 =?us-ascii?Q?U5drUFk0xlLgcI02PVVXFBI2HPy3vFg5sZdlBFYc83hIQsLg6lrvXINeXUtM?=
 =?us-ascii?Q?92T6JC5CcCrKO86YAt3TFk0glK8E/c0DIh86Up26Y23IOlH4l8ycWclmAOTu?=
 =?us-ascii?Q?b5MC/IDm2vOO5JVCMre+xVuuRBD3/KPSzYKbR2LobG/80tSXCj4GnnIQKCyV?=
 =?us-ascii?Q?z6IF1qG1QuxezdfmAFMFImTsWRqJiX2Ju30R/wCUqcR8riP/1nFpMCSzC+KY?=
 =?us-ascii?Q?7dRSdzM5JvRurCgFmrOZ/I6V7c1D9jubn0mLIHvRplr1fSdZ0z8NWEHeKD6j?=
 =?us-ascii?Q?5YMcAg8TGZVK8Z7MfQVHQuo1aVnoBpPTh9kKUxxt/ybxFs4CVHJffOunjJlG?=
 =?us-ascii?Q?zR4zGvOIL6fR2Ef9POU3Z1fn9KPMUyQ6Ys2rguo8TEUjUCVhkXQIS15oQzb6?=
 =?us-ascii?Q?8FmkD8MLxdLBZKzv9HMyl4Yp8v1TYeG426USN43M?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eec7a03-10d2-48b1-cdda-08da8772b5b0
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:53:17.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mrv5mYH7BIdlEthzJ/28sWa33/uQd36mNw3vajIWRyMfn+3efpKm6UFCup7n5mSf
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6797
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:32PM +0800, Lu Baolu wrote:
> So that the drivers are able to implement static singleton instance for
> some special domains. The blocking domain is an example. The driver has
> no need to allocate different memory for each blocking domain allocation
> request. Hence, no need for a free callback.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  drivers/iommu/iommu.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index e985f4d5895f..630e1b64ed89 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1972,7 +1972,8 @@ void iommu_domain_free(struct iommu_domain *domain)
>  	if (domain->type == IOMMU_DOMAIN_SVA)
>  		mmdrop(domain->mm);
>  	iommu_put_dma_cookie(domain);
> -	domain->ops->free(domain);
> +	if (domain->ops->free)
> +		domain->ops->free(domain);
>  }
>  EXPORT_SYMBOL_GPL(iommu_domain_free);

This patch is in the wrong order, it needs to be before the ARM patch
implementing the blocking domain

But looks OK

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason  
