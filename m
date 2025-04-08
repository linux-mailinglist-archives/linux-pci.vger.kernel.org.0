Return-Path: <linux-pci+bounces-25476-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DF8A7F552
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 08:54:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F1557A7742
	for <lists+linux-pci@lfdr.de>; Tue,  8 Apr 2025 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADE2725FA1C;
	Tue,  8 Apr 2025 06:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VhnqtQ72"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2054.outbound.protection.outlook.com [40.107.20.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD49825FA0C;
	Tue,  8 Apr 2025 06:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744095259; cv=fail; b=LtPv+bwk6zMFZwTz7rG/95hPS1D/b3eHt+lUJOR1is0tn5c3zIJr2+26FYyATfpT4oVPjezNPQfzIlPPVuefThlfnq0lrVmzZHRgN/GQum1nuDd1yps6kXPcYXAqkhvL1QJ0ZFi/e1itlmxhsvz00P3rNgRYduWnKI3HI/fgGDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744095259; c=relaxed/simple;
	bh=Gy9o+TACRQvME3z1V5ras3GIisTDjqTeP/vd3XJEYlQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jwqe+CvuloA+BycghJT5MWG+nxnpqT5QNQ8JSWOAL4CejpqnqmvoRCjO2mMWZ5b/h/eARAKZhLTwG8lsgK3ERv6LctyJsixkSPJQDQWnA3/ywvay/pmOOQbah52eUQIratSBPrq/ADcq/FJvNOyFYyfYCETWoQ5cpr+jPPhsu/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VhnqtQ72; arc=fail smtp.client-ip=40.107.20.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GLBj0TM1LoFvbxB+vNr/NMBfanZUo8NSbGI67JT5NOjDxoCecYHD8FbZcMxHLvghH6vhshK9fjvdguhr7aMkZrpb/qN8Z4maR/i78fHofjv3IfiRtAL31g73insbaudo4Xi+RQJzd8bkJgZM8XNe0CaoT+yr5Xyt6fQJD3hi8RL/gi3Mk4/fAxKuzO/CrO8ZWj4v2q+MRgfta7RESsMEGfhEg2KBo3gawAjmBBH/moUYXC6Y2See46i35py1s0XE/nChFgduVRNIKcqk/gtd4ERcE59Vf4JGpfbi3HZ3RxBDJQELxak7yKg1F8CNbL7HU8pCSYoN9Ld6mxFoKkDn4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fywXyYEIM5L+hIDdAWDaCAlTIKnFSd4a2XH9qp7crKI=;
 b=PqWVrkC0nvSbBrIkJTHmZHmWok0kUjamSvBkaSm3nZ19fZbSPUpMTXFl8Lnqxp0tbe9t4PoByhAKKFD7raijPKTa6VFk5jkHikwqKpcROrWOgrV44LzmI/tXj61BRLw2f3WccuxemjY2q40rgdkoNWa+K6gvgwSXsjWhSi5+265qvgDpeQ5xuZBs47F3Bu3/bIdQ8jdgEBx7xLzg5Z/hjuwOroX3vDPZcHdK3jIBDS53QxKm3sXuJHpGFL+IoQtIvyR7VHPW2/T/sEMBYfoCAW2ysEw8FOFG95wLD0FlVg1tQwwAQZyHawYSnAUTQHnw/f+3PiR/Cx2cVs2EvMHM8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fywXyYEIM5L+hIDdAWDaCAlTIKnFSd4a2XH9qp7crKI=;
 b=VhnqtQ72lXVeHi4G7dZNwFPrvOFkU5mNUDB0+nDOaNDlmEW3hut9kpcqIq2RNZMvrDnF2iK4rHK6zzjaZnOlbLrh3ezf5/WQZnWDF+iZP4VkvGTDqSzrSLgZHx7TzLK1lJCi8kfRW8C7whoRSxh2Zj3tQa0tS57wmH5xN8siAyfQVgWSfEFDP8N5jLo2D1WAVC8iROK2CJwHXJmadpes7H9HFlxh5HXcF3B7bg8Sls9rXwgrXGE5HuKRZ0DftZskD8weYeQrUbMHbY+ch3Zwj+vxAIeDDbbUeLNHjl6M8auhh5G+wBZC9cdEBSYmmhgTerLliaJ0DwL9Y4bPIPgejQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AS4PR04MB9458.eurprd04.prod.outlook.com (2603:10a6:20b:4ea::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Tue, 8 Apr
 2025 06:54:13 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8606.033; Tue, 8 Apr 2025
 06:54:13 +0000
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
Subject: [PATCH v1 3/4] PCI: imx6: Fix i.MX6QP PCIe hang issue in L2 poll of suspend
Date: Tue,  8 Apr 2025 14:52:20 +0800
Message-Id: <20250408065221.1941928-4-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7f8255b9-2d39-4fbe-9686-08dd766a2ba6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?sCXiC0MDUIyDslAgpOA0CpACWRRh8xa3Hw07SFA+F6SpKBgdX2USokly/GaL?=
 =?us-ascii?Q?QL62oX53yv4U9N7WTOJZ2QQroD40ZxXTVXUv1VUuu81IyBS8U0XcoEuDd5k2?=
 =?us-ascii?Q?Ptr9sixBM3L8L89hEc+jlkIT8MR43cS2xA2pMvJpCM71TkP0Ou/NqlsDEpHp?=
 =?us-ascii?Q?bfGq9kX/enqpL0kfrNCmVMlZvvNfvMQIE9ULQpwuBw/khY5Lw1WswNsAOSlB?=
 =?us-ascii?Q?qlTWURta+gFDR/OpKsqINjOHqVWQue0+jgK8w576ryghINyu9K6+XmL6tFJz?=
 =?us-ascii?Q?e6Ic2DW5cS2StFjr3DtQ7j7Y5IeafNROlzY7Un1zVqVCi1Jse66TsFkWqUlW?=
 =?us-ascii?Q?FjfI+0T/C6TP4HgHFlERJaOBs4+fD0Osj+mYBEX2gQz99qsRkQCV4b+4oBwF?=
 =?us-ascii?Q?YfBPsc6yONyl2f4zG95PPJWPkKJbjeL3D1JORzxYKGVZKHBXwBQ5zbkSfZ7r?=
 =?us-ascii?Q?sz9rfoBE8ng08I1wW4id5ChqWwkIafMprzMqpyp5019bnPVEvpqHoFblq3TN?=
 =?us-ascii?Q?0AuPS/wJEV6o1LphgIp7mIMCfL8wUQuQ6QslczbwOJHejJuHM+6RsBfdD70p?=
 =?us-ascii?Q?T00T4Avo7aq2tPDt5QoG8eslgSKL2usMd2FjZjjGmUjcwnzOi791kVYAzRhW?=
 =?us-ascii?Q?2Ydg7jeNpdhlB8JWB63t1lKuoRmEtaEHtHEgKw1a8TapSmTQ21kpHG5zwOd/?=
 =?us-ascii?Q?XC6deNY/c3FyGrR0mGcumkoO13mb/NjbXDrhRDWhrubvpkaE2BFlBBDTFqOG?=
 =?us-ascii?Q?Swz/KUHyCAi8O+epP9U6Z2hrQhsBgZFvxUkleoekBLHojIzSIe2YYHzokg9/?=
 =?us-ascii?Q?I0D6vMpHUu7pCqYQqX6gfZGUQNgm3fy2NqgiznJ1sSpCJmDc0KCMV3VAPxq6?=
 =?us-ascii?Q?nvgZ4h3ldzMC4+IEmze7DhSTDlDNTJQhU7iU2cm9a8U3Wm5AmkpFanAktp5o?=
 =?us-ascii?Q?9TeLJW7gFnM94FV+NpC3+4T7o3jMrP9H/Mx4W8wIcCuMUy0HwM9MI1F7H1A1?=
 =?us-ascii?Q?0V2NRHqKpc9B0XLfuJqR8cn9/mcGCVNb6poU9eBj4aCWRCyxruF0SaYiJa98?=
 =?us-ascii?Q?E47ozXns+VICqbsyZeavcienmKn8/+Swnr5/LJo0HStBcR3o8gZXzWOGU4uc?=
 =?us-ascii?Q?ChdndpIVbwDEqNehIS1LvUhzlSClS5kG5l4FdLA3sE5ajVtW1qoXNf/tNT3R?=
 =?us-ascii?Q?aqSNrKmNYBJZcV77sQ5lyQJivVprEexxFZTuogKGUJTSST7SVFl2ERjpOx6v?=
 =?us-ascii?Q?ZWrDRTyCRhHh41UX5JPmfHOjEd4A5+29J+r2ZdDhVGdpVC6JddZbxydS5/Uy?=
 =?us-ascii?Q?+9+y/qAFBcgzz7dcXxXNREUyY23kdk2tglJJB62P4nD6Ow7qOT+8bJ8LinM5?=
 =?us-ascii?Q?lAU4vOaspHAFnx+0Ul95ABPMf8zx37f2griHrLr7LSHGI0x0hhiYXlPDWHMU?=
 =?us-ascii?Q?77Mg32XzmHbYNfAfA/6NcBwrXMnzkHyE3sGyXKjJ6k6KSgJoV2gjXw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QpyiK9gOkH/s3CFRDsci0Q1P7fP2cj+EgBQEbygZgU3druauntEree8UmAhz?=
 =?us-ascii?Q?deHWjOE2Sv45w5fIzZYQjmwVbHWkMRIAJ/+SbtEssz32dfjWsE9yDyMn03gI?=
 =?us-ascii?Q?f1Lb///jj+PUy+M3DqTK5c4HGiB1YrJb1op4Bvo9BikcM/WM1n0sTLTaW/AL?=
 =?us-ascii?Q?UL4KF8klXoXbPPeoF4juKX6NAk/0fXdib9khkdvV42o9djNvpzmGmQrYqZye?=
 =?us-ascii?Q?QctMr6qv8sQNUfpdXSawdDNgWNGSoJSuOBI6JvRNtVsHpoKsNOCML8XAxDsa?=
 =?us-ascii?Q?JDSx3rJt82UYxete0SeWyTSPH3gaih2LMHLT+PLgmYaGf2dNq19KnXh5IY4O?=
 =?us-ascii?Q?x0YIggOdhKLRREdMeT0Ni9ks+hL/k5PVxhTS9ewOHeDPlRxyAMa3UJ7eHA5j?=
 =?us-ascii?Q?Rgf0ZozMwtSoYOnHH6UP04/fl8qcgEMN3c7aHaXxsrelmD63TrwTdR+GtF0i?=
 =?us-ascii?Q?S7cT2LEaOxnGvef7+L1h/lpbWaDk+6HKkx0d3uzOLHvztqVrBFHjF1WB7pMu?=
 =?us-ascii?Q?M+pd8Fcfvr3Ho/C7gFdBujenlCXMCmVtHE4Ljzsnz8UmjtforS0gmaLKs8QQ?=
 =?us-ascii?Q?9uQ7334VX0U4FstU46nAxmISNXmBX3Jtl7ZNB5hKZeh5BlqPKA/W+WoFi07d?=
 =?us-ascii?Q?7hmYiWF3Co06dP5aIacg/81yhpEugRCrUu5g12RttBq9g4vJqwwGGPwMJQSz?=
 =?us-ascii?Q?ymoYKI2Gch7payPWWZ7mdZyHUmpDMauI4Kzaw/PdY9/aBw0kANsZO5eIrV9Z?=
 =?us-ascii?Q?TZOEqZo9gmDJkjwcZeVaMzySF39as5CdDezNqdQmPYtPrnJngIZ5Oie3W+Hs?=
 =?us-ascii?Q?LGGHw48sJa8MlMnv7N7eNMY1gfN7PfnFxraakfWYj+GtyIkrtZu9pqTUfu9G?=
 =?us-ascii?Q?oVLOq88y+rEuh7tVClsi1hZl/PB+4lPUdv2CjCATiExKGYCfmgc14U6r7LIY?=
 =?us-ascii?Q?I9hM/BM6Y3dA+PANvL+08l3KcUH6nST6v6p5JLyRlrF4hz4fAZ6EPszbQb0g?=
 =?us-ascii?Q?E/MnePJIdv5Fkt+euhLfD1MPcxte+5DDKJ6RkatmSTB8fV2Psyz94BRJ4F3Q?=
 =?us-ascii?Q?JBY+S41yngvfRmYR9/sRqjpp/8nWMt+FL7MozgqLcgvj2NNWcFk8dIN/GQf0?=
 =?us-ascii?Q?ORzQaJMoYzGRD/sBgumLOqMs+PubNhd3YC0BWmoCFXn6PFD59krEqepr0eux?=
 =?us-ascii?Q?M8XgSU7fowbxQIMX5AfWD5U/kx/cZmg354flCZV0Twfp1iUTwlWP1CZf0thk?=
 =?us-ascii?Q?jrv/52C86Qx1KLRzF5ZktGZXnNn6ItMJG0clOtRXQBSIfuULMJ9173zQ6YZ4?=
 =?us-ascii?Q?NMVLIN3DRA1/fahLxtn2vDAW3wg6r69q6qliWgMQ+RC/hTqcD2twxlOBiabx?=
 =?us-ascii?Q?cVvtgJ59FpURx44ZRKKpFOGOcp2ozmXOqjd4SMeLHPOjwR1xgmZjd7hYwFp/?=
 =?us-ascii?Q?Q2eslDu0LZAu2qkp88Gp/ltr0HuIki5TMp4si5j9soKwebn9FnCSFfkp/PMV?=
 =?us-ascii?Q?8AxwPoRYkwbefFiTcgzivBxkVPQ0ew07P37EZwQH0wn65MvEH36/fEe9XXha?=
 =?us-ascii?Q?2+7C2oNh9fyfD4gApTU4QPzyBidqGo4vE56wLjQy?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8255b9-2d39-4fbe-9686-08dd766a2ba6
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:54:13.0307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k9nq7aJuWE+uOafjFWD53xonx8Q1WIJxfZGUvsEGjMCnjUtcYd3QHif5XnLBA1tNE/tKqbc78ez9WE6tEup8hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9458

During suspend/resume, i.MX6QP PCIe is hang in L2 poll when one endpoint
device is connected, for example the Intel e1000e network card.

Refer to Figure5-1 Link Power Management State Flow Diagram of PCI
Express Base Spec Rev6.0. L0 can be transferred to LDn directly.

It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
PME_Turn_Off is sent out, whateve the ltssm state is in L2 or L3 on some
PME_Turn_Off handshake broken platforms.

To fix this issue, add one quirk to remove the L2 entry poll and let
dw_pcie_suspend_noirq() proceed directly after PME_Turn_Off is sent out.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 5f267dd261b5..aade80010cbe 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -116,6 +116,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1614,6 +1615,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1692,6 +1694,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


