Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8414EE1810
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 12:33:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391006AbfJWKds convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 06:33:48 -0400
Received: from mail-oln040092253036.outbound.protection.outlook.com ([40.92.253.36]:10145
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390935AbfJWKds (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 06:33:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mbWzYOHvJ7DLGuqx2C/JpH8hogF4UnXJB67hpsUI97gJaCngvhdewEXTzwXZZWS7iVFlxtD5bD4xVR6Oi4vXPl5STiNbLkl/rD7ko00oEVK87uB9ZBmEJF+tWFLXKzSSG3IhdBG/U9zK1UXxdmYie2BSzNwyCCTCSouKyDPruPzH7WYQ9rzfotGMoXEpS2H8BmsNlbp4jP+c92ljKlBo2exwqlCgIYsmx860vRzpk43w7qH1UpS0SOUHn8YEsNm0/UX9fdT7cRpwuULc4ryQoNE7MBRSMFA+HY3mleCwJbXKm2Hjqp6WdU5JWi/hR+paj+xKbpIFUhi3M0IvjA2bKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VlUxN8CAzYvB4J1h8171H7fV0N/zQl6v0B590uBhPO8=;
 b=S0MEEpJmm2wxuoJ6zDNPiIHi+sYizS3hNuCu7hNPWAs/D2QWPWIsi4nJUagEVC9RTc6i0Tukv7llRBBesRZXnjYrSph4rqRbv/UOmE5dPpHutxCNYlFwIlf+icRwIj+CjjyJPC2lva/8YID3v0Qn1F+cuXdCyk6W1n+aBmeaYWnPnpECwrJOl3Oqh5fBLSy14crIMuem7hQKjb/CBfdZpLWXMHuLXYogWA+02EFBPDz8kxBIl6NVXyFQCbke2Em+b+4K/ClQDulTiwPd9AP6jy/rkXM662DgTcdC6JHR05HHc3WNTCrngwOB6d/Mp4vM6a/le4JFtuWVDf+IhfHyQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT053.eop-APC01.prod.protection.outlook.com
 (10.152.250.57) by SG2APC01HT236.eop-APC01.prod.protection.outlook.com
 (10.152.251.175) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 10:33:43 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.53) by
 SG2APC01FT053.mail.protection.outlook.com (10.152.250.240) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 10:33:43 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 10:33:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Topic: [PATCH 1/1] PCI: Add hp_mmio_size and hp_mmio_pref_size
 parameters
Thread-Index: AQHViX0m6toKrk1OzESm1M80C1WD26dn+tqAgAACogCAAAHqgIAACEQA
Date:   Wed, 23 Oct 2019 10:33:42 +0000
Message-ID: <SL2P216MB0187E0B5D83583094065CA35806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB01833367A1A154AEB816AE4E806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
 <20191023094743.GU2819@lahna.fi.intel.com>
 <SL2P216MB0187D47276DED3EA634123BE806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20191023100359.GW2819@lahna.fi.intel.com>
In-Reply-To: <20191023100359.GW2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0115.ausprd01.prod.outlook.com
 (2603:10c6:201:2c::31) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:F04BC230F1DAED8DA8E59E575EBB957B026008360374D4987CCC562DE1D4D49E;UpperCasedChecksum:1E0E2A9ED2A0E5614003CCD6A0A8E10AE0CA0B4A39013D5FD7F2D75C186FF12E;SizeAsReceived:7780;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [/WJBjejDWNWeML1OyRPOiowRs4HOQHBWSvHYaD4V7xY=]
x-microsoft-original-message-id: <20191023103334.GD4080@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: SG2APC01HT236:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +2xYyom7rZzoYFsFGwnZ9GyvCPkaDe1/lBmQHKr/ZPmH4cfQmenn9sa7jp02TZj+D9sSB2DoicJfFpAx6oiGjTSYtJvF9h36tEqLj4Ki2uc8VP16lZV4BR7XrtzDBNaOeKHrMe60/ejp6hd6cnDhrkvYwkv4KIZvCoEfujwZM6BPPbFbPLpAzu8FBRs+edVN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <91CEBE902BFE6F45BF9748FACBBE15B0@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a729f6-8574-4af2-69eb-08d757a479da
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 10:33:43.0152
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT236
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 01:03:59PM +0300, mika.westerberg@linux.intel.com wrote:
> On Wed, Oct 23, 2019 at 09:57:17AM +0000, Nicholas Johnson wrote:
> > On Wed, Oct 23, 2019 at 12:47:43PM +0300, mika.westerberg@linux.intel.com wrote:
> > > On Wed, Oct 23, 2019 at 08:37:48AM +0000, Nicholas Johnson wrote:
> > > >  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> > > > -				pci_hotplug_mem_size = memparse(str + 10, &str);
> > > > +				pci_hotplug_mmio_size =
> > > > +					memparse(str + 10, &str);
> > > > +				pci_hotplug_mmio_pref_size =
> > > > +					memparse(str + 10, &str);
> > > 
> > > Does this actually work correctly? The first memparse(str + 10, &str)
> > > modifies str so the next call will not start from the correct position
> > > anymore.
> > I have been using this for a long time now and have not had any issues.
> > Does it modify str? I thought that was done by the loop.
> 
> If you add "hpmemsize=xxx" in the command line and print both
> pci_hotplug_mmio_size and pci_hotplug_mmio_pref_size after the
> assignment, do they have the same value? If yes, then there is no
> problem.
Looking at lib/cmdline.c line 125, it looks like there is no point in me 
testing it. It looks like you are right.

What is the better fix?

pci_hotplug_mmio_size = pci_hotplug_mmio_pref_size = memparse(str + 10, &str);

^ Could be too long, even if we are ignoring the 80-character limit.

> 
> > Can somebody else please weigh in here? I am worried now, and I want to 
> > be sure. If it is a problem, then I will have to read it into 
> > pci_hotplug_mmio_size and then set:
> > 
> > pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size
> 
> Yup.
Or do you prefer the above?

Thanks
