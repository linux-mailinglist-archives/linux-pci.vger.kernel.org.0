Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C99128149F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 11:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbfHEJAh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 5 Aug 2019 05:00:37 -0400
Received: from mail-oln040092253044.outbound.protection.outlook.com ([40.92.253.44]:4544
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726423AbfHEJAg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 5 Aug 2019 05:00:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dOlz9s0yCMTkh2ID732tYIUnCt5pu8NnJWS0X/VfIRLFlC6V+yZK8vHe9RjJMWRdodloVarSbyRf08eHUieRMv89MJHZVCa7OkAayyUkZRiPjfrXjsPO/68VT7lafH/VF2dRkNF2GicIaDx+Qil8N6TP5nHDialjQjXMPcbJCOd5AhtmMQ0N/GX6aXtK8uZ4PovC/sqHyX5qaM1IhZhUTo3OqQxt6V/dyCLkC+6LcFXkuP5CfaZ7Z0ZOxc4/vN7apsQX9X8XHsXa77S9/Hm/iwIJEN0Vh+EH+y0RstFhBRBl/noavHjlplTDVad2XzS3puYeD/VH3imnDDSenSq4Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5S90g7OKwtvpuauPNx5fC8l7P9LIijgpxfj8fQwfn00=;
 b=kUVvFxKpEA6A/pPJVGBIGcat3GTkg083USEql+aHAl0LHf/yZiQe45/t+lJXMMXJvZPWAB1vWp0rlmXRVyfDEgy8vpcHb10sgVqgjQxAm0IXt257tSozIOLn7LYuky3ua+H78cJnh9ysaUQk1ZAJ9dI8x0PXEtsu9EjyXHk4uCoCd4GjXVivBnSmgAVKgl5/slj8LSnKY+F75Z4tHHPUk8No8NruIVTzWJUx/d4lCz20icVkx4Z2260jlOKvTvC2PzqHLR45Mrn3aZEXj8jnTPgX/s5MMGhQnWhnKTWZYWfjmecfHDDtrbzqzuhU3wY+JksJQuYYTl5fjR6wl2E5mA==
ARC-Authentication-Results: i=1; mx.microsoft.com
 1;spf=none;dmarc=none;dkim=none;arc=none
Received: from SG2APC01FT063.eop-APC01.prod.protection.outlook.com
 (10.152.250.54) by SG2APC01HT067.eop-APC01.prod.protection.outlook.com
 (10.152.251.167) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2136.14; Mon, 5 Aug
 2019 08:59:36 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
 SG2APC01FT063.mail.protection.outlook.com (10.152.251.186) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2136.14 via Frontend Transport; Mon, 5 Aug 2019 08:59:36 +0000
Received: from SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222]) by SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 ([fe80::944c:1ec0:2a91:f222%4]) with mapi id 15.20.2136.018; Mon, 5 Aug 2019
 08:59:36 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Logan Gunthorpe <logang@deltatee.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Possible PCI Regression Linux 5.3-rc1
Thread-Topic: Possible PCI Regression Linux 5.3-rc1
Thread-Index: AQHVQh7cG4T+gPWoEEORs36yrE7T46bZxdcAgAGMzQCAACqSAIAPQRMAgAGVpQA=
Date:   Mon, 5 Aug 2019 08:59:36 +0000
Message-ID: <SL2P216MB0187F372AD56D1973304DCB580DA0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
References: <SL2P216MB01878BBCD75F21D882AEEA2880C60@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <20190724133814.GA194025@google.com>
 <SL2P216MB0187E2042E5DB8D9F29E665280C10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <4f5afb8e-9013-980f-0553-c687d17ed8d5@deltatee.com>
 <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
In-Reply-To: <SL2P216MB018719A03F048FFA0F745FED80DB0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0234.ausprd01.prod.outlook.com
 (2603:10c6:220:19::30) To SL2P216MB0187.KORP216.PROD.OUTLOOK.COM
 (2603:1096:100:22::19)
