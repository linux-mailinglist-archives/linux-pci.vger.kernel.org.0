Return-Path: <linux-pci+bounces-12982-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E827F97385F
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 15:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17AC11C242F2
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 13:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16CC191F9E;
	Tue, 10 Sep 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="VygVfjFw"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2039.outbound.protection.outlook.com [40.92.89.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B68524B4
	for <linux-pci@vger.kernel.org>; Tue, 10 Sep 2024 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.89.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725974026; cv=fail; b=eVnoSwzk2R+YeCojrZudWVVGBuZ8juwblh8CFEVu2ffd63Q0/Ne2rgD4pEwb51owzDYAx0un53kS3TG8XePYgLYtTL2aCStqJEKVhOUKiavgmHJbxzGmFdI8Z8XiY+HONftg/t/md8wm9JheuLpDHTZa9LgiciPPuStH+OQcq0Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725974026; c=relaxed/simple;
	bh=g47a4z0mnlIKypqr1gFHwFhiwo9LYNPqgO7Sn/DPH3w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXN5r+02elyjOKhdR3rFgYy1WR8Zt+LeazqJteTr/ymzIuy8HbzXRla+tTIkamfVSiPHIBFO09AmI3Aph5v07wcPuscfwj95RSlWS/xbTXVr0SFXIgCInReeI+QWCuVgERSNbR3eZhsDbBbgNk5WYTBCR5DRc/Te7lzgXO0J1f4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=VygVfjFw; arc=fail smtp.client-ip=40.92.89.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gDxKILSMl3FjM58DA/2JK5Jy1LbBh14C45xng3jbEMpMdYEF+BBFrsVenHxxKD7E1WDOO43oS31eEpeDekqRDZr3Oz7Rfn/O6k60Sk0aGlf9S0ZRULj+/aMA5+11jlAVQkKgE5UxbN8KEInAnYheDFXNkuHb5SL7qCJQXpVWgr7ouwyRTfTi5zTZnDAhTm6gnC/ahcQSr6jxNAJerREYaKyOfAPpm4wz3gOPBGKZWO/MMTz1sleWEspmwNdGvxSZs8EdIuEkL+4Fp3c++WSGNe+LRHBUVQX1MRh8m30qckablt95ClLdsChAFhY6G+Sw1vVDtPETjb4VhGzziZQtFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g47a4z0mnlIKypqr1gFHwFhiwo9LYNPqgO7Sn/DPH3w=;
 b=hAhrGZZFYQ6QHsYdy+KasWWmSwoZAyC4xYJfh1kPfSP4Jlh92xuIaw+Gnix7d8OQLX5vmIoYlPtrPA2OzDUyR9hy+WkgzHdBq1ir4sGRiQzZA7D49LE1uv3HFE4XUPj7AQtmGUrxL8sqGw9ORGBjvl66TQ2ecjblh9WSRlH4Dyb5W1/7v0HIB3VbGJMTGyZtP70rOii6uXUqKPwUUq0eGw//JfvTcYxfkfRkT8pCbGgv5ZKyuIEt/bLrRI2QR5PieaziLAu+WBkoo6Yysz0JZ+8ed5RAPM5EeVkSmLSUQw8OmZfEelb1HWdLx7TslDyGQ0t/6f4sVzpEo3mONJE+OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g47a4z0mnlIKypqr1gFHwFhiwo9LYNPqgO7Sn/DPH3w=;
 b=VygVfjFwUEVlnTIPLMfD+3Bi1z8j1/mCehzJD1qvpa13BKGuOmuOIsrtLijMT9nZAFWdcR1uPH2ndr45xB1+L7ZNjw8XC1a2MwmnrTFsD99MD13o2XKeZ9FKxXyvkCAHT3LSg/y4b2B2H1EdgmYxGKeksEMgQZAxUitZ2i85vuavaI/hGlosSe952pJLzh/x+bXa1z0Q0FLCsiQ8MaayU12BVcnqIStd1KIYo6qDAgcU7R5fR96vMiEbeXYfwRNz/6P8sL+7DBhCEWPbrjexJQ5PV8n+djw0HEUsDGqF03y/YMGKfklg8t8Brf3pWdvjeJLddt8OcIyYMzAfBTmhhA==
Received: from VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1d9::21)
 by AM0PR10MB3682.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:15e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Tue, 10 Sep
 2024 13:13:41 +0000
Received: from VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9061:3480:b7e4:9bf1]) by VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::9061:3480:b7e4:9bf1%6]) with mapi id 15.20.7939.017; Tue, 10 Sep 2024
 13:13:41 +0000
