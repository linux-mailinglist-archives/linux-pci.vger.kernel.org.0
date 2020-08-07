Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80CC23EE24
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 15:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgHGNXo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 09:23:44 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:52835 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgHGNXn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Aug 2020 09:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596806622; x=1628342622;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TSSb5yXtzpkxuSq6IOENrpbY4vk0FbvrBudR5TknFz8=;
  b=OInpbfSFDYZckWaJ7sreg5txRZXQYyXa5k8yixO3pI07tLYCdklU9rZz
   yLadfhal2ZsHMCr9XdOuy4Y7Kxm8wjh1t1379OH9X3/HbETmnlShT1fKX
   Ab9p77hIG3uHhY0Z/EvrCDpjZUg3O1jInnS4dj6Zbi3pBt9h3cQViTjDl
   3stpJPghfMS9QCuO5xYnq+xA0ZxjZU3iFMjbovv9C4LZpxCZUgO+ROoIk
   6gBUCTYdXo38MTf2SI5FjFpi1CAaCBo8fMIZvxHF4QqXuiHKC3vOhE9vA
   7nk3iItnS0sQu2fresKShIauPNTbDSlhbUiY6gRN2AiSXG4cMLT1Wqt8i
   g==;
IronPort-SDR: Z1Me62bVsk34lAkMm8QxHav7d8PzeVRdueXRNqWKcDKWYjjRcRze0dHVYG3XpNQURJu9FNT2hD
 /3BE21l5lg+qll1vRaH14dWM3kvaWoi2ywNOey+MEnGcvq/mrhyUsSpixGYxUodZXAK7EJ9+oB
 WIUlz4NPjai9FsRdfshGN4OSfStGxTjNKkflxvHRMcNTmR3AqegAXcTYQ6YhxOhRoUS/AE7Uv8
 JwpEYdo6C0lax/JmtQm6IeB1owD7oaCWPbHMmR+XdF0AncG+Om17763tkXavYBOyB4yNrw4Fik
 AJc=
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="scan'208";a="22148318"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2020 06:23:29 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 7 Aug 2020 06:23:26 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3
 via Frontend Transport; Fri, 7 Aug 2020 06:23:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A959pgblJugD68ENSz6vPAsaS0EZt1BFlEsLL31NRznAzd0AMI9LNCqbn6uKGDftXfuvGOOJyyAsjcQsMKLe/zrnx5oVN5R1EU7cPbLlhsdOrbObyEEUskB/o3IzmQTz5nuBa4cTw66IJtxu3c7iJccg6vYGlH2vtprVzb2lWoB8NLF07ujB4/8fDeJz+iihJkA4kLjAuAu7M4VR3isKGCg+di3bCgF2pzKTe03UYE5X8SFpCS9H7U1zAwzfrCasGOn3snu/xY77F09tDPoDPm8TQCeh5OLnqu9nNDZyLgk//xPsV0Au5PdV/OsETvGB3LvVwvFHv7rgsOyZtXx/yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSSb5yXtzpkxuSq6IOENrpbY4vk0FbvrBudR5TknFz8=;
 b=L0wwyX59EpbNfAvORh1hPOY8XmR+5IBM++4yewTBajTCh7NIBvf4lNPzgPCF97qjlXw/tXXjiUWXmqeG2m/ptxCZo7STQrmPf15F+WQYN35WRF+KFlrN1dqbjodpAgti37Z3UtNsYQk7nu8EpIMuRRdKmuXFr8Llu6wRB3qYeaAfRUY0UgNVu15oQpPrE+6puuuMJGlWpUphktOs/hmhWnPrT3oSzCTUj6k/5qK7+HS5wEFtEFKB290TAcbjaXuX315cFBBEQ4RHsD68pobWwh8NOm3AKDMA+cP3kJ4L2eP82N6P2cXLUe0K5mxowCCeZcvNAqmvJEsrTg0HGRLb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSSb5yXtzpkxuSq6IOENrpbY4vk0FbvrBudR5TknFz8=;
 b=Fo2ukRwTZFHEmDCgvSw6XpaVZ5jD/LlID2WON5huqyzo7Swm1SozYxzLkgBRIc4xcFx7i98hKe+DHj29IhXVUUCwTkG8IlcDSQcdm3/E4zgHgV4m/un12x5AzYJEYBkWHYikl5JPBwtzL/3tyz8Y2NvmHVvCshBUpLTcuTLwRsk=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4301.namprd11.prod.outlook.com (2603:10b6:208:188::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Fri, 7 Aug
 2020 13:23:26 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12%7]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 13:23:26 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <david.abdurachmanov@gmail.com>, <Daire.McNamara@microchip.com>
