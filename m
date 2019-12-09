Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3E6117858
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 22:23:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfLIVXB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 16:23:01 -0500
Received: from mail-oln040092253085.outbound.protection.outlook.com ([40.92.253.85]:43574
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726408AbfLIVXA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 16:23:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WEnbBiTiEMadvYBeJ6rot8Lsj36BEk/vOmKPGpdy+xDXtguXMVEYYV09Hksmr2FClhE+DikjMCM/U8of/+i/wQ0sRjPt8nF3CA6eSQwmqfuff6iHo4LvB9vDglVhQpYdT3B2YW7ABb6TN00+3R6XFB9zXXMfQqyNa/SUhgG1WA/nqHSzDz22gWlCWi4IGMrKf2oqftOlyL4t9EFKUOGK6W0l1kxjyo3s1cZ4NLVxaVThECYY657bUmRL7q1bSoz+tbUmrdTrUoW3dxHGc2MULObs4aWjRPebyidwvukQqLZ4R0FoQtdDBQFH6VphJkmvp3pb9GyoWsNo2zyQFuY+Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dKfmJgjNd3c0qpfZjlSGzYVXDk4rdYxze8Q/XYeGyII=;
 b=CfJY1ODyyNnd0CvIjRIz8ZILQS5GIyh2rlPpWMr9f7mncEGXM+QcOI6F+YLsQ6weNNGBGiJMXEmOTCcBirM/UwY1hjzdlq4ZcI+nyLAZ6SoYa0YSskiWDFHVKdkwXEVueY5oRRxQigMqhDZHonu8ZG9Cb81dxeAmdrrzGMJvUR4otUSl2DZb7715IsgycnFFgLn6LqGK/AwUcb7M2oNEE0hKOOHymxbHHS4u4gBvPmQNWmw9V3ZuKVX1SQAMzZBniHcacGNN7jk8bK7QUIQinta+dewF5FxmjvmpduLjdzGCYRxgtKTEzAuG7FKC+P3Y9Qd+XHaqw5FcYfmPiz1JGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT017.eop-APC01.prod.protection.outlook.com
 (10.152.250.51) by SG2APC01HT213.eop-APC01.prod.protection.outlook.com
 (10.152.250.252) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 21:22:50 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT017.mail.protection.outlook.com (10.152.250.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 21:22:50 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 21:22:49 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "bjorn@helgaas.com" <bjorn@helgaas.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>
Subject: Re: [[RFC PATCH v1] 0/1] Add pci=nobbn to ignore ACPI _BBN method to
 override host bridge bus window
Thread-Topic: [[RFC PATCH v1] 0/1] Add pci=nobbn to ignore ACPI _BBN method to
 override host bridge bus window
Thread-Index: AQHVoODiiG1xuuRCOEaC/dBx8A2UfKeyFLaAgABXGgA=
Date:   Mon, 9 Dec 2019 21:22:49 +0000
Message-ID: <PSXP216MB0438258FE3687E1B33D48A2B80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043824762539AFC40143D75880490@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <CABhMZUXOQXruHnZARVqe8cdkuhGXenMZ__7GhaJtDDsdBrcoyQ@mail.gmail.com>
In-Reply-To: <CABhMZUXOQXruHnZARVqe8cdkuhGXenMZ__7GhaJtDDsdBrcoyQ@mail.gmail.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0169.ausprd01.prod.outlook.com
 (2603:10c6:10:52::13) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:0A72FB5ED855A5F081936D7ED8A460C8E5455359F1669D4922A10EECE936EA99;UpperCasedChecksum:1098633862171E7DE5A51AB21848C0FCE8785A726B8E30CFEC9D8AD69BBE32DD;SizeAsReceived:7924;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [RnCXcg+VXLEaVpgAgjZrd7tHNFxzWpov2kkGxRp6FTMFVWJOhaq8wcOHnYSRF/vDvs3u8i1o/Pw=]
x-microsoft-original-message-id: <20191209212236.GA2204@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a4e718aa-a5a8-4f6e-69e7-08d77cedf0ff
x-ms-traffictypediagnostic: SG2APC01HT213:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CQZhR0vwhG7gs+2AjRBeiG1FYgGkkUnjzeIJYf/l/wnmT7elf774aSELjnvwXxFCr2Emg+Fg0a3HAZWxHhReKBriI0Tz0BYzXFZuHCA4hdTJ/WRhhHSO3MBK2DP7lxfP51N9POYXlLIkBUXZ6XH6Rir2yGyuyquPiSSkT4hlSMvAlYJLmqdR+RHTPxgZAZL9
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B9A2C53F9EAC35489EF137720E118E62@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a4e718aa-a5a8-4f6e-69e7-08d77cedf0ff
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 21:22:49.6344
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT213
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 10:10:55AM -0600, Bjorn Helgaas wrote:
> On Thu, Nov 21, 2019 at 9:02 PM Nicholas Johnson
> <nicholas.johnson-opensource@outlook.com.au> wrote:
> >
> > Hi all,
> >
> > I want to be able to override the bus resource from ACPI, but nocrs does
> > not do it. I am putting this out here to get a feel for the sentiment
> > for doing something like this.
> 
> This should be cc'd to linus-pci and linux-acpi (added).  I only
> noticed this message by accident.  And I don't see the patch at all.
I thought I had you cc'd into this - you were in the get_maintainer.pl 
output.

Looks like I posted the cover letter twice instead of the patch. I will 
re-post shortly.

> 
> > What is my motivation for doing this?
> >
> > I have a Gigabyte Z170X Designare motherboard which only gives resource
> > [bus 00-7e]. I want the full [bus 00-ff] because I am trying to add as
> > many Thunderbolt 3 ports with add-in cards as possible. Thunderbolt
> > consumes bus numbers quickly. An Intel Ice Lake implementation (ideal)
> > consumes 42 busses per port, but prior solutions consume 50 busses per
> > port and have additional busses required for the NHI and USB
> > controllers, as well as the bridges from the root port.
> >
> > Why not change nocrs to do this? Why the new kernel parameter?
> >
> > I imagine that on systems with multiple PCI root complexes, things will
> > get hairy if we do this, if they are not placed on separate segments /
> > domains by the firmware. I do not own such a beast, but from what I
> > understand, the firmware normally places them on the same segment /
> > domain with non-overlapping bus numbers. But we may still want to use
> > nocrs for other reasons. I need to use nocrs to allow Linux to allocate
> > vast amounts of MMIO and MMIO_PREF under the Thunderbolt root ports
> > without the BIOS support for Thunderbolt. Hence, they should be kept
> > separate.
> >
> > Why do this in general?
> >
> > The bus resource is still a resource which is specified from ACPI, just
> > like those overridden by nocrs. Even if we do not use pci=nocrs to
> > override it, it should be possible to override it, just as it is
> > possible to override _CRS.
> 
> pci=nocrs is for working around defects in firmware or Linux.  The
> firmware knows more about the platform than Linux, and in general we
> have to trust it.  We probably should taint the kernel when we use it.
> 
> Any parameter like this should work the same on all ACPI systems,
> including ia64 and arm64, and should probably also taint the kernel.
> 
> I can't see the patch itself, but I'm a little confused because we
> normally get the bus number range from _CRS in acpi_pci_root_add() and
> your patch doesn't appear to touch that.
Because pci=nocrs is x86-only, I was making pci=nobbn x86-only. Which 
means I only touched the areas in arch/x86 where pci=nocrs is handled.

If you want, I can change nocrs to work on any arch, although I will 
need somebody who owns ACPI systems of different architectures to test.

The only such system I know of (that is not server hardware) is the 
Microsoft Surface Pro X, which is an ARM64 system with ACPI and at least 
three PCIe root complexes on PCI domains/segments 0, 2, 3. Mainline 
Linux does not run properly even on X86 Surface devices, so I imagine it 
will be an absolute nightmare getting Linux to run on this. I also have 
no intention of buying anything without Thunderbolt / USB4.

Kind regards,
Nicholas

> 
> > Nicholas Johnson (1):
> >   PCI: Add pci=nobbn to ignore ACPI _BBN method to override host bridge
> >     bus window
> >
> >  Documentation/admin-guide/kernel-parameters.txt |  2 ++
> >  arch/x86/include/asm/pci_x86.h                  |  1 +
> >  arch/x86/pci/acpi.c                             | 11 +++++++++++
> >  arch/x86/pci/common.c                           |  3 +++
> >  4 files changed, 17 insertions(+)
> >
> > --
> > 2.24.0
> >
