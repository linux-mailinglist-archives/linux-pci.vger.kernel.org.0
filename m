Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECF95127783
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2019 09:50:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbfLTIuW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 20 Dec 2019 03:50:22 -0500
Received: from mail-oln040092255087.outbound.protection.outlook.com ([40.92.255.87]:43008
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727135AbfLTIuW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Dec 2019 03:50:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LETB1PxKPnpV2Zcem7/KYafPuaK7eQoAo/3417+qL2gBElaH1r0gUXqN6svzzs+zSGb6jZtskCckxc4gTluyhpR3EDWAFVlOB5mVxq9Lk/468i1h1qH8VkeYYr1HElpRFa435T3VQR3muJu3PdShrol6lmRIV7UhGeASaUNJCqVVfSMGMzeJFvjg8Gdz1tsN5qAz3tAcFI/qk0u7UzmD12ahDZ0heIjX1Uv1aJteOUxgKWCc5sVm8xSFw8QFKxRyf2mccUX/Y5NSw5zqBCXs5DPvQf8yYpznaVLOec/hBUuUPoSOY8lDkt8IcaJ2f3P9hBL7mkEeuJD+p0z08hT8Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j/qRJkZpdBBGdnBBdu/OQNM9Xv0903fVpLOavpib+tQ=;
 b=V0nvoTp7Eqgh9aTEteSih4RgcHtrKXiy+kdPSZ6xojbQCQ2oaYJQyTleFXk32tBND7KmoIj5yUWgX9RskYpB8XcptUQB35UGJ08QzYa0MK9sJ5jvod0tE8NGgacBSsROzxG8JPyQPWDOiME6D2/pCYnAnqDgB1ZvV58i3py1rsxnK1IAbTi5jyFhrNyIbO4koV9/J88NtiBWfqD7miU4Sw1zRN4lnVxbqNvGbTa8vMngr6evKIbbz/YkTvDse8nKLxeZe2W50iYdpLab2iQ9MWuSUpcopCvro5KeDKe1naXp1JT01VALX6FPGGeH36H34IZMVhze/GnaQ0Rt7Zk/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT132.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT159.eop-APC01.prod.protection.outlook.com
 (10.152.251.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2559.14; Fri, 20 Dec
 2019 08:50:14 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.52) by
 SG2APC01FT132.mail.protection.outlook.com (10.152.250.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.14 via Frontend Transport; Fri, 20 Dec 2019 08:50:14 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2559.016; Fri, 20 Dec
 2019 08:50:14 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Topic: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Index: AQHVrpB+5sK/XGeQw0yttw28ATWBvae+e8EAgACidQCAAxacAIAAkwAA
Date:   Fri, 20 Dec 2019 08:50:14 +0000
Message-ID: <PSXP216MB043888F94710A361E4D84DFF802D0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043840E2DE9B81AC8797F63A80530@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191220000358.GA126443@google.com>
In-Reply-To: <20191220000358.GA126443@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEXPR01CA0109.ausprd01.prod.outlook.com
 (2603:10c6:200:2c::18) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:F855BA5884A513592D612ADEB0FE1425C82BDCD0ADD03B8B71DA19680BC08343;UpperCasedChecksum:E9D8B675A18992AF997A75D9987BA494C0C307504AF795FDB17FBA13AB47D237;SizeAsReceived:7638;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [HxoIoUgI7m6Ry2ozidc62JYW/LoovkdT]
x-microsoft-original-message-id: <20191220085006.GA1607@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 1986a1cd-6770-4e30-ec0f-08d78529a136
x-ms-traffictypediagnostic: SG2APC01HT159:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: RnU3kqWcxfI3MwhVA5OQR4uaUKGbUgFhEGnnYpBuYRlg9LwLEcs4t4QGSUlVTmZ5ytIFKsyVlqrZc61SIqicXGv4ms4zBe3joYaKrxbWUMZ5vx92LtwYKRnLu5ca5hUUSq8acOMLld0WdWGDpJa05tqYSzsYB1DN21+Vh3G5ItHoLdf2KTMoIe/njDLv052q
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E7FD1774B7DB644FAF17DD9771CB1EFE@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 1986a1cd-6770-4e30-ec0f-08d78529a136
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Dec 2019 08:50:14.7406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT159
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 19, 2019 at 06:03:58PM -0600, Bjorn Helgaas wrote:
> On Wed, Dec 18, 2019 at 12:54:25AM +0000, Nicholas Johnson wrote:
> > On Tue, Dec 17, 2019 at 09:12:48AM -0600, Bjorn Helgaas wrote:
> > > On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> > > > Hi all,
> > > > 
> > > > Since last time:
> > > > 	Reverse Christmas tree for a couple of variables
> > > > 
> > > > 	Changed while to whilst (sounds more formal, and so that 
> > > > 	grepping for "while" only brings up code)
> > > > 
> > > > 	Made sure they still apply to latest Linux v5.5-rc1
> > > > 
> > > > Kind regards,
> > > > Nicholas
> > > > 
> > > > Nicholas Johnson (4):
> > > >   PCI: Consider alignment of hot-added bridges when distributing
> > > >     available resources
Prevent failure to assign hot-added Thunderbolt PCI BARs with alignment >1M 

> > > >   PCI: In extend_bridge_window() change available to new_size
Change variable name in extend_bridge_window() to better reflect its 
purpose

^ I would have preferred this not be its own commit. Is it too late to 
squash it back together with patch 3/4?

> > > >   PCI: Change extend_bridge_window() to set resource size directly
Use guaranteed PCI resource size instead of optional add_size when 
adjusting bridge windows

> > > >   PCI: Allow extend_bridge_window() to shrink resource if necessary
Prevent failure to extend nested hotplug bridge window if pci=hpmmiosize 
or similar kernel parameter used

> > > 
> > > I have tentatively applied these to pci/resource for v5.6, but I need
> > > some kind of high-level description for why we want these changes.
> > I could not find these in linux-next (whereas it was almost immediate 
> > last time), so this must be why.
> > 
> > > The commit logs describe what the code does, and that's good, but we
> > > really need a little more of the *why* and what the user-visible
> > > benefit is.  I know some of this was in earlier postings, but it seems
> > > to have gotten lost along the way.
> >
> > Is this explanation going into the commit notes, or is this just to get 
> > it past reviewers, Greg K-H and Linus Torvalds?
> 
> This is for the commit log of the merge commit, i.e., it should answer
> the question of "why should we merge this branch?"  Typically this is
> short, e.g., here's the merge commit for the pci/resource branch that
> was merged for v5.5:
> 
>   commit 774800cb099f ("Merge branch 'pci/resource'")
>   Author: Bjorn Helgaas <bhelgaas@google.com>
>   Date:   Thu Nov 28 08:54:36 2019 -0600
> 
>     Merge branch 'pci/resource'
> 
>       - Protect pci_reassign_bridge_resources() against concurrent
>         addition/removal (Benjamin Herrenschmidt)
> 
>       - Fix bridge dma_ranges resource list cleanup (Rob Herring)
> 
>       - Add PCI_STD_NUM_BARS for the number of standard BARs (Denis Efremov)
> 
>       - Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters to control the
>         MMIO and prefetchable MMIO window sizes of hotplug bridges
>         independently (Nicholas Johnson)
> 
>       - Fix MMIO/MMIO_PREF window assignment that assigned more space than
>         desired (Nicholas Johnson)
> 
>       - Only enforce bus numbers from bridge EA if the bridge has EA devices
>         downstream (Subbaraya Sundeep)
> 
>     * pci/resource:
>       PCI: Do not use bus number zero from EA capability
>       PCI: Avoid double hpmemsize MMIO window assignment
>       PCI: Add "pci=hpmmiosize" and "pci=hpmmioprefsize" parameters
>       PCI: Add PCI_STD_NUM_BARS for the number of standard BARs
>       PCI: Fix missing bridge dma_ranges resource list cleanup
>       PCI: Protect pci_reassign_bridge_resources() against concurrent addition/removal
> 
> The logs for individual commits are obviously longer but should answer
> the same question in more detail.
> 
> Basically, I'm not comfortable asking Linus to pull material unless I
> can explain what the benefit is.  I'm still struggling to articulate
> the benefit in this case.  I think it makes hotplug work better in
> some cases where we need more alignment than we currently have, but
> that's pretty sketchy.
In my opinion, fixing failure to assign is a clear reason to merge, 
especially when the failure will result in a user wondering why the 
device they plugged in does not work. If that is not enough to get past 
Linus Torvalds then I will have to go back to the drawing board, because 
it is the best I can think of (for now).

I have had a go above for the four patches.

Mika, what would you have written if you had to do this?

> 
> Bjorn

Thanks!

Kind regards,
Nicholas
