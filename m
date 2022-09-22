Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9BD55E679E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Sep 2022 17:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232005AbiIVPxo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Sep 2022 11:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231965AbiIVPxm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Sep 2022 11:53:42 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2056.outbound.protection.outlook.com [40.107.220.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8D045F6C;
        Thu, 22 Sep 2022 08:53:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YnFY9MMC2AGiK0MDGb7FphM+1Yhh6n6b4VtvpBXK2aq2YFSxmb9ZJVGsuib3cgk1llfUhXcFUH4VZJdcjjwlJ0zBCc4P1r+jmUu5UfCL4itS1xRHuDNasyZ3Cf0/ZnqZoOX/qt1PmSe1KgTjrU2ZC7gGaLKUueAALZN51i9JdoM1ZE+FCX9JlADp4jISymdF/QsTA5cLZhixrDV833L+swn8OyVkJ3vnsz0GCdXWMY+v6FP6CQXXazGGqQjurjh7f7EEuxBP+pingxwiWFiakCQjAUmZKAWvh8n+ApsZ0ai/kG2dmepi/RGk+TezetYKvMejWFIorih8a/5/61NGCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QGuRWbZR5yH/MJLD+EpIQpr4M95iJ4ZhzGFiuASwgmM=;
 b=XKkO2Yjs57DqF9nUUa4KyBlE21NpD/X+P1JqVrHgluGhDAupXJrhK5S214MFUDEsILRZ1qHq5q2ZryGE9FJq58Je5MKnz9hAGCIfZCw1Y4c1+7haFTc4A6p+GT62kpvxfZenJ3TUx1M3BsroC/FpqUIt1LiDZ1GErN+MfxncQuOLWArz6462A/Ez3s6MoXsFAI56Qt6DnFDMKuRIDxOPAJMpkdpTQ+run1HNdFieL6hb5qqH72UN6vXhyXx3Lyxz+jdmyuW1A1F63AeQ5CBl1JR09/eFh9x1MrH3AwcAykZs/IMOQ9xjl2MlM96bYAiztGFsb9HWsbahbge23dErqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QGuRWbZR5yH/MJLD+EpIQpr4M95iJ4ZhzGFiuASwgmM=;
 b=qm/OU/6fRBImZdJrvqmWVVoYqM5l6c9wHHb8+T0hbSgRH+ugIjk6iArN+XAcFHw45wzxc2TrCHjYHioCj8xysiUkpmfqwXVi7H7WHV1eie8D2yKRulpNHo9yhTcnsK7HImUXDlSaTAjYuPcMT82a3l0ZfGO+zGEIXTygAFRPa74zzVnTz5lkNv7S2YQKDx2hjsGeeB5WHYWM80n3OVhuBT40MvrDaowaEjH3ReCSLw4aZS65bciTNJQu7liKGsN5eVZRGAJZhmNfozzgg8aRMJPia0jm0aqu6hbOjxTVJQhFeqOB630uSC4UTHz4WNYSGGy9sawmCWeda1jmA31SUQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by PH7PR12MB6809.namprd12.prod.outlook.com (2603:10b6:510:1af::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.17; Thu, 22 Sep
 2022 15:53:38 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::462:7fe:f04f:d0d5%7]) with mapi id 15.20.5654.019; Thu, 22 Sep 2022
 15:53:37 +0000
