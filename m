Return-Path: <linux-pci+bounces-17020-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 164429D090E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 06:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA013281388
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 05:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6BA513BACB;
	Mon, 18 Nov 2024 05:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="R/CMEPKX"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2074.outbound.protection.outlook.com [40.107.249.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1FE38B;
	Mon, 18 Nov 2024 05:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731908870; cv=fail; b=Aqjj6S0oxCiHxmH6lX/kYqgs+3IPnZBc1n89vLj4oNje20sKLhOZR6tA9DU4JfHeeKCX0hA2oO8xLudv7jqy6bMFupRDS2bM2MuqV/L8GePRc+nkTitZ0jEaNQeqcGR/RzTiEYPsV/3HKkilKTipfVlNmX5oNEt83KNmUv0vNEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731908870; c=relaxed/simple;
	bh=esGd/YrZfFQia4KG7070SaYTIBRAVHFyNIAIWxlX4BI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SFa4yTQBLRMEXcijbiC4+WIF8LaxKWAu45rbVdw/6VSgqGSazMzvxWsgVQy2Wg12E58CCYYNii2oj9FXFgZ3QIT7scVrnHIB85xDgbB4XiyEIFpBl7ndR1behbyvIO3abB/IxdgUzfVl6yaH3Q9cR3piwqLBzbDaZJ55RMkbW1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=R/CMEPKX; arc=fail smtp.client-ip=40.107.249.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m+/fGprP5lSFrpRGOcrn/c5M9xlKZttbaAzedaKs43i5Ttbwy33t5ElsO7Cl2P9YNO3SA+y6c52p5/7eZeSmSS8143ZUjQwk8udbUK64sFuK9SBmgDL/OdMbFOdemEi+mWgZ0q24Q+0UlYeibCQ0afYRkPeVJPMh0PHnTyqItIc0dPm1KBfjxnBh/uj2JTLW6uv/pvtU6h8jmgDAnD29FWg71ya6C8Cn88/biEo2g+InSMg4qareAkOfL+sJnQuHsWuTmzHvCciTioCdZRW5Zz/ffvg7pjFXAlmka3R2jUQDX3WF/shrpOlCbeQc7IBATbSz6lvRmROv9y0QwIQq5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VO5ivLl6SjZ06i6R3HOPhfsqzcosheOLbjxtxumDL/o=;
 b=uTzA0vIcNuy++e/TuFd3RXe4OQXwQsyAwofGwyZN4Qf9MLUlXW6glb0CIyjNmErMi+57rSlpsOFnz7u9pwq/YUpHKYxgxdS6fU8dFoy/a6w09GzUBWGsI3yX7tr+djVIcf+Z7op6QRCzWu6jNHv/a71Nb0dYb/o9tg2AM++UHR/EYbTzmiFbbHrlOrnlk7H9GKuYeIb+YHDSA9Jpg7XifBXiVYgSTZnM7uC//8tuSW8Q1ItW0tIlbhesFpLC6XGcuCFlPVJ8gNETmrMrKRxPbhQbJwluTtIhnYZZzWFkscJbAkGN8vSwhUHjIgnhVoYL9aKlBsZQASr7ewwv/D9wFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VO5ivLl6SjZ06i6R3HOPhfsqzcosheOLbjxtxumDL/o=;
 b=R/CMEPKXmnTCJOcKcANNkrc8G3trwEESmsGXIU5Ze02lbpQmMXaGCmbPL18VKL105YQxxSfGO6kQobXF3aJEp83uFz9W0lLLOpJlacKTb7Wg01PEPTssHFHgghrV/QUS3rSWthgGaXa+hkgJZmnUasrG894qeSgtj6z0wQcid6Py/Tl0z0YBSPVDPtq+plcE+eFj5cxbAFmPFeY3YajOlPWS/J/RiMHiIDCskifTgD2yFblXDJtIE+DimRVHXQe+fhz8oib8It/r6RFnlhEks1MSkby2aJjMi9os5zjs0OER4mlV54nM7OMeCq8U5q/4xkZtn+WjuFk9F/Y0QIkAlg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB11043.eurprd04.prod.outlook.com (2603:10a6:150:21c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Mon, 18 Nov
 2024 05:47:45 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%7]) with mapi id 15.20.8158.023; Mon, 18 Nov 2024
 05:47:44 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v3] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Mon, 18 Nov 2024 13:44:47 +0800
