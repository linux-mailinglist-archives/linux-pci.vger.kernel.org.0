Return-Path: <linux-pci+bounces-34534-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 26ED0B31221
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 10:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBA891CE35AB
	for <lists+linux-pci@lfdr.de>; Fri, 22 Aug 2025 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6255D2EDD73;
	Fri, 22 Aug 2025 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IaOxk+Z/"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011036.outbound.protection.outlook.com [40.107.130.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D732ED870;
	Fri, 22 Aug 2025 08:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852282; cv=fail; b=e1hWIAQ/vPO4dZFiBrnEMNJoWNhWpNNtaD8MhIE0zZA5D5Yb1fLPsPudq14O4lbCmdFqYb9I8h8b6z+dLXyYE6i/5r13sFDALklDLLs7G9c5YVYiM5JU+xZswXW9VHuzeeXdq5DldNdLjuaDULMJ6fMU2FtcLsdqp5VuxZrGrJM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852282; c=relaxed/simple;
	bh=hACC5A8Z5lvpKcHZ1KgwMB6wr1qqpQ75eTZsKlx88U8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N6Rer4jc7wzhxra+cv0Fr2jU9OVFZHiMlyxYO7r7/dcG2Ny1xLc5iQBSA9klWy3GM6kRpp6dVJ2KM9ZVSE0tWQ4LKHQTjUx32iFsEVjEdE8tjQilkxn1MSvdVsBRLLglEt1MsFD+T4SpphD7wDt2kvmCUSPUzGvNpbOr8mHftxQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IaOxk+Z/; arc=fail smtp.client-ip=40.107.130.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fdrbo3vi51AzqH5JMGtKH9oLhIwHCP5cqo4VGsBIFYM4IJhLcDGHTnZ+DECc4ACohw8OssEh9VFkUlpErIxeJXL/1LhE8X1TeaLPejUgrkWp3Nl7CS7DY/cWq8l7hdBcwG4vftTX4ct3pHLhWgKmO/tc7OCcCQsHr2qJbMI49yj0wbIBNeIKakeame+iY4am4mQMFEf+pVmPR+egvz37HOsd1lDYtic6TLBG0ArOrLOufo4FuFVOSwKxxKvJlLcz3DDAG0TpOdXWfqK+BJ3tdJaGe3rG2dIfoJ9onlBQsDBk3jTmXRZTpK4ZqNoq36TjJLo/i/lpUJryYzqzFakA0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wiD1Xw5ggHe75SY0VUkEQ5k0ohXKS9HkkB/Bh0Nqmsw=;
 b=ZXZIVcGceOWiLn5v/iUP4GeX4thgTJxmcq9SpcmNRbSLNafJ2hwUf1FJ+0JViSyMcUBuRzFiMjmjGwOfaNw1BDqFVtMlVuQg8GGm7K3nJVuldYWHzp/mlrg7Qk5YOBW54Dje2/vB0P7VyZYZUWn2xavlZY+zwboKCsEHAlxRSrRk6ZTfysevxLLXqm8+sIX8lKJWyB5ODAM/c5e+OS3J7G10WqRpz6HtPInX+BChaBMY3e0v2J/mbY8SWpcbvzJWDMsQCyEEkrM9fSp257D6PFlI56rCMMKunhtvc5RRPwtEopdYUYBs1n5opx4oX2i3OlA8tKMOZNJNGMnCsPgXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wiD1Xw5ggHe75SY0VUkEQ5k0ohXKS9HkkB/Bh0Nqmsw=;
 b=IaOxk+Z/bf142N//tYOxC15d8f9HCJTZSlBbRVFFHUSSJgT1oZOKMTym4TKiPksh57HDYha5M/V2ThzwlTBfd9xM4qtC1nDfI/1Nh3M/YJUylDIgct+hIDEH+lodwH19LZMCEPPGeFHq6ZkK0aMpSVppapSpmE/LMU09dX2JnchLmIzzipXBWjEqra1fhlEl9PnN/LziGyKzR4TiunvuqzrbuaVeZBkHymymu6Ic8rua9KifwABvpqKqVrj9uezUL4rMlJB1LDv50T9chvCyc5Zkm5NiJxGzlCU1ZnsK2TGml0DhOm5njtl8V8P6kGlmS8VmAmMP39BBu43uhQ7yig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7630.eurprd04.prod.outlook.com (2603:10a6:102:ec::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 08:44:38 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.014; Fri, 22 Aug 2025
 08:44:38 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	jingoohan1@gmail.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com
