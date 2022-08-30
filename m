Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0766B5A64BC
	for <lists+linux-pci@lfdr.de>; Tue, 30 Aug 2022 15:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3NaB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Aug 2022 09:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbiH3N35 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Aug 2022 09:29:57 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D60CDA;
        Tue, 30 Aug 2022 06:29:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aLD7X0TuU8C70y4Sa8IZiX3ro7fbWwH27L8xGNUzlVWLYOkN7XWsIecsgz9MvRZ8zZLsLSC9ceNpxzUUHiRolzU7FQwfjqIM4+xjPILu/8wrn2tvXAAosIQiv9073hQK9VHlIbr6t0D5Ufxqr9+bbkIFLw5JNvIPvVcN0Kdsx2hNWQk+helHlkh2n07DoWhC8ZYzIKPQrV8IqeYXqFedDuTpM0KT22Z8JJotKCJE1DQabo8v92BxlK9UnfcIJKwoUZGTi8raa6fhgHH9dYVN7cr+GuOfUkBZ7ILzIavK94BMYUNjhGV9AOFJ8QwCU45mMgdqkC+FbXkWqZq+z0kmhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x2BtLmgTXaH+t4jDVNPEslmtt/G3aaPQePI/FvtlAvY=;
 b=ix29UnsVbHI4uW3f6gjRVS3P4XIJtPfFTHNaqTV0MRlxfDcT28PAn5Ql2p3BQc7Gca80tEJDItrkahPwAn1v8ErQQ8Bi+dWFoomuhkSBI/72eQmp47qxRBJg2BIZAVwBI+qor/IJm8wwXiFTpLeA/Pl350Yp80Cwxzd3ux+AezdBFyM3jKe6ey+c1HIb4nVYxxzy+RLby5WzCNQqBGRt2tuCyXkEcadSpXnho/6AyArPxI3tfwI3pMbt9L2Dx0n/X53hm2NWOqiN+aqHfQGu8kJW6pVyxs21nBsvFjiKyEsOWJbauTL7IGw6+M+N9hfYciQUgMshkZMUCn5UXFkGCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x2BtLmgTXaH+t4jDVNPEslmtt/G3aaPQePI/FvtlAvY=;
 b=BfIITQSoTAfR/Nj3h9wQkixt2TrS1Riw+dfUtgvm2ZC+qHF/whlzu8wEQWq6vJ5TGwS1vG466H472CF4g1oVDUgSsm1QcXugOUTwAEf2sl/nhee5/+odcdcfBRG8nGvyEiwLj1SLMJVLqgpWC43adkZNNyxBJAI59BiUfNZnJJjI/7MUsqnDnHA6u/KiAbWC2PZIhj2pypDNZAquywuH6XYAqW/JRfLLtontnBkwAqXQcVJRQQUXkKBOFk/RjDN4sSsKNrAue41Uns16B7rcInnDyLHXb9FmkI3gSi+FV1IYkjNMOQEkD8wD7FvFaPdRkOzynTcU+fF3s+UTU1S5Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR1201MB2467.namprd12.prod.outlook.com (2603:10b6:404:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Tue, 30 Aug
 2022 13:29:52 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Tue, 30 Aug 2022
 13:29:52 +0000
Date:   Tue, 30 Aug 2022 10:29:50 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
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
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Message-ID: <Yw4Qzif8W53ykR6K@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
 <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
 <Ywz3A3tHEzY+Sf7b@nvidia.com>
 <c7d71936-ea06-3a71-d13a-cedd108413b5@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7d71936-ea06-3a71-d13a-cedd108413b5@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:208:36e::28) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c3860882-9b1d-4573-7b25-08da8a8bb802
