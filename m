Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044C11F6D54
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jun 2020 20:20:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgFKSUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 11 Jun 2020 14:20:16 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:7742 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726326AbgFKSUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 11 Jun 2020 14:20:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591899615; x=1623435615;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=upv1uXT/vorIaGNDBDcr+GVBLwma5vxehvsVgEHjnXw=;
  b=o6kgnmRVhvCXL9obf2FlaIkzkQl0QFIhB6ergAlO4dhZmUuZ78ufibwk
   vy6T9aBQmVBK+/iETstVAYR6POf2vEznsHH6Hwq/QGWF6wkMvJjxxSk+j
   ZKLrtE7b06VLfKVP0S5/IXKTlWevMMjCdmfYf9NGDlEdvi3USHie3pjo7
   WH7XPGWVc9hJSFf6/pWD6tnl58RUtS9G/XE/OAUCp/0J6BDQ5yv4/mnmn
   qyme2pyCjgDO0tf4AlU7xNvd8ntVy4099P+E3uG+bOLuVGha9+XOYeMB7
   AzxIqTgNDecrsCF4ISZwYwKLpKnjnyB+DmVBMCc41A6x1IIylzqyOeGis
   Q==;
IronPort-SDR: pLe4Ume+jNXUpO4ub+95+0t1IgXtkyXaCihtoemVU7Ez/7koxkiE1saha7T5t6lXifSw42/bZC
 6QqNR2tLUSmEP+69MSA9TTQvFHqmDe4AXpvcLN6avj5rCEXSwOVQ2x4Ck5e/nIi8GtlzikNlX4
 ufnKgGp70abBESACidqVaTNb4SiwplXCvdW5TUsh5TU3ela/yOd5XW2FYbyZhTOVqhnlmfiZdl
 nARgnGv6D6fGLDuxnRphRGFkTaxDKbQdnpG+Yyo2Agpfbe4mc9kTOhwKuy68KpuFh3l3g3if2n
 X/M=
