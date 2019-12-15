Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 19BBD11F568
	for <lists+linux-pci@lfdr.de>; Sun, 15 Dec 2019 04:17:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726019AbfLODRO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 14 Dec 2019 22:17:14 -0500
Received: from mail-oln040092253092.outbound.protection.outlook.com ([40.92.253.92]:32075
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725990AbfLODRO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 14 Dec 2019 22:17:14 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoKTWiprH4ZOk/1VV6Q3+E6vgiMyf/3F1uy+DhQcQ428oWGHEMoO/2nmFB1yN36UqN3Sz60GIHrriLAKWUVxUsXNHmikYdU7RPRxKeFih3IOx5iofwNI26GZzmYeaYLJYerZ8cy8QajKq9YQ9TFqf7mB9tAjTRguTzQAu0VmSPskewgF/Fcp29tb9e2HYtVbnDboojWE4RWrb3i9oZViYU9N/hX5wpZm9F1UJi+iZonrH6RBKV4GQcUMYwTqRU4MHf+S+5cAS/zqFn/xgrI9q787IJwpvnrn/5ABo4zZ+JNgN/v1gFa4HPbmZ4A9n8gElp3UzKQ1/Z6/6LOQMVIuvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dTzE8PF2sfxedpNN+Jno6pyFzsKOhdHeK4tmfmWREZw=;
 b=fwLL+XQ46T86TL/7QORVLg12NAEIRieLUKCt/2H1lCYfOedsBk3jRm5hE/KEfxvWi60ZRZtBI/cyzLLD2n5MT4oS62YdUFdr11vKIN7pqUMKVgmyKX2gzw4O850R8s5puWETLqJ1armXL0ZeP1M2Rb6ZIUeB/g2/oAoBm4AsNLbpDzAoeXMPuJLa1lvqK1oyC1Q1u62YpH5sZqTXMrYz/MwZabzU1Qv/oZrkJ7IHIjy0ufXR1uConPnWSgyrjdQgEp3mldkZZMrZzMiX506fp0L03d/ZI5vVNl9R/XlmNjSMH3AMSWJFs6dhJ7O2j4RncCHPt9AtHikRsenNKk4G8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT056.eop-APC01.prod.protection.outlook.com
 (10.152.250.59) by SG2APC01HT240.eop-APC01.prod.protection.outlook.com
 (10.152.251.50) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2538.15; Sun, 15 Dec
 2019 03:16:27 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.54) by
 SG2APC01FT056.mail.protection.outlook.com (10.152.251.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15 via Frontend Transport; Sun, 15 Dec 2019 03:16:26 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2538.019; Sun, 15 Dec
 2019 03:16:26 +0000
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
Thread-Index: AQHVsZBJH4x6UZhJJ0OzP9pilhD//ae3xGIAgAAhGoCAAA8BgIAABtaAgAKNhYA=
Date:   Sun, 15 Dec 2019 03:16:26 +0000
Message-ID: <PSXP216MB0438ADAE9B4081B69CABEA7580560@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <4fc407f8-2a24-4a04-20fb-5d07d5c24be4@denx.de>
 <PSXP216MB0438BE9DA58D0AF9F908070680540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <c9f154e5-4214-aa46-2ce2-443b508e1643@denx.de>
 <PSXP216MB0438AD1041F6BD7DB51363A380540@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <9aa45b1d-8afe-2d59-4bca-4d2beb983cfc@denx.de>
In-Reply-To: <9aa45b1d-8afe-2d59-4bca-4d2beb983cfc@denx.de>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0067.ausprd01.prod.outlook.com
 (2603:10c6:201:2b::31) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:7B8696DA3B5A7C72F1773FC0A2DA3F1C33C81F90FAA173848517101755EA66FF;UpperCasedChecksum:EBEDBC8607EB22D83E2E0554CF4C06C18D4DE55C4AC7B05E44DA414F66D38CFE;SizeAsReceived:7849;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [KGqMWtXz8Y4Ei6REv9vy+tm8hg6eP9yPQgD0DhemkaU=]
x-microsoft-original-message-id: <20191215031605.GA1659@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 8b6e4f9e-a07e-4b44-9f27-08d7810d2b49
x-ms-traffictypediagnostic: SG2APC01HT240:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CWtitCTgWibpy8I7cwGhXXshG838uUZqcsYU8k4lVsMmLYT6eS6WLAE5lav0s6xFSfdZTg2WLIDzxIQw/CH2Wa9BnNeNmaHN72vuzji2hQAD/gsC7Z33EBVfSJUY9WPsjKkofzmtOHBoKGdeCL0Bp2idgpS8Aa5dVcF03twHo/W2Sw/FcI3DpJ91ajrUEivY
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <66E5F4FB1F56A6468C7928CA84698F29@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b6e4f9e-a07e-4b44-9f27-08d7810d2b49
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2019 03:16:26.2655
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT240
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

> >  From the logs, it looks like MMIO_PREF was assigned 1G but not MMIO.
> > 
> > This looks tricky. Please revert my commit:
> > c13704f5685deb7d6eb21e293233e0901ed77377
> > 
> > And see if it is the problem.
> 
> I reverted this patch and did a few test (some of my test cases). None
> turned out differently than before. Either the resources are not mapped
> completely or they are mapped  (with pci=nocrs) and not accessible.
> 
> > It is entirely possible, but because of
> > the very old code and how there are multiple passes, it might be
> > impossible to use realloc without side effects for somebody. If you fix
> > it for one scenario, it is possible that there is another scenario for
> > which it will break due to the change. The only way to make everything
> > work is a near complete rewrite of drivers/pci/setup-bus.c and
> > potentially others, something I am working on, but is going to take a
> > long time. And unlikely to ever be accepted.
> 
> While working on this issue, I looked (again) at this resource (re-)
> allocation code. This is really confusing (at least to me) and I also think
> that it needs a "near complete rewrite".
> > Otherwise, it will take me a lot of grepping through dmesg to find the
> > cause, which will take more time.
> 
> Sure.
> > FYI, "lspci -vvv" is redundant because it can be produced from "lspci
> > -xxxx" output.
> 
> I know. Its mainly for me to easily see the PCI devices listed quickly.
> > A final note, Epyc CPUs can bifurcate x16 slots into x4/x4/x4/x4 in the
> > BIOS setup, although you will probably not have the hotplug services
> > provided by the PEX switch.
> 
> I think it should not matter for my current test with resource assignment,
> how many PCIe lanes the PEX switch has connected to the PCI root port. Its
> of course important for the bandwidth, but this is a completely different
> issue.
I meant that you can connect 4x NVMe drives to a PCIe x16 slot with a 
cheap passive bifurcation riser. But it sounds like this card is useful 
because of its hotplug support.

I noticed if you grep your some of your dmesg logs for "add_size", you 
have some lines like this:
[    0.767652] pci 0000:42:04.0: bridge window [mem 0x00100000-0x000fffff 64bit pref] to [bus 44] add_size 200000 add_align 100000

I am not sure if these are the cause or a symptom of the problem, but I 
do not have any when assigning MMIO and MMIO_PREF for Thunderbolt 3.

I noticed you are using pci=hpmemsize in some of the tests. It should 
not be interfering because you put it first (it is overwritten by 
hpmmiosize and hpmmioprefsize). But I should point out that 
pci=hpmemsize=X is equivalent to pci=hpmmiosize=X,hpmmioprefsize=X so it 
is redundant. When I added hpmmiosize and hpmmioprefsize parameters to 
control them independently, I would have liked to have dropped 
hpmemsize, but needed to leave it around to not disrupt people who are 
already using it.

Please try something like this, which I dug up from a very old attempt 
to overhaul drivers/pci/setup-bus.c that I was working on. It will 
release all the boot resources before the initial allocation, and should 
give the system a chance to cleanly assign all resources on the first 
pass / try. The allocation code works well until you use more than one 
pass - then things get very hairy. I just applied it to mine, and now
everything applies the first pass, with not a single failure to assign.

diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
index 22aed6cdb..befaef6a8 100644
--- a/drivers/pci/setup-bus.c
+++ b/drivers/pci/setup-bus.c
@@ -1822,8 +1822,16 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
 void __init pci_assign_unassigned_resources(void)
 {
 	struct pci_bus *root_bus;
+	struct pci_dev *dev;
 
 	list_for_each_entry(root_bus, &pci_root_buses, node) {
+		for_each_pci_bridge(dev, root_bus) {
+			pci_bridge_release_resources(dev->subordinate, IORESOURCE_IO);
+			pci_bridge_release_resources(dev->subordinate, IORESOURCE_MEM);
+			pci_bridge_release_resources(dev->subordinate, IORESOURCE_MEM_64);
+			pci_bridge_release_resources(dev->subordinate, IORESOURCE_MEM_64 | IORESOURCE_PREFETCH);
+		}
+
 		pci_assign_unassigned_root_bus_resources(root_bus);
 
 		/* Make sure the root bridge has a companion ACPI device */

Kind regards,
Nicholas
