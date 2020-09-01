Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B1B2585C9
	for <lists+linux-pci@lfdr.de>; Tue,  1 Sep 2020 04:51:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgIACvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Aug 2020 22:51:36 -0400
Received: from mail-am6eur05on2072.outbound.protection.outlook.com ([40.107.22.72]:54816
        "EHLO EUR05-AM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725901AbgIACve (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Aug 2020 22:51:34 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4sKGMEtPuQGVPA/WvF3r3WXJ3v5f/rzXFe1w9NVVHT7/WrrAgLkXVgPMcUVJLecrYkM+dOwMNrZwenu3OQGFxQBuQrq2fy15B21Xgsfbva7DhXyEPGoa2lyJ9zzkSVy/H+hTYYoUaY6KksWUTpdnQNm0qbYWKAIsZbDd99uGNfu0C6FNWuSfbCrqzu2b+uwHyvaTKDZ58QsAZx0KNHxbNgMCXO74XQERKakEjDcdNl7HmbBJkJd/DTuVIzrdsX0Sg21sNSHe5fOpSypBgk/TPfUHJd4UDwFr25xksZHM74Re/X/oIRhrXgKqb+nc3MV6yMbLJrsaRtWevEtuDMZ7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ndGJG9pRGDsTTrmo/14cgciDpmyf6aYfuwh0gKU838=;
 b=S4ufmHLpUoPH8Np46SBVgVgQDsoXXXpQNeeLqcy6lTjGrCQwcfpUtUbDMUECtN+qXN76lxxEZ8wZGkYDfXlqT2ufW/n4+vP7NztJyJ5AsKUtILIyKllfljJ0ePn3htPjGiJWpk+cZMLnkMbDTdZeGnQZd3m8vGAUyoDMA0opEP76vZvTceK2+7eIt8vjpMOxTtaNoyO07YP4KHfnxiXfr+Ks3iKXhUSFfZLcUjgl1UAhlYEv9pT+B1pQuvRzTgckKUiZBxlEnKHOQ5jCUNc2eyD4hdrZe6KaBH7GNppnRZdrdTmrzaP9WM05zvKvjjzc6BLWZXXg6RwzIU+dAJX0Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ndGJG9pRGDsTTrmo/14cgciDpmyf6aYfuwh0gKU838=;
 b=kH/PwKNCxUmhav7SSjOjOJNfMYWrAjmuEW8xW7KFkJcqr+hXe87HpxSNO989NAsNSS36W2M9Jnl+VpUiAFNWUY53ujBLw6Sn9wSrXaU5ZXQ4s7eWjhfG8uxwzc2+NpckvsOGaEG9r9urlqeNL37ZyfZJmXtgoO5qdn7C592qcDk=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0402MB3550.eurprd04.prod.outlook.com (2603:10a6:803:3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19; Tue, 1 Sep
 2020 02:51:28 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::ec1c:173d:f9de:2415]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::ec1c:173d:f9de:2415%7]) with mapi id 15.20.3326.025; Tue, 1 Sep 2020
 02:51:28 +0000
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
Subject: RE:  Re: [PATCH 1/2] ARM: dts: imx6qp-sabresd: enable pcie
Thread-Topic: Re: [PATCH 1/2] ARM: dts: imx6qp-sabresd: enable pcie
Thread-Index: AdaACo2r/pPcl11ITumTzDVCFncMIw==
Date:   Tue, 1 Sep 2020 02:51:28 +0000
Message-ID: <VI1PR04MB585346A768355281ECD20D118C2E0@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 79da11b9-d0c6-4ae2-98e9-08d84e21ecd0
x-ms-traffictypediagnostic: VI1PR0402MB3550:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0402MB355099F57BAF5E9C033D6ADE8C2E0@VI1PR0402MB3550.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DdlRU186XukECBgNJbfKMIMhuMUWsDX4II+2i96dbUmVSvOq7ROlFtF1oLPvrCxObbOpfgDPqcu+PyKVieBfjgPc7wIwXvdEPs6pxgd8FFSWMiJzjIAMHG4/esLC5s5ucL6moRvgkId3AB+NjRK47J2tysJNMDQHp/Fn1vAaoK8UduJGqMlVsAHvfm9wMfK4DnEeOH7y73eQcQhC+nK2oYydKlniMRaRWcFgReQEdIO7F33MA+3YWpGvWruLuh5VmsBPVxGOL8+YjvTraRHkcLMZK6igmqY/M/po8jMNCLNZpQ99lbLRN1t7TEL3SJaV3bNPRCeCZWcfKgLms84tKGSJr4VVKeVnMYQKAoI+W5DMvW7mRWO3bGg1FAewbIsK
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(366004)(39860400002)(396003)(2906002)(4326008)(55016002)(9686003)(86362001)(54906003)(6506007)(110136005)(26005)(71200400001)(316002)(7696005)(53546011)(52536014)(5660300002)(186003)(33656002)(83380400001)(8676002)(478600001)(66446008)(66556008)(64756008)(8936002)(66476007)(66946007)(76116006)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2fpshFDr+0eCsAapl6ZGRFtBWpoHNbCSZBqHH8ACyoGCGw0FyVpjmIOmOp6N9WkbCqShSo1PASE4UUTftdvfrhIHUCvHhnFWG9tULdoQyysNPSP64QMRPBxCClHIoJ5j2wM4VzLiGHlbjiqVA7rxrGqdqANepTHoax0o3/mVLGQN/YYxVgvs5OZ4iB4qb0mKv/LN19cD2NAyQjwdXkuptdw6EauTkE7GnI2gjSaHaeI5Z2Nyom3KlgeynubIdWeoypOjmB/JLl7bxbHcWCRThFfvO//HEMqCL4q+ZR3RSqxvFqbAcP80FnCkRb8VGCnHAlcx2T2f83ks5ne7K2HZtlBq3x6q7LBmDIHBkp6EY0ZlhRkAQ8Fv0e1KXhBoYcKvV5cUfP64ywMD+nhp5wigwAQf3BQx6Pr4oLtg3pyYxYRurajCot7M8bwncIV8EUDcXAfzunBlaMQij61VTJgorm1IpE8VCtFJQ7Ys/1kn45qa91Q30IRxQDItKFDcS5B6cfTOWVZEHqNTQqOK65CCGGajBrfoLxsdV1O6RQmDNoMzF70mjnLusOHmRgRJ8JFB75X9LyGR/CAiOj63xx36vdSPJkxapxDAZkJ5b8ahJeDIm2vgXHzqjLIk59tlBQzygkJDn+pTOSOS4mADhDjW3w==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79da11b9-d0c6-4ae2-98e9-08d84e21ecd0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2020 02:51:28.5117
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9/C76JccVAalWSNa3DdwN4rvCFHfclCox9AzAGlr1xw9dI7ZWIeH85scdN6Ib5Wr0qmgBQdz+M18s0ii/pOROw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3550
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
IFtQQVRDSCAxLzJdIEFSTTogZHRzOiBpbXg2cXAtc2FicmVzZDogZW5hYmxlIHBjaWUNCj4gDQo+
IENhdXRpb246IEVYVCBFbWFpbA0KPiANCj4gQW0gRGllbnN0YWcsIGRlbiAyMS4wNy4yMDIwLCAx
NTo0NCArMDgwMCBzY2hyaWViIFJpY2hhcmQgWmh1Og0KPiA+IEFkZCBvbmUgcmVndWxhdG9yLCB1
c2VkIHRvIHBvd2VyIHVwIHRoZSBleHRlcm5hbCBvc2NpbGxhdG9yLCBhbmQNCj4gPiBlbmFibGUg
UENJZSBvbiBpTVg2UVAgU0FCUkVTRCBib2FyZC4NCj4gDQo+IFRoYXQncyBub3QgdGhlIHJpZ2h0
IHRoaW5nIHRvIGRvLiBJZiB0aGVyZSBpcyBhbiBleHRlcm5hbCBvc2NpbGxhdG9yLCB3aGljaCBy
ZXF1aXJlcyBhDQo+IHBvd2VyIHN1cHBseSB0aGVuIHRoZSBvc2NpbGxhdG9yIHNob3VsZCBoYXZl
IGl0cyBvd24gY2xvY2sgRFQgbm9kZSAoaXQncyBhDQo+IHNlcGFyYXRlIGRldmljZSBhZnRlciBh
bGwpIGFuZCB0aGlzIG5vZGUgbmVlZHMgdG8gY29udHJvbCB0aGUgcmVndWxhdG9yLg0KPiANCj4g
VGhpcyBoYXMgbm90aGluZyB0byBkbyB3aXRoIHRoZSBQQ0llIGNvbnRyb2xsZXIsIHdoaWNoIG9u
bHkgY2FyZXMgYWJvdXQgdGhlIGNsb2NrDQo+IGJlaW5nIHByb3ZpZGVkLg0KPiANClRvIGJlIHNp
bXBsZSwgYW5kIGVhc3kgdG8gbWFpbnRhaW4uIEhvdyBhYm91dCB0byBzZXQgdGhlIHZnZW4zIGFs
d2F5cyBvbiBpbiB0aGlzIGNhc2U/DQoNCkJlc3QgUmVnYXJkcw0KUmljaGFyZCBaaHUNCg0KPiBS
ZWdhcmRzLA0KPiBMdWNhcw0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJkIFpodSA8aG9u
Z3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGFyY2gvYXJtL2Jvb3QvZHRzL2lteDZx
cC1zYWJyZXNkLmR0cyB8IDMgKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0
cy9pbXg2cXAtc2FicmVzZC5kdHMNCj4gPiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJy
ZXNkLmR0cw0KPiA+IGluZGV4IDQ4MGU3MzE4M2Y2Yi4uY2Q4YTFmNjEwNDI3IDEwMDY0NA0KPiA+
IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNkLmR0cw0KPiA+ICsrKyBiL2Fy
Y2gvYXJtL2Jvb3QvZHRzL2lteDZxcC1zYWJyZXNkLmR0cw0KPiA+IEBAIC01MSw3ICs1MSw4IEBA
DQo+ID4gIH07DQo+ID4NCj4gPiAgJnBjaWUgew0KPiA+IC0gICAgIHN0YXR1cyA9ICJkaXNhYmxl
ZCI7DQo+ID4gKyAgICAgdmVwZGV2LXN1cHBseSA9IDwmdmdlbjNfcmVnPjsNCj4gPiArICAgICBz
dGF0dXMgPSAib2theSI7DQo+ID4gIH07DQo+ID4NCj4gPiAgJnNhdGEgew0KDQo=
