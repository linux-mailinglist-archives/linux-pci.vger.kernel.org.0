Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 503375ADF5
	for <lists+linux-pci@lfdr.de>; Sun, 30 Jun 2019 04:40:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbfF3Ckm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 29 Jun 2019 22:40:42 -0400
Received: from mail-oln040092254035.outbound.protection.outlook.com ([40.92.254.35]:47616
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726416AbfF3Ckl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Jun 2019 22:40:41 -0400
Received: from SG2APC01FT007.eop-APC01.prod.protection.outlook.com
 (10.152.250.54) by SG2APC01HT025.eop-APC01.prod.protection.outlook.com
 (10.152.251.170) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2032.15; Sun, 30 Jun
 2019 02:40:36 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.54) by
 SG2APC01FT007.mail.protection.outlook.com (10.152.250.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2032.15 via Frontend Transport; Sun, 30 Jun 2019 02:40:36 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::9d2d:391f:5f49:c806%6]) with mapi id 15.20.2032.019; Sun, 30 Jun 2019
 02:40:36 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Multitude of resource assignment functions
Thread-Topic: Multitude of resource assignment functions
Thread-Index: AQHVKm0pVEQv4eRpFkSF/OVkoIUtBaarA42AgAQe1oCAABL4gIAEUCSA
Date:   Sun, 30 Jun 2019 02:40:36 +0000
Message-ID: <SL2P216MB01871C19CA4C0477105B567E80FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
 <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <1a0e2012fd26685819cb1ee83180405717f690be.camel@kernel.crashing.org>
In-Reply-To: <1a0e2012fd26685819cb1ee83180405717f690be.camel@kernel.crashing.org>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0177.ausprd01.prod.outlook.com
 (2603:10c6:10:52::21) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:24DE2D0A07BF3FFE83A64EBBA386FE8248ACBE30E7DEC861389DBB43F2B033C6;UpperCasedChecksum:3B66F180301FCC4B814CB3984E642618C7E8AB08EC6E8B2EDC196406890830C3;SizeAsReceived:8187;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Cei/Vi0f+hFuCNcxzeZs21yd5CugTeKbvcMlG5Lhyw/8XT4ZXEWZh7v7TPRVKr+PD0hmYYEfFWI=]
x-microsoft-original-message-id: <20190630024024.GA6175@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT025;
x-ms-traffictypediagnostic: SG2APC01HT025:
x-microsoft-antispam-message-info: 9ArKtoXVvhu3MkRFKw+PK6Blt8LysMzLW5LloXg5+CqKixXmzcEuLmY8MaTht84gdXHpYZ0HaunNBqssrzhw8Sn+mtYYEiCGutq6GCe+RRhFwszX4x882mic1dwu7Ony6XjUp2Srwvs+hH6pYaknnsMl/YkmJ7+0WkL/B0Fk6Ag9xwARQsJ91dpB5PAtxZ1A
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7494C3DBD8DB914BB45AC74811D73F2C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 2081cfda-4838-4960-4d71-08d6fd04546f
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2019 02:40:36.3205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT025
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Thank you for the reply. I have been mulling it over for a while.

On Thu, Jun 27, 2019 at 06:48:35PM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2019-06-27 at 07:40 +0000, Nicholas Johnson wrote:
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
> Well... so a lot of platforms are happy to do a full re-assignment,
> though they use the current code today which leads to rather sub
> standard results when it comes to hotplug bridges.
> 
> All the embedded platforms today are like that,and all of ARM64 though
> the latter will somewhat change, all DT based ARM64 will probably
> remain that way.
> 
> > My next proposal might be a kernel parameter for PCI to set various 
> > levels of disregard for firmware
> 
> Well, at least ACPI has this _DSM #5 thingy that can tell us that we
> are allowed to disregard firmware for selected bits and pieces
> (hopefully that tends to be whole hierarchies but I don't know how well
> it's used in practice).
I will need to find out more about this - can you suggest any 
particularly good resources on learning about ACPI?

> 
> > , from none to complete, which can be 
> > added to incrementally to do more and more (rather than all in one patch 
> > series).
> 
> So there are a number of reasons to honor what the firmware did.
> 
> First, today (but that's fixable), we suck at setting up reasonable
> space for hotplug by default.
What annoys me more is that the BIOS vendors

a) don't provide means to 
configure this in the BIOS, and if they do, it is hidden options which 
require you to re-flash the BIOS or use the dumped IFRs and EFI shell to 
modify the variables

b) Even the few motherboards with the options for Thunderbolt available 
without resorting to (a) have it limited to 4096M.

