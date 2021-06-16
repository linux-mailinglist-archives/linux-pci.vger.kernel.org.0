Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8F23AA289
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 19:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhFPRi4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 13:38:56 -0400
Received: from mail-bn8nam11on2042.outbound.protection.outlook.com ([40.107.236.42]:32469
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230291AbhFPRiz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 13:38:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HxvHJSrDqTWclE1uAd/wEsApAk2jUQvRAKGu6PM8vwN7AGLlOHs3HJBrEK74S2KDv9ueLDjv2fr8bwEor2RfyOr6NlOxVtH2H4x5DEkKiu+nq534XTjlYd8ZyGJlM6E4MlcF4bai6JL4g7LxeAwzmsAECkYkTONiA/CSTwHyrC0LgZlcVZpyViloExSYSpTxenWTkcIuCT/q3zefdUdOFXdxLqW0S2YR7/4XYuLO0h7UZJK4PKtHjhKhvyjVC7i1JoKxBkbf7xMJ/xZdJ4wpMoltMR5d1MFVDynQhaE+OnjfTqT7ELo/vZhU4gTY8hGVlUWZ0KrNxBFbK8XdEEKWkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf8eJCeQyjzaexanhCnKCBB16CvV7LThO4GQHZuM8mE=;
 b=G/jcCrZt0SYQc/gHD8GUDVx9IGaRzIre/qdA4MVuisqDbewPpRWAIyuxzryF2Tkfe+tj7EEjiT/ziTmYK800tabe93FooAij9khy8j/Bn4DbZh/H3LB36w1gWM3P3f0PNJvzAjdg9gNtvVs102S2WzqeH2GgWdoSqZsYGmx4CpC2KJXKPW0PxNl1DJCl/NEGmCuHiuzIf52l5J2fvCNgzRHHU5vIWXTm1pMcUE6viuTXfR57zkTVaG/PfKc7hsrjka8qf7unpiF28epIV7xxs3lhSlXwf7LAD9u8ktgXl8NjaGwS4i9J4NcMPSqLmIpwBn0NEhfCb60+mVYMSJadJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vf8eJCeQyjzaexanhCnKCBB16CvV7LThO4GQHZuM8mE=;
 b=Ka/JvKztD6ZxU1q9Tpvxa8l8TRkw9ltvSyORQKdWdDQheOSK9ajEs0f3UWeI8S/CxcpUtWWEvOTww1hwwDX+rjn8MS8DwdeflgGeFguZhz+kfe402+QX/3yfu0oHsUaE1zAZBznVNErX0cBQOPOyA+VZKBhOR7MAcvLVGWXI8Oa01pGJ/3/MgQGTSgExdbmLxyLgNmcoLCsx3NX0v7CgQ2UbC7btwmUWsqQD3nFDe6NcVfj30nQ/pNGLtOlkjTgP/3MgjjAiG0X53H46zna4mgdnyYFBT+LxtljD/RXeztl/5MivTHNRrwiKXsYWmpN84av/3S9ffMAqGvMLte3ARQ==
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB5520.namprd12.prod.outlook.com (2603:10b6:5:208::9) by
 DM8PR12MB5446.namprd12.prod.outlook.com (2603:10b6:8:3c::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4242.15; Wed, 16 Jun 2021 17:36:48 +0000
Received: from DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::18b7:5b87:86c1:afdb]) by DM6PR12MB5520.namprd12.prod.outlook.com
 ([fe80::18b7:5b87:86c1:afdb%8]) with mapi id 15.20.4242.019; Wed, 16 Jun 2021
 17:36:48 +0000
