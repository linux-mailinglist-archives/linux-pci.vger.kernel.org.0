Return-Path: <linux-pci+bounces-44133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE041CFBC55
	for <lists+linux-pci@lfdr.de>; Wed, 07 Jan 2026 03:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 722603060A50
	for <lists+linux-pci@lfdr.de>; Wed,  7 Jan 2026 02:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F13F2253FC;
	Wed,  7 Jan 2026 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="g51KBXZG"
X-Original-To: linux-pci@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013071.outbound.protection.outlook.com [40.107.159.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF3FE23AB95;
	Wed,  7 Jan 2026 02:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767754016; cv=fail; b=tsay6fJXMm6xhdBKLPCE6jxKUxeS0iottqgXd3ZfJuPcpSlF/N2k7kbUxX8dU7CVGkO/5QqFzfgbGgI+Ws0v1Rpsaz+tz6pKU5jPCZIgwxfyrF/sd6YynOrzPhXczzT8SzlOi46QnrPxRy/G25HMYxV6phhEe0PVzP3D7Dk0PiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767754016; c=relaxed/simple;
	bh=8+n0qM7Pf6JPqe6UYcl1trje/jizmV0OWs5324w233Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DXcpnzXnBZ4lB+rRRTlGgYupm39vQfDUESxtSpGAQMoJmPxUd046s5gs/NhpDFdWwfCCFYh3CuV0feflqCvPFpExUyI+DoGW/e4KUbcUYsB/+rg+ivRgR9xMY4eD+k1WrwzeX8pOxEgW4tJttEJ6tmfrk4ecVqq6v5tlKkae80U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=g51KBXZG; arc=fail smtp.client-ip=40.107.159.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoNPNWM+X9BL2R2MV4Y+uE/Il5VJcBmygUBmLgIkGKEVQWWlcuNJSYdJiNRzgqqFc4Fga0lAAoMSDfOnaol4LzaQeuiD1dNSa02or60BZDBxDKvqB6Bg4gyf2sB14hv8PmojjhXhqqzAT3X8gJScUpVn2AHLg6IJh5/t3IoYrjcQN50r4sNREaywkyt5/H0XKAfNEmbPdLmzqHn3CnGzeLn9ZiOP5u5WGNykm3FABUbTBR/LZAH2l6uZHpCFCnV+Hu3VwMrvyGaiZJgx43NNqxZgFBpN4a4B1YLa79amfDuEBENTWbnq6ex+vpnsTVMRiS5gkBWO+cgkt+yQRhnA3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LPsiPZ7+XdmUapyrR7xfMbp21y//k1rA2wr1Ag4DtwM=;
 b=KdgQ9sQ3Cz02gM2KubssATap8/h6rBPxgJ/uPrzVnutSafgWhwroxyTfxBFaaQYLVgt6wFodB7WCXW/O8vm3PcnPJNhbUBDzWXa/yQfeUXT4i9Oypu3PbLoigPV6NtRA9KZb1w0lYAH9LQite6mezJbWHAdTZ7AJuxiY+z51wZFZQTB4RzmwpYAq7auaA8Bk5bVKw23LnqEwyY2efC2j8z26/+GVu1ZDn7yBrYpZd9HXAJ7XApnneofkiABNcicXcPRiIId7WojqZxJI03LUkHYQmNVHmtKg0UsAxS2N2fNKXbjowzoXydHamuqvQ/cWzJGCALpPS2N3kswHkfmYKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LPsiPZ7+XdmUapyrR7xfMbp21y//k1rA2wr1Ag4DtwM=;
 b=g51KBXZGXPNJP3WYR7W+BArJOHTr/H7LWhTpjSqNe8SuJp8Im0sFlWg2eXgDWZJtjYOrw3n3n8hueuqzhO6nYyPA91Xcx/teMqh1Lh7pZSRMZjZK8iZIUGDC4Q+FWPBtbhHG/l/gZcP9+UNz/ujRvFCqjvWgW2PWH6bGln5Oi3Vn7Wn4fWx+3f1nY3fvjnMQ8SoLJ643UTpyVX1cgGihFn1qTyl6J3pHTa/1UnE1Nad3maVWfhFURfUtM7djmphdV+H4kL0MI+MOm0FW9QFFf+VYozBSiK0Lxew1aUrYrpUUzWzOtyIeBcAMPjjT0uoM69fyU7Ka8v9XRLpbTe3p1Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by GV1PR04MB10332.eurprd04.prod.outlook.com (2603:10a6:150:1ca::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.2; Wed, 7 Jan
 2026 02:46:49 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%7]) with mapi id 15.20.9499.002; Wed, 7 Jan 2026
 02:46:49 +0000
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
Subject: [PATCH v8 1/2] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM is existing in suspend
Date: Wed,  7 Jan 2026 10:45:52 +0800
Message-Id: <20260107024553.3307205-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
References: <20260107024553.3307205-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0113.apcprd02.prod.outlook.com
 (2603:1096:4:92::29) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|GV1PR04MB10332:EE_
