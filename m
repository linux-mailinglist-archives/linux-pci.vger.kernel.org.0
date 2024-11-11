Return-Path: <linux-pci+bounces-16424-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CD9B9C3828
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 07:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B043D1C2074D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41192914;
	Mon, 11 Nov 2024 06:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="cj9UtsDK";
	dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b="vpXSSEhQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B1B1EA80
	for <linux-pci@vger.kernel.org>; Mon, 11 Nov 2024 06:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=60.244.123.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731305077; cv=fail; b=ZZQukADAtvMmWlRCYoDB/xkifC8eHkOxm/HXPhO+8mHuKnjLp6DK2uLRPb2azMNP7Paax0LB82AVajBgAQZfArHpXMmkBw4wtumdpGZuDMcRBpcboh0rPe+f1ikU4/UzdmrfLTK7GGK94A+Fs+e1V58JU7A8xr+iLJ8vYqrkl1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731305077; c=relaxed/simple;
	bh=AaSLvXF2g9NBF96fNgOM9ORfRlcJiznwLE3FAF22/R4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HU2/fZDvgIy7nRIqdocruiekpuaecfXocBRYgY9pQFLwA/MJaUAOkPnmrPQLaEipIbOdgQKaiq7cuG5VNB4lwSOVbPQToxdZIPVeY7Q8tIbbAL4ITSwWXegmFUaLyQjUc+rhiRuKLO8C9U/lhjx8dpdpPasI2EtqCvmCKEbjpBY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=cj9UtsDK; dkim=pass (1024-bit key) header.d=mediateko365.onmicrosoft.com header.i=@mediateko365.onmicrosoft.com header.b=vpXSSEhQ; arc=fail smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: cfa14c789ff211efb88477ffae1fc7a5-20241111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:Message-ID:Date:Subject:CC:To:From; bh=AaSLvXF2g9NBF96fNgOM9ORfRlcJiznwLE3FAF22/R4=;
	b=cj9UtsDKgakhvafLFCG2sCXAC1uyZLaG2JgeOvk7ww5mR0yZJ9TU5AZOwIhuSBQyPGDnBU+I/BJTIu5b7UQLuba5uAmGbFGtYiAe4Ie+8M7+uRLjG7h5Oli3Jh9Dnr000ptE6iEnnmA9turvMA9CZzlzOirmy2ez1nkbiJKKH5o=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:e3f3f604-3fd4-4dad-bfb0-1b23894dd297,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:b0fcdc3,CLOUDID:03a5d7ca-91e6-4060-9516-6ba489b4e2dc,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: cfa14c789ff211efb88477ffae1fc7a5-20241111
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
	(envelope-from <jianjun.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1034317469; Mon, 11 Nov 2024 14:04:28 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 11 Nov 2024 14:04:27 +0800
Received: from APC01-SG2-obe.outbound.protection.outlook.com (172.21.101.237)
 by mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 11 Nov 2024 14:04:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=niK8d1CPSIT+9m8k1o/HfmTxX9FWgi0VqHhOonJf7imZXpxEfknYQoXFKNFHhsdCKyVTxqjBjw1hAXvqNvxjVoj1U8o9RcnnjMYQKYXjLbcyfpC3YQGUYMCjnu6RP+1/T2pnhYtZ5a6ddvsHxFkRH+JOVC2AhO3bh2ziMZ9WV3MSQsU//9eGD+9tmfsu/FOzBmW86m2bW8y72HJYXMBySOLlZKCz4nxRiKHd+sNUZw/Oklc/HTR23NfJLkc8AI7+v7kNBHynIk3xdjuk2IhpuKIl31YZUuYQIC8OAeT7esinl8oP2wARyALvO9F7iiBsbwt7IbAkWicpCwwwPLbkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AaSLvXF2g9NBF96fNgOM9ORfRlcJiznwLE3FAF22/R4=;
 b=L5K0KvCE5QOzAK5RP2EXNC8cZ2j0CXtuqI7FGR1M95cCr40Bg80OZB0Mk6afn8v7dkCpaZwFJhRvIE7epVj6ze5VcMhVlbThm1CfuMYEQb0kK63qv9x9ZBGWJjJtDG3Ur1QroTR5pdpooUv1ne1oxDl7ZuWPGzBCIOcs7WAjErTuUUJiDys1JacPJrawrGaEVZKAj2oqhHkwn9qqBVC1Pw82AHIcAVigo9DL8gRSVA4rAklon68fTtSWPi7rSy8tvLyBowvBknD/bBtPRmOtBhZYc4VRzTq3rSLGx02ZHJD8mwnWHCnAiJXGk1vduK+YVQj175Q82v/UZNwuzlTPfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=mediatek.com; dmarc=pass action=none header.from=mediatek.com;
 dkim=pass header.d=mediatek.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mediateko365.onmicrosoft.com; s=selector2-mediateko365-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AaSLvXF2g9NBF96fNgOM9ORfRlcJiznwLE3FAF22/R4=;
 b=vpXSSEhQtFZTzcA99gyxrhUNQQABsdozbxP34jvztbvhag6yeHC5j8Ax3Hbk/YVDg/6mg/KhZAUdu7qImzgf6qpywaIx8P5sHlGwewEqb8hz9fU+h4nBBTBorgH4TLIc5/Aw2UH4g3o4mmFVwPqBxfT6HzeFyYVSgLH6zSlHMk4=
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com (2603:1096:301:17::5)
 by SEZPR03MB8566.apcprd03.prod.outlook.com (2603:1096:101:216::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.22; Mon, 11 Nov
 2024 06:04:24 +0000
Received: from PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6]) by PSAPR03MB5365.apcprd03.prod.outlook.com
 ([fe80::1c6e:6591:5151:27e6%4]) with mapi id 15.20.8137.022; Mon, 11 Nov 2024
 06:04:24 +0000
