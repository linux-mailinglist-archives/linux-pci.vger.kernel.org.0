Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5F52AD7067
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 09:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728111AbfJOHqz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 03:46:55 -0400
Received: from mail-eopbgr80051.outbound.protection.outlook.com ([40.107.8.51]:43488
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727282AbfJOHqz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 03:46:55 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lV4hJahYRjn0KF4DmqpDy20L+n7zgSopQkEx20dvfywXEV5y2KeUPTWzz/sWqG8Fh9DRnNaD02y4NsYPiArLLDDo/plV/WYB6yTJQVA/J4kifg9p3JyD+ieBqdtKPbPuvwLIAumZyLSodXHVCB9PgzQx+HKjjjmHoRJ9rT9aoN4oatyQAR65X9q8e8FhZJzQHebwhUP79nVEM3nSk2qeBevazVLHYrBlSRDDfd0RitatNJlZsEy3Hw5r0GZDcSLRsZIG4Bvmu8qO9QD/nUqLF1WQBiKs3T1yChPyBoFi1hMdHkdGQ52hq+O6kZqmaz4Cja5ACNbWFL4j7ABmmltouw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q6viBeBEzsdRnrMWfOHh4HUijf/MVqoyhkbpFbqYLY=;
 b=X7TMulq/EUUrF84OQd1CXzrRFt4NJVM8lNO4QMHjpzIx7SsFZ1+f/GpfgAL4JQg02UsXUQq1onzDghoQ7WYvpImIfr+iYVqSu7L4bwgq5p6dEZmwb9EGy9x+zFDkRXGgroWpOSIWM35h1XDBvx4cN9OmfSmDx/E33vu/PSozvSqAL6oWmkKPlIjFchV+RXfbe5KurP4aortwo4PIMzm0KltlW4vBw9DT3PKxz/2p5oGURPMOh9qQlDC+XRP1uXih8QiPB9kfLXxkrv7PuYYhEaQfBI4kqJJ3aNbXP8Kh2s2dmZmj5E8ktIkRQihoIMPR4grHgCQPR0YuLeyQY1SO7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+q6viBeBEzsdRnrMWfOHh4HUijf/MVqoyhkbpFbqYLY=;
 b=EBjeGxOsHE42NXghPfPpxT1eIOZir+4RtziSnhEYzz0v+IaxwkJt5O3mDxgG+nzFPHEvBMxqfgq6Dcar5xb+itCClzLpWCbeprRqERd7lwDQkvRQKZAcOsTOnaF6bQIJFQ1glPiIa0qBFdJDeGhEUGwgh+P9YvIZrt7CgJwMfIs=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3009.eurprd04.prod.outlook.com (10.175.230.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2347.21; Tue, 15 Oct 2019 07:46:51 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::204a:79f8:1bb8:f8a8%7]) with mapi id 15.20.2347.023; Tue, 15 Oct 2019
 07:46:51 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Russell King - ARM Linux admin <linux@armlinux.org.uk>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 4/6] PCI: mobiveil: Add workaround for unsupported request
 error
Thread-Topic: [PATCH 4/6] PCI: mobiveil: Add workaround for unsupported
 request error
Thread-Index: AQHVbDZta7DhuZVctEuImCNxAD64Y6c7F6QAgCBpOuA=
Date:   Tue, 15 Oct 2019 07:46:51 +0000
Message-ID: <AM5PR04MB329953CADC8E2DC11AFFCA2EF5930@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-5-xiaowei.bao@nxp.com>
 <20190924164930.GZ25745@shell.armlinux.org.uk>
