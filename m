Return-Path: <linux-pci+bounces-30173-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0C9AE018C
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 11:17:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFED03B1734
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jun 2025 09:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0793F265CC9;
	Thu, 19 Jun 2025 09:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="gvoUfQGg"
X-Original-To: linux-pci@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011071.outbound.protection.outlook.com [52.101.65.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BE7266561;
	Thu, 19 Jun 2025 09:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750324481; cv=fail; b=OxyyteqLcvsB09Jqrl0cBhGGMFBXEPf3f+YtW/yCPx9od/fICzyO3/pDjY9QfcB+L7rDvk0F8+Z+8De2V6idb3zKIonK8tJQDN0eme2IV7hz3H+UpaL94rlfE5348d2bBNg60cn7+k7yI8rCCyGnlTNyl1RMfk6DGyIQw9wSYcg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750324481; c=relaxed/simple;
	bh=349IMquuBDTUZ6JRzTwuWFvqwrah1mkQJmElSRHo/Co=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mokIoRskZ6zsyaMHhvuF1lQX2d5mOuZZyd75GNY/ZVcErP78tlo+9jktAsv6rTd0IWlBdd8Rwd+jkBE3ZnFrB6xps4saUlXFdc4YScfHDefIPXrwZrD+1Q0VTEJ4GjvxYlRut+PgXaM4uiMtUwyRT2zvxNrIUYCXCeb6ZviNjws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=gvoUfQGg; arc=fail smtp.client-ip=52.101.65.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bIcQUd/IDfdbXq2QaRqe3GrLwJdbtKWK6FuS5vyk2Jx6Nuh1DkXyiJWDAT2rVy6qZ4W7WZzgteXnkDJCUd/3Lfp+WS2vF6tsJBIeVaoK+p8dAUR1hX9UscAkkjOuz6YOhklZi4t3VWKivQem2TtRNhb0HREFT3DD5YmH3csSjJ5ayIt0UAZcL4YvRbsyratZNYjipurMuSmdQt1HC/dxp+NPvCWPCbUKk0a0JkzVxBZKsDMcaZWv8A+M/0PMm/z26hEoILN7Qy7INhrcYmIAsBxleG+xyMDAsGsWvux29yVJe7KyV0kLFu5tbKhJbhJwkQ0PgftUVvxOXKSW0LCz+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IEivKNtFlk/z/CZDzEYkg3wFfThFQY800PDqGR+3CDc=;
 b=osca451eQcVaX+WR/l5G/kt+NfLkiF0VF2HEi2daPg+uoUe4fcp3ZMBF6WgmkWxGKkWyxTVlv04h9icj1W2HgQXd8JDs1UbvXUNZSDGb6OpDsMi3ZQH5M2hQ+hGf8TpZFarM9S3nbjzKDLI15pH05kQTTgFsuLYTTyOvhRVey+OlxeXNy+3SaIab6qSIxLqr6+E/2xBPTurji0uQ0pOf2Jkml7fxt7G5eSrVMuRz73FhSM/F0yec80JRf8byKRQGXASo8b1jSAl5rrh8r7P5npW5mj1tcOL7HMPwxuYJPvwCT+ibkVMmFwQ0TW7z/n9eHd3LUM0cnkxRGjcAtXPurA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IEivKNtFlk/z/CZDzEYkg3wFfThFQY800PDqGR+3CDc=;
 b=gvoUfQGgh/GqILHvdeKfKgSh3RpVCg4sI1EgHo7S1O5MTatEyKke5cLKDnTjWkLkLIs4EV8PjUtmvNMi4nPeDQkdgLBAQ+Tu+Qe7p1IeQULpFgJa8n14biedx7Al4utDgrhuIVIgIXaJ0JCEyM2dOD6m8epmKWbkT5tZgVU0j/d83JrQqyQoVYTqbT/zjURq1H5Tai1GWzDA3905NYji2YbCXcM+nbmBEnvOmlcr05kJSbQ3F2EhWCkoJhQMtqrWR2SII0LjqN92Nzlg+NXFrStm1rnCgOUWh1awziKgZKY8u+ph0mYhsO3xKo3Ac+Dqr7XML8V5X0xopAvpHfgKag==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by VI1PR04MB7021.eurprd04.prod.outlook.com (2603:10a6:800:127::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.21; Thu, 19 Jun
 2025 09:14:36 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8857.020; Thu, 19 Jun 2025
 09:14:36 +0000
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
Subject: [PATCH v3 4/5] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Thu, 19 Jun 2025 17:12:13 +0800
Message-Id: <20250619091214.400222-5-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250619091214.400222-1-hongxing.zhu@nxp.com>
References: <20250619091214.400222-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::22)
 To AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|VI1PR04MB7021:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d437405-485f-4de3-7ec3-08ddaf11b62d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F+B8inOdT5v8+qe4ShjnQ+Z6RvzYac/VXbpcBAcjEMSskN4HuLDYw7WGosi4?=
 =?us-ascii?Q?viruqmWl5iA9uO67YY+v9sXIGSvJcJ9waBZa2KHlC9vaEmhQMG5ktS101a0n?=
 =?us-ascii?Q?9Ztdy28YYStWivlRoyxebljH2i6gNjKbyGse/ZqqMlJl+QAXixCrLC0o3/XB?=
 =?us-ascii?Q?bmdePRbe4GzFU2oAiD8y3sd0XGsBu0r73kxgPSm9dicPP7PXoEBY2SpmC+rj?=
 =?us-ascii?Q?UFrHRyiEAWu1Dn7lkOoxEEf8JXg4SCRUL4+3Pd0kp6e7FVK0vSzsLgjwL/eg?=
 =?us-ascii?Q?VE5yo5qlTN1os5gDMvin98zChNA4Me5jj6FwjXwL/hD4OrUJaooZJOA/OakD?=
 =?us-ascii?Q?rRo3e2dtf7xP/rTuliio4FF3snngRYRjjON3P1e3ypYuP/z3wQ1rS+ZYbjR1?=
 =?us-ascii?Q?iLX4q7Y+AVMScFDvtsQ5A8lqSBf6n9uRFLFizvyu+5qbKuO2YZ9BLMOLqihd?=
 =?us-ascii?Q?iShIuv1Ik+iVDJAGu1KidApAX3U7V2m6QbCarPY6ocvXZVstzwj8A3blrcNh?=
 =?us-ascii?Q?kskMyYHV3Kyv6C0pYMKH5UX9+EoZ1wvKh/hGV0/vrw29UJV6dIzFbmRGndzB?=
 =?us-ascii?Q?k606qHjpOodR+JQbu7ZzvlG0NcUwj7v9uDpJ7KTE7NCn+K90arCjmn88Dlx0?=
 =?us-ascii?Q?X4gnV1mfiPOJqCzYqigX2jctB09EOf43jHWZLHCJq2BYirE06NO9rtPvRgv+?=
 =?us-ascii?Q?RNm8kP1c+VV71R9aDU1rpSlocShvDAAI6bm/n0KPqJ/H6Ps43dxlrWQj/fug?=
 =?us-ascii?Q?8Vbo1NaGHCzXyzTmapNkxiiMl6fWy2GlsECJHA+S9bEm+x5HY+BXAVUhHRgz?=
 =?us-ascii?Q?q9itgp5My6H45xOiHsjFKKt7FtgIDGrMJ74J4RXX7/rPURjc8zsMwHlTR8bd?=
 =?us-ascii?Q?pGk34PTana/WdkmCSq1ws+s+w2Fmdoha6x3EMOo72AGu4HML1PsDlQy4TNmZ?=
 =?us-ascii?Q?1eQp3Wqh8DoxWKG3tfdImxH3PkRQu2UYbwrFR3NJH1PZhRhne4qhngIlMEkG?=
 =?us-ascii?Q?RB78f609ZMNy1UHOGJYJlFTNg47nSzOC/KO5Fg0/5GzZXBKtrk9VzC6ZcVvL?=
 =?us-ascii?Q?is8PAUv2oYSnQc6QDFuR8HU2yR9UtIfoJuMLRL6xMCHVnP/mPFCumVN0GXYG?=
 =?us-ascii?Q?90kVqf3Ri0nEsMXBfreiek/locHneAWKsW2DJD9BGUjX6QgVP6pTizUg6zZ1?=
 =?us-ascii?Q?OzHch4pywEjgELuzAAFPYsWTs0ymNiBAGTBntV+VWujEL0be/RtjDlnK13Pp?=
 =?us-ascii?Q?l6ZU10PdLDzu+wufEKJ86GmZj31LKke5xAGXzLT18YKExrExY0aIuc/2x4y5?=
 =?us-ascii?Q?6WUSGNY/kCwpyOeal/JPFKasIqqQj5GQJPBcqhrY/lpufuxI2bRARl3F6280?=
 =?us-ascii?Q?NemJN0mKGSj2Dhlske7lqSGtMAE4t3T8Z+kwlbT2RX3ka8uQNCnaev+ZNhQ4?=
 =?us-ascii?Q?/rE55/Q3KvQcyn5yHGrxWwwvNnHzAJSJzhGbWGvql9JmmVUsnEY4eIbqDWbn?=
 =?us-ascii?Q?YCi6W+BENpH/Pso=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(52116014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?goJayZzOC6FkShyO5WtH/UZWAuwPVukZIsLJ5t+OCeKhBrg9mu4oQzjVPA1K?=
 =?us-ascii?Q?5WHjHOj74dCiWzKffAIIQ4YkXEZH96vzjH3lEr18VxpfPwUHqP280CZEBMWV?=
 =?us-ascii?Q?IiYIR4JJcl1qNEi5e6Mq+pEehRVB39Oxhr53genfKIvF6zDV6On4oWJk04x3?=
 =?us-ascii?Q?BYH83YoDJSKwGC2r4W6+9ejOZSHIokdg/C/bVU2CID755My0dSfwXadSQRT3?=
 =?us-ascii?Q?xNmz/a0LzlCaS99OR2+J9aBp2k30+tdjHrXbu8cBq0IO40G50zJpb5orYmrF?=
 =?us-ascii?Q?e+JuInje327dHa2DXH5mTODp87EaYqS+6fb6JhYo1ieAdBraFHbzkyiR9Ci5?=
 =?us-ascii?Q?oXBcoID+LZZrw8jwsy5HbJArxLm54g/UGab/LTQkFLcDA5jliNmtjhncuqXP?=
 =?us-ascii?Q?c3zTH+leui/BFEZkizQfQTbs67p0HNiLuRaTR3/GZ/6kPmJoT2U/xdgsugUz?=
 =?us-ascii?Q?B4kPz7JncLTdj3WbXX//2//b3ETDzYaQkd0kTqos/6UVc0Se9zX3CxPL+DVs?=
 =?us-ascii?Q?+dN6CIRWPhL36ecL7XjwpxnvnEst8bL+qy6Wuk/zF1f9dl1mspSa/lXonw+e?=
 =?us-ascii?Q?gb91zF9YlVsnPYw7yEFGSls5jf8a7uxZDPjJdG3ZzSum5i/FzIqsOtemAHRw?=
 =?us-ascii?Q?0a74y0BGPXFLkUcZhh9JClhXjgFodELkT+J1qRQlfjDDeMot8MTCpFjILVla?=
 =?us-ascii?Q?rGI0VP1mNbWXtzVL3njM3yRVMTXFqxo/UFOey8Z1nLGXMhyATJXmHPrJrP2j?=
 =?us-ascii?Q?HOt1zXhvXms+PNl5QursD7APRfHku/XWIvXDu9JC/LDrMIcIEBoCM1SjxMWH?=
 =?us-ascii?Q?CSx+lZeP/KDxBgKd3IC9NM/NXRmiMdC1Tce19p1NzUNVwIqHiUb3vZaqZNjX?=
 =?us-ascii?Q?q5EpysZ24HwkNNbUptobyhMr9E7P4pnDcTa0oL/HfdU5RhiUvJbvnNEoBI0Y?=
 =?us-ascii?Q?U5T9bFU6nIWto89GMYnxOUf2KBiY/iK6kF3XZMk4V9JBp85d0hoYBM+eC5OH?=
 =?us-ascii?Q?7mi9IpdrUgI3gZ10dDeCn677TyxDoKBZ5/r9c7zDo+dTTuTFnO9Gghel6/sx?=
 =?us-ascii?Q?jWH82nemnxq1699UYVbhL+HxTy2w9GkBXFqPSU+WIj3k/Y8ZKZE2OqhM+AeT?=
 =?us-ascii?Q?pTAsc/XO65LH5AXmEna1gPGCyvKgQnzS7gikC5+39205enfHN+5J8YR4eyDt?=
 =?us-ascii?Q?+xFPyBTtB7YCMLG9CexNM4W5FQJqpr9riMcViabE4YX1CTp9D9mz2Dmn3Zzf?=
 =?us-ascii?Q?kecoiNEff/hSbbEdXmQYvxIBB5X7zoUU+Co3PoCvw4u2fk656r2pi5cr/VWA?=
 =?us-ascii?Q?p9lXspRnc6y5lbtZGs8avjYbqLlnLy65m8MXrq5q8gQFurk2dSBecRR1oEVq?=
 =?us-ascii?Q?IwF/TqEXTf6JtEcsU+9HDTBUdAAhDq6Fm4giEs4lihzuAH8LT6RflHg7UP+m?=
 =?us-ascii?Q?i7AMZrYrI9T2rOISHY5za1k9Mj0EHHctKhiursBE4/qAWVdGadnnEOa+Of1J?=
 =?us-ascii?Q?UMHuEntLCttMyj7SoSSwN7tNnKvSe0k/5XubhRA18OzJ5fGGLLl8KR1tXfyt?=
 =?us-ascii?Q?z3fXiVWyh2vI7Y1ppEPnxxP6HKXYaBB/1qBVER/t?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d437405-485f-4de3-7ec3-08ddaf11b62d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 09:14:36.5282
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5wpD4nI9J2iT65++ceZC8nH8a9HGnMtWyYdmVJdyE1CdGc8J43MraRFCsNwOK7Cjtm1TaH8G6qmDi9YjmoihQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7021

Skip PME_Turn_Off message if there is no endpoint connected.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 2d58a3eb94a1..228484e3ea4a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1035,12 +1035,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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


