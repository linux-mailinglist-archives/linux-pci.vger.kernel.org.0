Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C8F272F3F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2019 14:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbfGXMyH convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 24 Jul 2019 08:54:07 -0400
Received: from mail-oln040092253107.outbound.protection.outlook.com ([40.92.253.107]:6297
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725883AbfGXMyG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Jul 2019 08:54:06 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vss115/V5ZVt2vJRKPw7Ea4saPFGBRvhGT67VonoI7/OHrbOQC4xu7lLACFWoFN69WLEKYxYVzUgtyQhnMd5m/YRVv7D1fha7xBvJiMm/w47Pp55P7syBxNxwDK1fQik8DEwy9dAnOqlIrpLyeVyZytrUZ6IXPdM6RGgnh7+fBXEkeXLRHGYb6ODKnmudeWDxqmbaTPaODumF0rwq+MKvXwmzxGLucVO3nVmS07xQsfU3H4Z52Pm5mihHLFYESNGgN1+tWqJTv2qn/3P/k2nEos3jovtp6Au00690vppan0QqYMXSY9Ns/EI/cR9dpl13t+eJ25rMdFE5Wg7Docisg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KTrJhy4zwrqxS/6zKoIRpa/CGc3843ZCbR4kPPn/Jek=;
 b=EKGIQI2Rf/remzbDEv2qqETjYCEgs2UJi9LpYJJL5tYUh7rmU88IS2zj5VZIuBnSmv1SbN/tz70UFfBniYV3mm2Vjc9uw9J6L/Awl9RQ0TKEFbOkhSW0hdzLve5O7qsZGNLhVU0EWJJcp2Y2um85/DmenmnoBFEEzx7odcsvhubI16GgyRQcJcbk2168vUr5lqmDAyQarXwoOeN09aowm5DwCr5supSFYGYFwaUZhzB/dTcS4xdAQ6tqi1eXby5Erndoq6B+h8KOQL2v0wHyHRsOxBXJAVUqyDCgPzftkRhhKhycMbbDNdKhVJfvMFwTDnJ5vY+5e1hHkzujpgeWpA==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from HK2APC01FT029.eop-APC01.prod.protection.outlook.com
 (10.152.248.59) by HK2APC01HT009.eop-APC01.prod.protection.outlook.com
 (10.152.248.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2115.10; Wed, 24 Jul
 2019 12:54:00 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.248.60) by
 HK2APC01FT029.mail.protection.outlook.com (10.152.248.195) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10 via Frontend Transport; Wed, 24 Jul 2019 12:54:00 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::1cba:d572:7a30:ff0d%3]) with mapi id 15.20.2094.013; Wed, 24 Jul 2019
 12:54:00 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T4w==
Date:   Wed, 24 Jul 2019 12:54:00 +0000
Message-ID: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0029.ausprd01.prod.outlook.com
 (2603:10c6:10:4::17) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:3BEB98D17EB85E2C3647B667AC61B4A04D34A240DDAC61EFC8C0979AA1B1EEFC;UpperCasedChecksum:451E5B2935B0B8D79892594F68B444035972D5C21CC8F7D4688BA83B9F9885A2;SizeAsReceived:7466;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [tXw/zwmGkNuqKyD6Pq4BN3Z741zi5Hmh1YxlFP6PLnndrKJTTGm4ZJ+HlbpiirFT]
x-microsoft-original-message-id: <20190724125350.GA3190@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031323274)(2017031324274)(2017031322404)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT009;
x-ms-traffictypediagnostic: HK2APC01HT009:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: UnHksuoGd7nGj425kUwzTZGRzpPxAGjdyGXoBHpsLbh0R/gVzm35HTKJ0sUUwdlSjNXi79rgHe6wYLahhlRhsGa5XrHI6dYWGvwqDcVscJ/C4B5O2v/FJ0zIQJRqhq1DLMXA4u9p04usO2BbIHPlaan+SHnmPjhwRY/oaFCyajcGTNXUpyb3Dr5saT2a91w/
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2310B14D73E8464F9B7D60E0AA28E850@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f134d88-e353-41e8-ef5d-08d71035ff4a
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2019 12:54:00.1315
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT009
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
regression that shows on both of my machines. It is also reproducible 
with the unmodified Ubuntu mainline kernel, downloadable at [1].

Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
imperceivable amount of time). Booting with pci.dyndbg does not reveal 
why.

$ uname -r
5.3.0-050300rc1-generic
$ time lspci -vt 1>/dev/null

real	0m2.321s
user	0m0.026s
sys	0m0.000s

If none of you are aware of this or what is causing it, I will submit a 
bug report to Bugzilla.

I am away from 2019-07-27 to mid 2019-08-04. I will post my patches for 
5.3-rc1 before I leave. If possible, please have a quick look over them 
while I am away for trivial changes or oopsies for me to fix, so that I 
can fire off another series ASAP, so that later when we do a full 
analysis, there are less problems.

Thank you!

Kind regards,

Nicholas Johnson

[1]
https://kernel.ubuntu.com/~kernel-ppa/mainline/v5.3-rc1/
