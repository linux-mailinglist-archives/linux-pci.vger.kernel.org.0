Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA2EFB3A4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2019 16:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728008AbfKMPZN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 13 Nov 2019 10:25:13 -0500
Received: from mail-oln040092253036.outbound.protection.outlook.com ([40.92.253.36]:47936
        "EHLO APC01-SG2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728005AbfKMPZN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Nov 2019 10:25:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fkYEakjJZYvrHlx5C5JvcflXi5alb2f4zWetFN2hCUmgzNeCr4Re12GV2wmmmK9r2hh1AfTjAxp0TjzLVHe389ftWzuM9zY7vG5ZZfGNAUzziApNOVC022kFijs8+kxwaDFKWOba5E7mDOeHEN6bPd99Sg4cudO6H4bL+NVJqmt9XPxWxLMhhK5dEcEMdTULD5cX+Aq+/mKjTayXpeHWLrQBVWpXA8D7AeYH21kINBwsXK7oA8StdTF4qMgCWyQaIAvkMgRpvRTM9guLhsTHf2z8fU8cXAxxFHm8P27u3q558unYnQX3uXLrmsB9F9eZU8yjjP+6GllQoxR4d276nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ISP7/D8TS0ssr/P+BKguybYIiQAbD999lXY8SXapgrA=;
 b=a7eDWa+uWjNOR0Eh2J5jfwgPfLtnEKudYR56C3QzHy4gQoKqQSq1fUHBjTvDUNYgVfScJrfDIWQ+ZFkRXxXe1yW2YtTnu0TfWj8GyxXG03PXicdvlD5lpRRr05Ccpk+pJTge1jPIR1I868i2W9QqIQaR0kxJClxIHUibkTMb4MZ8arOlPU78U2T278hsJInlHNhKFTzPZjXRY75TgnzsbOsTMjy5kQgK8oPOFbe0AfvHRR+O4es+Z00ey8uESfitvk4kOcwIKGHi4CF8bB2XPagT/kNDM/M0lHizKLH16ZB8uJbE2W052cxi4o45LJgsVZoRw3Cbgs3Jaev1Y2b4Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SG2APC01FT007.eop-APC01.prod.protection.outlook.com
 (10.152.250.51) by SG2APC01HT102.eop-APC01.prod.protection.outlook.com
 (10.152.250.253) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2430.22; Wed, 13 Nov
 2019 15:25:06 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM (10.152.250.58) by
 SG2APC01FT007.mail.protection.outlook.com (10.152.250.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23 via Frontend Transport; Wed, 13 Nov 2019 15:25:06 +0000
Received: from PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602]) by PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 ([fe80::44f5:f4bb:1601:2602%9]) with mapi id 15.20.2451.023; Wed, 13 Nov 2019
 15:25:06 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "logang@deltatee.com" <logang@deltatee.com>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v3 0/1] Fix bug resulting in double hpmemsize being assigned
 to MMIO window
Thread-Topic: [PATCH v3 0/1] Fix bug resulting in double hpmemsize being
 assigned to MMIO window
Thread-Index: AQHVmjaG4rzeiLW1N0+O23g/Zlpwsg==
Date:   Wed, 13 Nov 2019 15:25:05 +0000
Message-ID: <PS2P216MB07554AB9A8B0693212CDAF6480760@PS2P216MB0755.KORP216.PROD.OUTLOOK.COM>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0056.ausprd01.prod.outlook.com
 (2603:10c6:10:2::20) To PS2P216MB0755.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::13)
x-incomingtopheadermarker: OriginalChecksum:230C1E5DACBE5B9B8EF30B916561980829D529344BBDDCDAB29C78D6CD850D07;UpperCasedChecksum:F652AB35C875A03BD96F1689F3FDD1FC582A29CF7DE803EF8ADCBEA1087D20DB;SizeAsReceived:7681;Count:47
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn:  [AtdtRdYM9W6A64Z/4YfL8VBjDL6pbh6NUbqjYHjvJrgLTmmcbZrYuX0zGt6Fqs15G1xQ2bYMs5U=]
x-microsoft-original-message-id: <20191113152457.GA5033@nicholas-dell-linux>
x-ms-publictraffictype: Email
x-incomingheadercount: 47
x-eopattributedmessage: 0
x-ms-office365-filtering-correlation-id: 3de3f1eb-58c6-4e6d-2b37-08d7684da926
x-ms-exchange-slblob-mailprops: cF9fn+9l+fuoXw0uJWgN4LHeYIiRVMC9JLTpVqIM7OyGIBbw663UQbxWfmOmSx/95YCZM5i/vZD7RAiiE8ibexILSHvALRYTDVj8NyT87fiG43g7uiAlum9HVMIUegCiXPMt63hbiCs6dhFU4DHLyN2B5FxXB63aSyQoveT3FO7qKStrJGJgYaBpjiovrfAWkvdsdVttniGGSsFYPFyJKG1d+aCb8oAK1RsGZIO0mmAgz52DXq3FrdeuysCInextnqNqdn7j1QCvt/wVY22f8AYqBA+PgvT7i3DetaG7vNqS1tNjKAS7KigjImxUAmxSMaKpoBjDL35icoRvm1rGwN9l6qM7s/K8OnUGZ/AwyuAtTz42wV/MMS0V8XvFm9twd49VzwRMKWlV33epW/A1J4mzEqwIRUq2GV6GjmdeUDdEXkXh03vZgy9E4J1POjzv0OeDNGLddIfro5i1OTFtmUAtur/RW613iL1Xs4KdIVtDPWWOS/QU/dDBDu9d40By/fvDdMC9EE/h4+6YQ+s3E6GscOw5wU86JmYXqyCmd5Wn6GYTt/RsUwPbVSRL+LoXqL2IQVK8dvPSfixwJJI3pvBWTPij+JNdjKFwS/8S8SHNG8cZOWKTSwk3zGlHxxeO
x-ms-traffictypediagnostic: SG2APC01HT102:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ukBQ4vU2agnjymlw8IDc0UXhkS6XL4X4aj0qQ8ai1BDeBmLD5CQXOqJVh1IglN/njb+8Ft2l6/KZDVhl+JwB2wtZdqJd5Ao5CBr9Qyx6ebdMdcoVtXzLCzshDEAngP+/Ov2TJq1l16Cr6oFHlpTQdnAYASgOd2eBfsbbZRnlCPA/OFqVrxM1ZzTmZvhz7w7A
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-ID: <F540D89F41CD35488BEACB5946F33258@KORP216.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de3f1eb-58c6-4e6d-2b37-08d7684da926
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2019 15:25:06.0533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2APC01HT102
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since last time:

Changed order of parameters, added comments in the code as per Mika 
Westerberg's advice.

Added Mika Westerberg's reviewed-by.

Nicholas Johnson (1):
  PCI: Fix bug resulting in double hpmemsize being assigned to MMIO
    window

 drivers/pci/setup-bus.c | 38 +++++++++++++++++++++++++++-----------
 1 file changed, 27 insertions(+), 11 deletions(-)

-- 
2.24.0

