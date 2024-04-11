Return-Path: <linux-pci+bounces-6121-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7218A1342
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 13:42:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 659911C216F7
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 11:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A417145B07;
	Thu, 11 Apr 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="JMBQXjme"
X-Original-To: linux-pci@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11011008.outbound.protection.outlook.com [52.101.229.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D1C26166E;
	Thu, 11 Apr 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712835736; cv=fail; b=j/aiMWXTj5WT0eiTYgJObXpoZQouiebEbiws/TXqs3y57oozxDnAn0ZhsfcDqfhosxBLnnxN78RsrbNFsOmlzjvz1fqxVyfgedMFbGmklNClAamQQ3ZoUSLycxzAkMBUzx7J+4fxmrruMLEk2tR/bc5d8oHPAoHD77hEjIgpbuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712835736; c=relaxed/simple;
	bh=+aqgKUZJDzGS1WaSCmNp0Tbh+wN3poNRsgPrC92WzLA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kphZh+XSyp90wlBuR7qNMX3q6d45ShPJvxfnLL96+MC17qdjce7lbaOj7H7PeYhw4QZyU93/Gw/loRHw2ru9LWHYctQ0kViAvC3BvcgKcsnaoe5HnQLf4PBu/pE4Mf3qnemHrvhQECbXIwvbwNHnDmnDJ4DT9IgjGAEEc6ibb94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=JMBQXjme; arc=fail smtp.client-ip=52.101.229.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVQNDhvApbskcfGz2lNBe1NsjOvPUjovJv7CqGA4QTOulYJnFZXdjROu4hHT/L0bkAFm1aNuLqJh8ITm0q9PlbyjdYuov16NQRLIOzdcdCkTGO3rOGNiLJ1+W7hadwr6Pkklx9wa02cW4HS9fDL+gxNYsJrwek+kV8WKTZAc8ccUrWs6+FNNea0z7wms0jQIq/u4uWGaRzgdSFubOh+aGWvPNOc779qPzidTGMCg/KEg+q1PfgUG2lbckS6V00Suz/UQRZSS9ZFALPUkEsYueDdC9LUddktnd7D44rCMXWK5y1pXsHfItYiAlxB/Div2T5q3vxRLQTTHUjz7gGmqsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aqgKUZJDzGS1WaSCmNp0Tbh+wN3poNRsgPrC92WzLA=;
 b=hPOFBnmSRb/AyhwU0oO7Oat4ORS9i+3PXj80K5mJgjRA+Rv6BtFAG14PhjSUa4xTFbSIwLW+UjwDBunFo1eu4usZmrIq4U+51UCDGlr8Qc6kBxR6GBlM7b++hF6Dz/7EXN3KI2FZds4Ub7o+l1ACKK8RXPFf1lZpFIO46k1r80ZAutWrwdntCiSixqIKbrgeFMMPZraIDC8atoh/yUUwOl4EZPVnwzxH1XY870T2JJD/8qxvjmdxy3anYx8JU5JesgiU/WrEs3npN64dg+WteuCM7iZd7xUNSYdVA2mLuu9truFv/MigFCe607tcsJ9OE5iJxjNFK7NA4/lwtPHWjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aqgKUZJDzGS1WaSCmNp0Tbh+wN3poNRsgPrC92WzLA=;
 b=JMBQXjmePIf7WTSvgCECpjbfuaBQYo69c2jNKXM7y8VDzi4LvExyT5qAvGCWb2uQfJ9VhoKSh6AM8lNv9uzUjH3NhoDvu9IcULTbsqRRz7NlsIIZu7igyx97n3SCiih6pciAU2nw0PpeVKeBJjdCTR3FbYlD8QLdypicd4Nw4/0=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYCPR01MB12077.jpnprd01.prod.outlook.com (2603:1096:400:439::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 11:42:10 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7409.055; Thu, 11 Apr 2024
 11:42:07 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v6 6/7] PCI: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v6 6/7] PCI: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHaiuDUYXvnpjTAcEWMkUDbcITLnLFhyb4AgAD5fYCAADBxcA==
Date: Thu, 11 Apr 2024 11:42:07 +0000
Message-ID:
 <TYCPR01MB11040C216B72458062195B0A3D8052@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-7-yoshihiro.shimoda.uh@renesas.com>
 <20240410175144.GD16629@thinkpad>
 <TYCPR01MB11040EAA36BFE3193F4F7FA56D8052@TYCPR01MB11040.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TYCPR01MB11040EAA36BFE3193F4F7FA56D8052@TYCPR01MB11040.jpnprd01.prod.outlook.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYCPR01MB12077:EE_
