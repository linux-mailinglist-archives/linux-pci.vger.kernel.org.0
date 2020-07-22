Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA67228D5F
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 03:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbgGVBNN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 21:13:13 -0400
Received: from mail-eopbgr40073.outbound.protection.outlook.com ([40.107.4.73]:47784
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727953AbgGVBNN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 21:13:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VSZ78/ZPPB/xWR2znqxlFYU1bfniydqiL7ir1btIYhv/imGF+7Iw3WkqyKHHKcBjY49Q44Cha29XQXh8UTA8go3ZRwHIe2gzn3rLhoZLzwMHWHk8VhxBpMg7vM6rjCUvtRr4IENKobePNiUdZHjpEGO4e9G60ahzb1OEL2heeusRu/VJg/0VP1Yn4muPmtuRyHpRAwUjYN0f0X6/YEdtc/r0+rGgEDc5zWeVk5Dp/Mv+HOo+4M4QIGItYEIpqLuY15OzXrx7CjrwmCecW/tcdhSbVxmEJ8f+knVpfh2tCJhdtHPr/krhJ8/tQpkyHz3XfrJt1Tz5kFrB6oR3/R9zzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0+6EVeLcS5pC6/ieCj7KegzTR7ya8G5lfAcPBzwzHU=;
 b=QhaWg8u9HlhqHuSi+rDIhmoyJEEl1w2W1Bc0STU5HYALGuJvWpEMLoO5TajF8FllfFUXCFO4uiva2VU88EzMrByFDI860JGB2Ur0uciLeOD1zPgQI6ij5y3wWnqH5UU+j1BAM0op7b31HVvp1YpYsYJyRte6QGhf6ll0ogoNsmXt/yvNcQuvy4huFR3mGAoEaD0qfhzFgMcRbaqWlHCUKQJbS5xvE3a/zR9Dlq23NDTnQgwReqGcSj0S1ZjsAjnbzGYTjtr1ktt8lHiE3husLK0wWIjyShBRlJ1hks2U9AGrV4Nr8vHezmJstZncaTWtdZC7Nziv5XfLO6SDpRaBYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J0+6EVeLcS5pC6/ieCj7KegzTR7ya8G5lfAcPBzwzHU=;
 b=d42JOxSxyG7vul5iDm8pp4IQdAzzazig4anHBBTx4E14eph8ll1YiZ5pCVI5QlG13UyOcCDB8xIt/Hb+43k+t9hthuk2qOqcZARE7oO5ByCFq4Oh9LdlYOsSLSHl5izHpiCltAlfiFfSoxc3ipbJ43CxsaeADgG0+yQquviw6/M=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR04MB5501.eurprd04.prod.outlook.com (2603:10a6:803:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.24; Wed, 22 Jul
 2020 01:13:08 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::1de7:774:144c:e60f%6]) with mapi id 15.20.3195.026; Wed, 22 Jul 2020
 01:13:08 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [EXT] Re: [PATCH 1/2] ARM: dts: imx6qp-sabresd: enable pcie
Thread-Topic: [EXT] Re: [PATCH 1/2] ARM: dts: imx6qp-sabresd: enable pcie
Thread-Index: AQHWXzNQI771uV8xb0CtKGrtQKefrKkRr/CAgAEboqA=
Date:   Wed, 22 Jul 2020 01:13:08 +0000
Message-ID: <VI1PR04MB5853FE6C8680BD087C7C9B408C790@VI1PR04MB5853.eurprd04.prod.outlook.com>
References: <1595317470-9394-1-git-send-email-hongxing.zhu@nxp.com>
 <d8760e851fdf8a934dca20a9440bced16bb39123.camel@pengutronix.de>
