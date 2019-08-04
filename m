Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEAE380A09
	for <lists+linux-pci@lfdr.de>; Sun,  4 Aug 2019 10:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725987AbfHDIrt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sun, 4 Aug 2019 04:47:49 -0400
Received: from mail-oln040092255093.outbound.protection.outlook.com ([40.92.255.93]:8367
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725941AbfHDIrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 4 Aug 2019 04:47:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ObSQPhqefH4p8hb1tneJXRyoz4t2iFcfl8n+imv4qIKW1piSpzlO2ikOdQiapY4ftklBONX4Gqgu0b2CJsYE4vIkl1Svkqswj6PuAGwUmlbsB+31Zr/RmZ/JMLHXrUrQTYANre0egcGxKnjbuEohfyPgsvnuIF1sHqyzVPr9I5Q+ImU+uDM640txV4YoCVCS/eRxGyKmbRjDtS3bJTMn9FIaERyZjD7inhO+SzFeFi3DNfwX+SI/5NHpIBSQOlfHqOTiVRSCpx9Y3jvN1i74Reb8HJIEh/QmlE+VvnW3/VsZGcoQUeSLMl9e8Xvvtu9szyhsXqCriVd6FCvXBoScbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBoY8klwRSqoATzr4W4Xphpt/DHTTzYUCuRp+UJrYh8=;
 b=XoUu44pFj5eauh8SvHwkQOiKy+TeNO5AN5kFFF92e5T/lhV3IzumHgNllmrwvEZS2uNIua5m2ae1Wx0GxKq+gs/wesBlrtwnVQlqUF8/ZDzCZEmcY/wctwqU+riX0I4ZATGFy5ND4sSaGIouYRGh7egkZ+d9mHlXefrsMempH9WSFsDBii/Z9+09dSKO58Wi4L5JcECAkYJDF7X1C7dWD7NG+d2d1CLlGIZUrCuYPTuiGvi+o3lgiIy1sfJfIHCBpuKSAyMA6sJnN0loN6n5M0RiMfxxYW7ML2eYlEqe44+6z1a25YP2wZ7a7BZHar8/DZP3IJGzLvYLlAoB/MCyjw==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from PU1APC01FT114.eop-APC01.prod.protection.outlook.com
 (10.152.252.52) by PU1APC01HT096.eop-APC01.prod.protection.outlook.com
 (10.152.253.55) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14; Sun, 4 Aug
 2019 08:47:43 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.252.52) by
 PU1APC01FT114.mail.protection.outlook.com (10.152.252.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14 via Frontend Transport; Sun, 4 Aug 2019 08:47:43 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222%4]) with mapi id 15.20.2136.010; Sun, 4 Aug 2019
 08:47:43 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T46bZxdcAgAGMzQCAACqSAIAPQRMA
Date:   Sun, 4 Aug 2019 08:47:43 +0000
Message-ID: <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
 <SL2P216MB0187E2042E5DB8D9F29E665280C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <4f5afb8e-9013-980f-0553-c687d17ed8d5@deltatee.com>
In-Reply-To: <4f5afb8e-9013-980f-0553-c687d17ed8d5@deltatee.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0034.ausprd01.prod.outlook.com
 (2603:10c6:1:15::22) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:687E78227E36C9A1F78151900A7B392D3B71E2801387B6D79D0876E837BC8D0F;UpperCasedChecksum:F8C34AC7138353657652655ED211C9ECA0596D9E62630FE958BD65F8E5E7F7C9;SizeAsReceived:7832;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [qbTCdgIBPRDPBI+6BLB1uVlGK1pqw8wAeewJmhyYr4JyvZiMPnvCwYrL9lZOpnjAjyLll1fd0w4=]
x-microsoft-original-message-id: <20190804084734.GA1814@nicholas-usb>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:PU1APC01HT096;
x-ms-traffictypediagnostic: PU1APC01HT096:
x-microsoft-antispam-message-info: 7QgFUB59Iqb/+QN30dPzSOS93IUR587ljuvMCnln+THlYvIGT0cvrAud872teVhF+iRgvepD6ctyq9gQDFq8+KgaLLl8+8Hdu8pa3yAj3bLHs3LoeUuMG7cVyG+FR/HAZeuv/fgiPeUKVwz9McTO2TU0FQqZBrlOgohc0UhRgl521Wd9tk/3m2CZIdr3nq2J
Content-Type: text/plain; charset="us-ascii"
Content-ID: <89D9B2F90ED0E445A718CD8EFD63F0AC@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 04e07db5-6baf-43de-3c17-08d718b86a39
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2019 08:47:43.4747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PU1APC01HT096
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 25, 2019 at 09:50:48AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 7:18 a.m., Nicholas Johnson wrote:
> > On Wed, Jul 24, 2019 at 08:38:14AM -0500, Bjorn Helgaas wrote:
> >> On Wed, Jul 24, 2019 at 12:54:00PM +0000, Nicholas Johnson wrote:
> >>> Hi all,
> >>>
> >>> I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
> >>> regression that shows on both of my machines. It is also reproducible 
> >>> with the unmodified Ubuntu mainline kernel, downloadable at [1].
> >>>
> >>> Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
> >>> imperceivable amount of time). Booting with pci.dyndbg does not reveal 
> >>> why.
> >>>
> >>> $ uname -r
> >>> 5.3.0-050300rc1-generic
> >>> $ time lspci -vt 1>/dev/null
> >>>
> >>> real	0m2.321s
> >>> user	0m0.026s
> >>> sys	0m0.000s
> >>>
> >>> If none of you are aware of this or what is causing it, I will submit a 
> >>> bug report to Bugzilla.
> >>
> >> I wasn't aware of this; thanks for reporting it!  I wasn't able to
> >> reproduce this in qemu.  Can you play with "strace -r lspci -vt" and
> >> the like?  Maybe try "lspci -n" to see if it's related to looking up
> >> the names?
> > 
> > For a second you had me doubting myself - it could have been a Ubuntu 
> > thing. But no, I just reproduced it on Arch Linux, and double checked 
> > that it was not doing it on 5.2. Also, the problem occurs even without 
> > the PCI kernel parameters which I usually pass.
> 
> Ok, can you bisect to find the commit that causes this issue?

I have done a partial bisect and then found the culprit commit by visual 
inspection. I would have done the full bisect, but I am using highly
underpowered i7-7700K so each round requires 20-30 minutes of compiling.

Reversing the following commit solves the issue:

commit c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
PCI: Add missing link delays required by the PCIe spec

Mika, care to weigh in (assuming you are back from four weeks leave)? 
Clearly this creates delays in "lspci -vt" in some Thunderbolt systems, 
but not all - otherwise you would have caught it. You mentioned Ice Lake 
in the commit log so perhaps it works fine on Ice Lake.

Thanks,
Nicholas

> 
> Thanks,
> 
> Logan
