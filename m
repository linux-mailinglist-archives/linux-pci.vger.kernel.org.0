Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDBBB1627F1
	for <lists+linux-pci@lfdr.de>; Tue, 18 Feb 2020 15:18:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgBROSp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Tue, 18 Feb 2020 09:18:45 -0500
Received: from mail-oln040092255071.outbound.protection.outlook.com ([40.92.255.71]:27639
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726445AbgBROSp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Feb 2020 09:18:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C/XRRPcJF7wffdbUZbXFis0SiYssTUl3uX4Uf3/yicaSBvHwiHMf5iAFarPqxs0x0iXNLu8FYgswk+54lSdcvfDQHQxa8mLCLeLZoR7+9UhBuan6actYXxME/nIMTUJR7zQ4V9qoXF8goHeY1hHoNkEJ4ll3DXV6bHMN0bAe5IUMyUlwQDCRmoVMhQa+w3sRTDBBNRvygl0Z/1clirPdjBF17b8AT0G3bz1dVqyqhW8QRFRfpnMUSoeFHBT2RwpwADCXY9KYw8xvcMmTMK3uBZXRTmhR3/cBKxqDYAhCvs7yaoJ+duE19YINjVv81j0xojBoJPF/0xacb3Iqd0qpXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRSDCrDGEYSSuwEcjqqFVH3Ps7EzVDwMG558kMuSPwM=;
 b=g6vvSLeUaMdbocUaZKUb3WMUbnyumws88QIdJkF21pAFOELRLQouMewOiQHswg/aAE0cpl0fcqTBM9Emc432OMY5BlB3cw+LnaDU2/MSTYsWLRy+gOyiSEYf+2KgLsJ99rd2dFG0gIImor5esKu+jFHioZJvDXDy67KcqMBaG7SIHsDVyd2/v+s79dO4PSROj3J6y6sya1E4K6JIjBerJUpUOPc4jLi+FXPl0ivd60u+2H5ygZGgI5wxQ2Yh8VI/TOYcWYZo0bpI0rF4XYeazNgNFLzje972M6ysKY1oR86EbPtUkjOsjwE1f2gb29lrLbEPsPvCX/de/YqhOQo2VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT029.eop-APC01.prod.protection.outlook.com
 (2a01:111:e400:7ebd::37) by
 SG2APC01HT095.eop-APC01.prod.protection.outlook.com (2a01:111:e400:7ebd::421)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22; Tue, 18 Feb
 2020 14:18:40 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM (10.152.250.59) by
 SG2APC01FT029.mail.protection.outlook.com (10.152.250.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 14:18:40 +0000
Received: from PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2]) by PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 ([fe80::a5dc:fc1:6544:5cb2%7]) with mapi id 15.20.2729.032; Tue, 18 Feb 2020
 14:18:40 +0000
Received: from nicholas-dell-linux (2001:44b8:605d:19:a52b:32b4:97db:591c) by ME2PR01CA0160.ausprd01.prod.outlook.com (2603:10c6:201:2f::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.22 via Frontend Transport; Tue, 18 Feb 2020 14:18:38 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Stack trace when removing Thunderbolt devices while kernel shutting
 down
Thread-Topic: Stack trace when removing Thunderbolt devices while kernel
 shutting down
Thread-Index: AQHV5mZRaprLG3S8P026BwNeB/+bQA==
Date:   Tue, 18 Feb 2020 14:18:40 +0000
Message-ID: <PSXP216MB0438220243C0097569D4B2DB80110@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: ME2PR01CA0160.ausprd01.prod.outlook.com
 (2603:10c6:201:2f::28) To PSXP216MB0438.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:d::20)
x-incomingtopheadermarker: OriginalChecksum:95A77B66E62B47898D73F43832FC6F5ED1B1D54D6DBC670E47AC004D4F00B941;UpperCasedChecksum:4740F6B0040AA4C3EB7F2A13CEF1429E3D21ED10CB17EEDE479D2959798B4B98;SizeAsReceived:7673;Count:48
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [LsHoodef3X6fJDRFC0k6i0n6zxy92qUVLtAZaMmRrhmyuVRJffuuPQ+iE3iOq29i]
x-microsoft-original-message-id: <20200218141832.GA6749@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 48
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 106dcdd8-cd1e-40a5-ddaa-08d7b47d7363
x-ms-traffictypediagnostic: SG2APC01HT095:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFVFZUoK0cx3DMLRwnm7MoYgtFwavmlcblqB/PxGgJYNr406lCek5KU4P10aVqRAPRnjN/MIKD/CL3GMxZTRvajvEhyJ7iap8LFuVUpZYcyxJ3ZyluDaXVduaDkoleDlWbbb2ldCANGGayJGCoS/GwmDBsR8We4fO0JiZJZ4xy/WEhD2N2Ut5gFQYgHE/vBa
x-ms-exchange-antispam-messagedata: YlBqRqLtyWK+yb8+zU5hpRyNc4BvJDOZTD2vb7v/bJu9H6Koypt/ZJ04YOdZyYNaWJ8J9vZIk1gW0z8o9c0XTrvSqEytDcdCkBykkqUB1wbLVcH1we9PiQUqOdQmh0h9riF+XBX1vWNAOSFxZM8MsKM09MgCkkfzP1gEc6QVi5sxhG7Ct+O9jj5hGs+sexk+LpRPDn1rfXsGDa/XxvQdNw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F4BB3CDFBDFF249B92A82D2771BD2ED@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 106dcdd8-cd1e-40a5-ddaa-08d7b47d7363
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Feb 2020 14:18:40.2537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT095
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

If I surprise remove Thunderbolt 3 devices just as the kernel is 
shutting down, I get stack dumps, when those devices would not normally 
cause stack dumps if the kernel were not shutting down.

Because the kernel is shutting down, it makes it difficult to capture 
the logs without a serial console.

In your mind, is this cause for concern? There is no harm caused and the 
kernel still shuts down. The main thing I am worried about is if this 
means that the locking around the subsystem is not strict enough.

If you think this is worth looking into, I will try to learn about how 
the native interrupts are handled and try to investigate, and I will 
also try to get my serial console working again to capture the details.

Thank you for any thoughts you may give.

Kind regards,
Nicholas Johnson.
