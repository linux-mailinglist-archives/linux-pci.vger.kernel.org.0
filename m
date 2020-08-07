Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26EC23EE09
	for <lists+linux-pci@lfdr.de>; Fri,  7 Aug 2020 15:21:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725893AbgHGNVz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Aug 2020 09:21:55 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:34775 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgHGNVy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Aug 2020 09:21:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1596806515; x=1628342515;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=Y5buinqjiXLrw68qBp5damgHf9U8vh3DfEI3b8JGl3w=;
  b=siShXRmDqcf6eHikwNfB8V63YoU4GbN7DuJXX195JRx5/JD+bnYsmJqk
   CH5hxV5//lcu/UrsIRq73jEqY7Hq9rZIvm7YRCrxE7m6Q7e8TXXNBl6qL
   svwJwzK6Jqmrpoztv65weN9a2W1LhOUgn8HKJy3HZepCGrEA8UNQ4AwzU
   VowzhD7wcwur5sDMDdllNjhI/U6bKMIcgzD6rQ4veft3MDqW3ChMTnPLd
   07+lqtVjuSE1I3+HAP6GwByBCRdzXvtwtEhFA6eZv13QmzGdjSu29KJer
   mkhRJNNkj5xkAN8TodQ2rO+9sLC/FXZ5cKnBFApsCY9gGgnd8KVPHprTJ
   g==;
IronPort-SDR: Td9uvF+mUHEYFXaLFrLYhzGbyjTwHOXo/DrzH+1xq7VJ9bLYM04pph2jlc2IsDfFulhJqCZ7e5
 osEGThdr/W118K596Ha0Igg7jquQIy2N8FDllJYxBrNCGP9/ExzzwZoYwlvkQd44VtZhgzzpIh
 EFd4oXFAN52AOh9GQNduP7OBSlsms17etKMVQYFwwH/D961GyM0XwZPyKyFV2s72mnME6bD8U3
 Bx0cLEhd9PFqnrrZuhkeKqRt95uhchxY8mQ9HM0EHD126qUZIK+0OwYxeoTd60oyivk4aBRs0Z
 pGI=
X-IronPort-AV: E=Sophos;i="5.75,445,1589266800"; 
   d="scan'208";a="86310448"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Aug 2020 06:21:41 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 7 Aug 2020 06:21:37 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Fri, 7 Aug 2020 06:21:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n9x0C/lZT4cqDbx3MEMji4JUhSCSQAxuEThBWAYs7/x1/T6DGrWrU5M9cVEv4kTEbtpqI4s28s9j7Q1K99YBd9JoUBZeHp6FV3Zi+MXlW2wmL3hG9pvKz+GkKHcgwz9av6a67z4PrE67LXoIkw1Sa6W4GAVa+L/CdgW2CpDIcyw3K0Dzu3vqO+CpYedZhOenBEFbJhM5anPkYnPEjz0dE2lV79yPW83vXlsPpb6uuMHPWJCbSIqV0z2KCWKhlS1e6lHUbpyUcAS8V7QZTzdVBh1VswlFIdKwHe6NGZExq0vuPvovOC4C/nNo4L8vTkIsMpZlD7hSW06vkxGj2T0UEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5buinqjiXLrw68qBp5damgHf9U8vh3DfEI3b8JGl3w=;
 b=MU0BrizOLXCNF45EZokuod623frysfJS4iL1GFpv0YUFOpxFXX8s+PwdMGrCHuv1sQSNCzBxx/hFtzhoYIUwPZr+mL3Gq7U2CIvOcaQT+5mW61bgDRb+kFTVpjloJJLyB3nvZZaOFJ0dlUqFcA7jfyXOwv5Jzw8A8Hexil1vLVePUf7mpj78C7TsLkGv3R0AFTuuqo2ZovwwtVSFLjMW5hjIX3yonjzio/BpClNnhYK1I1YHBjYWHtRA4OVAmsv5DajdBR3sUHxdMLRmZiT2ZluIXcJj1pgtdPijFSaCbdR1iYvgu32pbfP24SXsK4NEKgu7OYjIrl3/QAVUglFAMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y5buinqjiXLrw68qBp5damgHf9U8vh3DfEI3b8JGl3w=;
 b=q/r/zao0w42UiG65ruNdGioHZUD5VjDGFowv6SBz3CYpEPZNbZS9rGZ7ZM2f1SV1ZtUYrGACbwip+pwCxynlAWIYRs/1UzQZCXO/3HicLt3OIIa6dvE4vzYTNdnktwQzpg6y8dTgZ4QDH8KjysdB1b93WQtDa4+wp97EqJ/YunI=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by MN2PR11MB4416.namprd11.prod.outlook.com (2603:10b6:208:188::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 13:21:38 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12%7]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 13:21:38 +0000
