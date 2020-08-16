Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D41E24588F
	for <lists+linux-pci@lfdr.de>; Sun, 16 Aug 2020 18:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbgHPQfy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 Aug 2020 12:35:54 -0400
Received: from mail-am6eur05on2058.outbound.protection.outlook.com ([40.107.22.58]:62880
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726407AbgHPQfu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 16 Aug 2020 12:35:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lIk8TPM3QA+v7Qxo69x3KDjEpyGwg776c+A1x9Spog+mgvqCUiShQ9pT7/aJOb22VHZG/q5l5jXTVevRticBn7dPhyyMjoYq/Y69/0I+YrB7WmGc9EN25tQM8QV2TWdI3WJXr26/4iiIoDl7Ip7WGWoq7KzhOxbk1iT/KMDLT0j9Z45BTnACpqiGXVUy926aMdKNzip+B74D/zOnRU91Vee2Gkc5F7yjany2dKzd/5vDvFtB7UuetZTbCwIo1tXodIVOaqpludpdXosWOzy93FHWuziqLWowX3Qefot6IgRPc72sYUf3Y8+fFWslmaLrkWELCDuuqTncSBiHP7OK3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuNNBz1Z0cWReIvq7uHZtwTdcEHoJxX9kWDOxaYP/5M=;
 b=TitZuZChDUAyRs7qR0Rn0HGK6uGNaasm831ogBBfo61cj1xbUCc1EvYJs9ZBgmnMyiNs9MdPWngxbKlNdsqPcSU8FE9hGpBuEudl0cmOUr++HPEXDUNGmFCpYJc0Gre8EUM4ZgcnYJFBYuZUSEgwE/KjqY2z4lQKj1G8faeJjdrntvbx3bVmluhtgKt/ADCOy8F4oW8TVXw5jvlgYiif7XQN+tzu/2UFuAynzYghYNAEt1TmvrMvdx/4g+F0VaZrNcB4o0JfeAm7c3hYZ2XmMobbbyHtRpIOg7JVC3h3tGJRSRsiJEQZtsRZp/ZyOT/FTLNc1SyH5vqQ9YRcHfRY+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FuNNBz1Z0cWReIvq7uHZtwTdcEHoJxX9kWDOxaYP/5M=;
 b=ARCL9m6bucXv2ZB5kq4z2xQI32uj7XwDuoIulJ+iuPkrFmPhmFZHcZdTIXp2etDSUZpbl+gj2qAXFXC8gXF8n/Dv2J9Ttt9FyC/BcMpD63HdhyepTkx1znUanQG0sLsqhwjZWEDDw7gSEdTPArerlTngE2EllY/qLza4fo4Jx2w=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0402MB3578.eurprd04.prod.outlook.com (2603:10a6:7:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Sun, 16 Aug
 2020 16:35:44 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::525:4554:3b4f:321d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::525:4554:3b4f:321d%2]) with mapi id 15.20.3283.027; Sun, 16 Aug 2020
 16:35:44 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: RE: [PATCH] PCI: designware-ep: Fix the Header Type check
Thread-Topic: [PATCH] PCI: designware-ep: Fix the Header Type check
Thread-Index: AQHWchMU/epatx3sk0yrfgSC9wePyqk3wTkAgAMwdHA=
Date:   Sun, 16 Aug 2020 16:35:44 +0000
Message-ID: <HE1PR0402MB3371A9E1DDC8C6F2CFE71968845E0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200814080813.8070-1-Zhiqiang.Hou@nxp.com>
 <CAL_Jsq+a7kRVgnRhOxffZedz3M3s3DPcB6Q_tc4_Vu-WT55ZDQ@mail.gmail.com>
