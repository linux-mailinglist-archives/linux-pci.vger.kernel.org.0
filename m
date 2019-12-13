Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A55DA11E309
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2019 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfLMLya convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Fri, 13 Dec 2019 06:54:30 -0500
Received: from mail-oln040092254026.outbound.protection.outlook.com ([40.92.254.26]:26448
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726717AbfLMLya (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 13 Dec 2019 06:54:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3SzfG5aSw9VGS3xycqNWlC01+xSmqzptfggNtYVdLE1kBcKfSB68ukPa39vJFSyooXi7WRry3I4vIL54iXH1bMK/ggqEr8ve+6VGLaBrD3UIeIskRKdLwYsG4x/oDI/Zsd5UYtgldh/yqPYB1AjResNuOO9jxT6QugyDT0zQABg5yaoaHijWuD4SSxbnIMdSjxCE5Z0bdl7jP/sqreyxWWzXqJTPu+rH7qClFwIpjgAGMP/PgeibqWEJGyI6yIe/LMGulG4aCyZ8lYGC4cUUfRIgAcJA79RjTERUHy45G71+pK/CvDB/276seH0yfH4LOPH88s4SciFcu39tHhX8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yMhzyEJsFo5hTGjxvGapc9TCn4OBc36rXEa+7Z4J6X8=;
 b=k7SJKiSBV3vDG/kIKkTW6rwasW0kW6bok8ugXNVt9pqVLEDkDweDRUPTOagNazU4hlfbyPwwoYjSXxQDx7hvT8AFrzPOtaP7otOWqDtHeIfLx8d2rljd18/vc1LY2Q7XvHrdAlaeAkupSb2WHOV3iAuVtuNA4mA4vCcxQuF3RNVmKD6jYv3x10BOJhizX3Q89qXSglU+mZj0BTbZ0mWmvQ5A0HTUlGWlE7/fhCPcuP72rLcd1YNtoBrSi29amRp8iwr/Vtv37TEqJEkaNKTpsxy1CoWPpoVQu+iRZoppUw2ZYC9oR50WvEWvZSv2KTDKx4nzqQIcZvghqeBBT4ZRDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT015.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT202.eop-APC01.prod.protection.outlook.com
 (10.152.249.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Fri, 13 Dec
 2019 11:52:44 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.53) by
 HK2APC01FT015.mail.protection.outlook.com (10.152.248.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15 via Frontend Transport; Fri, 13 Dec 2019 11:52:44 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2538.017; Fri, 13 Dec
 2019 11:52:43 +0000
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
Thread-Index: AQHVsZBJH4x6UZhJJ0OzP9pilhD//ae3xGIAgAAhGoCAAA8BgA==
Date:   Fri, 13 Dec 2019 11:52:43 +0000
Message-ID: <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
 <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
In-Reply-To: <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0064.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::28) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:CC05112F1C1F625FE73CAD7DE4D221A59973353B3A9A3917321273127C5F5A82;UpperCasedChecksum:992198A55263D72353C7085A8BBEB424C3929735CC0043603F22B7A56B410668;SizeAsReceived:7705;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [1k62aGO/OMyGfZzgIrdM+nej3Xbgd08Y]
x-microsoft-original-message-id: <20191213115235.GA1456@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: b0f2f5a9-7204-4aba-667f-08d77fc2f688
x-ms-traffictypediagnostic: HK2APC01HT202:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OGGwLywm2bkQmybs86OIiXL7nNDYLeFYMbe4dObsqQuCbQ/UzfdU2W/j8ZQW76W5HTp5Gl8UQHGfSA9Ju+EkKrDFVCch2ZBGR7YvLgOQCYd+X5C6BCg1+r1CXHpXiP5EaewIVaXu66GPuuOe7GNTP/G/JN13K5JkzZcsLaEdoK1ZLO8B8PqCJRbLzniKEg/3
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <072012C910C0EB44A82CF2F126F44658@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f2f5a9-7204-4aba-667f-08d77fc2f688
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2019 11:52:43.7609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT202
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 13, 2019 at 11:58:53AM +0100, Stefan Roese wrote:
> Hi Nicholas,
> 
> On 13.12.19 10:00, Nicholas Johnson wrote:
> > On Fri, Dec 13, 2019 at 09:35:19AM +0100, Stefan Roese wrote:
> > > Hi!
> > Hi,
> > > 
> > > I am facing an issue with PCIe-Hotplug on an AMD Epyc based system.
> > > Our system is equipped with an HBA for NVMe SSDs incl. PCIe switch
> > > (Supermicro AOC-SLG3-4E2P) [1] and we would like to be able to hotplug
> > > NVMe disks.
> > > 
> > > Currently, I'm testing with v5.5.0-rc1 and series [2] applied. Here
> > > a few tests and results that I did so far. All tests were done with
> > > one Intel NVMe SSD connected to one of the 4 NVMe ports of the HBA
> > > and the other 3 ports (currently) left unconnected:
> > > 
> > > a) Kernel Parameter "pci=pcie_bus_safe"
> > > The resources of the 3 unused PCIe slots of the PEX switch are not
> > > assigned in this test.
> > > 
> > > b) Kernel Parameter "pci=pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> > > With this test I restricted the resources of the HP slots to the
> > > minimum. Still this results in unassigned resourced for the unused
> > > PCIe slots of the PEX switch.
> > > 
> > > c) Kernel Parameter "pci=realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> > > Again, not all resources are assigned.
> > > 
> > > d) Kernel Parameter "pci=nocrs,realloc,pcie_bus_safe,hpmemsize=0,hpiosize=0,hpmmiosize=1M,hpmmioprefsize=0"
> > > Now all requested resources are available for the HP PCIe slots of the
> > > PEX switch. But the NVMe driver fails while probing. Debugging has
> > > shown, that reading from the BAR of the NVMe disk returns 0xffffffff.
> > > Also reading from the PLX PEX switch registers returns 0xfffffff in this
> > > case (this works of course without nocrs, when the BARs are mapped at
> > > a different address).
> > > 
> > > Does anybody have a clue on why the access to the PEX switch and / or
> > > the NVMe BAR does not work in the "nocrs" case? The BARs are located in
> > > the same window that is provided by the BIOS in the ACPI list (but is
> > > "ignored" in this case) [3].
> > > 
> > > Or if it is possible to get the HP resource mapping done correctly without
> > > setting "nocrs" for our setup with the PCIe/NVMe switch?
> > > 
> > > I can provide all sorts of logs (dmegs, lspci etc) if needed - just let
> > > me know.
> > > 
> > > Many thanks in advance,
> > > Stefan
> > This will be a quick response for now. I will get more in depth tonight
> > when I have more time.
> > 
> > What I have taken away from this is:
> > 
> > 1. Epyc -> Up to 4x PCIe Root Complexes, but from what I can gather,
> > they are probably assigned on the same segment / domain, unfortunately,
> > with non-overlapping bus numbers. Either way, multiple RCs may
> > complicate using pci=nocrs and others. Unfortunately, I have not had the
> > privilege of owning a system with multiple RCs, so I cannot be sure.
> > 
> > 2. Not using Thunderbolt - [2] patch series only really makes a
> > difference with nested hotplug bridges, such as in Thunderbolt.
> > Although, it might help by not using additional resource lists, but I
> > still do not think it will matter without nested hotplug bridges.
> 
> I was not sure about those patches but since they have been queued for
> 5.6, I included them in these tests. The results are similar (or even
> identical, I would need to re-run the test to be sure) without them.
> > 3. System not reallocating resources despite overridden -> is ACPI _DSM
> > method evaluating to zero?
> 
> Not sure if I follow you here. The kernel is reallocating the resources, or
> at least trying to, if requested to via bootargs (Tests c) and d)). I've
> attached the logs from all 4 tests in an archive [1]. It just fails to
> reallocate the resources in test case c) and even though it successfully
> reallocates the resources in test case d), the new addresses at the PEX
> switch and its ports "don't work".
It is unlikely to be the issue, but I thought it was worth a mention.

