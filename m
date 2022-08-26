Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2462C5A2A14
	for <lists+linux-pci@lfdr.de>; Fri, 26 Aug 2022 16:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233925AbiHZOyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Aug 2022 10:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbiHZOyv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Aug 2022 10:54:51 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B771122;
        Fri, 26 Aug 2022 07:54:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Puq9xQvVFk5DE3FLOVRiv5skaT0VCPc9kE1T/yRJXhiiwQlsk0Lobxmv4vxuTfahJjcJdS9xVjPFFw7/gxV213BzuzLmm9S1y3/cYCScDF+jpJPaKVQRhyT/3uxkoboaP95MlNw07sTMjM6/gqRok0exQYuPH/UTrJP6u1CRi6Q/zwrlTLtvMmqMJ9MSI8gx+dMbrTLNu+zzMYJIU88eFnpGfvPaRKVcaHXWx5gX1NKDl/MXgMgGq8hfQTlNO4u6P9RAwtOS0xVe/512XeS4FwGsje85Fn011hc4Wy/1vt9tR7h4UMZQ06aZgUB8y8CSQFx8zTs1JBHY3z9HAHxYog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kD0ffl9RY9zk4xKrKopM4bkuNwhbD/ByknryH6w99pg=;
 b=YuTieOT+h3wPUfHw3nafIF2oG2v1SoQJtWM0dWYhRgrvfhe3ZsAcPka6e5g2Bk+F4RswupadWkYXHLkB/sRqqgBvK+wwKL85HCiSItDJ+ql1UYEzuc5iew/y3xQ55FEVxhNNSr63le/CYJKYNNaHtYF/CSAtI7GaBzxxKxCjCCekUTHvlIqbT93BuP1kTH9HXj60n9zmCj9+Xl4D6ncPohjnmdXM/h8ao7HvHvR4ba1pnSwPsZExt6A/8D3ja+HRbZbd0LGrYek9Xiz5ZGj5gXmCcHMt50uF2TMCKYS/SmfFV/mO5sOylZB3VW5qkq0rjPSRnzgS4zCAqWWFajmiAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kD0ffl9RY9zk4xKrKopM4bkuNwhbD/ByknryH6w99pg=;
 b=s1e26gL++ZX0WGrE8FYqwqRDLH+1odAeoeF46/Qh95pI544IGrpUw36DHGqXJEf6Tff7xKVqeGHoOqyv40r5TqtyQ+yN3KnKWqlljDewpmPU9513eZQmi8aCdZuQ+vOZzFJPXtakLwIab3Xau0nL/tb388jrv0Y86WlvBrsnoLl2PQlFA96//Rty/SP/aJb7MLQT83ZTENUrajMG8MRLOU8TIR93f4x//+0LUug7ar+zwu2ZJjv6i/tvCc2F3yOAtLn5pBBEujeVtsg8UJtJgD0TrseDKa0NwRo+r7o+xcT5bA++lhf7AkAxSsASU1ebliOa5xF2mvzsCHdjjKqnQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SJ0PR12MB5423.namprd12.prod.outlook.com (2603:10b6:a03:301::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Fri, 26 Aug
 2022 14:54:47 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%8]) with mapi id 15.20.5566.016; Fri, 26 Aug 2022
 14:54:47 +0000
