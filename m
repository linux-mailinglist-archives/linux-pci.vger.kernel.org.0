Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8EE57D51
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2019 09:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfF0Hk4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 27 Jun 2019 03:40:56 -0400
Received: from mail-oln040092255022.outbound.protection.outlook.com ([40.92.255.22]:6168
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726401AbfF0Hk4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jun 2019 03:40:56 -0400
Received: from PU1APC01FT052.eop-APC01.prod.protection.outlook.com
 (10.152.252.54) by PU1APC01HT056.eop-APC01.prod.protection.outlook.com
 (10.152.253.82) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Thu, 27 Jun
 2019 07:40:49 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.54) by
 PU1APC01FT052.mail.protection.outlook.com (10.152.253.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Thu, 27 Jun 2019 07:40:49 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2008.014; Thu, 27 Jun 2019
 07:40:49 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Multitude of resource assignment functions
Thread-Topic: Multitude of resource assignment functions
Thread-Index: AQHVKm0pVEQv4eRpFkSF/OVkoIUtBaarA42AgAQe1oA=
Date:   Thu, 27 Jun 2019 07:40:49 +0000
Message-ID: <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
In-Reply-To: <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY3PR01CA0090.ausprd01.prod.outlook.com
 (2603:10c6:0:19::23) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:5E2CF75C0DD90E22B95B5B5D7764E8F5ED822E1B7E2AE78B59DD953A9CEE2807;UpperCasedChecksum:3080A23A655C5749FA3D5356008660E99EE65D4AE1FD7AAD07E58534BB857E1A;SizeAsReceived:8004;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [bFSlDj86r9mft6N82qpucMZzU46ulkN2y3TeJ+tcZbdLXvVMDpEjcWFWP+bwHT00hT1NLqUGsFk=]
x-microsoft-original-message-id: <20190627074038.GA5604@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT056;
x-ms-traffictypediagnostic: PU1APC01HT056:
x-microsoft-antispam-message-info: ihlh/D3EmIbbu3Zphi6Eh0RotrKaZvdb6CybKk4HGoI4G4iT8L/Zagd43h7vSNgm/k3O3akF+KKZFnQBqNH1/OrHnTG7w151brzVrW60BTxEtcVzC66ixvxEcDsewWC71xcmxE1ic9ol7Ss+Fw5+alqraopA4ML1Sg9yKjZtbeXluev2tH20IJI1jwI15KIv
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9929694FDF13C8438C6F74D3CBF8F567@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 90593567-81a6-4534-93c2-08d6fad2c60c
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2019 07:40:49.8548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT056
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 24, 2019 at 10:45:17AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-06-24 3:13 a.m., Benjamin Herrenschmidt wrote:
> > So I'm staring at these three mostly at this point:
> > 
> > void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
> > void pci_assign_unassigned_bridge_resources(struct pci_dev *bridge)
> > void pci_assign_unassigned_bus_resources(struct pci_bus *bus)
> > 
> > Now we have 3 functions that fundamentally have the same purpose,
> > assign what was left unassigned down a PCI hierarchy, but are going
> > about it in quite a different manner.
> > 
> > Now to make things worse, there's little consistency in which one gets
> > called where. We have PCI controllers calling the first one sometimes,
> > the last one sometimes, or doing the manual:
> > 
> > 	pci_bus_size_bridges(bus);
> > 	pci_bus_assign_resources(bus);
> > 
> > Or variants with pci_bus_size_bridges sometimes missing etc...
> 
> I suspect there isn't much rhyme or reason to it. None of this is well
> documented so developers writing the controller drivers probably didn't
> have a good idea of what the correct thing to do was, and just stuck
> with the first thing that worked.
> 
> > Now I've consolidated a lot of that and removed all of those "manual"
> > cases in my work-in-progress branch, but I'd like to clarify and
> > possibly remove the 3 ones above.
> > 
> > Let's start with the last one, pci_assign_unassigned_bus_resources, as
> > it's the easiest to remove from users in drivers/pci/controller/* (and
> > replace with pci_assign_unassigned_root_bus_resources typically).
> > 
> > This leaves it used in a couple of corner cases, most of them I think
> > I can kill, and .... sysfs 'rescan'.
> > 
> > The interesting thing about that function is that it tries to avoid
> > resizing the bridge of the bus passed as an argument, it will only
> > resize subordinate bridges. From the changelog it was created for
> > hotplug bridges, but almost none uses it (some powerpc stuff I can
> > probably kill) ... and sysfs rescan.
> > 
> > I wonder what's the remaining purpose of it. sysfs rescan could
> > probably be cleaned up to use the two first... Also why avoid resizing
> > the bridge itself ?
> > 
> > That leads to the difference between
> > pci_assign_unassigned_root_bus_resources()
> > and pci_assign_unassigned_bridge_resources().
> > 
> > The names are misleading. The former isn't just about the root bus
> > resources. It's about the entire tree underneath the root bus.
> > 
> > The main difference that I can tell are:
> > 
> >  - pci_assign_unassigned_root_bus_resources() may or may not try to
> > realloc, depending on a combination of command line args, config
> > option, presence of IOV devices etc... while
> > pci_assign_unassigned_bridge_resources() always will
> > 
> >  - pci_assign_unassigned_bridge_resources() will call
> > pci_bridge_distribute_available_resources() to distribute resource to
> > child hotplug bridges, while pci_assign_unassigned_root_bus_resources()
> > won't.
> >
> > Now, are we 100% confident we want to keep those discrepancies ?
> > 
> > It feels like the former function is intended for boot time resource
> > allocation, and the latter for hotplug, but I can't make sense of why
> > the resources of a device behind a hotplug bridge should be allocated
> > differently depending on whether that device was plugged at boot or
> > plugged later.
> 
> I don't really know, but I kind of assumed reallocing any time but early
> in boot would be dangerous. It involves un-assigning a bunch of
> resources without any real check to see if a driver is using them or
> not. If they were being used by a driver (which is typical) and they
> were reassigned, everything would break.
> 
> I mean, in theory the code could/should be the same for both paths and
> it could just make a single, better decision on whether to realloc or
> not. But that's going to be challenging to get there.
> 
> > Also why not distribute available resources at boot between top level
> > hotplug bridges ?
> >
> > I'm not even going into the question of why the resource
> > sizing/assignment code is so obscure/cryptic/incomprehensible, that's
> > another kettle of fish, but I'd like to at least clarify the usage
> > patterns a bit better.
> I got the impression the code was designed to generally let the firmware
> set things up -- it just fixed things up if the firmware messed it up
> somehow. My guess would be it evolved out of a bunch of hacks designed
> to fix broken bioses into something new platforms used to do full
> enumeration (because it happened to work).
Unfortunately, the operating system is designed to let the firmware do 
things. In my mind, ACPI should not need to exist, and the operating 
system should start with a clean state with PCI and re-enumerate 
everything at boot time. The PCI allocation is so broken and 
inconsistent (as you have noted) because it tries to combine the two, 
when firmware enumeration and native enumeration should be mutually 
exclusive. I have attempted to re-write large chunks of probe.c, pci.c 
and setup-bus.c to completely disregard firmware enumeration and clean 
everything up. Unfortunately, I get stuck in probe.c with the double 
recursive loop which assigns bus numbers - I cannot figure out how to 
re-write it successfully. Plus, I feel like nobody will be ready for 
such a drastic change - I am having trouble selling minor changes that 
fix actual use cases, as opposed to code reworking.

My next proposal might be a kernel parameter for PCI to set various 
levels of disregard for firmware, from none to complete, which can be 
added to incrementally to do more and more (rather than all in one patch 
series). This can supercede pci=realloc. The realloc command is so 
broken because once the system has loaded drivers, it becomes next to 
impossible to free and reallocate a resource to fit another device in - 
because it will upset existing devices. The realloc command is only 
useful in early boot because nothing is yet assigned, so it works. 
However, the same effect can be achieved by releasing all the resources 
on the root port before anything happens. I think it was 
pci_assign_unassigned_resources(), and I did verify this experimentally. 
This switch could be part of such a new kernel parameter to ignore 
firmware influence on PCI.

I hope that somehow we can transition to ignoring the firmware - because 
firmware and native enumeration need to be mutually exclusive, and we 
need native enumeration for PCI hotplug. If anybody has any ideas how, I 
would love to hear.

Nicholas

> 
> Logan
