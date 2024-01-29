Return-Path: <linux-pci+bounces-2713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26880840394
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 12:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6606284A85
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 11:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 464F35B5A5;
	Mon, 29 Jan 2024 11:12:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2078.outbound.protection.partner.outlook.cn [139.219.17.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14FC556459;
	Mon, 29 Jan 2024 11:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706526771; cv=fail; b=gXA+tZLPiMTm9WcztGQJXgCMlTD1y5rsHMVgsQ0OMLsuR/oduuNSgtg2cws3pyI4IiS88nhbD/XXsgCYxNQBxvgVvZsOOAujLY3oBWXqxiZPOPsD6DkMkOqUixbNuWONtHi+vx+9jG7vklh7V9XwGSN0ygRZaRmjMrj7hQuupzY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706526771; c=relaxed/simple;
	bh=ckTVQcOJ7LSvXTt1r4HqH5W4W9jyDX/ZMccvm6od7VU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TawqGuo47aFiXSUU+QK45Qv3x3nOe5qarMQR2NoSIYQ/ikRQ4EHNb0HypnuOdmjXMcyP8FQvI2BSp2CDwab36p3ez452HYBCePbO23uG4bmIkejkqvMt/u2odZrAfm/gDuHKmu3yGaHVQ1hsG7t838/ILqNw8Rqtn5EHZZfehxI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OmRYmTQ6nm0GJUwzzrQXdgl+pwbeJH/0zxJCgIUN+/sF6lTBoEurr9dFXVkmJfFVf8hNjnNLBEQxHknRGEbdenJMEUNXO0IyHvZv51GY8jA1vAgRGSJoDLkQLvncc5umN97+Sp8QUq9kErBXv7WGSoY3NWv+iU9yL7yZ8RmO64COQFlmi3kZIO65sX5trpXjift/jrdAozB2Z28xC0h9lX85aTfXJc6yST0tEE+gncYNI2f7zCA/OGyOvRyB+SgAfgHc5m9WBKA68QyZniFdV+tIAN42pIx8VHSYpD3Sh9+Kkbh2+cb1JIKopp+dsCvlxbiVl+0Z9cMZ7a7jsqyDww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckTVQcOJ7LSvXTt1r4HqH5W4W9jyDX/ZMccvm6od7VU=;
 b=PuhAOwahHJJaPVj6vv13Zvk6Lj9iU4hoqmihEhjsmXmlVcztdCFxBUfBX1Egk0uR422SmiWfl5mEB1N5/DFN7SedbZClk9/oQHso8ErDi+YNXaKWqWNlU3jX0b3Q6zrD1ZExe8aQD3rm0ZcBZi/NhOrsdMzqqlS6J7ViUYRg/PzzR6h30vcBCqol5WUgv8DtvtjB1tmf+pE1HIZhUc0dENn+XAJvejs5ikrNKPkzD+gJU8IIOsXHfooGkRYwbFPts5m+6CAboGxNWW1kIQUjFQZOOkAmSUTsrngT8wR+w4WIG7kaOVNRDgVpVToFqZi0iON7WPJWXya2+XhKsvIgLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0495.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 29 Jan
 2024 11:12:36 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::5a5a:fa59:15fd:63dc]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::5a5a:fa59:15fd:63dc%3])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 11:12:35 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>, =?gb2312?B?S3J6eXN6dG9mIFdpbGN6eai9c2tp?=
	<kw@linux.com>, Rob Herring <robh+dt@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>, Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Paul Walmsley
	<paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Philipp Zabel <p.zabel@pengutronix.de>, Mason Huo
	<mason.huo@starfivetech.com>, Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v14,RESEND 15/22] PCI: microchip: Add event irqchip field
 to host port and add PLDA irqchip
Thread-Topic: [PATCH v14,RESEND 15/22] PCI: microchip: Add event irqchip field
 to host port and add PLDA irqchip
Thread-Index: AQHaUk6kBq7FoRtl5E2kE7tbXdr61bDwo4GQ
Date: Mon, 29 Jan 2024 11:12:35 +0000
Message-ID:
 <SHXPR01MB0863594A82EE4019162FF79AE67EA@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20240129010059.3672-1-minda.chen@starfivetech.com>
 <20240129010059.3672-2-minda.chen@starfivetech.com>
