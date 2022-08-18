Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5349598481
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244975AbiHRNm6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:42:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbiHRNml (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:42:41 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90DD9B5E46;
        Thu, 18 Aug 2022 06:41:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hzA3q6cP6atJ564S1GvtIc6JT7IqFZbW6S5zKNMiW/KjDSzcKEHvhss3NNEZ9RlCMbXNJ0yG/p/4bZ9LtMliUpA4FtkYV7KzgfjHuMUhv5fHbQx5eu+ph+zYCSjaFDp5XGMdzHs0mLNICO6XPgxVq5IDTq7z5UoM7zhCtayBoJtCVCZj5gTDTE8CjqAHQlUCaEkjB41ZYB0wx37BUBVdBckVNx9KXiu76PrhDbvJC5ZvsRmnmmbVl7EY/hsiczk7WX5SsV0WHz0AEi4ax94RWBy3l8krTbmEGsoZaDGo0vewoqjppwgcIDLKu37LIjLMJoXi/gyWAvW/SRtT29CBNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8kXoL7OOEWwOc2Zsh3QAJMp32FexBDm1yFhpdI4UXY=;
 b=Qipq9LaLUris1aYtMmghjSunv4BK1bDr6mH7f2ONdAJNvxqfsWSNEmstkOPoJk1NyxDXolhKLeeI217TJOvDlk9A+enQFELQwvGPy28l2Q+BLsZOTvBROBy28MGobhExRl3+SyXRWtkcjfV4gLUD9Vi/WCwmF7Wn+HliKwrGrAsKxxdyXrIumwlyN2DfDJzEYNZ6EizpXQdhzDPtOhaUO8ZH9D0O1buplDhKXyZPE2UV1vhpKY8qEKyt1pOoVbraeJeRQF9jnjzucohId794T8N8s0ZcZtoF12RKME8QsLQCSA76KBT4+yz354MCxbxnmShv1dkh0D2CEIASglQOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8kXoL7OOEWwOc2Zsh3QAJMp32FexBDm1yFhpdI4UXY=;
 b=A4aUfox8vOohycyOiZgkY0S0yk0ZajW5XgwR4ipxb4B6VEscD71QWuNgbfrOk1h4bF3i3BkIZ7+6wyKn1EHldekoXW2gHZRzKRcw7hgoG1C6mRgMDIeu0+EbC4Qgt0aL6+KKD85Y7k+EQ/fYM2AkzMekf4c6wyv1hf5b3cmIl+LxnZkq7mW8hGLfsGSXuzzCXeShkva808A+QM1gMXILUowYSF4aiDKQfh1XeaJHAw4EOlVucOG3eBwaAmW+pQSjLlE2eYcTVgySyo25GNlDkV3RphgRa/u6RrUMF4ZnNagBdp1KC9iAWLu/OCGb4GmvSPpanfe6xnrNKlSTcZOJQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN2PR12MB4142.namprd12.prod.outlook.com (2603:10b6:208:1dd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Thu, 18 Aug
 2022 13:41:20 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 13:41:20 +0000
Date:   Thu, 18 Aug 2022 10:41:19 -0300
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
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v11 09/13] iommu/sva: Refactoring
 iommu_sva_bind/unbind_device()
Message-ID: <Yv5Bf7+59po6K/1h@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817012024.3251276-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0165.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::20) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12ea30b4-03a7-49af-eece-08da811f5570
X-MS-TrafficTypeDiagnostic: MN2PR12MB4142:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CXclGwiqJO0rHQAsDV0wgzebjQY/5rbChBsXHBUzZ4xGIb5/9YyPrI+QHi+vX632iPxlmXJZhYdIU3H7wec6CPJefmr5V4SK3fQFcuMz8+syNcV1wunwuUQCdtR5MFeZwc/JUv7yFspfsknP73WXYKOoPkp7nJx97V2NenmQyI50HX5BCwvO7pNe97BFC+5v9TKgAln05QSEtwXRCVFAw3U7RktvGEmc4TDi1mXn0uARsLeVh3MozObBE7zeJ9bd8ToPDSHiFtQILQvOr0sbtM2rmncCKIAvL5rwan1sZ+NpahIG/RJdAD4mphKSmPLtr6IghmEUV5aPxVkqVhBsEsTixBwhbOrjGG/tKg5veDn+h8nV3OKeMP3BwKL/VN7ASSpvx6WrXW7W9xT4vgkLC4LT/gVDr8klNXKscYI7NKIABSsC6J6snZb9TXhWjWObPMjFpGIHy8vazJeC8GCDKnBWmnvo8Kj2CUkbwFdsVP2+oRLnToQbzONuVA8BYuR3AWQ0UW43t2diCS5yeIxUbkKdsVRLbn3GJod4It8a7r+CMNGpeQ/jXNlPBARb+6rLnqrpvUGg/5Rhx5CCmC/kf1iXWm/7+PbmaU2g9VwQmQmcdkD9mqQh2X6t9FeVrd/YtG808GvZqLJ6LP7QfnMKG+nLw1yu+tSHnIZkRPoL8aIKV7+SZdWe6Iwn6VToV9of7YurU/woBwTJxDr5N48pzA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(376002)(396003)(39860400002)(366004)(136003)(83380400001)(186003)(38100700002)(66946007)(4326008)(66556008)(66476007)(316002)(5660300002)(6916009)(8676002)(8936002)(54906003)(6506007)(41300700001)(7416002)(26005)(6512007)(478600001)(6486002)(36756003)(86362001)(2906002)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hIjX2JtwH29hfAfPrmuehLbFyskEWUzFElueTIFH2BV72J8Gn5vVekFnoNal?=
 =?us-ascii?Q?OKviJyl9Tpp5Mb+3OBLxhzrcLDiFlk9sEQPID+HAD5ZaxzAIirKLgOyc+9gS?=
 =?us-ascii?Q?nsHo1cf5Pu2aXFlx6dFO0dBM9zAUMCQ9SqDx7YnFSK5El65rQ+RBhF4BW/vS?=
 =?us-ascii?Q?sfx4njSc9LoViU/31DJhIOFbO3xIKmlZPHHqh76u07nMVqyvwJd8Qm/oXGw6?=
 =?us-ascii?Q?h3PT4H5BSq7gGW6CEcx3mNQUgg8nxHiNF83h2rGUOxi0HOIPKlVKtgUozIEL?=
 =?us-ascii?Q?2kkzY57n6BzvY147n6IAiJPjl6L4ffRfGoY5vvUobdBG+LrGQkjNMYhq7Idf?=
 =?us-ascii?Q?x8+bOCu/KKUN5ghFxgDeOJ39Q2GGV2V7+fv2TvOK068+utdC6uafF9300FRV?=
 =?us-ascii?Q?YGRiND/Cyu2mWLlAwi9z7lQNsTo2vypGVkt57FGZKFIu7xvM+RsilS84rGTs?=
 =?us-ascii?Q?HSYHkdN7BdtCvTx4mahpWsvXxtrbFwTtDcNP1Numl7/ylHPN2zCus1NJWxAq?=
 =?us-ascii?Q?WZh0EmiP/z7h8pJdaKEQkXGXIte+jxImf3Ja6sA+vl1Sjv4HlTlYssOQfhBw?=
 =?us-ascii?Q?XfJvdIwx/2nrUkWI1JxUfaZvijw9olcHjlmkSC/7k1Zwe3WejqxYeOV0Od4k?=
 =?us-ascii?Q?chcSZVwP61lyQ5v8DwcLk68pNlNsSI/wDiQs0hh5OP3Lc8h5sSVfGGiTQPxF?=
 =?us-ascii?Q?atv3ERDrDFvJDeFRANCrrH3XbEKsLDhIyVAjGv2blbsxO0D+Q/D6jt6bRYF8?=
 =?us-ascii?Q?AHcFUSHAW1KDZ6OWheH0kulSZ3vGt//o0BlP3ZQHMJNqgNXIbNqZ+2UNF6uA?=
 =?us-ascii?Q?R8li8KKJqTn5Ojm0JzrpnnxoSGFgJN2tHeMtMZ1kaJNgWG8ylhYt+g/vs+jl?=
 =?us-ascii?Q?aPxDZtLDvUJgP+TG5eQeSWodjgPKhr6GOKjbZoDBkfROCMPTUC6wlwfSRu9w?=
 =?us-ascii?Q?+9z4azKVN8AO3U8CyAIaoUy+BpzmcbWNibgeDyowe4lHucMn+RogE6/nQLon?=
 =?us-ascii?Q?UuUewk5/akOZnHccSFDt84IuurHilq05Wx0Pzfn8HDLi+PYiJJM8dwT/oha+?=
 =?us-ascii?Q?7E8Q8A4uVtH7N2LVlnzZ63TsCflx+yeGSEPwTktCITNGZIPGfI2wx080jjNu?=
 =?us-ascii?Q?K+GHwPRdCPZidPTdNsIc2zDbD3Y1Kngyh23YeA/Z0ZYumzednEWnVsW8ATUB?=
 =?us-ascii?Q?vgivFKuQYQTjrei9eSgj8xYns90u+9xG88AJ2flWqLDIRgBIoomvrFyvazsb?=
 =?us-ascii?Q?BMaoxqUul4vIh0LquZp3LYOFtzDWqc//CBjlpFY9nP4r6ERH9Pdz2V7ZtNZ+?=
 =?us-ascii?Q?Q2LpNwvH9NAztpJGbqbIhXTW3BFNcbgULCv9DlPwggHv6aYJaZc7CGeW0kEX?=
 =?us-ascii?Q?evXUf7PvAYJ86oN97FhXySjtwVjbJL3G8h+7MoXjVX7smLlMkvTWNW7uQFp8?=
 =?us-ascii?Q?LhvItDBS8ycCkBJXvmFG+aXEJvT/z6315o16R0gsE/ec595iSecpV6CLdD9t?=
 =?us-ascii?Q?4b5IvO7w3f6KlXEC/h21peTNOeDqjM8xFPULpBHcE/DEb7sadbUhAQeSF6/j?=
 =?us-ascii?Q?j2QLYovL9b06cWH1kee8N2bN3pHS/uFyMr+d93LX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ea30b4-03a7-49af-eece-08da811f5570
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 13:41:20.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hjPBc3cKTcdZqjq1AOlWd30ZZpIt8NdzD8lkwzFcf608bD0rUU3OJgPPHYKr0TnM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4142
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 17, 2022 at 09:20:20AM +0800, Lu Baolu wrote:
> +
> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *iommu_sva_bind_device(struct device *dev, struct mm_struct *mm)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_sva *bond;

This is called handle below, pick one name please

> +	ioasid_t max_pasids;
> +	int ret;
> +
> +	max_pasids = dev->iommu->max_pasids;
> +	if (!max_pasids)
> +		return ERR_PTR(-EOPNOTSUPP);
> +
> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, max_pasids - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	bond = kzalloc(sizeof(*bond), GFP_KERNEL);
> +	if (!bond)
> +		return ERR_PTR(-ENOMEM);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing domain. */
> +	domain = iommu_get_domain_for_dev_pasid(dev, mm->pasid);
> +	if (domain) {

This isn't safe, or sane. A driver could have attached something to
this PASID that is not a SVA domain and thus not protected by the
iommu_sva_lock.

At a minimum you should add a type match to
iommu_get_domain_for_dev_pasid(), eg to confirm it is a SVA domain and
do that check under the xa_lock of the pasid xarray.

And then the general idea is that SVA domain attach/detach must hold
this janky global lock. 

> +		refcount_inc(&domain->users);

This atomic is always processed under the iommu_sva_lock, so it
doesn't need to be an atomic anymore.

Otherwise this design looks OK to me too

Jason
