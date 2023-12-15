Return-Path: <linux-pci+bounces-1031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5727B813F1C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 02:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD6D21F22CA6
	for <lists+linux-pci@lfdr.de>; Fri, 15 Dec 2023 01:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6B236F;
	Fri, 15 Dec 2023 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="WxnSzQUM"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2091.outbound.protection.outlook.com [40.107.114.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544DF7EA;
	Fri, 15 Dec 2023 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AptIWDmQNPmZQOk4aDylZdntsqjFirCDynYhIu9EXfjnfxx/zm+O0WAs1XjWq78JbPMFXZ+5RdgAwcRTTPBsKFR3wmKyhj5FyU4IA8oSzlgasfoZAXmnulwaekO/k6WEO9s41g/JzYrZVBUieMerktuDMMMRFl8A28spfDMh93xqds1InzDueRYxvg4nm4Y8JrLHl/Z4s6AGssI+dg0+cvVyDiyP6pvp0TpWZgOMS90NF/MXsetbmWvrF5d1J9Y2KSBb3KmQb0zDLSAoTW2noRq8/pQBfSqJOYm1mkJ1F3L5FBOVXOsGlNQ2ffRv3T29Ntdv/o0vdxGA6bM8ligrpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9NvEkfFxBTLrjaRHQSByu6rtnWfArQmJ9ZqJhSHkss=;
 b=RABZCTXNwTf35A2ggl3/q5oIiI23GyH1YI1AIrFRXCtXyyB+pWYhKWWow/+fyxSrd5Bdzv+9ftTHl4OFdToTRxxaEKbyUQc4rPfwJrZejYnVq9RmDd2F2nHkrvXFC/XbCeoR3rSb0yVBGIkcurlfbKwMDQYXYAhDo/Sk6PqLeKzOGhd1UWobR2lwZlxZVQZk7YsQUUWp3VesKs6KHIT5ZR6HsJlcfIXQ87UEqV2SsvUyZY6RmgEWwoOve9EJWdA7f85HwUuE0rSgleYh6RpzmDQG7K2Y+LjpQyLkSwPrO4WFCsDOIVMXSknPVSRmR5UEp9fc+MJbjJujfzsimKQceg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9NvEkfFxBTLrjaRHQSByu6rtnWfArQmJ9ZqJhSHkss=;
 b=WxnSzQUMnBFoEs7jORKkrkJMUagwP69w4dCrmr5CRNShAzn8U8hOdGtFmWvclGewq25zZ0KQjbbIPzyBEDTbPxLjYhYauxzx5k9MV2eanjKkZUIs7szWSO55zeREumoPfC7NkbDoNNI21aAbLM4bJuQLQQdTYo9YY34pZRT+grg=
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 (2603:1096:404:8028::13) by TYCPR01MB7917.jpnprd01.prod.outlook.com
 (2603:1096:400:184::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.10; Fri, 15 Dec
 2023 01:20:21 +0000
Received: from TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7]) by TYBPR01MB5341.jpnprd01.prod.outlook.com
 ([fe80::50f5:eb2b:710a:b7c7%7]) with mapi id 15.20.7113.010; Fri, 15 Dec 2023
 01:20:21 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Justin Stitt <justinstitt@google.com>, Nathan Chancellor <nathan@kernel.org>
Subject: RE: [PATCH v2 5/6] PCI: iproc: fix -Wvoid-pointer-to-enum-cast
 warning
Thread-Topic: [PATCH v2 5/6] PCI: iproc: fix -Wvoid-pointer-to-enum-cast
 warning
Thread-Index: AQHaFr8dzMui/XtQv02XKHCgkTAyO7B+QXSAgCt408A=
Date: Fri, 15 Dec 2023 01:20:21 +0000
Message-ID:
 <TYBPR01MB5341E53029A4FA23D3880F60D893A@TYBPR01MB5341.jpnprd01.prod.outlook.com>
References: <20231114055456.2231990-1-yoshihiro.shimoda.uh@renesas.com>
 <20231114055456.2231990-6-yoshihiro.shimoda.uh@renesas.com>
 <20231117092141.GG250770@thinkpad>