From: =?utf-8?B?Smlhbmp1biBXYW5nICjnjovlu7rlhpsp?= <Jianjun.Wang@mediatek.com>
To: "lorenzo@kernel.org" <lorenzo@kernel.org>, "helgaas@kernel.org"
	<helgaas@kernel.org>
CC: "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
	"manivannan.sadhasivam@linaro.org" <manivannan.sadhasivam@linaro.org>,
	"robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "bhelgaas@google.com"
	<bhelgaas@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
	"lpieralisi@kernel.org" <lpieralisi@kernel.org>, Ryder Lee
	<Ryder.Lee@mediatek.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Thread-Topic: [PATCH 3/3] PCI: mediatek-gen3: Move reset/assert callbacks in
 .power_up()
Thread-Index: AQHbMRw97PA6QAWRm0+g05S2U5zNfLKr8MeAgAALsICAALC1AIAAZB2AgACFbwCAAAeIgIAAA54AgAAB3QCAA/kogA==
Date: Mon, 11 Nov 2024 06:04:24 +0000
Message-ID: <026a225fde4f4e499f75c24551bbce3199a8d2e7.camel@mediatek.com>
References: <Zy5EjY_oQaRbb5MY@lore-desk> <20241108171710.GA1667022@bhelgaas>
	 <Zy5JJuAsxPqEos4I@lore-desk>
