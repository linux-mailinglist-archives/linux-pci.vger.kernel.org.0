Return-Path: <linux-pci+bounces-744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F074980C41A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F0F1C2094A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 09:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A97E21107;
	Mon, 11 Dec 2023 09:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="mYSMLi3i"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39F2EB;
	Mon, 11 Dec 2023 01:14:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=micMsoHe7lR4xp9pvit7qrPSDhjO/FjdvkX2rTaVk4PDpnjvdhgW1G36oBrVRrSM7vBTWVmJHqGNlMoUwIhiJVEwwk3qjcp+waYxeFutJ5SwxXwO/lNw0BcjwB7ED51v4XdrtrwSxsh3GtBkp+YzXFCvJyGCa7ZJ0ynkda3IegAigj/VRpWfIEjVqcLp1BzIonhwWh60uh+JImnw7YeCNz0A2q18EKTzGlScZ8UwPC8R46Y4Jsq2zUeZvshlThlJmLi5OjtzwqjdxBzqRMgPllZ/sZES8UZHu8ME1GBVY/sE2ZbbtcX5cS7j8wTiBgcgse0EgaGM9QqIKZQIZp2jzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GCg+NiHdhu/C3KbL4qN0Cx9Ilr5xM0FA9Gr2c3XuI0k=;
 b=PMEz99suR9NNf3CzSPcvNcxwTbWX9VgfAWUFptLmg0fplqTOisRTHjD2ODc85AvUbbhN3g7vQMNtXNI6zXoEuonm3HtaOOATgRSsE3rP/w7sSDJCd0hssUPn4Shjmw1yy3eW6YEzzzj4faQotguUzBkyu79uQALkREHEC7IKISyVg6XfqgOvp6hLw9qAvS5O+DpC9R1MosF6knKVRs1OrZlKc3+mwtaXl1eT7MMS413d4glKCRFsNoUgSa/7tskWo7yExevoWFrNbQyycuJqb2OoeGOocLth/tb9vVy8JL2BuLzlrFXJDe3wCFScRKNpBT5FlMoUFeCq9rhb04qhJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GCg+NiHdhu/C3KbL4qN0Cx9Ilr5xM0FA9Gr2c3XuI0k=;
 b=mYSMLi3i1RW8PGs4Gev6I1Iq8kVRMMq8jqIHRc6GJSX/Jhyf9iJhoQjgLWzM/mw7XbWmjh5yzTtCD85D3iXiK4DuPYmrbYpHqE+DQHMpRmZJsL5Fm/1yHWl5Ihe7289ScHrXXYuC+fQ9kqFwievkCwJLbzIjQiPJae38Q+yMTJo=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by PAXPR04MB8592.eurprd04.prod.outlook.com (2603:10a6:102:21b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 09:14:21 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%6]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 09:14:21 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Lucas Stach <l.stach@pengutronix.de>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>
CC: dl-linux-imx <linux-imx@nxp.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Thread-Topic: [PATCH 2/4] dt-bindings: imx6q-pcie: Add host-wake-gpio property
Thread-Index: AQHaKbbwr3lxUFkrO0CtzIef2ijtuLCfJ0WAgASpYFA=
Date: Mon, 11 Dec 2023 09:14:21 +0000
Message-ID:
 <AS8PR04MB8404D7A5FE8A93E5D0FA3D2F928FA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231208091355.1417292-1-sherry.sun@nxp.com>
	 <20231208091355.1417292-3-sherry.sun@nxp.com>
 <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