In-Reply-To: <CAL_Jsq+a7kRVgnRhOxffZedz3M3s3DPcB6Q_tc4_Vu-WT55ZDQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3ccefb29-8330-4e35-0408-08d842026c3c
x-ms-traffictypediagnostic: HE1PR0402MB3578:
x-microsoft-antispam-prvs: <HE1PR0402MB3578CF6C04A7DA8EF577C0C0845E0@HE1PR0402MB3578.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: t9W6VJZJ0t6FV8gu25QjQ5xDgpnjTh60B66ivXygTQD/mRvFaPDMnEgDteEaJ3y1vm5tE4mQ3J7EbbGSSc0mQhOBXU4bWLxH4wE2I4h8UNNw7Z3Bjthx9hYNqlWJucpHnU01qUEa2FqKl7MECW8mfzBvpkV1xa4H56UrK0eW6SAqIQYvueAZPaUrvESA7zpdMC/xAfkir/It+wV5jXHwdYhdKvguNTwLdvUQQT8QQNbTZuB+QsPZBCYTdAmGFYNU2AmfL26XqHbquEE05U5LkNahjsHUVPl9bPUQe49r72w7ju8OIytFx80FijPfrVQU
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(376002)(366004)(39850400004)(5660300002)(55016002)(6506007)(9686003)(33656002)(4326008)(186003)(71200400001)(478600001)(26005)(8936002)(2906002)(7696005)(53546011)(66446008)(64756008)(66476007)(83380400001)(8676002)(86362001)(52536014)(66946007)(76116006)(6916009)(54906003)(66556008)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: /HGrIgu4Z03DLmtAdq++VQxnsRimjmdQZYULAUsSsD4AHagwrhAGHG8d7XfasL5DrR+PHmu5+5oU1yPg3APS/gsye2SOi+WPtiqvlU8pw4KU8TkaxuyCkd2/fwlg71WAmhD7KNeJRgmEgv5dOVFY1Zp3rnUvJvvyBW7dDpkaA1T6CauMacPO798asJB1r+DBsdDYikvxT5wk979TvTt78qtsMuqvnRZAV1oOq0triTCV786uAXszsNo+5OGhNNiyht2weEDD5y7x6YND8nzaKM/z99t5WtmPc/WFTJMUYZWcyeCI9kV93m+md3xzzqaJrrFwu7EuusnAWVXQWwgXx/Walvl+hMkgjdKzUv3LzL1CtJzDd8WYyaV0OjXdPI1esfHuMO577HHnaExk1IAqc3pQ5PL0jQrU3HLHuYlV73uIe6ENcOjoeUnb1DwhWRMAGWmgwOycHVCqLeOi0X55B5d5HPGbLQYIxLjGqzqtnXspBYediB0qMAKP5jl4AYz+Spra/Ht0IXosI+OT4O1EbnRDYzLzOiO6D1Yq4BXqCatWR5ahAzYcphx77EOD2OP24f9iqMv0G/zZsCf+nI0itHpS3WWbJGWHJI2jvJjeEWgA6zX7G0/wNrKrYArS3zRgiH9LF+wl6nXHuOSuL+grNQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ccefb29-8330-4e35-0408-08d842026c3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2020 16:35:44.3954
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: UuzHUNbEH++9P81rMEgVV8dwUlqnbdtUH4f+7Qvx30u0h4BTC5VDk4IgnyekeiDdWdeKK0YHbebAke62j9jjoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB3578
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgW21haWx0bzpyb2JoQGtlcm5l
bC5vcmddDQo+IFNlbnQ6IDIwMjDlubQ45pyIMTTml6UgMjM6NTENCj4gVG86IFoucS4gSG91IDx6
aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7
IFBDSSA8bGludXgtcGNpQHZnZXIua2VybmVsLm9yZz47IExvcmVuem8NCj4gUGllcmFsaXNpIDxs
b3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdhYXNAZ29v
Z2xlLmNvbT47IEFuZHJldyBNdXJyYXkgPGFtdXJyYXlAdGhlZ29vZHBlbmd1aW4uY28udWs+Ow0K
PiBKaW5nb28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT47IEd1c3Rhdm8gUGltZW50ZWwNCj4g
PGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQ
Q0k6IGRlc2lnbndhcmUtZXA6IEZpeCB0aGUgSGVhZGVyIFR5cGUgY2hlY2sNCj4gDQo+IE9uIEZy
aSwgQXVnIDE0LCAyMDIwIGF0IDI6MTUgQU0gWmhpcWlhbmcgSG91IDxaaGlxaWFuZy5Ib3VAbnhw
LmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgY2hlY2sgd2lsbCByZXN1bHQgaW4gdGhl
IG11bHRpcGxlIGZ1bmN0aW9uIGRldmljZSBmYWlscyB0bw0KPiA+IGluaXRpYWxpemUuIFNvIGZp
eCB0aGUgY2hlY2sgYnkgbWFza2luZyBvdXQgdGhlIG11bHRpcGxlIGZ1bmN0aW9uIGJpdC4NCj4g
Pg0KPiA+IEZpeGVzOiAwYjI0MTM0Zjc4ODggKCJQQ0k6IGR3YzogQWRkIHZhbGlkYXRpb24gdGhh
dCBQQ0llIGNvcmUgaXMgc2V0DQo+ID4gdG8gY29ycmVjdCBtb2RlIikNCj4gPiBTaWduZWQtb2Zm
LWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBk
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyB8IDIgKy0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJl
LWVwLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1l
cC5jDQo+ID4gaW5kZXggNDY4MGE1MWM0OWMwLi40YjdhYmZiMWU2NjkgMTAwNjQ0DQo+ID4gLS0t
IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0KPiA+
IEBAIC02NTQsNyArNjU0LDcgQEAgaW50IGR3X3BjaWVfZXBfaW5pdF9jb21wbGV0ZShzdHJ1Y3Qg
ZHdfcGNpZV9lcA0KPiAqZXApDQo+ID4gICAgICAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgICAg
aGRyX3R5cGUgPSBkd19wY2llX3JlYWRiX2RiaShwY2ksIFBDSV9IRUFERVJfVFlQRSk7DQo+ID4g
LSAgICAgICBpZiAoaGRyX3R5cGUgIT0gUENJX0hFQURFUl9UWVBFX05PUk1BTCkgew0KPiA+ICsg
ICAgICAgaWYgKGhkcl90eXBlICYgMHg3ZiAhPSBQQ0lfSEVBREVSX1RZUEVfTk9STUFMKSB7DQo+
IA0KPiBTaG91bGQgaGF2ZSAoKSBhcm91bmQgJ2hkcl90eXBlICYgMHg3ZicuDQo+IA0KPiA+ICAg
ICAgICAgICAgICAgICBkZXZfZXJyKHBjaS0+ZGV2LA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICJQQ0llIGNvbnRyb2xsZXIgaXMgbm90IHNldCB0byBFUCBtb2RlDQo+IChoZHJfdHlwZTow
eCV4KSFcbiIsDQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgaGRyX3R5cGUpOw0KPiANCj4g
SG93ZXZlciwgc2hvdWxkbid0IHRoZSBwcmludGVkIHZhbHVlIGJlIG1hc2tlZCB0b28/IEknZCBq
dXN0IGRvOg0KPiANCj4gaGRyX3R5cGUgPSBkd19wY2llX3JlYWRiX2RiaShwY2ksIFBDSV9IRUFE
RVJfVFlQRSkgJiAweDdmOw0KPiANCj4gUGVyaGFwcyBhZGQgYSAjZGVmaW5lIHRvby4gJzB4N2Yn
IGlzIHVzZWQgaW4gc2V2ZXJhbCBwbGFjZXMuDQoNCkFsbCB0aGVzZSBhcmUgZ29vZCBzdWdnZXN0
aW9ucywgd2lsbCBtYWtlIGl0IGluIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLA0KWmhpcWlhbmcN
CiANCj4gDQo+IFJvYg0K