Cc: linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Fri, 22 Aug 2025 16:43:37 +0800
Message-Id: <20250822084341.3160738-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
References: <20250822084341.3160738-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0047.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7630:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d0a949d-945d-494a-64d2-08dde1582127
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|19092799006|52116014|376014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1t3NBikaq1wBmC9ayOzSv2wgpH8vJ/ywbXag8gVtRhs9PRXCV4LJaPsw1XpB?=
 =?us-ascii?Q?qzSYN6GOWFUsEjbeif+smhvDE22gTqt4QJ+TvTqXQaBV8xVfNlf7DWujVEVG?=
 =?us-ascii?Q?6UReS/kTgaKimQ8kqRmTcfM7o7whpEyA0Aykn5RQ3l2KHkp962XVRfEfSf34?=
 =?us-ascii?Q?mjIlybfu5tmf43a3IF0DnDeN9KibvPN35gtHmoL44eGqKsKYCq7pSSOY3MZJ?=
 =?us-ascii?Q?fFQz9uuNRl3X4fA6VyoK76EkxuVusW+qOM+vGKhW1xHixSmKQr7HQU2ZHSks?=
 =?us-ascii?Q?zO3AVW416HVHebnXAYPih8RBZwuOycRR12igtcZtvE8ev+1VJG2rv/mCFOYi?=
 =?us-ascii?Q?DJ/IWcbKykp/zpdZ9tuvQ/SM1UxA8iZl0qczvuzgFzUt1iUzqDG+gx3Yknw8?=
 =?us-ascii?Q?0yi0jejLyq1IJt+MeYlynB9YzOFErsAcFE9BkREy8TXRz7MIxVIQpM/dI+Dz?=
 =?us-ascii?Q?s7USs0in/Ou0mJMumFPY21ZHToh2I1NTXGfmM63OvTAOSkGXRvGHd1uqSC/R?=
 =?us-ascii?Q?XWjr5TjzmS/S0vpNAiRSVJM9iJN3zMPGe8hlkC6RFjbl+GH+qWosdEepJQFF?=
 =?us-ascii?Q?h9ibujgNvMXco83u6pRDrBaVvyjJGJpbIkFENkC1UnWpsp2HfErETDrqBBGD?=
 =?us-ascii?Q?SAihii/WxDF7H3eER77TddhcfFwzCjB9EgvH+XoWsgJ23c0vZQk5VRTUjsjc?=
 =?us-ascii?Q?AfyGqbd8/IFGmqA8TfNgWObFoqnQfibewh5tnGKRAdLfiJkDj70/V+I6fy0s?=
 =?us-ascii?Q?RmHjjTJApBJbVcbXr9zPT9N2TuLm0iBakRP6iMUICNUCE26OwhzaeFJpUnlM?=
 =?us-ascii?Q?6OOKRF3I84lw/cHWXecucccbrNepjdArK/qzmvRKyrP+seY11hM8SGxPKxDi?=
 =?us-ascii?Q?IbmTG1ObyZcu+wv0Fj+5z/a9VNYLoIr9Td9GwGwXnQIW3f/hKaTmKSMPqDMf?=
 =?us-ascii?Q?58Vm6Yt43BU1d9QjA4Gf48Ztg5RkBu0HZYzByPeKHIaYcHop6+GAlDtQaHhn?=
 =?us-ascii?Q?eYz3flMjf+gdICxSSmEwPxgj8cym6HTWudVZ4IvninQX2L96IhEvAm8+e54j?=
 =?us-ascii?Q?/pcRf5sZTaEhE5dvF+RV1zre9Zy4Fcp34umjHcMxgfuqUUfFOFe00ZKVhUMy?=
 =?us-ascii?Q?mEGTB8w/MEWC32FIFUcD2c9osxpDkjFioSagtxiQvpldILp9WRj7RV/mg21m?=
 =?us-ascii?Q?OZvTDTIZtTrjoaKMjp/m2rFWjUNZzpIyODl+KVt+HuWfrbiC534cLe4gC6JB?=
 =?us-ascii?Q?tGhuYgWwojj+WRwWeNJ/SJjqZZkvtCY73leQoOXM9eFfWagKkFFM1m//eWfL?=
 =?us-ascii?Q?yNYWnp6YloQbzUAIMcpz6zV3KtnPtKWcuh6qciiZC7D8YOW7WD+jSpAp+leN?=
 =?us-ascii?Q?AdUHo8SaCwL2OU66d54QBfcTQNq9Co00nFIbZwEIUgYIJ2vfkOFGL1WMJ1cF?=
 =?us-ascii?Q?n2uOdXEQ1Daqsy2cYjHpM5KfSFgcMvjFommgY2EDAMh/D3f7neyV2ONg2GPi?=
 =?us-ascii?Q?VWNSve3plsADNI4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(19092799006)(52116014)(376014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JGqwhpwjCG9QwYJwZKxrQvAW7gFju+jrzyKGTi7wMGdliOpSlyMStJm1daZs?=
 =?us-ascii?Q?m/SusH5lE51VsXi2BHOV+HZkIHgNSQrnD6f3zMMkKZu12hBb4gUadlUbvnAD?=
 =?us-ascii?Q?+1VBJpTMWLGKcr52HbWBWM/wzwSU0Dzcj/eflFpxKHNdYI6WA2sMiF/w5gRr?=
 =?us-ascii?Q?JR4TORfZtUsY8i1SSZXl9VR/NAD0HVos6PYI1SkvnTif1r5bQPDfWSze5d50?=
 =?us-ascii?Q?2narVLZ6ymQFUZLC+f7dYa09a5WKpr+sR2scwCs9vFnL+v9SHtAtf5+3FlUp?=
 =?us-ascii?Q?I3mNPVFePLKOBpZhgVjNK1UA09fanX6Wk6FPgELo2YUVq9A8tqGS7WEuS+r0?=
 =?us-ascii?Q?fhiF4wbStA2ox9bt0aXf+x3DZUD4qhFp7KKrkawcd0M43jg3hXglIfaBHkTf?=
 =?us-ascii?Q?pwSIMinrZ8Dq3K9Rq4VItghW5nIj5ILPIRUWLXI4cvy8rk70Iz+0KxnfrP+X?=
 =?us-ascii?Q?Mmh9cw9EhudcY38JYq+URQtM+utwtZSYLpNlgZoqPmLHH88asszolGzES36b?=
 =?us-ascii?Q?4CZD1AxDobpJdWBRb0H7/S/tljQqwQtY8Jakw6ctfk1jt/4/m5I4SggG+L/8?=
 =?us-ascii?Q?frSATe51Fd+qhuNQ/opOs7SiFJIVRH5uiQStwcwcjzTZusm9FW8ov/o+zjy9?=
 =?us-ascii?Q?FVb7GnJwAELKWcWH0MiXQLihii+qORICAXU0lZznPxroK6FvI1sdsRlTBRFb?=
 =?us-ascii?Q?oYqnCQL41GhE2Rq9erVR8Ku4cu5/N/Cc4e+9DYq3T7/vD1MRiBDVXcE3dWzS?=
 =?us-ascii?Q?xtJjAYSLILLQHbZSu4XqB2/XeyLl07brveM2VDjvi9k5Lc74FPD9IYFh4uh6?=
 =?us-ascii?Q?TWTybOloIm2GfTHbNLrc53XJWOGKzpGHIRetCe8cfBq0NYJu8m2Z3RReZ0iH?=
 =?us-ascii?Q?31NY+WxIc1iGvGodS+fRCcXvnH9iKtwd0daMCIn26nQDMCoZ2KmE+gYQwXLA?=
 =?us-ascii?Q?fVoVZehvK2ff/djukIiWCgIS4WrrlnlBUkSiyfjIRjUdT/eUSlX1LhqmkhEH?=
 =?us-ascii?Q?3t8vsS0vBa/fO8BomSJVVDngcMoz3d4aJi+4ubMjJvbikYwdDKTW4eUzxvrJ?=
 =?us-ascii?Q?oDrqBqIYmmUU6dS4UR7DSLgdf+VLYoeY84k3jaock/84ohvRjTOmygQkrT49?=
 =?us-ascii?Q?UeSWNcdSvfhM3kFKMHkNR4NtKicYFWtJipKNCQJwVxbamQ5MvcnnivOhjCpB?=
 =?us-ascii?Q?t+G84BFOJLTLMfFot7cZeHWYG1r3o3+01EYdmMID1x5hjfm92E6WJNRcaoDC?=
 =?us-ascii?Q?h1z9q+xHaSnAd5q4GHrxZSHuXaV4QiMWUJWUIu+hmyqTF99YKJMv4thpEyGa?=
 =?us-ascii?Q?Sdb6uzBUhD8DQnJOwva9dilyCkWJ6FRJDLMkZj2jPJhloF8vnJ1fAleDrvgT?=
 =?us-ascii?Q?X3OjTKPbu28x+UkAqcnT9D6iF6QCwWC/qfVBxGJiAqL1SwgHPyffBT2Cmjkr?=
 =?us-ascii?Q?U7D3id6LQWmezf4oKQz134/r2/9ybssraTIK65tMvKpie1iLAYuRI/2zT9jI?=
 =?us-ascii?Q?POHLcK3d591cpSDaC107EzNlzt4oRjN3iL3LEhBE4HPNb5YNGjiblewZZO3T?=
 =?us-ascii?Q?SP7tz0AHt1blyMMs3Gdh3aHC3XAXxsQQCNMzyhTO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d0a949d-945d-494a-64d2-08dde1582127
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2025 08:44:38.7874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 52x8T4MmK/Y7ftMEN43tGnTk3lENbO3v1LTBhkQAzGTR7WaE0A529FeDzCJFwqviSx6gA0tUpysf/ePEtwG8Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7630

Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
Synchronization.

The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
PME_Turn_Off is sent out.

To support this case, don't poll L2 state and apply a simple delay of
PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
in suspend.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 2 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 1e130091d62a0..85740400a8d0d 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1017,15 +1017,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 			return ret;
 	}
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
-				val == DW_PCIE_LTSSM_L2_IDLE ||
-				val <= DW_PCIE_LTSSM_DETECT_WAIT,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		/* Only log message when LTSSM isn't in DETECT or POLL */
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
+		/*
+		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
+		 * when LTSSM is not powered in L2/L3/LDn properly.
+		 *
+		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
+		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
+		 * transferred to LDn directly. On the LTSSM states poll broken
+		 * platforms, add a max 10ms delay refer to PCIe r6.0,
+		 * sec 5.3.3.2.1 PME Synchronization.
+		 */
+		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
+	} else {
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+					val == DW_PCIE_LTSSM_L2_IDLE ||
+					val <= DW_PCIE_LTSSM_DETECT_WAIT,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			/* Only log message when LTSSM isn't in DETECT or POLL */
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	/*
@@ -1041,7 +1055,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 00f52d472dcdd..4e5bf6cb6ce80 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -295,6 +295,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -504,6 +507,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


