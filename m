Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A1B50169DFB
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 06:50:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgBXFuf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 00:50:35 -0500
Received: from mail-eopbgr00070.outbound.protection.outlook.com ([40.107.0.70]:21894
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgBXFue (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 00:50:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlkWOpDgdz3TCVevgSOSNicH9Ifx14GrYptLDjktqJrVJ26YPll/nYa/fYG4XDzIaYwmjlxeDoWrJUK7Uz8s4g77sXVWe9ei11V3MRrxD2tS5i5U+mfkqoeM8Y9ig57v4U+KmSHCIDlzKXSTRiiWtFNO/xTZ4ZcggbdWPKV32zlrZiUNIMoM7Dzz2F/nz/V6K29S6HnTtaK/stVWkb/VPxkhyVdE37PJTzkKlh/Ti55oza8AKNNDf8shivjLg2dtRD9phcHu29bXn2bHBJgOX2jyoW4XsBdSPPU5rbKSiWSc4u48R0TCZq23Zkq08rKS3Yenm3okE72xBJT079pU1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlQnjAbckBu+CIY0yHGG9VW7Rd4DS6T9ZToeH3Hpkok=;
 b=ajusrdxXHP5MJeffJ9xnVQIUOehPoUQSBZUkuNI9scOVfx16+D9+AiuYtobMQVe+XSYA4LsqTRgnyOglii3TiFKP7s9C/PEhelicGiRAglGq2ON5NtNGFkSFdQu1dMfmDDc2bOSLUGAdqCH/B7crDioAznIQFNBfWAk+bwwO8HzPGJdmWc1PXxKrqhaXFgcxIg2sYba0XN7w6kwr5U1ktHF0+FJyA6o+vcZgH9K+oLHU98ih6kuS8VCQU02CNd4FTwfJ9F0YJF9Pu/HMmZmnZ+qttHEfW+5PNG9O424KpAyNHLFxLJaShUpzmKSrwH1cKs21WMSBJF6rMfa25LFLow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hlQnjAbckBu+CIY0yHGG9VW7Rd4DS6T9ZToeH3Hpkok=;
 b=jYCK/fIbqnjgVMzMdClC6Depo0QcCT0zahCysgD/t/RuHHWfLNSxrTPLozH/Ki4Hhx2tXHFpRBd2eA2xtXoKXXzD84nTh81P5KqUspeyvLmMS1MM5Hm9qRVXWh7wNeSfAKzDITW68DrK5BfnqdlawhYeZe7GU/F/659j/i/4fSM=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6539.eurprd04.prod.outlook.com (20.179.249.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Mon, 24 Feb 2020 05:50:30 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 05:50:30 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv10 09/13] PCI: mobiveil: Add Header Type field check
Thread-Topic: [PATCHv10 09/13] PCI: mobiveil: Add Header Type field check
Thread-Index: AQHV4iOLwf5yYYVL3kO4rRyUNZ7HzagkYtOAgAWFg5A=
Date:   Mon, 24 Feb 2020 05:50:30 +0000
Message-ID: <DB8PR04MB674794A917F923FB565B044684EC0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-10-Zhiqiang.Hou@nxp.com>
 <20200220173115.GJ19388@big-machine>
In-Reply-To: <20200220173115.GJ19388@big-machine>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73a716d5-d804-4f45-0be9-08d7b8ed7531
x-ms-traffictypediagnostic: DB8PR04MB6539:|DB8PR04MB6539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6539FB2C8E1AC5EBBBF3AA8884EC0@DB8PR04MB6539.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(6916009)(55016002)(9686003)(33656002)(2906002)(186003)(26005)(478600001)(8676002)(8936002)(53546011)(7416002)(4326008)(86362001)(66946007)(7696005)(81156014)(81166006)(76116006)(71200400001)(66556008)(66446008)(5660300002)(316002)(52536014)(54906003)(66476007)(64756008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6539;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XWsERt5hyj+eGLMHSXEpTQSI76/ErV62XAFDT6Cq3wNZfiMJuELzLxYCQgc/1PqUYRuSYkFOVw9hrX5loDsQGLr/QdTz/XD48W/lAESkJoe18tIzfX788TcDo/3wlYHl2kq4RJ4Gqf0e5CkKsTV6i91Msef+c5MHYJ1GD+PGCAomAzTU3mHFCXdJNNYlCYVZng6VjdLXN41JBkxT/ueJ2IYiHBQbM3G4fJFB9k5jk0XbQNS9uAmzvZvrhjTY4cC1Lub+PR5EOJ5rfcNaeW3c9H4d5wxTk68nL9AdGovVbW1tSRLJyWWRtzDBdUr+0WQbNgdfuQSgfoI7KXL0IIzLOks/WplZ9WISWmBlItJdPagsD6tJntzjEAIEmEo4cxnlBoxvMAZ79vTDU/x7yAKDi7Rk/LTFeHcdO+VfOyOL6OuuVyuMwZwnfOfkMiAAq5AA
x-ms-exchange-antispam-messagedata: z/3FGlNvGAYrCysYhw5s+onX/2tV44Dc/Mq7FU0KEfxC4c4hkFxHyGrTls+YUB3gDtv8Gd5kdxlRuXj0OWNSNR7NXqN77oDVsK1FhtGaS6IAIAXf+k7bvjEu0pLl9p/e1oUZwhjOvoYDbKuwm1zEzg==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a716d5-d804-4f45-0be9-08d7b8ed7531
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 05:50:30.7693
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jmX0f6OxQQ2GRl0skqMq6p5+uZKJgmQqXgWz1chzfgybNm0J/qW9ogUuoKDmfJY1N+4NQm7/VSDy7bgafBDXyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6539
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpUaGFua3MsDQpa
aGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBN
dXJyYXkgPGFtdXJyYXlAdGhlZ29vZHBlbmd1aW4uY28udWs+DQo+IFNlbnQ6IDIwMjDE6jLUwjIx
yNUgMTozMQ0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRy
ZXcubXVycmF5QGFybS5jb207DQo+IGFybmRAYXJuZGIuZGU7IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBt
LmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNv
bT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
OyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvDQo+IDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjEwIDA5LzEzXSBQQ0k6IG1v
Yml2ZWlsOiBBZGQgSGVhZGVyIFR5cGUgZmllbGQgY2hlY2sNCj4gDQo+IE9uIFRodSwgRmViIDEz
LCAyMDIwIGF0IDEyOjA2OjQwUE0gKzA4MDAsIFpoaXFpYW5nIEhvdSB3cm90ZToNCj4gPiBGcm9t
OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gQ2hlY2sgdGhl
IEhlYWRlciBUeXBlIGFuZCBleGl0IGZyb20gdGhlIGhvc3QgZHJpdmVyIGluaXRpYWxpemF0aW9u
IGlmDQo+ID4gaXQgaXMgbm90IGluIGhvc3QgbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+IA0KPiBSZXZpZXdlZC1ieTog
QW5kcmV3IE11cnJheSA8YW11cnJheUB0aGVnb29kcGVuZ3Vpbi5jby51az4NCj4gDQo+ID4gLS0t
DQo+ID4gVjEwOg0KPiA+ICAtIE5ldyBwYXRjaCBzZXBhcmF0ZWQgZnJvbSAjMTAgb2YgdjkuDQo+
ID4NCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5j
ICAgIHwgMTMgKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMTMgaW5zZXJ0aW9u
cygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9i
aXZlaWwvcGNpZS1tb2JpdmVpbC1ob3N0LmMNCj4gPiBpbmRleCA0NGRkNjQxZmVkZTMuLmRiNzAy
ODc4OGQ5MSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWls
L3BjaWUtbW9iaXZlaWwtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9t
b2JpdmVpbC9wY2llLW1vYml2ZWlsLWhvc3QuYw0KPiA+IEBAIC01NTQsNiArNTU0LDE2IEBAIHN0
YXRpYyBpbnQgbW9iaXZlaWxfcGNpZV9pbnRlcnJ1cHRfaW5pdChzdHJ1Y3QNCj4gbW9iaXZlaWxf
cGNpZSAqcGNpZSkNCj4gPiAgCXJldHVybiBtb2JpdmVpbF9wY2llX2ludGVncmF0ZWRfaW50ZXJy
dXB0X2luaXQocGNpZSk7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgYm9vbCBtb2JpdmVpbF9w
Y2llX2lzX2JyaWRnZShzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkgew0KPiA+ICsJdTMyIGhl
YWRlcl90eXBlOw0KPiA+ICsNCj4gPiArCWhlYWRlcl90eXBlID0gbW9iaXZlaWxfY3NyX3JlYWRi
KHBjaWUsIFBDSV9IRUFERVJfVFlQRSk7DQo+ID4gKwloZWFkZXJfdHlwZSAmPSAweDdmOw0KPiA+
ICsNCj4gPiArCXJldHVybiBoZWFkZXJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfQlJJREdFOyB9
DQo+ID4gKw0KPiA+ICBpbnQgbW9iaXZlaWxfcGNpZV9ob3N0X3Byb2JlKHN0cnVjdCBtb2JpdmVp
bF9wY2llICpwY2llKSAgew0KPiA+ICAJc3RydWN0IG1vYml2ZWlsX3Jvb3RfcG9ydCAqcnAgPSAm
cGNpZS0+cnA7IEBAIC01NjksNiArNTc5LDkgQEAgaW50DQo+ID4gbW9iaXZlaWxfcGNpZV9ob3N0
X3Byb2JlKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKQ0KPiA+ICAJCXJldHVybiByZXQ7DQo+
ID4gIAl9DQo+ID4NCj4gPiArCWlmICghbW9iaXZlaWxfcGNpZV9pc19icmlkZ2UocGNpZSkpDQo+
ID4gKwkJcmV0dXJuIC1FTk9ERVY7DQo+ID4gKw0KPiA+ICAJLyogcGFyc2UgdGhlIGhvc3QgYnJp
ZGdlIGJhc2UgYWRkcmVzc2VzIGZyb20gdGhlIGRldmljZSB0cmVlIGZpbGUgKi8NCj4gPiAgCXJl
dCA9IHBjaV9wYXJzZV9yZXF1ZXN0X29mX3BjaV9yYW5nZXMoZGV2LCAmYnJpZGdlLT53aW5kb3dz
LA0KPiA+ICAJCQkJCSAgICAgICZicmlkZ2UtPmRtYV9yYW5nZXMsIE5VTEwpOw0KPiA+IC0tDQo+
ID4gMi4xNy4xDQo+ID4NCg==
