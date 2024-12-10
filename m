Return-Path: <linux-pci+bounces-17994-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7233B9EAA67
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:17:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 370A4168F2D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:17:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2B0122F387;
	Tue, 10 Dec 2024 08:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IHtP/VqL"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40FA23099F;
	Tue, 10 Dec 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818612; cv=fail; b=tuFpBpiIURFdfMsjXr0AzqG/hSG4MFCWKXDi1UbgzhkeEprTVToLOJhcecXftMRGALnZa8bKN2z2IFyXdiAZh1IwDVsLKdQqTKSjRrTUKAVhqDy2ACV9kHMgyi5AWuaEEa/fhsNJrXVx4G+SwpC8UHVZfFrj2yqIGFrg1xixUpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818612; c=relaxed/simple;
	bh=AUpzlMmNcn/9p54YDb2KBpfPSJXgKNU5FsqWyfb9SmQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JCQJRdG1C1G/VVJivDc7Pjx/CeNJCAV6pm+oLFRv5B6LuUrbdrcFM4YDLWjaoKxtANIArz4tCJtmZveVAwG9ROu3HR/DZqlK/1rCDuQKLMLhb9NcP6mrS+/3CQAHj+ty61xB5vHryqfBGpYqrAFzDg/eLexGwY061QNSpB4eRzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IHtP/VqL; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ahW2pXeZXwwmnwW98FwkUr0E0qcyuiJ2MT5SJA5H159JXw36EB12nEr4dJY4jK8z080IMSjSPVeELzh3ztOq8ckYU1fiaqCBEIOn+JHQqYc8UO+R0/8+ABFkAM0wFfGKdH6J/GrMoXwtyxlb6Gp0xe7+IGp0pqlTkyZ6VHYnWTs0yvuZ6T5O17KlS3Y1ZnHBFNJfP3fLyjM3sgBlWPWA3SmIJa/ZnmP2qu20QSfNLht/ojJ4jR16e3thFAnCX/zN5RSHicvLSqQQ5fGWNKLy9z3mMSdJSAs1Rd7Pqw8Yshz6sAVgfLnFUHJt1sZwrlkaJQDEysGz1EmUVfigi8Ftaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o66Y5mKiXileIcWu4vfHTgpzvmYZZDvoWEzjioPl/nM=;
 b=lYHCo6TFwEPCI9v9eLGmyCpuReNEH0jfKhmtYK6oBuh7h7nsW9bmksWLWEp2wY/gCTtCHVzyffDstOur1GmkbIxa6QgKpvoR8wriHP5gBdPfNCi/F4HZ+my9IPNY9vT4o+eV9QnAtBrM+fU/mPRxdOFCiO55vOKoVNyrn3Z92n1xZ4Dkq83b3jXSXSeDzi9xXUmsTi6L8mSCzhN/KxVQQsObQX9uSrA48gzVqQ+9yg8lU7bIfIKMcQaslOIBwzynPtC41LNErN9+xgf81K8EUCXnMzo0kaNJ8ZXrSkp7LCVeK5FFiYZx5HKjYlrz7cqLcCtfmTCme4FXLpb3ZNdpUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o66Y5mKiXileIcWu4vfHTgpzvmYZZDvoWEzjioPl/nM=;
 b=IHtP/VqLsYDYKXgqbltNcsNVvmI/4diEfvmw5tfN/7Wr7UNrxWG7l41HhGtAoRYtybe5xgvwINaI11fmuuBh8mJnqnD0PQZc6p0lp9QAYNUTZOzeZvt3WmxwLEqMzAr12dEIe3TxU917qAUX6Biy1GOQZNXf7TLLTZFKr/2WEjJ0jIWnEHxyEmmJ6Be7UsCnPA2zAVajaVaz3pG51Bot5/MR2RsctFKHDkwTHmo47H58WzKZpbhPt/9c9yIkZo9my2i8koYIyCekY5S6U0Ds1qSOa7xh3N+Kr2tSW87kHE8kE5CyKq+1KaG0ASDeYNJ/FEccP6J8Qxz5nkaWO2WEqg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 08:16:49 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:16:49 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: dlemoal@kernel.org,
	jingoohan1@gmail.com,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	frank.li@nxp.com,
	quic_krichai@quicinc.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 2/2] PCI: dwc: Clean up some unnecessary codes in dw_pcie_suspend_noirq()
