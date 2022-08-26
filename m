Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 353085A29A8
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:38:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344434AbiHZOhv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiHZOht (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:37:49 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2072.outbound.protection.outlook.com [40.107.102.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCE6D21DC;
        Fri, 26 Aug 2022 07:37:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PjUSRBzO3ZuZ2M2LqqKWmYbWCcn5OIh28NKg+l+K4urmnsH39kcMkQAzou2er1ojSrMyt/Q/E+zYP6GTaO4F3TnNy9FFRDje5kgrpYFMWmH7aLimHA+q4O7IfxeA4stfnl7IcpaByorCkAOFudsa9KmRFF0BPXuLJyalXzrebDZrOd0fgeN/uPstiOOTK3hSC+NHPsMaYo3tSgxHjeBCfkfjZUn4kAnYdqyuqTihViGsm7fy9orX385KzfIa6NYlges7s8nnUUjcMi5nPfcBfzrZvTWZvy0j1FDDSA9kv8TdHa+aK9vbfxxkm2xIoaWJN484lLTEF8e0GnGAOwJ3gA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tWKev4e5PxghEfpyNk6Ca6lf3EFe9BNYVtA69FeXCs8=;
 b=F9EwezaPUmciJI8aUh25xbQySt4Z44Fh7onF8jXAcLylI57ONQZf7sL0mPvAqQgNHZABuS3isLuo5HAZOl+JzQHTLHIjQfruJ4m7K2D3oRog6tBjBOdwKli7cpoZENs4ogJqGlbvo1X8dX0ON9QFAUWRMNnrRIbjhgl0OQUPNMldaf/FrAxvaRJqfVE/nP267M8u1O+M/qfpGdBS5Guo3LwSDBW4aj3J7LjiVqKRFbFjhccTpB80wBwuWdl1A4hT86fv4/vx4qU0dFLyP4Czi2qvyGxDFJ2DJ4123HAsn67kqKXEYe4BphzYnkw/1QenMlE8yTFeCm1zQqPLjqZmOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tWKev4e5PxghEfpyNk6Ca6lf3EFe9BNYVtA69FeXCs8=;
 b=nOxoHF5oDTiAlBZgK8658g6kD81AOlwdvt7UTCnDRIIck8ivbu8Ha1WtPnN2EqvfmbWNRzFJqGR7A/LzPr3Y92oaKZMR6aDfav1Oo1HveCsa7B4n9Xxe+m9Clow88/2MsIKgmXBhWkbba0HEUVzDV9onGcevguRDsTFXtsjihxwI8OYDHMjtJYSccgM6Y5p28ODNGfn+keLMikIhzrN9DM8s0hfw05REptCH82TSF0+8U8a3TDw6f8Dm9FXjcUPhmgOch5t01HcHGNRKMJ+0EluzuC/pS5Ons9bqSqLadN+d8McY67aEHSRLfzi9rHc9JaSCJSmCrKKgFQkxAzgOvA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6539.namprd12.prod.outlook.com (2603:10b6:510:1f0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.16; Fri, 26 Aug
 2022 14:37:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:37:46 +0000
Date:   Fri, 26 Aug 2022 11:37:45 -0300
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v12 05/17] iommu: Add attach/detach_dev_pasid iommu
 interface
Message-ID: <YwjauaF1sTP6l2j9@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BLAPR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:208:36e::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b8e107e-ebb0-4110-3b1b-08da87708afb
X-MS-TrafficTypeDiagnostic: PH7PR12MB6539:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BjrVyFC2zVy9e0VdsnJE2AjMB174+hvVGmthBc9a0yRgIuXVDxbPURfCQcTNfviHwT/NeMNzhd9ns4r7z1+toCFPCeQ8ykst2dP4fLES5EuscSIXc2Ivp0WAbJZdE6PC+Ny82TjDyXi0d4KITrpOnzXde3G8THq9+4qo2hj4uA4nc3AeyvgeZ4HM3GG8+wP8Vo9WV9ar047FIiqhZ8VBYYTwpLTK5xcA+bPhVW/7oLaXXXFBDacp0RlToEBkUQZD1rsa/rjyhT7Jjzz1Rq2qDULhdG4SecXGH8fEl1Sj23hWbL6t9fDESsNC1RRLwpzVfdqkQ6fjQeA3ActyYrj2jkLiZf8HrFz16ZKmLI/J/lNAwZ+AUZyZJh7f8MPNdSFOQXddODTp6tVrPCSQVToIL5XJJDN4anWjRSts6s5RYsw1IYG7KJaqyisg6eDtd5FLOtRqyk52xnsQj6w0klzvIGGj8MyIgLBGwxMptd8m62s6qISov6Yy9cY/LbTip0w7pocfcUDlojnwU8CAVeQ7EJKRF55eYbhqeqQDhSZpVlr+vhpnHtt++Xz1+61M70KevtQTslu6p2GtDod5GLkE1KANTeAJi2k02IT2yWQAF85SAtSNT3c5KIP9N31jf97BYA5jupZBMnhzdoSxd//U8bT1zL6XloGOhX4rKCrcDAp/vow6+MNeBtgd4SRokhi+NdVEKzwfl+mhaJWjGaU2ew==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(346002)(396003)(136003)(366004)(376002)(38100700002)(2616005)(186003)(2906002)(6506007)(6512007)(26005)(6486002)(41300700001)(83380400001)(478600001)(7416002)(36756003)(54906003)(5660300002)(6916009)(316002)(8676002)(66556008)(66476007)(66946007)(8936002)(4326008)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vJcoaM9d8JTqbfcldx5+LXTo6lPlMuUDYcaQ5hgrg5ShaWHjIACFAiWFewKC?=
 =?us-ascii?Q?0Si/COJHU/7RBbjAUnNCy5i+5SOfJePYn0p0r3YF8wx4MD8SDvuc1Ob0swuA?=
 =?us-ascii?Q?ck4VewL0KLSRVQ3s48UwLPzo+pBMI3OEwrrS9Bw6eIzONlxJG8gMOrFJyZGA?=
 =?us-ascii?Q?JxyZWezqxCKjS2PKcD4RfIJ9AlWGBaVYJYNU64RMLxKt4bkQ5lY1TydCYYCc?=
 =?us-ascii?Q?I3lKEe/9HDyhrftiDeKpEJbiRf8wQ0NglAgayw8NYexbNdqOA3CKSdug7gLu?=
 =?us-ascii?Q?y20F8DdB4D2CDPikfrVQbIcF3D2HKLVwzel9irwfbGy6mzKGDfZFbSQwBbv8?=
 =?us-ascii?Q?rbEB+xBpmNj6xeUEXAYLfHPEc9L4Tcj/y1nnNYWNE6XQ9EHQM3VsFlUEWuai?=
 =?us-ascii?Q?DjmBGTgpumk56418ANLAEwOe/BMcrGtoXG4U3x/DkznGfygjhKC8w1L1YUyr?=
 =?us-ascii?Q?pqyLtViiekAFLJsIoOBfH8vLIOazR5tCAIgWFO7QQQSZY//ZfoTMzIzoQGOM?=
 =?us-ascii?Q?9LGCuk21/HZYyLaceso8thPZpIRcwgggEFvfnrsagg1lppurlLQk51DQlIUF?=
 =?us-ascii?Q?x2/M0X0d7R/TRd/5kESmHOBR/NGURkB7M1sWmCvpYR+qqFKNGOi4MUe0HKqP?=
 =?us-ascii?Q?nrsbEmu0dO1fz/KnRo7z81p/9gAWox9bmqFPB/G6Xl2H9KAanoBWQCJ6GWKi?=
 =?us-ascii?Q?Z+DjcRIqX54nAG3cxXhdiz2Bz05IshTGIy88ArHC+OGyzOLC5PUFFsg+hsne?=
 =?us-ascii?Q?k4E1FWfVMlpcsZWvBXcfnoITSQvkJA3xEBMY0UpeT0ECyE4iQv134OksWQx0?=
 =?us-ascii?Q?bMzP00tWQ2a0mv1b5/uzAcXqSFiDIzGzAmBTyqpbatjEDc9YH5TFKusRydeX?=
 =?us-ascii?Q?2meAbggLJKfc8QaXg+9Xq5LIlqV73K3MneHdsdzR2NjH2HkiWoXt2RiJNORk?=
 =?us-ascii?Q?vsquU+U+fGH3R6QvTj8DcxCMLVk5JIfUnZBfD4ZOy1Pu2liP51NF6KQcnq+F?=
 =?us-ascii?Q?rgmFDSBkWa0OGOB4h1kZmAw0KHC3WcuNIYipHoM7caG/j9x8eVvCsKWgzBbG?=
 =?us-ascii?Q?j6n6W69Tr2v0sYQN+hCti3Ef2MzWn2pmiS0EkpI+wpmstVEkDRc0B345jje+?=
 =?us-ascii?Q?ssMYmnNPeuxUGPwD14urTrKYu0CBCf2iTZFLkSpgbhRCDMnPLnSFXaZWUb6D?=
 =?us-ascii?Q?NdM+7YWDoRGqb0WGS5fikPHij/N7+77y04Ysdq8/omRo9fEnOKJTUw93R40B?=
 =?us-ascii?Q?11bAEgUAGnVFAbB3IW/RYuSFyikwc9tBPtgH2oD9Vg3igX3xwEsHqiFX5P/4?=
 =?us-ascii?Q?9bsfV6tjmg9tpBnzLERs+IBPbYd09QriU8TwSbNW2DptDzMoggnWeytbrFUQ?=
 =?us-ascii?Q?Ghwgy7uAASoI2zlYQux1Ev/e8cqEK86DM8uTQ1/Ys3iU7hzYFA07l5TERzJe?=
 =?us-ascii?Q?1d5Q+aFTC96j4PS/EZHfDOiN2HkPIb9IuFXwEY0FhIGzMO9IMTU9HmByh07y?=
 =?us-ascii?Q?W3WBgUg+7kwV0vp13oZKwkDqV/hHPg543UN65wU6MhaTSWzsf5aMz9YJJ4NR?=
 =?us-ascii?Q?za+kS68dQ5HmL1iW8JFZGeCRfOJLWcfYJklGr3Wd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b8e107e-ebb0-4110-3b1b-08da87708afb
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:37:46.6185
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P/TCduGbKuKIdghFgPRNKDaU+3Wgclnm+nioCFgs2Vc0VwSdYhYQdPml+lm3hWBu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6539
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:29PM +0800, Lu Baolu wrote:

> + * iommu_get_domain_for_dev_pasid() - Retrieve domain for @pasid of @dev
> + * @dev: the queried device
> + * @pasid: the pasid of the device
> + * @type: matched domain type, 0 for any match
> + *
> + * This is a variant of iommu_get_domain_for_dev(). It returns the existing
> + * domain attached to pasid of a device. It's only for internal use of the
> + * IOMMU subsystem. 

If it is only for external use then why is it exported?

I would add something like:

 Callers must hold a lock around this function, and both
 iommu_attach/detach_dev_pasid() whenever a domain of type is being
 manipulated. This API does not internally resolve races with
 attach/detach.

> + * detaching from the device PASID.
> + *
> + * Return: attached domain on success, NULL otherwise.
> + */
> +struct iommu_domain *iommu_get_domain_for_dev_pasid(struct device *dev,
> +						    ioasid_t pasid,
> +						    unsigned int type)
> +{
> +	struct iommu_domain *domain;
> +	struct iommu_group *group;
> +
> +	group = iommu_group_get(dev);
> +	if (!group)
> +		return NULL;
> +	/*
> +	 * The xarray protects its internal state with RCU. Hence the domain
> +	 * obtained is either NULL or fully formed.
> +	 */

This has nothing to do with RCU

xa_lock() is used to ensure that the domain pointer remains valid
while we check the type since it blocks concurrent xa_erase().

Jason
