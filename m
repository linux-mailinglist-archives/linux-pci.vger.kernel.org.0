Return-Path: <linux-pci+bounces-37293-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 158D8BAE8D7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 22:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBDA63A7E80
	for <lists+linux-pci@lfdr.de>; Tue, 30 Sep 2025 20:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0A283FF1;
	Tue, 30 Sep 2025 20:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="a+X60JCQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011008.outbound.protection.outlook.com [52.101.65.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA969241663;
	Tue, 30 Sep 2025 20:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759264801; cv=fail; b=FgEj8Hy3aJvW2QKaC/nxNCJc4vZxE1G+ORzxw4kbxXkKR0h8H1D6zS44mqyjh0g6bKcSV/7s2+pGY6osBJPeYYYga+MP7tjB67RK8I9eTB1ZV5l3qwNAQNSJpafSx+3sHBgV5HIeFzgu4BEPYCxJEU1YAH+dXBTaBluBcM4nNAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759264801; c=relaxed/simple;
	bh=FshFxFHeT7mTICFnBHeJm14voOIu50ryRpS4aFfueWw=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=d8JNAJE0HKVEg7ze9i3Og6QfFaSMO4/5Cbbzy60GnS867r9QnTCaCPdBKfu2r6bl8lDpXSvKL6TDwK6OkRk4tSv4MXfeFskUlNwMDHwLDJN/Ha/J0yQnSmRVI/8n+zNFyLhRsRAAXHOjXfnoPjyvKQhYj2M7cPWOcLeo1Yfgrus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=a+X60JCQ; arc=fail smtp.client-ip=52.101.65.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZc+qn880/DsjfnndJu9bU5S2QFeQNkR7BD0/LTp1prIVHoCoLxJfBE35WmGt4YIWH0fP5oo521LEQS30YwP27e3rnwHs7+OnbDeQk86z/WbB3M01c1zd0dyGlglL/f/Ybf8ZfZCP/TGer4sS+6+w+AMOZ14/bNfkZrvHEB6wS0hYmgU2BqFZZo/lV55mBg/EFRqGO/mhgBDvRQCZ5dWBvmbCMhkZftpY4BB01SZf4PbaW/ssCh5N6vpAGvofy7ZfWqSxFJ2oVmmDZ1i7cPTw6EMKKoldIumUaRfzNOQEU+SGNxt4kHavxc3sELnTErdWB7sMRJE+XAmrvVFVmVjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dl1c8Jhzf+1rqNt+Rks+kmVvwceTvZ8YxP+TFOnhsHE=;
 b=nCS/baEZ11DS6g0Ittm18rTjaCKDlJWAFEIZovGaKrqgqgdbh0sSvbGW4F48psbxFHF1y3krIZ2WuiT+UhqWNGLgr9uibzDuP5Ay9aYN4DkGOeCAUrZbn9GU81xoYlrvbkHQnfejU+QUCnbI01pd1xMJW3sZ9G+21BKGp07p7E6zXeFFSG29fWAvBeKQ0hwKzoRCVdA84Pk6rGgOx/MjvcPkiZHVx+V21a/8993pqjcyGEh0Ewf5k97GF2XWTdxsXzngnF+RXjv1p1k38vFscavSjWLGoXEPkHBzlkyFA7v/aG7HJSdegBXff8ZH3Sw8eD3ZgzO6hUZCkpKrGv3/5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dl1c8Jhzf+1rqNt+Rks+kmVvwceTvZ8YxP+TFOnhsHE=;
 b=a+X60JCQSOOCS1YpADriPu1am3u7ypzmxNKc4sktjg4qIkclAOaQpRe2LEqLRKVWHxaOKs/l+FJ11ZmJELzvM2H0upn7oKLYNBR35XPzZolbNjZiCWfsuh4jCY0Q9UaTMdtvSYQkCk2yfFloFoeQN/t0Vo1399jbJJcH4sS1AV9zqY17mHKqZcF3Oig1mi7GZln2CxjqT+oWwim6hQQWC4oUId2ewaT3mxQMgwmc4k9Ax2nmXsobbl3EyT7KFDB0s++/Ujitl/fgHp9ANWg1uGUi3r1eUb435mf9QSOEqcqHvnLIMFf30TZu50rwgx9KyErcq192ZhigS6FKIiNqWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com (2603:10a6:102:23f::21)
 by GV1PR04MB10848.eurprd04.prod.outlook.com (2603:10a6:150:20f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.13; Tue, 30 Sep
 2025 20:39:54 +0000
Received: from PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15]) by PAXSPRMB0053.eurprd04.prod.outlook.com
 ([fe80::504f:2a06:4579:5f15%6]) with mapi id 15.20.9160.015; Tue, 30 Sep 2025
 20:39:54 +0000
