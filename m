Return-Path: <linux-pci+bounces-1782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87524826C04
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DE6FFB21C37
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9B2514011;
	Mon,  8 Jan 2024 11:03:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2071.outbound.protection.partner.outlook.cn [139.219.17.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4DF29412;
	Mon,  8 Jan 2024 11:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZMGDbtUTigqpF4YG2ptl0pXzYfbe0vjbHP2RR5PP8npNBtDvgY0a5dv+T4lVKYt+CtweppyxOAt7QidJbt43VGVQhdhYIgXUS0mS4MJMRY6JwzvV+m0JI27uklHZoNYzQxhWmbjMLN+vRZDdee8feU8dc9iMVb8g2dl+h3czTuOCQSmc2n9/qeHoHVR8xE6Vj0W0frEHu1b99KynWt8fElAVI2VlPKaB584LFUfZVwX1vvVFQgls8PN2AZsoUeO2jfxKoZR8lMFN4dvz/d6a+0EYKVBqtm6whuNwxe7Vl1rsWFKsIkUT2+P1i8P07yXwOlN3njyp5NWTqbsinSNmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OnoNkc66yulR4F2JLKRij8viozjKKZejnS/oAoKO0QA=;
 b=bSzhpJFb5FMlAeFNNIkdP3nT5aUdZhX0WXBp7HhdVr/6LLQle9IQDIP6hTSp4wNweKObStdHHClqRPsRSdr//Zlfd5p4/0Qd5rKDxoGv7lBGqjzfv7Fy7qE9SpDbN6aBh5+YCxlCg1F1bGVjBw7Ska9jAnhttT/Ffn7KE9uVJuSkYkcuyvQzfwcCFL5oZ7pSRQLe0Pw53Vd0FxYABkPfvUegIcxG+cBzn+aGSBbGd6s3yNh/X7pnHVMADBVhRpHSA3J5Kd4m1ZNbDE3ssRoshAT9a3h108Lm7k/DaDo90Vzhh6LMsWOpXJP6RUgxLZPVsz/ueOR3Hk1AnCTJtDFncA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550::13) by ZQ0PR01MB1272.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:18::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 10:48:10 +0000
Received: from ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
 ([fe80::936f:9f2f:6715:e402]) by
 ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn ([fe80::936f:9f2f:6715:e402%6])
 with mapi id 15.20.7159.015; Mon, 8 Jan 2024 10:48:10 +0000
From: Kevin Xie <kevin.xie@starfivetech.com>
To: Kevin Hilman <khilman@baylibre.com>, Minda Chen
	<minda.chen@starfivetech.com>, Conor Dooley <conor@kernel.org>,
	=?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?= <kw@linux.com>, Rob Herring
	<robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, Daire McNamara <daire.mcnamara@microchip.com>, Emil
 Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject:
 =?gb2312?B?u9i4tDogu9i4tDogW1BBVENIIHYxMyAwLzIxXSBSZWZhY3RvcmluZyBNaWNy?=
 =?gb2312?Q?ochip_PCIe_driver_and_add_StarFive_PCIe?=
Thread-Topic:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxMyAwLzIxXSBSZWZhY3RvcmluZyBNaWNyb2NoaXAg?=
 =?gb2312?Q?PCIe_driver_and_add_StarFive_PCIe?=
Thread-Index: AQHaPpXiMe+t6/O8C0OnZGJ4Y32LtrDKgdAQgAD6TACABDOkUA==
Date: Mon, 8 Jan 2024 10:48:10 +0000
Message-ID:
 <ZQ0PR01MB098182407F5F427D9A6C7CD9826BA@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
References: <20231214072839.2367-1-minda.chen@starfivetech.com>
 <7hfrzeavmj.fsf@baylibre.com>
 <ZQ0PR01MB098128579D86207B4B9BA7D28266A@ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn>
 <7h34vbbsfj.fsf@baylibre.com>
In-Reply-To: <7h34vbbsfj.fsf@baylibre.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQ0PR01MB0981:EE_|ZQ0PR01MB1272:EE_
x-ms-office365-filtering-correlation-id: 4e52aeb4-1b16-4713-b5db-08dc10374e6e
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pA+qiCg4YESTo9mgbzSlXLXSw11wC2i6bcnbfXSpejURc9wd4/3ij60j7F33TNIzJaHlu/QgubBwfn7HdBiMLoObc+tGCjFKxrEttbegEFN0zsbp2nJ0vOVq+4OBRXijy/IwK+duKv8VzABGLQvK+In+7OlBjFUjtpw5cfsOs7GlYArKpSJJ/uSwOI9jBERPKz/tkGa4Y/ZLMH7m1L5dXnM86/5Od6bv/ehtiAN/83YwDVB8r9kX+/uCA3fmFihteHezjLTlMpc+Kb162h+jA6u1dOupZEDZGhQeWmH9+wikmRlagxA0CHYQPpFjmPqXllAW6lIJBkN88Tt8vhpsvoKq/ZRsUs/39YeVyUL9vqixil7jf4MA3Ibv+MIG81hTzqUaKaH+qhpZ/AgvGG+15LhK2AoGW17XZfE92Clq6gs4THK53mCLYNr8Vr55RyeHawSfh09lx3/8RnsTodDOkXM/fgY+jwUuymTW5Mknj40uOTLjs59CjKPtG7QGhGLjRsAw88EuiOFavMMYnfhf40hIQ+iEXRh6f42apeTicGLXd1tD4QOtXcMAGPyV7NPd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(33656002)(40180700001)(86362001)(40160700002)(38100700002)(122000001)(224303003)(83380400001)(2906002)(26005)(9686003)(55016003)(7696005)(921011)(508600001)(71200400001)(66556008)(66946007)(76116006)(110136005)(66446008)(54906003)(64756008)(8936002)(5660300002)(4326008)(44832011)(7416002)(66476007)(38070700009)(41300700001)(107886003)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?MTkwaGxOOXFZbHR3TGVQbFZaREk0UmhYTjBLeUM3RDRkWDlYTUI1RzhIdmEz?=
 =?gb2312?B?N2xHcmE1OVo0T3RHVUxNSEJxNGc1cVdaWEY0ZXZGRVZGSTJYTE0zV0JvQWFo?=
 =?gb2312?B?TFc1aFQ0WHhDRk4yUDE3c0hNMlpNNisrMFNBQXBaWHpHTUdBRzVIUVRKOFlz?=
 =?gb2312?B?WVYzR3E2T2pRMjNMYXExL1Rqb0lpa3FZWktOUG9VQVV1V3NrODlzY2xlbkdX?=
 =?gb2312?B?V29qYXhOTXlSakVjU3E0UkdoMVdFSk8ranlzNzllRHo0bkJBd3ovaEhEVlpx?=
 =?gb2312?B?NHB6UVBSbzBQbncwODMxOFZ5Qlc0WnR5dzQwZlNqRE9vRnRYRDVzajhSZjFD?=
 =?gb2312?B?MVFNd2pFSzR6b2plSE1yQkgwVjZPanVnUUV1Y1ZCVHg1aHFVNDVwMFRFUXdp?=
 =?gb2312?B?K0JocEpvSnI4ZmMvN2ozcERlNmIxL21PMUw1d0hCcFhpNE4rYlRKa1ZLOGFw?=
 =?gb2312?B?c2xVMVRLUFVSd0doL1pGNVpPbW1KbnY0ZjM4QWJ6OTJIQ3gwNUp6bG51MWFK?=
 =?gb2312?B?ZFozZ1BMRHdHckFWK2RJYnljeGw2WEk2VUI0R1B6eUJ2Vm5iQ3FFZGZ6RmNo?=
 =?gb2312?B?L0RNcVo0OWl0NWxod3lsdGMyYWlUR09CSnlEclBBYlhIc1VhbUZuVmtsQlVE?=
 =?gb2312?B?WGNSQjRDbXFMSXh2andMU2VucjZiY1E2SWJxazRCSXBlUzE2YUpWbzlvaFQz?=
 =?gb2312?B?ak9odFZxYnduaDJQR2tyaXIwYkpiSy96K2NnMlc1cEdoZ3dpclRGQ2FBb092?=
 =?gb2312?B?YjcyQktDamRqY2hKdSt2UzJrblZVZEFlWU1FS2JDaWdSSWxYOWdvcTQ4YUUw?=
 =?gb2312?B?eXJDdTFmUXY2bzZLNTJtYkhOSlRYTTlNeUpuUDI4RFBzV0lDMlFsOStNbG9R?=
 =?gb2312?B?TEs5RTd5NjZJOUMxY1ZST3FtZ2VEMmJ2V1lLYytkQm1IUEdMUTZIR01CSllh?=
 =?gb2312?B?c0VVSFBsOXNoZ1U4NW1Ya2F3dW9HU2xudmF4N0MwMFc0K2VHakdZTnlJVDlG?=
 =?gb2312?B?NU0zUDMxMkRML2tUOEl0YlBPVTlSNXV2cGlRTlJ0MnlBWDVvM3M1bllEb0Vn?=
 =?gb2312?B?MHhDSnk4c1F3QWdsL0Uvc1lSZS9sWkVTU29xYXBqcTZMVklocTVJUE1wTWs0?=
 =?gb2312?B?bG5yWlljYUpNRkgzQmpCZFVLOFNoZTdYeFhqZzExUGJZbWxRZ1UzSHd4RlN1?=
 =?gb2312?B?dkI0end4ZWZseXF1cThRaGhKK1RzeWMrdFY1TlY1WDhZL05XTjAwMVR3VHNj?=
 =?gb2312?B?MFVlaDYzbzlmamcxeTVwQW80N1hDZ0pHekpHdmUwUkNpbnJwSTZRdDhNSnR2?=
 =?gb2312?B?a0N4Mnl2SDhIbzc2c2V6MU91RnRlRkswZE1BUG5iV0dUc2RQa2RYRGVlVFZG?=
 =?gb2312?B?UklyT0p0dVE0bng4M0xubkZRejQxZDc0YTdYN0JVdTluYldVYmFNalRUbXpq?=
 =?gb2312?B?ZU9qMThqYnRWNkRkQWIwNjN1ME1aUGk0L2pEU1ZXSzJ2N3JES0d1eWNBU2Ja?=
 =?gb2312?B?bm54alRpNXRXUG5TblZkZEtnRGc2VmJ4c0VZRUJ6QVdoemRmOThGbVpGZlJN?=
 =?gb2312?B?eTFORCsvT3lEMmQweDFxK0FlblkvNTA1dHR3SWJFWTcxcGRrdVp1a0dvaFJq?=
 =?gb2312?B?OWxXUlVLS2RFdkpWbi90UnVUYW1Bbk5HNVlmRFVVNXdnVFo2dUhubFZhYlZj?=
 =?gb2312?B?dk0zUE5UZGpLQWVmTWpTTHhXUXVaSDFWWmJYN3VocHFpMEYxSVFmYmZVd3pN?=
 =?gb2312?B?bDgycy9lMHRXdkxjd1BLUTYydlpaSkZJWXROTXg4am9TWHhZRUVLM2hLZmd1?=
 =?gb2312?B?S2JKeDg4VDlYZ3JROEpqeG9rVmd2Lzl6R2FCN0VEODg0b2JOY2k5U05DV2h0?=
 =?gb2312?B?aDRBdXB4Mk5OM1B6OG5BTGtRL2pwcWJaNjh5NDRWOVlGWU14YU9VZndVS1Rq?=
 =?gb2312?B?ZTJXOFZNcG5ZUyt0dFh2VENTUVg1Z0xJUjgwYjNQWnFpUnFoUWI0Vy9WaUMx?=
 =?gb2312?B?UHlGRmJRM1Fzb2dYTzd5R2M4ZDFHek9sdGxaQmlXMndCc0ZLSEw5aTljSVRi?=
 =?gb2312?B?TkhyaFFUdmpzd3VNZkswdzZla1dOb2J3WUpxMG0rZE5sY3p0UXBnOGs1QVpB?=
 =?gb2312?Q?VAE/dS/tkwD7Os9Hs940eUEdx?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQ0PR01MB0981.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e52aeb4-1b16-4713-b5db-08dc10374e6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 10:48:10.4631
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EjSJSNY9AdvsNHGBzztMic2AgEORtvxx1jnqVnsKj8aNPnkq2c0W/T9MX5bQqq+7ZNfSoBcdvPneKVwMG8Q+W/fjFdCULZZz87u4B/Zm+zE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQ0PR01MB1272

PiBLZXZpbiBYaWUgPGtldmluLnhpZUBzdGFyZml2ZXRlY2guY29tPiB3cml0ZXM6DQo+IA0KPiA+
PiBNaW5kYSBDaGVuIDxtaW5kYS5jaGVuQHN0YXJmaXZldGVjaC5jb20+IHdyaXRlczoNCj4gPj4N
Cj4gPj4gPiBUaGlzIHBhdGNoc2V0IGZpbmFsIHB1cnBvc2UgaXMgYWRkIFBDSWUgZHJpdmVyIGZv
ciBTdGFyRml2ZSBKSDcxMTAgU29DLg0KPiA+PiA+IEpINzExMCB1c2luZyBQTERBIFhwcmVzc1JJ
Q0ggUENJZSBJUC4gTWljcm9jaGlwIFBvbGFyRmlyZSBVc2luZyB0aGUNCj4gPj4gPiBzYW1lIElQ
IGFuZCBoYXZlIGNvbW1pdCB0aGVpciBjb2Rlcywgd2hpY2ggYXJlIG1peGVkIHdpdGggUExEQQ0K
PiA+PiA+IGNvbnRyb2xsZXIgY29kZXMgYW5kIE1pY3JvY2hpcCBwbGF0Zm9ybSBjb2Rlcy4NCj4g
Pj4NCj4gPj4gVGhhbmsgeW91IGZvciB0aGlzIHNlcmllcy4NCj4gPj4NCj4gPj4gSSB0ZXN0ZWQg
dGhpcyBvbiBhIFZpc2lvbkZpdmUgdjIgYm9hcmQsIGFuZCBpdCBzZWVtcyB0byBwcm9iZSBhbmQN
Cj4gPj4gZmluZCBteQ0KPiA+PiBNLjIgTlZNZSBTU0QsIGJ1dCB0aGVuIGdldHMgdGltZW91dHMg
d2hlbiB0cnlpbmcgdG8gdXNlIHRoZSBOVk1lIChlLmcuDQo+ID4+ICdibGtpZCcgY29tbWFuZCkN
Cj4gPj4NCj4gPg0KPiA+IEhpLCBLZXZpbjoNCj4gPiBDb3VsZCB5b3UgcGxlYXNlIHByb3ZpZGUg
dGhlIG1hbnVmYWN0dXJlciBhbmQgbW9kZWwgb2YgdGhlIE0uMiBOVk1lDQo+ID4gU1NEIHlvdSB0
ZXN0ZWQ/DQo+IA0KPiBJIGhhdmUgYSAyNTYgR2IgU2lsaWNvbiBQb3dlciBQMzRBNjAgTS4yIE5W
TWUgU1NEIChwYXJ0IG51bWJlcjoNCj4gc3AyNTZnYnAzNGE2MG0yOCkNCj4gDQpUaGFua3MsIEtl
dmluLCB3ZSB3aWxsIGJ1eSBvbmUgdG8gdGVzdC4NCg0KQmVmb3JlIGRvaW5nIHRoaXMgcmVmYWN0
b3JpbmcsIHdlIGVuY291bnRlcmVkIHRoZSBzYW1lIGJ1ZyB3aXRoIEtpbmdzdG9uIE0uMiBTU0Qs
DQphbmQgd2Ugd29ya2Fyb3VuZCB0aGUgcHJvYmxlbSB3aXRoIHRoZSBiZWxvdyBwYXRjaCwgcGxl
YXNlIGhhdmUgYSB0cnk6DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9udm1lL2hvc3QvcGNpLmMgYi9k
cml2ZXJzL252bWUvaG9zdC9wY2kuYw0KaW5kZXggNTA3YmMxNDkwNDZkLi41YmUzN2YxZWUxNTAg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL252bWUvaG9zdC9wY2kuYw0KKysrIGIvZHJpdmVycy9udm1l
L2hvc3QvcGNpLmMNCkBAIC0xMDU5LDYgKzEwNTksMTYgQEAgc3RhdGljIGlubGluZSBpbnQgbnZt
ZV9wb2xsX2NxKHN0cnVjdCBudm1lX3F1ZXVlICpudm1lcSwNCiB7DQogICAgICAgIGludCBmb3Vu
ZCA9IDA7DQoNCisgICAgICAgLyoNCisgICAgICAgICogSW4gc29tZSBjYXNlcywgc3VjaCBhcyBK
SDcxMTAgU29DIHdvcmtpbmcgd2l0aCBLaW5nc3RvbiBTU0QsDQorICAgICAgICAqIHRoZSBDUUUg
c3RhdHVzIG1heSB1cGRhdGUgYSBsaXR0bGUgYml0IGxhdGVyIHRoYW4gdGhlIE1TSSwNCisgICAg
ICAgICogd2hpY2ggY2F1c2UgYW4gSVJRIGhhbmRsZSBtaXNzaW5nLg0KKyAgICAgICAgKiBBcyBh
IHdvcmthcm91bmQsIGhlcmUgd2Ugd2lsbCBjaGVjayB0aGUgc3RhdHVzIGZpcnN0LCBhbmQgd2Fp
dA0KKyAgICAgICAgKiAxdXMgaWYgd2UgZ2V0IG5vdGhpbmcuDQorICAgICAgICAqLw0KKyAgICAg
ICBpZiAoIW52bWVfY3FlX3BlbmRpbmcobnZtZXEpKQ0KKyAgICAgICAgICAgICAgIHVkZWxheSgx
KTsNCisNCiAgICAgICAgd2hpbGUgKG52bWVfY3FlX3BlbmRpbmcobnZtZXEpKSB7DQogICAgICAg
ICAgICAgICAgZm91bmQrKzsNCiAgICAgICAgICAgICAgICAvKg0KDQo+IEFsc28gZm9yIHJlZmVy
ZW5jZSwgSSB0ZXN0ZWQgdGhlIHNhbWUgU1NEIG9uIGFub3RoZXIgYXJtIHBsYXRmb3JtIChLaGFk
YXMNCj4gVklNMykgYW5kIGl0IHdvcmtzIGZpbmUuDQo+IA0KPiBLZXZpbg0KDQpIaSwgQmpvcm46
DQpEbyB5b3UgaGF2ZSBhbnkgaWRlYSBhYm91dCB0aGUgbGF0ZSBDUUUgcGhhc2UgdXBkYXRlIGNv
bmRpdGlvbiBhcyBtZW50aW9uZWQNCmluIHRoZSBwYXRjaCBjb21tZW50cyBhYm92ZT8NClRoaXMg
aXMgYW4gaXNzdWUgdGhhdCBvY2N1cnMgd2l0aCBhIHNtYWxsIHByb2JhYmlsaXR5IG9uIGluZGl2
aWR1YWwgZGV2aWNlcyBpbiBvdXINCnBsYXRmb3JtLg0KVGh1cywgSSBzdWdnZXN0IHRoZSByZWZh
Y3RvcmluZyBwYXRjaCBzZXQgc2hvdWxkIGdvIGZvcndhcmQuDQpMYXRlciB3ZSB3aWxsIHRyeSB0
byBmaW5kIGEgbW9yZSBmb3JtYWwgc29sdXRpb24gaW5zdGVhZCwgYW5kIHNlbmQgYSBuZXcgcGF0
Y2guDQo=

