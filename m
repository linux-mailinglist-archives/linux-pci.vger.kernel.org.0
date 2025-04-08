Return-Path: <linux-pci+bounces-25475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C21A7F54E
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 08:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 746631896717
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 06:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D0925FA3B;
	Tue,  8 Apr 2025 06:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kEgeRYAt"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2051.outbound.protection.outlook.com [40.107.22.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1AF925FA0C;
	Tue,  8 Apr 2025 06:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095252; cv=fail; b=ti4mfTT0g7d926W0de2HyCHgbChCGvEFNAc17hxseVOn2gYvmVezkGKLE8ZNn2YPYU79wsyXbNMLfQ7B6sHNuwAwBPW3bD68XLuH8f6pOVv7APvwHIpEip64iLMzvY/2AWmSAKqwEOior72P3N8ro8wAp587phfSqlkH+fTYBpQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095252; c=relaxed/simple;
	bh=SHAr4bIwn+J23k9fat11TBH6bHpoHxVyszgcPPG3QAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CEkybFQDCydlzVkHI1yp6DleTmeP52EfthMcc8TGB/sDUdHJDEvhxU8Ryg5i4HgGT/+cH9LbkBLmdfynJwlDLJlCujbG7i7q3709yifcJGMU6Kkay78hMBOvh2rjqa08b0LWSt8ojgWEGcgiXkZ/uMJ551v+WISa+eYyPsLNwe8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kEgeRYAt; arc=fail smtp.client-ip=40.107.22.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLnpQuKqkm0WS7VS0xbC6IY284cjFSLmz8xYfpEZSW22IJvMdWM/9qIy4HXatsc8d5DnGtb594Loi4SLJIVSGVgSdiaqBW14o9DFlLjLwsVoHC/DjJKmazA5RqbSv2RL5e4i3BdDsIqOV7jX4/X40kCLAtE7bOCwWg/Uj7dhclKDmNrzgLVLrFRuoJG7JuW7SpAFLsIjpXT38NwXqbwa4LtqPXiSUGFBVD36WpXR3y7rBCIx/VmaX2zo+hY1Nx4MsJL+0hubuafWw+6rnoziPWYwfXPe37JphrYYc8Erdsj7mxPc6Y2//5AMpBdEFlhKohBybTicf/oQYZVuI+uvsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ByoIsS0Y9gejDZtYsfbxMCXFnVvtOHb7zUuz/KDdnBU=;
 b=pNqhRxP3+FSDzdDfH5+Wu33un5CzrUB4Qnn0EV9JKpIFNxJJT6lmBmRV3Ybzxg10JDXSdskEjynjUG7LjNAWOJg5vmJksJftAGo42MBr+5wsLSw7Ufp4uGboDx98kd6hDQkLkC2be2FehBatkFGmX/grNalqFPZ09bC0Bsuq0bhb044s5lsbIyc5N92iSQUxWoY6wK/X5vaME9FgAQrg4q3ceBRSYOS00ZwmCDGM4YxEIPynk9VfUZgurhSrdgCYA9XRzAerMf7ecGD6Hr1OvzCMUnwJoGO1KG0r+N2ajIXVKeLnjs24R9EFKvCMJkXAsggCUF2LNWTaqOAR50+wyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ByoIsS0Y9gejDZtYsfbxMCXFnVvtOHb7zUuz/KDdnBU=;
 b=kEgeRYAt4ocvccUXgxku0lZb6cPof49UKN1Vg3P4Tmpdo2+zfeH1mB/h7wCg3AJqYfRxOJc7/mQrN3ybNEZI4bg4wpcMFzExLLVBMdap/B3PomUrTtnwdakZReAngCoPGT907IErRhNJwrfEBjV/poS66ayyUZCTJ6z8IKQzoO9xoawv8Kw1v8Gkjv+WPapsUI0vtoltEMswr9vlQ+fVDJDeWKZ8dmWn3h1RxCYXOtqviIP7rpzqXbNz0tI9ojmVOSDpB0R2UvAbr5oI5Jf+9wTORzLcopDfWmSUANTrqPjQxicOWSZySJXMUbPAAc7Nsz5pnFQeSUJpQWZ7qwwSuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS4PR04MB9458.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 06:54:08 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:54:07 +0000
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
Subject: [PATCH v1 2/4] PCI: dwc: Add quirk to fix hang issue when send out PME_Turn_Off Msg TLP
Date: Tue,  8 Apr 2025 14:52:19 +0800
Message-Id: <20250408065221.1941928-3-hongxing.zhu@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|AS4PR04MB9458:EE_
X-MS-Office365-Filtering-Correlation-Id: 644a54d4-cb5f-4a64-52f6-08dd766a2878
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SV6AeXgHjafYcRr4cIfQd3yWQyHe+Z6Lkg2L4LkGc8+EpPL2WNxk4LMo+npp?=
 =?us-ascii?Q?lw41/jFrCqkYwEOruGBnx3qZoH2b+bcelvbnJEtkrXq79eAjgp1wxCaK80NJ?=
 =?us-ascii?Q?IhnVlJGSARqG4taosC7sM5c5qPt+McQrWYd1/gyCgR/DTBqY6XekYa2RmW4A?=
 =?us-ascii?Q?tvm+AmvrI5ESyZDFTsEjU1FzCmJ1YnCCnbva8ZPlkscU19glA8PG4gN5CXZp?=
 =?us-ascii?Q?P5qp96Mzu6l9mhdU9pymY9LMS/s2NsL69/gg5SkCh6PKb4pA34clcJgG5Qoa?=
 =?us-ascii?Q?+JwS9f8DSaD100TRWa2k8yLPGdIqHjE8LXSWEVpyh/ZXPSWwQ+M/XoPmymq/?=
 =?us-ascii?Q?rJVefiMaDu/ZF93itfbumE4v4HIRt4e+GlezZR8fmLUSB+Mk7rYIr56/rUqL?=
 =?us-ascii?Q?I9VmP+5sAJS4zK0BgtGeEGFXCopTIegUCGsSapJ4BMyQ3fmy4j8Mev22kFA7?=
 =?us-ascii?Q?Fmv9snmg+UDIJMZk8l8w5S46kKRH73gf2qgPc7592m6xJ6/i1k2vD+YOGD/f?=
 =?us-ascii?Q?IqUpIkpYEFkwa0HsKdn3lP5hgRu/MyFAobe+AAKBLZeB+zzSfFtwlSGs0G/s?=
 =?us-ascii?Q?0OuqBWPWeknP/WnI3IY7rVUd10uBzn88Vlx1s7yTt0H49xR/OH6b4MUkf3sT?=
 =?us-ascii?Q?xgsFqaPFDnwFFIThyOUBVKO04XFu2d+7hKOgxmuweCiyUnVQsNnhUoWloxgo?=
 =?us-ascii?Q?5vH+D24aCHLpUJT9cFicg6ZiIfE9hQ/70fP/K5pP2+Ckg2OlXmi0o5EsaTny?=
 =?us-ascii?Q?BEb04xbKyqWdHD59kq0WYpJChYHpb9Gxj67ARSK+psYlra8OauCJn+V+wnJN?=
 =?us-ascii?Q?pq9+M7Yr+Uhz3xJIt76sYTZt+0+2Ex8kQZG/5J4vg2Z43bpJdEcPmOZyQadG?=
 =?us-ascii?Q?zTwJzh7RB5+CHarozITuBZyKrYvTFlDAMfK4dpGS5RjCFAm6lLyms+tY89LI?=
 =?us-ascii?Q?6YJxJtAr/3zgoDyRRyxLyXIMLBnplUJcRVWJV4o1IrOlWRywDpFf869HQHBx?=
 =?us-ascii?Q?1y/f7DZMN5vI/u7cyAiV+4KIj3vnBv6nJTxerWvY4wOCCZA8NbIkmZ+/A1w1?=
 =?us-ascii?Q?uQUKKD/kPuDhIQNffA/UMr2+NVLzwPPiNHMRjZKf/fJizNS14G3/HiRwl8Ut?=
 =?us-ascii?Q?jJ62Rn3JegO2yMa3xkLducdcAE/nJHgv9CRlVwiLPV9I85k4gITwPf2MMKzk?=
 =?us-ascii?Q?GQmjOpj7YBMrytTFcTUH5+m883WV69HwL2sxEgyFd5JmQzBZv62jzUMxPKcJ?=
 =?us-ascii?Q?B0Om1nnHc9mZRLfa3OhJBmI9Ha2quURad/drUQXs+44nSHeZiYG5UPjNPVCr?=
 =?us-ascii?Q?rSe9zZKXK6NCcyhFxLooDYmiDLUzwvobQhLz1t2jVcn1PhVHoH9IcTMIDBlt?=
 =?us-ascii?Q?O9E7ICmuM8XFTcERmjigxriU9D3j9Bds9NftmomcEYIizQa5yVNswrTzN2+P?=
 =?us-ascii?Q?RjnheKZfI3fQBkNfg4qq30jOgWnZ7Gt0Gd0XlneRd/WJU/sAqOrufw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RjjZyw8YxxyzVpWhSKKSELLpTFWEWbTg7CNJB1VdHjZBKSEgMQGYvNWWDmAi?=
 =?us-ascii?Q?TK4P8/asVqbqT8Mof7bnOF8hsYSfcYpdQKDT17eLCLEXBxr/yF0TAnR/39Uz?=
 =?us-ascii?Q?0H+1ERRccKzuzJUZmJVCvDibuggS6YFIRtUk0M3nzjcNJFzc2EvQ/QqH6W+B?=
 =?us-ascii?Q?H0R01Ko9wuxn1gIov1WH1Z2RQVq1SCYxBVWOi0UQfCt3/Rq7NKg/nc9PrK73?=
 =?us-ascii?Q?ccXDHdg/+CYIsNfZOQMDSXgK58gPiu109NbW7pSWyPnVa7tVC2SIL+xtpzNm?=
 =?us-ascii?Q?C3a7L2xPXO2UKz1fu2TGT9tYyy8F893OLQFpOwU97A3gP8+1WXvbmJ20c/Z8?=
 =?us-ascii?Q?wFQuis+4Nsw3TCHpSUH5zUdmNoGYTmAD8ojrMmstlvWXa5p/mgZYrxT24N9d?=
 =?us-ascii?Q?BaYROGWvYd/iGbCxzNAsXSR9ggqmlBQnVzuPgIa4rOBKHhqDZndbAhW92QqY?=
 =?us-ascii?Q?ahayg42DhVm1WDLbiuWOakGsI2Yq2ezhqzYEN7nk0yr0A2RaBhDCF0ECq+6k?=
 =?us-ascii?Q?ZjIXBBsl0mDOJVFFMjI1XBLhncnkgmgKPoiM1xbBA1jA6aXC5pWftr77Nbug?=
 =?us-ascii?Q?rYt4iRcABZYwIdzzX4WyrEaTPstOfV19ie6uccjRGuRqb3lzP+IGSDsRDm1O?=
 =?us-ascii?Q?+Xaz9c8eraHqrHKYqPp2wZAolm4X3gWC1QjU+4qQYw16Jb8o3bszixYRhvRS?=
 =?us-ascii?Q?0Mlz25KdOJEQ8vr4nNR/TRQIo3yBXkX2JwObmj1Na6yyxnKH+1SC6XYaK0+y?=
 =?us-ascii?Q?0gUqCuXCyLbM8yM+inxdcNqK3oixblFsz3wckSZ282F+j6bccwkiinRqGAVR?=
 =?us-ascii?Q?jvF4mva05Gv58AvAnwv69OlSwwhkhiNmkkVNtp2Uw0uL9d1Ji9AGdnBSqCL/?=
 =?us-ascii?Q?MMEh8numX8J403DpCOvm+lI16Tx63uNWAlmRRVq4N2gCFfGchiGTYmKVtyo+?=
 =?us-ascii?Q?F0SHg+Ms7xjOWnaRJb4kCj2Jn4iKhJIunR3pkp0hrXGbt5b1AdBoP7ctsprG?=
 =?us-ascii?Q?53arlPigT1o09r5MhAV31JYr9JOPhPyArlXdkX+D4usHVc2PZwW1XQniS4YF?=
 =?us-ascii?Q?df42PA+QmD0cadnsYZffNR/od67V/fDs8geWDMJcKbfqx6EsM4uvQN1GKGIq?=
 =?us-ascii?Q?d7pZ5dnbV2Euk1dCEkIMWOCxcKEQUPg47kAXiskycYoqWq8IVxFHPlpcIvJ4?=
 =?us-ascii?Q?s9pU7/5NNlyNAJkL3+1ALCDg2Q3KebaxL3g8GbEQdQDpbs0A+Bj5TimyTJar?=
 =?us-ascii?Q?34pv7WlTtdOOT/8X2D/glb0hlq0BycmvQU2s/NCW2kUmbIwhvcoDOuqZWJk3?=
 =?us-ascii?Q?/METnc1JdM2ofvdRfHVlmntNLDaiKfkN6sWgO1Fu/xI1VnrE2YqGBYxJNk82?=
 =?us-ascii?Q?pwi2zJQOf/kcTO8gTosb4KDCJ6l85Zg3mYUaFfw6ZJXQCqU5TgI51i3w16b2?=
 =?us-ascii?Q?CYwg0ty2kmVG3JMDyrOqTucYFXHTuJsm3TuplUO4bWxpr+6EHI7/mMcL1xZm?=
 =?us-ascii?Q?Mwa7rtF5CmJ/+sHpA/zjygBPy41fLqjLSOVRN4pis1n//Fp/ZR4UXr0+ThKs?=
 =?us-ascii?Q?as7ICWVVOu0XG/Oq59W3KcAAxjhd9N53QHdkMEBd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644a54d4-cb5f-4a64-52f6-08dd766a2878
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:54:07.6319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VpOyPiNlLPyzouwlN7aHaL7u33fRawvqWEfN/n0443HEPITOWicHHAaqxduX7LCZDcyzhH6ygeinjjuVHoCwmA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9458

