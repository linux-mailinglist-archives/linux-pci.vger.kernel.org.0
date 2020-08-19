Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E513249436
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 06:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgHSEzt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 00:55:49 -0400
Received: from mail-eopbgr80041.outbound.protection.outlook.com ([40.107.8.41]:22144
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725803AbgHSEzr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 00:55:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y5nRyBlxN9S/yFurX+CgB+topYJ2Bnr8eiCM+89NS3PUcXzWIRcTqsZ872Q24vaV0c1A2Sa2PgF4EblZjRAZjDtlR0/oRkgiKyjPhmxvnBB7DDpOMGloAk8PG65XueQBEBcllUvOxuHw7GbfZIlgSL3rnOJTEm9RvSRca45PfKKAAk613UJAsyYgDlZuCbMVsw7rb/6Rvz41ihtFnmgFW+bPBmmn86gP8KO+ZLxdLIwvOZqaP3vwbzABsuca4klwLr4E7YsHcmmfVRKCpUy9CUYDufnhj0I+N0+4/T9G9sYqdKuGL8LMpmyh1srUwG+zP2bUmoHHlMbeJGJNdk6Txw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCwLR3QbJCGeSdsx3ZAFKPY7OzU/bj9jOXxGVYHPRb0=;
 b=jrPbRcOSsddaPloTEDSgUw7im0klWKHHgfzorH2dAKWEAGu2BJ+FFCk1Gpx7ZYmQOCsO8CejiNa+vRAjDPXTIWV5maYxzAjI+VWzABGQimX3ai59qsJOlnST0FlEZ1WqnVs6dZJNuyY42L25yZ2m/7J8pPnOtC7dnb8BvvVId5VVvIlhazYs2XH2ZLiwjkdmvF5Ok1/sVbfKlpgPTQYEb1nO2qBKcuBxBQmtuAq7Vo4OleeWNmxrj8eTwj2rSw0ryBQhEBQAGy83wSt9GC30B49l1HjpiA5JDc7wQ7kx148Ea2HVo27jYfGiB4IL/Vy7o+tkqGHKJFwVH2a378J+AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XCwLR3QbJCGeSdsx3ZAFKPY7OzU/bj9jOXxGVYHPRb0=;
 b=E8O4Wcn4y0uRnsN0kzvxluO3x0Q3Gr+cWdmTG3lSj/1g+2nHl0lj/8PBlY2+thXwu4hS+5D1QEFdlQ0NxPunH2c26IZkEdFAzZzR2Pm22NS1xqDylIyl+8jkdIksqdjImgsnoo4eURNEsZdmWaSXsHCnUCbO88gN19aX3GptxDg=
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com (2603:10a6:7:85::27)
 by HE1PR0401MB2458.eurprd04.prod.outlook.com (2603:10a6:3:7f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.23; Wed, 19 Aug
 2020 04:55:43 +0000
Received: from HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::525:4554:3b4f:321d]) by HE1PR0402MB3371.eurprd04.prod.outlook.com
 ([fe80::525:4554:3b4f:321d%2]) with mapi id 15.20.3283.028; Wed, 19 Aug 2020
 04:55:43 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Subject: RE: [PATCHv2] PCI: designware-ep: Fix the Header Type check
Thread-Topic: [PATCHv2] PCI: designware-ep: Fix the Header Type check
Thread-Index: AQHWdULdmUdKZ3Yx7k+9v6T/XTG8U6k94vIAgAD8TNA=
Date:   Wed, 19 Aug 2020 04:55:43 +0000
Message-ID: <HE1PR0402MB3371820E90A64B8B83D2CBA9845D0@HE1PR0402MB3371.eurprd04.prod.outlook.com>
References: <20200818092746.24366-1-Zhiqiang.Hou@nxp.com>
 <CAL_Jsq+TG7JD2oWGmOSJqqBQihbHr0C12cteH5EtSRLCj63Nhw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+TG7JD2oWGmOSJqqBQihbHr0C12cteH5EtSRLCj63Nhw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c36c21a5-a274-41da-e9e3-08d843fc2109
