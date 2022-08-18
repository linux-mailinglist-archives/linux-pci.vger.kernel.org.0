Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 601DF598436
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 15:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244519AbiHRNdp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 09:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243265AbiHRNdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 09:33:43 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam07on2089.outbound.protection.outlook.com [40.107.212.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A61110FFE;
        Thu, 18 Aug 2022 06:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTkv8tg/H8n0w2y5STBERHsFL6F3vVMj+JWkvNYdZg9b0i41fzbX8ul/geKKkZKh8aAnVpgfbFBm8LRuRIGbkH+6ww7JEF2rmtMzIe9DJVgHc60XtWWBUcbp8enTMJLB09eaw7yRIkpLDko0NAUNKT8llZK95yNoNCtlwT9gyyVvIFl+5yArMTnKJspZVxmYsyEA+hW23NNdFugdhiYm9Q1p6oy29XFTPkuO/GVeRYWGn4diF48E0jAT+1Ru89+rfSx3yLTulsGQ4d6iivbFBU+d3M4eCoYygnI8YTD36pRykBvf/JlWeVH9A6S/24/ROvkWZnf1hACLOWDPvp/Drw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzmDsoa5mQjJNXZ1cps8dVhi150tSzcqO5aVeztQ/ww=;
 b=hR6nqcdRT7gcWZt2nG6Qj+2VIGqnbEa1MHjEnx41w6vnB5sde7l5j4mrQ1Ns7eiKtse3mW+cyDCsP0M91IhAKLEC73KyLX4ZxDF1ISVP46+q4U4ySeLdhXegJHStoZ0fEWxxLdsCuQSzfTg4L9h5Kr9fweinKYXRv1Z4EF97p8KlZqZAh1k1qfd9U/gLrPwMQx3Zj54WecSAcgOnB+/5zM91anUkv5EA7IIdhGiXzNyV4FQ33FgJih1duumitQDdxkgUYLuWBa4i6I3mQvkJ1LqZ7KBc1ls0pCo2XqUm9IQyrEvQSzgWM1F00uo/AHx5ZWuiO6S3eQ9FXhx8OjsxCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzmDsoa5mQjJNXZ1cps8dVhi150tSzcqO5aVeztQ/ww=;
 b=ZdU4HLhNDlF+OYcCtyWWamZo8xmN9E2J1ZaZ/VWllaElKbia60CcH3jjlhsttez565r/y12tgHS2huqNJeQk6/VuTdpu96qexCIioLCZdyYypc0R0vNaNTScABSK6ul3g9y+2xNM72y6cEx0Pz8c2+IGuDM35EwPbPZwjIkTp2YKHcDNS2Ee8MccskBimJqIlCz4N+N2KPO0GZgdcJh1qWqPKdjKRggPcGBieeSZoXRjDyzyfaKSbouFb/B/t9YyEPI3tBc95sfutsjpVPUnNMylZsVOzroHln7gGP1gE6GMXWVA6iBdazsOPTNnJMNbc82uKgWnwAgbMiehpTBbmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BN6PR12MB1396.namprd12.prod.outlook.com (2603:10b6:404:1b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Thu, 18 Aug
 2022 13:33:40 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%6]) with mapi id 15.20.5525.019; Thu, 18 Aug 2022
 13:33:40 +0000
Date:   Thu, 18 Aug 2022 10:33:39 -0300
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
Subject: Re: [PATCH v11 05/13] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <Yv4/s6lX6Nq+40tu@nvidia.com>
References: <20220817012024.3251276-1-baolu.lu@linux.intel.com>
 <20220817012024.3251276-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220817012024.3251276-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 088c1f57-6071-4c7f-c338-08da811e4329