From: zdravko delineshev <delineshev@outlook.com>
To: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: nointxmask device
Thread-Topic: nointxmask device
Thread-Index: AQHbA3xRb4NScq4cFUSTGvZPrcImc7JQ/0vr
Date: Tue, 10 Sep 2024 13:13:41 +0000
Message-ID:
 <VI1PR10MB8207C507DB5420AB4C7281E0DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM>
References:
 <VI1PR10MB82076D45499546DE7B5BB9D4DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM>
In-Reply-To:
 <VI1PR10MB82076D45499546DE7B5BB9D4DB9A2@VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [ZXC5MQNgx8ksWEfLu4dRnACkLuBh1XSJ]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR10MB8207:EE_|AM0PR10MB3682:EE_
x-ms-office365-filtering-correlation-id: d4becf85-034e-41bd-5565-08dcd19a6442
x-microsoft-antispam:
 BCL:0;ARA:14566002|15030799003|15080799006|8060799006|19110799003|461199028|440099028|3412199025|102099032;
x-microsoft-antispam-message-info:
 1ykCYZt1Jo7F75O8ptsRVIeEOXxNSupyzuSCOqVl+tAkDL1MyUI5iYfWIgjaZxN5Qf7JpHUYlL7L8DOLM9f+T/2x8H7m5K4WBqahzzvtWtbLw+1Ny1AYAIjYVeKZY2pY4f1NcsxBIa9Pg8hiKN4OHhh5xmvMF1FtSGHrdJrzWmdB1TqsU6MZuawCzvUuyO3cVDFjBdtzr0nVK6nqzcEibSEJaUchGPF3Vt67qoYpUX/ITTkT4GK3Wazyjp6l3d+KYEcCc3voSaJQVjWgyWPNbOrAvEGwy0WS+wvULochR5KYdvl3a9Ndz3M4xYny7WB4d3TEvXGMk6nFs9MD+vxYiRpd5j476F94tCLUe3rDXjcWnjjl4F3xhqOYdphdRQJCOn7UlTWpPEoKyWjk9DZE2jAXhTN0wUiLYHBpbbAfzkU5QyUH5kVlD3Sr0dyCZblRghVSznTIyh+dgPcu/atgm7VDkajO81Kg5YYnGcxIb01FXiNAR+HEcFjHcYDY4F5pn/B8zECP9o0nAoFJlmyYBcK/5F9mlvSey4syRv85ArbEAsOK7yO9PgaDoVFFruJcLwrxVUDXLvCtu4qgr5SuwOA9yqg12PbeMGtecYWr1SzdFWgCiObdwtKFFXypQ8hhw3nzo2s1nZrom5eC6Ez1hnWbBqkuU3SHfTT8vOgkt88VFfAeL337K37JYux03RI2r4ByzGBAnoUkon9sDVHPKQ==
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5HBZljLxNp0kPbOM3hOai8bILxBJnOHcg+eJSQMUfVl7hPs9Bv8uWnaep8?=
 =?iso-8859-1?Q?FKn4K4AQHyGORys2BaN5CvlfrigkB7DXLqJoRs1C6qPltcyLkNvgn0cCg/?=
 =?iso-8859-1?Q?wrwNz1pr8j0tidyqh7L3uwFSlXJrXzT1rwVnvl5gVD2YBA+DLjNHnNCi+k?=
 =?iso-8859-1?Q?jyMhxSGaNqbe4C0XtThg8RgVD4xPU/cIQ+I3G0DNQIibuxVtJdfz6mFH97?=
 =?iso-8859-1?Q?/Q/Hff1MyuNjZs3822d7yL22N2mps+AowU2ThJO24GVLnqYcwq1ZL+SUFW?=
 =?iso-8859-1?Q?9N+IHlmRLfsStzfpUCMTjJksRhJowx6h1jl0qXaiW3YJiUit5eEjyiOVXh?=
 =?iso-8859-1?Q?8aQ+mB8KeVHsu9Ap+dl7OrL7Sd2wp6u/M17NF7ErWrOydv1B3SQGsIpz+E?=
 =?iso-8859-1?Q?wWe+pGbUT4HOvlNco822/OU+7Hx3pHJ7zAgzNlfDNDDmGbMeGaIgqp0Wyc?=
 =?iso-8859-1?Q?LZKe91cmRke84Cdds7Knq4hWPxiIr9GwnSs5unIelz5iwTy0ToRPfAAvsa?=
 =?iso-8859-1?Q?LuQp/VVhP7slbSWveiCSEdwMlY+TCZecJHvYOI9a126x//QCJ0vhtBB0Lo?=
 =?iso-8859-1?Q?94SUgDc/qpN0rgkKxrv9PJsGDO3ESftoC9hPTl+OnbjA+3/EPUxztSQ4Dx?=
 =?iso-8859-1?Q?LpxQiB1D5tTC8FJC7baRibCTUuGzVO8OgkKfv7f+hD3ycyOUGvmqd08cLN?=
 =?iso-8859-1?Q?SE0yV2yW2l2iF+wX+l3NNZTtHMfrbyOmipQlMzzTRU/2aKtqbp+Jh0QEXM?=
 =?iso-8859-1?Q?c64GSpE5tfHjowxDUg/vX+A9WmSHf3BGvOYkoc7VKCO76HO0dYjs5S4be8?=
 =?iso-8859-1?Q?FjYSXW5ESrope8cuFj9TZoMOlzaj/IX2ZpY0c/RwISEPkf1YcYPxuq8IUs?=
 =?iso-8859-1?Q?Be6N99trCDyjyO9F/eUtjnRfoSXaWYR57Cbn9LWauZoVGKOVqgaXAkFVNe?=
 =?iso-8859-1?Q?87n/vEPWJSNvYKNrK4IIiG/zk6vUubtNvnXvfFkMGYz4+nTRlwY2+9DJqq?=
 =?iso-8859-1?Q?L4dC0Mmvgvh/AmHPaoc34Uz+BUXvR4apKnw6bHKsUss6UBmEKZs/AjbzZD?=
 =?iso-8859-1?Q?HRuBUExFmdLhyEoBQs/h2OGWfLKobcNVI7VCTgI+9kwncKnebFJ3tPjfsu?=
 =?iso-8859-1?Q?RuubmrpTXb7qhG+Q7dB6qvE7FdKoCR+asFn1ko4x2LPZ0Jw82p+EPFdDkt?=
 =?iso-8859-1?Q?E+ZeJve2gYbqHovD9AfjXb2Sc5h0AWY33JMzn2cCG9qQFVxTnU/X5ZCNzI?=
 =?iso-8859-1?Q?sbz3JksEMiYrYXS43Tdw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR10MB8207.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: d4becf85-034e-41bd-5565-08dcd19a6442
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2024 13:13:41.6774
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR10MB3682