X-IronPort-AV: E=Sophos;i="5.73,500,1583218800"; 
   d="scan'208";a="83208092"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jun 2020 11:20:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 11 Jun 2020 11:20:14 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1847.3 via Frontend
 Transport; Thu, 11 Jun 2020 11:20:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A0GQUuecrEuvTNKjZZe8UMGzgg85ZT2RuTgaEY7+BKRmvKX/hB5+A01SF8zq0OiKoWUC2A+MUvKoRhQmXqEmBmpO6rfsupqwXMkY5a/yEGjshJH4DpKKNeCmcjXzyPpKIXXtFz9x8ZPS7OGVaW0fWBFeZEiwV2TPt9DvEZ9QRTGJ26IV/u4WDjYRJ+PO5HCnX5BsY7CyDJIJrUOlSSBaAe/z5HmrixKFmSQ2N/Cbd4+ACghUZrpH8myWRSn8jWPs/71G7VmW5xDNyND+0z0Lf+DcFmqWVgaXgCnQnY21M7nG0UPMxFRv/B7QWDOH9+auk3GhQRvUdYfRgmnxaO9dYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upv1uXT/vorIaGNDBDcr+GVBLwma5vxehvsVgEHjnXw=;
 b=Ss20TBWVFxMHLCp6D2N0cPqOCUY566X87CzNLs7llnkoY/85EC04LQguA9VORVtHssKMIN6IQsvDUR+vz46VUfL9oVropFwK+rng5irHPr1tuipvnnEpQ4Ol4tfZCQaZrZxvfqQIRYLUCidWoxqBOtDNmJaJ18qXS1A78aCZf0NwFZLVstkt5l929Qfqdm7zHIcpVylB+UnOTQePMpNLMXqVUu9JkJQztdZHksYE+mVfTkzOkIa9tdlo9Xi00mhJBmzx79q/ZLqNqafRItZpbeh54TEjcKcPU2BuOWfsp2D5xXAyguJFzCXqPzOBNz6x7VuzlojSOBRdocHk4Gan0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upv1uXT/vorIaGNDBDcr+GVBLwma5vxehvsVgEHjnXw=;
 b=D97g1AjqKth1Pu3RRFLYi9FWnw/5WqoyQXVzcqUDklRxMOUTxlVAR9Z41qu6V6c6BrGd4UX0TCeNFOst4UrZUoVxi6MLQwC2IsxlHGJKTH44Y2OST69CBrYs/Z7RqWmg8/ysuIApcHIRkMAA8kw3dUnczX+CBWsP0Cc1iDZYUug=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4630.namprd11.prod.outlook.com (2603:10b6:208:24e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3088.23; Thu, 11 Jun
 2020 18:20:11 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3088.021; Thu, 11 Jun 2020
 18:20:11 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: [PATCH v11 1/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v11 1/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWQBzx3pB6yEP3S0SmrUb5hrrsBQ==
Date:   Thu, 11 Jun 2020 18:20:11 +0000
Message-ID: <bb21af9144fe624a42ddc3ea302667fa9a46a4c8.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 403fe3f1-d17f-4e83-9a6c-08d80e34142b
x-ms-traffictypediagnostic: MN2PR11MB4630:
x-microsoft-antispam-prvs: <MN2PR11MB4630966A0A2214B7E06E5A5F96800@MN2PR11MB4630.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0431F981D8
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: X8S0xfuYCpcs1stnPrAX5jN+YwoAXyrLp8sb1G+bHHZ3wFOh2U4+JW6Uc4Tq9+4t8zffJuNrEK6BSHWQNoIpWZ9cXS8GLxco4S+GDtWRKFnTGSvVd3C4bIjFTyQIiBJJ7CR0yPw8SRvG5a0TvQfUPmcnL2ra0lF99yFGTLrRJlfzEMqMlIuM33JK78fPS+tThsV4XtZdsA0tA0+ZDxMjiVxLmr+myOQeDHmr3geQwoUbl4TZ79RPUQzcRymASq4LOMN2pU3SmLGW6GEKytJ2Mxq4cdkKIsQ/e18GOdSlRVqSI85W7huwWLow1gNM4P3OgFoqUmreLs8omIYuUrELZkF4MkCJ6fD/aIx5BlnpPFT1m3ec9zTWXMQsDjUWctgQRS2Y8+P5C10TC+Qd9uQHnA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(346002)(366004)(39860400002)(396003)(110136005)(86362001)(2616005)(6486002)(316002)(478600001)(966005)(66556008)(66476007)(2906002)(71200400001)(6512007)(64756008)(66946007)(8676002)(66446008)(91956017)(6506007)(76116006)(8936002)(26005)(5660300002)(4326008)(36756003)(186003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: ZKBNwO9wNo/APQBcEYN4RgbyQdtUu3v+nRGC5He3ehCq1XM6HhQyyxz1dFSDbkL8xU27nVV9HjsMSRbHGQmGiovlc6M81HdhdC3kac64p3sOfWIV/RxO7ecEz2lhMcb3urp2uhMkBzydqvJX05fJ+kP6oq9eYDlRiO0Kn2I0Gg945ql6EQ5R9ZOBRauRJ9Og1T5FWJ7OyT9XIHnNf16GTH/tjcdP2K9AtE9kivlr8rHQFfiBdbwuWXTbgK/VQT2+8xUiLAHSp3sBIMmyxpDZXEYjxG6NENcyCmjjGF0zN+wB1elfHpniFGS8z97RZRj0hFAh+9ODvHE44XEKXxp/BLs2ygWhvsMqRCbegztCWfHXCSzKM3lAMMSfK25PcOk0LB058nWSv/6YyTYKgRFBo3J4b7C4ZvuTEuf3D4iQxJiZhm+QQKaPDD8oDWAYtAFg0+Xrk1oxnlcSZ7HJYYo77wvmZymTX9uCW36goPcmMTIBDeKJXhAdJ9Zp6ho2Zjpf
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <45412C60452B4B4F8B2CE6779D3A0420@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 403fe3f1-d17f-4e83-9a6c-08d80e34142b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2020 18:20:11.1445
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A6hxioF8vwERKGL24fakZgTpzVjvVjzGmIHYIVoQ1gWclY+Mbvhmwn5NEoPEivsC78M3ZzkFvYbv1PZ/KcoAsMVXiLlkZCXsEMQuf+qJJO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4630
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQphZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBNaWNyb2NoaXAgUENJZSBQb2xhckZp
cmUgUENJZSBjb250cm9sbGVyDQp3aGVuIGNvbmZpZ3VyZWQgaW4gaG9zdCAoUm9vdCBDb21wbGV4
KSBtb2RlLg0KDQpTaWduZWQtb2ZmLWJ5OiBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFA
bWljcm9jaGlwLmNvbT4NCi0tLQ0KIC4uLi9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9z
dC55YW1sICAgICB8IDkzICsrKysrKysrKysrKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgOTMg
aW5zZXJ0aW9ucygrKQ0KIGNyZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KDQpkaWZmIC0tZ2l0IGEv
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0
LnlhbWwgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxw
Y2llLWhvc3QueWFtbA0KbmV3IGZpbGUgbW9kZSAxMDA2NDQNCmluZGV4IDAwMDAwMDAwMDAwMC4u
MjZiOGNmOTRhNzQ2DQotLS0gL2Rldi9udWxsDQorKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KQEAgLTAsMCArMSw5MyBA
QA0KKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xh
dXNlKQ0KKyVZQU1MIDEuMg0KKy0tLQ0KKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVt
YXMvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCMNCiskc2NoZW1hOiBodHRwOi8vZGV2aWNl
dHJlZS5vcmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCisNCit0aXRsZTogTWljcm9jaGlwIFBD
SWUgUm9vdCBQb3J0IEJyaWRnZSBDb250cm9sbGVyIERldmljZSBUcmVlIEJpbmRpbmdzDQorDQor
bWFpbnRhaW5lcnM6DQorICAtIERhaXJlIE1jTmFtYXJhIDxkYWlyZS5tY25hbWFyYUBtaWNyb2No
aXAuY29tPg0KKw0KK2FsbE9mOg0KKyAgLSAkcmVmOiAvc2NoZW1hcy9wY2kvcGNpLWJ1cy55YW1s
Iw0KKw0KK3Byb3BlcnRpZXM6DQorICBjb21wYXRpYmxlOg0KKyAgICBjb25zdDogbWljcm9jaGlw
LHBjaWUtaG9zdC0xLjAgIyBQb2xhckZpcmUNCisNCisgIHJlZzoNCisgICAgbWF4SXRlbXM6IDIN
CisNCisgIHJlZy1uYW1lczoNCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogY2ZnDQorICAg
ICAgLSBjb25zdDogYXBiDQorDQorICBpbnRlcnJ1cHRzOg0KKyAgICBtaW5JdGVtczogMQ0KKyAg
ICBtYXhJdGVtczogMg0KKyAgICBpdGVtczoNCisgICAgICAtIGRlc2NyaXB0aW9uOiBQQ0llIGhv
c3QgY29udHJvbGxlcg0KKyAgICAgIC0gZGVzY3JpcHRpb246IGJ1aWx0aW4gTVNJIGNvbnRyb2xs
ZXINCisNCisgIGludGVycnVwdC1uYW1lczoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRl
bXM6IDINCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogcGNpZQ0KKyAgICAgIC0gY29uc3Q6
IG1zaQ0KKw0KKyAgcmFuZ2VzOg0KKyAgICBtYXhJdGVtczogMQ0KKw0KKyAgZG1hLXJhbmdlczoN
CisgICAgbWF4SXRlbXM6IDENCisNCisgIG1zaS1jb250cm9sbGVyOg0KKyAgICBkZXNjcmlwdGlv
bjogSWRlbnRpZmllcyB0aGUgbm9kZSBhcyBhbiBNU0kgY29udHJvbGxlci4NCisNCisgIG1zaS1w
YXJlbnQ6DQorICAgIGRlc2NyaXB0aW9uOiBNU0kgY29udHJvbGxlciB0aGUgZGV2aWNlIGlzIGNh
cGFibGUgb2YgdXNpbmcuDQorDQorcmVxdWlyZWQ6DQorICAtIHJlZw0KKyAgLSByZWctbmFtZXMN
CisgIC0gZG1hLXJhbmdlcw0KKyAgLSAiI2ludGVycnVwdC1jZWxscyINCisgIC0gaW50ZXJydXB0
cw0KKyAgLSBpbnRlcnJ1cHQtbWFwLW1hc2sNCisgIC0gaW50ZXJydXB0LW1hcA0KKyAgLSBtc2kt
Y29udHJvbGxlcg0KKw0KK3VuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCisNCitleGFtcGxl
czoNCisgIC0gfA0KKyAgICBzb2Mgew0KKyAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDI+
Ow0KKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KKyAgICAgICAgICAgIHBjaWUwOiBw
Y2llQDIwMzAwMDAwMDAgew0KKyAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNy
b2NoaXAscGNpZS1ob3N0LTEuMCI7DQorICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHgyMCAw
eDMwMDAwMDAwIDB4MCAweDQwMDAwMDA+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4
MjAgMHgwIDB4MCAweDEwMDAwMD47DQorICAgICAgICAgICAgICAgICAgICByZWctbmFtZXMgPSAi
Y2ZnIiwgImFwYiI7DQorICAgICAgICAgICAgICAgICAgICBkZXZpY2VfdHlwZSA9ICJwY2kiOw0K
KyAgICAgICAgICAgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQorICAgICAgICAgICAg
ICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCisgICAgICAgICAgICAgICAgICAgICNpbnRlcnJ1
cHQtY2VsbHMgPSA8MT47DQorICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDMyPjsN
CisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAtbWFzayA9IDwweDAgMHgwIDB4MCAw
eDc+Ow0KKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0LW1hcCA9IDwwIDAgMCAxICZwY2ll
MCAwPiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgMiAmcGNp
ZTAgMT4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDMgJnBj
aWUwIDI+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCA0ICZw
Y2llMCAzPjsNCisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1wYXJlbnQgPSA8JnBsaWMw
PjsNCisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1jb250cm9sbGVyOw0KKyAgICAgICAg
ICAgICAgICAgICAgbXNpLXBhcmVudCA9IDwmcGNpZTA+Ow0KKyAgICAgICAgICAgICAgICAgICAg
bXNpLWNvbnRyb2xsZXI7DQorICAgICAgICAgICAgICAgICAgICBidXMtcmFuZ2UgPSA8MHgwMCAw
eDdmPjsNCisgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDAzMDAwMDAwIDB4MCAweDQw
MDAwMDAwIDB4MCAweDQwMDAwMDAwIDB4MCAweDIwMDAwMDAwPjsNCisgICAgICAgICAgICAgICAg
ICAgIGRtYS1yYW5nZXMgPSA8MHgwMjAwMDAwMCAweDAgMHgwMDAwMDAwMCAweDAgMHgwMDAwMDAw
MCAweDEgMHgwMDAwMDAwMD47DQorICAgICAgICAgICAgfTsNCisgICAgfTsNCi0tIA0KMi4xNy4x
DQoNCg==
