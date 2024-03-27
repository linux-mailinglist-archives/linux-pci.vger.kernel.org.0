Return-Path: <linux-pci+bounces-5232-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D488D929
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 09:30:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12C611F2C08D
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 08:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B5364CD;
	Wed, 27 Mar 2024 08:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Qe0P6F2s"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2042.outbound.protection.outlook.com [40.107.114.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D4E36132;
	Wed, 27 Mar 2024 08:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711528216; cv=fail; b=NB16HzdHGr3kEWjMFD5joxCmZkhd1Ydm/U0D+RFJ2RmDmJOasYtyxCKca7+hLan3yXZwW++Sp9qSP5kCOkmaaIRJGIo2XslAqr3JafxpuOTCXf/wOFuxQVLkwtPUcZ0FojvZpyThDxlvFdEkSPOa3USIDcNQyVYMS00x5j3SE/I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711528216; c=relaxed/simple;
	bh=Me0Hui43uNE061YaL40py46E1gubo0fwv35PN5cbIf0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WYtzun6nPe31l7Yrw9RQkxQZalgvsE0z3aGN4742SQZekugVrsmZIlUvNGZmlgWVVrbYoVcpxkJE9jzn56Jq8obe2UiQ1ahDH6XOjXTxsdw7CZO9SF34RZy8nj4cJMf8u48ssIwh+rWhMpvNx1FuO9pTmxykC0KMXy7G2HQn7M8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Qe0P6F2s; arc=fail smtp.client-ip=40.107.114.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyDUfVR752pUOzv921h7pI+jyqCQYJ7haMrSU4w3KeVJMfUEMGXYLim7J06BXLxHfOhbM5FMKuEHJl/3nMWwkJ1fcTUuaCKXkKu2TcV74GvoWimaO8/v83Me5BBLMbou+ryI5dXgP/6qI4XAWHmvwcjlbMATRfShlzAmwjqYcVY9zw9bKnn2qt3DXLu4hW1Yj6/Af4vDy4rBT4eSprRfYgXOhtMW+4dVoGIEQ7+FetevaYNUlupMu1ILWuuDXVZJAIM3tAS1e+tZ7rBBdVMEagpVoUleF1k2akoezS1SVdhN45Vcg3NJZXvqPtMVT4lUbwFo1Umv4YADO8S/o009GA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Me0Hui43uNE061YaL40py46E1gubo0fwv35PN5cbIf0=;
 b=aaFwG280oyh+W9eB4T8wuKSd7QvjNulsWfTsdTOWKcp/edcjsCa56WTGYb2LQ/gY1EDXOwGj1SrN8V6KtbktSsD/mmD5LA2sdFqbVUZpKbiuh3Px3RkWJcS3WYAzdSlJJXfRZplqPYOXj65EJemmva6vlfbtMcNzcPaCMYeZ3KKJpRoBlKjawotAR1z2gKC4m/Y/nZXGoVbssHYsCctjcf1G5REqF9rqxl3uCS2hgCS6RFQv2O/svn7oKhH2golJAeR2kGxf+m0X9mgFHTac0EC/jJTWODaXbFdven2jmUdDT+Sy1AsaE22nMWdJwF8t6g13l94GlMu1XNkhUue0eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Me0Hui43uNE061YaL40py46E1gubo0fwv35PN5cbIf0=;
 b=Qe0P6F2sArS94hxv6nYnMF3wO3c67UNdS7ao8yOWYQflEOe3dAxhs2bc5BkbN55tanu1apqPZNBM5YVyyR0eYj5Gau2Z8/e3kBW420w5cHNbySFiPeI2hn/SajZ1WQOAv0pfqleTKxG8xOrKevxVpoIsRHKTDW3FOjsnbyrxgLQ=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS3PR01MB5863.jpnprd01.prod.outlook.com (2603:1096:604:c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Wed, 27 Mar
 2024 08:30:09 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Wed, 27 Mar 2024
 08:30:09 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: Frank Li <Frank.li@nxp.com>, "lpieralisi@kernel.org"
	<lpieralisi@kernel.org>, "kw@linux.com" <kw@linux.com>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "jingoohan1@gmail.com"
	<jingoohan1@gmail.com>, "gustavo.pimentel@synopsys.com"
	<gustavo.pimentel@synopsys.com>, "mani@kernel.org" <mani@kernel.org>,
	"marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: RE: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Thread-Topic: [PATCH v2 6/6] misc: pci_endpoint_test: Add Device ID for R-Car
 V4H PCIe controller
Thread-Index: AQHafye97ZlAwgf9kU+dZUE2YnHEwrFJWvUAgAAmxiCAAby2AIAABCTg
Date: Wed, 27 Mar 2024 08:30:08 +0000
Message-ID:
 <TYCPR01MB110401FFFF9BC2B25DA3F9E8CD8342@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240326024540.2336155-1-yoshihiro.shimoda.uh@renesas.com>
 <20240326024540.2336155-7-yoshihiro.shimoda.uh@renesas.com>
 <ZgI/IGe2L0rJ8SSF@lizhi-Precision-Tower-5810>
 <TYCPR01MB1104072DA4D6B3DF120A10D0AD8352@TYCPR01MB11040.jpnprd01.prod.outlook.com>
 <CAMuHMdU+5=r5Wa9cy0XDRnygumjMsC6mH0Tg-OVgbBkQjk1+0g@mail.gmail.com>
In-Reply-To:
 <CAMuHMdU+5=r5Wa9cy0XDRnygumjMsC6mH0Tg-OVgbBkQjk1+0g@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS3PR01MB5863:EE_
x-ms-office365-filtering-correlation-id: 58877e32-814a-4050-f101-08dc4e381ce9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 XwIRFP9seVSUnvrweMZ+ZWjF5wJSMlvLNzFaTmsNE6eOcVfqBkgD4MqQuqQ1+cG6esNPunBrYNkHye0hTZwSC3ItXl8aN8FXAUdBHkr5IMmx3e4Nu5qU7mYJc2qyKaUgReu3xU+9XVsI/oz5Nxt9Ja0c09wwy288hQrLlRyxLQGdHvfCGWquQ6HsK4nYj/ocqiRr3P9Tcg3d2AvMph2xCZKqA0+1TNAqTZsT9lPLqF/yMhWAI40UnwQ4RL0szoPBqzNCveEF4O+wV7Wfpvdq9wq/Dv22npozsjG81pmHpoCUbW3aT7ciGneV0XcFV35HIdLBRejBMNW0fLDvj3f1CtbcPXxo0sP5nposB/iDPM8lPl3Oj7x1z4RI/iVGajsTI6b/KeiU49kTK0pkOBYwPBWCZWmMUyYL9QsG/ShGJk2Pw4XN4Z4zyqe949mJvM7v/pJu/27INeeU5AQccIGXzUOybd3jMRerj8+N/T/zvoQWUO28KRF7ll9Tm478zZL8xbvz25Iz1veL28gE7fO8XKBxwPYZZBRWMT+UvGCFR1t1lNU9rLtWp4xuM3lwaVwo2S0U8Zh+ZUFAe2e9rSldtkeVgdFiZUKWrOd9B7bEgkwZC/fzKyGpsEkTWM0cAyekfHbOJ2oFZ1KAm1Pi7/esZbD3+cYwO9vXwO6TMY/G60c=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N240Y1RCZXl6d1preWpCK2I2QTgwV3hROVlJU1BVVXdNL21PYlBTV2M4QzNE?=
 =?utf-8?B?emY4Wm0wRWFMVHlGQ1BOSFhqWlM5WVNZemQreXlacHQwNFRSOG5ZT0Z3VHlw?=
 =?utf-8?B?TElsTHlCZ1UydFJRSmw2ODhjNXNWYjAyYkRpazNUZy92WHIreTZlNU9yWlZO?=
 =?utf-8?B?YzRPT216NVp4d2JQN0xsdUljRnhuUy82VzZrQTkyRGc1dGMvaTRKZ0doa3VK?=
 =?utf-8?B?Q09aRVBYN01pRnFOV1BIaE5HenRhSUZXaW1yMGlQS1dHSHBXNFRYc3QycU5P?=
 =?utf-8?B?cHQrU3dYN1kxVXA0RjM2TEZNTHhBNXk3TU5jaVFLc29zTWt2RGMzdXhUTjFF?=
 =?utf-8?B?ZjMwSlgzYVFTWHdxSExLc05rSlo1aFk2MEhEWXNseTdmcXVWS25KNzRkQkpk?=
 =?utf-8?B?ZTIrZVRRdStMYXBPRUE1ZlNKU3YyVGZmVTN1MmdSaXE2UTY5Q3lUdkd6K1JP?=
 =?utf-8?B?TitheE9lSWY1enFUM3FGQVEyUmJ1amhUcGlMejgzRC9xaU1JK0hVN1FtekRF?=
 =?utf-8?B?eXpkUFMxTWVZL2cxWWZyMWszMzVQdHJwOUF6YmdoUzNxTG5FeHZnalZ2SlVy?=
 =?utf-8?B?Y0lMV0djemp5VnF1QnQrdng1UjFCMHNWTnZPd1c4eWJaSThhMEVFazJBLzND?=
 =?utf-8?B?QWdrMTZ1YTY5TzdIOFh1YUF0TGd5NHpibXVDQVc3OXpoN0ZIQlRkNTRwTjR4?=
 =?utf-8?B?TTV1TmF3VWR4S0lzbzdzNXpxVmh0ZFQ2TDczMUI3NzZic2ZLdzdSSkN2VHBs?=
 =?utf-8?B?ei9nTkpONXcrMWhoZG5NN3R3VVZaVDdhWDdDYVpMTW0wc2FNUDgyM281N3BI?=
 =?utf-8?B?SjU5c3lZaTRwelY3elcrQTJKZGdOenZJZzQ1TTBTdUo1RWdlRktjY3ZEUmUr?=
 =?utf-8?B?MkxZS2hoaXFTRDFZdk5FTjF0c1U0YzBYYkZDcFhkUVNyaVVFWHNYUHRrRWhK?=
 =?utf-8?B?a00xdldpNkJZQnVmMVkvNHNXeEIrN1I5TG9VSWFnbGl6ZlBlcnFWeEFkYnQ4?=
 =?utf-8?B?bnBLYkpsS3luTTUrVmU5VGFHSWp1MW1DUmlNMDZ4MjhudFgyQjlHdmt6a3lt?=
 =?utf-8?B?UExISEs4ODFVVm1XSzdCUEJnRFZ0ZTlVa3Y0MVBQSXJ0ZmU0ZUlPWDNWUE9m?=
 =?utf-8?B?R09xRUMvaGtvc3Q3WVhPajZqSGxiVWNDSmdScTNFQSs2YjNvdHh2N1pUdG5N?=
 =?utf-8?B?eFpHczcyblAyMmF0ekNUdVlHL2pVQ1p4ZzJpMlREdXBCK0MwRTluK0wvaWMr?=
 =?utf-8?B?M2lUVG51QVZJcldDK3lNYnRRQU1UOUVyeUJ0MVJrWmc3TVV2K3RMTDFScjdz?=
 =?utf-8?B?NitDNnExdkMrVmhXYUN4WFJnbWpTUTB0QUliZ0V3VDBBMXNXSTljamZOUXNj?=
 =?utf-8?B?bWdkK2dxVmU0eWk5bGhRUE9uQThqVTNpaCtuTzBveDUxa2NhdUdLVmkwSnRU?=
 =?utf-8?B?aHdyeWlBQUVmcEFFNFJ5K1pxY2dXZVZadXRlOXZKeFp0TTdtZ1lSa2c3alVD?=
 =?utf-8?B?eStmNUt6WGZDUU84UE5oQys5Mkl6dTBJcUVCMXdEYVFDRis0NXRXMmJwWmxp?=
 =?utf-8?B?M2xLZ1daa1lxQWRsSmN3dUI3SXdlcDUva2JPdjlGVWRpQTg5Umw1czBMQ282?=
 =?utf-8?B?M3pWbERRamtkaG4xWlRDcWFpTG1ocVA3ZS9tMUlTY0NDYWRmOHoydHJxZk5N?=
 =?utf-8?B?eEd3TzhuekZPMG1RNWlHS0h1d0NzRm5weWRGbktYaEpLeFpMZnM0cHoycXVu?=
 =?utf-8?B?SlpZTGtHaExsRjRTS1FKZTMvSFgrZkFmWGpjQmEzQkwwbDNWNkFMYzRJbisz?=
 =?utf-8?B?Z1JtemV1WStZQVpHcVRtQlM1Vnc5K0lxMjNzb3RKQThaUnJMM2FiSWg4K2Ux?=
 =?utf-8?B?TTlWbzd5bGo5aEJnNmYyS1VpSGQyTWpVcmVTVlk5ajY3VDQ5Tld1cE1tcm5m?=
 =?utf-8?B?VnNwVEYrUWJZb1ZORzlKeXNheXhYL0laYmQ1ZE5CTGI4amkybU85NHVtcm1h?=
 =?utf-8?B?K3VZTmdRMkxRUmhMMWRIREpoaWRkeDFzWmxpdkkwemRPZG9jc05RM1BONDdZ?=
 =?utf-8?B?S2R0eFcySFhGcDEzN3BjTmJlY0xiOHhUVU8vcjRSL01GTkJ5N29rb3djNlJE?=
 =?utf-8?B?M05TK0NSUjJ3eDFBRE9HZmpBQStnRHNhTlB0NFc5cGZianF0ZXU1NXIwc2F5?=
 =?utf-8?B?RHc9PQ==?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 58877e32-814a-4050-f101-08dc4e381ce9
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2024 08:30:08.9754
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /ZmYbhb+EfrCHfsqO9/DeqKH+y420QEO6u4sEtkRM/1ve8qPUsYH1PbctE7QXsABLz2f10QHyUufBeXiZWv4P8JcWQl3tg/gCID+2vXSIdc+PGTpLpiRtBiJfjo8vabN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5863

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogV2VkbmVz
ZGF5LCBNYXJjaCAyNywgMjAyNCA1OjEyIFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+
IE9uIFR1ZSwgTWFyIDI2LCAyMDI0IGF0IDY6NDfigK9BTSBZb3NoaWhpcm8gU2hpbW9kYQ0KPiA8
eW9zaGloaXJvLnNoaW1vZGEudWhAcmVuZXNhcy5jb20+IHdyb3RlOg0KPiA+ID4gRnJvbTogRnJh
bmsgTGksIFNlbnQ6IFR1ZXNkYXksIE1hcmNoIDI2LCAyMDI0IDEyOjIxIFBNDQo+ID4gPiBPbiBU
dWUsIE1hciAyNiwgMjAyNCBhdCAxMTo0NTo0MEFNICswOTAwLCBZb3NoaWhpcm8gU2hpbW9kYSB3
cm90ZToNCj4gPiA+ID4gQWRkIFJlbmVzYXMgUjhBNzc5RzAgaW4gcGNpX2RldmljZV9pZCB0YWJs
ZSBzbyB0aGF0IHBjaS1lcGYtdGVzdA0KPiA+ID4gPiBjYW4gYmUgdXNlZCBmb3IgdGVzdGluZyBQ
Q0llIEVQIG9uIFItQ2FyIFY0SC4NCj4gPiA+ID4NCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWW9z
aGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiA+ID4g
PiBSZXZpZXdlZC1ieTogR2VlcnQgVXl0dGVyaG9ldmVuIDxnZWVydCtyZW5lc2FzQGdsaWRlci5i
ZT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3Qu
YyB8IDQgKysrKw0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KPiA+
ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9taXNjL3BjaV9lbmRwb2ludF90ZXN0
LmMgYi9kcml2ZXJzL21pc2MvcGNpX2VuZHBvaW50X3Rlc3QuYw0KPiA+ID4gPiBpbmRleCBjMzhh
NjA4M2YwYTcuLjJmYTNjNjQ3M2M3ZCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9taXNj
L3BjaV9lbmRwb2ludF90ZXN0LmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9taXNjL3BjaV9lbmRw
b2ludF90ZXN0LmMNCj4gPiA+ID4gQEAgLTgzLDYgKzgzLDcgQEANCj4gPiA+ID4gICNkZWZpbmUg
UENJX0RFVklDRV9JRF9SRU5FU0FTX1I4QTc3NEMwICAgICAgICAgICAgIDB4MDAyZA0KPiA+ID4g
PiAgI2RlZmluZSBQQ0lfREVWSUNFX0lEX1JFTkVTQVNfUjhBNzc0RTEgICAgICAgICAgICAgMHgw
MDI1DQo+ID4gPiA+ICAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfUkVORVNBU19SOEE3NzlGMCAgICAg
ICAgICAgICAweDAwMzENCj4gPiA+ID4gKyNkZWZpbmUgUENJX0RFVklDRV9JRF9SRU5FU0FTX1I4
QTc3OUcwICAgICAgICAgICAgIDB4MDAzMA0KPiA+ID4gPg0KPiA+ID4gPiAgc3RhdGljIERFRklO
RV9JREEocGNpX2VuZHBvaW50X3Rlc3RfaWRhKTsNCj4gPiA+ID4NCj4gPiA+ID4gQEAgLTEwMDUs
NiArMTAwNiw5IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCBwY2lfZW5kcG9p
bnRfdGVzdF90YmxbXSA9IHsNCj4gPiA+ID4gICAgIHsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lE
X1JFTkVTQVMsIFBDSV9ERVZJQ0VfSURfUkVORVNBU19SOEE3NzlGMCksDQo+ID4gPiA+ICAgICAg
IC5kcml2ZXJfZGF0YSA9IChrZXJuZWxfdWxvbmdfdCkmZGVmYXVsdF9kYXRhLA0KPiA+ID4gPiAg
ICAgfSwNCj4gPiA+ID4gKyAgIHsgUENJX0RFVklDRShQQ0lfVkVORE9SX0lEX1JFTkVTQVMsIFBD
SV9ERVZJQ0VfSURfUkVORVNBU19SOEE3NzlHMCksDQo+ID4gPiA+ICsgICAgIC5kcml2ZXJfZGF0
YSA9IChrZXJuZWxfdWxvbmdfdCkmZGVmYXVsdF9kYXRhLA0KPiA+ID4gPiArICAgfSwNCj4gPiA+
DQo+ID4gPiBZb3UgdXNlIGRlZmF1bHRfZGF0YSwgd2h5IG5lZWQgbmV3IGRldmljZV9pZD8gSSB0
aGluayB5b3UgY2FuIHVzZSAweDAwMzENCj4gPiA+IHRvIGRvIHRlc3QuDQo+ID4NCj4gPiBJIHRo
b3VnaHQgd2UgY2FuIGFkZCBhIG5ldyBkZXZpY2VfaWQgZnJlZWx5IGxpa2Ugb3RoZXIgZGV2aWNl
cy4NCj4gPiBTaW5jZSB0aGUgUENJZSBjb250cm9sbGVyJ3MgZW5kcG9pbnQgbW9kZSBjYW4gY29u
ZmlndXJlIHRoZSBkZXZpY2UgaWQsDQo+ID4gSSBjYW4gdXNlIDB4MDAzMSB0byBkbyB0ZXN0IHRo
b3VnaC4NCj4gDQo+IENhbiBpdD8NCg0KWWVzLCB0aGUgZm9sbG93aW5nIGZ1bmN0aW9uIGNhbiB3
cml0ZSB0aGUgZGV2aWNlIGlkIGluIGVuZHBvaW50IG1vZGUuDQpodHRwczovL2dpdC5rZXJuZWwu
b3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvdHJlZS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYz9oPXY2LjktcmMxI24x
MDgNCg0KPiBUaGUgZG9jdW1lbnRhdGlvbiBmb3IgdGhlIFBDSUNPTkYwRmkgcmVnaXN0ZXIgc3Rh
dGVzIGJvdGggdGhlDQo+IERFVklDRV9JRCBhbmQgVkVORE9SX0lEIGJpdHMgYXJlIHJlYWQtb25s
eS4NCg0KWW91J3JlIGNvcnJlY3QuIFRoZSBkb2N1bWVudGF0aW9uIChSLUNhciBWNEggaGFyZHdh
cmUgbWFudWFsKSBzYWlkIHRoZXNlIGJpdHMgYXJlIHJlYWQtb25seS4NCkhvd2V2ZXIsIGFjdHVh
bCBoYXJkd2FyZSBJUCBzZWVtcyB0byBhbGxvdyB3cml0aW5nIHRoaXMgcmVnaXN0ZXIgaWYgdGhl
IHdyaXRlIHByb3RlY3QgaXMgZGlzYWJsZWQgaW4gZW5kcG9pbnQgbW9kZS4NCg0KQmVzdCByZWdh
cmRzLA0KWW9zaGloaXJvIFNoaW1vZGENCg0KPiBHcntvZXRqZSxlZXRpbmd9cywNCj4gDQo+ICAg
ICAgICAgICAgICAgICAgICAgICAgIEdlZXJ0DQo+IA0KPiAtLQ0KPiBHZWVydCBVeXR0ZXJob2V2
ZW4gLS0gVGhlcmUncyBsb3RzIG9mIExpbnV4IGJleW9uZCBpYTMyIC0tIGdlZXJ0QGxpbnV4LW02
OGsub3JnDQo+IA0KPiBJbiBwZXJzb25hbCBjb252ZXJzYXRpb25zIHdpdGggdGVjaG5pY2FsIHBl
b3BsZSwgSSBjYWxsIG15c2VsZiBhIGhhY2tlci4gQnV0DQo+IHdoZW4gSSdtIHRhbGtpbmcgdG8g
am91cm5hbGlzdHMgSSBqdXN0IHNheSAicHJvZ3JhbW1lciIgb3Igc29tZXRoaW5nIGxpa2UgdGhh
dC4NCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAtLSBMaW51cyBUb3J2YWxkcw0K