In-Reply-To: <20190924164930.GZ25745@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ab0a1fac-263d-4fe8-06a5-08d75143d74e
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM5PR04MB3009:|AM5PR04MB3009:
x-ms-exchange-purlcount: 2
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB3009C992DD1233F5E53D761AF5930@AM5PR04MB3009.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5236;
x-forefront-prvs: 01917B1794
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(376002)(39860400002)(136003)(396003)(13464003)(199004)(189003)(54906003)(5660300002)(316002)(486006)(6436002)(74316002)(55016002)(44832011)(186003)(26005)(476003)(4326008)(6246003)(14454004)(7416002)(3846002)(52536014)(6116002)(2906002)(66066001)(966005)(7696005)(8676002)(305945005)(7736002)(71190400001)(33656002)(6916009)(71200400001)(86362001)(45080400002)(9686003)(25786009)(6506007)(81156014)(81166006)(8936002)(53546011)(99286004)(6306002)(102836004)(76116006)(66476007)(66556008)(66946007)(11346002)(478600001)(446003)(14444005)(256004)(64756008)(66446008)(229853002)(76176011);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3009;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/wzAsmIYsJB1pY0yiG+OxsYdN3RzaBU7LqoxeUQTooUGA98xu04b9Euwmqr9UBoZLIp0xEkkx6VOYLbW4pvVqHuY9q603YE6M5+DmtCC9YFB7X/1G46QnvibEuB1Tf0nPGKf7Aafuquy+PAMKKzl3YZZEj2IOHO9iD1ir+Tc8vsbA2pFUCmmfd2BQ8synDxMTx6vgDLcXyRttb2JXe32CMyXndRah4rNIS3PCnj02/TrDPrOOh6bCnqGDfXopNVuoLnbGkuGkuu64acXxkPIzLUbQDyCAUC4S8f0mQqG2rJS8I6c6HhXmYpL9FYTarSiTPFhTaIlF6eK38B724xZVF3iNAXIEgyUtV8d4NV28yPILnDhcZtD481iKFZRgxByGNuVKGi3nEJM4R5EdIxVRrPr9Y9byBvRwgxklzh3EU=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab0a1fac-263d-4fe8-06a5-08d75143d74e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Oct 2019 07:46:51.2488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MoGHRVfaZpz0khppxHx3jVV6RMfqLx9H2LExrmSee5lzdxnpkfwr8mhyvAlurNe02sZG9oPsm9v30i23Ka6Krw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3009
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUnVzc2VsbCBLaW5nIC0g
QVJNIExpbnV4IGFkbWluIDxsaW51eEBhcm1saW51eC5vcmcudWs+DQo+IFNlbnQ6IDIwMTnE6jnU
wjI1yNUgMDo1MA0KPiBUbzogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+IENj
OiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0K
PiByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGtpc2hvbkB0aS5jb207IGxv
cmVuem8ucGllcmFsaXNpQGFybS5jb207IE0uaC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlhbkBueHAu
Y29tPjsgYW5kcmV3Lm11cnJheUBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1QG54
cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggNC82XSBQQ0k6IG1v
Yml2ZWlsOiBBZGQgd29ya2Fyb3VuZCBmb3IgdW5zdXBwb3J0ZWQNCj4gcmVxdWVzdCBlcnJvcg0K
PiANCj4gT24gTW9uLCBTZXAgMTYsIDIwMTkgYXQgMTA6MTc6NDBBTSArMDgwMCwgWGlhb3dlaSBC
YW8gd3JvdGU6DQo+ID4gRXJyYXRhOiB1bnN1cHBvcnRlZCByZXF1ZXN0IGVycm9yIG9uIGluYm91
bmQgcG9zdGVkIHdyaXRlIHRyYW5zYWN0aW9uLA0KPiA+IFBDSWUgY29udHJvbGxlciByZXBvcnRz
IGFkdmlzb3J5IGVycm9yIGluc3RlYWQgb2YgdW5jb3JyZWN0YWJsZSBlcnJvcg0KPiA+IG1lc3Nh
Z2UgdG8gUkMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5i
YW9AbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVp
bC9wY2llLWxheWVyc2NhcGUtZ2VuNC1lcC5jIHwgMTMNCj4gKysrKysrKysrKysrKw0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaCAgICAgICAgICAg
fCAgNCArKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMTcgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1sYXll
cnNjYXBlLWdlbjQtZXAuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9w
Y2llLWxheWVyc2NhcGUtZ2VuNC1lcC5jDQo+ID4gaW5kZXggN2JmZWM1MS4uNWJjOWVkNyAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJz
Y2FwZS1nZW40LWVwLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWls
L3BjaWUtbGF5ZXJzY2FwZS1nZW40LWVwLmMNCj4gPiBAQCAtNDksNiArNDksMTkgQEAgc3RhdGlj
IHZvaWQgbHNfcGNpZV9nNF9lcF9pbml0KHN0cnVjdA0KPiBtb2JpdmVpbF9wY2llX2VwICplcCkN
Cj4gPiAgCXN0cnVjdCBtb2JpdmVpbF9wY2llICptdl9wY2kgPSB0b19tb2JpdmVpbF9wY2llX2Zy
b21fZXAoZXApOw0KPiA+ICAJaW50IHdpbl9pZHg7DQo+ID4gIAl1OCBiYXI7DQo+ID4gKwl1MzIg
dmFsOw0KPiA+ICsNCj4gPiArCS8qDQo+ID4gKwkgKiBFcnJhdGE6IHVuc3VwcG9ydGVkIHJlcXVl
c3QgZXJyb3Igb24gaW5ib3VuZCBwb3N0ZWQgd3JpdGUNCj4gPiArCSAqIHRyYW5zYWN0aW9uLCBQ
Q0llIGNvbnRyb2xsZXIgcmVwb3J0cyBhZHZpc29yeSBlcnJvciBpbnN0ZWFkDQo+ID4gKwkgKiBv
ZiB1bmNvcnJlY3RhYmxlIGVycm9yIG1lc3NhZ2UgdG8gUkMuDQo+ID4gKwkgKiB3b3JrYXJvdW5k
OiBzZXQgdGhlIGJpdDIwKHVuc3VwcG9ydGVkX3JlcXVlc3RfRXJyb3Jfc2V2ZXJpdHkpIHdpdGgN
Cj4gPiArCSAqIHZhbHVlIDEgaW4gdW5jb3JyZWN0YWJsZV9FcnJvcl9TZXZlcml0eV9SZWdpc3Rl
ciwgbWFrZSB0aGUNCj4gPiArCSAqIHVuc3VwcG9ydGVkIHJlcXVlc3QgZXJyb3IgZ2VuZXJhdGUg
dGhlIGZhdGFsIGVycm9yLg0KPiA+ICsJICovDQo+ID4gKwl2YWwgPSAgY3NyX3JlYWRsKG12X3Bj
aSwgQ0ZHX1VOQ09SUkVDVEFCTEVfRVJST1JfU0VWRVJJVFkpOw0KPiA+ICsJdmFsIHw9IDEgPDwg
VU5TVVBQT1JURURfUkVRVUVTVF9FUlJPUl9TSElGVDsNCj4gDQo+IAkgICAgICAgQklUKFVOU1VQ
UE9SVEVEX1JFUVVFU1RfRVJST1JfU0hJRlQpID8NCg0KT0ssIHRoYW5rcw0KDQpUaGFua3MgDQpY
aWFvd2VpDQoNCj4gDQo+ID4gKwljc3Jfd3JpdGVsKG12X3BjaSwgdmFsLCBDRkdfVU5DT1JSRUNU
QUJMRV9FUlJPUl9TRVZFUklUWSk7DQo+ID4NCj4gPiAgCWVwLT5iYXJfbnVtID0gUENJRV9MWDJf
QkFSX05VTTsNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21v
Yml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiBpbmRleCA3MzA4ZmE0Li5hNDA3MDdlIDEwMDY0NA0K
PiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5o
DQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWls
LmgNCj4gPiBAQCAtMTIzLDYgKzEyMywxMCBAQA0KPiA+ICAjZGVmaW5lIEdQRVhfQkFSX1NJWkVf
VURXCQkweDREQw0KPiA+ICAjZGVmaW5lIEdQRVhfQkFSX1NFTEVDVAkJCTB4NEUwDQo+ID4NCj4g
PiArI2RlZmluZSBDRkdfVU5DT1JSRUNUQUJMRV9FUlJPUl9TRVZFUklUWQkweDEwYw0KPiA+ICsj
ZGVmaW5lIFVOU1VQUE9SVEVEX1JFUVVFU1RfRVJST1JfU0hJRlQJCTIwDQo+ID4gKyNkZWZpbmUg
Q0ZHX1VOQ09SUkVDVEFCTEVfRVJST1JfTUFTSwkJMHgxMDgNCj4gPiArDQo+ID4gIC8qIHN0YXJ0
aW5nIG9mZnNldCBvZiBJTlRYIGJpdHMgaW4gc3RhdHVzIHJlZ2lzdGVyICovDQo+ID4gICNkZWZp
bmUgUEFCX0lOVFhfU1RBUlQJCQk1DQo+ID4NCj4gPiAtLQ0KPiA+IDIuOS41DQo+ID4NCj4gPg0K
PiA+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+ID4g
bGludXgtYXJtLWtlcm5lbCBtYWlsaW5nIGxpc3QNCj4gPiBsaW51eC1hcm0ta2VybmVsQGxpc3Rz
LmluZnJhZGVhZC5vcmcNCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91
dGxvb2suY29tLz91cmw9aHR0cCUzQSUyRiUyRmxpc3RzDQo+ID4gLmluZnJhZGVhZC5vcmclMkZt
YWlsbWFuJTJGbGlzdGluZm8lMkZsaW51eC1hcm0ta2VybmVsJmFtcDtkYXRhPTAyJQ0KPiA3QzAN
Cj4gPg0KPiAxJTdDeGlhb3dlaS5iYW8lNDBueHAuY29tJTdDN2RjZWJjZGY1NjUxNDM0MTNhNzcw
OGQ3NDEwZjM0ZjUlN0MNCj4gNjg2ZWExZA0KPiA+DQo+IDNiYzJiNGM2ZmE5MmNkOTljNWMzMDE2
MzUlN0MwJTdDMCU3QzYzNzA0OTQwNTg3NjM5OTc3NCZhbXA7c2QNCj4gYXRhPSUyRmY4DQo+ID4N
Cj4gblE3MFBiUHBlUiUyQmxGZExtJTJCJTJGUFo5emwxSEMlMkJJWWMxSWIlMkJEYkFSR1ElM0Qm
YW1wO3INCj4gZXNlcnZlZD0wDQo+ID4NCj4gDQo+IC0tDQo+IFJNSydzIFBhdGNoIHN5c3RlbToN
Cj4gaHR0cHM6Ly9ldXIwMS5zYWZlbGlua3MucHJvdGVjdGlvbi5vdXRsb29rLmNvbS8/dXJsPWh0
dHBzJTNBJTJGJTJGd3d3Lg0KPiBhcm1saW51eC5vcmcudWslMkZkZXZlbG9wZXIlMkZwYXRjaGVz
JTJGJmFtcDtkYXRhPTAyJTdDMDElN0N4aWFvDQo+IHdlaS5iYW8lNDBueHAuY29tJTdDN2RjZWJj
ZGY1NjUxNDM0MTNhNzcwOGQ3NDEwZjM0ZjUlN0M2ODZlYTFkMw0KPiBiYzJiNGM2ZmE5MmNkOTlj
NWMzMDE2MzUlN0MwJTdDMCU3QzYzNzA0OTQwNTg3NjQwNDc2NCZhbXA7c2RhDQo+IHRhPTNyUEE0
a0pZdFF5R2NIUzRtJTJCNG1TcGlKSVl4OVlremhhdzczYlYwMVdrcyUzRCZhbXA7cmVzZXJ2DQo+
IGVkPTANCj4gRlRUQyBicm9hZGJhbmQgZm9yIDAuOG1pbGUgbGluZSBpbiBzdWJ1cmJpYTogc3lu
YyBhdCAxMi4xTWJwcyBkb3duIDYyMmticHMNCj4gdXAgQWNjb3JkaW5nIHRvIHNwZWVkdGVzdC5u
ZXQ6IDExLjlNYnBzIGRvd24gNTAwa2JwcyB1cA0K
