Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1C11DB214
	for <lists+linux-pci@lfdr.de>; Wed, 20 May 2020 13:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727004AbgETLok (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 May 2020 07:44:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:38085 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727018AbgETLoi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 May 2020 07:44:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1589975078; x=1621511078;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Y3ABrxhtuulp4g4RoacArUpNNnnxFiJmX2cbe69kwxE=;
  b=W1YYg7QNKPzWmm9ru8pIupKHME7bYnK/ep1ncfq+d6Q1xoPGmgPglxrW
   Sab/RJwlpfZOa5EBwj3RZPJk1P4QtORLE6bwtFXBKEXntpVvPGE5AzAVY
   8siA/e14+SpSs++YR/rHjJt8xUsf+XHWbZBfNHNqITMw26Z8h5X07Rdmm
   7LAFApEwUFuQDMGak4hbvqu39r/a6oL7mTKREX0WTzi1V/T6mh6RxMg9B
   epit8Y8qT6McT+J0rO3dveJv+/8iVVeM1zVt3lSYql2IIGDMESZYjNx7p
   +YoZudH7/Egvi16yfgBFtTae6ZdkkPQZ8fPAcLYv/V9OLj+HLsEQqE9Az
   Q==;
IronPort-SDR: pFiVVJyw/wpXtIF4zH3nRd4uWn3svpWboVy0uLcQLVKucbtERjCFOjzEwrS623tPrXEAlfxQ5k
 4CcpW7zKyRlfh7ages8AMYU5TZBe2+HF9OD2zVV+83rHjbgdh08FmK2YCxaZIHe3xxNPxnCe/U
 snfQncFBui5sHS0ANMsrgTqdc6R8uqsqSjJHgSgG2UuPgNVC4qSy3tnoPLjxOcvBHzYQ5XnxSV
 +Q/r39MT3guQ6sFYDo7SjF+Sb7SpltTz7U3OKJv/pNAGj37hjSKMONL15oyrUBlKCCM4xgIwC7
 COk=
X-IronPort-AV: E=Sophos;i="5.73,413,1583218800"; 
   d="scan'208";a="80362162"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 May 2020 04:44:38 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 20 May 2020 04:44:37 -0700
Received: from NAM04-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 20 May 2020 04:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YQWTw+rI0j8vhHNbzv0Q5DDWRtfGYWYSU1Bz1LAiYXa799BVyN2rRbgOE7Osak9zpotIn/4w8paw7tAr+8tKm3wwi7nJdjS16QeXRIgGhVrB/EsAvgg26jJ8En9fSjfup4g+Fwh7wwDBxoBQStWBHEWzlXhrlFuGSeP/BtGhuPOiQdpnEei0aI3Ul1gKGg0G2U0Zzr9zsxq7xQN5yJkVNaESB5AL68sFWLMb+T6B551Sy7XqKHxR+Tt9R5xNAuTEMFIJrg018BM86Xuph84ji9299aizhHLaYfwovxxPMQb9QtCsJi25Xl0ZPDD13wL/e+sc5OT/9ZljsiFzShTNFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3ABrxhtuulp4g4RoacArUpNNnnxFiJmX2cbe69kwxE=;
 b=G3Ju9aOEFKhO9BVQ0fJwwK1KrgG4VdtzNfg6l5oUVccyPpMEjeorLsQhiJVV0W17hPCXMVP1lgrhBwtcVgRJMf4EN9NBSSrvSv5SG1uTA6Bz7MQAI+0+nua5FdRJaSX98OsoJNWZEgjsHX4CMD327gDn03SKlztu0/rwDD8WTT3o0ad9PMUaT/LQBpY7m9n3+e+voZVW1EeL2VFtmhHtlUQE+C5zQBlRn4ORYgkX250SM9xPZX0q734oJOd0oj5/HRljVspBRJZ9VmDjKP5o7dRFdCUVkRy6+tKC3Q+q2wvi06+qx28uQ9sJ578KLERCI9IA0QUybVc2DKhY/382Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y3ABrxhtuulp4g4RoacArUpNNnnxFiJmX2cbe69kwxE=;
 b=MsG4rdFu6lZOd0D/I2Ip37wYv5t8i8dRFOSc9n7SrdkXxt3JZb2BMf4fQnygyibtcWiUD7p6vZWkdZ8JkyKZP63M3i/0pTKfkgyR/TyQzry/MXokYvGUj4/HoQFryHB+W/YmjzTAbQqcMHUYFVLBH7OlKunegcZA+QQ83BdKcXY=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB3872.namprd11.prod.outlook.com (2603:10b6:208:13f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3000.27; Wed, 20 May
 2020 11:44:36 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::8d6f:606b:5ddc:d5cb%2]) with mapi id 15.20.3021.024; Wed, 20 May 2020
 11:44:36 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh-dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v9 1/2] PCI: Microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v9 1/2] PCI: Microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWLpwJ9kFP6Hrw2k6pRUSXUoHryw==
