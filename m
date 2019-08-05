Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B9081EB5
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 16:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729079AbfHEOJY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 5 Aug 2019 10:09:24 -0400
Received: from mail-oln040092254054.outbound.protection.outlook.com ([40.92.254.54]:9684
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729001AbfHEOJY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 10:09:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kNFHlb2kepKclSVpNp9s1E/BeH4z1Af3S0RudGsHXGqgua3VrxI2mYKa6wX7kjGXqOCznUTRpt5gc+U9+5VjO7ko4f63xNuUPOULSweWaODdNFtX8PFTuc6tCuAVBcQ17cggEUsyoHZOJEpSBya9lgjk3eIc0qEe49cY9xHCoctgKVo1XZny+gXIMiHCZewiZuPeBiqLjtj3wLNkfZes+aGhVZSstyGdItm9BJUip/QU/1G1vwTuj0Fz7WJWsfL5v/X1TBjiSqY/74Ski3LjVWXFIH26YcWIE9HJq4fnPW/w1XUlwsgAQBxvS5o+KTYgx4vD4zAg2ZfAOX1jlvRJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7n+H0HYurqU53rBQY8f5kCMDvXyVe+dHPIfOO50lkc=;
 b=VXqgPvlRECiHEDKZ7GqhfuqbYyjSiUUObHjSl8zw/9yL3DaKJsdy/XSxrh5/Tjr2NkYjO+b7JSS8cmmWgX2bq3y4lVl1My7iS4woBrjgGFZPH8E9lFCeV2Z1yUofVQVDmCvywJh/U2QMzA0XQgfSkKaMmUlVujCqhZ8ESCkXwvItldXXS1buAi/W7Yx9yEA0d9Jntn7jYZUNKmolY8rHax0DFPb2zILAPsBojbLpYLdYpKZpdjkSg7HdV5zQADFFWkMTgdS4jwHOMOXsh+f36TpN3pjkOvJ+k9XJT8mbJxNq21u+62UYYZcskdxmDm0Yr82BQqlUEdjB7DylJqHTEg==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from HK2APC01FT061.eop-APC01.prod.protection.outlook.com
 (10.152.248.54) by HK2APC01HT084.eop-APC01.prod.protection.outlook.com
 (10.152.249.101) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14; Mon, 5 Aug
 2019 14:09:19 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.248.52) by
 HK2APC01FT061.mail.protection.outlook.com (10.152.249.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14 via Frontend Transport; Mon, 5 Aug 2019 14:09:19 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 14:09:19 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T46bZxdcAgAGMzQCAACqSAIAPQRMAgAHR0gCAABpdAA==
Date:   Mon, 5 Aug 2019 14:09:19 +0000
Message-ID: <SL2P216MB01876A10BD2E487294D525BF80DA0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
 <SL2P216MB0187E2042E5DB8D9F29E665280C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <4f5afb8e-9013-980f-0553-c687d17ed8d5@deltatee.com>
 <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190805123450.GM2640@lahna.fi.intel.com>
In-Reply-To: <20190805123450.GM2640@lahna.fi.intel.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYXPR01CA0112.ausprd01.prod.outlook.com
 (2603:10c6:0:2d::21) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:E4EF03CB28A6E8BBA00F071902ED9B553A82C16893FD2F5491F946AD14753A8D;UpperCasedChecksum:703790F43AA203FA3A7A817E4E184D86B2026A6A25E5C5529EEBF69EF78508D8;SizeAsReceived:7967;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [arCIklsPF112/jrxFLtXG6XI5dV4Wp1pCeswKnkYYwhi9a36jf16YmeLc2oAwbCfqPKxEt1i6Zs=]
x-microsoft-original-message-id: <20190805140909.GB2305@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT084;
x-ms-traffictypediagnostic: HK2APC01HT084:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-message-info: k4hQFUYkRzZ9NtuDdiHPoPudAfw0kt2bwR82JG5cT8OFEUf4m0ENHKwuldmn38Uo4TkybZbYt2lMbTeB4o9ras4zSCmbc9LTIE+D4oJAgORMoVYtE/j4X6wJL471ZunPpUNOzkyvFURK8H1CTxa3JEtD+r1e4CjWWsGZXfI0tj49WhNCI4WhsQnAYsNjcTtg
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E42F6FED89FA3B4CB6EB311A4D451C84@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f07a98ea-642c-4219-b1e0-08d719ae81c8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 14:09:19.2490
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 03:34:50PM +0300, Mika Westerberg wrote:
> Hi,
> 
> On Sun, Aug 04, 2019 at 08:47:43AM +0000, Nicholas Johnson wrote:
> > Reversing the following commit solves the issue:
> > 
> > commit c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5
> > Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> > PCI: Add missing link delays required by the PCIe spec
> > 
> > Mika, care to weigh in (assuming you are back from four weeks leave)? 
> 
> I'm back now.
> 
> > Clearly this creates delays in "lspci -vt" in some Thunderbolt systems, 
> > but not all - otherwise you would have caught it. You mentioned Ice Lake 
> > in the commit log so perhaps it works fine on Ice Lake.
> 
> I also tried it on other systems but it may be that something is
> missing. Can you add "pciepordrv.dyndbg" to the kernel command line (or
> change the dev_dbg() in wait_for_downstream_link() to dev_info() instead
> and attach the dmesg along with full 'sudo lspci -vv' output to the
> following bugzilla (as I think they are the same issue in the end):
> 
>   https://bugzilla.kernel.org/show_bug.cgi?id=204413
> 
> Thanks!