x-ms-traffictypediagnostic: HE1PR0401MB2458:
x-microsoft-antispam-prvs: <HE1PR0401MB2458D53F7BEE31B422BAED61845D0@HE1PR0401MB2458.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rsODqUFMLNmNzx4mGDwYaYwsUNdPT41LyQ7q0t3JbcdBOSiVncCSDNh5VjJFvZhZS6qszxd2E7m7p+bWmjNaiUyN6WckVaPO+9oFXh/kqrFpOS3bNnjqNbTxSsEQtdmmqI738/LwdOElS3WLnJVY1VbhmPobYmQcFRaHUovUHpMu+FnxeuJkF0bf3qRQQUCxlbZx7A37wSH74TOWF/w89IRQ8f6WF/NIt5B0LARUdSDL4niaApLq7Y4xlfWg4yGD79k9HzcfRZaqsLBI+ZO/xwA6Xt2qCmBik4I+Xjb6m5eVgTZF38NOqV4I6CTcdmrJmr07Stk3bzUGqEX1gpMaJQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HE1PR0402MB3371.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39860400002)(376002)(366004)(346002)(4326008)(186003)(83380400001)(53546011)(2906002)(8676002)(52536014)(5660300002)(7696005)(6506007)(54906003)(316002)(33656002)(8936002)(26005)(6916009)(66556008)(71200400001)(66476007)(66446008)(66946007)(76116006)(64756008)(4744005)(478600001)(9686003)(86362001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XHMp2ExyZEWRaAEW6G6A1bYXLX1s2U1Ns/FXYqhpjVDt7FKk5ATYIZXYj0i1rZArsDUuD8YgPaanqnsGHzLX826RxXsFCx+8ro7Tos+X+sK4jGmAvFVzvmiIDqeSo2aogLP3bki9aBw4x33UAu8GVdUSr102i1UibzemopiVXIFwoAs4ANE7CE22gSiSKwijRibfqqV09r/VcTeIvuodc6H2R+Te9wjNd+Kpz1VTUiNGdx0JvG+8saOvBb2PbSFHxMDK30Q1s386B4Cb0QswcH2hFPTFz7geQqA3cAoxFPRIoHdaWEa5wVGr4R2+zPYefSVXanPzZKPaBlWK7LT/QAYwJBOw4XG3RghmRNwns7yLQH0rxVsdyw9idSxqTrEB+w01lT8oa506oamSKZHibLPMFe8EQQaXs6mpt5OMuCtJLsH6mCLwqR9wrmCfrlnpbaw5pGJF/5SFMudiGtK/SkB3TE8mUOOh7RfXjutRGi2x2I/KI1C0/G65mvEKV8fW20No+R9D1QyMp7DBaXjMiyW+4vj3Cjrjkh1jPqRqKScBrT3DBVpO6XIqy2Bjhw7KG11GXJASSJg5g5Y2sN8Mp2CwjMwMKyOUYc7tLwgcosyxoiR7r7Prn0wfkyof+y3QcIxk10HahaOR9VY2sjI3hA==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0402MB3371.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c36c21a5-a274-41da-e9e3-08d843fc2109
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2020 04:55:43.6754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Zb6+H5r116Sp2ulB/5CSs9m1Gv3SiY7W7XFXyM/GPlnOjfNNe1lbtbgsY5LmczP4RNmwhMtA5WYJSlGIXCHBEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2458
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgUm9iLA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpSZWdhcmRzLA0KWmhp
cWlhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2IgSGVycmlu
ZyA8cm9iaEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIw5bm0OOaciDE45pelIDIxOjUyDQo+IFRv
OiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1rZXJuZWxAdmdl
ci5rZXJuZWwub3JnOyBQQ0kgPGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBMb3JlbnpvDQo+
IFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT47IEJqb3JuIEhlbGdhYXMNCj4g
PGJoZWxnYWFzQGdvb2dsZS5jb20+OyBBbmRyZXcgTXVycmF5DQo+IDxhbXVycmF5QHRoZWdvb2Rw
ZW5ndWluLmNvLnVrPjsgSmluZ29vIEhhbiA8amluZ29vaGFuMUBnbWFpbC5jb20+Ow0KPiBHdXN0
YXZvIFBpbWVudGVsIDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT4NCj4gU3ViamVjdDog
UmU6IFtQQVRDSHYyXSBQQ0k6IGRlc2lnbndhcmUtZXA6IEZpeCB0aGUgSGVhZGVyIFR5cGUgY2hl
Y2sNCj4gDQo+IE9uIFR1ZSwgQXVnIDE4LCAyMDIwIGF0IDM6MzUgQU0gWmhpcWlhbmcgSG91IDxa
aGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlh
bmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgY2hlY2sgd2ls
bCByZXN1bHQgaW4gdGhlIG11bHRpcGxlIGZ1bmN0aW9uIGRldmljZSBmYWlscyB0bw0KPiA+IGlu
aXRpYWxpemUuIFNvIGZpeCB0aGUgY2hlY2sgYnkgbWFza2luZyBvdXQgdGhlIG11bHRpcGxlIGZ1
bmN0aW9uIGJpdC4NCj4gPg0KPiA+IEZpeGVzOiAwYjI0MTM0Zjc4ODggKCJQQ0k6IGR3YzogQWRk
IHZhbGlkYXRpb24gdGhhdCBQQ0llIGNvcmUgaXMgc2V0DQo+ID4gdG8gY29ycmVjdCBtb2RlIikN
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0K
PiA+IC0tLQ0KPiA+IFYyOg0KPiA+ICAtIEFkZCBtYXJjbyBQQ0lfSEVBREVSX1RZUEVfTUFTSyBh
bmQgcHJpbnQgdGhlIG1hc2tlZCB2YWx1ZS4NCj4gPg0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyB8IDMgKystDQo+ID4gIGluY2x1ZGUvdWFwaS9s
aW51eC9wY2lfcmVncy5oICAgICAgICAgICAgICAgICAgIHwgMSArDQo+ID4gIDIgZmlsZXMgY2hh
bmdlZCwgMyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBSZXZpZXdlZC1ieTog
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4NCg==
