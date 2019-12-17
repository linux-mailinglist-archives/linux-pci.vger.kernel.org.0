Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2404D122227
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2019 03:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726875AbfLQCuU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Dec 2019 21:50:20 -0500
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:52878
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726859AbfLQCuT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Dec 2019 21:50:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dPq+S92JF077esTAx9ue6Qh53j3536q/5IgSzFD2DqTsSjCfj548Qi9FduQNslm3Vkbozin27O8WplWNVQgEwWvrKKfsED9Y5lFD7WscA/JKIte+qdexv+W6As0zI72HZDnAP0lrhTP0ccBzwi/pbHH6cv3ukK474qnfPo+q/9rZGt0mp+YNv2KrK+oJfQ6kzOqhbhh68q9PtzJjDQTrTUuuB5UHVlr7JjkjBrUWZr1IvZHSfrs+30yfLiugQkQVJDgW6QqYa+tO07VZpuv+oq/OqPnnafBS98IBG7yS9t0DLLRZI+lINTYPfxscrlLGNZ+JkJPsuM1lCk5SiGNSKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmmHddfra0gGS7w9c8e+0PL+o6cnE/xTkJUf52Sv76c=;
 b=VTC9V94ynWJiuzVZ8byN2+THeoy1P4fA7ocpg1oApMRDXY5npZ4HlwrmtIF+j9TRAuZg2BcvOAYM+BS+YrkJOgP2xFNSIm5jJfy+N7EwA68tXGWTx29g5hJDLqJ95sPfJT3Fgndk0OgsWsaXKAEsvXEKhAo1c35eL43SCzXaV4t49zpCt9va3w+Hk1WratLWyHL1nAVQj9IJDmkLlfEiROojwMII/65MRYP42MOgnFMzVkpNXqUE4jr0t+I+RP/DNVRO0oiuVr4+DmaRI5DI3yb4gpcElOYQ7/ikbQB5+EDEjC8jXJjky0mXDiAeYPL84acHgiLLyLPPs0PS4gRMjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmmHddfra0gGS7w9c8e+0PL+o6cnE/xTkJUf52Sv76c=;
 b=OwztODREkEPniQsheMPgCRaS9rWbHi4Vc1DF7moDrRqFwFEM2/8Nsb3qn4aOSUIo01ZlfWWR24ODlwADcuFSHrrKQVWx82nFkBGb7C24NKVMx0GvZAFfRpUO0rO+HE3f1wJeJ1v9GFQT12W99CuE2R+A1AB/hntCAwblRmbFhUY=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6954.eurprd04.prod.outlook.com (52.133.242.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.18; Tue, 17 Dec 2019 02:50:15 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::2198:bb00:1add:d638]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::2198:bb00:1add:d638%3]) with mapi id 15.20.2538.019; Tue, 17 Dec 2019
 02:50:15 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Olof Johansson <olof@lixom.net>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVn1Tsfp+9ZVhNFU2th1+s/za9wae4ifkAgAU/LmA=
