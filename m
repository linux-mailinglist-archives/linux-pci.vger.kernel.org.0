Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F93C241493
	for <lists+linux-pci@lfdr.de>; Tue, 11 Aug 2020 03:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728027AbgHKBga (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Aug 2020 21:36:30 -0400
Received: from mail-db8eur05on2089.outbound.protection.outlook.com ([40.107.20.89]:48866
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727848AbgHKBga (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Aug 2020 21:36:30 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9yFxywvCTxa7/+ycGdWSgDsGodMbzNfbC6rclJYAiiexYjBxxwDf79TrKRhywhh1gnhlhFZYx0G3lUxBAzFpe0FqH9mZ/mj20HeSqkN3sJXgG6C/yxgsx4SLWAKfZ89+bc1Eh8vQo6mUwGbMNyu0aTyIx3JSNFbc1fSjsRd5n/ySOZmqNgjnISL2Fmy8bdZyyG6AysOw1txiZ8DH3adVuIzZ43fxtsrQs8eOOXM2Jk/XIfww8DDZQDKQp6FHGPnQCsniyNJbR58aX7fHOBl0d3tV2dashlYsAOiE4jlhfYPvecH+s7wa4cBX8ZY1NwHc232OktZJK02QEGaKUaPsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LCRuB6kWI1dpZHJT+KVHWkxD15lxqwj3UdFNA3jrbk=;
 b=Lg883CmBedDsj6XlpGqJI1RMKih66vDfFPMmuRUJnJXQk59bKUhKDUE2v3w1vgj80mAMhSzNi281uJn8Ye2cyINUrCbpDawKX2v1a9WWfXztPc1qT7j7bRKtNRoaBbBh1cVb71L/p6SH6BYf318G+ztZodvodJzLe+2UxHWeZOZKqPqIxrsLyOczLrCUHTj3vdyaM/OYJTIG2nSmG0v+FHGhehyXow6TyLWCAHycRnSXmSr38u1LeQrLx0s3b9dR4/EKZkMl4+HITDNXJSyRsVDTeGqtwcbMiUxAGS3+stKOlNvIFTUWvCWjnPqXDjsaWgdtY7LDgPzdY/HwXIwLxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5LCRuB6kWI1dpZHJT+KVHWkxD15lxqwj3UdFNA3jrbk=;
 b=Qd8qHnT1M92I1pjhc8uk42I8jTv3Pz3EYcVfkG45O7Ce7iw0+Ih43qQehf6nRxCCNwfNIx4wfNwj0rL5C5YXH4JjA1JH5NJeQ6CT7HZa9UhNuxM8w/znzbZBwI8EfFRG/gj2BXHoGk9n351GOmO1Fo3HEiR1VFXrJyN/OpWuomY=
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com (2603:10a6:8:10::18)
 by DB6PR0402MB2757.eurprd04.prod.outlook.com (2603:10a6:4:94::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.16; Tue, 11 Aug
 2020 01:36:26 +0000
Received: from DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406]) by DB3PR0402MB3916.eurprd04.prod.outlook.com
 ([fe80::8db5:8715:8570:1406%7]) with mapi id 15.20.3261.025; Tue, 11 Aug 2020
 01:36:26 +0000
From:   Anson Huang <anson.huang@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     dl-linux-imx <linux-imx@nxp.com>
Subject: RE: [PATCH] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
Thread-Topic: [PATCH] PCI: imx6: Do not output error message when
 devm_clk_get() failed with -EPROBE_DEFER
Thread-Index: AQHWaiIRlBG4bNrbekyoNod9S+sWZakxFaEAgAEVipA=
Date:   Tue, 11 Aug 2020 01:36:26 +0000
Message-ID: <DB3PR0402MB391658AB241147DABB8A660DF5450@DB3PR0402MB3916.eurprd04.prod.outlook.com>
References: <1596519481-28072-1-git-send-email-Anson.Huang@nxp.com>
 <c2f17d7360387bf6d93d2ac24e5b326a542a5861.camel@pengutronix.de>
In-Reply-To: <c2f17d7360387bf6d93d2ac24e5b326a542a5861.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 8402097d-36e5-4f4b-f7cd-08d83d96f6ae
x-ms-traffictypediagnostic: DB6PR0402MB2757:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB6PR0402MB275712EA10B82D9B7E6A2216F5450@DB6PR0402MB2757.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YOqmxW+rKT8b36xM5TpjvRUKxrSV1mx2e7dh+bHTzTIYKVmQvF2gCsb3LFY1NJUBzttPfFXkjhIEpYAjuwv/XroccH0zJS7QXOjfvu0ijf6psmrJ75e8gYmhOq8dAHgkdvs8FQp3b5bQ4CiBjnqSr1281irqO55LEfOOBP4a9V1BQhZbf+ZPpDaNJzrYZvSw0Giy3Vnk5zwGhi+7ggXsdGMTRaDhPzSazFXdR5F9msAXRojPx5srNoEQXJpKLfOmFOMQ1qro0da1LmUkXae3KXhfjp3FtRW8ABVNQITmO8vwTD7w/VvhRTHOJO/oyfKLUEy16LpmwmvehcV8SxV46cjuY2Q++Lvrg5AVrTfAiJlSMgs6Q1WewlPJQX5osxI8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB3PR0402MB3916.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(39860400002)(366004)(396003)(376002)(346002)(8676002)(66556008)(66476007)(66446008)(76116006)(64756008)(71200400001)(66946007)(4744005)(7416002)(55016002)(15650500001)(86362001)(44832011)(6506007)(478600001)(110136005)(8936002)(9686003)(5660300002)(52536014)(2906002)(316002)(33656002)(4326008)(186003)(7696005)(83380400001)(26005)(921003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: 2wzY3H1lmGnL5TH7Dfa4ZHJV183H+IkUJqbzxj6+80ovW4v5xZR+3uxDWfD2Hhe1PJekcyYEruJVtH49M6vlF9oa5kuONzaY9X9usRgOGLeBDrgKQevSHgT9Tkjaj6iOWemccHrl0/H5363NKg1tfmWpCHgoJtTq2s7xhaEFjDGvg4bIX9wAhWmcqT4tmocqqlq4aTunVjPhmmP1vildvk2Y98veghSdSrEiDwXumMiI2P4ojpTqH4PVGYfwMHwrz5PM9OIzSGE+tifg1hT9qvb/pr7Ce+ep9IGs3Lejx+EImF5XvZoHECjIA1/IiKwFg5e0z0yO/YZFTtYvBN7Abet4rJqDrI/joqW8yibESIyskwiKCOQcIQUs+UBTMtGq2/TvfPnRfnN4eLj3MGptj1BeD4YRsM5U4zQtnY09dJUCHD2D1x1vlmP0It5btuU7QtCt9l1ID9SAYLrGU6dTyST5BCkMtLlq8gEtAh+NgXEb5Qv7mU/r86S0PAsnG0hKxhsWuSWRF/+EbLoGiDwYsR3yA15n+E22eYx+tOyqZO7hpvF+M9jt0rZqLClUgs104n3HhfPd9MEAVReA4FvAc+bdOWk05XXJN+bs1IaSQrdGrbi5PSoU1mZ/0Z1WYcujrVNruxsWHMjXMB39alU9YQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB3PR0402MB3916.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8402097d-36e5-4f4b-f7cd-08d83d96f6ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Aug 2020 01:36:26.2467
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ENbu1M0knPKtPB7lCdCz1NCvm8cAQXjEyiWy7MjUtAEMF05HIi515XTNWUUtrgG0jptujH1kupdoO61cZLyBNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0402MB2757
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGksIEx1Y2FzDQoNCg0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBQQ0k6IGlteDY6IERvIG5vdCBv
dXRwdXQgZXJyb3IgbWVzc2FnZSB3aGVuDQo+IGRldm1fY2xrX2dldCgpIGZhaWxlZCB3aXRoIC1F
UFJPQkVfREVGRVINCj4gDQo+IEFtIERpZW5zdGFnLCBkZW4gMDQuMDguMjAyMCwgMTM6MzggKzA4
MDAgc2NocmllYiBBbnNvbiBIdWFuZzoNCj4gPiBXaGVuIGRldm1fY2xrX2dldCgpIHJldHVybnMg
LUVQUk9CRV9ERUZFUiwgaS5NWDYgUENJIGRyaXZlciBzaG91bGQgTk9UDQo+ID4gcHJpbnQgZXJy
b3IgbWVzc2FnZSwganVzdCByZXR1cm4gLUVQUk9CRV9ERUZFUiBpcyBlbm91Z2guDQo+IA0KPiBU
aGUgcmVhc29uaW5nIGJlaGluZCB0aGlzIGNoYW5nZSBpcyBmaW5lLCBidXQgSSB0aGluayB3ZSBz
aG91bGQgdXNlIHRoZSByZWNlbnRseQ0KPiBtZXJnZWQgZGV2X2Vycl9wcm9iZSgpIGhlbHBlciB0
byBhY2hpZXZlIHRoZSBzYW1lIGdvYWwuDQoNCkFoLCB5ZXMsIGp1c3Qgbm90aWNlIHRoaXMgbmV3
IEFQSSBhZGRlZCwgcGxlYXNlIGhlbHAgcmV2aWV3IFYyLCB0aGFua3MuDQoNCkFuc29uDQoNCg==