In-Reply-To: <20231117092141.GG250770@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYBPR01MB5341:EE_|TYCPR01MB7917:EE_
x-ms-office365-filtering-correlation-id: 065fe295-aaac-4e15-c406-08dbfd0c01d6
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 S0LiP7ZiP2ZjkQTVIym3WXUrhgJw5SF2cP5WkHAIjcXvwbHvR1uKy7O9BEydETBBZF5M8mOxYZAziO3JcA+TiLF1AozXOhm83HGwPErORd+OePwMJKnD7FLnQ8J2rEK/4wgGJll1IYs9tPf9k1PA/b3fWUOsaOGYSLdbLO7ZQS146/eyzYzC4JD2UtaLH7Chrlw8y0Lz5ikh6sMDWG1SZwQmMIBeJboH2IJLjLHGBYKQS+jmwqdZipMQ4o2RWeTSDraXbpKOhiXzSicUgl3JET2UUX8k7nJalSaGT8/fw5+XdlXP7wvvlHj+a5kUPXSqIBS09Mt95GpZPU5i+hWid0AOoJz2Vsr5A+eWRWt4/wjsYj2eatFoKrbPNuKJQD3m8gC9ghupvKsRXqZvTO6IOXJOf7DNGnr0BIpyCBEzuPvDNOgAvsaZoOwjopBVAEOymZP6xCo4/ht3U6QYwMfsTZRrhi7pTlM+lL3lUXItIv9KkiA4955Z7tfNw4xy3j6CggIFxibU5LrZxc/lTp9fdwRuZ6KojZ0qFW1r7izjxXJSLb5DPymoTOYtTazOtba83braabGC+NXMCcb3YeZ6jv/F7qINlPQgVKOm2FGZwDit8PRH9tlR3yqayFuiscWcXv1W571i3iuSFZwX1I7NU6EgrymywBtkG99Q5+7kvEw=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYBPR01MB5341.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230273577357003)(230173577357003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(7696005)(71200400001)(9686003)(83380400001)(5660300002)(7416002)(52536014)(4326008)(41300700001)(2906002)(478600001)(8676002)(8936002)(76116006)(66946007)(316002)(6916009)(54906003)(64756008)(66446008)(66476007)(66556008)(33656002)(86362001)(122000001)(38100700002)(38070700009)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?QXNkWG5Md2RGVDI1WnBTODM5ajVJaVVmR0V0YzkrVUNmcmhIdzJUSktMM0x5?=
 =?utf-8?B?aWc5bjVmWUY1bU4xR3cySXVMeU01R202RWpyd214Z2hpa0drMnhWMUFuUVVi?=
 =?utf-8?B?U0RNVGhQUDMwUmpuRDVqMTZ0aTlFNDkzUDFCRHdMMHEzbTE2Z1J5dklXRHhr?=
 =?utf-8?B?V0F6SWJWS2RtTUo2WEYrd2lDazNvUlhTR0VCYVhtaFFVZ0ZKVWQ4b2JtUGxC?=
 =?utf-8?B?cmYweUo5K05LQUx5Z0VNRklqNmJ2NEptQ1djZFluRWtzKzhlUFJHb2xXeEIv?=
 =?utf-8?B?TURLa3lST3hQYmVKNldmbVpQNGJvd1ByeTJyMWdRRElHQUhIQ2pxbk1kbEZo?=
 =?utf-8?B?RDNzVlFKRG9QU2VFSVNVMDhjWStwUThjVU9tMW5RQ2ZZaSszSjZzaWQ5NE1y?=
 =?utf-8?B?SUJFanhJMjZGenZDcVA2K1JEL3M5THN4a05zbEpXc3VkY282WFJIYUVXNXZS?=
 =?utf-8?B?Q3M5Q3cxblRMc2x0YnpVOTkwdW1yZFd3bFM2MWFJeHU3QU94NWI3ZDMyZU1Y?=
 =?utf-8?B?TXJPb3RrMDZUZUdvQVZhb2VSU3ErV1JES0dPbHQ5M3F0Y3l3MjFhSVpMT2pM?=
 =?utf-8?B?OGpFdFpBTlJLOHhnUG5IbzdMN09QYXFKTHdqSkxxUmhEOWdoeEhaUHQwYjlw?=
 =?utf-8?B?VDlDbXBnKzllRmYyVk1qYUlkQmk3TktkOG5pM0hBS3M1RnR2UGFSamxvQlIx?=
 =?utf-8?B?NWtzQ2N0K2NzSUlkM1V1ZFNGdTJqUk1rYXhYMTVxZDl1YkNZZi9HN3VWcC9D?=
 =?utf-8?B?WGxuYWJwc0dHUENDRUs2NmFzZjNTVjhXVWR3ekRUSFI0RlUvR1lacG5pQTBD?=
 =?utf-8?B?TXU1cjNaRVFwaDl2MGpQWGF5bngzWEtwZ0F5SmlTZzExMTNFbThZM2hXc0JY?=
 =?utf-8?B?M2k1RHRoNFVDRkRydThWSlNMdkduUGRLMGVRYmxGUjhBSWVJWVlFSDd1WjRo?=
 =?utf-8?B?WlJKVFpLdnZRNXFYY1pRTkVlbUJwQzlXRHpQSjljT0tqMkVSMktEeDJrMkFF?=
 =?utf-8?B?bERlV1N4V1M1RXJoLzJaNFk1Wkkzd29QUG5URERHeC9ONUxhanNZNGE3Y3Ez?=
 =?utf-8?B?SW5zUG5EaitRRys1cXhQU2RrNlBLdTZJUldOSEEwSEYwdnJvUEF4ZlNhVnVn?=
 =?utf-8?B?dFY0V21rMGw2cGFBTFVqUVR2SVk0M3JQZktZS3doajBZTUNVQ0hhUXA4RHBK?=
 =?utf-8?B?bjRPWGRkTlUzQThSemNkbkpFeXZNdlpwaEZMZVgwZjZvT2kwYi92OWtSWXFU?=
 =?utf-8?B?VUJDNkJqOGR5NUd0b2t1S2Y1UFdrN2VuaVNzc0x0WFJUZ0hNOGJiUzdUb1My?=
 =?utf-8?B?OExIYm93WnRMS0cvYU10UkQyaXhzVzNNbnBHZUcwT1FaaTVVN1lpT2JEWm1a?=
 =?utf-8?B?SjJ0SjBhUWdzQ1JwN2tERDAvRkFtcTFYWC9VQUJJelc3RUNqdEhSS2hsRFhv?=
 =?utf-8?B?bjB3blkwRFUzclVUQTROcndhRzBhT1kyVGlURjYrYlpXd1o3ekYwRHA3RWl2?=
 =?utf-8?B?VnFjNURYbkpZL2pKanlDc3E2SDR4eXQ1UHgvZEVpdXF3d3U3Nm5EZ0ZNaTQy?=
 =?utf-8?B?c0dIaWlNNFRtZmtFUlY1SXBMN0JhZk1PMDhKT0RhQlJRMkc5amg5WHdlU3Jh?=
 =?utf-8?B?Y3dnTXBlR3dKa2c1ZWc3alZ2REQzbTMvZmVDSXBQL1RSRFBpbUxHZWtrV2p6?=
 =?utf-8?B?OHd2RHdzdjVoN1JIaHJrN0VUUDhlQXRoUzBWcWhhRVVvNGhzM1RRRG5WbEwr?=
 =?utf-8?B?Rml1MDdjRUtzV094K2ZNMHpkUWtibkI5dTVYdGZUYXVYK2VPRm1yRjdMN2Zx?=
 =?utf-8?B?QzJheldyekwwb1V0OHVRUmJKTHVpc0JSUFVEYWVaVnVlTXVHSitZWWtzTGVy?=
 =?utf-8?B?bHc1czFOUkw5WTI0cmJTTlB3MWpLUHczTVVBOGRjMUFScWZqU0JHUXI3RVFw?=
 =?utf-8?B?bVl5cCswVVZkSDdmeUc1b1ZiUUFxZmYzbTVVTHM1bkRha2kwYWZOT2JDQldI?=
 =?utf-8?B?TEFuRHlNaHFpSW1rWDBHVnRCUXhxNjZOdGJKN0tqSXdmZGY4VDgyTmJMVUk3?=
 =?utf-8?B?bjMxRnVwRTBlek9PV3JnSTlnL2ZtejR2VTNIcnVvSjVBNksxV2dOZE1UMUtv?=
 =?utf-8?B?c1Z5ekpuSm5WUUx4YW1sb0ZNSW1RVTZGbkxrTXNOT3RHZUtEWkJJbEdOaHVM?=
 =?utf-8?B?WDBXTTkvMkNEbllqaGgxdUVqYXBqV3dVaHEzaWJtUVhidllFWWhsbVNCdktu?=
 =?utf-8?B?OEZrRW5TU1h5RHFaSzJPd0VqMk1RPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYBPR01MB5341.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 065fe295-aaac-4e15-c406-08dbfd0c01d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Dec 2023 01:20:21.5109
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HOVFk4xjkNv/0UoTWt0gnoPxFBNBejMllD4oM++QqjXPT2UyAU1qOHSfzL478KbiUc8bZgrMyunOme6khUcVsXNikXYRqIOA7Z6536Rnx0PdBG+oOsl1zXzeJZ4j2zKR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB7917

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IEZyaWRheSwgTm92ZW1iZXIgMTcsIDIwMjMgNjoyMiBQTQ0KPiANCj4gT24gVHVlLCBOb3YgMTQs
IDIwMjMgYXQgMDI6NTQ6NTVQTSArMDkwMCwgWW9zaGloaXJvIFNoaW1vZGEgd3JvdGU6DQo+ID4g
RnJvbTogSnVzdGluIFN0aXR0IDxqdXN0aW5zdGl0dEBnb29nbGUuY29tPg0KPiA+DQo+ID4gV2hl
biBidWlsZGluZyB3aXRoIGNsYW5nIDE4IEkgc2VlIHRoZSBmb2xsb3dpbmcgd2FybmluZzoNCj4g
PiB8ICAgICAgIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1pcHJvYy1wbGF0Zm9ybS5jOjU1
OjE1OiB3YXJuaW5nOiBjYXN0IHRvIHNtYWxsZXINCj4gPiB8ICAgICAgICAgICAgICAgIGludGVn
ZXIgdHlwZSAnZW51bSBpcHJvY19wY2llX3R5cGUnIGZyb20gJ2NvbnN0IHZvaWQgKicgWy1Xdm9p
ZC1wb2ludGVyLXRvLWVudW0tY2FzdF0NCj4gPiB8ICAgICAgICAgIDU1IHwgICAgICAgICBwY2ll
LT50eXBlID0gKGVudW0gaXByb2NfcGNpZV90eXBlKSBvZl9kZXZpY2VfZ2V0X21hdGNoX2RhdGEo
ZGV2KTsNCj4gPg0KPiA+IFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRoYXQgYG9mX2RldmljZV9n
ZXRfbWF0Y2hfZGF0YWAgcmV0dXJucyBhIHZvaWQqDQo+ID4gd2hpbGUgYGVudW0gaXByb2NfcGNp
ZV90eXBlYCBoYXMgdGhlIHNpemUgb2YgYW4gaW50LiBUaGlzIGxlYWRzIHRvDQo+ID4gdHJ1bmNh
dGlvbiBhbmQgcG9zc2libGUgZGF0YSBsb3NzLg0KPiA+DQo+IA0KPiBBcyBHZWVydCBub3RlZCwg
dGhpcyBzdGF0ZW1lbnQgaXMgd3JvbmcgYXMgdGhlcmUgaXMgbm8gcG9zc2libGUgZGF0YSBsb3Nz
IGluDQo+IHRoaXMgZHJpdmVyLiBQbGVhc2UgZml4IGl0IGluIG5leHQgdmVyc2lvbi4NCg0KSSBn
b3QgaXQuIEknbGwgZHJvcCB0aGlzIHN0YXRlbWVudCBvbiB2My4NCg0KPiA+IExpbms6DQo8c25p
cCBVUkw+DQo+ID4gUmVwb3J0ZWQtYnk6IE5hdGhhbiBDaGFuY2VsbG9yIDxuYXRoYW5Aa2VybmVs
Lm9yZz4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBKdXN0aW4gU3RpdHQgPGp1c3RpbnN0aXR0QGdvb2ds
ZS5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5z
aGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiANCj4gUmV2aWV3ZWQtYnk6IE1hbml2YW5uYW4gU2Fk
aGFzaXZhbSA8bWFuaXZhbm5hbi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+DQoNClRoYW5rIHlvdSBm
b3IgeW91ciByZXZpZXchDQoNCkJlc3QgcmVnYXJkcywNCllvc2hpaGlybyBTaGltb2RhDQoNCj4g
LSBNYW5pDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtaXBy
b2MtcGxhdGZvcm0uYyB8IDIgKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCsp
LCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLWlwcm9jLXBsYXRmb3JtLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
aXByb2MtcGxhdGZvcm0uYw0KPiA+IGluZGV4IGFjZGM1ODNkMjk4MC4uODNjYmM5NWY0Mzg0IDEw
MDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1pcHJvYy1wbGF0Zm9y
bS5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLWlwcm9jLXBsYXRmb3Jt
LmMNCj4gPiBAQCAtNTIsNyArNTIsNyBAQCBzdGF0aWMgaW50IGlwcm9jX3BsdGZtX3BjaWVfcHJv
YmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikNCj4gPiAgCXBjaWUgPSBwY2lfaG9zdF9i
cmlkZ2VfcHJpdihicmlkZ2UpOw0KPiA+DQo+ID4gIAlwY2llLT5kZXYgPSBkZXY7DQo+ID4gLQlw
Y2llLT50eXBlID0gKGVudW0gaXByb2NfcGNpZV90eXBlKSBvZl9kZXZpY2VfZ2V0X21hdGNoX2Rh
dGEoZGV2KTsNCj4gPiArCXBjaWUtPnR5cGUgPSAodWludHB0cl90KSBvZl9kZXZpY2VfZ2V0X21h
dGNoX2RhdGEoZGV2KTsNCj4gPg0KPiA+ICAJcmV0ID0gb2ZfYWRkcmVzc190b19yZXNvdXJjZShu
cCwgMCwgJnJlZyk7DQo+ID4gIAlpZiAocmV0IDwgMCkgew0KPiA+IC0tDQo+ID4gMi4zNC4xDQo+
ID4NCj4gDQo+IC0tDQo+IOCuruCuo+Cuv+CuteCuo+CvjeCuo+CuqeCvjSDgrprgrqTgrr7grprg
rr/grrXgrq7gr40NCg==