> 
> > I experienced this recently with an Intel Ice
> > Lake system. I booted the laptop at the retail store into Linux off a
> > USB to find out about the Thunderbolt implementation. I dumped "sudo
> > lspci -xxxx" and dmesg and analysed the results at home.
> 
> Very brave. ;)
It's a retail store with display models for people to play with. If I do 
not damage it (or pay for any damage caused) then I do not have anything 
to be afraid of.

> 
> > I noticed it
> > did not override the resources, and from examining the source code, it
> > likely evaluated _DSM to 0, which may have overridden pci=realloc. Try
> > modifying the source code to unconditionally apply realloc in
> > drivers/pci/setup-bus.c and see what happens. I have not bothered doing
> > this myself and going back to the store to try to test this hypothesis.
> 
> realloc is enabled via boot args and active in the kernel as you can see
> from the dmesg log [2].
> > 4. It would be helpful if you attached full dmesg and "sudo lspci -xxxx"
> > which dumps full PCI config, allowing us to run any lspci query as if we
> > were on your system, from the file. I will be able to tell a lot more
> > after seeing that. Possibly do one with no kernel parameters, and do
> > another set of results with all of the kernel parameters. Use
> > hpmmiosize=64M and hpmmioprefsize=1G for it to be noticeable, I reckon.
> > But this will answer questions I have about which ports are hotplug
> > bridges and other things.
> 
> Okay, I added the following test cases:
> 
> e) Kernel Parameter ""
> f) Kernel Parameter "pci=nocrs,realloc,hpmmiosize=64M,hpmmioprefsize=1G"
> 
> The logs are also included. Please let me know, if I should do any other
> tests and provide the logs.
> 
> > 5. There is a good chance it will not even boot since kernel since
> > around ~v5.3 with acpi=off but it is worth a shot there, also. Since a
> > recent kernel, I have found that acpi=off only removes HyperThreading,
> > and not all the physical cores like it used to. So there must have been
> > a patch which allowed it to guess the MADT table information. I have not
> > investigated. But now, some of my computers crash upon loading the
> > kernel with acpi=off. It must get it wrong at times.
> 
> Booting this 5.5 kernel with "acpi=off" increases the bootup time quite
> a bit. The resources are distributed behind the PLX switch (similar to
> using "pci=nocrs" but again accessing the BARs doesn't work (0xffffffff
> is read back).
It was only to see if ACPI was part of the issue. You would not run in 
production with it off.

