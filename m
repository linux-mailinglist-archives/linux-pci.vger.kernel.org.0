Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591333ADC29
	for <lists+linux-pci@lfdr.de>; Sun, 20 Jun 2021 02:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbhFTA3O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Jun 2021 20:29:14 -0400
Received: from mail-mw2nam08on2086.outbound.protection.outlook.com ([40.107.101.86]:38249
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229615AbhFTA3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Jun 2021 20:29:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RupX92zh/RXEQamEQhA0VQZqTKsl6AYPosKCUGJ/wjoaaBKFQraQuVC3YrmKn4jb0Oqy1s2xdbuEs3bvWXbvhQWHK0RImgU4nn+pS84IYClMFEgI7jpzRwPDi0kwzAOIz6CTKz0BPWfSfamve7lEm9RDOeQnlEhprVgi8VGSDPECRgNxN/rqdT3RVmD4PG2gMxSJeSHqcvmPhqv361WiEqsXeaYHcsyAiOKPysphH/8oXhTOieBMCAzxLdYwhshEDzE7E79ksd05bVfpYHLrqRNB7JVZbt7y0ETWRqHv0lw69nJMsdj/YXRaOUiSoi058YZOV0DCdIWhxMLkFbIaZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECwE+1gx3HASMv7wlk/iKJbfxUo5+C7CqohGV4fA7rg=;
 b=K3N3CbanRBKxrQkXOHJgYNIFcLwj+CNkof8EUZGyqyl0ywiaLkn90e5WhYCu7mkDQX4SjkWu89UMY/SPup30a0oYdoW8gZpq4PdATzQuv8uHNwVub8Fzx/5tVyZCKf7BciGA0PfNlOKHIKTRXkcHpYP6Te7JZB8ZUnkPskB6L3Po25o/iCaRmcoYwSJRyLenPTrkDeM1lOTdLjb6xJ840g5IqpeejQYIjx8FkHx1J1s+asiyI2e5hYgOmoy2xf8PjdngP0KKaBiFuTWExeXARNk0evr3nQivFEWKJJKvagyy+nKb7AfkXh/rwvjJd/01pGaTpVw4IkCCUQxhDz28Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ECwE+1gx3HASMv7wlk/iKJbfxUo5+C7CqohGV4fA7rg=;
 b=JiXs3+5Eenh3JJYiMzGMX7Uv0Gs4kCMmRdW09KHr1W156s5hlb7GNg1/ww4Yym6TC2/KfCQY9T1dDn48JsKHUHF3G1Xw77w24SX0+NP6t3VQAKpfFJehjbcPvsUIfhrdI5j7EpASkeREj3C2gAz1QfqDEWUCbmDPIwW4VuNkJNO9ggT+kHZzdMJpmjQIENFf+J01mF0Rq/PsAO9KkD1RZBGDNgUedt2YDsuDoUS258iu7+Ki/tydvSnAWPHYK9yZlNYKRRKQe7IGOAIMwo34FoSIBdmonD/3PlDTRXhLq8C6vGrCmgAaq/51q/TbWJVZHMHWDtSdo5wwn0n4908SSA==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5224.namprd12.prod.outlook.com (2603:10b6:208:319::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.16; Sun, 20 Jun
 2021 00:26:58 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.023; Sun, 20 Jun 2021
 00:26:58 +0000
Date:   Sat, 19 Jun 2021 21:26:56 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jon Masters <jcm@redhat.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Will Deacon <will@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Thierry Reding <treding@nvidia.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pci@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-arm-kernel@lists.infradead.org,
        Eric Brower <ebrower@nvidia.com>, Grant.Likely@arm.com
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
Message-ID: <20210620002656.GL1002214@nvidia.com>
References: <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
 <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
 <20210616173646.GA1840163@nvidia.com>
 <CA+kK7ZijdNERQSauEvAffR7JLbfZ512na2-9cJrU0vFbNnDGwQ@mail.gmail.com>
 <20210618140554.GD1002214@nvidia.com>
 <CA+kK7ZhJ8+BhLZeZ5XtL2M_qDpOo823taFbM45DTV=H6L1EvhQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+kK7ZhJ8+BhLZeZ5XtL2M_qDpOo823taFbM45DTV=H6L1EvhQ@mail.gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: BL0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:208:91::22) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by BL0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:91::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.7 via Frontend Transport; Sun, 20 Jun 2021 00:26:57 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1lulIe-0093n4-Lv; Sat, 19 Jun 2021 21:26:56 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eb06deb1-5248-4794-80ab-08d933821d2a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5224CAB3DC95B0351C9D17A0C20B9@BL1PR12MB5224.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2201;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ESs8VMFE6oqRJmjsst5pWx2i6zola2N6D0+q7wAxF898uFOohQYoPjGnSJUm2OL1oLx0BTaXV5EF4rVCNUSyEJIVDwy9d1Nq8/g6TjDPvrqZO3Ck8KYX+za5qVzJ463zzhqtfFL0nyJtp6/dJOVjHXhXL092/B+13eAVQj1jZQ0ylqxwhEgGCOuUS/oCAPxY+MYxyLijeC0LOMBwY7WUwnqUUEH6qsDKkRBJ8y5TPwxjDkBbeoZ9LGof4hOg29OdfB0qzNO6+5XIFnRrwzcXp9yv/19TGiFh7Ax95vjCJKStDnUfaGHJVHqjAJZi2mAcyF0/awue56nBwQ7WkNZXYV2Ptz7EI9LTPn9t/+S45pBEK77vXKuq6P3av1hgqMMtkGxAfLfBWA+ITJizST8A/i01zj+uZxm8Gx0hhEOp+RlBXznCLlw8ysosfq1EOOhnE+TJ0SH15q+i9m//18dJxgh/Zpn9hwTLlz3XprwrzYp97+6i1ykObVwwTgFTTL3hipM0nWbK3iQoT7Oat4QQvM1i1C3QxAAH6g+we8nAteiRnLgfPayMKMxEFg7XwocwhDJW/69l3LW4DlwDkhXCXsNKhAxiG5NqAjbBtfTCNo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(366004)(376002)(346002)(39860400002)(136003)(83380400001)(66556008)(53546011)(2906002)(316002)(66946007)(8676002)(66476007)(33656002)(38100700002)(5660300002)(86362001)(186003)(8936002)(2616005)(478600001)(6916009)(426003)(36756003)(54906003)(26005)(9786002)(1076003)(4326008)(9746002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?peMWgDXbDYLvQJD91Q4mY/NIB12mYWsFHtLYSyKdf22D2BWDfb8qV/b9XUPz?=
 =?us-ascii?Q?wHoB1aOUWttLDvVL8MkBvsPKI/+IZUDAxtYioiYpOSxIDs1rfNHlvCHfAxVv?=
 =?us-ascii?Q?l9Wt5R/4g/Zlv15c6ciX+WlCjusBsFk1f2arFlGfsgRGtFigFcoAFMNpwveP?=
 =?us-ascii?Q?cQLCwsGnZw2DGL5hv2+MOv4Fr2didFdaHXJCGGr29q+WUXkoc5IP20oBbIm2?=
 =?us-ascii?Q?8B3sCx2kxNMwHeHWcKuwr+Vaun++kbrgVVP0khIdox4jxMEHwIdtdaPQxlTa?=
 =?us-ascii?Q?4NR64in4z3B06ioOLNSTUtW3aJgopa1k4Awxpj4fusw6WjuCpcAYVUcggrWU?=
 =?us-ascii?Q?dxfJcMqpupAm+RGVYVwdzAIJMyV1VT+dtWU03pUaazRAsbA/EAha4zNcdoAA?=
 =?us-ascii?Q?/aMwT3bvL/y/Y6piD8gJsmo56TaT2IFKw2KnFCa9QkZF1yWM5RqwFyvYjUoF?=
 =?us-ascii?Q?/HcCLbMqsnTIRYpI5X0aQLo2y9FMqekkF5uViAhZOjbt3zcF2IJeInmflPek?=
 =?us-ascii?Q?ku4jYfoxfnibucLVZQAv36J6TYL2elThZ0czClm0cLVjPMi548Bad9Ojocnp?=
 =?us-ascii?Q?Hku0AAwVwVtcEb39bMMkJZLf92IoH1vAR3HID3alNb3z5BYK72ZMa85seyck?=
 =?us-ascii?Q?wSz6oRKgcepekHX8NoUyHH+jhHakHqoYs+7PHFalS6y721+UjravgkeM7/Yx?=
 =?us-ascii?Q?C0At3lZyuNIXPGMLbl9NUAY4lXkyIcNXlGMZZDylGZ6at0lruu6/tAtldm/q?=
 =?us-ascii?Q?PMhtH/7KhdDJaFl1DVf31QLQehtjvRin2Ij53BB06csp1lvENUzxieROd/93?=
 =?us-ascii?Q?28QlSlaDDM2Mnt6VTtvCiufkuQX2T3QELOZaYurOpuIae0Becoieucg6Ut15?=
 =?us-ascii?Q?UC0iBFqrMzCh0emwzrpzD/yuPTbibRpDZF/KpPWo9h3393D9A6m0oJeAejSh?=
 =?us-ascii?Q?Dir336tXIrtad1/dGBXqr/gAE8bTb0OMtzIQDQyIZW6kyEpxnhFK22s8RAKu?=
 =?us-ascii?Q?/qEY7ERYmWfNbkrV8DSU4ckpfx0s4/Mba0hUQkNGe27eTA2LE9wA/9mV9hKp?=
 =?us-ascii?Q?aVMGJAWmO4K6S/UiBhei9+Ue1wz4cmQkLz/ge9ZVOtiw7jkdUiQn0/rL4Th/?=
 =?us-ascii?Q?cPZoO1BwNMyzdYQuLlDt+CTXzzjFFNYXFFYkBgEnX8yTuZDXkq3SfGktMuuN?=
 =?us-ascii?Q?2AvtIeE97UJ4/vI3MLx2iyHO7pibOOjr45NpClRalI0tZLZrLET+XWPuuijh?=
 =?us-ascii?Q?7rE6HbguP9IhwjjztA5fc49mHIB5by4rLbm5Imn0ok+yAEg1bi1nPJlCMWnw?=
 =?us-ascii?Q?4I9oSVbpYOHEQKR4n5X0yFSt?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb06deb1-5248-4794-80ab-08d933821d2a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2021 00:26:58.0961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oEadaAEZFVhaL93l8ZXB5YA4kvuzOJWXj0BBBuFf+cMjShC6482TQlu+bVIcqPMj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5224
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jun 19, 2021 at 12:34:57PM -0400, Jon Masters wrote:
> Hi Jason,
> 
> On Fri, Jun 18, 2021 at 10:06 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Jun 18, 2021 at 09:21:54AM -0400, Jon Masters wrote:
> > >    Hi Jason,
> > >    On Wed, Jun 16, 2021 at 1:38 PM Jason Gunthorpe <[1]jgg@nvidia.com>
> > >    wrote:
> > >
> > >      On Thu, Mar 25, 2021 at 01:12:31PM +0000, Lorenzo Pieralisi wrote:
> > >      However, in modern server type systems the PCI config space is often
> > >      a
> > >      software fiction being created by firmware throughout the PCI
> > >      space. This has become necessary as the config space has exploded in
> > >      size and complexity and PCI devices themselves have become very,
> > >      very
> > >      complicated. Not just the config space of single devices, but even
> > >      bridges and topology are SW created in some cases.
> > >      HW that is doing this is already trapping the config cycles somehow,
> > >      presumably with some very ugly way like x86's SMM. Allowing a
> > >      designed
> > >      in way to inject software into the config space cycles does sound a
> > >      lot cleaner and better to me.
> > >
> > >    This is not required. SMM is terrible, indeed. But we don't have to
> > >    relive it in Arm just because that's [EL3] the easy place to shove
> > >    things :)
> >
> > "This is not required"? What does that mean?
> 
> It's not required to implement platform hacks in SMM-like EL3. The
> correct place to do this kind of thing is behind the scenes in a
> platform microcontroller (note that I do not necessarily mean Arm's
> SCP approach, you can do much better than that).

