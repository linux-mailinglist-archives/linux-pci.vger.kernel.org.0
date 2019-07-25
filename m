Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9654C74F1C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2019 15:21:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfGYNV2 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 25 Jul 2019 09:21:28 -0400
Received: from mail-oln040092253020.outbound.protection.outlook.com ([40.92.253.20]:4272
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729992AbfGYNV1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 25 Jul 2019 09:21:27 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV/DIFY7GtJicGCoR6WIsDasxPTtvwPvcQIqGMyF3IJISSnay4VeObKlASG62pbXS15E62hsM3Y3y2DiGzs3pKdA/JIjE76SH8zqzzD3hMZ9sCGJ07UtmwSfY1WjPTOdsbBLU1BWChJr1gBJSSKtrqFusyhNmz6o1NjluOYmN+snuLeBv6sSPvgv7wM3Fx1g7o7ZzP8SJbwduhIiUKobzpv/UXRRHZSWhcF4osxX7qngzTXOp00ejSZLdcXRyObEi0O7BOAakme+OlLTcOBIMuxruvIOxqdLywzFSXryhZqZMmTMuqmUcaaHTS4iFScbZXUrMOUqOJYCeGRCRh6w0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H9EUh87UabZNWaj3CjLPoNcbkchcLA5B6Cj1S3JhFWk=;
 b=KA8dYRSeK7NKBWAEOHzLGCJaztCADZ0qUj+54On90N//h/jOyuuopECX2tme1PwJ6p8dLDkX31Uw5u8BBee86EwT/zYmqCUtn0EfDLDb4z/mb1MMFtNpld/rp7srMUi0qipnlSY+AqkvykYTyEFhlxp+vWEnF5mGtmZ9G//VePKNx5NVs3FBWIHkq936vDX22qKCC3e5sZ/ylcRlf/grsaTphdF+9+MfncytOY9lS1ef4jWs2fA5AQ64h6qgW3iaDbvlvVB7iHNsl/Fn1pUqO8onDqOx1pOpJIVqY25rhp60PaFm46K0hIoWbz1J6GV/YqelwgGVVHoTJJFhieDxWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT112.eop-APC01.prod.protection.outlook.com
 (10.152.252.59) by PU1APC01HT136.eop-APC01.prod.protection.outlook.com
 (10.152.253.239) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2115.10; Thu, 25 Jul
 2019 13:21:23 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.55) by
 PU1APC01FT112.mail.protection.outlook.com (10.152.252.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2115.10 via Frontend Transport; Thu, 25 Jul 2019 13:21:23 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Thu, 25 Jul 2019
 13:21:23 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T46bZxdcAgAAkWYCAAWk9gA==
Date:   Thu, 25 Jul 2019 13:21:23 +0000
Message-ID: <SL2P216MB01873051649F3472F67172A080C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
 <c016b0b3-6e76-625d-e603-65ddb1286cf6@deltatee.com>
In-Reply-To: <c016b0b3-6e76-625d-e603-65ddb1286cf6@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYCPR01CA0005.ausprd01.prod.outlook.com
 (2603:10c6:10:31::17) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:8D4E6D77027D70048E0FAD16B0FDCA29BAAE3C638917BEF2B78A09D76CED7AFE;UpperCasedChecksum:DC2BF764184848C1274155ACDCAFD428ED7EF542A8B592F2FF6A0DE7D4808871;SizeAsReceived:7754;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [o4eL2zoqVsXklAde8SH+zL/NqbGXlOHHBKOAnn8JZ6NOlYc4wVY+A9EQVsZ9ZrgQ]
x-microsoft-original-message-id: <20190725132112.GB2445@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT136;
x-ms-traffictypediagnostic: PU1APC01HT136:
x-microsoft-antispam-message-info: cFjLCjCbwOyyV6klwV8fH/2qBpwJ2ZpMx9wYl1z8nV1wXVyTBvKTXpsFyhR+vtMssWmk2MncWseAHbDQTb7twEmTPKDHxcGuWAq68e+q0JfsO2lrjnQt3Jd1OnN7SXMR8hFObzqoGrsR/KIykIzTS97dQdTPvcCbFXYnLDK1dFZ0s/Db0Ekjy3rz2OCMx50v
Content-Type: text/plain; charset="us-ascii"
Content-ID: <964A0029898AD44089D658B787601287@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 6dea256a-cd70-4629-e47e-08d71102fcfe
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2019 13:21:23.1213
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT136
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 24, 2019 at 09:48:19AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-24 7:38 a.m., Bjorn Helgaas wrote:
> > On Wed, Jul 24, 2019 at 12:54:00PM +0000, Nicholas Johnson wrote:
> >> Hi all,
> >>
> >> I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
> >> regression that shows on both of my machines. It is also reproducible 
> >> with the unmodified Ubuntu mainline kernel, downloadable at [1].
> >>
> >> Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
> >> imperceivable amount of time). Booting with pci.dyndbg does not reveal 
> >> why.
> >>
> >> $ uname -r
> >> 5.3.0-050300rc1-generic
> >> $ time lspci -vt 1>/dev/null
> >>
> >> real	0m2.321s
> >> user	0m0.026s
> >> sys	0m0.000s
> >>
> >> If none of you are aware of this or what is causing it, I will submit a 
> >> bug report to Bugzilla.
> > 
> > I wasn't aware of this; thanks for reporting it!  I wasn't able to
> > reproduce this in qemu.  Can you play with "strace -r lspci -vt" and
> > the like?  Maybe try "lspci -n" to see if it's related to looking up
> > the names?
> I also just tested 5.3-rc1 on my machine and lspci behaves normally.
> 
> Logan

I have looked deeper into this and it seems that removing the 
Thunderbolt controller from the root port with sysfs resolves the issue. 
If the system you tried this on does not have Thunderbolt, then you will 
not have been able to reproduce the bug. Please see the message to Bjorn 
which you are carbon copied into for more elaboration.

Thanks for looking at this.

Regards,
Nicholas