Date:   Fri, 26 Aug 2022 11:54:44 -0300
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
Subject: Re: [PATCH v12 09/17] iommu/vt-d: Add blocking domain support
Message-ID: <YwjetO21TWkhN6KH@nvidia.com>
References: <20220826121141.50743-1-baolu.lu@linux.intel.com>
 <20220826121141.50743-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220826121141.50743-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0012.namprd20.prod.outlook.com
 (2603:10b6:208:e8::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e581539e-ff57-4614-1e65-08da8772ea00
X-MS-TrafficTypeDiagnostic: SJ0PR12MB5423:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kQi8ggGYLzoWYjAQrsN2r3mJ7e1AXXq+babeeJrdmL2dXxFfrQ2o3Ol5oLCMN7Ar8MK4sFXCjajAUHepkE3gL1boZjOAdkD1GO0eTF+WXHJDs9Ys/rfVUCxgjUiIvGjz6xqczmOhlkHs7U8xZDaXMHT7YkxGORiTmD91dqOfUVTpqcMugkqe78/C/lEpIEhm2AIRRgdturIa/scJCXLrGNNIVdwd0uJYgWHPV51cZIsI5WcbKYpovWXGAGCMx2OsvS7i9X+qe4derZ1SE4s77fmpIYimMpzfwsm1fNaGjw5k6Jo4uVqdh/E9PYmfYeKAvgIqj1rSx+MTCS7+l1BsTTXdPtMSpGkVaJF1wkiSou6DoeMjtnzZRuZwv3+FtvBdF7thBR+zS5SHnMfnIjC3Ni8cnV3+QQQjQ1wIWCT8Si4EHebX0IO2z/DzT2P8oopXIuAGlbA+j4nrZ+BUoXDAuFN29j2MAhBkIz+FA/hTzNU8Sz5/88Bvk8OisIcGCPHQqFXbbSoSyg4/Mp7L14vlzd9DCHKYmU7CNYEp4XXttO/cuzup/P2TVKjBOkcYySDABLSoCfER9Ih/EInPFfiCHthwDo8r8og6QwMBMdIDTweewhBsmrW6mZoUUSlRe56vlbETBgm2/PnrfUaRdtnnD8V1uv9nkfcpjSk99Ko90A/hgZhnJGZ9iM8hGibvaKGwvTyyINA+vChtfVTZ3AJ8jA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(376002)(346002)(39860400002)(136003)(26005)(2616005)(6512007)(36756003)(6916009)(316002)(38100700002)(54906003)(8676002)(2906002)(66556008)(66476007)(66946007)(478600001)(4326008)(8936002)(6486002)(5660300002)(7416002)(6506007)(41300700001)(6666004)(186003)(4744005)(83380400001)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WA1MZvGE2xljIw3asGU+Ks5u877hnq05ZS3oPxhBjGVYB8WGzZEHNgF1VfGw?=
 =?us-ascii?Q?dDZe6jFaLYknm5oXBQggfuM3buavkf3FxNya7li1uzE+istPQu9EHIcGFTMr?=
 =?us-ascii?Q?DeJAGq61I7BhCbiF03fdMiyjkfxZNKV9y6rfs6BjEiYCG3X5TCEgbeEuN3Gq?=
 =?us-ascii?Q?/RgvGOaPY+W86iLNAuhg/++Nb8abMYETewEdFsucURbPgRm624iGXxzYQSPy?=
 =?us-ascii?Q?MDLmJxQYvNNIFMooPdGb5By220NCwHEdooAtOGfucQ92YQalu/ly8ijYdrBD?=
 =?us-ascii?Q?YOz3MKrmSQannLyMa0y44vFnLpvJFwzinTlfhqDoHwqda7FGLXbojmGlzb6W?=
 =?us-ascii?Q?mZXgUMajXn2S6eSKzkkI81aF/ZxOF3xPq+CX+bJ7VbK2p2fOYbf0YUIy5EIA?=
 =?us-ascii?Q?u43C01FTs3+hQsbQhb/x/Ch7ji5E4m5McbzkKPsHV6McXpQIkmR3+Y9iZGUQ?=
 =?us-ascii?Q?JMIJU6BauqOCpHJL0U7G6dztyoO/xhIF7561wKyltaVYrCGM0sCkR6ZWJpH/?=
 =?us-ascii?Q?sEth4K478f3bAZA7xYr7iEO3tt5zlw9IFv1ZE9B8kYk88ZKhmFeWwz7oI7hX?=
 =?us-ascii?Q?YtZtLuyPYruAWOZGn8biRcS9TlV+CEOEODDodehHiD5z0dCn2QoX2aA6wdG6?=
 =?us-ascii?Q?/GAoQYcYqVmalpmtg1oUo/Zd+jCN0rxbkx7ox8aZtTt8HFBI8X4OUyOFog04?=
 =?us-ascii?Q?ohB6mDWvvPa+mPf4F1XQ8tLn1aJiaBZIEoSI03ECEqWhR+TRSwr2rvM1ZGbi?=
 =?us-ascii?Q?ycvnVc9b9Jb8aTDPDjYuYS8yjSnSnTt6DYHoep+mZ9hZKuxFeb4hVVPFW5mD?=
 =?us-ascii?Q?6ww9Cgn33M+HMkOjeSigYIzfm/OzELSA1nSUyxK4MrvgSoctpwyHhaGopwTk?=
 =?us-ascii?Q?YHabqdNdwZh6rLO7fO7VOoywMsTossomDVBICE2XnJVA8yZeaVis4FXgO6d3?=
 =?us-ascii?Q?cZNFl0B4399i1iPSK7bdgZbZP/shsimw950IX45z6j0pSDt+SPgOFvUbOa+g?=
 =?us-ascii?Q?6uvOZMO1OsSOkNYQFdGx99nstkalQWFpR9Gc+vYrd0b8zKDgxf30JtoCx1+4?=
 =?us-ascii?Q?NiuT9aSqmJa5GQJIM9rqWCuUoTJebb+wiSL/4Ws9iU2AhFlv22Fg7Q3I1ARA?=
 =?us-ascii?Q?3pJkN+Jq9AcXReWQyoN0MARktf7OFKvmMV0zvYSBZ2dECeMXHz3vpvGpRY1W?=
 =?us-ascii?Q?BxcQSTAld2t/1oiKRVdqPBWBXsWEANFjYJhlgLD5XvUjd3LFP7RQgXXlKvjN?=
 =?us-ascii?Q?XWt3ESCQgfa2xnLJIkeLCTtVLIjhGzjODa4x7nYyXFPXDav9JtlUicwjiwGL?=
 =?us-ascii?Q?4kKWGSCfylyT9cMWOKPrZHQ8C3rfFVyc8cZWUY+Imoc8qmv572gOntdx3H5T?=
 =?us-ascii?Q?f0dm+OXzDxAk39INe5FTWzqR2f7dL+gwbi9knPDnYgDioWEayiKQkoBUqWfQ?=
 =?us-ascii?Q?gGc537wUCRMVtrz3Q8sPNg21H+MI5BweNIXM73b7drsGbHG9S0/Z135txbjh?=
 =?us-ascii?Q?xfnCzcBr7OpXUjD2kUx+wjjc0knYIAVgxvpuKjBFMi7wMksq+grROO+8Ulzk?=
 =?us-ascii?Q?CpEkAOjsEODhDwwQdLCRUinNByHb/EL99aNo9qHw?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e581539e-ff57-4614-1e65-08da8772ea00
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2022 14:54:47.1211
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VUME1g90AihK+143NPLRknjtScIMcPbUFkihJi5vtr3N0aflwZzsGR1/8MpNRxhW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5423
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 26, 2022 at 08:11:33PM +0800, Lu Baolu wrote:
> The Intel IOMMU hardwares support blocking DMA transactions by clearing
> the translation table entries. This implements a real blocking domain to
> avoid using an empty UNMANAGED domain. The detach_dev callback of the
> domain ops is not used in any path. Remove it to avoid dead code as well.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  drivers/iommu/intel/iommu.c | 25 ++++++++++++++++++-------
>  1 file changed, 18 insertions(+), 7 deletions(-)

At this point I'd suggest to make a little series that does all the
blocking domain stuff in one shot

The removal of detach_dev callbacks is pretty nice for clarity.

Jason