This is what some are doing, but burning that much sillicon area just
to run the non-performance software for PCI config space feels really
extreme to me - and basically means most of the the mid tier won't do
it.

Let alone the complicated questions around how to manage this other
processor, do in-field upgrades, deal with it crashing, and its
debugging/etc.

> > AFAIK x86 has HW that traps the read/writes to the ECAM and can
> > trigger a FW flow to emulate them, maybe in SMM, I don't know the
> > details. It ceratinly used to be like this when SMM could trap the
> > config space io read/write registers.
> 
> They trap to something that isn't in SMM, but it is in firmware. That
> is the correct (in my opinion) approach to this. It's one time where
> I'm going to say that all the Arm vendors should be doing what Intel
> is doing in their implementation today.

What is the ARM equivilant to "not in SMM but it is in firmware" ?

> > Is that what you want to see for ARM? Is that better than a SMC?
> 
> Yes, because you preserve perfect ECAM semantics and correct it behind
> the scenes. That's what people should be building.

I'm not really talking about perfect ECAM semantics here, but the
whole ball of wax - the endless rabbit hole of a SOC that has 10 "pci
devices" on chip and has 40kb of config space that needs to be
presented to the OS. How do you do that in a silicon efficient way?
How do you deal with it in a way that allows contigencies when the HW
is inevitably wrong?

The usual answer is to use a lot of software and run it someplace.

> > That is alot of special magic hardware to avoid a SMC call...
> 
> And it's the correct way to do it. Either that, or get ECAM perfect up
> front and do pre-si testing under emulation to confirm.

This is what the sophisticated people are doing - but I think
insisting on it leaves out the middle of the market that can't afford
the silicon area for extra microcontrollers, afford the extra design
time to do all the needed high fidelity emulation to be sure it is
right, or afford a mask respin.

Again, it is not just ECAM, the bad root complex's are a really tragic
dysfunction in the IP marketplace. Even if they were perfect we'd
still want to have SW injected in config cycles, some how..

Jason
