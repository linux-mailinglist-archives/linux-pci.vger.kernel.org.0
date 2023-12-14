Return-Path: <linux-pci+bounces-931-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEE812644
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 05:08:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACAAA1F21A84
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 04:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8580B1C36;
	Thu, 14 Dec 2023 04:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bpzlU4xy"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2072.outbound.protection.outlook.com [40.107.20.72])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DFD83;
	Wed, 13 Dec 2023 20:08:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ta+YugoYkRVWm8blaTFGIVoG48vhi0Xk7QYaXJjpk/9/0FO1574QMBWf9J/IHMG4Wlp3rvDlyFL/3opBegGMttFR7hjKlxfKWOTsgRxGbMUgYq1QrBjZevkr/AHuh9S48gT5TLlLx4Yl1ydJOu+VK+TaKx86KHnhP52Dj7Mlxu75S22dfCdtD7Tyd26rBPnkdpK2XM9hRoQVS3bqGZ37leEpYlZXfyctcgtt8DBP/tCIRrwuEPbdAShDWUEnK/SGa7AGdZqyk4KlEYKeOrd+nJ1Mo5urmEQcNLNL1iZ9fMxnFe8gX3Bjnh/ihbAoO5rzrjSNdhPereCfYtpHegWw9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5X8fMwgVIqxX45tDpb2RVCE0EPRtHJzqDHNfm1h3wIo=;
 b=GE1L9dTtZVbBrVIH6SQMYdNlr+DmzCyVKBNOKmNVjzivBPekYcjx6EBS4C8K30Nabcr6ob7f/40zBtEoq5ox/mq4WdSNDovEGdVzXT/hHX12EkhVEtbSotgOgvRd9D3JnMTJ0lWiaW2tqvdt99dFXvbo4Mju7GnKB0j9FPzm1txs8t1yB1V+2eX/gGlbNon+ig10e+dlmnXpDe1qktbREnJgNyc0SJGFA4Q2Hylc3JqMbKt6irgyOtttOGM+GX2f7OBKSyxk6N3PhlcwTO1Rrb5JsSQr/ORDisAVk0q016Opf2WZNCMK3zKNrQK+LrAZX+3TZd+eJoaXflP6S1g2qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5X8fMwgVIqxX45tDpb2RVCE0EPRtHJzqDHNfm1h3wIo=;
 b=bpzlU4xy2pKnzwYjAYfR22eTQYIV72c1LD3VyUsFchhtujy6fxuXjfFPwZVe8JPz1583pggTjsG5JH8e758UAbNZSCKCYt2Ezar6V0CWfILI0bQv6eKM/puH4krqVYr3z58wI8dBWWl1AEyWAhhLfXabWfRV0HNT8Zc5nLfvVrc=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DBBPR04MB7932.eurprd04.prod.outlook.com (2603:10a6:10:1ef::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 04:08:13 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 04:08:13 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Hongxing Zhu <hongxing.zhu@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
	"bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "shawnguo@kernel.org"
	<shawnguo@kernel.org>, "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, dl-linux-imx <linux-imx@nxp.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Thread-Topic: [PATCH V2 1/4] PCI: imx6: Add pci host wakeup support on imx
 platforms.
Thread-Index: AQHaLabAkoMJyK3DvEOy9BefsP2JALCnofeAgACF7OA=
Date: Thu, 14 Dec 2023 04:08:13 +0000
Message-ID:
 <AS8PR04MB84044B72EAF25185AB66EB94928CA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231213092850.1706042-2-sherry.sun@nxp.com>
 <20231213195743.GA1055303@bhelgaas>
In-Reply-To: <20231213195743.GA1055303@bhelgaas>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|DBBPR04MB7932:EE_
x-ms-office365-filtering-correlation-id: 6c511a10-268f-485d-ceb0-08dbfc5a4aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 bfk3yEXK5FId6utI8l7/KyJsnbuqczJJk/4uwGTuiRviKvv2sBfC3yVyyDgQLO/teDJ7UpozkKfZDqbaeGCEIGCf6NHADVwzDiNu0Ov42ZiEo+y3kEIPiBKRtggChD4GAPlu8KfsLCMneLsZWez1K1cWJFk1PIFGBApzpjA0O4+AWXIyG+8Uf/+7HJmbBJdcY51d+Mm3f0+LjlaZBq+rUdzkVuBUGCq4F0Ae1QhDhFNIqO2203MIiOHua3t7nR5AOjQ2e/bZ/Ace9EgalFPIqS/sTyV1mRlOnPtpsi/ggT76CfZIC9QFu8pf6v/CIvhEeh75dtAPIUphtPNWEy7ELO3lH6Oc8yFO9ClVvJEzWVMPZE69xtiDjAKjGQrMkuNakTDscnE531gy5R46injE+q5D32XlSoi/QpsKZCpCXcwKIM4gJF0VExwaKVEqylUC+pvObkbj3Aa7Yewg35XqP+9OuXLb9fP2Aog0WrbnzQQe9bqUdANtHo+XCAQrjn5O8NyaV3x442TrVUMihquyNsGffrJYn2IZ5R1B1hnuTh/wA7buI715DMPG/+K5+/r6Pda4e6y8EHo9yp5OyuqSnPnSD+hMOpMTFtlB1gxmpwH8b5obMqN/uvHIYrOj7GbY
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(9686003)(7696005)(6506007)(53546011)(83380400001)(26005)(52536014)(44832011)(86362001)(41300700001)(4326008)(8676002)(8936002)(2906002)(33656002)(5660300002)(7416002)(38070700009)(76116006)(316002)(6916009)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(71200400001)(478600001)(38100700002)(122000001)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?bVd5bG5MeGtnbXI0Y3lQMnhBY1FPVXI1YVpYQWdjTERlWkNwWlRUN0xmV3RG?=
 =?gb2312?B?MjRWS21uQlBGR0Z5KzNjUCtGb0FIUkNRWkZvYWJCUWlBOFlTbTNtVXUrRFp3?=
 =?gb2312?B?QmEvUFBualpxNE9vYllyb0IxdERNK3N3QWR0anlaUnFtNCs0Y3oyRHc2OHZh?=
 =?gb2312?B?YkVjTllzcHNjNnR1dW0remJDU2M0YnQwYlBHSmdjMlpGczVsTm5vUDJpeHdh?=
 =?gb2312?B?dm1NZWNxQmk5MTNaa2JmTkdzcDhzM0ErQmFJc0ZwMC85aTRzZXUvWVhNclll?=
 =?gb2312?B?bGh3eU56V1dOTmNrTkFWTEEybXRwV09rb0FEdEEwMzQ4ZnZUb3JEa2dTb2d1?=
 =?gb2312?B?ZHZXTkNPOXZxMVdOaHZ6ZmhiVEtVMUV5RWc1T1ByZmNsK2Z2RXlLbTdDNlFB?=
 =?gb2312?B?WlBveEl0TWZvemVNYWI2MlFJWmQ5UVR5REo2a3dQL2IxcU9WbVZZeTJad1RY?=
 =?gb2312?B?SlBvL09FU25CajFFNFpCMGx3TW5OWVlKZlJwcG1KY3JTTEVRL0NEazFIQysw?=
 =?gb2312?B?Um1KaWo1ZmVNN2kyWWpqSWdKZWxZOS9UbnNWZC9kdFcyVFF0cUhidnpOUEVx?=
 =?gb2312?B?a3cwQjEwQjByZUdUcWdNdWFCL2lEYlNSVVloeVcrRjYxQ3E5QlA5M2RNTkZN?=
 =?gb2312?B?aFgxZlpLcUVVZGlaVVJMR3NhWTdObjhPVVhQamUvYlNQYkdVbU5SUkRmVXVD?=
 =?gb2312?B?RmhsN0ZVRXdXaUpZdkRwdGVZZjNtU1d3RktnNHJDMEdRV1RNSENEYzBBT1U3?=
 =?gb2312?B?S014S0hVcGRIYzU5Z2R2UGtHbU1rdHRMYVcrbDY3dlNPNDF0Z1JrS3dHTjdw?=
 =?gb2312?B?eHdYQk1CUmxwNWpMRERka3dQaWxrZTRUOTkvTlNwdnV0VEhOd0l3d3NzaWp0?=
 =?gb2312?B?WVN1YlUwWGczMldkbm9za2FyRER6QUVYYTR0VzZDNnpZTkpWNTByclBwWVhy?=
 =?gb2312?B?Y1hJZGpWSExBS20zNHR6cjhVS2JoU2RLd0FFR1pPblIyK29oL2ZGNjQramEz?=
 =?gb2312?B?T0JWUm5kSXFKeXBrcndpVzl1L3p4TGY0VTdvQlR2YkdyZ3VvK1hwcnk5dGti?=
 =?gb2312?B?Q2dxUDlEZmVBQzk4ZFFZRmtGNGhJYzlQRDg1c05odUp5ekIwazVzdHVKTU16?=
 =?gb2312?B?UHJjS2lROFAwQ3dXOUF5NzA0UW9XYkFacysvcTA4S0RPZlc1MTNJV2FnMmN3?=
 =?gb2312?B?UmhKY1loUVpkYnYrQ1lZRjBOQVRyV2o5VEJZRWJWS3Uvd1crV21lSUVWWC90?=
 =?gb2312?B?WW8ySUFqS2MyUjREREkxdVFLZmpMTDVVMFpJb1JoS0NjdnBNc1h0czFvWU9a?=
 =?gb2312?B?M2EvNWtKQWFteVZGUDBYVXhTaC9QRjJvUFlacHE1WmI5V3pRUnV3bVppNWJI?=
 =?gb2312?B?amVuV2JXRUFiV09xYnUzRVQ1Q2l5KzRsTXlOM1B3Tnp1VkwwVERZUm9Pajdq?=
 =?gb2312?B?QWk1QmdIZ3phVDV1V3R5Tyt3REczMERIUG9ZZXVIcVpwWGRHSDBwKzNVaVJm?=
 =?gb2312?B?ZUlRTU5ER1pLeWV4TWRQSjFUSmtVdmV1ekV3R3F6WVNORGZxdEpVSkhxNlVG?=
 =?gb2312?B?NEJZVndtUDM5Q044QWlJQ0VUTTNOYkl6NlQ0dnNCd1BDVkxGQm9TTUN0SGN1?=
 =?gb2312?B?ekdsd2I4WjhJTDAzUXFETEI5Y1JXT1VQYUJGMmM5OXVJWThMZDlJSVZHMnVF?=
 =?gb2312?B?TG1hcXlBYWlzbG44RUJNQzVjajFYNTErR0h0ekxIRWhEMnFybWdWMlZNQmFQ?=
 =?gb2312?B?Q1ZGSzNFRkliV3RMSkVLUE1MczJEZGlLcmgzOGMvdTZadEorR0dpU2p3d3g5?=
 =?gb2312?B?dUdCZlVBOEhEMHhTeVFzVHQ1QnhHdFBaQ2JrM2MrT0RBaDRwYUxZdlF3cjRR?=
 =?gb2312?B?UVlUU1JLY1ljdUtkZ2lCTjhVSDJFV0VJTHNVK3N5Y0tBeFlmYTE3bW9YUjAy?=
 =?gb2312?B?dDg5R1YxbXQ3M0EzZ3VOTWxTbU96TFlxMGRRUkNUdVhwYUVVbWg4bG41UURp?=
 =?gb2312?B?YXFBeG00SzdtSTRDakI4S1NZVnRpNmNHUHJMTzFNZnFWVjJOKzFmYnVUYkcz?=
 =?gb2312?B?SzhuVmR0Y0VWUHBLRHhFb3ZtN0hPM0NHU05DbXVFSUI1UERDbGpNSUM4dE1a?=
 =?gb2312?Q?liIg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c511a10-268f-485d-ceb0-08dbfc5a4aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 04:08:13.2812
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZrVz1g7OP/IS+/27n+5KJoZB/4I0WWBVcvaWspwMbIyOCP8sh+hU9yioIgCcrQ9SZZlEWx0s6IQQaPYLQL9yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7932

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmpvcm4gSGVsZ2FhcyA8
aGVsZ2Fhc0BrZXJuZWwub3JnPg0KPiBTZW50OiAyMDIzxOoxMtTCMTTI1SAzOjU4DQo+IFRvOiBT
aGVycnkgU3VuIDxzaGVycnkuc3VuQG54cC5jb20+DQo+IENjOiBIb25neGluZyBaaHUgPGhvbmd4
aW5nLnpodUBueHAuY29tPjsgbC5zdGFjaEBwZW5ndXRyb25peC5kZTsNCj4gbHBpZXJhbGlzaUBr
ZXJuZWwub3JnOyBrd0BsaW51eC5jb207IHJvYmhAa2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29v
Z2xlLmNvbTsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8ub3JnOw0KPiBjb25vcitkdEBr
ZXJuZWwub3JnOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJvbml4LmRlOw0K
PiBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNvbTsgZGwtbGludXgtaW14
IDxsaW51eC0NCj4gaW14QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51
eC1hcm0tDQo+IGtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBkZXZpY2V0cmVlQHZnZXIua2Vy
bmVsLm9yZzsgbGludXgtDQo+IGtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6
IFtQQVRDSCBWMiAxLzRdIFBDSTogaW14NjogQWRkIHBjaSBob3N0IHdha2V1cCBzdXBwb3J0IG9u
IGlteA0KPiBwbGF0Zm9ybXMuDQo+IA0KPiBEcm9wIHBlcmlvZCBhdCB0aGUgZW5kIG9mIHN1Ympl
Y3QgbGluZS4gIEl0IG9ubHkgYWRkcyB0aGUgcG9zc2liaWxpdHkgb2YNCj4gdW5uZWNlc3Nhcnkg
bGluZSB3cmFwcGluZyBpbiBnaXQgbG9nLg0KDQpIaSBCam9ybiwgdGhhbmtzIGZvciB0aGUgY29t
bWVudHMsIHdpbGwgZG8gaW4gVjMuDQoNCj4gDQo+IE9uIFdlZCwgRGVjIDEzLCAyMDIzIGF0IDA1
OjI4OjQ3UE0gKzA4MDAsIFNoZXJyeSBTdW4gd3JvdGU6DQo+ID4gQWRkIHBjaSBob3N0IHdha2V1
cCBmZWF0dXJlIGZvciBpbXggcGxhdGZvcm1zLg0KPiANCj4gcy9wY2kvUENJLw0KPiBzL2lteC9p
Lk1YLyAoYmFzZWQgb24gaG93IG54cC5jb20gd2ViIHBhZ2VzIHJlZmVyIHRvIGl0KQ0KPiANCg0K
V2lsbCBkby4NCg0KPiA+IEV4YW1wbGUgb2YgY29uZmlndXJpbmcgdGhlIGNvcnJlc3BvbmRpbmcg
ZHRzIHByb3BlcnR5IHVuZGVyIHRoZSBQQ0kNCj4gPiBub2RlOg0KPiA+IHdha2UtZ3Bpb3MgPSA8
JmdwaW81IDIxIEdQSU9fQUNUSVZFX0xPVz47DQo+IA0KPiBBZGQgbmV3bGluZSBiZXR3ZWVuIHBh
cmFncmFwaHMgb3Igd3JhcCBpbnRvIGEgc2luZ2xlIHBhcmFncmFwaC4NCg0KV2lsbCBkby4NCg0K
PiANCj4gPiArCQkvKiBob3N0IHdha2V1cCBzdXBwb3J0ICovDQo+ID4gKwkJaW14Nl9wY2llLT5o
b3N0X3dha2VfaXJxID0gLTE7DQo+IA0KPiBBRkFJSywgMCBpcyBhbiBpbnZhbGlkIElSUSB2YWx1
ZS4gIFNvIHdoeSBub3QgZHJvcCB0aGlzIGFzc2lnbm1lbnQgc2luY2UNCj4gaW14Nl9wY2llLT5o
b3N0X3dha2VfaXJxIGlzIDAgYnkgZGVmYXVsdCBzaW5jZSBpdCB3YXMgYWxsb2NhdGVkIHdpdGgN
Cj4gZGV2bV9remFsbG9jKCksIGFuZCB0ZXN0IGxpa2UgdGhpcyBlbHNld2hlcmU6DQo+IA0KPiAg
IGlmIChpbXg2X3BjaWUtPmhvc3Rfd2FrZV9pcnEpIHsNCj4gICAgIGVuYWJsZV9pcnFfd2FrZShp
bXg2X3BjaWUtPmhvc3Rfd2FrZV9pcnEpDQoNCkkgcGxhbiB0byBjaGFuZ2UgdGhlIGhvc3Rfd2Fr
ZV9pcnEgdG8gdW5zaWduZWQgaW50IHR5cGUsIGFuZCBhZGQgZm9sbG93aW5nIGNvZGVzLCB0aGVu
ICJpZiAoaW14Nl9wY2llLT5ob3N0X3dha2VfaXJxKSIgY29uZGl0aW9uIHNlZW1zIG1vcmUgcmVh
c29uYWJsZSwgbGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGZ1cnRoZXIgc3VnZ2VzdGlvbnMu
IHRoYW5rcyENCi0gICAgICAgICAgICAgICAgICAgICAgIGlteDZfcGNpZS0+aG9zdF93YWtlX2ly
cSA9IGdwaW9kX3RvX2lycShob3N0X3dha2VfZ3Bpbyk7DQorICAgICAgICAgICAgICAgICAgICAg
ICByZXQgPSBncGlvZF90b19pcnEoaG9zdF93YWtlX2dwaW8pOw0KKyAgICAgICAgICAgICAgICAg
ICAgICAgaWYgKHJldCA8IDApDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVy
biBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiRmFpbGVkIHRvIGdldCBJUlEgZm9yIFdBS0UgZ3Bp
b1xuIik7DQorDQorICAgICAgICAgICAgICAgICAgICAgICBpbXg2X3BjaWUtPmhvc3Rfd2FrZV9p
cnEgPSAodW5zaWduZWQgaW50KXJldDsNCg0KPiANCj4gPiArCQlob3N0X3dha2VfZ3BpbyA9IGRl
dm1fZ3Bpb2RfZ2V0X29wdGlvbmFsKGRldiwgIndha2UiLA0KPiBHUElPRF9JTik7DQo+ID4gKwkJ
aWYgKElTX0VSUihob3N0X3dha2VfZ3BpbykpDQo+ID4gKwkJCXJldHVybiBQVFJfRVJSKGhvc3Rf
d2FrZV9ncGlvKTsNCj4gPiArDQo+ID4gKwkJaWYgKGhvc3Rfd2FrZV9ncGlvICE9IE5VTEwpIHsN
Cj4gDQo+ICAgaWYgKGhvc3Rfd2FrZV9ncGlvKQ0KDQpXaWxsIGRvLg0KDQpCZXN0IFJlZ2FyZHMN
ClNoZXJyeQ0KDQoNCg==

