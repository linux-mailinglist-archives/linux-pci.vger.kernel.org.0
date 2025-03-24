Return-Path: <linux-pci+bounces-24481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86000A6D451
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 07:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 107E7189055C
	for <lists+linux-pci@lfdr.de>; Mon, 24 Mar 2025 06:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2D7190462;
	Mon, 24 Mar 2025 06:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y6+nn7Do"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2088.outbound.protection.outlook.com [40.107.20.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334F1990AF;
	Mon, 24 Mar 2025 06:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742797914; cv=fail; b=MTeCpq4j3S5IkfnfjRvzuec7q8HfbPq9qTrT+tvyvnhSvkxbhV/YvIZW3C/6gw8P/Jw0McFyE/OxCpr55KM40FLoB5U3tq02d3LzEn11ybXsAtCJJNPPXMUufboEwrEQtzuYip+km/Ds95Wfi1//vpw/5mI8g6BXuuYaM1Q6+Hw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742797914; c=relaxed/simple;
	bh=u8Yj5F5WnNUgcYeTmzq7WUykAx7YZ8qaNuFMgEGc+DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fJc33Evyj95P51+YjZnlgl4M/Sw27/zeyGxN5u2mWD23vugq8vlUjm3z2SMqZrOd1G1fjeddEinTvPPeoSri01pzIFjFCOvX4KD9oA9hrgjMyTt8BrHiRd6+Q4FFfk9X7A0+r9h0Zso6YU3cDjbdCMnc5q1o5ca2mZe1Q1hElQc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y6+nn7Do; arc=fail smtp.client-ip=40.107.20.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXsLSYVj9oOWBowpWqXUZAcgTbDfyE+HLfwGeEj8TyFd61X5qGNccb5321BAHHE57jVcyVYDoXm33QKvS/yGQTuEPR03JSec6gu52YjSc3R3fSSoIz89VHATPuyV21cz8kmLplYfKtFn0fpp2q/VK3uw724DbZ1ypGvtYiaYKr56H8q/xMGdsk29FAWE8c8yhziUX+95wo9d1LtrAgkVXL4D2UbrlNzj4PxfRSAXQ5Nmv+20XKcdpycfwaGFoffXWlDK3PjFHarh1wTQ7MqDaCtno9xUaOySfu2UXqf6pW1V0W7XuHYe/eKvbySXaoYygOdd9Y9mthG78IxdDZSXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iWJ0No6zk7h4YLzKpJkzg/71mpMBUmXrG+ClUjRbsVw=;
 b=eqEjE0WQd/2zL+GabX/58MLpJP3AuIgDJvY9+MSeHkspol/npmKH41IbqpKB2mdyUaPXJBQDJd2tZ4xLPs61S02OLtW8LEI72h1rAkK142ahs+0iCyG0UhxEpkfNeVk2BQ4AR+144HTaT2Rm/DDabVcQz90r7wt8SpS5bMPWY51pLE+nk7MJQVzkYYY+FbmPWkBdAu5yHj5IgZiUAxTr9oss5T83UINAFoYIdMCbO1QTjIiazLH0BxKa28LikCi8rkXuXecByaGg8Hnt4OUFY+bx8wQfEWcNh7R8DBdkMiOx59F0LN62YFz+WNYdFtKkawt+stV6fZJWB/ohI/SuMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iWJ0No6zk7h4YLzKpJkzg/71mpMBUmXrG+ClUjRbsVw=;
 b=Y6+nn7Do799F5yQo3zZawwEgdujwCfsYbElQazgpxEBtTQk0pQPEEHpYRM21uSJkV4NMLf+9UDEQ2vZqOtmum8hsvcI2xNPfuvJB/zS1n7d5y8OlREgfirQEGCqbVasG/009WK4jkwvKSMZgG21LCcujtC5K8AjsCJ81l1IOInQ2EwEZtABcpwnBS0M3/M8GnWtwjwMkTR8bgjZY+2gRjMxD2uk5/NuK1uPulV6MrmHwH6V7jezywPqrjuZ5wqHr0+/hPJHz9t6tINL2D9SKM0fPpI5iq/9RY6RXVl4KTDd6pwryb0fdwlrDNhpVXOICsRCivig8vbiUYFagozna1A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DBAPR04MB7366.eurprd04.prod.outlook.com (2603:10a6:10:1a0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:31:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:31:49 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	l.stach@pengutronix.de,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 3/5] PCI: imx6: Workaround i.MX95 PCIe may not exit L23 ready
