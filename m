Return-Path: <linux-pci+bounces-5579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C783896075
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 02:03:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDE01F23933
	for <lists+linux-pci@lfdr.de>; Wed,  3 Apr 2024 00:03:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED0B36C;
	Wed,  3 Apr 2024 00:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="HQ7vtGjM"
X-Original-To: linux-pci@vger.kernel.org
Received: from JPN01-TYC-obe.outbound.protection.outlook.com (mail-tycjpn01on2097.outbound.protection.outlook.com [40.107.114.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12BD944F;
	Wed,  3 Apr 2024 00:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.114.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712102615; cv=fail; b=c7MqqSYPahEltzuTROF8VKaTT4ONuNGZE8lG6Pc+Rdj+Qgb4woTaz1/g4D6k/nOGjsk1yoKcSxiQAFfUqisOwJNRqZdfcBi5613sxx0xjN77f0kAJ81AyWL7q/pxj13WICbChKtyOREiLqzk/oBvhekDU1jGnPwzfsoGSX6YCLs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712102615; c=relaxed/simple;
	bh=cYNJn95/AGGyFdqRc5hGJn4tZs0qhU+Vuw2xlRZjUHE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EhRV3QACHihjn0BoTMIEB0850Nhyhguz/8hfZJXvgfzmplHdtbwGXQxub4rksSIVq24pePCVSaE4f+dwEMp2N69irV06KGtBjLwPsaiTW5MtoBGGaBxOFvOFbKA1Q9rmrlqH8evwLd86o/PJJ7tZrfA6xPVKric3imfptXqOIyM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=HQ7vtGjM; arc=fail smtp.client-ip=40.107.114.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAMUXlZa9oHFOunFB1YlRGBizC4Tp2qZluKWFByyqKnjHOMhIhoVVpHjMDrS7qWoxwbXlPauPAGVKkB/z58RFMlaIeSewq9cteRRtCsU/9URUyW6yqaJ0t7uoO+l6Pq2nyVMCRGil8pyiuwDUCdycC132BLfkisORqzdvQ5mrKFKCE06KRHOOAc2nrrJgA8mmyjc/Um/BWnszFkpgcwbCRCm9pcjW6SHbYN10grk9VPdXXNsU2fyN5XwvVH8E4Nsrrk32coX3q5lN1BUI9VUyTTzmrnG6tewthGJF2sQ+26yyYG9V6WipWBHrMr5yWUN7TLV3sSPY1qNrImkuSNE8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cYNJn95/AGGyFdqRc5hGJn4tZs0qhU+Vuw2xlRZjUHE=;
 b=EFkvQXDCeWjzAwumPeH/q53LyPX+4mcfB3SeKf4iYo3PVGG/4zFgqyvlXXB6xWK+FBg0P3YfrpwJV/wC67aZBQNwXxtXLtzOTdCGcanauVo27stwBuWS3Psuh6qEd1TcbQNQijmdkuko0LcFMxTIeDr2iTE8ZavqgEQffHwV6HsAlAEBku9PbISAasiANoVwVBGuKxrBccOsGs2JXI0y/wTcME4xxZr/EHM4pqYaB3pjVjU0GctFXpgvCmop6tpUjLQzfJRM5zD+i3wfP2j6sR/ZhW9OWkYnMkoQrEhU0EUNVZxRkt9ZjCUoTJZ3t1eB5OXwYwMrGTq0x8FYMOFDjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cYNJn95/AGGyFdqRc5hGJn4tZs0qhU+Vuw2xlRZjUHE=;
 b=HQ7vtGjMmrK8F/YZ1U5m434laH1Wa2TUemVxrfOv21TxrjwvpigsUH8fD5VnlUAEif141ruDf9aqXoGmORWODH30n0gibjr3sjZVy5blSNRZ+LYTr3rxCJmYzmpPrmh77BXDEEja1+rxjZvH2ff2JJ8oD2jxCWle6Cu1d8RJBYE=
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com (2603:1096:400:3a7::6)
 by OS3PR01MB10248.jpnprd01.prod.outlook.com (2603:1096:604:1e4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 00:03:28 +0000
Received: from TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f]) by TYCPR01MB11040.jpnprd01.prod.outlook.com
 ([fe80::f9d2:106:9dc3:224f%3]) with mapi id 15.20.7386.023; Wed, 3 Apr 2024
 00:03:28 +0000
From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>
CC: "lpieralisi@kernel.org" <lpieralisi@kernel.org>, "kw@linux.com"
	<kw@linux.com>, "robh@kernel.org" <robh@kernel.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "krzysztof.kozlowski+dt@linaro.org"
	<krzysztof.kozlowski+dt@linaro.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
	"mani@kernel.org" <mani@kernel.org>, "marek.vasut+renesas@gmail.com"
	<marek.vasut+renesas@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "linux-renesas-soc@vger.kernel.org"
	<linux-renesas-soc@vger.kernel.org>
Subject: RE: [PATCH v3 6/7] PCI: dwc: rcar-gen4: Add support for r8a779g0
Thread-Topic: [PATCH v3 6/7] PCI: dwc: rcar-gen4: Add support for r8a779g0
Thread-Index: AQHag93fYJpAtBsUYEK0qdjDsRLcJbFUnd+AgAEOubA=
Date: Wed, 3 Apr 2024 00:03:28 +0000
Message-ID:
 <TYCPR01MB1104015F9725D119733337E72D83D2@TYCPR01MB11040.jpnprd01.prod.outlook.com>
References: <20240401023942.134704-1-yoshihiro.shimoda.uh@renesas.com>
 <20240401023942.134704-7-yoshihiro.shimoda.uh@renesas.com>
 <CAMuHMdXCsye4kEP4=1rYNx97VpXHjjNg9BFawnUBADfL2ADQTw@mail.gmail.com>
In-Reply-To:
 <CAMuHMdXCsye4kEP4=1rYNx97VpXHjjNg9BFawnUBADfL2ADQTw@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYCPR01MB11040:EE_|OS3PR01MB10248:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 lb8TrJKsSP37wyENgzbxIHGuVqxvut7JGD+NGKrsIHQw/e/zlSK+GuWC+2IzgoGm0fF6HrSVhIyCKx3gWaN3e4/F46ZAXbWmwCWx0zQDuT2BAb+6VAQC7I4PApx/U+Cbm5OQnY/aIFbTAEFV9PDUnQieEPrzGMuN1TnS6b+TydtVSAkanq11AaCpoQyYdp7PSQ1XZi8OLF3vJku+fXn8xGL5deWT73FcBa7DR3A0HjfmEjp7mAxH0/VQcrSDJNpgi5YAleSjArE5dDX5CyvFLHvyumcKkEnYKZBwsTB2QUmjiCp0aJJgNrKLfEJLU3U8yOA09CmOUTQ1CWqzcdw8x/TnkYMoWDHyMYM1s/1128Hz5Cb3/qIMVRzeN4ibJbg9GD3cwlKBgzVTyzmLevDbYAuhnUfgTMUgUwKFBPaAm8ggzRD1jVzdqHZAU1EnxmWKp4sm/+RJs9IZnHQ1o7bWvnvW3iSSBbsdiiASYndbtvg2ZtL8aynmwFCkq8TNpuM6nSwEBYq+Hw3hay2HrJmKtXsJuqQZJwgIjTDL/JoviU9Nn+KkE5BfxgaiBBJlOaUMAMhMi3KHapNg/WAPA81tvlMt/nceQx+GjyZl0e7v88NiK8twfJvJdD+7RYzonuPRdwizLa0WdVKNY1mSxiRXO7Ctfg7pH/xOTuvSqpjrTbc=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB11040.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OU9RU2VGQloxRHVNcUdkMEl5OVZXTGJaZ0JIdjUzZ01DY29ZbGU4R2ZRVlJl?=
 =?utf-8?B?clN3Zi9jWG40LzluQ01zTlVkUnhQenZ1a3d5L0hOV0dybEVBNUZLa0J0QUt2?=
 =?utf-8?B?dUdUR3Q5bzRUbkdvcFg5UG5SZW16SHo2b2hJSVlRYUxkWHZWeFBGbm9XRUZs?=
 =?utf-8?B?WXdIbDF1aXN4R1ZZN0orUVo4bDgzZGN2L3JJUlFyQ0hSNlJHbitZNDJ4eVRK?=
 =?utf-8?B?MzVRRHRLK0U5K0tiMVRWS2lkNFUvVllBWTBpWEV0RFNiUlhKY0FidHRFaFQz?=
 =?utf-8?B?MG1jNFQ2S3pTMmxRMVpPL1g4RSszYlZPQ0dpaXE1VW42cFJkYk9IZGliNkpM?=
 =?utf-8?B?d0hGQS8ycmxOZVI3SlZhbERDcC9HQURSTGtnT3h1VUxIeU1NMHJMZ3dqN3d0?=
 =?utf-8?B?WWpSdTVEQUZ6bnl4ZkRGNC9rdkprWmtKUVdUL3NaTVVCMWY4akl4TVAxcWpq?=
 =?utf-8?B?eDRWV05yZlZHSkVKQ1NCU29rcDViWWJTMGI1WnpQN1VuS2lVU1FlSDJBQWs0?=
 =?utf-8?B?ZVpNekJ5WXpsRGZSS1VHU0lybWc5L0F4YU9GZ0dRM05PS2krMCtSaG5GK3l1?=
 =?utf-8?B?NlByQnRMa3I2U0J0aXlDKzYwem8wRHJYL0IzUHB6UjJPK3crUVlXWFhjTVVL?=
 =?utf-8?B?K29YVFdsWEthRTJJNmxYYmZJaDZya21tTG1iUERENE42cFNMWGtsVENWNDgw?=
 =?utf-8?B?TzhpV1BOeTB0bTlyeERqa2UyNTlmM2dlS2FDL3QraHZIVlhqNEY5NnMvWFdD?=
 =?utf-8?B?UUxxZkxsMWR5aDcrK3E4Rk1NOHFWVkgveW9TMEtEa2pJeEZqeWtabmU5SUJJ?=
 =?utf-8?B?S2pmbGhFc0toWWRBQTQvcWttTkZsTk1BcHRwY0NyNFFNRE1peW0xTG9ET0o5?=
 =?utf-8?B?SEhDVUpuUkRnZXAvK3IzaWgrem0zanBqZ3ZTQ1JzMkJGMXRXQU5PaWp0NmtR?=
 =?utf-8?B?VjNYYkZqRjM5YUpyYVRyKzQ1UlZGVXBCaTlUdjdIQWh5MHFJUzZGR1VlVHox?=
 =?utf-8?B?L2twbTVqTU1OWk5TQWs1WmZRaWd6UWJFTlZmTUd2b0I2Q3UvZmZvSjlCMFVj?=
 =?utf-8?B?eGpWaC9nbG5xcHpoQXRnTzk3MkhoMHBLMlg1YmQ2UlVtQ2JtSThDQkRtbEhF?=
 =?utf-8?B?M2xhaVdiSk5STlpFb2taUkoxZndZeTEzbEZ4cEs2Yi9NMkU5T3k1cUVSRG84?=
 =?utf-8?B?ejFwcDRKTWVWS1R5bXJkN1ZtQndZWHBaMnNQdGhERER5bmttTFBrK1I2RWdE?=
 =?utf-8?B?Q0lCcjVoU1dlUys5MmFSbVYrUk9tUlliWHdOUkN6NHhSWURvbTJsVEFaRmNi?=
 =?utf-8?B?clozYmNyS044eUJBMFJGcGZRRlZIZVUrY2IvcTU4U0J5L1RxYk5LcVhoNDlT?=
 =?utf-8?B?Uy8zQmE4b2M4SUNKUVFkdCs0dE8ySmpGeWhZdGl0MUtyS0xzU2NXbGRBL3g1?=
 =?utf-8?B?b0o4dEdkMmJPUTdvcWFXK1FSbi9aZis5M0drSzNRbDdhRkFOVVFIcHVyWVVR?=
 =?utf-8?B?NGJmQXhSMEtmU2Z3U1Uva0M1NzVUMU1TS3pPYXEzYTVhV3dMREtMRnpWZCtU?=
 =?utf-8?B?aCtoczYxSTZCRkhYb1FYMnNGcEJPQzh2M09Mc1VxZlc3NGZ5WWJsTzFQSmlT?=
 =?utf-8?B?b2JNY2RMeURwQVgrTGJOUVBBN0FrbEFFY0treEFma2NlTFNQS0J1SHpuZzJs?=
 =?utf-8?B?Y3hYazFtd3E0dzVYZGhuMDMvcFJCT1BNajI0QTFNSjFRTGNGYURQWTg0VEhY?=
 =?utf-8?B?ak5uYVdaUTlSWENNeWxXdXowU2lVMnhWOGswZEFENFRCYVBqbEN1NDJYOGxP?=
 =?utf-8?B?emMwVjJMMnZ2blNZb2NtZjYwNGw2YjYyWlErWjlycTI2QTNHdHZOZWZiNVIr?=
 =?utf-8?B?UGR6YVBnKy9nWXpNY3VGWldpOGRtVm9SM1F1SFFPZHRLRzduZ1BlcWZ6dXgz?=
 =?utf-8?B?MURSemZseCtaUCs3TkRqK3FOaVFOWVVhamNNM0xEeTV0Y29MaWlmUWlGY2Jy?=
 =?utf-8?B?N1pvajE0VFJpTUVXVDBpUGx3YTVBenJMZVVsWFphc1hDUml0YXc0Z3pMMmZW?=
 =?utf-8?B?YlVhNWZKNnVXM21Gc0tBSUlMOVRONVNNWmdCWUdaV1RRdmg4T1ExYUhVM2tz?=
 =?utf-8?B?d0g4cEJPU1laUlMvVnVZRWJGWjlhY1VDN3ZYL0Zra2gyNU5pRkl3a3lIeVp3?=
 =?utf-8?B?R2MyN2xnZU8xa0FYSDFYeVp4ZGliYUpGcDlpZ0c4Rnp6RXB5bHlnS1ltb3Nv?=
 =?utf-8?B?clU4SlFvNEkzaE5Ua0M5YnFqRWl3PT0=?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 92740292-46fa-48fa-4bd6-08dc53717dc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 00:03:28.6240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QoPo6ZFmEcNBNaXdCpgfM4Dwu5xmBDnr1CKFbDpGFkJtD8gKYplctBLIO/iRFBwRq5v3C8SrLAfl9ft27ORijLLOJ4aHem2P2O30SCItwPaO72jv0nJy05PN4NEr7OZG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB10248

SGkgR2VlcnQtc2FuLA0KDQo+IEZyb206IEdlZXJ0IFV5dHRlcmhvZXZlbiwgU2VudDogVHVlc2Rh
eSwgQXByaWwgMiwgMjAyNCA0OjUzIFBNDQo+IA0KPiBIaSBTaGltb2RhLXNhbiwNCj4gDQo+IE9u
IE1vbiwgQXByIDEsIDIwMjQgYXQgNDo0MOKAr0FNIFlvc2hpaGlybyBTaGltb2RhDQo+IDx5b3No
aWhpcm8uc2hpbW9kYS51aEByZW5lc2FzLmNvbT4gd3JvdGU6DQo+ID4gVGhpcyBkcml2ZXIgcHJl
dmlvdXNseSBzdXBwb3J0ZWQgcjhhNzc5ZjAgKFItQ2FyIFM0LTgpLiBBZGQgc3VwcG9ydA0KPiA+
IGZvciByOGE3NzlnMCAoUi1DYXIgVjRIKS4NCj4gPg0KPiA+IFRvIHN1cHBvcnQgcjhhNzc5ZzAs
IGl0IHJlcXVpcmVzIHNwZWNpZmljIGZpcm13YXJlLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTog
WW9zaGloaXJvIFNoaW1vZGEgPHlvc2hpaGlyby5zaGltb2RhLnVoQHJlbmVzYXMuY29tPg0KPiAN
Cj4gVGhhbmtzIGZvciB5b3VyIHBhdGNoIQ0KDQpUaGFuayB5b3UgZm9yIHlvdXIgcmV2aWV3IQ0K
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1yY2FyLWdlbjQuYw0K
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtcmNhci1nZW40LmMNCj4g
DQo+ID4gK3N0YXRpYyBpbnQgcmNhcl9nZW40X3BjaWVfdXBkYXRlX3BoeV9maXJtd2FyZShzdHJ1
Y3QgcmNhcl9nZW40X3BjaWUgKnJjYXIpDQo+ID4gK3sNCj4gPiArICAgICAgIGNvbnN0IHUzMiBj
aGVja19hZGRyW10gPSB7IDB4MDAxMDEwMTgsIDB4MDAxMDExMTgsIDB4MDAxMDEwMjEsIDB4MDAx
MDExMjF9Ow0KPiA+ICsgICAgICAgc3RydWN0IGR3X3BjaWUgKmR3ID0gJnJjYXItPmR3Ow0KPiA+
ICsgICAgICAgY29uc3Qgc3RydWN0IGZpcm13YXJlICpmdzsNCj4gPiArICAgICAgIHVuc2lnbmVk
IGludCBpLCB0aW1lb3V0Ow0KPiA+ICsgICAgICAgdTMyIGRhdGE7DQo+ID4gKyAgICAgICBpbnQg
cmV0Ow0KPiA+ICsNCj4gPiArICAgICAgIHJldCA9IHJlcXVlc3RfZmlybXdhcmUoJmZ3LCBSQ0FS
X0dFTjRfUENJRV9GSVJNV0FSRV9OQU1FLCBkdy0+ZGV2KTsNCj4gPiArICAgICAgIGlmIChyZXQp
IHsNCj4gPiArICAgICAgICAgICAgICAgZGV2X2Vycihkdy0+ZGV2LCAiJXM6IFJlcXVlc3Rpbmcg
ZmlybXdhcmUgZmFpbGVkXG4iLCBfX2Z1bmNfXyk7DQo+ID4gKyAgICAgICAgICAgICAgIHJldHVy
biByZXQ7DQo+ID4gKyAgICAgICB9DQo+ID4gKw0KPiA+ICsgICAgICAgZm9yIChpID0gMDsgaSA8
IChmdy0+c2l6ZSAvIDIpOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgICAgZGF0YSA9IGZ3LT5k
YXRhW2kgKiAyXSB8IGZ3LT5kYXRhWyhpICogMikgKyAxXSA8PCA4Ow0KPiA+ICsgICAgICAgICAg
ICAgICB0aW1lb3V0ID0gMTAwOw0KPiA+ICtyZXRyeV9kYXRhOg0KPiA+ICsgICAgICAgICAgICAg
ICBkd19wY2llX3dyaXRlbF9kYmkoZHcsIFBSVExHQzg5LCBSQ0FSX0dFTjRfUENJRV9GSVJNV0FS
RV9CQVNFX0FERFIgKyBpKTsNCj4gPiArICAgICAgICAgICAgICAgZHdfcGNpZV93cml0ZWxfZGJp
KGR3LCBQUlRMR0M5MCwgZGF0YSk7DQo+ID4gKyAgICAgICAgICAgICAgIGlmIChyY2FyX2dlbjRf
cGNpZV9yZWdfY2hlY2tfYml0KHJjYXIsIFBSVExHQzg5LCBCSVQoMzApKSA8IDApIHsNCj4gDQo+
IElmIHlvdSB3b3VsZCBpbnZlcnQgdGhlIGxvZ2ljIGhlcmUsIHlvdSBjb3VsZCAiYnJlYWsiIGhl
cmUsIC4uLg0KPiANCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoISgtLXRpbWVvdXQp
KSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXQgPSAtRVRJTUVET1VU
Ow0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBleGl0Ow0KPiA+ICsg
ICAgICAgICAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgICAgICAgICAgICAgICAgICB1c2xl
ZXBfcmFuZ2UoMTAwLCAyMDApOw0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gcmV0
cnlfZGF0YTsNCj4gDQo+IC4uLiBhbmQgY29udmVydCAicmV0cnlfZGF0YTogLi4uIGdvdG8gcmV0
cnlfZGF0YSIgaW50byAiZG8geyAuLi4gfSB3aGlsZSAoMSkiLA0KPiBhdm9pZGluZyB0aGUgZ290
by4NCg0KVGhhbmsgeW91IGZvciB5b3VyIHN1Z2dlc3Rpb24uIEknbGwgZml4IGl0Lg0KDQo+ID4g
KyAgICAgICAgICAgICAgIH0NCj4gPiArICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByY2Fy
X2dlbjRfcGNpZV9waHlfcmVnX3VwZGF0ZV9iaXRzKHJjYXIsIFJDQVJfR0VONF9QQ0lFX1BIWV8w
ZjgsIEJJVCgxNyksIEJJVCgxNykpOw0KPiA+ICsNCj4gPiArICAgICAgIGZvciAoaSA9IDA7IGkg
PCBBUlJBWV9TSVpFKGNoZWNrX2FkZHIpOyBpKyspIHsNCj4gPiArICAgICAgICAgICAgICAgdGlt
ZW91dCA9IDEwMDsNCj4gPiArcmV0cnlfY2hlY2s6DQo+ID4gKyAgICAgICAgICAgICAgIGR3X3Bj
aWVfd3JpdGVsX2RiaShkdywgUFJUTEdDODksIGNoZWNrX2FkZHJbaV0pOw0KPiA+ICsgICAgICAg
ICAgICAgICByZXQgPSByY2FyX2dlbjRfcGNpZV9yZWdfY2hlY2tfYml0KHJjYXIsIFBSVExHQzg5
LCBCSVQoMzApKTsNCj4gPiArICAgICAgICAgICAgICAgcmV0IHw9IHJjYXJfZ2VuNF9wY2llX3Jl
Z19jaGVja19iaXQocmNhciwgUFJUTEdDOTAsIEJJVCgwKSk7DQo+ID4gKyAgICAgICAgICAgICAg
IGlmIChyZXQgPCAwKSB7DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKCEoLS10aW1l
b3V0KSkgew0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVUSU1F
RE9VVDsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXhpdDsNCj4g
PiArICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
dXNsZWVwX3JhbmdlKDEwMCwgMjAwKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBnb3Rv
IHJldHJ5X2NoZWNrOw0KPiANCj4gTGlrZXdpc2UuDQoNCkknbGwgZml4IGl0Lg0KDQpCZXN0IHJl
Z2FyZHMsDQpZb3NoaWhpcm8gU2hpbW9kYQ0KDQo+ID4gKyAgICAgICAgICAgICAgIH0NCj4gPiAr
ICAgICAgIH0NCj4gPiArDQo+ID4gKyAgICAgICByZXQgPSAwOw0KPiA+ICtleGl0Og0KPiA+ICsg
ICAgICAgcmVsZWFzZV9maXJtd2FyZShmdyk7DQo+ID4gKw0KPiA+ICsgICAgICAgcmV0dXJuIHJl
dDsNCj4gPiArfQ0KPiANCj4gR3J7b2V0amUsZWV0aW5nfXMsDQo+IA0KPiAgICAgICAgICAgICAg
ICAgICAgICAgICBHZWVydA0KPiANCj4gLS0NCj4gR2VlcnQgVXl0dGVyaG9ldmVuIC0tIFRoZXJl
J3MgbG90cyBvZiBMaW51eCBiZXlvbmQgaWEzMiAtLSBnZWVydEBsaW51eC1tNjhrLm9yZw0KPiAN
Cj4gSW4gcGVyc29uYWwgY29udmVyc2F0aW9ucyB3aXRoIHRlY2huaWNhbCBwZW9wbGUsIEkgY2Fs
bCBteXNlbGYgYSBoYWNrZXIuIEJ1dA0KPiB3aGVuIEknbSB0YWxraW5nIHRvIGpvdXJuYWxpc3Rz
IEkganVzdCBzYXkgInByb2dyYW1tZXIiIG9yIHNvbWV0aGluZyBsaWtlIHRoYXQuDQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgLS0gTGludXMgVG9ydmFsZHMNCg==