=0A=
Hello,=0A=
=0A=
i found a note in the vfio-pci parameters to email devices fixed by the noi=
ntxmask parameter.=0A=
=0A=
Here is the one i have and i am trying to pass trough. it is currently work=
ing fine, with nointxmask=3D1 .=0A=
=0A=
=0A=
81:00.0 Audio device: Creative Labs EMU20k2 [Sound Blaster X-Fi Titanium Se=
ries] (rev 03)=0A=
=A0 =A0 =A0 =A0 Subsystem: Creative Labs EMU20k2 [Sound Blaster X-Fi Titani=
um Series]=0A=
=A0 =A0 =A0 =A0 Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-=
 ParErr+ Stepping- SERR+ FastB2B- DisINTx-=0A=
=A0 =A0 =A0 =A0 Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=3Dfast >TA=
bort- <TAbort- <MAbort- >SERR- <PERR- INTx-=0A=
=A0 =A0 =A0 =A0 Latency: 0, Cache Line Size: 32 bytes=0A=
=A0 =A0 =A0 =A0 Interrupt: pin A routed to IRQ 409=0A=
=A0 =A0 =A0 =A0 NUMA node: 1=0A=
=A0 =A0 =A0 =A0 IOMMU group: 23=0A=
=A0 =A0 =A0 =A0 Region 0: Memory at d3200000 (64-bit, non-prefetchable) [si=
ze=3D64K]=0A=
=A0 =A0 =A0 =A0 Region 2: Memory at d3000000 (64-bit, non-prefetchable) [si=
ze=3D2M]=0A=
=A0 =A0 =A0 =A0 Region 4: Memory at d2000000 (64-bit, non-prefetchable) [si=
ze=3D16M]=0A=
=A0 =A0 =A0 =A0 Capabilities: [40] Power Management version 3=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Flags: PMEClk- DSI- D1- D2- AuxCurrent=3D0m=
A PME(D0-,D1-,D2-,D3hot-,D3cold-)=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Status: D0 NoSoftRst- PME-Enable- DSel=3D0 =
DScale=3D0 PME-=0A=
=A0 =A0 =A0 =A0 Capabilities: [48] MSI: Enable- Count=3D1/1 Maskable- 64bit=
+=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 Address: 0000000000000000 =A0Data: 0000=0A=
=A0 =A0 =A0 =A0 Capabilities: [58] Express (v2) Endpoint, MSI 00=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCap: MaxPayload 128 bytes, PhantFunc 0, =
Latency L0s <64ns, L1 <1us=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtTag- AttnBtn- AttnInd- P=
wrInd- RBE+ FLReset- SlotPowerLimit 0W=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCtl: CorrErr- NonFatalErr- FatalErr+ Uns=
upReq-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 RlxdOrd+ ExtTag- PhantFunc-=
 AuxPwr+ NoSnoop+=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MaxPayload 128 bytes, MaxRe=
