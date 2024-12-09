Return-Path: <linux-pci+bounces-17907-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D23289E8C4F
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 08:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAF0D161690
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 07:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31205215067;
	Mon,  9 Dec 2024 07:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eUn2tY0r"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2043.outbound.protection.outlook.com [40.107.247.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DB621504D;
	Mon,  9 Dec 2024 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733730018; cv=fail; b=elFgAy9whhhnmVJHcLjkBkG3URYWV+p4qwvuFpl1wQpF9UqSRceLm4+iQ9QhY///e6scXo8gh56Udy41C77d0D6LB0Be1aAuER7MBSh1/z7LhIwLCITAN6zfUlKLF1A80Z9O3ay6/JtnkRgzgjMGpP55nYNcQ4bKoWon9cYzSSM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733730018; c=relaxed/simple;
	bh=gGG6bAnnLa9sFPNVfiBXzq6XFOs1gke5Z3IUarhJ1IU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uIIUhfCcNVcNPay93LQYj4bKBFROcAyi88iE/Ncta7GVGAo1qKUoylGy3nfPAygJHXduv2reK1mj+ad8/IGfIZCPP52Shyt3pOp+IYmKHWuxP/1o/5VxsMu5Anegl6K7rlj0Vw8BXyeN+oSsM9qCkCHAQnXMi+Idw5ZH2tYtjsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eUn2tY0r; arc=fail smtp.client-ip=40.107.247.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ejsl6D/MxaQ1J6BS0m+JGivNYouJvYx2rQ+QegHTMV4ylum17h/b0p55rRShhGmAlenvcfKFivYpnwaSRcjrp8BXCaHIh4bsC/X9vbsHKmmq+Ze3XCEifFkHeB5WcNEs5gZurXAl/CdnBzrT6dTteJosFkIvEi8nrJL9/phe3bKw4QI9dLyoZp2jQh9Z3sj8z8mUOq0sTQilppeOH+elh1DybPpzlTJcLvPV8PwFZeG2C+6t0obZyhif48pRY5CTbjua1cdwPKuknrqbEkUWxZVhxK68OrNom+W9Y/B2GF5DTPH0PDQfp+tkyi7vAL9JlE8awGXdM8oKF2WBfs5EOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YzEVCLwtdOOEG0zIHeRC/sTYscASs4ylgFHzejcDpI=;
 b=f9JciCy7QWWtY/+WRiy7/ruasoFsoLK+TfKW9jlOjl90Kr7mWwK6fzyOYCeJ8wXklVY+5LKagQBUVCSSZXKyx2fK+K901JG6ACEopxwjRrGzj9w1/GdC8QgPuyo3on1p9i1gsBgn9R8dtximkT7d1T3I1RSnbjIlDRUYw9N+SiG5iDFn/tb7h7k4lBrN0sW1HT0A3Yg34wENtwIpXblgKvIiSt1W3UNEeSJbnIQILmTy/Cm0Y3p7r+e+RiVTkPT4GHCuuaIknuB6V4mRS44SumbFNz/wpx7c23Whl0pOxK+fC+fPAKErhoUwaswThnp9rBPPB259T4sFwl7qxOmPBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YzEVCLwtdOOEG0zIHeRC/sTYscASs4ylgFHzejcDpI=;
 b=eUn2tY0rrKqzaH2rtluel/rEIyuy4OqgoU2SIX8lE43gFgAQwExujIcfygRUfs8mXTk2857wXjAC3lzUONy9Aoa8Mb8Ko50g6tY5EiRrQC+vMUmNds4f2tGOiEpCoJQIwlmU6S8fa/bBXIVzW29wXwoUen5u3Omb3iRef908gC4aaS4+x9bAMcP9bpSKPQvfzBA6xcunrIwXBLQGsETq3vDw3i5UDknherGNVGjZzmKlvLMYixhEubhcmeCDtm5JDA6QIPGdb4E+kBBgduTTLfrG/cinGK2WTg4BLXnMoEuN8bz7/IUrJB7Je5/PlNcY0FjYb9h20dcKbrjUST8Zvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by GVXPR04MB9927.eurprd04.prod.outlook.com (2603:10a6:150:118::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.28; Mon, 9 Dec
 2024 07:40:14 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.8230.016; Mon, 9 Dec 2024
 07:40:14 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: jingoohan1@gmail.com,
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
Subject: [PATCH v3 1/3] PCI: dwc: Fix resume failure if no EP is connected on some platforms
Date: Mon,  9 Dec 2024 15:39:22 +0800
Message-Id: <20241209073924.2155933-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
References: <20241209073924.2155933-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:196::6) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|GVXPR04MB9927:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bbcc89f-9111-4100-9323-08dd1824b7f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hicgw8nyVGZ81/a/TXXi9MIpBXvlPB2v2yugfARJJHCVzSwWgYZboWdv1bhs?=
 =?us-ascii?Q?je5B2q7mnasvxWC5hj/ddx8/yu+E+VvLJr0UwQWdBSBNiHDJH2SD6ZGyY78m?=
 =?us-ascii?Q?taOKVnB0F5jy4HMB6QHYZKSjE30j1BjotnpOKNgWOJRr3dVCUEO2DKduDrhH?=
 =?us-ascii?Q?RkCCvOJncL+dk7a9MtlSzwJNqx2FUQ6UJV5Cdex/EDfRaSJLaJG7ZrE/dyWz?=
 =?us-ascii?Q?5S6CHGFU9uX/3cMrch6tv3QzzCoCQtbGlXkNaeruZvIRWvTRnX5dtUoRcvz0?=
 =?us-ascii?Q?H0hiaTF6Fms96Gx6jdyTSZd++px0u1tPRqmq+2OiuY9HoO4W8x5mW93TCEAg?=
 =?us-ascii?Q?Sz05FyBkifE0oKoJ2DKQquF4bfiMwyU6aHECCnUSdfvefllCa6n8n0fELXYw?=
 =?us-ascii?Q?UGH8Gen1sFUYS7wz8Dd0h4odS03CM+UxnLtp1mI4WD6vyd6nTu/qvcBLZZ6w?=
 =?us-ascii?Q?S0f7cU7IcRrRaYfsxoKDjG4XX3BF6pIEl5CnUx+lyTBHmcRyZxN5E2WDl5l7?=
 =?us-ascii?Q?Chsm5AtN7Kqrd2xZ1VYeqqCLaedBN8XwRfsF1e3sPiiUW/pbPP6enu9Ndmgl?=
 =?us-ascii?Q?LWKcDZLoXACKQpnNeOlJAbCjiY7aLLFreKygA7A01KOPUt3J8FjkQOMJQKCz?=
 =?us-ascii?Q?WjMGACeMTOJK+SftwrVCBYWVZ8Ay326LEAS1IS00827HLVAl0CDLSsvAUU0M?=
 =?us-ascii?Q?7WndRSdiFQpNK+KuEJVVvWZpo0otLP1qzGxDQ4QujsGfWIChAogpoKiYgsdd?=
 =?us-ascii?Q?u4d7xsjXV0ATb2WN/adZg0H1Y96KJP4OldBpHB+hGHGnBTlrBdNmlys7vokm?=
 =?us-ascii?Q?/M8qq8gYANdgxZdhbdFuAdcWk6/SUU6TIyn896IWhDi4s13Q7ajbRseCes0q?=
 =?us-ascii?Q?yeReQFkOlgkn7IX+TPQmVwXGiNPFF9B/+iqe2M/fcnmAp1HHmOuN6LlygR0n?=
 =?us-ascii?Q?v89Vbh09B35UicofHu5W2SpZu1zyaiuo4i7qv2xMUHsCnsZ0kiBNy09SBgqD?=
 =?us-ascii?Q?ORR0WxsKLGKP1NKN3DJFt+nmdvtdB9m4+q8mr/cX4R75eG4n8HG2mTDJ42At?=
 =?us-ascii?Q?nFaxHcDxm6rbtchUkHVCJOe1z80TvpJ9Vmoc4xrAVUssXZyng8uxlZ/TVSV7?=
 =?us-ascii?Q?eJfHk3KukortxPDep8bM/R5ck4SH/NQj27oRRk9VOoB/kKh6UdbApQT2lW+4?=
 =?us-ascii?Q?D6umkRNRXwFlyXJMAAogX/8QFY992bBa6nV05xJt8tbHRSVqj+x9uh0UzS2+?=
 =?us-ascii?Q?0er9WopZqIF04QaILPhlI2Am9+GooskQFHHookFhlCFZhLkbm1USEfSMxqzN?=
 =?us-ascii?Q?Qe+guUviveohkxp2TTIA6FVLk3N6timvBc0o2Zd6B2DiKKMMf43mEA1Z6Hfm?=
 =?us-ascii?Q?DP++IvH2hPXymM2t/fIchZfF0r/oKOXwswlzTsdTsnP02yTwIA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BRlsCWuPmoPy8sm5DQNs7grn8wZh325ysb2STOOcERatgUWnVTech5NwoG3f?=
 =?us-ascii?Q?/DjHi3ALzaD2Tl46hjiFqMPfSpTXLBQfnAraEbdHtT/ZpSdFJdJFq7Wf9Ysk?=
 =?us-ascii?Q?mBwdh135C3cPRomqGojOjSv24ILpakKslLnfwAO01xB3AWqD3+CRN7HVK5EI?=
 =?us-ascii?Q?3SrKAQ4XacXYtJY821CslitdVOGFluiif4+0o93Vfi4NenZ7AfWn7ROEA0LQ?=
 =?us-ascii?Q?hd7+uuXtLZaSVNn1MUOGwyw3o9o0cwbkV/h+bDnv6vRa5Lef4PfiVVy6pBnW?=
 =?us-ascii?Q?TS5MBYJ3fjf8AU9V0agkm/AEcqnS2B5IoOKIeDWu+dHqurvY0WEyjUtEZI77?=
 =?us-ascii?Q?RQJ8b5HUmRbW+/Tr7iH3O/n7IFYyUTBYfiZJcdqmtbi8uNres2ic1t5/3qct?=
 =?us-ascii?Q?FK3bFAQs+ohG16LMhQBpTqmr9v/jFbwOxGVLEuU4uiIJjAifpkOayqftBnD4?=
 =?us-ascii?Q?dBoGP0T8HvEEG3MkNSercG5lGdg73QbqS9PG/xQbygMCztDYX37yMgU73WVk?=
 =?us-ascii?Q?6dHS1Z1tzRZ4nSQ0vG9jUBpB/sMzdOHPm9xYAjONCRhJrBxcUUTOe0dn0kp2?=
 =?us-ascii?Q?M1pcqL/Yh6BAwB0XyQHCXMEzyo9G1Zl0KhfhMnyorsyF5bNxzGozOEp9Gnxx?=
 =?us-ascii?Q?w0QfxLJBrcLL5RqQOhDmo/UBqmi+8v1dToqsv+3uk3yhOEJvXkA+bgDDHCSo?=
 =?us-ascii?Q?yAFv9JzTnIlwCiaJwkwC7LJSnBGG1ej5C0x7G4XLeCNCt7FqF5Wrttlo7mu+?=
 =?us-ascii?Q?0+FcI57RnRO6wFVyOOKqUBfWv0/pREeJpQAdotZPMbOUIhLeiOZogRKzbKjU?=
 =?us-ascii?Q?+LDDI2O/XYKFiXcBEMu00Gos++D2eqg7K+DiikxKSqVMlprhH5YPOReebCsT?=
 =?us-ascii?Q?6byWkgl6srErc0s88o30P+xDGXizePAuQ+WHN6FO9BHJ9izhEUxi1moiVyF7?=
 =?us-ascii?Q?Tf6MjuIxbqu9aUpxN1RbDsvy8D7mJeYaVK+/j6KB05i3k6PBtMqlorHz6RfF?=
 =?us-ascii?Q?CaAkbqwGjobZ1EwobbY78he8azL5SLsGn3mAqdIzBSPGSzvjdAchcITl3ec7?=
 =?us-ascii?Q?XeyagF7/w9O1ewzILNPbGr7Iw1Jo2BlYXBbTMO3ZSGVM8uO8VAYE+R+doZ7q?=
 =?us-ascii?Q?V87t+EGLz8HTV3k1IXKU+EPchiRNaomKs52/+9JRl1ObzWkb3wfv9/FsNMkL?=
 =?us-ascii?Q?1lupKlWlFrE47oSWLr5GQz7ky3CFm3fwYBqTA7+IVl8Nx9v16CRsucR9TJOA?=
 =?us-ascii?Q?Un9eFdOGwXPJQ/eK8lloDZiPZqEVb92IUx83PI4GqTg0kmyReclnoXESy4R4?=
 =?us-ascii?Q?4ANDpv5KqCEfRxkuJUipcJCs8KZTSH5wzGKFzKtb2cMKKLx14O8LONwkAnrd?=
 =?us-ascii?Q?P33AWJlQBQ1BMwMcoFY7FyTWvpQ/7idcCGJnOapCJNalme7a4BqtrTWy2IH0?=
 =?us-ascii?Q?J6yWaOzFm60ggRPReZhjenlb+J8dRg9AKg8ymbywb9oRQqXAqemkHDuMhSxw?=
 =?us-ascii?Q?bPaC8wI1v/jqaab8jBcFqi/u+X1hztYa+lx/k7Z++nLpP3sAITFIKK1RICSD?=
 =?us-ascii?Q?NwhIPfLqfeIG2rb5T4ydcyHiLSoo4zklLdwtlaKO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bbcc89f-9111-4100-9323-08dd1824b7f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 07:40:14.2561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IQ5b5qA0x6napWzljJwjPwYFRht0KJfg7dzFRbUPoH8ngewc0rYBJwSkW0E/n5GUyQB4Pfq2LgJy7QMZFG2piA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9927

