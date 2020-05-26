Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438ED1E2493
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 16:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727990AbgEZOy2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 10:54:28 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:53945 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726916AbgEZOy1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 10:54:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1590504867; x=1622040867;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=upv1uXT/vorIaGNDBDcr+GVBLwma5vxehvsVgEHjnXw=;
  b=LojTzbpiZR4seEHe4aqDhlp4FzwM4sc4TNrIpynbgWFvbpXYultzRloP
   WwxFNqPak/PTsFfDomNzhTe6D0gRRMYm32owGKvGx1041tUjllGxshdr0
   K2TYsBsF+/Bt3jJgkFC/RYtE9Hl0xZ7F8k2vDaPj+Z5ektYqC8AdiIurY
   c+B0DeCLqf3osjQVKL6qR+Kfutdyt53TPdtd2dOsPK3esVNewkX7EUy4o
   aTz3n4/sh+WlH/S2cIpW7hc8rnaUUMUpYmlMXjgBUIktnGIn5CtoAE0gX
   UXWjsyVkTFWNf1YMSwxBv5+q8KnADq4XRu+/1GdTAju6MLeX1Zeh4HezA
   w==;
IronPort-SDR: 6Pua7W7yf70SbUiX8BrzNeXV4GGCtNkPq+M6Ja7piXfkQ202zdFBJm72nSQKxv0hNHVZhLeOFu
 clXGzDk3iI227sy6i0Wxf2Gn51ZnY1ZdLufculTqXkpm9bON5Hwz6t+S95taQiZJ45lpkCykZN
 Dpjg34l2zjHE93hbfZull4QnI77uITyypjoo3MnVysPIB/VY0pCGa5CIF06hmYAFRp6cZ9NlsJ
 Oqn9AVbYr63VYjb1CB2VwdHnzpdhqy2q6m1vBsnIKwK04H+zc7yBBYNN5/qD3qMK/MjnLegfVe
 H3E=