Message-Id: <20241118054447.2470345-1-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0013.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::25)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB11043:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ae446c4-1607-46ff-18d8-08dd0794862a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sbyxRtZHqprq0WvK8N2B90da5XSs6QSJ8yqY6XcGkWyXfxOjcCiM5csIGaY6?=
 =?us-ascii?Q?MtghqJUYcUcAZ58UXDsh80V0YhHbxZdSAIpqmq6DFmkAdAjJ2bhtrkZFenvR?=
 =?us-ascii?Q?8IyJQT9G/kSdiEMOb6oTRrdVWUuTYFvKXWPZjrNvBexOowX4QtjVZHxE1Z6e?=
 =?us-ascii?Q?ggbB2soR9CWRPOXm8eXDkhwCEMOGHizFaoo2fRz6o+hQ3ck9NBcwHA9TDeN5?=
 =?us-ascii?Q?CeoPMXUkfrQQF3NAD4PP6TZGzhOBvikf0xQ50D7iMSjqVE7FaEdE1g3gAIWM?=
 =?us-ascii?Q?GMLnfY3M3UyAsCTOWHNu0mPtFE0jZM0sM3ZgHZHQV5lfPHELxiMY4bO3MloG?=
 =?us-ascii?Q?0bNA0/N7qHBBkXWK1Q7GXtDJQeCoxx64kDqs4Lf50TsxJ+07Dz8xUcQvD4m5?=
 =?us-ascii?Q?HrHvs0DK2dDYbueI6bgfTGLu6+gXcxyJXG+MO+ztcwEZvBubrsjQL5wVKcQ7?=
 =?us-ascii?Q?HRhWd2+PJN+LCU07TWOTOuyVApZW3Sso3xeVlvCGcIOUqwvHCM3k9OLKYtEO?=
 =?us-ascii?Q?7vdV78boQKGF3QHa5BmRw+NjWcadbyfLv5gMSaKDkgArQiPy8b3UKH1VH/Ze?=
 =?us-ascii?Q?dFgeRkIh3fQgbQrh8zcxDOXm8d9yRIhSYomSJuVfVg6QTcA03YS3KC+DfREp?=
 =?us-ascii?Q?DkUSjzlkY4s8nOcLmM8dco1/B9gzDC1DTnsHu0muIF2KO66FlUDf6xLCgnAm?=
 =?us-ascii?Q?+jaa8/Xq88zwOdYfKjkc1F7OdLrPZjgtqWKJGu7dVIYr8kaw4uwxJBhuhBkC?=
 =?us-ascii?Q?nPc82nKJlVvjPKN0RgWGoIlQEpQscHIxvL/tRC7Js7zwX66uAlAOC09G5Ty7?=
 =?us-ascii?Q?lPwD0kyXtlx522YlV2AgrbFUC2gwZPfXGQkcGG8otxVIlx1jQuk6F8q8G8pu?=
 =?us-ascii?Q?QoYFcTnns6QHO/eSmQWhoKt8XFxnejyQoowRRCleWu2X4+6bbsQ1lyqO6wu4?=
 =?us-ascii?Q?OY4YizdVqGaoPQFTa+2Vi8cX6jJXFuYDD2j1e9h0tu+95r+jI5A6HZL6B9fF?=
 =?us-ascii?Q?/x0F1huw8MMUsQxw5E8fjApHteBhxR/8wiiN9WiXNEkoJBN0wnTfqvmQO58X?=
 =?us-ascii?Q?l3dnfFtGwUk+pz6We3A403bAo5XbGlFOKrjySXN4m5NvmPXIXHOx5x7EVfpn?=
 =?us-ascii?Q?2NA5CaLFsSsFHwyRox/65SkftCs5YWqeOFIWHzQTKXQ7ezMEHxGdnTfF+9JV?=
 =?us-ascii?Q?36mF55ZtTwzrFp/bzsOlpV/KlhOFM/YgjhcQzIyTS31rSQBg30LX8BkJVrxv?=
 =?us-ascii?Q?3dfyiZB61LkEEPCx9TEPAoEYHGA33NnFzSHvTzeIl8EM0liBNHd3ZYPT+Z7n?=
 =?us-ascii?Q?7snEz2B30exu/Qp3hyKbwjdsYekHgxFyHCHEGSXBhUP5Keuwl21FIMaT4xey?=
 =?us-ascii?Q?W1SbXc4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oBlh6lz+WqG79yvln+TObho2OjEPY6wEOpO6OogCA2awWTmTBdJHsFhRQTXB?=
 =?us-ascii?Q?MLRwxw0Smel5CEka5/HqVGmNiZBR+2yOLSdtxvIRu2QRvzmCzvd7iWSjKasI?=
 =?us-ascii?Q?antz3oQrgT4XqW5wsZoqhXmijg/xgfCOMPbnBd3w+mMQIn5RfINcwQVkQwcJ?=
 =?us-ascii?Q?L4EkcDlHFRuGEPOiL9DDatiiSYk1Or32mHgK2DECk/VLtaXgObVSNkc/wBFd?=
 =?us-ascii?Q?H5vjjTFBlCg4dLAaP61FzLGuuOd2Z+F/6Q9RRWxcIri7BjpGVdg1JGCc3M7g?=
 =?us-ascii?Q?v3zoXdSjd8FRC9xVrfORmXMu6b9Vf162Uai1s7OPL9VLdMe/BoE4tWXhq626?=
 =?us-ascii?Q?vVSWeXf9KNlStbcakNOrHs+FoygDPmOrYc7tikRsnnQQBkctKkEchwOwe/Gt?=
 =?us-ascii?Q?aqDlrVyiejVgQ2E6mGDV/M6FumMsrWTynAPs7TA+ciJfn3f3euNwalMXWNPE?=
 =?us-ascii?Q?km4ii2LBEZtOH8g3J7hO2WYa0nbZYHhbxhFJvrutfmTxkDJ8baVrMRUbgkhJ?=
 =?us-ascii?Q?XA31GC0f6xxHIZ/TmDyZjfL6Ho0LQ5+xX+LS+boPe3RltTCyT2RjAlAdm5Nd?=
 =?us-ascii?Q?hKsxnkroN46fgFQHlyudVEGQAR6+BFGiBag2X7jz57suPzVkjuqMh+WcSzv6?=
 =?us-ascii?Q?czudOY7upVTtzgNlbXdvkYniBH5d5tlGtfblmfzVxJwwR61deLhX8sxBUX5h?=
 =?us-ascii?Q?S+l5BHqIsk+uA2tHSbR3RR1K4X/oaGoAyz0cFc5um2BA9HQOljW4YiAdEea9?=
 =?us-ascii?Q?eDxrmSUH3qWX9Tmm/pxOqbbUz/JyRS6l0ewovBgGyXLzbUEXUZwXgKcnxLPV?=
 =?us-ascii?Q?Y/uwwdtsZrekUMqIj7mct/mqTc5FtuN/2GXHcOQJeOzsWPBr784lFgwNwICb?=
 =?us-ascii?Q?xgQJg0GaODlXYpBh4cD+jY/eWdytb5Uno0TBBZfk88W7wvRrr9ZFwBfEBu6p?=
 =?us-ascii?Q?XgrLIrCJFG3YBSFlllyTB5Xw8O+p/Zw2PEWUxP6+Q9xbmiN1fqJC+5Q9VHGh?=
 =?us-ascii?Q?9ZT5XBygR4zuUx+yNnO8wsmEEkKMfKbHdr9eQMQrQQ+5HK8HXLD+KKqCCMO8?=
 =?us-ascii?Q?VcVL3f8OAN8BNHYpA/l1cYf8XWqvmbO7+7/TUp8JbGu3SyyJCfj6iHrW1I+g?=
 =?us-ascii?Q?85U9AzQeaqwz3yaYt/tsoK0vJQTGnF1IM+SBb+WK+BsPTa5GXGhYvtqPGbG5?=
 =?us-ascii?Q?Gy9RtmjYLIc24R0IdjAbzpBFvwjEkVSYY60XBJrby6x6vUU0xmXQqjfRaipd?=
 =?us-ascii?Q?71slKPhHS5rD7rvvWSOURJsdojsXMvypfwDIYN1nRKAcr5idHKPA+PHUOSrz?=
 =?us-ascii?Q?Uwnh6GcYhrwZJbU1VpFCnSm+u1hKCt5bdiajlWI/Q0Mf978mGhhFN4G+Tqgt?=
 =?us-ascii?Q?V8k4LWsenoe55Y37U9oj4uw9b1iXTbVSyjhLbw059AIIWXk/ghTQorgowTLT?=
 =?us-ascii?Q?OynFspbS1GqWrdWA0HP3zgTR5Q3jENgfx5AZF7SnoeQQIei6QQLtPy5PfyuS?=
 =?us-ascii?Q?2BxBRTYzLhqaXEEm5BfjYuQ7yk0hYGDizXGm4TjTxGcQyra5dKLC1/rNQgaE?=
 =?us-ascii?Q?lkX4Zj1+W9YstuCcLaeSMPGW8IISJJk2xWnjuGn+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae446c4-1607-46ff-18d8-08dd0794862a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 05:47:44.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H2NSBPjy2ZFjjDdqfrVB7frYkZPyCiS5X/yXZ5yVXcz+nEBrv31XS6QbZPXmd9QpfSBRz5KH6+l4panpBH0t7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11043

Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM state before sending
PME_TURN_OFF message.