Date: Mon, 24 Mar 2025 14:26:45 +0800
Message-Id: <20250324062647.1891896-4-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
References: <20250324062647.1891896-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DBAPR04MB7366:EE_
X-MS-Office365-Filtering-Correlation-Id: bd0f5dbc-6ed7-4fe6-8134-08dd6a9d8ee9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|366016|1800799024|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TnAYoAol6Hhay/5I4xbdZd1cgQWKC4WJGYpttmPBpgCuE0qGa5U2OqWzboel?=
 =?us-ascii?Q?LV3T1YrPCGj7cmD7+reQ4tNAnlCoWbJLyQ2oqAdDXiB/AQEVtEpERkgjQ2JH?=
 =?us-ascii?Q?8+WO1iK/5444fnmKXl12H1BWP3QVM37DeobyUvFmjUsdcCdWlsOFEBJ2aDBW?=
 =?us-ascii?Q?coeGvkYJtDUb3ZKtkjmoH5fJ8dxPi430m8DO2DR3/JrKPToIJHI3j+4NlUDY?=
 =?us-ascii?Q?mzAjsTA0dwebqF7TmqoHPWtc4uE44oe/+mbOdmPOW3gOYnfk8DqrD47nMKi6?=
 =?us-ascii?Q?zOgD8mCdPt3F89bdho8hMTAqBxHzTtTdnsPRWD2XwEAS2zc2vKXTR2xM5wzM?=
 =?us-ascii?Q?GXy7pUTiCLH3klqisSYEYei5ESUIQVsY3xvvwhsAo8BMFtIl1EOnxWyyDXjM?=
 =?us-ascii?Q?Ez6jkjpN9110B8x3RcqEzlWDfbouSDdt7E99Jf84wg3UGifje3bbXR2h9/+0?=
 =?us-ascii?Q?rNDJu/OCNqeDw2eTPW2RemSEYJePkW4Cs3wFTVAZXZl8cPh56mqXWwk7sTYe?=
 =?us-ascii?Q?K4/helhlSSuSZFw7vSzh426cXpSs0iIJlOiyWF0meFSfuh9BNfCVUUQNyLjq?=
 =?us-ascii?Q?vRN+rCvMckXqU4xmTWhnC3U5hhAy0oXn0JRmF3DhKTTZaA6vvMSaDU+x09PS?=
 =?us-ascii?Q?8ysnpp0HZtchq1Qrxam+enfeIo6bCHJNIzWX53dvUwsEPcbnTUB0OiNzOYob?=
 =?us-ascii?Q?IuBLHKpPEKp3x5c6XT/dVY3KcrNhLmf0tR/ZtlCYNDQHu6vHznF/Kxta7/UO?=
 =?us-ascii?Q?t24tQ3qO88fU6yczfgj/C0pUH1KtdmXIdzVINXk/deBh9/ryYdPrsP0oLNT9?=
 =?us-ascii?Q?71Gs5b3/mMl7ZEfSp/8DKZ0V5eC1+rXP2lxwGbhG4CO/1vhqAnl2dY23AtGt?=
 =?us-ascii?Q?i5eFUIZt9n2UVr2UWhlvS+qKXAXsfj2RXdIEu/M9CMbetjp5dGLngZKxdpEL?=
 =?us-ascii?Q?tI7CTZXYVMy4RxFSLSUBtDf6Pjo+4UqxLYXssb1XZj6RrGSNWmW1tAKqzKVn?=
 =?us-ascii?Q?Cvb4ELE2UxyUOcag0FV4CrX/WoeNzHXCS0fMFJwiMsl3TdELnyjGakN/o6DL?=
 =?us-ascii?Q?kje4KMUUr9yvnzmGE/YQa22uLwEfSTSqk84tpZuaeM9vVRhF1dTuIyIrC0jY?=
 =?us-ascii?Q?wfV/JWnU7qXjIbN+sMgE/3yT5FXOpidquOmdhEMGhjf4BfBvUcyrYbKSpWro?=
 =?us-ascii?Q?zlQMHszwvNMuZX3CBUAfxn+xMhh4MDYa3hluNexknNjbRu+ECojEv4plRlkC?=
 =?us-ascii?Q?Lj2n6WWJAA/G07B54xJiwCY6c41JZO8eI2lgG2N66PabcseksPDROTz8VH+B?=
 =?us-ascii?Q?z4FjMDxUgIVyoZS8oTv2+oKhSdCFX9KqBHPeDKDdP9NHrYk5/zOff5EwoMxQ?=
 =?us-ascii?Q?mcsdnp4LRBplwkQaHI5UN11lHNcOUxsWQwDx2GDVSQEvFfI5ZvlX/vVlfhJc?=
 =?us-ascii?Q?yNiQsCZFH9OkFku1PDlDlvzdHTkmoaQTqEgPTP8iHnF9YMAOClzQOQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(366016)(1800799024)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pdovFiCDz66EIvDQKcFFOQvdkBlsh7m34DtS7dmG9gFqGYMxSfYha9cXu5KM?=
 =?us-ascii?Q?8dhWq1tgISu3Jz2cQgoTiNrHKQHvw4X09+sxpbqUrsHIgGskR0k3MscGUFQU?=
 =?us-ascii?Q?wKqduwHD/uv0rVnCPueJFAHILqLFtv6nXhA1R9ErkARWzGsSj8yjS70FaPhs?=
 =?us-ascii?Q?9X+pBFUBAOsFVHFDM8XouOY9dwMAjV5c+GfAfFRH22H9h4bivJjgCm0vBj0d?=
 =?us-ascii?Q?59d9YGYr4TZUJh01Q4W+JuJnnCxylvNG9ZOsSgN5Rc/icQjl1AVQeaD0LVIl?=
 =?us-ascii?Q?U5uV/UvHBO/SFLWrvM6UiME2CBLWnQq6JsmYF49FmYNbRHFSommGqFd4ZlyZ?=
 =?us-ascii?Q?nWu9DatE/b+9fGhkADddyk1RK+gaQHmL4tydfDWIkWb3U6Ky3837EpRhDpG2?=
 =?us-ascii?Q?tUX90k0b/l9ZbIcG9neavHypqgJ0yFMjtJWsVuWa9GZCu4UNkvB9vXQRuH6b?=
 =?us-ascii?Q?m4O1FpU2xTZE3G80gg52ihoeGYXHkBs+jQ+vJZxN3d4hVTWebbPN5xFwvQ/G?=
 =?us-ascii?Q?0DiFLmfXTWkFzsDacadJ0VTE3/GHFOzDM5cjq2/A9c55klwZKoZwYucvAeHp?=
 =?us-ascii?Q?xc/CG+bfgzftYuNWJhNnaWrTZvxv9QmX7vE3IED7RFU0FGxmwd/HRrcyo4I9?=
 =?us-ascii?Q?0tT4gjoNWnc0NO1QFy+nGRSOraEqo5FOO6x65vUTOYwbuLDO/K04TJeIn5Pa?=
 =?us-ascii?Q?VPbp1EBkKYtbR9wQtEd0pRt/eT9aSRRCr90Tzf1SZs5bchF+rSynu//YPfr3?=
 =?us-ascii?Q?C+bMo7508mYvQchoMZC3IHplgpSP34iG3QsJ8ikoax0LziDjlZygsWBzd51/?=
 =?us-ascii?Q?JQCld8n23KvIpXzYNn/Nn66IoX855jv+fpfSr1DdrVZ1Gjg9cYO/0sOyJrZT?=
 =?us-ascii?Q?NMq+6kgDGkCM5Dgj7fqlpCy2t3eaMvmSIV220ONwpXdHI9OqIfZxZBw+jKBB?=
 =?us-ascii?Q?sElTSjaWgw0XEZryCSrwgbvNc6mI+X0bL2+3qW+3ieAMprq1e5vc3DoUbwYu?=
 =?us-ascii?Q?trui8i+qUpw1nRo5GjZ4JGxVu3eI4mD3deXe7GzxTa1Xl2RDe3+8DsAlzaY6?=
 =?us-ascii?Q?tJbbUiSamD+AZJAG2CD7f2V5lRv1ANnJvSp/C9aVWxJupfYqqtWAbx22vFIK?=
 =?us-ascii?Q?6hlP50/zc54qc1gZKyBZqHSqa+2kGlCPsgu8u5K7NIJfjCUiXe2s2TRZFS8b?=
 =?us-ascii?Q?ot5ffi8RUHIrNIAJ/Puzf4BqvNMcfBZ450/HL29aM8hdueJEYbtt+67d9z8c?=
 =?us-ascii?Q?weD5J2gbDAL3GEhplK+KrOikms1sA52KYIkP7+kAYRJyq/+rZT9mn92DSV2C?=
 =?us-ascii?Q?EBuhJUprQbri0B3buyFmTUabLVmXpDtWvIZaIAqV3rwcHW3J+mb7MpMi93/G?=
 =?us-ascii?Q?ddMzmKqw1XTilRPNR1WcgAexJ21BPZ2zVMIXduCnAEg4PXQSlxls8loTO4ah?=
 =?us-ascii?Q?ITQPG6J2r/M/DUP6UPe3nPHGg1VS/qCy+Vli3WTUGRJXhwV2OkIOfYxpoJxr?=
 =?us-ascii?Q?f1ttfIXpfDWtr3I2ipEiCFvLaeCXfXn5XE1HmECx2Mb9VpksY+8bwA4Ebuzt?=
 =?us-ascii?Q?5DG5dFVswxb3fz7aDKw9Z8J4jLpqTpID18mJ3Qa+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd0f5dbc-6ed7-4fe6-8134-08dd6a9d8ee9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:31:49.8432
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q+klHnbAWXsHdZvWenpw2vxyqvXweJrgi1nW+PZ03ezRMC5uiTHWTYMRnwlEcAf/0JLLbfoRZxM7PLP/yssfeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7366

Workaround for ERR051624: The Controller Without Vaux Cannot Exit L23
Ready Through Beacon or PERST# De-assertion

When the auxiliary power is not available, the controller cannot exit
from L23 Ready with beacon or PERST# de-assertion when main power is not
removed.

Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 0f42ab63f5ad..52aa8bd66cde 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -48,6 +48,8 @@
 #define IMX95_PCIE_SS_RW_REG_0			0xf0
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
+#define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
 #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
@@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
 
 static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 {
+	/*
+	 * Workaround for ERR051624: The Controller Without Vaux Cannot
+	 * Exit L23 Ready Through Beacon or PERST# De-assertion
+	 *
+	 * When the auxiliary power is not available, the controller
+	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
+	 * when main power is not removed.
+	 *
+	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
+	 */
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			IMX95_PCIE_SYS_AUX_PWR_DET, IMX95_PCIE_SYS_AUX_PWR_DET);
+
 	regmap_update_bits(imx_pcie->iomuxc_gpr,
 			IMX95_PCIE_SS_RW_REG_0,
 			IMX95_PCIE_PHY_CR_PARA_SEL,
-- 
2.37.1


