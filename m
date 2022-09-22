Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEF95E6786
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 17:49:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbiIVPtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 11:49:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiIVPtk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 11:49:40 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0857426D2;
        Thu, 22 Sep 2022 08:49:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CfE/dfSaUbYo3bTMc8DVJsQB0BC1VUWVZcb9PQC9HKJ1o0wp5B50e1FC4VTCWssNlz0ns0bKf7tdCf89TQv4Bbj0bzKx6OhMmJKkEd81FufitooTSvvK2XARVZ25QbQ/zMMvDlarubXPPwS31iPL8G/75ZurIacikyk7mbQe236LqXJ9jXb8w58xmu6zlIkWESz+aVjKH2gh68mFt6rKSb8OAu5DtneARZNo+TqNjzDfB2Bfa7Lh4Ca+sNU67IgcjeCNQjksq8WJEZ8WdtojwY1iqevs9EcucERexj6CSw18CzzDOWUa9z5nsS3xpV0NShz2nga1yQTtGXwKoZrnXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwwIHz35mUkO79I5T4YsAqovSO31ik04Rn6lfAQMDVk=;
 b=jqF7j90ReSdnL8PH3WiK+ngqNyRCQW5mxbo/0h/8R5+CAsblH8pj4Xms7bnlUAc9mlz2LPEKESmWwJvQ/ZRrfgQUfRz9NTzuJGptz6Wn4FVX41WKmJxaBhmtJR8fFZi7jGFnEP8b+gIeXc482LST66ixQf323NQKpcfa5NWISVQTutHkla9RRO20h2GNTx/DJ33Brdss9D3l7H3ZghPrbH2RwcmrfAT/ML10zFupdCbHl+OJjVLBDqCYpCmD9Bis65XWXAdoWidFYzwxkoDcnR8jZsVFiu4t5qSjyvKC1B4y4c6MBzM3+aJ87S6t6WqohveprWVZ78LBSURC1k3evg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwwIHz35mUkO79I5T4YsAqovSO31ik04Rn6lfAQMDVk=;
 b=OeEEB2HlRp1NNY6o5bNeDfnux5aE2N7uKN7ZI3MxdIizf+7jj74w5y/HqRkyGhLdlbH6eYPS4CKH9v9PUhxv7nrkkwA99Agcxj4RB+OQDoWvTL8DE+EalwoeCt0H9HiIC5ljUzgOPorSSJYRLUwnpVYcR0CZrr9pSwS/TewFWiQdc8YglxZsOWD0pdC8EjSzL2cilVt2hrPkj2K660ZwSzIR4UA6AAt7U5Tn+Mp+uRzfYfGOIvNf+EkFifmiBcJ3BDx2BdF7PRIlIXKzH2r3NjwicOxVvmy+pWotnnQeUNNNv/HD0eDTVCBbFNzkpDX+rGPm0ElAO9YHIJgLLWt8cQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14; Thu, 22 Sep
 2022 15:49:29 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:49:29 +0000
