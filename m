Return-Path: <linux-pci+bounces-2912-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1378452D8
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 09:37:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6D9D1F2221A
	for <lists+linux-pci@lfdr.de>; Thu,  1 Feb 2024 08:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3CAE5FEE0;
	Thu,  1 Feb 2024 08:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="YpWUOTkT"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2112.outbound.protection.outlook.com [40.107.220.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66B15959B
	for <linux-pci@vger.kernel.org>; Thu,  1 Feb 2024 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776639; cv=fail; b=hJxMg8quoGNxlDolQG1P69ZyT+m6Cge/w+rcXNUZjNIFKLs7ONEDoCM4Mk/yy/AjBXMBM+neA66ujv0wlyLe3acrCqB5nxu9BuSxWtrr0n1UWdoQjDLpRbXfiTLs+2kagh8hGwIwYHzwK7CDFulkJBbXlI6vfolSj2rTnEM9VG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776639; c=relaxed/simple;
	bh=wl4gbyBik07DTVRFiXpNVJOQ6akJWJyWKps59UDJbjk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JlyRZBAxR+78FIsYGM6UvQ0ArZH6BpS5Cjq7C1xXNnU58S5En2M7ivsFk9GqleAgNa3rLR6TVAQohr9ip04lo0ejon/kMeuM8pTy45u1O6ixMdPQNUiJNkOQPmjFpJYyQOM3n3wPqOPWj+7pyaqiGyOQIOOpFL2koFY2O60KnfI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (1024-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=YpWUOTkT; arc=fail smtp.client-ip=40.107.220.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kwXe7XoEPdQEJ7hhEhp/x6GuEpr/DI5ed/VqaAlZQ2jGyx3gn7Zle7CLwdQBzJXbd+JBLROkhZp4DMmuVVx+IEYG+F4dejVentClQQAmbo7/PpekwZ5OMJlu+v9xLhPewtUrRm5i4u66507ahZmnCDOuLLJYwkOiTCcLnh92yUpXhJ7BDDrn3WBBQDfzOeXBGy38+F2U742xDAhHl64JBOTsu7N3df01lLAxnmSduw3AhSxgoD8WisJDlRvZeYYO1u1FS++s1M+0cIEzL7ssIyV5SczK66foLVLdP3bUVocUw1qbK7s5h9OKdZ1F7swVkRbwBK1WQ/KShvwlfgsWjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wl4gbyBik07DTVRFiXpNVJOQ6akJWJyWKps59UDJbjk=;
 b=NnpvQzsQMopT044SFtIPJPmZP9KIAkZYjZyPmBwTRTetLu4RLY8cP5rerG/hfYxXONGd8pnIIwQAd3b5uJjfjxTfudcCCkiIiaqKfv0GFzJodFHuKhVrT816hVZNA09IJLj4HIGz4ZRVqQfea88gHuDdDsfslCdFunYn9i1Pd5qem7sx+Ghv74zbWADK9TtHuekzRk6PMwFr1yDzwjJROurahUrghgEW2ptXnzsmJI/E6A9lj1mlxs95j9hq5kK2aCwDUaRPNKT0rc4oqQauTDaa7cUopbbgnkyUJPapUiGQSjklFefZpDUhv8HC9DBxn7LCiwr9fGE03eJ0NadO2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wl4gbyBik07DTVRFiXpNVJOQ6akJWJyWKps59UDJbjk=;
 b=YpWUOTkTegAYfAGVaK/dVNgqnXO0UTLRMEMx+2Cj+sZA56tR+jhid6jNh/zgxLcNCDkIAevT43HmWFZR9V488cFTzGFYn2hOXrFkTExBkVHuTK3EzWExjqSU/Vr8pA58M1d7K19U1G2gcYJ1N+P05WAV+PLN9NjuN2SN+cBI9e8=
Received: from BY3PR19MB5076.namprd19.prod.outlook.com (2603:10b6:a03:36f::11)
 by CH0PR19MB7852.namprd19.prod.outlook.com (2603:10b6:610:193::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.34; Thu, 1 Feb
 2024 08:37:13 +0000
Received: from BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::bf85:e768:b732:5496]) by BY3PR19MB5076.namprd19.prod.outlook.com
 ([fe80::bf85:e768:b732:5496%2]) with mapi id 15.20.7249.025; Thu, 1 Feb 2024
 08:37:13 +0000
From: Lei Chuan Hua <lchuanhua@maxlinear.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas
	<helgaas@kernel.org>
CC: Ajay Agarwal <ajayagarwal@google.com>, Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Manu Gautam
	<manugautam@google.com>, Doug Zobel <zobel@google.com>, William McVicker
	<willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, Robin
 Murphy <robin.murphy@arm.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Thread-Topic: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Thread-Index: AQHaVLy/6yQsKI9EqkmNtxnaySMFQLD1GDGAgAAPJyI=
Date: Thu, 1 Feb 2024 08:37:13 +0000
Message-ID:
 <BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com>
References: <20240131234817.GA607976@bhelgaas>
 <20240201031413.GA614954@bhelgaas> <20240201073239.GA17027@thinkpad>
In-Reply-To: <20240201073239.GA17027@thinkpad>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR19MB5076:EE_|CH0PR19MB7852:EE_
x-ms-office365-filtering-correlation-id: 88c88a53-c04a-406d-dc6e-08dc2300fcf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 4/5pQjFxyESFgYEd7+auzWvyG0E3BPAKlcF5PFrZTdFTxSiXrA+mcOkWOSajznpBd3pJ/R7id+A54M8e4zod34Ouiau8B7lbxrNoJkqWGb+82t8RYMbcmmf2evgWjNYN0sj+b+2AL8LbrnB96VqGobSIsGfV/TFp+nOr+3kOtymfZ5bu0lO1vlm4NKt4Ba/JQYITqQN21L3cJziZ+CeQxNKEGKglTsSRqiF+ipPtlfooQxJM1pH2islshirV24S4DCivjWpFaGnWPnDSBxdrStb5wUd94aGEQ4/LPlFQWGGNPXAlX16qQBs7rQYuVcWSorxYAWQeL5SYu/RqQlCZzjD/8JLfop6uF60fhy+mUv8rsMc9i4qOpoFGBJchLrb6Klo3UXPNr46omY59im3O/Nwln2de6PRJ8g6uVXIUjEjgO5TWfZTBmk/utnkHerE2EMLRfrjOQ7+ClZxPpEng/Xf4eGb6oNrUNjpySbCsE2t/vJUYlCsMNrxx+tmLleMFtjeFCQCPx22n2ZajpC2Uo5SPo5mQI3YlUd94XRLwJYbTG4UleUi6KYS8YbkYk09HfI8daSapWyqyudc7iWx4ASZ7rIJXH4/8D4nZDHCx0IKvfg2ixBxBhuY+gj/9pCUdwOn2QTWnNAmiEFLSZkFg6GPyhKyvUyXtywZ2ii5RXgY=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR19MB5076.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(396003)(39850400004)(136003)(376002)(230173577357003)(230273577357003)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(41300700001)(55016003)(26005)(66574015)(38070700009)(53546011)(6506007)(83380400001)(9686003)(71200400001)(7696005)(478600001)(38100700002)(122000001)(33656002)(86362001)(2906002)(5660300002)(7416002)(54906003)(64756008)(76116006)(66476007)(66946007)(66556008)(110136005)(66446008)(316002)(8936002)(91956017)(4326008)(52536014)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?KzNpS1Y3SWxqV0tpTzdHTVRsa1RFcTdjTkhmb2hRMzVHYjAveDh3RFByMzJ1?=
 =?utf-8?B?Y1NmMm5Sa3ZNeENqM3gxSkYzQVN6SkJnY1lmbTVEU2p2d1BoSCs3WGR1eElK?=
 =?utf-8?B?c1RXand3c1ZQUUNJSU1Na3NEb2UyUzVLWURnZ0p6NE5vY21iRTVJbjAzY0Vw?=
 =?utf-8?B?d0ZJUmJhcWVMUkdvQ0RRemp0bFlVczNVeFdPcEpFdC80SVY4bUkzTmVnc1hB?=
 =?utf-8?B?WFZOblJOY2l1Y3Y5REdTYXAydVE4VEtCejY1R0FRRldoNmlkeHRlaExjTThT?=
 =?utf-8?B?NVFseGFLdStTRGJPaXZETEg5d1dWOTdHY2JxQjhNVGVteUordXhCN0RycXBC?=
 =?utf-8?B?R3F0ZW8yZUEybzhaOTlUSWlYSXJUUTMzYmZIWkRVK1NNdktrN0xKd3dVWXFQ?=
 =?utf-8?B?U0NjeEFZUTRHUFhnbWh6VVdLbVhaMlAvaWtJK2Viek9tSmx1RjZxcEthM05H?=
 =?utf-8?B?T2xlNEJNejhBMnhZUExHZGpseFNCUGNlVmlOTFJBTS90cWhQaUliNU5zcER0?=
 =?utf-8?B?MzhZS0ZLZEFKdFJXTmdvZG0zT082M1QzV3k1VHFvWXFzc1RUU0RieU5PVjZk?=
 =?utf-8?B?R2o0V2ZHVzhCVFExNmlxYXBsL3YrNjZnMTNvTC8vU21YWGd5S1NkS0NEc1hW?=
 =?utf-8?B?THZMRWZqVjVYU0NMU3RpN0xrQXQwUjc0RmVqOGZMZTRXdG1FUDdxYi8rMGNw?=
 =?utf-8?B?ZXVyT25rMTZtV3VKa3VkWmlKV20wQUVHVWVISjZ1Z3I4TktJRk91Qkx2aU16?=
 =?utf-8?B?NXJBZVJ6Y1I2WUlobTZ2dnlWSEJHUlp0bEt1emV3VlQ3L2FWaVVmbm5BL3A1?=
 =?utf-8?B?cnRHVE4xaWFaZy94c0xtbEt3SnVyak5VWkJsSjBzaDZObjlBM1JzS3lIQ1hP?=
 =?utf-8?B?SzA2TXJ5NkN1RUczbDdzZ3FFUkhSTCtvb0QvNGxuc2cxZC9VN2FiSDBUNmJj?=
 =?utf-8?B?bTBad25RT0orZHJ2Tnl4ZXk2ZGZPNWtqWmJYa1d5ZXdVSVIzTSt6aEpJZFNV?=
 =?utf-8?B?am51b0Rpd0NiZlhyamp1cHJyMUFKazhzQTRoOVAveDA4NlJ0eEdleTVrM3A4?=
 =?utf-8?B?a3BvSmExRTdlYjZTclFrSkFuVnR6andkOHhDTkpCeU5ibHdMTVRRclR0eThI?=
 =?utf-8?B?RC8wZ09aaGt4WFE5b2RoUzZ4Z0ZrVENINWl0NFo2NXF4VU1QbWtYOUlQTjBW?=
 =?utf-8?B?ejZubnFkYVBGUG9acUJycVkwdUs0d0dqNzNiakNKcVlueGJSVVNwNDNFTCtC?=
 =?utf-8?B?K1JEQ1NGc09LdjhjRlN4Zk1weWJYTTkreFhzdEFDYVE4MmlNUmFqemc2Q3hO?=
 =?utf-8?B?Zm91d0w0Y0tabnZiaG5URERvNThGeWhXcnM1cjB5VzNKSnNqdWM2UFNXU28r?=
 =?utf-8?B?YW05MnJqTTBRVS9GcnRGeDlUOHJPakdzV2h6eU4xekRJWWxKYW9Sby8zRDQ0?=
 =?utf-8?B?cFVyN1p2VUtRWHN5eVdtdEt2Wk91WVdOYmZRTVJ0bExNOS8yeHBhcUlCU1c4?=
 =?utf-8?B?RDRsSU5hR3JsY0VYdzAyZzhacWZnZ0dDZmtGZlZCK0x0ME9vcVBSY1VVR21L?=
 =?utf-8?B?RzY0MXBGODVaZnFyL1U4enRjNjZZMWV5bXR1YmhsNVpCOUNiWXlQWXRXKzAx?=
 =?utf-8?B?N2xmNTNEeW5wZ1o5NjFPUUQrZzR1UFFlMHlXSEVkUDExdXRrWFg4S0dHUEpO?=
 =?utf-8?B?MFQvbGh2eFJYZVplTjFnZHNsYTIxaklwRU1ZNzR5YU1Od21tZVczc1JZaGln?=
 =?utf-8?B?cUhaUThmc3ZsNGFaU2JXWFliUnZVUWRmSDBYY1ZwVm4rR0NucWV1dFk3ZEFN?=
 =?utf-8?B?UWsrNVpoV3ZtOWNWbWgwdHlSQlNkWW81YUw3TVNZU25pV1NsaVUzMG1FcHBP?=
 =?utf-8?B?R1lvdnRUZDEweE9aK3pWTXBoa0lXM2JpMENzRi83aTJTNWJkRUNNeEF2UlhP?=
 =?utf-8?B?MXo3UEppN3BTUHVyRDZSalVCbVVXaWUxOHZONkRzTWFsS2RFaSszczRBM0FH?=
 =?utf-8?B?TlhRUmRnb3JSYUFWdlZtOW96NStRaWV6WE01bEh3S3M0cmFMaS8xbXNPdW1w?=
 =?utf-8?B?N0tGMGlhdXIwWmhSL3Q4VlJRZVoxeURlSFh0a2pweEllU3djMXVuckpTbWcv?=
 =?utf-8?Q?tjODnqHHjnaP41YCOl4cKj0Ae?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR19MB5076.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88c88a53-c04a-406d-dc6e-08dc2300fcf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Feb 2024 08:37:13.0283
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OtebfQFuETCXSqDL+VNHCT3vy4XqDxDWNNrOP/C7Id4KgzikHuNqNu+wvbzxdhWvCTYapGcU/UTJDaVVXjJiHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR19MB7852

V2Ugd2lsbCB3b3JrIG9uIHRoZSB1cGRhdGVkIHZlcnNpb24gdG8gcmVtb3ZlIHRoZSBkdXBsaWNh
dGlvbi4gCgpDaHVhbmh1YQoKRnJvbTrCoE1hbml2YW5uYW4gU2FkaGFzaXZhbSA8bWFuaXZhbm5h
bi5zYWRoYXNpdmFtQGxpbmFyby5vcmc+ClNlbnQ6wqBUaHVyc2RheSwgRmVicnVhcnkgMSwgMjAy
NCAzOjMyIFBNClRvOsKgQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJuZWwub3JnPgpDYzrCoEFq
YXkgQWdhcndhbCA8YWpheWFnYXJ3YWxAZ29vZ2xlLmNvbT47IEppbmdvbyBIYW4gPGppbmdvb2hh
bjFAZ21haWwuY29tPjsgSm9oYW4gSG92b2xkIDxqb2hhbitsaW5hcm9Aa2VybmVsLm9yZz47IEpv
biBIdW50ZXIgPGpvbmF0aGFuaEBudmlkaWEuY29tPjsgTG9yZW56byBQaWVyYWxpc2kgPGxwaWVy
YWxpc2lAa2VybmVsLm9yZz47IEtyenlzenRvZiBXaWxjennFhHNraSA8a3dAbGludXguY29tPjsg
Um9iIEhlcnJpbmcgPHJvYmhAa2VybmVsLm9yZz47IEJqb3JuIEhlbGdhYXMgPGJoZWxnYWFzQGdv
b2dsZS5jb20+OyBNYW51IEdhdXRhbSA8bWFudWdhdXRhbUBnb29nbGUuY29tPjsgRG91ZyBab2Jl
bCA8em9iZWxAZ29vZ2xlLmNvbT47IFdpbGxpYW0gTWNWaWNrZXIgPHdpbGxtY3ZpY2tlckBnb29n
bGUuY29tPjsgU2VyZ2UgU2VtaW4gPGZhbmNlci5sYW5jZXJAZ21haWwuY29tPjsgUm9iaW4gTXVy
cGh5IDxyb2Jpbi5tdXJwaHlAYXJtLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcgPGxp
bnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc+OyBMZWkgQ2h1YW4gSHVhIDxsY2h1YW5odWFAbWF4bGlu
ZWFyLmNvbT4KU3ViamVjdDrCoFJlOiBbUEFUQ0ggdjVdIFBDSTogZHdjOiBXYWl0IGZvciBsaW5r
IHVwIG9ubHkgaWYgbGluayBpcyBzdGFydGVkCsKgClRoaXMgZW1haWwgd2FzIHNlbnQgZnJvbSBv
dXRzaWRlIG9mIE1heExpbmVhci4KCgpPbiBXZWQsIEphbiAzMSwgMjAyNCBhdCAwOToxNDoxM1BN
IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOgo+IFsrY2MgQ2h1YW5odWEgTGVpLCBpbnRlbC1n
dyBtYWludGFpbmVyLCBzb3JyeSBJIGZvcmdvdCB0aGlzIV0KPgo+IE9uIFdlZCwgSmFuIDMxLCAy
MDI0IGF0IDA1OjQ4OjE3UE0gLTA2MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6Cj4gPiBPbiBGcmks
IEphbiAxOSwgMjAyNCBhdCAwMToyMjoxOVBNICswNTMwLCBNYW5pdmFubmFuIFNhZGhhc2l2YW0g
d3JvdGU6Cj4gPiA+IE9uIEZyaSwgSmFuIDEyLCAyMDI0IGF0IDAzOjAwOjA2UE0gKzA1MzAsIEFq
YXkgQWdhcndhbCB3cm90ZToKPiA+ID4gPiBJbiBkd19wY2llX2hvc3RfaW5pdCgpIHJlZ2FyZGxl
c3Mgb2Ygd2hldGhlciB0aGUgbGluayBoYXMgYmVlbgo+ID4gPiA+IHN0YXJ0ZWQgb3Igbm90LCB0
aGUgY29kZSB3YWl0cyBmb3IgdGhlIGxpbmsgdG8gY29tZSB1cC4gRXZlbiBpbgo+ID4gPiA+IGNh
c2VzIHdoZXJlIHN0YXJ0X2xpbmsoKSBpcyBub3QgZGVmaW5lZCB0aGUgY29kZSBlbmRzIHVwIHNw
aW5uaW5nCj4gPiA+ID4gaW4gYSBsb29wIGZvciAxIHNlY29uZC4gU2luY2UgaW4gc29tZSBzeXN0
ZW1zIGR3X3BjaWVfaG9zdF9pbml0KCkKPiA+ID4gPiBnZXRzIGNhbGxlZCBkdXJpbmcgcHJvYmUs
IHRoaXMgb25lIHNlY29uZCBsb29wIGZvciBlYWNoIHBjaWUKPiA+ID4gPiBpbnRlcmZhY2UgaW5z
dGFuY2UgZW5kcyB1cCBleHRlbmRpbmcgdGhlIGJvb3QgdGltZS4KPiA+ID4KPiA+ID4gV2hpY2gg
cGxhdGZvcm0geW91IGFyZSB3b3JraW5nIG9uPyBJcyB0aGF0IHVwc3RyZWFtZWQ/IFlvdSBzaG91
bGQgbWVudGlvbiB0aGUKPiA+ID4gc3BlY2lmaWMgcGxhdGZvcm0gd2hlcmUgeW91IGFyZSBvYnNl
cnZpbmcgdGhlIGlzc3VlLgo+ID4gPgo+ID4gPiBSaWdodCBub3csIGludGVsLWd3IGFuZCBkZXNp
Z253YXJlLXBsYXQgYXJlIHRoZSBvbmx5IGRyaXZlcnMgbm90Cj4gPiA+IGRlZmluaW5nIHRoYXQg
Y2FsbGJhY2suIEZpcnN0IG9uZSBkZWZpbml0ZWx5IG5lZWRzIGEgZml4dXAgYW5kIEkgZG8KPiA+
ID4gbm90IGtub3cgaG93IHRoZSBsYXR0ZXIgd29ya3MuCj4gPgo+ID4gV2hhdCBmaXh1cCBkbyB5
b3UgaGF2ZSBpbiBtaW5kIGZvciBpbnRlbC1ndz8KPiA+Cj4gPiBJdCBsb29rcyBhIGxpdHRsZSBz
dHJhbmdlIHRvIG1lIGJlY2F1c2UgaXQgZHVwbGljYXRlcwo+ID4gZHdfcGNpZV9zZXR1cF9yYygp
IGFuZCBkd19wY2llX3dhaXRfZm9yX2xpbmsoKTogZHdfcGNpZV9ob3N0X2luaXQoKQo+ID4gY2Fs
bHMgdGhlbSBmaXJzdCB2aWEgcHAtPm9wcy0+aW5pdCgpLCBhbmQgdGhlbiBjYWxscyB0aGVtIGEg
c2Vjb25kCj4gPiB0aW1lIGRpcmVjdGx5Ogo+ID4KPiA+wqDCoCBzdHJ1Y3QgZHdfcGNpZV9ob3N0
X29wcyBpbnRlbF9wY2llX2R3X29wcyA9IHsKPiA+wqDCoMKgwqAgLmluaXQgPSBpbnRlbF9wY2ll
X3JjX2luaXQKPiA+wqDCoCB9Cj4gPgo+ID7CoMKgIGludGVsX3BjaWVfcHJvYmUKPiA+wqDCoMKg
wqAgcHAtPm9wcyA9ICZpbnRlbF9wY2llX2R3X29wcwo+ID7CoMKgwqDCoCBkd19wY2llX2hvc3Rf
aW5pdChwcCkKPiA+wqDCoMKgwqDCoMKgIGlmIChwcC0+b3BzLT5pbml0KQo+ID7CoMKgwqDCoMKg
wqAgcHAtPm9wcy0+aW5pdAo+ID7CoMKgwqDCoMKgwqDCoMKgIGludGVsX3BjaWVfcmNfaW5pdAo+
ID7CoMKgwqDCoMKgwqDCoMKgwqDCoCBpbnRlbF9wY2llX2hvc3Rfc2V0dXAKPiA+wqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIGR3X3BjaWVfc2V0dXBfcmPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgPC0tCj4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
d19wY2llX3dhaXRfZm9yX2xpbmvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
IyA8LS0KPiA+wqDCoMKgwqDCoMKgIGR3X3BjaWVfc2V0dXBfcmPCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICMgPC0tCj4gPsKgwqDCoMKg
wqDCoCBkd19wY2llX3dhaXRfZm9yX2xpbmvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgIyA8LS0KPiA+Cj4gPiBJcyB0aGF0IHdoYXQgeW91J3JlIHRoaW5r
aW5nPwo+ID4KClJpZ2h0LiBUaGVyZSBpcyBubyBuZWVkIG9mIHRoaXMgZHJpdmVyIGR1cGxpY2F0
aW5nIGR3X3BjaWVfc2V0dXBfcmMoKSBhbmQKZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkuIFBlcmhh
cHMgdGhvc2UgZnVuY3Rpb25zIHdlcmUgYWRkZWQgdG8KZHdfcGNpZV9ob3N0X2luaXQoKSBhZnRl
ciB0aGlzIGRyaXZlciBnb3QgdXBzdHJlYW1lZCBhbmQgdGhlIGF1dGhvciBmYWlsZWQgdG8KdGFr
ZSB0aGlzIGRyaXZlciBpbnRvIGFjY291bnQuCgpCdXQgbXkgcG9pbnQgd2FzLCB0aGUgbmV3IGRy
aXZlcnMgX3Nob3VsZF9ub3RfIHRha2UgaW5zcGlyYXRpb24gZnJvbSB0aGlzIGRyaXZlcgp0byBu
b3QgZGVmaW5lIHN0YXJ0X2xpbmsoKSBjYWxsYmFjayBhdCB0aGUgZmlyc3QgcGxhY2UgKHVubGVz
cyB0aGVyZSBpcyBhIHJlYWwKcmVxdWlyZW1lbnQpLgoKLSBNYW5pCgotLQrgrq7grqPgrr/grrXg
rqPgr43grqPgrqngr40g4K6a4K6k4K6+4K6a4K6/4K614K6u4K+N