Date:   Wed, 16 Jun 2021 14:36:46 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Will Deacon <will@kernel.org>, Vikram Sethi <vsethi@nvidia.com>,
        vidyas@nvidia.com, treding@nvidia.com,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>, mark.rutland@arm.com,
        linux-pci@vger.kernel.org, sudeep.holla@arm.com,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        bhelgaas@google.com, linux-arm-kernel@lists.infradead.org,
        ebrower@nvidia.com, jcm@redhat.com, Grant.Likely@arm.com
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210616173646.GA1840163@nvidia.com>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
 <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR02CA0032.namprd02.prod.outlook.com
 (2603:10b6:207:3c::45) To DM6PR12MB5520.namprd12.prod.outlook.com
 (2603:10b6:5:208::9)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR02CA0032.namprd02.prod.outlook.com (2603:10b6:207:3c::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4219.20 via Frontend Transport; Wed, 16 Jun 2021 17:36:47 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1ltZT4-007j68-Lh; Wed, 16 Jun 2021 14:36:46 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 44efcb88-9f6c-47e5-0ae5-08d930ed5135
X-MS-TrafficTypeDiagnostic: DM8PR12MB5446:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM8PR12MB5446D1D4BA09AC0E7C03F7A5C20F9@DM8PR12MB5446.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A/R5zPfIY8FoyD/UffJBxnnDHPM3QW+/RDrKgSJAVqqYYusUy4OvRLjOs1C+7Fh/H6oyqk9R29qZYmWCNlinbvPC950F3ULsC6u0vgLXZzdY+KBTbSRfndRqF1yK52NN/d3zc8+JtVH9ghnXup5YeR/y7JJN2jEwNgVKKcU9zok/iZ9VARfJakdp1cNbjNxuqCckX0w8pad+rbqdCmCYjsbAL1pW87oXShF4z/uo+7XmFtNhkriYYN6MWX0tLdvmvQW0xr+xWXEP3w0GNmmbSoYIxNTj0Uzt3okRcb/dzW3slSNA1+hKAnbsP7M9h2+/QuWxc/yPsoj2NHZJQnsS5gvt66voyVafdR8gBzi99ti5Y0ewU/gkmhJJ2PSxcEvV8rblulPErAn5z8dm1454O3W+fj9MowAnng+pZ0JvMVFHbiPcIuYRL9tlidW6PnXEy7ucI9ID/eHXxEqGuSJXVASko7hTXdzTl739tTB5MrtgU6AvsCG70u1lcKxi5Tr2vaLxqqUTVhTE+Q+4OYIwq1q/p4wVqjPFFItPjQ5OixqrOBEjVbTcuHfHYtq5oHVG1J0LYfcAhX+xQhFJuHKpz91M9rukPLbIGyCdwo8qZRg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5520.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39860400002)(376002)(346002)(396003)(136003)(1076003)(86362001)(4326008)(2616005)(316002)(33656002)(6916009)(54906003)(5660300002)(426003)(478600001)(186003)(2906002)(36756003)(38100700002)(9746002)(66556008)(7416002)(66476007)(26005)(66946007)(9786002)(8936002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mlfCfSHnykJwo4Jt/akn/EIGF25dCCJf1DU/Yv3sYEQeWPA6nz0CxauEo7F6?=
 =?us-ascii?Q?c1gxti5qy1FMRVYPpw6/l9tQaqOJCzd8C2RPCRu5m4Jxnmy2HIx0tCckXey2?=
 =?us-ascii?Q?OkK8J4QLCulMAz0ShxlmouOkbOnEc9MuA0z0aquVvfX1LJZsrrrv/7keR/+T?=
 =?us-ascii?Q?AuE6mbUUbQMetf6OlIcWD0nb/VDtFlbolwBtax45zuappxXMibVJC8Vd8YxR?=
 =?us-ascii?Q?YnBB4TMWuircasTnkM4wlixrEDolYAWLHvdRk6fh70ZS5ERHH3ZMdpYvvfg5?=
 =?us-ascii?Q?1xeRfWWDxorgnX85xcImPwcfd756r8X78NdarqPKrfrhHZ6wsA3mRXlfUj8/?=
 =?us-ascii?Q?rPaZXTmaApy6VSs+fmrFz2MdiZidBp0iyCFmJwu0kosgpg8vKfJFVVjMSefu?=
 =?us-ascii?Q?jwjAxaJ77z1+56+rxo0IK8be/xnrC7Ht6NOBwyen+N2YzAtROcyx5dv6k5v6?=
 =?us-ascii?Q?p2P+AE/85Lvq3sL8wJ3hM2vdSoatLKyKRaDQI3XcbRHTKq7ynVz3pryJueGJ?=
 =?us-ascii?Q?fBy2qWb5jIB8AlhbKqMnzTh5tfwOQz9qnTHPSUpN/FKeGXNYdXrRLbD0CMrb?=
 =?us-ascii?Q?GrtEJ7b1cCt1B5Gfi3RqawoZTUEvftlFH80Et2nECik9TTXiyfeqUsbOGigx?=
 =?us-ascii?Q?4iAp2Vz9v9NglcTCBk2zW5/LmWS/2L+Fpds7RKj1IutNiitBTzD5E9JZXZnF?=
 =?us-ascii?Q?OIoxP+x2zMGskF/rIDb5IKYGm7B188PaCsi9TYk+vtDfb+neYGSY00U6g+vR?=
 =?us-ascii?Q?ZcJOzZ6xQWLc4puq49KtEI/FwEtV0KeKW8qofTT9lauPyx5SMhxoJbDMVi9I?=
 =?us-ascii?Q?gn0LQnWs0cGx8yUSDiGixRy8LUeokUg91dpaW6OCWJY3Aut6rmW93HNRgHMy?=
 =?us-ascii?Q?rX2nivtsid9WL7mTp4+/D33JKMp8/kKAEde7BTJpNpaLFlnidNz15KgHuuJO?=
 =?us-ascii?Q?T+9VQJrm6deUuOWXl5AC0FPr5qjb493D2Fo1wELFAG+LaU+RJFKDxul73E1n?=
 =?us-ascii?Q?CelHcG5j10/h7N+26Su0aVI48YAAPBCFU6COhXiiyhSjynF46ry1Q8ZY0LPW?=
 =?us-ascii?Q?6qXQwbyjtiBq5u/fsLD/vih5sR/d5cn2lkuVeR0GAUOUcoAIu5BKdZgbATod?=
 =?us-ascii?Q?qQqlhW4iGc4iyoszhpm9h3x08Qj9qLdCCYwXGNESd7SWLkZ6Ub0Jz7AFO+xK?=
 =?us-ascii?Q?UESoRez8S6beiQ8zwwJl+7Z+LFol500G7SEnsQM3xLpy/wtmqAUIMsk3gbR4?=
 =?us-ascii?Q?LSHOiVWPkCdcXliUVq5fG8zr6W/e0Fvo7asO1gumw0nlaK5m2/WM+JjOYVMQ?=
 =?us-ascii?Q?MZV9U8/OaU0oHIoHsTAgJvYq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44efcb88-9f6c-47e5-0ae5-08d930ed5135
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5520.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2021 17:36:47.9689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Of1jpIenxD2LxMU4kLHARFc/XMiNmGYc4CxaPKw2OsY0NuwKG0M74jN9mi4PuqTW
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5446
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 25, 2021 at 01:12:31PM +0000, Lorenzo Pieralisi wrote:

> A discussion was held between me, Will Deacon, Bjorn Helgaas and Jon
> Masters to agree on a proposed solution for this matter, a summary of the
> outcome below:
> 
> - The PCI SMC conduit and related specifications are seen as firmware
>   kludge to a long-standing HW compliance issue. The SMC interface does
>   not encourage Arm partners to fix their IPs and its only purpose
>   consists in papering over HW issues that should have been fixed by
>   now; were the PCI SMC conduit introduced at arm64 ACPI inception as
>   part of the standardization effort the matter would have been different
>   but introducing it now brings about more shortcomings than benefits on
>   balance, especially if MCFG quirks can be controlled and monitored (and
>   they will).

I wanted to inject a slightly different viewpoint on this (old thread,
since it was revisited in some other forum) - I'm not so interested in
this firmware interface to fix ECAM compliance/quirks/etc.

However, in modern server type systems the PCI config space is often a
software fiction being created by firmware throughout the PCI
space. This has become necessary as the config space has exploded in
size and complexity and PCI devices themselves have become very, very
complicated. Not just the config space of single devices, but even
bridges and topology are SW created in some cases.

HW that is doing this is already trapping the config cycles somehow,
presumably with some very ugly way like x86's SMM. Allowing a designed
in way to inject software into the config space cycles does sound a
lot cleaner and better to me.

For instance it may solve other pain points if ARM systems had a cheap
way to emulate up a "PCI device" to wrapper around some IP blob on
chip. The x86 world has really driven this approach where everything
on SOC is PCI discoverable, and it does seem to work well.

IMHO SW emulation of config space is an important ingredient to do
this.

Jason
