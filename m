Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93F2F5ADF7
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2019 04:57:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF3C5o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 29 Jun 2019 22:57:44 -0400
Received: from mail-oln040092253053.outbound.protection.outlook.com ([40.92.253.53]:47232
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbfF3C5o (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Jun 2019 22:57:44 -0400
Received: from SG2APC01FT053.eop-APC01.prod.protection.outlook.com
 (10.152.250.58) by SG2APC01HT102.eop-APC01.prod.protection.outlook.com
 (10.152.250.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Sun, 30 Jun
 2019 02:57:37 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.55) by
 SG2APC01FT053.mail.protection.outlook.com (10.152.250.240) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Sun, 30 Jun 2019 02:57:37 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Sun, 30 Jun 2019
 02:57:37 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Multitude of resource assignment functions
Thread-Topic: Multitude of resource assignment functions
Thread-Index: AQHVKm0pVEQv4eRpFkSF/OVkoIUtBaarA42AgAQe1oCAAJVXAIAD0oeA
Date:   Sun, 30 Jun 2019 02:57:37 +0000
Message-ID: <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
 <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
In-Reply-To: <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0025.ausprd01.prod.outlook.com
 (2603:10c6:1:15::13) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:C3237D181964FB58A52ECD5A8394EE96A44A96B3B1BBA909E4AD6F4F9DC02884;UpperCasedChecksum:2B39CC9951BFDA2E552A39813EADB3B3DAB02A457F1A7A1C4314EF729430852D;SizeAsReceived:8158;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [egM2Mv0UNcwQdpLJIqwqqeNu74zCx7p+u4ANWzDf6mCJLTSdWP2zd8uQDjX+ElN5VnY5oYOF22g=]
x-microsoft-original-message-id: <20190630025727.GB6175@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT102;
x-ms-traffictypediagnostic: SG2APC01HT102:
x-microsoft-antispam-message-info: IRCTPD/mCERP4+5FVCuinpWJXr5wUkC4w0BjgAldINZm52CKp4TxrXWHzZc7JTo0f/dJPISIDL7e1cJHn7jJuUJkx0QepDxZjIP3aRf8VLWfe+Iq4DIGKFZnslDYD6WvOQVs3C9xigE8O1Ecnah2aKvqxPDs+QVfrDi1xVqHtcFr7UPF5yzC+aVg0SuVyMsJ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1AD2BD7AE3CDC447BAD29A89E63E5C5B@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a227e27-d0a0-4ed1-4dfd-08d6fd06b4fb
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2019 02:57:37.1316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 27, 2019 at 10:35:12AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-27 1:40 a.m., Nicholas Johnson wrote:
> > On Mon, Jun 24, 2019 at 10:45:17AM -0600, Logan Gunthorpe wrote:
> >>
> >>
> >> On 2019-06-24 3:13 a.m., Benjamin Herrenschmidt wrote:
> >>> So I'm staring at these three mostly at this point:
> >>>
> >>> void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
> >>> void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> >>> void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
> >>>
> >>> Now we have 3 functions that fundamentally have the same purpose,
> >>> assign what was left unassigned down a PCI hierarchy, but are going
> >>> about it in quite a different manner.
> >>>
> >>> Now to make things worse, there's little consistency in which one gets
> >>> called where. We have PCI controllers calling the first one sometimes,
> >>> the last one sometimes, or doing the manual:
> >>>
> >>> 	pci_bus_size_bridges(bus);
> >>> 	pci_bus_assign_resources(bus);
> >>>
> >>> Or variants with pci_bus_size_bridges sometimes missing etc...
> >>
> >> I suspect there isn't much rhyme or reason to it. None of this is well
> >> documented so developers writing the controller drivers probably didn't
> >> have a good idea of what the correct thing to do was, and just stuck
> >> with the first thing that worked.
> >>
> >>> Now I've consolidated a lot of that and removed all of those "manual"
> >>> cases in my work-in-progress branch, but I'd like to clarify and
> >>> possibly remove the 3 ones above.
> >>>
> >>> Let's start with the last one, pci_assign_unassigned_bus_resources, as
> >>> it's the easiest to remove from users in drivers/pci/controller/* (and
> >>> replace with pci_assign_unassigned_root_bus_resources typically).
> >>>
> >>> This leaves it used in a couple of corner cases, most of them I think
> >>> I can kill, and .... sysfs 'rescan'.
> >>>
> >>> The interesting thing about that function is that it tries to avoid
> >>> resizing the bridge of the bus passed as an argument, it will only
> >>> resize subordinate bridges. From the changelog it was created for
> >>> hotplug bridges, but almost none uses it (some powerpc stuff I can
> >>> probably kill) ... and sysfs rescan.
> >>>
> >>> I wonder what's the remaining purpose of it. sysfs rescan could
> >>> probably be cleaned up to use the two first... Also why avoid resizing
> >>> the bridge itself ?
> >>>
> >>> That leads to the difference between
> >>> pci_assign_unassigned_root_bus_resources()
> >>> and pci_assign_unassigned_bridge_resources().
> >>>
> >>> The names are misleading. The former isn't just about the root bus
> >>> resources. It's about the entire tree underneath the root bus.
> >>>
> >>> The main difference that I can tell are:
> >>>
> >>>  - pci_assign_unassigned_root_bus_resources() may or may not try to
> >>> realloc, depending on a combination of command line args, config
> >>> option, presence of IOV devices etc... while
> >>> pci_assign_unassigned_bridge_resources() always will
> >>>
> >>>  - pci_assign_unassigned_bridge_resources() will call
> >>> pci_bridge_distribute_available_resources() to distribute resource to
> >>> child hotplug bridges, while pci_assign_unassigned_root_bus_resources()
> >>> won't.
> >>>
> >>> Now, are we 100% confident we want to keep those discrepancies ?
> >>>
> >>> It feels like the former function is intended for boot time resource
> >>> allocation, and the latter for hotplug, but I can't make sense of why
> >>> the resources of a device behind a hotplug bridge should be allocated
> >>> differently depending on whether that device was plugged at boot or
> >>> plugged later.
> >>
> >> I don't really know, but I kind of assumed reallocing any time but early
> >> in boot would be dangerous. It involves un-assigning a bunch of
> >> resources without any real check to see if a driver is using them or
> >> not. If they were being used by a driver (which is typical) and they
> >> were reassigned, everything would break.
> >>
> >> I mean, in theory the code could/should be the same for both paths and
> >> it could just make a single, better decision on whether to realloc or
> >> not. But that's going to be challenging to get there.
> >>
> >>> Also why not distribute available resources at boot between top level
> >>> hotplug bridges ?
> >>>
> >>> I'm not even going into the question of why the resource
> >>> sizing/assignment code is so obscure/cryptic/incomprehensible, that's
> >>> another kettle of fish, but I'd like to at least clarify the usage
> >>> patterns a bit better.
> >> I got the impression the code was designed to generally let the firmware
> >> set things up -- it just fixed things up if the firmware messed it up
> >> somehow. My guess would be it evolved out of a bunch of hacks designed
> >> to fix broken bioses into something new platforms used to do full
> >> enumeration (because it happened to work).
> > Unfortunately, the operating system is designed to let the firmware do 
> > things. In my mind, ACPI should not need to exist, and the operating 
> > system should start with a clean state with PCI and re-enumerate 
> > everything at boot time. The PCI allocation is so broken and 
> > inconsistent (as you have noted) because it tries to combine the two, 
> > when firmware enumeration and native enumeration should be mutually 
> > exclusive. I have attempted to re-write large chunks of probe.c, pci.c 
> > and setup-bus.c to completely disregard firmware enumeration and clean 
> > everything up. Unfortunately, I get stuck in probe.c with the double 
> > recursive loop which assigns bus numbers - I cannot figure out how to 
> > re-write it successfully. Plus, I feel like nobody will be ready for 
> > such a drastic change - I am having trouble selling minor changes that 
> > fix actual use cases, as opposed to code reworking.
> 
> My worry would be if the firmware depends on any of those PCI resources
> for any of it's calls. For example, laptop firmware often has specific
> code for screen blanking/dimming when the special buttons are pressed.
> If it implements this by communicating with a PCI device then the kernel
> will break things by reassigning all the addresses.
> 
> However, having a kernel parameter to ignore the firmware choices might
> be a good way for us to start testing whether this is a problem or not
> on some systems
> 
> Logan
If Bjorn also agrees then I will give it a shot when I have finished 
with Thunderbolt.

Some other related thoughts:

- Should pci=noacpi imply pci=nocrs? It does not appear to, and I feel 
like it should, as CRS is part of ACPI and relates to PCI.

- Does anybody know why with pci=noacpi, you get dmesg warnings about 
cannot find PCI int A mapping - but they do not seem to cause the 
devices any issues in functioning? Is it because they are using MSI?

- Does pci=ignorefw sound good for a future proposal?

- Modern arches could give this option by default if they want 
everything done by the OS. Although this would not be nearly as nice as 
a code overhaul or branching out pci into pci-old and pci-new.

- Thunderbolt has given me a glimmer of hope. It used to be so tightly 
integrated into the system firmware and add-in cards were not even 
detectable without it (you need to hit up the pcie2tbt mailbox in the 
BIOS to wake the controller up, for a start). It would not even show 
without ACPI running. Now I can use pci=noacpi with this patch series 
and work happily with Thunderbolt.

- I have not given iommu or intel_iommu parameters but I am getting DMAR 
faults (probably because I am using pci=noacpi) but normally the DMAR 
does not come on if you do not ask it to. Is there perhaps something 
recently added to do with Thunderbolt that is activating it? I 
understand that regardless, DMAR does not work well without ACPI. The 
main two I care about are DMAR and MADT (multiple processors) tables and 
otherwise, I would disable ACPI altogether.

Cheers,
Nicholas
