Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5B144FA52
	for <lists+linux-pci@lfdr.de>; Sun, 23 Jun 2019 07:01:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbfFWFBk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 23 Jun 2019 01:01:40 -0400
Received: from mail-oln040092255043.outbound.protection.outlook.com ([40.92.255.43]:44352
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725268AbfFWFBk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jun 2019 01:01:40 -0400
Received: from SG2APC01FT047.eop-APC01.prod.protection.outlook.com
 (10.152.250.53) by SG2APC01HT056.eop-APC01.prod.protection.outlook.com
 (10.152.251.220) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2008.13; Sun, 23 Jun
 2019 05:01:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT047.mail.protection.outlook.com (10.152.251.172) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2008.13 via Frontend Transport; Sun, 23 Jun 2019 05:01:34 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::8c3b:f424:c69d:527e%3]) with mapi id 15.20.1987.014; Sun, 23 Jun 2019
 05:01:33 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4] PCI:
 Fix bug resulting in double hpmemsize being assigned to MMIO window]
Thread-Topic: [nicholas.johnson-opensource@outlook.com.au: [PATCH v6 3/4] PCI:
 Fix bug resulting in double hpmemsize being assigned to MMIO window]
Thread-Index: AQHVJqddn+2PwrSPpkW3hy382qHokKajKMGAgACMcgCAAAGZgIAE/U+A
Date:   Sun, 23 Jun 2019 05:01:33 +0000
Message-ID: <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
In-Reply-To: <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0099.ausprd01.prod.outlook.com
 (2603:10c6:0:19::32) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:4C5374F144F66FDC04E8943B36BCB59B18F88FDD0A20B92A5A18C4A122EE63A6;UpperCasedChecksum:5A4F4C948A38F0B9268F07574BDD069C9E9CF925BB1DE330D503C789740DB2D2;SizeAsReceived:8005;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [XKNzQH/9TbYlxWZjgzq75haJUU3IRQA3WrdqXLTARg06x4BCz/Oe1lLl4CdzE0k/8ZYHJPqiwWM=]
x-microsoft-original-message-id: <20190623050123.GA5162@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT056;
x-ms-traffictypediagnostic: SG2APC01HT056:
x-microsoft-antispam-message-info: fWQlwVxl4lwlz87kivrShjYRq7etiENrf8vI0t65bAOPpEUP+udIciUtuM5G5a2M3oXY4DeyTrfzlqFTpNtL2D3Jm5A8E1kDXNO5GKB+lESLPbw5FmSPFxe3oRd6KjQf3M5XE2ZgfOl22OgMc4r8U5NILGMgAAB4Pw3/uHTjNTrNSLl3DXzwhnRUPzbKRf94
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3262C1FC0D69D40B9CB7B76D5266181@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d135c843-8164-461a-c8ba-08d6f797dc97
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2019 05:01:33.6524
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT056
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn, please weigh in on this - please see below.

