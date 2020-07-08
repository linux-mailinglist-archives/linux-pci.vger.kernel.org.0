Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D58B6218A80
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jul 2020 16:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729745AbgGHO5I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jul 2020 10:57:08 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:60703 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgGHO5H (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jul 2020 10:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594220227; x=1625756227;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=yrqCFzpiWpbM4C8DLeLnp3nMMLuZ0DQzga/eSprFC+w=;
  b=yKJlwvAw+CLfTIdF5UHvaM/nn42LAyyXiZZzUajiqeFWH8dYPTkHonEm
   DO/68qUDdX0+RoVMAPVuzK2X9Fktd6ydzU0UhcdB81g613TnjPlwFiItv
   TnBeR707+lQ0f7oiVCmQhKuWB+PaUTmwMWSBLfr+eVr3+oQDFPy4tT8nb
   UdyP2KJivKwMzzR2I1ElEx8h31a3dqhjOy/XZq3mb8w06FMc4JzpJ7Tlo
   KBaP/Jo/dfLOa+Smv71vBnAn1gyCAbWkRrVZqA+G2mu0Xal4fKZljafS5
   Eo6Rsv869r4BWAQ57qalXzo2DBwKtCeq+768bDVJRBaMxGThlFSFbCi+J
   w==;
IronPort-SDR: r1YYED+0SlB5TEQp0XE+jjXl+pxrdma2y1TXGBqC7sHxXPXQLB04OCqmDF05E7C2bR8gyzA5+J
 OeOKCjFz7+HfymOQ8VnEiBcZI8cUViWpgCMl6GKywUCixjVOnhUXP637PDD5+SA4jhAWQLJ/s1
 vjrtwqrb7ZvkPhypDusiXvo1foFsqJN7//GjCBhqxwINKPEQjiuB1EIqNP0ngGWXNayNnfV1UE
 lxsZ96I7wiTHig9IHqE2vJ/i1+qTEwBzg/dYOJVCHJ674fuw+KaCovtrP8/IepmtbYDexPzTfh
 8O4=
X-IronPort-AV: E=Sophos;i="5.75,327,1589266800"; 
   d="scan'208";a="86668932"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jul 2020 07:57:07 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 8 Jul 2020 07:56:41 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Wed, 8 Jul 2020 07:56:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LF+4JCniEMKQJjd+ekSlLHfcFxvt7u3OTSHEHNGaF9+s1WxLmTO0qqnPBBYSg+ngatnV/F7mDS4vmYZwMkVdFFKCiHsQzDcVofmAHVus7sZgL8e3VCDPBttiHOuZxMIIpPNITxMvhKgYDP+ElY0fPL2oZlyWylddUdaP46sa0Kh/SFrgpbsY+NNn+TJlEcOl6l8en40l5KtON6d/AgRZabVdb+vF2Cu1GKkUjYSNLgk4FAoE72oSdcApc4jlCDlzsuAXZ0Bhnp2mqMgFYjlqa7dhswl5YqGpGzoPHD6l48VyOTLTMQSHjzdj9iI2XUY5y20mHrniP7TAiiI+DJUkqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrqCFzpiWpbM4C8DLeLnp3nMMLuZ0DQzga/eSprFC+w=;
 b=kEqeZmjcjW0IammfzdSmmVKyr6OET/SjAk2QWyZgdMUlgi16DMSmD/b8N8dKaZMo2nLhP49Ci+mGdxXkHwrJJlsxPrWtIKF/cwTsPMUTx3wFdiE0n/IwtfZtC8HjJzw7xsQaKbWyLhF+/2kpRraMfKW7wfdkopeTi66QM9XPvw+TrW3JMaopdEjP3w2cc4tkicVavbq4cpbxUmRs4MCC4sN9L/PFwoEYWScpAKFcy648pZ5JNMUsVyWfwlc80t8JlMEveMhBVIWKQ/HLFYnRKmE+hiCTiQFWPbQUgJRdaNGYUoSRdXGmyRGC/EVWlwLYBKMUbBN8XkFTE5WfvsJg5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrqCFzpiWpbM4C8DLeLnp3nMMLuZ0DQzga/eSprFC+w=;
 b=svIxh6kIgdE3AE7iuJhNQm0IXbFdu+OWuZEb+sbhj8pyZAZbGoTxsbO7vcD8WJt7qrqg/yB7jyrDnZ+TxAkaMopeR1elHq6eitfb3Gy4W3nG/B9K1Hx/zbKzrsmtF+3aErwarPlQ1r3L4em0CBq1VZbM9EJq4CqvOFosQ64rjx4=
Received: from MN2PR11MB4269.namprd11.prod.outlook.com (2603:10b6:208:190::32)
 by BL0PR11MB2946.namprd11.prod.outlook.com (2603:10b6:208:78::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Wed, 8 Jul
 2020 14:57:02 +0000
Received: from MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12]) by MN2PR11MB4269.namprd11.prod.outlook.com
 ([fe80::2015:b551:35a7:4c12%7]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 14:57:02 +0000
From:   <Daire.McNamara@microchip.com>
To:     <robh@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <linux-pci@vger.kernel.org>, <bhelgaas@google.com>,
        <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
CC:     <Daire.McNamara@microchip.com>, <david.abdurachmanov@gmail.com>
Subject: [PATCH v13 0/2] PCI: microchip: Add host driver for Microchip PCIe
 controller
Thread-Topic: [PATCH v13 0/2] PCI: microchip: Add host driver for Microchip
 PCIe controller
Thread-Index: AQHWVTgIOCLIkJdPV06nqwI9G4nOSg==
Date:   Wed, 8 Jul 2020 14:57:00 +0000
Message-ID: <56d2a9855f93455c6150b92682178c93fe70ed72.camel@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microchip.com;
x-originating-ip: [89.101.219.210]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 810acfab-564a-4c28-9a97-08d8234f2c3f
x-ms-traffictypediagnostic: BL0PR11MB2946:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR11MB2946B94CF10250F3DC5B2AC696670@BL0PR11MB2946.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:792;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MMlbHs2pZX7bB4fho1hEYaXYWpvAPGGohrhm6wixpDH00/7YINMYZJa0jcqo9flyMaZ9mP0udzjIlYOvh9u/htevpajlbslAFuINb3ZuwGkGcjt9uJxgs8HPrbRRSeTogFS7XppE/j/QeqlpSfDaATFlVBRt9ZawdlhGosQ8H1dQJ8igHG/r058/1edzb4FemK7Vy1W3dQz98FidZIojEyk2x7SPq6noXCT05NPC8o7ZSF30NoJku++oIC+xb2wkM/IaW0YTP+cJsoYJJVGpmI6+utz0KJwXtpUnKSweaFtBhzTlziMYQiWM9yG1L5/c
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4269.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(376002)(39860400002)(346002)(136003)(366004)(396003)(8676002)(8936002)(316002)(6486002)(2616005)(71200400001)(478600001)(5660300002)(76116006)(66946007)(66556008)(66476007)(91956017)(66446008)(64756008)(186003)(2906002)(4326008)(26005)(110136005)(83380400001)(36756003)(54906003)(86362001)(6512007)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: pHzQQZ8/Q9ZSn3jvRzQ3O4yE4A7rPsEWzJY2Zudx20ZolWZVtLLWo52RrMWjHG76N4aepmSc/CRuzyHNuC8eS5EFpDwdUYWsJ0LBpcnhxbJizba1FlWEaICBr4L1o67kMZev+dsn7XA4R+Ij1gvul7J31sCZgmIjmD03gOJmSpCZKGTTFVrVDIFNAToDng1/fb5AA+trGybHlFdRcK2gWcGyUq8X1F0Uhmj2N2UmTrEN98WydpYj3GDn+1PBRlTu+f4/M6x+Zwb/riEFlNQvEw+s/a/js+z8h7M1SHMBXhtpKaIeBuboMakq/O2n4QSad53hb1P4zFmG7G71sM0dDbAik4NI5V76NRn7+uuMPLXcmyB+xyo8nV3pzNySjv3qxtbOyGwt0akFnO9kujMFUDNWVe76R4e9LEq7bB0YVsLu34O2yhfygVpoIIfjBX4Tlu/TegOPVx2wph/zamIwVk8MATclNpXLkCY9qTQKBKbCiqp5UMFekEJXKcBjn7af
Content-Type: text/plain; charset="utf-8"
Content-ID: <C73AB7AFD593D6438E204123E725AE73@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4269.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 810acfab-564a-4c28-9a97-08d8234f2c3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2020 14:57:02.2970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4u0jgPk5sK2Vp1X1KJ42Wc0W6OdLVEHx4cblmvPZCmCp3xX+SAswtmXXJ2JaFRknhP+KbCMseD0eDl88qkDe1rfjVajROppiip+6ldksx64=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR11MB2946
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VGhpcyB2MTMgcGF0Y2ggYWRkcyBzdXBwb3J0IGZvciB0aGUgTWljcm9jaGlwIFBDSWUgUG9sYXJG
aXJlIFBDSWUNCmNvbnRyb2xsZXIgd2hlbiBjb25maWd1cmVkIGluIGhvc3QgKFJvb3QgQ29tcGxl
eCkgbW9kZS4NCg0KVXBkYXRlcyBzaW5jZSB2MTI6DQoqIENhcGl0YWxpc2VkIGNvbW1pdCBtZXNz
YWdlcy4gIFVzZSBzcGVjaWZpYyBzdWJqZWN0IGxpbmUgZm9yIGR0LWJpbmRpbmdzDQoNClVwZGF0
ZXMgc2luY2UgdjExOg0KKiBBZGp1c3RlZCBzbyB5YW1sIGZpbGUgcGFzc3NlcyBtYWtlIGR0X2Jp
bmRpbmdfY2hlY2sNCg0KVXBkYXRlcyBzaW5jZSB2MTA6DQoqIEFkanVzdGVkIGRyaXZlciBhcyBw
ZXIgUm9iIEhlcnJpbmcncyBjb21tZW50cywgbm90YWJseToNCiAgLSB1c2UgY29tbW9uIFBDSV9N
U0lfRkxBR1MgZGVmaW5lcw0KICAtIHJlZHVjZSBzdG9yYWdlIG9mIHVubmVjZXNzYXJ5IHZhcnMg
aW4gbWNfcGNpZSBzdHJ1Y3QNCiAgLSBzd2l0Y2hlZCB0byByZWFkL3dyaXRlIHJlbGF4ZWQgdmFy
aWFudHMNCiAgLSBleHRlbmRlZCBsb2NrIGluIG1zaV9kb21haW5fYWxsb2Mgcm91dGluZQ0KICAt
IGltcHJvdmVkIDMyYml0IHNhZmV0eSwgc3dpdGNoZWQgZnJvbSBmaW5kX2ZpcnN0X2JpdCgpIHRv
IGlsb2cyKCkNCiAgLSByZW1vdmVkIHVubmVjZXNzYXJ5IHR3aWRkbGUgb2YgZUNBTSBjb25maWcg
c3BhY2UNCg0KVXBkYXRlcyBzaW5jZSB2OToNCiogQWRqdXN0ZWQgY29tbWl0IGxvZ3MNCiogbWFr
ZSBkdF9iaW5kaW5nc19jaGVjayBwYXNzZXMNCg0KVXBkYXRlcyBzaW5jZSB2ODoNCiogUmVmYWN0
b3JlZCBhcyBwZXIgUm9iIEhlcnJpbmcncyBjb21tZW50czoNCiAgLSBiaW5kaW5ncyBpbiBzY2hl
bWEgZm9ybWF0DQogIC0gQWRqdXN0ZWQgbGljZW5jZSB0byBHUEx2Mi4wDQogIC0gUmVmYWN0b3Jl
ZCBhY2Nlc3MgdG8gY29uZmlnIHNwYWNlIGJldHdlZW4gZHJpdmVyIGFuZCBjb21tb24gZUNBTSBj
b2RlDQogIC0gQWRvcHRlZCBwY2lfaG9zdF9wcm9iZSgpDQogIC0gTWlzY2VsbGFub3VzIG90aGVy
IGltcHJvdmVtZW50cw0KDQpVcGRhdGVzIHNpbmNlIHY3Og0KKiBCdWlsZCBmb3IgNjRiaXQgUklT
Q1YgYXJjaGl0ZWN0dXJlIG9ubHkNCg0KVXBkYXRlcyBzaW5jZSB2NjoNCiogUmVmYWN0b3JlZCB0
byB1c2UgY29tbW9uIGVDQU0gZHJpdmVyDQoqIFVwZGF0ZWQgdG8gQ09ORklHX1BDSUVfTUlDUk9D
SElQX0hPU1QgZXRjDQoqIEZvcm1hdHRpbmcgaW1wcm92ZW1lbnRzDQoqIFJlbW92ZWQgY29kZSBm
b3Igc2VsZWN0aW9uIGJldHdlZW4gYnJpZGdlIDAgYW5kIDENCg0KVXBkYXRlcyBzaW5jZSB2NToN
CiogRml4ZWQgS2NvbmZpZyB0eXBvIG5vdGVkIGJ5IFJhbmR5IER1bmxhcA0KKiBVcGRhdGVkIHdp
dGggY29tbWVudHMgZnJvbSBCam9ybiBIZWxnYWFzDQoNClVwZGF0ZXMgc2luY2UgdjQ6DQoqIEZp
eCBjb21waWxlIGlzc3Vlcy4NCg0KVXBkYXRlcyBzaW5jZSB2MzoNCiogVXBkYXRlIGFsbCByZWZl
cmVuY2VzIHRvIE1pY3Jvc2VtaSB0byBNaWNyb2NoaXANCiogU2VwYXJhdGUgTVNJIGZ1bmN0aW9u
YWxpdHkgZnJvbSBsZWdhY3kgUENJZSBpbnRlcnJ1cHQgaGFuZGxpbmcgZnVuY3Rpb25hbGl0eQ0K
DQpVcGRhdGVzIHNpbmNlIHYyOg0KKiBTcGxpdCBvdXQgRFQgYmluZGluZ3MgYW5kIFZlbmRvciBJ
RCB1cGRhdGVzIGludG8gdGhlaXIgb3duIHBhdGNoDQogIGZyb20gUENJZSBkcml2ZXIuDQoqIFVw
ZGF0ZWQgQ2hhbmdlIExvZw0KDQpVcGRhdGVzIHNpbmNlIHYxOg0KKiBJbmNvcnBvcmF0ZSBmZWVk
YmFjayBmcm9tIEJqb3JuIEhlbGdhYXMNCg0KRGFpcmUgTWNOYW1hcmEgKDIpOg0KICBkdC1iaW5k
aW5nczogUENJOiBtaWNyb2NoaXA6IEFkZCBNaWNyb2NoaXAgUG9sYXJGaXJlIGhvc3QgYmluZGlu
Zw0KICBQQ0k6IG1pY3JvY2hpcDogQWRkIGhvc3QgZHJpdmVyIGZvciBNaWNyb2NoaXAgUENJZSBj
b250cm9sbGVyDQoNCiAuLi4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCAg
ICAgfCAgOTMgKysrDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAg
ICAgIHwgICA5ICsNCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAg
ICAgfCAgIDEgKw0KIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5j
ICB8IDY4MyArKysrKysrKysrKysrKysrKysNCiA0IGZpbGVzIGNoYW5nZWQsIDc4NiBpbnNlcnRp
b25zKCspDQogY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvbWljcm9jaGlwLHBjaWUtaG9zdC55YW1sDQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1taWNyb2NoaXAtaG9zdC5jDQoNCg0KYmFzZS1jb21t
aXQ6IGNkNzcwMDZlMDFiMzE5OGM3NWZiNzgxOWIzZDBmZjg5NzA5NTM5YmINCi0tIA0KMi4xNy4x
DQoNCg==
