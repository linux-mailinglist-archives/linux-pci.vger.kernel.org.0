Return-Path: <linux-pci+bounces-34169-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6224B29AD4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 09:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD317B4D4
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 07:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8452F2777E4;
	Mon, 18 Aug 2025 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AI7r1/n7"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013005.outbound.protection.outlook.com [52.101.72.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6146927602D;
	Mon, 18 Aug 2025 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755502373; cv=fail; b=ODyakNPKRY3MXfyc/yAMeLnh5n49XQmDIDQuaonLRLdjRP7iiJDUc7271uqKQGYnQwhzoGTo8qWyM4OyfVXwwKwGQCLLxbyYS+Y1F7ENpx7g/zn+SInVfolUHpxodm6qzUa5+QwdD0IwP+pO5eUgFQoAJ7fc4f1Otzc8jZx3OyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755502373; c=relaxed/simple;
	bh=hKfBFd3u9V3Oi1VALJhPiKAaw8dBAmDIYKVJtzL/3pQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Dz96VJV8tBkOYZE12vkICRqf/zE32zxXqiKe6t3vK8FE9gBDlg2oFyRWeGBHcWXLgmcJ7R+2qU3NkOIumerQetT9D71eJ73v+woRacMvA6Fz6CboOCZ9PP7pcfmnXk16kgC/SjVxsfGLwXVSb1Z7/Y9LLu7BgTRZI65RyRNzHRI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AI7r1/n7; arc=fail smtp.client-ip=52.101.72.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j+Zc8539t+lujvOqBZgo/MDb6T4YLb1o3s0qskaxPvTbjQ7SLYyy9ciCPsgYBpVlA9o/1loF8v6yFGaDTsEs2bQbB+ZjCVGPUq9H/Iq/UPlS/jXN5LNfgDW8ZoseAIWJb+vBKfMzIOESl/ukE1yOHdEKRlazSbGOIIBLy/I2SACBmmgtrfbBs0ljkNMUzhyMkLflk5VVx2dAgu9FonRe8uzyP4L3BZFcL+UR1IQt2QJbe1yQsxiq84rGGaSQUVmej5SfuF65+kGv0UdH++o7xYgkgpxpTnXOt9+U2wARXVw8NPOofMQ/UQOaHBxvxunIKdT2hINm7l3lkwbsfWt50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mOG8IGwhvP+5XiHrSDj6cvPezXVBN+WyWAlXnZPeEuM=;
 b=qbB41LmTMtKHtohlU82Ai/A/hh1yKgBhmrJdVBI8o7vGYQgrFEeu+kdJkuDzcWavsqgVfAYl7a3Zm62K6Si5Vme1NCqJ/K68gIJOErrw8Be3+X+W8jVn6Krg72Vq8djbS1shYE3rvl8cgpv1Vma68tsvuGRxOZuiidv6XoXWNQPpcthR96tj5vAeG3ujebv9OPK7qimRvd1AfwFrJao+sumOSGr5V5WNH0KLctNpzi1NWpAXf92LfcjgE3Ej+92nzGlpbwx6vAGmDSGCW+fVVyO7Gw6bT0jmEgggsg/2+vpVL+NoTcr6MaJMqhG1/NapG80nSXTY/bvVfHahqpCSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mOG8IGwhvP+5XiHrSDj6cvPezXVBN+WyWAlXnZPeEuM=;
 b=AI7r1/n7alXfTBPlRlDwFGX4YH4sZAJKA0XAB3qXPQ9ZzBwlFw7owkoQGFB1VVHx4Zw3j7Ps49oI0xxKrWiMc+RL5cADY+jQmTCQOS/3ISPR9JyP8O70m6nKj/l9/KxNCks24NiVBHnLzuFwtOWkNW05U9LqDrLbgLc6BXl9lJBAs2qo2C1UrKPttpSS+zKQIX/U66Gt8gHjUuPSTTH2y44pmTDHoa4QqIDuivk06f9v7M6JiWQhZ85vtroexln6fbNAHNuiMB2N9MOkJWV2wYEfg8I95ZK2t+Gced4DmutAJhTI5VbeoKFzwrv7845/d0f7MNVkzA2DAw+agg6r4Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10533.eurprd04.prod.outlook.com (2603:10a6:150:206::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Mon, 18 Aug
 2025 07:32:36 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.011; Mon, 18 Aug 2025
 07:32:36 +0000
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
Subject: [RESEND v3 1/5] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Mon, 18 Aug 2025 15:32:01 +0800
Message-Id: <20250818073205.1412507-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250818073205.1412507-1-hongxing.zhu@nxp.com>
References: <20250818073205.1412507-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10533:EE_
X-MS-Office365-Filtering-Correlation-Id: aef6bc5e-e2d1-4ddb-e052-08ddde296703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|7416014|376014|52116014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EVYqbiCYhUUHen8+0FWxa+ZK8bTxSfIkef165ZuJ/+ymLU9grj4+Cvfn907i?=
 =?us-ascii?Q?pdsxcxnZVnf1tdW/DJzA1IQtagdZBiZ8JWtnqDwN+Bp5zZBVS/dwAvjqj5Nr?=
 =?us-ascii?Q?cSREU7U5owAp/jK6QNC0+PDVlb4/gY8TiFRlfI8Z6tUV4JiqjzaPyLo2b5HF?=
 =?us-ascii?Q?V3DDEXXYmq1FeOaWgVPdGxHZynjJLS31pUAMxQygDSb97J1muhjv2ZXZt+IQ?=
 =?us-ascii?Q?XZHqLJ+IUvtVF4fygd5srEqibT5/eX7bx6TvijBaK75G8TSDUEK3qM2rWxkS?=
 =?us-ascii?Q?zkPyLxX3yyVtF4h7nKzjYY8owrZ00IOe2FJRK7s8MCCvCXXm924L4KkfO74J?=
 =?us-ascii?Q?NHfIItekRv/XUo2t9t0riCsiaKwteGIsS/sUOFMvYxWkhb1PrfhoXxNVF9Xp?=
 =?us-ascii?Q?ujP/N7lJCacc8eQ4sVSSHqxiwUmbQ/wHFutQhxd/n/CZ3m9ZyhE7i5VoNrHH?=
 =?us-ascii?Q?S6J85x/0rpjLOfdZefLVXfj1roR7NqgkybON3kDnYmkTo1cYTXlsJGv8uu5l?=
 =?us-ascii?Q?p6MmA8oFJ4s1eCxtt+DStfH/tpVkqf94s/nK/aXyuUkRu9AofrAKBNxgrL5r?=
 =?us-ascii?Q?vzAyqJ+f0yJzrwvbPAilmOlK3KVu7MM4XXM6VUfNtZoGLAr8kPyp6uk+mJ/P?=
 =?us-ascii?Q?b460u6zd8zbgp2m0iOJmwuq7A4mmVEGkdcFU5y2Fx3Ypkz7Ak8Z5wmghwPzx?=
 =?us-ascii?Q?EWOPy9lRBPsWJ8QS+c/LP1WloLH3uvM3Y1l/gCFVtuOPdAeGkTSi897l97NT?=
 =?us-ascii?Q?w3PXL8b72L7MRIa5ka/BitT2LD4u7CFlUQBvgiBTWk7f86NUnmIYuEV6TaKD?=
 =?us-ascii?Q?sYDinU0y4ZAxcGSE3h2KeE9XBaKRc2txpHglnt5/33eNt8NT5FSORV/QwAPM?=
 =?us-ascii?Q?19y8CQpcFaouLVAiQzowt41yRsXmBrgkLn0wa9yN0sh+bH8Fgd85bGE3Pa8y?=
 =?us-ascii?Q?z84mrhPuqwapNWBQnHRhRhCT1jFAUL08+EESmQsvc8CuEyLaZMXFkhuTQj6s?=
 =?us-ascii?Q?JngJYyhrJ4z90KUdYxOW6UdGLvRBL2HUa6Rbpn0tZkLK7NfbEJXEGkSBLVQk?=
 =?us-ascii?Q?iIX8sYKdvemRUpEaJqHj0BAxUfhXKtoptaB4McEQgukuq/cAvSAS9Sba/BAr?=
 =?us-ascii?Q?hFS31QebHvpGbgoyzkgu/6kTbGQGCx+XbMbVXOrH+1fVJ5F4JSCa7FcrBTBO?=
 =?us-ascii?Q?USs3FjmJCOmNHPILFZ8/EYH2cLkyKrrGomA1tFJfCEPeJJ44TNLdIyHrt2DO?=
 =?us-ascii?Q?0c8XFps6k++SUms+Q7z69axUKUxXnZhhLha7v+uFl8leSFaro+k2R/DiiWCs?=
 =?us-ascii?Q?sNELTAlrtJGGuxUVbuDdEFdUIQD0T+ZV0GmmYu0Z8Lw9CL5c5suVVqDzfm64?=
 =?us-ascii?Q?VIf7/gVWeouN6mVWTlRVdFTujSpgf/xdU17Fu46FhM/FPTzWYhBHVY4HpU4L?=
 =?us-ascii?Q?oQ75nuqYbvlc4kHS7eMM9V661UnoIVh+cuVaju75wtmNrGKi93AdunblwpT3?=
 =?us-ascii?Q?I5JFqcN/sH9wtIg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(7416014)(376014)(52116014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?U9Kydj4IYHqLYToPbAFgifmEa1SHPC9YeJesi2oijjnwecOX4+42m1D1QJR0?=
 =?us-ascii?Q?cFUvhniHCHUr+cyfAUuU6vWX5R3gyWUY9mu4bp47IZYSfAGWPGy2WfzeVhLF?=
 =?us-ascii?Q?Ug1HcXD9DCFsbNnqm/N283nk/DIdkTCpE6luJio24qqw+UgpaPTLGId1IOJN?=
 =?us-ascii?Q?PzNKrg9H5d7gzD7W0/aUd8oYxHDE0y6Ogo1pC5iG1/rOxgplRxuQGs21VRQT?=
 =?us-ascii?Q?//1v1M56q37TCvrd7Ztusni7EW/pnTs05wf886Vz9uUk81wAAHW8sz6NBD3i?=
 =?us-ascii?Q?8pzxHRuPe6Vh2UQZzigPMDxSUC4l6PLRU0ld2RBpGtpG6ZqQYGhP8MMBjdCp?=
 =?us-ascii?Q?ORbtaWWMRCv+kmdw9zTAQD8k2FHUXE5FBK1c/tFUKrrnZwGnHyOH5NVLx1wD?=
 =?us-ascii?Q?5N60qTibQBmKPu8EMSj90JvJYxfCVcuvq/UrkpELzSU4flGERC8BfpVmzkaB?=
 =?us-ascii?Q?Znb4dedfgDt9YTQbIbDtX5SASpZmtBgT7tYSl9d2Kja0f2AOrsbRtyvvEjjR?=
 =?us-ascii?Q?w3u7KqDII3fBqSHsAvm+IaXlelCX32GoXL/ni3elghWv9VxKKMpiEQkeKeRz?=
 =?us-ascii?Q?Lw8vHtCqa+TMrV4dql4GknF/fl7oCm/nTN29N/UlD5DK9Ph/00OGXcdeTIfN?=
 =?us-ascii?Q?b/0WT/uCKj53h2KGjy/8dRymVF87uDESISxAfxo2kmWsQUJVbIuB9K7da+TB?=
 =?us-ascii?Q?wAuFiMskV+EN/R5WEvXIrZQmd167QGoemgtZEbCv8BGZptZ09+5LJQVpG9o0?=
 =?us-ascii?Q?H4hSKhPQ0zxiussapJ5DD67BNO1RaS8RATuNW3qagjGQQnmeHSMbVhrF90y4?=
 =?us-ascii?Q?8PQqJEDYhvufpmfaaJMxXs0w0BT1X1g7odIBks0PZt5VzBlGL/khZEyuDndJ?=
 =?us-ascii?Q?POmx+8/gkr81+sgoBXAW5uRkbPHOI9cS7Zl8iHjX8iQrdfNI1ZITdaPLtZlZ?=
 =?us-ascii?Q?i5AynRDpqD5GZTwHviCGuVyjrOeyRM7JzT7pIsQ19J90N4bUiv+QZFwt+1Od?=
 =?us-ascii?Q?IAga9fISUwM9shHr6v2LEMjk1Y02UljGibushsOFSQUYtCiq9bnExhbssDBk?=
 =?us-ascii?Q?sS279yuzXvunXzmADjfdBzGaxPdaCqUl2dAaYmciT8tL1AoiYSGr0KgeIJkI?=
 =?us-ascii?Q?LXSXLZA2v/aLvRVE6ELW8KUZ/hzgSacjaUcbzEVLB/bV2NKzTtRCHQ/IwSmE?=
 =?us-ascii?Q?sOLzE5EemaJtY0wu+Q8bgjoH46SbKX9hw+KT2cqDMnJ3uLfO0efvUNCNn7Vh?=
 =?us-ascii?Q?X18HPVZ9rSisTmShBuddddjoyChJ7jQYYLcHZJFoMldGOkHs0S5jdMEmoP+7?=
 =?us-ascii?Q?OPySnJU+vEMot2DB+If8OlPG7QTIsmqwUJj2V/rdg5wxqln89wL+UUhmA4KU?=
 =?us-ascii?Q?rVxVNKj6Zg8qYe+rv59N83GvXzaUpoAGlFotNBPg2KoOUN94r6msZvrMNeWG?=
 =?us-ascii?Q?S2SzTXuM+w9Eq0F9h0khtPWTFUJdbeoC/NhZTaR07ABQGhQITyybT6/dNJgk?=
 =?us-ascii?Q?9eIB1t6G1Q8EC3/tVOhqG88k+tYN8Zg1PPumUxiw87/CMbE5AVJWLhdFd2X9?=
 =?us-ascii?Q?FzqkElM4j0UgCxuup6MQKsH/fTUyX37ODwJdbRSs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef6bc5e-e2d1-4ddb-e052-08ddde296703
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 07:32:36.2375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b3brzz+ULPcHNwBwWhD+e/i4fCdlq4P5DXbxRtdsMmo+sG6gT+jlalEZpHakMH3kDrqdknU0b78yUVew+2MRvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10533

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
 .../pci/controller/dwc/pcie-designware-host.c | 31 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b5012..20a7f827babbf 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1007,7 +1007,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -1024,15 +1024,26 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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


