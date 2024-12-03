Return-Path: <linux-pci+bounces-17595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E93F69E2E9B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 23:05:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C0AB64441
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 20:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49ED6209F5D;
	Tue,  3 Dec 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Rbl3AUyT"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2085.outbound.protection.outlook.com [40.107.247.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B89D1CEEA8;
	Tue,  3 Dec 2024 20:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733258247; cv=fail; b=eqhbCeTcU+0irtizxxDvJZH76PRoCAFeMspJwrOcDazbyrLCfalLtwPPtJikRsCja+mWb28vs7rhw2H5gbZNZPQx8/cav/C+WfyPXJNI9ILhzx9WqSqgm0m1kALxwaLgxYEIdPN+p4uDQHBdHD9PjzpAbjXqtdlEaY9XoCXMnAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733258247; c=relaxed/simple;
	bh=BqHEt8m1nlQE+CROgZ5Z9jf9BfRy50ieLQvI2rOkvkU=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=RzlAM8XjbZ/6ax9rAKwARm9Fi9ScH9xH/xRotgvsdUdfEfO7u0OwoiwQEn/s3KmHZWDTklmWsJinx2MjB02GlS0McIhsFjcxJ+KsGCTcFtF80c6YTon+dhUCWrXmLI2VaqiV4wikL8s1NpAkYIecRBnbeaRPkX1hsv8yoS95UzE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Rbl3AUyT; arc=fail smtp.client-ip=40.107.247.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hsXuTdMnLzx4LveSjw5SPLaABPOHTcGAS2rNFdrgsyGf10T+eZUyjUsbOQ55bvEsrS9A/txaIzJRu9hniaTn8c1ccy4LOfhaXAVY4+Y5YO7S8gL/1WlliFIhNH5Fa6KyZNFQs7yXRM7Hr6a0L8c8WGeH+G6SVWgeJEP69SPdjMz8lu+7o0zcRNeDZKtmlwpIjX8VbjGrNT7n0SD0tDdviR5KcM08PLYR6sUrHFNzzTbKU1Ol+9SdV3kzbXLU17c3yI/yLaYzXrosgYJQ6eTWlaF6kCBI9MN46rQ4IC0YtEnjzY5tGwgfXjvlEqJs0wpNLp0p1TeTgOCpvv8YNkxdzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EtZBap3w8ZIg+WP8zXzWpJT9lQzplQNKYcUxAiAUeY=;
 b=iduKCd7kX5ZzXwVeEV91hLuzc2grdmNL4bhil9mAvnH9OQLE9NmP6KSMpbnS94dAmkV7JOOEP8MnoyTQlxAG7EyLKaudVa+2Klo/7tByDQWrLPorSUX1n+H+1ZDSG8+lLt0U5ZDnwz0i7Szd+HP5M+cK266BJMW+M5hK9K8Q5/ED+H8agayZdOjP5D1+d7MLVvO0xbuxz3oW1nuJ92K5jvtn3w9uJg7aicH4LBeHKECNHEWTn4j4Auj/OdND0WhMiFvy6+LdoMYbIuhN7+GRJgZBVwzu8X0tZYmOnIiP1+uCN78dw1TA6un3/CkpKBbD5AcGlgSdS6DRPNBZbFUPVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EtZBap3w8ZIg+WP8zXzWpJT9lQzplQNKYcUxAiAUeY=;
 b=Rbl3AUyTXFlNQqPzo1OwiHfNwx9+u9DgF2FFT8+SjutU76j5ExbOZo+FlSI5voe5K4K7MkM/5dsjvv9OVU+Kr9xPK2jrkjqErkPf58GriJnCdzVNN1PJHPSqe1uvxuq+4Ig9FL5/EFXQDiTLEvGhIHYVlugocpk4YVHOeWJXQ/BJXPEqbD0wi/ZEHz3FfMnVKxeTavcv1YRi9BrNI78EUMNpyeAa96c+B19awoHe1L+grbKqfxCXlpuKGZ8LtLYFVICEcROFxSAgKaLlDtqxCCBUcWwXsmSc2WsTjjJ4LoDKxLx2QL6t04u+uf+qt6I4HUPTvSQAuUNyAcyYj+hOhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB7108.eurprd04.prod.outlook.com (2603:10a6:208:19e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Tue, 3 Dec
 2024 20:37:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8207.017; Tue, 3 Dec 2024
 20:37:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 03 Dec 2024 15:36:52 -0500
Subject: [PATCH v9 3/6] PCI: endpoint: Add pci_epf_align_inbound_addr()
 helper for address alignment
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-ep-msi-v9-3-a60dbc3f15dd@nxp.com>
References: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
In-Reply-To: <20241203-ep-msi-v9-0-a60dbc3f15dd@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Thomas Gleixner <tglx@linutronix.de>, Anup Patel <apatel@ventanamicro.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, jdmason@kudzu.us, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733258225; l=3362;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=BqHEt8m1nlQE+CROgZ5Z9jf9BfRy50ieLQvI2rOkvkU=;
 b=QQN5g0eQRW0rJT6T5urTDAdXuYXzc5JS03FnK/FaP3Sz8oXcUuwJ5uVfJRcVOJm5kFTecJksZ
 ignF7Y+w9OBBBsuHwFcRA1yWCWjv+bq+HtfFq/Mj/jzSNBJd3IFolH5
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR05CA0013.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::26) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB7108:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ab7f54-4cb1-4b13-d987-08dd13da49e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ekpsU3h1N0x1UHpobnNsNnVmNkYvMTV3YXlrRVBTS3QwdjVVUExib0dTQXZZ?=
 =?utf-8?B?Z2RKVWpYdEF5bGk5eGxLaGRLOWM2QkJNV2UrODJnTjBKMll3dHM2Q296QVVW?=
 =?utf-8?B?OWFKMVBCSll3ZDdJOFlwUjJ6NkRaZUtOcndZNm5vU0M1TnlCdlJKQjd6WnNj?=
 =?utf-8?B?bmM5ZE94VlVYNnE1b2JLNGwyODR2NGlPVnFHSU5XaE1iazBSU1krQkVWcEFu?=
 =?utf-8?B?YWY1Y0o3V3JKekhJZ1kzNEV2TElLSDhqaEdpZG5KcXgrM2FVaHNHTCtLcnJR?=
 =?utf-8?B?UDA0em9pckZ2WDk3SWpnbTA4ZU9qcjhlaVBYZkNod2JxWE1pOXE4QXdtVFV2?=
 =?utf-8?B?cTlWNW5TMFFQWk9OcllHSlgxQmt6UXZTMjRTM012VC9LbzlEbXV2dk80YVd4?=
 =?utf-8?B?bUE5OERBUnlVTGcyeEVxcmM3UmFkSXEwVm5VTFFlSDBwYWNTVDV2VkErV2xQ?=
 =?utf-8?B?NUp5MEdkcGZNOHdzMWplZlByWGc2VFBUdjF3SzJTL1pId0JURUhTNVFHNDhl?=
 =?utf-8?B?UnVaSWNBK0YxZkE0MUFLVWhmVUtRcFhpcjBhRGxNQ0xwSDA1V2lVVm9FN0Zy?=
 =?utf-8?B?d3g3cTNjc013U2ZObDBGVm1ianVBWDRJaUZqVzV6Y3ZkZkRGeCt0empFR3Uv?=
 =?utf-8?B?WXJCRFAyd1J3TEVCOXdCY3NuSG9hT1lCYjRsUzlQRDVLbXY5M3JqTjViRDV1?=
 =?utf-8?B?QW5KOVEwdWl3MDNnTjdiSmpQYW1lWThyQnd6OTc1RTROVmtQbGthNERsWWlU?=
 =?utf-8?B?UEVVUU92MHJ5ekoyeFAzdDRUZ3EwUG1MdjNTN0M2cTUrbHJ3NTd6N2xMaHRR?=
 =?utf-8?B?SlZhUTQzK0ZNZ1FNaHFYWmlDNmVZcjFQcHQ5UUpSNWp3M28zU0d4RisyUHdx?=
 =?utf-8?B?cmhnd0F3Mnl4VXFUSE4xK2lIS1NYejRtUTZvOElRODRvQ0xYVWQwYTNaaEpY?=
 =?utf-8?B?dCtydW8zQzRIcVl5dWY1MGY2ajVyRUpGMmhpSFo2b2pFSVZBSmYvaHZSUXhv?=
 =?utf-8?B?aUQzQU9PbW1jTHZnOG5QczdGOXA2TGtrcGlvVDZDTkdsa3E4UlkvellJcXYx?=
 =?utf-8?B?QWFpYXMzVXBqc2ttb1ZYZ0VMR3MvSDlCRmIyQ0drTHd4R0tEQmlzbndZWU41?=
 =?utf-8?B?eVJHTDFMVUJXY25nbGZadElzdE10QkRsQm9QTUNWN2FrbmlsR04vRkZTeUYz?=
 =?utf-8?B?b0dyd1Y2SHpueC9JVjVYVWozNEgrUUNmNGN1UGRCaHhiTGNSZFNydUlLbGND?=
 =?utf-8?B?OGx0bGRONGRlaGdrUTN1STRjUjNkRlRJeERLRkxuWCtWdXZzSlhZb0F1ZTRh?=
 =?utf-8?B?Si9pNEc4bUdMM0RvSlBIb1pFWVN3WTZQbEhMRE10RHRBRXAzc1JoSzFvdE9I?=
 =?utf-8?B?dWpvTEN2M2kzV2FmWW1oSlBBY2M0WVJqckZhWkt0NTE0U0g3cUIrcVdrSEJi?=
 =?utf-8?B?U3l2anQ4Z21qZHprNmk3cW1WK29rQkZ2QjNvbmozZEhQemM2ZWdXUkpiWHly?=
 =?utf-8?B?U2lXTlpENW1tMVkxM0hWQ0RCcmNuUUZiSUEzbE91TitKTiszdkRCZ2ZVZm1Q?=
 =?utf-8?B?YWFtbmpiZEd1ZjJRQWN2L3JxNjI5elZoMlNHSmF3c0tkanJIZEZtRXJvZXJS?=
 =?utf-8?B?WExSNnI2RE50NGFadFRtaFVxSm5Ca0o4UmYyWDhPZzhQZXNVSDNYL2JsNmw4?=
 =?utf-8?B?blR0eW4xdXBEZGxiSkNuRVZhcHVlaU5rekhMSzY1Um9JZVZ1ZG53SzFyT3NI?=
 =?utf-8?B?Q3BidTJmTnl6Q0tnd1dLTngydTgvekNCMWVBQ3hrMFFFZ21ldk5kTTBVTHd0?=
 =?utf-8?B?S0htN1FCR1BGbTNMamcvYUc1TmpxRkw0V3JPMVJ2UkdwTVl2eFJKd3Q2VFFR?=
 =?utf-8?B?eVBzaWx1MDJUYVliODZxZHBpNDJWdW1wR0dtZDR5THkzTEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z1J5ZVFzT1A4c204anU5TEdqb0RMemwrZlA4ZkdEbDN5YWp1QXpPM3hEUGRy?=
 =?utf-8?B?ejZ4YitWVzFTdU9pMFRwYWp2R0wvMTdOU3RRZHJQcThXK3htV0NRR3kzYng2?=
 =?utf-8?B?S2h5QVAyQy9qM3Z0bEZpcjVhaFJ0N09zL25GVXdkdmVhektoZ1doNzhYaDBP?=
 =?utf-8?B?bStxa0ZSZ1NpbUlmLzA5VzNuRER4eEdkS1Z6dE9QME5UaVh6eG5raHhTRWZo?=
 =?utf-8?B?MFJDM0orT05iVmMxaXFMMDhUb1VzL1dxb0NOYysrMTk3VWZtZU9pdEhxZ3Jy?=
 =?utf-8?B?SU1UazRWSy9OZy9Wa0h1V2FHMVBBeGJQTTh3QldNSUhXOTVJd1JIbW0zbE8x?=
 =?utf-8?B?ZlBXR1FGZ2FCem40N2xHdk1kV1ltRmNiKzdldGtFQXg4aW1NaW03bUdaZVh0?=
 =?utf-8?B?bWNPWTk1d01wa01YQ0V4Y2NQOWFvRzlLMTBBeFhiRFpESmFlV1RwSTZzcGxv?=
 =?utf-8?B?d29wbnppSzRZc29uOThLRDNib3dLeUczKzJUdUZqWnlIWlRTRlhlQUtieHNj?=
 =?utf-8?B?K2FBSkNiTjRDV0R6ZFdKUTM3Vi9pWnZHZFlBem1WL0NGVFp5Q2VRN2V3OWZo?=
 =?utf-8?B?WTExcVFhNG1UUkVTZE1ZR1g4TVpJanpBK1lQRXB6Y21wVzE1bjdaeVBaeXJh?=
 =?utf-8?B?OW5EWEl4dWZ5cFJIRGsxSHpraVB3a2h5WUlmL3RrY2Y5S2F6aHZTdVdPYUpJ?=
 =?utf-8?B?R1JrUjdYam9Kb0RLdFZHNC9hZWEzYUlwU3VJS3RpSlNBdFhmOGNvZENCQjRB?=
 =?utf-8?B?eTMydm1oWmV5ZUQyQmswNmNubWxkVloyQ3VBbVdnNXR1TnBrTWhxWk95TW0v?=
 =?utf-8?B?M0s4UTlDZlJUNXNNbUJUb2JVZVQxcS8rMHhIOU04MTVIZTBnYmh1K216aDRm?=
 =?utf-8?B?RWg2a1QxeWFBN1dpUWE1VVdBbHZHUFFnWFI0eko1dkpYSG53TkM0LzNZUmRn?=
 =?utf-8?B?OXcyWTU1R2NXY1ltWWFrMyt2S2NyMGNiNEpkN29pL3U3cXVOSGgzVG92SVJG?=
 =?utf-8?B?Rjd4NmJTOHhFRnZjZ2tqNWdpSmM5Y3cvVVM2VTl3MWxOQlZhZmJGNHdQVERQ?=
 =?utf-8?B?Njd5NWQ4SG5iQjNzM2RSNDQ1N25SMytiTDRwQSszS0c0STB4Wi9MZDdMbWhn?=
 =?utf-8?B?b3BLdTEza0Y4aVl2WVZZNEpnWHlnSWVHM2xKNktXM0lwbmxLaGw4M0pacjc2?=
 =?utf-8?B?b3JrMXM1SnlaOGh2b2R3QSt5QmxMUmo5ZkFRM21kdDlEUmZyaFowWXJsR3dQ?=
 =?utf-8?B?TnJ6Ly8zMC9CTW8vWnoyVFRpaVRVZ1pDVTlMVzZ4azVsdnMyUHpzR3ZvZTZ3?=
 =?utf-8?B?ZXo5YTJYOTNCVlZRVWp6bkhsTUJsaG9SMEErOTNjSXpEcHFoU1JoV1pDZVBD?=
 =?utf-8?B?eWVPejVweUUwMUNWQ1IrVGYvRENWbjVpY05PdEpRWVIzc2RRV1gxeUMyZmRu?=
 =?utf-8?B?NGVnaTBhZzd5Mjd6clBySlNxRmF6d3gxR3ZvL0hOOW83M3F1anF3dnFaUWdM?=
 =?utf-8?B?ZU91VWdlYjJQbXdBSnRORi9wR1doWXhPOTR3VXlUbVEzYjdKMDBXSnZqbEp4?=
 =?utf-8?B?L0NEVWpmOFV4YnIwa3NiSGtjUXV2SGlFbGtEd0lGVkljdjkvK0FFSjR1bk1W?=
 =?utf-8?B?bnBZdGswUER3MFdvc3RUR2dESUtoV3p3dVI0WHVpNkJlQXZQbFduZTdvYXQx?=
 =?utf-8?B?M2IvNEFoV1B4aWV1YStaSkUvZ2lCMXVRamMxNlJJbTRxZHJDY1IvMnpTS3My?=
 =?utf-8?B?anJFV0hRbHNiaElxdWNTWDhVZ2FVczl5eUJld2ZwMnJ1QWpuQzZMeXpRcnpy?=
 =?utf-8?B?dkNXWWRpK2crcEFkRGhWbnY4VHhHdU5lRjFEYVJ1bGtZdEIzQ1pHMGJkai9l?=
 =?utf-8?B?N2E4emZmRnB2WDhBV3BIeEN6UzBGQVZRYnlEcldTNHRRT1J1NnBTVEt4b3lp?=
 =?utf-8?B?ODd0R3E5U21kZFlad3ArQzE2VEk0WkpiL25kR3BWcDRrZEFOMnNaaXZFVjJq?=
 =?utf-8?B?YzZHU2xKbGdNdkxOS0xMeW8yaUVaR0EyVVJMcnNMWHdsSXdFSWsyN2RZNjdJ?=
 =?utf-8?B?VXZ2ZzFncnFwZGJoWXAxZUdBeW1ET2JFZzJTTmxSU05VNktOT2NGOUZoVG5x?=
 =?utf-8?Q?oY9Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ab7f54-4cb1-4b13-d987-08dd13da49e3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2024 20:37:22.1031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: reAW98dWL4AB9PC8b9g1xf6w1T6X1P4Hr2h1LadXb2MCbPLzXbFV006RJw63AJrOlZEC7d/UATzbGPNMJYGLIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7108