adReq 512 bytes=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevSta: CorrErr- NonFatalErr- FatalErr- Uns=
upReq- AuxPwr- TransPend-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCap: Port #0, Speed 2.5GT/s, Width x1, A=
SPM L0s L1, Exit Latency L0s <64ns, L1 <1us=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ClockPM- Surprise- LLActRep=
- BwNot- ASPMOptComp-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCtl: ASPM Disabled; RCB 64 bytes, Disabl=
ed- CommClk-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ExtSynch- ClockPM- AutWidDi=
s- BWInt- AutBWInt-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkSta: Speed 2.5GT/s, Width x1=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 TrErr- Train- SlotClk- DLAc=
tive- BWMgmt- ABWMgmt-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCap2: Completion Timeout: Range ABCD, Ti=
meoutDis- NROPrPrP- LTR-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A010BitTagComp- 10BitTagRe=
q- OBFF Not Supported, ExtFmt- EETLPPrefix-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EmergencyPowerReduction =
Not Supported, EmergencyPowerReductionInit-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0FRS- TPHComp- ExtTPHComp=
-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AtomicOpsCap: 32bit- 64b=
it- 128bitCAS-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 DevCtl2: Completion Timeout: 50us to 50ms, =
TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0AtomicOpsCtl: ReqEn-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkCtl2: Target Link Speed: 2.5GT/s, EnterC=
ompliance- SpeedDis-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Transmit Margin: Normal =
Operating Range, EnterModifiedCompliance- ComplianceSOS-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Compliance Preset/De-emp=
hasis: -6dB de-emphasis, 0dB preshoot=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 LnkSta2: Current De-emphasis Level: -6dB, E=
qualizationComplete- EqualizationPhase1-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0EqualizationPhase2- Equa=
lizationPhase3- LinkEqualizationRequest-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Retimer- 2Retimers- Cros=
slinkRes: unsupported=0A=
=A0 =A0 =A0 =A0 Capabilities: [100 v1] Device Serial Number ff-ff-ff-ff-ff-=
ff-ff-ff=0A=
=A0 =A0 =A0 =A0 Capabilities: [300 v1] Advanced Error Reporting=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESta: =A0DLP- SDES- TLP- FCP- CmpltTO- Cmp=
ltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UEMsk: =A0DLP- SDES+ TLP- FCP- CmpltTO- Cmp=
ltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq+ ACSViol-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 UESvrt: DLP+ SDES+ TLP- FCP+ CmpltTO- Cmplt=
Abrt- UnxCmplt- RxOF+ MalfTLP+ ECRC- UnsupReq- ACSViol-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CESta: =A0RxErr- BadTLP- BadDLLP- Rollover-=
 Timeout- AdvNonFatalErr+=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 CEMsk: =A0RxErr- BadTLP- BadDLLP- Rollover-=
 Timeout- AdvNonFatalErr+=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 AERCap: First Error Pointer: 00, ECRCGenCap=
+ ECRCGenEn- ECRCChkCap+ ECRCChkEn-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 MultHdrRecCap- MultHdrRecEn=
- TLPPfxPres- HdrLogCap-=0A=
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 HeaderLog: 00000000 00000000 00000000 00000=
000=0A=
=A0 =A0 =A0 =A0 Kernel driver in use: vfio-pci=0A=
=A0 =A0 =A0 =A0 Kernel modules: snd_ctxfi=0A=
00: 02 11 0b 00 46 01 10 00 03 00 03 04 08 00 00 00=0A=
10: 04 00 20 d3 00 00 00 00 04 00 00 d3 00 00 00 00=0A=
20: 04 00 00 d2 00 00 00 00 00 00 00 00 02 11 44 00=0A=
30: 00 00 00 00 40 00 00 00 00 00 00 00 0b 01 00 00=0A=
40: 01 48 03 00 00 00 00 00 05 58 80 00 00 00 00 00=0A=
50: 00 00 00 00 00 00 00 00 10 00 02 00 00 80 00 00=0A=
60: 14 2c 20 00 11 0c 00 00 00 00 11 00 00 00 00 00=0A=
70: 00 00 00 00 00 00 00 00 00 00 00 00 0f 00 00 00=0A=
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=0A=
f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00=

