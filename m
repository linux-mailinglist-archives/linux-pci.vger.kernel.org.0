Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232444343D0
	for <lists+linux-pci@lfdr.de>; Wed, 20 Oct 2021 05:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbhJTDYp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Oct 2021 23:24:45 -0400
Received: from mail-eopbgr80070.outbound.protection.outlook.com ([40.107.8.70]:36975
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229555AbhJTDYo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Oct 2021 23:24:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ciat/dZFr6gA64Z6p5jC6yRl3Ck1XdBSNzUXXS+IrLhW+NDf9QUHJmWehomRhtSzEdRqz3/wj63dRsocrEPe9+wRqDr8qLcn/KCXkw7Ls2gfG9W2Q4rwxd0/w1P0c49ihyh4kqYYiH5bqJR7vt5CzShC2w77tl9iLkeNTT+KKUuy4K6tsigS8kWhCYWB8Rds0WFDdB0JzMnL/tjC6qO0dDoc6I+HL5K/cMDoc5VkPXqhbpzZc4A7mkbl9CjP6aA8dgmgGjDYY1gt23/xUXr6wf8QisHwQZ4ABVhMbHiwPSxKdOtdPI0Qkmi7gWcM7AlNH89UcbnE0++HEFzd2h4OUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kwqk8KyLExSgEuRlta7PWwX9K7PRjtulaOfk+ltPxg=;
 b=B7tOnHSv8wJqDnXo1N+l9iDiTUEnspLDMFFX7aA+F5hVkWy6F59WNncdq/zXxuXv1emMeGBkyD8ldR7fjduWxEMYvktp+2VgvOEtAAaQMZofZwAsOFJxu7GtE2OqtF+C1zVd+otkj597lbLjkWGakakdEhcmDojOi0TaidO9cSAkxryNnc4AC8evlWjW7KkCLGnSO/td85M3q0I7/F244HEpLkDldYyq2AA1glnl2gtXUdmWGFXUMK1MJohfPzPEdsg/US7sN5T8mY1YR/tJU5Ouu5NrCbylk5tKUnYswyxHWJKy2TnsC4cNLVfD/OEUFpp3TIjq0mvRdSxzFeVqXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kwqk8KyLExSgEuRlta7PWwX9K7PRjtulaOfk+ltPxg=;
 b=cMzOGnndeeOd/Sah4Jt6gtg+d9Y0MKNAzvMvjL5ofCvHMoyc3pBdOkXlvmanNGSXpBMdn3X8635QPrO2tLaJLVcLie7lIHjyMR6/6JzXsxUSFOpnuQbjF/ptUI1xx/ejT/UrngJr4ETtQuRVF8oYLs7YJ7AvubFr+WuwBtzgtto=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8851.eurprd04.prod.outlook.com (2603:10a6:20b:42e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4608.17; Wed, 20 Oct
 2021 03:22:28 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::b059:46c6:685b:e0fc%4]) with mapi id 15.20.4608.018; Wed, 20 Oct 2021
 03:22:28 +0000
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     Lucas Stach <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [RESEND v2 3/5] PCI: imx6: Fix the regulator dump when link
 never came up
Thread-Index: AQHXwY4tcTr8p7Uwa0qomeYelO+fgavUYCcAgAWT+PCAAUsLYA==
Date:   Wed, 20 Oct 2021 03:22:28 +0000
Message-ID: <AS8PR04MB8676D56073721F622FCB419E8CBE9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1634277941-6672-1-git-send-email-hongxing.zhu@nxp.com>
         <1634277941-6672-4-git-send-email-hongxing.zhu@nxp.com>
 <8f855cf445e2b7827524d5d4adfba80d3a924c60.camel@pengutronix.de>
 <AS8PR04MB8676CC1AFB9399776F75156F8CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