x-ms-office365-filtering-correlation-id: 94821fb8-a2e5-4673-2970-08dc5a1c6abd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 L+7R+Cwv/UhPjIhMqPLASk3YHBH7X5wVPCJDG0bpmaFT+voZZlZnNaAvpxymHZPMaqE6l99nFqkHyvfoXZqz7nQWF6GjWHKvh4EGlUkt+xp9J4iJeBjWAK5NUxBfhqJmz2rCFjz/Vkr47k+tcOH9CeQ0JkM8TzZY2oXhaweZY83Awus1WCWN9nsmFtT9cPrxD29rRj5wFKLGSvqc5M0wicCMj/4aLWFiKz9OYKVg0XLmIwc3p5xvC3S4Q55iBT1frLA3f4Sfo353hGta0yv/qSkkyaRaQocqWlL/uwuO+RtvfXgHLGOaEp6XR6O1xa91EYNWj7lbeHftuVCs5HxYlxNFEd/qyv4Ly63hsJkY1qGe43BeX4LgjZCVHWc2FknLPaBhHoZcf4Syb9Db7i14q6vZsFZO8kiWvzPWr/a9hAQCmjDf+IuiBEiPqAZYb8pi9Jq3UTmasNeK8t8f/RHJafWBQc2aHF8Y5dSZgYXfp/t4rllVglXYvKNCEiDkpyddoxm2AkbNmDHUPYJRKTZyAVd+9vrv8OQHWD/yQPsBKr1Zyv4C04mYtfqSE78/SJO/62PKSlS1fhhbh4ozQ+4xeZFFsJ7kUrzd1wQ3r2BxzRsICQfKZqG4A2ErE+dsyFVU1OFdLm+BKYvNHZ+pY2InHN48x8+YrPgDM+sh4UBRgYkkd19fBhDYE4/GAqyUzTNBrMUvJ9To2UnnqaZRaLfpNA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(7416005)(376005)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ejk3a1Y3dTF1RGRCb0NaR1VVYm1UeEgwZTFIY0NtWHJnb1o4TlgwNW5DcjVJ?=
 =?utf-8?B?eFFXaFlXUVRjWVFJU0ZML0ZlaG1qR3V2Sit4MWY4WWQrYjlVWUNWUUlaOGx3?=
 =?utf-8?B?dVl3SS9JS1BWd0xYWnZrdUhnQWdIQkIxZzJ0Y1ZwT2Y4K0piYzV1bWJRZXk1?=
 =?utf-8?B?N3JxeGgzdnl0NnA3V1VNbWUvUEZvTG9ab3ZxV2ZlWGlva0huTWRRNHI1RHpZ?=
 =?utf-8?B?bVhPTmpvY3ZWSnBIMHlpRlYzdDhUN1NTTElhWTVvb3NUckFkZEFvMWlLdHRv?=
 =?utf-8?B?SlVpNXlsR1pZQlE5NUxUODB2ZW11M1cxQzlPdTZtcTAwZmY0eTUxNmtHb0VX?=
 =?utf-8?B?OXZ5UjBIK2JhU1RHc3UwS3I5aDc0MDlEOSt3eUlvTWd1TVdvVklCN3Frd0No?=
 =?utf-8?B?ZjVOczN4M3V5cXoxTEV6cCtiVTFHTEg5Mk5uVFdvQlZ2MGFSbDk0aFJBOFNZ?=
 =?utf-8?B?NGNmRFFmYzJ1aXYxZHBPOURUQTh4TFF3RFJzNDRibkYvK1Uzd2I1RTRtRUJJ?=
 =?utf-8?B?eml4aS92cEk5VThucTFzbG5uWElTU1pmM3Vmc29zN1hoakNiSnpFdDlXb2pR?=
 =?utf-8?B?MlEzQW1la2ZvTmlCUVNkUGlYRTNYN3JpNHlRVXhLVWowN043K0pUZ0J0UVNT?=
 =?utf-8?B?QTRPazlxVEJacmhnUFNjampKNTFmOHdjYW1OYlpSaG5najRhS0JpQzNyMmxa?=
 =?utf-8?B?cmtYMmhVMFlVZWl4azlGSmJKalR2ajVRN2p2V1FHMW1ualBlbzVPeUJ5VFpi?=
 =?utf-8?B?cDdoQW5ySEFWQldnSTRRT2tiQTZBWlRkMmxzdWkya3RHUUpTYndIa1hTQS9u?=
 =?utf-8?B?ZEUwaEY2MmJHRzlROVFadmVKRUhQRW90TzJJVFkwd3NmaDhJVVFYaEtjVnZ1?=
 =?utf-8?B?a0R2MkFIN0NRTE1Ea2FxQy9VQWNxZCtuaE16L2trSDhFTitQWFBScGF2YmhY?=
 =?utf-8?B?YVFOYm1hQ2h0T0ZJUUtxS1E3Kys3NGJjZ1dxZFhqZ3N5eUtROFUyaVhZaXl1?=
 =?utf-8?B?TFM5bmJ6bUNoc0h1OHF4dnk3VmtDTHE5NHNNVXdtcmF0MEtac2c3OHpBNGdu?=
 =?utf-8?B?RmtUS3BpQ3RiMmhyTmc2ZUJwNXpPbGc1OGxUL3BWN2Y2bFJDUS9UbG82R3F3?=
 =?utf-8?B?VTBhK3NpTHBiZTRBcU5MazBHblZhRi9OQzk0bmMyV0RaRjJLT0g2ajJKclhQ?=
 =?utf-8?B?c3NjckFyc0wrVVJZTkU3NGpOK3NpcUNJMnB1UUwra05hcVk1cDJhbnd1bTJS?=
 =?utf-8?B?dzdlTURkZFRYQjFVQUg3UWFtNHFabXlhd3FOVENhTzN4UzNma1pkTTJVV0FW?=
 =?utf-8?B?dTNlVTBRWUc3aVNRR2M3UjlvWVUwL1Y4eGlxaHdtODNGY0xpa2p0bWs5dkk1?=
 =?utf-8?B?c3dBTmYvV2pYa3doYkI1WmpBZ29GNmkrL0lBUTEwdThMMUQ3NEtFQWJ5QW5q?=
 =?utf-8?B?Z2kwTThhL0NyOGI5WkFaY1RvcGFORFVwbm9yUWpudFZhRktCc0xyZzI3SU5M?=
 =?utf-8?B?SkhVem5lZ1UyVXVIblBySWx3aDQxQTdZRy9HaVdzME5uTFBDeXVvN3pNVTFv?=
 =?utf-8?B?U0dkY1oxMVhmQzVadWJWMDVOcDhhN2NTVXVSMUN5SHpxenNtNFRHajh5bjNs?=
 =?utf-8?B?aU9HK0k0M2NFVlVUcXkwYldWdHZEWCtvL1RCaDNQY3ZrR3BycmM3cStjUEM3?=
 =?utf-8?B?bElLUXlpQlo0ZUg2REY3L3BMcjAya0dyRURKSFB0cmh4N3RuWk9COEdNL205?=
 =?utf-8?B?VCtvcGZkZGtxN1dHa25KcGFuNER2aGt6Ym12a1VTQ0M0QTFzMWgxOGJKdXlx?=
 =?utf-8?B?OEVGNHI5dE9iTHN6YUJQbDBjWTVOamZEa2VZdmdpRG54cWM0anZKUHJWZ3Vm?=
 =?utf-8?B?RGVZbjRYSW5WZXl0QndFdUM0L21nQWFIZGlNMFlua1lEY3oxcFhRejA1ODZ4?=
 =?utf-8?B?VzdRdkdoYnZZeEJpRTFvSHVxaW9aT2hnbHFsS3RtbzdRak5OSk9wUUxDRm5L?=
 =?utf-8?B?YTBNTlVrSnNROHNrUDAycEtaWFFmc0JacDBUMm9PWWwvV3RVNVpJQWY1ZEM2?=
 =?utf-8?B?V096eHV6UWlsQjRQaFhrcGNPdDI5WlRtcitpTmpRaURMYkpNN2Rwbm9YZEdI?=
 =?utf-8?B?aVJwbjBOUzdMQTN0L1FHZ2VrbHZxRVJha3JUd1FXdWNWOWxralZJNThHSE5j?=
 =?utf-8?B?enc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 94821fb8-a2e5-4673-2970-08dc5a1c6abd
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 11:42:07.5747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BGEY9enmleQhjSVYFUcq9vH1Ey2my7rmp0933Z73u1NBnFGCXT9FLEcfI563IOK52vhM73vuvgemQCyVFRT0U54ePv/HymzeNmnCH9IkDJN5dTfpKa950JOev+ZN9J5D
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB12077