Introduce the helper function pci_epf_align_inbound_addr() to adjust
addresses according to PCI BAR alignment requirements, converting addresses
into base and offset values.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v8 to v9
- pci_epf_align_inbound_addr(), base and off must be not NULL
- rm pci_epf_align_inbound_addr_lo_hi()

change from v7 to v8
- change name to pci_epf_align_inbound_addr()
- update comment said only need for memory, which not allocated by
pci_epf_alloc_space().

change from v6 to v7
- new patch
---
 drivers/pci/endpoint/pci-epf-core.c | 44 +++++++++++++++++++++++++++++++++++++
 include/linux/pci-epf.h             |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/pci/endpoint/pci-epf-core.c b/drivers/pci/endpoint/pci-epf-core.c
index 8fa2797d4169a..d7a80f9c1e661 100644
--- a/drivers/pci/endpoint/pci-epf-core.c
+++ b/drivers/pci/endpoint/pci-epf-core.c
@@ -464,6 +464,50 @@ struct pci_epf *pci_epf_create(const char *name)
 }
 EXPORT_SYMBOL_GPL(pci_epf_create);
 
+/**
+ * pci_epf_align_inbound_addr() - Get base address and offset that match BAR's
+ *			  alignment requirement
+ * @epf: the EPF device
+ * @addr: the address of the memory
+ * @bar: the BAR number corresponding to map addr
+ * @base: return base address, which match BAR's alignment requirement.
+ * @off: return offset.
+ *
+ * Helper function to convert input 'addr' to base and offset, which match
+ * BAR's alignment requirement.
+ *
+ * The pci_epf_alloc_space() function already accounts for alignment. This is
+ * primarily intended for use with other memory regions not allocated by
+ * pci_epf_alloc_space(), such as peripheral register spaces or the trigger
+ * address for a platform MSI controller.
+ */
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off)
+{
+	const struct pci_epc_features *epc_features;
+	u64 align;
+
+	if (!base || !off)
+		return -EINVAL;
+
+	epc_features = pci_epc_get_features(epf->epc, epf->func_no, epf->vfunc_no);
+	if (!epc_features) {
+		dev_err(&epf->dev, "epc_features not implemented\n");
+		return -EOPNOTSUPP;
+	}
+
+	align = epc_features->align;
+	align = align ? align : 128;
+	if (epc_features->bar[bar].type == BAR_FIXED)
+		align = max(epc_features->bar[bar].fixed_size, align);
+
+	*base = round_down(addr, align);
+	*off = addr & (align - 1);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pci_epf_align_inbound_addr);
+
 static void pci_epf_dev_release(struct device *dev)
 {
 	struct pci_epf *epf = to_pci_epf(dev);
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 5374e6515ffa0..2847d195433bf 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -238,6 +238,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, size_t size, enum pci_barno bar,
 			  enum pci_epc_interface_type type);
 void pci_epf_free_space(struct pci_epf *epf, void *addr, enum pci_barno bar,
 			enum pci_epc_interface_type type);
+
+int pci_epf_align_inbound_addr(struct pci_epf *epf, enum pci_barno bar,
+			       u64 addr, u64 *base, size_t *off);
 int pci_epf_bind(struct pci_epf *epf);
 void pci_epf_unbind(struct pci_epf *epf);
 int pci_epf_add_vepf(struct pci_epf *epf_pf, struct pci_epf *epf_vf);

-- 
2.34.1