From: Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 0/3] pci: endpoint: vntb: add MSI doorbell support
Date: Tue, 30 Sep 2025 16:39:36 -0400
Message-Id: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAhA3GgC/23N0QrCIBTG8VcJrzOcOmtd9R4RQ4/HEmqGhizG3
 j03iBXs8jvw+5+BJIweEzluBhIx++RDV4bcbgjcdHdF6m3ZhDNes0PFae5epn0k39oQosH7nRr
 HnNGgrLJ7UtwzovP93Dxfyr759ArxPb/I1XT91uqVWq4oo4Jbp0Aa1yg4df1zB+FBplbmi2/WP
 S8e9L5SrEYhpfz34sfzVS+K18gMg0aA1rj4cRw/oFkQMTABAAA=
X-Change-ID: 20250812-vntb_msi_doorbell-bf0fbac6d6d7
To: Manivannan Sadhasivam <mani@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>, 
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 ntb@lists.linux.dev, imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1759264791; l=1580;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=FshFxFHeT7mTICFnBHeJm14voOIu50ryRpS4aFfueWw=;
 b=gwUG+o8wySMFliSaNAdIwJtsB95/eQftuqwXgrm3Cbal8WgoZ74dbHKqBARE8/p60V6sLOdYH
 wOP6E9f+HdoAroTLJvCh4CckrbcTsLeGKyhl4YeLW15O9HEd4o+hEWE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH8PR07CA0046.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::24) To PAXSPRMB0053.eurprd04.prod.outlook.com
 (2603:10a6:102:23f::21)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXSPRMB0053:EE_|GV1PR04MB10848:EE_
