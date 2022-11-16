Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB5562C7B7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 19:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233773AbiKPSgu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 13:36:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239223AbiKPSgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 13:36:48 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D31F59FCB;
        Wed, 16 Nov 2022 10:36:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XccbmKnrKbDQsxIRTJ6YF/sm3nzB5ms0rZKBos0MPK+ntgcmznUshavF4h6iwAiTtrIBUczYehRalFr+bUs/GqAZP3eEXp3oHzb/wcxGADVxsr9ZzIKhOITXD/Vf7lgTk5fRYpMZU6L0UvFh21uTVNo4lwN33tSocsoQhau79329gnUQO/CBLOhqMW50miLz0D1EHYSqDwt7+Onvg30ZBpXr2HPi2iEFP/K7R9hjcskC1L8X7tkcBWCGBJ1so2s3le0GkWwYRj3XanuL+6nCZyLwD15pVI8oc+Nsep89wbx5JIkxlK4mAPqvylOgbBpbIjAIkyFBlkZEsMKfkPR+Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8PO1VJb1+P2ftAS9ziT0frGzvzAjGerzq9nnXQndMXo=;
 b=mpgx3JjRZCvkOvebaqCb/UoKmfq1CtrqtrPy63HuSssaWH/y7jTgy0tbLAc3tlL+5bqwjiYq7qw9mVroejInXleTIZ5/JYLb1A8XeVnp+awEy2o+vj/tvxAZ0cCuHg8UX8ZtbkgYIEpzLj7oWe1jM9ZQN75G97v0AYW5q/wErBGdUY79xrGCf8LM+PEJ6dvPjV4cvugPimPQBerDsUzWCrPsunO6wTO/VtiyuQhLUzlExgOZoSamPJtS+wxwTwRfbEDUZ+HnBifaqCgKFkwq3haHE55DiiQ2HxllssXqZQbhdHOo1K6KgbrHEICEjJ4s5NohOI8yaTSBKMoDWBa65Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8PO1VJb1+P2ftAS9ziT0frGzvzAjGerzq9nnXQndMXo=;
 b=ETamoGuUTguQzIxZwbamRkJRnoblXPcdLebaICS5md/BkSQdGAYkoaLhV+4h+HX7Fisoa+yfGDycLS92z13BlRkx1Y0BEuiV3upwiX4empAqOBNpgIlJ4wZ92OQuts+B04NgOheprgucKVU4gfeBKkVe4c7pyiWz/jlFvYku1qp3HnIDsjjkGG6dl0neZ9JeViUaeHqGYFqsaMkTImclUP7wldjUZY9Ny+Crb85WGdvYIz+goniWe5kFtFUa5aNRCxpN+0nDhLJnpLohuOcC8eyPOWZadeMOkh6qlI9AUybUc0GwQOE9Ta6HqCRyxW90+bgyG6CeH5BkdCXfFeZQqQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by MW4PR12MB7431.namprd12.prod.outlook.com (2603:10b6:303:225::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Wed, 16 Nov
 2022 18:36:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f8b0:df13:5f8d:12a%7]) with mapi id 15.20.5813.017; Wed, 16 Nov 2022
 18:36:44 +0000
Date:   Wed, 16 Nov 2022 14:36:41 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ashok Raj <ashok.raj@intel.com>, Jon Mason <jdmason@kudzu.us>,
        Allen Hubbe <allenbh@gmail.com>,
        "Ahmed S. Darwish" <darwi@linutronix.de>,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: Re: [patch 10/20] genirq/msi: Rename msi_add_msi_desc() to
 msi_insert_msi_desc()
Message-ID: <Y3UtuaThvDVsKNZt@nvidia.com>
References: <20221111131813.914374272@linutronix.de>
 <20221111132706.612934166@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111132706.612934166@linutronix.de>
X-ClientProxiedBy: SJ0PR05CA0120.namprd05.prod.outlook.com
 (2603:10b6:a03:334::35) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|MW4PR12MB7431:EE_