Date: Tue, 10 Dec 2024 16:15:57 +0800
Message-Id: <20241210081557.163555-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241210081557.163555-1-hongxing.zhu@nxp.com>
References: <20241210081557.163555-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0050.apcprd02.prod.outlook.com
 (2603:1096:4:196::11) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PA1PR04MB10865:EE_
X-MS-Office365-Filtering-Correlation-Id: bc8a9ec7-4a1c-4d78-1b54-08dd18f2febe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?f8pKn7uDwe4JjFUiA7BG82wUNtKY9wmJoBpbKPw97rdTqEgP+ScQhbEleKjl?=
 =?us-ascii?Q?jwThzr81kHF3zWgCmeT0ql01yUasHxy3p2EXFZc9UfYJTltzVMYZzI8HziUZ?=
 =?us-ascii?Q?yc+VF3oRPe0cFQVsMhjCmcAHsbnP0IVaU/OS843YQ3vpiVKM6QkrCvQl9lYM?=
 =?us-ascii?Q?2TS67YxmkQ8mfXAzJV0anx1/SB7WScPt+Lx+1CnagHKEyq/Oj/D4C3xE+r/q?=
 =?us-ascii?Q?PdS/CuM2pWf9kyUQSY5v02EdIE17cc1p08Ht5oafMyTW7xGuioKR4B787ESs?=
 =?us-ascii?Q?hRM+tbajLNxyxQ5DGC+vOjRafA7/9GGi8iqvyNs0ZQZe6GUDKR6LVaG+G5Jh?=
 =?us-ascii?Q?0fHPwfTZKVdxm32HSYMmWYmLTl9PydEJ6ktpPYCxITsyUGhmylLlAXvypKSp?=
 =?us-ascii?Q?ibLgL3fHAynUlnnul0OGcHOaxSWpvo2H7zYfaoDMBPVbIP4XMpyKOHl4l2+/?=
 =?us-ascii?Q?aISCmB2SIlrYsMsIjPUu6jPUi1xGNQ7nE1xBtyv0+m7niSEpsuxhEFeo4b0S?=
 =?us-ascii?Q?TZZ3a8En572KLVtRQYnZjh/NZ7xDaRvq8xyhZqrwzwNP0amxb1Y5SvO05mKI?=
 =?us-ascii?Q?zzcdG73Le/ASJHPsPsTn9QJ3ekmMkdCS/jQxh7JQ7K/vW5PBYjpJ4DVbOKea?=
 =?us-ascii?Q?tfVoGEP6MTo4EM1H5RPbp23ZySUCA/MV5EdnWUdPrG5sbBDv+My7nGYcL8Mv?=
 =?us-ascii?Q?Ba2UXRRqTGe9lqEutMwzdfDV6pQEi7Cg38FxewS22srjNXBR4SW/7NkkXeEN?=
 =?us-ascii?Q?qHOz2b5pcnZj7D6hhajQv4yQrSohiTI8y89nXkE0jtlHZdt3lklug8G5FzPu?=
 =?us-ascii?Q?+kJLMPYIyKrMfQpAgyMC5ii60BepEziSvKECc8w7p0n74NQ5qx/J/HQgwKCJ?=
 =?us-ascii?Q?7dOB6GBT5rERBpbIPdvJIXwM35eMEFLyrNSDutpxlbjDRo3Shy7+cTYBXjN1?=
 =?us-ascii?Q?7GYWcqw+YB1lIJXLQiJwmTTiRtqqmSkes4GhoYAZ1rANVf9b3uxaehoQv7Es?=
 =?us-ascii?Q?g5aYaL9A7b2/q0ZM518pH04L2WQNOO5+JhfwKG/es9F5HjmOArfp92hIkA58?=
 =?us-ascii?Q?fkmM13x09lvlZfeNAhkV/Ili3O27G0CSvZgo9LQ2XAQefjVUI77bEPyWE6Fm?=
 =?us-ascii?Q?v0qQrrgTtJ7iAQpHEsGgyHBVVoNu6bwLanw8wK0psGPC/I7reTEXFvhpliLm?=
 =?us-ascii?Q?S3rGKCsZzvXzPNRPxJE1V8hJ3FgD811UOXiCiJJ07774wTuC+RUy1auLBIJj?=
 =?us-ascii?Q?72wFsQtHZt36y4ZkNWmQS6KL/q7SeCnyt3h3pjSadzdP28nnaMz6IeGPeje6?=
 =?us-ascii?Q?RhbyR6pQ3Ipb7DQpp+7c9mW21LXT2DVBokoOnMzdiQNxyXkiFMoRBsvdf9Go?=
 =?us-ascii?Q?poK858NjuEqyi/AhRwNdec9SdwaRsgYVghJwa/S+bZDO8MvBJw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6y+WZnZd2YczS5LIokRlRnZ4Iu2P8IracgJ/wEyGEQe/cVsihfJr1tbFNbvG?=
 =?us-ascii?Q?KHuL1eNfkUtZiD4X7IVow+wlSiI4RTNbSns4fB0SXWbJeU5BCrm8ZPvgDLI/?=
 =?us-ascii?Q?jVvQrz8msC/VOX0nsvbD9sxA1joVxIZ9OiA2d9/7fSeB1bEsUSr4ZFaK+FNP?=
 =?us-ascii?Q?iCoy8TTxca50lhkibP6qKi1cfcjJQyQZiYz0FJTgmuNuZzvAXtdIZSLzpY9Q?=
 =?us-ascii?Q?igQ9YgNdXS6PNN0jUuRzzpYywLyDsJvB9Lz9ZcPUiTfZaXQCCMdPrVzLrR1W?=
 =?us-ascii?Q?a3M4s33omojVaKpsA/fCxsEekUU5FP55YoRa5AlQTufFZ2/ImRD+BDCZTUnH?=
 =?us-ascii?Q?ILfTl7nfpvuLuNPGYhYFZf4eoke/7rQwtlDSIVW3orYkTrJ2KA5B5VNewkuI?=
 =?us-ascii?Q?ZHDBFtF+47NhtemVAIN/GGHDsMOJcFeqQcdEky/e+hIm29XEby6bPyrr0xg6?=
 =?us-ascii?Q?7DCSH9qdpJ65/V4hr3MdmAtMhaGAk7XNVVCKiP7uwzjtT1YEk1/4LlEvEv1V?=
 =?us-ascii?Q?0MEc2zRF2gTn+XaVMV97gcJQWCjXV5gdX4nGgmpTKMFS8cbj9Fbrb+u7HCIa?=
 =?us-ascii?Q?zR4Rr6VaeuiwrPV9H+UpTelJFQWuDtZaQ8Vb6VkZqvEGjmFqUwQDiMzSIjQe?=
 =?us-ascii?Q?HQVF32CJZlWA8Y40J2zlTMasPvPLEu/TnGM25u8rRl4LQG7WC3gRLsvBoWQo?=
 =?us-ascii?Q?Nfxs/kS8Pdy9nB4DodJeJz0gvv7tWnkb2z1pMkHK0L9vs6gaoMlOo33+YQ4b?=
 =?us-ascii?Q?Pq0IXhffOo+iw9MUaZDqqdgqPCmnk8jsIPZQIv9bdGEDUKHnUucIjQWO8TQP?=
 =?us-ascii?Q?t3GrRGWXEBlIsAtuCzyxnk06MN653e8h1nQokWEXtWGaArf9gZPZz+zEfhtS?=
 =?us-ascii?Q?DsWNTobpEa7ytUGRebnvNGl/zL83Q0QMfZsJTkdsmgsojql9ug42k+JVGZ2W?=
 =?us-ascii?Q?JauV5tpPtFGvA3icwsx/k60B3eeqHxuIQ0eXQdt77l4Q4TeVTebHMaCrULp7?=
 =?us-ascii?Q?ZmSsxcXW6BudQa4U4dlZ97fEiFQo1KrLD+ZfKINzzgbW9jPhpVkA80/y3/LQ?=
 =?us-ascii?Q?qeJezMinAvnG8VIH+ttGfqttGYqyWERNPioe/UgubIkkyJq4PI8eIK4bwtbz?=
 =?us-ascii?Q?DDaNFzCF6PKmr4hgKToTwu2zsPFJhqFZ7WIQJA3QcCT6VLp6gUpV7ia+JYpk?=
 =?us-ascii?Q?UqA6CaOkNadxkm1A6EGJdRqplPphwJo6ra+ioeBSddY0D48gWabiYgNSW6/K?=
 =?us-ascii?Q?NQOkpaBRk1XlyMdFZ9p8Esl7rEVVN4m2fLB4dpDeXOsd8CddVuOJMQHzo4z8?=
 =?us-ascii?Q?ccKMCqV5sy0Xwa5IXj8SPhncw06c/kUXbUCXqBWsGhAF2kpkjSKQGjHYG93Z?=
 =?us-ascii?Q?L/PqJMBFLZRpngP3ViS3tsa5+8e3eX6OuFKb/SiTW/QfiPdxFN6acW0gxTph?=
 =?us-ascii?Q?Z7tO0YOrDPlHSG1fyVCruVn46EVtqLaF0k8wxP4UwvsttZWeTzmvtiRt92Eo?=
 =?us-ascii?Q?lYXZR1g4T00Mx1Zyl00VW/bK4fYgxVME2Pc4jAFbUbit+hKxk+JVdv9wjxqm?=
 =?us-ascii?Q?qZEzjxd0Zmupsi74KM4lczHWXWH0dQxkT6QIZV+e?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc8a9ec7-4a1c-4d78-1b54-08dd18f2febe
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:16:49.5093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNBFf7SkyQ5qnAHYQqxgRuRzCtYG/SS4qoOB2I+ALguTW7NweHkA+GMBRB9hFh0NKrl9fBTZe/2TBxqDInoAUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

