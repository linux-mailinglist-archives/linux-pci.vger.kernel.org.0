Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD9A103789
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 11:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfKTKa6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Nov 2019 05:30:58 -0500
Received: from mail-eopbgr00059.outbound.protection.outlook.com ([40.107.0.59]:17634
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726001AbfKTKa5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 20 Nov 2019 05:30:57 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UIeXgTOQNem+OBQAgUs63R6yMLhylpV6u061aHdXDd1p6jqaPE8rIGPzczgeF4zFB2bpYfXiz24nYWr1opuRZIyVYi/gQV9kPfR/fhbmbD1YjvRxTUeuwvv+FYkaXulnMGbq00wgIIHSCd2sUfCap41aZiQHRRPWWwDzsfjUJTflKfx7Pf8LM/Wz/9aIMIU6UK/Ttva7LD2tIXAAN/9Iq2TCa3JI5O/KA1dmkNWz+I7CD+WqwCpSVwcMmAzl+H1HQqURRq+p4JB+Kcp4mcHW5DRlKyk7hoKAmfodau7coBigZF7hahIVrkDvl5KUeW7NOqU0zXCeHQktlyXq4vB95w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNb3nptkLxaCouVWOqqHRhMTjj4gy6DnWYjpMfmy4zU=;
 b=B4RlNxCnBP230H02uXTRRQE2hRFWQxN6LZqtd+0cK/O1HI4q3KfgvUV9Z4QRPlImOZEn0PCLgYmOpXlywIobgo2jtdyIqJeSKY5NMPBKIu46pfaQQojGxed9/NIbIcb1PD6q6/813iorst9UIStdMY9qKoZohdrPFGmqRyzgn//heMKbvp6Bscr3Ep7g7GSAbaqHDo/mDmnRYhxQQ+hz82UA5/uonlk85lMOWC1RoS+J+jKLMr6HskiVstabHvkEPwZmFsxMzi+qo9I216d1Rb/U8vqDpIlDapAVJM91bB5UaSZWumpU64ythgg2lhfYCHKFY9/zwsn5PchmhBD3QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNb3nptkLxaCouVWOqqHRhMTjj4gy6DnWYjpMfmy4zU=;
 b=PiUFPV/908XN2U6gpewQhj95STCoNhvzvwlyY6fS8n3sBtpQzG8s53dJHQa6k47D8MDFCgmty+7NssxN1KcdbTMe3GxBJleRR5VDqQoKeZ8EHIkSpBEqsfKQbBrDmeVtdy3hmGk/A/EWGutaLmvZvGUKo6x3P8mL5wYd9pZ75CU=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6683.eurprd04.prod.outlook.com (20.179.251.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.26; Wed, 20 Nov 2019 10:30:51 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.031; Wed, 20 Nov 2019
 10:30:51 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv9 00/12] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHVn1Tsfp+9ZVhNFU2th1+s/za9waeT0yyAgAAHlJA=
Date:   Wed, 20 Nov 2019 10:30:50 +0000
Message-ID: <DB8PR04MB67476281607788CD20B292D8844F0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120095729.GJ25745@shell.armlinux.org.uk>
In-Reply-To: <20191120095729.GJ25745@shell.armlinux.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8bf40b61-2a06-46be-9437-08d76da4b71a
x-ms-traffictypediagnostic: DB8PR04MB6683:|DB8PR04MB6683:
x-ms-exchange-purlcount: 1
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB668315F9C1B584C7EE750920844F0@DB8PR04MB6683.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(39860400002)(366004)(346002)(396003)(136003)(376002)(189003)(199004)(13464003)(316002)(99286004)(66066001)(54906003)(7736002)(478600001)(6246003)(305945005)(74316002)(26005)(186003)(55016002)(6306002)(9686003)(486006)(25786009)(476003)(86362001)(81156014)(81166006)(11346002)(446003)(4326008)(45080400002)(33656002)(7416002)(8936002)(8676002)(229853002)(66946007)(2906002)(966005)(52536014)(76116006)(14454004)(3846002)(256004)(6116002)(66476007)(66556008)(66446008)(64756008)(6916009)(5660300002)(6506007)(53546011)(102836004)(6436002)(71200400001)(71190400001)(76176011)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6683;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cFRUXBi5vX85b+PdBiKhU9t+EJmHyOR192z4FcjY5YpgwOy1zSsSQZ48lTxUeoB0HAT3MqvpJes5uRj4ZzFdB/QfTRfCXjkRhkniuDhgJcn+6EYsRQ61aPxKEw/PWRmXaLO/oXvX1cwLYCVmIp74ViZXgZRlco8yKzF/V8+8XEedVSb2+WApfMq3OT0sOWECftSlc2YNrSIoxjU6ld6bR7ulejWABhpzWFv52+yIn1WNcRN2/dRGJqvxzGoxZlGU0o1jfU/QcN1ChOqV630SCP9QtgQiPiKMvU8q4nQZgsD3OcBaDcuVSro/2jaVGmEUrvSEmsjIhHD1IWEO01V3EnQCmW5W5nUx6mWCJVpRAzuvcNK0Ly61BpMBM3OuXoFhER+eUW9U9U35XNhZcblgVNe/k97z0B95Pz7VuXCh0hhbnprTRpZloFnz7R2T8V/B
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bf40b61-2a06-46be-9437-08d76da4b71a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 10:30:50.8572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KYJlsi7YyT28TZxPHGtatAmjbnZew0l8U2Ycp7pk6Mi/V6OKurCgD8te1VS57BC7W0VsvZpwPBrqNt0qZzeF2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6683
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUnVzc2VsbCwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSdXNz
ZWxsIEtpbmcgLSBBUk0gTGludXggYWRtaW4gPGxpbnV4QGFybWxpbnV4Lm9yZy51az4NCj4gU2Vu
dDogMjAxOcTqMTHUwjIwyNUgMTc6NTcNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhw
LmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRA
a2VybmVsLm9yZzsgYXJuZEBhcm5kYi5kZTsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IGwuc3Vi
cmFobWFueWFAbW9iaXZlaWwuY28uaW47DQo+IHNoYXduZ3VvQGtlcm5lbC5vcmc7IG0ua2FydGhp
a2V5YW5AbW9iaXZlaWwuY28uaW47IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9y
ZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwu
ZGVhY29uQGFybS5jb207DQo+IGFuZHJldy5tdXJyYXlAYXJtLmNvbTsgTS5oLiBMaWFuIDxtaW5n
aHVhbi5saWFuQG54cC5jb20+OyBYaWFvd2VpDQo+IEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT47
IE1pbmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSHY5
IDAwLzEyXSBQQ0k6IFJlY29kZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llIEdlbjQNCj4g
ZHJpdmVyIGZvciBOWFAgTGF5ZXJzY2FwZSBTb0NzDQo+IA0KPiBPbiBXZWQsIE5vdiAyMCwgMjAx
OSBhdCAwMzo0NToxN0FNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhpcyBwYXRjaCBzZXQgaXMg
dG8gcmVjb2RlIHRoZSBNb2JpdmVpbCBkcml2ZXIgYW5kIGFkZCBQQ0llIHN1cHBvcnQNCj4gPiBm
b3IgTlhQIExheWVyc2NhcGUgc2VyaWVzIFNvQ3MgaW50ZWdyYXRlZCBNb2JpdmVpbCdzIFBDSWUg
R2VuNA0KPiA+IGNvbnRyb2xsZXIuDQo+IA0KPiBIb3cgbWFueSBQQ0llIGNhcmRzIGhhdmUgYmVl
biB0ZXN0ZWQgdG8gd29yay9kb24ndCB3b3JrIHdpdGggdGhpcz8NCj4gDQo+IEkgbmVlZDoNCj4g
DQo+IFBDSTogbW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGZpeCBTRXJyb3Igd2hlbiBhY2Nlc3Npbmcg
Y29uZmlnIHNwYWNlDQo+IFBDSTogbW9iaXZlaWw6IGxzX3BjaWVfZzQ6IGFkZCBXb3JrYXJvdW5k
IGZvciBBLTAxMTQ1MQ0KPiBQQ0k6IG1vYml2ZWlsOiBsc19wY2llX2c0OiBhZGQgV29ya2Fyb3Vu
ZCBmb3IgQS0wMTE1NzcNCj4gDQo+IHRvIHN1Y2Nlc3NmdWxseSBib290IHdpdGggYSBNZWxsYW5v
eCBjYXJkIHBsdWdnZWQgaW4gd2l0aCBhIHByZXZpb3VzIHJldmlzaW9uDQo+IG9mIHRoZXNlIHBh
dGNoZXMuDQo+DQoNClllcywgd2UgbmVlZCB0byBhcHBseSB0aGVzZSBOWFAgaW50ZXJuYWwgbWFp
bnRhaW5lZCB3b3JrYXJvdW5kcyBvbiB0b3Agb2YNCnRoaXMgc2VyaWVzLiBJIG9ubHkgdGVzdGVk
IEludGVsIGUxMDAwZSBOSUMgd2l0aCB0aGlzIHBhdGNoIHNldCArIHRoZXNlIDMNCndvcmthcm91
bmRzLg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KIA0KPiAtLQ0KPiBSTUsncyBQYXRjaCBzeXN0ZW06
DQo+IGh0dHBzOi8vZXVyMDEuc2FmZWxpbmtzLnByb3RlY3Rpb24ub3V0bG9vay5jb20vP3VybD1o
dHRwcyUzQSUyRiUyRnd3dw0KPiAuYXJtbGludXgub3JnLnVrJTJGZGV2ZWxvcGVyJTJGcGF0Y2hl
cyUyRiZhbXA7ZGF0YT0wMiU3QzAxJTdDemhpcQ0KPiBpYW5nLmhvdSU0MG54cC5jb20lN0M2OWY2
ZmIxZjRmZDQ0ZjNmY2EzODA4ZDc2ZGEwMTQ0MCU3QzY4NmVhMWQNCj4gM2JjMmI0YzZmYTkyY2Q5
OWM1YzMwMTYzNSU3QzAlN0MwJTdDNjM3MDk4NDA2NjA2NTAzMzYxJmFtcDtzZA0KPiBhdGE9d09M
V3pLZlpab2lQJTJGWnBUT3c1enI0ZW5wdU5JbXo0NVJNOEh5ODBhVWRJJTNEJmFtcDtyZXMNCj4g
ZXJ2ZWQ9MA0KPiBGVFRDIGJyb2FkYmFuZCBmb3IgMC44bWlsZSBsaW5lIGluIHN1YnVyYmlhOiBz
eW5jIGF0IDEyLjFNYnBzIGRvd24gNjIya2Jwcw0KPiB1cCBBY2NvcmRpbmcgdG8gc3BlZWR0ZXN0
Lm5ldDogMTEuOU1icHMgZG93biA1MDBrYnBzIHVwDQo=
