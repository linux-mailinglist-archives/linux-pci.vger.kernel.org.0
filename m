Return-Path: <linux-pci+bounces-17993-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF939EAA65
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 09:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A152188B63A
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2024 08:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC71230997;
	Tue, 10 Dec 2024 08:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cRSRiCqu"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66F7230982;
	Tue, 10 Dec 2024 08:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733818610; cv=fail; b=jlZMe/RMvl6XMMYiVmWPB7UlsS7EoObJCtmPFU+oC3HHPy8vFCWmgoRdjxPOsF+TUS1B3RnEKcw/j5wBZgggiVs5BMROCnwgb0jnmcc0bsvhNjWoz6j0FFX0UAvDuEjg6uTcaLeK6j3hH3B80tmCB74N7YeMPvPl7GgmKoksT+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733818610; c=relaxed/simple;
	bh=zft4qZ6+Zv2OThPUcfHgP70hCp/A8YOxKE/ffNOYlXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivOICHtJ0rKjVzldhmQ72DiPHwYKuQab7OX6oCySobBgCiVjV0a04bevhWC1I0yLnTDVEbo2oFFEuPP2GZnRskUY6nqnbxqD3eV1wWyDx1iW91G8Iq6atuP/taf2Ytq4y+FuGYviPX7HEA3rRElpZxmhdQa0RVpCnIW3ZluqNLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cRSRiCqu; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4c96+68Nv09RsH2bkMnFztlmfw4AL3lBTIk1u64dJc3VtVWHw1qopOIfTHEnGyzzfK0qLDHoDZIMgQJiUf6YMXpZg9zKQXflFZ7St5SsMO9a0EgKWKZaxCPIOV19idw0QJwCLuOjKxUV41XJuWl+tp/Jgr1UEDIz0SwjN+ZAHCVANL/htMWx7TW19T6rP/LH6UZBnRCqPWs76r7z6YWUWrIqak7iClkzibvXZIdQATcsk+hLi07BFnnv+QS3rhgn/1ZbgR0LQTtfznEOOWNOYZUQKnmvfxUXwvQvmulfmmXmGlKLl+EMeXajNUjbpt6wpH/hG84PZJBJv+JiE1lgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6cuLc+8G8uk+I9dbviih8A+H9l13EVdBe6wtOOqfMA=;
 b=oiSMGC4g4Mn/X6dwdNj//oUpZ2pfbvtKvjfEKqjV96FYjknhXQPxjQhH9g3yYaJuvjv2Mwvx5yQphGkZ0QbMBmM2Gz7/jsSK2OCDeZPf3DSlog7muu3KfGTq1fsT0xHW94MMryjuDt3ITNhFF59dt4F2uUMcgbw0XPe/vtGp+bAdNYT+oVHrRvtFP1mThgcR68l3v8ECh3sDG6RI3FzCN0JePFNJ58wmviLeo0kU9NwAZkMNyGKJPHitT8SV7tuLnq7F9FSUDuK21qyzquaeSb+lHBZsNTxhZj0JmPF2cGygMYPsKlV8nl4WSAe4JbDq6XB+O4n4+1IS/+ASEwvJCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6cuLc+8G8uk+I9dbviih8A+H9l13EVdBe6wtOOqfMA=;
 b=cRSRiCquRplJpTJWmDJaoJvgoS5mOGCGyxTwsLjWiOBGi+ngDUEyuamwwMUUnMOrDRZcGXpxNzPnjxOBu6tp63RKGbk+4YzdOgIHf+VzENHJmk7ZNu2bstcMvIdCaD1a/54aVRGYWsjx5iFU8AaTQy9qTJ1tbMetr73KyzDBm+fbThof7FJtcWGcRMBB/7HODtFuslCXGGWSM2Twj7e5cfki2+qCV+eoU6BiZFOmsfu91IEAssKbknybGL2QFLbbmLVjw6NTDSQSKV8JSsl8P7xTW07dcwJlZu1irBc4VgG0lcdEJjdBYRsEQmT9suA3FyzKH3Kn/r9BAzmiJ71Zww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PA1PR04MB10865.eurprd04.prod.outlook.com (2603:10a6:102:48a::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Tue, 10 Dec
 2024 08:16:44 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 08:16:44 +0000
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v4 1/2] PCI: dwc: Always stop link in the dw_pcie_suspend_noirq
Date: Tue, 10 Dec 2024 16:15:56 +0800
Message-Id: <20241210081557.163555-2-hongxing.zhu@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 93e625ca-8130-48bf-1284-08dd18f2fbdc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QWI8+JiZygHejqmgFs60aHWw/hPFViYH53gg5LVCWhqzrOUmEDZhrJAwngq9?=
 =?us-ascii?Q?KDN45O+IzJZ5zn2lLY4/PU0L4+Jw27uyWXZ3E4WofJogYRlXjUi2xhiwhWpv?=
 =?us-ascii?Q?NzmHedE7Hjd553b+sEp9ryD0s0PPG55m7Pgs4yvrObvbVY3D4t5a5/geDQI1?=
 =?us-ascii?Q?vLwROzGXc0tkSZtJIsNtcEs1QFJ5M5LG4lTtO5fcNt0IS9WdwgxgWv8WVkz6?=
 =?us-ascii?Q?srY7BBhVs5Azr4ZKtrLbg3eKKknDkSdcDGHwJ/8drWlbfjBQ9ckImHYtw3c7?=
 =?us-ascii?Q?kgNUWFcSynuIfDQF9kDcwTxmdJnouVUCawUGObBtSv9WAgj32LjIXDrMombG?=
 =?us-ascii?Q?JofOpkuye+DPBDHVBqpE0Eg5jJimaOeefRCsb7NNryrxmVCqkqEfYyYnv9EW?=
 =?us-ascii?Q?oF5oZhzcGccLySc/etSQLGDHPug1/00IPYmBIHHFIQyZxkeGzdWi0zmgHTA4?=
 =?us-ascii?Q?lUVmofojzZBLnJkmlAKP/TEFz1YwcL/8k7s5A9y7j1hfRgFm3q8fU7brq/VK?=
 =?us-ascii?Q?WqtppdR7Z30/LdCwGENTpM5LvOTWTakb2f0CfpmOSzKAti0ILTf3qy7zww/a?=
 =?us-ascii?Q?4WIgtQxmNKJEjqkywpt/i1H76ZP4CGKBWg6RXq7tLgg8dssDm5+TBbn0Xt6o?=
 =?us-ascii?Q?L+vv1/DDdbBRVkYXMrKsng3PUD7Nb1u9fGwbbXJ8ktKMcCbNW9PljuyEjegE?=
 =?us-ascii?Q?0UCmvRqcnYb8K4fr+NOkvET/aDnffhF50xsm6YukzYk1dT/khrOgvW2WLPlh?=
 =?us-ascii?Q?WwGniOzjRuF1XWZA90MTmr/rYBNYlnyXiDAP+D/D0l9BJtf3tn3pRUk/lu9A?=
 =?us-ascii?Q?9d9EF8zhAweT9rMr/+oxlF8q33y2xU3qQBTJgbsHldozUSef0kscwaypN8Iy?=
 =?us-ascii?Q?UKT+i+WKiMv5tQeoX4qb+6iMuymANwOFnAwDIlSqebwyM6HF3RwN4m4rZDoD?=
 =?us-ascii?Q?zPM4yYPFDzPJ/2159Fh5ilfBl1Htw+E4U7Qu6K/STdaV5sEVE26shVXGLiVW?=
 =?us-ascii?Q?GE7smY93o4zt1/OFYudBHysQMUHlEcRrfc/DmekjFloTPWfUTp56VAgMLwkc?=
 =?us-ascii?Q?kZnO2nP+m1lykriTAbODmRqtuxWycyTUMx2Raz4ZiAibNIJdyLwsf3BkfjNo?=
 =?us-ascii?Q?R4Q4sg7g6E70ngyWzlEAWzlsZWsygym3zoqOE1Ijemqft8XTjTG4ZcIjucBV?=
 =?us-ascii?Q?aas0u3/AyBSUbstwkdbYehak9NCttvln+B27d3mnVGKC0I/HBKbAqzkrauNU?=
 =?us-ascii?Q?Z56Pp9un4f2h3oEznxIHoDa7Qztx+6TWe4GSGJ+NAQFCQeTbR8PSMPZYYMsh?=
 =?us-ascii?Q?wY98PIxXptD+QAcl/XmRVIQ6YlxFK7UTlaAfEZkpTJfsJyenKUBEsBgWdnhx?=
 =?us-ascii?Q?2kaUnXT8Gtj7uc6j2b4IgB/eOF8WgnSeLdUAPQ4/hqKf5GSUkQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Kh8rEFLryye/H7FPRrWMP7ZWLUwLDJVxnVtrpBtBumTcuSC86oBYt44BiWdc?=
 =?us-ascii?Q?l8VHBs0YfV9fOQy1WYhAR5tRg3gZt5gnEAlA2iX7JGDpba09eLXnDAGSOkRQ?=
 =?us-ascii?Q?+5vZ77zG6XAWt6BEwh3ZmAFyWvYvw0KWfeToKcvhw/FqJGiCT5ExY5tk8lGP?=
 =?us-ascii?Q?+ijYO0PO8BS9L/ZA++UkOlx0hFyqTkd132AFcRZTaHJWu2Isf0KAtbu6VmID?=
 =?us-ascii?Q?BhBW5QjVcqnfZpvmLMOYAtQSJ87Guod+RDaEVRUKv/x1/86Btr+erB0IXHAL?=
 =?us-ascii?Q?t3jeUSNFhpqSP4lUBZcuELawnV/aiq9IGhKuU46ic3RnjO4ZNcyM8pF/tAGk?=
 =?us-ascii?Q?xLknCcilhnr0cOC8l2nMqgkmsRtWupWutwtUj+k/jIseUkqZpIYMXpLb/50I?=
 =?us-ascii?Q?drhy8ULNPeoRlT0+sbDrqL71Zp6NRgNzbxsTGGjlgdtGE32kGM/pfmnsNaGB?=
 =?us-ascii?Q?UeRAy9K8+H7aDyfPOUQXzFC31afPYPhSTeqylNwkIdFcOIJHemo13qguYT3w?=
 =?us-ascii?Q?l+AtNj2otAkFjDXM/6kJwHnlBT21zxJBG/53CvhKpEuYCGAW1sTZdulwh8PF?=
 =?us-ascii?Q?lS4BTuAmgaa0XEXwyLo5e0KWJVUu7xthhLvMpHOi0f6fxNjhdXm3SKbPelpH?=
 =?us-ascii?Q?qTcG0qwSvGjsiWcqc1GRagrDy5RhT1RMEu/rSSQsLn9YAH1v/gVhvDgc4sxC?=
 =?us-ascii?Q?4bpULHCX9vV5RtE0hG32QhbEFbEfZWBIRhGu0dHpceyYAx4YWbfipk3EpvEz?=
 =?us-ascii?Q?deh/VPhRi2BqjytlIRDqCYfAEFLGrOKfzaKiQmnatHHJYpO6ocdtaKDc4w3Z?=
 =?us-ascii?Q?w0Q9MVVf7AQsuZDYuFUEM129MVs29Gd9o4Cd+DPC+UGRN3GPkXmrLyT26Qyo?=
 =?us-ascii?Q?E7EY7z5ScgkCx58Fgg54jYi0X+27VO8vf3t35nUAzuxjZtTxgspxx9Legbpe?=
 =?us-ascii?Q?EQjJikqeqbn0G8zmv3Im0uyFbmJO4p1tzecnyPoWOYpJNDzg0aZ6pSEdz+7b?=
 =?us-ascii?Q?JDKN54jWsQRDh8M0X8dI0/Se7jvx4fj2pnDIkShej97SdXTdc6o6gafPrdNa?=
 =?us-ascii?Q?Y3LdgR2gFfVprkdF7gMDe6Db3nnu/hbo5R5dJ1zFIIF+yYUlF6FnomMin+Oh?=
 =?us-ascii?Q?Lxjjk7odJv5G3+nh/J5vpPyMyXZMtuWsIOtLSNBRUV+1YKme8ieyijwTLS8s?=
 =?us-ascii?Q?pZCZ+3yFEe11l0bFdFayuXnXGNkdtvmhbmmSrwRnP6yCN0YMbdZ7n7HdhyiE?=
 =?us-ascii?Q?V9XwMhUOIBsV6sy8HC9okEqePH2Fym/k3CbSIFCFAKQROcfJtdlBllwCiKYh?=
 =?us-ascii?Q?3HtKDCw9iQekpOfnZc30/diF8VC8WhOdbohcSWskzEyK2okNizJR3X9lZzzB?=
 =?us-ascii?Q?XSvtClUIFQPprDlxCc8FTT3dFyvdDQvar+jStYK7gYRpvZkpllXj0WREBes8?=
 =?us-ascii?Q?LdYNwYCDAm8Cf9kYsMiPnMJ0aGu/X9J7Gw+zc0BfU6Oc2qmFE+tCrE3oS0nU?=
 =?us-ascii?Q?n1XxdwmNnkkEpVzuDC8DphHPB1cbJzZjXVhTxmBqHwOK7UCVi+RHVkRlTjb8?=
 =?us-ascii?Q?WWm9KNKRSU3UqRePi3u9YdNqMNIHe6zJ45kNJ2OB?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e625ca-8130-48bf-1284-08dd18f2fbdc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 08:16:44.7104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DcH1jUfhYyrq7INoc+cjs+R2g9ktZT6iVcIgT5Jh2xaXtmu7WHw20qqnPZkrmuVO1oY/Fi7oLPdmibTOpI0Tuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10865

On i.MX8QM, PCIe link can't be re-established again in
dw_pcie_resume_noirq(), if the LTSSM_EN bit is not cleared properly in
dw_pcie_suspend_noirq().

Add dw_pcie_stop_link() into dw_pcie_suspend_noirq() to fix this issue and
keep symmetric in suspend/resume function since there is
dw_pcie_start_link() in dw_pcie_resume_noirq().

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f882b11fd7b94..f56cb7b9e6f99 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1001,6 +1001,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 		return ret;
 	}
 
+	dw_pcie_stop_link(pci);
 	if (pci->pp.ops->deinit)
 		pci->pp.ops->deinit(&pci->pp);
 
-- 
2.37.1