X-MS-Office365-Filtering-Correlation-Id: a0acc33b-0b21-4a8a-25e8-08de006182c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|19092799006|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dnlUSE1rR3haYzdMNHNjUjBqSmZvM1cvbnRvMGk4VFVNWjhSR3FxUktXbktK?=
 =?utf-8?B?SEpsalhndkJzc3g4MGFjRVRPUjF2Njg5aGlGRjZnSHY0RkRpMDByLzlENjEr?=
 =?utf-8?B?K2FuRkVadXg4YkwwY2Frc2tyOGtmTXBuTWpzODRVUHJ6MFhQV3kxQktxaGNh?=
 =?utf-8?B?Mlo0YjNocWtLZ2UvWHgyT1pFN2JtTnBPYU9tUVBMU2lZanVhSW9XUVpEekJG?=
 =?utf-8?B?QUtmQzdxMEdnNHY1Qm95Wi95Wmt1QTNoN25RSnlybmFSMU0xSGU4K3E5d1J3?=
 =?utf-8?B?dExjaXRRVzhqQXZNM0R3UkdoM25zZWpJelg4VjBHdFVZamdWSzcxQVBRMUY0?=
 =?utf-8?B?U1ZUaGRoRFNYc3VmeTZpTFZkbjFCU2NsV2lZYXR3Nzl4eUN6UGFkYnpGNTFm?=
 =?utf-8?B?MWMzaTNhb2lKaHdFVlpNbUFwRUlZemU0RHgxeklmb01ieFVRWktSWnRRVHgy?=
 =?utf-8?B?bWlXNXVDNEs2LzhrNTFuWE83TDVGNHFMMmdjbWdROHVPdk5qeFNZb0xCMDdL?=
 =?utf-8?B?UVJncEJTcjJiaE5TV2lQUzJVMXVNV3FiaURJMEVaSWhYcGVnKzV6dFUyaytr?=
 =?utf-8?B?eFIwME4ybXdUZnR2Y3ZjVnpQZDdCQUNYYW9XMDJ2aTdLamwyeTdmN3ZRMi9w?=
 =?utf-8?B?bzdXOWs0K2plNmh6QWN2dnA1TXZKUko0NkEwUXV0RHRBa0NiMDhBREc0ak1B?=
 =?utf-8?B?L0kzd2hSZ3FVRDdTZUF1cmttTTlyWUw3YWpNMmZGNFNsNGdaSDZZbXl0QkNz?=
 =?utf-8?B?eWg0blhuclpDejdOOFZjaWtZVk9xUXhKNmsyODVXWk5PQWYvalh2TVpySE9P?=
 =?utf-8?B?MStVNS96OWNZbW0yRmE1dFMzaHF5L2tiQmhQZlpCN2VtTlY5MVNubFNieTlm?=
 =?utf-8?B?QzdYSm4yQzhQOEFJL2h6WEJyUGdKYTA4WURUTUNBYVpMZzFGWFJvd2lnSEtR?=
 =?utf-8?B?NFI0Z3ZLaXBaZHVQWS9KSnZFbzFtM2t5cWgxQ2xYODFjanp0RFNkc2J2M3VW?=
 =?utf-8?B?cE83U3JKOWtweDBiTUVmOGVtakxxeW1NOUNoOXpld2xHM05FdWVQZlZVSjlJ?=
 =?utf-8?B?SlNVUDc5ZGhPenNoaTkyenV5S1Bkd2F0eDVia2xVeE1iR2tOSnZUNDM4MXd1?=
 =?utf-8?B?dzh6Y1Q3NUs4SUZBNGduWVQ5V0k3UUZyRFFjbnUzeFhzRHFQR0krY2hINjhy?=
 =?utf-8?B?eTRTZjd0L1V6MTg2NDNtei9xU1hsVW0yNUN2bmxRWkNETGtENDViNDNqeXVY?=
 =?utf-8?B?V0lXWkRPMjNaWXU2TWc1VnJPZHB1T1NBK0UxREljWFVXWWVMSjExMVl5eHdv?=
 =?utf-8?B?VWNySUI3eHo5WXhIWWFlRUJ0aWJ2RWRKNDFxeEZyWUhNbzBzUUFVMGlaRThL?=
 =?utf-8?B?eXhRZUpyd1A3MlpUODRsOW5LaVZ0NlNLZDBnTFdPN0tacHVkZ1JaQ1RjZHV5?=
 =?utf-8?B?Q2RVQk1sdVgza0lZTTAxRVVyc1dJMkJHbmFsUmczK2NUZTVrN3QxR0dEMllr?=
 =?utf-8?B?cVViOFUxdWIwRnFiQVEyU3NRVEdiN0cxSEVRVGZZaXR3SVIxSnlCQmxXM1Iz?=
 =?utf-8?B?Z2k2TWtFWEJEcnlBaWhUR0UxRE1DMitSMFFuUFY4RTIranlVZVhlcktzVDht?=
 =?utf-8?B?NWJFd3VoekJvN1dFd2M2WnhYSmpOQlc2Z1M2ZnN1SnJpK2xRQlRjUUZVODhj?=
 =?utf-8?B?SEszK2ZXSkJaVENYUFNGeDF4MEFNY1E3b1A0a2l0ZnoyZy91eGZuZXVwR2xo?=
 =?utf-8?B?MWxROUFXQXFLV3Q3cW9Na25kTUx4WkZwWW54eDVEYXpLR054ck5STHg5eHNa?=
 =?utf-8?B?eW84d2ZhOC82aThwYmRQak55a2wrTlNVcnUwU05WdHhnQURzWHFrdkx6Z3kr?=
 =?utf-8?B?alFvN0F5UzBtdnkzdWRTQjZJM3VSSzdjclZ1RGRnNDZTNGtqVFA5aXlEU1B4?=
 =?utf-8?B?bXRMT2ZqVlJjMklkcExLb1dHRWc3a2xxSkR6RU90d0ZTZ1J5aDZhUk1Wam5z?=
 =?utf-8?B?dENnZVlYYyt1aUUxV0RnbFRvWHZ3WHVQZUJSejZXdzMwK2FjQkFteWZYOTBr?=
 =?utf-8?Q?pEhYtx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXSPRMB0053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(19092799006)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RmxLeCtqTFE5dEVCY0cvT29BK1lyMk5oTU9JQXZZdGlBdEFrRkJzR0JyQVUy?=
 =?utf-8?B?MktuWmMzN2hNaTFpazVGVWJvc3dOVDg4cnRNUmxzUkJQL2hESTNIWHRITEdT?=
 =?utf-8?B?Z0ZhS2VrSXdXazBGcE95cEFvK2ppOEpvVWdLQ2UweFFSaFNoMGJIcTlNT2ky?=
 =?utf-8?B?Ukpib2cyQmNrRzNTOWtOMXRKYUVjMUdrSXJWRGpvNXhDL2dSOU1IRVF0V1Z5?=
 =?utf-8?B?RTlQaFA4bHViNTU4RDJGZUgvcXY2S3VRZXZnOTdIb3QrL1drOVFuc3NaZE03?=
 =?utf-8?B?SlhtT3BSY0N1MjlFTkdjYlBOandoUWRKNTRBaXdUNzltNWtCNXJ4NlA5MzFE?=
 =?utf-8?B?NjdoZnlnM1RYbHNxZFpPOVd3S1lacFRxY3N3bkp6SzZTcXZoUFRQaEd3eUVE?=
 =?utf-8?B?ajZqa2xmZURMWE5ycUZCejhEd2dzSHRCMGJOejRzQU5YVUxVNHBMNE1vYTF3?=
 =?utf-8?B?WGpNNFpnRElteFhzdEJHdU1oMDRsYzBoN25jZzNXcVpYaHpaU2U3RjcrdDJV?=
 =?utf-8?B?WlVBOXlRbnp5QU1RM0RpNk8xejBkWjdIRzBUaStzT3NUTVJkMzZtS1lyS1pa?=
 =?utf-8?B?bDlLWG1sUXVqdTcxQmN1dWV4VGwySWhLZlpsaDR4eDMrRnhSZVJGMm1SYkcx?=
 =?utf-8?B?WklzQmlQY3hoNDdsOVJaYytoVlZoS215TDlyTC81clM5U1FSODYwa1ZtYXZt?=
 =?utf-8?B?RGIyKytmcE8raXM0dEtpeEo1amhORmo5T0wrZ3Axb0l1b2NFSnZVWitjeFhq?=
 =?utf-8?B?TmpReTVvMmgvQitCYitlN1lQZjd1bFlYNGppQ042blVtclNUT3JBcGhmQVMr?=
 =?utf-8?B?dW0yOXdBYkphY05MMnMvN08rckhVN1pJVW0xY2RkTm9qSlNwZlVoK2hVdGdx?=
 =?utf-8?B?RStVRGluRklkdzYvWmhPL2d3WjcxMGFMSjFQbUpTQWx4N21UOFBEdDNaK3B6?=
 =?utf-8?B?Q2Fqd1M0SUJDZ0g4OXJTUVpLa1ltMHFQSStSaGdDb0c3bzZEV04xZDRrK3RG?=
 =?utf-8?B?QjdLak1wZzViaWRPc1hZNFFjQmJCYVN1K1k1WnpNWnYrOFVOVmh3US9HRSsz?=
 =?utf-8?B?LzhKNnVBTE9CaUJwVEQvSzBTVDZkbEpabDJMUHc1Yk93Rjg2RVUvb2Rxbk9l?=
 =?utf-8?B?Uk5RRTRHWEFNMmlFem9pbVQ3SitXemV4cUxmM05FeGp0RnhuRU5ueEw3aXBw?=
 =?utf-8?B?Uit2ajNibnNJc2pibXVxVXdhbjFhQ3NFajliZ1pVODFOWHRaMWNMRi8vK2ts?=
 =?utf-8?B?RWh0bzNlTjJsSUhiN1UzOElaR0tudnNFUjRXOHlkRDlKVldSWGdNRU0zUThS?=
 =?utf-8?B?anYzdTJtMlRhcXhybytMV0ZjUjA2Y1BPNlE0UkpVMzVhanpMTzJLV3YrR014?=
 =?utf-8?B?YnkvdE94STF3VmhsNkp2NXgycWFvWFM2WUxXRFJacWlEMmJ3cjBSZEJEMGkv?=
 =?utf-8?B?Qno5dTFhUExPTjIxd01EeUNNM1N2aHM2SG51WWhhZmQzYUk1ZVcyRlBWQlda?=
 =?utf-8?B?cUNURCtKRzlMeDJ5ZHphb1FLK01lNWxLTnl2UkRrN0szNjhwd04yN2NpL0tp?=
 =?utf-8?B?SWl0a2ZYbjRROXgxTFlISWZmYitqR2Njck1nNThEWUw1eDlJMnRrcDhzU0Rz?=
 =?utf-8?B?bXo1d3Z2cndFaFI5TWlWUWxNK2xPWk1TYThHOUEwU1ZzWGk5Zlk0UVFVVWpD?=
 =?utf-8?B?LzBIMDM2dTRiWW1GUWN2eXluaS9Ha1RwYWlIa3hkb2JOdlRCdFNKR01QOFUx?=
 =?utf-8?B?ck0zaUJxZVk0VkhwdCtycy9naUJLK1hTUEkxalNOUE5oUjV0elFXMlVRdXBw?=
 =?utf-8?B?dDNyZzRuZ3hOQWlvTHV0TzN4dE9wOW1KWG9RMC9QeVNxSEoxejRBelF3dHlo?=
 =?utf-8?B?WEM0RjRabWNzb000b0tpc0xwS2c2TTh1UW40dzVxNW1kSjI5dEMzVkZNbEc5?=
 =?utf-8?B?NUZHR3RTMHZ5UGtSWWk1L2pmaHJkK254Qk1LbTE3UkdSTWtvSUhIcUpRUFZC?=
 =?utf-8?B?NHU0MVh1RU4yb1ZsUDRPNjJ3K2gzbFJ4TlA0WEhub1BVYSsrQUxrdHR0OW1G?=
 =?utf-8?B?UCs0ekM3YWFPSVZ3NjlMOS90WDlLdG9nVlVwNDdNcTYzREo4Z0dGdG9NNU5k?=
 =?utf-8?Q?A75zIN6z9vwf05OAQ7+HuUiHa?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0acc33b-0b21-4a8a-25e8-08de006182c6
