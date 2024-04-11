Return-Path: <linux-pci+bounces-6115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D74708A0AA8
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 09:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068ED1C21DF3
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 07:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CA513E8AD;
	Thu, 11 Apr 2024 07:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Juy2sfaP"
X-Original-To: linux-pci@vger.kernel.org
Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11010000.outbound.protection.outlook.com [52.101.228.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C513E881;
	Thu, 11 Apr 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712822216; cv=fail; b=KBPF78xo2k+TUoWGXY0hYkTtZOq3tF2ZwzGb7bDKyZ8UwVq8NwI543Yh3TJhJgH8eRMEJxSus3i2bh4ppMCv35wscRaPN/N2q39HZz9CT6X9Cvq7UZSuaBnrpEmuJqGVts5AiuDkBeaBlIyoeCn4xlx2OJHGmmlpPmPcFIpcqbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712822216; c=relaxed/simple;
	bh=50LA1RG6go5hzN+l8X3Qf+qWl5bZJFUBmgcgsk43IZY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ZT4nwO8cPoL32GdxYGSqT743BI7silV0WQ3WlCs+7DM94fA3FQoA/wzcPJ07pKMEnzZ0CaxrQZdfLZII444utCA5Hw3HcxhIkSMbx/aaDWWgAy84naMFRIrb0kCb1Hyq6pgA0rTPb4eFd60C3Eyphc9syYX6Vl3wI8ihcBgRvyU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Juy2sfaP; arc=fail smtp.client-ip=52.101.228.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mW4upQsYupfZ2NwWOoLlBnIp4J/xoy946L83UP5emrk7HpL/TpVDON04K1uoRA7GzwF7OzfMi056CQgK4hR8d/5ysLegdjKUhFb2+P3zC4Uo6iI+qkWEZVbtPcutEjXXNvZkDPY1TF3zd7TVYZzyz5GtxGSK5QR6lTUnRkucdHx+isekmFqhkSWqNjKK/Is9+FcptpWDzjIzyxoHUZsueqkiMhmTwHQLU9pxMEiSiz2W52/AMLnpt9d7Kvdjv221TrtMEQF3yRRr6WBh8gfy+/oXmvAachIbBOj/6A7Ha553t0Lv6PT1s2qfqa6pRB71Jgy+QDMmn15IOALAEg2zyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=50LA1RG6go5hzN+l8X3Qf+qWl5bZJFUBmgcgsk43IZY=;
 b=C4KNSW10jTIft59khp3jZPETsYmjq872NVh1GyEUpH4DkJuogUKT9wt243Eje2505MWedzYErZu6Z2wsxx5xGTYZHgUTEhwvFhJ5t0VmcPZSFmYm2qCCQgtttuiey9mW2GNtaxZ/WD/NgzExTUEHfBxC78xUgGs0VVzSjlS/16SBDAOC913sOR0Nx1zjAokx+0i07xxWZrDytSDLeEl76prKLQUR7B4xfTSfRdAYztm9to35eVHJMr/PLxtNnT0hwjWxdHka1fdq/xm3GYXqEwXqIq3FjVsxPUeG2U1x65LDB1k0uR996UKzyHEMHf2ZlyxbgOWb1is1mfRCd/FJgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=50LA1RG6go5hzN+l8X3Qf+qWl5bZJFUBmgcgsk43IZY=;
 b=Juy2sfaPVEiVFPHTlbcCGRsbEgvf/2AQWGqQ6t9bEbML3/YmcR5OhyT5JMtnxBDOYgvhrw8Qy5axueY0sGCK5xvIQOp6WyJyEJRbe1LRRBcJyU2zi04z5tG0GQTF2jx6zE85NfQT3ZbIj9Km3hfEHEF+3D4fAHuXuscwpvIm8y4=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by TYWPR01MB9663.jpnprd01.prod.outlook.com (2603:1096:400:225::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 07:56:49 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::11c0:4ed:1ee4:d774%5]) with mapi id 15.20.7409.053; Thu, 11 Apr 2024
 07:56:48 +0000
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
Subject: RE: [PATCH v6 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_platdata
Thread-Topic: [PATCH v6 4/7] PCI: rcar-gen4: Add rcar_gen4_pcie_platdata
Thread-Index: AQHaiuDTnvNoCBYE20K4Tt9Cjlj2CbFhwBmAgAD0wIA=
Date: Thu, 11 Apr 2024 07:56:48 +0000
Message-ID:
 <TYCPR01MB110406E27B8FE0B05F0E2EC7ED8052@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-5-yoshihiro.shimoda.uh@renesas.com>
 <20240410171713.GB16629@thinkpad>
In-Reply-To: <20240410171713.GB16629@thinkpad>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|TYWPR01MB9663:EE_
x-ms-office365-filtering-correlation-id: cefdd4a8-13b5-455d-f776-08dc59fcf0ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 dZSD4PkBNUF2a1X/DycEKtuskbmsjcwrc9K4LtmESG6hzk5iPosHq7gQfC/tpdUw1QeNTQhWQeYFQCdeZV9+h4MRUG08VXnkBtcOpRXmpSnedHOvdk4KhDHZ1UD+Wvd233G6OOqWuvVQGrZdMCCoBiMARO1BRtDCOf1BTpZ6XiVXse5SBDyH9Y0rkqZya3pdECbU5O80PNJIIViSPTp+Cim4GdYdcNmYi47GiahCtd4behguc8m9p4PWm+biFrTwd4NwM50vmXAcShnztyOO0VQnyVCNoPzEhGvTnPWfgiZcBW9/J6vd5IYaZ7TvwtmSuss/k4lLlrD+uZsH0WUKds3pj7p4RMYF9npIKlduilMj3FtlSZJJ3JNyQaUBSDBTojlL8PFALIX4Tf/58A04zPGnEtAlrGP3EGmdE2gw7TUAA/javwhbcMXEuTprQ87H/DAj+b7KvYAnCEw5nGLGG7dyvgGorYPIWaV2GcXwygoYX69MAwWKGdv/5iJ5HwoNFG7LD3fYUpf5u53SBIAObAtd+21z+Ooezwngg9PtXtsQqB5G3iCzHW2SAs5GEvGAqrVZ3mzQeU1YaUWQyhepFUBi6k0Hv+9SGtJA6+TU22hrlColHHHKRebr7LY8n9hVI5gulV1mpqSsiGaHldJuFu7Rhx5kQX1FkH4Sd2J8blslXAPTsyiMn4V9GoFkrijVwz8qFbZDYTHf2DXUYupnldrBYwr2Ll0CXP/TW06xKN0=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(7416005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZkVTalVHNkJOdTlRc2oxOUJGUUtVWnpzdnpzVHN5NzhSN2xNVXdjcVNQeHY1?=
 =?utf-8?B?TmtNcHdiZWxPbEJBcFY1MmZ5Y2NuL0VvNlkvNFd5VE5lcUdOU3ZHa0VPOHlq?=
 =?utf-8?B?NStNaXF2STY4OVI0eDVCK0k3T0d0bi8yK3gyYkdMRzJpUUFBLy9qSENXZ3d2?=
 =?utf-8?B?NjlsMzRqUHNMQktmREJlT3JFcS84M3lRV3N6MTF2Z3FSZGVrUm1DQ0F5aUpW?=
 =?utf-8?B?Nlh1dWQxSjJROUZ0RFA4KzJCQ2FmNEUwME9rZzZKMnVFdVluMWExTnFqNGNR?=
 =?utf-8?B?djk1QW1PMW85WXRic0ROb1JTdkxhcy9Kc0ladFE4cml0K240bVZTYjVlRFBN?=
 =?utf-8?B?eWZzTFJlWkd1bTZveHlzMDJSVkliNFlrSVQ3VVE0OEk1SFBIWXdxU0pGaU9j?=
 =?utf-8?B?MnFxWTZiWjJQUS9mQ0ljRytGbkdXOUJraGNKbld6cWszeHNZSy9pV0hUdXQ4?=
 =?utf-8?B?RkI1NUtrR01WaCt1Kzg2MUpYdyszVHlJSkdDY3NxcWJRWTlNdG5PeWdTclB0?=
 =?utf-8?B?RFM2b25YRWpOMjFVY1BZUTdzYzlxU1dLVllQQ0Ntd3ZRRUN3YjR0UktYNHJO?=
 =?utf-8?B?YUlqdisxVlBrUVIxVHQwSTVQWnBXVlYrd01nREtrcEdIdHhnbVRkNmMxR3ZT?=
 =?utf-8?B?M3U0QnRNbjkvMTJHNDhLa0ZmNXhDK1prV2cxaHg5UGQwZiswdEQ2VFNlYnRi?=
 =?utf-8?B?ZU9TWEc0b1hkNjd6aFMvMmZaVmF3UnFveDIrN2tHUXFuckhXbGNQR0ZvMnZ4?=
 =?utf-8?B?R1pualM2M2lDbWZkdTlZME1DNlA5TGFTa09NbTI0QnlEcFJjUXpXYTdyczgv?=
 =?utf-8?B?eldWOVRYTHlycmozSklTWUZNTG1QM3Iyajhna1BMZUNzYTRRWjM1S2xNTkwv?=
 =?utf-8?B?MlpuMFM3WjQreTJOQS9oQTliNUxxOU9ocGxOdVQzdlFHOTMvVlNDeHpibHNM?=
 =?utf-8?B?Zk9Bb25od2NzcjV2YlFUOXdpZ3VpTGZjNVRVeHdOcTQ4b3VKNDNPeUxmdGds?=
 =?utf-8?B?ek9EcjZrTitBeDAwL2hVVUkxU3I3VTA3YzBrUEFGT2N3Mm1Za1JQSFRXRVky?=
 =?utf-8?B?LzBVVjArTlVLWCtNRmo3aTFreUNoMENIbzNyMXZjMjMreDNhamNTRzJvMW11?=
 =?utf-8?B?TjhrbHhTMUFORHJhK0Q2RVIyUlFISkNCTXo1YktjSDZpYndWN1NnYkNyMEJo?=
 =?utf-8?B?dndQL2JrYXRsdDI3ZTZVTTRYazdicThMNWpWNSt4Y0Y5bk9nTVEySmV4QWpV?=
 =?utf-8?B?Y1NwRlB1dk5qclgwZitaL2RDcDUvNU9Kd2JROUI5QkVqU0VMamdIQzFQTTF3?=
 =?utf-8?B?eHpTRXl6T2RTWHAvcHhlaEpZanY3NWFFUVF4MjJwOTcwcFZJNkVsaTNwSzVD?=
 =?utf-8?B?SUlHb2pMMlI0Z0Z4TlVFbVpId0ppMGtTMUFRbUc1NEJNZlpMTitOS3Z3cVFy?=
 =?utf-8?B?Szl5dlZvMDB0L3FHUm4yV1YyY0t2MDgzRm84YTFDV3lhbkljd2RVTlE0ZXd3?=
 =?utf-8?B?NWkzekJranZ6TU12a3NaUE80MnVMVjIrMSszNjZ3dUt3aWg1VU43NmxIcVRQ?=
 =?utf-8?B?U3p2NFhzYVV6SXVyVGNla25KYlZvcnNiazFzL3NZSWZVTW9YTlkzdU9YOG5O?=
 =?utf-8?B?d2g3UU5TSlRENW1yTERlbkEzZHlxOG1GR3hzYjlXZWIydkJvWGtSSktyeDcv?=
 =?utf-8?B?a1U0cXFOUTIzNFI3S29BQlNLdEVBQStPZ2UvTFpGdVFWTFQxSGRaampYYWhm?=
 =?utf-8?B?bE0zZFZIT3NzTGFNU2g2cU4yRXBDZkNnbEVseWdndHhzOXhBZll4UWF0WTZZ?=
 =?utf-8?B?ZlhMaklMb1ljTHFUUVREbUJKa2M3TVVqV0FwYVJ3QTYvVVB6RVpadUNnSzRs?=
 =?utf-8?B?U1pJZlN3U09rRXJEb1FhRWE0bVNZMXRacnVXa2lIRVRQSHBSenhpWmwyekts?=
 =?utf-8?B?THhzdDlPTVRiTlM0QURBRW9vT0RRNzFrU2VialZNczZsQkwxLzB0Zkx5TTRW?=
 =?utf-8?B?bDRoQkU3OU9iY091dG5IdkgwQUx1TlkveEZjRzFhWkZJZEdlS2xrVFNsM3Ja?=
 =?utf-8?B?TUFrZkJlVUF5Y095dGRYcjErRS9ibXE5VVhXUWJFMzZiQTVvN0FYZ3pEQkVM?=
 =?utf-8?B?QzAwUllRRnR2d2E2N0JsL05zZ3JBVkdueG05bVFqVm5pcHhGVFVNUFp2ZXZO?=
 =?utf-8?B?SjFzYjJNZEdqQ01LTk1iS2FJM1daU2VZNUk4QUhmd0VaeExrR1hJNkpPbjha?=
 =?utf-8?B?cklWWWxzOXBPWUtBbWtkYWVSSHlnPT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cefdd4a8-13b5-455d-f776-08dc59fcf0ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Apr 2024 07:56:48.8133
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /tJWnDXVoOLgSx/Nw33pzqBSkGH1lQOSXrsb4EPkK1V7IEKMa6jltPdTUP6OJSffdf8ZyRgipIC34Vi8puVCBh3RoqBtsFXhZ7HEMJxposrUEDsVKYXG68BUI47+zK+x
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9663

SGVsbG8gTWFuaXZhbm5hbiwNCg0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2YW0sIFNlbnQ6
IFRodXJzZGF5LCBBcHJpbCAxMSwgMjAyNCAyOjE3IEFNDQo+IA0KPiBPbiBXZWQsIEFwciAxMCwg
MjAyNCBhdCAwOTo0ODoyOUFNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3cm90ZToNCj4gPiBU
aGlzIGRyaXZlciBzdXBwb3J0cyByOGE3NzlmMCBub3cuIEluIHRoZSBmdXR1cmUsIGFkZCBzdXBw
b3J0IGZvcg0KPiA+IHI4YTc3OWcwIGFuZCByOGE3NzloMC4gVG8gc3VwcG9ydCB0aGVzZSBuZXcg
U29DcywgbmVlZCBvdGhlcg0KPiA+IGluaXRpYWxpemluZyBzZXR0aW5ncy4gU28sIGF0IGZpcnN0
LCBhZGQgcmNhcl9nZW40X3BjaWVfcGxhdGRhdGENCj4gPiBhbmQgaGF2ZSBhIG1lbWJlciB3aXRo
IG1vZGUuIE5vIGJlaGF2aW9yIGNoYW5nZXMuDQo+ID4NCj4gDQo+IEhvdyBhYm91dCwNCj4gDQo+
ICJJbiBvcmRlciB0byBzdXBwb3J0IGZ1dHVyZSBTb0NzIHN1Y2ggYXMgcjhhNzc5ZzAgYW5kIHI4
YTc3OWgwIHRoYXQgcmVxdWlyZQ0KPiBkaWZmZXJlbnQgaW5pdGlhbGl6YXRpb24gc2V0dGluZ3Ms
IGxldCdzIGludHJvZHVjZSBTb0Mgc3BlY2lmaWMgZHJpdmVyIGRhdGEgd2l0aA0KPiB0aGUgaW5p
dGlhbCBtZW1iZXIgYmVpbmcgdGhlIGRldmljZSBtb2RlLiBObyBmdW5jdGlvbmFsIGNoYW5nZS4i
DQoNClRoYW5rIHlvdSBmb3IgdGhlIHN1Z2dlc3Rpb24uIEknbGwgcmVwbGFjZSB0aGUgZGVzY3Jp
cHRpb24uDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBZb3NoaWhpcm8gU2hpbW9kYSA8eW9zaGloaXJv
LnNoaW1vZGEudWhAcmVuZXNhcy5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMgfCAzMCArKysrKysrKysrKysrKy0tLS0tLS0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pDQo+ID4N
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdl
bjQuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMNCj4gPiBp
bmRleCAwYmU3NjBlZDQyMGIuLmRhMjgyMWQ2ZWZjZSAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLXJjYXItZ2VuNC5jDQo+ID4gKysrIGIvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuYw0KPiA+IEBAIC00OCwxMSArNDgsMTUg
QEANCj4gPiAgI2RlZmluZSBSQ0FSX0dFTjRfUENJRV9FUF9GVU5DX0RCSV9PRkZTRVQJMHgxMDAw
DQo+ID4gICNkZWZpbmUgUkNBUl9HRU40X1BDSUVfRVBfRlVOQ19EQkkyX09GRlNFVAkweDgwMA0K
PiA+DQo+ID4gK3N0cnVjdCByY2FyX2dlbjRfcGNpZV9wbGF0ZGF0YSB7DQo+IA0KPiBDb21tb24g
bmFtaW5nIGNvbnZlbnRpb24gaXMgJ2RydmRhdGEnLg0KDQpJIGdvdCBpdC4gSSdsbCByZW5hbWUg
aXQuDQoNCj4gPiArCWVudW0gZHdfcGNpZV9kZXZpY2VfbW9kZSBtb2RlOw0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiAgc3RydWN0IHJjYXJfZ2VuNF9wY2llIHsNCj4gPiAgCXN0cnVjdCBkd19wY2llIGR3
Ow0KPiA+ICAJdm9pZCBfX2lvbWVtICpiYXNlOw0KPiA+ICAJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldjsNCj4gPiAtCWVudW0gZHdfcGNpZV9kZXZpY2VfbW9kZSBtb2RlOw0KPiA+ICsJY29u
c3Qgc3RydWN0IHJjYXJfZ2VuNF9wY2llX3BsYXRkYXRhICpwbGF0ZGF0YTsNCj4gPiAgfTsNCj4g
PiAgI2RlZmluZSB0b19yY2FyX2dlbjRfcGNpZShfZHcpCWNvbnRhaW5lcl9vZihfZHcsIHN0cnVj
dCByY2FyX2dlbjRfcGNpZSwgZHcpDQo+ID4NCj4gPiBAQCAtMTM3LDcgKzE0MSw3IEBAIHN0YXRp
YyBpbnQgcmNhcl9nZW40X3BjaWVfc3RhcnRfbGluayhzdHJ1Y3QgZHdfcGNpZSAqZHcpDQo+ID4g
IAkgKiBTaW5jZSBkd19wY2llX3NldHVwX3JjKCkgc2V0cyBpdCBvbmNlLCBQQ0llIEdlbjIgd2ls
bCBiZSB0cmFpbmVkLg0KPiA+ICAJICogU28sIHRoaXMgbmVlZHMgcmVtYWluaW5nIHRpbWVzIGZv
ciB1cCB0byBQQ0llIEdlbjQgaWYgUkMgbW9kZS4NCj4gPiAgCSAqLw0KPiA+IC0JaWYgKGNoYW5n
ZXMgJiYgcmNhci0+bW9kZSA9PSBEV19QQ0lFX1JDX1RZUEUpDQo+ID4gKwlpZiAoY2hhbmdlcyAm
JiByY2FyLT5wbGF0ZGF0YS0+bW9kZSA9PSBEV19QQ0lFX1JDX1RZUEUpDQo+IA0KPiBJJ2QgcmVj
b21tZW5kIGNoZWNraW5nIGZvciB0aGUgZXhpc3RlbmNlIG9mIHRoZSBkcnZkYXRhIGZpcnN0LiBC
dXQgaWYgeW91IGFyZQ0KPiBzdXJlIHRoYXQgaXQgd2lsbCBiZSBwcmVzZW50IGZvciBhbGwgU29D
cywgdGhlbiBpdCBjYW4gYmUgbGVmdC4NCg0KU2luY2UgaXQgd2lsbCBiZSBwcmVzZW50IGZvciBh
bGwgU29DLCBJIHdpbGwgbm90IGNoYW5nZSB0aGUgY29kZS4NCg0KQmVzdCByZWdhcmRzLA0KWW9z
aGloaXJvIFNoaW1vZGENCg0KPiAtIE1hbmkNCj4gDQo+ID4gIAkJY2hhbmdlcy0tOw0KPiA+DQo+
ID4gIAlmb3IgKGkgPSAwOyBpIDwgY2hhbmdlczsgaSsrKSB7DQo+ID4gQEAgLTE3Miw5ICsxNzYs
OSBAQCBzdGF0aWMgaW50IHJjYXJfZ2VuNF9wY2llX2NvbW1vbl9pbml0KHN0cnVjdCByY2FyX2dl
bjRfcGNpZSAqcmNhcikNCj4gPiAgCQlyZXNldF9jb250cm9sX2Fzc2VydChkdy0+Y29yZV9yc3Rz
W0RXX1BDSUVfUFdSX1JTVF0ucnN0Yyk7DQo+ID4NCj4gPiAgCXZhbCA9IHJlYWRsKHJjYXItPmJh
c2UgKyBQQ0lFTVNSMCk7DQo+ID4gLQlpZiAocmNhci0+bW9kZSA9PSBEV19QQ0lFX1JDX1RZUEUp
IHsNCj4gPiArCWlmIChyY2FyLT5wbGF0ZGF0YS0+bW9kZSA9PSBEV19QQ0lFX1JDX1RZUEUpIHsN
Cj4gPiAgCQl2YWwgfD0gREVWSUNFX1RZUEVfUkM7DQo+ID4gLQl9IGVsc2UgaWYgKHJjYXItPm1v
ZGUgPT0gRFdfUENJRV9FUF9UWVBFKSB7DQo+ID4gKwl9IGVsc2UgaWYgKHJjYXItPnBsYXRkYXRh
LT5tb2RlID09IERXX1BDSUVfRVBfVFlQRSkgew0KPiA+ICAJCXZhbCB8PSBERVZJQ0VfVFlQRV9F
UDsNCj4gPiAgCX0gZWxzZSB7DQo+ID4gIAkJcmV0ID0gLUVJTlZBTDsNCj4gPiBAQCAtNDM3LDkg
KzQ0MSw5IEBAIHN0YXRpYyB2b2lkIHJjYXJfZ2VuNF9yZW1vdmVfZHdfcGNpZV9lcChzdHJ1Y3Qg
cmNhcl9nZW40X3BjaWUgKnJjYXIpDQo+ID4gIC8qIENvbW1vbiAqLw0KPiA+ICBzdGF0aWMgaW50
IHJjYXJfZ2VuNF9hZGRfZHdfcGNpZShzdHJ1Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIpDQo+ID4g
IHsNCj4gPiAtCXJjYXItPm1vZGUgPSAodWludHB0cl90KW9mX2RldmljZV9nZXRfbWF0Y2hfZGF0
YSgmcmNhci0+cGRldi0+ZGV2KTsNCj4gPiArCXJjYXItPnBsYXRkYXRhID0gb2ZfZGV2aWNlX2dl
dF9tYXRjaF9kYXRhKCZyY2FyLT5wZGV2LT5kZXYpOw0KPiA+DQo+ID4gLQlzd2l0Y2ggKHJjYXIt
Pm1vZGUpIHsNCj4gPiArCXN3aXRjaCAocmNhci0+cGxhdGRhdGEtPm1vZGUpIHsNCj4gPiAgCWNh
c2UgRFdfUENJRV9SQ19UWVBFOg0KPiA+ICAJCXJldHVybiByY2FyX2dlbjRfYWRkX2R3X3BjaWVf
cnAocmNhcik7DQo+ID4gIAljYXNlIERXX1BDSUVfRVBfVFlQRToNCj4gPiBAQCAtNDgwLDcgKzQ4
NCw3IEBAIHN0YXRpYyBpbnQgcmNhcl9nZW40X3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldikNCj4gPg0KPiA+ICBzdGF0aWMgdm9pZCByY2FyX2dlbjRfcmVtb3ZlX2R3X3Bj
aWUoc3RydWN0IHJjYXJfZ2VuNF9wY2llICpyY2FyKQ0KPiA+ICB7DQo+ID4gLQlzd2l0Y2ggKHJj
YXItPm1vZGUpIHsNCj4gPiArCXN3aXRjaCAocmNhci0+cGxhdGRhdGEtPm1vZGUpIHsNCj4gPiAg
CWNhc2UgRFdfUENJRV9SQ19UWVBFOg0KPiA+ICAJCXJjYXJfZ2VuNF9yZW1vdmVfZHdfcGNpZV9y
cChyY2FyKTsNCj4gPiAgCQlicmVhazsNCj4gPiBAQCAtNTAwLDE0ICs1MDQsMjIgQEAgc3RhdGlj
IHZvaWQgcmNhcl9nZW40X3BjaWVfcmVtb3ZlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYp
DQo+ID4gIAlyY2FyX2dlbjRfcGNpZV91bnByZXBhcmUocmNhcik7DQo+ID4gIH0NCj4gPg0KPiA+
ICtzdGF0aWMgc3RydWN0IHJjYXJfZ2VuNF9wY2llX3BsYXRkYXRhIHBsYXRkYXRhX3JjYXJfZ2Vu
NF9wY2llID0gew0KPiA+ICsJLm1vZGUgPSBEV19QQ0lFX1JDX1RZUEUsDQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3RydWN0IHJjYXJfZ2VuNF9wY2llX3BsYXRkYXRhIHBsYXRkYXRhX3Jj
YXJfZ2VuNF9wY2llX2VwID0gew0KPiA+ICsJLm1vZGUgPSBEV19QQ0lFX0VQX1RZUEUsDQo+ID4g
K307DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCByY2FyX2dl
bjRfcGNpZV9vZl9tYXRjaFtdID0gew0KPiA+ICAJew0KPiA+ICAJCS5jb21wYXRpYmxlID0gInJl
bmVzYXMscmNhci1nZW40LXBjaWUiLA0KPiA+IC0JCS5kYXRhID0gKHZvaWQgKilEV19QQ0lFX1JD
X1RZUEUsDQo+ID4gKwkJLmRhdGEgPSAmcGxhdGRhdGFfcmNhcl9nZW40X3BjaWUsDQo+ID4gIAl9
LA0KPiA+ICAJew0KPiA+ICAJCS5jb21wYXRpYmxlID0gInJlbmVzYXMscmNhci1nZW40LXBjaWUt
ZXAiLA0KPiA+IC0JCS5kYXRhID0gKHZvaWQgKilEV19QQ0lFX0VQX1RZUEUsDQo+ID4gKwkJLmRh
dGEgPSAmcGxhdGRhdGFfcmNhcl9nZW40X3BjaWVfZXAsDQo+ID4gIAl9LA0KPiA+ICAJe30sDQo+
ID4gIH07DQo+ID4gLS0NCj4gPiAyLjI1LjENCj4gPg0KPiA+DQo+IA0KPiAtLQ0KPiDgrq7grqPg
rr/grrXgrqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+NDQo=

