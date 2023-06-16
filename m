Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0064B7338A6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Jun 2023 21:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343842AbjFPTAT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 16 Jun 2023 15:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbjFPTAO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 16 Jun 2023 15:00:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C23AB3;
        Fri, 16 Jun 2023 11:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RPe/b8OwqDy2tfhA1EWxhAOxpLcoFoilfEbitU3qBjGmu8wl7DQTEzswWc6Zd8kZtS94JMHwD52PbAtQkCCBYyA5NO4Q94DPm6ZPo4MO//frvMQL+aUfqI0UxIVgfv7uJxDPqPR40g4OdM+23EhWCEkHjkf2xcnUf/np0G0PFTWCloNtc5hLBBKtmvtXWjpCavsw1G0qY5tckecHhq6B/06p6vbfp7w8dwXfX5LCDjqqVDmousv3FgLb88tgdmbBUZBEPltlwlvQwuEWMzr1gq7BwP0FrjDZdpdN23eUnLpgzGCcaqGdptUOdeTOXa2oPaGKX8mNnHP0elwKhVf0hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6JqHcoGBkTXzH6ZI8nOj9r3mU5BopKx6N7pQIPhoG9k=;
 b=Foh4hZfMuzCHt/jmrgo1AxvKdRgz+SXweXNn/Orpxe7QlBM0utKo0tvkQ++vh8B+xYznHWoR7Y//wvoeP1UpdKb4OKDbIoMPrP9Egig/sRAsFZBae+RG00OUlsMD0OwHWHcpAnxWU1R9XH4t65pQzzcZDnatwbo1zCUgltoJSu29odmfCDR9cluYih8KLsKuaMhMuSLR3Qu0TR2yFg6zLeLcsDgqhgNXQn4q2uPYEqiPPg4RIEtT/z+d6KlKl2ijzulVWBZphdNi+7DR8cKlbwSvznikdZef9NkpT+0XoWtTsFOTEps5Iew2+A9bcBKWlwgao2huX1iYvR8goMqzEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6JqHcoGBkTXzH6ZI8nOj9r3mU5BopKx6N7pQIPhoG9k=;
 b=UEuRixGPEHrxMwfqHC32ESSOmL/b0+JcUzpv/EWAqaJ5peCJt6TOWR+BLqSLCt6pF1L2w4bXT91jV6lB3OaM+q7AwlQH4hzLxWLGN17xm9N6Wcl7bI2yd5NTWHyiDSQIOl6WQpDhaU1d3F/XtaH+Ue+J0wPzKRnGqvgedCzc2sYu5UcFDv9B9h/JLv4XfOL2JrIi4IkqadcBBy7aZ/8Zjhk3XecRHevucCxpBcZgUtEHziW5KKCI61pKivXXg6CLwLYzcgydctWKSLl/TQsyetm91EZU+2sxMT8OxUVi4sTulE8YzM5UgWZ28vR9HP+dPQ9uYczXfaDktGcdQOeuSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8198.namprd12.prod.outlook.com (2603:10b6:8:f2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 18:59:35 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%7]) with mapi id 15.20.6477.037; Fri, 16 Jun 2023
 18:59:35 +0000
Date:   Fri, 16 Jun 2023 15:59:34 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Alexander Duyck <alexander.duyck@gmail.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Baolu Lu <baolu.lu@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZIyxFpzh3WG+ifws@nvidia.com>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
 <ZIiRK2Dzl2/9Jqle@ziepe.ca>
 <BN9PR11MB52765C24405D2475CF3CBEBE8C58A@BN9PR11MB5276.namprd11.prod.outlook.com>
 <ZIxTmGU4a5dniEY3@nvidia.com>
 <CAKgT0UfmdOOPSD5YvpHnh1A02URn9zxVLbyXJM_67On7xojLcA@mail.gmail.com>
 <520e2be4-726f-c680-c010-a308cdddbae0@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <520e2be4-726f-c680-c010-a308cdddbae0@arm.com>
X-ClientProxiedBy: BLAPR05CA0048.namprd05.prod.outlook.com
 (2603:10b6:208:335::29) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8198:EE_
