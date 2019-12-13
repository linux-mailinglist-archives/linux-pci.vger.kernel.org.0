Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 76EF811E011
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 10:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfLMJAk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 13 Dec 2019 04:00:40 -0500
Received: from mail-oln040092254039.outbound.protection.outlook.com ([40.92.254.39]:6038
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725747AbfLMJAk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 04:00:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kIopUBrXDfY0w65gg9P9mxEwfNtycxn20C/GQsp5U8xobpKB3UWFyAv77LKPSuUy8JYJKsVLR90UcL/LIYoiEX7/aSq8TpgJ72mlL4imCetEVhizVc9FUVdXKzOUN1T6n5kH2WK0lAtZov6g8+qKV7bV3Wyul2G4xQiQXAneKJRbLU1gHFstXZFYdJhFnjTm2s5AHJPjuL5M4oJd+RJyb30HMenfCdTE8OsQ8+rRZaiufaoVbpeKgIg+Q6DXuIViafNs+kxwBPlTO3gFRIpipuCAqdfEFdVJyAJgY8r4fkvIPCZaNeIOXCsolIY9gUgGyh3E5a41l7RCW2lG6LKxNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFyMTuXo/kBFqZc39Fw7HszGH/R7cC9/mJ7DzKdiQcg=;
 b=j2DNp+VnHdxirahPczKzE4NjyCjNtz0yYvjqonTLuLykviDg1A0+nwY+Faj1jXlivfaKSvuL6b+VXrCGJvSem+oKlAgDeNX/15lSy1GHp9zBteSem/s0Nm5yfc8A0MwlQAR9DVf3ldY0m4RbXMCe1d+fjUWGfhrOO/c2h1/qwj4/AAfwN9zps5WXATsw0e0uu8w5a0NE/h1DIpDeVPdk72l6Ilj+f0J3CBVjlv8nrh8I4ZyPsRvXd7nI3KGUUc/EVzx71q1eASW66ULu0scLqebWiGxlwSHWUxAuBplowPCpSsFd3w0d8dx7cDfgTZ4c9LqxBt8Q9JTiO3qmbeueWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT020.eop-APC01.prod.protection.outlook.com
 (10.152.252.53) by PU1APC01HT009.eop-APC01.prod.protection.outlook.com
 (10.152.252.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Fri, 13 Dec
 2019 09:00:32 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.252.58) by
 PU1APC01FT020.mail.protection.outlook.com (10.152.252.217) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15 via Frontend Transport; Fri, 13 Dec 2019 09:00:32 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2538.017; Fri, 13 Dec
 2019 09:00:32 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Stefan Roese <sr@denx.de>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
Thread-Topic: PCIe hotplug resource issues with PEX switch (NVMe disks) on AMD
 Epyc system
Thread-Index: AQHVsZBJH4x6UZhJJ0OzP9pilhD//ae3xGIA
Date:   Fri, 13 Dec 2019 09:00:32 +0000
Message-ID: <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
In-Reply-To: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0201.ausprd01.prod.outlook.com
 (2603:10c6:220:34::21) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:302DB9D84D9B43F02A55B5106BBB4F0EA5A311DC940E80C5349703FD71215AC8;UpperCasedChecksum:B4F9290D51F5EF717500BF6115EC959A2B82CC5E0C7A5C99C2FC7F4F26BC3C6F;SizeAsReceived:7553;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [Bul4mwBvdchTydGUgFf10SWEBY2+/xr6]
x-microsoft-original-message-id: <20191213090024.GA1528@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: f4fe648e-b4de-4102-0311-08d77faae86d
x-ms-traffictypediagnostic: PU1APC01HT009:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: INCHJ6kpah7XocreWHIkWCjGtnKpnCahv+NlGNSXCp2pbq7UCbVHqYmjVT0apn3tYdeha12RFGssV8PXNYelzwrg/EhHxaH5DrJqBa6p9hPJm2O0YjRh4HtdBRKJyi54Ky3vTXWS0D4ot+mOclB9BmscUIlFBSUZ66SyVHMdetOKvJy2Pawe7xwmOKkaboFS7S6bHiVZVGUrGmUcA+d06DbDRY8bYBQzETYPsC7/kuc=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <D1003FF60582F84C9E582A7CBC6DF50C@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f4fe648e-b4de-4102-0311-08d77faae86d
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 09:00:32.1988
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT009
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 09:35:19AM +0100, Stefan Roese wrote:
> Hi!
Hi,
> 
> I am facing an issue with PCIe-Hotplug on an AMD Epyc based system.
> Our system is equipped with an HBA for NVMe SSDs incl. PCIe switch
> (Supermicro AOC-SLG3-4E2P) [1] and we would like to be able to hotplug
> NVMe disks.
> 
> Currently, I'm testing with v5.5.0-rc1 and series [2] applied. Here
> a few tests and results that I did so far. All tests were done with
> one Intel NVMe SSD connected to one of the 4 NVMe ports of the HBA
> and the other 3 ports (currently) left unconnected:
> 
> a) Kernel Parameter "pci=pcie_bus_safe"
> The resources of the 3 unused PCIe slots of the PEX switch are not
> assigned in this test.
> 
> b) Kernel Parameter "pci=pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> With this test I restricted the resources of the HP slots to the
> minimum. Still this results in unassigned resourced for the unused
> PCIe slots of the PEX switch.
> 
> c) Kernel Parameter "pci=realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> Again, not all resources are assigned.
> 
> d) Kernel Parameter "pci=nocrs,realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> Now all requested resources are available for the HP PCIe slots of the
> PEX switch. But the NVMe driver fails while probing. Debugging has
> shown, that reading from the BAR of the NVMe disk returns 0xffffffff.
> Also reading from the PLX PEX switch registers returns 0xfffffff in this
> case (this works of course without nocrs, when the BARs are mapped at
> a different address).
> 
> Does anybody have a clue on why the access to the PEX switch and / or
> the NVMe BAR does not work in the "nocrs" case? The BARs are located in
> the same window that is provided by the BIOS in the ACPI list (but is
> "ignored" in this case) [3].
> 
> Or if it is possible to get the HP resource mapping done correctly without
> setting "nocrs" for our setup with the PCIe/NVMe switch?
> 
> I can provide all sorts of logs (dmegs, lspci etc) if needed - just let
> me know.
> 
> Many thanks in advance,
> Stefan
This will be a quick response for now. I will get more in depth tonight 
when I have more time.