X-MS-Office365-Filtering-Correlation-Id: d1a7bbc8-9b52-4572-8540-08de4d970129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|52116014|376014|7416014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?QHLQY9VJ/2J02BuVcnYDsIOa8xtqVlFapF9fSpO6u+IElfDY5kwr2RJ4fScM?=
 =?us-ascii?Q?jOyNwz5MaVaQEmMQJRSsdbQfvJZEp80d738g+AHG0lIv+ETSNmM4TBPncaG3?=
 =?us-ascii?Q?vByupc2ZFfZ1YFRymKSrnzjgrLuP+GPBf8GxJt4x+1qqYv66l7mwf048ZkYy?=
 =?us-ascii?Q?b2tE6N6AJpCPef78xK9KlcnwBhDQ12pc+I3/9mAxv7nZUDaxvtjLnlN51ZDn?=
 =?us-ascii?Q?LCYIp1TYVPco54ooKfNx0tnFVF+gxBgIQPVPA4ivxOM0PNcqqFKEjf6ttP6G?=
 =?us-ascii?Q?sSfC9NWdRJZpKLkeAqjqGRUB3RuLNUVKX+N1VuXsovcCnrdcBgvMCQDtevtR?=
 =?us-ascii?Q?C6iGqsOJJvHE+rj9U37Ffv71JUefKkwa0iOK2fDvRXtrgdrlbFJTpIOVwSJ2?=
 =?us-ascii?Q?C+CUfHeznOyrYFszsWiKIwqKz4RUvVs629eF45OXjCJPw63l9YH85Sfn7QSb?=
 =?us-ascii?Q?toacdY7ygacH9lWwSnI3UjrjdGtX7ufXTvEy+wra9U96bLP+lpWZCV3mmbJO?=
 =?us-ascii?Q?4z+WkIlAlXprdr17ydpXzKXTsZJGKM70Zqc2rmfPzEFruyWhSbVGrRlIgo99?=
 =?us-ascii?Q?mz7sEh6cHoV62hgBWmjRRdHcRciSc/wMPLpfYhliOBD8rTAa8MZ/jij6sKQC?=
 =?us-ascii?Q?zvaRorIb7HAeXtifZ6Tc5y9Kle1RjMJlm/PwEK68xXO5cgBjoBbvbNzbhC7O?=
 =?us-ascii?Q?9As3xho8J+nknMdnyOucZj/Noz5vP5gtmLw39Mfcbkdb9fRMTtrYkajKswD5?=
 =?us-ascii?Q?Vu9oogYaZUUz/5HwBXRTF9TZ9fNEwfV5ZM4iLKgt5A9zYp9VPcpBKPjlAiPr?=
 =?us-ascii?Q?A4NI5Bg6+plETC9Ijb9UtW4o2EydQYcev0KoLp8vBrXqmjQnkPiishNXw9Ww?=
 =?us-ascii?Q?0NEgLVhLpbGGHqdWLNlURcvDCJh689xGe0vMerdP8zSNIWGNNeHL4NzBrBqs?=
 =?us-ascii?Q?vH3/CS39DfnT88tjVdZC37SmFpmojLIexpjMDfM4/ggmH8UpOWrtF9MBP2k8?=
 =?us-ascii?Q?KNgG+Lpt02HxzgvztUIJZqbZUzIZKxJA3A1xPz28yV6jukFEfuZZ8vJsX67G?=
 =?us-ascii?Q?SJHk1dKFcyY2YwkM6/FeuTyrgTmVnizLKYIQeCA9fWAo8O8X0/+LZ6B3we32?=
 =?us-ascii?Q?+zBouTbHDQDMdOHaVvoMsDAq6tWI3RRQf1h2JsEbiC0S22YMYy/+nUJqpaxP?=
 =?us-ascii?Q?LrMv9yh4T65Atz6h3aG7UIdf0UIWYejgEKGaCslwihG+aC+aeZp3um8s6/UN?=
 =?us-ascii?Q?PPtwR+awRTj+Z018PgW+ufgSwG5FP/AkjXyQn92l6OQbbCyJvkp2lCvCK2sf?=
 =?us-ascii?Q?Li0SlwoSAAcutWeOL0RW2+FWiCXGW0btYWOmodXwWBNmQ5EDOOb6QEgCUEb4?=
 =?us-ascii?Q?7jMKvnCW8pY2cMSEvQ8ASJq7r+VfKlRcYuilLFkkh7CURiidU2LjcosTzQf/?=
 =?us-ascii?Q?aCNdINMNI1OH4DnszuOGseHUrFhJJXlTTWFwC2wopwiypfIOCYyPHbLQxIdF?=
 =?us-ascii?Q?38Ts+BqbQKL6mmsX06/SX4znvBdjdFHTYGb88B9/beEq4zrlLcBEjTbH3w?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6E6PHAw7ff1ZCPTtqBX0AlWEOeMezEaK37N+JztlsmiPwgaLc1PmsFh9zKqc?=
 =?us-ascii?Q?aNM98PYlOfYtMqghJFVc81cx2uctEbaIN1+vwbWoGWmnYmuD14EipUE/+dk2?=
 =?us-ascii?Q?MHaz9+r6rVW6scv4Hy0g9q6GA9GGrwjfqyuX+rOd9p//nb4GPI6myNPsAoFA?=
 =?us-ascii?Q?9VVsHlAHWus3EqAZPEzgw5JD0E/L5bVwODonRkqgH7Y0bpFmASwP6wT+ilU6?=
 =?us-ascii?Q?buemS2F6pRJ+nc6lqyF9EEeDR9xLjTVabdZEcWPYPqfY1AmsmK58Fl5DSzqG?=
 =?us-ascii?Q?d7Yv63jTmnl5vjD40F3AFoe2XUhQtC2pSxo8cLnGkXR3POy3J2fCRVJEoVo3?=
 =?us-ascii?Q?Bjn04+Ie31FcNkuxx7sIdSXLmRSvFuUc1AyTygyPAGerb2r4jg4xh3uXEo96?=
 =?us-ascii?Q?UMu72+qTTg9HTp1NKrpJr+j4V6otikp/g+ZDBPpVnVeCQNslFqePQ3DlHBWW?=
 =?us-ascii?Q?Zjg+mK+EoJnvSdw2uElU4Zogn9PG8PKA1p8XZef5ZcqocsXmm4S24H/zQwjN?=
 =?us-ascii?Q?YUAGCXjZV5DjpwqFtxpdzn/9Hsnh8z0fXFgtQQWdpBEoZGP9x3VLo3tUemlL?=
 =?us-ascii?Q?+HoZwixAPJFKTH2VQKsJ50k93IJJPnIndKpSstLAA+kRlpxIl1rkmSqPuTbV?=
 =?us-ascii?Q?j8Loo7L5GnErbDIbSZEgghvO4x4uSrpZC032oc3trXgQNssL1qXxXZ8/yjjr?=
 =?us-ascii?Q?sjGYllq2M8cOuTwHjYkqtwlMDYXKzDcLx5rN07/dMWbQl/bIMaX7/AL05OlD?=
 =?us-ascii?Q?RykhX5tNLGXq83kBmtzZDW3XUbxOS5Gbn18LVXrCiBPs/KHZ1qujZsapkRtL?=
 =?us-ascii?Q?5otTJGdMjLsbv5jq4KloG6N8DK568BTqIZJUv7B2DBMxenac7f3QhfmV0GWB?=
 =?us-ascii?Q?UFIPNCTu6rrlSiewSMxsYd4ihzHsT1LsAvMzgRVMUji+5q3527/Hr08WiLd1?=
 =?us-ascii?Q?pobEWUuC5r1x40CTuW8zJQre0DQJ9E66ZomTfowE6m24cQ8TRv8d83+D/6+h?=
 =?us-ascii?Q?3CQg3IOVnXhwvK66RzKoI41k3D1Zho4CWTWpIVUMNfcQYy8GkyLb5rPlsxTJ?=
 =?us-ascii?Q?tTeVmcQRMc+utiQBCxhFukoOocUO9HiHRuDjjtYF2cAlblJVUN5iqqgccp6W?=
 =?us-ascii?Q?qPKV5S2WR6XGA5setXe66IC/Xpp551nrExpfPVCWG42ZS2jjULSprhk4Tvdn?=
 =?us-ascii?Q?123yQjpa2jc1XEBnaf1tz2ewgPDyZ5hwvHRKipADLOF+saELgMh97fLfd0CA?=
 =?us-ascii?Q?Kb6KqU0Z1MhetCjJYbn9SyS/bDuXq2ah+NAagRBKw9O+ZyBEECD2h3qY4L5X?=
 =?us-ascii?Q?YrJJZ497PrVTDqiVM66TKuLpalYm5CwvJ4EUmYErws/M9YrPNfhdHXY+SjJq?=
 =?us-ascii?Q?nkYqTBkWjtejd8P112L1YNhvQkt453aM5WZZT5u03XuGkaq6LvlT2b4Nk+we?=
 =?us-ascii?Q?cNxXt933mLg2lrMVzOCru/DcXL6EwgRX0GaZImyy5pdqToz6FzOvkwv9URo1?=
 =?us-ascii?Q?uXlE81jKg6yFnLWVVoCiL2FYE6/1YkWbprrXcX7Q1HMCqCXGR5jmYN3uGqRk?=
 =?us-ascii?Q?i6zJb6ygBl2Uzhk3GeaPmi4Zf4q6TJ1mvpU/+OR5ulBp7BVzIITaEa5Nugm5?=
 =?us-ascii?Q?5iHpL2kVeYkg+gJsFjwdtQf02644UtqKRqNKBlMStA4jJXJKhUFEqDGuPZqq?=
 =?us-ascii?Q?GEdPflida3I+Xq2vxsPJNSULcsnWhv+S+Ds31nsDrtB/bhYwy+lQDVVxKpTF?=
 =?us-ascii?Q?8l9UXQgPSA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1a7bbc8-9b52-4572-8540-08de4d970129
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jan 2026 02:46:49.0590
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw/M7EcvtQ1pMfseUKAqkS4qh42BwjAzKPUNuaBdsWOhyfXTpD6iQ7m1Kpd5cC7V9VVAmpZvLGcAfhHQLNIKHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10332

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

