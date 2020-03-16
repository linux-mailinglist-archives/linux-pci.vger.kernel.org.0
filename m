Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89591186C54
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 14:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731361AbgCPNlu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 09:41:50 -0400
Received: from mail-am6eur05on2044.outbound.protection.outlook.com ([40.107.22.44]:18017
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730970AbgCPNlu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Mar 2020 09:41:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c3oD7wqXWfQQLDX+fVDLuHxfrqrn0mqkgAHSfbiGTyyqf2fSBYXBV668aDlNOUwu8TskCfrjkPFLJX8bD7tk7U7QuDZ4t3u7TZe1EA2Vl9wpXL0hsHb7F/UZRkaxmQ2FagJp4UorWi5jkDpFPCemjHovp8PXwsWUB385mWgdEzf7SnLSisLIyQwQx+lgtG8W3kHo8McDvEIxPXQvhP2kFW2IuIgyTp01snPZ6GYCnql3xQPv6E7q4RFc33ooOxSxVaVlWC9je4dCqrM6pEFn+ZEFpr5U+6pIN0sVI9UIAOUoMp650KaVn9pXwolGcb1RXtS2jRsoiR253SylGktv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCYqdhKEA4z+tUCXCQP2txJovL/BbC1aGBqu9lyC+WQ=;
 b=PfVtpx9AR8ejGsQ5rOtadN538DGJerkqR7VPg7TMQeBbzy10cgcqzMkkO6yhkvBVrizKE76ZUXZqQ4QPlb5YUpK24k2N9pFOnP8AtjzPW7BTFQ1vYhv+l7fxasMO6sfRtR3Dv+8y0mHj81o3y4/E+y/9BGXgNLr92Yl3mEgr5ZaHBf+aPhOk3GVZ+Y2uqlRnrXiKKvsIO69px8Cei7bYrGJsYAokemg7Qzj1mgcQ6/uTjDNHpV5+HgzT0z1d0ETjeyRhMYyC9+mFAbeb8Xt950YZbXtLabxZ2XgvjgHdMd3/mczeadd6H2KeVyoaErUmRuv7+D9tDj+GaWa1/9IV7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QCYqdhKEA4z+tUCXCQP2txJovL/BbC1aGBqu9lyC+WQ=;
 b=mVEsSUph+V7YaIykHDJkR2U6HdUy3mEnDSerHh3SAhvbgBRuttEp/MOwSLG86Tq5cXxgHdJwE+iBcZ51n8KJf+w/cDF5Hz3wsWzyLGEwRGVF+95Q23mUj5npR9dPwjN1H8j7KDDfn+7R+C3+VG/2Dr+DdfdqmLnt5tG+8npGyGk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7050.eurprd04.prod.outlook.com (52.135.62.24) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.18; Mon, 16 Mar 2020 13:41:34 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::4528:6120:94a4:ce1e%5]) with mapi id 15.20.2814.016; Mon, 16 Mar 2020
 13:41:34 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Joe Perches <joe@perches.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4