What I have taken away from this is:

1. Epyc -> Up to 4x PCIe Root Complexes, but from what I can gather, 
they are probably assigned on the same segment / domain, unfortunately, 
with non-overlapping bus numbers. Either way, multiple RCs may 
complicate using pci=nocrs and others. Unfortunately, I have not had the 
privilege of owning a system with multiple RCs, so I cannot be sure.

2. Not using Thunderbolt - [2] patch series only really makes a 
difference with nested hotplug bridges, such as in Thunderbolt. 
Although, it might help by not using additional resource lists, but I 
still do not think it will matter without nested hotplug bridges.

3. System not reallocating resources despite overridden -> is ACPI _DSM 
method evaluating to zero? I experienced this recently with an Intel Ice 
Lake system. I booted the laptop at the retail store into Linux off a 
USB to find out about the Thunderbolt implementation. I dumped "sudo 
lspci -xxxx" and dmesg and analysed the results at home. I noticed it 
did not override the resources, and from examining the source code, it 
likely evaluated _DSM to 0, which may have overridden pci=realloc. Try 
modifying the source code to unconditionally apply realloc in 
drivers/pci/setup-bus.c and see what happens. I have not bothered doing 
this myself and going back to the store to try to test this hypothesis.

4. It would be helpful if you attached full dmesg and "sudo lspci -xxxx" 
which dumps full PCI config, allowing us to run any lspci query as if we 
were on your system, from the file. I will be able to tell a lot more 
after seeing that. Possibly do one with no kernel parameters, and do 
another set of results with all of the kernel parameters. Use 
hpmmiosize=64M and hpmmioprefsize=1G for it to be noticeable, I reckon. 
But this will answer questions I have about which ports are hotplug 
bridges and other things.

5. There is a good chance it will not even boot since kernel since 
around ~v5.3 with acpi=off but it is worth a shot there, also. Since a 
recent kernel, I have found that acpi=off only removes HyperThreading, 
and not all the physical cores like it used to. So there must have been 
a patch which allowed it to guess the MADT table information. I have not 
investigated. But now, some of my computers crash upon loading the 
kernel with acpi=off. It must get it wrong at times. What about 
pci=noacpi instead?

Sorry if I missed something you said.

Best of luck, and I am interested into looking into this further. :)

Kind regards,
Nicholas Johnson

> 
> [1] https://www.supermicro.com/en/products/accessories/addon/AOC-SLG3-4E2P.php
> [2] https://lkml.org/lkml/2019/12/9/388
> [3]
> [    0.701932] acpi PNP0A08:00: host bridge window [io  0x0cf8-0x0cff] (ignored)
> [    0.701934] acpi PNP0A08:00: host bridge window [io  0x0000-0x02ff window] (ignored)
> [    0.701935] acpi PNP0A08:00: host bridge window [io  0x0300-0x03af window] (ignored)
> [    0.701936] acpi PNP0A08:00: host bridge window [io  0x03e0-0x0cf7 window] (ignored)
> [    0.701937] acpi PNP0A08:00: host bridge window [io  0x03b0-0x03df window] (ignored)
> [    0.701938] acpi PNP0A08:00: host bridge window [io  0x0d00-0x3fff window] (ignored)
> [    0.701939] acpi PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff window] (ignored)
> [    0.701939] acpi PNP0A08:00: host bridge window [mem 0x000c0000-0x000dffff window] (ignored)
> [    0.701940] acpi PNP0A08:00: host bridge window [mem 0xec000000-0xefffffff window] (ignored)
> [    0.701941] acpi PNP0A08:00: host bridge window [mem 0x182c8000000-0x1ffffffffff window] (ignored)
> ...
> 41:00.0 PCI bridge: PLX Technology, Inc. PEX 9733 33-lane, 9-port PCI Express Gen 3 (8.0 GT/s) Switch (rev b0) (prog-if 00 [Normal decode])
>         Flags: bus master, fast devsel, latency 0, IRQ 47, NUMA node 2
>         Memory at ec400000 (32-bit, non-prefetchable) [size=256K]
>         Bus: primary=41, secondary=42, subordinate=47, sec-latency=0
>         I/O behind bridge: None
>         Memory behind bridge: ec000000-ec3fffff [size=4M]
>         Prefetchable memory behind bridge: None
>         Capabilities: <access denied>
>         Kernel driver in use: pcieport
> epyc@epyc-Super-Server:~/stefan$ sudo ./memtool md 0xec400000+0x10
> ec400000: ffffffff ffffffff ffffffff ffffffff                ................
