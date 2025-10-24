Return-Path: <linux-pci+bounces-39229-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91CAC042FE
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 04:57:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BE603B7FAA
	for <lists+linux-pci@lfdr.de>; Fri, 24 Oct 2025 02:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CB92727E2;
	Fri, 24 Oct 2025 02:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="A+BbI2jo"
X-Original-To: linux-pci@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013041.outbound.protection.outlook.com [52.101.83.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258B2270576;
	Fri, 24 Oct 2025 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274630; cv=fail; b=H7EY+/WZtzIc8DJscHCOA/QevHS+n/wEADBYRSM5Aoq97xAm1InCcXFpEUXavWdlAvaNZ27vGb2UGlEDZHjsSZF2k4Sv4lDa3CerlFjXNoXrkHb/oaikkqjlnyZbcbPxaxRCd8CAXbeX/ES5E27hJ4XnWAawQuctKSbLHdW9iYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274630; c=relaxed/simple;
	bh=2OKZO9pE6kaub7uQYQFWn6aYrR1D2Pxa7NBCjDRXxi8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NvDixUAbfCIP2vCRYzVG4VtHFuL/kfwYnJ3IcXzTsIUwynK7rpwmeiR2oyO/eR39i8//0j8XaaOChh2tEyO0QG5dmKQ7m7tGHPXvwYlS3OGUP44VFGdQtPLG6+DcYU8wZTOlxQ8cwNIevNKXdZiL3GQx3FNd291WUdgnlf9hvX4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=A+BbI2jo; arc=fail smtp.client-ip=52.101.83.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qOIwBf0/HpLrTUMyO4vDJes1cGKRdk0XmBAIBoLD4LkvoGZt2gmLHFdmPk1iU6kyacZTzWywDdwoYIJRjOYTw/V7rK/arU/AsKMVDeYSzD2Z+fyqyhuHa86tv3hDAqjrk6psCcNnGKduft1PX+O1mVUNl9FTBo587M5akGkirZbMBVlhpj0g6ChTRTVyph2SsKyHEFNk16vDIuc1wmS7MbrvQ3/zy059yD4NZnKD+/gMqE8AoxeeC7re7fUIvKBnEiKq7nVFqmOOG7BDzH8Pcgiib+4FtfRNYMPhyS5s1zee/z1RVNE/wQUA3njtx/RvPTcX1ZFEdnpcYs3rkFco3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8XfkiLOsZ5L5eFiVv2br9yasfsx3d0hOOFgCd77+RAo=;
 b=preBFpIQhgTIOaomr87fwVPPIPiiqx1aXAqFQafaji/37EpQVSbfzmV7iEQuKjeye5ndt6utLe2HW8IDOp+H5JFyVISeE5oqGuBTDWoNNKaVimjgpAh4UuYVbnvMACpWMfZtDUAt9vmELqNjzoO5nDrlJS8FCHePE0NbcRoDKydMCs+dC1txWAOyGEjxZ204ljtYhMox9M/BNkm4O8zJYsZ6ELxijeah6g8Ij3h4XRLNUodJ7dk/oUwctekEZHru1kc1ye5YaO78zP2EfUsqEbq1wAhRvpQSjIA9XSfEBsnDD5DJU/zlIh7A9YFGN3alPzE0SO02erKYHA6P/+aoVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8XfkiLOsZ5L5eFiVv2br9yasfsx3d0hOOFgCd77+RAo=;
 b=A+BbI2joP9tSvOWxnbEx0snlGPMzXHTPiZuLXNo9lFnDMlY9bvg/Q8MwrTKzEVw7IefBFrI9zM+JRjGmzS8Cf0rfT8vQMepQLrSt7Jm6cbQ1iNYUw/gDf1ahNgV2+LhWKUcBKTND/DK+rQvnJJZuvbd5Y2d3xcnzTTTjrt00z4kwQ/x6p8bhYG/YMhEIaRONHrzEs06vwcnCmqEbZvjRQoQYtPUqYdSTtoPx49mtmMTw1iItVZL0ySZUIz7f2rvMC6FxaWgVOmtjXiinialFEzYS0IoU8PBzFTcnG9AnRiYoR4cZORkigIGcFtpZylMdfbrs7qB4HUtCEh4HPSQNfw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by FRWPR04MB11150.eurprd04.prod.outlook.com (2603:10a6:d10:173::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 02:57:05 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 02:57:05 +0000
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
	stable@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v7 2/3] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Fri, 24 Oct 2025 10:56:26 +0800
Message-Id: <20251024025627.787833-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20251024025627.787833-1-hongxing.zhu@nxp.com>
References: <20251024025627.787833-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0049.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::18) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|FRWPR04MB11150:EE_
X-MS-Office365-Filtering-Correlation-Id: 93e6b981-b5e8-4768-d042-08de12a903a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?76CWmTVLkV6xUNIgBdQFmJZCc/5CDXbSYPRfjsB4srhYSlMzLYELXMT0GdDe?=
 =?us-ascii?Q?S9iq0NoPKQ7hf8liinuo2aP9EqjcrMfD+4Spkm/QujRyXS7/3cjwqn5lLqM7?=
 =?us-ascii?Q?t0Y0WlbKqeX1Rv0kUks85kMYdve0HtixNAmKgfwFLqlDHgOw47ezsjbhj7Kg?=
 =?us-ascii?Q?Ugs49GnmekhnbIXAZ4loyPRQNVy9Qwx2ZeIzydSORyGLm0Ntc8n8rg0gpT3z?=
 =?us-ascii?Q?zKbhxt7gQOZPLQ33KZlOoh+zutHkNwCztW9ugnSOFRBGYQk2NBQgGrV/Z8FC?=
 =?us-ascii?Q?o2kfP9jbWW75Lm0anGm9Dyn5gdggzX5ftLnvEcG9c0s9J9+uItxkJ2m53Xck?=
 =?us-ascii?Q?OHHh4/HLkdVKKAVbgW/uJJ2wlqgz78AavwaoT/PL0pcTX9L8RVAl8bM3f48L?=
 =?us-ascii?Q?+7NY14JbtgIApedroa2C6Lg/s5AZNiPHXQR7GtpDsXmIG2g9ZjMlVDOzCr6M?=
 =?us-ascii?Q?QM5P9dUx2ilaEevqqOBgw4NSYhhUeqa+Sk/8y+Nn1H2D9+EgM9+3E2mTS3/w?=
 =?us-ascii?Q?EdXXyt7qDWIQyPxwtkVZctAbd+domgKYoWy087qzs4FDSzeJ4AlmJzCeG563?=
 =?us-ascii?Q?WNRlz/CMRn1si9q/jl4JwrXDVaBr/nRhLuvaPpyQL6V2Bj7CfM1MQUvr5+K8?=
 =?us-ascii?Q?dNcGqQFsvnAByFxqy4t0iW/N+WaBkAiQG4xQSML3erSphaulNDEHcswz9R79?=
 =?us-ascii?Q?NP6Dx/vl/vUp5u1XXcgvnWS7BKpOr0unRAT8W4n6HxO6nusmKvx4TNrK37Mi?=
 =?us-ascii?Q?yXdzklC6jaf7c9uovlHY999Th9RwCYoCSI0JuoZxeU0s3QmxlOCxZLxDKBQ6?=
 =?us-ascii?Q?Hp17/a57eLsyHsdZuCCPC8xOHSXh7PLSP6icaylkbcskDrYx3II0bcyX0QRC?=
 =?us-ascii?Q?9bpWADa1cLfDpVh8Q/FwrNHu+F85GfCwKuTDhnu26iltKnknxbBrfOmucp1Y?=
 =?us-ascii?Q?Y10pheR36aNSqKdodus1rcYmtUrmcni6t6lbJLNU19boDhMYfoQCTYyTwsV+?=
 =?us-ascii?Q?7gPBzmeTkU1UVqtstpMT2aJmLSeZPjgfIm0jOXCmgb5vcCCl4AY/lg40Anr5?=
 =?us-ascii?Q?mxhS5j1AlILhLys0J+MrkCFCAnrVmfWpXEf+qw+9clgJ9sk+ByprPN1KcDNv?=
 =?us-ascii?Q?cTJzIypQkg9wwYk4W/fMKAxuxZ+cpOnatEtramfYZ8w9amXoUFjbc/QIbLRL?=
 =?us-ascii?Q?wSYzW6Bj5aV5i6o5pJoanFEQ40Rl2om8GGFhrNUAAfcGReYvw5y4XITUm1WE?=
 =?us-ascii?Q?fqJ7y7UvI4hA/t9xDG2P7S0UptWfwEEjtT9D8l7XoOtbvK0gqoPa4ztLuO1T?=
 =?us-ascii?Q?pkUTpL/1op0ayMYra69Pi8mwzEiAkagmKB3jHF3HihuPK8tduutFeQXvSGHB?=
 =?us-ascii?Q?fyb25IewJfSYatiUq1wdK3IrvJOmOahcDXeD9kpjH635nT8IrMtE8oaSewlG?=
 =?us-ascii?Q?P4kK/5CuQW1JajHx+2/5PBh1RJq8ARu/9sK/JQ3v8WpVciAr3UOnc11+LhFK?=
 =?us-ascii?Q?JoXxAK6OBqliXoB7JqTn9I7orcmdlg+dDB+M2lSCeUZgkr6Knahzrkbnhg?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pUZHom/2jt6yFW6u7FEo7Zf7mYpwo+BIduHbpM+2bDyvTqm5ywrTJY43GvMy?=
 =?us-ascii?Q?CsjHiJZYiPXbdTbTm8BAwX9kIQtgw1QIsZxBzBrX3h/494rE7mc7xe1nnhlz?=
 =?us-ascii?Q?GrITL9rZaPqksr6mHZzf1OG/3IsuSqqM9ehcmWI549PblBX+r1MDTCVCbLxj?=
 =?us-ascii?Q?/QPVWPLk7MAjBeNpOo1t2bX7v4FsNy9LWG9Ca1K9h2+FcFw8Tb1UEnuLgCH1?=
 =?us-ascii?Q?k7N44C8f4kc58+GlTMOjTv5evfkBkw4Hr9haN3TfLqjOLdjUANm8wYYQVf0J?=
 =?us-ascii?Q?Hd+BySLnDNpGWOVbDjB0TZMe/wZPGonNdJ371YFdwRIZc9fqrOK/6T0P2e+k?=
 =?us-ascii?Q?VIrhLEXj3qYdv/g3VS0HKnx2wNV51GwZDmQt1bIJUCMWDflaEg7h1Bo7Zv8D?=
 =?us-ascii?Q?GsBUHMxUFXlUp21yU+O63IDHnt7ukP7qsghh6RdnPs3dCmw0qSsMRDma/vEi?=
 =?us-ascii?Q?JzkiZzdYOmVyU3dO8y71TZMdLyZ7k2J8l9H6SBrAiBbSQld6sXplBFa/Qmmm?=
 =?us-ascii?Q?RTp0HaefULin5iYAydkFEyU4/PqVOYf5LY4vCu4POAL9M0x6fs8Z+uQZYFVQ?=
 =?us-ascii?Q?gt6MXTy7Sskb1Iomgi5LVGfvpHM0efCRSleS1GmQqHlXZsHsSFhhpXx56dmk?=
 =?us-ascii?Q?TI/d1i5cpQ/DhnFe7iGvwlVKh2Da/S/kxMlV4G4AfGh8f1Pu/eFlTbUTGIcL?=
 =?us-ascii?Q?euAuX9BmbmWqLxC8lNcgNm8p18FqDMvVtOrntV2yrxURxi6bN3rG/AolKZZ8?=
 =?us-ascii?Q?f0Edkm5dKNhB3c0/T+RbF/VR/krwpVxhDZtYJW+KZVCyMWXZBW9gtB/gbicY?=
 =?us-ascii?Q?yqzHrQ+onV/yd4xH32PRQbjsLMLg0FdPpkqnZ/S9jZlTBF0nGzjddm0dpteZ?=
 =?us-ascii?Q?MTQacj9nCOePnikzInEGuo25ZGwUrZC6qJAm6EsKCswey1xae7MyUMwk2Ri9?=
 =?us-ascii?Q?cydD5MlYjd3FrQkC0j//yrA40yT8bIY8RIoVwJMNetPMYaCwDr/+TqkGXsVm?=
 =?us-ascii?Q?dWkYMrsh3VaqEfwy3wK2iNHUu8qmk8yRVX+WtC/ZUOu6FcXsifQCoYf+3upk?=
 =?us-ascii?Q?z3hbebw9GAm6Lja+vrtrQy+K1o1PyXR8kHSLatt7NMngYFpZgnFMO83KPnNh?=
 =?us-ascii?Q?hFLjk1jCAGz+7nQFGUm1HzArgX4Nikm876H0fXKS5w8K9MsGhYgEQM5KqC3x?=
 =?us-ascii?Q?4zv4NfDUhTHBDUrM5G8ydyliWFNB7vB2WPqekb3TcrHD9MrDUgK+KgwGVW2Y?=
 =?us-ascii?Q?8O1WTsgyYfZSbVVCGc3l6TRWYNJqNBW6A40ngaFRN5Tn4rd9aEV8jqSqZs0/?=
 =?us-ascii?Q?QDAbpRZlwiBDWMBOpMI7Me3ZK0vkZAiVA+3jKK4wdHUc5zvLTsYUXbQw2XP9?=
 =?us-ascii?Q?O131FY0RGrnaVwpJVtJKS3i0PuIIZDKijmrtBnkh17LWnpiH+UUVvAC6xU3+?=
 =?us-ascii?Q?Agh/nO0EY5uKtkKU8URpYCRn/tiD/LXFytqjZtYFolIvJZKVZZZXZjQ8GmdM?=
 =?us-ascii?Q?+N5Vtr5tgxO6Kdq3w/e0tTBT9IhE1TEzg+t+JH5MrNLldD1mAXSNiz12Aago?=
 =?us-ascii?Q?ZhwnpBq19ZJM5CHCDeOF9J4n6C9wWhCpq34DGV9T?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e6b981-b5e8-4768-d042-08de12a903a0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 02:57:05.4582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lV29j+coriutlLpK9lsBvzIL+u++XzEqBSfS/2TeAqjTEjKEQuleJ5DPN+NuBJXHiGoyyYABIeZHB1aHe5BocQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRWPR04MB11150

A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME
message and no devices are connected on the port.

To work aroud such kind of issue, skip PME_Turn_Off message if there is
no endpoint connected.

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 09b50a5ce19bb..a4d9838bc33f0 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1136,12 +1136,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (pci->pp.ops->pme_turn_off) {
-		pci->pp.ops->pme_turn_off(&pci->pp);
-	} else {
-		ret = dw_pcie_pme_turn_off(pci);
-		if (ret)
-			return ret;
+	/* Skip PME_Turn_Off message if there is no endpoint connected */
+	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_WAIT) {
+		if (pci->pp.ops->pme_turn_off) {
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		} else {
+			ret = dw_pcie_pme_turn_off(pci);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
-- 
2.37.1


