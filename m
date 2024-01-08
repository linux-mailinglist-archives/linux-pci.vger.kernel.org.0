Return-Path: <linux-pci+bounces-1803-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7AE826CF5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93E9B1C21E58
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC8EE14AA8;
	Mon,  8 Jan 2024 11:37:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2049.outbound.protection.partner.outlook.cn [139.219.146.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E9414A93;
	Mon,  8 Jan 2024 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=caFEY2UCaQPGtuX8DYW9OSTDBLtZtwjvlOdU5z4LUBKoG9OgTRZSpFp8ah4kK/dRcJATVfYjDKcyrLnqoSXIEuMN1k8xMOncqZA92wOdnI6svhROuoK3UJiiblPBFDJAlcB5WcZHiOI7frV/JHPJzmOBvezOyY5IIk3EKZFS02WkItanBmn6uzE9dYZNESBVuytbtFPfQyD4YbJy0p0W2/hbQzZSiJbOEyyRb3uBw76CAO0cnW9FNIX4boWRW3zjmbpFKbd7jfskcLLfcLPCUBktBc7oevi1X/kdAYQQJVU7u9VL0hiFzSrXCeH2w8oou0gxhAYEv3aHGuokKPrTxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8stLEPWxnqX1yX7wmAeR5xNZm29997T7UcU9AOutZB0=;
 b=mVDkSNITFxe6FU8yiDWRYJX+8USa/mwnb6FLNXOXKMs+RNAxYq4JYTZWVc46SHhfg8uGBXt822cihIVt0tJWY6ZzQQ3uXM2Wg1vAirGzgkdbycLmk2yppNElCJViSXS+3SniRdWuUdn8bp+9Ojm2SJhBSuameWUUENtweGOGE37W6TUCI61GpTLyTB0vQ5U/rM/e86Tng5F0S609aVgPSs2YdXF535BMIBryFEV+LIIez8IZQQyVPjvr5T1V9a/H8zgqeq2n2cH29lTB3Z0S/h99UsTls5V8CIREFN0dtvJJ6VXQU5A/e1nSyQfCDNkvWrrNPcVbmnecdg2cSQv0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0878.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:21:56 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:21:56 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Daire
 McNamara <daire.mcnamara@microchip.com>, Emil Renner Berthing
	<emil.renner.berthing@canonical.com>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
	=?gb2312?B?o7t0Z2x4QGxpbnV0cm9uaXguZGU=?= <；tglx@linutronix.de>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject:
 =?gb2312?B?u9i4tDogW1BBVENIIHYxNCAwMS8yMl0gZHQtYmluZGluZ3M6IFBDSTogQWRk?=
 =?gb2312?Q?_PLDA_XpressRICH_PCIe_host_common_properties?=
Thread-Topic: [PATCH v14 01/22] dt-bindings: PCI: Add PLDA XpressRICH PCIe
 host common properties
Thread-Index: AQHaQiK3erIk0yRSDEejKtsN6lOFlLDPxEPQ
Date: Mon, 8 Jan 2024 11:21:56 +0000
Message-ID:
 <SHXPR01MB0863D2B5503D55EFDEB9A989E66BA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
 <20240108110612.19048-2-minda.chen@starfivetech.com>
In-Reply-To: <20240108110612.19048-2-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0878:EE_
x-ms-office365-filtering-correlation-id: 8b720381-90fe-4849-909f-08dc103c0632
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 FeoHcOtwlmBXXJM1vGSLVPS9LE21117jDoyrz+FgXCtmW22W3hBnd+escHCNt82M5+g6SekWc2D1TbNai99nMey3cOqIlllYuUOXr4wPTl4N84G0JESlvp82260e5BY9fzpC+BNxSDdKWIZWIEDOqOssnPeioIM5QcyYRXsBivDajU430rNbFAlHkPo6tOpUKnzXxDDXIhKe7IvDMFfB7LKiiJI4zV+HItdjIgMlTKvXfqAtCiUowwWJvlH8kBelXScDU6p4sExf4rpZNBum1Nky7WtVTDBODVH4Pc0rJixDfCYra5PPtUj2wGJ3lHfeb0DtMzrNWFX0NMEBbR8ljfVEn3Hgv7xuSrQbqswuebbnzt2nPrgOmU0v+AaNUTJnRcPovlgqyh7mhJ8teyMd7Oji0hzpEo0cllw+wewD0Ruk/eiBLTc9EFSIyhdPiuRVl5VRx7/ZFnaVN6s5wdZXPsyoD/x+LAGd/0KBMXuwkFM4WuQnWimoZNVxjiwncx33SCfB0elXkkaM+pX8KinZktvRSqg6AGz3XtuYZfTHgC7x9wUrR4cYUEs+ye9XVcZQ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(33656002)(86362001)(40180700001)(40160700002)(38100700002)(224303003)(122000001)(83380400001)(26005)(9686003)(966005)(55016003)(7696005)(508600001)(71200400001)(66556008)(66946007)(76116006)(54906003)(110136005)(64756008)(66446008)(8936002)(5660300002)(4326008)(44832011)(7416002)(38070700009)(2906002)(66476007)(41300700001)(107886003)(41320700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RHdZaU5uUmtWcVZ4UWt6TU42dS9CNkNGZUhVSkdOOWk0dVhuTTJBTXhzQ3J0?=
 =?gb2312?B?TWVySlVSam1ScE84UkpDaVd5M3c1YXFydkdGcERhRlVxK0hzL2xDTjJYeEF4?=
 =?gb2312?B?SXE0VWpTTVZQaCtWVmNhNDB4VXBIWFl1N01Pa1JaTHM1amkyekZlUHB6QTgy?=
 =?gb2312?B?WWl2aTdXSFVNbHllRXBQMzE1SGY2WkY4SWVsUGZ4SmI1MjZGd1pNbWlXUEov?=
 =?gb2312?B?YlBOazNJcThTNEFxTzU4OFhaTWdWQXFBcjZJbmZTM3NXWlFXeStSaUcwSmJB?=
 =?gb2312?B?Q00wMk45dlJkd1dVOEoyOFBuMmkrZXBLSUxDRHdBZmJmRUVRM1EwU1dieWtq?=
 =?gb2312?B?S2gwczFEajFpaEtxYjBIUUsxUUVyUlM0SkIvekdueWdnSVZCZUxSa2FtRUVn?=
 =?gb2312?B?QmY1cklTUml1TFJHdUxJNGFQZTBMUDlJRHgycVJjeEwvSWU0ZDNtL3RPelJY?=
 =?gb2312?B?YXYvZ280ZDFteld1OG43VjlabEhOQytucVhPWlU1Q3J4TmV3NW9RTUptOUJm?=
 =?gb2312?B?WkMvVGVHaWtIRXJXb3VXR2VSTHlhQVlzM0VQblFFVllPSW1palN0V2FpTWU4?=
 =?gb2312?B?WGxGUlRQb2lhazl2OHFIdE9jTnhiUDFuRWJ4NEdlRGFBaFAyeVIzZkpibmNs?=
 =?gb2312?B?SzRSUE1DdEpBcmk4N2VHS3BIWTNJVitHcUlROGFRRjZKZFB1bXpLYUZHODhC?=
 =?gb2312?B?WEl6YTJZR2o2VEM3ZWV6UXhrcXJaeFVpN1QydlAzRkJmK3kvVkhwSE95WHBQ?=
 =?gb2312?B?endiejczc2xyL3RXM0pjRWcwcCttTUhjNTR2bXRVUXpTR0Fva2hFNXhObUp3?=
 =?gb2312?B?ZmMxWEdOczhTS3Mrd0hHcTZuWWNmSEVuREFNZ2IzRmMwUWcxZWtZZUh1bUdp?=
 =?gb2312?B?NzE0amdiamdINFk1OHA5bFRqeFRzdnFiaTdpNVFHOFk1akpNa2d1dkNDV0lE?=
 =?gb2312?B?MXBOTU1SUnA0UDFMT0tqTzBJMGxUblRsUFgzUFAzL29ieXlXdWkvOTNIaTBS?=
 =?gb2312?B?UmxjSTdtOGYwdzVjZkpvMUg5YXF5RVRmQ1FXbUZxZ1B2MVQ3Y1czcEN2VmZJ?=
 =?gb2312?B?QnRnUm45MFZHSkhPVnhOQnNpbnRyL2VmTzFweE8yVDg4dXVUZnJzcEIydjVV?=
 =?gb2312?B?REZGUXNFTmhrMDIrS01IdDZWcVdWeFZuREYvcGRmeHRMSCtqR2p5cFNLMGNn?=
 =?gb2312?B?WUZCd0JmdDdnTnk3c0EyMWs5WmRYcGpYckVOUWx1QTJReCt2WU1Lc0U1S2cr?=
 =?gb2312?B?Z0lOSzhUTXdPUHRJUnNjdjgyd2JSUWZlZjBJZlR2cTA0Q2lMYnRBeGZZQTIr?=
 =?gb2312?B?dXZKMEdlUmFKbms4VlJ0R1VubVdPOHdEd1VSTlFhcWlCZEh4bUFieXFKMDVn?=
 =?gb2312?B?QUVGSmtQL0pTbDNrQjdiaGgveEZpd0NqbS9LMHpCUGpHMzVac1dKZXdDR0s2?=
 =?gb2312?B?cnRoWDkzaW03bVZLYnZtMml5WFBVd2VWTmNlOGIxSW45VlR0S0RJYWJnSnA5?=
 =?gb2312?B?TWYvMWM0ZUZQL3dVUHRsT1U4MGtOVUo3NHUrYWdMT2NFak1BUjJuMjF2Z3VR?=
 =?gb2312?B?UjhrLzBxRUJxOVVUWSt6Vzl1bGFqZVdTZjVVT1NhTWsrTjJvNjJQVnllSnpZ?=
 =?gb2312?B?ME9NUkpMY2NzcFRNQmlQVTRjVzVKWjJDYy90U3VheWdudTRFbDVjMkdPOFcx?=
 =?gb2312?B?bmtaaGI1alhXZnJiOXk3b1gyQ3hGY3A2UnFDenRMc09nWXFjREtuSTZGSDEw?=
 =?gb2312?B?R1pXMW1BVlp3cFZoREZnTStzRFpzYW1KM1ZPa0NFTE5tUVJDTnl1anFtdHJB?=
 =?gb2312?B?TmVHVzdiTUlFTnVJdzlXdFRjWDNFclQ0VE1IUWQzOUtTVkhVZlRMQitpM0N5?=
 =?gb2312?B?L3pGTWJYbGFzWk90NjlnUWtHazRtQjV5VUQwa3dFTjhNNlVmcnVGdlZIUUM4?=
 =?gb2312?B?bms2OXJrV2wrNWtVZUp4RmtNVUQ0RHVOeUU5V09OZXJmeW9mNDBsWTNxUHdt?=
 =?gb2312?B?NW5uajFKVXFBSWVHWGd6MTEwV1YxY0taeksxdU5nU3ZFMnRTTlF0TkRURE5G?=
 =?gb2312?B?VFE5UmprdEdWanVLWk1KMHZ6NkI1dWQ2eHZacnBaVzZHMGhXaFJja08vSmNQ?=
 =?gb2312?B?VHFmaEtGdTdPbVBNNlFGQzlsRVo5c1FWdWFWdlB3d3VzQStEWW5GLzhESWxW?=
 =?gb2312?B?dEE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b720381-90fe-4849-909f-08dc103c0632
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2024 11:21:56.7548
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G4ED6mZpq9Fhg/H/qRPj/b7Bsu0L1yaDTpCer6EJAuVtL30IepSeuTvS7KAP/5UOU/MQDn1vgqNCjji5fV6DmJNhoKkocmNj905rkUa+t0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0878

DQo+INb3zOI6IFtQQVRDSCB2MTQgMDEvMjJdIGR0LWJpbmRpbmdzOiBQQ0k6IEFkZCBQTERBIFhw
cmVzc1JJQ0ggUENJZSBob3N0DQo+IGNvbW1vbiBwcm9wZXJ0aWVzDQo+IA0KQWRkIFRvbWFzDQo+
IEFkZCBQTERBIFhwcmVzc1JJQ0ggUENJZSBob3N0IGNvbW1vbiBwcm9wZXJ0aWVzIGR0LWJpbmRp
bmcgZG9jLg0KPiBQb2xhckZpcmUgUENJZSBob3N0IHVzaW5nIFBMREEgSVAuIE1vdmUgY29tbW9u
IHByb3BlcnRpZXMgZnJvbSBNaWNyb2NoaXANCj4gUG9sYXJGaXJlIFBDSWUgaG9zdCB0byBQTERB
IGZpbGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogTWluZGEgQ2hlbiA8bWluZGEuY2hlbkBzdGFy
Zml2ZXRlY2guY29tPg0KPiBSZXZpZXdlZC1ieTogSGFsIEZlbmcgPGhhbC5mZW5nQHN0YXJmaXZl
dGVjaC5jb20+DQo+IFJldmlld2VkLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xleUBtaWNy
b2NoaXAuY29tPg0KPiBSZXZpZXdlZC1ieTogUm9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz4N
Cj4gVGVzdGVkLWJ5OiBKb2huIENsYXJrIDxpbmluZGV2QGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAu
Li4vYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbCAgICAgfCA1NSArLS0tLS0t
LS0tLS0tLQ0KPiAgLi4uL3BjaS9wbGRhLHhwcmVzc3JpY2gzLWF4aS1jb21tb24ueWFtbCAgICAg
IHwgNzUgKysrKysrKysrKysrKysrKysrKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRp
b25zKCspLCA1NCBkZWxldGlvbnMoLSkgIGNyZWF0ZSBtb2RlIDEwMDY0NA0KPiBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3BsZGEseHByZXNzcmljaDMtYXhpLWNvbW1vbi55
YW1sDQo+IA0KPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL21pY3JvY2hpcCxwY2llLWhvc3QueWFtbA0KPiBpbmRleCBmN2EzYzI2
MzYzNTUuLjdjMmQ1MTIyMWY2NSAxMDA2NDQNCj4gLS0tIGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwNCj4gKysrIGIvRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9taWNyb2NoaXAscGNpZS1ob3N0LnlhbWwN
Cj4gQEAgLTEwLDIxICsxMCwxMyBAQCBtYWludGFpbmVyczoNCj4gICAgLSBEYWlyZSBNY05hbWFy
YSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCj4gDQo+ICBhbGxPZjoNCj4gLSAgLSAk
cmVmOiAvc2NoZW1hcy9wY2kvcGNpLWJ1cy55YW1sIw0KPiArICAtICRyZWY6IHBsZGEseHByZXNz
cmljaDMtYXhpLWNvbW1vbi55YW1sIw0KPiAgICAtICRyZWY6IC9zY2hlbWFzL2ludGVycnVwdC1j
b250cm9sbGVyL21zaS1jb250cm9sbGVyLnlhbWwjDQo+IA0KPiAgcHJvcGVydGllczoNCj4gICAg
Y29tcGF0aWJsZToNCj4gICAgICBjb25zdDogbWljcm9jaGlwLHBjaWUtaG9zdC0xLjAgIyBQb2xh
ckZpcmUNCj4gDQo+IC0gIHJlZzoNCj4gLSAgICBtYXhJdGVtczogMg0KPiAtDQo+IC0gIHJlZy1u
YW1lczoNCj4gLSAgICBpdGVtczoNCj4gLSAgICAgIC0gY29uc3Q6IGNmZw0KPiAtICAgICAgLSBj
b25zdDogYXBiDQo+IC0NCj4gICAgY2xvY2tzOg0KPiAgICAgIGRlc2NyaXB0aW9uOg0KPiAgICAg
ICAgRmFicmljIEludGVyZmFjZSBDb250cm9sbGVycywgRklDcywgYXJlIHRoZSBpbnRlcmZhY2Ug
YmV0d2VlbiB0aGUgRlBHQQ0KPiBAQCAtNTIsMTggKzQ0LDYgQEAgcHJvcGVydGllczoNCj4gICAg
ICBpdGVtczoNCj4gICAgICAgIHBhdHRlcm46ICdeZmljWzAtM10kJw0KPiANCj4gLSAgaW50ZXJy
dXB0czoNCj4gLSAgICBtaW5JdGVtczogMQ0KPiAtICAgIGl0ZW1zOg0KPiAtICAgICAgLSBkZXNj
cmlwdGlvbjogUENJZSBob3N0IGNvbnRyb2xsZXINCj4gLSAgICAgIC0gZGVzY3JpcHRpb246IGJ1
aWx0aW4gTVNJIGNvbnRyb2xsZXINCj4gLQ0KPiAtICBpbnRlcnJ1cHQtbmFtZXM6DQo+IC0gICAg
bWluSXRlbXM6IDENCj4gLSAgICBpdGVtczoNCj4gLSAgICAgIC0gY29uc3Q6IHBjaWUNCj4gLSAg
ICAgIC0gY29uc3Q6IG1zaQ0KPiAtDQo+ICAgIHJhbmdlczoNCj4gICAgICBtYXhJdGVtczogMQ0K
PiANCj4gQEAgLTcxLDM5ICs1MSw2IEBAIHByb3BlcnRpZXM6DQo+ICAgICAgbWluSXRlbXM6IDEN
Cj4gICAgICBtYXhJdGVtczogNg0KPiANCj4gLSAgbXNpLWNvbnRyb2xsZXI6DQo+IC0gICAgZGVz
Y3JpcHRpb246IElkZW50aWZpZXMgdGhlIG5vZGUgYXMgYW4gTVNJIGNvbnRyb2xsZXIuDQo+IC0N
Cj4gLSAgbXNpLXBhcmVudDoNCj4gLSAgICBkZXNjcmlwdGlvbjogTVNJIGNvbnRyb2xsZXIgdGhl
IGRldmljZSBpcyBjYXBhYmxlIG9mIHVzaW5nLg0KPiAtDQo+IC0gIGludGVycnVwdC1jb250cm9s
bGVyOg0KPiAtICAgIHR5cGU6IG9iamVjdA0KPiAtICAgIHByb3BlcnRpZXM6DQo+IC0gICAgICAn
I2FkZHJlc3MtY2VsbHMnOg0KPiAtICAgICAgICBjb25zdDogMA0KPiAtDQo+IC0gICAgICAnI2lu
dGVycnVwdC1jZWxscyc6DQo+IC0gICAgICAgIGNvbnN0OiAxDQo+IC0NCj4gLSAgICAgIGludGVy
cnVwdC1jb250cm9sbGVyOiB0cnVlDQo+IC0NCj4gLSAgICByZXF1aXJlZDoNCj4gLSAgICAgIC0g
JyNhZGRyZXNzLWNlbGxzJw0KPiAtICAgICAgLSAnI2ludGVycnVwdC1jZWxscycNCj4gLSAgICAg
IC0gaW50ZXJydXB0LWNvbnRyb2xsZXINCj4gLQ0KPiAtICAgIGFkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KPiAtDQo+IC1yZXF1aXJlZDoNCj4gLSAgLSByZWcNCj4gLSAgLSByZWctbmFtZXMN
Cj4gLSAgLSAiI2ludGVycnVwdC1jZWxscyINCj4gLSAgLSBpbnRlcnJ1cHRzDQo+IC0gIC0gaW50
ZXJydXB0LW1hcC1tYXNrDQo+IC0gIC0gaW50ZXJydXB0LW1hcA0KPiAtICAtIG1zaS1jb250cm9s
bGVyDQo+IC0NCj4gIHVuZXZhbHVhdGVkUHJvcGVydGllczogZmFsc2UNCj4gDQo+ICBleGFtcGxl
czoNCj4gZGlmZiAtLWdpdA0KPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvcGxkYSx4cHJlc3NyaWNoMy1heGktY29tbW9uLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL3BsZGEseHByZXNzcmljaDMtYXhpLWNvbW1vbi55YW1sDQo+
IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uMzFiYjE3YjExZTU4
DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL3BjaS9wbGRhLHhwcmVzc3JpY2gzLWF4aS1jb21tb24uDQo+ICsrKyB5YW1sDQo+IEBAIC0w
LDAgKzEsNzUgQEANCj4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkg
T1IgQlNELTItQ2xhdXNlKSAlWUFNTCAxLjINCj4gKy0tLQ0KPiArJGlkOg0KPiAraHR0cDovL2Rl
dmljZXRyZWUub3JnL3NjaGVtYXMvcGNpL3BsZGEseHByZXNzcmljaDMtYXhpLWNvbW1vbi55YW1s
Iw0KPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2NoZW1hcy9jb3JlLnlh
bWwjDQo+ICsNCj4gK3RpdGxlOiBQTERBIFhwcmVzc1JJQ0ggUENJZSBob3N0IGNvbW1vbiBwcm9w
ZXJ0aWVzDQo+ICsNCj4gK21haW50YWluZXJzOg0KPiArICAtIERhaXJlIE1jTmFtYXJhIDxkYWly
ZS5tY25hbWFyYUBtaWNyb2NoaXAuY29tPg0KPiArICAtIEtldmluIFhpZSA8a2V2aW4ueGllQHN0
YXJmaXZldGVjaC5jb20+DQo+ICsNCj4gK2Rlc2NyaXB0aW9uOg0KPiArICBHZW5lcmljIFBMREEg
WHByZXNzUklDSCBQQ0llIGhvc3QgY29tbW9uIHByb3BlcnRpZXMuDQo+ICsNCj4gK2FsbE9mOg0K
PiArICAtICRyZWY6IC9zY2hlbWFzL3BjaS9wY2ktYnVzLnlhbWwjDQo+ICsNCj4gK3Byb3BlcnRp
ZXM6DQo+ICsgIHJlZzoNCj4gKyAgICBtYXhJdGVtczogMg0KPiArDQo+ICsgIHJlZy1uYW1lczoN
Cj4gKyAgICBpdGVtczoNCj4gKyAgICAgIC0gY29uc3Q6IGNmZw0KPiArICAgICAgLSBjb25zdDog
YXBiDQo+ICsNCj4gKyAgaW50ZXJydXB0czoNCj4gKyAgICBtaW5JdGVtczogMQ0KPiArICAgIGl0
ZW1zOg0KPiArICAgICAgLSBkZXNjcmlwdGlvbjogUENJZSBob3N0IGNvbnRyb2xsZXINCj4gKyAg
ICAgIC0gZGVzY3JpcHRpb246IGJ1aWx0aW4gTVNJIGNvbnRyb2xsZXINCj4gKw0KPiArICBpbnRl
cnJ1cHQtbmFtZXM6DQo+ICsgICAgbWluSXRlbXM6IDENCj4gKyAgICBpdGVtczoNCj4gKyAgICAg
IC0gY29uc3Q6IHBjaWUNCj4gKyAgICAgIC0gY29uc3Q6IG1zaQ0KPiArDQo+ICsgIG1zaS1jb250
cm9sbGVyOg0KPiArICAgIGRlc2NyaXB0aW9uOiBJZGVudGlmaWVzIHRoZSBub2RlIGFzIGFuIE1T
SSBjb250cm9sbGVyLg0KPiArDQo+ICsgIG1zaS1wYXJlbnQ6DQo+ICsgICAgZGVzY3JpcHRpb246
IE1TSSBjb250cm9sbGVyIHRoZSBkZXZpY2UgaXMgY2FwYWJsZSBvZiB1c2luZy4NCj4gKw0KPiAr
ICBpbnRlcnJ1cHQtY29udHJvbGxlcjoNCj4gKyAgICB0eXBlOiBvYmplY3QNCj4gKyAgICBwcm9w
ZXJ0aWVzOg0KPiArICAgICAgJyNhZGRyZXNzLWNlbGxzJzoNCj4gKyAgICAgICAgY29uc3Q6IDAN
Cj4gKw0KPiArICAgICAgJyNpbnRlcnJ1cHQtY2VsbHMnOg0KPiArICAgICAgICBjb25zdDogMQ0K
PiArDQo+ICsgICAgICBpbnRlcnJ1cHQtY29udHJvbGxlcjogdHJ1ZQ0KPiArDQo+ICsgICAgcmVx
dWlyZWQ6DQo+ICsgICAgICAtICcjYWRkcmVzcy1jZWxscycNCj4gKyAgICAgIC0gJyNpbnRlcnJ1
cHQtY2VsbHMnDQo+ICsgICAgICAtIGludGVycnVwdC1jb250cm9sbGVyDQo+ICsNCj4gKyAgICBh
ZGRpdGlvbmFsUHJvcGVydGllczogZmFsc2UNCj4gKw0KPiArcmVxdWlyZWQ6DQo+ICsgIC0gcmVn
DQo+ICsgIC0gcmVnLW5hbWVzDQo+ICsgIC0gaW50ZXJydXB0cw0KPiArICAtIG1zaS1jb250cm9s
bGVyDQo+ICsgIC0gIiNpbnRlcnJ1cHQtY2VsbHMiDQo+ICsgIC0gaW50ZXJydXB0LW1hcC1tYXNr
DQo+ICsgIC0gaW50ZXJydXB0LW1hcA0KPiArDQo+ICthZGRpdGlvbmFsUHJvcGVydGllczogdHJ1
ZQ0KPiArDQo+ICsuLi4NCj4gLS0NCj4gMi4xNy4xDQoNCg==

