Return-Path: <linux-pci+bounces-25975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4C4CA8B007
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 08:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC9CD16DF38
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 06:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E244522D4E2;
	Wed, 16 Apr 2025 06:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g54gIfUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013033.outbound.protection.outlook.com [52.101.67.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E043022D4C7;
	Wed, 16 Apr 2025 06:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783764; cv=fail; b=HLSSfFBtXAsH76DzCBJVCEZcTZSBJIzwYAG6Si9c5jxf52OC4qHE0/eI4sLVWj7WDi6Bnzjsi4a+O/7aHvjyL1k4GjvjbhdnlEt/YlBefUxpBbUJlr9c82Yvz2/+Y9Z9W8oaznK/WJEJKNTUAENO7QT3r18blZA22rD+9nzKHO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783764; c=relaxed/simple;
	bh=tP1y8jmRInkN0Uqi18FgtepIcoQcsm+fwe2mjuJxex0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Gnn2DkWMYeHKPq2TEUNSHFQ0nupObFMaf3P/YL/mp+HiCsWHQWzvXIGvuSU8wvr4C0pjYYycuDIjwhjpCBGdriG8+A2xoqALB1j7UBV3xLT+dcN+RuK5MpHiJhPfYakXwrI4T4VxJYN33rAou3PcTiyfokdhtc2tIxEjuswSzgI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g54gIfUg; arc=fail smtp.client-ip=52.101.67.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BDPakLfcgdndkDPkSXKQlnV8FP4U1pGT3r0WvWfa2s+mPkIy9RRFZhPSRZb6wZAc8ebYId93d4uM3APk7ezcCfzivHtCagH+TbESvCGcRrJ0kCo934bAutI5tf4FSac1k3FlOMMb758rrwyWijMzHbCgf9TZYh4u0iEvjLqSmfJRMtaEstRqZuXr0KnZxeQCvUncBHQJ70Wg7PJba8TwOQAzzIoteREjpIRrLmmhEljKGmsrds6e7z5kAuX3G5qrBcWTQ5OT7CEQ43bNdN0gdsEl9zwxOcYdmeB+qzyaKXh3nGFDGbaZLj7paRF1e90CFmOhLE8z/s/9AGxM57TybQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4iPa7OY+q2H5o3W66scZBiAuu7Of4yBZLJcG45hihVM=;
 b=EYnSiGhinLab9AYEIZv6G6gJMYSEGmPGMPoEPTuiUDt0U8HcNcLZETucyepyOrXNnALvqtVNLheSBgmi+Pg/bj9SDhA5QBDV4Y4FCDrB5ugOtoh3S4RrPYxho+1BL8HlWC3eVEpks7X9sJQDg9aLUIxPOdJLI6L5Ms9o6pD+OzXSW+LGG6dcUKx+UrGsSEJOJcklSG3+cqmcTSXwr1t4vUVHfKAQ0k1BGrKF6c3QrbgMsqNBFJK+pS268HR9pcI05StI0tPksJPvU8iSAAWzdMH2r5Fa4eDn1nybL6BPkWj18J/SuWdgSnspsV/99+hITWlblKZlRh3DeUhJ8X8Lkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4iPa7OY+q2H5o3W66scZBiAuu7Of4yBZLJcG45hihVM=;
 b=g54gIfUgYKCxKmLMCTZxs5LyohD/zCNz6uYgpkMJUwn9mpJG2VTGPTMhXwZE4MS4cNZdTsi7d9hgI3lQ9sPi8kC530l0PtMDdeit+e3+yYe7//HfMs0aAMm5A2vAZSoGXB6n4pR/TcGWeWM5kRDITyjNCGLyiPJ2tWzHC1Ohc4f4JdSNQZMObZ9Q0YBB27aWJiZzKW5oFSk6l0QATrZ8peFa/hZT2tW4OQQHZq6o5dlMQHXDW5VWEdUpotfN0hQ6Gqc7LgG6ApckYvbXHU+KzdqcvcDqfpGZ3ZyMD1bkCLQeukWa06i4u5W35KQmuuPZiv+c3u0URdf/K3bP0vGh3g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB6992.eurprd04.prod.outlook.com (2603:10a6:803:139::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Wed, 16 Apr
 2025 06:09:20 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8632.030; Wed, 16 Apr 2025
 06:09:20 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v6 2/7] PCI: imx6: Skip one dw_pcie_wait_for_link() in workaround link training