X-MS-Exchange-CrossTenant-AuthSource: PAXSPRMB0053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2025 20:39:54.0409
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmYC/ykWcIRbXiXDJBLJa7qFnfsr/AhSLe3BDUSyMHJGwU10OTMuH92NgSd2X2mNfqaSAYBm5niX0CjXV9f5Iw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10848

Since commit 1c3b002c6bf68 PCI: endpoint: Add RC-to-EP doorbell support
using platform MSI controller, PCI EP can get notification from Host.

VNTB use this feature to reduce ping latency.

The first patch impove epf core API to allow set any MMIO address to specfic
bar.

The second patch add MSI doorbell support.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Changes in v4:
- use 'bar_size' instead of aligned_bar_size
- Link to v3: https://lore.kernel.org/r/20250925-vntb_msi_doorbell-v3-0-ae0b0c93caae@nxp.com

Changes in v3:
- update function name to pci_epf_assign_bar_space()
- detail check each patch's change log
- Link to v2: https://lore.kernel.org/r/20250915-vntb_msi_doorbell-v2-0-ca71605e3444@nxp.com

Changes in v2:
- add help funciton to get bar's inbounce size
- fix miss x8 when caculate bits
- Link to v1: https://lore.kernel.org/r/20250815-vntb_msi_doorbell-v1-0-32df6c4bf96c@nxp.com

---
Frank Li (3):
      PCI: endpoint: Add helper function pci_epf_get_bar_required_size()
      PCI: endpoint: Add API pci_epf_assign_bar_space()
      PCI: endpoint: pci-epf-vntb: Add MSI doorbell support

 drivers/pci/endpoint/functions/pci-epf-vntb.c | 152 +++++++++++++++++++++---
 drivers/pci/endpoint/pci-epf-core.c           | 161 +++++++++++++++++++++-----
 include/linux/pci-epf.h                       |   6 +
 3 files changed, 272 insertions(+), 47 deletions(-)
---
base-commit: c2a282d1fccc53a989da61a5da4f03c9d67ee99a
change-id: 20250812-vntb_msi_doorbell-bf0fbac6d6d7

Best regards,
--
Frank Li <Frank.Li@nxp.com>


