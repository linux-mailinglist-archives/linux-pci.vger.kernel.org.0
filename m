Return-Path: <linux-pci+bounces-749-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455680C744
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 11:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 351CC1C20996
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 10:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2FE92D606;
	Mon, 11 Dec 2023 10:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Mbvv5xxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2048.outbound.protection.outlook.com [40.107.20.48])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7386EB4;
	Mon, 11 Dec 2023 02:52:19 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tta6Hl8/H2kUsO5rymnCy7DXFl6uksMco1NSocfQ1gDCYyGloXAHfeqgSwnJ5lC6qlDqiB4DjJo4M8F0v56tSifW6HkYrQpiY8/W5aw3jb5mTBSgvjd6hFz2/M2GGt77hnmw/+Y60hn71kSNW84JRppPETBWa0KYt9va0Kp3T/8THijJS4ssF6+JBxMF/DbMpjxQ4rXZgnTMfrSXjqeagnYo45sw6x3EIGZLQTyWzXq2gYOihjy3Ci+c1yZSRt9HQO5YQ+haoW4x0r1/DXCSANa+F7QGvCgyIOPvIFqpinFiz6tEay/JK2fjHDT7pEaYDzRBdpfPPMegxMhHacS3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ztgc6tBvVDPKZIm5/Qv7LCQvAvs2gHaMIlE3FoTGpv8=;
 b=BqZiZ2u2easTu1xfKmg2wH14Vi2cf3av2lqju2vzVZPJwRwEfsKta/c1FcKFomITrNwQX4/WOgdNmHYn+JWgcKUsHcDu31qw5mvaQUEXwrfJ/zBOOfmv1borbl7tGXEjSRyBbhrm44047BzhkfpyEWYR0odxaUR1DOveSTSLYRNUzUmZj709I3IMTl+dp+l4BUFkfUlvTSlLxLrnjRItjazywsLIz9gU4bjlXy0Q/KhqZXTzY1oRoVce72Pl3KREBt0DAzWf28e4arJk2KNyVUWowbfRK3ubsEe3s+gui8I7YyrOvSlDjd9QIHQqx9iF2pcNasYvKkG4aYgtOH51Sg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ztgc6tBvVDPKZIm5/Qv7LCQvAvs2gHaMIlE3FoTGpv8=;
 b=Mbvv5xxIgJO1OSxxWO6xi0BoL1/PKsp1xgzme6PHtmTN4MV4N1qBO6KODXasqIa/krgXUtf6Qd+do3VEuI6zME0QLp2Csb7X8hITu8tAGekvBUVQRXMTvOcwxUh21AD4DddmCmwSfGdO0PttVc4lcQxBoUq+5ucTdk5pZ0dvxIo=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM0PR04MB7092.eurprd04.prod.outlook.com (2603:10a6:208:19c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 10:52:16 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 10:52:16 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Rob Herring <robh@kernel.org>, Lucas Stach <l.stach@pengutronix.de>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>,
	dl-linux-imx <linux-imx@nxp.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Thread-Topic: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Thread-Index: AQHaKbbwr3lxUFkrO0CtzIef2ijtuLCfJ0WAgAC3IICABAysEA==
Date: Mon, 11 Dec 2023 10:52:16 +0000
Message-ID:
 <AS8PR04MB8404E5D80CE9E09D835A92AB928FA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
 <20231208091355.1417292-3-sherry.sun@nxp.com>
 <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
 <20231208205545.GA2675840-robh@kernel.org>
In-Reply-To: <20231208205545.GA2675840-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AM0PR04MB7092:EE_
x-ms-office365-filtering-correlation-id: 24a2c231-e38e-48b9-a929-08dbfa373d9a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 cn8wuD4bMsTo/seuI11mED0a+AWPwfCViW1QKb7VKWc29otep4OIIwlIxyaO3nXzgbR+sDCpy1fjh6jxnWR1a7DQtYAsUjL9eWuxuk2zyOYuY+Uy2D7tJwlwa54OohCfDF3y7kVv9YhUhSGaAnzn78pWLXN5+TDlppJzKdtis8Ug8xmMyf9OBA5eUVFUmzkG3V96Bh/SqsLnv42m6LKwrNXEj64CE/Gv5nUD89D9eUhRbCjHWGaIt8E/pm0pkckdhtXL+q3ZnxhNo1w7JDdHWyluix1lsq6err0SJjqZwy3CsaEgoj5MO006/SHD9EMw6U6ltUCpX5fwfApjRmaNKUXoDK70Un0ZvqNl5sWviER/xN1q1pdoadcLiAu+2Img9OuGVfEbgbzNQThTNaJ+OPHqlgc7xaReKGcdyLo57AKROB85aXpkqT2MbvoyUpdnQqA6FtudXYzeN0u5a3644CnBaS5xmmQElfLkDQ6j3/8Dx3KICIopKcLNVRdj35+vUNt+k5basnlW3NCzu89WGeez3jHyUjyCYQXuYEQUzuRtxplLOoLBviBsJqrZvJLhw0uYhLGcw5vtdcJN9R5rJhI3YoeXX/dgcIk/G8O0k/3IrePcLtvJ93BSxzTOqLW0lbaH153p6WxtRerFJRDBVw==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(136003)(366004)(376002)(396003)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(71200400001)(7696005)(9686003)(6506007)(53546011)(83380400001)(5660300002)(7416002)(52536014)(2906002)(41300700001)(478600001)(4326008)(8676002)(8936002)(66946007)(76116006)(66556008)(66476007)(316002)(66446008)(54906003)(64756008)(44832011)(110136005)(122000001)(86362001)(38100700002)(38070700009)(33656002)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?Q3ZuTlgzNVZtWUNPeThRUnNCRFg4bnV6QTJ4Q0JibkpUOTFPQU9oM2xoSmdl?=
 =?gb2312?B?Wk9CeHdnc3ZzN2NmSzZPRXRROHhLTXRnc0JPaE5kZGdrcVd3dnlYc2tjV095?=
 =?gb2312?B?cHR1NmgrUzJ2VXNjTkEzUVlEMDlHVHVEOEZFanRqQ0FJaS8wOXh0NlB6dG40?=
 =?gb2312?B?aldVNFVtbkFVVzhtS0RJdE44TDhFd2tMYzV4VXM0SmJFeGlSbDBJL1NEOWVP?=
 =?gb2312?B?N2JsaGRRNzNQOVUvSERuaVRoNm1wbW5ndmliQlRsRHNKOEN1N3FCV0dsQm5M?=
 =?gb2312?B?R0dsNHlNbUFQOEVyamZHRlZuZVAzVTduV1p5eDAvYTFPS3NnbEg3V3Uwem1Y?=
 =?gb2312?B?eTViNVJFdzRMV0xEZXFtaUpENnRxcnRVSDZhdWplR1AwNm92ZkVQdWlSb2oy?=
 =?gb2312?B?RWlHZ3JqekQ1ci84TVkyM1IyOXZvYXZqS1IrQTRhN2d1QUQzZ2NXaHVaRWhm?=
 =?gb2312?B?RW1aWU9aR1BhL0tOUzJkUWZpenNOaFVXTG9tK0hWWHpOUCtibXVRazl4M24w?=
 =?gb2312?B?SjVpZTFISWlOem5Ec3BhQzhpOHBOUlRKeFZFMUVaQjRmdGdPSzlKelBtU2kv?=
 =?gb2312?B?R3d3eHN2WFVseHROMXRzK2N5QUFINGFDMlMrbyt5dE5hd28wMmFlM2RyTUp1?=
 =?gb2312?B?cE1WcWhMdmUxdmZaeDk4ZC84ZXFzOTJHdW80LzBkQklrcTR6TEs4b2FhOGVD?=
 =?gb2312?B?d2hJR2Nab1NvNitveU16cEExbEpqaktGaXJQVmRjN1NCVzNCU3Z0MFZpWUdV?=
 =?gb2312?B?Uk1IKzNTZ3BaNytqYWFLUWl2NGswaW0vb3gzU0VjditNWDU0clNwOXFXOXVo?=
 =?gb2312?B?dmlGWlpWOTNiNVlQbVQzcjlsTDlUa004cjZ2RjZwMHNGSmxIVEs3WW5SNkd5?=
 =?gb2312?B?di9IZUNrZUxmQ1RZRXA2clZjdGRVZG8wMllhVjYvREk3UXdDVk1TeWt4NXNC?=
 =?gb2312?B?dlJhRUpGL1VRSDZmYmZKc1hzQjhwbGNVNDUwcGF6M0pKNjdpRldSVzRDc1BX?=
 =?gb2312?B?SG5zeHlHVGVjQk04bFhLYWUrT0FoVG5yb0JoWEg1aXJiTStOSlNJYWhGdDE3?=
 =?gb2312?B?dmdTSzBFQTd2Z1hKaVh5UUxQU0xHUUEya0xZNVpseHlaSS82SnFoeHc1MnVl?=
 =?gb2312?B?dW9BNGV2Qm5rcnVnVHNqY2lHSWpueDFPWTBmUWZsNm9JT0dDMGE0NFNVMTlY?=
 =?gb2312?B?L1pCLzJPeWNMeWM4MTRkak1qTHJ2eVgxcTBqaHNaVnNrQ1BxNU1sblJvd0hZ?=
 =?gb2312?B?dVduaE1PZ2krYTBXY2tXd2lieGdtM21yeEIzWUNqK296a1g5Ukh1WXBaanhr?=
 =?gb2312?B?eWU4aVFuRFg2SGlyWlFsRUp2TnZNUVVhSmdaQXN0Y0R6RHd2a1czWkZJY3ll?=
 =?gb2312?B?dC9JV3E3T3ZZSTdIWUwwMHhsa3pWQTJwd3NCZ3kxOElqS2J2L25Kakx2RVRa?=
 =?gb2312?B?OVJZYVBFelV2S0E3RzVxbktkOWpkY29NcVhJNXlzRVFKbTdPY2N3OXVOejBU?=
 =?gb2312?B?Z1NvbGlYNm4yUHJ1V1dCeGFSTXQrNFg3Z2RwQmdnN1NnY3hkbkNKVUxWaFVk?=
 =?gb2312?B?Ti9SMHF0ZnZKQWJRQ1NXeGRST1dNY0tjU0dBWmZldk8zNmZlSHpiUnUxUE42?=
 =?gb2312?B?MUk1MVdXUG9hSGF6MHRJTWpOQ1VCYmdCTTRmbVJndk15cHg5MmtxeTlQYVdF?=
 =?gb2312?B?ODE3OHBJd1BHakFmRDN5UkxWN0tremhNSTRtMVNjMWJhS2RwS1Blak1NSVR3?=
 =?gb2312?B?bTg0d1FkVGdtWDVHM1k1UVFIc3ZRVU5uMlRveUhMaC9hWnZrUm9qZUVQUDFX?=
 =?gb2312?B?VkFRVnRCc3F6WEExMU9VOEQzcGZ2SlVRUzdFZitLR2JxQzlLRmNTVGNZdkpB?=
 =?gb2312?B?Wm9JMzNPM3VkdVBENTU2NkoyT3NiL0ZRcUVNa3VNU0V3ZU1ZRTlkTEZwckR4?=
 =?gb2312?B?ZFQzeGRoTGI3M255eDR5NWNwTHRxR1d0MDh2T3JXMy9MZXZzeWxBdG95YWhK?=
 =?gb2312?B?TlZEOVNwb0hhZmdIbGl5MjNSMHJpemVtZnVkSWt6TG5MdnZuNVlSdEtHYmFP?=
 =?gb2312?B?L2xIVGdaUjNXajVjSEVYRzFvSHpRNTdUa3E1RTVKRVpETTdaWFlMa0VncG94?=
 =?gb2312?Q?irxM=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24a2c231-e38e-48b9-a929-08dbfa373d9a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 10:52:16.6373
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q3AsDbMxz6tUFW2cLkdJydWeFwwTnUcaLMAILc3D+nQVCCXCBpss10S1G72i/c/9dLVcTKcpDwsp5r95i4YjDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7092

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyM8TqMTLUwjnI1SA0OjU2DQo+IFRvOiBMdWNhcyBT
dGFjaCA8bC5zdGFjaEBwZW5ndXRyb25peC5kZT4NCj4gQ2M6IFNoZXJyeSBTdW4gPHNoZXJyeS5z
dW5AbnhwLmNvbT47IEhvbmd4aW5nIFpodQ0KPiA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBscGll
cmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsg
a3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBrZXJuZWwub3Jn
OyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0KPiBrZXJuZWxA
cGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14IDxsaW51eC0N
Cj4gaW14QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0tDQo+
IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsg
bGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSCAy
LzRdIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgaG9zdC13YWtlLWdwaW8NCj4gcHJvcGVy
dHkNCj4gDQo+IE9uIEZyaSwgRGVjIDA4LCAyMDIzIGF0IDExOjAwOjE5QU0gKzAxMDAsIEx1Y2Fz
IFN0YWNoIHdyb3RlOg0KPiA+IEhpIFNoZXJyeSwNCj4gPg0KPiA+IEFtIEZyZWl0YWcsIGRlbSAw
OC4xMi4yMDIzIHVtIDE3OjEzICswODAwIHNjaHJpZWIgU2hlcnJ5IFN1bjoNCj4gPiA+IEFkZCBo
b3N0LXdha2UtZ3BpbyBwcm9wZXJ0eSB0aGF0IGNhbiBiZSB1c2VkIHRvIHdha2V1cCB0aGUgaG9z
dA0KPiA+ID4gcHJvY2Vzc29yLg0KPiA+ID4NCj4gPiA+IFNpZ25lZC1vZmYtYnk6IFNoZXJyeSBT
dW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4NCj4gPiA+IFJldmlld2VkLWJ5OiBSaWNoYXJkIFpodSA8
aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gPiAtLS0NCj4gPiA+ICBEb2N1bWVudGF0aW9uL2Rl
dmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwgfCA0ICsrKysNCj4gPiA+
ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4gPg0KPiA+ID4gZGlmZiAtLWdp
dA0KPiA+ID4gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2
cS1wY2llLnlhbWwNCj4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3Bj
aS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gPiBpbmRleCA4MWJiYjg3MjhmMGYuLjk0NGYwZjk2
MTgwOSAxMDA2NDQNCj4gPiA+IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5n
cy9wY2kvZnNsLGlteDZxLXBjaWUueWFtbA0KPiA+ID4gKysrIGIvRG9jdW1lbnRhdGlvbi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL3BjaS9mc2wsaW14NnEtcGNpZS55YW1sDQo+ID4gPiBAQCAtNzIsNiAr
NzIsMTAgQEAgcHJvcGVydGllczoNCj4gPiA+ICAgICAgICBMPW9wZXJhdGlvbiBzdGF0ZSkgKG9w
dGlvbmFsIHJlcXVpcmVkKS4NCj4gPiA+ICAgICAgdHlwZTogYm9vbGVhbg0KPiA+ID4NCj4gPiA+
ICsgIGhvc3Qtd2FrZS1ncGlvOg0KPiA+DQo+ID4gVGhlcmUgaXMgb25seSBvbmUgd2FrZSBzaWdu
YWwgaW4gUENJZSBhbmQgaXQgaGFzIGEgZGVmaW5lZCBkaXJlY3Rpb24sDQo+ID4gc28gdGhlcmUg
aXMgbm8gcG9pbnQgaW4gc3BlY2lmeWluZyB0aGF0IGl0IGlzIGEgaG9zdCB3YWtldXAuIEFsc28g
R1BJTw0KPiA+IGhhbmRsZXMgd2l0aG91dCBhIHRyYWxpbmcgJ3MnIGFyZSBkZXByZWNhdGVkLiBT
byB0aGlzIHNob3VsZCBiZQ0KPiA+DQo+ID4gd2FrZS1ncGlvcw0KPiANCj4gQW55IHN0YW5kYXJk
IFBDSSBzbG90IHNpZ25hbHMgbmVlZCB0byBiZSBkb2N1bWVudGVkIGluIGNvbW1vbiBQQ0kgc2No
ZW1hLg0KPiBBbmQgdGhleSBzaG91bGQgc3RhcnQgZ29pbmcgaW50byByb290IHBvcnQgbm9kZXMg
cmF0aGVyIHRoYW4gdGhlIGhvc3QgYnJpZGdlDQo+IG5vZGUgYmVjYXVzZSBpdCdzIHRoZSByb290
IHBvcnRzIHRoYXQgY29ycmVzcG9uZCB0byBzbG90cyByYXRoZXIgdGhhbiB0aGUgaG9zdA0KPiBi
cmlkZ2UuIFdlJ3ZlIGp1c3QgdGFrZW4gc2hvcnRjdXRzIGJlY2F1c2UgbWFueSBob3N0IGJyaWRn
ZXMgb25seSBoYXZlIDENCj4gcm9vdCBwb3J0Lg0KPiANCj4gTm90ZSB0aGF0IEknbSBpbiB0aGUg
bWlkZGxlIG9mIHNwbGl0dGluZyBwY2ktYnVzLnlhbWwgaW50byBob3N0IGJyaWRnZSwgUENJLVBD
SQ0KPiBicmlkZ2UgKGFuZCBSUCksIGFuZCBjb21tb24gZGV2aWNlIHNjaGVtYXMuDQo+IA0KDQpI
aSBSb2IsIHRoYW5rcyBmb3IgeW91ciBjb21tZW50LCBJIGFtIG5ldyB0byBQQ0llLCBjYW4geW91
IHBsZWFzZSBwcm92aWRlIG1vcmUgZGV0YWlscyBvbiB3aGljaCBjb21tb24gUENJIHNjaGVtYSB0
aGUgV0FLRSMgcHJvcGVydHkgc2hvdWxkIGJlIGFkZGVkIGluIChtYXliZSBzbnBzLGR3LXBjaWUu
eWFtbCBvciBzb21ldGhpbmcgZWxzZSk/DQoNCkJlc3QgUmVnYXJkcw0KU2hlcnJ5DQoNCg0K

