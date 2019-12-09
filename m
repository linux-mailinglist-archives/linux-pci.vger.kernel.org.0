Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C214116D62
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2019 13:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727403AbfLIM7f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 9 Dec 2019 07:59:35 -0500
Received: from mail-oln040092254038.outbound.protection.outlook.com ([40.92.254.38]:6242
        "EHLO APC01-PU1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727268AbfLIM7f (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 9 Dec 2019 07:59:35 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C1mb8DFHhjgqTdjfvG0HnunEo1wpvYzXML1lj+U8Eq3HDeKVEpUp6UbRweEh2t6ZHqAe4VUcAZv55Er9arwtr5Jy3RDwytp/xMzbUoTXgVzaOVqMQH5jOp6eniferMnYnvgBLBByqf83L1XEWBe1glUsx7o2Ygd3YzUbT5ZxVXSbqIaMjgA2LZanntT3EDw80A7KsWgqik7LVLM7UBjtb3Yl8wrnhIuVyN2TZGhY/wTj8qk0ITxl+19DqS46KncqcJMCtIgnz9qHl07Yp/eGW1czLOvFJe7leRVYJ4P3eUZF2deBy3GvGsVjuAvRTybFrQwiu4OVOO94GpeGJI75IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hgt8Fz/34WB95+U4hN92T52HVyUmskbWlFqc0YnLzYc=;
 b=iIvCh+C2xevQBmiWEZZYPegNCe97lZqF+hdcQ6BFIwszRpjLspTkKEhOcNoXLCw+byBvnu19d9lVBzAn8DgKdgW0038yRMmG1cJR4kIAUNeegVo2CE+OWbZ18Ydw0H/HlhDSypARWBbndaMvXU3eXvyrIsJL0cDuw6b6D1yVhT1/Mn3LDMl+7BbZNyMl9oc+YrWKkolAG0IK+J87irm4hzZ9OccVPMoWWbAcLxOrJ41xvXhJqzrWIWoRE+Ti227zJzVJRYJkoixLVVtvmn/PHljwdAnqarneF3TRCMM1UaZw50McU6+a7XicfKx4vdUJu9LKUvr0UMBolmiEOEhcGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2APC01FT003.eop-APC01.prod.protection.outlook.com
 (10.152.248.57) by HK2APC01HT157.eop-APC01.prod.protection.outlook.com
 (10.152.249.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2495.25; Mon, 9 Dec
 2019 12:59:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.248.51) by
 HK2APC01FT003.mail.protection.outlook.com (10.152.248.173) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.25 via Frontend Transport; Mon, 9 Dec 2019 12:59:30 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::20ad:6646:5bcd:63c9%11]) with mapi id 15.20.2516.018; Mon, 9 Dec 2019
 12:59:30 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt enumeration
Thread-Topic: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Thread-Index: AQHVrpB+5sK/XGeQw0yttw28ATWBvQ==
Date:   Mon, 9 Dec 2019 12:59:29 +0000
Message-ID: <PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SY2PR01CA0012.ausprd01.prod.outlook.com
 (2603:10c6:1:14::24) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:7C852B1160D71DE0BC17718381C76994FB1C9AF457069B62E5B9CDE6960760F0;UpperCasedChecksum:CE825370DDC225232E408D4E10A8C56337384988E6AFC10335EA5D58A8DD34CF;SizeAsReceived:7581;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [kCq2nX/44n6NdUQZwoGdrHcH5tPiqoIwapPGfhfH0/sDIhJqlYi2dqlWq2aeHdHRc4Xa8smMnCQ=]
x-microsoft-original-message-id: <20191209125921.GA3002@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: a830161c-5e08-4115-8241-08d77ca7a0c9
x-ms-exchange-slblob-mailprops: 3yIWLBAu26se/8SSSCRihR3j5171sTECVcaLCetuwRKF10ndRmopwzw8G/lU1sbld0A4qCJNIAhBThag5v38+rXN1X5zOKmZDZsfyWCdBboOnylDX53fm0C6W3icm5swORqf+WP55SnS+2qQIgcjciGNkqopa4V7liA4b6SmETUDr0cXg3aeUmb7oosJn4/oZbNQnXH9nAcaXaeWbK9C5igLElH5VDpgUtjfrtuTBWzW4xM6OU8tIURUcjYEmf9EhsqWk3pNcLyNp+cWaYM3hZxi/CGSxmFgfK6J8hyabgFpTT4u3EkHrh5XHlOeN6U6TypQYKd8UyjDTTgwGNtk9oy5bQrlElOBjcNr02TQv26cljtujzFHxqSYDqJC37IRAv/hFvoQO18QgDmsMzR6ePGKqFvqSToQrV2sBUAuBbrVxtkKBKtsH1uo9Z3nuaaZaRuYF64xxMeukJfPFNFPeE9p2rxxcOdHynNFUIxGcp0zfahGSADAcswxfJ51/VxFWJLK/oUY5Vhfyh0vxAYO+4h1jmZ+4Psc2Wt2ShrmFEc+LZp5YgfEbHxxGra3oAYJJrbXrQlfyAK7lGywDBQaTPOiaeW3X3SrOZMffI8mC6WJxgw7wf5OH9dvyUa79Ka88X9+vVge35gCHH9SAekSuw==
x-ms-traffictypediagnostic: HK2APC01HT157:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SzWYkLetMomjITTtuRb/EyVadJt56HfWTdvu3TmfwyFX7CrCgZHuBBIGRzEsJiaj5StN+gY2X5y2oqwww5+RlAK5e2Iaiyii7sXEGSU42OlBgFZG7PBAEU+hmZ3tuu5Mh04QzcIF6NE05mEC0zYnxu8fmy2DT0c/biShdT0yBuH7EmFbOizdMn/kVrCSFbxH
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <601346C75C0BA146B990CA3963CB7471@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a830161c-5e08-4115-8241-08d77ca7a0c9
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2019 12:59:30.0795
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT157
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi all,

Since last time:
	Reverse Christmas tree for a couple of variables

	Changed while to whilst (sounds more formal, and so that 
	grepping for "while" only brings up code)

	Made sure they still apply to latest Linux v5.5-rc1

Kind regards,
Nicholas

Nicholas Johnson (4):
  PCI: Consider alignment of hot-added bridges when distributing
    available resources
  PCI: In extend_bridge_window() change available to new_size
  PCI: Change extend_bridge_window() to set resource size directly
  PCI: Allow extend_bridge_window() to shrink resource if necessary

 drivers/pci/setup-bus.c | 182 +++++++++++++++++++---------------------
 1 file changed, 88 insertions(+), 94 deletions(-)

-- 
2.24.0