Date:   Tue, 17 Dec 2019 02:50:15 +0000
Message-ID: <DB8PR04MB6747DA8E1480DCF3EFF67C9284500@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
In-Reply-To: <CAOesGMjAQSfx1WZr6b1kNX=Exipj_f4X_f39Db7AxXr4xG4Tkg@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 23e86835-4041-460b-075a-08d7829bd7fd
x-ms-traffictypediagnostic: DB8PR04MB6954:|DB8PR04MB6954:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB69544E641E65A9C1B5D141C684500@DB8PR04MB6954.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 02543CD7CD
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(199004)(189003)(13464003)(8936002)(71200400001)(81166006)(81156014)(478600001)(8676002)(9686003)(26005)(66446008)(64756008)(66556008)(5660300002)(66476007)(110136005)(54906003)(316002)(86362001)(7696005)(186003)(33656002)(52536014)(76116006)(6506007)(4326008)(66946007)(2906002)(53546011)(55016002)(7416002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6954;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 40bkpwVWTZ11z1B4FkanbXLFwT65eEs29yvwozaO5N5+RkEfd7w8DWD38vhGuBDy8xixOtHVaN1+blZzY+/PwSwh3TmFhJ99JnjAGC6yLNa88VRmfiZePs1dSj48KhQwT4rOJHKmAYu7Gr6Up82AlX9TxILMG2Q3rGGgk8qPaOxMqI9MtkjUG/DM9evKYegRdEE+VCt1sJz+K2NKXh411a9CLTc07uht/kKrexuo4lsoxEKCBmWio1OR/X2fH7Gc63jfb6x8R1APPSR4uxjjSY1UscgcevEsUTGEThuiLMIJCNHHTL5UV12DgvSF3/s42N2pExIEg+srtUI/jraw550LqZF0bnL+4rTTWANmbEPX2X08KZjH8ZaJGxDyTfXKNQNJ78pjb1YQs1nbIw29Jpd8UaDce4IgaiiZ2mAYIiTHViMNf6CFdfUen/2PqZbqUcS4ERlLEwKyF8wECVBBUq+v2wopW96hvtbpdnDoJH0/REpm2ilA+XAzCAu6o8oZ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23e86835-4041-460b-075a-08d7829bd7fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2019 02:50:15.0630
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0S1YSLxYqEyWXvHhoqT9raJdjpDw4OuKyKDvu5EyYkmt76lRwJIM1/wfVisFIkpgwtHd5xY9Zm5+/8PS4NAvXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6954
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhlIHY5IHBhdGNoZXMgaGF2ZSBhZGRyZXNzZWQgdGhlIGNvbW1lbnRz
IGZyb20gQW5kcmV3LCBhbmQgaXQgaGFzIGJlZW4gZHJpZWQgYWJvdXQgMSBtb250aCwgY2FuIHlv
dSBoZWxwIHRvIGFwcGx5IHRoZW0/DQoNClRoYW5rcywNClpoaXFpYW5nDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0
Pg0KPiBTZW50OiAyMDE55bm0MTLmnIgxNOaXpSAyOjM3DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlh
bmcuaG91QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tDQo+IENjOiBsaW51eC1wY2lAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRl
dmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0K
PiByb2JoK2R0QGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7IG1hcmsucnV0bGFuZEBhcm0uY29t
Ow0KPiBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0K
PiBtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
Ow0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBhbmRyZXcubXVycmF5QGFybS5jb207IE1pbmdrYWkg
SHUNCj4gPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAu
Y29tPjsgWGlhb3dlaSBCYW8NCj4gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0h2OSAwMC8xMl0gUENJOiBSZWNvZGUgTW9iaXZlaWwgZHJpdmVyIGFuZCBhZGQgUENJ
ZSBHZW40DQo+IGRyaXZlciBmb3IgTlhQIExheWVyc2NhcGUgU29Dcw0KPiANCj4gSGkhDQo+IA0K
PiBPbiBUdWUsIE5vdiAxOSwgMjAxOSBhdCA3OjQ1IFBNIFoucS4gSG91IDx6aGlxaWFuZy5ob3VA
bnhwLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMgdG8gcmVjb2RlIHRoZSBNb2Jp
dmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llIHN1cHBvcnQNCj4gPiBmb3IgTlhQIExheWVyc2NhcGUg
c2VyaWVzIFNvQ3MgaW50ZWdyYXRlZCBNb2JpdmVpbCdzIFBDSWUgR2VuNA0KPiA+IGNvbnRyb2xs
ZXIuDQo+IA0KPiBDYW4gd2UgZ2V0IGEgcmVzcGluIGZvciB0aGlzIG9uIHRvcCBvZiB0aGUgNS41
IG1lcmdlIHdpbmRvdyBtYXRlcmlhbD8NCj4gR2l2ZW4gdGhhdCBpdCdzIGEgYnVuY2ggb2YgcmVm
YWN0b3JpbmdzLCBtYW55IG9mIHRoZW0gZG9uJ3QgYXBwbHkgb24gdG9wIG9mDQo+IHRoZSBtYXRl
cmlhbCB0aGF0IHdhcyBtZXJnZWQuDQo+IA0KPiBJJ2QgbG92ZSB0byBzZWUgdGhlc2UgZ28gaW4g
c29vbmVyIHJhdGhlciB0aGFuIGxhdGVyIHNvIEkgY2FuIHN0YXJ0IGdldHRpbmcgLW5leHQNCj4g
cnVubmluZyBvbiBsczIxNjBhIGhlcmUuDQo+IA0KPiANCj4gLU9sb2YNCg==
