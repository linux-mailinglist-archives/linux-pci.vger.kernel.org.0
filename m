Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96BF83ACD0F
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jun 2021 16:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232152AbhFROII (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Jun 2021 10:08:08 -0400
Received: from mail-bn7nam10on2058.outbound.protection.outlook.com ([40.107.92.58]:64609
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229782AbhFROII (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 18 Jun 2021 10:08:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpamVXfnFbmUaq53hbDq2Qn9M/cPDYIiITP8V/pa6//4fJSTKzGJXpoLFeZS/u1p1kna7hWCqjjcR2AfIo0gtEtiGemIWs03Rk6CKYbe6le6mGEqFBwNmt8s6ta+elYp+cpZIhWvRnf26wZ3M7mRaOofbo+1eK0OiLytvxMs2+xYycf0crJZdVy3BK3lhJ3BMLI65fsTyKnTN5UFTzD8kNbrhghh8MS8hWdNvq+cUZ6oKGDaYWB2wsl7f0Dom8EGRem1TbdkvSddav5tUsSv+jJZ+9BO5EbT3mUwG+uRCal5PZVH8wUGTw6rmRKmLW20l4KrwgkkelwvZNuKGc7z7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy1VqLlX/eNq++u0GVBMBGnFThYhEpzJTnojWm7q2ms=;
 b=fgxWmAhYs8hYHws8gI5b9qbwv+sIu5OtEQMCKYSes9KcvMwUB5Mn9dtqrRWitgB6i30YSPtXcqSigGWNLfDoJ/DrA3YIAn+WTwjCxgApauZWng01YRnUwAiIqH2L3r1slJyQW2p6Ow29JHLvKybDd1fOp5ie3KGo8gMttMKFuOykRDj+NcG5x68kDMy0d9TgUkiYuBCQ4h2jxI5rlYUki9A6xMSFa5GhADInDFxUewrFu4n4qdIIa9xZAKp9Q/zwbKsYdLz4NKP4btPt9NXOJSFeBHJwaWJ3Uqbig0A+J9DQKs8ybSRy1Znfg33OI3ztLQP2W8JHy7KKfVN2AToERA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dy1VqLlX/eNq++u0GVBMBGnFThYhEpzJTnojWm7q2ms=;
 b=Oj7rPXjG3IL+t5kiAx5LvLNRzwSbqIGHKK72VXYNkzPMbkeASBQy6wQtE65uSJtLkxLj4mg9B+YJpV7Z/CLvv2XDKwqNyQqbFKGDg7X8RJAnEtPOad+lcBClli+YJGTkBLUHwASBBd5zDW3Fhf0ge9DAGoWEu6NXLZr2spQ95/4/kIlWvTxS/1/nrdaPfIuLgu14xq18NpyUeRLz6LjEuqSGb9jay/CRqD/SwN1yf2LnNpyRorXHg5ac4Uzy8BalgfKuWLRqclWsYSsyXSguptGn0NeEIbLg80jZrgPepQqwYIUQ+OcEppEGvJRmOpSMDFfEfG/+R9SaT5nFrQFkBw==
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5301.namprd12.prod.outlook.com (2603:10b6:208:31f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.19; Fri, 18 Jun
 2021 14:05:56 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::3d51:a3b9:8611:684e%8]) with mapi id 15.20.4242.021; Fri, 18 Jun 2021
 14:05:56 +0000
Date:   Fri, 18 Jun 2021 11:05:54 -0300
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
Message-ID: <20210618140554.GD1002214@nvidia.com>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
 <20210107181416.GA3536@willie-the-truck>
 <56375cd8-8e11-aba6-9e11-1e0ec546e423@jonmasters.org>
 <20210108103216.GA17931@e121166-lin.cambridge.arm.com>
 <20210122194829.GE25471@willie-the-truck>
 <b37bbff9-d4f8-ece6-3a89-fa21093e15e1@nvidia.com>
 <20210126225351.GA30941@willie-the-truck>
 <20210325131231.GA18590@e121166-lin.cambridge.arm.com>
 <20210616173646.GA1840163@nvidia.com>
 <CA+kK7ZijdNERQSauEvAffR7JLbfZ512na2-9cJrU0vFbNnDGwQ@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+kK7ZijdNERQSauEvAffR7JLbfZ512na2-9cJrU0vFbNnDGwQ@mail.gmail.com>
X-Originating-IP: [47.55.113.94]
X-ClientProxiedBy: MN2PR20CA0065.namprd20.prod.outlook.com
 (2603:10b6:208:235::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mlx.ziepe.ca (47.55.113.94) by MN2PR20CA0065.namprd20.prod.outlook.com (2603:10b6:208:235::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4242.18 via Frontend Transport; Fri, 18 Jun 2021 14:05:55 +0000
Received: from jgg by mlx with local (Exim 4.94)        (envelope-from <jgg@nvidia.com>)        id 1luF86-008XhZ-VJ; Fri, 18 Jun 2021 11:05:54 -0300
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b5022276-a227-4249-9b4b-08d9326230fa
X-MS-TrafficTypeDiagnostic: BL1PR12MB5301:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BL1PR12MB5301DEE499EF24DD1FDCB93FC20D9@BL1PR12MB5301.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BfPn6jOAvXMT0SOP8fLwZQF1fW32ZLtzLXpAjcbHqxJXIgeOb2jiMv8UAn4PMPRQAO4rctOvjwb/XTv0KNtkMwDExHNIhj/UpReJqTYd87KKyvI+KY/pyr1yh0yGzST8yKauGSUSU0vLvIfS356GfsFO+eGp/TXpQJc9zEnccqlqG3/kolDcTA54inJv50D6gaNMZpXtkqxHScTLUUPccMJyItd1y0M20XgbGgHRW2BQQJwSQt7/9edEECTh8uM1+C8b9FlSE1akK5h74OgtQDPzMtihx5GlqIRfQ+5ji7BKUDasRiMdq3jmDujpTlUay9N6HBYabwt5ZIHsIs5LE0cEvpVeecpvtkyWnWpXIWfkMNyyxYudTu7HBXwoqdvAik6o0Si9I9q+TaWcvYbzRcTc3tWd84MgNeWhsJt2W3q4eszX0uo8RpFhlzRilsj1dEHxgmnnoHLXFlA+egK45frUyL7c8CZPqAT5XNQArOguNwH+srHt6Hb1zVCJzC8TYqUBxKZYrVmCw9aosgq/4iel9AyVoutKypOrx2/Za4CKcUosQnDaciB5iZWhXelu9mT8sdJgZRr/dElSpStPoKWz53nV5vq9KgfUp+Fbu3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(376002)(346002)(396003)(39860400002)(136003)(5660300002)(33656002)(54906003)(6916009)(2906002)(9786002)(4326008)(186003)(26005)(7416002)(2616005)(316002)(86362001)(426003)(36756003)(1076003)(8936002)(53546011)(66946007)(66556008)(8676002)(66476007)(478600001)(38100700002)(9746002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t0uwh7JXu9MZFEjwPl34kiAWlGQzsZbzbZ7La3bD61ciOthXCXrjgA6+jwIF?=
 =?us-ascii?Q?bej8gxVfgRlv0EImNuR3gvWYEPCUys4ukah4JCk1A0x2S+9n4/8VMitLv6m3?=
 =?us-ascii?Q?924girYPk0g4t90nIGwyz40EYNMpEwEFhZmnutEkLqzrVEZ6l8rRI3SrXoB+?=
 =?us-ascii?Q?U7G4/3Jg20lxL1HkJEn7YHKr0WR92iDSazGQBsRwBMv2wQza4TI8T3RDdeoU?=
 =?us-ascii?Q?Z1TKXDCt4PAg8d0/I/5Ji+xlhWDF2p88CJ1OnTS5mXqakaM+qaqOUL9YSVX4?=
 =?us-ascii?Q?E9J0ozWp8hFWfrI3YT8Ho+CtbxldsQ5NERpfMF3N1q+dipx8n62TpvBsKscW?=
 =?us-ascii?Q?YnWWXPulL6UW1k6VVLa2ICUU+FWTpnxfDL2QcM7aQQl1MGq71yxcsjugHwsF?=
 =?us-ascii?Q?lo/EbT3OK2PfPG6ViByMe3U0hscrne461wD0qvP0JTI5TpQBHANUCzVRgg/c?=
 =?us-ascii?Q?eP7mzqxQ1OGOyJJ1w7Lw0lKDGryDxr5dtUN5lDengP56BA2EJC2AZA+ZTFgV?=
 =?us-ascii?Q?426HQh4bFZXTM+5zjNACkY8/0OCRLYAvNXW4ZPehXMWCmuNVpBskKiXELwwp?=
 =?us-ascii?Q?I0TS75Vp4frCgS1iHvS8GligrgM1SouhUcyhO5h9PrWNvLLH4UCeviSTbzDc?=
 =?us-ascii?Q?nW7ambMZ9078BFOEQzyPJ3Dtt+RLjopqi51k+9VeOisG301dlnkyVUmnDmIU?=
 =?us-ascii?Q?XyvA9FJ5KRH1nnAQmCh3E2ykJXiRaZNAF3hZ9U8Inpn0CGAiAlcLqdCFzGFl?=
 =?us-ascii?Q?0ZuZVwsilt1S1V86IybmY11nWi+qZpebpP9TFpF9RWHnmxGjqMTcmitZ/gy1?=
 =?us-ascii?Q?tmjPVXBvc5K9KYIAYNC76hvNZhmb1lzaHF66+Nyu/j+JP3s93hMmk253wXu1?=
 =?us-ascii?Q?r7zZRpt7QXc4igqHyF8Manl/OJ7mPiCWUCWzmmY4r33ldt+zJ5t221/ODkt+?=
 =?us-ascii?Q?AE08zm/TWYpwc0jETTWWoULO0Cvmgei8iggN7HfpmLHUB323dJAzFjKuHBEL?=
 =?us-ascii?Q?GbgcwytiaH8vhFelEVQqWdJRBnFs5tYrTbK8+Eq7O7h4zRmUZee7GQdzauZg?=
 =?us-ascii?Q?1AXfal/4AePRuckHdrUIVkh//YSMcuKibooQPFxEYN8HEUdGaqgoL2MRJnwR?=
 =?us-ascii?Q?xIZthGyCenRFJFQUtk9Tz+o1KkfKqqgnVvyjfw4J3oIoSRm5ZT9Nq1p7Ja0C?=
 =?us-ascii?Q?nrm8vvvVPYhev/z82/dAILzs0ATlSmJe0X1IfEK2CwltM8h4YAU2SqWDqUQ2?=
 =?us-ascii?Q?7r5QM++JU6quD8EWinT26UBKtoBxX3ewW3oQEy4NqCF5Lt/ZXglZq2nfDiid?=
 =?us-ascii?Q?CpvVBq35t3VG93UsZUaJ64R/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5022276-a227-4249-9b4b-08d9326230fa
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2021 14:05:56.1441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /YHctgEAyffNtQxk0wYIQxHw4/Labg5LY4Fq+YWiWjG+SjqDZ1+5OWOxlHxvdcwp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5301
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 18, 2021 at 09:21:54AM -0400, Jon Masters wrote:
>    Hi Jason,
>    On Wed, Jun 16, 2021 at 1:38 PM Jason Gunthorpe <[1]jgg@nvidia.com>
>    wrote:
> 
>      On Thu, Mar 25, 2021 at 01:12:31PM +0000, Lorenzo Pieralisi wrote:
>      However, in modern server type systems the PCI config space is often
>      a
>      software fiction being created by firmware throughout the PCI
>      space. This has become necessary as the config space has exploded in
>      size and complexity and PCI devices themselves have become very,
>      very
>      complicated. Not just the config space of single devices, but even
>      bridges and topology are SW created in some cases.
>      HW that is doing this is already trapping the config cycles somehow,
>      presumably with some very ugly way like x86's SMM. Allowing a
>      designed
>      in way to inject software into the config space cycles does sound a
>      lot cleaner and better to me.
> 
>    This is not required. SMM is terrible, indeed. But we don't have to
>    relive it in Arm just because that's [EL3] the easy place to shove
>    things :)

"This is not required"? What does that mean?

>      For instance it may solve other pain points if ARM systems had a
>      cheap
>      way to emulate up a "PCI device" to wrapper around some IP blob on
>      chip. The x86 world has really driven this approach where everything
>      on SOC is PCI discoverable, and it does seem to work well.
>      IMHO SW emulation of config space is an important ingredient to do
>      this.
> 
>    There are certainly ways to build PCI configuration space in a
>    programmable way that does not require software trapping into
>    MM. 

Can you elaborate on what you'd like to see here? Where do you want to
put the software then?

>    I strongly agree with the value of an industry standard approach
>    to this in hardware, particularly if the PCIe vendors would offer
>    this as IP.  In a perfect world, ECAM would simply be an
>    abstraction and never directly map to fixed hardware, thus one
>    could correct defects in behavior in the field. I believe on the
>    x86 side of the house, there is some interesting trapping support
>    in the LPC/IOH already and this is absolutely what Arm should be
>    doing.

AFAIK x86 has HW that traps the read/writes to the ECAM and can
trigger a FW flow to emulate them, maybe in SMM, I don't know the
details. It ceratinly used to be like this when SMM could trap the
config space io read/write registers.

Is that what you want to see for ARM? Is that better than a SMC?

That is alot of special magic hardware to avoid a SMC call...

Jason
