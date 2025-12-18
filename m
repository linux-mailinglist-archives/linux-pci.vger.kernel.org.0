Return-Path: <linux-pci+bounces-43267-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BC0CCB055
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 09:53:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47E94300548E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Dec 2025 08:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C25E2147FB;
	Thu, 18 Dec 2025 08:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lWi0Jt+V"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013036.outbound.protection.outlook.com [52.101.83.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1747F78F29;
	Thu, 18 Dec 2025 08:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766047740; cv=fail; b=VhNAzft+v09SwMop5frjef7F8nKfwEtMTPsC836DN4nSeci8V+O2T3cHM0kOeabG4we/lDnvGCi84ja1jKgmJhf/VUPR0u6ywmUBB6iMHg3d4z+vtJT9VI3Ozg6eD5wzuc6hJrlzjterSmsRLA13VtbUPzkfxDMy1LxiTOT2fuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766047740; c=relaxed/simple;
	bh=oABtXFTlkpTR1D1+6sj5bf91qb1FX1QDoY/XgWTvpf4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NI8deSV5Uyt0OSEHgbMoTQeXeyhEy7iDSaYWVFFODopHZQBdW35l1R8sYKfMl7OBAmddRKnkHONUyqtDG7lF/Ol7+8kZOfbF0U8Rbgcm34RUvVWHU6Z34eliaX17T0846/sUhTi7ekjZexmvG73p1lyeIIZRGs70tKCO+wefmVE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lWi0Jt+V; arc=fail smtp.client-ip=52.101.83.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/JNiP7FuLlc4Pt2brliVph03k4qnMYIHN1Be7A0oKtTN5firdWUJm5J0eytbV+AQrQQCimwsm/63JE1b34c7zJFW1Lzy9ggWslwyGKIOsqllVlFpQCfibsz61iD4qF5Vsz3LCj84+aMzOBNeGVJKS753b6bm/oxnZsGq8V4hLoNEIdNX2Y0J9iF8Cw/QBE/Dx1n7FcY2N5rP5DXJMzarvcvMvDM7517n4LibsFw6H5XOjb3k+RFjQcWV5/EtHZF3AezEC3ttmFPmMk/e6DplpOHMZYQSLok6rmm/a46cHgOebAIAjZ9cWJlIKm2GQdwLpLgR747EHYpGuYqMjyZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oABtXFTlkpTR1D1+6sj5bf91qb1FX1QDoY/XgWTvpf4=;
 b=spBo7QxrzPq3uIEo5qVr6WEHNPK3bO5WLO4MqVP18fb+hc0OElIRv4UYMLVmAL2sPNrPa2Ixahi+h1LUZcajwoHhnE3+yGdoEnSXkeQLVWO9r2RIuoUc90xxuCwWuX7F5hVaiw3BMwGxFnT+qkpl9dta/ZvAjpL0H/tCPhllvnZgB/gpxxewmLsiiXu8FGNo/kAMU3BnDxBMzPp6YjR+GJ83avjVtXXpYHWi6dmtXw5ip1x3FrwWLLaA8kg2iqi+AF3gI3HPyztbtuzkq+494uq36c66tcPwEm0B28Wqf/YE50St+BW15ljxOCrq9ZfmbLDWNoI5NffzUxHc7WxqhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oABtXFTlkpTR1D1+6sj5bf91qb1FX1QDoY/XgWTvpf4=;
 b=lWi0Jt+Vhh0wRxMVOWRseb5m3dUIE1IVcL2xaw2V6G/+g56SPXWqywLGIAVgIBzffnyB1s81aDJ0fOlO6IGyqcM5+yZ3qLZdCobBZQ99q8Tkjx6Lf3txcQwESd4DNbOb2FWpUBX3jrbFYIQcyizhlXEf3gyRTqxPExREEszmytP5MTbCFcSgBPlqfCuLEtk1nnnBKMmoxyVYBxlsg1IN5ydFhe85YzYFmeoxk+/WciGeq+qioQUvtM5m00aEGvtmW/bt+KZiHQGZ508KthJ+jXEOsPW/Komnq+1CPPAbHups/mVDjjR2jeECzawRuIDQiZEh/+idVTd6hpXugoeGZA==
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA1PR04MB10553.eurprd04.prod.outlook.com (2603:10a6:102:485::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.6; Thu, 18 Dec
 2025 08:48:54 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9434.001; Thu, 18 Dec 2025
 08:48:54 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Manivannan Sadhasivam <mani@kernel.org>
CC: Shawn Lin <shawn.lin@rock-chips.com>, Frank Li <frank.li@nxp.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Jingoo Han
	<jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?utf-8?B?S3J6eXN6dG9mIFdpbGN6ecWEc2tp?= <kwilczynski@kernel.org>, Rob
 Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
	"zhangsenchuan@eswincomputing.com" <zhangsenchuan@eswincomputing.com>
Subject: RE: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Thread-Topic: [PATCH 2/2] PCI: dwc: Do not return failure from
 dw_pcie_wait_for_link() if link is in Detect/Poll state
Thread-Index:
 AQHcWX/Z1gYkRLXMSUaRfofEExV5hbT6wrwAgABJxICAAYvSgIAAu7+AgCnlsQCAAAY4YA==
Date: Thu, 18 Dec 2025 08:48:53 +0000
Message-ID:
 <AS8PR04MB8833BDE50B260CE235DF51258CA8A@AS8PR04MB8833.eurprd04.prod.outlook.com>
References:
 <20251119-pci-dwc-suspend-rework-v1-0-aad104828562@oss.qualcomm.com>
 <20251119-pci-dwc-suspend-rework-v1-2-aad104828562@oss.qualcomm.com>
 <40e3197b-1670-4b63-a973-98012bcc623a@rock-chips.com>
 <jmysdqydimjl7min6dw34bdcf6hiyk3pqb4plzvzl6folgat5n@v55h5i7pufg3>
 <AS8PR04MB8833807ECE928024892B73408CD5A@AS8PR04MB8833.eurprd04.prod.outlook.com>
 <yfag3ox6ifg5nvi4ayfcx3mvj5zfn2d2quwiakuczp7o3lwuy6@t3n4h23fsmiw>
 <paykevybcrzshvgcyenc6dfb5bv7iakr3p2j4gi37xznlfqq6g@por767desr3f>
In-Reply-To: <paykevybcrzshvgcyenc6dfb5bv7iakr3p2j4gi37xznlfqq6g@por767desr3f>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8833:EE_|PA1PR04MB10553:EE_
x-ms-office365-filtering-correlation-id: 7939375d-ea4a-465b-6079-08de3e124626
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?QjRpYTJyNlpkMVRhbXlBTkczcERpN2RieXFWWHNodmlUbElteWdHMTAyUWZy?=
 =?utf-8?B?Rm1sRjFOakdLU2pIdXd1elhOcDJFYkRTT1hFTmpuTmMyOXdXMW1lN2VQSDJC?=
 =?utf-8?B?UkhnTlBmUXJrUitCWGo2Yjh5NUJmdExMYXdKTk1qREdxdytLeGlBUWR6dkVo?=
 =?utf-8?B?cm9XL0hHWHFBSnl4V2FRclNGRlFLOXBLOUR4U0lNV28rdGREWENqSklpWFdB?=
 =?utf-8?B?aXd1ZmNBOWlhdG5rTHl4TlhTemJXMUlkaFVSdDcxanZqc1pFc2YxSHZyU3U4?=
 =?utf-8?B?OGtwRi95c1g5bEFQdEJlaDhYQmJFRk1UR1l4UEVGa2podVFMTVlXMWxBRllB?=
 =?utf-8?B?NVAzUXNOQ3ZSNjhFZ3ZlbXFCVEZRbk5GcS83cFcrRll3c2RhSHQybmJMVzJl?=
 =?utf-8?B?eW5scXZ3L2MzT0FVZGxDOTRZVktWbW9jdmgrUys5RXc4cmlXbWxHVCtKdFZ5?=
 =?utf-8?B?bGdpR3BlSG5zREpwZGY4L1JlZWFxYURJZ09jOWdzT0ZDdEh5ak51K1lVUUZO?=
 =?utf-8?B?Risxa0wxZG9LQVk4eEcyRnovTGZIT2hJalNzN2hsdk85eVQ0MVVaL0R5VVFW?=
 =?utf-8?B?UUVuSFYyamxZc1liVUd3ZzBwdlpMUE8xek91aHBnYWNBOS9JbU1vNml2RC9r?=
 =?utf-8?B?cVpGaDFtckxiSTZlMld1U3p2YXRnaTRmWHBFMTFkYldyRlY1NHpNNXg3Nlox?=
 =?utf-8?B?RVVsdGcwdUNZZCt5SGJPOFFNc3k5bFhzdjFjdmNxWFBveUZiSG5sbVhoT2ZI?=
 =?utf-8?B?aFBCeG9rSjB4VXFvbFFtVmF5dVY1Z0ZLUDVLMzA1Si9ZdXNIN29FNGZuZE14?=
 =?utf-8?B?ZHVxWFBWVlowLzRSa0gxZGRuakJ2aHRMMFpWNTVud2dwVi9RQ252d1YwK0Nw?=
 =?utf-8?B?YnNFbXFlVTUxdGRFL3J2RVYvSmdLUHRUeng0U2xWNEwyVEtCR3NadHY4d1Zp?=
 =?utf-8?B?bFlFUXZCQytFaW9xUE5heGtOa1lsWWNVM1lidjdRVUQrRURvRVhWclU5SjlW?=
 =?utf-8?B?Z0o3NnVDT3h6bk1OSTRuWnNEK3dabU5SeU5IRmpYdVZ3S2gxRnRBNTZpYlRq?=
 =?utf-8?B?alVjbytrRm1Tcm9XZmRucFhSZWNYNDltdWVEUGNmanhDYTZPNER5dWlTT2RF?=
 =?utf-8?B?ckRwMnlnTnhaQjNQZDVJOUhDUjBuanhqK3R5aWp2UlpKcGJBYnozNFlGcXp5?=
 =?utf-8?B?bTlEWWVHZEpRZzZwam14ajltU3FiQm9NWjMzN0ZVa2dYZXJUZ1FXZklVMnFV?=
 =?utf-8?B?bExGV3IzQ0RiVUhFT3JsNnVwK0dTMCtFbGZ6Tzd2bjhQUThzVWkwenhqTjUz?=
 =?utf-8?B?S1JMcThLaThXTmFZSzFORVJuemNZSFVOLzlnQko4dWdtOEpOU2lWYWowT1Ra?=
 =?utf-8?B?YjZ3SUxlcWNYanhVNWhXNW92RkExalY4YWN4ZmZmS1FidmFXRjlUZStXSndo?=
 =?utf-8?B?ZFpydG9hZ0JGYmc2VVpWWXFRUGZZQks5Nmx1UGxVTDFZYXZFVmYwUWRNZUZs?=
 =?utf-8?B?Sm9jeUJSZVFPZFJSaU94NS9YcW1ZVXJLcWNURGhFRFppQmVoZ1dXM0NUeVlx?=
 =?utf-8?B?RGxpLzlUT3d2U3BtcWNjUlF4c0hJUitZeHllMFRLSGdzZVltMGpROFpxZ0R3?=
 =?utf-8?B?Wkp4djE2bWs0d01DMHVqMmY3SjYxbERxTzg0NCs1M1BCQy9EZWpMcWM1YS9t?=
 =?utf-8?B?Zzk1WEcwUUVTbnNTMUd6SXBGSm1yejdsd1Y3b09MMXlJV1VKVlliNTZCWERW?=
 =?utf-8?B?MmxXVlZjQk53REVwSlFDZEZkQW8rdnFDeXV6dnpjQm1RSmhqbDFySmcvemNY?=
 =?utf-8?B?NHJlTnU5dlZaUHRqcTFJYUNMUmJLNXUxY0FUTmJZaHRRekFoVGJoQ0IzN09v?=
 =?utf-8?B?Q3REYjQ2VHNYMS95TVpRMjdmcXY2U2szNUN6a3FGWmhtbHBZTTFqdWRsb3o5?=
 =?utf-8?B?b095c1JHeHdIK0ZPL3NJS2xHT3ZOYXYydU4xeHdnalZGVlY2UzdqbFRSUUMv?=
 =?utf-8?B?azJPVzYwUlR3PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?N3FMSWR2L29Wcm5tRG1CeU1qdzlvSFRCd3Y4MlQ1cFI1bTIyNHpjSlFSUGU2?=
 =?utf-8?B?b1RMbTQyNHRoUjRia1YxaUFET2lvcWpsbFlyOHRlSDg3bktBYlRyWmFnY0RT?=
 =?utf-8?B?RXpIRXZYUTF3VlJRQUZBMzhrb2xMV093N29Pd1VTZUVLZk83Q2dBUnZBM0RP?=
 =?utf-8?B?RmlqT3piYzVtU1BrbVNBd1liMWJIOXhVTnhhL0hHajBMRHVmWmdybHZ0aUVH?=
 =?utf-8?B?ckZyK3IwYWwyOTJIRHVmaDcvTTFJUWdPRVR3aDlTSVVPU0d2K2JYKzI0cldN?=
 =?utf-8?B?U0xGbmwwdzhoU0dWWGw3RkZxbWYwU1ZBZWFVYTE4UjZ1MlJLQU9nQTF6Q0tW?=
 =?utf-8?B?N1dJSmp4QXFWbW9aT3J3UnlmOG1xVEFYSzRtM04rOUZ5cERRK1ZVQ0hiTlBy?=
 =?utf-8?B?YzhuekZkQkNCc0xVSnRHdEIzNGV1SzFxbjY1dTBEZjNmeG5xWUxpcTdQTzFj?=
 =?utf-8?B?bjlvZ2tzcTBGd0hTaUR0R0FyWmpLVko2UFB1VkFRRGFmcDNXR01pUGQwbGFx?=
 =?utf-8?B?bFpBVGtnTGNHdkwxb1dRcG5JZzJ6UjRjUVJKeXhQK3UxUTJNZnRhMzYrY3lm?=
 =?utf-8?B?V0pqVlJYWDZwSC9odnZ4Um1xSENicll3MHl2TkZ3WXJZUStuRFlEZWxOdmpL?=
 =?utf-8?B?N2FBa1VzcUh2d2krS2VJQSsrU0JFTjNpTEFDYVd3dUttaVBFcmgvZUd4UFRt?=
 =?utf-8?B?bnRBSmljeHMvQlNFR3A5ZHRnVWNqN3ZML1l4a1JiRnJHVVhDZFJDUzRrTDVL?=
 =?utf-8?B?UnRVcFhpWnA1aDZOcWc4THhHNFlNR0RWSGgyWmhHSFJzaWtiYzNxSFJGdzNZ?=
 =?utf-8?B?V0N6V1JaR2d3KytVSnVkVkhkd0dGdkh2NHJXRXJhOGhncmk5dTRydkxiNk5p?=
 =?utf-8?B?NWp2R2t3TjdxaFYzNHlwWDdUMU9GNlNXZjVWdENwRStnK2lhc3o0S1dQSVBJ?=
 =?utf-8?B?SGh1cUdGWFU4UG5rY01nKzdiMjRSdTFkR01TcmdkVDY5YTdWcmZzVmFOWlZn?=
 =?utf-8?B?ZTdRVGt3TTZwSnQxSHFTUkhwY3ZWRUs5WUZWZGN6OEhWck80VThuSmRXNE10?=
 =?utf-8?B?cDR2Mlk4NmlVeVVNSEtBQzRSTjZEaWtVQmFhV24vWEZncHZZUHJ5NXRCSElE?=
 =?utf-8?B?N1pUUUpRaTlzUXM2aW5XekVvaE1LcEVSVmt3NitxUUE2c0RzL1NpMWNWeHM2?=
 =?utf-8?B?REVWNzVTWGFCcG9yRnE3MkxDQUtTYTNZN2oxeWttQXdvQVFHU3ZpSjlKMHln?=
 =?utf-8?B?d0orVGIwenZyS0FYRGlVOGVMQUpKaTVtM3lQbHhGSVM4M2hQblEzblZjeDNO?=
 =?utf-8?B?UzZPQzFFa2xWdlE2cFc2bWh5OXpRQjdFQkFPTnc5eTZTc0FRQm5FZFhiK3VP?=
 =?utf-8?B?SHp1ZkxERzBCOS9VY2svVDdOMkpDbHZSbmQwL1ptQUowOHZBekZuV0pNOWJ2?=
 =?utf-8?B?MDhIV25pRUdUdDlNQ1JrbEFoNU9zUEZGcU9NSmN2MkE2TmJpM1VLNlVuMGtE?=
 =?utf-8?B?SjFmUy90dnoxdnlRM0xOVyt4SFNvTUJOYnM2bDUyNzY3RWREWXh3emJVdGwy?=
 =?utf-8?B?WmRrb3ordDl1WENZei90ZXVBOEZCdk4xYTZMckJSZmdzN1I0aHVHUCtmUVU2?=
 =?utf-8?B?YnY4RU1Oc3FnUlA4MXo4K0hrbThxTG1PUXF1ekZBcGQwYzNobDZuSk9pcDNM?=
 =?utf-8?B?Q21QWjJzeE9yc3NJandrbVI1bUFUSlhlZkZxdGFnbjNwak55NWZqdEorY00y?=
 =?utf-8?B?Qlc0dzFDRmdkNFd2cDZPd2trRU5KWTVwZHA1UTU2b04zT2hiNXhoUGtSdDRp?=
 =?utf-8?B?MlVDRy9ndG0rcWhEQUFYN3FKM2NTNC8zalpqdTlkOWorWnp0THlYckU2Zk1U?=
 =?utf-8?B?TENxZm02czk0TWpsWjljSENwZitkb1RpeFNNb3VDcCtqa210TVlJOFZDRW52?=
 =?utf-8?B?am8vSjh4S1VHVGZQaU0vSkJTc1I3TDJ0cmZNTlFQUWJSU2JQNW0zdWVSY01T?=
 =?utf-8?B?SGFOemt6cFdydGxvbm1DZVlqQUlnd2Jqa2hsd1lCdDlveENGOFdTVDV5ZzlH?=
 =?utf-8?B?Q1dRSi8rMXpQbHozVHNzTnNSVUtPQlFXK1poQXhNRHAxajlabmVMbGJFNFp6?=
 =?utf-8?Q?f9huW+oiMYSr/NM24qm7LZlNS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7939375d-ea4a-465b-6079-08de3e124626
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Dec 2025 08:48:54.0395
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GYrNHsRoo+XIU9CY6m0YZVbSHW8eu0vaemj2QQ4QJBGhbplfDkpzh2z3//5H4IsylAi5+NbkN7nW15A2s8dEqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10553

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNYW5pdmFubmFuIFNhZGhhc2l2
YW0gPG1hbmlAa2VybmVsLm9yZz4NCj4gU2VudDogMjAyNeW5tDEy5pyIMTjml6UgMTY6MTUNCj4g
VG86IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+IENjOiBTaGF3biBMaW4g
PHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT47IEZyYW5rIExpIDxmcmFuay5saUBueHAuY29tPjsN
Cj4gTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5pdmFubmFuLnNhZGhhc2l2YW1Ab3NzLnF1YWxj
b21tLmNvbT47DQo+IEppbmdvbyBIYW4gPGppbmdvb2hhbjFAZ21haWwuY29tPjsgTG9yZW56byBQ
aWVyYWxpc2kgPGxwaWVyYWxpc2lAa2VybmVsLm9yZz47DQo+IEtyenlzenRvZiBXaWxjennFhHNr
aSA8a3dpbGN6eW5za2lAa2VybmVsLm9yZz47IFJvYiBIZXJyaW5nDQo+IDxyb2JoQGtlcm5lbC5v
cmc+OyBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPjsNCj4gbGludXgtcGNpQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gdmluY2VudC5n
dWl0dG90QGxpbmFyby5vcmc7IHpoYW5nc2VuY2h1YW5AZXN3aW5jb21wdXRpbmcuY29tDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggMi8yXSBQQ0k6IGR3YzogRG8gbm90IHJldHVybiBmYWlsdXJlIGZy
b20NCj4gZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkgaWYgbGluayBpcyBpbiBEZXRlY3QvUG9sbCBz
dGF0ZQ0KPiANCj4gT24gRnJpLCBOb3YgMjEsIDIwMjUgYXQgMDk6NTY6MDVQTSArMDUzMCwgTWFu
aXZhbm5hbiBTYWRoYXNpdmFtIHdyb3RlOg0KPiA+IE9uIEZyaSwgTm92IDIxLCAyMDI1IGF0IDA1
OjIxOjU4QU0gKzAwMDAsIEhvbmd4aW5nIFpodSB3cm90ZToNCj4gPiA+ID4gLS0tLS1PcmlnaW5h
bCBNZXNzYWdlLS0tLS0NCj4gPiA+ID4gRnJvbTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtIDxtYW5p
QGtlcm5lbC5vcmc+DQo+ID4gPiA+IFNlbnQ6IDIwMjXlubQxMeaciDIw5pelIDEzOjM3DQo+ID4g
PiA+IFRvOiBTaGF3biBMaW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT4NCj4gPiA+ID4gQ2M6
IEhvbmd4aW5nIFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+OyBGcmFuayBMaQ0KPiA+ID4gPiA8
ZnJhbmsubGlAbnhwLmNvbT47IE1hbml2YW5uYW4gU2FkaGFzaXZhbQ0KPiA+ID4gPiA8bWFuaXZh
bm5hbi5zYWRoYXNpdmFtQG9zcy5xdWFsY29tbS5jb20+Ow0KPiA+ID4gPiBKaW5nb28gSGFuIDxq
aW5nb29oYW4xQGdtYWlsLmNvbT47IExvcmVuem8gUGllcmFsaXNpDQo+ID4gPiA+IDxscGllcmFs
aXNpQGtlcm5lbC5vcmc+OyBLcnp5c3p0b2YgV2lsY3p5xYRza2kNCj4gPiA+ID4gPGt3aWxjenlu
c2tpQGtlcm5lbC5vcmc+OyBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwub3JnPjsgQmpvcm4NCj4g
PiA+ID4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT47IGxpbnV4LXBjaUB2Z2VyLmtlcm5l
bC5vcmc7DQo+ID4gPiA+IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IHZpbmNlbnQuZ3Vp
dHRvdEBsaW5hcm8ub3JnOw0KPiA+ID4gPiB6aGFuZ3NlbmNodWFuQGVzd2luY29tcHV0aW5nLmNv
bQ0KPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIDIvMl0gUENJOiBkd2M6IERvIG5vdCByZXR1
cm4gZmFpbHVyZSBmcm9tDQo+ID4gPiA+IGR3X3BjaWVfd2FpdF9mb3JfbGluaygpIGlmIGxpbmsg
aXMgaW4gRGV0ZWN0L1BvbGwgc3RhdGUNCj4gPiA+ID4NCj4gPiA+ID4gKyBSaWNoYXJkLCBGcmFu
aw0KPiA+ID4gPg0KPiA+ID4gPiBPbiBUaHUsIE5vdiAyMCwgMjAyNSBhdCAwOToxMzoyNEFNICsw
ODAwLCBTaGF3biBMaW4gd3JvdGU6DQo+ID4gPiA+ID4g5ZyoIDIwMjUvMTEvMjAg5pif5pyf5Zub
IDI6MTAsIE1hbml2YW5uYW4gU2FkaGFzaXZhbSDlhpnpgZM6DQo+ID4gPiA+ID4gPiBkd19wY2ll
X3dhaXRfZm9yX2xpbmsoKSBBUEkgd2FpdHMgZm9yIHRoZSBsaW5rIHRvIGJlIHVwIGFuZA0KPiA+
ID4gPiA+ID4gcmV0dXJucyBmYWlsdXJlIGlmIHRoZSBsaW5rIGlzIG5vdCB1cCB3aXRoaW4gdGhl
IDEgc2Vjb25kDQo+ID4gPiA+ID4gPiBpbnRlcnZhbC4gQnV0IGlmIHRoZXJlIHdhcyBubyBkZXZp
Y2UgY29ubmVjdGVkIHRvIHRoZSBidXMsDQo+ID4gPiA+ID4gPiB0aGVuIHRoZSBsaW5rIHVwIGZh
aWx1cmUgd291bGQNCj4gPiA+ID4gYmUgZXhwZWN0ZWQuDQo+ID4gPiA+ID4gPiBJbiB0aGF0IGNh
c2UsIHRoZSBjYWxsZXJzIG1pZ2h0IHdhbnQgdG8gc2tpcCB0aGUgZmFpbHVyZSBpbiBhDQo+ID4g
PiA+ID4gPiBob3BlIHRoYXQgdGhlIGxpbmsgd2lsbCBiZSB1cCBsYXRlciB3aGVuIGEgZGV2aWNl
IGdldHMgY29ubmVjdGVkLg0KPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IE9uZSBvZiB0aGUgY2Fs
bGVycywgZHdfcGNpZV9ob3N0X2luaXQoKSBpcyBjdXJyZW50bHkgc2tpcHBpbmcNCj4gPiA+ID4g
PiA+IHRoZSBmYWlsdXJlIGlycmVzcGVjdGl2ZSBvZiB0aGUgbGluayBzdGF0ZSwgaW4gYW4gYXNz
dW1wdGlvbg0KPiA+ID4gPiA+ID4gdGhhdCB0aGUgbGluayBtYXkgY29tZSB1cCBsYXRlci4gQnV0
IHRoaXMgYXNzdW1wdGlvbiBpcyB3cm9uZywNCj4gPiA+ID4gPiA+IHNpbmNlIExUU1NNIHN0YXRl
cyBvdGhlciB0aGFuIERldGVjdCBhbmQgUG9sbCBkdXJpbmcgbGluaw0KPiA+ID4gPiA+ID4gdHJh
aW5pbmcgcGhhc2UgYXJlIGNvbnNpZGVyZWQgdG8gYmUgZmF0YWwgYW5kIHRoZSBsaW5rIG5lZWRz
IHRvIGJlDQo+IHJldHJhaW5lZC4NCj4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiBTbyB0byBhdm9p
ZCBjYWxsZXJzIG1ha2luZyB3cm9uZyBhc3N1bXB0aW9ucywgc2tpcCByZXR1cm5pbmcNCj4gPiA+
ID4gPiA+IGZhaWx1cmUgZnJvbQ0KPiA+ID4gPiA+ID4gZHdfcGNpZV93YWl0X2Zvcl9saW5rKCkg
aWYgdGhlIGxpbmsgaXMgaW4gRGV0ZWN0IG9yIFBvbGwgc3RhdGUNCj4gPiA+ID4gPiA+IGFmdGVy
IHRpbWVvdXQgYW5kIGFsc28gY2hlY2sgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGUgQVBJIGluDQo+
ID4gPiA+IGR3X3BjaWVfaG9zdF9pbml0KCkuDQo+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gU2ln
bmVkLW9mZi1ieTogTWFuaXZhbm5hbiBTYWRoYXNpdmFtDQo+ID4gPiA+ID4gPiA8bWFuaXZhbm5h
bi5zYWRoYXNpdmFtQG9zcy5xdWFsY29tbS5jb20+DQo+ID4gPiA+ID4gPiAtLS0NCj4gPiA+ID4g
PiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8
IDggKysrKystLS0NCj4gPiA+ID4gPiA+ICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNp
ZS1kZXNpZ253YXJlLmMgICAgICB8IDggKysrKysrKysNCj4gPiA+ID4gPiA+ICAgMiBmaWxlcyBj
aGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtaG9zdC5jDQo+ID4gPiA+ID4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdj
L3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gPiA+IGluZGV4IDhmZTM0NTRmM2IxMy4u
OGM0ODQ1ZmQyNGFhIDEwMDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiA+ID4g
QEAgLTY3MSw5ICs2NzEsMTEgQEAgaW50IGR3X3BjaWVfaG9zdF9pbml0KHN0cnVjdCBkd19wY2ll
X3JwDQo+ICpwcCkNCj4gPiA+ID4gPiA+ICAgCSAqIElmIHRoZXJlIGlzIG5vIExpbmsgVXAgSVJR
LCB3ZSBzaG91bGQgbm90IGJ5cGFzcyB0aGUgZGVsYXkNCj4gPiA+ID4gPiA+ICAgCSAqIGJlY2F1
c2UgdGhhdCB3b3VsZCByZXF1aXJlIHVzZXJzIHRvIG1hbnVhbGx5IHJlc2NhbiBmb3INCj4gZGV2
aWNlcy4NCj4gPiA+ID4gPiA+ICAgCSAqLw0KPiA+ID4gPiA+ID4gLQlpZiAoIXBwLT51c2VfbGlu
a3VwX2lycSkNCj4gPiA+ID4gPiA+IC0JCS8qIElnbm9yZSBlcnJvcnMsIHRoZSBsaW5rIG1heSBj
b21lIHVwIGxhdGVyICovDQo+ID4gPiA+ID4gPiAtCQlkd19wY2llX3dhaXRfZm9yX2xpbmsocGNp
KTsNCj4gPiA+ID4gPiA+ICsJaWYgKCFwcC0+dXNlX2xpbmt1cF9pcnEpIHsNCj4gPiA+ID4gPiA+
ICsJCXJldCA9IGR3X3BjaWVfd2FpdF9mb3JfbGluayhwY2kpOw0KPiA+ID4gPiA+ID4gKwkJaWYg
KHJldCkNCj4gPiA+ID4gPiA+ICsJCQlnb3RvIGVycl9zdG9wX2xpbms7DQo+ID4gPiA+ID4gPiAr
CX0NCj4gPiA+ID4gPiA+ICAgCXJldCA9IHBjaV9ob3N0X3Byb2JlKGJyaWRnZSk7DQo+ID4gPiA+
ID4gPiAgIAlpZiAocmV0KQ0KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiA+ID4gPiBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiA+ID4gPiBpbmRleCBjNjQ0
MjE2OTk1ZjYuLmZlMTNjNmIxMGNjYiAxMDA2NDQNCj4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS5jDQo+ID4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUuYw0KPiA+ID4gPiA+ID4g
QEAgLTY1MSw2ICs2NTEsMTQgQEAgaW50IGR3X3BjaWVfd2FpdF9mb3JfbGluayhzdHJ1Y3QgZHdf
cGNpZQ0KPiAqcGNpKQ0KPiA+ID4gPiA+ID4gICAJfQ0KPiA+ID4gPiA+ID4gICAJaWYgKHJldHJp
ZXMgPj0gUENJRV9MSU5LX1dBSVRfTUFYX1JFVFJJRVMpIHsNCj4gPiA+ID4gPiA+ICsJCS8qDQo+
ID4gPiA+ID4gPiArCQkgKiBJZiB0aGUgbGluayBpcyBpbiBEZXRlY3Qgb3IgUG9sbCBzdGF0ZSwg
aXQgaW5kaWNhdGVzIHRoYXQgbm8NCj4gPiA+ID4gPiA+ICsJCSAqIGRldmljZSBpcyBjb25uZWN0
ZWQuIFNvIHJldHVybiBzdWNjZXNzIHRvIGFsbG93IHRoZSBkZXZpY2UNCj4gdG8NCj4gPiA+ID4g
PiA+ICsJCSAqIHNob3cgdXAgbGF0ZXIuDQo+ID4gPiA+ID4gPiArCQkgKi8NCj4gPiA+ID4gPiA+
ICsJCWlmIChkd19wY2llX2dldF9sdHNzbShwY2kpIDw9DQo+IERXX1BDSUVfTFRTU01fREVURUNU
X1dBSVQpDQo+ID4gPiA+ID4gPiArCQkJcmV0dXJuIDA7DQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJ
J20gYWZyYWlkIHRoaXMgbWlnaHQgbm90IGJlIHRydWUuIElmIHRoZXJlIGlzIG5vIGRldmljZXMN
Cj4gPiA+ID4gPiBjb25uZWN0ZWQgb3IgdGhlIGRldmljZSBjb25uZWN0ZWQgd2l0aG91dCBwb3dl
ciBzdXBwbGllZCwgaXQNCj4gPiA+ID4gPiBtZWFucyB0aGVyZSBpcyBubyBmYXItZW5kIHB1bGwt
dXAgdGVybWluYXRpb24gcmVzaXN0b3IgZnJvbSBUWA0KPiA+ID4gPiA+IHZpZXcgb2YgUkMuIFRY
IHB1bHNlIGRldGVjdGlvbiBzaWduYWwgZnJvbSB0aGUgUkMgc2lkZSB3aWxsIG5vdA0KPiA+ID4g
PiA+IHVuZGVyZ28gdm9sdGFnZSBkaXZpc2lvbiwgYW5kIGl0cyBMVFNTTSBzdGF0ZSBtYWNoaW5l
IHdpbGwgb25seQ0KPiA+ID4gPiA+IHRvZ2dsZSBiZXR3ZWVuIERXX1BDSUVfTFRTU01fREVURUNU
X1FVSUVUIGFuZA0KPiBEV19QQ0lFX0xUU1NNX0RFVEVDVF9BQ1QuDQo+ID4gPiA+ID4NCj4gPiA+
ID4NCj4gPiA+ID4gSSBtdXN0IGFkbWl0IHRoYXQgSSBqdXN0IGluaGVyaXRlZCB0aGlzIGNoZWNr
IGZyb20NCj4gZHdfcGNpZV9zdXNwZW5kX25vaXJxKCkuDQo+ID4gPiA+IEJ1dCBJIGNyb3NzIGNo
ZWNrZWQgdGhlIFBDSWUgYmFzZSBzcGVjIGFuZCBpdCBtZW50aW9ucyBjbGVhcmx5DQo+ID4gPiA+
IHRoYXQgdGhlIExUU1NNIHdpbGwgYmUgaW4gRGV0ZWN0LlF1aWV0L0FjdGl2ZSBzdGF0ZXMgaWYg
bm8NCj4gPiA+ID4gZW5kcG9pbnQgaXMgZGV0ZWN0ZWQgaS5lLiwgd2l0aGluIHRoZSAxcyB0aW1l
b3V0LCB0aGUgTFRTU00NCj4gPiA+ID4gc2hvdWxkJ3ZlIHRyYW5zaXRpb25lZCBiYWNrIHRvIHRo
ZXNlIERldGVjdCBzdGF0ZXMuDQo+ID4gPiA+DQo+ID4gPiA+IEknbSB3b25kZXJpbmcgd2h5IHdl
IGFyZSBjaGVja2luZyBmb3IgUG9sbCBhbmQgb3RoZXIgc3RhdGVzIGluDQo+ID4gPiA+IGR3X3Bj
aWVfc3VzcGVuZF9ub2lycSgpLiBJIGJlbGlldmUgdGhlIGludGVudGlvbiB3YXMgdG8gY2hlY2sg
Zm9yDQo+ID4gPiA+IHRoZSBwcmVzZW5jZSBvZiBhbiBlbmRwb2ludCBvciBub3QuDQo+ID4gPiA+
DQo+ID4gPiA+IFJpY2hhcmQsIEZyYW5rLCB0aG91Z2h0cz8NCj4gPiA+ID4NCj4gPiA+IEhpIE1h
bmk6DQo+ID4gPiBZZXMsIGl0IGlzLg0KPiA+ID4gSW4gbXkgaW5pdGlhbCB1cHN0cmVhbWluZyBw
YXRjaGVzLCB0aGUgaW50ZW50aW9uIHRvIGNoZWNrIHRoaXMgc3RhdGUNCj4gPiA+IGlzIHRvICBm
aWd1cmUgb3V0IHRoYXQgdGhlcmUgaXMgYW4gZW5kcG9pbnQgZGV2aWNlIG9yIG5vdC4NCj4gPiA+
DQo+ID4NCj4gPiBJZiBzbywgd2h5IGRvIHdlIG5lZWQgdG8gY2hlY2sgZm9yIExUU1NNIHN0YXRl
cyBvdGhlciB0aGFuDQo+ID4gRFdfUENJRV9MVFNTTV9ERVRFQ1RfUVVJRVQgYW5kIERXX1BDSUVf
TFRTU01fREVURUNUX0FDVD8NCj4gPg0KPiA+IERpZCBzcGVjIG1hbmRhdGUgaXQgb3IgeW91IGRp
ZCBpdCBmb3Igc29tZSBzcGVjaWZpYyByZWFzb24/DQo+ID4NCj4gDQo+IEhvbmd4aW5nLCBwaW5n
IQ0KSGkgTWFuaToNClNvcnJ5IHRvIHJlcGx5IGxhdGUuDQpSZWZlciB0byAiQWR2YW5jZWQgSW5m
b3JtYXRpb246IExhbmUgUmV2ZXJzYWwgYW5kIEJyb2tlbiBMYW5lcyIgb2YgUENJZSBETQ0KIENv
bnRyb2xsZXIgZGF0YSBib29rIHJlbGVhc2VkIGJ5IFN5bm9wc3lzLg0KIg0KTm90ZTogRmxpcDog
V2hlbiB0aGUgTFRTU00gdHJhbnNpdGlvbnMgdG8gREVURUNUX1dBSVQsIG1lYW5pbmcgdGhhdCBz
b21lIGxhbmVzDQogYXJlIGRldGVjdGVkIGluIERFVEVDVF9BQ1QsIGJ1dCBub3QgYWxsOyBhbmQg
bGFuZTAgaXMgbm90IGRldGVjdGVkLCB0aGUgTFRTU00NCiBhdXRvbm9tb3VzbHkgYWN0aXZhdGVz
IGEgbGFuZSBmbGlwIG9wZXJhdGlvbi4NCiINCkl0IHNlZW1zIHRoYXQgTFRTU00gbWlnaHQgdHJh
bnNpdGlvbiB0byBERVRFQ1RfV0FJVCBpbiB0aGUgRkxJUCBjYXNlLg0KU28sIHRvIGJlIHNhdmUs
IGp1c3QgdXNlIHRoZSBtYXggY29uZGl0aW9uIGhlcmUuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCj4gDQo+IC0gTWFuaQ0KPiANCj4gLS0NCj4g4K6u4K6j4K6/4K614K6j4K+N4K6j4K6p
4K+NIOCumuCupOCuvuCumuCuv+CuteCuruCvjQ0K