X-MS-Office365-Filtering-Correlation-Id: 6321ef07-ff90-4fb4-6916-08dac80182c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iRYXso7LHYp7RXMKCTEO1op9FjTHdAW5zSZadA/oFQUszGyk64uFGMdOd5hVsGTIzlUV/TipB8ba2UvacoBHHvmxl4va6ajX8YdD3N47kvwQ17G6wDwW8+0S04y1yv4TJTiv6TVx1G59BAer9s0cXZFpTC8KdGh/Y1HFukfSOCJGSGnaWt/k7v9NGtasLUYSEg0c449OjKoOlaTd0mdGuqz3qcMX6liUTNZIYLjKkRy5P1hnZ9SXA5j4Xwto9IcPR34B43q4jP7uqSt3/1TlaHaApYji9594s54indYKkLt+vXjf1LaUeMnu3YWAAX2iW1Klq3FS+IFSZQSolHt0R9fmzq06qqBaskdXmTMl4GDfyZjcsjQy9jGwCoQD8zWyUM5ksFnTYluiZS/5yVi2lulDVKuACujr/gBRlZ4qyTbeeF2jul3ucsbNj/4dFZnFitP91qFLTJm8SNEDa8hvQlRXa/dKtC0AO8A98k2MLVzeVOwGVFsp3DHP4Nb6MwpQsDnerQyl1P19AoKfNbM2cfIlJbnRAW21AUPT0iuL/5xlpywjDy2K8znfgQ963iSYvWHEJIB41OSGTttfhfnC6SZUNTH1a5iHBhu4gTQk0Ar7HgyUSUJ46tlcsEmUHqCclQtKX27GHCs8AIlIWBlkvF+3mBFb7V9Pge7nwiPHRHojfllkCgOD0mLosi4kJaSBTZ0bzeIyRzMvyecAzF6ngA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(39860400002)(366004)(376002)(451199015)(2906002)(36756003)(4326008)(66946007)(8936002)(4744005)(5660300002)(7416002)(38100700002)(8676002)(83380400001)(6506007)(54906003)(6916009)(66556008)(41300700001)(66476007)(316002)(86362001)(478600001)(6666004)(186003)(6486002)(26005)(6512007)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iuRnwVByM3m9IzKB/3mM7hWkrlYOGxq/MEHrIYMJGAa0nQvth+WPjQjy6due?=
 =?us-ascii?Q?nceLXjioCptmXHvYmDKq0OpWtRZL0mmg9rsVWI4o7gfyRNUL188wOudBLVdb?=
 =?us-ascii?Q?KgiDyGA+PJqetVRc4tEL24oRmXY0iEO4xdTao2fHuoefOg4QrQiLlOTkJ+5n?=
 =?us-ascii?Q?13j7prbzsRvP7X39CxLJTB2CkPj7aSV/MC4DoUM3ArCuaJKA7EOdQHFnJcgE?=
 =?us-ascii?Q?gus9+86GRlLce9r+AgiWY9ZDYhetqrDfBGFayOXdXCJNfvq2IJt8iyooGCYb?=
 =?us-ascii?Q?YvYic5FbS16RdUMgOYUnFPWyTo6cLPyHHXEIWCgqGEOD55uIswCHpA8oNcyZ?=
 =?us-ascii?Q?D8NW/maybDrZKh9jzCj4Kj/PnCf7eG8lgRc7gs7LlvnTovwFM9vSlDVKK8G5?=
 =?us-ascii?Q?qUQ32wn33Lr5cIFJuNF+i2rDiSM0StLKUXBaSBoYn1WbJAYzP7lnWWsUAqNL?=
 =?us-ascii?Q?qIW1IzJoTmBBlgr5RJjGzoCT1kFiGP23r9V1NxkRK82RqiZiLcXP52/bKp3a?=
 =?us-ascii?Q?DUlwh52tP5PVuJ0MNyzI2GdrZ51JXCNWZFjXYOFFQyzktW9JiqjvNMCyCgQ4?=
 =?us-ascii?Q?w7EH0F5Qk+FhyJRKVnTk2+CshZaNbD7Excsm4IAFCDAXhZGaNh27Q4/YW+NE?=
 =?us-ascii?Q?HZ/XMCZZfttaQP6gzc+Z/MoMQ/X+CzS94B57NS0T4Z5mNF6FPHTLmy6zoMLV?=
 =?us-ascii?Q?2y5b3f8zCXJIWuvVgBbE4jv/oq38hH0xnQ8+/ByABJipXPtFSn6cPd40UMNA?=
 =?us-ascii?Q?xLz7s58vMpXK3zin1zYa/JvbdCMysUUsnRq8uDom5cV8ETafURoIWQC4Fx5H?=
 =?us-ascii?Q?6W+FoPZSYxpEXG1CW7/7ICcbiQK/9XjMJR1MD7imtOpVtGiDE4Hh+8oeBVHk?=
 =?us-ascii?Q?Oosl2leUQj4VCMY972x7g5yJ1iguNkDSExR5zG/res5YwkurvE0dB2dGLc/i?=
 =?us-ascii?Q?ntCWHfiuwj+Var3SmLxBoW3opdPdoKcMAgATWfkYVQ0J9RK8WNvesYjIZ/Gf?=
 =?us-ascii?Q?KayTBm3PrWEG17HxUFKZ26dh7HwBs9eQIjp92+YWWbQv83UtPfZv0/D7RkE2?=
 =?us-ascii?Q?5GFq4TL1E/Cpw/7HnOepM0EbTbnHRsSBgVaq9e5DGY0pJE8vWgb4MlpJWvFk?=
 =?us-ascii?Q?wOjqc7Lb0KeQJI8X7dVf74kn//dtbrgdWRmtB5JpjHEbm51mSuev28lhzLPO?=
 =?us-ascii?Q?P/vs2feHVNtGDAiAXVbpbqkp7ebl+k8N35tgEMyNQOvuF+X3y+tvjn5eVGI8?=
 =?us-ascii?Q?51+kCGYw3ILp0l0+UhVNaba6SCkbB4+lPg54IIt/ppi4Roihf85ZoY1cVpbK?=
 =?us-ascii?Q?Qc2og/NIrpAPoej0LlnN8XUJq77G/Zb+xVjRmoecuCyV7fUxJmKN3RlPln/0?=
 =?us-ascii?Q?+xsN9+VwniRLGmxL6Q4EzpW0dAMZIwV5ClHvyIo7IGyzUSfxsJcJDnYHdmQi?=
 =?us-ascii?Q?1pgc7J2w9bGO6LBR8cnODvrxDVpcAColAS1qPKSvzsIzMhhEjZJHZ3Ak5ExL?=
 =?us-ascii?Q?FBb1mk6PL36lsHw/X4WujAmyK03xb9aSHNFGaO2uroqE6ycfsWGt5DFWM4wJ?=
 =?us-ascii?Q?HEcFCxLtKsRoL9mWEjaqSQl2y186QcnpPivABjfq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6321ef07-ff90-4fb4-6916-08dac80182c0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Nov 2022 18:36:44.2235
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AX3lWhEkvaov3mHyF0blbILf2vt7yfxVQePXT4nbZsCrKcwSHFOmHxuiSwtLYBaw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7431
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 11, 2022 at 02:56:53PM +0100, Thomas Gleixner wrote:
> This reflects the functionality better. No functional change.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>  drivers/pci/msi/msi.c            |    4 ++--
>  drivers/soc/ti/ti_sci_inta_msi.c |    4 ++--
>  include/linux/msi.h              |    2 +-
>  kernel/irq/msi.c                 |    6 ++++--
>  4 files changed, 9 insertions(+), 7 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
