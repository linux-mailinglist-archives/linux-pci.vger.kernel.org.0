Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1305E5AC
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 15:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbfGCNoB convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 3 Jul 2019 09:44:01 -0400
Received: from mail-oln040092253041.outbound.protection.outlook.com ([40.92.253.41]:61049
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725830AbfGCNoA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 09:44:00 -0400
Received: from SG2APC01FT026.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT110.eop-APC01.prod.protection.outlook.com
 (10.152.251.179) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Wed, 3 Jul
 2019 13:43:53 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
 SG2APC01FT026.mail.protection.outlook.com (10.152.250.190) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Wed, 3 Jul 2019 13:43:53 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Wed, 3 Jul 2019
 13:43:52 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Multitude of resource assignment functions
Thread-Topic: Multitude of resource assignment functions
Thread-Index: AQHVKm0pVEQv4eRpFkSF/OVkoIUtBaarA42AgAQe1oCAAJVXAIAD0oeAgAReQICAAQ1HAA==
Date:   Wed, 3 Jul 2019 13:43:52 +0000
Message-ID: <SL2P216MB01878623FC34BC4894EB495280FB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
 <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
 <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190702213951.GF128603@google.com>
In-Reply-To: <20190702213951.GF128603@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0183.ausprd01.prod.outlook.com
 (2603:10c6:10:52::27) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:E96CF31610F05DAE052401268F700BA7C6FEEA1053D34059A577D9BA9C7BC2AB;UpperCasedChecksum:BE3CC3D2C4B346CEC5A38216580DA4757D1D1B58253A80DECF9E5B1F0252CBEB;SizeAsReceived:8203;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [GjluEtbA2lU5J/lVmPjL0f5mrOLsBfkt4Mr/Gk86yVQuuFn/V5PKsylTkznZ5NMIXa/kQk51fZo=]
x-microsoft-original-message-id: <20190703134336.GA1840@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT110;
x-ms-traffictypediagnostic: SG2APC01HT110:
x-microsoft-antispam-message-info: O7+YmrrEtKQ4S/4i1s5YgmNpekSgjZ2r6EbQWlE74ADqNZjObh/3ALQzW7ggYiAQOHJUCGilTsZpPa/ok5c+oB+m1yEW6gu/o6BZl56lyP0zEH1lpYS14e39jOhp1W1HWuwycfIcSk1P8DS6aG6BGbjdp+B9g0sz0sBq9o1BeM5+Lc5baTxGvlAxeZFaTHGp
Content-Type: text/plain; charset="us-ascii"
Content-ID: <0B09E615A129414FA305AEF472242B47@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: c42f1679-102f-4c6e-af70-08d6ffbc7c22
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2019 13:43:52.5409
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT110
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 02, 2019 at 04:39:51PM -0500, Bjorn Helgaas wrote:
> On Sun, Jun 30, 2019 at 02:57:37AM +0000, Nicholas Johnson wrote:
> 
> > - Should pci=noacpi imply pci=nocrs? It does not appear to, and I feel 
> > like it should, as CRS is part of ACPI and relates to PCI.
> 
> "pci=noacpi" means "Do not use ACPI for IRQ routing or for PCI
> scanning."
> 
> "pci=nocrs" means "Ignore PCI host bridge windows from ACPI."  If we
> ignore _CRS, we have no idea what the PCI host bridge apertures are,
> so we cannot allocate resources for devices on the root bus.
But I use pci=nocrs (it is non-negotiable for assigning massive 
MMIO_PREF with kernel parameters) and it does work. If I use pci=nocrs, 
then the whole physical address range of the CPU goes to the root 
complex (for example, 39-bit physical address lines on quad-core Intel 
is 512G). I am guessing that the OS makes sure that when assigning root 
port windows, we do not clobber the physical RAM so that any RAM 
addresses pass straight through the root complex. I have never had funny 
crashes that would make me think I have clobbered the RAM with nocrs. If 
I push the limits then it fails to assign root port resources as 
expected. Usually I assign 64G size to each Thunderbolt port for total 
of 256G over four ports. It is total overkill but it gives me 
satisfaction to know that the firmware is definitely not in control and 
that if it is needed, it can be requested. For a production system, I 
would likely tone it down a little.

> 
> The "Do not use ACPI for ... PCI scanning" part indeed does suggest
> that "pci=noacpi" could imply "pci=nocrs", but I don't think there's
> anything to be gained by changing that now.
> 
> We probably *should* remove "or for PCI scanning" from the
> documentation, because "pci=noacpi" only affects IRQs.
> 
> The only reason these exist at all is as a debugging aid to
> temporarily work around issues in firmware or Linux until we can
> develop a real fix or quirk that works without the user specifying a
> kernel parameter.
> 
> > - Does anybody know why with pci=noacpi, you get dmesg warnings about 
> > cannot find PCI int A mapping - but they do not seem to cause the 
> > devices any issues in functioning? Is it because they are using MSI?
> 
> I doubt it.  I think you're just lucky.  In general the information
> from _PRT and _CRS is essential for correct operation.
Strange, because there are dozens of these warnings on multiple 
computers and heaps of devices on Thunderbolt. If the BARs are assigned 
then they work, every time, no questions asked. Maybe this suggests that 
Thunderbolt is somehow exempt. Perhaps the controller has kept 
configuration from the firmware setup and everything behind it does not 
care.

> 
> > - Does pci=ignorefw sound good for a future proposal?
> 
> No, at least not without more description of what this would
> accomplish.
I have not given it much time and thought but basically it will be 
something that can be added to incrementally. I would start with it 
implying nocrs and releasing all root complex resources at boot before 
the initial scan. That way we can see if the particular platform cares 
if we do everything in the kernel.

> 
> It sounds like you would want this to turn off _PRT, _CRS, and other
> information from ACPI.  You may not like ACPI, but that information is
> there for good reason, and if we didn't get it from ACPI we would have
> to get it from somewhere else.
The nocrs is vital because the BIOS places pitiful space behind the root 
complex and will fail for assigning large BARs - hence why Xeon Phi 
coprocessors with 8G or 16G BARs to map their whole RAM are only 
supported on certain systems. I consider all BIOS / firmware to be 
broken at this time, especially with most still catering for 32-bit OS 
that almost nobody uses. I know not everybody feels that way, but I am 
an idealist and aim to move things in the right direction.

I would accept ACPI if it were just a collection of tables, memory 
mapped like MMCONFIG. I know there are more complicated things that 
require bytecode to run (although I do assert my belief that it should 
be avoided if possible) but if the static tables were moved out of ACPI 
then in my mind, it would be progress.

Is there a reason why PCI SIG could not add a future extension where all 
of this information can be accessed with an extended MMCONFIG address 
range?

> 
> There is always "acpi=off" if you just don't want ACPI at all.
> 
> Bjorn
I am aware, and I will happily use that when there is a way to manually 
specify DMAR and MADT information. If you use acpi=off presently, you 
lose all but one CPU core and the use of IOMMU. There used to be acpi=ht 
to disable ACPI for everything except for HyperThreading, but that was 
removed a long time ago - I do not know why.

The reason I often test like this is because it gives me reassurance 
that my code is not working by fluke on the particular system because of 
a firmware quirk. Also, Thunderbolt was deeply entrenched in ACPI 
before, so I am kind of over-compensating to make sure that there is no 
longer any unconditional dependency.

Nicholas