In-Reply-To: <Zy5JJuAsxPqEos4I@lore-desk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=mediatek.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PSAPR03MB5365:EE_|SEZPR03MB8566:EE_
x-ms-office365-filtering-correlation-id: c63c6291-aa6b-4c75-8c6a-08dd0216b12a
x-ld-processed: a7687ede-7a6b-4ef6-bace-642f677fbe31,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?QStLWUM0S01NYXhpYURTRkF6eDR6K08yR2FDWGxDSDNoZEZXdVUrUldHMWhv?=
 =?utf-8?B?VDRpMzZOaEJ0ZEpjbWxpaTRyUWsxL2pzaWVNdFdqTkI4V0JER3ZVTlA0ZW1h?=
 =?utf-8?B?SjlMUWdML2ZFeVV6UHR1VitaWjZDRHdhUUtCUGJGTi8zZ3c2Y3BSVGhZdjJt?=
 =?utf-8?B?bVlabmZNZDFkTTFOd1pFdW5DMVpIUW5NQlBOOGNQL0dURXpITnpyOHVNa2g1?=
 =?utf-8?B?dDlCeU1JelErWmRjczQzYk0reXZuRUZGTzR3eXcrbEZNVzI1RWNySS9VTVYy?=
 =?utf-8?B?U2gyUmM5UlJkcktqOGFvaGxxVGhhbHJmWE5LYm5rUHQ4WW5Bc2pKN3BiTHQv?=
 =?utf-8?B?bDRiYmxuL0ZjVDhhUE1uUENnMlBuNGRrV3BYSnVaN2wwUTB4a2Rlam1tNjdI?=
 =?utf-8?B?YTNvYzBBQTMrMmlwUUszNm0xQmlLbHNwcTFiNVRTS1FlT2J1amJrK1F4bC9H?=
 =?utf-8?B?T2hWSFUyYVVVR3VjTFFlZXVHS25NVllWSEJlOVVHOGlqNlpVV000YitPMElF?=
 =?utf-8?B?VUVIM2FTSFc0MStzbmtvc2R1VnRuQVdwRHRkVWJ4QmZuY1JSRHM4VWtYMGVn?=
 =?utf-8?B?aFhUN0F5eDFHNDViemM2ZjJkcVJjQkN5aFZKVXFhZ3AyOHdNbUZuaGhUY003?=
 =?utf-8?B?d2NCTGpzMzJWM05HZTNCODl4SnpPZE1JaTJnVU00ZWxIMFBYT2FkZUxLbERi?=
 =?utf-8?B?SGFjbXZvaU1HeGtBMXlzeU5WaXpId0dYZU16VUY0NGluYkRsQ3hJendRb25P?=
 =?utf-8?B?S2ZLMEdTSVRjUVJwckpEYnplL3E0RmVkaDVVSmNvcE16R0xaV3JGVHB0NVdj?=
 =?utf-8?B?ZWc5QldqTUJEUHI2Q2ZaQ3ZIQ3RWSDFxN0wrSjd1MFluTWdaSGM1b3RxV0xV?=
 =?utf-8?B?eURzQ3RZVTZLTW1YenJlWjhqQWZQbWo0eEUxdTlKWU1ocUZKN043M3VUYjBS?=
 =?utf-8?B?VTRXa2dQbWxDZ2grQkJRYkpXZmo1MnFiRFpsR05Fbzd6bjVyYW43T2JWNFpi?=
 =?utf-8?B?dC9ESGhMQmIxaVRyaFFUdEprSCtzTi9oVlNjUEc5OXVtNzVTcHpVaXNENzBM?=
 =?utf-8?B?UFAvRFk3QUZmc2lxRU4wdjcxQXhabHJVdHk0eWlKZXRXTDloUFR5ZWIrMTV2?=
 =?utf-8?B?OVlJaVM0aWxVRlVIcUQyYTdwbVRTSHJwYmxUWVhIZ0VoL3QvZmtVMVM2bG5m?=
 =?utf-8?B?eGVqeFZLWmdyLzZIaEo1c3lhVmlpQTRzQkk1bHl0aitxT25hcytUQTVPNTRU?=
 =?utf-8?B?YjY1dzlNRHJGYUV1QngxL1pGOHhUelFTcG5PTVk0eVJlOU9aNnVOcUVJZG00?=
 =?utf-8?B?MGdYcHFkZUkybndGUUtrSGJqWlVyaDBWR0N3ZlJUQVpYeUJsNUhxekw0ZnV2?=
 =?utf-8?B?dVBUTCtqaWExS0Q3Z3FUVTg2dUhpSy9rOVA1eXpiUXNmTi9RWWVNVHJZb21C?=
 =?utf-8?B?eHRJU3RkR3JTNFhjUFYvZjFQazJnV0U5dElSbkhQMVpCSE9XUGU1cFFyOExq?=
 =?utf-8?B?VnhITHRNQ3NrNGNzRE9MN2pwbjdhSStmV3pyS2lFMHRrVHdhZldZRUxGMmFV?=
 =?utf-8?B?UWdtUHF0TmJETjY1VmdEWndzZlo0TzdybnVXV3FUelNSRFkzcTJLMlVBbmtE?=
 =?utf-8?B?U2xUSTAwWk9wTWJ6UDlVakVURTNYUkJrWGdjd0wxMVJCdFZCK0dELzdRMWx0?=
 =?utf-8?B?Q24yOXVoQXhLc1Q2YS9ub1k5L0wxeGRSYTdWYlJCbzhZUG94aXZNUUVBcXNJ?=
 =?utf-8?B?WDR6U29mVnIweGJRVTBnQnFKNndhc09iZGFkSzZ1NzY2d3lQOFZrZWpCbDVU?=
 =?utf-8?Q?PO8g3hjaU7rng244KhQ1BRLd1YOn1FSBMi8Cs=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR03MB5365.apcprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bW5INmpkS3cxaTdLNkREY1c4bEtxeFVPQk9ZdUFvMXhkYnFVWisyWXEyRVdO?=
 =?utf-8?B?aTMxRXFZVjVINmsraFpnOG5NRkdUSEdOdnFFZnJubXhHSDE0WnhSbjl1aERy?=
 =?utf-8?B?L1djMG1XZU5qdDRDSTFBOFZHajRtMFBzYU82VGNGZzBqcmxDMEJRcHRnUnJl?=
 =?utf-8?B?UDYyTUR6aDkzS0pjUURqaGZVMFFCLzQ1QVRXUi9IL3BQZkpxL3c4OHM5Ujd0?=
 =?utf-8?B?UXhzRzdUeXFIbHhZTUNhTis2SW5tK0EzbE9pN1RrQkVMZzhMcGs4WW5iWnNC?=
 =?utf-8?B?d09KQ1NQUjVwN2JXQUNCZlNuZ3JZNVFQaFcvUldxbjN0ek9xWnpNeEZnNWJh?=
 =?utf-8?B?elZBeDZrTXVVckEyQVpFQUg4eWR2QnFYamtmUHQvckZGQ2I2V09Gc1FVMG1z?=
 =?utf-8?B?K2RWOS8yN2p4MTY0Z25nVjVpc0c3QW5hc0tjaEV3TFFsQi9yKzNJR3hqSjlr?=
 =?utf-8?B?MnE1ems4bGZFSUlmU2xpNkxkMnVtSmhGMDQ5eHZxMW90alpDTC9SVW94MjlP?=
 =?utf-8?B?d2NvQndNOXBJVTJkMXZReDhaVlh6S1A2aVRqYTNZZ0FNZzd2b2VHMisrZnJr?=
 =?utf-8?B?Nk1rNnRXWHFSMVZMZkdDU1U2cFBJL1RVSUpRa2o4c0V3azFuNytuZkVUUjZO?=
 =?utf-8?B?T1NBZWNFbkxVaUFicU5pQ1IySXZRczZQVFRQNWxaNkVNMm05QmNaT3l1NFdJ?=
 =?utf-8?B?YVlrZnkrTHZCZUZpcGJBejZjYmFEN0FZaVducTNaMDNZZUpndy8zQk1tS2FM?=
 =?utf-8?B?MnR1Ym13WnpZTTFZVjUzdmJLaE1VRDJoV21VYXp3VDlHSnZGcTVaaUJkVWpJ?=
 =?utf-8?B?V29WOExIRUhCSlFxRUx0ZnFYZ3RSS1Y1bk9QOGpydkF0d09oa3k1dSswRFRT?=
 =?utf-8?B?Qklrb3dyQXpkT3JIYkhwaUVxOHBhblFhck44ckcxOWt4RVZtZjlpSzIvQWk1?=
 =?utf-8?B?ZXJVTXc2Z24yaHVOeFo4YXdRMzdTMVJhcmYrZ1lWeSs0NnZMbFF0Rlh0WmZC?=
 =?utf-8?B?WUNJUmQ1YzNGQm9IYmI3bDVnV25CZXBqS1pnaXNWQlZFMUQza2swcVM4OVdr?=
 =?utf-8?B?ZTBEbHhCYU9oTTF0QmpsRUt3dFhjY1hLa2tIaXJyNVREMXhsQ09tbXllclEz?=
 =?utf-8?B?VS94ek1LYmkwWW5DT29xUmFUUWcwM2pTeHM0M0RhZTBjMEFwdWFrNm4xZkM3?=
 =?utf-8?B?RStGZllVUUJQSElhSlkwTmpGeVZ1elR6RmwzQWFYeCtKaThlR2IxUS9vc1Vx?=
 =?utf-8?B?ajhPdlhiSWwwbVZyVUMwMmdIZGd0NlBQZU5mUTAvNHlOSVpXMndSUEJwWG1N?=
 =?utf-8?B?QTRkRW9lc1FEazIxWGloTmI2THMxMzNmRlNhcEpyZENQT2xMYnVLVTNDY3dR?=
 =?utf-8?B?WGdpMU1sMmZ5NlR1K09VRUVQTC9SUmpHS2FmTzdSVWcyb0w2QlJ5Z1FnWndx?=
 =?utf-8?B?aUovaWRSaEZ5T3NINExkVStjWldjQnZjQ000VTdFcUZKU2tQN2d1MG13U0U5?=
 =?utf-8?B?MjBJekVuWWgzQ3c4U1RTK2E4VUtQUHIwMm9tM2p5TVluVTVFK0NjdzZ0YjVu?=
 =?utf-8?B?UUdtMGtSQTVFSHhlRjQ0cytDNEx5SUMvZ2U1Q1NlQlNtVGVVVUp3cmVKRzE1?=
 =?utf-8?B?M0NSQVZQU0MzT241eWwxbDVwdnNiRnRJOHAyem9pYWlZUG9kR2VpZXJ4akgv?=
 =?utf-8?B?NzFjL1FKbWZZUGpDdVZGZG5UeUtjTDhVT1U5N1czcmMvbkc2c2FiTE5MVVlU?=
 =?utf-8?B?OEM4N0NmRHpiMk9xSURPTVZCT3c4ZjdRMlBEcml4WDl2OE44RjEydU9OUHVH?=
 =?utf-8?B?b3V0ZnVCaFpXUUJTeEEwdVdxTTI0eDJ0b1VwaU9PMGpsNUZDWkZtejAzU2FY?=
 =?utf-8?B?bTg4RWdqQjF4a0FNeTc4SEtRQitXTWx4bXdTNDdhTWdoWUFYdjNIYmtvaFF2?=
 =?utf-8?B?TTVsUms4MkplREN6WjFPOEZVZnZrRElLczBKM1dWM3cyRFJTdEEwNDJkcmY3?=
 =?utf-8?B?U2NhOHB6dnFHQytuTEdRSTNleGprRjlQckNWM2cxQzFPNWZ0WVJPTUcyUHlN?=
 =?utf-8?B?RjFZNzRHM3UxdXJhd2YxQm95NzB5WXFTcE1UQnAxMTE1NjZYY0o1TnBqWnBT?=
 =?utf-8?B?anhaUTZzVU9IOTdKTk01elhVdmhXY2FYTHlEdWExYTViOWIzcjdwaVh4ZWpX?=
 =?utf-8?B?TlE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E54E64DBE88F17459C8D84D476C8ADD3@apcprd03.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PSAPR03MB5365.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c63c6291-aa6b-4c75-8c6a-08dd0216b12a
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Nov 2024 06:04:24.1128
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a7687ede-7a6b-4ef6-bace-642f677fbe31
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VHyznBjmvAMUuNSyqkXcR49VBPNWkEBJgXyhcGEVhnwcEf5zKtV3CTkI24+an/9hzXv9NN/97USBZXBYrPsldAKOr2BPv8R3ZN2SXphgmik=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR03MB8566