Date:   Wed, 20 May 2020 11:44:36 +0000
Message-ID: <5dc3002680da40400b083748329d8b736219952e.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e95bfd6e-260c-4dac-1647-08d7fcb32c08
x-ms-traffictypediagnostic: MN2PR11MB3872:
x-microsoft-antispam-prvs: <MN2PR11MB3872B76BD1D68CA3840DFCC196B60@MN2PR11MB3872.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 04097B7F7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Lg4HbZbrlBB5Lh61yOrZj95yWnzNSpFin6n7U2fsopj7L1kRQuHtLPbvpzerf3qHyHep8iiDCCeWoC1eYGLeD8z642TpjnIR+8BuwuXToN5XC1svHvdMalrq0zb97kNXtH6YYqo78Vt6HVAOPrVsRmkHsq8oc9SgYL+fkaCYgxGsSUVV93B9y0FZCDw0WC35EEeDu3TQJKgltUF8Y44QDD/bj88g2/HAUcAkZ8dviPpPkKCupk2GJNRG/zxSeaTVOj6ExIlPZtJYkgQXC09wAmQPcwZVm1h8EC8DJvGCoujRz/cDBXQQ5EkqZucOURb2F3TT6BYlC0EligL5l+5fiyXQy2kBeWSK8jjKKJ2OCHaGUDTXC73laNhWrulPl/aQyLg7lsJL9S2KVgkGLWhX2fZhDLRp7Ub6Z6lVjX+pD0GnW7kdE+tQijCz32rBMhAv0mFDecykWrWVqJgwbEgFyQHZHIQxPa6SYk+RnDSfYA/cJ7sDMAXNTbg95fCdCCKQgLIzuwyn/RjKC4Yjx9DS6w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(376002)(396003)(39860400002)(346002)(366004)(110136005)(66476007)(316002)(66946007)(66446008)(64756008)(66556008)(76116006)(91956017)(2906002)(5660300002)(26005)(71200400001)(6506007)(186003)(2616005)(6486002)(8676002)(966005)(8936002)(36756003)(86362001)(6512007)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: Kpbs5yU0dHclxOmAhUFYuGV8w1JpecXKhKjpMWIKwNa47VzbBA+GySCIV54PZH7Zi1ShRA2tc8dGLoR8ecced2kCFBpkpC3EpxX6jjh2WQBORMHMSL4pN+MtE4UYcYTxqjTRkSAeA/S0YDR2QX8T794CzUNTaqn9zjgX5H9j4zc1Wzpz96l1WU4jDiXLVYWCCvfXotAmv9U2LjKPC4wyfA7oTFxwflBmdLIwoLbP6XXMUBlWc34cjGt0DSYjXz8BRf+Wta6RRxXysulRDSifibKDBeVmIBsZ6NUn2u9ZOZcTQDcuVUyvwr4wk7Pv8ZkwoRqiW/05GTHjnCGHOF72Gvp+2bSlM6m171tQbYBrrOEka+dQ3gwjmFR6mGonhk+k5ChnZMufoTlfI/D04/g5qvnavtBZysgskjZf2osGnKtkoWOWK7hUIw2vMSQ3pDXvOPVzibcB4sLapRep+iXWyBjqWdDWLcu7X0enlz7JBtCDYfJsA0vvdOgkuEGD8blN
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <227766FBC80D0A4FABC282A6D2B086F1@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e95bfd6e-260c-4dac-1647-08d7fcb32c08
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2020 11:44:36.2998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j3+CywG7W01pR5gw4xj2pwkjk3pW+7ofNcfdAzrCNvRl2gY6QXKty1fpLjTXaDXjRA7Vb7aRJu6SexcWN/4jLXdMhZilC7xR9qAd6HDL+Us=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3872
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpUaGlzIHBhdGNoIGFkZHMgZGV2aWNlIHRyZWUgYmluZGluZ3MgZm9yIHRoZSBNaWNyb2NoaXAN
ClBDSWUgUG9sYXJGaXJlIFBDSWUgY29udHJvbGxlciB3aGVuIGNvbmZpZ3VyZWQgaW4NCmhvc3Qg
KFJvb3QgQ29tcGxleCkgbW9kZS4NCg0KU2lnbmVkLW9mZi1ieTogRGFpcmUgTWNOYW1hcmEgPGRh
aXJlLm1jbmFtYXJhQG1pY3JvY2hpcC5jb20+DQotLS0NCiAuLi4vYmluZGluZ3MvcGNpL21pY3Jv
Y2hpcCxwY2llLWhvc3QueWFtbCAgICAgfCA5NCArKysrKysrKysrKysrKysrKysrDQogMSBmaWxl
IGNoYW5nZWQsIDk0IGluc2VydGlvbnMoKykNCiBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCg0K
ZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9j
aGlwLHBjaWUtaG9zdC55YW1sIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0DQppbmRleCAw
MDAwMDAwMDAwMDAuLmQzYmNkYWIyODJjMg0KLS0tIC9kZXYvbnVsbA0KKysrIGIvRG9jdW1lbnRh
dGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCkBA
IC0wLDAgKzEsOTQgQEANCisjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9ubHkN
CislWUFNTCAxLjINCistLS0NCiskaWQ6IGh0dHA6Ly9kZXZpY2V0cmVlLm9yZy9zY2hlbWFzL3Bj
aS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwjDQorJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUu
b3JnL21ldGEtc2NoZW1hcy9jb3JlLnlhbWwjDQorDQordGl0bGU6IE1pY3JvY2hpcCBQQ0llIFJv
b3QgUG9ydCBCcmlkZ2UgQ29udHJvbGxlcg0KKw0KK21haW50YWluZXJzOg0KKyAgLSBEYWlyZSBN
Y05hbWFyYSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCisNCithbGxPZjoNCisgIC0g
JHJlZjogL3NjaGVtYXMvcGNpL3BjaS1idXMueWFtbCMNCisNCitwcm9wZXJ0aWVzOg0KKyAgY29t
cGF0aWJsZToNCisgICAgY29uc3Q6IG1pY3JvY2hpcCxwY2llLWhvc3QtMS4wICMgUG9sYXJGaXJl
DQorDQorICByZWc6DQorICAgIG1heEl0ZW1zOiAyDQorDQorICByZWctbmFtZXM6DQorICAgIGl0
ZW1zOg0KKyAgICAgIC0gY29uc3Q6IGNmZw0KKyAgICAgIC0gY29uc3Q6IGFwYg0KKw0KKyAgaW50
ZXJydXB0czoNCisgICAgbWluSXRlbXM6IDENCisgICAgbWF4SXRlbXM6IDENCisgICAgaXRlbXM6
DQorICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBob3N0IGNvbnRyb2xsZXIgYW5kIGJ1aWx0aW4g
TVNJIGNvbnRyb2xsZXINCisNCisgIGludGVycnVwdC1uYW1lczoNCisgICAgbWluSXRlbXM6IDEN
CisgICAgbWF4SXRlbXM6IDENCisgICAgaXRlbXM6DQorICAgICAgLSBjb25zdDogcGNpZS9tc2kN
CisNCisgIHJhbmdlczoNCisgICAgbWF4SXRlbXM6IDENCisNCisgIGRtYS1yYW5nZXM6DQorICAg
IG1heEl0ZW1zOiAxDQorDQorICBtc2ktY29udHJvbGxlcjoNCisgICAgZGVzY3JpcHRpb246IElk
ZW50aWZpZXMgdGhlIG5vZGUgYXMgYW4gTVNJIGNvbnRyb2xsZXIuDQorDQorICBtc2ktcGFyZW50
Og0KKyAgICBkZXNjcmlwdGlvbjogTVNJIGNvbnRyb2xsZXIgdGhlIGRldmljZSBpcyBjYXBhYmxl
IG9mIHVzaW5nLg0KKw0KK3JlcXVpcmVkOg0KKyAgLSByZWcNCisgIC0gcmVnLW5hbWVzDQorICAt
IGRtYS1yYW5nZXMNCisgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQorICAtIGludGVycnVwdHMNCisg
IC0gaW50ZXJydXB0LW5hbWVzDQorICAtIGludGVycnVwdC1tYXAtbWFzaw0KKyAgLSBpbnRlcnJ1
cHQtbWFwDQorICAtIG1zaS1jb250cm9sbGVyDQorDQorZXhhbXBsZXM6DQorICAtIHwNCisgICAg
c29jIHsNCisgICAgICAgIHBjaWUwOiBwY2llQDIwMzAwMDAwMDAgew0KKyAgICAgICAgICAgICNh
ZGRyZXNzLWNlbGxzID0gPDB4Mz47DQorICAgICAgICAgICAgI2ludGVycnVwdC1jZWxscyA9IDww
eDE+Ow0KKyAgICAgICAgICAgICNzaXplLWNlbGxzID0gPDB4Mj47DQorICAgICAgICAgICAgY29t
cGF0aWJsZSA9ICJtaWNyb2NoaXAscGNpZS1ob3N0LTEuMCI7DQorICAgICAgICAgICAgZGV2aWNl
X3R5cGUgPSAicGNpIjsNCisgICAgICAgICAgICBidXMtcmFuZ2UgPSA8MHgwMCAweDdmPjsNCisg
ICAgICAgICAgICAvLyBQQ0lfREVWSUNFKDMpIElOVCMoMSkgQ09OVFJPTExFUihQSEFORExFKSBD
T05UUk9MTEVSX0RBVEEoMSkNCisgICAgICAgICAgICBpbnRlcnJ1cHQtbWFwID0gPDAgMCAwIDEg
JnBjaWUwIDA+LA0KKyAgICAgICAgICAgICAgICAgICAgICAgICAgICA8MCAwIDAgMiAmcGNpZTAg
MT4sDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgIDwwIDAgMCAzICZwY2llMCAyPiwNCisg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgPDAgMCAwIDQgJnBjaWUwIDM+Ow0KKyAgICAgICAg
ICAgIGludGVycnVwdC1tYXAtbWFzayA9IDwwIDAgMCA3PjsNCisgICAgICAgICAgICBpbnRlcnJ1
cHQtcGFyZW50ID0gPCZwbGljMD47DQorICAgICAgICAgICAgaW50ZXJydXB0cyA9IDwzMj47DQor
DQorICAgICAgICAgICAgLy8gQlVTX0FERFJFU1MoMykgQ1BVX1BIWVNJQ0FMKDIpIFNJWkUoMikN
CisgICAgICAgICAgICByYW5nZXMgPSA8MHgwMzAwMDAwMCAweDAgMHg0MDAwMDAwMCAweDAgMHg0
MDAwMDAwMCAweDAgMHgyMDAwMDAwMD47DQorICAgICAgICAgICAgZG1hLXJhbmdlcyA9IDwweDAy
MDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4MSAweDAwMDAwMDAwPjsNCisN
CisgICAgICAgICAgICAvLyBDUFVfUEhZU0lDQUwoMikgU0laRSgyKQ0KKyAgICAgICAgICAgIHJl
ZyA9IDwweDIwIDB4MzAwMDAwMDAgMHgwIDB4NDAwMDAwMD4sDQorICAgICAgICAgICAgICAgICAg
PDB4MjAgICAgICAgIDB4MCAweDAgIDB4MTAwMDAwPjsNCisgICAgICAgICAgICByZWctbmFtZXMg
PSAiY2ZnIiwgImFwYiI7DQorICAgICAgICAgICAgbXNpLXBhcmVudCA9IDwmcGNpZTA+Ow0KKyAg
ICAgICAgICAgIG1zaS1jb250cm9sbGVyOw0KKyAgICAgICAgICAgIGludGVycnVwdC1jb250cm9s
bGVyOw0KKyAgICAgICAgfTsNCisgICAgfTsNCisuLi4NCi0tIA0KMi4xNy4xDQoNCg==
