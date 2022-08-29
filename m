Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4E65A5325
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiH2R3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 13:29:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiH2R3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 13:29:17 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39EC88E472;
        Mon, 29 Aug 2022 10:29:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V++QBO5/soMn5kDBaAbeb/NlTrEeQ/hLR/uT4b4VrwBTa8LikOOf9UNIG3shlctT8fwiW5C9tkw44ZM9wi//dqiHqWTMT1TIZmRzyEEIHyrnlIkPH/g6oR4ji5gm4Ti3IPh0R0DRXpWDsY+5i1XIQhwSZoN/pGmmAphWsVYvSuXBQCwP7iDyDfrYUUC/MS1Yi+6ZYe3DOdZvlSU2+mJRQ64zkthnxBsv6vh7LvmvJVmAfUT4DATzVv8swkypGLHwFrThf9Clo87URUktjT/HkDNbvP/uO5Edj02gunsptm1RC5+NMlXELvIekPP20XgUumTadzuDPz1Wsh3E3gvaXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7y/CsujlvdgL19Mcl/0xjOOdLIMMaL0RwjVt2Ekn5U=;
 b=EhZxbzWU7uPUuqOvkOkASMTGI21g2Ckx7iqkNmuFvepp6ZCyeVWImCW3M1sBnrCtinW0G7KGHGF5sgu6lFC4Q4N0m0nOgZhb9HBG1i6u1QH6SaoK8MicDaJkMZkqftB0EaVDv8LpeBL8KGQ3A4JkLVygd6DhfUAlWUcQWkVNPpoaChfbNKLK4S7UbC7PDBQ9eeST0ZMO74B+q2jP/iq3p2/agQyMXdIb2TF5hgZVBoxReB8zFLm8D/tXx6o/HXoxJ+YomwY3JkirWCrrHJo+dxP7HBkWljp/BawoAgmAdbVQyfQwJ4SV58opxQHO9CWTFON94ftWt54JZ/ZIdiGbUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7y/CsujlvdgL19Mcl/0xjOOdLIMMaL0RwjVt2Ekn5U=;
 b=ZaD/iGoNDNBFnlbQdSkPr90bfEklzZONZDKMNs2QcyDt7CPlpBr4haW7qnZ2Myg1D/y2hB+a2yGn2OOKBqkdNQrsyuBiSxBTsNrQ4iTF7u4/eeaim38UtVOgUZaf7n2IRorZBPJw5oDF5H3W48WDrv+NhYgEzp3uaBN1NY45acTFc/AqdjP4/vs3FGDwnDw73j4FtuNBlxRwSUZMGYwGzaTSKhLW8R3ZE9ioL8asv3fSF2o3Ow2az/pP199TWX3F4EcbBp0IlClQkMevSCYv0gfNkzzBWCGZaWRD+mORIZsGw9hYgYne8XEi0NHtH1sBjSfDv8iR1qzKBUMM9YeJ9A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DS0PR12MB7653.namprd12.prod.outlook.com (2603:10b6:8:13e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 17:29:14 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:29:14 +0000
Date:   Mon, 29 Aug 2022 14:29:13 -0300
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
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v12 12/17] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <Ywz3aQ57PthSYycN@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-13-baolu.lu@linux.intel.com>
 <YwjfKsvKyXLdCJ/Z@nvidia.com>
 <fe5c459e-9992-73b6-35b4-59ef815f1f9a@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe5c459e-9992-73b6-35b4-59ef815f1f9a@linux.intel.com>
