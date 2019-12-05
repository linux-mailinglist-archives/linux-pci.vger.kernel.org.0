Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6098113FEE
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2019 12:11:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729017AbfLELLS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Dec 2019 06:11:18 -0500
Received: from mail-eopbgr00071.outbound.protection.outlook.com ([40.107.0.71]:62631
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728735AbfLELLS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Dec 2019 06:11:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mp75BZ5mfUdXxpagSchxmnkcvHrIHv6euM10/NL4rWmLjNtIpwNWI+RWC3GQpisKmHNzc1IbfR7wGKmo1+eMqaSeHrOdcSIX9PgzhrDP9VqgUc1yXgvHsFRGhrcTbsxEUzeWZNcMS0gxaHy7pSKDnzhNECS7oCEl/Vg5JYvUVOQifY10Yie/FUXHdTCPPJyIY7vW1M2faVZsZn9x+3xu59QhjlqUYbdR2GCbuQLLsoJQiC/crSnxH3Dl1B2BRVAYtUGk1V+/VT4kHf7phBH/QQd1Zj26e/Keq17lRvg8UFoeqFO0khEcFcSBENB43OZif51ZagBrcW/prOGioOGZWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtAW2COMnfQW8Z9XCHCLRXFK1LDUjQCVknFr/ywWDR8=;
 b=iOC44E2BNZU7QKrHD5Y/u7g4ejS+++fXwSpxCP/s6E1XZDoTYtMfeyctn03MyrdiNk0Kikhssomg+NVSq0AnzVJnzBkxgNrXxJ3X7qTZM1wIWOX9/7kIrz9LUyPZ4fguuSUzbl7Lb+urM30jNmJgRR6seADHRAvU3V8ggOYUFn5o2SjC3IWaKOjtM3TDbE4eAK2nfhkNjd3cJXzxFDYPUPf7xhVo8I3bDtMiaREvI4EjPTuhhfo9GvmzHJvhjF5EPawMBNpp8MG4jfRwT84lXvaSg9YvFXC47w+2kakOzhbsMkM1qTRqWcw9Imam8a3LpSzUjVxX6BXNE+gZFSz1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZtAW2COMnfQW8Z9XCHCLRXFK1LDUjQCVknFr/ywWDR8=;
 b=s7/AAMCwb4l5BVnEKJVKliemNzsaP3TdM6XhUk7xl5f6l4up2nRMVprysRgrbh1U6HoFABR4cFmiB/5Z+sof47biDetXo3s3efJfT+UZADg7FxIvrG2aSGqCTnE+bwSrGKMnW+WK9GBBHguD4/7XDvg1ZhytMoSXTqu6m1ZFl6c=
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com (20.177.51.208) by
 VI1PR04MB5806.eurprd04.prod.outlook.com (20.178.204.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2516.12; Thu, 5 Dec 2019 11:11:09 +0000
Received: from VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::71d2:55b3:810d:c75b]) by VI1PR04MB5134.eurprd04.prod.outlook.com
 ([fe80::71d2:55b3:810d:c75b%7]) with mapi id 15.20.2495.026; Thu, 5 Dec 2019
 11:11:09 +0000
From:   Laurentiu Tudor <laurentiu.tudor@nxp.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Marc Zyngier <maz@kernel.org>
CC:     Roy Zang <roy.zang@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Diana Madalina Craciun <diana.craciun@nxp.com>
Subject: RE: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Topic: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Index: AQHVqP2u5HKRks3QXEmyFTQz0j+ob6emy2EAgADYg4CAAKoFgIAAOn2AgADd3QCAAfrtgA==
Date:   Thu, 5 Dec 2019 11:11:09 +0000
Message-ID: <VI1PR04MB5134A689AEA8C49BFC7F8356EC5C0@VI1PR04MB5134.eurprd04.prod.outlook.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
 <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <3dcdf44eb76390730658e3f4d932620c@www.loen.fr>
 <8f56c2d9-ab01-a91e-902f-a61def0e8ce8@arm.com>
 <AM5PR04MB3299BFC34A4666B7A9C12B13F55D0@AM5PR04MB3299.eurprd04.prod.outlook.com>