c) Motherboards are still cramming us into the 32-bit address space in 
case somebody is still using a 32-bit OS. There is the "above 4G 
decoding option" available on most motherboards, but I am not sure if 
that completely fixes the issue. Given that Microsoft said you need 
Windows 10 to run on the latest hardware, I do not see many people using 
32-bit OS on the latest hardware.

d) These options are especially needed because Windows cannot override 
anything whatsoever. Not even _OSC like pcie_ports=native on Linux.

> 
> But there are more insidious ones. There are platforms where you can't
> move things (typically virtualized platforms with specific hypervisors,
> such as IBM pseries).
I cannot argue with this.

> 
> There are platforms where the *runtime* firwmare (SMM or equivalent or
> even ACPI AML bits) will be poking at some system devices and those
> really must not be moved. (In fact there's a theorical problem with
> such devices becoming temporarily inaccessible during BAR sizing today
> but we mostly get lucky).
I think SMM is a nasty back door. Unfortunately the precident set is 
that the firmware makers can do what they want and we are expected to 
honour that in the kernel. In an ideal world, it would default to the OS 
assigning things and the firmware vendors getting blamed when things 
break if they insist on using runtime firmware.

In my ideal world, motherboards would have the absolute bare minimum in 
BIOS to initialise DRAM and the tricky stuff, and then boot a CoreBoot 
Linux kernel off a MicroSD slot on the board. This could easily be 
updated constantly (for example, to add NVMe support to old boards) and 
it would be impossible to brick the motherboard by changing this, as the 
SD card could be removed and restored.

This would fix the following:
- No longer need for PCI option ROMs and 
their security issues
- Open source / free firmware
- Will not need firmware updates to add NVMe boot support
- Allow target OS booted with kexec to assign resources as required
- Set up IOMMU for Thunderbolt (and all DMA ports) at boot time without 
special BIOS updates required
- Etc

I am sure there are problems to what I am saying, but I do find it 
frustrating that the industry has the inability to move on from legacy 
to the massive extent that it does.

When you have an arch, you expect that the same bytecode will run on the 
next system with that same arch. I don't understand why it stops there - 
I believe two systems of the same arch should be indistinguishable - 
without all of the firmware differences, and I hope to influence this 
during my career.

> 
> There are other "interesting" cases, like EFI giving us the framebuffer
> address to use if we don't have a native driver... which happens to be
> off a PCI BAR somewhere. Now we *could* probably try to special case
> that and detect when we move that BAR but today we'll probably break if
> we move it.
Also fixed by CoreBoot which will have the Linux kernel and all the 
drivers - no need for legacy services like this.

> 
> x86 historically has other nasty "hidden" devices. There are historical
> cases of devices that break if they move after initial setup, etc...
> Most of these things are ancient but we have to ensure we keep today's
> policy for old platforms at least.
Sometimes I think that we need a fork of Linux. Although that would be 
the same as saying "for old systems, support ends on this kernel version 
and you are unlikely to need the new features of the latest kernels on 
oldest hardware". They did drop the older X86 recently, I believe.

> 
> >  This can supercede pci=realloc. The realloc command is so 
> > broken because once the system has loaded drivers, it becomes next to 
> > impossible to free and reallocate a resource to fit another device in - 
> > because it will upset existing devices. The realloc command is only 
> > useful in early boot because nothing is yet assigned, so it works. 
> > However, the same effect can be achieved by releasing all the resources 
> > on the root port before anything happens. I think it was 
> > pci_assign_unassigned_resources(), and I did verify this experimentally. 
> > This switch could be part of such a new kernel parameter to ignore 
> > firmware influence on PCI.
> 
> We should see what ACPI gives us in _DSM #5 on x86 these days.. if it's
> meaningful on enough machines we could use that as an indication that a
> given tree can be reallocated.
> 
> > I hope that somehow we can transition to ignoring the firmware - because 
> > firmware and native enumeration need to be mutually exclusive, and we 
> > need native enumeration for PCI hotplug. If anybody has any ideas how, I 
> > would love to hear.
> 
> We'll probably have to live with an "in-between" forever on x86 and
> maybe arm64, but with some luck, the static devices will only be the
> on-board stuff, and we can go wild below bridges...
The rest was just speculation and thoughts. My real question here is: 
What path do we have towards modernisation? We cannot replace the PCI 
code to handle everything natively and disregard the firmware for modern 
architectures like the emerging RISC-V because that code will screw up 
X86. So do we have to have pci-old and pci-new subsystems which can be 
elected by each arch?

> 
> BTW: I'd like us to discuss that f2f at Plumbers in a miniconf if
> enough of us can go.
Please explain this as I have no idea what f2f, Plumbers and miniconf 
are.

Cheers,
Nicholas

> 
> Cheers,
> Ben.
> 
> 