In-Reply-To: <20240129010059.3672-2-minda.chen@starfivetech.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0495:EE_
x-ms-office365-filtering-correlation-id: e63e4bfb-ef1c-4f45-f15c-08dc20bb3287
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Qr021snsFm8KfKTwTEQO9Eh3eEHTg1ZpmFOUREHhFHU4m83Y2PKdj3QOmazIIR6SwsIS5CD8rVmhZFKdTPLS4q57Bk5FS4RQ60+tnz2rQgxKZPAyEYp6Ycw0sTI0OhO7nFA8WnGbecoA8WPU/cVUPF8AcDKu11zWWwH+7YNx2/wLKMpKOxIBotvBzCGqef14QO0CynkogoQ1F7WHpWei94ubWTiJTYyDiQi/f4mO0OFiTjOTmndSree2djgXTlyya79lcvilbp7skncp95g6UK53Xs5TuJklPah7ex9IM59n0pI257si3vHXKhRnCNwd+MmX8ueW6YmfspejNQ3kSzALjljwdZD9J7IRpDU6tMTBYy9KIV26lgRintIoFEFaViXEc+DX8+q32jSH120o9/PMuZhdlhy76cPIllxTW78ZJCqJs9ZV62Tl6lZrzAA28nv7ur7233XrYEWIAkj4JVEL+7ByHn78u+FVaLa/xjXp5ty/x4hWwZ8vW3MPNvnXoVubbJuLRJFskkGHcJcnSuLNhn98ynb+hHYonzGibHTFwKeYrFVRmKUfo5GNw1Fj
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(396003)(39830400003)(346002)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41320700001)(55016003)(7696005)(71200400001)(83380400001)(9686003)(107886003)(26005)(86362001)(33656002)(38100700002)(122000001)(38070700009)(40160700002)(5660300002)(40180700001)(44832011)(7416002)(2906002)(110136005)(8936002)(4326008)(66946007)(64756008)(54906003)(66446008)(66556008)(41300700001)(66476007)(8676002)(76116006)(508600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bUkyVmlOMXFmYVIxbXBURWlHVEtvN1Jna09kYUJUL2JpUVBhak5HYzZEc3ha?=
 =?gb2312?B?elFTdllFVS9hSmlXZzdQODc4dTlaYUdMakZIR3ZWY3VBRmhnL1czeGlGVWtQ?=
 =?gb2312?B?QkxLNWlGTWZ0Qkd0T1FwZm1ldERsMWZENjEyVVFpY0c2bWxEUGplTmFaU0dk?=
 =?gb2312?B?dnlEeTZJbUlScHFwb2hxc1FXeGJBNElhdW1Lalgyd2YvdUxJc3dLcEpsZ0NP?=
 =?gb2312?B?clNPbGdhSnppaUxRRHVPSHhVQ0NCNHhNZnFIUktFUFJmSVFiTy84RVN1VjVL?=
 =?gb2312?B?ZXN0dmx3NnpCZGFnbnVJdllRa3pPcmp1d2lUUC9XcG90aXQ4YXJRaC9yNEk5?=
 =?gb2312?B?a1JJTUk4Q3B4UmJVWGMxdGpoQWxWSzBtdjRXdVM1YUxRUUdpN2NnakcrTncx?=
 =?gb2312?B?aGs5M1BURWtOZ2oreVRJaGh0OHlaakFWZU9WcTU4clFKdlRhOXhGcnNNRmQy?=
 =?gb2312?B?bWx2aEhSdTBmeXAzKzNURnlLVlhtRDUvVkwrdjQwWlhLbk9HYUNnUWdCY3cv?=
 =?gb2312?B?dURsS0JuUmdDWnJQcGF2NXU2QXI1OC9FRHlWTWRNUjV4dXMvSWQ0VEpZcXZr?=
 =?gb2312?B?WW13c2EvZHdIOFloaHhrMTJqblFycW9mSmczcUpkU3NsRVdwVVFXMllOTlRq?=
 =?gb2312?B?SEtONmpnUlN2Yk1kZkRxZnNmbGQ1d1NLL3VnWTd0MENjOUNDUFNaL3hyMkdE?=
 =?gb2312?B?QW5yLzlIK0tYdUhpY2lNTlVwOGNGSldyVkp3dHM2K284RVlxYjZjMUZKajJ0?=
 =?gb2312?B?OXVEQ3VjTWYzRjVzZ0I1TU1TL0plOHZRQndMR0NoMmZHTFVCVmlzeDBFOU9O?=
 =?gb2312?B?aHRxYkFBNEFIYVMweDRmemovRVhDMUpkc2JCYUp2MVl0djdTazdya1oydmJT?=
 =?gb2312?B?QU8va1JWdkw5Vkh3MGFHd0MyVXY1ZjF2S3dlUUhENUdjcEJ2aWJwenU4TEs0?=
 =?gb2312?B?RTJXQjJCRkVJaTA2NWdnb1Q2QTRDTGpaVllncitZZlRlWWVBOWFFUUhvaWo1?=
 =?gb2312?B?MGJtUDBPK0NlL1pBQmtreEtPbis2V01zbHlERmc4NHYzYVEvdXM4LzQzMG9L?=
 =?gb2312?B?WWprSzRac3V5bEZHQlZBM3Y5RE5WQ0hqVUJ4VGxvZHZMUGhtQmo4aUlQSmJm?=
 =?gb2312?B?Ni85RUlhT21ObFZtVHdsWW54V1MzRWhZTksxT2o0d3lFODcrUFBDbVNSS2Zz?=
 =?gb2312?B?SVFXYmhIN1lwOEZyQU1UdXRZVTUvSTRYS3F4QnZ4MDcvQzJVSzRudlpVdk0v?=
 =?gb2312?B?VHlTUTBRYW5TcW5XbFgzd2Jma3VwakFJaFJvTm9TNC9iUE9MLzVRckwrcmxu?=
 =?gb2312?B?YU85dG96VzFZZlovU0ExTUNNODc0RUM1ZG12QmVhQXJKUTBJM2pDdTlVUTBh?=
 =?gb2312?B?L3dDcUVLcEZISmhwcnFsMlBsY1NvUHZhUkw2TStZNTNIUVVwVGMweWpkZWp0?=
 =?gb2312?B?NnE1bkRWOHMzTHkycHU1SXN2OGc0S1pyTjRFaDJkUkdaUUlRYXFpZjlpRTlV?=
 =?gb2312?B?aWc4QXRKMVA0TjNFQVMwUGs5QllQNmk0aGp0cGxWWGt0TUxSM1JlZGFubm8w?=
 =?gb2312?B?a1V4blBSV0VvN3BaazVjamo2SUdMTnpUWWxPaFR3dVFzVE1QOXpBNDZ4a1h3?=
 =?gb2312?B?MG1HdEJuNFlKNldJZE03SWs4UmlrZ3N2QzVhdEVlSGxWNDB3UVd3Nk15dlZm?=
 =?gb2312?B?WXp3ZXZIUy85dXRPT0YyOTY5Z1NQQ09YWlc2RWhOWTlqYW1BRDNoNU9pUWxx?=
 =?gb2312?B?STdQQ1p0WUFkc25JcEJmQm1va0xTZnZzREJzQ1VZMVJDMlMrRGZDOW5JMXBW?=
 =?gb2312?B?MjFyWTJKOGZZOHI3dkZhY3FHeGw1MFMwUUdQeFBPY21RTlJqaE9MN1kzakcx?=
 =?gb2312?B?SkNlUFhoOVV2cHQ1TlJBRWozd1RPWHJJRUYvejRQY05mU1diZ3IxbDNHbng4?=
 =?gb2312?B?bWZuVmxoeEVJYWtWQWZBbmUyYXdGb0dFMTlUUW1aaWIvYUNWOElzYUhuc2hQ?=
 =?gb2312?B?L0F5Wm9nYWcyTUVyTGVuajFYYzMwNjdySlJxa1VBRllobWYrMU9YSm1FcWdv?=
 =?gb2312?B?Y1VjWEtyVERXNzFPcGM0Qjk2cU5UVjVNUTRoTVdyY0dnUDNlNmxCSElIZ2JI?=
 =?gb2312?B?YTIvU2pSTUE3TXJhTGhJbXNWVzY0cnNHMGYwWUx2ZlNJWHczVnlMY1B2MGJ5?=
 =?gb2312?B?Z3c9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e63e4bfb-ef1c-4f45-f15c-08dc20bb3287
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2024 11:12:35.8304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vpe4KVbPUJzYZOK3FTkz7vRMXhuSVfQBWZtsEwca5JsbDbJIhbWV9qGBKnkLQMPSlyMrusH/GKiFL4pTpVstkaHvj1QqZL3SkHWT15EgMLE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0495

DQo+IA0KPiBBcyBQTERBIGR0cyBiaW5kaW5nIGRvYyhEb2N1bWVudGF0aW9uL2RldmljZXRyZWUv
YmluZGluZ3MvcGNpLw0KPiBwbGRhLHhwcmVzc3JpY2gzLWF4aS1jb21tb24ueWFtbCkgc2hvd2Vk
LCBQTERBIFBDSWUgY29udGFpbnMgYW4gaW50ZXJydXB0DQo+IGNvbnRyb2xsZXIuDQo+IA0KPiBN
aWNyb2NoaXAgUG9sYXJGaXJlIFBDSUUgZXZlbnQgSVJRcyBpbmNsdWRlcyBQTERBIGludGVycnVw
dHMgYW5kIFBvbGFyZmlyZSB0aGVpcg0KPiBvd24gaW50ZXJydXB0cy4gVGhlIGludGVycnVwdCBp
cnFjaGlwIG9wcyBpbmNsdWRlcyBhY2svbWFzay91bm1hc2sgaW50ZXJydXB0DQo+IG9wcywgd2hp
Y2ggd2lsbCB3cml0ZSBjb3JyZWN0IHJlZ2lzdGVycy4NCj4gTWljcm9jaGlwIFBvbGFyZmlyZSBQ
Q0llIGFkZGl0aW9uYWwgaW50ZXJydXB0cyByZXF1aXJlIHRvIHdyaXRlIFBvbGFyZmlyZSBTb0MN
Cj4gc2VsZi1kZWZpbmVkIHJlZ2lzdGVycy4gU28gTWljcm9jaGlwIFBDSWUgZXZlbnQgaXJxY2hp
cCBvcHMgY2FuIG5vdCBiZSByZS11c2VkLg0KPiANCj4gVG8gc3VwcG9ydCBQTERBIGl0cyBvd24g
ZXZlbnQgSVJRIHByb2Nlc3MsIGltcGxlbWVudHMgUExEQSBpcnFjaGlwIG9wcyBhbmQNCj4gYWRk
IGV2ZW50IGlycWNoaXAgZmllbGQgdG8gc3RydWN0IHBjaWVfcGxkYV9ycC4NCj4gDQo+IFNpZ25l
ZC1vZmYtYnk6IE1pbmRhIENoZW4gPG1pbmRhLmNoZW5Ac3RhcmZpdmV0ZWNoLmNvbT4NCj4gQWNr
ZWQtYnk6IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0K
PiAgLi4uL3BjaS9jb250cm9sbGVyL3BsZGEvcGNpZS1taWNyb2NoaXAtaG9zdC5jIHwgNjYgKysr
KysrKysrKysrKysrKysrLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRhL3BjaWUtcGxk
YS5oICAgICAgIHwgIDMgKw0KPiAgMiBmaWxlcyBjaGFuZ2VkLCA2OCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
bGRhL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxk
YS9wY2llLW1pY3JvY2hpcC1ob3N0LmMNCj4gaW5kZXggYjNkZjM3M2EyMTQxLi5iZWFmNWMyN2Rh
ODQgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLW1pY3Jv
Y2hpcC1ob3N0LmMNCj4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRhL3BjaWUtbWlj
cm9jaGlwLWhvc3QuYw0KPiBAQCAtNzcwLDYgKzc3MCw2NCBAQCBzdGF0aWMgc3RydWN0IGlycV9j
aGlwIG1jX2V2ZW50X2lycV9jaGlwID0gew0KPiAgCS5pcnFfdW5tYXNrID0gbWNfdW5tYXNrX2V2
ZW50X2lycSwNCj4gIH07DQo+IA0KDQpIaSBUaG9tYXMNCiAgQXMgcHJldmlvdXMgRS1tYWlsIGNs
YWltZWQsIFRoaXMgUExEQSBpcnFjaGlwIGNvZGVzIG5lZWQgeW91IHJldmlldy4NCiAgVGhlIFBM
REEgaW50ZXJydXB0IHJlZ2lzdGVyIGdyYXBoIGlzIHNob3dlZCBpbiAxNHRoIHBhdGNoo6x3aGlj
aCBpcyB0cmVhdGVkIA0KICBhcyBhbiBpbnRlcnJ1cHQgY29udHJvbGxlci4gDQogIEVhY2ggcmVn
aXN0ZXIgYml0IG1hcHBpbmcgdG8gb25lIGludGVycnVwdCBudW0gZXhjZXB0IFBDSWUgSU5UeCBp
bnRlcnJ1cHQsDQogIFdoaWNoIGlzIGluIGJpdCAyNy0yNCBhbmQgNCBiaXRzIG1hcHBpbmcgdG8g
b25lIGludGVycnVwdC4NCiANCj4gK3N0YXRpYyB1MzIgcGxkYV9od2lycV90b19tYXNrKGludCBo
d2lycSkgew0KPiArCXUzMiBtYXNrOw0KPiArDQo+ICsJLyogaHdpcnEgMjMgLSAwIGFyZSB0aGUg
c2FtZSB3aXRoIHJlZ2lzdGVyICovDQo+ICsJaWYgKGh3aXJxIDwgRVZFTlRfUE1fTVNJX0lOVF9J
TlRYKQ0KPiArCQltYXNrID0gQklUKGh3aXJxKTsNCj4gKwllbHNlIGlmIChod2lycSA9PSBFVkVO
VF9QTV9NU0lfSU5UX0lOVFgpDQo+ICsJCW1hc2sgPSBQTV9NU0lfSU5UX0lOVFhfTUFTSzsNCj4g
KwllbHNlDQo+ICsJCW1hc2sgPSBCSVQoaHdpcnEgKyBQQ0lfTlVNX0lOVFggLSAxKTsNCj4gKw0K
PiArCXJldHVybiBtYXNrOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgdm9pZCBwbGRhX2Fja19ldmVu
dF9pcnEoc3RydWN0IGlycV9kYXRhICpkYXRhKSB7DQo+ICsJc3RydWN0IHBsZGFfcGNpZV9ycCAq
cG9ydCA9IGlycV9kYXRhX2dldF9pcnFfY2hpcF9kYXRhKGRhdGEpOw0KPiArDQo+ICsJd3JpdGVs
X3JlbGF4ZWQocGxkYV9od2lycV90b19tYXNrKGRhdGEtPmh3aXJxKSwNCj4gKwkJICAgICAgIHBv
cnQtPmJyaWRnZV9hZGRyICsgSVNUQVRVU19MT0NBTCk7IH0NCj4gKw0KPiArc3RhdGljIHZvaWQg
cGxkYV9tYXNrX2V2ZW50X2lycShzdHJ1Y3QgaXJxX2RhdGEgKmRhdGEpIHsNCj4gKwlzdHJ1Y3Qg
cGxkYV9wY2llX3JwICpwb3J0ID0gaXJxX2RhdGFfZ2V0X2lycV9jaGlwX2RhdGEoZGF0YSk7DQo+
ICsJdTMyIG1hc2ssIHZhbDsNCj4gKw0KPiArCW1hc2sgPSBwbGRhX2h3aXJxX3RvX21hc2soZGF0
YS0+aHdpcnEpOw0KPiArDQo+ICsJcmF3X3NwaW5fbG9jaygmcG9ydC0+bG9jayk7DQo+ICsJdmFs
ID0gcmVhZGxfcmVsYXhlZChwb3J0LT5icmlkZ2VfYWRkciArIElNQVNLX0xPQ0FMKTsNCj4gKwl2
YWwgJj0gfm1hc2s7DQo+ICsJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5icmlkZ2VfYWRkciAr
IElNQVNLX0xPQ0FMKTsNCj4gKwlyYXdfc3Bpbl91bmxvY2soJnBvcnQtPmxvY2spOw0KPiArfQ0K
PiArDQo+ICtzdGF0aWMgdm9pZCBwbGRhX3VubWFza19ldmVudF9pcnEoc3RydWN0IGlycV9kYXRh
ICpkYXRhKSB7DQo+ICsJc3RydWN0IHBsZGFfcGNpZV9ycCAqcG9ydCA9IGlycV9kYXRhX2dldF9p
cnFfY2hpcF9kYXRhKGRhdGEpOw0KPiArCXUzMiBtYXNrLCB2YWw7DQo+ICsNCj4gKwltYXNrID0g
cGxkYV9od2lycV90b19tYXNrKGRhdGEtPmh3aXJxKTsNCj4gKw0KPiArCXJhd19zcGluX2xvY2so
JnBvcnQtPmxvY2spOw0KPiArCXZhbCA9IHJlYWRsX3JlbGF4ZWQocG9ydC0+YnJpZGdlX2FkZHIg
KyBJTUFTS19MT0NBTCk7DQo+ICsJdmFsIHw9IG1hc2s7DQo+ICsJd3JpdGVsX3JlbGF4ZWQodmFs
LCBwb3J0LT5icmlkZ2VfYWRkciArIElNQVNLX0xPQ0FMKTsNCj4gKwlyYXdfc3Bpbl91bmxvY2so
JnBvcnQtPmxvY2spOw0KPiArfQ0KPiArDQo+ICtzdGF0aWMgc3RydWN0IGlycV9jaGlwIHBsZGFf
ZXZlbnRfaXJxX2NoaXAgPSB7DQo+ICsJLm5hbWUgPSAiUExEQSBQQ0llIEVWRU5UIiwNCj4gKwku
aXJxX2FjayA9IHBsZGFfYWNrX2V2ZW50X2lycSwNCj4gKwkuaXJxX21hc2sgPSBwbGRhX21hc2tf
ZXZlbnRfaXJxLA0KPiArCS5pcnFfdW5tYXNrID0gcGxkYV91bm1hc2tfZXZlbnRfaXJxLA0KPiAr
fTsNCj4gKw0KPiAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGRhX2V2ZW50X29wcyBwbGRhX2V2ZW50
X29wcyA9IHsNCj4gIAkuZ2V0X2V2ZW50cyA9IHBsZGFfZ2V0X2V2ZW50cywNCj4gIH07DQo+IEBA
IC03NzcsNyArODM1LDkgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwbGRhX2V2ZW50X29wcyBwbGRh
X2V2ZW50X29wcyA9DQo+IHsgIHN0YXRpYyBpbnQgcGxkYV9wY2llX2V2ZW50X21hcChzdHJ1Y3Qg
aXJxX2RvbWFpbiAqZG9tYWluLCB1bnNpZ25lZCBpbnQgaXJxLA0KPiAgCQkJICAgICAgIGlycV9o
d19udW1iZXJfdCBod2lycSkNCj4gIHsNCj4gLQlpcnFfc2V0X2NoaXBfYW5kX2hhbmRsZXIoaXJx
LCAmbWNfZXZlbnRfaXJxX2NoaXAsIGhhbmRsZV9sZXZlbF9pcnEpOw0KPiArCXN0cnVjdCBwbGRh
X3BjaWVfcnAgKnBvcnQgPSAodm9pZCAqKWRvbWFpbi0+aG9zdF9kYXRhOw0KPiArDQo+ICsJaXJx
X3NldF9jaGlwX2FuZF9oYW5kbGVyKGlycSwgcG9ydC0+ZXZlbnRfaXJxX2NoaXAsIGhhbmRsZV9s
ZXZlbF9pcnEpOw0KPiAgCWlycV9zZXRfY2hpcF9kYXRhKGlycSwgZG9tYWluLT5ob3N0X2RhdGEp
Ow0KPiANCj4gIAlyZXR1cm4gMDsNCj4gQEAgLTk2Miw2ICsxMDIyLDkgQEAgc3RhdGljIGludCBw
bGRhX2luaXRfaW50ZXJydXB0cyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2LA0KPiAg
CWlmICghcG9ydC0+ZXZlbnRfb3BzKQ0KPiAgCQlwb3J0LT5ldmVudF9vcHMgPSAmcGxkYV9ldmVu
dF9vcHM7DQo+IA0KPiArCWlmICghcG9ydC0+ZXZlbnRfaXJxX2NoaXApDQo+ICsJCXBvcnQtPmV2
ZW50X2lycV9jaGlwID0gJnBsZGFfZXZlbnRfaXJxX2NoaXA7DQo+ICsNCj4gIAlyZXQgPSBwbGRh
X3BjaWVfaW5pdF9pcnFfZG9tYWlucyhwb3J0KTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9l
cnIoZGV2LCAiZmFpbGVkIGNyZWF0aW5nIElSUSBkb21haW5zXG4iKTsgQEAgLTEwMzksNiArMTEw
Miw3DQo+IEBAIHN0YXRpYyBpbnQgbWNfcGxhdGZvcm1faW5pdChzdHJ1Y3QgcGNpX2NvbmZpZ193
aW5kb3cgKmNmZykNCj4gIAkJcmV0dXJuIHJldDsNCj4gDQo+ICAJcG9ydC0+cGxkYS5ldmVudF9v
cHMgPSAmbWNfZXZlbnRfb3BzOw0KPiArCXBvcnQtPnBsZGEuZXZlbnRfaXJxX2NoaXAgPSAmbWNf
ZXZlbnRfaXJxX2NoaXA7DQo+IA0KPiAgCS8qIEFkZHJlc3MgdHJhbnNsYXRpb24gaXMgdXA7IHNh
ZmUgdG8gZW5hYmxlIGludGVycnVwdHMgKi8NCj4gIAlyZXQgPSBwbGRhX2luaXRfaW50ZXJydXB0
cyhwZGV2LCAmcG9ydC0+cGxkYSwgJm1jX2V2ZW50KTsgZGlmZiAtLWdpdA0KPiBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLXBsZGEuaA0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGxkYS9wY2llLXBsZGEuaA0KPiBpbmRleCBlMGU1ZTdjYzg0MzQuLmEzY2UwMTczNWJlYSAx
MDA2NDQNCj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wbGRhL3BjaWUtcGxkYS5oDQo+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGxkYS9wY2llLXBsZGEuaA0KPiBAQCAtMTA3
LDYgKzEwNyw4IEBAIGVudW0gcGxkYV9pbnRfZXZlbnQgew0KPiANCj4gICNkZWZpbmUgUExEQV9O
VU1fRE1BX0VWRU5UUwkJCTE2DQo+IA0KPiArI2RlZmluZSBFVkVOVF9QTV9NU0lfSU5UX0lOVFgJ
CQkoUExEQV9OVU1fRE1BX0VWRU5UUyArDQo+IFBMREFfSU5UWCkNCj4gKyNkZWZpbmUgRVZFTlRf
UE1fTVNJX0lOVF9NU0kJCQkoUExEQV9OVU1fRE1BX0VWRU5UUyArDQo+IFBMREFfTVNJKQ0KPiAg
I2RlZmluZSBQTERBX01BWF9FVkVOVF9OVU0JCQkoUExEQV9OVU1fRE1BX0VWRU5UUyArDQo+IFBM
REFfSU5UX0VWRU5UX05VTSkNCj4gDQo+ICAvKg0KPiBAQCAtMTU1LDYgKzE1Nyw3IEBAIHN0cnVj
dCBwbGRhX3BjaWVfcnAgew0KPiAgCXJhd19zcGlubG9ja190IGxvY2s7DQo+ICAJc3RydWN0IHBs
ZGFfbXNpIG1zaTsNCj4gIAljb25zdCBzdHJ1Y3QgcGxkYV9ldmVudF9vcHMgKmV2ZW50X29wczsN
Cj4gKwljb25zdCBzdHJ1Y3QgaXJxX2NoaXAgKmV2ZW50X2lycV9jaGlwOw0KPiAgCXZvaWQgX19p
b21lbSAqYnJpZGdlX2FkZHI7DQo+ICAJaW50IG51bV9ldmVudHM7DQo+ICB9Ow0KPiAtLQ0KPiAy
LjE3LjENCg0K

