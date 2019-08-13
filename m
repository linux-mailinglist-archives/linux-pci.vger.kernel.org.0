Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B847C8AD09
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 05:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbfHMDNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 23:13:10 -0400
Received: from mail-eopbgr70070.outbound.protection.outlook.com ([40.107.7.70]:18087
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfHMDNJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 23:13:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SaEDhzsZL6ZMgsSA7QJtpvL5ac33FDApE5REQdmhRXwqlFOhh3RHFQS/9yMWlg6u4Uu8QlXZdQOSaMJwqnp/p+URixfM1U2PA8Xc3I5HeU8yUUCzc/QGY4ybEIbX0mvA+NVlAStvDd/YdHkpWAWqNmG9iWmaBozojWWEj2eHgOag0jIsl2NH441dPW7CePy9i9F8lw7jg+8Ln+KFdHU1ZAzH3bqoeDOZnDA+tWMKjw2D+bMG/vSnpu+iu11b0d1AWuqUdR6K3/0X2UxSvjgMBZvpzQrXTz0w3LwnnNZy19vAt8+HdIMN/4IxkhbPVi1jJrLGYdLvVr9jJTkwHQFNcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhtqmBUdjz8wRrla1jKk4FSCf3GMfZ1Lehe5C3W0wfU=;
 b=A7eN0GO6IGMcG3w/5lG6UWqomGenELFC5prGDzwZQ9L0joV4SZ2hnDcYWXa3Zm5DztKX/+tMS7DwozD/Z40oOeqte1ep6hEPfGc6B5v75P4d9PNmQOptSzM2w2jfSII1vE5YAaqpWC85v+dZvkvCu6YvDHQpVNOrswOHATIaOQjkIqWuKhxwnQpYTWAchQpvrERvAoz7wtt+mTmLjxHpCu/NtvwhTD37gtR+NqOyQOXAxJOHVQPyxTJ6M+eH/cVx0lM7C3QZAky9buQAxg11FuKENv64HNWOJ8zUrUqBnniQZWvvpzinoRRu+RdLCPMHCSbC6u1GKLd42Uw//lZ3LQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zhtqmBUdjz8wRrla1jKk4FSCf3GMfZ1Lehe5C3W0wfU=;
 b=PUDOTNUPhl6j+LqRc8BenJHuLFNK7m38Fgy4fKKzTm+svquSsgEh6O+6AWlg+RSbpyiZOGXFkZjGWth6IicB5kKC0cPB4dAB2s/rwTih51c2QDSEZWzpSEfK4Te8hL+Oc245RaByKAGHdY8Li4UL78m6Hccm9PvTuhKWWQT2PWE=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6585.eurprd04.prod.outlook.com (20.179.248.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 03:13:04 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 03:13:04 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 2/4] PCI: dwc: Return directly when num-lanes is not found
Thread-Topic: [PATCH 2/4] PCI: dwc: Return directly when num-lanes is not
 found
Thread-Index: AQHVUMWJYdzIy46VokSNj8ZzDl4Znqb3L+WAgAE4QbA=
Date:   Tue, 13 Aug 2019 03:13:04 +0000
Message-ID: <DB8PR04MB6747A573EA7F658C1F1CFAA784D20@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-3-Zhiqiang.Hou@nxp.com>
 <20190812083412.GT56241@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190812083412.GT56241@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4ba569ac-81d0-4970-c2bc-08d71f9c2819
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6585;
x-ms-traffictypediagnostic: DB8PR04MB6585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6585DEA8DFABEA5066E59AB484D20@DB8PR04MB6585.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(13464003)(189003)(199004)(6246003)(81156014)(86362001)(66066001)(7416002)(8936002)(478600001)(52536014)(26005)(446003)(76176011)(2906002)(6116002)(8676002)(6506007)(53546011)(186003)(4326008)(3846002)(476003)(81166006)(53936002)(102836004)(25786009)(486006)(7696005)(11346002)(33656002)(7736002)(99286004)(66446008)(305945005)(74316002)(64756008)(55016002)(71200400001)(66556008)(66476007)(256004)(14454004)(76116006)(54906003)(66946007)(71190400001)(6916009)(229853002)(9686003)(5660300002)(6436002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6585;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pMRHY+Q2v/m8s+P0YgOsQBmePH6TOjyhfX/UK9BSuHDkxsM6SflHKGrmdSoRupeWWVJnqZ95wepvEeb0g7Q51yGZOJ8qRjqqOKpuGovEh/uxRyhnCUEYRBx6S4NBTMsjvVSCjS/Y39cCWGrcy5f41TquwkLFlAGcUacUgQ7ujm33BlaH+n8jvDMaczAJLYbCqih11fQGYJC6bIDLGiVlAgVPMa39kmN0fhAgio183fUGQ6xC/YM99tX2CT00l+IgyLj+sSt1j3jXLdVHEdTMH5X7DNNAT5Qj5c9ExydQciwr3Wc/rgDCKOtBK2c/XNGpbPdRSklKBMV/05N58TVo3HWDvFmPPk6oZzI9htlgrR+pq4QvQubFpGxHsTYe4yJt4E8MDok/xsKn4xpVimjgsuP5MX8Q4ciBxL/7+jn2ttU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ba569ac-81d0-4970-c2bc-08d71f9c2819
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 03:13:04.3251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KhiefFwvBppkvd9s9ywPI84C6srC7RN0Oak4I0P90Rs3VCcExiq4vslPe9tl94HdvJISI1Z2b4ejSF4POMM+pg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6585
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpCLlIsDQpaaGlx
aWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBNdXJy
YXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4NCj4gU2VudDogMjAxOcTqONTCMTLI1SAxNjozNA0K
PiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tOw0KPiBqaW5n
b29oYW4xQGdtYWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3Jn
Ow0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+
IDxsZW95YW5nLmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBNLmguIExp
YW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzRd
IFBDSTogZHdjOiBSZXR1cm4gZGlyZWN0bHkgd2hlbiBudW0tbGFuZXMgaXMgbm90DQo+IGZvdW5k
DQo+IA0KPiBPbiBNb24sIEF1ZyAxMiwgMjAxOSBhdCAwNDoyMjoyMkFNICswMDAwLCBaLnEuIEhv
dSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0K
PiA+DQo+ID4gVGhlIG51bS1sYW5lcyBpcyBvcHRpb25hbCwgc28gcHJvYmFibHkgaXQgaXNuJ3Qg
YWRkZWQgb24gc29tZQ0KPiA+IHBsYXRmb3Jtcy4gVGhlIHN1YnNlcXVlbnQgcHJvZ3JhbW1pbmcg
aXMgYmFzZSBvbiB0aGUgbnVtLWxhbmVzLCBoZW5jZQ0KPiA+IHJldHVybiB3aGVuIGl0IGlzIG5v
dCBmb3VuZC4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcu
SG91QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jIHwgNiArKysrLS0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMNCj4gPiBpbmRleCA3ZDI1MTAyYzMwNGMuLjBh
ODliZmQxNjM2ZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLWRlc2lnbndhcmUuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3Bj
aWUtZGVzaWdud2FyZS5jDQo+ID4gQEAgLTQyMyw4ICs0MjMsMTAgQEAgdm9pZCBkd19wY2llX3Nl
dHVwKHN0cnVjdCBkd19wY2llICpwY2kpDQo+ID4NCj4gPg0KPiA+ICAJcmV0ID0gb2ZfcHJvcGVy
dHlfcmVhZF91MzIobnAsICJudW0tbGFuZXMiLCAmbGFuZXMpOw0KPiA+IC0JaWYgKHJldCkNCj4g
PiAtCQlsYW5lcyA9IDA7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2RiZyhwY2ktPmRl
diwgInByb3BlcnR5IG51bS1sYW5lcyBpc24ndCBmb3VuZFxuIik7DQo+ID4gKwkJcmV0dXJuOw0K
PiA+ICsJfQ0KPiANCj4gVGhlIGV4aXN0aW5nIGNvZGUgd291bGQgYXNzaWduIGEgdmFsdWUgb2Yg
MCB0byBsYW5lcyB3aGVuIG51bS1sYW5lcyBpc24ndA0KPiBzcGVjaWZpZWQsIGhvd2V2ZXIgdGhp
cyB2YWx1ZSBpc24ndCBzdXBwb3J0ZWQgYnkgdGhlIGZvbGxvd2luZyBzd2l0Y2gNCj4gc3RhdGVt
ZW50IC0gdGh1cyB3ZSdkIGFsc28gcHJpbnQgYW4gZXJyb3IgYW5kIHJldHVybi4NCj4gDQo+IFRo
ZXJlZm9yZSB0aGUgb25seSBhbmQgc3VidGxlIGVmZmVjdCBlZmZlY3Qgb2YgdGhpcyBwYXRjaCBp
cyB0byBjaGFuZ2UgYQ0KPiBkZXZfZXJyIHRvIGEgZGV2X2RiZyB3aGVuIG51bS1sYW5lcyBpc24n
dCBzcGVjaWZpZWQgYW5kIGF2b2lkIGEgcmVhZCBvZg0KPiBQQ0lFX1BPUlRfTElOS19DT05UUk9M
Lg0KPiANCj4gR2l2ZW4gdGhhdCBudW0tbGFuZXMgaXMgZGVzY3JpYmVkIGFzIG9wdGlvbmFsIHRo
aXMgbWFrZXMgcGVyZmVjdCBzZW5zZS4NCj4gVGhvdWdoIHRoZSBjb21taXQgbWVzc2FnZS9odW5r
IGRvZXMgZ2l2ZSB0aGUgYXBwZXJhbmNlIHRoYXQgdGhpcw0KPiBwcm92aWRlcyBhIG1vcmUgZnVu
Y3Rpb25hbCBjaGFuZ2UuDQo+IA0KPiBBbnl3YXk6DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3
IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPg0KPiANCj4gDQo+ID4NCj4gPiAgCS8qIFNl
dCB0aGUgbnVtYmVyIG9mIGxhbmVzICovDQo+ID4gIAl2YWwgPSBkd19wY2llX3JlYWRsX2RiaShw
Y2ksIFBDSUVfUE9SVF9MSU5LX0NPTlRST0wpOw0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
