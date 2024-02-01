Return-Path: <linux-pci+bounces-2902-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0970F844F58
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 04:07:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B23B8284BA7
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 03:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56EAB39FEE;
	Thu,  1 Feb 2024 03:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="hXKRYxLz"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2106.outbound.protection.outlook.com [40.107.113.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD72FFBFA;
	Thu,  1 Feb 2024 03:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706756851; cv=fail; b=t2FGGCX7TzgGyUwg//BNtZGJSNm3+LpjImlEh57gwckPaSpQRhPhvNlgSyYn6Zbr77nKgznWAU3g5O3wdMTBXpnZ85i6t2HXI8cuMlIk0UmtwiA0A3QG7yhC84YmwVuK28aTAQYXLxCJdGvkyaQULRqtfg8EZBlWfZor3TCx4tM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706756851; c=relaxed/simple;
	bh=2PI+ZdcCQT5fQvA1nIYVUkdaLQTnzhiZ/v2rc5KbD+M=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VYL9i5qxnGkkP+4re4SEm4gSG/GEfoWZzs728+vyuI6FUuRj9T0oqrJjTjpmrDQSYAFtJS6iuyi3ku7lTlOL0rrewY0j2aY5m74cmPLto+KhMjIa1w/Zbx0RqHLkxDUwfVg3zgnGmZ5q0fXS+qkgFmDjGfiuxf3mHdZOZjlVbTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=hXKRYxLz; arc=fail smtp.client-ip=40.107.113.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KpoCzbc0jq4JKGy1NiT1K8aqPwy6UliViGSZP3mJKpuLd6n2KMrVNipWSwDUhg4r0ZqXRmShaE5L4B+pDX99hYWQuIeWGf0EnnQnwKYJ4fCwKCh8VO29XcZO/OhKIhm7rteBQwtOqHsi8ikal9m3suADIZe2Z8OzpcH9fED5QQyGiLOiiRnH04tdVJSm2cXyt67LnfGHIZUWWEFGQvPYrAlg9JRy/LdBu2Dqj5IeHu05iwwJ/FliQfNEo3Yl10kD41Zn5coFE2130Le/8Mx0Rtiw2XF1z8OUAcH4z6Gz/OD7CSO2BC0QDnaI8g5dOoPh+hRXpmz4HHS4iBuQkQ+hXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PI+ZdcCQT5fQvA1nIYVUkdaLQTnzhiZ/v2rc5KbD+M=;
 b=T1/3BW1/fzlih37QsJkuRIINiC3ny5WPFHp3iT5ndRJOSseVeijZrGDAzHqu2iSUlF4VBx0nItU9QwGVq74oUgsqwdfo/9CgSRBAKyWh0MB8DefHemeL2g2V+Nq8nS0lXbGMVswoUIku/6HhKVw4CxZphpowSLMp2KvLJaVFVyPou4ifbJqaZxqNaOm9QHaXj4DoBERJMt+TZs+zIybLLS+lunROpDKoU6aWEPBrhgj8c6Mq/Y6yl0wdhUVV3HZesvqBug0ZWI70lIuD1m6afgpWSv6ES5Od4/TvRT54/cdxsSpuVZ75pnJlYLovfgRk/SrYp1fsDBJyLA+Gyggepg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PI+ZdcCQT5fQvA1nIYVUkdaLQTnzhiZ/v2rc5KbD+M=;
 b=hXKRYxLzZ2WkH7bwBpiaP+g8MhdcTSvXathyyGogRdFtOcDkTA1xLfCYEOkgCb9peJble0p/B9AAStovAVoJ3xieEj31vLUaBN1ULFLaHYr/6gBFaCjXpmlKlTzrwE1uA0dD4lbjCDwD473cxS5p4/1nhNo/Caq9qIGydqtDmj0=
Received: from TYCPR01MB8613.jpnprd01.prod.outlook.com (2603:1096:400:152::8)
 by OS3PR01MB5798.jpnprd01.prod.outlook.com (2603:1096:604:c3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.18; Thu, 1 Feb
 2024 03:07:24 +0000
Received: from TYCPR01MB8613.jpnprd01.prod.outlook.com
 ([fe80::b6ab:c824:4115:bf2c]) by TYCPR01MB8613.jpnprd01.prod.outlook.com
 ([fe80::b6ab:c824:4115:bf2c%4]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 03:07:24 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Frank Li <Frank.Li@nxp.com>, Bjorn Helgaas <bhelgaas@google.com>, Jingoo
 Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Lorenzo Pieralisi
	<lpieralisi@kernel.org>, =?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?=
	<kw@linux.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Serge Semin
	<fancer.lancer@gmail.com>
Subject: RE: [PATCH 3/6] PCI: dwc: Add outbound MSG TLPs support
Thread-Topic: [PATCH 3/6] PCI: dwc: Add outbound MSG TLPs support
Thread-Index: AQHaU97hc8ede52khkKNQoSH8xnu+LD0zzQg
Date: Thu, 1 Feb 2024 03:07:24 +0000
Message-ID:
 <TYCPR01MB86137941900C38F89EC2F321D8432@TYCPR01MB8613.jpnprd01.prod.outlook.com>
References: <20240130-pme_msg-v1-0-d52b0add5c7c@nxp.com>
 <20240130-pme_msg-v1-3-d52b0add5c7c@nxp.com>
In-Reply-To: <20240130-pme_msg-v1-3-d52b0add5c7c@nxp.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB8613:EE_|OS3PR01MB5798:EE_
x-ms-office365-filtering-correlation-id: edf9669c-0697-427f-b8f7-08dc22d2ea43
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 Tdbz49GyV/ZPMVumVncbGpBVdip7OGYVSpv33zSqZjwUu3uNAdxTb8nEi6k/e4Bdq02NOczHuRJfcOpD5Iu74MVNaORcAGp9IKFqvUHkpaI2ZQcg201U9gU4i+PjnGQGUKZT4jgt/+H9hPa1JssRiqK8Ibd3hFOIhbF/RZ2kdD/RMOYBBPDy33Sq00jMAUTl9ksrH5VMHrh/+r4fhtELDGTfr3uX2+11RANkKO15in4zaRsckbkPq+n/a11P3CLJlUGHnjjH/QL2437t2sU1Pn9oKWe3rso2iyA+PONL7zj5fJO5jKqS5Ipk8wPxqAeeD52fwssA8q2Klih6fZB0GBY4iQ8XxKSkyZl5DmZxv3jKEiKeA3qUlIfV7szSRVju5REsGSo3h8j3BmpMJ8VrHuoFyVClI9k/zYFcXpdi4Fxm+kHjKpgt1suoRkiLslOSpn7ti3DG6l85A+zmJ7LGZ7juEwgVYI2N1mo7H8ZsCPdXmeJxLMqri3Yd92b/eaIr81QApHH8lJYmQBL1aAuAlSMxbeuTQTiRil+kIWS+/aasYa/Xc5MxiLCuPtYj2M98rT6U2uEK2KESn9beSPdchmnS0i/sM3mT2VOQTET/uanxnxw1gk+VfOIlP333mEciukrp7UcPtP3iDNUGsuzlEA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB8613.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(376002)(366004)(346002)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(52536014)(4326008)(38100700002)(122000001)(64756008)(54906003)(66476007)(66446008)(316002)(76116006)(921011)(110136005)(66946007)(86362001)(38070700009)(66556008)(41300700001)(2906002)(33656002)(7416002)(5660300002)(83380400001)(9686003)(7696005)(71200400001)(478600001)(26005)(6506007)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?c3dYdWxsNyszZlowOTc1czNrUU96WkRkd0lNTlBpUzE2cTV1Vkd5eHBaOC8y?=
 =?utf-8?B?K3JEMGpKUFJEL0ExT0lJY25aalorUFVFMUxxKzV1WkM1MWYwUGhCQklycXdK?=
 =?utf-8?B?NGxwUHBJVVNpTUcwRlpkbDFaVU9IYVpKcm9uak1XV1JGeWdMd3NtYlhEbXhN?=
 =?utf-8?B?Nmdqb1FxVXdUZU9oOW84N3FOMFh0SUVkY2svUW1KY0lwTUwreU5HZW95MUh0?=
 =?utf-8?B?SXhwMW5vNlA4UmwxMStIWktvZVhBRW9yK2l2M013VU1IN0M1ZExsV0dhK2NB?=
 =?utf-8?B?R2JtSzN5MHhjYWl3OFJKMGVKa01iYXZ5a1lranZ2MFM1QVpDVnd1QUhhcEls?=
 =?utf-8?B?TlVwaU1RWitqdkQyNWNoNVBnMkJiV1hOV0RvaFRDNWRFR2F3VEtiR3pFK29K?=
 =?utf-8?B?RTYyQ1R6d1RwWTBDS21mcW41K3I1ZjFPQnQ5T2o3SEl2WnE1S0dCTVQ0c3hP?=
 =?utf-8?B?VzVsaW9JSnpCVndON0s0RW5rYkJFcGszbWM1SUdjNUpQOHdqWG50QktnZDJl?=
 =?utf-8?B?M2pTN204bERQSFBlOWRndUF2VmNkelNhV29SLzBlYWxMOURIMUpQbEpGMGFh?=
 =?utf-8?B?Vm44czI1T2hMbTkzQVgwdldnMUw4dnVDandoaUh5QlREVDVhNllmOVV1ejNT?=
 =?utf-8?B?ZlpPL2Q1OWdYc3FBUlNJSUI0Z1ZaSGtOWXNCZGIxTHRrMXZaNThGSktKaWdm?=
 =?utf-8?B?WlU4U2RWY05EOS9IKzdNUy9iQ3hqSGE0WEdSQ3psNDJtalpIN1BtVWhHN0pi?=
 =?utf-8?B?N01xVjdpbWh4SzR6N21LV3BFdXQrUjJGd3RwbEhqaG9ZT3B0NUhtNVRNZkFh?=
 =?utf-8?B?SlVvVnorbHY5dVNGZUphVVRXWGlpa2dIK1orK0lISHNMM1FMWis1RHpDZHFv?=
 =?utf-8?B?S1hSdit6Nm0yWGlXNm9ndW4vZEdlaFRLREwweW9JdmZwa28xWk4rWDVlNmQ3?=
 =?utf-8?B?aG9EUytrdm1Wc0xvSllJR1RTMTVSR1l2Zk1pUnp3bVFIaTU4K1VrOHpRRzMz?=
 =?utf-8?B?dnJDdy9jUzBDSHZTQlFGcmM5NVdqRmNaYlFZaThMcHh0OUtYRmw4ZzBESUhs?=
 =?utf-8?B?NVJVTkxYZGxSUUlUQW8vczloZnlIWFRvNVRVSXFwTzFqTUg2YWtkNkltQVpE?=
 =?utf-8?B?VlpWVVhIWnl0YjB2SGdNbThWL2REK3VqT1ZwLytQYVBsNWRod0VpS2xMeTFs?=
 =?utf-8?B?Rk5VbHRPQXVDVWVmYlVIV0k4YTJwNWg2Q2VScWJNNVg0YmhIWHQ2SlBPeXBr?=
 =?utf-8?B?NFE2L1RnL0ZHdkdtblRTamljTU8yYTJQNzdRdEpLaFVmdFF6U3lSU2dKT1pp?=
 =?utf-8?B?bi80c1JHOW1HWmFDcDZpdUMyRGs4UGt4Y3BUYjR1V25tWUxZNkNsNUhCREx2?=
 =?utf-8?B?MWVMM2w3OWpPOHR2ZVVTVmlMUjByTkZ5UVRCQnpoQm1xbkYwYmJtVkNXSS9R?=
 =?utf-8?B?aUljYXM4WVJIMUlNeVRaVXNlUEY1SlkxaUpCd1lLVWttdXpnYTlvb3NIWUVn?=
 =?utf-8?B?dnFuSEVGN3NLYkxsMWFDcHRUOW90V2lTMDhrZnJLTmdLU3doczJZMU1aVUUv?=
 =?utf-8?B?SlBkaG9XcmRFMUs0Q3VVTVpZSTFPOEovL200R2I1TlVOaENlcklKTjdDQ2hK?=
 =?utf-8?B?Y01tRTNxZTV1SzhmNlVTMm9OVG5tWjJMOTJqUENtL21lNXpQS3VXbVo0SGlu?=
 =?utf-8?B?MDY2YVE1WXBLcWY3ck9UM2t5S1N2VENrY0oyTVJxVmNSWk5aUVM5WlduYU9Y?=
 =?utf-8?B?S2ZZTi9zb0VCSlBmS2lEaEZrTU1xcEVsWkpxV0t3UkpGM2JPMDcxNW5Gcmpo?=
 =?utf-8?B?R0xSajhEKzU5NUtYdUxYcWY1cU9iODV2eTFseitwTWFiU29Xell2VmhEcU5K?=
 =?utf-8?B?bFdLN2xmT0JoVnExeFN2VUJTL3RkQ1J1Z3Vnbm9Jak9vSmt4UUFjQUZBSy9D?=
 =?utf-8?B?Wit2WFFjTFF4bHg5cVRFaVNSYmJZYjhsTy9aMitPT09HTHM1U2wyRmQ5VkhG?=
 =?utf-8?B?MVcxMkwyd0pjKzZYNE40NEpJcGhyM09MVUQyZ2pCbkhsYVJFMXF5U2Ewd21t?=
 =?utf-8?B?eHh3Wkpib3Q4L2ZQS1hsYjFTcEp0N1J2U3NhcWZUa0hrZndScHM0ckN4UEpW?=
 =?utf-8?B?VTZNbmUxTGJrSWRzTzZqVlhESHRFd3dBNXVxZHU0UU1tQjYxWmhub2U2bm5Y?=
 =?utf-8?B?alE9PQ==?=
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
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB8613.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edf9669c-0697-427f-b8f7-08dc22d2ea43
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 03:07:24.8487
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: e2N4q1hVrxGfxfkFxP5SZtn8pq7BZ3kaINXri6YB8nGOBmo5fYelXEq9FBnkSoFFtPh7RG5VrvvDLEbknbcQgFSfR23ruXg5BBB6NVqM0YEcyHxHzoZvKlPY5hMlSB/Z
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5798

SGkgRnJhbmssDQoNCj4gRnJvbTogRnJhbmsgTGksIFNlbnQ6IFdlZG5lc2RheSwgSmFudWFyeSAz
MSwgMjAyNCA5OjQ1IEFNDQo+IA0KPiBGcm9tOiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJv
LnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+IA0KPiBBZGQgImNvZGUiIGFuZCAicm91dGluZyIg
aW50byBzdHJ1Y3QgZHdfcGNpZV9vYl9hdHVfY2ZnIGZvciB0cmlnZ2VyaW5nDQo+IElOVHggSVJR
cyBieSBpQVRVIGluIHRoZSBQQ0llIGVuZHBvaW50IG1vZGUgaW4gbmVhciB0aGUgZnV0dXJlLg0K
PiBQQ0lFX0FUVV9JTkhJQklUX1BBWUxPQUQgaXMgc2V0IHRvIGlzc3VlIFRMUCB0eXBlIG9mIE1z
ZyBpbnN0ZWFkIG9mDQo+IE1zZ0QuIFNvLCB0aGlzIGltcGxlbWVudGF0aW9uIHN1cHBvcnRzIHRo
ZSBkYXRhLWxlc3MgbWVzc2FnZXMgb25seQ0KPiBmb3Igbm93Lg0KPiANCj4gU2lnbmVkLW9mZi1i
eTogWW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0K
PiBSZXZpZXdlZC1ieTogU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPg0KPiBS
ZXZpZXdlZC1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1A
bGluYXJvLm9yZz4NCg0KUGVyaGFwcywgeW91ciBTaWduZWQtb2ZmLWJ5IGlzIG5lZWRlZCBoZXJl
Pw0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+IC0tLQ0KPiAgZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmMgfCA5ICsrKysrKystLQ0KPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLmggfCA0ICsrKysNCj4g
IDIgZmlsZXMgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkNCj4gDQo+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUu
YyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+IGluZGV4
IGRmMjU3NWVjNWY0NGMuLmJhOTA5ZmFkZTlkYjEgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+IEBAIC00OTksNyArNDk5LDcgQEAgaW50
IGR3X3BjaWVfcHJvZ19vdXRib3VuZF9hdHUoc3RydWN0IGR3X3BjaWUgKnBjaSwNCj4gIAlkd19w
Y2llX3dyaXRlbF9hdHVfb2IocGNpLCBhdHUtPmluZGV4LCBQQ0lFX0FUVV9VUFBFUl9UQVJHRVQs
DQo+ICAJCQkgICAgICB1cHBlcl8zMl9iaXRzKGF0dS0+cGNpX2FkZHIpKTsNCj4gDQo+IC0JdmFs
ID0gYXR1LT50eXBlIHwgUENJRV9BVFVfRlVOQ19OVU0oYXR1LT5mdW5jX25vKTsNCj4gKwl2YWwg
PSBhdHUtPnR5cGUgfCBhdHUtPnJvdXRpbmcgfCBQQ0lFX0FUVV9GVU5DX05VTShhdHUtPmZ1bmNf
bm8pOw0KPiAgCWlmICh1cHBlcl8zMl9iaXRzKGxpbWl0X2FkZHIpID4gdXBwZXJfMzJfYml0cyhj
cHVfYWRkcikgJiYNCj4gIAkgICAgZHdfcGNpZV92ZXJfaXNfZ2UocGNpLCA0NjBBKSkNCj4gIAkJ
dmFsIHw9IFBDSUVfQVRVX0lOQ1JFQVNFX1JFR0lPTl9TSVpFOw0KPiBAQCAtNTA3LDcgKzUwNywx
MiBAQCBpbnQgZHdfcGNpZV9wcm9nX291dGJvdW5kX2F0dShzdHJ1Y3QgZHdfcGNpZSAqcGNpLA0K
PiAgCQl2YWwgPSBkd19wY2llX2VuYWJsZV9lY3JjKHZhbCk7DQo+ICAJZHdfcGNpZV93cml0ZWxf
YXR1X29iKHBjaSwgYXR1LT5pbmRleCwgUENJRV9BVFVfUkVHSU9OX0NUUkwxLCB2YWwpOw0KPiAN
Cj4gLQlkd19wY2llX3dyaXRlbF9hdHVfb2IocGNpLCBhdHUtPmluZGV4LCBQQ0lFX0FUVV9SRUdJ
T05fQ1RSTDIsIFBDSUVfQVRVX0VOQUJMRSk7DQo+ICsJdmFsID0gUENJRV9BVFVfRU5BQkxFOw0K
PiArCWlmIChhdHUtPnR5cGUgPT0gUENJRV9BVFVfVFlQRV9NU0cpIHsNCj4gKwkJLyogVGhlIGRh
dGEtbGVzcyBtZXNzYWdlcyBvbmx5IGZvciBub3cgKi8NCj4gKwkJdmFsIHw9IFBDSUVfQVRVX0lO
SElCSVRfUEFZTE9BRCB8IGF0dS0+Y29kZTsNCj4gKwl9DQo+ICsJZHdfcGNpZV93cml0ZWxfYXR1
X29iKHBjaSwgYXR1LT5pbmRleCwgUENJRV9BVFVfUkVHSU9OX0NUUkwyLCB2YWwpOw0KPiANCj4g
IAkvKg0KPiAgCSAqIE1ha2Ugc3VyZSBBVFUgZW5hYmxlIHRha2VzIGVmZmVjdCBiZWZvcmUgYW55
IHN1YnNlcXVlbnQgY29uZmlnDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2llLWRlc2lnbndhcmUuaCBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUt
ZGVzaWdud2FyZS5oDQo+IGluZGV4IGQyMWRiODJlNTg2ZDUuLjcwM2I1MGJjNWUwZjEgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+
ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5oDQo+IEBA
IC0xNDgsMTEgKzE0OCwxMyBAQA0KPiAgI2RlZmluZSBQQ0lFX0FUVV9UWVBFX0lPCQkweDINCj4g
ICNkZWZpbmUgUENJRV9BVFVfVFlQRV9DRkcwCQkweDQNCj4gICNkZWZpbmUgUENJRV9BVFVfVFlQ
RV9DRkcxCQkweDUNCj4gKyNkZWZpbmUgUENJRV9BVFVfVFlQRV9NU0cJCTB4MTANCj4gICNkZWZp
bmUgUENJRV9BVFVfVEQJCQlCSVQoOCkNCj4gICNkZWZpbmUgUENJRV9BVFVfRlVOQ19OVU0ocGYp
ICAgICAgICAgICAoKHBmKSA8PCAyMCkNCj4gICNkZWZpbmUgUENJRV9BVFVfUkVHSU9OX0NUUkwy
CQkweDAwNA0KPiAgI2RlZmluZSBQQ0lFX0FUVV9FTkFCTEUJCQlCSVQoMzEpDQo+ICAjZGVmaW5l
IFBDSUVfQVRVX0JBUl9NT0RFX0VOQUJMRQlCSVQoMzApDQo+ICsjZGVmaW5lIFBDSUVfQVRVX0lO
SElCSVRfUEFZTE9BRAlCSVQoMjIpDQo+ICAjZGVmaW5lIFBDSUVfQVRVX0ZVTkNfTlVNX01BVENI
X0VOICAgICAgQklUKDE5KQ0KPiAgI2RlZmluZSBQQ0lFX0FUVV9MT1dFUl9CQVNFCQkweDAwOA0K
PiAgI2RlZmluZSBQQ0lFX0FUVV9VUFBFUl9CQVNFCQkweDAwQw0KPiBAQCAtMzAzLDYgKzMwNSw4
IEBAIHN0cnVjdCBkd19wY2llX29iX2F0dV9jZmcgew0KPiAgCWludCBpbmRleDsNCj4gIAlpbnQg
dHlwZTsNCj4gIAl1OCBmdW5jX25vOw0KPiArCXU4IGNvZGU7DQo+ICsJdTggcm91dGluZzsNCj4g
IAl1NjQgY3B1X2FkZHI7DQo+ICAJdTY0IHBjaV9hZGRyOw0KPiAgCXU2NCBzaXplOw0KPiANCj4g
LS0NCj4gMi4zNC4xDQoNCg==

