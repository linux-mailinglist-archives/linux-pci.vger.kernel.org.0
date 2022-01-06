Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331BA485F59
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 04:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbiAFDtl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jan 2022 22:49:41 -0500
Received: from mail-eopbgr10040.outbound.protection.outlook.com ([40.107.1.40]:52037
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230498AbiAFDtl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Jan 2022 22:49:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZDBwELzxBBrCVENh5QgujghdLf51bRpjVlj0xHrX5rLzvioZb0idOco4WAThdS9d5l7aET84oZVqN8uo57opJczeWjTTpmKbNbrZ3503G7VqkjnAD6ER2rJ1NA4QjglKJHbBx4AvT8Wr72I9r6n6r7JxrRYc8ROyIwWBn+VgO34Sz4QhvorMZ3T1C0OKTDx88SLQYj1I8zt6+doVQa2YXLbgmdUtAl04CchCCUwAa2Voxdhf7BqfJNuC3D3o6OLkrTIj1w8jl1tAiah5QJuT+ium08Iy+kXSVNnusBK86XJRNmTC04crWahDqeUYyHaDsWISeQLFhMFAXvrbHmJ2QQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4SPj5jQLkjYeonIXrPwoitSD/mjOTuttzZ+5WsPBAas=;
 b=cvHKgxQ4HmwO68vU0VzZz9drmdCTzycH9ksrypem57n/EIt7TeLToWhVAgbmMMsNsYiqTWpAiMvDcY5MuKKbR/Z5oOYserzEzoAU+u+x8/UKsLY5EdbzfVtNvt43XxR6S8sM83Xbw6NTuSBw8nJKw1KuYo29yOj1MJJwOuusE2fMXDo60Qf6M2Cb48y1RYk1gi5K5kHr9qvc8eKeV2KoAOuO1CrqJxABPMyAhNCEoe4/e8NpwlJ6ia/3ni3LYTh+5wOVkAS4WYtOs2j8fjmf+LaEUhuOuKTJrtFjTbcpu0F3fYFDAvcI/iPNcWEv9wkXrMGVwAgFgc2UT5DKi/Q0ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4SPj5jQLkjYeonIXrPwoitSD/mjOTuttzZ+5WsPBAas=;
 b=mxXcXR5MmbKsaigvQWANcXx2Kw5ELXrN8v/r5vitw5mrPlEPWTHF9gtghX47X+jt+up2s0Y9a6qy7v9Q/wPnZNU5xYw0ExtReknyI1uJw59TG6KLxF31uAzosMg/sL6PP5FHccyX3tlA4Fg2dikQLTxOexW9Tq0X6sQgeX2CB4c=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS1PR04MB9455.eurprd04.prod.outlook.com (2603:10a6:20b:4d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Thu, 6 Jan
 2022 03:49:38 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::949e:59fd:6098:6508%4]) with mapi id 15.20.4867.009; Thu, 6 Jan 2022
 03:49:38 +0000
From:   Hongxing Zhu <hongxing.zhu@nxp.com>
To:     Fabio Estevam <festevam@gmail.com>
CC:     Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mark Brown <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v5 5/6] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Topic: [PATCH v5 5/6] PCI: imx6: Fix the regulator dump when link never
 came up
Thread-Index: AQHYAgwNcqhuPckh0E6/5PAJczEnX6xU+NQAgAAwk8A=
Date:   Thu, 6 Jan 2022 03:49:38 +0000
Message-ID: <AS8PR04MB867662FF5FC56A7613D509CC8C4C9@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1641368602-20401-1-git-send-email-hongxing.zhu@nxp.com>
 <1641368602-20401-6-git-send-email-hongxing.zhu@nxp.com>
 <CAOMZO5AqgOOo3+r3yQSsfaNxW9eHXhCi=m+mqR=sf=K6dXA8tw@mail.gmail.com>
