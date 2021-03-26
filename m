Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A48734A2C7
	for <lists+linux-pci@lfdr.de>; Fri, 26 Mar 2021 08:56:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhCZHzu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Mar 2021 03:55:50 -0400
Received: from mail-eopbgr140044.outbound.protection.outlook.com ([40.107.14.44]:26446
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230007AbhCZHzg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Mar 2021 03:55:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k6u5ckM3SlxPslrb7QggSUZ8cOHgir5d1tAYSKQ63djoE7IU607Bx4P8t7bWGtgMjBiytwsfmRibl0BKOhbDmndAR7x9e6RXzmCpHgXjzJQoZQUkV50jjJcEJ9wNz613J1bO5OJIUqNwfXLK/iJaGQNxCMr4/1UBgulje1Iz31+hqV9A/cKLE9SwOQUdW4dPVSiL48nkhtzHFOvQdZ1zUXbSZFSh9haSTsLVFPxnhGxwJZd9lXzOZsPayK3AxAillfaFDEDbwkH0zL5LzwAnTm34RobgK7ph9FzLc9p96jEStm/iQ2hwuKjqaEpYjmEBuvQrwybniHvbQjG+N9+uOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xapetZYF7j6+i5bIGqSn9wr+roSBgt++ZDz4119jtAA=;
 b=bO+Ts/+CNh025Lg4ppf8wrM4yPm+jv3sAm7Yt9ezA1rUBikrH+xVJIjjjHazi0xyDaiuH4XDV0Q7Jbk1+pXC5qIJbQIGM2fTB7cBgnvBzYvPi6crdO+6cSXHlzUXacj62hBj48VU7OzO53rOSZB4Z1T3pxuMgRzGDQn8WiJZ8dT09pmBps+pJV7hYPxjuZaBESfO7Y1l4n67yrJRN0zPvneMtKSdGZvzIs4KAiJTj1aBZB/+DwiGTehoPJmvfqZNgjbEhHl4THBpehWCzcSapIu4S3qJ5NQg8yglEH8p/mCgrcXEtwF82VdMpdMyK5dWsdZWCkRa1sCG+DSQReoQFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xapetZYF7j6+i5bIGqSn9wr+roSBgt++ZDz4119jtAA=;
 b=UOju0AebmG9XXInVDEomPBPC1a9O2fxhK06rOfUPwBiNkFvOfwSfExwa6t/Op3Hu5aazqAfbAeKousilHaC+pjg5KK6u5rOHCGbdnWLZA9WhL9y70PIDrLDal/vrs3tYsGcaCTyYgNFkqXnQ/R9yLMdFY9w0I6XUzoNV/5bsQRs=
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com (2603:10a6:803:e3::25)
 by VI1PR0401MB2301.eurprd04.prod.outlook.com (2603:10a6:800:2e::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.25; Fri, 26 Mar
 2021 07:55:34 +0000
Received: from VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f]) by VI1PR04MB5853.eurprd04.prod.outlook.com
 ([fe80::8116:97ef:2fd7:251f%7]) with mapi id 15.20.3977.030; Fri, 26 Mar 2021
 07:55:34 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>
CC:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "andrew.smirnov@gmail.com" <andrew.smirnov@gmail.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE:  Re: [PATCH v3 3/3] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Thread-Topic: Re: [PATCH v3 3/3] PCI: imx: clear vreg bypass when pcie vph
 voltage is 3v3
Thread-Index: AdciFH0V4LmURbFcRMeMT6KV9BEEag==
Date:   Fri, 26 Mar 2021 07:55:34 +0000
Message-ID: <VI1PR04MB5853077653BBA73ACF58CF3F8C619@VI1PR04MB5853.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: linux.com; dkim=none (message not signed)
 header.d=none;linux.com; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.67]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1751a4cc-6c0f-4ead-ad02-08d8f02c894e
