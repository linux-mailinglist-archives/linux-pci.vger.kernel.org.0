Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E525A2A0B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:52:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiHZOwp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:52:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbiHZOwo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:52:44 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2057.outbound.protection.outlook.com [40.107.96.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1785D8B1A;
        Fri, 26 Aug 2022 07:52:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DGWxpuJpCn4EJdpyoHdaSPwvvRCXCZx0Otug6F8eRDNvFutOvc2dFFB5XS9NH5fIHFCRKWfan6LC1K+HPhvF/qM/Jeq3aZBtjaOnj6WCYA2xK0RIgaoJjqVlf095slM0mTvHn8FVYguxC8lc0Wh4gEUTt463FRpPNPCG0z1Pbl8PxJPpOQUlY5ASiyN5L3QlyI03TFWGx6TO01p0MPQmBPMTYGb4VEy3MgbFOyOv+s/r3eml3oSQtk+YZIflKIHw9fP1LubTjrG28Wy+Vw7g02K7YTthchliZAV5cSwEA2sIzRJ0OE5YgjSVYXKT490IaEe6xMLwTy+XamFeeX5fFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E8XZpsqJevGJHpeNjo6D/YJfbYoZYBuAU0ZXIEeksug=;
 b=fhHmVB/HodC9gR0khqW9gBuaLf3Rcg7cOZcttoM9jidi/z3kz+K+RzFnfciVesJk6QdgP/C0Y5ClBny7Xmm9gC/UrKQAxnIgtyPAcfRCng5/7JpX+amRmus0Z5RA8ZbvJ8QWgEhRuAMBd7BYqTCJNgHYJF7U6GFbMDdrQxUIv7XYcdOuhQR1TvzSnBNGNSaHe5kR058Qf1wTKzSaqLMO0HnTDx0ky88kkaqIP34RajOheUom/ojNvk6xsUX502hKBtf3PBsVmDtHxSEAMPg3AK2M2YKkF8hWrrIdMnNa52qCjgoWuLLJOqrIVYzlhvhXBYaP5TEeTjTiip4obvfx5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E8XZpsqJevGJHpeNjo6D/YJfbYoZYBuAU0ZXIEeksug=;
 b=cMIOzC+N9dJC5s+Krjp8JGqCLtRY32N3LG5NoI8A1IBrRoyoKY4xQ9LGsBL05u449p1jwrfh5P/ZDNOlqReySu91zuhyesbUGcpCBOxUUvAxuiAnZ6ldXWc0dpN8E8w9itbfU7jS1OaiqJJBkZUytH1b5rWZ9ZW6NYpG9TCLYIFRFNLIgVYiZmhd96DO72VGqKyForyZsA3yJErol/35rv/IzcO4gi8eopHsvLsGkVWEnDsoMNh0QquOf9OdTwvzhiBhMGunV/fvFmpUviFppGJDbCwjyz7EcHYR5Ws69e3+GOylvOXrXAxAHgRNArejq74uZty6C4pYUu/aQ4LrTw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3034.namprd12.prod.outlook.com (2603:10b6:5:3e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:52:35 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:52:33 +0000
Date:   Fri, 26 Aug 2022 11:52:31 -0300
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
Subject: Re: [PATCH v12 07/17] iommu: Try to allocate blocking domain when
 probing device
Message-ID: <YwjeL2SVmdRpoWb6@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-8-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-8-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::29) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65eaa174-8e0f-4504-2838-08da87729b54
X-MS-TrafficTypeDiagnostic: DM6PR12MB3034:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uwWpuDSmE+PBU4CgixeAidtGawgkx/hJua4wQRt+L99e3aufF4xSUJbr+/Q8Qp5d1Uv13FdFv7H07FF3so32dCgT2qBk7Qq795zvcpJmfe0uvR+ErQPjrBU6yLRFqoIy0BmisA+vQ7IiZmuJu0lW1itAWqVcS1PndvDh7rpXnwF/wqlxqHvx9gj+mr8tLETNEq+O76b/I7cLI5qrC70JKygMXJvmOmEHqTmPmHJgFFVkaQoUUDMwtV+vpXNN877ctxLXCYYARlmNX9e3lWAtzmVSkXkqY5+O2Y/njz1OlMxOuMeKZLkRTI7jSQz/cSDMUuApkaQ8sHNGIrvUqd9bfe+4Q/0Re/NNGOAf2rIh1vtj1EqEgGFYEOzDYi0EBBccydwraFpB1dLPj6PcwQZr5d4JE8nrpvV8TDa4AzrrdgYJl4H+05LeeaZJuPV3ksJwcfdmn1z7gJ8P1IYCVeNmtbYWoYuaXX2P71v+1VXCHMVRJ3x/EP5FPlPZ9m3NYkzNpokZ0mUMktXjabxv+mL2CqISklEdHGj2UKQcCuARZB0KSx7RNPfx2TETlYistmspMq5wO8/QJqSLJPxrgJ57CU+a915VqkDIdbZmLfW9a89O72ldiLHVLBHmw00pk+VhC3jrvv0lJ09iau75CdqvS9YSQoGZ/6bvs8X/cVm0XXPgvpX4BT8qqXM1/ADBY1/791boUhRzVCNe7TiV2/pQoA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(39860400002)(136003)(186003)(26005)(41300700001)(6512007)(86362001)(36756003)(6506007)(83380400001)(2616005)(6486002)(478600001)(38100700002)(8936002)(66946007)(54906003)(8676002)(66476007)(66556008)(316002)(6916009)(4326008)(4744005)(2906002)(7416002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z8ZrQEqd5dNDbg2ooD7JZNmiE+fhLS0UaGav5YCS+9IVVt1wLUjHdRV/NMSn?=
 =?us-ascii?Q?DosWNeUYX6msUyIJqw6aA+M2EZJMU9usrdBPftY0y+bP2W7uZRHmzasXE8/p?=
 =?us-ascii?Q?61XLuENY+X60prYSvR3+sx/fhf02wuDZAepwpl7k44sr+6ufaHPheFJChXSg?=
 =?us-ascii?Q?1cJP6XbR/NswPgnB7mKL0URwGt19GIfsDQwg0QcOdy/nC/+Yv4D5P+8R/55y?=
 =?us-ascii?Q?T78/UYaLr9TTajr0Balgru11zo9FpuxQMtPzRUGo+UN1ix4aI63S8z0r7Gd1?=
 =?us-ascii?Q?rMuutMqUy3zInr+VEdBMhHjlNEqb6Hm20l6N8Koeqs6Jr63v7xtP/u+ULAx8?=
 =?us-ascii?Q?+fTRLuZfx9j1SM/zrpAh/EV3MqbD4UmyVit6SgQFliKjFn+beUr+wrvvqn3B?=
 =?us-ascii?Q?NhU97oPbFYv8Rm+cO+HxMwN10UvpnR1cAODDQbDymARlr2SKjuqpgAHgOpw7?=
 =?us-ascii?Q?62BwjRbXzDYsVViFoDU9COtaVVQKUTbvBYKDvIbFbLjeaYS8sJQtH17OSIC1?=
 =?us-ascii?Q?XXDQRlqwxoFcjEerip7D6tY8r91NWw9hY7wIbw4q/ZehBAXa+SBOo0MqaNX5?=
 =?us-ascii?Q?wD4TTGCU9iseon24/HydqYFzOmBe1mHY4hXe9M97nmYnEoN+VHPwVdLCJ8p2?=
 =?us-ascii?Q?mYLDDhQE2hF7Q/x2tdJcvaHNFzEqfk3ce+eJTwndurCLThzjCR8beC9Wgv7f?=
 =?us-ascii?Q?cB6nykffMCCf4i0CrZOkbtnWtI5jVWhGiXnnWTKMJvh4Abgs9NEMO5kS5guR?=
 =?us-ascii?Q?g2DxOoppn0sD1CY+In42AH65IW5knodPAon1F4/Vouz6UABaIV70lH8LSqzn?=
 =?us-ascii?Q?b8qkquDZYmv/RYatrKKj/jsuf8NeZtD0khk8CO0UsaV7D3kOEiPipwcG3iqx?=
 =?us-ascii?Q?Zg4+2gvxq4l3IbGJyE0+ci43nqxR1ELME+Ip2ma9B5bn9mXZnhDjjBaoxWCF?=
 =?us-ascii?Q?EfdBCUVGMfDnZvf33ZevK+XY0KcOCgB8YCgjBdPY65H+7aIL8lTucIxWmCN/?=
 =?us-ascii?Q?pehH15OtoWp8ZUIwLJRRTNP9mzcC844lM3EVo28m/3+qYci2R8VEk9j8NJHt?=
 =?us-ascii?Q?oZ03DK82IcN+q/yzKDnc8aIXJAJhVDRZT4EINF5VxkSj2ypaQwQ3tFd0uVCw?=
 =?us-ascii?Q?FktxU71brGZ1FG7zNpcRMOT1nt54Na9z8j2rnuMK8XLVW7uyTlXs9IFRq9Xh?=
 =?us-ascii?Q?ouwIpKC461Xwb7MxDNxMGvSaj0AzhqEo2rYN7TPhQaphuZLUiFW+4KcUitgF?=
 =?us-ascii?Q?PqHwr1FF+N8bINMg6fGIBy3xr4QnNZN2UMXTGEmeHEgGqVhcGREAM1oopG5P?=
 =?us-ascii?Q?20iOZ7G3si52RxD0VoUA1avxlHY2T/G39RPuXa3Vh9fCH7kC8FEKVwD6+bYn?=
 =?us-ascii?Q?RyVksOjwQfjknvAUxs0qlPm+l7/kOr6DabFfv8VXYtB+zdty9NdQaoS7VDMk?=
 =?us-ascii?Q?ekPKb53Y7Aj4voBiet5d/pzoRQhUiUlofBvdS2CT/JJlMoM9lw/uU3M7nW+T?=
 =?us-ascii?Q?KeJY5AsAdEuYdTeGT1EAgSlunRGLuBBzzGvZRZUNdWAC/1SddIaho5ucqNxk?=
 =?us-ascii?Q?ldffmAEmcZlzJKkIf2PRGGOiMSqd+druV+r03b9a?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65eaa174-8e0f-4504-2838-08da87729b54
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:52:33.0553
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fl9lpqUDRJF/OJsCVj7hgJARoOFUfwrHc7kcZ2Z1mBjdSRNP1w+DMIEmc0hPdi7/
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3034
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:31PM +0800, Lu Baolu wrote:
> Allocate the blocking domain when probing devices if the driver supports
> blocking domain allocation. Otherwise, revert to the previous behavior,
> that is, use UNMANAGED domain instead when the blocking domain is needed.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  drivers/iommu/iommu.c | 29 +++++++++++++++++------------
>  1 file changed, 17 insertions(+), 12 deletions(-)

This seems like a lot of overhead to allocate these things for every
group?

Why not add a simple refcount on the blocking domain instead and
allocate the domain on the pasid attach like we do for ownership?

Jason