Date:   Thu, 22 Sep 2022 12:53:35 -0300
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
Subject: Re: [PATCH v13 08/13] arm-smmu-v3/sva: Add SVA domain support
Message-ID: <YyyE/3RISqf/MHR2@nvidia.com>
References: <20220906124458.46461-1-baolu.lu@linux.intel.com>
 <20220906124458.46461-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220906124458.46461-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL0PR02CA0042.namprd02.prod.outlook.com
 (2603:10b6:207:3d::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB4192:EE_|PH7PR12MB6809:EE_
X-MS-Office365-Filtering-Correlation-Id: 8694662f-8825-48fd-248d-08da9cb29c83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u/aFBhBtURhSeDbIDmgpu9jYsr45OFYNfa38/clfW/ZuMDJ1PBGxdww9NyaeKuGY4YS2dXVpg5jNytkQJN/nABbfuG9gwb1Tyqi8Jm7DqSGoQW28XRH9lILnIjWUHw7c3c574ssJNbdLmQ7gEA0MV3o5+zaYj2asKQvtzj4o0YZrSOECy/eeSQiCfNHq9I7CoWXowvK80nKNVgZoAXAjuSXBfFf0fV34ExelB4E+QQS4jLq+wMYzQpehoLZJwUoA9/UBIsN7qkPuklayLDn7JhS7LG8LkZK4mXPW9u1SEfCFNTg+F5FhjoMa/x/8yA/wqZ5gjq3ZxnjSDegfLxwBvjsnp8fVfR0yW8msqrTm6iYCOAgBT+KHsp1xlDvND2AV6QYKltmUkxU2nSrdo39ZyXNZfVtxfLXv3PSLMmW0kxpPZuZ3y7Sxg+YPQL2ILtDlPjTtoAaOa1294Xuu4r2qQr5FmKFTEj65kTZWKcl+MkBeRBNv9AOXQHQ7s9D2QaxJqjn0mW4tkU+2x5ZPW57xScW6L0D5nAp/S1iC7qTP6v2NgXZfY+1l5CgxEdnYyaePN3mX54pCNz0E4Vym4bT3GkYhk152z+Ob9k3mtQwU/zq7PxXFgmETrc13fZ4liYy17OUgzWtSZJFRgBKmWsj6sYAPW/iUsSGu/v2zFYBwUrOcKHF2j4SBHvBzBuWGCUtYSBw/pcRjtlccRGS5JEDG1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(376002)(136003)(39860400002)(366004)(346002)(451199015)(6512007)(26005)(38100700002)(36756003)(6506007)(86362001)(41300700001)(54906003)(6916009)(4326008)(8676002)(66476007)(66946007)(186003)(2616005)(66556008)(7416002)(2906002)(316002)(8936002)(478600001)(6486002)(5660300002)(4744005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FX5Zo+rzlvbJdoeFBH2Mt5X+yMKUXk2lz3jALJmQxZH4HoeTpIT3x4PWiIs5?=
 =?us-ascii?Q?QTxFy5qjbDU0CGB8kLuwlKQE1U4HhwQlkgZyszM5L7kljLEEV3mw+XkLJ+Hz?=
 =?us-ascii?Q?TkzHfhhz8TBFGjeRUQpNcdq/ueGtgWEfpsGHMV/mc/K1JyprfQ9S8ByAys6/?=
 =?us-ascii?Q?zqeBwceuPBK86W7hpE6bFhusFtBBn1yXf9VxPukaejN4C1+NxALLqyQ0mT1f?=
 =?us-ascii?Q?Hh2ynoj9s14ygPdLQXmvY09cRdZoqdLrGemaGi4efFPmJS1DG2ugtB8Kyb9i?=
 =?us-ascii?Q?2/ByOCNnZ3tSw9RYcVHc8glVHxdIyB8Wrn8gqa8n5C4ER5C4lgIiOToAhT+E?=
 =?us-ascii?Q?lZjfgzYEcEBWG+keq6pXd7ubR04lzhANMsjm6G+cqDwUY3LDbPGIpCXvcISQ?=
 =?us-ascii?Q?oE0an2RIjIK/UadBu8SyEE9YY7nQvHlhY1uQXx9R2fykpFOniFwCg6OqyT9A?=
 =?us-ascii?Q?aKPmQbxEOy9APILT5GQfvYnpeBMcmIcigH46yQ5T/J23+3Z39kwF9Bbot77Y?=
 =?us-ascii?Q?rLTqWuZhI9IcgZYfPC2WhEiQy6fLstZ417+fskMqM+QcBr+AWKQU9oKpASuK?=
 =?us-ascii?Q?c4w+sdINJFg3UwDxmscRH4+785zTKXUmhFzF4fkVSO3Hb5TslGBQUCmPvX0O?=
 =?us-ascii?Q?mypVyAXHdrlKyD742F9FFfMPQKqastIGm93Q/eXxvWMM4RG8M3Yz1J6jaj/D?=
 =?us-ascii?Q?dkipnVQEHOeKXNKV4OYjiRDJaMpCLQy0cXP04TAbNhwvjNbLXHLJoCKgu8IN?=
 =?us-ascii?Q?ZFTr92USnjWpd37p9n2ZJKLVxFFoyRMmLus+3mp5FEnq1l0F+Xw0gBxWo0+4?=
 =?us-ascii?Q?IBwBeB0rniFkjLByypoZQ7BJwXilbmMj7RGa+AgOH19DeCiWsgKK+Lt524oP?=
 =?us-ascii?Q?qGgGb8SBy46pFfpjw9wRyu2XCD6+S1G3/Vad42Wl+xqxJHZTY+1kGDz/BRC0?=
 =?us-ascii?Q?fGlvjFyVmvxAdAURGMRuV5mD4wj5sYgFoWJRquA29gyCXREx2QgNBOMkfEnj?=
 =?us-ascii?Q?FPHDbT1hmuK1S/XlkHcsfEBmyFGlZiQukrt1sS9JJhiLErdOSWqXeDRioiHs?=
 =?us-ascii?Q?DIHbqdSyDqS2svIDglOGkBSedELX+UJHrm2JsXrYdg+sslCOfKh2xY82b10W?=
 =?us-ascii?Q?Qnl+5HXe1VwocVcMCRu9DhfQkizEZ8h5Ptfnhnh0GhUYOdAvxaBW2WoT40+3?=
 =?us-ascii?Q?qGsvM2S31QoisZNB6gFCHl7qhvisB0ynj/Z11cgyRThCfslMurFMOIseHEel?=
 =?us-ascii?Q?UNyeOd4gQmmzTPLWmAdqU/Q6Um7rcAmfVYvhuV4tKg5qLFxFv3hSQnrrKWZV?=
 =?us-ascii?Q?DrewBo6fbY+87W1w7zsH/IfHtokbbgKHoHbCSvkQhn6WKpgnipvZCE3ph0Op?=
 =?us-ascii?Q?W5bXWWi0XRZr+mwJOnpkz0NoMdjK6nHkJcA9opqcsyLiaKz+R/+BWkqmSNsr?=
 =?us-ascii?Q?2PjZ2nHecY7A0TRZNsbdfxHZqzgByolPcqEfdnutdQvzT7dDp9Cr1q1RJi00?=
 =?us-ascii?Q?yw40T0yP7sa5D3hzGM0S8HoJ0haGTDIeBVnvV1q/7zH3lO2SVjr8YUPcbH5e?=
 =?us-ascii?Q?Vi53R+fPIBpevBo4E9R1jqcTf4yPjHE53R3a1bd6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8694662f-8825-48fd-248d-08da9cb29c83
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2022 15:53:37.3749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl7BZoTUSl+eMe14h8lxln3AwmGpA66GoO7BSKC+V53RAhst8obFJhwVQ1+i2pvb
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6809
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 06, 2022 at 08:44:53PM +0800, Lu Baolu wrote:
> Add support for SVA domain allocation and provide an SVA-specific
> iommu_domain_ops. This implementation is based on the existing SVA
> code. Possible cleanup and refactoring are left for incremental
> changes later.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 14 +++++
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 61 +++++++++++++++++++
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   | 15 +++++
>  3 files changed, 90 insertions(+)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