x-ms-traffictypediagnostic: VI1PR0401MB2301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <VI1PR0401MB2301B69504477532D155462C8C619@VI1PR0401MB2301.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UMzE74ruNlmo/SlhcRgM/hQkey07DK+umsuMQ9awm6YrkINM6J+vxuCIOwEi7h9alhiq3w6XjA74MxuziyHax913mYhz/zd7K2Pb66ov2lOpOQ4zkQXhvseAwgwPEfF1XXd+DrgIM6Pmc6ZKxuO/eoaah6Im3vdJ0+EYBPCK9bDNMxwmHjKIVG6JagyzB4rDs8pd/9zc4/SE+7xJUUTC8F398WQr3gVREw1VuMy716yc23Cy+reshPM2Ao0Xu03syFwOjGE/yefCWd0y+IntBXK8pXeMQshABWYVgjKm39U5gWljy5DDLn3ZsdYMcz7YnDy7UqTmugyq+bVUqz3oH2QY2IolBXn1QIBztzvYkQ0iFKJOVPlvgKSMCCn2joBPr2MOs+2qlpzuw10OqCBRTs8EBlxzJ3QvGSIqGYDuoHwa9t9/3zzgYEdc1N43BNy6bmH4ROQSEBhStKfVWbRGzDP6iLfRdObb950MdtvVYMNkeqr0GMdWuFFczr8ipDgilldu2eBuQcKUyVIdXZe4ywn8W5vn+5kGNZzu1lpGcXh971fAu7ZEd1+cVJc4sXyZgJnSzuBcYxt2ThSQD2byw19OAcvR2NyfPDO5Lx5hehJ2m1w+t+gqAhKiw+WWYVXslqWWe+kJSShwsI6qncC7J1G7ow73jZua9VuDVQ2S8qU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5853.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(396003)(376002)(366004)(346002)(39860400002)(9686003)(38100700001)(66476007)(83380400001)(86362001)(66946007)(53546011)(5660300002)(66446008)(52536014)(76116006)(64756008)(33656002)(66556008)(6506007)(8936002)(2906002)(6916009)(7416002)(4326008)(8676002)(71200400001)(54906003)(7696005)(186003)(316002)(26005)(478600001)(55016002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?utf-8?B?ZGtoeXpXd3d6bktqclhTUXQveVlGR0wxSi9MRnBYdjRSRWZzeWJBd3VSQWox?=
 =?utf-8?B?QVpZUlczSEJBeG04UHBHb2FQUzVKQVpweVJNZ2svK25SNklTYlIvdmdtS001?=
 =?utf-8?B?Tjh3THBxZ0dQMjZ5ZTFlQ0xQRlBQTFlHcWpuYUo1eXBwQkZWQkx2OHcyTWZC?=
 =?utf-8?B?NFBsYVgxUHRuSmJlcDYxclNCeG4wNFFKSUhNbk5PMmFHcHBHYjZVS0ZkNHFV?=
 =?utf-8?B?NTBVdXRlL0dlWFlJZlZBUVBrYk9welYrdEdiSDltbC81NGdwdm9Kd0dNQXZP?=
 =?utf-8?B?aHJiK0JpVEdBVGNGbzhGK1ZrNVJ4SVMyUDQ4VERFVlBLQjE0SllBOEN2QXhi?=
 =?utf-8?B?ZDFNdFFXWWxxTmdHTWtrVUJkOWRIak1vajVKSHQrTjR1aFlxSjcxZW1HOEwy?=
 =?utf-8?B?RUxTekNzemIvSjF6d3phc1ZneHZveWRpLzg5YURxYzArK09VTW1HZWFWckZU?=
 =?utf-8?B?eWRFdG5rWEdReHlMUVpTY2hDdWQ3b0lnSlBYQkNWRUt0RTdlUU11c2lPaG1O?=
 =?utf-8?B?c0IwNm4zaktQY2tINmp4bDJZU3Q2R2I4NExoWmxhNk9INXlNdXg0M0ZCVXpZ?=
 =?utf-8?B?Z3VDTnRJSTlibGtzS25wZjBXeE9MRVhKUHBYYzdtem5PY012V1p3NkhJTk9H?=
 =?utf-8?B?czZQd1U0SlEzVGNmWmNGbnhFYmp3aGl6TCtHeE8rNVNMYlp4SHl6QzhkTmRm?=
 =?utf-8?B?Yzd4RXFKanNlakhGVERwM21CU29XOG9ZTFVVUCtrck03c1dhMTlhZGNVWHJ3?=
 =?utf-8?B?d1BUVTQzUThlamRnaTdvZ0cvTFFkUjlmc3N3Sk9qY1R4dHNHQzRTOUZWcG9Q?=
 =?utf-8?B?U3BPaUYxejlRUkxwdy93aVpiM0Q1ekwrbjVNdUcrUHJYQmovUjU3T0xaUjAr?=
 =?utf-8?B?cVNCY2psTEpMOWhKS2JweFRRNTB6d2l0NEhvQ2RjcVdQdTRQOWwyWXNBKzJu?=
 =?utf-8?B?Nk5JaCtpNStJQkdYa1RqYjdiKy8zYWNkNjVITk1IdjYvT3dXNHFrdUdvQXNQ?=
 =?utf-8?B?UHhhRVk3WDVPQlFrN09WaytzalYzbW5YcnJvYTlHZGtPYm9LN2hBY3ZjZXdJ?=
 =?utf-8?B?bU94OUdQeElMYWduRmNTQ3UyY2lyTXlicnh3Zm82Wnp4dU50MWJONlcydXF6?=
 =?utf-8?B?a0VML3BsZlpvcTF1TWs3dnRTdFp6b0RiRGppREhud3FtTEgvN3RvNDlLZU5u?=
 =?utf-8?B?UTRKZTg0Si9aTENyV1hJZFdmN1hLUU5QSC8rV3UzdHpibUlEa1FRbVRnWUVz?=
 =?utf-8?B?MmJWRWhQM0lUVjZDbDdKZmpyMjZ2bGhmL0FaZzNwbUF0STk3VVFGeUdtMmxj?=
 =?utf-8?B?ejQ2dTMxbVIrd0dVZmRMRUVHRnVUZ0JuQUh5K2RnTTFTUjMxUFlTWWJKa01s?=
 =?utf-8?B?aWZKcWFFbEkwU2tTSzRNbHcvc3REajJCSko5Z1JEcUpDZWdERG1PR1dZTVd0?=
 =?utf-8?B?cGVIQUJjM1FsdEpUdDdQN3NEV2dxeUF4Ylp4d1pPOG9tNDYzdDY1WVVmWEpm?=
 =?utf-8?B?UGlXWklZU1Azb2RQZ2VYbWZKVVUxYndZNSt1WXIxaFV0SElIWmdVRG5rbjR3?=
 =?utf-8?B?T3c2NXM5ZUZ2dHdzSHBMSDUrTG1HWGU4WEhtdHZ1YmFyT3RHUFBYRm5taU5v?=
 =?utf-8?B?MkJtZWozejhQU3BvUVZORG03OUl4WVN5cGVaMFVMeUNFTDhxRXp0YlBneFlh?=
 =?utf-8?B?TFNNMjMxOTN1WHJhdjdEQjNJR2dnV3crcUc3LzFlcXlaaEM0WlE1NkRVSncv?=
 =?utf-8?Q?3QzaAfcMqvKB34x3Ol/pCK1yKAIw5G1ZDCaRA8K?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5853.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1751a4cc-6c0f-4ead-ad02-08d8f02c894e
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2021 07:55:34.4727
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nEHyMKh1wEyZq3uETDKQvkZfVvoleaI6NQuzwq/DOCRB0InvrrnBdwdq1rIhnJ0U7kJ0p3n8HES09VtdE0hAug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2301
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBLcnp5c3p0b2YgV2lsY3p5xYRz
a2kgPGt3QGxpbnV4LmNvbT4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAyNiwgMjAyMSAzOjQ2IFBN
DQo+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBsLnN0YWNo
QHBlbmd1dHJvbml4LmRlOyBhbmRyZXcuc21pcm5vdkBnbWFpbC5jb207DQo+IHNoYXduZ3VvQGtl
cm5lbC5vcmc7IGJoZWxnYWFzQGdvb2dsZS5jb207IHN0ZWZhbkBhZ25lci5jaDsNCj4gbG9yZW56
by5waWVyYWxpc2lAYXJtLmNvbTsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgt
aW14DQo+IDxsaW51eC1pbXhAbnhwLmNvbT47IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFk
ZWFkLm9yZzsNCj4gbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsga2VybmVsQHBlbmd1dHJv
bml4LmRlDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMy8zXSBQQ0k6IGlteDogY2xlYXIgdnJl
ZyBieXBhc3Mgd2hlbiBwY2llIHZwaA0KPiB2b2x0YWdlIGlzIDN2Mw0KPiBIaSwNCj4gDQo+ID4g
KyAgICAgICAgICAgICAvKg0KPiA+ICsgICAgICAgICAgICAgICogUmVnYXJkaW5nIHRvIHRoZSBk
YXRhc2hlZXQsIHRoZSBQQ0lFX1ZQSCBpcyBzdWdnZXN0ZWQNCj4gPiArICAgICAgICAgICAgICAq
IHRvIGJlIDEuOFYuIElmIHRoZSBQQ0lFX1ZQSCBpcyBzdXBwbGllZCBieSAzLjNWLCB0aGUNCj4g
PiArICAgICAgICAgICAgICAqIFZSRUdfQllQQVNTIHNob3VsZCBiZSBjbGVhcmVkIHRvIHplcm8u
DQo+ID4gKyAgICAgICAgICAgICAgKi8NCj4gWy4uLl0NCj4gDQo+IEEgc21hbGwgbml0cGljayBo
ZXJlLiAgV2hhdCBhYm91dCB0aGUgZm9sbG93aW5nOg0KPiANCj4gICAgICAgICBSZWdhcmRpbmcg
dGhlIGRhdGEgc2hlZXQsIHRoZSBQQ0lFX1ZQSCBpcyBzdWdnZXN0ZWQgdG8gYmUgMS44Vi4NCj4g
ICAgICAgICBJZiB0aGUgUENJRV9WUEggaXMgc3VwcGxpZWQgd2l0aCAzLjNWLCB0aGUgVlJFR19C
WVBBU1Mgc2hvdWxkIGJlDQo+ICAgICAgICAgY2xlYXJlZCB0byB6ZXJvLg0KPiANCj4gV2hhdCBk
byB5b3UgdGhpbms/DQpbUmljaGFyZCBaaHVdIEhpIEtyenlzenRvZjoNClRoYW5rcyBmb3IgeW91
ciBjb21tZW50cy4gWW91J3JlIHJpZ2h0Lg0KSXQgc2hvdWxkIGJlICJSZWdhcmRpbmcgc29tZXRo
aW5nIiwgbm90IHRoZSAiUmVnYXJkaW5nIHRvIHNvbWV0aGluZyINClRoYW5rcy4g8J+Yig0KDQpC
ZXN0IFJlZ2FyZHMNClJpY2hhcmQgWmh1DQoNCj4gDQo+IEtyenlzenRvZg0K
