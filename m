Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4A90E16ED
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 11:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390986AbfJWJ5Z convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 23 Oct 2019 05:57:25 -0400
Received: from mail-oln040092253097.outbound.protection.outlook.com ([40.92.253.97]:18528
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390971AbfJWJ5Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 05:57:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YBEpUDMgoF+jHpuewsnEIeGOu7JOjQyLPDyhBMys6FziCQTocxXqLz9TuBlQTDJ8TU49/z7Qkk0lW9OrxctAjfHEKZxw7nPeehjPnYE0BBl4JilafXTlp1lSG7j9Vjf3QFTcQ7YLSo+aihY7coJ98o/1J87aiUH4/FKpoc5jNEtBv+UdTQ3sGGVIOaDjh94MeFUBNhZTuaUuVj4c4xtcZ3J1Zm9TU8+538oE3LSiLV6U5LRfinYfHlJEhQZLRrPOBZpsDxHbvUYT5pTVq1/tswDmGRhpGFv6JgS90lJkZ0QdCmyenulXU7cKz1zp2s9QdEycpFLso8sf1InZxgw3Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=syfUwvI/D4Epfi/TgZkatcDK5Oufx/BMI1XGzElOzsA=;
 b=fcvrFuf4smSN5y4b3Y8zXEQfY/4yH3Pgnt5h1KviPWZ5DlFcOTRQ4Oyv1Tul+rXKDN3cJ8Pt6buvP/1ZYwR8VMbFC8FTGMi1dcU13psdI43N9DSQfI0YtxLDaxBsZxhgPa9/FcuplO6fsycl/m5+imQK+Sl+cl2lIC4bHWNgxx51Yn/mN4GIBRsp/p0R1iAgaZbJG159R0hrcJlCl3C8+qc+1QuL+3qetVtzevgpi7o6iJupfVDTA/+XXLiK3djiHKsVkt0u2SIWEPNaohp2SW484yB2+9M0k9ORHOxjn9Do6u+C6YRLwjJcijghNH0cGwPVrEpd79mRsURNEe0M1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from PU1APC01FT013.eop-APC01.prod.protection.outlook.com
 (10.152.252.60) by PU1APC01HT221.eop-APC01.prod.protection.outlook.com
 (10.152.253.159) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2367.14; Wed, 23 Oct
 2019 09:57:18 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.56) by
 PU1APC01FT013.mail.protection.outlook.com (10.152.252.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.20 via Frontend Transport; Wed, 23 Oct 2019 09:57:18 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::ec26:6771:625e:71d%8]) with mapi id 15.20.2387.019; Wed, 23 Oct 2019
 09:57:17 +0000
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
Thread-Index: AQHViX0m6toKrk1OzESm1M80C1WD26dn+tqAgAACogA=
Date:   Wed, 23 Oct 2019 09:57:17 +0000
Message-ID: <SL2P216MB0187D47276DED3EA634123BE806B0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB01833367A1A154AEB816AE4E806B0@PSXP216MB0183.KORP216.PROD.OUTLOOK.COM>
 <20191023094743.GU2819@lahna.fi.intel.com>
In-Reply-To: <20191023094743.GU2819@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0218.ausprd01.prod.outlook.com
 (2603:10c6:220:19::14) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:379183CF568804A8CF9553F3B06305BE33C8ED8CF75319F8170CDD0C263B3837;UpperCasedChecksum:A8A118439133A174A247B9000ABB1EB3FCE0DC1F83782102F71A1C6DD82AB697;SizeAsReceived:7667;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [XhAnspKP3MvUZ83Bqo/QF8Xu8KY4QxXLlbGnFO+QjvI=]
x-microsoft-original-message-id: <20191023095708.GB4742@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-traffictypediagnostic: PU1APC01HT221:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLJ6ZGMdPab9ubzLn/R0wzxYwEIsJnWneQNnwAl+YFvGHUxCHvPl0BgBr/TAxcN6gCl1jPEbiq06Cc0SdBJjWeLc42Gk2eJGQ06mTSTr0/k9v4oXAvv4nWwCiTaJxW+Kd1unJQaieTAfEOuoSmSBaekpQH7xInLuIxuUNlcCCicKwi0D1S0XIEv7ailww02o
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <DE93B908AF4A4343A1C01CAF96DEA464@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 381825c1-5a3d-48ed-d709-08d7579f636b
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2019 09:57:17.8951
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT221
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 12:47:43PM +0300, mika.westerberg@linux.intel.com wrote:
> On Wed, Oct 23, 2019 at 08:37:48AM +0000, Nicholas Johnson wrote:
> >  			} else if (!strncmp(str, "hpmemsize=", 10)) {
> > -				pci_hotplug_mem_size = memparse(str + 10, &str);
> > +				pci_hotplug_mmio_size =
> > +					memparse(str + 10, &str);
> > +				pci_hotplug_mmio_pref_size =
> > +					memparse(str + 10, &str);
> 
> Does this actually work correctly? The first memparse(str + 10, &str)
> modifies str so the next call will not start from the correct position
> anymore.
I have been using this for a long time now and have not had any issues.
Does it modify str? I thought that was done by the loop.

Can somebody else please weigh in here? I am worried now, and I want to 
be sure. If it is a problem, then I will have to read it into 
pci_hotplug_mmio_size and then set:

pci_hotplug_mmio_pref_size = pci_hotplug_mmio_size

> 
> Otherwise the patch looks good to me.
Thanks, I will re-post with your last suggestions of going over 80 
characters shortly.