In-Reply-To: <AS8PR04MB8676CC1AFB9399776F75156F8CBD9@AS8PR04MB8676.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 17293ef5-31c2-43f8-111b-08d99378d899
x-ms-traffictypediagnostic: AS8PR04MB8851:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AS8PR04MB88519C674F842F212BC6B6C58CBE9@AS8PR04MB8851.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7zBY4l/lIMQXxBCjsEk4Snjz8N7ClLL3Me9L8zzKgl+mhNHVDw4/gkgksLfR6hOc3l8P1yRIQG2VdDETgg8ypyrD2lMKlVemGdbLqiiuavnZtRFWzome8+ckTYEU0N7bD4gEX4FehOWXU848xxzubOeXbl19D2D6GI1Cma3ojRI2F61sVG5BcYp28PHaBi+9o0LzCpHGqR5UtJj1v8voy81jN5XPhnRdjjvpyt3QTCRRdp5T061GzsJzisu4qi7+qYbBv4N2XhXfrT6WLRiKoQ0xwmBokwv4HuIk9fkWRRSzFYWeyzAjMt+/CXGFFgPy/+36j8dQHxR5BBOzEW14SKCfjQ71EEScFSMeoUDTqRWcY/O9e38f46qwfqVMK2g8tN+e+A0OjM5ZD1h8v4wAacN2XNubtK0dPhzZVrQ1XDrKPZfcAQy4s4t+ZOc6XAAzgOhTowbtnEGBvwuoFBm18ssIg3FB/CPP564RnyppiZTTBkVDbGA8cbkQG8ZUHZMAVJ6/Ezup/j/C4BIkJTi4EVYeJGWzSuKgIOxjEqT/WMlGteIrGUDwviaCSje63ESnHah6JfRO2OiGXBC77+0jdKzPCFHkvaYyuIgGvlyhct3Khed+V0w+HP8+zrBgie7BFNd1DLI7H/oxoroOufb+1FhFOthdHQSWlMn1mg4C0jxsvwHvBA/EvskEn067CbPIY4jArUv5ljdIjuXLGHmbiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(53546011)(38100700002)(86362001)(122000001)(66946007)(83380400001)(6506007)(4326008)(498600001)(52536014)(64756008)(26005)(5660300002)(45080400002)(110136005)(9686003)(2906002)(8936002)(71200400001)(54906003)(76116006)(8676002)(186003)(38070700005)(7696005)(33656002)(66476007)(55016002)(66446008)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NEFJSXFtL21VakFJanRJLytUV1NxbnNBMDJlbk44YUhMNXZWbVpxbCsxRHpO?=
 =?utf-8?B?SDZmT3pWK3ErTEgrWmdHak95QUFneWR6Rk9Sb0hwT0VCQVpYZEhWaHI1b3VP?=
 =?utf-8?B?Tkx5a3pHczU5dW16cll6MExWNC9VbUJjbzNKaUlzSFdaUkU4MWNPdzcyWUE2?=
 =?utf-8?B?azJoNk9EaDNxbHZHbmlXQXAyRFROdXZheWV6TWZySzVBTngwV0I2c2lOcDNW?=
 =?utf-8?B?aWhQWGNGaEFyZE5HcWMzZVRxUVlsL0tKUVgyR0twUTNCRWptU29sUzVHWWhX?=
 =?utf-8?B?ejUyWlBHaVBWeTBuZUZobHJwbmtRL2NnbVcxNFlmU2pCSmszdEhMY0hlSUtm?=
 =?utf-8?B?WGxXSDZMMkl3YVR2YTN1N1pNTS9FdFVaNWV6b1pPbjd1WFp2Vjk3aWtJaFdh?=
 =?utf-8?B?bHp5QVR5cVh4MURhUUlsWjVJTW5iOURKV2llakZpMlFXMGZObkRNNVNZd1I0?=
 =?utf-8?B?aGVxMXlIeUpYc2hZU1N1OHNSMU1QbjFpWE84SjY3ckg5TVlDVDJteUZTeXpl?=
 =?utf-8?B?TDFSYlZBY2xNZ3NScjYrdFpnMSs2QmZMWDhoVzd6Y2VMNDBJZUN5VzB3ck5N?=
 =?utf-8?B?d3g2VXN1TEp6M0JKNHFVd0dZL3pjeHlra2NoVG0yQzBEY1BVLzVYblpzMVI4?=
 =?utf-8?B?MmUvMFl1N3F0aEtPME4xUXhOWm1KK0Y3SG5OK0taRlBleGE3UHJKRU5EeFVH?=
 =?utf-8?B?VnhpZjFsMElEaEoyaGd2S1U4T0tZQjllQWkxQzd1bWM0ckkvOVIzaFBhcC9h?=
 =?utf-8?B?VXVKZlc2ZnFaSTFtaU5SMzRyWGdMejE5ZkVzNkZFT3FiWkIwMjloQktTdVRE?=
 =?utf-8?B?UGlWSlRzYTVyRDl1dm9lOU1VUitpSHNlc2E2SjdicTI2bGlrWE1VWjdLNStt?=
 =?utf-8?B?WjR0MmxZQjMwWEFRMjZrTytpRlR1cEtZTktrMnVrTXVaWTcxVS9rOG1PQWl3?=
 =?utf-8?B?aG1qaUhOcUJmTmg5M1ZMR2xMUCtON0cwTnBma0dXeEU3Mmh4cUJZVVorTFBG?=
 =?utf-8?B?SnVqajZ4WFpzTFhXR2E2c1dVYXJhUmFnZ0RCMXZSV0RjSEV5bkdTMXVJa0dv?=
 =?utf-8?B?YVF1VENaeFdmaUlFaU14NHl1bkZ2UElVSXYxZEQ2YTRVaytOQUQrN0hockRG?=
 =?utf-8?B?MHFkYVpydEl2SDRGc3phaEh4TWltVjI3eHM4S0lHWitZdUxMamxjU0lqVTBu?=
 =?utf-8?B?eWlkWXFKU0cyQmx1QkQ2TU9UTGtWLzR4ZjFwU09rN3AzWDF1RmFWcGw5bjc3?=
 =?utf-8?B?Q3EvVTJ3TXFyQm8zOGpTM2s5S1NDZWdSakJqNVNUMVRsNGY2dHJlemJxSVAx?=
 =?utf-8?B?U1gvdVBEekxvUjhGTnRTYmwxMnhCeEhjOVNuMEdkZkZKMnJIS0F3R1JOS1dG?=
 =?utf-8?B?VEExaVgxdkZuYzBHaDlHanZYR3BRVExrYlU1UGcwWXVSVC9DRkhEV0hMa1RG?=
 =?utf-8?B?YW84cWExdlIzNUJnM2IzOGJyZUJibTBCamM0NWs2VCtEa1dlZmtHdXhmL1Qw?=
 =?utf-8?B?MUpwNElJdTgzakVJUFJidUNZRWluU0l3OUMweHJ2VzFBVVVrRjBKNnF1enV1?=
 =?utf-8?B?TG9mQzlES2R6S0piK2xqS0JEOS9NT20rOW5YY1Vqei8vYy9Pb2lTWTJzUTlR?=
 =?utf-8?B?cHdpNUgrM2FuODg0UThjcFQ4U0ltNWNSc2JiOGhCdXdKd3RnM0kyZ0trN0xE?=
 =?utf-8?B?bFRVMWE2cDYrRTI0RnRjVDFHUytCWkN3NXl5TU1xRDJhdXJYeGEraW1veVZu?=
 =?utf-8?Q?uS38s6EByHNkTQTPM0iFrmQFNfzRqXL03YT9vZi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17293ef5-31c2-43f8-111b-08d99378d899
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Oct 2021 03:22:28.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zgJvTRaUItxtrFe6YavR7q5GcM3RpSaL0q/TRRb3miUb1feV4xDEEA4aprzjCj4YXGeMV/AEoEmw8L2ZzRuq7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8851
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSaWNoYXJkIFpodQ0KPiBTZW50
OiBUdWVzZGF5LCBPY3RvYmVyIDE5LCAyMDIxIDM6NDAgUE0NCj4gVG86IEx1Y2FzIFN0YWNoIDxs
LnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gbG9yZW56by5w
aWVyYWxpc2lAYXJtLmNvbQ0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGwtbGlu
dXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4ga2VybmVsQHBlbmd1
dHJvbml4LmRlDQo+IFN1YmplY3Q6IFJFOiBbUkVTRU5EIHYyIDMvNV0gUENJOiBpbXg2OiBGaXgg
dGhlIHJlZ3VsYXRvciBkdW1wIHdoZW4gbGluaw0KPiBuZXZlciBjYW1lIHVwDQo+IA0KPiA+IC0t
LS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gRnJvbTogTHVjYXMgU3RhY2ggPGwuc3RhY2hA
cGVuZ3V0cm9uaXguZGU+DQo+ID4gU2VudDogU2F0dXJkYXksIE9jdG9iZXIgMTYsIDIwMjEgMjoy
MyBBTQ0KPiA+IFRvOiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBiaGVsZ2Fh
c0Bnb29nbGUuY29tOw0KPiA+IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20NCj4gPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgZGwtbGludXgtaW14IDxsaW51eC1pbXhAbnhwLmNvbT47
DQo+ID4gbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBsaW51eC1rZXJuZWxA
dmdlci5rZXJuZWwub3JnOw0KPiA+IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiA+IFN1YmplY3Q6
IFJlOiBbUkVTRU5EIHYyIDMvNV0gUENJOiBpbXg2OiBGaXggdGhlIHJlZ3VsYXRvciBkdW1wIHdo
ZW4NCj4gPiBsaW5rIG5ldmVyIGNhbWUgdXANCj4gPg0KPiA+IEFtIEZyZWl0YWcsIGRlbSAxNS4x
MC4yMDIxIHVtIDE0OjA1ICswODAwIHNjaHJpZWIgUmljaGFyZCBaaHU6DQo+ID4gPiBXaGVuIFBD
SWUgUEhZIGxpbmsgbmV2ZXIgY2FtZSB1cCBhbmQgdnBjaWUgcmVndWxhdG9yIGlzIHByZXNlbnQs
DQo+ID4gPiB0aGVyZSB3b3VsZCBiZSBmb2xsb3dpbmcgZHVtcCB3aGVuIHRyeSB0byBwdXQgdGhl
IHJlZ3VsYXRvci4NCj4gPiA+IERpc2FibGUgdGhpcyByZWd1bGF0b3IgdG8gZml4IHRoaXMgZHVt
cCB3aGVuIGxpbmsgbmV2ZXIgY2FtZSB1cC4NCj4gPiA+DQo+ID4gPiAgIGlteDZxLXBjaWUgMzM4
MDAwMDAucGNpZTogUGh5IGxpbmsgbmV2ZXIgY2FtZSB1cA0KPiA+ID4gICBpbXg2cS1wY2llOiBw
cm9iZSBvZiAzMzgwMDAwMC5wY2llIGZhaWxlZCB3aXRoIGVycm9yIC0xMTANCj4gPiA+ICAgLS0t
LS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0tLS0tLS0tDQo+ID4gPiAgIFdBUk5JTkc6IENQVTog
MyBQSUQ6IDExOSBhdCBkcml2ZXJzL3JlZ3VsYXRvci9jb3JlLmM6MjI1Ng0KPiA+IF9yZWd1bGF0
b3JfcHV0LnBhcnQuMCsweDE0Yy8weDE1OA0KPiA+ID4gICBNb2R1bGVzIGxpbmtlZCBpbjoNCj4g
PiA+ICAgQ1BVOiAzIFBJRDogMTE5IENvbW06IGt3b3JrZXIvdTg6MiBOb3QgdGFpbnRlZA0KPiA+
IDUuMTMuMC1yYzctbmV4dC0yMDIxMDYyNS05NDcxMC1nZTRlOTJiMjU4OGEzICMxMA0KPiA+ID4g
ICBIYXJkd2FyZSBuYW1lOiBGU0wgaS5NWDhNTSBFVksgYm9hcmQgKERUKQ0KPiA+ID4gICBXb3Jr
cXVldWU6IGV2ZW50c191bmJvdW5kIGFzeW5jX3J1bl9lbnRyeV9mbg0KPiA+ID4gICBwc3RhdGU6
IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPIC1UQ08gQlRZUEU9LS0pDQo+ID4gPiAgIHBj
IDogX3JlZ3VsYXRvcl9wdXQucGFydC4wKzB4MTRjLzB4MTU4DQo+ID4gPiAgIGxyIDogcmVndWxh
dG9yX3B1dCsweDM0LzB4NDgNCj4gPiA+ICAgc3AgOiBmZmZmODAwMDEyMmViYjMwDQo+ID4gPiAg
IHgyOTogZmZmZjgwMDAxMjJlYmIzMCB4Mjg6IGZmZmY4MDAwMTFiZTcwMDAgeDI3Og0KPiAwMDAw
MDAwMDAwMDAwMDAwDQo+ID4gPiAgIHgyNjogMDAwMDAwMDAwMDAwMDAwMCB4MjU6IDAwMDAwMDAw
MDAwMDAwMDAgeDI0Og0KPiBmZmZmMDAwMDAwMjVmMmJjDQo+ID4gPiAgIHgyMzogZmZmZjAwMDAw
MDI1ZjJjMCB4MjI6IGZmZmYwMDAwMDAyNWYwMTAgeDIxOiBmZmZmODAwMDEyMmViYzE4DQo+ID4g
PiAgIHgyMDogZmZmZjgwMDAxMWUzZmE2MCB4MTk6IGZmZmYwMDAwMDM3NWZkODAgeDE4OiAwMDAw
MDAwMDAwMDAwMDEwDQo+ID4gPiAgIHgxNzogMDAwMDAwMDQwMDQ0ZmZmZiB4MTY6IDAwNDAwMDMy
YjU1MDM1MTAgeDE1Og0KPiA+IDAwMDAwMDAwMDAwMDAxMDgNCj4gPiA+ICAgeDE0OiBmZmZmMDAw
MDAwM2NjOTM4IHgxMzogMDAwMDAwMDBmZmZmZmZlYSB4MTI6IDAwMDAwMDAwMDAwMDAwMDANCj4g
PiA+ICAgeDExOiAwMDAwMDAwMDAwMDAwMDAwIHgxMDogZmZmZjgwMDAxMDc2YmE4OCB4OSA6IGZm
ZmY4MDAwMTA3NmE1NDANCj4gPiA+ICAgeDggOiBmZmZmMDAwMDAwMjVmMmMwIHg3IDogZmZmZjAw
MDAwMDFmNDQ1MCB4NiA6IGZmZmYwMDAwMDAxNzZjZDgNCj4gPiA+ICAgeDUgOiBmZmZmMDAwMDAz
ODU3ODgwIHg0IDogMDAwMDAwMDAwMDAwMDAwMCB4MyA6IGZmZmY4MDAwMTFlM2ZlMzANCj4gPiA+
ICAgeDIgOiBmZmZmMDAwMDAwM2NjNGMwIHgxIDogMDAwMDAwMDAwMDAwMDAwMCB4MCA6IDAwMDAw
MDAwMDAwMDAwMDENCj4gPiA+ICAgQ2FsbCB0cmFjZToNCj4gPiA+ICAgIF9yZWd1bGF0b3JfcHV0
LnBhcnQuMCsweDE0Yy8weDE1OA0KPiA+ID4gICAgcmVndWxhdG9yX3B1dCsweDM0LzB4NDgNCj4g
PiA+ICAgIGRldm1fcmVndWxhdG9yX3JlbGVhc2UrMHgxMC8weDE4DQo+ID4gPiAgICByZWxlYXNl
X25vZGVzKzB4MzgvMHg2MA0KPiA+ID4gICAgZGV2cmVzX3JlbGVhc2VfYWxsKzB4ODgvMHhkMA0K
PiA+ID4gICAgcmVhbGx5X3Byb2JlKzB4ZDAvMHgyZTgNCj4gPiA+ICAgIF9fZHJpdmVyX3Byb2Jl
X2RldmljZSsweDc0LzB4ZDgNCj4gPiA+ICAgIGRyaXZlcl9wcm9iZV9kZXZpY2UrMHg3Yy8weDEw
OA0KPiA+ID4gICAgX19kZXZpY2VfYXR0YWNoX2RyaXZlcisweDhjLzB4ZDANCj4gPiA+ICAgIGJ1
c19mb3JfZWFjaF9kcnYrMHg3NC8weGMwDQo+ID4gPiAgICBfX2RldmljZV9hdHRhY2hfYXN5bmNf
aGVscGVyKzB4YjQvMHhkOA0KPiA+ID4gICAgYXN5bmNfcnVuX2VudHJ5X2ZuKzB4MzAvMHgxMDAN
Cj4gPiA+ICAgIHByb2Nlc3Nfb25lX3dvcmsrMHgxOWMvMHgzMjANCj4gPiA+ICAgIHdvcmtlcl90
aHJlYWQrMHg0OC8weDQxOA0KPiA+ID4gICAga3RocmVhZCsweDE0Yy8weDE1OA0KPiA+ID4gICAg
cmV0X2Zyb21fZm9yaysweDEwLzB4MTgNCj4gPiA+ICAgLS0tWyBlbmQgdHJhY2UgMzY2NGNhNGE1
MGNlODQ5YiBdLS0tDQo+ID4gPg0KPiA+ID4gU2lnbmVkLW9mZi1ieTogUmljaGFyZCBaaHUgPGhv
bmd4aW5nLnpodUBueHAuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpLWlteDYuYyB8IDIgKysNCj4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNl
cnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
LWlteDYuYw0KPiA+ID4gaW5kZXggMzM3Mjc3NTgzNGEyLi5jYzgzN2Y4YmY2ZDQgMTAwNjQ0DQo+
ID4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiAr
KysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gPiBAQCAtODUz
LDYgKzg1Myw4IEBAIHN0YXRpYyBpbnQgaW14Nl9wY2llX3N0YXJ0X2xpbmsoc3RydWN0IGR3X3Bj
aWUNCj4gKnBjaSkNCj4gPiA+ICAJCWR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9QT1JUX0RF
QlVHMCksDQo+ID4gPiAgCQlkd19wY2llX3JlYWRsX2RiaShwY2ksIFBDSUVfUE9SVF9ERUJVRzEp
KTsNCj4gPiA+ICAJaW14Nl9wY2llX3Jlc2V0X3BoeShpbXg2X3BjaWUpOw0KPiA+ID4gKwlpZiAo
aW14Nl9wY2llLT52cGNpZSAmJiByZWd1bGF0b3JfaXNfZW5hYmxlZChpbXg2X3BjaWUtPnZwY2ll
KSA+DQo+IDApDQo+ID4gPiArCQlyZWd1bGF0b3JfZGlzYWJsZShpbXg2X3BjaWUtPnZwY2llKTsN
Cj4gPg0KPiA+IFRoaXMgZG9lc24ndCBzZWVtIGxpa2UgdGhlIHJpZ2h0IHBsYWNlIHRvIGFkZCB0
aGlzLiBJIGd1ZXNzIGl0IHdvdWxkDQo+ID4gYmUgYmV0dGVyIHRvIGhhdmUgcHJvcGVyIGVycm9y
IGhhbmRsaW5nIGFmdGVyIGR3X3BjaWVfaG9zdF9pbml0IHRvDQo+ID4gcm9sbCBiYWNrIHRoaW5n
cyBsaWtlIHRoZSBjbG9jayBhbmQgcmVndWxhdG9yIGVuYWJsZS4NCj4gW1JpY2hhcmQgWmh1XSBU
aGlzIGlzIGdvb2Qgc3VnZ2VzdGlvbi4gSXQncyBtYWtlIHNlbnNlIHRoYXQgbW92ZSB0aGUgcmVn
dWxhdG9yDQo+IGRpc2FibGUgdG8gdGhlIGR3X3BjaWVfaG9zdF9pbml0IGVycm9yIGhhbmRsaW5n
IHNpbmNlIHRoZSByZWd1bGF0b3IgaGF2ZSB0aGUNCj4gZW5hYmxlZCBjaGVjaywgYmVmb3JlIHRv
IGRpc2FibGUgaXQuDQo+IEJ1dCBpdCBzZWVtcyB0aGF0IHRoZXJlIGFyZSBzb21lIHBvdGVudGlh
bCBwcm9ibGVtcyB3aGVuIGRvIHRoZSBzaW1pbGFyDQo+IG9wZXJhdGlvbnMgdG8gdGhlIGNsb2Nr
cyBkaXNhYmxlIGhlcmUuDQo+IEJlY2F1c2UgdGhhdCB0aGUgZHdfcGNpZV9ob3N0X2luaXQgbWln
aHQgaGF2ZSBzb21lIGVycm9yIHJldHVybnMgd2hlbiB0aGUNCj4gaG9zdF9pbml0IGlzIG5vdCBp
bnZva2VkIGF0IGFsbC4NCj4gSG93IHRvIGhhbmRsZSB0aGlzIHNpdHVhdGlvbiBhbHRob3VnaCB0
aGlzIGlzIG9uZSBjb3JuZXIgY2FzZT8NCj4gDQpbUmljaGFyZCBaaHVdIEkgaGF2ZSBhbiBpZGVh
IHRvIGhhbmRsZSB0aGlzIGNhc2UuDQpBZGQgb25lIG1vcmUgY2FsbGJhY2soZS54OiBob3N0X2V4
aXQoKSApIGludG8gZHdfcGNpZV9ob3N0X29wcyBzdHJ1Y3QsIHRoZW4gZG8gdGhlIGhvc3RfZXhp
dCgpIHdoZW4gdGhlcmUgaXMgYSBlcnJvciByZXR1cm4gYWZ0ZXIgaG9zdF9pbml0KCkgaXMgaW52
b2tlZC4NCkhvdyBhYm91dCB0aGlzIHNvbHV0aW9uPw0KSSB3b3VsZCBzZW5kIHRoZSB2MyBwYXRj
aC1zZXQgbGF0ZXIgaWYgeW91IGRvbid0IHNheSBubyB0byB0aGlzIG1ldGhvZC4NCg0KQlINClJp
Y2hhcmQgIA0KDQo+IEJlc3QgUmVnYXJkcw0KPiBSaWNoYXJkIFpodQ0KPiA+DQo+ID4gUmVnYXJk
cywNCj4gPiBMdWNhcw0KPiA+DQo+ID4gPiAgCXJldHVybiByZXQ7DQo+ID4gPiAgfQ0KPiA+ID4N
Cj4gPg0KDQo=