X-ClientProxiedBy: BL1P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::12) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3aab0213-456d-42ca-7ed2-08da89e3fe63
X-MS-TrafficTypeDiagnostic: DS0PR12MB7653:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /sf0895wcKNUgwlyHLqfugY9gfjOp0jxOjsIzEXJV24kfVK6YEwIkSHH2nRnOYBw8loKZ57D0TB0FF6+y4gdOE1sMjzZ4tg8UcFAtq1VTppycdrcTT832b0BRILGiIYTEvWIQ8boMHgGln7OE36g6gzj/msvEL+iNbTAxY5RH0BLht06ziV7vOOfnE+aaNyiAARN/z/2qBVpvANjkcIqHoS2zia8V7PBHHw0MgL36+5a4QJoxA85v/GkwAjqiIJh63I7euylAbdIIhTyBvpfIiTJYfq0dAzCOd4CfYm3RylRKQv6hzRpfID31p93oKhz07yq0dTSX+0kq8RdguZW6DjKVqnULc+/F97pjDOGjJzqmTKFTtB2kIDSUvTTPg3xfEig0K4kHdflXQQQvLtUrbz1BnaqBIbl75JHlpyhOXb7t4kth5YCcWy0CjQ3BtyOxUy0ruEQhPZSpmuvxHT1HfmTja8d9YUB0Z4vbPEV7vghePFd4+8130MzBHkf0wFk0qctqyS1D0nJ4Y8Chzz2WONqNRpd9Ph9IDb7SRULTI+tbaBdPRDNhrAlAB2LYmXq4gybeNzmevskxk+N2ZdnVw7d7HvxgnuCzp/GjDs4PJH3Dv7Y0vcoITiNHkW4/vZEM5yIppDnoJH0XoIy959Jz0w0A7D9CAiOP9BgylON9ic3ZIZy0F8+sABCYIYdD2ZElfE09xcAhlXm2nX10DXprA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(346002)(376002)(136003)(39860400002)(316002)(6916009)(54906003)(478600001)(36756003)(6486002)(66946007)(66556008)(38100700002)(4326008)(66476007)(8676002)(41300700001)(8936002)(7416002)(5660300002)(26005)(2906002)(53546011)(6506007)(186003)(2616005)(6512007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D4OlJqgms+Jo7SPlFHieoR6dT/X7OjZbB/AqaO4oETBapMfdfKB5XAnpXAX0?=
 =?us-ascii?Q?L5+/NavDf+4kKVF8HzcHQyJQ3j8Wbs4fUD12puuw8hmAGhCFvdaPoUT0cIUr?=
 =?us-ascii?Q?rji85GBSDXm1IgbsQ3A1LXcyZe+NwzLOom8uvVAd8luvG8FATLV9BrncJcTu?=
 =?us-ascii?Q?eStIbVfTJScFYyJZ7EfnuNkGlQVGfSTINUznPunN1tznKD4bOykAZUSlXjqV?=
 =?us-ascii?Q?Sog2JxOPlhqO2cNocPX5R3A9cdDRnowdX4oJhPZD0wCXxWqDWZAoE8BoNJ7d?=
 =?us-ascii?Q?VLLiwl6cqWNi3nPWTpKDQvCtsKy9kVUvUUXP8zFSCXikC4qyrKvHnNoou3uF?=
 =?us-ascii?Q?jNn4KkdRtF9jK7H648Wx1O7wFC+d6YwIEml5dDYb+q2gs0NdMvkeRzdem7vJ?=
 =?us-ascii?Q?1lcFDoTfEr5Xqrbbtifh5BlVv5Q55Omx6RBsSy+a3uPUBRVh3xY7SuM33m+s?=
 =?us-ascii?Q?GoPV76XwBkwohbWjD6GrUYhlFrosuqmwdwd3nGPstQ5d6bLCxj0OrNud8u8O?=
 =?us-ascii?Q?K/Fbpoi862RdgZ/XMPGc6J2UCiTR3h4ThKDMZeVDrXn30RrY4r6wHUoliHL7?=
 =?us-ascii?Q?nl4SCVojpaqCeE1G1QPwUpVKeKo5pwecXbgM3otKTPNruXh+prQkIC67f+v+?=
 =?us-ascii?Q?Bti/hIcTqeTLJZoMdlCUqOm7DHAlfg0WQ9sgSgnkYhjnZ3sl911tapsUCrS2?=
 =?us-ascii?Q?QCjB55RJCO/DoYEL3vNohaFlesjCdy2IgRNnom0SrIxfwwysttFTdOlkv1ot?=
 =?us-ascii?Q?JDpdDk7QFoSjmpW1S1ERz7wpZqnIP9WhyYmXMEqXPz1HsG3eWkUvZI0SucOt?=
 =?us-ascii?Q?F7sgDwxRM0+eyWohSsjG0dkN7+0FVdc15r3C9EhOF/6WtYlmyU1zUaAmTZ05?=
 =?us-ascii?Q?TKKlvdGpyvqaXhxbjyBwuPYaOFcvT14Db4mToJ6gbeFs2g5IiEFbDeUm9OL4?=
 =?us-ascii?Q?mxfff2JC3rpMHunjisM8qHVYOY+/dcJEdtoFl//R3L5xhc7eNIk/ACx0eNnb?=
 =?us-ascii?Q?IZ3r3Fd/e0/unuft2b7uG0HJ62aRH5+V5UK4JckVM04R9cYFV1/Tc5IqHAjb?=
 =?us-ascii?Q?U5MU2JbHCQn0BAhSbO4g0Y6q2hM4p5qi7+6z7ETiZEWDgzDmC95PvitIFiB9?=
 =?us-ascii?Q?H2kcw/+kJw0o4yUqu1CXVHVZOYcklMWEJS7XgBqofRGu1fvtpvDwvBhWh3CO?=
 =?us-ascii?Q?7XN5bpZd3gnNEBJU0jsPqKEnig1vQCv6U80sQIdzauB+252MZakv2Dld2pnR?=
 =?us-ascii?Q?QU6DX/W8d5P82JOL5YzWum6Baoe1toZVx/ulCiTDnovR2UajdbQw2OvEm/7x?=
 =?us-ascii?Q?oBzkbK03AJYEzOhRwHT5tj0JK08zZfcLkQOp+JTjwVTRzq9N5rWoUJKGOpQo?=
 =?us-ascii?Q?B5FiBU72xB9K9q9PAVhpEQCbARfu6rSpCEI9bqydt6ggfgDnN0eWVlVKvvpZ?=
 =?us-ascii?Q?y+xXh5HqJg8T29FuoZjtmDjrSomMTEMZzdCsaeFEoxTNZw9dBEqCrlqnAVno?=
 =?us-ascii?Q?5N5AlhEBCmGJFJ8MwR+GctRGXpN6tJ4zZkyKuZLOGhDumcJUom6AdFNG8qjD?=
 =?us-ascii?Q?c2KVtI3YGRwQizjZyjC7T1It4QA7oIIKJ3Ek8E8S?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3aab0213-456d-42ca-7ed2-08da89e3fe63
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 17:29:14.6423
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BavCGO4+KXNt7o/QKp85YJXrgIioczlgCVNi82Qm243Ow7Ort4qx6K6JQAtL6bY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7653
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 28, 2022 at 09:57:21PM +0800, Baolu Lu wrote:
> On 2022/8/26 22:56, Jason Gunthorpe wrote:
> > On Fri, Aug 26, 2022 at 08:11:36PM +0800, Lu Baolu wrote:
> > 
> > > +static const struct iommu_domain_ops arm_smmu_sva_domain_ops = {
> > > +	.set_dev_pasid		= arm_smmu_sva_set_dev_pasid,
> > Do we want to permit drivers to not allow a SVA domain to be set on a
> > RID?
> > 
> > It seems like a weird restriction to me
> 
> Conceptually as long as the page table is compatible and user pages are
> pinned (or I/O page fault is supported), the device drivers are valid to
> set SVA domain to a RID. But I don't see a real use case as far as I can
> see.

It may be interesting for something like DPDK type applications where
having the entire process address space mapped SVA to the device could
be quite nice.

You, currently, give up interrupts, but perhaps that is solvable in some
way.

So, IDK.. I wouldn't dismiss it entirely but I wouldn't do a bunch of
work to support it either.

> A reasonable use case is sharing EPT between KVM and IOMMU. That demands
> a new type of domain and implements its own .set_dev for page table
> attachment.

Not everything is virtualization :)

Jason