Only print the message when ltssm_stat is not in DETECT and POLL.
In the other words, there isn't an error message when no endpoint is
connected at all.

Also, when the endpoint is connected and PME_TURN_OFF is sent, do not return
error if the link doesn't enter L2. Just print a warning and continue with the
suspend as the link will be recovered in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
v3 changes:
- Refine the commit message refer to Manivannan's comments.
- Regarding Frank's comments, avoid 10ms wait when no link up.
v2 changes:
- Don't remove L2 poll check.
- Add one 1us delay after L2 entry.
- No error return when L2 entry is timeout
- Don't print message when no link up.
---
 .../pci/controller/dwc/pcie-designware-host.c | 40 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 24e89b66b772..68fbc16199e8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -927,24 +927,28 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	/* Only send out PME_TURN_OFF when PCIE link is up */
-	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
-		if (pci->pp.ops->pme_turn_off)
-			pci->pp.ops->pme_turn_off(&pci->pp);
-		else
-			ret = dw_pcie_pme_turn_off(pci);
-
-		if (ret)
-			return ret;
+	if (pci->pp.ops->pme_turn_off)
+		pci->pp.ops->pme_turn_off(&pci->pp);
+	else
+		ret = dw_pcie_pme_turn_off(pci);
+	if (ret)
+		return ret;
 
