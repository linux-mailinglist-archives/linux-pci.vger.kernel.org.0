Return-Path: <linux-pci+bounces-25474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F998A7F54D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 08:54:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0165A3B279D
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 06:54:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F180207DE6;
	Tue,  8 Apr 2025 06:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="TVT9JYoR"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2059.outbound.protection.outlook.com [40.107.20.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3329C25FA1F;
	Tue,  8 Apr 2025 06:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095248; cv=fail; b=HvgtbsGzqntoUPgB4hMKG6085K0pdS4AzzsBilotiBoczQgYjRnaR17c5iDTwbXCYdcatiVEG4CQD8W81yNTUIHDbqIepCKkCKnxSt1Et9QRXIl++OSfWnf42o3JmmpHHSdEDormDrdGaZ2Z61zrwE6PvY+nPDRFL2UbXpj98fY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095248; c=relaxed/simple;
	bh=yNJ4lQmpsaPwLdfaFQqCC9/uQq1ieJmnY2c0pW5v6iI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MPgIYaS5ADuxESe7v+BRHTkWy9CLnU3o1z/Q1eRYkS+UtdIYEeC9SedYRQGalJtTfKUreX6ttOJ8DAObPpNuwIRovaLleedT6TWCOSJGcuEQDmh7iSJ6w/7ZG7dO0Efc9AOmVoT59pQoyWOOVJYwQAINv/Ecc9tVJDfkST0FSHc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=TVT9JYoR; arc=fail smtp.client-ip=40.107.20.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jcvMmcYB4kpBXvx1VGtLdsNglsOSZePEaZsctFmZ/HiA6AcKLKdmNCgBSGHxcNwWyT1Lrjgke4bGkvAHCbFc7Kf8in0RI0pSLZ3ymuINGiP6CHxEMciXme91ehbYCLqmSW23CwUyhxT2V0ucqEe635YPaWLNIZMKFbN+lLT23ns4VOi37EJ+3irkXery8t0uVJOQaEEKzggnoeENdiTVUf+cj3EjqiDSLkZ2zTPlZPEdF2aUsGt0wRg38lWLWEV3dTnA578mq4/crXKdBX7iWfKi41TNXlU9ROsgsM33bl0k0LPg6juIP3ox4TvQah+p4zKJjyFTVXGsNguBhHAXPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LwBzwADTuI+Olw5Y2HdB2HKD14Pf3MTlzMEhGDwYaYQ=;
 b=lLTetPWrpY6hT85wkDuDdRkpzSfLjg9qYhNcqbCX7mSP9DwoD/45Pqh8Uod4qACZ9PZ7QecFn6hZ3N6zb8grcBV+FVedyxJea6e9uslDX6+/7qQROM7zA8fxf/XL3OWJJJ1nT2Og+LjvuEVgvRI/AVOMbxCA4WgSdBkhT4pHK4oIplzrcqDNlKe04KlOkaYTSb1yUOvYd6+0sgjv565+Q7Lm8Pg4WOfpu660P/Yk6zRC6I6VPDR26DT9J/wIMfSyeXRbluo0y4KvKs7pRVGmdHDgHTsmEXvwrL+Wt2pJpsHwj9umB5AL49XIKILeJAzKk+qCaCoPIbJTLMtM78iPnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LwBzwADTuI+Olw5Y2HdB2HKD14Pf3MTlzMEhGDwYaYQ=;
 b=TVT9JYoRkB+j4/x7ZwN61IspBlb5Grn73iRt2LSypJb3nhRe1eW9rC6wJ3S/OxwdW122sa0t4eBDMAS8o0YkifLmVG7Z3ca+xQi7+sFgz9LfSyrksiBYpkgF2AvOuaJdMVwt261qpLWouag/mlVgx/93kNUNvgROuZkR4IFh3jUriLiyjRlR3XyCwi780wR671BBkMqQeIi3PVihDuu8twdMF1nEmnCoPQtscZwCGydYvfcz0DpffH8o/lwhfOoQXSD1pcevarSnstfokbo0qnczYoplx98tRe9CZETlk6wljp6bRaP8PxIEzeNptkP8Ea8O9g52CBDZjp7oMH1SVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS8PR04MB8309.eurprd04.prod.outlook.com (2603:10a6:20b:3fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:54:02 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:54:02 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
	frank.li@nxp.com,
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
Subject: [PATCH v1 1/4] PCI: dwc: Add quirk to fix hang issue in L2 poll of suspend
Date: Tue,  8 Apr 2025 14:52:18 +0800
Message-Id: <20250408065221.1941928-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250408065221.1941928-1-hongxing.zhu@nxp.com>
References: <20250408065221.1941928-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0001.apcprd02.prod.outlook.com
 (2603:1096:4:194::10) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS8PR04MB8309:EE_
X-MS-Office365-Filtering-Correlation-Id: 977d658a-922c-4262-ea82-08dd766a2571
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2Jks64jvv/vs5RWlb14ieHTVH7dXap4GfybKe2R7X1+LNU36GJpCN/RQ2XZC?=
 =?us-ascii?Q?dpIi6joMxUFGUQYibhS4zdXGja371O1GJRaXY6PSMoofru3HPHFCwVHi6O0t?=
 =?us-ascii?Q?QDyZj0aLaEd6u9tZsNhO4FaEQFGdFQgSam9ZwXRIY4Gd9btpkbdFoLibKXnR?=
 =?us-ascii?Q?nsFAtiCghsxGPNwn+m5dwQJlPmckz7gk4Mi71qkmMgWeFhY5aIR1mLK6uEL6?=
 =?us-ascii?Q?d46IeH+N+dYLlqHpni/hEpBVBN+jCmuen61wnpeTitsVwUQ4k/WlIvMRnVBq?=
 =?us-ascii?Q?8DMz7Gnc26VUJYEQr0NkbDnp2YGsGvMrHX34zNThNAsPDtMGLbfz1jl2gsH0?=
 =?us-ascii?Q?EUYDe1VFZzaizkPcnhR0ZceK1ERPadCRKuMb+ayhyho5P6ALad3UvBfIqpmE?=
 =?us-ascii?Q?7yv/lxF2q/4LkP5zpAPQUDOGzAs8Td1cLvDn1Fbpqq1+8cIgKZqxcV+mFVqa?=
 =?us-ascii?Q?DFSTmV6MzFkzz6AJQD46lbPu6gCQH1WDy8j4NsxlSLkL0bMzjJ+EZNzLfwH2?=
 =?us-ascii?Q?B5J65j5N2crnPR/bO11kM862EQ8zpXqOCVweAkcNyaQ/wNKE0DuBbHzax/WK?=
 =?us-ascii?Q?IsGuBvBTUd26gsh3LglFdz4N/2NiObdvuMh+Zw4TLointHQ7CWfQlJRGIw5G?=
 =?us-ascii?Q?/jiZlpKRVS6M9KheT0iqoSoRZkkSQi/f9LTM7iSQbzlWtgIMEAZlHuXY4FXu?=
 =?us-ascii?Q?OULm8E2mh9MbtY+YjG0BRJFgjAAsPd4+uFDK5Nn7C9q4YhpDerHjOmmYpRsi?=
 =?us-ascii?Q?ddfg8HaWKS2OjqeTamWXdGuURvTTFB6wCaBfZVJB/ttqLe/QYrTpHij6oMP6?=
 =?us-ascii?Q?GIC9Vr+zzU4okE5KzlctO7tH6LwvKtCITzkyGOp7IMrhuQG72F35I+OgiPaP?=
 =?us-ascii?Q?CDx+3S+hwheJGeiySyzn8ap46xPdPlkRw9VNoxvHehAtbnIwtx9fqiz5PlUW?=
 =?us-ascii?Q?HbNlijMAymb242V12KKCmVTRwdV2zvOv76G7KVfqk30OPldlhO6dpUuwvG50?=
 =?us-ascii?Q?XiC8WFdSKHXDJjxVqFO/ZO7q8y42/ssLwN20qjuSe6Hi1NumgvFadTQ/vW3q?=
 =?us-ascii?Q?BuF3UjS0vBOKm76dk/5DINO0W+zUrurSHrrVuT0N0FgY8mF0MC3mOuythxLg?=
 =?us-ascii?Q?DeUS8jjmVPrtYaVz28tgEFKBkHKuImE4Caelo/X7DTxDzHtetY3zNgbF3f7Q?=
 =?us-ascii?Q?0q11orGjigz7kwORKDh393nrbvihbQV+G6mSyKSAgzjXJ6gi/9Z4PofHroBn?=
 =?us-ascii?Q?myOncndp1Y343XppwhJ2B2gDfDiejeN1H+oQs61Eevv9DjljXev/MB9wQAUS?=
 =?us-ascii?Q?EopgiljnHAr9rDRLw2wY3TXDjN4rtlkDboH7mbgzoG9V3QnEGeTtyNkgJoJR?=
 =?us-ascii?Q?Xi8V+6FJyufOU8XOk+4GYVqgrWocGWJc30lZ2rgOnR4gm1+7LVKYzIrHkJa8?=
 =?us-ascii?Q?Fo4oBUjBuLyR8PB7+WuusCrdakwUM5OAY+av2dDQcOtFLR2/if6A8Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t+mqnFuRk9bUWTXPk4FlQThhZIqbisTeEz01HUWoUuHn2QR8PsgiIT9XowaB?=
 =?us-ascii?Q?rlk4m1ErU7YlK9GQs7xQxVAfCKFQkjkhhRRWQAno6MqFTPD9jOFgL+Pqcbko?=
 =?us-ascii?Q?Cj4lnfDPHI6+yGkQeezY2af/GHjxuG6ziuZ0nFRfY4nKtY2U8njaM6Rqq3is?=
 =?us-ascii?Q?9mnJgHwJEnxybpTh3M+jYqsAYs3JwxzG3clm7k0LzfpYgK4RZm3Ag/6Vtnnf?=
 =?us-ascii?Q?xlTTITR8uUxAqR2Tyv60uuZz+xSyEkZV2r6TaSUJjI+IppalL38yXt55tHNs?=
 =?us-ascii?Q?DyKQqiriPh3lfRPlMUwCPznxWfJvp4mjvL7kQP72xyfx+GssjB7H4a7HJOiM?=
 =?us-ascii?Q?pi3StmUxCp4tj4U1xWn/ybusTSZfQcNcPixxBUmooPY7n+Enpq/5nDCbMDz7?=
 =?us-ascii?Q?cgAy1KXFkX3aP7CAR0H0TSCq7hOIe/B0L8okl6tK9y6jbkDH/cy9N76kbHsx?=
 =?us-ascii?Q?7vNgnbBKHfefOqHcuLr8wcyvZPKa+UGh4LgX0g6RsXLB52E2Ty1NNqbCfApK?=
 =?us-ascii?Q?TeZBiWiITZSo1nOmmYkb4G6UxXaUoEhaDagMFl+X3l0Bua3PBlgrl0yT4zJl?=
 =?us-ascii?Q?bfqWHQGuyLz6/tmkn1VGaw2kSwcuN45LALsjeHfVjuiNMJArjJy3mQ/Q34C/?=
 =?us-ascii?Q?k5i2PS+/IvgDpIJr/g7JbyJ5It6uIprDqSBnD39Ghqmg6tZbPvdgmi+lgBQ1?=
 =?us-ascii?Q?rk+iAyHz9y8knvJx8TSQ8wBSSrabcGJ/d/ZrvbtRcAeNwZAU/BU0/3tsY5Cc?=
 =?us-ascii?Q?0FgaLL19SK8eihlbrpYI9MdLu9xlcSwfqRs15Kq6eG2V64ZNC0f0MEZVG/EQ?=
 =?us-ascii?Q?iXvRHt12H/nIudqiNj/cJ5cNoqxE/q8v1ZjRZIqshzXJJTaEhr8bJU3kfDhm?=
 =?us-ascii?Q?AuQ7luK9K7cKf9QxHZDDikM1FI2iCQytRcjXIOlpAtTBbd4h9B599vlpAzRu?=
 =?us-ascii?Q?Fi7Cqh5k7BsJvl8z2kRXcdPDZOCZ+6KVVTNjHn9D5Sx4rnhESRiVjeY3G1f8?=
 =?us-ascii?Q?zoK2k8j88wPHKSRUuY3aGmcLu9HKqDFBdbrNG5c1R4sjJuuUP6Y6IqJ8fPFR?=
 =?us-ascii?Q?WZAQqF3Ng5WmxcVayaof+1Nh+AxgYOds7uYbdfx7pAUCUCSxnb/BOLjVw2B5?=
 =?us-ascii?Q?wrB+BsP8A9/TPMdRoTEszRgJfvXT8Rjd0IfbA061K55+jje3OZr2AxZS5eAf?=
 =?us-ascii?Q?/REv+ntsjchXzojx3NPBSW51osdaqSo4HYz0g8+Ui9c9Jf2loxw0HXhf4lTY?=
 =?us-ascii?Q?SbJv4tcJSuDAFQNIZN395Ztl+rNWdqiEA7+RU6LPxW147grukvb49avfISkR?=
 =?us-ascii?Q?u+M1dnI1up6tQMidZZL08bBp+AHnnuFQEnhuSq8T6WgVIYLQR5TiCsO57Ilt?=
 =?us-ascii?Q?CpBunTpELSyjM5HWPi5UK8k/wcZ3rwIh7nRiMwKRPTXvu/+iW6Fs2Vj8umuR?=
 =?us-ascii?Q?JOzI55SmbmOGzS4tubQh1AY1RrA9f519mMmMH66UQiakJvKE71b+75fcDvCZ?=
 =?us-ascii?Q?Q9de0HmrncpBmMhhIQJtFGpbzqzrtijQWEAFUridheveI6Zs94EF5EwAHd27?=
 =?us-ascii?Q?jKSIaetU1LHzdJA2kzHnupltUPsBUac8v18ZvMjA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 977d658a-922c-4262-ea82-08dd766a2571
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:54:02.6116
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zzDsKHZDzPK3trymnieXkoeCmxxojwbYN+nLvsqZJbUvCYc6lKnd3p34ynfIUZwTXtt4LimqJ+3Jjlkp6dkwQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8309

i.MX6QP PCIe is hang in L2 poll during suspend when one endpoint device is
connected, for example the Intel e1000e network card.

Refer to Figure5-1 Link Power Management State Flow Diagram of PCI
Express Base Spec Rev6.0. L0 can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whatever the ltssm state is in L2 or L3 on
some PME_Turn_Off handshake broken platforms.

To fix this issue, add one quirk to remove the L2 entry poll and let
dw_pcie_suspend_noirq() proceed directly after PME_Turn_Off is sent out.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 22 ++++++++++---------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 ++++
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ecc33f6789e3..0817df5b8a59 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -947,7 +947,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -964,15 +964,17 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
+	if (!dwc_check_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
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
index 56aafdbcdaca..05fe654d7761 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -282,6 +282,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_check_quirk(pci, val)	(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -491,6 +494,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