SGVsbG8gTWFuaXZhbm5hbiBhZ2FpbiwNCg0KPiBGcm9tOiBZb3NoaWhpcm8gU2hpbW9kYSwgU2Vu
dDogVGh1cnNkYXksIEFwcmlsIDExLCAyMDI0IDY6MTAgUE0NCj4gPiBGcm9tOiBNYW5pdmFubmFu
IFNhZGhhc2l2YW0sIFNlbnQ6IFRodXJzZGF5LCBBcHJpbCAxMSwgMjAyNCAyOjUyIEFNDQo+ID4g
T24gV2VkLCBBcHIgMTAsIDIwMjQgYXQgMDk6NDg6MzFBTSArMDkwMCwgWW9zaGloaXJvIFNoaW1v
ZGEgd3JvdGU6DQouLi4NCj4gPiA+ICtzdGF0aWMgdm9pZCByY2FyX2dlbjRfcGNpZV9waHlfcmVn
X3VwZGF0ZV9iaXRzKHN0cnVjdCByY2FyX2dlbjRfcGNpZSAqcmNhciwNCj4gPiA+ICsJCQkJCSAg
ICAgICB1MzIgb2Zmc2V0LCB1MzIgbWFzaywgdTMyIHZhbCkNCj4gPiA+ICt7DQo+ID4gPiArCXUz
MiB0bXA7DQo+ID4gPiArDQo+ID4gPiArCXRtcCA9IHJlYWRsKHJjYXItPnBoeV9iYXNlICsgb2Zm
c2V0KTsNCj4gPiA+ICsJdG1wICY9IH5tYXNrOw0KPiA+ID4gKwl0bXAgfD0gdmFsOw0KPiA+ID4g
Kwl3cml0ZWwodG1wLCByY2FyLT5waHlfYmFzZSArIG9mZnNldCk7DQo+ID4NCj4gPiBJZiB5b3Ug
dXNlIEZJRUxEXyogbWFjcm9zLCB0aGVuIHRoZSB2YWx1ZXMgY2FuIGJlIHBhc3NlZCBzZW5zaWJs
eSBpZS4sIGp1c3QgMA0KPiA+IGFuZCAxLg0KPiANCj4gSSBnb3QgaXQuIEknbGwgdXNlIEZJRUxE
XyogbWFjcm9zLg0KDQpXaGVuIEkgbW9kaWZpZWQgdGhlIGNvZGUgbGlrZSBiZWxvdywgYnVpbGQg
ZXJyb3IgaGFwcGVuZWQuDQpJcyB0aGUgY29kZSBiZWxvdyB5b3VyIGV4cGVjdGF0aW9uPw0KLS0t
DQogICAgICAgIHRtcCA9IHJlYWRsKHJjYXItPnBoeV9iYXNlICsgb2Zmc2V0KTsNCiAgICAgICAg
dG1wICY9IH5tYXNrOw0KICAgICAgICB0bXAgfD0gRklFTERfUFJFUChtYXNrLCB2YWwpOw0KICAg
ICAgICB3cml0ZWwodG1wLCByY2FyLT5waHlfYmFzZSArIG9mZnNldCk7DQotLS0NCmRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmM6IEluIGZ1bmN0aW9uICdyY2FyX2dl
bjRfcGNpZV9waHlfcmVnX3VwZGF0ZV9iaXRzJzoNCi4vLi9pbmNsdWRlL2xpbnV4L2NvbXBpbGVy
X3R5cGVzLmg6NDQ5OjQ1OiBlcnJvcjogY2FsbCB0byAnX19jb21waWxldGltZV9hc3NlcnRfNDA4
JyBkZWNsYXJlZCB3aXRoIGF0dHJpYnV0ZSBlcnJvcjogRklFTERfUFJFUDogbWFzayBpcyBub3Qg
Y29uc3RhbnQNCiAgNDQ5IHwgICAgICAgICBfY29tcGlsZXRpbWVfYXNzZXJ0KGNvbmRpdGlvbiwg
bXNnLCBfX2NvbXBpbGV0aW1lX2Fzc2VydF8sIF9fQ09VTlRFUl9fKQ0KICAgICAgfA0KLS0tDQoN
Ckl0IHNlZW1lZCB0aGF0IHdlIGNhbm5vdCB1c2UgYSB2YXJpYWJsZSBpbiB0aGUgZmlyc3QgYXJn
dW1lbnQgb2YgRklFTERfUFJFUCgpLg0KDQpCZXN0IHJlZ2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9k
YQ0KDQo=

