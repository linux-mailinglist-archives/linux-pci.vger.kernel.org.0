Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E52CE1837
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 12:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391068AbfJWKn7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 06:43:59 -0400
Received: from mail-oln040092254068.outbound.protection.outlook.com ([40.92.254.68]:48288
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390386AbfJWKn7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 06:43:59 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kK9hmCoFXliFdMLmgYJw8cuXQ5nTg+eW5TZXF2cnsZQTJNbDedqskDwdtfW5q/mqcTEqJwPD8D5ejZoNn1BU3SoVaf+15mTjndQ06++hSHEPXMK0bvRgJHTORBNtaX14M7qQbXRbkjzyIJ7IVy8xf51Eg63y/bJGK4LMGnCeuUHHqZddeik1uNt8N2NH+koFLFnGJ6P0EjmrdduXqnHnqk5Q7RQchS2HewOkQyTZrpng75UstsLMI6uNqXO1MaTCy+2FMp3BISlWSkzm2DKTF1D6F0bUe5MKsx/Yq4nnrjOiNNG9UohJrnzJL+tvQfBNWhlwDtR59FNqzLGCdx6vYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QndjHuoDKoNgBnXE9ZhWSKjWrZOC0u07NYwfAAsnskw=;
 b=Cjrib0bG6AGmWnc+34OslI7AMECUNjIwZDQAAqw+NEb5z/XILmqq+1WF/RPZO5hcVYmoFqf1cdXh5IatnF7d5Y4+dvoc7lK57v1HcirWY68GyIwyu1BGuE7nJfZ1AfQH4FEQXOS481gRZlarDHy6T0yw7EsvZdc5nXsdAbvyzv7uAnp3qOXnODUZfrdzupFTlFw/ZAzmxEk9NatyMfRKQw0OYHVa/yYtb4YES3XzLgNmNuP8LzUHQtOlWwCtSTcZYFOVXLIjsfSixMccZJXlIGdD6zVjZhYQX4PBtVWHxkx1noEI0fnbW8xFeqb7NHrYH+/qFguZ0MA6wy/caDV9Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT030.eop-APC01.prod.protection.outlook.com
 (10.152.250.55) by SG2APC01HT138.eop-APC01.prod.protection.outlook.com
 (10.152.251.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 10:43:53 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.51) by
 SG2APC01FT030.mail.protection.outlook.com (10.152.250.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 10:43:53 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 10:43:53 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>
Subject: Re: [PATCH 0/1] Add support for setting MMIO PREF hotplug bridge size
Thread-Topic: [PATCH 0/1] Add support for setting MMIO PREF hotplug bridge
 size
Thread-Index: AQHViX0IscNJYyHchk6j0ubA//SaQKdn+jIAgAAQTwA=
Date:   Wed, 23 Oct 2019 10:43:53 +0000
Message-ID: <SL2P216MB0187DC3EEA0B3FD8D4F81B45806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB01832E0DD8892B52A3FA2589806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
 <20191023094522.GT2819@lahna.fi.intel.com>
In-Reply-To: <20191023094522.GT2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME4P282CA0017.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:220:90::27) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:EC1185017EA86D646DCC0261E13DDD076FD5B8FF6FCC28E462AF16B6E946DF79;UpperCasedChecksum:D449B46EE167145D70B700980EADE58740F91F1D20D697688AD178E00B98B3AD;SizeAsReceived:7646;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qlLLeVr12dNLSLOFyCXVW4/HhrzzeUblPieIjsAHICE=]
x-microsoft-original-message-id: <20191023104344.GA5897@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: SG2APC01HT138:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KItML5yrGk1DwJQNcv35iGI4GXUrO41BEb3SuOMpf22FDvYXledfanOvX0DBQuiCvo6QcZU+YYF8t51seCdz9BFA8WaWHDO24Spi+V/POhgnjBbWs1HABe87yx+aiZ863Loo4ZZ2hF7XDmx2AnrNgoIHa+ehEatXg+ABBCTOfuI19l9dOFNmELbRqvzMJulO
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2953F534D8CA8E4FB3BC9E60974A514D@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 761e5cfa-e33d-49bc-88df-08d757a5e5ea
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 10:43:53.7866
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT138
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:45:22PM +0300, mika.westerberg@linux.intel.com wrote:
> On Wed, Oct 23, 2019 at 08:36:59AM +0000, Nicholas Johnson wrote:
> > This patch adds support for two new kernel parameters. This patch has
> > been in the making for quite some time, and has changed several times
> > based on feedback.
> > 
> > I realised I was making the mistake of putting it as part of my
> > Thunderbolt patch series. Although the other patches in the series are
> > very important for my goal, I realised that they are just a heap of
> > patches that are not Thunderbolt-specific. The only thing that is
> > Thunderbolt-related is the intended use case.
> > 
> > I hope that posting this alone can ease the difficulty of reviewing it.
> > 
> > Nicholas Johnson (1):
> >   PCI: Add hp_mmio_size and hp_mmio_pref_size parameters
> > 
> >  .../admin-guide/kernel-parameters.txt         |  9 ++++++-
> >  drivers/pci/pci.c                             | 17 ++++++++++---
> >  drivers/pci/pci.h                             |  3 ++-
> >  drivers/pci/setup-bus.c                       | 25 +++++++++++--------
> >  4 files changed, 38 insertions(+), 16 deletions(-)
> 
> If you want to add cover letter in the "normal way" so that threading is
> preserved you can do something like 'git format-patch --cover-letter ...',
> then edit the 0000-...patch and send it along with the other patches
I do everything above.

> using git send-email.
But I was told by Bjorn that I was sending emails with funny encoding 
which meant he had to manually apply the patches, which meant more work 
for him. I could not figure out how to make git send-email work with the 
correct encoding. I had to use mutt -H to fix the encoding, doing each 
email separately.

I have no idea why my git send-email is strange.
