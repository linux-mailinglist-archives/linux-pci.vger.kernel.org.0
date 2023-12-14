Return-Path: <linux-pci+bounces-984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0242812C6C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 11:04:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56CFF1F21ABF
	for <lists+linux-pci@lfdr.de>; Thu, 14 Dec 2023 10:04:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5793639FCC;
	Thu, 14 Dec 2023 10:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="KkOVcdXR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F262991;
	Thu, 14 Dec 2023 02:03:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZKOMPmnoDqf2e+egiwsSY4TpUk7U0SF7alT6/fUfnDbOzs3E89kNGlCGKfhcwryqixxtU48A3meipcrpqU0a6EreoQxdY2at08tpPN8dMy03gw9+JlsQI+v8QAuY2/PXwXhGztSyZrt97WqpbuPWpGqKpyg3e4pkJO2qhyCFK3cG+r40Uoq5M0sodQSqoFPErDF6r+LPDZI8f/j+Yo1otGY8sEWWXNgLqoIvTlU9oTQmKkI2KDIGkeFeFJDLUw3MZLIGQH5u2J5LwyHowbC2QocxFPdChokSrXbeyQDLhfkz2Rq/glqJH4JquEm5KdcE6c9fg8BnevAV7Py2OY2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fzk2I/kIn5+qMH0oPv0kzchsZaGNGMZQHCKaEtvClug=;
 b=aYfF+1alKpSAmU2pdQXStoQZImHMx25CuoXbslBtfEixSB7p7YEqtrIpOXniZfi6y/9+9COSq5FUxTOrflF4wrlOTcecf0yoqLwADeaJR0Kye7IAWqdFz4gobg3jVeey/bzmEcTEbQhvGQ6ooGlzTn/P1vbLJeFYxPcMqBqD0vHobapp5ioNBtKzsaAmoVA56OOOoqKnQ4f19HFcpaby+FcHarsGHSmiwTmmVBUYTRhhPFPBlIqkrYTe2EfSa4XewLSsuvLqYHo6Fv1Y1rXnoAdG1z7ehC7W6XcAejaiIR3L8OGRh1o0wJHK3SmgsqU8OVxuTaZi/xg06MgYRofmoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fzk2I/kIn5+qMH0oPv0kzchsZaGNGMZQHCKaEtvClug=;
 b=KkOVcdXRvljcIszHcrbt4rlFUSSThkpMmCRAOPCTRKzbK87y6p8IG1IvsbHS2PPnP/nkdZ4fjYg7DKOt/eajp2imHwWfeh/bwgnATI0GQk4/1e75xtjL4xADFlZGDpwESNIu7syimsj2B+Io8wYGFT+I2hSBrlufDp7va6MeD5g=
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB7798.eurprd04.prod.outlook.com (2603:10a6:20b:2a3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Thu, 14 Dec
 2023 10:03:51 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3627:208e:4d62:1e2a%7]) with mapi id 15.20.7091.028; Thu, 14 Dec 2023
 10:03:51 +0000
From: Sherry Sun <sherry.sun@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Subject: RE: [PATCH V2 0/4] PCI: imx6: Add pci host wakeup support
Thread-Topic: [PATCH V2 0/4] PCI: imx6: Add pci host wakeup support
Thread-Index: AQHaLaa84O56+RWCtUOkazHtbsy70LCoPT0AgABOkpA=
Date: Thu, 14 Dec 2023 10:03:51 +0000
Message-ID:
 <AS8PR04MB84046143C236AEA322BBBAD3928CA@AS8PR04MB8404.eurprd04.prod.outlook.com>
References: <20231213092850.1706042-1-sherry.sun@nxp.com>
 <20231214051328.GD2938@thinkpad>