The dw_pcie_suspend_noirq() function currently returns success directly
if no endpoint (EP) device is connected. However, on some platforms,
power loss occurs during suspend, causing dw_resume() to do nothing in
this case. This results in a system halt because the DWC controller is
not initialized after power-on during resume.

Call deinit() in suspend and init() at resume regardless of whether
there are EP device connections or not. It is not harmful to perform
deinit() and init() again for the no power-off case, and it keeps the
code simple and consistent in logic.

Fixes: 4774faf854f5 ("PCI: dwc: Implement generic suspend/resume functionality")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 .../pci/controller/dwc/pcie-designware-host.c | 30 +++++++++----------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index f882b11fd7b94..11563402c571b 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -982,23 +982,23 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
 	if (dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKCTL) & PCI_EXP_LNKCTL_ASPM_L1)
 		return 0;
 
-	if (dw_pcie_get_ltssm(pci) <= DW_PCIE_LTSSM_DETECT_ACT)
-		return 0;
-
-	if (pci->pp.ops->pme_turn_off)
-		pci->pp.ops->pme_turn_off(&pci->pp);
-	else
-		ret = dw_pcie_pme_turn_off(pci);
+	/* Only send out PME_TURN_OFF when PCIE link is up */
+	if (dw_pcie_get_ltssm(pci) > DW_PCIE_LTSSM_DETECT_ACT) {
+		if (pci->pp.ops->pme_turn_off)
+			pci->pp.ops->pme_turn_off(&pci->pp);
+		else
+			ret = dw_pcie_pme_turn_off(pci);
 
-	if (ret)
-		return ret;
+		if (ret)
+			return ret;
 
-	ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
-				PCIE_PME_TO_L2_TIMEOUT_US/10,
-				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
-	if (ret) {
-		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
-		return ret;
+		ret = read_poll_timeout(dw_pcie_get_ltssm, val, val == DW_PCIE_LTSSM_L2_IDLE,
+					PCIE_PME_TO_L2_TIMEOUT_US/10,
+					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
+		if (ret) {
+			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
+			return ret;
+		}
 	}
 
 	if (pci->pp.ops->deinit)
-- 
2.37.1