On Wed, Jun 19, 2019 at 06:49:45PM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-19 6:44 p.m., Nicholas Johnson wrote:
> >> This is all kinds of confusing... the bug report just seems to be a copy
> >> of the patch set. The description of the actual symptoms of the problem
> >> appears to be missing from all of it.
> > I believe everything to be there, but I can take another look and add 
> > more details. It is possible I lost track of what I had written where.
> > 
> > There are common elements which I borrowed from the patchset or 
> > vice-versa, like the pin diagram for using the Thunderbolt add-in card 
> > for testing.
> 
> What's missing are symptoms of the bug or what you are actually seeing
> with what hardware. The closest thing to that is the bug's title. But
> it's not clear what the problem is with having a double size MMIO window.
> 
> The pin diagram and stuff is just noise to me because I don't have that
> hardware and am not going to buy it just to try to figure out if there
> is a bug there or not.
> 
> >>
> >>> Currently, the kernel can sometimes assign the MMIO_PREF window
> >>> additional size into the MMIO window, resulting in double the MMIO
> >>> additional size, even if the MMIO_PREF window was successful.
> >>>
> >>> This happens if in the first pass, the MMIO_PREF succeeds but the MMIO
> >>> fails. In the next pass, because MMIO_PREF is already assigned, the
> >>> attempt to assign MMIO_PREF returns an error code instead of success
> >>> (nothing more to do, already allocated).
> >>>
> >>> Example of problem (more context can be found in the bug report URL):
> >>>
> >>> Mainline kernel:
> >>> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0xa00fffff] = 256M
> >>> pci 0000:06:04.0: BAR 14: assigned [mem 0xa0200000-0xb01fffff] = 256M
> >>>
> >>> Patched kernel:
> >>> pci 0000:06:01.0: BAR 14: assigned [mem 0x90100000-0x980fffff] = 128M
> >>> pci 0000:06:04.0: BAR 14: assigned [mem 0x98200000-0xa01fffff] = 128M
> >>>
> >>> This was using pci=realloc,hpmemsize=128M,nocrs - on the same machine
> >>> with the same configuration, with a Ubuntu mainline kernel and a kernel
> >>> patched with this patch series.
> >>>
> >>> This patch is vital for the next patch in the series. The next patch
> >>> allows the user to specify MMIO and MMIO_PREF independently. If the
> >>> MMIO_PREF is set to be very large, this bug will end up more than
> >>> doubling the MMIO size. The bug results in the MMIO_PREF being added to
> >>> the MMIO window, which means doubling if MMIO_PREF size == MMIO size.
> >>> With a large MMIO_PREF, without this patch, the MMIO window will likely
> >>> fail to be assigned altogether due to lack of 32-bit address space.
> >>>
> >>> Patch notes
> >>> ==========================================================================
> >>>
> >>> Change find_free_bus_resource() to not skip assigned resources with
> >>> non-null parent.
> >>>
> >>> Add checks in pbus_size_io() and pbus_size_mem() to return success if
> >>> resource returned from find_free_bus_resource() is already allocated.
> >>>
> >>> This avoids pbus_size_io() and pbus_size_mem() returning error code to
> >>> __pci_bus_size_bridges() when a resource has been successfully assigned
> >>> in a previous pass. This fixes the existing behaviour where space for a
> >>> resource could be reserved multiple times in different parent bridge
> >>> windows. This also greatly reduces the number of failed BAR messages in
> >>> dmesg when Linux assigns resources.
> >>
> >> This patch looks like the same bug that I tracked down earlier but I
> >> solved in a slightly different way. See this patch[1] which is still
> >> under review. Can you maybe test it and see if it solves the same problem?
> > 
> > I read [1] and it is definitely the same bug, without a doubt. This is 
> > fantastic because it means I have somebody to back me up on this. I will 
> > test the patch as soon as I can - perhaps after work today.
> > 
> > My initial thoughts of [1] patch are that restricting 64-bit BARs to 
> > 64-bit windows might break assigning 64-bit BARs on bridges without the 
> > optional prefetchable window. My patch should not have that issue - but 
> > after I have tested [1], it might turn out to be fine.
> > 
> > Correct me if I am wrong about assumptions about windows. My 
> > understanding cannot be perfect. As far as I know, 64-bit BARs should 
> > always be prefetchable, but I own the Aquantia AQC-107S NIC and it has 
> > three 64-bit non-pref BARs. It happens that they are assigned into the 
> > 32-bit window. I will see if [1] patch prevents that from happening or 
> > not.
> 
> As best as I can tell the patches should have identical functionality.
> My patch ignores the error returned by pbus_size_mem() your patch forces
> the function from returning an error inside it for the same case.
> 
> Logan
I finally tested this (not rigorously) and it appears to work the same 
as my patch and did not do anything strange. It solves the problem that 
it set out to fix. If you want to add my tested-by then that is fine.

I still slightly prefer my patch because it corrects the return codes 
instead of ignoring them. However, both patches have merits.

Bjorn, please advise on what you think is better and / or easier to sign 
off on.

In my PATCH v7, should I consider moving this to the end of the series 
so that any changes do not impact anything else? I.e. can remove the 
patch if we take Logan's version instead.

Also, if you decide to take Logan's patch, which of the following do I 
do?

a) drop the patch from my series and leave it at that (in this case I 
hope I can have a co-reported-by in Logan's patch when it gets accepted)

b) merge Logan's patch into my series, giving credit

c) something else


If you decide to take mine then we will need to discuss Logan's concerns 
about my documentation and I will need to update some more information 
into the bug report (or link both bug reports into the notes).

Cheers
