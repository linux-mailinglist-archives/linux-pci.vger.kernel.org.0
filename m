Return-Path: <linux-pci+bounces-35308-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F39B3F77C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 10:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78CDA17E21B
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 08:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3535D1E260D;
	Tue,  2 Sep 2025 08:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ha8G2P3S"
X-Original-To: linux-pci@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013044.outbound.protection.outlook.com [52.101.72.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079C02E8E05;
	Tue,  2 Sep 2025 08:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756800188; cv=fail; b=skGeyWt6k91Cxswwz9MQcImJnKOI8zvwfYahz0XxtQ+h/M3yLUdfLFC9HsnWQZdc0kCuXEmWdK66BUI1j84kM/QY8WnMUvJvpo9Nr7cUmIB7IuYlTDeHQFBGkjUOsBo3KB4cBPcg0fMJWId8D37R3Ycka8ZXCLlffQwqWh2gQfs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756800188; c=relaxed/simple;
	bh=MhFFU97MNIa8qO0ASMTxSRz0s+r3c9CS5OWkbuQlJXo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=orIkc8vAKGBnSLYo8yqayod0iLP/gpRB6XJBKqGX5ZQ1cjsgs4vwrdETSHeg3uBhj82wwaTuV33EPPm4i3yZKCwhvGS2LZ5JV0xQNRQMZw2ph0NEkyDg9/0dGv0ANhxmVxYvypRcht3xhjHyqBFElqY9Oir8Y9Nyj30/b50ozY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ha8G2P3S; arc=fail smtp.client-ip=52.101.72.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fp6R3OPZCPRc5XQGwH5TYyped2mNaDYw9rtSudJdk9qfKHjpojgUxALMwOOGZxcvmBNhDlNbAS9lHNbfO+uf5XBfAMy9em840Iw+d5LRGYlT/H2KlAnWP6lLfqLmN8ImAJMCAu5NhSaGoNoqr3NBRacrfKOB5OxXJW44j3uqL64coXlhhi4/IFNi1dpUR1Bhtzxp73GkTawsc0fJfFHXOSL9leY4FUS+McWMSif/2p4zH6Bl5uBQzrinTN6FXNgrLAg/xg0Ihq9maxvZWOyo6iYuszjYUckeprB/hlO1ViUwuIsEVOPDr0MbIqH9RoxuPuDkRRGhpfB905j+TfT/Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VSpOjUnKar2LyU4DfBMDTW/5eUemxGIXZU0pMTZZaHk=;
 b=Td2jMnHophBahYBCwvmsf3KvLQpzuG+UrVk81fdqgFrX8syL7Ku1/SxZ7hfobulnUpD8LkrdZ0JJDdP4yOaFpW00Pw+r34wufVzNxVcKo1aUVNkUrnp16SOUfBZbL8c6fJNzzPV+Sx+4HiBwFPr52RarGGwgyUqWQNIEs3meWC+N5i33hw9V5kcCn2NRvmPQoIDB4Hed+lx+pBApxlCancXRPFH8FuEfS9ErqWfbkCd6qNwWcew1Ev8UQL22VZyAoUFDCfEI2WxZRG1b+yOsEdGEYaT9+uuVM9KgeNZX5wH2Li20yCSfTkQ25u0Rj1CLJN+rZr0YwwIOFCDn5CFjJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VSpOjUnKar2LyU4DfBMDTW/5eUemxGIXZU0pMTZZaHk=;
 b=Ha8G2P3SFA9RjPHWhJ7i1hzYqpPTUkzcGMcp1u1b/3WSgBth/50+FbJhubUFkTTWIDe/vAQrFLUr3jYzDhqNcslra7YG4Yo0I9pt9SugSK9PDlbB9lfMwL5wU9Qiaq4BxqN57tQWSjgl01ANPtV/wCCUpYImgUJxWTkmMCGzqX4Lk8byxDBw24Mr19cYUxpimsE8Lm/p1dq/xC91GYoT3d8NlpiFqJ/DT8R4nxAobsfEFxEkZgTe4KCYoSSEzjjkosgDwqOZVcx6TqlAhNpFuAHwRAXGTudKkU2iWTQ1tGmI6B4ahgfRvu/Q/KwEfyjsaV/+L45sBwFVJnXd+xP1oA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7725.eurprd04.prod.outlook.com (2603:10a6:102:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 08:03:00 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9094.015; Tue, 2 Sep 2025
 08:03:00 +0000
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
Subject: [PATCH v5 5/6] PCI: dwc: Skip PME_Turn_Off message if there is no endpoint connected
Date: Tue,  2 Sep 2025 16:01:50 +0800
Message-Id: <20250902080151.3748965-6-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0087.apcprd03.prod.outlook.com
 (2603:1096:4:7c::15) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7725:EE_
X-MS-Office365-Filtering-Correlation-Id: edddb617-5307-4b79-bdea-08dde9f7223a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|1800799024|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fR8bHPiaWPa0C0uIaH45izERS9g8CLsCbKcR8C39hWp7e0FDOBCQfF5xIhQ3?=
 =?us-ascii?Q?izWKBpj8vUsdYxF6tq2RDdeSGFXGGGeHmQxB0guAE33C6QVW0NRlOC6eImdG?=
 =?us-ascii?Q?CENN/UvwOGpV7jv/n8iKJGTHcelHTVAuLSw+ZCOKqPD8afi/q7RnbKEjCPRA?=
 =?us-ascii?Q?TqsLlLrBMsJ4GW06zVjphM4+HZUrtiPYJgA2TH3CoehAYOcqqKqFKvLAGS2p?=
 =?us-ascii?Q?zZCtwAOwfObLFrYHmAaLNDjr7UaYO0LV2y9eOtjLjG6OiKWZch1+B/W+zyR6?=
 =?us-ascii?Q?0awvJmpEX3Ny+hquiVbbiR+0yzvyeB/hx6kv4kGo1FEIPZAJ55hVS6jbjT12?=
 =?us-ascii?Q?nqu4ZG4/olQoJ+/PqA47zqxW3j8Xt8yOyCkj7NqVAnFlwNU9VCZ8BUqcDmi/?=
 =?us-ascii?Q?qvKnMqe3yGnGQcTCt3gUSQ7RpJ3vHCcxifRI8aIBMakx/752+pZS5+te4aD2?=
 =?us-ascii?Q?s2l80XRXsBX1a7Yo2KzZiG233UfxunojvYCIoGu/1wJzFi0iYN9YFWQw3023?=
 =?us-ascii?Q?/j8DzNVwNKA5xmwrBEkESpQu/seh0s/MWypCg4NdOLwBNp9DwbW3kAMDXB8r?=
 =?us-ascii?Q?a6WfPDrh4cuH4ny5cZYAse+qwzvsLz4CGZXtvoZvIeSQ6cG4dLyXwtDQGj3L?=
 =?us-ascii?Q?1pPa776CMIxCS57XovforngUmurgezJ13f94p60p3lmCskKBAwDusG9/82s2?=
 =?us-ascii?Q?A0p5gN2/FBVkLcXkY5DMGIMJ8PJutyc9FvC3gslavDhznxMUMu5OVGhTx7YW?=
 =?us-ascii?Q?p0qa9CZbDuoIqSUle3s4Hu7Kx+k4/Q/uIZG/7NyalBVSJNGoGvP64OxY+iOy?=
 =?us-ascii?Q?cH2ebSymDSGBEt5QGfF+VJpowYMyqUrpbAC3QYzm5Mmn0KyJYJy/I35CFGfd?=
 =?us-ascii?Q?HAWvrqlUw/CQdCkAUGtq9+tZo7scsLbyqd4/Ql0R/n8ghJc/UoL8IaH0jP2f?=
 =?us-ascii?Q?2NJfEvpf7N7DfhX3FfjTcOuYuLuwE1DeenJResRUPudmy5xe0ZnJJ4aMdBFm?=
 =?us-ascii?Q?q1f0rzlwHBwjX39gx4LsbJwkZr8SuX262EDlvpdIbVPU2zEcWt06XwIwR87A?=
 =?us-ascii?Q?Xy92EYhOgCbN2IWnDO0KvwlhR0mg369fQMsUVoCSMUkXGfB9E51LEfnwEOjb?=
 =?us-ascii?Q?Zv4qDnoBO0YYWt57qxRMrU4ahy3Fv2vDl99nPBUFYnqoJcITByDjpJTfp7AP?=
 =?us-ascii?Q?Y65OoyZEggYy4FMST0LQwcQuC8jfVMTXqy0d3MXWPrIXszVcpnbacosZuTvM?=
 =?us-ascii?Q?gCcnWJ6f+EYDtmyHJgtTtBZB+r684vjZzW+Y2ucanE+iUu9QMJ7vgN2RX/sb?=
 =?us-ascii?Q?1uNusgOtwCKqHjyGVzCv6cfimGsQeUUAmPnPa/+rLUHiViDz9RpMqGKQIqg1?=
 =?us-ascii?Q?zpBz4SiwYjbLzjvbpID4GfkdzXEpkijYaoW5C4VMIoJPHSjFKIk3oNY2eNEz?=
 =?us-ascii?Q?YAU+j6I3/lV98XSG7kIMZVxozshcq6ZiGBQ/92ir0tx+4JYiFhneZ/h8u2L0?=
 =?us-ascii?Q?I/ESuxZ7LVEE24U=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mkty06aKKAug+Oj6yID2GFOZR/n5DjOJPA2JQNs8O1+qNBTOXGr3QHIihyB+?=
 =?us-ascii?Q?rvfXqO95h8PS1ZlqC6BdmX8EEoLtS2H71LOMEmFsOVD7rODHwI1JR7b6S4WN?=
 =?us-ascii?Q?I7XfIuMN0pYRd3mhTq+A0GOLVqIOv9V3j70ZtpydIloGQtHU/gSpYSuGInDo?=
 =?us-ascii?Q?Fh5iPGTdJ0Mvamm4sJs2DcQtq+pegL12MdX6liAphKsKuy98O9rO3GeSMV6n?=
 =?us-ascii?Q?mEN8ASa60hv+UuYzLUgpoxey6LCNGu7MNm7uxHlIaELpMBdx3k8Fq1MkMpG5?=
 =?us-ascii?Q?Z5VH/Vqz/nCc0+QoZHxBPe2ONeVhPlfzbyecPDCemgTakw7Igxq7pxy32nNt?=
 =?us-ascii?Q?PHMpyvHM07rzpt2Ca18eIKSpxMJk2uBYwqswIrBs2wEX1N6uPZbMB8tAB5Qa?=
 =?us-ascii?Q?4OhZOZOX0VnIuX+bWaUpuVSRZpiXkKNOhSDgoM6jI7wSiYnCERyxJT/1PEpz?=
 =?us-ascii?Q?psT7UkZOJJL1qpvqygKze4P3pLlgOS0gd5d6t4V8k1devOO8OWAynf5QSCvM?=
 =?us-ascii?Q?Sc0+1ByYX5bpKcx6hfZb+/C5ItYESWHBaIJecqIMVlhXQAgBJ51lqCQCKip6?=
 =?us-ascii?Q?HaJ2iDR133qnrGG3lI9rduwAIZH+pVu4Tz8ST0u1NnkllxP2gk82ebiwRD5e?=
 =?us-ascii?Q?an5xNIKHwe/ThAG/P2lbCQ1oWNF5nykl/B41R2tX0nqrFpYYLpLQ4nHgMSsF?=
 =?us-ascii?Q?Lfri4JVFNLWTGMcp0DFuTMHusdpiWOTtrJb5Gz1d4jT5IQM+HwwB9D78JVzv?=
 =?us-ascii?Q?R6QV79WX6EuUGpfZXxTFKIP5UT4r2irhGgtbhzrIN0MdnBWIGH+TR1Tfy3LT?=
 =?us-ascii?Q?CnLfz88vVUwIZ5ouUHeqn9ab/g9yIFPAf8FIwsEwUnvOjBbe7tSda41TIu2B?=
 =?us-ascii?Q?akaWQ3k7GI8/Dm3vRy7IT3a2R3pfRjj0BmmCv29C3EP9W8kugIKO3GVpP/N6?=
 =?us-ascii?Q?ZycG7532H4SL2hZYJI5/BYJ1mLOJ2nhna/AX+Am5jgf+YvantZdD/YwNSIhU?=
 =?us-ascii?Q?ZhQ9u5pduPydGsJgejvbsDhKxaksfygAAJ9VzHuldxY+qfeYqA9JsEJXRkkz?=
 =?us-ascii?Q?MQ7wANnDp/+dQT8rlY0SRdAJmmJY8Bseonmm/CL01elcflToYvBEcPk5TttQ?=
 =?us-ascii?Q?91ICgi5bgeC9qyNv7GIldpt8gcmdT+iFdWFHHvz6SlJ+7d04+9vAqr2QQ7E2?=
 =?us-ascii?Q?Q+oFypsmcA/f/SuLzer81qgerlHIc9UsZyWIj7GzXu+QFBNDvN7ISUvRaSuF?=
 =?us-ascii?Q?hc4d+Zb0l6qWd6y/derffhg8Ha/fOLBSmcSHw4W+gNIvOwUFvdEGI9pnRL4q?=
 =?us-ascii?Q?VYXW0/HsHctS02vcvrU3x2UpqUzh7+cdg839ZtAfsNR5oYo9Q454tCMtJpnQ?=
 =?us-ascii?Q?cG6QO9YpWQq8PGHT2VrPcUdWvsvv7DVY+GlosowfyZnfd8jM9Ydgyu/cFt0d?=
 =?us-ascii?Q?XvQKnBryNtZaDZcIDRAeufqDgYj9V4jyL2z0a3Plr5onuD/7utiXDRhWPwaZ?=
 =?us-ascii?Q?rmFDjqnSPNhSuTkzc6TJYP5/5XtxYjjRnur4qW4Sd1IonljhlezLWQJD4Ovf?=
 =?us-ascii?Q?STR0iGyUSTvvnMMsskaxdFa405RJfMmClKM5PjE3?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edddb617-5307-4b79-bdea-08dde9f7223a
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 08:03:00.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R9mv8P34B3wdWwxAnOVbEU/qMJWmNFBE3mG3hRr/U5v/ztyeVIKhZDPc7j95b7OYRxNIsEcWVIWqFpo40VJeaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7725

A chip freeze is observed on i.MX7D when PCIe RC kicks off the PM_PME
message and no any devices are connected on the port.

To workaroud such kind of issue, skip PME_Turn_Off message if there is
no endpoint connected.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 57a1ba08c427..b303a74b0fd7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1008,12 +1008,15 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	u32 val;
 	int ret;
 
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


