Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA9072E7AD
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jun 2023 17:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjFMPy2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Jun 2023 11:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238838AbjFMPyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Jun 2023 11:54:25 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2087.outbound.protection.outlook.com [40.107.244.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780A81AD;
        Tue, 13 Jun 2023 08:54:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k+XBwDsEoz1lZ8kDPjqlY/bBj1P0A+Ff+HEgD9i1kNX1QbE5AOevGJKJh9Sfj35X8FALtbd6KyMQQDEUGauxvl1gV19hRtNDSA/J7ppmszSF53SOPVkhnwBYOlKXOA5tqurna9xGRw030LSAhGRyDkWegOUiKYMUZHxLm5mPxofWc6AdGjuKb7ifMM6dfkJ0ug+9S8150kMi8/xg9OH7qmCN/hturc6PdmCeXvetyHrKBViqDD8kZEd+F2oohN23ExJhbE0NjpJ6jsW/OeoMTcNEm/GSHH1F//8M6wQ2l3Uyaek2GpNaD7WulG+h2BJ3K137ZlM4TWvrZ5/K8sbBOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OWB/tcG20xWtegMtNhoWwlUd3Anrl7Na5T1fzvM9WzI=;
 b=Cjf2oXOaI2M44U2aAe4HgmpSxH9JFHLMrMaudqM+uX0X3W9edrDvXQ9miM/lFXuy29WhkjWY+iXBy356+ASjHFB9s/lTQ55//i0kaJfUPr5S94FQprQsaohOOYaaStHO+CfJSPQDHGmoEna/o9oiPZKnKAYRTlfoz3xjdSoPosDUGVqylYoOBGxFw8ZSmg0IGEuGSF23QDxhStzip9UxivFoIPAmpPx18xY3pNjvf8N1tmKYzBqUwNBGOVi6fMazKpWaSMq6iw2t9F7xgyTALCzHwddkxB9nQJtxLpAts14NHr7I1K6v/aZHcPeRV9qjsFs4Q6D5IwibREH6UPdtSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OWB/tcG20xWtegMtNhoWwlUd3Anrl7Na5T1fzvM9WzI=;
 b=K7JbEIq1FXiYhDbU+je4+/FNNQQpGb+Ww/qzMvAlMhPx0o6YOs9UovcNETW+UzEnxXE6hCypgC95/qZGpjzOrejqYbjzklTiQauf2bPFilJozMut25n6dav/x0YauwzG6ScAunt4o8mpPlmNsd5w/XvmBRNneLf1SrBjFj3Xai6ZOYn99tCFF+lokhZj5LsHS+jLnLu3njXRTmL86RT6xpShwP9+ObesWDAjC7jElFqHjq7mzkfhilqHgMPkYZ1wwrZcIZSore6HJEk3iX+7z7bUo/VkgRJF42YRmR2NGCW4nx9BCkDyDLKkX8BdZ43moaH398OWLB7LBT5ChhQ4Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.44; Tue, 13 Jun
 2023 15:54:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::f7a7:a561:87e9:5fab%6]) with mapi id 15.20.6455.030; Tue, 13 Jun 2023
 15:54:21 +0000
Date:   Tue, 13 Jun 2023 12:54:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Baolu Lu <baolu.lu@linux.intel.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, iommu@lists.linux.dev
Subject: Re: Question about reserved_regions w/ Intel IOMMU
Message-ID: <ZIiRK2Dzl2/9Jqle@ziepe.ca>
References: <CAKgT0UezciLjHacOx372+v8MZkDf22D5Thn82n-07xxKy_0FTQ@mail.gmail.com>
 <CAKgT0UfMeVOz6AOqSvVvzpsedGDiXCNQrjM+4KDv7qJJ1orpsw@mail.gmail.com>
 <a1cff65b-b390-3872-25b5-dd6bbfb3524c@linux.intel.com>
 <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b24a6c7b-27fc-41c0-5c82-15696b4a7dc1@arm.com>