-		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-					PCIE_PME_TO_L2_TIMEOUT_US/10,
-					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-		if (ret) {
-			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-			return ret;
-		}
-	}
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+				val == DW_PCIE_LTSSM_L2_IDLE ||
+				val <= DW_PCIE_LTSSM_DETECT_WAIT,
+				PCIE_PME_TO_L2_TIMEOUT_US/10,
+				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+	if (ret && (val > DW_PCIE_LTSSM_DETECT_WAIT))
+		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
+		dev_warn(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+	else
+		/*
+		 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
+		 * 100ns after L2/L3 Ready before turning off refclock and
+		 * main power. It's harmless too when no endpoint connected.
+		 */
+		udelay(1);
 
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
@@ -952,7 +956,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..bf036e66717e 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -330,6 +330,7 @@ enum dw_pcie_ltssm {
 	/* Need to align with PCIE_PORT_DEBUG0 bits 0:5 */
 	DW_PCIE_LTSSM_DETECT_QUIET = 0x0,
 	DW_PCIE_LTSSM_DETECT_ACT = 0x1,
+	DW_PCIE_LTSSM_DETECT_WAIT = 0x6,
 	DW_PCIE_LTSSM_L0 = 0x11,
 	DW_PCIE_LTSSM_L2_IDLE = 0x15,
 
-- 
2.37.1


