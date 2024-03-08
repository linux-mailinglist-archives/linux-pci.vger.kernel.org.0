Return-Path: <linux-pci+bounces-4663-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F15876390
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 12:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9DE11C2115F
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 11:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9CED5676E;
	Fri,  8 Mar 2024 11:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="PXozqCk9"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2068.outbound.protection.outlook.com [40.107.113.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF79D5675D;
	Fri,  8 Mar 2024 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709898308; cv=fail; b=c1J5xPFhP/pjG4pxi4xXx7ckSl7zAnWfnUku6wNynNUx/qG9Y5XBoxGMQhnmcDwZhnJyxWaF3OSwniAI+ZUkufA/utx8O8R/ulNMk4GcRhTrw4ZDxOM6awyx3cNbDGCRnM63NBjOzuUgpqATheQDfXMF4zcdkCDfAdNE1zezFV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709898308; c=relaxed/simple;
	bh=MELUrH+WaPDWXKkFE5OGWLBZbngjt3DIgsD0B57J81c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rbvtJbZaMZaaPlMrw7/Qyb+/dRc7VDRkIEfi0ztEQMfsoYJa5J4XhAunHORMn3uKR2W5pmLx1a2MfWtCi8h01xt1E1b5Cf3hnbSMDpM7IAdtSzva9hffMjCD5aSUX4bAZFtay1AGGkRe1PKVo4tXlxXsisa5jqF4xI237Bmc5jU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=PXozqCk9; arc=fail smtp.client-ip=40.107.113.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FwCWaKCBdu9t06sUBLJvt1d/IU1yC1CaOgvaXp005sLr2LuKqTaeXLdtrVOsObH8Mo7YgDj2sx2GAYN89KG9hMJtUYf9JnVEPRLEymQDh1i6N+1hUCwqis2r66DC3F3aB3E4ZVqvGKB7ani/EKZ5EV5cdMjk12WAmWDu2aUqFrA8BzalY7ndPGGcEm5JSsJ5D3nX22aHe/Hd1CLYsWI75R9lac7mO6Bbb2VrCuABdL9nVYrWJN2kfjXilWKcrASZ7dvt38Thxp0NWCBCb6N07PARBzM6gMRBXElfoCRHM+OO6oN9FVczLGKAkZNr/ymS7FO3jC7zmmCk3mbmZteowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MELUrH+WaPDWXKkFE5OGWLBZbngjt3DIgsD0B57J81c=;
 b=g3qwmnukV7WDvn7V45lmzdlaDn2s9ihz1nu7pTQ2pMZoc2Lim8DY9h2aav9Jp6L5krwZd3O8rbkCcJVgrTYO+FDyVsisBExivGwMviG5+0VKonUYXNLW9+9LKs08qmwIZojkmY6Sv7w8slbQsjjoDEjLr+vxALnx0eS6XaN1fPn4EYTkVvjoQbqLE39C/WlscSp4kayC7MDWiQKsIDCfIP55MkEez2Gf6DDM6tSrZdoas+C0LujQ5X7it1HHYL7yRhN4meYwM1GV09xpG1ZkX7d8jcg4FpbT9es8tz0OfjyEgS5qyBuje3E0jzlad3Q16AN+ndbKt7xDhDXfq+FYmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MELUrH+WaPDWXKkFE5OGWLBZbngjt3DIgsD0B57J81c=;
 b=PXozqCk9IgKTvOa+oq2ByHQPxlvu66Dhxbti3Is+pNLDyxT+GOW5coQezz44nwelh6cmRl74mLMB+mgu2gcRuKxiI7iHZSVm029yW4X2/UW4QbEMsRNtRKgNzlbwAl7V+uZ3p52dPuKzFZxOaYZu8RJUiQEHL9+QzeZa8mAcz8w=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYWPR01MB10774.jpnprd01.prod.outlook.com (2603:1096:400:2a6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Fri, 8 Mar
 2024 11:45:01 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7362.029; Fri, 8 Mar 2024
 11:45:01 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jingoo Han
	<jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut
	<marek.vasut+renesas@gmail.com>, Kishon Vijay Abraham I <kishon@kernel.org>
CC: Serge Semin <fancer.lancer@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>, "linux-arm-msm@vger.kernel.org"
	<linux-arm-msm@vger.kernel.org>, "mhi@lists.linux.dev" <mhi@lists.linux.dev>,
	Siddharth Vadapalli <s-vadapalli@ti.com>
Subject: RE: [PATCH v4 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Thread-Topic: [PATCH v4 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Thread-Index: AQHab7AzqEk4WgOTk0mbglrxr7ODIrEtvC+A
Date: Fri, 8 Mar 2024 11:45:01 +0000
Message-ID:
 <TYCPR01MB11040F6C956F17D38F28BCF64D8272@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
 <20240306-dw-hdma-v4-3-9fed506e95be@linaro.org>
In-Reply-To: <20240306-dw-hdma-v4-3-9fed506e95be@linaro.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYWPR01MB10774:EE_
x-ms-office365-filtering-correlation-id: efe186db-f0fe-407f-5eca-08dc3f65307b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 KAcNHsJZhdrGq2yoxvP5oQTcqtVIoA2hKuqs4IoWx+0RTy5yYDiNYqHbfiUvQDlzdQSgQoNIKJWVVbBl2JzjkOz/l98W6+I70KxI6P6Q24Pd/FHJgRAIFavkWna5K0A400nB2nQ7spH7e2WlJxcqnbtgV0gj/JlcvF9BHjBh/H6mVUHOHgmWEVbSnuS9rMlogWCpHnoLVXIxagS7M9HVC1SmCZ7thzg6WFtXhJnR9lmizrv7PG5p7QhKvvAN9jevczIvCxP6ck5uTdt3HpqSuPoA1cuyKiY/whyHZFiA37nWoX8g0Oh11STZXOnuUTuqouZ7CS7AFTxZJhvnlyelc57bXutqsmacQ1ieD9UZ3qmVEVkWiYnCfBxSPZ4zxzMXyHM4lxwADWJtZ5D6YZGMZWzZIAmMZ5Q7HRiliDrLd4O75Ev+JKF324Z5kuhPSzzlK2UcAabS0ifYLFldBmXJZxhZM5zZjBvXmkz/EKt+rCkkIYfF/oZalitYRpC3G6dtgHHvHYDcyRYskGdRXt9hec2IyGhfVTPUEqwaCU12qGG5WAZngvinCONliRv0VW5Fb+Wu22iHrNa4MO5trqR9cPaYXLlSeqj0hJAx3XoluobPs+XwBv+no1O7A3Xrtnv0z52IPfxidc7wnpVHqzs3xPKdvV0Voq42WJCGw8Z/X4uIDeILn37pToRHiYY6h8h3MuFHO3CzVmuPCTsxatSM3W/1gVyCUmIRkXimpFkq7t0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(7416005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OGpUZGZJU1BYc0p2c1RhTk04cU0xRkI3d3dRSm9yRmZLNzBWRGVIVlIxc29U?=
 =?utf-8?B?a043bUQvSUdpQmY3WFMxdExIR056a05QZGxmOUl4SERmNXhGNkt0eFFnQkt2?=
 =?utf-8?B?b0ZCcS9pQnlQNlFvVzlrSitTZ1J3Q0hBNnpiWEN0T1lGUjFSa2dOdGV4Q21V?=
 =?utf-8?B?RER3R3I3eDVicmM1RU1ETEhpYjJMQzdSb0pwd0tBL0FpVzlUYmt3WFBOWHly?=
 =?utf-8?B?cFNNeWhJTHBDVndrbG00UnJzZ1pNeEF4WXdlRW4rcXZFeUxJWDFjakZWRENU?=
 =?utf-8?B?Y2xaSVo1YkdlRm9MeU9ZVGlZSDM4d0J5Y2p4S0o4dXRHMnkvWGdDZ3I3cDJw?=
 =?utf-8?B?eWJJbUdvQmJrKzZ0SFA0cEhkMEZmZ09LcW9vSTlaazExYXlQTEZXVTMvallr?=
 =?utf-8?B?WXAxeWwxb1oraFFVemMxeHpQZ2hTdU8wa3lQMzlyNVl3dlA3Z1Vka203b05V?=
 =?utf-8?B?RTcvMEZVUUdmM21ZeGFDQmozRUVobWY2RGxnRmdNbmJzeVdVcG5ESzBLb1JU?=
 =?utf-8?B?R0QwNEltQUdLWU9RV3l5U0lNVEZUdHpqRUNpVGdZUVRsKzNDVDlxeGNvUEFt?=
 =?utf-8?B?SkpEYVI3dnRFMTZaK3hjdlVieDQ0QlpMNmhsM1FFRTgvR0xpV1ArMEIwOEt1?=
 =?utf-8?B?eHE0N0pSbkhKZzJ0VVhjOVNVTXJNN0hSZUljd3QzcjlqSmlVeTIrQmxVcGNW?=
 =?utf-8?B?U21sN0JjdnVybVZKYTVDa1NLcUFwcE9ReUY1YjByUG15MjVYbkt2Z2gxT1cx?=
 =?utf-8?B?a2doMHJ1SmJVSDBDL3k4Uk1Fc1FtM0FCMU9zUXpwQURKRVhKZmYyZmZXSzUz?=
 =?utf-8?B?S3k0b2tPVWNLRFhDZjBaUUx6S0lnRjVvdHRZbGZkei9XcUdIeC9zbUwybSta?=
 =?utf-8?B?S1pPNHl1dWlDc0dCVm5qakV3R2sxK09FaTdUaUs5UjJ2a3drTklPOE5SRDF4?=
 =?utf-8?B?anJ4dVpnNmxEdXpqa25Jc0w0K2R3bWYyTmVqTW56ZHI4eDR5dFl0OFdDWUtU?=
 =?utf-8?B?Q1U1TFQ4d3pZT245TjlGejBtRFh3b0k0VU04b1ROUmJIWUc2R2VBVUVwbFFE?=
 =?utf-8?B?RUpUd1JtRmY1UzhzdC96bVZHTVdVaXRTMzBodFBQL1d3bWc5SHNULy93bXlZ?=
 =?utf-8?B?T3poWUNnV0x1WFFzUTBLMERjbk03bjBQemsrcUpoNHMzZENlaDcxZXN6WnZ4?=
 =?utf-8?B?NGlZT2FieURGM1hFZHN0S1BjT250dXgxYnVJRzM1Ymd2NWJpdzBUQ21hdkky?=
 =?utf-8?B?VkVJNWxIcUcrK25MZXVRR3VsUjFLMENQQUozQkVrUWNPbTFSTCs3OWhMaGQ2?=
 =?utf-8?B?QkU1Z1hwb0J4L3p3ZVN4M2VtcjhVM1pvdEYrNC9WVHZhZW0rWFFtaVVqdE5R?=
 =?utf-8?B?YW96d1phYWhUVnhsVlRZYld1UWlRc3ZXaEx4RS9OQk5yMzRSbEk4Nk1WYW1Z?=
 =?utf-8?B?YkU2OVhyRU1CaVY2SjdoSk1ka25MUTkxaDZsNTd1VjNWSzIrSlZCQ1ZpMjg2?=
 =?utf-8?B?cHAvQ24yVFBkNUJyZEpsZk12enIxVElTK05waGtkbW9PbDBzdlliVE5vVFVN?=
 =?utf-8?B?bzludnBHS0hzc2VsT3M2K0VhdTRaNGNNOC81TDlFUHV5K3pKc0NWcnVJZFFN?=
 =?utf-8?B?WlN6b1M1a0hkUkVlVEJab0NLd044Q2R6NHJaRVl2ZTRGalBNc0phR0tPaC96?=
 =?utf-8?B?cGdrTXNUYXd5TmNVQjY1bUVXUFZOSG9HUmxraEhiNGJKS083MmpVSWNRYzVS?=
 =?utf-8?B?TlE3a1pMTldJMW41d21Wek91cFkyTG5pQnVrVVhKU3VObFlrcS9FRkNVTTkr?=
 =?utf-8?B?RWlNYzVnb3hiK3RvYlkvM0NyTW45N2dkUGFlb0VCM2NwaWtXNUVkU0h5SmhR?=
 =?utf-8?B?VnZRelpKZHlzdHY4VkNEMXlRb1B5MVlsRStjTEFTc05vYnh5SFJoVktic1pj?=
 =?utf-8?B?RlY5cTFTZkNPSGVvZ1d3M3Z5d3ExazJXRmdYWnlzYU83NDFOODJvbER4bEFE?=
 =?utf-8?B?bVZvQ3MyVXZHZEhnOTFkbFMxWWoyQldYYkJxWkFySGFpMHZCWVk0V1hUbWtD?=
 =?utf-8?B?UlptOFhiM2tRUVZCa1N6MUhWRjVuaGQ2MEY5cW9XVzh1N05oMEliZUROWTAz?=
 =?utf-8?B?OC9vRFhXVHNVaGNxOEhzeVg1RUtJRDk5Zk5sanN5NlgvMzFvRHN1dkRmUkxU?=
 =?utf-8?B?L1E9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB11040.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: efe186db-f0fe-407f-5eca-08dc3f65307b
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Mar 2024 11:45:01.6880
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y1hmNRUBDBfB8Hqm5cgY0X4Ynbkm4w5T/oSbkH6jn78Rb+NWVHNIOwYkTbdGLmmXge01HD5uJD+Xf1SbeQ+yMPTbMiPSFBGFwfluh1OtUv2SBINUSHxaZUfh5h77s2/G
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB10774

PiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6IFdlZG5lc2RheSwgTWFyY2ggNiwg
MjAyNCA3OjIyIFBNDQo+IA0KPiBJbnN0ZWFkIG9mIG1haW50YWluaW5nIGEgc2VwYXJhdGUgY2Fw
YWJpbGl0eSBmb3IgZ2x1ZSBkcml2ZXJzIHRoYXQgY2Fubm90DQo+IHN1cHBvcnQgYXV0byBkZXRl
Y3Rpb24gb2YgdGhlIGVETUEgbWFwcGluZyBmb3JtYXQsIGxldCdzIHBhc3MgdGhlIG1hcHBpbmcN
Cj4gZm9ybWF0IGRpcmVjdGx5IGZyb20gdGhlbS4NCj4gDQo+IFRoaXMgd2lsbCBzaW1wbGlmeSB0
aGUgY29kZSBhbmQgYWxzbyBhbGxvdyBhZGRpbmcgSERNQSBzdXBwb3J0IHRoYXQgYWxzbw0KPiBk
b2Vzbid0IHN1cHBvcnQgYXV0byBkZXRlY3Rpb24gb2YgbWFwcGluZyBmb3JtYXQuDQo+IA0KPiBT
dWdnZXN0ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IFNpZGRoYXJ0aCBWYWRhcGFsbGkgPHMtdmFkYXBhbGxpQHRpLmNvbT4NCj4gUmV2
aWV3ZWQtYnk6IFNlcmdlIFNlbWluIDxmYW5jZXIubGFuY2VyQGdtYWlsLmNvbT4NCj4gU2lnbmVk
LW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1AbGlu
YXJvLm9yZz4NCg0KVGhhbmsgeW91IGZvciB0aGUgcGF0Y2ghDQoNClJldmlld2VkLWJ5OiBZb3No
aWhpcm8gU2hpbW9kYSA8eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQoNCkkgYWxz
byB0ZXN0ZWQgdGhpcyBwYXRjaCBvbiBteSBwbGF0Zm9ybSBhbmQgaXQgd29ya2VkIGNvcnJlY3Rs
eS4gU28sDQoNClRlc3RlZC1ieTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2Rh
LnVoQHJlbmVzYXMuY29tPg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+
IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCAx
NiArKysrKysrKystLS0tLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUuaCB8ICA1ICsrLS0tDQo+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LXJjYXItZ2VuNC5jICB8ICAyICstDQo+ICAzIGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1kZXNpZ253YXJlLmMNCj4gaW5kZXggNTk5OTkxYjdmZmIyLi5jNTliMjg3NmU1ZDQgMTAw
NjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5j
DQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+
IEBAIC04OTQsMTggKzg5NCwyMCBAQCBzdGF0aWMgaW50IGR3X3BjaWVfZWRtYV9maW5kX21mKHN0
cnVjdCBkd19wY2llICpwY2kpDQo+ICB7DQo+ICAJdTMyIHZhbDsNCj4gDQo+ICsJLyoNCj4gKwkg
KiBCYWlsIG91dCBmaW5kaW5nIHRoZSBtYXBwaW5nIGZvcm1hdCBpZiBpdCBpcyBhbHJlYWR5IHNl
dCBieSB0aGUgZ2x1ZQ0KPiArCSAqIGRyaXZlci4gQWxzbyBlbnN1cmUgdGhhdCB0aGUgZWRtYS5y
ZWdfYmFzZSBpcyBwb2ludGluZyB0byBhIHZhbGlkDQo+ICsJICogbWVtb3J5IHJlZ2lvbi4NCj4g
KwkgKi8NCj4gKwlpZiAocGNpLT5lZG1hLm1mICE9IEVETUFfTUZfRURNQV9MRUdBQ1kpDQo+ICsJ
CXJldHVybiBwY2ktPmVkbWEucmVnX2Jhc2UgPyAwIDogLUVOT0RFVjsNCj4gKw0KPiAgCS8qDQo+
ICAJICogSW5kaXJlY3QgZURNQSBDU1JzIGFjY2VzcyBoYXMgYmVlbiBjb21wbGV0ZWx5IHJlbW92
ZWQgc2luY2UgdjUuNDBhDQo+ICAJICogdGh1cyBubyBzcGFjZSBpcyBub3cgcmVzZXJ2ZWQgZm9y
IHRoZSBlRE1BIGNoYW5uZWxzIHZpZXdwb3J0IGFuZA0KPiAgCSAqIGZvcm1lciBETUEgQ1RSTCBy
ZWdpc3RlciBpcyBubyBsb25nZXIgZml4ZWQgdG8gRkZzLg0KPiAtCSAqDQo+IC0JICogTm90ZSB0
aGF0IFJlbmVzYXMgUi1DYXIgUzQtOCdzIFBDSWUgY29udHJvbGxlcnMgZm9yIHVua25vd24gcmVh
c29uDQo+IC0JICogaGF2ZSB6ZXJvcyBpbiB0aGUgZURNQSBDVFJMIHJlZ2lzdGVyIGV2ZW4gdGhv
dWdoIHRoZSBIVy1tYW51YWwNCj4gLQkgKiBleHBsaWNpdGx5IHN0YXRlcyB0aGVyZSBtdXN0IEZG
cyBpZiB0aGUgdW5yb2xsZWQgbWFwcGluZyBpcyBlbmFibGVkLg0KPiAtCSAqIEZvciBzdWNoIGNh
c2VzIHRoZSBsb3ctbGV2ZWwgZHJpdmVycyBhcmUgc3VwcG9zZWQgdG8gbWFudWFsbHkNCj4gLQkg
KiBhY3RpdmF0ZSB0aGUgdW5yb2xsZWQgbWFwcGluZyB0byBieXBhc3MgdGhlIGF1dG8tZGV0ZWN0
aW9uIHByb2NlZHVyZS4NCj4gIAkgKi8NCj4gLQlpZiAoZHdfcGNpZV92ZXJfaXNfZ2UocGNpLCA1
NDBBKSB8fCBkd19wY2llX2NhcF9pcyhwY2ksIEVETUFfVU5ST0xMKSkNCj4gKwlpZiAoZHdfcGNp
ZV92ZXJfaXNfZ2UocGNpLCA1NDBBKSkNCj4gIAkJdmFsID0gMHhGRkZGRkZGRjsNCj4gIAllbHNl
DQo+ICAJCXZhbCA9IGR3X3BjaWVfcmVhZGxfZGJpKHBjaSwgUENJRV9ETUFfVklFV1BPUlRfQkFT
RSArIFBDSUVfRE1BX0NUUkwpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvcGNpZS1kZXNpZ253YXJlLmggYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2ll
LWRlc2lnbndhcmUuaA0KPiBpbmRleCAyNmRhZTQ4Mzc0NjIuLjk5NTgwNTI3OTAyMSAxMDA2NDQN
Cj4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4g
KysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmgNCj4gQEAg
LTUxLDkgKzUxLDggQEANCj4gDQo+ICAvKiBEV0MgUENJZSBjb250cm9sbGVyIGNhcGFiaWxpdGll
cyAqLw0KPiAgI2RlZmluZSBEV19QQ0lFX0NBUF9SRVFfUkVTCQkwDQo+IC0jZGVmaW5lIERXX1BD
SUVfQ0FQX0VETUFfVU5ST0xMCQkxDQo+IC0jZGVmaW5lIERXX1BDSUVfQ0FQX0lBVFVfVU5ST0xM
CQkyDQo+IC0jZGVmaW5lIERXX1BDSUVfQ0FQX0NETV9DSEVDSwkJMw0KPiArI2RlZmluZSBEV19Q
Q0lFX0NBUF9JQVRVX1VOUk9MTAkJMQ0KPiArI2RlZmluZSBEV19QQ0lFX0NBUF9DRE1fQ0hFQ0sJ
CTINCj4gDQo+ICAjZGVmaW5lIGR3X3BjaWVfY2FwX2lzKF9wY2ksIF9jYXApIFwNCj4gIAl0ZXN0
X2JpdChEV19QQ0lFX0NBUF8gIyMgX2NhcCwgJihfcGNpKS0+Y2FwcykNCj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMgYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jDQo+IGluZGV4IGU5MTY2NjE5YjFmOS4u
M2M1MzVlZjVlYTkxIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9w
Y2llLXJjYXItZ2VuNC5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
cmNhci1nZW40LmMNCj4gQEAgLTI1NSw3ICsyNTUsNyBAQCBzdGF0aWMgc3RydWN0IHJjYXJfZ2Vu
NF9wY2llICpyY2FyX2dlbjRfcGNpZV9hbGxvYyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2
KQ0KPiAgCXJjYXItPmR3Lm9wcyA9ICZkd19wY2llX29wczsNCj4gIAlyY2FyLT5kdy5kZXYgPSBk
ZXY7DQo+ICAJcmNhci0+cGRldiA9IHBkZXY7DQo+IC0JZHdfcGNpZV9jYXBfc2V0KCZyY2FyLT5k
dywgRURNQV9VTlJPTEwpOw0KPiArCXJjYXItPmR3LmVkbWEubWYgPSBFRE1BX01GX0VETUFfVU5S
T0xMOw0KPiAgCWR3X3BjaWVfY2FwX3NldCgmcmNhci0+ZHcsIFJFUV9SRVMpOw0KPiAgCXBsYXRm
b3JtX3NldF9kcnZkYXRhKHBkZXYsIHJjYXIpOw0KPiANCj4gDQo+IC0tDQo+IDIuMjUuMQ0KDQo=