Date: Wed, 16 Apr 2025 14:06:43 +0800
Message-Id: <20250416060648.3628972-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
References: <20250416060648.3628972-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0054.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB6992:EE_
X-MS-Office365-Filtering-Correlation-Id: 0520880a-fece-45a3-393c-08dd7cad39ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q3iOF/tMhBIm62Lh5dJdYDcqbaIRVFOMvZOM8ySX3yIh18K5YxGML+JBB4jx?=
 =?us-ascii?Q?n118pKW2Es4NDiIamKRka0z6hDu5ixC6umR//RLfgWooKRUcdeYmdNLdYEo5?=
 =?us-ascii?Q?MpDOZE01ha1mzx3R5u00sWeD+reCoJyHHe0Ngg4wC4LyasWSsIainl2skrwp?=
 =?us-ascii?Q?ocjL0kYHCpTBVtutQuHVe1QCbHjzIoNQbBH0FKO+ta6agiO7p+Ypx13eyhDf?=
 =?us-ascii?Q?WQ1TNf5LbU1xmDTVGpqXvp/CflxnM0uZINVPzJ81B87Bo3WrIdZQwzLoiK94?=
 =?us-ascii?Q?EDlo9io918aCLJLot0bE/GJzvo610DrMdIT2qocrZyEKhKp22E5jlVGjQqvU?=
 =?us-ascii?Q?F5rq3BtvRJ42qtVIpajmOlpUeKFyT08iZtd27HOs6TyYAhFo2Z/NU5Zm48Iw?=
 =?us-ascii?Q?OErZGVY7sA2vAxL6qGMorbLkHQa9NK6GQPaIvfQ73kkzj28k7llfhl8Onh2N?=
 =?us-ascii?Q?6BT/NcEzgDqL9P1sbZMwN63Z0KRf+4Sj4CxWZ3fGAidykZ4LJQlvtz9Qu6DC?=
 =?us-ascii?Q?dHh9B0ya0gaSaUB/VJhgO4MvuszkXtIWJx+DXmXqgRH+0/dffezmZ54323+4?=
 =?us-ascii?Q?B8tItuPR0BB1I0jZTLN+JGTl6AgOdh5isHgKtd0xDRN35ou6UXBAb71WnXWD?=
 =?us-ascii?Q?dJMfpOfRYAXU7Q8qw5bmvTV2TdmmplWoZpNVMFuj9zVakrcqy4p4yIYjweXP?=
 =?us-ascii?Q?7YVZ1Dg7ez4L2h++6+02vZSVsDKTKEtIVnDCbuHqYxAwzkHMOcH0eUWXBpBS?=
 =?us-ascii?Q?+8KN6Sj3E+waaa3E+PnWOYPLtxQoYYWgfhN7/WdLAyvmnZJ1icRb0BjmMlZA?=
 =?us-ascii?Q?a+H5yjff65Hd+KOxykdNiT0ydKbVL+JOg1iT1cgy4eWxq1s4pXnuSpts51Bx?=
 =?us-ascii?Q?HjNkoYiypdIAI1sSBcoMKCK0mKHCV+TkjQl5Q2IADClPnZfdbtAu+8AjXkhI?=
 =?us-ascii?Q?npDuJmsY2khEXyasb+jsR/yXJ8jKWqZOd1gXA363bjG6WuqlI03hp5ceX266?=
 =?us-ascii?Q?OpX1xWrsvXNPANH7vcrwEzIkuVAytWMI+P4xm8+9BeIlgS7gjM2joHIDSOd5?=
 =?us-ascii?Q?BWKTi4GQaD5VmH9muyJeAMzqwZVyJkLw0TwZOFCe5Ulmo4KTAjY/+6uvAmES?=
 =?us-ascii?Q?AKokkrwtl2joHCuwBAovSUFSTXR0zo1fLwSW0XjJnkiskv92LqjBG4xfGF4A?=
 =?us-ascii?Q?Yqau1dKJ0zqAS4zok82PPrslgZKVA1GxY+WxZU9KZLSq7JspN5rz1PH9nG3/?=
 =?us-ascii?Q?E5Nv6M/fbkwjloOlARbemI05yt1HF/YbHEI301qTNL1WK4o0dF1OZaqx8tgX?=
 =?us-ascii?Q?gqx+SnAfYRqg9Y964B+Z+v1BYqujvmd8NtzcD86NaVhiL8Dnb3/u9zH0dSb4?=
 =?us-ascii?Q?kSIzvUeBmI7BcmySnedOV+Sdu3Fiu74HBAfD0DpIlEK4NXcnaA6GqfsKfmGh?=
 =?us-ascii?Q?8fdmzt3+ViwLBKYPIbJsSKT1RBs7eODbunPTOcN+zog+CVZ3/GN2Mn0TYQcU?=
 =?us-ascii?Q?6s/rQfbOCZGjdUk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aP/cUv5x7oHI0SflGC0STCfM0g6gtEhqyl0OgvzEwR85nOLRIdyi6iczueks?=
 =?us-ascii?Q?GxJE4Nx9A1KtDEj813UGHt80sJx/696/Eg7e8I7gIPbAHRevDNbenzSkyCwN?=
 =?us-ascii?Q?/nAZQNyh5gik/1JA1allVJZJPfuy4taMs8i56osoSvSJqgaQ8DRvdb92kchm?=
 =?us-ascii?Q?phxYS59SHIQ9FQ91TyzYZB7C1i7Mu4eD5+Pr6TQHpH8agD6fD0hd8s0UrZlV?=
 =?us-ascii?Q?QYf3QFO2UYOUtOHEWXWDl7lyPZsBY4Edc/e05dC5g/Os0YGUmhZ7Mnz5n0ko?=
 =?us-ascii?Q?RQOzUeol8+cpTCqK9JyAWMrWjCA6ygeaNUTxgiRmhrAjh871y/VMMPopPhXL?=
 =?us-ascii?Q?vSW0Xmjljdw15/LFTc1RufceNt4H/Fm8XOt/Yf8FcCDzIJSF8JRlys6p88ki?=
 =?us-ascii?Q?D8/uVVvcHquxtFeJ3pPlNppDrL1KNWrEfcy1Q3roU0GL4b9k+ZJSNMhX0mkv?=
 =?us-ascii?Q?6nTIcF59+Y+jUTl7T1h5Dgf+zX2qdG+Kd6PNFkByzYs5CsjXEF5UB8Lz5cJb?=
 =?us-ascii?Q?EDJ/iCyvKEMsNxEcj/sUQ61GVFCuuZYQkzy2+/dkUD52U2T/9IVMI0amyPEw?=
 =?us-ascii?Q?gsQVeXlGUw36xEtGf4/WNxK8sHb6n/B0g0ojKJEdF7G5kK+I5WiLIYpjFKv+?=
 =?us-ascii?Q?/+wsiKCdIU0pcAjQtZJJf93//cApoqXv88hkLimB68iXpP+/ybrsxa5InnBn?=
 =?us-ascii?Q?2V8rltbqn5ns6/FdPoqITXjsWt5wi9rW6BGBjCxMLNLLHKBEG2zUTJTvqJAD?=
 =?us-ascii?Q?CKCaAvQ6NMaQ+cJYz/WsHFkZEv85NXl/YyZMurCiv0Z4H6EX441yE4nxBjdk?=
 =?us-ascii?Q?ngkaW5I+6l0AVW82sZCMuvQSHcQNEYh2fBT7tUvXGH8i2hqNetyHsKFocjzd?=
 =?us-ascii?Q?7psX/ZJgcxd93jV3xFOR0U/ZPjS7eu52TfWOXge0vUFJZtH+zthpcGDUUaqj?=
 =?us-ascii?Q?XaPZ6mCVmMnAz+ySMFsyE8MrZiqtDjQqYHquTsUAxtROKYjDa59jol7e05hS?=
 =?us-ascii?Q?lW2mbsVyGXp3Wz6QmTQVkBmdE9yJq1i6cFqQE9PVL6nV+SLW9adm89oBbsId?=
 =?us-ascii?Q?14ESD0s9CRvC2RIIcPsVqZm5c0D+77FqcbVf7CTeLAPmXOgiZ+mC/VpY5rqq?=
 =?us-ascii?Q?ow95wuqPK/sPwlEkhb3HeCCo0xJV9IZ/B93IwPUyBaNBtdlnziGtprsovLi4?=
 =?us-ascii?Q?EZRkEKudoLl2gAMy7PNJbnAaWKwZTbfc0HstedDUw9EuSvBMxcRC4VLNqVUT?=
 =?us-ascii?Q?WCMWAwhHZsDXqWEKnMhrBHgSMjaMk8d5thPbUxLCiY6LrdPO9XwG25DleoQe?=
 =?us-ascii?Q?E1a5YIImKfzCo6pckgpRI6jXadFrj9AGaA/VXkxijiNW0jRAkcVJOLA/GV9N?=
 =?us-ascii?Q?sJgSeJ0MBF0BDyLiwqDh2+yfbCEzXl6S26CGtyE+69wezroayEbULGSVVC+L?=
 =?us-ascii?Q?lUzsaaBPmmbJFHZpYerYMIBcy2s+sQzq5rF05DBhPeQNUyF1+pr1nk9LRw1n?=
 =?us-ascii?Q?U90ZBe/s6oOcugZrxlI2K77OV9+REHUGcOfHfVNt1wSd5XO3z9Tn8R7auYmb?=
 =?us-ascii?Q?ln7JRmGKiIuuDsMQzBccSiq8WN3rzEpQzw12PyrI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0520880a-fece-45a3-393c-08dd7cad39ee
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2025 06:09:20.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PrHiBGB8CJJc5TYEuC7ZBrs7SFibpbD2rILUtx+FX6qbIlsKBWCxA2/1MXcLTw89Hef9/sJ60fTPpB/2kC4Yww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6992

Remove one redundant dw_pcie_wait_for_link() in link training workaround
because common framework already do that.

Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index a4c0714c6468..c5871c3d4194 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -881,11 +881,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 	/* Start LTSSM. */
 	imx_pcie_ltssm_enable(dev);
 
-	ret = dw_pcie_wait_for_link(pci);
-	if (ret)
-		goto err_reset_phy;
-
 	if (pci->max_link_speed > 1) {
+		ret = dw_pcie_wait_for_link(pci);
+		if (ret)
+			goto err_reset_phy;
+
 		/* Allow faster modes after the link is up */
 		dw_pcie_dbi_ro_wr_en(pci);
 		tmp = dw_pcie_readl_dbi(pci, offset + PCI_EXP_LNKCAP);
@@ -907,17 +907,10 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 			dev_err(dev, "Failed to bring link up!\n");
 			goto err_reset_phy;
 		}
-
-		/* Make sure link training is finished as well! */
-		ret = dw_pcie_wait_for_link(pci);
-		if (ret)
-			goto err_reset_phy;
 	} else {
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
-	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-- 
2.37.1