x-incomingtopheadermarker: OriginalChecksum:EABFFF0EC8EFE5E1635266CD95AC9DD800ACF965930423D13EE7B0863EF7F25B;UpperCasedChecksum:DC0D164BDF39EBD0D60331DA6F63DB4ACA583AC45624D1771EBC2CB4AAD3FD6C;SizeAsReceived:7972;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [hC47cSDXM4gVSqy5Y8orel70t2m4vb0iahlp3KBy/zBT10+INtCeDlfdKcVRU9mF]
x-microsoft-original-message-id: <20190805085926.GB65@DESKTOP-QG5GO4D.localdomain>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:SG2APC01HT067;
x-ms-traffictypediagnostic: SG2APC01HT067:
x-microsoft-antispam-message-info: w9+MLt3qiOz5hrAZEZ4TGJh45KwFhZyoYQ2oVfNOqmmZIffwDq4mhooxb03Q6BUniuUfzFeuJ4NToJIRH1bBijMp5+QiMe78Dvt/eQVZz5TQnfeQlO6Lis8Z5boUusvhaztEaTh/XRbSLdDQzDfovZ6JjHGFQKONoqp4k9pV3tqnnsp/ta4Q9amm5boo0zHQ
Content-Type: text/plain; charset="us-ascii"
Content-ID: <21AD01361E40D14C9C8E6BE389140395@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: f1c10bec-fb5a-48cc-1a31-08d719833d91
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2019 08:59:36.4802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT067
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Aug 04, 2019 at 04:47:36PM +0800, NicholasJohnson wrote:
> On Thu, Jul 25, 2019 at 09:50:48AM -0600, Logan Gunthorpe wrote:
> > 
> > 
> > On 2019-07-25 7:18 a.m., Nicholas Johnson wrote:
> > > On Wed, Jul 24, 2019 at 08:38:14AM -0500, Bjorn Helgaas wrote:
> > >> On Wed, Jul 24, 2019 at 12:54:00PM +0000, Nicholas Johnson wrote:
> > >>> Hi all,
> > >>>
> > >>> I was just rebasing my patches for linux 5.3-rc1 and noticed a possible 
> > >>> regression that shows on both of my machines. It is also reproducible 
> > >>> with the unmodified Ubuntu mainline kernel, downloadable at [1].
> > >>>
> > >>> Running the lspci command takes 1-3 seconds with 5.3-rc1 (rather than an 
> > >>> imperceivable amount of time). Booting with pci.dyndbg does not reveal 
> > >>> why.
> > >>>
> > >>> $ uname -r
> > >>> 5.3.0-050300rc1-generic
> > >>> $ time lspci -vt 1>/dev/null
> > >>>
> > >>> real	0m2.321s
> > >>> user	0m0.026s
> > >>> sys	0m0.000s
> > >>>
> > >>> If none of you are aware of this or what is causing it, I will submit a 
> > >>> bug report to Bugzilla.
> > >>
> > >> I wasn't aware of this; thanks for reporting it!  I wasn't able to
> > >> reproduce this in qemu.  Can you play with "strace -r lspci -vt" and
> > >> the like?  Maybe try "lspci -n" to see if it's related to looking up
> > >> the names?
> > > 
> > > For a second you had me doubting myself - it could have been a Ubuntu 
> > > thing. But no, I just reproduced it on Arch Linux, and double checked 
> > > that it was not doing it on 5.2. Also, the problem occurs even without 
> > > the PCI kernel parameters which I usually pass.
> > 
> > Ok, can you bisect to find the commit that causes this issue?
> 
> I have done a partial bisect and then found the culprit commit by visual 
> inspection. I would have done the full bisect, but I am using highly
> underpowered i7-7700K so each round requires 20-30 minutes of compiling.
> 
> Reversing the following commit solves the issue:
> 
> commit c2bf1fc212f7e6f25ace1af8f0b3ac061ea48ba5
> Author: Mika Westerberg <mika.westerberg@linux.intel.com>
> PCI: Add missing link delays required by the PCIe spec
> 
> Mika, care to weigh in (assuming you are back from four weeks leave)? 
> Clearly this creates delays in "lspci -vt" in some Thunderbolt systems, 
> but not all - otherwise you would have caught it. You mentioned Ice Lake 
> in the commit log so perhaps it works fine on Ice Lake.
> 
> Thanks,
> Nicholas

I am re-posting to add more information. Here is my Thunderbolt, with 
the NHI under bus 05 ("lspci -t"):

           +-1c.4-[03-6d]----00.0-[04-6d]--+-00.0-[05]----00.0
           |                               +-01.0-[06-38]----00.0-[07-38]----01.0-[08]----00.0
           |                               +-02.0-[39]----00.0
           |                               \-04.0-[3a-6d]--

$ time cat /sys/bus/pci/devices/0000\:05\:00.0/config | hexdump
0000000 8086 15d2 0406 0010 0002 0880 0000 0000
0000010 0000 ac00 0000 ac04 0000 0000 0000 0000
0000020 0000 0000 0000 0000 0000 0000 1028 08af
0000030 0000 0000 0080 0000 0000 0000 01ff 0000
0000040

real	0m1.132s
user	0m0.002s
sys	0m0.000s

But it is instant for all of the other busses - so it has something to 
do with the NHI in particular.

Regards,
Nicholas

> 
> > 
> > Thanks,
> > 
> > Logan