In-Reply-To: <20231214051328.GD2938@thinkpad>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8404:EE_|AS8PR04MB7798:EE_
x-ms-office365-filtering-correlation-id: 5b5cadc3-0dce-4733-70ec-08dbfc8bf918
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 pyjZ09dx+00bWywQaykeHYwhgX5iPBx3MZocMB/9DNLQFyGwIT9hpCuG86/jRU6a1YzY01nsbR8s23whSJEQkYi/IKJS9ARgaYTF7vthlj4ZkFghQ5uYglt9CHeYup0OO+cev/PmSHqoyWF33xmrEgaGj499wMrETsuEHWqzolzxfzEFtqORenWnWzcNtVRHW3ZTAPXPzhkyeh0HMN3Y8EQ31gQ/kBZGsLX411/TNuqYLIW0AOPVBOmbOypgXJTee0n61qI2mV+EiAu4PWYF4wg13i3H/56tR0QWFFydbZPXK0YdtFcPoLHDIP8Mhlur2O1fycz7HmhkNQ9ps7oUMZMkEmjUq1nnobNafif63r8Cga3+97z8MWqjN9r1ZTcPds3EvKZALgDsvIUl5RITnL+oH2i0eKLBHC8hq5ETPqHe11FnNTuQGzY9Ra8Lx88XEUrtbGqrllrKlAKi/DnaZ+4sLuKlkf6OYVqbv0c3L5EZYiRWmAQGIq3Fdg3agpqk4TeN+qbjIHiF/6ab3q5gqHxUC0NStEzmMdeTispaJurkLJFo8Nx3vhtrg2t/GVS76BS2wZ9WRbHc6Sjgh8LWzx3ijvm2ffKxb7RmpC4VSsA=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(2906002)(7416002)(966005)(478600001)(41300700001)(33656002)(55016003)(38070700009)(122000001)(86362001)(5660300002)(52536014)(44832011)(4326008)(76116006)(54906003)(64756008)(66446008)(66476007)(66556008)(66946007)(316002)(6916009)(83380400001)(26005)(45080400002)(8936002)(53546011)(9686003)(6506007)(7696005)(71200400001)(8676002)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V1B5NHRhbXNQVlNCU3pwK0NwYzNYbjNMS2RjbVB5Rk5kV08xb0RTb1lKL1hK?=
 =?utf-8?B?eDFaWDdlSEFaMjZNUUhySjFwaW1uZk5tL0VkK3c4QWVncml2emJ3R1VWb1dI?=
 =?utf-8?B?cUd2eWtXbWwwaE1aKzUzOFFOOE56TDdNMDhIZC9tQjdMQ3lRaWdHY3UrWlZS?=
 =?utf-8?B?bnNlYU1oTXN4ZkNMS3RXOGdlT282MXF6Vi9NMU5iSTB6VTh5VUxXcTlLUjNO?=
 =?utf-8?B?dzdmYk5NOGtFNFRsZzF1RStKU0d0dGRvb3NRWnVhVktNVjcxZ2NBN0FoSTdE?=
 =?utf-8?B?K3Z6dittblNxNVlmVmk0bDhrNHEwNTVLWllHbDZCZjVhcEo5bEJMTHIyNzFF?=
 =?utf-8?B?dkd4Zk0rU2pkVW4vK212aG45N1AwTVAxdHduTllaVW5xdUpqcVlJcnpqTmZo?=
 =?utf-8?B?VWxkMjBsU0dzMXljbHY2ZTBoUy9heTJ0bjk1Wm11dHY5OUg2VDh5MGs1ODNy?=
 =?utf-8?B?WjdsOTBrREI3Ui8vaFFoUFoxR0ViMUM1K1NFR1FOdjg4T0pkcER3ZzFtR1gz?=
 =?utf-8?B?YkR0V21McUhURm42TWtqdW5jdlNHSXgwaDVBc3FvVytsNEtIY2EwUkNnUjlI?=
 =?utf-8?B?cHlzdGtTNXZGOHJoQ3BvWUNXNEFLY2pMdUVqNnVRMVNEeXdKTUx3ZzdKb2ZP?=
 =?utf-8?B?TnQ4QkUvaStKcURqU3hXT3I4Wm9EQ1lEcVpEUnh1MG8zcVBwZ3M4UlVVbnMy?=
 =?utf-8?B?Tk4xR2djSDZiS2p3RVlGWlg3LzJFV2pGa1hKVHBTR0hXRUVFYXlMRFp3MmdV?=
 =?utf-8?B?dlVxdjVjcWJONVRnaWJkZGNJZFh5NU44WnZkOWRMRFlxRU1CQnZTdzZnb3JY?=
 =?utf-8?B?b1NkYmUyT1hUV3YrRG5IUE5aOVdqWXJwdUEzaG1kK3kwMzRZaytQSC9XblRM?=
 =?utf-8?B?anovMS90dnB2UlhkRkR0cnFXQWRQdXRISGZHYmdpMFdTWEptVDk5MDl6K2NB?=
 =?utf-8?B?M3U0OFY0aHNXZVhUVzRtWUZQZ3RLTlE5NC9iTW9RdUpUVzU1TFhGLzBnLzdJ?=
 =?utf-8?B?ajBtNTNPVi8rdWk3dlZrVG9SLzRUUDRZUFpWWXVOSDZ3OXdCM005OWRjY05s?=
 =?utf-8?B?cnJBOWF0N0hyd3dKUUdqUWFNTXM0QjJGYi9TdVRhQnNUS2doSitNMDFpc0s5?=
 =?utf-8?B?NG40SDNFMlBScWY1d3RzREtpM3ZoWGltNndmc3UwWjhnVkRaNXRrRnhmblh2?=
 =?utf-8?B?aUgvNUNOWDNQYnpINmVlbTExS0h2RjJDQksrcE8rbHEyNVhCR1pveXdLYTVH?=
 =?utf-8?B?bjJ1a2dhdGF0UmxCWnB4UFkzL1dKS0k1UzQ5RG05TjJxb0tJRGYvSDRUTi81?=
 =?utf-8?B?NER4MUlzVVFkOWxQcWM4YS9ick4ra3ZVV1B4N2NVQVZEeUE1SGs5T25sVUhx?=
 =?utf-8?B?RDRwaGxPMHZZMlhhWWNNd0xsWE4xYzJWNzF6NWlEajVYWHFkQ25uZEZwMGdq?=
 =?utf-8?B?UWw1MGZpNk5WdmFSYm42YzY1Rno5SzZZTEN6YnB1Si9yWmVxajkvVkhyQmVy?=
 =?utf-8?B?dFZrRVV0dDg1RjNUVzlaZDJnQUl0SW5Ueldlb09heDZHcDNCMmtFeUJ5UTFV?=
 =?utf-8?B?aEtsWkszd3N4ajloc2tCSGxJREMwTXpZb2dkNkdEQmFENStObGpzekh1L3Q0?=
 =?utf-8?B?eE9aclZ3cHE2UmhkcUVwMkROcDFNRzBkYU1uQ2RLa3pWUkV6WDloQmM3K05J?=
 =?utf-8?B?WEtqWm0zN0M5anJ2MVQzWEZKWldJM2RkZ1ZoczJKMUxZZGtsd0V3WUI3bGZy?=
 =?utf-8?B?cHBUaFVkWlBDSDNRNm5TelFSb3NNV1A2ZnlUOUN4UW9HSzNtVkpoMzNQL3Qz?=
 =?utf-8?B?eFBCdk8vMDdVU056SWk5WU5laFFYQWIrWDB5WVlSL0x0V2JpTVhtZXJCSFZn?=
 =?utf-8?B?bCttR0lrT3dLRlQxNGJCbDVIWGdJYUwwZjhmQWEvWlZEWStML1hEc05BWnh2?=
 =?utf-8?B?SUZYR0RjcUtMWC95NXkvbE82RHZBbUNBTlh4cVFBNElobTBvaWxOUnpFbGZD?=
 =?utf-8?B?N3kvTVlLeEJMOHlSeE1WQnpJdVRpNlVPbTlteGRQcnNLSVcybzN6ZUROSjlw?=
 =?utf-8?B?ZG14M2F4SlBBUCtKSnZIdmxSYWNtczk3bk1xUnppYVJ4RVhCblEwK3dVb3hz?=
 =?utf-8?Q?+F6g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5cadc3-0dce-4733-70ec-08dbfc8bf918
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Dec 2023 10:03:51.2203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6J1X0ZiQiPLQqDtAmbDtv7xNy5NafQZvJQzzhlVhgdPP3VeWwIsyWRcgf9I3KKIbXgfACWcXp9QXhrut+Lx0uw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7798

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWFuaXZhbm5hbiBTYWRo
YXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGluYXJvLm9yZz4NCj4gU2VudDogMjAyM+W5
tDEy5pyIMTTml6UgMTM6MTMNCj4gVG86IFNoZXJyeSBTdW4gPHNoZXJyeS5zdW5AbnhwLmNvbT4N
Cj4gQ2M6IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBsLnN0YWNoQHBlbmd1
dHJvbml4LmRlOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7IGt3QGxpbnV4LmNvbTsgcm9iaEBr
ZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBrcnp5c3p0b2Yua296bG93c2tpK2R0
QGxpbmFyby5vcmc7DQo+IGNvbm9yK2R0QGtlcm5lbC5vcmc7IHNoYXduZ3VvQGtlcm5lbC5vcmc7
IHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU7DQo+IGtlcm5lbEBwZW5ndXRyb25peC5kZTsgZmVzdGV2
YW1AZ21haWwuY29tOyBkbC1saW51eC1pbXggPGxpbnV4LQ0KPiBpbXhAbnhwLmNvbT47IGxpbnV4
LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS0NCj4ga2VybmVsQGxpc3RzLmluZnJhZGVh
ZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIFYyIDAvNF0gUENJOiBpbXg2OiBBZGQg
cGNpIGhvc3Qgd2FrZXVwIHN1cHBvcnQNCj4NCj4gT24gV2VkLCBEZWMgMTMsIDIwMjMgYXQgMDU6
Mjg6NDZQTSArMDgwMCwgU2hlcnJ5IFN1biB3cm90ZToNCj4gPiBBZGQgcGNpIGhvc3Qgd2FrZXVw
IGZlYXR1cmUgZm9yIGlteCBwbGF0Zm9ybXMuIFRoZSBob3N0IHdha2UgcGluIGlzIGENCj4gPiBz
dGFuZGFyZCBmZWF0dXJlIGluIHRoZSBQQ0llIGJ1cyBzcGVjaWZpY2F0aW9uLCBzbyB3ZSBjYW4g
YWRkIHRoaXMNCj4gPiBwcm9wZXJ0eSB1bmRlciBQQ0kgZHRzIG5vZGUgdG8gc3VwcG9ydCB0aGUg
aG9zdCBncGlvIHdha2V1cCBmZWF0dXJlLg0KPiA+DQo+ID4gRXhhbXBsZSBvZiBjb25maWd1cmlu
ZyB0aGUgY29ycmVzcG9uZGluZyBkdHMgcHJvcGVydHkgdW5kZXIgdGhlIFBDSSBub2RlOg0KPiA+
ICAgICB3YWtlLWdwaW9zID0gPCZncGlvNSAyMSBHUElPX0FDVElWRV9MT1c+Ow0KPiA+DQo+DQo+
IEFzIHlvdSBtZW50aW9uZWQsIFdBS0UjIGlzIGEgc3RhbmRhcmQgc2lkZWJhbmQgc2lnbmFsIGRl
ZmluZWQgaW4gdGhlIFBDSQ0KPiBzcGVjLg0KPiBTbyB0aGUgc3VwcG9ydCBmb3IgaGFuZGxpbmcg
aXQgaGFzIHRvIGJlIGluIHRoZSBQQ0kgY29yZSBsYXllciwgbm90IGluIHRoZSBob3N0DQo+IGNv
bnRyb2xsZXIgZHJpdmVycy4NCj4NCj4gVGhlcmUgaXMgYWxyZWFkeSBhIHNlcmllcyBmbG9hdGlu
ZyB0byBhZGQgc3VwcG9ydCBmb3IgV0FLRSMgaW4gUENJIGNvcmUuDQo+IFBsZWFzZSB0YWtlIGEg
bG9vazoNCj4NCj4gaHR0cHM6Ly9sb3JlLmsvDQo+IGVybmVsLm9yZyUyRmxpbnV4LXBjaSUyRjIw
MjMwMjA4MTExNjQ1LjM4NjM1MzQtMS0NCj4gbW1hZGRpcmVkZHklNDBudmlkaWEuY29tJTJGJmRh
dGE9MDUlN0MwMiU3Q3NoZXJyeS5zdW4lNDBueHAuY28NCj4gbSU3QzAyNTRjMDAxZGY2MTQ5OGMw
OWQ0MDhkYmZjNjM2ZjVjJTdDNjg2ZWExZDNiYzJiNGM2ZmE5MmNkOTljNQ0KPiBjMzAxNjM1JTdD
MCU3QzAlN0M2MzgzODEyNzYyMzk4MjQ5MTIlN0NVbmtub3duJTdDVFdGcGJHWnNiMw0KPiBkOGV5
SldJam9pTUM0d0xqQXdNREFpTENKUUlqb2lWMmx1TXpJaUxDSkJUaUk2SWsxaGFXd2lMQ0pYVkNJ
Nk1uMCUNCj4gM0QlN0MzMDAwJTdDJTdDJTdDJnNkYXRhPUlvQkF3VHkwcWViMEo2SnJLMFdSaEk4
QTRUaFVma1Z4Nm1yaQ0KPiB2ZSUyQks1eHMlM0QmcmVzZXJ2ZWQ9MA0KDQpIaSBNYW5pdmFubmFu
LA0KSSBjaGVja2VkIHRoZSBwYXRjaCBzZXQsIHRoZSBpbXBsZW1lbnRhdGlvbiBvZiBob3N0IHdh
a2UgZ3BpbyBpcyBkaWZmZXJlbnQgZnJvbSBtaW5lLCBJIHJlZmVycmVkIHRvIHRoZSBtbWMgYnVz
IGNkKGNhcmQgZGV0ZWN0KSBwaW4gaW1wbGVtZW50YXRpb24gYW5kIEkgdGhpbmsgaXQgaXMgc2lt
cGxlciBhbmQgY2xlYXJlci4NClJlZ2FyZGluZyB3aGV0aGVyIHRoZSBXQUtFIyBzdXBwb3J0IHNo
b3VsZCBiZSBtb3ZlZCB0byBQQ0kgY29yZSBsYXllciwgd2UgbWF5IG5lZWQgbW9yZSByZXNlYXJj
aCBhbmQgZGlzY3Vzc2lvbi4gVGhhbmtzIGZvciB5b3VyIHN1Z2dlc3Rpb25zLg0KDQpCZXN0IFJl
Z2FyZHMNClNoZXJyeQ0KDQoNCj4NCj4gLSBNYW5pDQo+DQo+ID4gLS0tDQo+ID4gY2hhbmdlcyBp
biBWMjoNCj4gPiAxLiBSZW5hbWUgaG9zdC13YWtlLWdwaW8gcHJvcGVydHkgdG8gd2FrZS1ncGlv
cy4NCj4gPiAyLiBJbXByb3ZlIHRoZSB3YWtlLWdwaW9zIHByb3BlcnR5IGRlc2NyaXB0aW9uIGlu
IHRoZSBkdC1iaW5kaW5nIGRvYw0KPiA+IHRvIGF2b2lkIGNvbmZ1c2lvbi4NCj4gPiAzLiBSZW1v
dmUgdW5uZWNlc3NhcnkgZGVidWdnaW5nIGluZm8gaW4gaG9zdF93YWtlX2lycV9oYW5kbGVyKCku
DQo+ID4gNC4gUmVtb3ZlIHVubmVjZXNzYXJ5IGlteDZfcGNpZS0+aG9zdF93YWtlX2lycSA9IC0x
IHJlc2V0dGluZyBpbiBlcnJvcg0KPiBwYXRocy4NCj4gPiA1LiBVc2UgZGV2X2Vycl9wcm9iZSgp
IHRvIHNpbXBsaWZ5IGVycm9yIHBhdGggY29kZS4NCj4gPiAtLS0NCj4gPg0KPiA+IFNoZXJyeSBT
dW4gKDQpOg0KPiA+ICAgUENJOiBpbXg2OiBBZGQgcGNpIGhvc3Qgd2FrZXVwIHN1cHBvcnQgb24g
aW14IHBsYXRmb3Jtcy4NCj4gPiAgIGR0LWJpbmRpbmdzOiBpbXg2cS1wY2llOiBBZGQgd2FrZS1n
cGlvcyBwcm9wZXJ0eQ0KPiA+ICAgYXJtNjQ6IGR0czogaW14OG1wLWV2azogYWRkIHdha2UtZ3Bp
b3MgcHJvcGVydHkgZm9yIHBjaSBidXMNCj4gPiAgIGFybTY0OiBkdHM6IGlteDhtcS1ldms6IGFk
ZCB3YWtlLWdwaW9zIHByb3BlcnR5IGZvciBwY2kgYnVzDQo+ID4NCj4gPiAgLi4uL2JpbmRpbmdz
L3BjaS9mc2wsaW14NnEtcGNpZS55YW1sICAgICAgICAgIHwgIDYgKysNCj4gPiAgYXJjaC9hcm02
NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1wLWV2ay5kdHMgIHwgIDIgKw0KPiA+IGFyY2gvYXJt
NjQvYm9vdC9kdHMvZnJlZXNjYWxlL2lteDhtcS1ldmsuZHRzICB8ICAyICsNCj4gPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYyAgICAgICAgIHwgNjAgKysrKysrKysrKysr
KysrKysrKw0KPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDcwIGluc2VydGlvbnMoKykNCj4gPg0KPiA+
IC0tDQo+ID4gMi4zNC4xDQo+ID4NCj4gPg0KPg0KPiAtLQ0KPiDgrq7grqPgrr/grrXgrqPgr43g
rqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

