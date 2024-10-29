Return-Path: <linux-pci+bounces-15547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3112F9B4F82
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 17:37:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5CCD286240
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2024 16:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861261DE2B5;
	Tue, 29 Oct 2024 16:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Te2JhypP"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFDC318FC9D;
	Tue, 29 Oct 2024 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730219832; cv=fail; b=Dy3EFB9vRJibGKjymSw9MwoWpfobiKostR2ZoQW2Bs3bOPx/W8A77AMMqZrVdbb2ItI6LONIEaW7qs0lyFubDoEMe1bQ3C651PT1ly3kxQEYZ12fmbdTqMQVPxh+Jn6nv5zokQMMu6FfP3mEoSzrOEBykB8bZzC9rUne/23/7+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730219832; c=relaxed/simple;
	bh=QOgfKyodPSXGdn059Wbm5lzn0V1+zBWDoUWmg/pDYgY=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=DfoE6jLRKvwOTmSYNQodx3qmCRA7SGrLb5fFlRmxQN/IBB9EaIX6usT2Ud+bjBw0cm/88xpzuJ8Oxp2VurIEit89C93zWyEIcRxhLrITCiz+LkyDr99o26y8p6iGX1gs4ZLk0GMKuu+EQ8JriM8tzLR6/YnmEE5uqTe1fmCwMs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Te2JhypP; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LsW/o/rlbIiN99CIYiFjhAecK6heBjS5Cpsxkqc6uVRVC+sVqgm+CPVh7ubi3wucIMQaNPujJ5OvS+z/sicl9Fyr3FRR6KLdyWQx9JO0hkrNxhV3j0qieYcXhOujoAcduCMKGwtnIUXoO/mer2SELppel5PRmtVuB/qQ2fSi5705Td1WeTyHgLrzDDxXqWiYg9g7pSknm4TVLcmlTZY1cE9fpnkoGwtU8KQtEdHJeq63fY0Nz3ayQzSRyFhOY8B+JnDwQggs9f5k5BNxiUJlCMxbVpFrusvL7AdHJZOtsy8/Wx2mmpvfsSTu6l2zWhE/vuFYMLuNISDP1mRr5eJmtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CIjUKF1pCR2NnXoJoZT8XtU0SA8MMpxu73bnZDj5E6g=;
 b=DjbV04Tw27NNn0Jv+M3oLI4d1OqP/xxDb0G6iO7V+7g47KR0dooRNOspzmN62iQjQcBi20jSBaXEslVlPAsedTvwUGQLCWH7o0HKLTVsCBH+lnBhaxY2CdNFAUdjO2opUfg9bpmio8KqdselMZrwZCRhLP/eKp0LFfqv/epdgd10CslJ8kxRG7cwCB030V8pYv/N+LJZt5YedFQ1ZOQ6ZOXDuaaHKbkHjveiJaid4sQvFD37DRsA3/TFofGWLxYON3NOgGxdMHuEpj0B5RwZvvS4ldkoofEsPuonjkLVKdp6zQZpuiiTs+BsxMXzRw4eOJdDOQ2ijvf1B1V3jWMDFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CIjUKF1pCR2NnXoJoZT8XtU0SA8MMpxu73bnZDj5E6g=;
 b=Te2JhypPy3Z7re/gLb0TBIIhQh5DrKOFggl+BB6gnZ4AW2iQ7uX3QVuwh53HyCPGF3vaVn0z6gXtUhGz0yjMbXl5CU05il3W89gd9SvJ7JBZyVOPhpCb/lPFUq0LSBIAFMWh8diR4mAzVMPPCdXykkmFymEXr83KsplPnSzJiVfm2lXMof9p61nyC/JRllw04q+0IaB1ChsvW2mkXqdqNzjAfPSOaTG02jjQAkRAH8MdvVxVVGBChv0fb13Nf/h0hRXrOcZ6Pj1vwi4/jdUhJlB37qGxFQKKhnzrqEDiAuexu2zlL0ylS6ByEOzuEPuer1itxtDyupJKvkQMfOxslA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7577.eurprd04.prod.outlook.com (2603:10a6:10:206::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.32; Tue, 29 Oct
 2024 16:37:07 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8093.027; Tue, 29 Oct 2024
 16:37:07 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 29 Oct 2024 12:36:37 -0400
Subject: [PATCH v7 4/7] PCI: imx6: Remove cpu_addr_fixup()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241029-pci_fixup_addr-v7-4-8310dc24fb7c@nxp.com>
References: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
In-Reply-To: <20241029-pci_fixup_addr-v7-0-8310dc24fb7c@nxp.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730219803; l=2455;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=QOgfKyodPSXGdn059Wbm5lzn0V1+zBWDoUWmg/pDYgY=;
 b=9wvE6bON6I4IaU2EIMPtWUKxcAjgPgF13XjSP41Is/Klje1XPIpcpF4IMwvSOP/eKvEdLjWjl
 qf7zFOo8ip0DMKi3N0DXP4rAX6Y8vfhiP9wtXPBMET2lg38tXC+fXeU
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BY5PR13CA0035.namprd13.prod.outlook.com
 (2603:10b6:a03:180::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e7d3cfd-5e2a-4d61-8be6-08dcf837ed57
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aTliUm0zTlBnUnJtYkVucFp6ejJJSytYRlp3OXJydk9uUWgzZFRUQTE1WVBK?=
 =?utf-8?B?b1ROZ0VGY0FhWDhxb0RVY3FNY2NWcTFEWHo4VU5zZlpncFVxdGs1Tk5ua2Vy?=
 =?utf-8?B?MXMraFlxQVF2VThsYkRKV0lrR1JmQnRONnhHZDJsM1BhSE5EK1hmMU9vRnpU?=
 =?utf-8?B?QUkxTXNmblNqaTV6Zm9rMnhHYXZERzArYTdWbmpQMXZEYXBSUHVjeEMybFlQ?=
 =?utf-8?B?U29ONG5JblU5bGQvTk4vb0tTNk1UVFFCQ2xiR3JORGI4VzNubnFGNWNXOE1N?=
 =?utf-8?B?SGptdzNUME5BdHZHMmZ3SmppcHVPdTNHempXWTBTSzlmVjc1RVRBQjF4aTlO?=
 =?utf-8?B?SkJvbWczSTRucmtENHlzVzJxaHhpclIvWktnT0EzNGhMMXpLbTR5QlErT3pu?=
 =?utf-8?B?amE5WjUzTnBVWjNNd2hLaVlUQ0JiYytraWVsWHpMcFNLeEZIK251elBpRXU5?=
 =?utf-8?B?VnJJaHdDN3VuVzQ4RXNwSDNpbWFYMCtpRTVDbU0rVjBQNndtbC9oYkRTcW55?=
 =?utf-8?B?YWRMc3dzYm5RSHNQNXdobVlIdGx1cXp2MWN1MEJTVjZIK1RhNllROXAwOVNY?=
 =?utf-8?B?MjVxdkNDOUFvcXlESUtMelNkZWNnRjZ3ekZ2cnFSZnc2ODBTRjF4THpEZ3pS?=
 =?utf-8?B?TzZEY1BpT0NPeTU5NlV6Q3RxNUNUOUZ3Z0J3VjVveFY4WnR1dmJNemdYZUg4?=
 =?utf-8?B?elpVdE41eGQzZ0xDYjd5ZmJhR0d6czJQWmNJM2ZzdnYrSjE3dlpicXBvRjRX?=
 =?utf-8?B?aFNUdmx6UDVwUFlVWjhOeWx0THYwTUVQRGlzWEpZQ3hxZ1RaZitHUytwNVZ4?=
 =?utf-8?B?OVFwRFhoMCtVME9MdzVaOGdxcHc0L2lNOXVoaU5WY1BiL0liR1gra1Y4L0lN?=
 =?utf-8?B?YXBxcnRrNEd2bUpCVzFVeW5ObHNXQ0xHTG43TVFnV2dZRi9nOFgwRUJSaDR5?=
 =?utf-8?B?emVsN3NORWU3Zzc4K0VBaFFKYmhNaUlmN0lKYk9POFpNS1NxTk1RR1pORHlx?=
 =?utf-8?B?aFJJaS9ZVlNiUk5qWmdnUlVoN0lzY1ZNZndXQXdEazN1Q2pyeTJlNS96bytx?=
 =?utf-8?B?ZVVuWWM1MVdhUVgwcVVIeUkwa0RJM2tWZUJlSWlzZWpxZFRLWnovd2VadnIy?=
 =?utf-8?B?SFNvK295K3M4U2p2ODhCWkdzQy9zdUZHdzVnOXBqc0xndVFORGJwVXpQTGpO?=
 =?utf-8?B?NGVwbi9wUjlJSVZnVkd2dHYweXJIU1p5QklQUHBpeFZOVEtES0lNS2grSEJP?=
 =?utf-8?B?Z1YvaVp1Z2RCMk81NklkWDhwMWJ0eXl2eERLZUNvdlVNQlJhVGxBOFhxYkVa?=
 =?utf-8?B?anpqNHgwOWE4WXN2Rlp2Z2FnZUV3Z1ZVZjl6VmN5TjFQcmlndGRHTzJqc2xK?=
 =?utf-8?B?SC9JRjZESWhyMzhkSytoQU9YOHRXOGZkNlhJbUlCb21lZ2RtL2FZUDlRN2hJ?=
 =?utf-8?B?cm1BdjRGaEthNFBsWWw4VDJnMUJXaDF1eUZKdjk5RU5aczdsM1lDMWNQcnpG?=
 =?utf-8?B?K0lxb3VZSEY1SG9xcEgyUWNkZW8za1JtOGlPRU1CSUg0SG5MVUhZL2g3Mnor?=
 =?utf-8?B?K2lYMDdiT1dZM3NRMnRwZE1lbS8yQWRJNXJnenBKZWNkelI3Q2NIbWhOMWVD?=
 =?utf-8?B?OCs3WlE3b2ExUXhFK2FqeCttR2pOSlJzc296R3VQanYramVuTFpWZHlxOFBy?=
 =?utf-8?B?ckl0RVV2UFFPTERuUzErR3YwcVFtb1crbVZZTk4wNFZlQ1pranRhQTdCdVZ1?=
 =?utf-8?B?RjVaSkNwKzV0dEowdWROVE5kK2tGMXd3K0o5Q096SEZYNGpMdXVGLzVFQkRp?=
 =?utf-8?B?RFQ2eW8vVEh2Qk51dlE3dWpsTlA0SFdxWjRLc1p3RjZlUVFaY1ltMXZ2WFd5?=
 =?utf-8?Q?NHx2qNF72MzgN?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anZGYnBtZGxnYWpEbkJpVVZEV0gzWWZDYzE2Z1Zac0xQUThHTFlVWVF4R3Vp?=
 =?utf-8?B?OW13Y3RSaC9tSlBlSzY4QXBlYWpXUTFRdHdqT1dIRjBBd29ZNi9SaDFOSVph?=
 =?utf-8?B?MWJkcTB4ek1VVHlOcFZXSzlEN0FUSExiNFJZSjQ4NFVXZDZYa2lyN3hGK0VN?=
 =?utf-8?B?UHp1bHNMRlpmd20zcDZsTlFEQVAwQ3d1S0tFbTdIc2FDNzVqQlR3UTNwYnkz?=
 =?utf-8?B?T3F6UU1CbitEWVg3Z28xaWdGUlNaKzBtZzZCb3lwSnM5MzMxN25ZZ1ZmQjFF?=
 =?utf-8?B?WTRkT0FMK2NRUWQ0WGJXbkJ6WmZ1NHZEdTB2ZTFQVFpVbXIvNXVBY1lBdWI5?=
 =?utf-8?B?UW15S1N0SnF4UHA3RUxOV0F5Z0ptRDdpZS9DN2N5RmN0U1VJTU1vc0VLMWxt?=
 =?utf-8?B?dnZRK1l4OFBDbVVYK3JjUFpDa0pGVVhTT1c0SmFoMEE2MGZrd3lSdWVYSFJU?=
 =?utf-8?B?ME5MZXh0Q2lXQnR5dFBGRTZOaERlM2J2MVBFZnJ1YjU1dDRJV05NRncrV1pZ?=
 =?utf-8?B?T2thQWhIbW0rMVRRY1NXQnEzQTV0MTl5QUxBeVdRYm5BUnFhL0RyUUdwRHJQ?=
 =?utf-8?B?YWZzQ05TZ2NHdkNjYks3NzBvK2dEQmxjRHdvdlhScnNwY21kNEJ4Tk5IS2s3?=
 =?utf-8?B?NHRJcVBBb0VNZjlxL3R0bFo2QXozNnl5dUZSRXdrWWw0a0M3T2pVNHBLUHov?=
 =?utf-8?B?Z2FzaFhGcnp1d3RyTER2T2ZhSmpEN1YzKytpNVZCSjRzcGZGZmg4Z1VZNkNJ?=
 =?utf-8?B?TFhGYTlLcHdMaFpsbDd6cFRVR2RGMm80OTF5OE53UVRHYTNhMUs3Rk15ejlK?=
 =?utf-8?B?Ri9JK0JIMjg1Snd6VXFhekJKMk9pNlV0bGh3OHBWbXN4UHkwdU14U1BVd2RU?=
 =?utf-8?B?NXdjdEFESlBMYkx5QVZUbjRIYldTVE9mZGFkZ2tUT1pDeVB1YVNra1hSR2VP?=
 =?utf-8?B?YnVPVmNvTmRGY1FyZmRYa0NrQUJacmJuQ2p6V2NaV0RHVDZnenFlUmVtbkRH?=
 =?utf-8?B?WGxSM2NZcWhLK2wyQmp0d1dLc3ZBMzdSVU9GU3QwTkFyd2lPVkkyZFlHZFNO?=
 =?utf-8?B?Q1VRLzdLYkczM3BaU2dXMHdlMnBMcXVxRXVTNEJWbmJiNHJEYlRUSzc4cUNV?=
 =?utf-8?B?Vk9Oa1BmcjFvR1hTYzNZaFA3V0JTd2pWYk5tU3BEc3VCR1c5bGJnTzNsY1kw?=
 =?utf-8?B?eFVhUlVYSVF3UkV6Tmt6Zm9ld3FoNFp6MmVKRjFxNGlDUHM3cnQ1WjZxWWNN?=
 =?utf-8?B?dk9HaE1vWC9jOXlmWVF1RjJaMUkrUC9qTkQ5ZGZnbmIyNVdzRzJMcmNIL2tz?=
 =?utf-8?B?VDRjNkwrT2xtYThnZlFLV0h5TzRBMHo5VTBLTzZLclJoKzhDanpRZ1pUOUg3?=
 =?utf-8?B?Z0dCMk5CbUk0c3U4NHJ4RzQ5allMc2pESjBnQStqNDlFY210alRaOStDSUpT?=
 =?utf-8?B?cHNxVkdNWkNkeVI0bXJ6NFZiUzd5Z2pwcEpiM0RkcnZ5UklsTFRUaWtXNldr?=
 =?utf-8?B?S3BtdGgzTXFoaXg2ZFdVZHNGRzc4bGxLRmtLQ1ZHdkx5R1dhUWkzVWhxTzUy?=
 =?utf-8?B?VFJSdndNbkVYWm52cE5UUVhnMUNrd1VBKzN4UE9uR0tUQjAwNzFqZmppdjdE?=
 =?utf-8?B?eG5TTHNmVmR4UmY5SU5jOUJaOHB1Q2NpOWxGR0RTVFg0OUxjNjBJU0RwRnYy?=
 =?utf-8?B?Z0oreWNWNmtTSllNTGZ5Slp3OERuak9SSUJIZXhVSG5pRW44blVmV2JHMXo3?=
 =?utf-8?B?UkkwamJONzIvNzE5cHQvTFJmRFc0bnlkNVJOOTQwaWRzZXQ3UVJQYVhNM3Br?=
 =?utf-8?B?NHI4VGNsZnAwVXdSZDdERW91ell2SHBIR0RpUFlVcjBRZzZiUWJwUTlMbzI0?=
 =?utf-8?B?ZUdaWmtwWS9ZSm55bXlzWXd6cjJFR0NkWEJVNkt1cGMzZVpuYUcvanlTS1gz?=
 =?utf-8?B?cko0bGFBTC9pZThkN0pZajcySWZYb3lrVnFlZnZCQzBMRGswMFp2S1ZVMGZH?=
 =?utf-8?B?ZVcxTFlkVTRuRmdLNDZXSnFuNk9jM1c3MWxyZVE2UzQzWFpQZGtMd0s3SFA4?=
 =?utf-8?B?TkVCQjhZSzdHWncyOUF2YklxVE9yVUFpSlBsWXNTV1Vzc2pEUzRoWnltMjNG?=
 =?utf-8?Q?rAY2u5N9lvuZbOTZZ94k7gTPI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e7d3cfd-5e2a-4d61-8be6-08dcf837ed57
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2024 16:37:07.2078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qrYj5NA5uinB3/4fvDB1Rq3BogkWoXiBukYQ+G22MBnvEZLkmG4913KqEpHUIUW2fNvlfhxI4gbCe4jn85uymQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7577

Remove cpu_addr_fixup() because dwc common driver already handle address
translate.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v7
- none
Change from v1 to v2
- set using_dtbus_info true
---
 drivers/pci/controller/dwc/pci-imx6.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..533905b3942a1 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -81,7 +81,6 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_HAS_PHY_RESET		BIT(5)
 #define IMX_PCIE_FLAG_HAS_SERDES		BIT(6)
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
-#define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -1012,22 +1011,6 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
-static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
-{
-	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
-	struct dw_pcie_rp *pp = &pcie->pp;
-	struct resource_entry *entry;
-
-	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_CPU_ADDR_FIXUP))
-		return cpu_addr;
-
-	entry = resource_list_first_type(&pp->bridge->windows, IORESOURCE_MEM);
-	if (!entry)
-		return cpu_addr;
-
-	return cpu_addr - entry->offset;
-}
-
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
@@ -1036,7 +1019,6 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = imx_pcie_start_link,
 	.stop_link = imx_pcie_stop_link,
-	.cpu_addr_fixup = imx_pcie_cpu_addr_fixup,
 };
 
 static void imx_pcie_ep_init(struct dw_pcie_ep *ep)
@@ -1446,6 +1428,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->using_dtbus_info = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
 		if (ret < 0)
@@ -1585,8 +1568,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
-		.flags = IMX_PCIE_FLAG_HAS_PHYDRV |
-			 IMX_PCIE_FLAG_CPU_ADDR_FIXUP,
+		.flags = IMX_PCIE_FLAG_HAS_PHYDRV,
 		.clk_names = imx8q_clks,
 		.clks_cnt = ARRAY_SIZE(imx8q_clks),
 	},

-- 
2.34.1


