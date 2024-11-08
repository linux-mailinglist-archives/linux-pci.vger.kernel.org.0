Return-Path: <linux-pci+bounces-16357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0F69C25CA
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 20:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2BA0283023
	for <lists+linux-pci@lfdr.de>; Fri,  8 Nov 2024 19:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90EC81F26E3;
	Fri,  8 Nov 2024 19:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="oWno+ry7"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2067.outbound.protection.outlook.com [40.107.21.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977BE1F26E8;
	Fri,  8 Nov 2024 19:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095049; cv=fail; b=qkuCcYkDKCB9Rr9UkKw/cAleKXMufBF/6x3JIWY0ubvx4tpxNfB/SYu+/8zgG7YqiAviPwsjn2eooIK4A0RBE/P/Fj1l2uNF0f/O4P0PUxxyBiFspyZ01CXMRZ/AzvSxrQHLXWDtxF5tyKBMYea236ufvQ1kTYyIj8uCYfQKHL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095049; c=relaxed/simple;
	bh=G/yY4CrPOouB+dXrLHUGTnxa+S7MToMCeY+wZ3vMPxk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=F060o/jTSOXs2096380rZyOJeMPtop6d8S/L2ZNBLaBW77NubWirSGWM7h5eCskgfARov1SV+XQ6/nHnxvRb75bOAwiIFF5JmA/Fe0Ntg+j/p+TMg6ER8HMdZ8OMjHLMqqHR2fNvaH8v5NrA6MlrePMfugaURd75cw18oZuWMeQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=oWno+ry7; arc=fail smtp.client-ip=40.107.21.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mm03sEtGVGeklBftXm/q+3KW71YQfG541i8vTv09+d4vERxFfnDHvFiA6W1r6EQnytMjLXVSlrixfp4op0TWpAtLno+QROPNu2WXSY51QU0smsH2LUNGGLb87uG6k2bqNLJ+9mhZmHK+fadaw7d3iEmxu2agd4zLkeR4VMnXOa7e1q1fKH9n3dVqFo5dqV7ARBAA03IJw1YlpMPA7ZMUG2GCBBFV63ChzpqOjeXDVHjlciBtBSXUmXyaPGaB143eTj1X1YYK69E+BUDeq7IMPQmVBL5C68/b/T8GpE7f32qnJzDFCc2a2BTzYYEkw1htTb/hrNr8hJNPCv51MC3iHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2yCmUQdPdUzzzBlVi0xn7vIIg3JeouJV/1R9GlTHoTA=;
 b=LRW3jSELVWlslW3ieYXmjJtGkCxuVJiskafB+th8HgnnC/VEK6zN1ufDY1+/akO7YtU6eOpT6MHDprMjWOOfSaLRi3QbDyss44z4l8ErVeNzmxgXG9Q2Nd6/ZglYvnogfjjmX6Ea0cZ1+tFrtcsvXDE8v16x8b7PLxvXaHkfpLTe2h1iXyppCX5RTytd3gSCFrQZIgu9xDnVaEulGHcogPw/P8tsre4wimRn7axry2gM1hFdatU/YU87DtBYiupndXvd7cmaWNFHqj2/+mJJFEh91FzJysbBKt/YtKvA2iqF/ql++RRcI3elrEK+t22l0McCGN91IIyeXp/SbAN2/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2yCmUQdPdUzzzBlVi0xn7vIIg3JeouJV/1R9GlTHoTA=;
 b=oWno+ry7vAoottUGg9OsdTp+0+zZ6aIZFd6Hef9YGDjw9D65ZRL8/6HppWK+NnT4P6i6V8A2AM21hySAr9h8RYgLqe5ikaAkO525wlJ4rfDebwdzxf3kMXVElOfdMc5ee9X5SXrWSVq8RN6whJDQ2jyBL1RqOPV9LwyUHR6ArTreOZ/YmwYBkMKQ84GaH11QaGG/2tsmowFQWKO8wAsvVp+BeqrCfrkBeulYWr7FQhkhIQNOXdmjnlk+bZI8gcO5DPqqWvf6pW2j1rgGnjqCnU2JiTXe8M5xeJDxL8HKWpbbcWFg3IKJhRsKrU2MZLA2kRsOyMO6/lL/q2IvqUhjXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8669.eurprd04.prod.outlook.com (2603:10a6:102:21c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.21; Fri, 8 Nov
 2024 19:44:04 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8137.021; Fri, 8 Nov 2024
 19:44:04 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Fri, 08 Nov 2024 14:43:32 -0500
Subject: [PATCH v5 5/5] tools: PCI: Add 'B' option for test doorbell
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241108-ep-msi-v5-5-a14951c0d007@nxp.com>
References: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
In-Reply-To: <20241108-ep-msi-v5-0-a14951c0d007@nxp.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
 imx@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, dlemoal@kernel.org, 
 maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731095022; l=1804;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=G/yY4CrPOouB+dXrLHUGTnxa+S7MToMCeY+wZ3vMPxk=;
 b=+BhbJy4Ltv91y3dtRF93z9RGWMXDturZTVKFbeWeCay8qN8bl7APkDApsgn4wGR6dSZAFf8xK
 hQwumJJCiUNCchn/1qHoOPLg/W6EBLKvnqdcEuxkNO6sjA4H6JPUR49
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5c3::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8669:EE_
X-MS-Office365-Filtering-Correlation-Id: b17fa552-e258-4918-d419-08dd002db3bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|52116014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmJXZmN2UkpTK0ZtbWl3Zkd1S25DdnNYeE5zblRsRkVwZ3lWY1U4ZEJIVHVX?=
 =?utf-8?B?RFA5eDNzMG5pYmdwZTRrTDJTVU1jM3FLMEl4VDB4U085RlF0QU5rbis4UWd3?=
 =?utf-8?B?eS9qSXRmTUlOR3NlUld6NEpOWFQ3TjQ5bHcrTkpKeEdPOWVWSzkyL1VpNE9z?=
 =?utf-8?B?YnR2eEJBNE5kYndsMStFbC9mdGlrVVVUbXFlRWJUaG0wNVBYZUpYRkErSXhD?=
 =?utf-8?B?UWp2ZE00M1JaTkpVRm5VMVJrc0JQM3Y3OVNMKzhuTjl4VGZ4ME8rMHFycEQ0?=
 =?utf-8?B?bnl6SUdIWXRicVlsTDd5MTdheFJEOFN1SmQ3YlBINndEelZsZE0vMFFPWlY1?=
 =?utf-8?B?aER2ajdjSDd6SG5WY2IyNlVvNWZxUC9LVDhnVVZhTlFEVUU3VSt5ZDY3LzFn?=
 =?utf-8?B?QzRTbEVZQjVmR2UzR0tPdERkWTZIekRnMngxR1NndVFmdnZpSFV4UmpvbTc2?=
 =?utf-8?B?TEdyNzVFaUZFL2lMelFuMHcxNEFVcmJUNnU2UTBJVDZwQW9NWlNYa0ZmZ05B?=
 =?utf-8?B?T3c0UnZDSE9sNXQweWk2WXo3YlBHR0dhVzA2aXB0S1l3UnBQQ2hVUWtGOGFX?=
 =?utf-8?B?Y2NDMngvUklnUlc5M1BGZGpaRStHZy9PdXR0U0NETXBPSFdjT2VhcE53aG5p?=
 =?utf-8?B?YlEvM2lOMzN4cENWWWNvam93QlNRbFZHOHJQRGhBSlFvKzgwS3RldnF0by8r?=
 =?utf-8?B?Sk1pK21IbHRUb3BXSmNwaXljZmdmZXliM1NJam5PWTV6Qkg5RTl3bVB1Wk1t?=
 =?utf-8?B?Umh3SlBnb25qQndraHE5WlE3TCt2U2dNY25aQXQvUWt3TWcwbkl4UGl0ZXFH?=
 =?utf-8?B?WFhJMXB6SSs0ellNaUdsa29VdzB4WWhSNjlHbDZQOEQ4VHNtcnlJSjVQZ3py?=
 =?utf-8?B?SFp0SFZSRGVYN2ZqcXBIU1ltRlNtNWhMMWMrL0kzWFI3UGh1MGNLbDhka25Z?=
 =?utf-8?B?YUIya1BpYURpTDVKa3VUNzBKSkNnbXI5U1lqMC9CcnErcXlCRWVCVk1sNFdQ?=
 =?utf-8?B?WGxKMHJSWnNFUnlCQlMrZjl6TzNha0RTWm5MamE4SW9XREkzZG1YcWJLaTBs?=
 =?utf-8?B?ZWFjM1Q0MnFjTS80RlpVWW5USHR1aHVWZVUwTnc2UE4rQmZSdmJ2SHFHblFr?=
 =?utf-8?B?Y3UrWVFyUXF3WWRzN0h5cEVJV0g0RFZrWE01Y25XYTBWbmlRZFZRT1BwYjdo?=
 =?utf-8?B?a2JJNDd3Q2FlRDRZRW1FY2lwMEMrb3drTG1LZndVQS9ZWjdiaDRtQ2NYYTZN?=
 =?utf-8?B?NzhWLythY3ROTVdHMjR4RHRXRFNMNGFKL1kxTCtWYVlZZVdnWlFvYm5wNVVq?=
 =?utf-8?B?dm41MjAxejhjbDhKMG8xRnVSZE53ZVVzc29mQ2x0eStVSWloS284S0sxUTlR?=
 =?utf-8?B?dnFwRFJTSnVEb3JRR0ZobjJCWmNoMjFmVCsyL2RDS0Z3dG9nNEo5QitXZmN2?=
 =?utf-8?B?em9Cb0RJLzNVL1BXMW8rTkROVGoxNFJhZTZLcGJhaEpETmx3NHEzTEx6ak9R?=
 =?utf-8?B?OEFGeHY3VUdaekxzanh3eGxpenUxQkRjV2l5SjlwODhoVzE0Yy9QYjY4UHI3?=
 =?utf-8?B?MHZzcjdKUlVmMmtMa1k5Mk1tV0QvaFpnZ0pYYmRxNDM5ZmtkdFl4RVZiTXpG?=
 =?utf-8?B?eWM4YnhJNWFvSTBGSUxVS0FiR3VpOGpHL1R4RnVBRnk0Zlo3Q2JXSEk4NVJr?=
 =?utf-8?B?Y1RsaENENFAwa3crN2JXVkdQdG9IOURhcGRRVDFXTGVsU0xoTllXcnkrYm5B?=
 =?utf-8?B?VEdic2Y4SDJJUmlEdjVrN2VPbndITHBBM1ovUXJFN20ydU1iM0NTVXl5VVo2?=
 =?utf-8?Q?wh4culCuRYQV89Yh2fe0Q5YJ6fp2DzzsdbA3o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(52116014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ajJmRk5WUSszdEE0YXhmWXhKNituOGZ1NVlFZmxaemk5cGZaTmpaSVZUUlBS?=
 =?utf-8?B?c0Z3QzZYb0tFL2VtM2kwYkpuRzR6UjJ1KzBPc0JTd1pDKzlGN1dpZU1EYjBh?=
 =?utf-8?B?K2NFNXZzRyszNjdBSFc0UUNUVEVzaVBsZWN3OU5zN0d1NTNTRDBXZnZlRk1y?=
 =?utf-8?B?bmxNKzVKTXNLZ1d3cVltekFXQ3VJMGlKQi9KbW5FYXRWSlFrYVZKWjY2RStr?=
 =?utf-8?B?clJwL0tla2kwV1dSU1pYT2FGUldVQ3FLQjYyRjJZM2tLMmVPS0Y5cUFVdUtB?=
 =?utf-8?B?clhUUHNSTjBiSDFpUnk4c0MyZjRjRFVuUTJJSjNZcU5OSU13d0VKdkx6RmFU?=
 =?utf-8?B?dWgwRksvaFdoaUFNZkxySVFVL2F3NHg0dlNVRytQQVdsYXkzblc5TC9KUFFU?=
 =?utf-8?B?d0ZZMUNldmZJdlZVTU5kN3BMSGlpN0QyR3BVbVlqSk00VGR4Vk0xSmg0bUd5?=
 =?utf-8?B?Y1I5MTZ2Ykp3cE5zWW56Y01YWjNMVVVHTEtaa1FiMHQxclVKWDFHQmpKVDg2?=
 =?utf-8?B?bFlBVml1eHJGbUovMFpCemQwSzMxM0RuZGdBU0hOSUNHOE11SmpyMGN0MXh0?=
 =?utf-8?B?b1Bwem1sNU8zQWphTVhkMW1JUVVLQ3VkNGg2akhCeGVVcXBMeHJPL3VQTHNx?=
 =?utf-8?B?aHk2dWNBNmg4NkFuM0JCaXNnVGh5ZE43enRiQ0NyOVFZV2xQUkNpNm5UbmdR?=
 =?utf-8?B?UUMrb0RCN3pZcW54SDU3K0JWT2g3WlhqUmdscFhuTDU0dWorSmt6VG1QaTVZ?=
 =?utf-8?B?T3QreVVNcGNZUWttcVFrVm51a1lkdHNDb2J0SFl0Zzh0R1BOTGRyUllHeUYr?=
 =?utf-8?B?cGJYZ3c5cSttK05rT3BIc3RZcDY3aWFNVGxXQlRvMk82TzFCTjhaWFB4VER2?=
 =?utf-8?B?ZVpiSnk5Z28rYUVWWFVxd2U2c0lzSHJIZCsxbE1BakRnS0hkZGdpbXFJOVdY?=
 =?utf-8?B?ZmN2SXA3K2d1ZjNpcC8yemJzZ1JaTGF6Nk53aXBpOVY2M3U4emdCY09hL0Rk?=
 =?utf-8?B?Ylh2aDF6NkxPQThjM0FyUGNLbkx1MFpaVHF5amQwdTJsSXVnbmRDOW1CYXBB?=
 =?utf-8?B?eFRDVW5HSHZ0MUtxQlBwbUhzMW9WalkvNFQ4eW9LaDA0QnN1ZGhRMm5LUjZG?=
 =?utf-8?B?Sk01MFJ5Q21keUYrd2Q4UU1ncjFrRWI2NTFrSXZZTlRjd0l3SnVVK2dpdks3?=
 =?utf-8?B?aHc3WWRxcXh6RjVTNjh0dTRlNXJtZFNoN3E2QWxXVHdmUUJidW1CVWRhQTFH?=
 =?utf-8?B?OWNzNnJlQ0M5U0hSM2lhVHVNNFNXNzFqcWloUC9RbjV1OWV2c0ZzZzhidjRh?=
 =?utf-8?B?WTBEcktYNiswN1V0WnF4NFN1V0l0RE4vdkJtb1pzRXNYRncyMnh3UVRYWVk3?=
 =?utf-8?B?ajh1ekJPOWhDVTczNXBqa2tWcENLV1pqdlM0Q2hrcFFpbGtOZW9PRHFEQXNK?=
 =?utf-8?B?eHRWaU1ZU1o5dHlSMnpkOTJJaHdvQXU3Ly80c3hqUGJWWDVqYW1QL2tTOStu?=
 =?utf-8?B?b3VhcmNpOHVQdGI2V0RUaEU1elJVQVB5NUZHUHpuU2VjYm11M213QWFRS1ZI?=
 =?utf-8?B?SkxMcjJpV3I2bmt5aWpiUUJ1V3lzYWtHekVMMHlKN2lQaFdma2kzWDJxYXB1?=
 =?utf-8?B?R0VRUVlnczQzNXppVllCWnpMU0dLZFM1TXN0QkhLUjU4cjBhVGRnYitTYVJV?=
 =?utf-8?B?YzVGdmhPTDNJYWJMaGhnc01odnRaTWFiaGdrZ2JjWFdVaHd5bjRWamtucHMz?=
 =?utf-8?B?bEpIblRaVmYxZTJkVFhnenFIWXlTbEQwejZGZWwwNHpBV1hZQ01SQlowQmFS?=
 =?utf-8?B?eWg1Y05sU3NJVkJDQ0RuWnFlMTdqVHFLb29jQ0krd0VXT3FCWUtiTGhLYm53?=
 =?utf-8?B?YllqdHV5cThtUlkrOXdPQUN0T2lKS3FQZkJnSHNRemdONDZ4NFNuVXBwWkpL?=
 =?utf-8?B?NWRrb29aM3E0aEdKRUNDNzdueVk3Y256bVF1bzY4Y21pNmo3MVVFcHMvdVdR?=
 =?utf-8?B?WkI2WWIwTUJtbU1QVGJxTjU5a09IYmlQM3VUNnVPak1hN2JTZ0cwelllNzE1?=
 =?utf-8?B?UnYyYU1CVTArVlVDUnBJT1J5VUZMVytxYUx0TVYyZ1JMaHJ4QWpCWldSZHNW?=
 =?utf-8?Q?FTaXL+7AY4HrnuZ/L6lDqsUBZ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b17fa552-e258-4918-d419-08dd002db3bf
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:44:04.6595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WmUqmDSjMStBqWL9GDTSb81J5kbpd8lNFdLQxbHWttfzR7HfcBNS7nIV/lbYsjHtcQ3zlHMeRC1lO0BKUVWoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8669

Add doorbell test support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v3 to v5
- none
---
 tools/pci/pcitest.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/tools/pci/pcitest.c b/tools/pci/pcitest.c
index 470258009ddc2..bbe26ebbfd945 100644
--- a/tools/pci/pcitest.c
+++ b/tools/pci/pcitest.c
@@ -34,6 +34,7 @@ struct pci_test {
 	bool		copy;
 	unsigned long	size;
 	bool		use_dma;
+	bool		doorbell;
 };
 
 static int run_test(struct pci_test *test)
@@ -147,6 +148,15 @@ static int run_test(struct pci_test *test)
 			fprintf(stdout, "%s\n", result[ret]);
 	}
 
+	if (test->doorbell) {
+		ret = ioctl(fd, PCITEST_DOORBELL, 0);
+		fprintf(stdout, "Ringing doorbell on the EP\t\t");
+		if (ret < 0)
+			fprintf(stdout, "TEST FAILED\n");
+		else
+			fprintf(stdout, "%s\n", result[ret]);
+	}
+
 	fflush(stdout);
 	close(fd);
 	return (ret < 0) ? ret : 1 - ret; /* return 0 if test succeeded */
@@ -172,7 +182,7 @@ int main(int argc, char **argv)
 	/* set default endpoint device */
 	test->device = "/dev/pci-endpoint-test.0";
 
-	while ((c = getopt(argc, argv, "D:b:m:x:i:deIlhrwcs:")) != EOF)
+	while ((c = getopt(argc, argv, "D:b:m:x:i:BdeIlhrwcs:")) != EOF)
 	switch (c) {
 	case 'D':
 		test->device = optarg;
@@ -222,6 +232,9 @@ int main(int argc, char **argv)
 	case 'd':
 		test->use_dma = true;
 		continue;
+	case 'B':
+		test->doorbell = true;
+		continue;
 	case 'h':
 	default:
 usage:
@@ -241,6 +254,7 @@ int main(int argc, char **argv)
 			"\t-w			Write buffer test\n"
 			"\t-c			Copy buffer test\n"
 			"\t-s <size>		Size of buffer {default: 100KB}\n"
+			"\t-B			Doorbell test\n"
 			"\t-h			Print this help message\n",
 			argv[0]);
 		return -EINVAL;

-- 
2.34.1