In-Reply-To: <CAOMZO5AqgOOo3+r3yQSsfaNxW9eHXhCi=m+mqR=sf=K6dXA8tw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 099222bc-e220-44c3-fb3e-08d9d0c79027
x-ms-traffictypediagnostic: AS1PR04MB9455:EE_
x-microsoft-antispam-prvs: <AS1PR04MB9455A1C7689DC41FDE0CC9CB8C4C9@AS1PR04MB9455.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VaTZTAJZYxVA4R8HQyKrOfWpCK3HPLIZXDHmCJhAOFryZcAnP2OuIKmPf/RpEg16ldak11Cth8qHl3w3fD5QxcujZbuMirrm/JXt+SZ8dJnD5AbLzB9TJKLHqnF4ynJWDaBW+pninNQ2ZmCVAn7LdVdf0I7KX4weg/lOUIapmzQJVfxGoNBh+iIpAChtpQM+zMOMa9Qxl1T2zw/0dEGx0mnhr25JIfY2RSntvroVCcOQ7gFHQTGOsjR1MTQ80eUGZ1N5GbVmIWB69OHe/BIFt3fzAFBCBuFF2S+ry33qyHSprPGI6NQDstZiQGkiL3XBJImTM8aSTo7Km5Tw5o4ejVeVIfqFgA47lLVr4DcFJIUTIyb/CRlvvNe7UZpR5EgX4Ggv6eXIoZ6x4fxYFW3RXywzUWKa9F8smHtt7Vm1nl4fyx8IcbqDYBlvRWvNvLAtEMWhxsksF0SAACDHR0lhBH9nsewYw4YWQ3PJv+tyaSykeOGL2345fFYkcA9Z+6UyY0HTcBZOrF6ro8iPLp0A4HhUS1oS3OE77NJD9p34ix8Ik5Oa5q+cga5XqSG5cb+D4J2fEIVyXOPTIHd4K+fXH9We6iniJ18mEYGwrYu5jk89+EoK9wZX5DTQCl7jZR8w2TA5OwXESe5UV5D4+IE09pjrsQMclYXAc6XfqgmJVcr7ILAkB6R46mQzRys5d7EO4I28Lc1+ifmziozr2dkvxjm2YJ+MlLPPNA7NK5iS7/zWXiyuhlq3cUEe3EV4A7kuqXyQbJxIfy3nQ8qiZ2Hgjt20o6QiViguknjpj2jz9CQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(71200400001)(966005)(7416002)(38100700002)(508600001)(6506007)(64756008)(186003)(52536014)(66556008)(316002)(6916009)(122000001)(9686003)(44832011)(38070700005)(86362001)(8936002)(33656002)(55016003)(66446008)(76116006)(83380400001)(66946007)(2906002)(54906003)(45080400002)(26005)(8676002)(7696005)(53546011)(5660300002)(4326008)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VlA5MG5mUU5XTklSWDhvRGgvRWtzdlg1Q09ReDVLMmZIcjlxazBEemNjd2xU?=
 =?utf-8?B?S3VUbG9LQU1oWUdlNlpzdTRZMkpzNG1tYjNWS2JGTTh2bEVFdFpkK1R0UHpJ?=
 =?utf-8?B?b1pJcHhEWllkK3NLby9la3NLaXRuZlVHL01QUDVMUGY0MUNLaVovWld0bktR?=
 =?utf-8?B?NVRMaDIyMTU5N2UrMWxVU0M0Q0UwYjRvMFdxL0hTdTBkZEd6NTdabVhOcTFo?=
 =?utf-8?B?cFpTN3cyNzIxVkNkNGNYNGpha0dPbTlkMjB2WlZNUHp3NC9kVEtYSHdGOWta?=
 =?utf-8?B?MjZQRFpHQ3NIbEE1ck9nWHA0YkxtczRXaU9zNUJEVXRwOEVYL21qSngwRjVC?=
 =?utf-8?B?Y2ZkdWloYUNsUGd5QlV6QklwQnhMZjZQL09XYm9peUtTamFIVEpKdmJNN2JO?=
 =?utf-8?B?Kzk0QkZ1YjlISisxd2pNeVRUaWlLTUEyVkFpOE4yNVAzL1FTSDB3bG03SDB5?=
 =?utf-8?B?NjJZWmpxZGxQN1IxMjNyV3A2MmxYNks4SDZhSTBNYmtOa3YzUGZFNEJvY1Nn?=
 =?utf-8?B?RnMxSVltU2ovZC9Fam5BekYwVnZPVWpFdVMra20ySS9PS2lKTkpPVElhaWVP?=
 =?utf-8?B?dWZ1WDg5cG1Fc2lON1MzQmlRVTZiNWxlaHBnT25lUTQyY2s4TFdWVFlUM3Vj?=
 =?utf-8?B?MUwxUE5iRWtFTzFLVXlwdEZpRlBvNFRKNUx4MmtNVGQvcGJ0OHBxdml4b29y?=
 =?utf-8?B?TW5VS2NiQlMwb1llaVhUL2FhYjU4aVhmYnc5ejloTndXNVg5bEVJY0svaE4r?=
 =?utf-8?B?ZE9oN1EwRS94d1hhS3RtV050T1RWaW5rdnBLZklJcTQ3UHRQcGtMbmtqSHNp?=
 =?utf-8?B?cUpockJWMmM1bWsyRDI1aEVtbTBEbFZGK3VES21mejhQVjE0L0JyT1gxKzJh?=
 =?utf-8?B?SXpZZVJUQmh6K1l4OWo4amFpMkgyNXZxajlpVUZONHlneWVGT0lsaHV0dFl2?=
 =?utf-8?B?VDFmaytGU2tiM0l2dUJ3UkpkcVZld0NvNVBBZks2aFVkd1IwWVJ4WklVNTdO?=
 =?utf-8?B?UHlRcFNWcGdxVkJYbnZWYUQzWUpTd3pXbHk1NnhFMk1NUk1ybWV4K291TWJB?=
 =?utf-8?B?UXZ2bmV1WnJtNlZkSHZSYWJldG9sYS9XUW9iaE5PYm11V3NNdXU4WWtsWHdU?=
 =?utf-8?B?cjNsMVliSzJkVUViUm8xc1l6RjlGRDUzazBpQ0FocjNtMERkS2NIdnhYOVdl?=
 =?utf-8?B?c3ZLMWEwV2grcTZsWHJVMUh5YjBVUThHMVpFUXZ1KzZyQnc5VERLblhIaXd1?=
 =?utf-8?B?T2c4MFdrYVlLbTluVjdxSFdhWFkxT3RhUUhHMVJWQ3FqVG1sNzJZVnY5Rkxq?=
 =?utf-8?B?SGdTK1FNbGs5RHB3R0k2L29qY1ZicGMwaGxsSCtCeW51R2Njc2VuOE1KOEJ3?=
 =?utf-8?B?UGZXZkFUUGRLdmJwVGswYnNCNEhrL3ZjTjNRUS9JWVlyM1JveW1QYVhHTkZu?=
 =?utf-8?B?QlhBbWFvUzZNVUhhbnJnTGxWOWtYTHRQNW9GWWhON212UFFoYmkraFFMSXNr?=
 =?utf-8?B?SE5kTVJ0MmJBaERtbllYTlhtUmJhSFIxN2JiY1FFMHI2QnJLK08yZDE1ZnZH?=
 =?utf-8?B?dXZXOUZtVGJnT2tRMmsyNmNWTng1TEsxTEZVbVJIUG4wa3ZVcDkvNVo0U25U?=
 =?utf-8?B?WkxjbFk3N29USUpMaUFHYXFHcGJMSjc2VFlodWViUDhFd3ZXRlpvU2lBdXBL?=
 =?utf-8?B?ZjFuc0xubzNFNGtKVEJXN1dkSk03SFJlQ0tQQ0c1MGhaRGxYWXNHN2JEeDdY?=
 =?utf-8?B?bTE4cjMyMXgrUWtBM0dZdThQK0ZCZjl2WlAzaTYycXBKODhPRXpsdC9Ic1dW?=
 =?utf-8?B?aFBBQ21SbHlONXVOL1Q5dEVFb05MSXpXRlRlNDZnY2MyWGk4SCtWMThvbGFD?=
 =?utf-8?B?d0RMYnhQQ0d4aFJ4dUxFclZtK2g0TFRTTlYvUjJoUUJ0ZGlOZG9OT1p2R2Mv?=
 =?utf-8?B?ZlJmaUU3Y0dxYml5Ync5RExGdTNsajkvWWxWMHplcU1WakorMC9VTngxdWpr?=
 =?utf-8?B?dUQxMEtCaTM5aXU0RkhKWWdPUDgwMlliazN3eGlSNFNZY2F6Zklubmt2My9m?=
 =?utf-8?B?ckFvclJUelM0T1FLR2hpYVNJMXhtZk84QkFKNHdNUGZvRS9iVy9QcExkUEI5?=
 =?utf-8?B?Q0RQSHgxS0xsN3N1Y3RQTlRPQmh6Y2d5VWJsbjJhMFQwRjBIbU9zVk9UL1R4?=
 =?utf-8?B?MVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 099222bc-e220-44c3-fb3e-08d9d0c79027
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jan 2022 03:49:38.3838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: C+t+tWE+If85a7rlU/kAJetyGbPPrYJnZinBGCXaxzQ995b0Up87fiDNvEpsVsfv6XDo3piB8+QUtgRnCn7pDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9455
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBGYWJpbyBFc3RldmFtIDxmZXN0
ZXZhbUBnbWFpbC5jb20+DQo+IFNlbnQ6IFRodXJzZGF5LCBKYW51YXJ5IDYsIDIwMjIgNTo1MiBB
TQ0KPiBUbzogSG9uZ3hpbmcgWmh1IDxob25neGluZy56aHVAbnhwLmNvbT4NCj4gQ2M6IEx1Y2Fz
IFN0YWNoIDxsLnN0YWNoQHBlbmd1dHJvbml4LmRlPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdh
YXNAZ29vZ2xlLmNvbT47IE1hcmsgQnJvd24gPGJyb29uaWVAa2VybmVsLm9yZz47DQo+IGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb207IGppbmdvb2hhbjFAZ21haWwuY29tOw0KPiBzdGFibGVAdmdl
ci5rZXJuZWwub3JnOyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBkbC1saW51eC1pbXgNCj4g
PGxpbnV4LWlteEBueHAuY29tPjsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3Jn
Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGUN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSCB2NSA1LzZdIFBDSTogaW14NjogRml4IHRoZSByZWd1bGF0
b3IgZHVtcCB3aGVuIGxpbmsNCj4gbmV2ZXIgY2FtZSB1cA0KPiANCj4gSGkgUmljaGFyZCwNCj4g
DQo+IE9uIFdlZCwgSmFuIDUsIDIwMjIgYXQgNToxMiBBTSBSaWNoYXJkIFpodSA8aG9uZ3hpbmcu
emh1QG54cC5jb20+DQo+IHdyb3RlOg0KPiA+DQo+ID4gV2hlbiBQQ0llIFBIWSBsaW5rIG5ldmVy
IGNhbWUgdXAgYW5kIHZwY2llIHJlZ3VsYXRvciBpcyBwcmVzZW50LCB0aGVyZQ0KPiA+IHdvdWxk
IGJlIGZvbGxvd2luZyBkdW1wIHdoZW4gdHJ5IHRvIHB1dCB0aGUgcmVndWxhdG9yLg0KPiA+IEFk
ZCBhIG5ldyBob3N0X2V4aXQoKSBjYWxsYmFjayBmb3IgaS5NWCBQQ0llIGRyaXZlciB0byBkaXNh
YmxlIHRoaXMNCj4gPiByZWd1bGF0b3IgYW5kIGZpeCB0aGlzIGR1bXAgd2hlbiBsaW5rIG5ldmVy
IGNhbWUgdXAuDQo+ID4NCj4gPiBUaGUgZHJpdmVyIHNob3VsZCB1bmRvIGFueSBlbmFibGVzIGl0
IGRpZCBpdHNlbGYsIGFuZCBub3QgdW5kbyBhbnkNCj4gPiBlbmFibGVzIHRoYXQgYW55dGhpbmcg
ZWxzZSBkaWQgd2hpY2ggbWVhbnMgaXQgc2hvdWxkIG5ldmVyIGJlIGJhc2luZw0KPiA+IGRlY2lz
aW9ucyBvbiByZWd1bGF0b3JfaXNfZW5hYmxlZCgpLg0KPiA+DQo+ID4gVG8ga2VlcCB1c2FnZSBj
b3VudGVyIGJhbGFuY2Ugb2YgdGhlIGNsb2NrcywgcG93ZXJzIGFuZCBzbyBvbi4gRG8gdGhlDQo+
ID4gY2xvY2sgZGlzYWJsZSBpbiB0aGUgZXJyb3IgaGFuZGxpbmcgYWZ0ZXIgaG9zdF9pbml0IHRv
by4NCj4gPg0KPiA+ICAgaW14NnEtcGNpZSAzMzgwMDAwMC5wY2llOiBQaHkgbGluayBuZXZlciBj
YW1lIHVwDQo+ID4gICBpbXg2cS1wY2llOiBwcm9iZSBvZiAzMzgwMDAwMC5wY2llIGZhaWxlZCB3
aXRoIGVycm9yIC0xMTANCj4gDQo+IFNob3VsZG4ndCB3ZSBpZ25vcmUgdGhlIGR3X3BjaWVfd2Fp
dF9mb3JfbGluaygpIGVycm9yPw0KPiANCj4gQXQgbGVhc3QsIHRoaXMgd2FzIHRoZSBpbnRlbnRp
b24gb2YgODg2YTljMTM0NzU1ICgiUENJOiBkd2M6IE1vdmUgbGluaw0KPiBoYW5kbGluZyBpbnRv
IGNvbW1vbiBjb2RlIikuDQo+IA0KPiA+ICAgLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBdLS0tLS0t
LS0tLS0tDQo+ID4gICBXQVJOSU5HOiBDUFU6IDMgUElEOiAxMTkgYXQgZHJpdmVycy9yZWd1bGF0
b3IvY29yZS5jOjIyNTYNCj4gX3JlZ3VsYXRvcl9wdXQucGFydC4wKzB4MTRjLzB4MTU4DQo+ID4g
ICBNb2R1bGVzIGxpbmtlZCBpbjoNCj4gDQo+IE15IGNvbmNlcm4gaXMgdGhhdCB0aGlzIGlzc3Vl
IGlzIHN0aWxsIHByZXNlbnQgaW4gNS4xNSwgd2hpY2ggaXMgTFRTLg0KPiANCj4gWW91IG9ubHkg
YWRkcmVzcyB0aGlzIHByb2JsZW0gaW4gNS82IGFuZCBJIGFtIG5vdCBzdXJlIGlmIHRoZSBwcmV2
aW91cw0KPiBwYXRjaGVzIGNvdWxkIGJlIGFwcGxpZWQgdG8gc3RhYmxlIGFzIHRoZXkgYXJlIGNs
ZWFudXBzLg0KPiANCj4gSG93IGNhbiB3ZSBmaXggdGhpcyBmb3IgNS4xNSBzdGFibGU/DQo+IA0K
PiBDb3VsZCB5b3UgbWFrZSBhIG1pbmltYWwgZml4IGFzIHRoZSBmaXJzdCBwYXRjaCBvZiB0aGUg
c2VyaWVzIGFuZCBjbGVhbnVwDQo+IHBhdGNoZXMgbGF0ZXI/DQpbUmljaGFyZCBaaHVdIFJlbW92
ZSB0aGUgc3RhYmxlIGtlcm5lbCBtYWlsIGxpc3QgZmlyc3RseS4NClllcywgeW91J3JlIHJpZ2h0
Lg0KSXQncyBkaWZmaWN1bHQgdG8gbWVyZ2UgdGhpcyBzZXJpZXMgYmFjayB0byA1LjE1IHN0YWJs
ZSBrZXJuZWwsIHNpbmNlIHRoZQ0KIGkuTVg4TU0gUENJZSBzdXBwb3J0IHBhdGNoLXNldCBoYWQg
YmVlbiBtZXJnZWQsIGFuZCB0aGVyZSBhcmUgY29kZXMNCiBjb25mbGljdGlvbnMuDQoNCkhvdyBh
Ym91dCBjb250aW51ZSBwcm9jZWVkIHlvdXIgcHJldmlvdXMgZml4IGZpcnN0bHk/DQpodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3QvbGludXgtcGNpL3BhdGNoLzIwMjExMTA0MDAw
MjAyLjQwMjgwMzYtMS1mZXN0ZXZhbUBnbWFpbC5jb20vDQpUaGVuLCBJIGNsZWFuIHVwIHRoZSBm
aXggcGF0Y2gsIGFuZCByZS1zZW5kIG15IHNlcmllcyBsYXRlci4NCkJlY2F1c2UgdGhhdCBJIHN0
aWxsIHdhbnQgdG8gc2F2ZSBwb3dlciBjb25zdW1wdGlvbiBhcyBtdWNoIGFzIHBvc3NpYmxlDQog
d2hlbiBsaW5rIGlzIGRvd24uDQpCVFcsIHBsZWFzZSByZW1vdmUgdGhlIHRpbWVzdGFtcCBpbiB5
b3VyIHBhdGNoIGlmIHlvdSBhZ3JlZSB0aGlzIG1ldGhvZCwNCmFuZCByZXNlbmQgeW91ciBwYXRj
aC4NCg0KQmVzdCBSZWdhcmRzDQpSaWNoYXJkIFpodQ0K
