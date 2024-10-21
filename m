Return-Path: <linux-pci+bounces-14956-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F20649A909F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 22:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDB41B21318
	for <lists+linux-pci@lfdr.de>; Mon, 21 Oct 2024 20:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8737A1FBCA1;
	Mon, 21 Oct 2024 20:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZwmyqVqe"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C4D1FBC98;
	Mon, 21 Oct 2024 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729541284; cv=fail; b=uhFdgPapBXLEvh6npFIFb0pkykThWGoo/n2rEZ9BjXUtoY7GSYXyvmNcpAL+FEY5c5JZw6p5CtuNWfbk8hDNfcDcJLAyHE/v8mNjISyt1hKxcOOd7If16ohI72Q6r3AaE3/wDtzmemEs3eI8dmfgpHWkg3bvYH2/xGlEyp5iImo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729541284; c=relaxed/simple;
	bh=GExlPE6INqJBVe829R4B7L+Abmx+hOxi51phEI8z7Gw=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l2efUZwUcqjJLzHrOJ3DWwiDF0GvmLWHa9cm4AZU3MYXtoZUssNddfa3tQpUjqDfTXTywdKsixzH28XU6utsTyL+S6WL+pX77DTUJNrJ6Hd+ywTj68eosCAsLfEOgl6vRz5ETFtQsmm4iYbjsDKpPhus88cjlSygZEE2qAGfwpk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZwmyqVqe; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWgbOVLkoy/f/kgr0RKQdmQsJ2p+vJqraVRPP9bySc67bhLqQv154lXZhrQUSFS0YLMzdAC1iVnaqRPJcBHeQ/40dWZGWXT/+Y2pCWSI3v3hhGycL/LraZU1BpYWbrhIfhU61l1mQ1yR+L/DkKDsvIjTB007avrt/Bs+F6mg4cB9WtyqVAr3dfNCrpP0RlNNOrkatXkpoA+qKYQjACpwfe806jOOwFMbCxmCkN7/+oLzWWvx2tiCRZhQN1lMCwxsG6lMCDuiDVsKRfonuBwj7qaHuQQ0n6N6kI/dLF4XRN1VSR7xGOxPAz8yF2SwzrQNtHz/f2dkQREO6nIHFEBKIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=84RI+077QT0IyR3qvihpandZLg8yhI+5Vnaa39qgDFs=;
 b=sdbjTRUkPYmfpJIhZQX4RB7W+cSVYjDvcbTUOD4AAJpsNjEmvGUnKeP3fr6gmXeOfI95asOOGrq83fuvshLjaPa0ezJuQeCLzfPIJ83a3qlnR8idvQn84kLVo00J4LZq/ZVNzbYHqtDwmZIb3Yw9mFTLkTfcvZGZCj2OQ46T966gaDjJ9n0eeiYJ7esZsPltQQMGF1lPBp9+u6GxK24UrisxCObLm7adChQx3bkgywOdXtlJiOaioa1LfQ7MUkGVhr2hkCguMgTtgkyBFqutZR71Y2aCba0dF1kKBivhsi0c0OJMZhqKMWXKzqd4YUVYoKox+r594hzgTx0MeioY2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=84RI+077QT0IyR3qvihpandZLg8yhI+5Vnaa39qgDFs=;
 b=ZwmyqVqefz3bZ8qe9DeHzcm0bmaakQDx9s8G32hIkyB7WR/YxLVedea7+e1eiKuk1PeODkpztBGpgN9Bat55BCgdtAO/Y3/+BwX8fkKUdVkDInxoKX9TZBaRcRZJ4Mg/PdhqqwoW7e/l9o3XIYDCxIlEzcSuoq3aOkkjo69LPWjE5ec07z172i92/tWmEg73FZMGxGtsMBSq5zfYlaphpRyWBeo5r0/5MmemdCmhyxh083vJXkUgT6PbaLcRXuGCWXLjbRbMvf4lSnIgWyImg6Gp0j7l5vxsKqKi0KiFIQk1vrGAkCM+7AT0ln/gxnJHt12GyYLP/duNjRfXJurGaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM0PR04MB6882.eurprd04.prod.outlook.com (2603:10a6:208:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 20:08:00 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 20:08:00 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 21 Oct 2024 16:07:38 -0400
Subject: [PATCH v3 3/4] PCI: imx6: Pass correct sub mode when calling
 phy_set_mode_ext()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-pcie_ep_range-v3-3-b13526eb0089@nxp.com>
References: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
In-Reply-To: <20241021-pcie_ep_range-v3-0-b13526eb0089@nxp.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Abraham I <kishon@kernel.org>, 
 Saravana Kannan <saravanak@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@axis.com, 
 linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729541264; l=1188;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=GExlPE6INqJBVe829R4B7L+Abmx+hOxi51phEI8z7Gw=;
 b=crDAQDQKZ6D3k6ZY8OmJpO6GsDeZURRgb44H6Y+TiYfG5JjD1HlvPlMq4EtNrY0vyWr2XuS61
 UIBDmoTEAEnAiJtBuLMQYUZ67vF/1JGUdEf17KLb+AW11lQiUi12n+u
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR13CA0071.namprd13.prod.outlook.com
 (2603:10b6:806:23::16) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM0PR04MB6882:EE_
X-MS-Office365-Filtering-Correlation-Id: 180c6b20-4386-4c34-0650-08dcf20c0ff5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|52116014|376014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bGF4Qmd6UG1IVVpGbUV5djJXYTB6VDhUMnNTQnlZeGxhWkRqYy82a0NrTXZD?=
 =?utf-8?B?ZEpCYlZwZnMwdG9WVW1Ed1dQQ3JuS3pOLzU5ZkNNaVNlM0xkcEpYWXlNSGxJ?=
 =?utf-8?B?T2thWitaejFZdDNib3NXRWtBVnB0NExNTEJ6ZGNhWGUrd3pFeTJxS3U2MEFM?=
 =?utf-8?B?UXE1U28zYnJPNGtmOXc0dW1hT2w0RFcwbzRXTDlXTm4rd1JPQ015azNtWmty?=
 =?utf-8?B?U1RHOEtuNUNoUWtzZ0JmYUlHVjZYY3pjbVQ0YjNJSmVIblp6SlpQVTBNSXpm?=
 =?utf-8?B?TGhUellZbFRSa0JRenlwUFdIR2l0K0lXMGkzRnl3Vlc3OTJ0N1VSVXNNNTMx?=
 =?utf-8?B?cGU1a2JYWm1rT1k1SlFZem9DQ01yRHN3Q3VpV0dHVGFMMkVOaWRaOUdUNWJO?=
 =?utf-8?B?bDh5aG5ld3BnR3BCNTY0ZnM2YmptbHNsUEpTa3cwZDZXMDBpSU9jVUo5SXAv?=
 =?utf-8?B?ZzFMU0tQb3d0cTFUQWVLZGVqdjAwdXpuNTVBNDlDbWxPLzlKNEVpYUQvZnE4?=
 =?utf-8?B?NDFDZVV0eUJvdjFzUUM1UTFieisvaDRIS2V3eFc4MjZhS0IzVWdRTHlVRldn?=
 =?utf-8?B?anJCUTR2Mm5za01JL3NUUGVIZSszNENTZFJLYkg1WjhxeE04SjJXQXJuY01L?=
 =?utf-8?B?Sk5XVDlpVVJSYTdBWnJzdDdlMlVlTTFZR05hSFZpa2xYVVNlWkJtRGFnaStW?=
 =?utf-8?B?emNHSzZsTjUrVHIwK0duVE5ud3BUbnZPaHFCY3dZRDdSdXI3VUlLUVBub2xp?=
 =?utf-8?B?UlVNaDN1R0N2ZVk3RlVxM05EUDArZnpHMDVwOEZTWkZXbC9ZcnJVOEJaN214?=
 =?utf-8?B?YTlVS1RBMVBMamQ0MHVkRkQ5ZDR3SzRRVTdqb1BzUVdNc2hXMTFOYnl2NkFt?=
 =?utf-8?B?UkRXb2pxZGcxNS81K1NTQnFBWWU0RGg0L2gvRFcxeFBoQUg4L3lCbS9qaDVl?=
 =?utf-8?B?Uzd4UzJiWjhJUndFNlJ6NTZxd2paRlNyVG1vek9yRjd4blJNL05iNDlhQmNL?=
 =?utf-8?B?dlA0NUNVZW1qb1h5Y1NmMmtJRnZ3YnJSVy9NU085VWt4Z29hRnFmNS8vdHJP?=
 =?utf-8?B?aUdJckhqa0VmUTZpRi9zaHhFUW51bkdGZ3VsSnFqSWNsWTBKUjJJcFY3VlNp?=
 =?utf-8?B?WnBDRUVuVzh1RFRPalZsWS9WWFZLQ3FvU002dTBFczE0Q3gxK2w3alQzSFhj?=
 =?utf-8?B?UE43OVJNQy8yeE9ITVF5Q3JDVU0zSUNsdURWK1RXRTRucHpLaGVmM1ZxdmYx?=
 =?utf-8?B?aHBTSVNKeWpER1dKNlhBVlhmNmRpdldrcllTTE45emxsTEJUa2lvalZWenNV?=
 =?utf-8?B?THFVZkZkMVdRSUIxWnRva0N6VUNRODRKeDVFdllqUUxZVHlsemNHMHpQUzJy?=
 =?utf-8?B?T0xSSU9ZVlc5c3phRzZKVHJMOVNqVVhuNXR1OG92bkxza1IzRHhqWVlidk9Q?=
 =?utf-8?B?NEVXNmprMFNQMy9HQjVCbDIxK25nV0pMb1BvNFArRGxDMEtXaHN4Sy95bUx5?=
 =?utf-8?B?UGZFVWVSWTZCTmV0dGtTTVlXOHNIMC9sSC96cGlJQ3hqTkFXQ1dqa2VXUFRG?=
 =?utf-8?B?a05sYkJYNHk0RG5XdHNYMTdWMlZEZWhPY21IUGlXZFYxb2dOcVdZY0VxbE1C?=
 =?utf-8?B?MzZKckR1NEZtbmxlVFZTSFZOVTFtQUsxbHMySzRsYS9KN1ZSQUhSMDB2YUlY?=
 =?utf-8?B?TFVjalFiOHZmMURsS0NKVEovR2x3TjBKYzFhREVIUUE4eHFNci9ycUtTWEJB?=
 =?utf-8?B?alZzY2U4dVNDanBtWTlreVJhRWoxRUJyNm4wZ0F1RFVmV2RzM04zQ0VENUJQ?=
 =?utf-8?B?S3Z1bzVZQXhiOFAveGxzWWkrMTZRTTY1NzVybVRxeEEwa3RqMU5oQ0JUMmNF?=
 =?utf-8?Q?QgG1qVsnkG9Xn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(52116014)(376014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZjUwMjVhb21aUmp2Rk5zTzcwUmt6QzlWZzBtR3puY3RoalMvR09td25jZVBt?=
 =?utf-8?B?aDFOWmJuaWlsMGZnNlJlQWptQzhpYWJyNEhiYjNia0lPRHUvOUpVRlUzTHN4?=
 =?utf-8?B?TnU2N3RHWjBrNmJiRlZEWjFheVdRSDNDSG5iNlJtREJuODErcVBpS093TGFX?=
 =?utf-8?B?a3lhZUR0Wm5ycWgxdFYrVWcrTHp2SFVNRGRSbUcxZ0RHU3QrZXM3a2NFZ2d3?=
 =?utf-8?B?L0JZQ1paaWd4bTdwb1YzcThsS0ZQc3JVUS9xcERGTGVXa3J2ZmRITFdRNEJv?=
 =?utf-8?B?VVhMNHROUGNwRytCR1dnY2dRNWtwS0o1UE43RldqTlFPcWdLWnkvb1FjbDZJ?=
 =?utf-8?B?dGlYV2xuSHpWai9WNEVLV3JQZm9ZWWd2ZytQM2kxbGtONW8xcFU5TDhJNTNU?=
 =?utf-8?B?Zm9acHNaWVdJNjV5YmEwVnR0SUJMbVFLcWk1TkplRC95R3VONzEyd25zK21E?=
 =?utf-8?B?MzlCcGVqVXJtbzBLd0p2MThNcG5QdnpMSEVsSG1ac25sUklmZjhWTzVuVzY4?=
 =?utf-8?B?RmFUaVNUbCszekphWVBJVEQzNWF6VTJ5TTQ4RE01d3ZramQxYml1MG96cUN1?=
 =?utf-8?B?V3hTMzRGMC9IV2hCQUZkS1RnWFdjRnNOYUdSZUoxWmw1aFVVTTAzL24vbE5q?=
 =?utf-8?B?NVZFR1JJQUFodC9sYVIyZ0Jya21DZVVWcTE3Wk1ndDBhR3ZZdlRGdWdjRG1I?=
 =?utf-8?B?YUtlYXBsOGI0NlF1QUpGWU1JZEc4aUxQN2ExWWNET1NJUE1TY0NLVC9SUFdT?=
 =?utf-8?B?UncyQjFaVjhCSGdGTFYweEFldlNZbS93OWlEM29Cc2ZocCt6ODZaWmt2RFRZ?=
 =?utf-8?B?NUYySWpZNnhoRERXNUJTNEwycnJqQ3pDeGZWRm5GTldIZjEwQ1dIdmc5a21R?=
 =?utf-8?B?Nkd6clE4N05iZTlzZDRXTG1RNlVobENOTzVPaG40Q2dLSWl4Wlk4SHRzeHg2?=
 =?utf-8?B?ektWR3ZHdUpObjF4SjZhY2VKNERBUTd0MnA5Nk91TktFZlQ3UFU0MGNjZWxG?=
 =?utf-8?B?OVN4UUZBS0V0UWhGcEE4UkNPUGhHVW5JVUpqTlUxbHRvMVY0REN6WkN5bDBx?=
 =?utf-8?B?Mi80NDJ6a1dpQS9BS1FNK3N4eHNHQ3ZERWJVZFpLTmQrYVozZGE1QmhQUStO?=
 =?utf-8?B?WS9IK2ZFbWZiMVV3WmZHb2F3Wnc1Nk1KRzhBN1VPV3dpZVJCSmRjb2hkUTFI?=
 =?utf-8?B?UnZPaG1MalpyRmgvbUhEdG9DTTdnbHJSeW5vK01IRCtZaWc1OEdMTENYdWFH?=
 =?utf-8?B?V05PNjJZZUFadUJoaWRMbjNxcm15VHh3MWdDb0ZJN3lkNmVsQWZVMTBQT0cr?=
 =?utf-8?B?UjMraWxTNjNTRHVUekRCUGRGK05UT09jOVBiNVhqcmNYcDRFYmxqcGJlSlB1?=
 =?utf-8?B?S0Iwck9TS01CY2FEU0RsS1hJaHRHYmZWZVh2cmN4djBxMVk5d2ZBMzZlY2tq?=
 =?utf-8?B?YytDSmV5ZXdSQ1E2VS9KRFN4Y1NGa2FlZmhlUWZ5SmxvYmV2UVJ2MzZMUVlu?=
 =?utf-8?B?Ni93YjIrUU5CWGdjMlVybkFITkFUbEYreTZrcFVrQ1B3SkwzVHd2OEhVaFJu?=
 =?utf-8?B?MjllRU5OMWI3RkhnOTd6WmtVMEluclk5b0JJMHduU2M5aW9qd3MyelhPVUhl?=
 =?utf-8?B?dnZ1L21BTzRxY3I2ZFhpTGIwWjdhZnRwT210ejZtK3g5cXlPR09NRGY3WnA3?=
 =?utf-8?B?eUNrTnQ0NGU5Rk5Pak9EaWxhbi9VNzJEVEJOSzFEQngwZEthMHA1Zk55Q2pY?=
 =?utf-8?B?RzNUK2pjd2xNUkU1TEJIUlVtbTg3blVpRW0zWDVvM0Fsb0VuaVNmcjBjRm1l?=
 =?utf-8?B?Z3dFTmI5VHFsOERXcW4yV0dRUzNOZGZtdU53S2QwOGMrRXkvYklpTFJKVDI2?=
 =?utf-8?B?ZENpcmZWdkt2M216RndGcHA5OVR2U3JYSWlna29RY2RNQU0wMURUenRrZEdt?=
 =?utf-8?B?Q2JpZXA3U2ZvSytSQlZyUHNURmpsczNmUjJNcWpMYklrUkQ2aU14THNlUmNY?=
 =?utf-8?B?cFRJUEZwTXF3b0lieXljUkJ3a0cyeVNFYUljNmpwTTBzOUtGY2tkVHRudkVu?=
 =?utf-8?B?VHhUZ0g3WWExbFlLRTZPMHFLNG13SDk5R0xScjRQZ3poYml0a21iRHZ0WXRD?=
 =?utf-8?Q?Xa8d4YEAdFPb3VqbTNQzCW4HW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 180c6b20-4386-4c34-0650-08dcf20c0ff5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 20:08:00.1852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rO2KiRTjn5iEQitW6B8fNzTMpVvUs9Mx2lC2WKhhhWLEjYlGJXBmJMEkdjhw7k6ZKlhzrie8ImqCPEGdkCm+Qw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6882

Fix hardcoding to Root Complex (RC) mode by adding a drvdata mode check.
Pass PHY_MODE_PCIE_EP if the PCI controller operates in Endpoint (EP) mode.

Fixes: 8026f2d8e8a9 ("PCI: imx6: Call common PHY API to set mode, speed, and submode")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 808d1f1054173..bdc2b372e6c13 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -961,7 +961,9 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_clk_disable;
 		}
 
-		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
+		ret = phy_set_mode_ext(imx_pcie->phy, PHY_MODE_PCIE,
+				       imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE ?
+						PHY_MODE_PCIE_EP : PHY_MODE_PCIE_RC);
 		if (ret) {
 			dev_err(dev, "unable to set PCIe PHY mode\n");
 			goto err_phy_exit;

-- 
2.34.1