Thread-Topic: [PATCH] MAINTAINERS: correct typo in new NXP LAYERSCAPE GEN4
Thread-Index: AQHV+gyIX68iXFnIKEaIIhxR91lGSKhLPECg
Date:   Mon, 16 Mar 2020 13:41:34 +0000
Message-ID: <DB8PR04MB6747C64A930F240215A3FA8784F90@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200314142559.13505-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20200314142559.13505-1-lukas.bulwahn@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [223.72.48.36]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7c99bfe5-df19-4eea-faf8-08d7c9afbe12
x-ms-traffictypediagnostic: DB8PR04MB7050:
x-microsoft-antispam-prvs: <DB8PR04MB7050CF1E56E39EBDCC3271AC84F90@DB8PR04MB7050.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 03449D5DD1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(199004)(76116006)(66556008)(66476007)(71200400001)(8676002)(2906002)(64756008)(66446008)(81166006)(81156014)(66946007)(53546011)(6506007)(55016002)(9686003)(54906003)(5660300002)(110136005)(478600001)(316002)(33656002)(8936002)(4326008)(86362001)(26005)(186003)(52536014)(7696005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7050;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJl50Ebo2w/lQAEobCfUrRFVmuD3AhnC93TXmEbizpzG0Tn1ulIKxKMjtyE6nu/D12Wd8Iim5ooPXFx0WAQcRawTocN6YGVVhlInuW08UlPFcATukT8Yui1Tw1dAr4/9AMQEa9t7C40QtgfAQ+xQVVC6uS1syye1w6trzJxPJfB5R/8Sh6hhOpMNtFluPn8lbZq7JHv97I3eZQD/672Nhp1sYb10/K+OHuegSvj3KC1wxqVtem82u2lJbxrnjblbUOQjFNBVpvtxS4Mn2Yvu2ijx448Hv5UNKIGSPmhoLip0C0myrPa+KXb8upQKeeAvIanMM+7O70JZLM2iV7XILX4taWu7/gaKNCN93gLN4QAYGVQX7xIxS9ntWW/v8Iz3gu61iW4kUfxAOhmbu9VE/UC9ai+cJSp5oOwxmMYczyUa3VMVj+h+p1nK6SeZcq0j
x-ms-exchange-antispam-messagedata: bEpwUAUVZ6aaSN807ij42hGeLXI+8aERrivE8ZazGS7LizKPYnh2v1YehCLtB3RCtKco+KhmfdV0z4Ll3ZxQjR//GAlFfpYQNqacrLeflz138QV3LwqcPqXNoUZ6ewWh+Ol934IV7OqPemG+gj1pcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c99bfe5-df19-4eea-faf8-08d7c9afbe12
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2020 13:41:34.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tz4HA3Zhbkwb5ov/0WoBtcaPAT2l32qJApvH0WAniY9wKVqrmn0NYj8FP8eDMCx5ZIV8qinhUOim8/J3lwZSHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7050
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEx1a2FzIEJ1bHdhaG4gPGx1
a2FzLmJ1bHdhaG5AZ21haWwuY29tPg0KPiBTZW50OiAyMDIwxOoz1MIxNMjVIDIyOjI2DQo+IFRv
OiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA8
bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IFJvYiBIZXJyaW5nIDxyb2JoQGtlcm5lbC5vcmc+
DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmc7IEpvZQ0KPiBQZXJjaGVzIDxqb2VAcGVyY2hlcy5jb20+OyBrZXJuZWwt
amFuaXRvcnNAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
OyBMdWthcyBCdWx3YWhuIDxsdWthcy5idWx3YWhuQGdtYWlsLmNvbT4NCj4gU3ViamVjdDogW1BB
VENIXSBNQUlOVEFJTkVSUzogY29ycmVjdCB0eXBvIGluIG5ldyBOWFAgTEFZRVJTQ0FQRSBHRU40
DQo+IA0KPiBDb21taXQgM2VkZWI0OTUyNWJiICgiZHQtYmluZGluZ3M6IFBDSTogQWRkIE5YUCBM
YXllcnNjYXBlIFNvQ3MgUENJZQ0KPiBHZW40DQo+IGNvbnRyb2xsZXIiKSBpbmNsdWRlcyBhIG5l
dyBlbnRyeSBpbiBNQUlOVEFJTkVSUywgYnV0IHNsaXBwZWQgaW4gYSB0eXBvIGluIG9uZQ0KPiBv
ZiB0aGUgZmlsZSBlbnRyaWVzLg0KPiANCj4gSGVuY2UsIHNpbmNlIHRoZW4sIC4vc2NyaXB0cy9n
ZXRfbWFpbnRhaW5lci5wbCAtLXNlbGYtdGVzdCBjb21wbGFpbnM6DQo+IA0KPiAgIHdhcm5pbmc6
IG5vIGZpbGUgbWF0Y2hlcyBGOiBcDQo+ICAgICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYmli
ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMNCj4gDQo+IENvcnJlY3QgdGhlIHR5cG8gaW4gUENJ
IERSSVZFUiBGT1IgTlhQIExBWUVSU0NBUEUgR0VONCBDT05UUk9MTEVSLg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogTHVrYXMgQnVsd2FobiA8bHVrYXMuYnVsd2FobkBnbWFpbC5jb20+DQo+IC0tLQ0K
PiBhcHBsaWVzIGNsZWFubHkgb24gbmV4dC0yMDIwMDMxMw0KPiANCj4gSG91LCBwbGVhc2UgYWNr
Lg0KPiBSb2IsIHBsZWFzZSBwaWNrIHRoaXMgcGF0Y2ggKGl0IGlzIG5vdCB1cmdlbnQsIHRob3Vn
aCkuDQo+IA0KPiAgTUFJTlRBSU5FUlMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9NQUlOVEFJTkVSUyBi
L01BSU5UQUlORVJTDQo+IGluZGV4IDMyYTk1ZDE2MmYwNi4uNzdlZWRlOTc2ZDBmIDEwMDY0NA0K
PiAtLS0gYS9NQUlOVEFJTkVSUw0KPiArKysgYi9NQUlOVEFJTkVSUw0KPiBAQCAtMTI4NTgsNyAr
MTI4NTgsNyBAQCBMOglsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnDQo+ICBMOglsaW51eC1hcm0t
a2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcNCj4gIFM6CU1haW50YWluZWQNCj4gIEY6CURvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0
DQo+IC1GOglkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYmliZWlsL3BjaWUtbGF5ZXJzY2FwZS1n
ZW40LmMNCj4gK0Y6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1sYXllcnNj
YXBlLWdlbjQuYw0KPiANCj4gIFBDSSBEUklWRVIgRk9SIEdFTkVSSUMgT0YgSE9TVFMNCj4gIE06
CVdpbGwgRGVhY29uIDx3aWxsQGtlcm5lbC5vcmc+DQo+IA0KPiBiYXNlLWNvbW1pdDogMmU2MDJk
YjcyOTk0OGNlNTc3YmYwN2UyYjExM2YyYWE4MDZiNjJjNw0KPiAtLQ0KPiAyLjE3LjENCg0KUmV2
aWV3ZWQtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQoNCg==