From:   <Daire.McNamara@microchip.com>
To:     <amurray@thegoodpenguin.co.uk>, <robh@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <linux-pci@vger.kernel.org>,
        <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <Daire.McNamara@microchip.com>, <david.abdurachmanov@gmail.com>
Subject: [PATCH v14 0/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v14 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWbL2unXPJeAhG20y+Cpysn2cQjg==
Date:   Fri, 7 Aug 2020 13:21:38 +0000
Message-ID: <eb2abaa7fc97a6e700a7c4ed37182820803414c3.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: thegoodpenguin.co.uk; dkim=none (message not signed)
 header.d=none;thegoodpenguin.co.uk; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [87.42.139.3]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2639174-b227-44bf-1d1f-08d83ad4d0b9
x-ms-traffictypediagnostic: MN2PR11MB4416:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4416164B972621FA8DF1F56796490@MN2PR11MB4416.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g7kk+tk/yiRVyuKM4jHV5IyUupajCspcrZh9om0+ElneEtLfnwOT21zBNyJgyhSr47JDeeRFHPymGBa8ZF8M18g7uByqnT7TSsciyohC0b5MgvcfAbkMwjgXuz5ujqudPz/PV59/cepxHYgG4I3o6/nI2xkEeyxCQseFn4MHb2Wn0AQL/LeOOgsHIk/f5aqHgsDQPNU9G4wFk2GljZEOcAThF0ms1PGMvMT6brio4m8zwyCqG5sTqvpMGu/wGKdGE5T2hmoll4J6CPTkahyJpOZ/1X2eYcrZ/71EXmE1Lm1PdwRiSAYU6dEQ9dgKPEMR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(346002)(396003)(39860400002)(136003)(376002)(83380400001)(2906002)(5660300002)(6486002)(8936002)(316002)(8676002)(71200400001)(26005)(54906003)(66556008)(66446008)(66946007)(4326008)(66476007)(64756008)(76116006)(91956017)(36756003)(110136005)(478600001)(2616005)(6512007)(6506007)(186003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: IfvvfgwaHF5JBeI9hbhofYdTWKcKRXJ0tq6iHLxPWjNS6ojj9GjRsmr2LR0j8hwWoVN6MwHH8W+6ibW+qi2LxLJDNppdc4XiK8hbYNtGq+L0X1tXaL3aHUfL/FP7Z32fF6fQk1aO/gj/m2zH2fsfhZGspGPZA+J9Sz7FY2K3RrjR0gxT+zDwAqeLEcYMe3FPla8Qd+UH7ULsH1P7V5CEdTookdldUl75XNR5uUxccjNJBC0DDbFYo0pcw/5eAeU1/MNFcKc89+LP5p7Nz/B1HZYvFcJ+dQTTwKNkkoitf1neNEj7H8lezbxsCTi1Y0PKmfZovVwdAVFlUFaS+MENJOH7gOvMesEknswG0k+BMArbuuG/9mSjgxCGlvAI4gVOdFrz6XGcea9jsUYSfud/GwJVXh9Bt7kDC4I4fvZgKMF7WOacQQagL6IIeD5EUBXmSUpyGyBBqa3XvhbJ/HnmtogUG+q/nZvt9v1qtjFDrcBueGhKLHdI8585JFFtUJULw8YcRMhjkrkgJ+R6h2mNhWDQk1aLQlgZD+gqrmenOVEuo7YHFWGHa2QChKk0MrWTDI1ZC0NoeCa+lFho/POLWxHx/eSSdvCnCxBFKI/AaYfmA1JW5Nx9h8aFp9I4w75tQvkxj+GUN2TQQcWJOXC+dw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <762BD6894A71E344BE948ECD58141C29@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2639174-b227-44bf-1d1f-08d83ad4d0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2020 13:21:38.0466
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MqJVvgt3Tc9/ihy5B3CV3vyANCVm/kAMtL4UipczR21zZ27gofr+NBrdzTK1Qj1C+9X1F3yZN5onJxsC9zNpMj+jhs0iANbQGr6ftiQvI2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4416
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQpUaGlzIHYxNCBwYXRjaCBhZGRzIHN1cHBvcnQgZm9yIHRoZSBNaWNyb2NoaXAgUENJZSBQb2xh
ckZpcmUgUENJZQ0KY29udHJvbGxlciB3aGVuIGNvbmZpZ3VyZWQgaW4gaG9zdCAoUm9vdCBDb21w
bGV4KSBtb2RlLg0KDQpVcGRhdGVzIHNpbmNlIHYxMzoNCiogUmVmYWN0b3JlZCB0byB1c2UgcGNp
X2hvc3RfY29tbW9uX3Byb2JlKCkNCg0KVXBkYXRlcyBzaW5jZSB2MTI6DQoqIENhcGl0YWxpc2Vk
IGNvbW1pdCBtZXNzYWdlcy4gIFVzZSBzcGVjaWZpYyBzdWJqZWN0IGxpbmUgZm9yIGR0LWJpbmRp
bmdzDQoNClVwZGF0ZXMgc2luY2UgdjExOg0KKiBBZGp1c3RlZCBzbyB5YW1sIGZpbGUgcGFzc3Nl
cyBtYWtlIGR0X2JpbmRpbmdfY2hlY2sNCg0KVXBkYXRlcyBzaW5jZSB2MTA6DQoqIEFkanVzdGVk
IGRyaXZlciBhcyBwZXIgUm9iIEhlcnJpbmcncyBjb21tZW50cywgbm90YWJseToNCiAgLSB1c2Ug
Y29tbW9uIFBDSV9NU0lfRkxBR1MgZGVmaW5lcw0KICAtIHJlZHVjZSBzdG9yYWdlIG9mIHVubmVj
ZXNzYXJ5IHZhcnMgaW4gbWNfcGNpZSBzdHJ1Y3QNCiAgLSBzd2l0Y2hlZCB0byByZWFkL3dyaXRl
IHJlbGF4ZWQgdmFyaWFudHMNCiAgLSBleHRlbmRlZCBsb2NrIGluIG1zaV9kb21haW5fYWxsb2Mg
cm91dGluZQ0KICAtIGltcHJvdmVkIDMyYml0IHNhZmV0eSwgc3dpdGNoZWQgZnJvbSBmaW5kX2Zp
cnN0X2JpdCgpIHRvIGlsb2cyKCkNCiAgLSByZW1vdmVkIHVubmVjZXNzYXJ5IHR3aWRkbGUgb2Yg
ZUNBTSBjb25maWcgc3BhY2UNCg0KVXBkYXRlcyBzaW5jZSB2OToNCiogQWRqdXN0ZWQgY29tbWl0
IGxvZ3MNCiogbWFrZSBkdF9iaW5kaW5nc19jaGVjayBwYXNzZXMNCg0KVXBkYXRlcyBzaW5jZSB2
ODoNCiogUmVmYWN0b3JlZCBhcyBwZXIgUm9iIEhlcnJpbmcncyBjb21tZW50czoNCiAgLSBiaW5k
aW5ncyBpbiBzY2hlbWEgZm9ybWF0DQogIC0gQWRqdXN0ZWQgbGljZW5jZSB0byBHUEx2Mi4wDQog
IC0gUmVmYWN0b3JlZCBhY2Nlc3MgdG8gY29uZmlnIHNwYWNlIGJldHdlZW4gZHJpdmVyIGFuZCBj
b21tb24gZUNBTSBjb2RlDQogIC0gQWRvcHRlZCBwY2lfaG9zdF9wcm9iZSgpDQogIC0gTWlzY2Vs
bGFub3VzIG90aGVyIGltcHJvdmVtZW50cw0KDQpVcGRhdGVzIHNpbmNlIHY3Og0KKiBCdWlsZCBm
b3IgNjRiaXQgUklTQ1YgYXJjaGl0ZWN0dXJlIG9ubHkNCg0KVXBkYXRlcyBzaW5jZSB2NjoNCiog
UmVmYWN0b3JlZCB0byB1c2UgY29tbW9uIGVDQU0gZHJpdmVyDQoqIFVwZGF0ZWQgdG8gQ09ORklH
X1BDSUVfTUlDUk9DSElQX0hPU1QgZXRjDQoqIEZvcm1hdHRpbmcgaW1wcm92ZW1lbnRzDQoqIFJl
bW92ZWQgY29kZSBmb3Igc2VsZWN0aW9uIGJldHdlZW4gYnJpZGdlIDAgYW5kIDENCg0KVXBkYXRl
cyBzaW5jZSB2NToNCiogRml4ZWQgS2NvbmZpZyB0eXBvIG5vdGVkIGJ5IFJhbmR5IER1bmxhcA0K
KiBVcGRhdGVkIHdpdGggY29tbWVudHMgZnJvbSBCam9ybiBIZWxnYWFzDQoNClVwZGF0ZXMgc2lu
Y2UgdjQ6DQoqIEZpeCBjb21waWxlIGlzc3Vlcy4NCg0KVXBkYXRlcyBzaW5jZSB2MzoNCiogVXBk
YXRlIGFsbCByZWZlcmVuY2VzIHRvIE1pY3Jvc2VtaSB0byBNaWNyb2NoaXANCiogU2VwYXJhdGUg
TVNJIGZ1bmN0aW9uYWxpdHkgZnJvbSBsZWdhY3kgUENJZSBpbnRlcnJ1cHQgaGFuZGxpbmcgZnVu
Y3Rpb25hbGl0eQ0KDQpVcGRhdGVzIHNpbmNlIHYyOg0KKiBTcGxpdCBvdXQgRFQgYmluZGluZ3Mg
YW5kIFZlbmRvciBJRCB1cGRhdGVzIGludG8gdGhlaXIgb3duIHBhdGNoDQogIGZyb20gUENJZSBk
cml2ZXIuDQoqIFVwZGF0ZWQgQ2hhbmdlIExvZw0KDQpVcGRhdGVzIHNpbmNlIHYxOg0KKiBJbmNv
cnBvcmF0ZSBmZWVkYmFjayBmcm9tIEJqb3JuIEhlbGdhYXMNCg0KRGFpcmUgTWNOYW1hcmEgKDIp
Og0KICBkdC1iaW5kaW5nczogUENJOiBtaWNyb2NoaXA6IEFkZCBNaWNyb2NoaXAgUG9sYXJGaXJl
IGhvc3QgYmluZGluZw0KICBQQ0k6IG1pY3JvY2hpcDogQWRkIGhvc3QgZHJpdmVyIGZvciBNaWNy
b2NoaXAgUENJZSBjb250cm9sbGVyDQoNCiAuLi4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2ll
LWhvc3QueWFtbCAgICAgfCAgOTMgKysrDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmln
ICAgICAgICAgICAgICAgIHwgICA5ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxl
ICAgICAgICAgICAgICAgfCAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNy
b2NoaXAtaG9zdC5jICB8IDU2OSArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQs
IDY3MiBpbnNlcnRpb25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQogY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQoN
Cg0KYmFzZS1jb21taXQ6IDQ3ZWM1MzAzZDczZWEzNDRlODRmNDY2NjBmZmY2OTNjNTc2NDEzODYN
Ci0tIA0KMi4xNy4xDQoNCg==
