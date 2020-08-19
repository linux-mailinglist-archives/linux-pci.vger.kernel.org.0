Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F15924A41D
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 18:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726874AbgHSQcL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 12:32:11 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:43141 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726854AbgHSQcF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Aug 2020 12:32:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1597854724; x=1629390724;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zlO9e+p2Z5JkXzCMtcipJaeTOHC6wswv8m/Q9Kl1vZw=;
  b=SSh6SgBWPWwsmvWOmDG99wwCWZ5ZWAKgvCkT7LOuH231ipXysWBcT7kh
   db/Sr79/uC1xJ0H4UBEG+g2RY3dR5CQCMZqgZYpPU/H8B4AdkV8YYJwPo
   0SA7O11izFmERA2EC00vYzO3r0+2zgXlkT34TaUPZ4ALw4Ku5E4tyqb1p
   88os+iRQ4Ntk8BGQtMvccK6Hcft9mT9c0s2G56sbPoj33zAv88CkhaCne
   Fh5DO4oDTss+sEBTXmbIIam4nvHQXb31iGuGP6yjvUdBiSxRy2d6DqTiY
   kTIEXZ8sFjv77ryLD/0inXUNNIotkDiLmR3mGJFORwYzGQqy044oX8cdj
   g==;
IronPort-SDR: 5G6/Tf067vdojdS4ZVrlEcoCK50ItL/fl4mP3XS+hO4wP1ZbUIEnCH4BRy+gD70bSy9HcWkiKg
 QhU7ll86RFjfKQqdgjD3ucTpcos6OTHfjgQvHFXCYiiNhL9UypMxw6vt9Af2SAkjrZyD6FXbqN
 w2pOC6fJkB+FLfeLwvnZjGPJ1dSMp8zXGoTJpiVd7sJzt4ElypRWC4QyocPS+LlBULjSL/TYyd
 HcAFGQCKzW6RnyiJ9zF6vTagZb9DVqqqa7QiqXZ0NrmjwOpsJgxbFsGBWQu20e9qP8FE+7zvE6
 PO8=
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="86198988"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Aug 2020 09:32:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 19 Aug 2020 09:31:05 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 19 Aug 2020 09:31:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ccMUJtZooaiL4mkpbKhBxHJablNo1khDdqhyLdktnm9luBv3h7OpPC76+gIjC86LVBRGNnMm5t8VRgd+xbDpnGyB1bvKF2aBHIfX0LTewXeP4BhPA7LDm7X01lDLTsvamn/6SAlmdcx7mpcDOIYQGDu51kWAD5C4nhEqLhmZPF0DRvWyecEScjehNAx8EHEcCP/ylqYRTga35gFpql1rMkZKPYcDyvw9/qswetS42rObsL8U1t5DiJ87jhs/MT5gZUnu2mIlDWjxBRFSoWnJiYrlu3vgSxqluSY6FkEBSxyEpR1xV0ngWQJHtrB+NVyu1VikSv5ZrmKLj3YxCyeocQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlO9e+p2Z5JkXzCMtcipJaeTOHC6wswv8m/Q9Kl1vZw=;
 b=g40hTYr6H7nK4HnyAdH35KO5oh+aRhjS/58FfYmBGPHLnBCrdFFHkfv6bQgC2NM9XMLvmZurIVqbck6xr1t05g8NVJ7nJ7K0u9Gul5YH2wRZPM07y6pXjFxP+3Xlmnu4MprmCosDMwoNObEY4jndrc8ERIxEbx+5vdE/n5MvNhYvkYQr8bUCWG3nyCfAkX2JrKQeizQrYxEcn08twEFgmHvXBEeYm3d914o6OuwoUp80y3pASsWISFZnvvvZvttRklhtrXxRsnoqK+dZCU1gGsiUfxRhXZCqqC0lIZsJZPKkqaPqx0HSrg3GBSJxyFmyKsrVQDCl1/RHFT8B+tlx0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zlO9e+p2Z5JkXzCMtcipJaeTOHC6wswv8m/Q9Kl1vZw=;
 b=qleCFV/nbgH0e4q1rU0X6PgjL2U024BW0x3T0DMTnIOumKn96IUKAr+lnh7goP3JLkG1Sc5kgkKTsN4+POdiU9ks2WT6HnXwNyQlPMl2huHvPVQqn9rTX9KEqVKjsOi/iyfhz5RK6PkjnDShSweM2yBBQZz1w6MJp3WcAZ/c/rU=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB2916.namprd11.prod.outlook.com (2603:10b6:208:72::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Wed, 19 Aug
 2020 16:32:01 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12%7]) with mapi id 15.20.3305.024; Wed, 19 Aug 2020
 16:32:01 +0000