In-Reply-To: <AM5PR04MB3299BFC34A4666B7A9C12B13F55D0@AM5PR04MB3299.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=laurentiu.tudor@nxp.com; 
x-originating-ip: [212.146.100.6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 289ff90c-26b6-4907-47e4-08d77973d4db
x-ms-traffictypediagnostic: VI1PR04MB5806:|VI1PR04MB5806:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB58069B4F74567FF8E16FFA75EC5C0@VI1PR04MB5806.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02426D11FE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(13464003)(189003)(199004)(66556008)(66446008)(66476007)(52536014)(64756008)(14454004)(229853002)(11346002)(966005)(110136005)(478600001)(7416002)(76116006)(81166006)(81156014)(71200400001)(8936002)(8676002)(54906003)(26005)(44832011)(66946007)(2906002)(5660300002)(53546011)(74316002)(4326008)(7696005)(6506007)(99286004)(33656002)(25786009)(14444005)(186003)(55016002)(316002)(102836004)(86362001)(9686003)(71190400001)(305945005)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5806;H:VI1PR04MB5134.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2w1z2JaElDyLFCI6Jgv35lnaZIkBzWGMoDciwSL7KlwGp0r5aaerTb848GfJAJDK4CN1pUksffbjmr2ZT16xLxtFqADayDsQDJIjywxENwcAQTCYn+/0FUtfwVOF7PvGITpQE91qqWZmvzzb+bTG0+6MTOOcwaCcHKG88zvOEWp9VtfXN5NGIl6hL9ZYIsyQPva78PrJ2C2gGBDzJPIkUCcXSNEM1/rKwKEWUWvz9aRADXd5Hg+rwykfH1/unYbvVBgf4QbR3WBdAmx/197PfI4z9DMQ6S7W+TTeDgQZqDUxPwynS0gu7zNgXb7fxJdpvCdLhYtX9DX4osew7+R6OY2MkH7Rbg80nwIHTfRHRg5oROj2mn+odPHOigMULLxg76iPhkxIo8R0WYrBKK4VXW6aBAvPKbn6brDoXs5PEt5N1D/urY8E/IoomZlqg5cs4fLNVm3e5ZPaFJGEqm8Cd/YLnV10iGbDqcKo1yQICL8PEzoJcNz188a+xhgPsEm+k3JWFnePAOcTqFglzKXIAo2V/6sSIXsbpdmCCyPHjn8=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 289ff90c-26b6-4907-47e4-08d77973d4db
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2019 11:11:09.3906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtzKoychbfMkV6hhvDryh8xqY8mrdiIcqfmY6SSsZe8F+HutRfZgnfY6KYsQN6sYTTHWjovdm5iKbzFJ+IsSkw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5806
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgWGlhb3dlaSwNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBsaW51
eC1hcm0ta2VybmVsIDxsaW51eC1hcm0ta2VybmVsLWJvdW5jZXNAbGlzdHMuaW5mcmFkZWFkLm9y
Zz4gT24NCj4gQmVoYWxmIE9mIFhpYW93ZWkgQmFvDQo+IA0KPiA+IC0tLS0tT3JpZ2luYWwgTWVz
c2FnZS0tLS0tDQo+ID4gRnJvbTogUm9iaW4gTXVycGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT4N
Cj4gPiBTZW50OiAyMDE55bm0MTLmnIgz5pelIDIzOjIwDQo+ID4gVG86IE1hcmMgWnluZ2llciA8
bWF6QGtlcm5lbC5vcmc+OyBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gPiBD
YzogUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29t
Ow0KPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwu
b3JnOyBaLnEuIEhvdQ0KPiA+IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT47IGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc7IE0uaC4gTGlhbg0KPiA+IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBy
b2JoK2R0QGtlcm5lbC5vcmc7DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+IGFuZHJldy5tdXJyYXlAYXJtLmNvbTsgZnJv
d2FuZC5saXN0QGdtYWlsLmNvbTsgTWluZ2thaSBIdQ0KPiA+IDxtaW5na2FpLmh1QG54cC5jb20+
DQo+ID4gU3ViamVjdDogUmU6IFtQQVRDSF0gUENJOiBsYXllcnNjYXBlOiBBZGQgdGhlIFNSSU9W
IHN1cHBvcnQgaW4gaG9zdCBzaWRlDQo+ID4NCj4gPiBPbiAwMy8xMi8yMDE5IDExOjUxIGFtLCBN
YXJjIFp5bmdpZXIgd3JvdGU6DQo+ID4gPiBPbiAyMDE5LTEyLTAzIDAxOjQyLCBYaWFvd2VpIEJh
byB3cm90ZToNCj4gPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+Pj4gRnJv
bTogTWFyYyBaeW5naWVyIDxtYXpAbWlzdGVyam9uZXMub3JnPg0KPiA+ID4+PiBTZW50OiAyMDE5
5bm0MTLmnIgy5pelIDIwOjQ4DQo+ID4gPj4+IFRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9A
bnhwLmNvbT4NCj4gPiA+Pj4gQ2M6IHJvYmgrZHRAa2VybmVsLm9yZzsgZnJvd2FuZC5saXN0QGdt
YWlsLmNvbTsgTS5oLiBMaWFuDQo+ID4gPj4+IDxtaW5naHVhbi5saWFuQG54cC5jb20+OyBNaW5n
a2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBSb3kNCj4gPiBaYW5nDQo+ID4gPj4+IDxyb3ku
emFuZ0BueHAuY29tPjsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsNCj4gPiA+Pj4gYW5kcmV3
Lm11cnJheUBhcm0uY29tOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiA+ID4+PiBkZXZpY2V0cmVl
QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPiA+Pj4g
bGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRl
YWQub3JnOw0KPiA+ID4+PiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+ID4gPj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogbGF5ZXJzY2FwZTogQWRkIHRoZSBTUklPViBzdXBw
b3J0IGluIGhvc3QNCj4gPiA+Pj4gc2lkZQ0KPiA+ID4+Pg0KPiA+ID4+PiBPbiAyMDE5LTEyLTAy
IDEwOjQ1LCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gPiA+Pj4gPiBHSUMgZ2V0IHRoZSBtYXAgcmVs
YXRpb25zIG9mIGRldmlkIGFuZCBzdHJlYW0gaWQgZnJvbSB0aGUgbXNpLW1hcA0KPiA+ID4+PiA+
IHByb3BlcnR5IG9mIERUUywgb3VyIHBsYXRmb3JtIGFkZCB0aGlzIHByb3BlcnR5IGluIHUtYm9v
dCBiYXNlIG9uDQo+ID4gPj4+ID4gdGhlIFBDSWUgZGV2aWNlIGluIHRoZSBidXMsIGJ1dCBpZiBl
bmFibGUgdGhlIHZmIGRldmljZSBpbiBrZXJuZWwsDQo+ID4gPj4+ID4gdGhlIHZmIGRldmljZSBt
c2ktbWFwIHdpbGwgbm90IHNldCwgc28gdGhlIHZmIGRldmljZSBjYW4ndCB3b3JrLA0KPiA+ID4+
PiA+IHRoaXMgcGF0Y2ggcHVycG9zZSBpcyB0aGF0IG1hbmFnZSB0aGUgc3RyZWFtIGlkIGFuZCBk
ZXZpY2UgaWQgbWFwDQo+ID4gPj4+ID4gcmVsYXRpb25zIGR5bmFtaWNhbGx5IGluIGtlcm5lbCwg
YW5kIG1ha2UgdGhlIG5ldyBQQ0llIGRldmljZSB3b3JrDQo+IGluDQo+ID4ga2VybmVsLg0KPiA+
ID4+PiA+DQo+ID4gPj4+ID4gU2lnbmVkLW9mZi1ieTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFv
QG54cC5jb20+DQo+ID4gPj4+ID4gLS0tDQo+ID4gPj4+ID7CoCBkcml2ZXJzL29mL2lycS5jwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHzCoCA5
ICsrKw0KPiA+ID4+PiA+wqAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2Nh
cGUuYyB8IDk0DQo+ID4gPj4+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiA+
Pj4gPsKgIGRyaXZlcnMvcGNpL3Byb2JlLmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgfMKgIDYgKysNCj4gPiA+Pj4gPsKgIGRyaXZlcnMvcGNpL3JlbW92
ZS5jwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiAr
Kw0KPiA+ID4+PiA+wqAgNCBmaWxlcyBjaGFuZ2VkLCAxMTUgaW5zZXJ0aW9ucygrKQ0KPiA+ID4+
PiA+DQo+ID4gPj4+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvb2YvaXJxLmMgYi9kcml2ZXJzL29m
L2lycS5jIGluZGV4DQo+ID4gPj4+ID4gYTI5NmVhZi4uNzkxZTYwOSAxMDA2NDQNCj4gPiA+Pj4g
PiAtLS0gYS9kcml2ZXJzL29mL2lycS5jDQo+ID4gPj4+ID4gKysrIGIvZHJpdmVycy9vZi9pcnEu
Yw0KPiA+ID4+PiA+IEBAIC01NzYsNiArNTc2LDExIEBAIHZvaWQgX19pbml0IG9mX2lycV9pbml0
KGNvbnN0IHN0cnVjdA0KPiA+ID4+PiA+b2ZfZGV2aWNlX2lkDQo+ID4gPj4+ID4gKm1hdGNoZXMp
DQo+ID4gPj4+ID7CoMKgwqDCoMKgIH0NCj4gPiA+Pj4gPsKgIH0NCj4gPiA+Pj4gPg0KPiA+ID4+
PiA+ICt1MzIgX193ZWFrIGxzX3BjaWVfc3RyZWFtaWRfZml4KHN0cnVjdCBkZXZpY2UgKmRldiwg
dTMyIHJpZCkgew0KPiA+ID4+PiA+ICvCoMKgwqAgcmV0dXJuIHJpZDsNCj4gPiA+Pj4gPiArfQ0K
PiA+ID4+PiA+ICsNCj4gPiA+Pj4gPsKgIHN0YXRpYyB1MzIgX19vZl9tc2lfbWFwX3JpZChzdHJ1
Y3QgZGV2aWNlICpkZXYsIHN0cnVjdA0KPiA+ID4+PiA+ZGV2aWNlX25vZGUgICoqbnAsDQo+ID4g
Pj4+ID7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHUzMiByaWRfaW4pDQo+ID4g
Pj4+ID7CoCB7DQo+ID4gPj4+ID4gQEAgLTU5MCw2ICs1OTUsMTAgQEAgc3RhdGljIHUzMiBfX29m
X21zaV9tYXBfcmlkKHN0cnVjdCBkZXZpY2UNCj4gPiA+Pj4gPipkZXYsICBzdHJ1Y3QgZGV2aWNl
X25vZGUgKipucCwNCj4gPiA+Pj4gPsKgwqDCoMKgwqDCoMKgwqDCoCBpZiAoIW9mX21hcF9yaWQo
cGFyZW50X2Rldi0+b2Zfbm9kZSwgcmlkX2luLCAibXNpLW1hcCIsDQo+ID4gPj4+ID7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtc2ktbWFwLW1hc2siLCBucCwgJnJpZF9vdXQp
KQ0KPiA+ID4+PiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQo+ID4gPj4+ID4g
Kw0KPiA+ID4+PiA+ICvCoMKgwqAgaWYgKHJpZF9vdXQgPT0gcmlkX2luKQ0KPiA+ID4+PiA+ICvC
oMKgwqDCoMKgwqDCoCByaWRfb3V0ID0gbHNfcGNpZV9zdHJlYW1pZF9maXgocGFyZW50X2Rldiwg
cmlkX2luKTsNCj4gPiA+Pj4NCj4gPiA+Pj4gT3ZlciBteSBkZWFkIGJvZHkuIEdldCB5b3VyIGZp
cm13YXJlIHRvIHByb3Blcmx5IHByb2dyYW0gdGhlIExVVCBzbw0KPiA+ID4+PiB0aGF0IGl0IHBy
ZXNlbnRzIHRoZSBJVFMgd2l0aCBhIHJlYXNvbmFibGUgdG9wb2xvZ3kuIFRoZXJlIGlzDQo+ID4g
Pj4+IGFic29sdXRlbHkgbm8gd2F5IHRoaXMga2luZCBvZiBjaGFuZ2UgbWFrZXMgaXQgaW50byB0
aGUga2VybmVsLg0KPiA+ID4+DQo+ID4gPj4gU29ycnkgZm9yIHRoaXMsIEkga25vdyBpdCBpcyBu
b3QgcmVhc29uYWJsZSwgYnV0IEkgaGF2ZSBubyBvdGhlciB3YXksDQo+ID4gPj4gYXMgSSBrbm93
LCBBUk0gZ2V0IHRoZSBtYXBwaW5nIG9mIHN0cmVhbSBJRCB0byByZXF1ZXN0IElEIGZyb20gdGhl
DQo+ID4gPj4gbXNpLW1hcCBwcm9wZXJ0eSBvZiBEVFMsIGlmIGFkZCBhIG5ldyBkZXZpY2Ugd2hp
Y2ggbmVlZCB0aGUgc3RyZWFtIElEDQo+ID4gPj4gYW5kIHRyeSB0byBnZXQgaXQgZnJvbSB0aGUg
bXNpLW1hcCBvZiBEVFMsIGl0IHdpbGwgZmFpbGVkIGFuZCBub3QNCj4gPiA+PiB3b3JrLCB5ZXM/
IFNvIGNvdWxkIHlvdSBnaXZlIG1lIGEgYmV0dGVyIGFkdmljZSB0byBmaXggdGhpcyBpc3N1ZSwg
SQ0KPiA+ID4+IHdvdWxkIHJlYWxseSBhcHByZWNpYXRlIGFueSBjb21tZW50cyBvciBzdWdnZXN0
aW9ucywgdGhhbmtzIGEgbG90Lg0KPiA+ID4NCj4gPiA+IFdoeSBjYW4ndCBmaXJtd2FyZSBleHBv
c2UgYW4gbXNpLW1hcC9tc2ktbWFwLW1hc2sgdGhhdCBoYXMgYSBsYXJnZQ0KPiA+ID4gZW5vdWdo
IHJhbmdlIHRvIGVuc3VyZSBtYXBwaW5nIG9mIFZGcz8gV2hhdCBhcmUgdGhlIGxpbWl0YXRpb25z
IG9mIHRoZQ0KPiA+ID4gTFVUIHRoYXQgd291bGQgcHJldmVudCB0aGlzIGZyb20gYmVpbmcgY29u
ZmlndXJlZCBiZWZvcmUgdGhlIGtlcm5lbA0KPiA+ID4gYm9vdHM/DQo+IA0KPiBUaGFua3MgZm9y
IHlvdXIgY29tbWVudHMsIHllcywgdGhpcyBpcyB0aGUgcm9vdCBjYXVzZSwgd2Ugb25seSBoYXZl
IDE2DQo+IHN0cmVhbQ0KPiBJRHMgZm9yIFBDSWUgZG9tYWluLCB0aGlzIGlzIHRoZSBoYXJkd2Fy
ZSBsaW1pdGF0aW9uLCBpZiB0aGVyZSBoYXZlIGVub3VnaA0KPiBzdHJlYW0NCj4gSURzLCB3ZSBj
YW4gZXhwb3NlIGFuIG1zaS1tYXAvbXNpLW1hcC1tYXNrIGZvciBhbGwgUENJZSBkZXZpY2VzIGlu
IHN5c3RlbSwNCj4gdW5mb3J0dW5hdGVseSwgdGhlIHN0cmVhbSBJRHMgaXMgbm90IGVub3VnaCwg
SSB0aGluayBvdGhlciBBUk0gdmVuZG9yIGhhdmUNCj4gc2FtZQ0KPiBpc3N1ZSB0aGF0IHRoZXkg
ZG9uJ3QgaGF2ZSBlbm91Z2ggc3RyZWFtIElEcy4NCj4gDQo+IFRoYW5rcw0KPiBYaWFvd2VpDQo+
IA0KPiA+DQo+ID4gRnVydGhlcm1vcmUsIG5vdGUgdGhhdCB0aGlzIGF0dGVtcHQgaXNuJ3QgZG9p
bmcgYW55dGhpbmcgZm9yIHRoZSBTTU1VDQo+ID4gU3RyZWFtIElEcywgc28gdGhlIG1vbWVudCBh
bnlvbmUgdHJpZXMgdG8gYXNzaWduIHRob3NlIFZGcyB0aGV5J3JlIHN0aWxsDQo+IGdvaW5nDQo+
ID4gdG8gZ28gYmFuZyBhbnl3YXkuIEFueSBmaXJtd2FyZS1iYXNlZCBmaXh1cCBmb3IgSUQgbWFw
cGluZ3MsIGNvbmZpZw0KPiBzcGFjZQ0KPiA+IGFkZHJlc3NlcywgZXRjLiBuZWVkcyB0byBiZSBT
Ui1JT1YtYXdhcmUgYW5kIGFjY291bnQgZm9yIGFsbCAqcG9zc2libGUqDQo+ID4gQkRGcy4NCj4g
Pg0KPiA+IE9uIExTMjA4NSBhdCBsZWFzdCwgSUlSQyB5b3UgY2FuIGNvbmZpZ3VyZSBhIHNpbmds
ZSBMVVQgZW50cnkgdG8ganVzdA0KPiB0cmFuc2xhdGUNCj4gPiB0aGUgQnVzOkRldmljZSBpZGVu
dGlmaWVyIGFuZCBwYXNzIHNvbWUgb3IgYWxsIG9mIHRoZSBGdW5jdGlvbiBiaXRzDQo+IHN0cmFp
Z2h0DQo+ID4gdGhyb3VnaCBhcyB0aGUgTFNCcyBvZiB0aGUgU3RyZWFtIElELCBzbyBJIGRvbid0
IGJlbGlldmUgdGhlIHJlbGF0aXZlbHkNCj4gbGltaXRlZA0KPiA+IG51bWJlciBvZiBMVVQgcmVn
aXN0ZXJzIHNob3VsZCBiZSB0b28gbXVjaCBvZiBhbiBpc3N1ZS4gRm9yIGV4YW1wbGUsDQo+IGxh
c3QNCj4gPiB0aW1lIEkgaGFja2VkIG9uIHRoYXQgSSBhcHBhcmVudGx5IGhhZCBpdCBzZXQgdXAg
c3RhdGljYWxseSBsaWtlIHRoaXM6DQo+ID4NCj4gPiAmcGNpZTMgew0KPiA+IAkvKiBTcXVhc2gg
ODo1OjMgQkRGIGRvd24gdG8gMjoyOjMgKi8NCj4gPiAJbXNpLW1hcC1tYXNrID0gPDB4MDMxZj47
DQo+ID4gCW1zaS1tYXAgPSA8MHgwMDAgJml0cyAweDAwIDB4MjA+LA0KPiA+IAkJICA8MHgxMDAg
Jml0cyAweDIwIDB4MjA+LA0KPiA+IAkJICA8MHgyMDAgJml0cyAweDQwIDB4MjA+LA0KPiA+IAkJ
ICA8MHgzMDAgJml0cyAweDYwIDB4MjA+Ow0KPiA+IH07DQo+IA0KPiBUaGFua3MgUm9iaW4sIHRo
aXMgaXMgYSBlZmZlY3RpdmUgd2F5LCBidXQgd2Ugb25seSBoYXZlIHRvdGFsIDE2IHN0cmVhbQ0K
PiBJRHMgZm9yIFBDSWUgZG9tYWluLA0KPiBhbmQgb25seSBhc3NpZ24gNCBzdHJlYW0gSURzIGZv
ciBlYWNoIFBDSWUgY29udHJvbGxlciBpZiB0aGUgYm9hcmQgaGF2ZSA0DQo+IFBDSWUgY29udHJv
bGxlcnMsDQo+IHRoaXMgaXMgdGhlIHJvb3QgY2F1c2UsIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2gg
dG8gZHluYW1pY2FsbHkgbWFuYWdlIHRoZXNlDQo+IHN0cmVhbSBJRHMsDQo+IHNvIHRoYXQgaXQg
bG9va3MgbGlrZSBlYWNoIFBDSWUgY29udHJvbGxlciBoYXMgMTYgc3RyZWFtIElEcy4gSSBjYW4N
Cj4gZHluYW1pY2FsbHkgYWxsb2NhdGUgYW5kDQo+IHJlbGVhc2UgdGhlc2Ugc3RyZWFtIElEcyBi
YXNlZCBvbiB0aGUgUENJZSBkZXZpY2VzIGluIHRoZSBjdXJyZW50IHN5c3RlbS4NCj4gSWYgdXNl
IHlvdXIgbWV0aG9kLA0KPiB3ZSBzdXBwb3J0IHVwIHRvIDQgUENJZSBkZXZpY2VzKDIgUEZzIGFu
ZCAyIFZGcyksIGl0IHdpbGwgbm90IGFjaGlldmUgb3VyDQo+IHB1cnBvc2UuDQo+IA0KDQpXZSBh
bGxvY2F0ZSB0aGUgU3RyZWFtX0lEcyBpbiBhIHN0YXRpYyBmYXNoaW9uIGluIHUtYm9vdCwgc2Vl
IFsxXSwgc28gaWYgYSB1c2VyIHdvdWxkIG5lZWQgYSBsYXJnZXIgcmFuZ2UgZm9yIFBDSSB7c31o
ZSBjb3VsZCBhZGp1c3QgdGhhdCBpbiB0aGVyZS4gT24gbW9zdCBvZiBvdXIgTGF5ZXJzY2FwZSBj
aGlwcyB0aGUgU01NVSBpcyBjb25maWd1cmVkIHRvIDUgYml0cyBmb3IgVEJVX0lEIHBsdXMgMTAg
Yml0cyBmb3IgU3RyZWFtSUQuIE91dCBvZiB0aGVzZSAxMCBjb250cm9sbGFibGUgYml0cyB3ZSBj
YW4gZWZmZWN0aXZlbHkgdXNlIDcgYml0cyBnaXZpbmcgdXMgYSBtYXggcmFuZ2Ugb2YgMTI3IFN0
cmVhbV9JRHMuDQoNClsxXSBodHRwczovL2dpdGxhYi5kZW54LmRlL3UtYm9vdC91LWJvb3QvYmxv
Yi9tYXN0ZXIvYXJjaC9hcm0vaW5jbHVkZS9hc20vYXJjaC1mc2wtbGF5ZXJzY2FwZS9zdHJlYW1f
aWRfbHNjaDMuaA0KDQotLS0NCkJlc3QgUmVnYXJkcywgTGF1cmVudGl1DQo=