In-Reply-To: <d8760e851fdf8a934dca20a9440bced16bb39123.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 603e35d7-8d2c-482a-a22a-08d82ddc64f3
x-ms-traffictypediagnostic: VI1PR04MB5501:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR04MB550164EAD684DCD9E81C70A38C790@VI1PR04MB5501.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gUygcpxCNulxpr9FmktfODvypC5Ge7akr0/whQbIUuglDKWQC+FYIL07Wq259KXFSwWsDg0FBJ3whL7kwHs5tH9990AKv/Vjzzg1+5evo3zBEkh3rhyEgODdFJkzTuXwlHe3Yb3vTxcUSmb+eyuKGLzAdEB1/FCp9CUY8OAB69RoQeYVvp6EJMz8GnuiaG9A/25kXif3fVfUZhORNhur6dQ3SfpSkHKiIA+QAJSTVs3NbZfV/NMVubLq1kQlMGJUDrvKxtc99MiU5v+TA5kzVFwAEQq/cFcV5uoKqgPnYlBpJqM33vdk7PJj72n2SoyrqkSLmtx8tO0nTG2o0p3hZnqYwIdBaQqB+fW/qfIxNJkqznApR86zBKoQ9h3D0Vmj
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(376002)(366004)(396003)(39860400002)(136003)(33656002)(5660300002)(52536014)(71200400001)(76116006)(55016002)(83380400001)(86362001)(4326008)(478600001)(9686003)(8676002)(6506007)(7696005)(8936002)(26005)(53546011)(110136005)(54906003)(316002)(2906002)(66446008)(186003)(66946007)(66476007)(64756008)(66556008)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: bPr4EL04qMQnEu6RPfoUHLLdbtBBeZ5A/jIrR8sWzYkgWIoYePKSN6nAXDMnXhvgm/ETJJ9zSyvNaFI/l3QX3Y9oQJ8pUwEKsGIcPt8bo2INA4+Q/WOUWUwLtNJPBikr88CT/qKOOjeEX3tho1BEY+gq+255T2IdWekVeBXARIS+ryB0vfmPYI9/kBBDgGX1WtNzlOVK3G36g/mw6FwkURzNUsk5vMYCHTlVaahToquktnk06fZHX0Hr/94f8FNLkRZHFTjNCji1xno7Go89uZEoc50/qd6ntnGuMn6qcI6OusWMnLSWhKBmO4Ods4UlQSu2URIqaaNt9nYmRbvLfu7QqjNVSPxbra2PPsR5jpuB34M5tdk+N6gUwEBvvMH1hmdWeZw7CNmbEGmRgV7UHyKJOEd4aqvAuSHy9Rjulb9wBi+16k5Xa/QK2dwdfpHDT1zMuwteOXlRytjkN51WxbqABC0pih1wxSfnuwVH1QE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 603e35d7-8d2c-482a-a22a-08d82ddc64f3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jul 2020 01:13:08.2188
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: z0CW43kIhm8huDoQgNXbpsq6IL9cWKuJSRvLmtSZ0MwGgQQ0hT372s7f7Bg6VTPEsm2cb9FG5KTO7K+t3x0cnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5501
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMdWNhcyBTdGFjaCA8bC5zdGFj
aEBwZW5ndXRyb25peC5kZT4NCj4gU2VudDogMjAyMOW5tDfmnIgyMeaXpSAxNjoxNg0KPiBUbzog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsN
Cj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBsaW51eC1w
Y2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29tPjsNCj4g
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnOw0KPiBrZXJuZWxAcGVuZ3V0cm9uaXguZGUNCj4gU3ViamVjdDogW0VYVF0gUmU6
IFtQQVRDSCAxLzJdIEFSTTogZHRzOiBpbXg2cXAtc2FicmVzZDogZW5hYmxlIHBjaWUNCj4gQW0g
RGllbnN0YWcsIGRlbiAyMS4wNy4yMDIwLCAxNTo0NCArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1
Og0KPiA+IEFkZCBvbmUgcmVndWxhdG9yLCB1c2VkIHRvIHBvd2VyIHVwIHRoZSBleHRlcm5hbCBv
c2NpbGxhdG9yLCBhbmQNCj4gPiBlbmFibGUgUENJZSBvbiBpTVg2UVAgU0FCUkVTRCBib2FyZC4N
Cj4gDQo+IFRoYXQncyBub3QgdGhlIHJpZ2h0IHRoaW5nIHRvIGRvLiBJZiB0aGVyZSBpcyBhbiBl
eHRlcm5hbCBvc2NpbGxhdG9yLCB3aGljaA0KPiByZXF1aXJlcyBhIHBvd2VyIHN1cHBseSB0aGVu
IHRoZSBvc2NpbGxhdG9yIHNob3VsZCBoYXZlIGl0cyBvd24gY2xvY2sgRFQNCj4gbm9kZSAoaXQn
cyBhIHNlcGFyYXRlIGRldmljZSBhZnRlciBhbGwpIGFuZCB0aGlzIG5vZGUgbmVlZHMgdG8gY29u
dHJvbCB0aGUNCj4gcmVndWxhdG9yLg0KPiANCj4gVGhpcyBoYXMgbm90aGluZyB0byBkbyB3aXRo
IHRoZSBQQ0llIGNvbnRyb2xsZXIsIHdoaWNoIG9ubHkgY2FyZXMgYWJvdXQgdGhlDQo+IGNsb2Nr
IGJlaW5nIHByb3ZpZGVkLg0KPiANCkhpIEx1Y2FzOg0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRz
LiANCk9rYXksIEkgd291bGQgaW50ZWdyYXRlIHRoZSByZWd1bGF0b3IgaW50byBvbmUgY2xvY2sg
bm9kZSBsYXRlci4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0KDQo+IFJlZ2FyZHMsDQo+
IEx1Y2FzDQo+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IFJpY2hhcmQgWmh1IDxob25neGluZy56aHVA
bnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2Qu
ZHRzIHwgMyArKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBkZWxl
dGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1z
YWJyZXNkLmR0cw0KPiA+IGIvYXJjaC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+
ID4gaW5kZXggNDgwZTczMTgzZjZiLi5jZDhhMWY2MTA0MjcgMTAwNjQ0DQo+ID4gLS0tIGEvYXJj
aC9hcm0vYm9vdC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+ID4gKysrIGIvYXJjaC9hcm0vYm9v
dC9kdHMvaW14NnFwLXNhYnJlc2QuZHRzDQo+ID4gQEAgLTUxLDcgKzUxLDggQEANCj4gPiAgfTsN
Cj4gPg0KPiA+ICAmcGNpZSB7DQo+ID4gLSAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gPiAr
ICAgICB2ZXBkZXYtc3VwcGx5ID0gPCZ2Z2VuM19yZWc+Ow0KPiA+ICsgICAgIHN0YXR1cyA9ICJv
a2F5IjsNCj4gPiAgfTsNCj4gPg0KPiA+ICAmc2F0YSB7DQoNCg==