When no endpoint is connected on i.MX7D PCIe, chip would be freeze when do
the dummy write in dw_pcie_pme_turn_off() to issue a PME_Turn_Off Msg TLP.

Add one quirk to issue the PME_Turn_Off only when link is up to avoid
this problem on the PME_Turn_Off handshake broken platform, for example
the i.MX7D.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c    | 16 +++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h     |  1 +
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 0817df5b8a59..a62bf7e0ade8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -956,12 +956,18 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (pci->pp.ops->pme_turn_off) {
-		pci->pp.ops->pme_turn_off(&pci->pp);
+	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_WAIT &&
+	    dwc_check_quirk(pci, QUIRK_NOLINK_NOPME)) {
+		/* Don't send the PME_TURN_OFF when link is down. */
+		;
 	} else {
-		ret = dw_pcie_pme_turn_off(pci);
-		if (ret)
-			return ret;
+		if (pci->pp.ops->pme_turn_off) {
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		} else {
+			ret = dw_pcie_pme_turn_off(pci);
+			if (ret)
+				return ret;
+		}
 	}
 
 	if (!dwc_check_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 05fe654d7761..d752af660e95 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -283,6 +283,7 @@
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
 #define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define QUIRK_NOLINK_NOPME		BIT(1)
 #define dwc_check_quirk(pci, val)	(pci->quirk_flag & val)
 
 struct dw_pcie;
-- 
2.37.1