X-MS-TrafficTypeDiagnostic: BN6PR1201MB2467:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4QMVLFU0WHoS/DszF7EB54TwlnbqDUjZUIBx8ju5Zt8/D1mSTtownG2LxwA+qBLZZWY4zy3Pa3pAOAPH8JhGKNB8jiXE212898bfcgOO2o9bp0YpdtA1Ew3LphO5o3SO+WGpmW9MTC6aAztaCZFoOwR7LRxUfXTI0iNVlxtv+vU9OqC15D3srNhXDQHWq9jh57I4bZBbBDKg3XIVioiRPtLKB40QaF31bLYcQSH/Y7bO7Ut7zGH098SFyyaUrOBzInxoQq3lXeTGE73YdRQlkD4kSvlWcGw6q/J2sKx+px9uOneGtGtirI05cB94ogWeprNqg1czvqW6AsDOtnS8C8yxAk/UUs9oTaVVY8AAgf98DlcmIXiaeeLyrD6ZLUJj+pYtlTJ77WtWuAbsyYiSTfb9PpE68LzGczgxLPmYIRmKNQdMOmRUh2s84HoPQa/Z7zGJzdITnq66gpSm2T8zp1PYM68kvaYVt+JLjQc1vhRA9YD6ghXUeucmrSNgVf2oMtnkGEP+bd6XXqaKRnHNrBAO/IU0TrQYHwB3Zory2hCr4zYSnOTtjyeFCIX6JKfGFYegA4Og8SD4suhPhGQ6gmnKtFKFAYr/sX4Pe9VXIraItXioC5zvb1Dkrrzw683akhBgkyK4p2sIupnhpy+j4UBIqdaRY2Rn+LC61tHCa29s9A8PQZhgfSLF32aFkKFkq5ig0b7xQgn+Luk0kD1r+A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39860400002)(376002)(396003)(136003)(186003)(8936002)(26005)(41300700001)(6506007)(53546011)(83380400001)(6512007)(2616005)(8676002)(7416002)(5660300002)(4326008)(2906002)(66946007)(66476007)(66556008)(54906003)(6486002)(478600001)(6916009)(316002)(86362001)(36756003)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?aU7P8ygSAZoTQ6VF87kWyju4EJZsJ+ZZBI+6ZDbrZy8YPwcVp9NpTky9h++k?=
 =?us-ascii?Q?mkFInbPHsZWkw34nKC/v2jsJ/Ys7z6x1hRDpeynXZtl4iWce1iHFcvw8KABK?=
 =?us-ascii?Q?mqw2Iik8ePYk0uXGcCf/w6HlZCkA6DdIIdgzGIzgxr04p1WEr1bQgKY5dClg?=
 =?us-ascii?Q?lLGCCgywuua5vFT05yK3MGG5MFwQDFAK5sEUnADN1j2rtX+zwbNWHolQZoUM?=
 =?us-ascii?Q?X3Z24OqPHoFVlukQvrtoI2zzEqRkBCEu9Y8VXlq/iSqEPEAKgQenDNTUKwKP?=
 =?us-ascii?Q?MDr7vSz8Gc9OVP0eigcGkOhUcXu81u2O4nRXp6dtMTFUo+CwTnA0pGAiJyqi?=
 =?us-ascii?Q?PiQo5dXarsmuTc/uav0ADlC7NO62NZJFlosyQXchQnzWyQCfZLTFBoc/8sqg?=
 =?us-ascii?Q?Ces0JxmZ/+1QgtZXHFQxxqR3U1flvQOUkXIwjOFCTF5vi6dGednsDQ1ZnIxd?=
 =?us-ascii?Q?30B16Y2PGeahpECjk496sjdNWtc6p/d2Oz7SBfOgSC4ZHGA8o2Tc0PAS5mkt?=
 =?us-ascii?Q?eOWkRwBAUUZuoXi02rk6sw7rndMH21Y2targIZ6EqjFZIm8bAiCd0Sj+w94Y?=
 =?us-ascii?Q?KhYIwB6fIRko9G6pNJr+yBGuAAL/r/ClvupVdOYABdI3uc5UVNQxH68si7zN?=
 =?us-ascii?Q?D1acjtbFfHns0bk2GIOxZfxdCCAlFMIFIBbM+1o5VXsy7fc4N0VGtxYVJrEq?=
 =?us-ascii?Q?TlV3/BAG6VmKZ7uhA8gkS4ucZgTfzbSkKb8JCfQFd0TgW9CX6hcph/HQbPpE?=
 =?us-ascii?Q?JzOs2Vohx4IKquuqD64bXZVKzL5RmclglCDNrF6MhZlIQC6yIOGrI7yE36hm?=
 =?us-ascii?Q?bwViKL01AdJIzOhqc94PVhMDOP6TPUEO07K9Up8o06SXyonNUURXk2HNNqKM?=
 =?us-ascii?Q?Zq2duErmgiujWgRuAKogR2+C/bOb9/Ta1p3jkLpJnvC15wl9ueCZ5ryrgRRW?=
 =?us-ascii?Q?Z/enlB5fjx7dyRmo2m93vFtwLaJ4WGlDPmHlPyVmi8oy8tiOrxKKNRekQySS?=
 =?us-ascii?Q?MD1UOc3SyLngNV1LB6E2qAqh1joGVWIMcAe0HShYzQJ63Ul6oYwYAXiBPEe0?=
 =?us-ascii?Q?bpfS5p9tacN03MeOn+1iPn4I6opkJdRYIxizAqbiSF3sFWTQ5nMHRHfRL1cz?=
 =?us-ascii?Q?p5Gst49dPjIGhIZvzN7VVUCuBA21Cqf2Xti8sWMHGBpfpzMmyEL6uBHvGLFT?=
 =?us-ascii?Q?nhOC1wdqdUXk0cN2kLGOvFk9y6RFgvvgylP1ohOwQu+1MDQG24LeV8pzD7mL?=
 =?us-ascii?Q?5fLRosj3ZIqOXe7Ziwq5+0TPiIGO4l0G9HL2Hlcz0J/JCTnZZ9/tKQB5WwTe?=
 =?us-ascii?Q?dagmWInRND007CFSaI8kUHUU/uvuh/VDj84KcS3JBAxKCz/RMJXvzHrRQjIz?=
 =?us-ascii?Q?4owWPQrnslp0l9h582bfs4XV1psQpZ7QVwwuXthEsDv2e9O2jDt1ME6Bm4ED?=
 =?us-ascii?Q?fzGG/0CyYQ8alN7CNjGY0YF6jb+vR9FXdYIUqGRrsBWAmkBEqhQnrzmPeiPM?=
 =?us-ascii?Q?8KAeVIm+xIslVZ68e8alUMMTU+VgoXnR+58zI1vcqMmLRDwRSt027SanXDwn?=
 =?us-ascii?Q?7KaKGkIH0FbiJmg0BE+0GzqjDx7p02iwm+tWTI6C?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c3860882-9b1d-4573-7b25-08da8a8bb802
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2022 13:29:52.0010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +JTCPHWmxhWtehUlUsk52DG/kWbllhqj0YktMo97/sfakAgmxDAa/qi52+Ch0oW/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB2467
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 30, 2022 at 09:46:01AM +0800, Baolu Lu wrote:
> On 2022/8/30 01:27, Jason Gunthorpe wrote:
> > On Mon, Aug 29, 2022 at 11:40:24AM +0800, Baolu Lu wrote:
> > > On 2022/8/26 22:52, Jason Gunthorpe wrote:
> > > > On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
> > > > > Allocate the blocking domain when probing devices if the driver supports
> > > > > blocking domain allocation. Otherwise, revert to the previous behavior,
> > > > > that is, use UNMANAGED domain instead when the blocking domain is needed.
> > > > > 
> > > > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > > > Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>
> > > > > Tested-by: Tony Zhu<tony.zhu@intel.com>
> > > > > ---
> > > > >    drivers/iommu/iommu.c | 29 +++++++++++++++++------------
> > > > >    1 file changed, 17 insertions(+), 12 deletions(-)
> > > > This seems like a lot of overhead to allocate these things for every
> > > > group?
> > > > 
> > > > Why not add a simple refcount on the blocking domain instead and
> > > > allocate the domain on the pasid attach like we do for ownership?
> > > 
> > > I am working towards implementing static instance of blocking domain for
> > > each IOMMU driver, and then, there's no much overhead to allocate it in
> > > the probing device path.
> > 
> > Well, I thought about that and I don't think we can get
> > there in a short order.
> 
> Yes. Fair enough.
> 
> > Would rather you progress this series without
> > getting entangled in such a big adventure
> 
> Agreed. I will drop this patch and add below code in the iommu
> interface:
> 
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -3219,6 +3219,26 @@ int iommu_attach_device_pasid(struct iommu_domain
> *domain,
>                 return -ENODEV;
> 
>         mutex_lock(&group->mutex);
> +
> +       /*
> +        * The underlying IOMMU driver needs to support blocking domain
> +        * allocation and the callback to block DMA transactions with a
> +        * specific PASID.
> +        */
> +       if (!group->blocking_domain) {
> +               group->blocking_domain = __iommu_domain_alloc(dev->bus,
> +                               IOMMU_DOMAIN_BLOCKED);
> +               if (!group->blocking_domain) {
> +                       ret = -ENODEV;
> +                       goto out_unlock;
> +               }
> +       }
> +
> +       if (!group->blocking_domain->ops->set_dev_pasid) {
> +               ret = -EOPNOTSUPP;
> +               goto out_unlock;
> +       }
> +
>         curr = xa_cmpxchg(&group->pasid_array, pasid, NULL, domain,
> GFP_KERNEL);
>         if (curr) {
>                 ret = xa_err(curr) ? : -EBUSY;
> 
> Currently both ARM SMMUv3 and VT-d drivers use static blocking domain.
> Hence I didn't use a refcount for blocking domain release here.

I don't think that works in the general case, you can't just destroy
what is in group->blocking_domain..

Maybe all of this is just the good reason to go to a simple
device->ops->remove_dev_pasid() callback and forget about blocking
domain here.

Jason
