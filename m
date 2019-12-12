Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9446711CA92
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2019 11:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728589AbfLLKXb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 12 Dec 2019 05:23:31 -0500
Received: from mail-oln040092253056.outbound.protection.outlook.com ([40.92.253.56]:6191
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728339AbfLLKXb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Dec 2019 05:23:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQX9L+MQcArEmTu+v+Z4CHMtdaEpT0EHUFyQd+rtFo+NmGQAFeqESJbNz05DnNgWf6pOvii0qw/5E7HMmK91VuvnRTMqReE3MulGI+yAK0ogV5MzOVxtvRzLHUsReR2Ojp7KWG4fhh2ZUES0tSVDA8+LZprsNiSBKFKhhCX6maAYKTQqE/I7e3QIllSUjyslnhxQePtIM/zYZwdmumcA1b0YztO2NYy2u3vv0CvT1Jd2JfYADpB/q/0LD/e2ByC52rKNAZHrJoaHZ/l5kULfZAfsVUVZ6rO63Or9adcXEvbOCqCybl/hJqAhr9TorvG/EE3ZWYxWEAZLtK1qGoxOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2suxBRlx4DortOsNvdQiwdZ9XeaEm9SX5PpELvBdc+s=;
 b=lQDrxaE2C0KM6bBaWEgky28z766sT+RQ/IJCqo/yasCi+u6+pOk7EZJ9os0/OkAHmHuMGQ5u2nVFoq5MmUVPHrYT+DBOmoTF8a/74Dsb3sAdngO76YDSJO9I1eYpBKIBCwGMojk5RsG/424mLyVigPW04qU2dzZUfeo+neVjsPmhMxSQdbHtV7+C1H2Uz1Me/4RNyJt+ObFEHAlIifHz1ClKWkL2vxQxnbkeIPquX4j05oxpE1q7hmtAgbCd0sdzIGwdfBNlUrB/zCmXt5+S0f2Vw6rFVcI1novCUyeumgHi3UFLHiSP/QIVJjFaIm3FHjUEl3HLNdfxUFseExLbww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT050.eop-APC01.prod.protection.outlook.com
 (10.152.250.53) by SG2APC01HT180.eop-APC01.prod.protection.outlook.com
 (10.152.251.183) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Thu, 12 Dec
 2019 10:23:26 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.52) by
 SG2APC01FT050.mail.protection.outlook.com (10.152.251.238) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15 via Frontend Transport; Thu, 12 Dec 2019 10:23:26 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2538.016; Thu, 12 Dec
 2019 10:23:26 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Topic: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Index: AQHVrpB+5sK/XGeQw0yttw28ATWBvaez5zkAgAJn/IA=
Date:   Thu, 12 Dec 2019 10:23:26 +0000
Message-ID: <PSXP216MB0438B40D6EFFF5F9B5952F6580550@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
References: <PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
 <20191210213836.GA149297@google.com>
In-Reply-To: <20191210213836.GA149297@google.com>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0100.ausprd01.prod.outlook.com
 (2603:10c6:10:1::16) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:08F74278F8568228DB0DBBC190698F687120CB3AB3BB5E174018E19F267EE2CD;UpperCasedChecksum:F4E01E1F6AAF9B48191FDBA8D8A0D702537B3C556F6E680C35DFB83F6261F3E5;SizeAsReceived:7693;Count:49
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [LtKVBW5ZIO1RG3O+fC9OjTqW4dAtljzfF3k5Phq8hQWWdwWq4711EspiPt5lKaIVNev+t/YTcEY=]
x-microsoft-original-message-id: <20191212102317.GA1503@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 49
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 345ef186-b1c1-4286-8b80-08d77eed5276
x-ms-traffictypediagnostic: SG2APC01HT180:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6JqG5le3xz48xCiNrYSWEcj7I8/icb4hySvLnLXeE7pRZlqbFruzM0Lgjosw2VNPawcNzJJg+mgX99BKm9mhzn/YNnpq0gqBPt/F7OgcyTC5fBEWc8iTrEA6RJGoXyhqJJ760gE355YBRWfpgrpOJdDiFTLVcBwFs9htijlCMTdkbusOqkJOkpJxnM0glW6h
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <ABC6B899D7F08A4E8A8F1D0B29364526@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 345ef186-b1c1-4286-8b80-08d77eed5276
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Dec 2019 10:23:26.1709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 10, 2019 at 03:38:36PM -0600, Bjorn Helgaas wrote:
> On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> > Hi all,
> > 
> > Since last time:
> > 	Reverse Christmas tree for a couple of variables
> > 
> > 	Changed while to whilst (sounds more formal, and so that 
> > 	grepping for "while" only brings up code)
> > 
> > 	Made sure they still apply to latest Linux v5.5-rc1
> > 
> > Kind regards,
> > Nicholas
> > 
> > Nicholas Johnson (4):
> >   PCI: Consider alignment of hot-added bridges when distributing
> >     available resources
> >   PCI: In extend_bridge_window() change available to new_size
> >   PCI: Change extend_bridge_window() to set resource size directly
> >   PCI: Allow extend_bridge_window() to shrink resource if necessary
> > 
> >  drivers/pci/setup-bus.c | 182 +++++++++++++++++++---------------------
> >  1 file changed, 88 insertions(+), 94 deletions(-)
> 
> Applied to pci/resource for v5.6, thanks!
Thank you all for your time, support and patience with me. I have 
learned a lot in the past year.

I will obviously stick around to address any potential concerns with the 
patches, but it also seems like kernel development is what I want to do 
as a career. Hopefully I can take this beyond a hobby despite my 
physical location. Perth, Western Australia is not big on this. Perhaps 
there are companies open to telecommuting employees. In any case, you 
will continue to see me around.

Kind regards,
Nicholas