T24gRnJpLCAyMDI0LTExLTA4IGF0IDE4OjIzICswMTAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3Jv
dGU6DQo+IE9uIE5vdiAwOCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiBPbiBGcmksIE5vdiAw
OCwgMjAyNCBhdCAwNjowNDoxM1BNICswMTAwLCBsb3JlbnpvQGtlcm5lbC5vcmcgd3JvdGU6DQo+
ID4gPiA+IE9uIEZyaSwgTm92IDA4LCAyMDI0IGF0IDA5OjM5OjQxQU0gKzAxMDAsIGxvcmVuem9A
a2VybmVsLm9yZw0KPiA+ID4gPiB3cm90ZToNCj4gPiA+ID4gPiA+IE9uIFRodSwgMjAyNC0xMS0w
NyBhdCAxNzowOCArMDEwMCwgTG9yZW56byBCaWFuY29uaSB3cm90ZToNCj4gPiA+ID4gPiA+ID4g
PiBPbiBUaHUsIE5vdiAwNywgMjAyNCBhdCAwMjo1MDo1NVBNICswMTAwLCBMb3JlbnpvDQo+ID4g
PiA+ID4gPiA+ID4gQmlhbmNvbmkgd3JvdGU6DQo+ID4gPiA+ID4gPiA+ID4gPiBJbiBvcmRlciB0
byBtYWtlIHRoZSBjb2RlIG1vcmUgcmVhZGFibGUsIG1vdmUgcGh5IGFuZA0KPiA+ID4gPiA+ID4g
PiA+ID4gbWFjDQo+ID4gPiA+ID4gPiA+ID4gPiByZXNldCBsaW5lcyBhc3NlcnQvZGUtYXNzZXJ0
IGNvbmZpZ3VyYXRpb24gaW4NCj4gPiA+ID4gPiA+ID4gPiA+IC5wb3dlcl91cA0KPiA+ID4gPiA+
ID4gPiA+ID4gY2FsbGJhY2sNCj4gPiA+ID4gPiA+ID4gPiA+IChtdGtfcGNpZV9lbjc1ODFfcG93
ZXJfdXAvbXRrX3BjaWVfcG93ZXJfdXApLg0KPiA+ID4gPiA+ID4gPiA+ID4gKwkvKg0KPiA+ID4g
PiA+ID4gPiA+ID4gKwkgKiBUaGUgY29udHJvbGxlciBtYXkgaGF2ZSBiZWVuIGxlZnQgb3V0IG9m
DQo+ID4gPiA+ID4gPiA+ID4gPiByZXNldCBieSB0aGUNCj4gPiA+ID4gPiA+ID4gPiA+IGJvb3Rs
b2FkZXINCj4gPiA+ID4gPiA+ID4gPiA+ICsJICogc28gbWFrZSBzdXJlIHRoYXQgd2UgZ2V0IGEg
Y2xlYW4gc3RhcnQgYnkNCj4gPiA+ID4gPiA+ID4gPiA+IGFzc2VydGluZyByZXNldHMNCj4gPiA+
ID4gPiA+ID4gPiA+IGhlcmUuDQo+ID4gPiA+ID4gPiA+ID4gPiArCSAqLw0KPiA+ID4gPiA+ID4g
PiA+ID4gKwlyZXNldF9jb250cm9sX2J1bGtfYXNzZXJ0KHBjaWUtPnNvYy0NCj4gPiA+ID4gPiA+
ID4gPiA+ID5waHlfcmVzZXRzLm51bV9yZXNldHMsDQo+ID4gPiA+ID4gPiA+ID4gPiArCQkJCSAg
cGNpZS0+cGh5X3Jlc2V0cyk7DQo+ID4gPiA+ID4gPiA+ID4gPiArCXJlc2V0X2NvbnRyb2xfYXNz
ZXJ0KHBjaWUtPm1hY19yZXNldCk7DQo+ID4gPiA+ID4gPiA+ID4gPiArCXVzbGVlcF9yYW5nZSgx
MCwgMjApOw0KPiA+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiA+IFVucmVsYXRlZCB0byB0
aGlzIHBhdGNoLCBidXQgc2luY2UgeW91J3JlIG1vdmluZyBpdCwgZG8NCj4gPiA+ID4gPiA+ID4g
PiB5b3UNCj4gPiA+ID4gPiA+ID4gPiBrbm93IHdoYXQgdGhpcyBkZWxheSBpcyBmb3I/ICBDYW4g
d2UgYWRkIGEgI2RlZmluZSBhbmQNCj4gPiA+ID4gPiA+ID4gPiBhIHNwZWMNCj4gPiA+ID4gPiA+
ID4gPiBjaXRhdGlvbiBmb3IgaXQ/DQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBJIGFt
IG5vdCBzdXJlIGFib3V0IGl0LCB0aGlzIHdhcyBhbHJlYWR5IHRoZXJlLiAgQEppYW5qdW4NCj4g
PiA+ID4gPiA+ID4gV2FuZzoNCj4gPiA+ID4gPiA+ID4gYW55IGlucHV0IG9uIGl0Pw0KPiA+ID4g
PiA+ID4gDQo+ID4gPiA+ID4gPiBUaGlzIGRlbGF5IGlzIHVzZWQgdG8gZW5zdXJlIHRoZSByZXNl
dCBpcyBlZmZlY3RpdmUuIEENCj4gPiA+ID4gPiA+IGRlbGF5IG9mDQo+ID4gPiA+ID4gPiAxMHVz
IHNob3VsZCBiZSBzdWZmaWNpZW50IGluIHRoaXMgc2NlbmFyaW8uDQo+ID4gPiA+ID4gDQo+ID4g
PiA+ID4gYWNrLCBzbyB3ZSBjYW4gaW50cm9kdWNlIGEgbWFyY28gbGlrZToNCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiAjZGVmaW5lIFBDSUVfUkVTRVRfVElNRV9VUwkxMA0KPiA+ID4gPiA+IC4uLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiA+IHVzbGVlcF9yYW5nZShQQ0lFX1JFU0VUX1RJTUVfVVMsIDIg
KiBQQ0lFX1JFU0VUX1RJTUVfVVMpOw0KPiA+ID4gPiANCj4gPiA+ID4gVW5sZXNzIHRoaXMgY29y
cmVzcG9uZHMgdG8gYSB2YWx1ZSBzcGVjaWZpZWQgYnkgdGhlIFBDSWUgYmFzZQ0KPiA+ID4gPiBz
cGVjDQo+ID4gPiA+IG9yIENFTSBzcGVjLCB0aGlzIG1hY3JvIHNob3VsZCBiZSBpbnRlcm5hbCB0
bw0KPiA+ID4gPiBwY2llLW1lZGlhdGVrLWdlbjMuYy4NCj4gPiA+IA0KPiA+ID4gTXkgcGxhbiBp
cyB0byBhZGQgaXQgaW4gcGNpZS1tZWRpYXRlay1nZW4zLmMuIERvIHlvdSB0aGluaw0KPiA+ID4g
UENJRV9SRVNFVF9USU1FX1VTIGlzIHRvbyBnZW5lcmljPw0KPiA+IA0KPiA+IEl0J3MgZ2VuZXJp
YywgYnV0IHNvIGFyZSBtb3N0IG9mIHRoZSBvdGhlciAjZGVmaW5lcyBpbg0KPiA+IHBjaWUtbWVk
aWF0ZWstZ2VuMy5jLCBzbyBJJ2QgZm9sbG93IHN1aXQuDQo+ID4gDQo+ID4gQ29ubmVjdCBpdCB0
byBsYW5ndWFnZSBpbiB0aGUgTWVkaWFUZWsgc3BlYyBpZiBwb3NzaWJsZSwgaS5lLiwgaWYNCj4g
PiB0aGUNCj4gPiBzcGVjIG5hbWVzIHRoaXMgcGFyYW1ldGVyLCB0cnkgdG8gdXNlIHRoZSBzYW1l
IG5hbWUuDQo+IA0KPiB1bmZvcnR1bmF0ZWx5IEkgZG8gbm90IGhhdmUgYW55IG1lZGlhdGVrIHNw
ZWMgZG9jdW1lbnRhdGlvbg0KPiBhdmFpbGFibGUuDQo+IA0KPiBASmlhbmp1biBXYW5nOiBpcyBQ
Q0lFX1JFU0VUX1RJTUVfVVMgZmluZSBmb3IgeW91IG9yIGFjY29yZGluZyB0byB0aGUNCj4gYXZh
aWxhYmxlDQo+IGRvY3VtZW50YXRpb24/DQoNCkl0J3MgZmluZSBmb3IgbWUuDQoNClRoYW5rcy4N
Cg0KPiANCj4gUmVnYXJkcywNCj4gTG9yZW56bw0K

