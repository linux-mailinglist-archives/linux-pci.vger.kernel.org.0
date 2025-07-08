Return-Path: <linux-pci+bounces-31657-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64768AFC427
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 09:35:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36C84179187
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 07:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0C329898A;
	Tue,  8 Jul 2025 07:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KC0i+y88"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012001.outbound.protection.outlook.com [52.101.71.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10E329898B;
	Tue,  8 Jul 2025 07:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751960105; cv=fail; b=hxAXlvsV8XtPIhPZGR2E44OnyBCw3a5oB0Z3czFZeOUhDbablORsKfV92q3gg981rPomBflxSu8ZYSY7Zdl+VY9HFAKdzQGFb8AUYllNhM+QN3NeMZed7CsJX55p4SSGHO8i45IjpsV1/JOVUHlmeuOuQwJUws/S15Enl4XqmGg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751960105; c=relaxed/simple;
	bh=ByqhAf+VSxmDMXwRtaTjDf0TDg+kEcDB9ac/2nR8aUY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=XmwlUGUgTVu1xjkwkAXHSw20zAloAOOKC/wBDv0xv48hkIEeryY1khkCq4O2J2+B/79IdPRh60WVi7Ho7wueRct3+hjk0rakhIvgHxBDvPvYRuiKNxn8t7Z5bCVEWZWtYi159/jGzKrgMlYa10lTTOc/sCp0n0W9PFjaq31Xp0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KC0i+y88; arc=fail smtp.client-ip=52.101.71.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XQTnb8eUQHQtRXQBgY3hhRJR1rkRDw7rlKhawm14m64Ozp1FjH2+lf4x4POHPSos1yoIcrab25yTAa2UFYFKG57CS8qvvEYXbmLkXmK8DcNk9EvzBw3vd48quNI6P9VYw+iN0rq1K+LN5AGXtzrGvV6Ardv3r0HJRkV7/tebVTTxlUwDnUZui/+SdIqDJY6fGfeX239YNgGbOypP0FK+Ov4VVFEHZGF88tuv+xc1+NNGBhZXuhVxzVFRtCgMIOBzF1/1ZnYUQajvIzyvVawvllJdka+RNOrcKlMDHXWHMhto6G7l/XrX/sqy0kMCKSKGJjLZ4+WF4fK8yhuYQp7VRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByqhAf+VSxmDMXwRtaTjDf0TDg+kEcDB9ac/2nR8aUY=;
 b=UzwZsWUClbmcEs3GYxBZjg+CspJrrDC9PHrpU04yWazmW3izprc6EFTYcU6fA9MUEcjUzmvw9VbTurr4BHORsgBojY7KehAoIsY8Mr0dZXu+PI1PCDC+yMA9xGqII5v+pOgKpjBV62gYjWiwfQ7ngB97fVLdeoug3Gx8dXLlYcugcLMIik35z4TGvJfZFySHkO5/QRr9pP/r+34WII5Ls/HZZqnY07LzxTg9cH9pprhExiH6NJOaALUtDkvwXg2sy03vQyq/g2pQEzSucXHGWljYQhFNiK6qu3jFe4VoiyPSMdj7XgISb3DuLkvbS9V+7Zzrdkujh0Fi46N3bt0wkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByqhAf+VSxmDMXwRtaTjDf0TDg+kEcDB9ac/2nR8aUY=;
 b=KC0i+y88CoOtZ0zp/Hi06CtQ4Mqy86cxYU9aWvBfe3AFuZr0AH/j5iHHNksqZk6HCMHHuJAPTEfBvkpLzg9YzcWLvCFELylLsOjfAyXeeMozbkweKAy9SoL4J1yDRvVM7NtCmCupZa8/WGPdk7pDZjfhb0JDf1O0nrrTTH8NmDKMqfD02RNS62VQlsmVPP5KTuzIgZd3UcoVNzJzvowLkEQOFV6HqBFtIaUgigfb5Jeho1+exCCKCUfCalIpJrGBkpLopAI4onwJ1Gc0mlSYjE2deuTz5DHo0aoZimFbNmzeytqZhM19LyNVTP8YXCRv9SdK1IjaQm3a/cNHjydjgw==
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB11084.eurprd04.prod.outlook.com (2603:10a6:102:492::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.25; Tue, 8 Jul
 2025 07:34:58 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8901.024; Tue, 8 Jul 2025
 07:34:58 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Bjorn Helgaas <helgaas@kernel.org>, "mani@kernel.org" <mani@kernel.org>
CC: Frank Li <frank.li@nxp.com>, "l.stach@pengutronix.de"
	<l.stach@pengutronix.de>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
	"kwilczynski@kernel.org" <kwilczynski@kernel.org>, "robh@kernel.org"
	<robh@kernel.org>, "bhelgaas@google.com" <bhelgaas@google.com>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>, "linux-pci@vger.kernel.org"
	<linux-pci@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Thread-Topic: [PATCH v2] PCI: imx6: Correct the epc_features of i.MX8M chips
Thread-Index: AQHb31qUj+ZrPd0xZ0Op7blHS6urXbQnLYmAgADFKtA=
Date: Tue, 8 Jul 2025 07:34:57 +0000
Message-ID:
 <AS8PR04MB8676B8D14A5C54E8C32025BD8C4EA@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <20250617073441.3228400-1-hongxing.zhu@nxp.com>
 <20250707193415.GA2095765@bhelgaas>
In-Reply-To: <20250707193415.GA2095765@bhelgaas>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|PA1PR04MB11084:EE_
x-ms-office365-filtering-correlation-id: 27319340-2cf8-47ab-d120-08ddbdf1f0b9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?gb2312?B?dnhZeGFLbEIvWTlpbDFKRW55NG1ia0F2dnZ6SVhlYTV5dUpOY3R6VjZKMCs3?=
 =?gb2312?B?VXVPYi9RQldZMEtXeTFpSjZWcXhreEh5QmhiWkpINUNQSlJTYUFqeFJGbWIz?=
 =?gb2312?B?WmNSOEhTVFlFZGVQbzZKOFZXWXJFN2hMdHF5dVpVM3FpQzlES2dTdC9QdHl3?=
 =?gb2312?B?TzRhalUxWW5adHJCMnNaRnB0Wi9CNm04MUkzRlo1Tm5jdFdDdXczZnlhOTRW?=
 =?gb2312?B?M0dsc1dBWXNRYUs5OXBCY0h1dkhRNlNkWnRVN2Q4U25ibitodXh2Rm84RjVC?=
 =?gb2312?B?ODZnZUNJcXJ0M1g1OXZYcXpCM011bHRNS3hyb2cwYzg2dDgwZ2IwRDJsSVhY?=
 =?gb2312?B?NWUrTCt0N1hCRVpHcEZNRVMwWjBQVkZQR1RhdkpYNGpjZ2E5NmJIOVhLSUNN?=
 =?gb2312?B?MjJkamd4NE1aK3kvSzd5c0pIdVd0ZnlxS2dMWUwySWNnRDFpR1VFU2VtRmpC?=
 =?gb2312?B?STBuU1EzZjl3UTZMVjhQSXdJSUIvR3YxMGQvOXVtendoQk1HMGowakd1d0R1?=
 =?gb2312?B?SU9xaWoyRFlpY083UGNZbEVwMXFlcCtlamMvQmhKcGxUcCtHcXdMZkpUbjN2?=
 =?gb2312?B?eW9JWnNETm9NQ1JzUzlwcDMycjg1NEhkREVLR0s1dmVqbU40aWVUQVZ1clV6?=
 =?gb2312?B?eDhINHZoVW9RZ25rdkMyWmp1aUxJSUhsaElwc0FjN3E4S1pLNDZJQWhaWXZ6?=
 =?gb2312?B?cXMwQWNLR0dQRGY4S1JieFowN2xmWk8vWUVWSVBqaGpOZGlSN0hBc2YwZWE0?=
 =?gb2312?B?STVERHF0N3lTdm1VeUNzVnppb2loRjRTRFpJa0lUYlpNWTYvMTdieU03SmFJ?=
 =?gb2312?B?Z0x6UURjcko5Q0ROVUNTbFNKdlJiY2RWLy9JQXlJN3RlUlllRHBLUlJLejJX?=
 =?gb2312?B?QkhOeDByWmRHaEdFRCt6azlITEhLUEZyT0MyaFg4Y1lYNlNqUDZjSCtSc09k?=
 =?gb2312?B?QXhESUxqUE5KNzQ5YU9od1hlTkZtZTRTWFJuUS9lUCtMSGNveDBTbHZoNGFE?=
 =?gb2312?B?aHpCUy9INFNYZjdxclVwRFZyaFYxaHVSdUVJckd1YU5LOVlCWUxlL1dZZUwy?=
 =?gb2312?B?RzhRclk0MjBVQ2F3ZlN4VVBtUFdoQkk3THI0ZGxpcG04dmIxUCtQYW5PZ20z?=
 =?gb2312?B?emVBeE5GTm03L09mUjJqajMya0lFZEl3djg5YUQ4VkpiV0RFZ1VteEhvczVq?=
 =?gb2312?B?M01DL0VtSjY4cm9qQ2JScDBCUUhsZ3g0UWNWdlk1bjBhMGc0NDQyWTRaMXdK?=
 =?gb2312?B?R1JxK0FDblRycStpbGMzalhLeWhvMm5HWEpDWTdFTUQ3ZlVRWEFQZnM3YTd6?=
 =?gb2312?B?MUJ2czEwNk1Va0E1bVdHVUhqUXQrZ2tPVWpRclR2SVQyUkxJamROZGVkN200?=
 =?gb2312?B?eTBIZ2hDMWZkTUNCenpib2FtREdVVDZ5RkpPTm9yckh5amNSQy96Mm9kakRD?=
 =?gb2312?B?Y3Y2SkxEdktGZ0V4K2tibUR0aVNJSnM2R2p2UFNVUm8rQ1E4aWtEMEdtOVU2?=
 =?gb2312?B?SFFMK2ZBM3E5OFRia3VMMlNLK0FVUnFRcnB3dTd4Zk1LK05XV0NQYjRxazk5?=
 =?gb2312?B?c21oYXpWcnZIeC9oNHQvc1hkaWkwbW4rZlM4eDJTcjRIY0J4RFFqanlkVmwv?=
 =?gb2312?B?K2hhOEI2M1crWUJ4Q2thbVdJcFg4RU1GL1dFTUlwOVBIMjQySWoxMTNWa1ZV?=
 =?gb2312?B?WlVRY2t5YmtQTmxSL21SZGVDckZPRzIxQVlYS2YvWjBXdUY4VjR3b3d1dVdu?=
 =?gb2312?B?SmQyZDBqbXdhUHY2YWpxWGpTai9qM2dpU0JTbkc5MFJWcFZFdGxxUURqdUVw?=
 =?gb2312?B?Z1RPb3VVRkhJVUtHN3o0Sjh6eHV0WWFXbC9MS0tXWmxIdTIzTE5lczVoZ3NH?=
 =?gb2312?B?UkU0cDBxWmhMRzl2aHNrRzltLy9TTjNNR2RTakkxREZhZWp5Z2ZJM05INzE2?=
 =?gb2312?B?TDNNQndGMFlXQUNTK0dOR2tZL0RlZDdpMFcyRlhOMnRubUhkWk5nMVgwS0di?=
 =?gb2312?B?Z1B5clM1ajJnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?RXdxRUhKdkZqalkxb1JDTk5najJpOHliSk5DOS9WaUFLc0FjNktvNzA5RXE2?=
 =?gb2312?B?NHpmL1dRUXNKVEdsRkpnR2tEbUxRUnVXZGhFd1FUMlJRbzk3Ui9Xd3dhbW1B?=
 =?gb2312?B?VmtvbmF6U3I1eEp1Wi9vd04wMWErb2t3eVM4NHE0azBNNVhlcGhzY1ZsTC9C?=
 =?gb2312?B?ZGZDT3IwM1BRUlRvNHNyZ3o0QitWZG5LN05Zci9sUmtPcHJtYStkTHBHMUxw?=
 =?gb2312?B?Y3dZOHhoK3NYaVlRMXVOY0Ztd2VhWnpLeHh1eGhjN08yTCtRWi80N21LWktY?=
 =?gb2312?B?WmxyTGRvY3ZvcjF6My9TNDgxbHN4Y29GMWpHcTdBQ0RyajZZSGdlS2VFL3lJ?=
 =?gb2312?B?T0h2UEkzaU9zNWhWVGk2Rk5MbFBJa2lUV0ZTUi9FUTJIOW1rY21WZXNMbDlI?=
 =?gb2312?B?NFpTU2ZFWGFmSi92S2lHSXpmYUptMndQd0ZCckE3T0NmR0VJL2N2ZXBmeDVF?=
 =?gb2312?B?RnpQRGRDWXB5TWM2emZjZng3QWE2UVh5VHpaM0o5S0UxNEhrL2pPb3VZVk1k?=
 =?gb2312?B?RWFMVkhqakRPbzlvMlhacFVzd3pGQ0hLbkxhd1VDY000NWJ3SVVab1l6NnQ4?=
 =?gb2312?B?VTl4UUtrYXVUQTd2M3RUemlsNmxTaEgrQ0l2aDZRMDlTVmNnNjVUZUxFTHor?=
 =?gb2312?B?bGZhNWFhMTZLcXdVN2JaQXVuUW5XMGhDREh4eDJnaU1iUnErS2FIU0F6bEkz?=
 =?gb2312?B?RGc5Tk11TzBWMGt4TEZOUWxnZHVhSkxtRWlUMndLV2U1UkVUTGxUWjRkSzA1?=
 =?gb2312?B?NE1HV1ZHWTAyZklTQnplWCs4aHl5NlpReEdrNWFaZGFJcnpHM2ZnUXA1RDBh?=
 =?gb2312?B?WTltcjMzbFlsRVNDN1lxdGxDZWdxZkRuWnJLQkJlS1d1dHc0MW05VVlKTHhS?=
 =?gb2312?B?TFYrVERuSGhLQThjUlk0b3UycDV1bHVKVHp5YTUzdDdYUDJkdmp3Zno5RENa?=
 =?gb2312?B?cWkxWkJMNjJHdTFNMjlFdG9EQlpsR2duMlFUdUNLcjRHdForZFJHb0xMVjh5?=
 =?gb2312?B?bE5hWC9UeWZCY2phNUh4UFZBcnNhQjhiYzhqOG4yeXRCY3plcm1xWFdDcjRz?=
 =?gb2312?B?U1AxbWFEN0t3TEZLWjJTdWpTNDgxQ2RLM28vNmVuNGhuU2RSTVJpdEg5ZE9D?=
 =?gb2312?B?RlVrbDBWVVl0Rmt6ZVkzRUlBVXFJLzBGRHY4K1pjNDlZUnFvN1czMGRENEky?=
 =?gb2312?B?MXZJQlZhbjZJL0dvNHpocGNKektVb0ZGcUNqemlISmJHamlvcndjRE5tQ0Rv?=
 =?gb2312?B?T2FQQ09hVzJuYUpmS3FrSUpUVkdvT0ZWNXdTUTQ1WHpTOXg2RXkzUDNBM0RE?=
 =?gb2312?B?OVNtU0RrdGtmRjMyOUw0Uy9ieDZUam84NEFXa2tZVTlIcmZhT2NwdThqQTIz?=
 =?gb2312?B?V1RSbm1UaVlLWGU5anRNQWF1Wm1DaGp4N0lXSUFLT3FBTWpBRmVYVVhkMG9Q?=
 =?gb2312?B?YzEzMVZ3bC9jcGhzVFBGcURjZFR5UTBzMWkyYnhrczZPTWRKcXoxUUhpMlRK?=
 =?gb2312?B?ZGtJcTZISTE0UmFvYUtYMmtGM3ZCRW14UTQ2aEJyQ0tpZ3F6d05mOWp0QVp5?=
 =?gb2312?B?ejdDcXoyTVlGbDVYYnhHcG02OVY4NTlCRm1zMkhib2VMTVRGeUJXcFpjaDJI?=
 =?gb2312?B?eHR5cnhwUWFjbWY4WSt2Rlp6Z0pOZ0RSanBpLzBPcjd5eUFnMGRQQ0pUeUx3?=
 =?gb2312?B?SHpKakN6Y3BnME1hQ2p6VDZ5blc0Zlh5cThwMGJlTmlFQTZCUFdOMmE4Z2Qz?=
 =?gb2312?B?Ty9zdWJpODlJQ1dYRnhKQm9GNHI5anV3MkJ4SXU0YW1ITWhDT0UyZi9OajB3?=
 =?gb2312?B?bjMveXFTN25vS3doRzViQ1lIQmp2dGpBYXhsZDFyam5qY0U4YTdPbEFLTXg0?=
 =?gb2312?B?T0x3bHJVNUpGQ0txSytaUHIzM0M3VEVlRUNGZ00zMWVqczg0endNOHRBSytx?=
 =?gb2312?B?UEZhc3dhU2dTUCszaGVmTEpsY1FuakhPQzA4WUdoNWhIN1dWdEFCNGNhMmIv?=
 =?gb2312?B?LzNNVTh5WmN0eitnUGtLSG9FM2JhYzM4bTZZZkNvalFHd1I2b0d4SHRHZXN5?=
 =?gb2312?B?TVdPU2FiTFFZOE5qNmlNRmc5d1ViL1hKL0xDRWx0Q2FWSTEyK0VqRlNSNStq?=
 =?gb2312?Q?ZTygrz7fCgMHVnuYrJda1xv7j?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27319340-2cf8-47ab-d120-08ddbdf1f0b9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jul 2025 07:34:57.9532
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sVKx3lgLvMUJllT4rZ4+aIOjLmgW26oV6884rWPbIXWM9Qw+CpNmNP8G17ZP/vLOzJX+OfoFNt2SY15yoV4bvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB11084

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIDxoZWxn
YWFzQGtlcm5lbC5vcmc+DQo+IFNlbnQ6IDIwMjXE6jfUwjjI1SAzOjM0DQo+IFRvOiBIb25neGlu
ZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiBDYzogRnJhbmsgTGkgPGZyYW5rLmxpQG54
cC5jb20+OyBsLnN0YWNoQHBlbmd1dHJvbml4LmRlOw0KPiBscGllcmFsaXNpQGtlcm5lbC5vcmc7
IGt3aWxjenluc2tpQGtlcm5lbC5vcmc7IG1hbmlAa2VybmVsLm9yZzsNCj4gcm9iaEBrZXJuZWwu
b3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyBzaGF3bmd1b0BrZXJuZWwub3JnOw0KPiBzLmhhdWVy
QHBlbmd1dHJvbml4LmRlOyBrZXJuZWxAcGVuZ3V0cm9uaXguZGU7IGZlc3RldmFtQGdtYWlsLmNv
bTsNCj4gbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBpbXhAbGlzdHMubGludXguZGV2OyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjJdIFBDSTogaW14NjogQ29ycmVjdCB0
aGUgZXBjX2ZlYXR1cmVzIG9mIGkuTVg4TSBjaGlwcw0KPiANCj4gT24gVHVlLCBKdW4gMTcsIDIw
MjUgYXQgMDM6MzQ6NDFQTSArMDgwMCwgUmljaGFyZCBaaHUgd3JvdGU6DQo+ID4gaS5NWDhNUSBQ
Q0llcyBoYXZlIHRocmVlIDY0LWJpdCBCQVIwLzIvNCBjYXBhYmxlIGFuZCBwcm9ncmFtbWFibGUN
Cj4gQkFScy4NCj4gPiBCdXQgaS5NWDhNTSBhbmQgaS5NWDhNUCBQQ0llcyBvbmx5IGhhdmUgQkFS
MC9CQVIyIDY0Yml0DQo+IHByb2dyYW1tYWJsZQ0KPiA+IEJBUnMsIGFuZCBvbmUgMjU2IGJ5dGVz
IHNpemUgZml4ZWQgQkFSNC4NCj4gPg0KPiA+IENvcnJlY3QgdGhlIGVwY19mZWF0dXJlcyBmb3Ig
aS5NWDhNTSBhbmQgaS5NWDhNUCBQQ0llcyBoZXJlLiBpLk1YOE1RDQo+ID4gaXMgdGhlIHNhbWUg
YXMgaS5NWDhRWFAsIHNvIHNldCBpLk1YOE1RJ3MgZXBjX2ZlYXR1cmVzIHRvDQo+ID4gaW14OHFf
cGNpZV9lcGNfZmVhdHVyZXMuDQo+ID4NCj4gPiBGaXhlczogNzVjMmYyNmRhMDNmICgiUENJOiBp
bXg2OiBBZGQgaS5NWCBQQ0llIEVQIG1vZGUgc3VwcG9ydCIpDQo+ID4gU2lnbmVkLW9mZi1ieTog
UmljaGFyZCBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBGcmFu
ayBMaSA8RnJhbmsuTGlAbnhwLmNvbT4NCj4gDQo+ICJDb3JyZWN0IHRoZSBlcGNfZmVhdHVyZXMi
IGRvZXNuJ3QgaW5jbHVkZSBhbnkgc3BlY2lmaWMgaW5mb3JtYXRpb24sIGFuZCBpdCdzDQo+IGhh
cmQgdG8gZXh0cmFjdCB0aGUgY2hhbmdlcyBmb3IgYSBkZXZpY2UgZnJvbSB0aGUgY29tbWl0IGxv
Zy4NCj4gDQo+IFRoaXMgaXMgcmVhbGx5IHR3byBmaXhlcyB0aGF0IHNob3VsZCBiZSBzZXBhcmF0
ZWQgc28gdGhlIGNvbW1pdCBsb2dzIGNhbiBiZQ0KPiBzcGVjaWZpYzoNClllcywgaXQncyByaWdo
dC4NClNpbmNlIGl0J3MganVzdCBvbmUgbGluZSBjaGFuZ2UgZm9yIGkuTVg4TVEuIFNvLCBJIGNv
bWJpbmUgdGhlIGNoYW5nZXMgaW50bw0KdGhpcyBjb21taXQgZm9yIGkuTVg4TSBjaGlwcy4NCg0K
SGkgTWFuaToNClNpbmNlIGl0IGhhZCBiZWVuIGFwcGxpZWQsIEkgZG9uJ3Qga25vdyBob3cgdG8g
cHJvY2VlZC4NClNob3VsZCBJIHNlcGFyYXRlIHRoaXMgY29tbWl0IGludG8gdHdvIHBhdGNoZXMs
IGFuZCByZS1zZW5kIHRoZW0gYWdhaW4/DQpUaGFua3MuDQoNCkJlc3QgUmVnYXJkcw0KUmljaGFy
ZCBaaHUNCj4gDQo+ICAgLSBGb3IgSU1YOE1RX0VQLCB1c2UgaW14OHFfcGNpZV9lcGNfZmVhdHVy
ZXMgKDY0LWJpdCBCQVJzIDAsIDIsIDQpDQo+ICAgICBpbnN0ZWFkIG9mIGlteDhtX3BjaWVfZXBj
X2ZlYXR1cmVzICg2NC1iaXQgQkFScyAwLCAyKS4NCj4gDQo+ICAgLSBGb3IgSU1YOE1NX0VQIGFu
ZCBJTVg4TVBfRVAsIGFkZCBmaXhlZCAyNTYtYnl0ZSBCQVIgNCBpbg0KPiAgICAgaW14OG1fcGNp
ZV9lcGNfZmVhdHVyZXMuDQo+IA0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L2R3Yy9wY2ktaW14Ni5jIHwgNCArKystDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlv
bnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2ktaW14Ni5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3
Yy9wY2ktaW14Ni5jDQo+ID4gaW5kZXggNWEzOGNmYWY5ODliLi45NzU0Y2M2ZTA5YjkgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWlteDYuYw0KPiA+ICsr
KyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaS1pbXg2LmMNCj4gPiBAQCAtMTM4NSw2
ICsxMzg1LDggQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBwY2lfZXBjX2ZlYXR1cmVzDQo+IGlteDht
X3BjaWVfZXBjX2ZlYXR1cmVzID0gew0KPiA+ICAJLm1zaXhfY2FwYWJsZSA9IGZhbHNlLA0KPiA+
ICAJLmJhcltCQVJfMV0gPSB7IC50eXBlID0gQkFSX1JFU0VSVkVELCB9LA0KPiA+ICAJLmJhcltC
QVJfM10gPSB7IC50eXBlID0gQkFSX1JFU0VSVkVELCB9LA0KPiA+ICsJLmJhcltCQVJfNF0gPSB7
IC50eXBlID0gQkFSX0ZJWEVELCAuZml4ZWRfc2l6ZSA9IFNaXzI1NiwgfSwNCj4gPiArCS5iYXJb
QkFSXzVdID0geyAudHlwZSA9IEJBUl9SRVNFUlZFRCwgfSwNCj4gPiAgCS5hbGlnbiA9IFNaXzY0
SywNCj4gPiAgfTsNCj4gPg0KPiA+IEBAIC0xOTEyLDcgKzE5MTQsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IGlteF9wY2llX2RydmRhdGEgZHJ2ZGF0YVtdID0gew0KPiA+ICAJCS5tb2RlX21hc2tb
MF0gPSBJTVg2UV9HUFIxMl9ERVZJQ0VfVFlQRSwNCj4gPiAgCQkubW9kZV9vZmZbMV0gPSBJT01V
WENfR1BSMTIsDQo+ID4gIAkJLm1vZGVfbWFza1sxXSA9IElNWDhNUV9HUFIxMl9QQ0lFMl9DVFJM
X0RFVklDRV9UWVBFLA0KPiA+IC0JCS5lcGNfZmVhdHVyZXMgPSAmaW14OG1fcGNpZV9lcGNfZmVh
dHVyZXMsDQo+ID4gKwkJLmVwY19mZWF0dXJlcyA9ICZpbXg4cV9wY2llX2VwY19mZWF0dXJlcywN
Cj4gPiAgCQkuaW5pdF9waHkgPSBpbXg4bXFfcGNpZV9pbml0X3BoeSwNCj4gPiAgCQkuZW5hYmxl
X3JlZl9jbGsgPSBpbXg4bW1fcGNpZV9lbmFibGVfcmVmX2NsaywNCj4gPiAgCX0sDQo+ID4gLS0N
Cj4gPiAyLjM3LjENCj4gPg0K