Before sending PME_TURN_OFF, don't test the LTSSM state. Since it's safe
to send PME_TURN_OFF message regardless of whether the link is up or
down. So, there would be no need to test the LTSSM state before sending
PME_TURN_OFF message.

Only print the message when ltssm_stat is not in DETECT and POLL.
In the other words, there isn't an error message when no endpoint is
connected at all.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../pci/controller/dwc/pcie-designware-host.c | 27 ++++++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f56cb7b9e6f99..bdb9c1ad6cdd5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -973,7 +973,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 {
 	u8 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	u32 val;
-	int ret = 0;
+	int ret;
 
 	/*
 	 * If L1SS is supported, then do not put the link into L2 as some
@@ -982,25 +982,32 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
-		return 0;
-
-	if (pci->pp.ops->pme_turn_off)
+	if (pci->pp.ops->pme_turn_off) {
 		pci->pp.ops->pme_turn_off(&pci->pp);
-	else
+	} else {
 		ret = dw_pcie_pme_turn_off(pci);
+		if (ret)
+			return ret;
+	}
 
-	if (ret)
-		return ret;
-
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
+				val == DW_PCIE_LTSSM_L2_IDLE ||
+				val <= DW_PCIE_LTSSM_DETECT_WAIT,
 				PCIE_PME_TO_L2_TIMEOUT_US/10,
 				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
 	if (ret) {
+		/* Only dump message when ltssm_stat isn't in DETECT and POLL */
 		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
 		return ret;
 	}
 
+	/*
+	 * Refer to r6.0, sec 5.3.3.2.1, software should wait at least
+	 * 100ns after L2/L3 Ready before turning off refclock and
+	 * main power. It's harmless too when no endpoint connected.
+	 */
+	udelay(1);
+
 	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 5c14ed2cb91ed..7efcb4af66da3 100644
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