Subject: Re: [PATCH v14 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Thread-Topic: [PATCH v14 1/2] dt-bindings: PCI: microchip: Add Microchip
 PolarFire host binding
Thread-Index: AQHWbL3ubdrlM7OGqEi1gIrT7uD4vQ==
Date:   Fri, 7 Aug 2020 13:23:26 +0000
Message-ID: <4bcbacfb4b117dfde38a57541dd37b02b887a318.camel@microchip.com>
References: <eb2abaa7fc97a6e700a7c4ed37182820803414c3.camel@microchip.com>
In-Reply-To: <eb2abaa7fc97a6e700a7c4ed37182820803414c3.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [87.42.139.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b670f24-37c7-4f05-4c5c-08d83ad5114f
x-ms-traffictypediagnostic: MN2PR11MB4301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4301F738D3D71F2E99F294DC96490@MN2PR11MB4301.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GgOBrNG63KCPl1jFUIuoNhEORIIFQY2afn0XFMlbtkFz6II+F/W1YL5Lc0U3VyaK+h/+OiHZqaztszlbgustY0uOMYNMnl8jBuna/HSrESZbsFIi3VBI+H2kpyx4CQtuNcYqZwsDazR5zFXelDbbKVUvz0ZoGKOEeIeu4z1fm6QnYoq4KiuUAceLM2McwYUQVTiwhqpOSqE3HF56fsXmuF0/zVXWtBM114fhjbpzunc/eKDvFXbeNwhbMe6e2mLPjJLsdcpSbgGgMdyD3yabieAXD1cQMgAhwMdxxdvMjSpv7osjYyfATJrOV7If8lU+ZW2K7RJkdwKwHsJ3/Qr9Nr+sXIxmhbdookjou2mn4upv45z11H1XLowtJId7XHs6KCd1DVOFf5xa/eXtzPRpWA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(136003)(346002)(366004)(39860400002)(396003)(36756003)(316002)(5660300002)(110136005)(2616005)(2906002)(6486002)(6512007)(966005)(107886003)(91956017)(76116006)(478600001)(8936002)(8676002)(66946007)(64756008)(66556008)(71200400001)(66446008)(4326008)(186003)(54906003)(86362001)(26005)(66476007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qxQMZcz8OLhviWTwGUR7q+7wh56E7rikYE72sigCFN+bZNhyg07At3l5MpDBPNsIBXfUeP96go7DQNJndapv+KXsx5ve6J9Mqi6eMFlNbKeU90HHLhiZGm84rELtZ9dhdlBcbzddEq80u6jpf9OJ6H+Yrem9NkwDw/0UGjPlDeGhOC9TpKNA9HGrlOMSTXk0XgmpZOeIsRmsiyYB85k3yu97cRQ0Are+ORaPLx7LZkapZyj3U2VX6nioa9qrns5CsxWrZAQQmRZ8W+r2uXVPTPMG7kmtSuImIZyR3n6rC4P1kIJYGUkgG9vDGlVURnvPO6zyqJHAfOB/vOGF2i7/YID9jgWplidyW0G19nibfMEMGN+DD7T9z1w44IEU/Z2NAZRg0WIpeY+XhlsFoDclTj1Vu2N+Sr/soSbFLamkGHjenTwzUvAufpMvyRZcKiOErrAD7mOWKgd4WHZmw1ZHNkIGuPaqkmXqy17KlqMGga3s/Kj+2BmrtlEoezqe9rtDKeGyQ/ubxIJVZGpUpmlYJ4kV5aCVIJcEO8M/qNVkJxrIh1zNZD1NCNJv9Kw7CwB06r5ID/6VVAWZ9JVhECdgESq3qGVXiWxDLUrgIDjZJV2dCKUTt9O02OJp4pBIcbJH/2TG5q//Zz3ApXEAqnGRuA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <336D17077798B84DB1BBABAD00E4FCFF@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b670f24-37c7-4f05-4c5c-08d83ad5114f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 13:23:26.4570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /fMgifQHpY7STe+T8yWcXZVfa2hV1E94uviXYtNZ6+BEYMli1yifJqlbAz/xMzgCmvoAmW1wF3/miAym/I9jBg6ctPjTO3DRBjjDoaxqTGc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4301
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpBZGQgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBNaWNyb2NoaXAgUG9sYXJGaXJlIFBD
SWUgY29udHJvbGxlcg0Kd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxleCkgbW9k
ZS4NCg0KU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRhaXJlLm1jbmFtYXJhQG1pY3Jv
Y2hpcC5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFt
bCAgICAgfCA5MyArKysrKysrKysrKysrKysrKysrDQogMSBmaWxlIGNoYW5nZWQsIDkzIGluc2Vy
dGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCg0KZGlmZiAtLWdpdCBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1s
IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1o
b3N0LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAwMDAwMDAwMDAwMDAuLmI1NTk0
MTgyNmI0NA0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2Jp
bmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCkBAIC0wLDAgKzEsOTMgQEANCisj
IFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiAoR1BMLTIuMC1vbmx5IE9SIEJTRC0yLUNsYXVzZSkN
CislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Bj
aS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1pY3JvY2hpcCBQQ0llIFJv
b3QgUG9ydCBCcmlkZ2UgQ29udHJvbGxlciBEZXZpY2UgVHJlZSBCaW5kaW5ncw0KKw0KK21haW50
YWluZXJzOg0KKyAgLSBEYWlyZSBNY05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNv
bT4NCisNCithbGxPZjoNCisgIC0gJHJlZjogL3NjaGVtYXMvcGNpL3BjaS1idXMueWFtbCMNCisN
Citwcm9wZXJ0aWVzOg0KKyAgY29tcGF0aWJsZToNCisgICAgY29uc3Q6IG1pY3JvY2hpcCxwY2ll
LWhvc3QtMS4wICMgUG9sYXJGaXJlDQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAyDQorDQor
ICByZWctbmFtZXM6DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGNmZw0KKyAgICAgIC0g
Y29uc3Q6IGFwYg0KKw0KKyAgaW50ZXJydXB0czoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4
SXRlbXM6IDINCisgICAgaXRlbXM6DQorICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBob3N0IGNv
bnRyb2xsZXINCisgICAgICAtIGRlc2NyaXB0aW9uOiBidWlsdGluIE1TSSBjb250cm9sbGVyDQor
DQorICBpbnRlcnJ1cHQtbmFtZXM6DQorICAgIG1pbkl0ZW1zOiAxDQorICAgIG1heEl0ZW1zOiAy
DQorICAgIGl0ZW1zOg0KKyAgICAgIC0gY29uc3Q6IHBjaWUNCisgICAgICAtIGNvbnN0OiBtc2kN
CisNCisgIHJhbmdlczoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGRtYS1yYW5nZXM6DQorICAg
IG1heEl0ZW1zOiAxDQorDQorICBtc2ktY29udHJvbGxlcjoNCisgICAgZGVzY3JpcHRpb246IElk
ZW50aWZpZXMgdGhlIG5vZGUgYXMgYW4gTVNJIGNvbnRyb2xsZXIuDQorDQorICBtc2ktcGFyZW50
Og0KKyAgICBkZXNjcmlwdGlvbjogTVNJIGNvbnRyb2xsZXIgdGhlIGRldmljZSBpcyBjYXBhYmxl
IG9mIHVzaW5nLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSByZWcNCisgIC0gcmVnLW5hbWVzDQorICAt
IGRtYS1yYW5nZXMNCisgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQorICAtIGludGVycnVwdHMNCisg
IC0gaW50ZXJydXB0LW1hcC1tYXNrDQorICAtIGludGVycnVwdC1tYXANCisgIC0gbXNpLWNvbnRy
b2xsZXINCisNCit1bmV2YWx1YXRlZFByb3BlcnRpZXM6IGZhbHNlDQorDQorZXhhbXBsZXM6DQor
ICAtIHwNCisgICAgc29jIHsNCisgICAgICAgICAgICAjYWRkcmVzcy1jZWxscyA9IDwyPjsNCisg
ICAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwyPjsNCisgICAgICAgICAgICBwY2llMDogcGNpZUAy
MDMwMDAwMDAwIHsNCisgICAgICAgICAgICAgICAgICAgIGNvbXBhdGlibGUgPSAibWljcm9jaGlw
LHBjaWUtaG9zdC0xLjAiOw0KKyAgICAgICAgICAgICAgICAgICAgcmVnID0gPDB4MjAgMHgzMDAw
MDAwMCAweDAgMHg0MDAwMDAwPiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgIDwweDIwIDB4
MCAweDAgMHgxMDAwMDA+Ow0KKyAgICAgICAgICAgICAgICAgICAgcmVnLW5hbWVzID0gImNmZyIs
ICJhcGIiOw0KKyAgICAgICAgICAgICAgICAgICAgZGV2aWNlX3R5cGUgPSAicGNpIjsNCisgICAg
ICAgICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KKyAgICAgICAgICAgICAgICAg
ICAgI3NpemUtY2VsbHMgPSA8Mj47DQorICAgICAgICAgICAgICAgICAgICAjaW50ZXJydXB0LWNl
bGxzID0gPDE+Ow0KKyAgICAgICAgICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwzMj47DQorICAg
ICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwLW1hc2sgPSA8MHgwIDB4MCAweDAgMHg3PjsN
CisgICAgICAgICAgICAgICAgICAgIGludGVycnVwdC1tYXAgPSA8MCAwIDAgMSAmcGNpZTAgMD4s
DQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDIgJnBjaWUwIDE+
LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAzICZwY2llMCAy
PiwNCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgNCAmcGNpZTAg
Mz47DQorICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtcGFyZW50ID0gPCZwbGljMD47DQor
ICAgICAgICAgICAgICAgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjsNCisgICAgICAgICAgICAg
ICAgICAgIG1zaS1wYXJlbnQgPSA8JnBjaWUwPjsNCisgICAgICAgICAgICAgICAgICAgIG1zaS1j
b250cm9sbGVyOw0KKyAgICAgICAgICAgICAgICAgICAgYnVzLXJhbmdlID0gPDB4MDAgMHg3Zj47
DQorICAgICAgICAgICAgICAgICAgICByYW5nZXMgPSA8MHgwMzAwMDAwMCAweDAgMHg0MDAwMDAw
MCAweDAgMHg0MDAwMDAwMCAweDAgMHgyMDAwMDAwMD47DQorICAgICAgICAgICAgICAgICAgICBk
bWEtcmFuZ2VzID0gPDB4MDIwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHgwIDB4MDAwMDAwMDAgMHgx
IDB4MDAwMDAwMDA+Ow0KKyAgICAgICAgICAgIH07DQorICAgIH07DQotLSANCjIuMTcuMQ0KDQo=