X-MS-TrafficTypeDiagnostic: BN6PR12MB1396:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PMj8du61oouLoUlxM2xNZUQTTdW2bn5bMZ34Wm0xQkOUSHVokn7Fqb6GVG8xQc9HmcfV/YbSegyOItx1xSbkNKCZ9XKWPgx28eCJvcLyA/9C3ZWVBLB1VNkwIghidA5XrJl1eqZf7RhYFWhyERiiitd3PP8GfVjkMSE1CFKF31k2yBw2GvG2UzxMalWjeUY5bK5tMNwnLBIZs/okI2G87BUf8qxXEGX4IwIXTmAMocZISOjuUFKbNqtUgA9zsutrUlnRpKQn3tUMeHDZmtMH+ISWWcJx6jPEcaqCTbKxQdGCz8zr9dnG86tQmER7EIFFGBwLjkZ4uJiopEf9hYpAcWp3ccQOwersY9i+CB26JXJCPbxno7SlbJkgSfbQQElDWV9O5KOdKPgI6eM6EZrihr9bVZTOeAhJrSeNcchHOAWS2nY5GW3PhNMkM76sr5RTT+e1S0k0prRtlmInYNyta6zMjwW5p2OGLviKu5oowRgAIiukxXRWoJTJwzJx+TpglgRBk22BYar+wrWPGTJhQD4ufPBYPJkAprZz3LXhDM7/R3pWVEtfeiCYyhzeAOm2nVvVC3t5ubU3xqwXeqXzFipIWQd0jwsQ+SZTx6UGWTYcWOkkT+rt6Po0PPs8d8LLw0BTI1VxE0zscmwu2fg9cu2mNIMR0/Fobp/MKSrDqo9Rph5QNxWrrWFEbCVMP23QV4IVRm19cr95sAdSH3Rq3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(376002)(346002)(39860400002)(4326008)(8676002)(6506007)(2906002)(6486002)(66946007)(66476007)(66556008)(38100700002)(41300700001)(26005)(6512007)(2616005)(86362001)(478600001)(5660300002)(7416002)(83380400001)(6916009)(54906003)(36756003)(186003)(316002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+L2Mb0bao4yEweRnZwmrTrDgJ2oKe512jiffDB+ZpYxT3g98cQsFHCHiJUOO?=
 =?us-ascii?Q?LyCl7UJmNS2kmFkmxoJrVtFeoJjS1y14ykhIdEE0ZRoe0ODAF+lCz8t1KI1L?=
 =?us-ascii?Q?dCmL4G3t9BIw5PiNCOvbUhwwAMGRjziK/fQ8yJJ1+zDGPKnp6BUldD1dm4yV?=
 =?us-ascii?Q?08KttBXtdfgrXT7wmSMVBho3usaC7yREempBKUG/gSA3IC89L6eKlr4tqLX6?=
 =?us-ascii?Q?z42BRsaxGAJRg+zUOZqleSHbJzZPFXjhD2E/y2twIYpHfUVONKvjrij/THOI?=
 =?us-ascii?Q?pMxGnwsHR/yBDT2E48gZGabVDN/0BYwI/bwRVqcAopN+Vs/2OlsULyCPxU14?=
 =?us-ascii?Q?CaQDGR37BFILLMTgLMyqT35F/mBDk+SZElJwRtLVWfSvEuDpG0WgUsjkc4LM?=
 =?us-ascii?Q?ixUCJ6W7dtD8WimNp0sNov34gnp+fqLwb3OPMgnoKMOivWuMH7kZ+TAu2Qnb?=
 =?us-ascii?Q?V20W8hpEKndcgUJaVaQR2AHeKoKVhK1wkHlH9xLv4aKZPeltV15z+zXxaOUo?=
 =?us-ascii?Q?yaP66sBqz5QdGmiaSe1HPV8RJf5qptiGTEfyZO0zN/lerIM/U9bsOE8kQEPz?=
 =?us-ascii?Q?rv5K1ybFAld+ae5HL+vvI+/mGGt/Ds8KM/Mm1A0/iItaNOWXnprnKTuuoaTU?=
 =?us-ascii?Q?f104ix5EfMYXHLkk8eLKRgETmJ5uS9rDrSTYfF47w5xHYM2SRupY6UXInRVO?=
 =?us-ascii?Q?BgsiKvdVtT52FcLp701eR8CG68ojaGLmwc5vI9375YlcKpLuLlTTWV7OqYb0?=
 =?us-ascii?Q?CTWMpcV/eowgJLe8eEFN/EKiIVqNE5P9T5CGX5TZV/cjekOEkvL6C+iuCQjy?=
 =?us-ascii?Q?Wz97VPDrKlWG55hbodhghYOuK/pJZiOsKGo1j6aONRSV/YyRRz04ah/7Dddh?=
 =?us-ascii?Q?dT3c+zAk9hpq3Mxs29NFVoOan2BTw3wshEu5blx+4ll4/c8F23Le0+jN4a1H?=
 =?us-ascii?Q?Dv2AJZ9bfX9u1E38198oIsdbvN0yW1M5+S5Ey7LukFtnqhH0WzFdUSvwXsyW?=
 =?us-ascii?Q?VCf7Q9cNv4tEwWKvNN04h1jBUpHMp72KN3f9AJ7JLpXtx5GUXsdEHnvvBZar?=
 =?us-ascii?Q?Tif6XTr2ho4Op49uoEvPciadnqi/DWmGrDM2niFn3s3xBcnMDV7yzmtrVOe8?=
 =?us-ascii?Q?2qckCqLtat+X+lfjjCE+OD2RGhkCZhcDJn2bJOxiAGKwe8KwAw9oYOAa1oNd?=
 =?us-ascii?Q?zaZ9EDj+38hqIYueyVGwME1uhaQx1m9x07wUBu9ZlR6rCUyrnxd21ddhzTE3?=
 =?us-ascii?Q?HKBNlayhY+9fQ9F6toxsGWTEx/VBQbCaZaxd1lRardPovBCfOoYjVk2pYCzS?=
 =?us-ascii?Q?sil3Qci/6EtEEBj3/9xxW56lgsKR4QQMWzLSi8DLCWqvzJabyviy4JyAZHF6?=
 =?us-ascii?Q?eWJMjvj/U/YJYB/R2JOqoe0VtTOEGFxprMHA9mtZTd/H4GAn+GvqoV0T9OCb?=
 =?us-ascii?Q?mIjtddP2glZ6Nvape4y0Fg9zT+a7YjTwlYdGjs/izq/Pf96YUKUmuvdjvYN4?=
 =?us-ascii?Q?H0HzhMedSQn/QqStHqjMdhoFCBXS+7vXQznXjRYhYydh+Vv27alD65PfNGyV?=
 =?us-ascii?Q?h+rKe1xR6NpWP3MZZFw3a+SsHadHSHdCdwtylzMu?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 088c1f57-6071-4c7f-c338-08da811e4329
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2022 13:33:40.3251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qMtShXrXEYbasRBJSUtdq1G36Y/XfQ7kx3jhtWXOVYH/JNJbMQ8Hq8mBO9YMbMdB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1396
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

On Wed, Aug 17, 2022 at 09:20:16AM +0800, Lu Baolu wrote:

> +static int __iommu_set_group_pasid(struct iommu_domain *domain,
> +				   struct iommu_group *group, ioasid_t pasid)
> +{
> +	struct iommu_domain *ops_domain;
> +	struct group_device *device;
> +	int ret = 0;
> +
> +	if (domain == group->blocking_domain)
> +		ops_domain = xa_load(&group->pasid_array, pasid);
> +	else
> +		ops_domain = domain;

This seems weird, why isn't this just always

domain->ops->set_dev_pasid()?

> +	if (curr) {
> +		ret = xa_err(curr) ? : -EBUSY;
> +		goto out_unlock;
> +	}
> +
> +	ret = __iommu_set_group_pasid(domain, group, pasid);
> +	if (ret) {
> +		__iommu_set_group_pasid(group->blocking_domain, group, pasid);
> +		xa_erase(&group->pasid_array, pasid);

I was looking at this trying to figure out why we are having
attach/detach semantics vs set and this error handling seems to be the
reason

Lets add a comment because it is subtle thing:

  Setting a PASID to a blocking domain cannot fail, so we can always
  safely error unwind a failure to attach a domain back to the original
  group configuration of the PASID being unused.

> +/*
> + * iommu_detach_device_pasid() - Detach the domain from pasid of device
> + * @domain: the iommu domain.
> + * @dev: the attached device.
> + * @pasid: the pasid of the device.
> + *
> + * The @domain must have been attached to @pasid of the @dev with
> + * iommu_attach_device_pasid().
> + */
> +void iommu_detach_device_pasid(struct iommu_domain *domain, struct device *dev,
> +			       ioasid_t pasid)

Don't pass domain here?

> +/*
> + * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
> + * @dev: the queried device
> + * @pasid: the pasid of the device
> + *
> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
> + * domain attached to pasid of a device. It's only for internal use of the
> + * IOMMU subsystem. The caller must take care to avoid any possible
> + * use-after-free case.

How exactly does the caller manage that?

> + *
> + * Return: attached domain on success, NULL otherwise.
> + */
> +struct iommu_domain *
> +iommu_get_domain_for_dev_pasid(struct device *dev, ioasid_t pasid)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	if (!pasid_valid(pasid))
> +		return NULL;

Why bother? If the pasid is not valid then it definitely won't be in the xarray.

But otherwise this overall thing seems fine to me

Jason