X-MS-Office365-Filtering-Correlation-Id: b10601ca-f360-4b71-adac-08db6e9bd38f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p9xroGKhyO7U6I6ZMe+rWoIqNfIRaDPcyHPvM/hp52jo3jra4ICjJZwjnpcsay9AFzfkD6k0eT5CQbCx+qwUJA85pEyBM8CCsf2x18DMIYA4jBvylE+whsI3cKdWqIRHvJrdCTGbArIH8pfA6Kn/fzZPMfejwi5AtIC9dxF6e4tpiM0x2uKkg6q1m6i1twJxr2EUxL4+W7+YAQreR3L/U3p448gaYPGbCj7KWHXJC26PyQzx9Nii8unBExkyralMw87JW2F/jkbKcX32t+8oE3PJCm1rguSndTB4xs2b4f+uzh1cYB6ZB6cQuZ5ioR4FdB8iYhjAfcC1kZD8Jb8mP71ppJyjZ3bpiJtPPNIYW5QgBny24DpNuDqa1tQWJJm95E6odzQpU8Ul7b3I6uEsfpcPYiuJT1cWidNKOV4RBViPSseAMFDIQMPA9AbhutFgHU9//abFSPJoNEeq33X/ciBXAR6HMYzPs+dkQlNMIV7a5js2GICE0qIwvXf477HPCR6JAEJ5j087VXEsRGMFymm9akpshgTH0wB5MxIJrX+oenWCrlkCqCW6Vs++VnMEblFDG7z4lpvtY4j8IT92IsBP+sIq63WfpUlioL0QjGM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(376002)(39860400002)(136003)(396003)(366004)(451199021)(5660300002)(54906003)(41300700001)(6486002)(8676002)(8936002)(316002)(6506007)(6512007)(26005)(186003)(86362001)(4326008)(66556008)(6916009)(66476007)(66946007)(478600001)(2906002)(2616005)(36756003)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FGh51jfh5Qva2j4XBN0HfBCDNVDdhLBOLB0IAiciA3NduRDlgM5/LmRfltew?=
 =?us-ascii?Q?Cd3aYax1IZQGG0ww6ClYtObEBiq0lwQqn1YzWNAhCXMJtWiIDAQ+4+L23P/R?=
 =?us-ascii?Q?vKdORQZnWgYUWpWF0fjaJleW16gfGTX9mzZ1E/6S9OVS87Mq36gkz0sdC1zX?=
 =?us-ascii?Q?itO4ThhFEsfom9KfZmpLp/PGVCwvkIw12sD+Zpyia1XmE++G9nEOuDSGEQdA?=
 =?us-ascii?Q?TbhACBicTg6gINyn2q+6CksOKIRJ8VPnK4lyAne6V5CoHhbovwOKJ/sjj1ct?=
 =?us-ascii?Q?KD1rd6HBVkyRTYgtKNx1Ha7pHvAq18RD7nGJS7PXku96abGo9XUp0D9UYvYP?=
 =?us-ascii?Q?Ftaa5tz2CerhuRVhFD1/LekONDkJZd3+STgQhA4Xo0L5jDKKIZ1QwZZWl/VP?=
 =?us-ascii?Q?5FgbI+pLwvbrJLMbwwWUozpWxqogn2ykZEVVojaMpMUwjLJF4zxBVeAlhFH+?=
 =?us-ascii?Q?j75ujSaAkavXBJxixwfsuQQDfXK92kHK5qTs36FycFDlV6BVZJzMZYUZ/DJq?=
 =?us-ascii?Q?MVFXdrRLcbn4Wf0G53mOFYRse6MCwt7sHiCRpl7Lk2Wyt7MjUGwLQgPWlayM?=
 =?us-ascii?Q?thexaY0JyLaK2vgMGJxzzJdcGWSAsF/riiODHthTjfMFGmSpaJ8YWd1Fw6Dy?=
 =?us-ascii?Q?FZ5NzKXzVeDwh0Dr0qSfevuHhLVb6zE8JrMIr/CoL4TXz+7VfEMZPYkyOu/S?=
 =?us-ascii?Q?5nqXPn6xeGajPweho/F6jnqltpv/8NVXgzXGRPgi4RrGeS7yxlUyieYJB+Md?=
 =?us-ascii?Q?t6DPfqZXhhJWSxBhQ19PXKh+kK9gi1HAaZJY5+WUe079dRNm5Asvjd0q0FT2?=
 =?us-ascii?Q?AztRKAE3iiBw8LcdrsVMW1ReBH13Ppm0/SuDT0gOml40CdA4li1n/2LJ3BT/?=
 =?us-ascii?Q?398LYrfi/LL1q7kIu1gp81CAnuabW9GzfU4QiwVM9WpCv5oqA1oDQEOIo8Ta?=
 =?us-ascii?Q?p4xcoW83P4yNatCjCBPMjX9uX2NefhJ08YbpMq9ypmsdZFyam8KsVQ+ILq+5?=
 =?us-ascii?Q?2OMUjNvkOYCVrJFNpc0BNsxK04SNuzlCqNMjBKjg4GonEC5zMc41W4ypPHNc?=
 =?us-ascii?Q?V5Jlde1X66Xa4Xh2D+4VljoGs9vyDGelLa8iNTeD1wgn3+m/8e4HjZZSt95p?=
 =?us-ascii?Q?XR2PHJhX9gnoBvprqwJslrZio3RyrPcR1HZ2KLO8nkPne3/Mj+ywUtROyD/j?=
 =?us-ascii?Q?mgot9QSiQnpd+gSmPOpdllRZl53t8+OU1RA3ipS6FrZbb7vYmL+lLkOBAyau?=
 =?us-ascii?Q?wqBDGx/g2P9p+Zd1XLTWFchyPWJt01KV2zW8qZmb/3H2nO3JglP335kaLscq?=
 =?us-ascii?Q?FHgdUJ2cSwq8ZDtqaqRoGPoH58i/ja4XhGe9XK9lhNt5vhqGYrpyT+P4BRBT?=
 =?us-ascii?Q?f0k7thGPt81g6uxiN027QiA7Blg8yhPXAxuk53jBc0zRrzWVmkZaICO4ALjN?=
 =?us-ascii?Q?KyjeSqlCEn1RXvh7Dj0S2toer5G/XUJsGoPc2pqTiQTzPXCXwrpGkUYlIOyn?=
 =?us-ascii?Q?zfd//Scod/ULyX8fOPQKITWN/4OxbOUlHiMPoaijGPAm0FxU1pwi+QcgoR3Z?=
 =?us-ascii?Q?BzmAjC7Xap9QbFacoc8U7O8aO/4ytc4Wl5Ad/HMy?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b10601ca-f360-4b71-adac-08db6e9bd38f
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2023 18:59:35.2582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +hALvXLeXYicB90u54D4UrsfGo2KZXEM0JuHaJBfbL/jse/3Kl6K4F/5oR1sHo5m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8198
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

On Fri, Jun 16, 2023 at 05:34:53PM +0100, Robin Murphy wrote:
> 
> If the system has working ACS configured correctly, then this issue should
> be moot;

Yes

> if it doesn't, then a VFIO user is going to get a whole group of
> peer devices if they're getting anything at all, so it doesn't seem entirely
> unreasonable to leave it up to them to check that all those devices'
> resources play well with their expected memory map. 

I think the kernel should be helping here.. 'go figure it out from
lspci' is a very convoluted and obscure uAPI, and I don't see things
like DPDK actually doing that.

IMHO the uAPI expectation is that the kernel informs userspace what
the usable IOVA is, if bridge windows and lack of ACS are rendering
address space unusable then VFIO/iommufd should return it as excluded
as well.

If we are going to do that then all UNAMANGED domain users should
follow the same logic.

We probably have avoided bug reports because of how rare it would be
to see a switch and an UNMANAGED domain using scenario together -
especially with ACS turned off.

So it is really narrow niche.. Obscure enough I'm not going to make
patches :)

Jason