From:   <Daire.McNamara@microchip.com>
To:     <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v15 1/2] dt-bindings: PCI: microchip: Add Microchip PolarFire
 host binding
Thread-Topic: [PATCH v15 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Thread-Index: AQHWdkZDvS2GOcXP5063xkLNR54ZTg==
Date:   Wed, 19 Aug 2020 16:32:01 +0000
Message-ID: <9228b6315ba92e9e74b3f6484df6f4957ec4faae.camel@microchip.com>
References: <954a9f86bbfe929bc37653f1e616e8acff8b4bd8.camel@microchip.com>
In-Reply-To: <954a9f86bbfe929bc37653f1e616e8acff8b4bd8.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [87.42.139.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b595daa2-36be-4a63-4f9f-08d8445d6668
x-ms-traffictypediagnostic: BL0PR11MB2916:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB2916EE01E78DAF28784FE597965D0@BL0PR11MB2916.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9GFf6dGoIBqNl78BhX7VG9MhkOAM3hTXyNzsuXAXlrbcN+88Yu/zq3yHELfLGEJTCKiXxkgTB14UtogijJOSX8XJB3ml8xexu0/0HcmHrYi3Ysa7Qwyr7PWS8z2hR2Ok/JTuefLVyzu9/x159JYRfQK6lZ0wXW8zlt16rqW/+94CKGSsg6zV8b0WrDK7rtJrXoZbCeIqlVDst+YozqB6BFF+ANcSlcCaBYqq+o0q61wxUAYyiYvumj+tvAbYyI0r8SPphZWtZNy4TZKFLyuY7Jxdeq/2MwtjiWGsWBi0eYWOuZVJW7KWSv36QHU4ulvVVLf+pmVS73OvVYHI8snv4ANqgXQ7xmF8ojJumOKtm2wuCWveuLCqPi4jFzJh8AIjt48SYDGRBpce/7Hxx/xy3w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(346002)(366004)(39860400002)(136003)(91956017)(64756008)(36756003)(6506007)(66446008)(66476007)(5660300002)(66556008)(186003)(6486002)(8936002)(966005)(2616005)(8676002)(2906002)(26005)(110136005)(4326008)(6512007)(71200400001)(76116006)(66946007)(316002)(86362001)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 6cXy1najZT8Hxkv8TyXLvCVKkqo4TshN7fFoOYUX+fbhrZ3p8KSdsCb6lRDLn3zAZwaKXFEeN2gx9lIW1s3fvm4QNYjq6tKDypFcb7XFTtTP3OSBlL7UFWo0dSAFsP3wlSO5AKCBuSVfmN0ouVGgr/kpImZpFA2SGLmo7uVu5SS4+6TMSkgWeX5jxU92jrtwAvIikkS+EhjuBiTcxnopYg6JwG7WprCRXEoHUv2MU0WQiLRUEfpuFtmRKgmEkwIUgsxjSNrDp5rOxKjQewNwJkYJ9A5SbJx+jHpC6vnPpmfZVtI3lpkuc0hGbK44k/gEDKKImmjn97KKEgrDPcPF+yUrZ4JH0YpOqN50PrFHq7Ht3Yupu0357u9orf308AGndsTI8LU+i9tMoNKD8w5dvmNdkT6qeNjKgeL7OPersZMbs3ek2m20VFCWKaCaBW6jKhbREusofhRSRlek1mSu2VREyY2HVbipjW5ld+jlQP0lWjzYvcN/D/l7WiPtmz3/w/GfPSlruUDr/oZiw4sm5N/pDe9VhafcYy+pO55ue3LsHY9HV4r0oybWVGJAXcN7XCHqgb+Z+1mdirSdCpVUUhgRQSde3A1H9kPhhVay6yoUKIBFxL7HAwKt0BBbqC+SAClPqKLvvzJB6bITSiTkoQ==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C382718765FF7040BEB20407498A9B88@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b595daa2-36be-4a63-4f9f-08d8445d6668
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 16:32:01.2855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jdMdt4uugxFWJu18AU24BUQFDSj+yocGnH3f2K14r0OgNtr7FP/IITuhC8oZyv5P42IvuNtgIK2zODhsliLShzL2eEntVM2lLJGuimlKTkE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2916
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIGRldmljZSB0cmVlIGJpbmRpbmdzIGZvciB0aGUgTWljcm9jaGlwIFBvbGFyRmlyZSBQQ0ll
IGNvbnRyb2xsZXINCndoZW4gY29uZmlndXJlZCBpbiBob3N0IChSb290IENvbXBsZXgpIG1vZGUu
DQoNClNpZ25lZC1vZmYtYnk6IERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2No
aXAuY29tPg0KLS0tDQogLi4uL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwg
ICAgIHwgOTMgKysrKysrKysrKysrKysrKysrKw0KIDEgZmlsZSBjaGFuZ2VkLCA5MyBpbnNlcnRp
b25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQoNCmRpZmYgLS1naXQgYS9Eb2N1bWVu
dGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCBi
L0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9z
dC55YW1sDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMDAwMDAwLi5iNTU5NDE4
MjZiNDQNCi0tLSAvZGV2L251bGwNCisrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQpAQCAtMCwwICsxLDkzIEBADQorIyBT
UERYLUxpY2Vuc2UtSWRlbnRpZmllcjogKEdQTC0yLjAtb25seSBPUiBCU0QtMi1DbGF1c2UpDQor
JVlBTUwgMS4yDQorLS0tDQorJGlkOiBodHRwOi8vZGV2aWNldHJlZS5vcmcvc2NoZW1hcy9wY2kv
bWljcm9jaGlwLHBjaWUtaG9zdC55YW1sIw0KKyRzY2hlbWE6IGh0dHA6Ly9kZXZpY2V0cmVlLm9y
Zy9tZXRhLXNjaGVtYXMvY29yZS55YW1sIw0KKw0KK3RpdGxlOiBNaWNyb2NoaXAgUENJZSBSb290
IFBvcnQgQnJpZGdlIENvbnRyb2xsZXIgRGV2aWNlIFRyZWUgQmluZGluZ3MNCisNCittYWludGFp
bmVyczoNCisgIC0gRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+
DQorDQorYWxsT2Y6DQorICAtICRyZWY6IC9zY2hlbWFzL3BjaS9wY2ktYnVzLnlhbWwjDQorDQor
cHJvcGVydGllczoNCisgIGNvbXBhdGlibGU6DQorICAgIGNvbnN0OiBtaWNyb2NoaXAscGNpZS1o
b3N0LTEuMCAjIFBvbGFyRmlyZQ0KKw0KKyAgcmVnOg0KKyAgICBtYXhJdGVtczogMg0KKw0KKyAg
cmVnLW5hbWVzOg0KKyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBjZmcNCisgICAgICAtIGNv
bnN0OiBhcGINCisNCisgIGludGVycnVwdHM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0
ZW1zOiAyDQorICAgIGl0ZW1zOg0KKyAgICAgIC0gZGVzY3JpcHRpb246IFBDSWUgaG9zdCBjb250
cm9sbGVyDQorICAgICAgLSBkZXNjcmlwdGlvbjogYnVpbHRpbiBNU0kgY29udHJvbGxlcg0KKw0K
KyAgaW50ZXJydXB0LW5hbWVzOg0KKyAgICBtaW5JdGVtczogMQ0KKyAgICBtYXhJdGVtczogMg0K
KyAgICBpdGVtczoNCisgICAgICAtIGNvbnN0OiBwY2llDQorICAgICAgLSBjb25zdDogbXNpDQor
DQorICByYW5nZXM6DQorICAgIG1heEl0ZW1zOiAxDQorDQorICBkbWEtcmFuZ2VzOg0KKyAgICBt
YXhJdGVtczogMQ0KKw0KKyAgbXNpLWNvbnRyb2xsZXI6DQorICAgIGRlc2NyaXB0aW9uOiBJZGVu
dGlmaWVzIHRoZSBub2RlIGFzIGFuIE1TSSBjb250cm9sbGVyLg0KKw0KKyAgbXNpLXBhcmVudDoN
CisgICAgZGVzY3JpcHRpb246IE1TSSBjb250cm9sbGVyIHRoZSBkZXZpY2UgaXMgY2FwYWJsZSBv
ZiB1c2luZy4NCisNCityZXF1aXJlZDoNCisgIC0gcmVnDQorICAtIHJlZy1uYW1lcw0KKyAgLSBk
bWEtcmFuZ2VzDQorICAtICIjaW50ZXJydXB0LWNlbGxzIg0KKyAgLSBpbnRlcnJ1cHRzDQorICAt
IGludGVycnVwdC1tYXAtbWFzaw0KKyAgLSBpbnRlcnJ1cHQtbWFwDQorICAtIG1zaS1jb250cm9s
bGVyDQorDQordW5ldmFsdWF0ZWRQcm9wZXJ0aWVzOiBmYWxzZQ0KKw0KK2V4YW1wbGVzOg0KKyAg
LSB8DQorICAgIHNvYyB7DQorICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mj47DQorICAg
ICAgICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQorICAgICAgICAgICAgcGNpZTA6IHBjaWVAMjAz
MDAwMDAwMCB7DQorICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxw
Y2llLWhvc3QtMS4wIjsNCisgICAgICAgICAgICAgICAgICAgIHJlZyA9IDwweDIwIDB4MzAwMDAw
MDAgMHgwIDB4NDAwMDAwMD4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICA8MHgyMCAweDAg
MHgwIDB4MTAwMDAwPjsNCisgICAgICAgICAgICAgICAgICAgIHJlZy1uYW1lcyA9ICJjZmciLCAi
YXBiIjsNCisgICAgICAgICAgICAgICAgICAgIGRldmljZV90eXBlID0gInBjaSI7DQorICAgICAg
ICAgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwzPjsNCisgICAgICAgICAgICAgICAgICAg
ICNzaXplLWNlbGxzID0gPDI+Ow0KKyAgICAgICAgICAgICAgICAgICAgI2ludGVycnVwdC1jZWxs
cyA9IDwxPjsNCisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdHMgPSA8MzI+Ow0KKyAgICAg
ICAgICAgICAgICAgICAgaW50ZXJydXB0LW1hcC1tYXNrID0gPDB4MCAweDAgMHgwIDB4Nz47DQor
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEgJnBjaWUwIDA+LA0K
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAyICZwY2llMCAxPiwN
CisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgMyAmcGNpZTAgMj4s
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDQgJnBjaWUwIDM+
Ow0KKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmcGxpYzA+Ow0KKyAg
ICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LWNvbnRyb2xsZXI7DQorICAgICAgICAgICAgICAg
ICAgICBtc2ktcGFyZW50ID0gPCZwY2llMD47DQorICAgICAgICAgICAgICAgICAgICBtc2ktY29u
dHJvbGxlcjsNCisgICAgICAgICAgICAgICAgICAgIGJ1cy1yYW5nZSA9IDwweDAwIDB4N2Y+Ow0K
KyAgICAgICAgICAgICAgICAgICAgcmFuZ2VzID0gPDB4MDMwMDAwMDAgMHgwIDB4NDAwMDAwMDAg
MHgwIDB4NDAwMDAwMDAgMHgwIDB4MjAwMDAwMDA+Ow0KKyAgICAgICAgICAgICAgICAgICAgZG1h
LXJhbmdlcyA9IDwweDAyMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4MSAw
eDAwMDAwMDAwPjsNCisgICAgICAgICAgICB9Ow0KKyAgICB9Ow0KLS0gDQoyLjE3LjENCg0K