X-IronPort-AV: E=Sophos;i="5.73,437,1583218800"; 
   d="scan'208";a="77852316"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 May 2020 07:54:26 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 26 May 2020 07:54:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 26 May 2020 07:54:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XWf4BW3aqeZn1rDR52Kg6PTFnuso95HhiDmWGPZ4zUbMDqUFSPo6Y4BWegvfQtSVS5mJ9FuCM6sawNEChA8pb8nQrw07y2ChSqUa0jK2ovWIWcwnVT4LUGEh8T5ySFVkWUjjYgqteqbbztksH0vEnqSVuoSmO5GuvnG0kKPe3EiqdqU8g/rH32Hk/jLOFZFqp459NRXq4/3jzhdztNJIJ6Rf2d/sS6ekw3hvnTj/GQnt6/J7e1Ct23Au38PJtily97ApMvFz9k4rdR7R6pStEyopqOwcZKpZqXfQyN1nDfQFUmLqAmGqBh/yXlvlsqAhy8KkKI5YKuIO7j06pwoGZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upv1uXT/vorIaGNDBDcr+GVBLwma5vxehvsVgEHjnXw=;
 b=ZVDtSEReLNcTzwNRxixINWMSorPsK9mYl99mTuL2YV6hbD4s7rA0iPyhIyg59ygaI31DetePkU+4n/sOTvuQTUD9lU6Z6vJkw4ONn/CY3gWEZahU5Ra6FM/eJzWirE4INpbYzzimh5jWcjzju6yBJCAZEnZqHiGJNi+63P7GeuHJExVrOFxxqi5izjFeVPkwFyfph9IxkGmofDONFfOr0MS47ZrZhk0g05qcypq3nCDKrvG0g7kvg9HqXNfdR4R7yy6EZekrM3k6GORaHLcsY6zMWYAhqXM1uozpdkOjC/5pf/lZwqk/kbjT/E/I+SOT7oh4ktuhov0w1SlIYaqwdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upv1uXT/vorIaGNDBDcr+GVBLwma5vxehvsVgEHjnXw=;
 b=eTLklXycffcZ8f8PTsf2rE2HXKzKmhYzUuknMG7U/lnghILGm233CN3r/FduIrFgKVy6FDxX9Szm+lGdzRXCI+4twkt8MR1jAxokGQ3xZCngOVXA1P++pStGQofIk6iU5es1MLBO14DVEAYorLqTZ3QyT7Kh2QhZNlW0O/7EQzA=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB3856.namprd11.prod.outlook.com (2603:10b6:208:ef::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.23; Tue, 26 May
 2020 14:54:25 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3021.029; Tue, 26 May 2020
 14:54:25 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>
Subject: Re: [PATCH v10 1/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Topic: [PATCH v10 1/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWM22M5LnhM1J+m0KtcvgrN59Gzw==
Date:   Tue, 26 May 2020 14:54:25 +0000
Message-ID: <222156ca78b3fe86d51c9f59491d8a2fad22a112.camel@microchip.com>
References: <930a4f34fd11be89bc66cfa35b249c9b685aa8c2.camel@microchip.com>
In-Reply-To: <930a4f34fd11be89bc66cfa35b249c9b685aa8c2.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4f52b2c7-28d8-4369-57b1-08d80184aed6
x-ms-traffictypediagnostic: MN2PR11MB3856:
x-microsoft-antispam-prvs: <MN2PR11MB3856117EEDDF95B4A1091AF996B00@MN2PR11MB3856.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 041517DFAB
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 20Ch8k9dlpttJj3QW0J+cM9/E7khfVmc4TyR2l29k0+EMAEjXgUQfByRsSUk8vevViTSIvaxkjJ9jfEKuM9NSimwUfMG2cZV6c3KhNZuG1mvbOdcO1sIBttGifvq5xWiRIN6SZ5lMvba+USnE5XY0uIfSPjFYP7pkWDHICbw3HbDCzeF+6osyI81h1wfGFTjU5kG0mqg18HpJyTWddd9kKHDfbrRlVwL3E7mnypHpLs3rVixgWP7QgeaSooTMxtiVWVShSCjTmOINqHzm2no4PMQeyV1VQPMsHx/XwAqDwlWZTBohMgzD8PQCXLVo4vLXqXJDSsBGhD7S5t9K5qZGSqdKNI8nsQUT0XoMMbk0Z6SObbk3XD9/xFiflLETVNpBitU7bLebgOSGNwN6pPpPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(396003)(39850400004)(346002)(366004)(376002)(136003)(86362001)(966005)(8676002)(6486002)(4326008)(478600001)(36756003)(6506007)(8936002)(316002)(2906002)(6512007)(110136005)(71200400001)(26005)(186003)(2616005)(76116006)(91956017)(5660300002)(66946007)(66476007)(66446008)(64756008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: nrZhUq+DrlOa7jRiii8D9CC98OCX7C24+35aCITmleXaO9DC99tVOhTMtTKc2RjRyKZAN2FlgFKkaEiBsErReHW20xNqAY/EhO0fRC/2DZc1/ww+AzX5gFkanJteKlK/NbPnj2e/peQFjdKJh76zKUpcfQvH+avMTnDN05KXSoGZFyGngh6PeLeeQcA8eMuuSvzVQ2Vrsv6eFb5gIE3FToFVvCFPJAPkmlor8Fda/KEhBO9Ysto96CeM/As5t7RMmAc2iWNUEIMNVkkaLLKK02wFgAjeLqyz5OcnLea3LHRaVeU16hIy4U1QTIVyPjm2yX0iy7YSmvoStrIeJ/36piOD930xizC/6QKJUHk/0ESJrdu/RVrG1EXl7ZjDjq44EzJxgGQzcP6mdwrRUknwsXB6TjgPTaqm0QkWJv3MBvx7wi52QZN4EI/GXK97BXDzLKpB7ZjFokoap5Mcyq+ZhaTn7AIStbdB2qSqsKKMSZkb8iZ5hJupa6brjJHayyhA
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <C2C0E3CA14BC98408321D4F69A512FF7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f52b2c7-28d8-4369-57b1-08d80184aed6
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2020 14:54:25.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yJiVdoXsd9HneKZXpHWAvF1Z1DS2HlP8dLdg46mQq+Armtlxn8E4eBBGa06UT98q1hMumltK1MtUezggdjJExiWqG5wZiH6gmTjZ9fF6tQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3856
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