Cc: stable@vger.kernel.org
Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Fixes: a528d1a72597 ("PCI: imx6: Use DWC common suspend resume method")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c         |  4 +++
 .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
 drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
 3 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 4668fc9648bf..d84bfcd1079c 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -125,6 +125,7 @@ struct imx_pcie_drvdata {
 	enum imx_pcie_variants variant;
 	enum dw_pcie_device_mode mode;
 	u32 flags;
+	u32 quirk;
 	int dbi_length;
 	const char *gpr;
 	const u32 ltssm_off;
@@ -1765,6 +1766,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	pci->quirk_flag = imx_pcie->drvdata->quirk;
 	pci->use_parent_dt_ranges = true;
 	if (imx_pcie->drvdata->mode == DW_PCIE_EP_TYPE) {
 		ret = imx_add_pcie_ep(imx_pcie, pdev);
@@ -1849,6 +1851,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
 		.ops = &imx_pcie_host_ops,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
@@ -1860,6 +1863,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx7d_pcie_enable_ref_clk,
 		.core_reset = imx7d_pcie_core_reset,
+		.quirk = QUIRK_NOL2POLL_IN_PM,
 	},
 	[IMX8MQ] = {
 		.variant = IMX8MQ,
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 43d091128ef7..06cbfd9e1f1e 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1179,15 +1179,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
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
+		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
+		 * when LTSSM is not powered in L2/L3/LDn properly.
+		 *
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
@@ -1204,7 +1218,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 
 	pci->suspended = true;
 
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 31685951a080..dd760c17bdcc 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -305,6 +305,9 @@
 /* Default eDMA LLP memory size */
 #define DMA_LLP_MEM_SIZE		PAGE_SIZE
 
+#define QUIRK_NOL2POLL_IN_PM		BIT(0)
+#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
+
 struct dw_pcie;
 struct dw_pcie_rp;
 struct dw_pcie_ep;
@@ -520,6 +523,7 @@ struct dw_pcie {
 	const struct dw_pcie_ops *ops;
 	u32			version;
 	u32			type;
+	u32			quirk_flag;
 	unsigned long		caps;
 	int			num_lanes;
 	int			max_link_speed;
-- 
2.37.1


