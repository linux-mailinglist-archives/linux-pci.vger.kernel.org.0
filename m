Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 914695A531E
	for <lists+linux-pci@lfdr.de>; Mon, 29 Aug 2022 19:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiH2R1i (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Aug 2022 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbiH2R1h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Aug 2022 13:27:37 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC4ED910BD;
        Mon, 29 Aug 2022 10:27:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZ4NkB22IS6F0OThhvTNXR+tIMbkLYT9u2aL1xXWTu9AE0kz+46rlzmXs38XfnSEJo7KtwjkWlL+4aeZoLlTlR/91f5ZHMuBtOXSRZK1i2VuaFyEOpkvSnSS1HGOHPpuTjN1b4KM6olRv8f1+sS9eqLCmHLEmtlxY5cnb4aICYJJQsdNQ6uesV5N0blK+7yY6ZODMUVU5yqTJIyVjAfhXALVbDTNQ3/Ky1CyfK8fKZ5BRbl2RfqMPmTZe3RL+aQ7wKoZwQHQ63W0fLNq0j2DxrZ6HQEhWBJtNvr2YnNyeud21yRlaluXQQsWdEjZ00+r8KUyrFhxHSaToBq3CFxeAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0CyAT12bYIuklEb0RsiTNrmEWLwWumjaqXOaOOHWLI=;
 b=gqZvcc51dO5ML/vD63Woe1dASTXkwz6jfrX0esmGSMHEWYmzlWPKrpE6sBmL5P/Le0eJAUfqcU4HB69skw9OI6Z87KKG+/wj/SYizg7fGSDOcDhMTN+T2Ug16MzMcnRZ8a9o2zDP3JXT1nHFlV8QCEC+Ri6pV+rHipmFsOr7fjgHbUrVg/JNkH6ZH0rVIEgG0o5YCaLwv7LwHqCFbV9I9SkAHdEDThwi/STbyeP2sBf2NVS2z0gbt6APJmGpXI9yHU8pPkCSpmtBd3ULMFlaaDTe3/BrtMfX/BbtLN9gUMX7EeVNsOlb5mJNBxdtvLpWSv1Q2Dd8cLXpaoYxuohlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0CyAT12bYIuklEb0RsiTNrmEWLwWumjaqXOaOOHWLI=;
 b=kRes7wLQuzfFTiPdmNnMSUf/PzcnoxeuBI0vcPgHDginZkPaYAusiXG9D3AAuvkd0ot0WCZbbY5yQ6LNi6u0+oulSprDU48DFZg/0t6Ek7oRFJPa5bxp+1tS2znGYD1WXVZW5Rbxni8dJWzeb3FYvC5YQtA9xpqsU5aRa48pAR+uddxfCiUCHHXrMem7h5N8cFyiYUSWb8+jHxKNte4n+xM0tQN+EiFrIDh/JDm2QyT7QF1jrTjKyT+mTXIVqmB4j2hTFyqrICsGcXcc1OIcR3qWrese8BUJHy4DAbhhDs6FAR3NFLlLqo1LzoxuCzq6DRwS8TkTLNLQJns5gl5YpQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BY5PR12MB4274.namprd12.prod.outlook.com (2603:10b6:a03:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Mon, 29 Aug
 2022 17:27:32 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 17:27:32 +0000
Date:   Mon, 29 Aug 2022 14:27:31 -0300
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
Message-ID: <Ywz3A3tHEzY+Sf7b@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
 <YwjeL2SVmdRpoWb6@nvidia.com>
 <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <316f6575-59ea-08e3-aaaf-bc1e4f42a574@linux.intel.com>
X-ClientProxiedBy: MN2PR06CA0018.namprd06.prod.outlook.com
 (2603:10b6:208:23d::23) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7e215827-82de-4878-cf4f-08da89e3c18e
X-MS-TrafficTypeDiagnostic: BY5PR12MB4274:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gX17gdMzoWOjJzo16tHZh3vrP4CD5F4+lUxQLo2wFCNxloE7jdB43MFdit2NsF66z3bplBYbBc4wqHISmfyfl1GVu+cF8Lu4mA+HSZwcy7DuWapeqtxdMPCmsPr2rpYJlb5vBInXubCZTZmQ+DQRqUYiRPXVmoNHot6WEmy1aWVQaPpti3cRKF/0eHAI7vhuJNipz6hElrAiC5XYMmHjnT+LNcDMe5rz2p8X4wLoR7yaTBJwRITUO4X9oGL/ERzbkRHTkw3ShgfJ3NTTSehLu6V5WylGWX4ytcBU5T1fvBF7j7O/xzaqKWPRptlJCT3kGptpHPJpHeCuAU34KJmGck7TyaivjLw+c0Mt6nmCexy3txLq2pFC7aweGKkL9hcaa2ZZJfUgtms+D6kIunW5qfPbPIkkW2DQCx0GKedJ8v9JxGr0Ut7DQlTdj0E249vGmRujEpS94GRBLug0l1naCthdAWeDsK44KvM3x6+rG9EZB5wxvOtUV8ACyUqN4YfCHUnx1Gy/Og6WxM2w2+7zYV8v0BsrW/vaje77+IkazqDFRuZHWFlZPinRQM/UK8VC5A/QePHEuT3XGrRgYhaO4rF07t4njyG9r6lZTTxt0vEsKQ7eBbPyWkII4kxCWnNUBNKxAnIpSFSFIGwnAaeowGQEeO53HlNgFO9PtMxyKn2sg53sbcEpE9Sj3rkqJ4DQ2goSJ3RYuDfmhGyYzD7goUUQf9datzc0kguo2QHMHH364AhECkBI+rO6Zx47lswrH1Bb0/QYx0PelHE/dN+pEg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(376002)(39860400002)(396003)(366004)(346002)(316002)(86362001)(6486002)(8676002)(4326008)(6916009)(54906003)(66946007)(66476007)(66556008)(5660300002)(478600001)(36756003)(8936002)(41300700001)(7416002)(2616005)(38100700002)(6506007)(53546011)(2906002)(83380400001)(6512007)(186003)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k4X+zZhsptKA9Wom+oTgDWj0OOa9dI88KW1gcSyUQoVK3CQuJAAT2hAlyGnk?=
 =?us-ascii?Q?HEq+TMhBILlHDQA/qohFrM9uabOIZB2b6nctOZ+DtYv6RIRYd7h92Y1BpwQK?=
 =?us-ascii?Q?MGQpC1FjwQqurM0B2WVzmrjX7Y3NwjJbuANn08B6WlzKQdWF5YVVhptqPP8h?=
 =?us-ascii?Q?iYberEmf86tf/0WmYg3xL8yh9TPIysHVF+GIDq0oNcLO6uXOZoRh7iN5kRh4?=
 =?us-ascii?Q?hl4GiYXakQS/hH5Eqyl3OVbIs9hiYD17D5tzHytOIj6Cr6oc1eYwgAU3xJC8?=
 =?us-ascii?Q?qv5lwnQ4YQbAJmhsrYvEI8YzRiJkOTHBTVZJCGenf6PwXkugKRM9g70jlIc8?=
 =?us-ascii?Q?57NQyg1ajAZ/78ZeL+MBUUNzjGkpIoRa41uijh7wo7AMNTx8HEmbsxHfzfLD?=
 =?us-ascii?Q?2xZEC0wg38xPvWcbOlZC52PVfNdHcDixwv6Iw5l9DqTNujIyYsgrdoXgkBmm?=
 =?us-ascii?Q?+vnGNv5YPnMXm/N4mBUz7WKRjBKVzRQhM8qEJdyxcPQegZGTPQHad6AWSh+a?=
 =?us-ascii?Q?3GGIga3SrthpVlpBnX5hFZSefJw1zdiLMKjL5yxL589bA3ofa9CJXXlPlaaO?=
 =?us-ascii?Q?pGk6LJr4oJWjfEHgYlvC/9SjZdt4F01Zm/uF1xPnuzC8IhFpU0Nk10JAACoK?=
 =?us-ascii?Q?qjNXkBA2Eaky7ioChEaogesyXqy+PXLYjpPxPtUKIGsYAjOWbgYKdQjHOusk?=
 =?us-ascii?Q?Y9wUC2UlnBuXE8fgDmpl7q6GiU+rd3FAeZZb18t9ie4MiWijeJMVbl/XrJey?=
 =?us-ascii?Q?OtCspKTsaghGjQASRv/RpA3Lt/zqNE+WfEVgeXfi2r9CJ4G8hArrIFUhyCDR?=
 =?us-ascii?Q?YgFnCZPd8ymfFKyy1aawvy0cNlY3677WTGwKvcrxF00ONI16gMkS+Vo1w5kg?=
 =?us-ascii?Q?okQEZp2BT8q6YLs4bvWvqO5/gEtPQ7keHqwqaefcjUGUbijB+Bhr+Uk2MvUk?=
 =?us-ascii?Q?ItHR864l1KcTFbgifjyEoFvQaKityhgA+l8BRzMbebrPmY6SJ+M9uGWGA+l8?=
 =?us-ascii?Q?Bj3Twp2DLzDAH3wjOAd/AVLiF9LJcHQZ9QC5Av6zFz5ULhg8OTN4xJKFRiFg?=
 =?us-ascii?Q?CBhaRBrhsvbkgstPIXF+VoCylqj2SmadRrS0f+X4nM5p+v8Vd6R+M/RuVPcM?=
 =?us-ascii?Q?OF2vqOA5dX+Egtu+7jGbcuUpQyoZQ8SMCWgqU3UTEQVwTDWQz/PGgI91Al28?=
 =?us-ascii?Q?3shJCFZytfsWuK1kwveZU9yT39g52DYoh1QswYV8bPEyS4jIKizoJdU2BMYN?=
 =?us-ascii?Q?nyOntSdJLwAiEUjACDKfp3Z4ZT/Q+HCaET+DnLMRd4LYWZynrapDa+004kMl?=
 =?us-ascii?Q?v1sYnW1ATUyNJi5Ut46wkXumCjI+/L0zkxwyB1F/XkNNjrCRh4LywnHXRl6a?=
 =?us-ascii?Q?ZvBiH+rcqYv/OZXQfWkzQkrd91jGzGQfPWPCmVMTDUB6SEVoHC/4nwj4MSO0?=
 =?us-ascii?Q?q+YNAGQJkqjftbDbkZuRd3tQmPgZ4c0zVoIURjmMqEDQjgjMVgfARd0rF9zp?=
 =?us-ascii?Q?PEd1KQinJCgZ3NYvsGz2C3VRvDaU671XMghiLTuM1ptqzcZU1MQtEaUNoWf/?=
 =?us-ascii?Q?anANOBd/83u5l+c/CS4T58AGTjN6cd/HdD0rQevA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e215827-82de-4878-cf4f-08da89e3c18e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2022 17:27:32.5852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ve4lRNCeUEylia8/PsmmureXt4YopiQen+PcP35LzAPsbYeWEBpwgKAHy1qwTIJz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4274
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 29, 2022 at 11:40:24AM +0800, Baolu Lu wrote:
> On 2022/8/26 22:52, Jason Gunthorpe wrote:
> > On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
> > > Allocate the blocking domain when probing devices if the driver supports
> > > blocking domain allocation. Otherwise, revert to the previous behavior,
> > > that is, use UNMANAGED domain instead when the blocking domain is needed.
> > > 
> > > Signed-off-by: Lu Baolu<baolu.lu@linux.intel.com>
> > > Tested-by: Zhangfei Gao<zhangfei.gao@linaro.org>
> > > Tested-by: Tony Zhu<tony.zhu@intel.com>
> > > ---
> > >   drivers/iommu/iommu.c | 29 +++++++++++++++++------------
> > >   1 file changed, 17 insertions(+), 12 deletions(-)
> > This seems like a lot of overhead to allocate these things for every
> > group?
> > 
> > Why not add a simple refcount on the blocking domain instead and
> > allocate the domain on the pasid attach like we do for ownership?
> 
> I am working towards implementing static instance of blocking domain for
> each IOMMU driver, and then, there's no much overhead to allocate it in
> the probing device path.

Well, I thought about that and I don't think we can get
there in a short order. Would rather you progress this series without
getting entangled in such a big adventure

Jason