In-Reply-To: <83ca3d88cdaa7bc6e6bd3c4e88518b155a6b0f05.camel@pengutronix.de>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|PAXPR04MB8592:EE_
x-ms-office365-filtering-correlation-id: 0ef10479-03d5-4781-2fe7-08dbfa298fb4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 +qB4ORoGdoebG8VVzM5N6fKx/bA1JiUBn0DaazRgEBIImqlxF+SO12VYkcK6qvFAvK7dtLiFC2mlrv823AcrzWP0thgPQALRDeSptapBA2d7uDtll5TVd5sL0z/ZKy67tSqpeTlP5Lyz7KSC9UeRgp90ev5kzd4zjUUBNgnkclB23q9Uethc7YY4Gy9LQ5GhsU7sSTpnHMXE2kWFoM5UFfNaRIG5eIx3CYi0ZRa9CSr/yq5Dyb2DzpiDFHtCgecEEpREWxjzM3WurCd4JyUvBSDLVvP/Is5IVRw1T5DRBwh/W067AbD03mtyawY+XnmbINOFFhpBln1qsmyst17fZ5ZLrMqjUsgNprt29HfA4wC5p0bcqNnSj3sT4j/KXA2K0jngNEp7Va09HNPrKfgHIEMoYnrVvnxZGy0YiJ9F67Tb2j8eDSho7meuHuOLLdvrNoB4+X4bmGZQBG4FEUGIJ0FrcwFReyIzqq2CifgZzbLd3P1O3fOYSgbpdMSP/TUQJQ5w3y3dyTTW1Zufy+Jn3P0VhNQkJ874WQGUJtPRwKN1L1vLME6E0oEY0rQP2FLdjBrWRPEg0LUe64MD8oDaOZx2fnKNJ2r2nKLISfKlXg0AFvThbuPi8s7Ugm7eEbmHbc+zG8azeXjGwoMeGr3z5bgVPZ7gz1E1gugU/g6Jr30=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(9686003)(53546011)(26005)(478600001)(7696005)(71200400001)(6506007)(83380400001)(7416002)(44832011)(5660300002)(41300700001)(2906002)(76116006)(54906003)(66446008)(64756008)(66476007)(66946007)(110136005)(52536014)(316002)(66556008)(8936002)(8676002)(4326008)(38070700009)(38100700002)(921008)(86362001)(122000001)(33656002)(55016003)(32563001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dHdwaDhRT2RLYm9xR1RrMDYwekJqbC9WNXkzZllzaFBSQkRxYmZLcGZpbERx?=
 =?utf-8?B?YXRrcm9seFJCYjJWZUxpWUYwTVBJTHBJSUprd2toN1lZZk0zamRkbVhXNjBu?=
 =?utf-8?B?NUN6d3g5S1paeUFIMGErUjhrL2FXQi9ZNU5kT1ZIWWpndVAwaTd1b05hL05x?=
 =?utf-8?B?Zk5rUVh1clBqQTE2T3FOWW9mMDlVdWYvUUk2VG9BNnZpSjBzMHFtYndGU0do?=
 =?utf-8?B?dFlPQjNDK2FaVzFSK0VHTk8yVkNyTGtTUXF2ODIreGRxVmpLYmhLTFdRYUxl?=
 =?utf-8?B?cFprQnd6VkhYTVFXSXltWkRYUEUyelp0L0tzTlkrcXdQckZORWljYWpENFV0?=
 =?utf-8?B?Mis5SGJKbjMyeHJpSXBmZkQ1TmgzMUJwWmZ5YjBxT20vVHM4a3FTeE1KYWxz?=
 =?utf-8?B?RzlLbmdsTzRDN2dxVXdYRFVKaUx2Q1llMXkrWEhNRWpNL0FFb1VSamVuM0gr?=
 =?utf-8?B?YWlneW5ZejFuT3UveHBCNENUOWNSeUhueVluMUJ1Y1lHaEZERzZVcC9PZjA1?=
 =?utf-8?B?TEhBMWUvWXdvVGYvZm9ZQjkrNFVPUmZXRnlvZ0RMMWs0SjFvekw2UlROR1ZP?=
 =?utf-8?B?b3NTRjAxUWovR2lCVVMraXdoQkpWelMzS0M4bFB6YWw0ZEF4WG1VUUQ4UElT?=
 =?utf-8?B?NHk3OGxodS9taGppVUc0eU5CN2JHZ0RMdmxBQnRad0liU2RSSGZ6aDRoZldB?=
 =?utf-8?B?b3BZSjVrK1dsbCtlcXg0N0JQYVlULzRNbkJZSEF5dDNrTEx2cXNId0FnR1ly?=
 =?utf-8?B?QXI3UnpzbDN3c1dwb0lFSTN6S1B2S2p3SjdoVW5nNDFiM2tLVDdueG13YjBG?=
 =?utf-8?B?bWlCTjZlUndaVmZ5RWpyZ3NPbkQ0Rms5dlNCc25uVkp0MVR3aWpZNTA0WWRl?=
 =?utf-8?B?aG9BaDllWDY2NDg4bkF2NlBRamg3MmlBWnF3Q0N4M0JJQmMrLy9TSHMxU0J0?=
 =?utf-8?B?VGVCYVJLQkxuTUZzS210Q0lXTFRPK1dDeE80ZmFqUEdTZWROejF6T2N5MTk2?=
 =?utf-8?B?TTB0VG9GRnhhczNpb3ZHaXFjbFBCMDVQSHBJRzFiM3hmU084ZDVteDdoNUsv?=
 =?utf-8?B?dncxcDdNbGF6d2wzRms2dFlKUys4RjVTZVZXVVA0SWJ5cHB0LzJaNXNqem1V?=
 =?utf-8?B?ZjdRVjNLd1dLZExYYnIzZmlaRGtMV1pVOFg2YU52bG1JeXM1d3BSckRFWFJx?=
 =?utf-8?B?cmJ2cHlLTGp4NzFQZUV2NURUMHZrVWNOVitKVHBFWXFmd0NLS2plWlU5T0RH?=
 =?utf-8?B?blpQT00wRzRFZGpGeTFNckxQQnRuWmlpQi9RY2ZMdjZ3SllxcC92RDZnclBH?=
 =?utf-8?B?Z3FKRnRadVBiSmVlemdPeEFLZ3RWdm14NnFuRG1mek9PY0d4V2RnNGJwWm5o?=
 =?utf-8?B?eUlOYmx4THYwSWtzSjdMTXplVy92aFlrOElEZENYVDJhampXdVRIWk4zcVVJ?=
 =?utf-8?B?UWxQclNJUTd2YmU5ZVh1a3JIL3ZEMk1HSDQ5Nm95MXU5aU50QzkrUlVzNk01?=
 =?utf-8?B?RG9qOE5Ob1NXd1hFZjUyMmdDQzU3ejYzUG1PNkZTUmtheVlKUGg5VmZCTVR6?=
 =?utf-8?B?MDc5SFdSaE5tdVdaNGIyMWRIRmgxZldsNWlrSWk2c0NJanZIVFp2dmZ1Wk1o?=
 =?utf-8?B?UllXUVJrZ2lOODAwbVVsZWJ4clB6ZkRwcUozTHpuZEJoeVZMZVNoSDNSbWgv?=
 =?utf-8?B?aU0xWHBnTTFFUW9SSHVQNkhVQ2kvUVljRTJSeFFYQlNhU0JKTSt1NFdDTmZp?=
 =?utf-8?B?UlR0NHVtZXFjclUyUm1NaEJlbGZ5Wlh0eGZmV2VjY1VYWXVtRmRla1AxVjds?=
 =?utf-8?B?c0FDOWVDWHRsTnc5ZC8wN3dOWmJPdDRpME4rQlVEM1E3a2lzNUdyanF5STJw?=
 =?utf-8?B?WFRHQThHNjhTNWpTOGZaaloreEhTbGpxWWwwS2dTTVZWU1RRMDVzNkFnUzZW?=
 =?utf-8?B?Q21BNEtRQWU1MDYwckhWZ3BzSjl4d0hWK25JOFZKSlQvR3p1TzAzYlgxT011?=
 =?utf-8?B?Mkt6NnZlejVnbnpXSjdTbUZyTDV1MXp4b1RuYjdiN1FPWjVkbVcvMGhXQWx4?=
 =?utf-8?B?cG5SVXBodXNVK2RFM1JnS0pEZ3p5U3dxREFrVTNmNFdGbVpKeFBhM2JCblIw?=
 =?utf-8?Q?LML0=3D?=
Content-Type: text/plain; charset="utf-8"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ef10479-03d5-4781-2fe7-08dbfa298fb4
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 09:14:21.4009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 05QT1w5V/jvsCASN/WU/p2jlDagPMrQ0IeMCfj8vm97AR8fn2YIMwRM2WzENutB86ccE6X+ohdsS26tGfucAxA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8592

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTHVjYXMgU3RhY2ggPGwu
c3RhY2hAcGVuZ3V0cm9uaXguZGU+DQo+IFNlbnQ6IDIwMjPlubQxMuaciDjml6UgMTg6MDANCj4g
VG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT47IEhvbmd4aW5nIFpodQ0KPiA8aG9u
Z3hpbmcuemh1QG54cC5jb20+OyBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsN
Cj4gcm9iaEBrZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBrcnp5c3p0b2Yua296bG93
c2tpK2R0QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5l
bC5vcmc7IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsg
ZmVzdGV2YW1AZ21haWwuY29tDQo+IENjOiBkbC1saW51eC1pbXggPGxpbnV4LWlteEBueHAuY29t
PjsgbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLQ0KPiBrZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LQ0KPiBrZXJu
ZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMi80XSBkdC1iaW5kaW5n
czogaW14NnEtcGNpZTogQWRkIGhvc3Qtd2FrZS1ncGlvDQo+IHByb3BlcnR5DQo+IA0KPiBIaSBT
aGVycnksDQo+IA0KPiBBbSBGcmVpdGFnLCBkZW0gMDguMTIuMjAyMyB1bSAxNzoxMyArMDgwMCBz
Y2hyaWViIFNoZXJyeSBTdW46DQo+ID4gQWRkIGhvc3Qtd2FrZS1ncGlvIHByb3BlcnR5IHRoYXQg
Y2FuIGJlIHVzZWQgdG8gd2FrZXVwIHRoZSBob3N0DQo+ID4gcHJvY2Vzc29yLg0KPiA+DQo+ID4g
U2lnbmVkLW9mZi1ieTogU2hlcnJ5IFN1biA8c2hlcnJ5LnN1bkBueHAuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBSaWNoYXJkIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4g
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZnNsLGlteDZxLXBjaWUueWFt
bCB8IDQgKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspDQo+ID4NCj4g
PiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9mc2ws
aW14NnEtcGNpZS55YW1sDQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiBpbmRleCA4MWJiYjg3MjhmMGYuLjk0NGYwZjk2
MTgwOSAxMDA2NDQNCj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRy
ZWUvYmluZGluZ3MvcGNpL2ZzbCxpbXg2cS1wY2llLnlhbWwNCj4gPiBAQCAtNzIsNiArNzIsMTAg
QEAgcHJvcGVydGllczoNCj4gPiAgICAgICAgTD1vcGVyYXRpb24gc3RhdGUpIChvcHRpb25hbCBy
ZXF1aXJlZCkuDQo+ID4gICAgICB0eXBlOiBib29sZWFuDQo+ID4NCj4gPiArICBob3N0LXdha2Ut
Z3BpbzoNCj4gDQo+IFRoZXJlIGlzIG9ubHkgb25lIHdha2Ugc2lnbmFsIGluIFBDSWUgYW5kIGl0
IGhhcyBhIGRlZmluZWQgZGlyZWN0aW9uLCBzbyB0aGVyZQ0KPiBpcyBubyBwb2ludCBpbiBzcGVj
aWZ5aW5nIHRoYXQgaXQgaXMgYSBob3N0IHdha2V1cC4gQWxzbyBHUElPIGhhbmRsZXMgd2l0aG91
dCBhDQo+IHRyYWxpbmcgJ3MnIGFyZSBkZXByZWNhdGVkLiBTbyB0aGlzIHNob3VsZCBiZQ0KPiAN
Cj4gd2FrZS1ncGlvcw0KDQpIaSBMdWNhcywgdGhhbmtzIGZvciB0aGUgY29tbWVudCwgd2lsbCBj
aGFuZ2UgaXQgaW4gVjIuDQoNCj4gDQo+ID4gKyAgICBkZXNjcmlwdGlvbjogU2hvdWxkIHNwZWNp
ZnkgdGhlIEdQSU8gZm9yIGNvbnRyb2xsaW5nIHRoZSBQQ0kgYnVzIGRldmljZQ0KPiA+ICsgICAg
ICB3YWtlIHNpZ25hbCwgdXNlZCB0byB3YWtldXAgdGhlIGhvc3QgcHJvY2Vzc29yLiBEZWZhdWx0
IHRvIGFjdGl2ZS1sb3cuDQo+IA0KPiBUaGUgZGVzY3JpcHRpb24gaXMgd3JvbmcuIEZvciB0aGUg
UkMgY29tcGxleCBjYXNlICh3aGljaCBpcyB0aGUgYmluZGluZyB5b3UNCj4gYXJlIG1vZGlmeWlu
ZyBoZXJlKSB0aGUgY29udHJvbGxlciBkb2VzIG5vdCBjb250cm9sIHRoZSB3YWtlIHNpZ25hbCwg
YnV0DQo+IGluc3RlYWQgdXNlcyBpdCBhcyBhIGlucHV0LiBUaGUgZGVzY3JpcHRpb24gc2hvdWxk
IHJlZmxlY3QgdGhhdC4NCj4gDQo+IFRoZSBkZWZhdWx0IGlzIGFsc28gcXVpdGUgdXNlbGVzcywg
YXMgeW91ciBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBhbGxvdyB0bw0KPiBjaGFuZ2UgaXQuIFBs
ZWFzZSB0cmFuc2xhdGUgdGhlIEdQSU8gYWN0aXZlIGZsYWdzIGZyb20gdGhlIERUIHRvIHRoZSBw
cm9wZXINCj4gSVJRIGZsYWdzIGFuZCBkcm9wIHRoaXMgZGVmYXVsdCBoZXJlLiBUaGUgRFQgc2hv
dWxkIHNpbXBseSBjYXJyeSB0aGUgcHJvcGVyDQo+IHBvbGFyaXR5Lg0KPiANCg0KV2lsbCBpbXBy
b3ZlIHRoZSBkZXNjcmlwdGlvbiBpbiBWMiwgdGhhbmtzLg0KDQpCZXN0IFJlZ2FyZHMNClNoZXJy
eQ0K