Date:   Thu, 22 Sep 2022 12:49:28 -0300
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
Subject: Re: [PATCH v13 07/13] iommu/vt-d: Add SVA domain support
Message-ID: <YyyECCbmfsaDpDgJ@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906124458.46461-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0389.namprd13.prod.outlook.com
 (2603:10b6:208:2c0::34) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: 7515b2d1-5ff6-4a68-8199-08da9cb208dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rBvkB2XtNynJ1B9BTi7NuTPzVLZ5H8wsiOf16w++Hz4fHMkQyTUyAN2UiP2mUjvUbGxgMqv+mqRUE7bsQoYL7srNWklABov+lT/7hufnEoAc1J0s41gIWIYoha/RQV5zsyYiOoJnv6k+FPgTDc23i4OzRPPrkXXP3a16fK1OC4pBR8sUv7IQZTiPHFLhYL1JvUFj+fORrwN3h5jKp91xhIMHLW9f7A4Vnd+CE7VFZaZIel3Qx597mILHWGJqD+kMICLvzyV2D8whLxlOP99xeJ2un/Ms18BN955S398vzWOsBhhTuSX57I9T4aI9Gxa90zzZo6X15VJceX0/m+Fc0DTXpEcTuC4nSFTi6rDPQbrEz8aVY3gRVqLVtOKwUAUi1NYZJtxiiFlb4kWqVAQUxI96ldSejKm6p6Sq6FKMly8KZZW+mcqgcgqdTDwa8msDm0oJWHVRgapNTu1MAdtUtWLWxs0e49YYFfaWNySP9iEc4DX62m0W0ubA1JfgMSctmSNwPxQSG4v734xlY1Ig1h0eZuR2F+78cQ1w/hqNpQuLSYowqEg+ZTAXiALdVke2Aa3DgglKWUqKorC2MUsaLA163nADDAlkTmVNYhmV5nPFWIZnMD5qi3Ko+WtCrucoAFJ4pvckQOfefEG6FPX1LATCOw3O1XHXyhdtUbEypeapE+6YN7hYG6HxnOpfPqtK
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(366004)(376002)(136003)(346002)(451199015)(8936002)(2906002)(7416002)(5660300002)(86362001)(36756003)(316002)(66946007)(54906003)(6916009)(66476007)(66556008)(6486002)(4326008)(26005)(8676002)(6506007)(41300700001)(6512007)(478600001)(2616005)(38100700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8RNsruZQ/hwTrCC8YkuFVaL8KPwJHrz8loOxW3AvLvmZWg+roRyxeufY1ME7?=
 =?us-ascii?Q?wFUQrmlb1CLRzYDivY7mOhkGbbpIiu+2AP6QNasjzTOn5w8NpRQKOP6lrvbk?=
 =?us-ascii?Q?TQZeJVr2t9caKZsOPnBaJXoU9TAQj514iTHBPxH0pjzkpuWqJ4IGirYe9/07?=
 =?us-ascii?Q?LoklPvN6nRxg9fK0wKZDCGeTgbfOzIPzOleChMI0W61A7Yhk0VmhjT1JWEQs?=
 =?us-ascii?Q?/38X3iIjC3ix605CnHOtFqE9ifOfLbvArf4gcgtJreWuyM+Z72hcGRaD46FX?=
 =?us-ascii?Q?DKUIpzGTDdWfh7u2h8n49O4z4XEN21y/M4DY1ioX/aB+YB8pI5DHlFvqr3y+?=
 =?us-ascii?Q?fkG9/IK29id464PRiu8jP2fnAGw1l61td9wHfo85e+eKG6ElV/LHDswbxZfa?=
 =?us-ascii?Q?qCb0hgJWJ4vvekEuw2QbbtIfpPzNsb16lct9kcFMT55bVGyS3ib8vrIXF0I9?=
 =?us-ascii?Q?dQWuktaGInLLse61Hj1q9dLKTs5/50TW0zm4zuDPO75f0VPohXRYpZN39sWg?=
 =?us-ascii?Q?73mGjQxhDA/3VdN428m1QNzcis4yo2jltPi1fMfj7GRhT1BqYXu1bglElWce?=
 =?us-ascii?Q?ijFoC/IoaCBPgGYADGkIeN4mz5BT35afg/R1FSk4JR7b4BZCN5Zj9FXK7Yj+?=
 =?us-ascii?Q?D4qJtrfvSMT4yjkX2uzwyrhTqCGSW8kzFxnY0sxAXnKGH3gfISF0H91Vt7b9?=
 =?us-ascii?Q?umNymswiIg5bKVQHTH8r9XZKPl8QLC3tPg5zhIHa3/kPiCE6k/QaDct7qevc?=
 =?us-ascii?Q?ZLhhCfygmw66RTINLjiJu30IN/EmJD/qjeu4vSnrheQOTp+0sVPdib+2IcvI?=
 =?us-ascii?Q?dIuKoFiR0ZbnEvP+GzN149875juGAzlk1iejXrBPXSP++m9jjtpUavEsOYun?=
 =?us-ascii?Q?kqFkslV70LOI0Ac1IBinPYiJOwFtx1rcIvVKpb1mXLk+Ime5H5qCQxZYor/9?=
 =?us-ascii?Q?iDLn+G6mZ/cusKZ3DjtFdSNgn9HSk4AlUnWZjbq3WZp/St8YdO6vXyptIxNd?=
 =?us-ascii?Q?F7oFU+1CvzBWvApSR1HIsKmdyoB0LuUhFzo+z1eFt2K31dkhF4yrcYyAsn6V?=
 =?us-ascii?Q?lGdYYmIidth94aRsHQqmk/ZkLcLRhWg00rpb/ByY+yt4TVctKfnff+ObGZud?=
 =?us-ascii?Q?AntVJD46btABqBKJ8tGztTtKdy5S98cQi/2e+ytmw+UvZ4WwUm/xVFOPswrT?=
 =?us-ascii?Q?BRLfa9ET00YkGC/sXi/lBxYfOBHuoulFsljnLe2d/pEcsOex3/S90X2BhrvM?=
 =?us-ascii?Q?72/7prFRDF90pA75eyaj9pDZycO/2n7YvWlnEsCJsBZ0P+QkPX/lOgKkDPKa?=
 =?us-ascii?Q?odQ/fcB5r5sEAkE+LGMQHaaBXLqNFI9xqb/rmjM6XN9k596WEfYfcfcxY9oS?=
 =?us-ascii?Q?V60b9L4L9JOvGdgruAmDrjEsI7WryK9jxp4rpgwPE4zMJZQxL36jVZqn2E1Y?=
 =?us-ascii?Q?SxT3pvs54BaGfjNJ1cnzxcE9Ew+RFiDHGXBTAnAsTEB+RieJoQJoRDLB1Mno?=
 =?us-ascii?Q?xFiE/PWARPdEzbOr9fgDJU0hU8W73MYT4i0xHFQi9pxEyvFFKw9Oc/kesUoD?=
 =?us-ascii?Q?K2guJfKcWCW/TWN0U5CiqwHrxCdLsvtHt2KLn87r?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7515b2d1-5ff6-4a68-8199-08da9cb208dc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:49:29.4533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LqoiqVwHsm0m6xxPerh8diQcga2WoTVt3X5yizn6qf2rUrp2E0Ephzyv4tSyEJ1+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 08:44:52PM +0800, Lu Baolu wrote:
> +static void intel_iommu_remove_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> +	struct iommu_domain *domain;
> +
> +	/* Domain type specific cleanup: */
> +	domain = iommu_get_domain_for_dev_pasid(dev, pasid, 0);
> +	if (domain) {
> +		switch (domain->type) {
> +		case IOMMU_DOMAIN_SVA:
> +			intel_svm_remove_dev_pasid(dev, pasid);
> +			break;
> +		default:
> +			/* should never reach here */
> +			WARN_ON(1);
> +			break;

This is eventually going to need a lot more cleaning up to split out
the PASID from the SVM stuff.

SVA should *only* be a set of predefined handlers (in the core code!)
for the generic PRI mechanism, it shouldn't be entangled deeply into
PASID or the drivers like this.

When we get done with this, the flow should have the core code attach
a SVA domain to a PASID with PRI enabled and the core code should
supply a generic PRI implementation that does the mmu_notifier
stuff.

Also, stuff like this:

				/* We mandate that no page faults may be outstanding
				 * for the PASID when intel_svm_unbind_mm() is called.
				 * If that is not obeyed, subtle errors will happen.
				 * Let's make them less subtle... */

Are going to be problematic for VFIO as well. In a VFIO world the
entire RID and its entire PASID table has to be owned by VFIO and
never shared - so these sequencing issues should be solvable.

But this is all for further series..

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
