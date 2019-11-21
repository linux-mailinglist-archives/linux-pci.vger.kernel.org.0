Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45CB71054DE
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2019 15:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbfKUOwt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 21 Nov 2019 09:52:49 -0500
Received: from mail-oln040092253037.outbound.protection.outlook.com ([40.92.253.37]:60959
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfKUOwt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Nov 2019 09:52:49 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hbUw3Bn93KDK9/H/BfnPARvBQaJeMkyGSZYjxxkZNDeiymuZaZm042JuJg//rIC1dhKhdzIOG86KcZkFX6VL1+WBlRfot3dK1OM0MwXfHxYjllZ5WLFagEwe03bKAepE428Lz/gVPuR+HLuXggoedWLbXZxOSkUuo9dC6tB1ZXkfUKygadKYhM0IIMD4kR5qkQLBWbIfzqPBwavfMVkJkC6cGyfqnTc2LDHfHyJT5yqJ62+YM1AJMOMO1Y/V725xutwammcwSQTUX/tvgJvWDs425VIQFHl+wi+bIba1B90RLHH+IqW1iXSghOUJsPuFx2J710iy7g8n3EFlEFnHPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ghgmefyddDSLyM7kzWDvbAuDXR6ksbvey4TExZPAw2Q=;
 b=KdiK4pyjsW1ZgbDS4ahZG44bHUIok4/J+7F3iWIzGktGgEiOYN50tn6I9myl/CqsYAVzYMqTW2HNvFcg/KUBhuEjEKSrC4trDBe34GQ14vfzHQ0Ousg2s30B1cBg9Q/ZGVgq9mHKYRCkJ0K6WIkB+W0NpnnH70Rd91r8JyApGjfG/cRFq5MugSpTzIxVFfqI7SuPm7rVxE0mF1Bp0BtSWY8dLd814tBDOAysvcsErntv9Zeof2jHYzLsBUG+C4gEzfBcECkOAWzLarSDPKk14sldUzavLtkfeR+uyjeDaNWvurbM5H7hFENxYCsXTOg7AnUBX+eISpIcbp5YA+DCOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT044.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT165.eop-APC01.prod.protection.outlook.com
 (10.152.251.137) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2474.17; Thu, 21 Nov
 2019 14:52:42 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.55) by
 SG2APC01FT044.mail.protection.outlook.com (10.152.250.239) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17 via Frontend Transport; Thu, 21 Nov 2019 14:52:42 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::b880:961e:dd88:8b5d]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::b880:961e:dd88:8b5d%12]) with mapi id 15.20.2474.019; Thu, 21 Nov
 2019 14:52:42 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Topic: [PATCH v3 1/1] PCI: Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVmjaUpBZrOiNs+EaePGmphxD+QaeK5IeAgAXQSwCAAN4DAIAASFMAgACtqgCAAzleAA==
Date:   Thu, 21 Nov 2019 14:52:41 +0000
Message-ID: <PSXP216MB043824FACB1E66E3F31890D2804E0@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PS2P216MB07556573D454EB9A6D1A5140804C0@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
 <20191119133828.GA171084@google.com>
In-Reply-To: <20191119133828.GA171084@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MEAPR01CA0023.ausprd01.prod.outlook.com
 (2603:10c6:201:1::35) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:72FC63663633B3B664E68DEF549225B11997C666484C02A1AE1DA2D0B3EDA93C;UpperCasedChecksum:624F68319A1A333BBA400F72882CB839AC477F431A0B6F43C85F0B2B865B686C;SizeAsReceived:7756;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [OdNfpSA1jXSPEd3piWq08THcgmT+PPzE]
x-microsoft-original-message-id: <20191121145234.GA2038@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: bce18599-6cea-41cc-c8dc-08d76e9275be
x-ms-traffictypediagnostic: SG2APC01HT165:
x-ms-exchange-purlcount: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Wgx2T7XV6GcZJnCaZPanqUVP3jIptAFd+B9T2EqXkG8OHhdiicqXeAypPwJUqSZeq0hc4uIU0gnJteIrWEW0EpFysbAslTIPafC9pV+5wHDWwJYAu6L7e9GFmLAMzDY7PvPGWcd+aGlk2LC/7UE6gnQqOLw4ioNeroXPwhOdkXp60j2ACk180+89R682MUtGwozQCUx07BAuxfOMwXxvjRVWC4m3JWaLa0rJNfg+OrA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1B73B06479F0504DA7C6096638876204@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: bce18599-6cea-41cc-c8dc-08d76e9275be
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 14:52:41.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT165
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 19, 2019 at 07:38:28AM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 19, 2019 at 03:17:04AM +0000, Nicholas Johnson wrote:
> > I did just discover linux-next and I built it. Should I be doing this 
> > more often to help find regressions?
> 
> Yes, if you build and run linux-next, that's a great service because
> it helps find problems before they appear in mainline.

Funnily enough, I just built Linux next-20191121 and it has a NULL 
dereference on start-up, which renders the system unusable.

Can anybody else please confirm? I enabled most of the new options since 
the last linux-next a few days before.

I did just compile on an i7-4770K using my USB SSD to boot. I suppose 
there is a tiny chance that the CPU had an error and produced bad code. 
It is not my machine. It was pegged at 100 degrees Celsius the whole 
time.... I do find it hard to believe that I am the first to notice it, 
though. I cannot find any bug reports on this.

If this turns out to be an actual bug, is there a preferred way to 
report it? It is probably not from pci subsystem.

I can do a bisect, but they consume a lot of time on a slow system.

Here is a preliminary bug report (assuming you are meant to report 
linux-next bugs here):
https://bugzilla.kernel.org/show_bug.cgi?id=205621

Cheers!

Regards,
Nicholas Johnson

> 
> > I will now concentrate on fixing the problem where pci=nocrs does not 
> > ignore the bus resource. One motherboard I own gives 00-7e or similar, 
> > instead of 00-ff. The nocrs does not help, and I had to patch the kernel 
> > myself. Only acpi=off fixes the problem, while knocking out SMT (MADT), 
> > IOMMU (DMAR) and the ability to suspend without crashing.
> > 
> > If you disagree that nocrs should override bus resource, then let me 
> > know and I will not attempt this.
> 
> I guess the problem is that with "pci=nocrs", we ignore the MMIO and
> I/O port resources from _CRS, but we still pay attention to bus number
> resources in _CRS?  That does sound like it would be unexpected
> behavior.
> 
> I *would* like to see the complete dmesg log because these _CRS
> methods are pretty reliable because Windows relies on them as well, so
> problems are frequently a result of Linux defects.  If we can fix
> Linux or automatically work around issues so users don't have to use
> "pci=nocrs" explicitly, that's the best.
> 
> Bjorn