> 
> > What about
> > pci=noacpi instead?
> 
> I also tested using pci=noacpi and it did not resolve the resource
> mapping problems.
> > Sorry if I missed something you said.
> > 
> > Best of luck, and I am interested into looking into this further. :)
> 
> Very much appreciated. :)
> 
> Thanks,
> Stefan
> 
> [1] logs.tar.bz2
> [2] 5.5.0-rc1-custom-test-c/dmesg.log

From the logs, it looks like MMIO_PREF was assigned 1G but not MMIO.

This looks tricky. Please revert my commit:
c13704f5685deb7d6eb21e293233e0901ed77377

And see if it is the problem. It is entirely possible, but because of 
the very old code and how there are multiple passes, it might be 
impossible to use realloc without side effects for somebody. If you fix 
it for one scenario, it is possible that there is another scenario for 
which it will break due to the change. The only way to make everything 
work is a near complete rewrite of drivers/pci/setup-bus.c and 
potentially others, something I am working on, but is going to take a 
long time. And unlikely to ever be accepted.

Otherwise, it will take me a lot of grepping through dmesg to find the 
cause, which will take more time.

FYI, "lspci -vvv" is redundant because it can be produced from "lspci 
-xxxx" output.

A final note, Epyc CPUs can bifurcate x16 slots into x4/x4/x4/x4 in the 
BIOS setup, although you will probably not have the hotplug services 
provided by the PEX switch.

Kind regards,
Nicholas Johnson