X-ClientProxiedBy: BL1PR13CA0184.namprd13.prod.outlook.com
 (2603:10b6:208:2be::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8eba0d27-9f4e-4afc-550c-08db6c2673b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pJs7fct5kqKFdd522YCTWdYxeyu8vcl6rdBT3eHdaoK3oFpL0LfO9ZSkeOsUnh6fh74poIOT6Hx5tKcgog0e1Te0VJIemglr/TsMWy+Rh0WLomwWcxHXrC5pf0DnJO5ySEYdjrD0HAnMcvRuaUsIfY98k62h9ogFBOmm+Ok9miBzlAibS8GX4oRr5FAxO/0HP3WDvTUj1XoVLgceAHwkV922ogeYOLaFxsQY+0296Iy/2QKavFfoQrgU6EAPFGOSPne1MxqU6elGcfpgFn9nWwHQFdcRi/en7EYrtBpB++JsLezCPLj5LOQDnzIcW1AW+X2dXqoW3VjGbt13E9HuEX6FGjej7fASdJNUMy5v1bWHgBHmt4nnpR2G1Sd4/cnuL2zc0U2v0NIkY7zCtXRSxVqkRq68MhxNmvC9BmYCaTUuNXxdPAOjdtNXfPchsHknzJDLVXH7iH+Sp2VgqwIJ/g6tYsWpGbdi6ZAJu1wkzD8mS7sOwLAExWmzuAX5htrwqP/m6YsaAcnsXPOYaxe6wRXizY8gaxNgOdgoDWXqxaDT+klrIlDWiw8VlLBtG6q2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(136003)(376002)(346002)(451199021)(38100700002)(478600001)(54906003)(5660300002)(41300700001)(66946007)(66556008)(4326008)(6916009)(66476007)(8676002)(316002)(8936002)(186003)(83380400001)(6486002)(6506007)(26005)(9686003)(6512007)(86362001)(36756003)(2906002)(66899021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xFyyQBKNLSsV59It5gzIYK+VS7ISJoLc5nRVdboTFTXIL1OyqdcPDvmPUFzV?=
 =?us-ascii?Q?MuqDWkrc8hDd3h9IvN0xr4D0VzwIcpOXFmFd3kG3oDoIsQB0eCU0pDTZ2fTO?=
 =?us-ascii?Q?zqqgP/KL30Tc6HzJpdoWGzx7ls2hKgPtxvq1P/qZPrfSNFu+8/wJDHeYvuAc?=
 =?us-ascii?Q?IE3CAbcLHc88tCtfh3cyJlTLOG9OiUWDnFpIQ9TNVngMfuA86t5HH5jTE5J4?=
 =?us-ascii?Q?iLaej/CQzzLcCcCrP7fLbHOdoBMJSJkH+Mh1ArHYVjYMtKS5vMrpCdLnB5Ce?=
 =?us-ascii?Q?u/4SsW0JMvcGpEpX1Kl7l4BStMXccp2wqZK3SE8F7mF2y8JrIIhfOmgvGtpt?=
 =?us-ascii?Q?efeA8yH4gFLf9VDQqXwGCI2iDiZ5cuQOgJf2MU0mrtINZ7r9TGglDbPy4ZP5?=
 =?us-ascii?Q?c+n6GNIMFSmG/wz0rzJMXbIEb5MTx2QY5sokhloIfw7ireuyQHu5xZVixK0b?=
 =?us-ascii?Q?9KWi8XidSZ+jz1oYeMU/V8gPspiwX183IanV4Q8kkIBnKg0YzSMk3yg3blzk?=
 =?us-ascii?Q?qLqP6/ZsB7UkBkyGtZnUCQMrta0ZUgq2qTWpvgWhFTfvTiYq7gGW3ojB1J3m?=
 =?us-ascii?Q?2Qp2Mx20+JdGcHO/uRvGAiBdxKvWMvXdCg2NWK72Sf4JpH2RW/kRyl4IFS/6?=
 =?us-ascii?Q?keBhJZYis8y/ig4SMYYEMpqZfFu63DmBoMnpwXHoU4sO1QeOqeISc5ZE4qcb?=
 =?us-ascii?Q?sUKMFPe4zusTo2Y3TlDUCRLzyKjJl7+OPuxVWI9YK4/AxUh83uF1uIzPqgYf?=
 =?us-ascii?Q?gqsPNIyinUrfgBbbQ0PZC2DrMxkGL6RKcbu6hJs1Ig3xoLvHy9y/Iu2o2Rm4?=
 =?us-ascii?Q?WMA9KcumHUkMrNlFIbiCEKnS1VEARGJsKPJeU8baHTTuZZSmzOG1l8nNZDvE?=
 =?us-ascii?Q?EHcNvbSBeUgGtFGOLRKW7Ug8MDml07btgRwWgbct0IyF86onLpQ6OlI+Rcw/?=
 =?us-ascii?Q?rzk9iOEFeUyNG62ACvL8UR638521adWHegm4WesLJAWdDZ2e+4aTDu/DelwT?=
 =?us-ascii?Q?yTfCNd/5m2H6nf/gwUp6wRP0/DdhasoGM54/01qTdbgqGefZinAqSkczBYut?=
 =?us-ascii?Q?U0hax9VBWtFoTZu9wcqphT/ktjnH28pVGdcBVxHz0PgzPw1j5/YKJGuaPzp2?=
 =?us-ascii?Q?JFjQO04LysyRSlCMoCnCfAsdZP7B5G6MXIWe3Pje9Nf3o3t8/lad1jqr+SmR?=
 =?us-ascii?Q?3OXQdIPIzqfKpWDCdmEwamW3ttuzwsCXMgu54aTdgrxkFeP651xaNo4ihPjS?=
 =?us-ascii?Q?FYbqsCBV9Ux2TyAMy2scWracfqcAVQQYi455U6sPRTEj4hQT/T29+MtQvXV+?=
 =?us-ascii?Q?s51qGWLEHOyLtcBwia/3GnLAXLaD0tQ6BFGgFwEM8MzJRVZsfCU0BMXytk+U?=
 =?us-ascii?Q?tO9m/gbMzPxBKukcdYa7MvaeD1lG8Bp9IEl0AkjwdOpgpK8mMI8b6mQVoIAu?=
 =?us-ascii?Q?9n4KacMj9W3TmmD6Y1d82t9xYSpzjnbdqXmIBn35VH2e5yRLumokfH8HnfHH?=
 =?us-ascii?Q?CW/Ca03+lQlofXmcyihf5btYjpStPaCWufmh+wwBUj+xiB5FX+mwOswtNN+q?=
 =?us-ascii?Q?e5xbZ3AMaRstiKpwn1aahUwVcd5/E7XVjW/CfRJ6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8eba0d27-9f4e-4afc-550c-08db6c2673b0
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2023 15:54:21.3393
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9pHomoj0VDrqQOJS0OSkr86yUjOt/WAIUGQfgLNxllq18IrIVfrGfHJQQDqHrRnE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628
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

On Thu, Jun 08, 2023 at 04:28:24PM +0100, Robin Murphy wrote:

> > The iova_reserve_pci_windows() you've seen is for kernel DMA interfaces
> > which is not related to peer-to-peer accesses.
> 
> Right, in general the IOMMU driver cannot be held responsible for whatever
> might happen upstream of the IOMMU input. 

The driver yes, but..

> The DMA layer carves PCI windows out of its IOVA space
> unconditionally because we know that they *might* be problematic,
> and we don't have any specific constraints on our IOVA layout so
> it's no big deal to just sacrifice some space for simplicity.

This is a problem for everything using UNMANAGED domains. If the iommu
API user picks an IOVA it should be able to expect it to work. If the
intereconnect fails to allow it to work then this has to be discovered
otherwise UNAMANGED domains are not usable at all.

Eg vfio and iommufd are also in trouble on these configurations.

We shouldn't expect every iommu user to fix this entirely on their
own.

> We don't want to have to go digging any further into bus-specific
> code to reason about whether the right ACS capabilities are present
> and enabled everywhere to prevent direct P2P or not. Other use-cases
> may have different requirements, though, so it's up to them what
> they want to do.

I agree the dma-iommu stuff doesn't have to be as precise as other
places might want (but also wouldn't be harmed by being more precise)

But I can't think of any place that can just ignore this and still be
correct..

So, I think it make sense that the iommu driver not be involved, but
IMHO the core code should have APIs to report IOVA that doesn't work
and every user of UNMANAGED domains needs to check it.

IOW it should probably come out of the existing reserved regions
interface.

Jason
