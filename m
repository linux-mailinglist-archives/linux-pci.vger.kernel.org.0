Return-Path: <linux-pci+bounces-35006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 716FEB39D3D
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 14:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AF8D1C25D78
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC0430F547;
	Thu, 28 Aug 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="jenCrInA"
X-Original-To: linux-pci@vger.kernel.org
Received: from SEYPR02CU001.outbound.protection.outlook.com (mail-koreacentralazon11013019.outbound.protection.outlook.com [40.107.44.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E5626AAA3;
	Thu, 28 Aug 2025 12:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.44.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383974; cv=fail; b=KO3lRx7vPxts9dUSvcXyVy8AVjgZlFtoCbUz84iEKW2DzW6QlmZt67jtcg0fo+G/9lMyUncEuXyaFa9nW0CcV81pxyyToiKkb031w1heru1u3QEMQCzPIYrKF67MFTY27z3/NtPzRxuGLQBBX/hMa4TPVcl0DzcOI8/xWhVjA04=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383974; c=relaxed/simple;
	bh=ziE0Ii//wEWZdQvIegbD2lg2ZGLTWhGNLdN8255ZkMY=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pG128s9bqNX50dNTl+hNCsjhxCPLoKINxWtkhtfpATRHAyvr24vurn236Z66MgLZev6UjArXsyGUVs+i/Q/tkPqKMJZY/gewqIyAaeUNPzlEBw7591jlQV+pAzbt1smbUxGHi852VILiMbj2p7eWymwa2ahW/cTPn1FbSjI3z3k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=jenCrInA; arc=fail smtp.client-ip=40.107.44.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aovzHbif5Jse01/jKCVK5pZCJ/MYkGWx/AHZVtjbXRCPHuH6NVLjeI7zJ8vNjdPrkzp7kMfiN0ZaKjyG6AvweWIuEzV8BnvG8vvnxgs7gqEyw9KaXhdRZpTuApawZxV+NuTN7ucaMr42UUIfDucRB61AjugOfKr1U9P990KOGH7sqdPTO3XWrhxKBlkcSHwz0U17Za+3z948SQ3curmjvyS4LyLXljzOGhPPA+CMaoUd5dLXGJtiOnpdT/sEYScNemwRAa/RezabYUiyCN2SVppcMyzH4XHM47w6+/R/lAfuNEXejKuM4OQKSmu7ekgtAUYqGNEQlAPoiaUfjLQRMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C2wAUDXWJgkQtl4kIpjWBeqKIRUuVdSCKdV/19OsfFk=;
 b=gQru261D4kVF8VW2cT3aZYokndznjso3OVuz25WDP8tINA6YH73nEz1fGhdflsrz9oGtekLDylGMpYGrYafjiQKXpaFjhbF15GOt/pqvM/vXZxoCPI/66Y3HQR3zqd/dYzVozSUGe8Noyoi8XFLr04FEMa6kv0XbL/WRY6GG1kCxqWRajGk9w1m6NfzBLkfB+NUT5B+CqgGhg9p1D3Aob7qY54DvqrYPj5Y8amgi6aVuGsNso+9Q8SIkzw+NDCc1INo0liTy5pazg7b5Ds3B/1J/CtBH5/FSwnVFsYPVAqavN5+7dnCpY/OmvIA8gjSo1Uu9bJsahASM1nzGseSUbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C2wAUDXWJgkQtl4kIpjWBeqKIRUuVdSCKdV/19OsfFk=;
 b=jenCrInAWiza/4D8MmZFoJfcPDrTVqz6O0oFdWcgyWP+Vc+YKcZF8v/2jooCTJZ0HhGiLcYJEhfZYB67hVNjEXyxtKnkKBHYYcTv+YEDddSNA2bhdXDF0cbbipnMMInjC5kA53rtZJaBePg0ETzxGk9SamYCok4Pcz9H7kJXDiGeATgKjxATNsewUOYM0kK38jEKpK7N/n2nlJn6Sq8um7LKczhLaZu5E8QA7J+/1fHsYlT9XNcSfd74Kh1XPtGytaSu1+HyCCCDdFJAsb1naaaiNdi+DlXwz1q3pUdRcjX7JeY99bUvmtIsORMYT1FSSH6oyJ3MU7KrewMRGxVR4A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com (2603:1096:101:c9::14)
 by KL1PR06MB7287.apcprd06.prod.outlook.com (2603:1096:820:143::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.15; Thu, 28 Aug
 2025 12:26:08 +0000
Received: from SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6]) by SEZPR06MB5576.apcprd06.prod.outlook.com
 ([fe80::5c0a:2748:6a72:99b6%7]) with mapi id 15.20.9073.014; Thu, 28 Aug 2025
 12:26:07 +0000
From: Liao Yuanhong <liaoyuanhong@vivo.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	linux-kernel@vger.kernel.org (open list)
Cc: Liao Yuanhong <liaoyuanhong@vivo.com>
Subject: [PATCH] PCI/VGA: Remove redundant ternary operators
Date: Thu, 28 Aug 2025 20:25:56 +0800
Message-Id: <20250828122557.35025-1-liaoyuanhong@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0248.apcprd06.prod.outlook.com
 (2603:1096:4:ac::32) To SEZPR06MB5576.apcprd06.prod.outlook.com
 (2603:1096:101:c9::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5576:EE_|KL1PR06MB7287:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a569911-9805-4a24-c972-08dde62e1081
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZaQNYvWUIhK+ikic6PpBLKxPSkhPGhNTsZ5Tt92n5WzMaJots81ycSbWsZgA?=
 =?us-ascii?Q?nR1jKzv1m5g28TL7+jj2RBzLQSvZ7CGJAmMPC6UDG4aC3TsvPym8/A6CUryH?=
 =?us-ascii?Q?MXGxs5RH9JMn7VAgP4RPImP/f1bne7xzlZ5QtajaeYDLS3TOh+VMSmCyLPqg?=
 =?us-ascii?Q?obDQ8oLNo+oC2V7Xg11zCopeM53t02eisFnHYJzM1nMA3zMhZbnMXI+Ls1XL?=
 =?us-ascii?Q?5Cm+9us8jgve+BYX66NvJYfYIOP1pxosgNaDTluszmVG/GEvjIfAQrayi/jl?=
 =?us-ascii?Q?yTY+3BRMY4+XmU8Lh5attM5EgXokJj5TNhzZHPvrdakJfeRr6L/zv/BI0Xc1?=
 =?us-ascii?Q?gXKbygHsZuiaGHyopBZqRqn9Xv0Q5i+SPbruPs5383MhC5VgZPzmN5g0V1SU?=
 =?us-ascii?Q?0w4GecJKogpE7r+k6gB4uKjxRZ95NEiCdyE6GkXmy7FfmPo7fk04YB9F5XxM?=
 =?us-ascii?Q?Z93aEyTU9sQaVxpurDtepbqLax7EaUnUJ6f7VsFkzecPYeze0LYRSBoRHX+2?=
 =?us-ascii?Q?mccCJ9V61t0sqkNhpXcqFFnSC1KGLZYkekLCXVFrUVZUmLyA3sNM/z5CMj+6?=
 =?us-ascii?Q?tUzVPv59A2nqFkkN6G0yqHEh7usKmo70vR48mQsf9GdGlom9pPeMzcdxTdeK?=
 =?us-ascii?Q?cIQ7VS47jZwaCGceDfluU0ey1XgZ9ui4eFzc9WJo78jjXWy3+i653Brrf+fw?=
 =?us-ascii?Q?RflFIerOp/mjuZKm46kHqJG/YI8047wznYiSx3/GAaCwJ8tdiE6w6siqOo9r?=
 =?us-ascii?Q?3eoK0U6q9NmCld4x2LAz8V/n95SMk+0RRNvK7c8FENnM+VaJfDY5YbE/PfgN?=
 =?us-ascii?Q?20Aq635J/G0jUEd692SpFUgMzy2mKcefMtY6UfYQDh+jbhQLtq17UqGgboxI?=
 =?us-ascii?Q?tpzgTO4hs7jYIBw7Svcwu2XhHoHqiDloZkRPxVN1H4undxmJIrql/7DzrIZz?=
 =?us-ascii?Q?utpIZMPMHlget4JvaF73MGBKMG4o4UhN4Dc7a91titd5+afmobXNObRJgDrJ?=
 =?us-ascii?Q?OQp14//sAjt8MJRHuK+nO0aeutO7iKKfLrrJV9chGrRNu4ASGXSgAcN7XQlg?=
 =?us-ascii?Q?VIyXjaEWcPCfMshmI3B3TTghnZUll+bS+2+AeTwNvXW0gVkbzJxKA/aQWHAw?=
 =?us-ascii?Q?+iLKpiwGTnyxWdL37O5DXMojXWXwp5xO34z/KDg57ZAeyU0Nc+yLxNIOk09f?=
 =?us-ascii?Q?u62s0X9PbwEHuL92Fj8QLEhE/AYokl4zVOiWwehXKaelBXO1so61GpbHmCnK?=
 =?us-ascii?Q?sZ/n1kkTOgzwl2YEV4+tvjTCuc3Ct6rhEMX4BVlvDT0SGg24VtjapdIeKhdi?=
 =?us-ascii?Q?rCbYAYals8WaBTjmfel8oaHkW4SeF2AbdneKvhxr2XGbVuywzVIx++fjzxpY?=
 =?us-ascii?Q?nf0byyxhV5J7YwfX87J8Gx7N48yKUe/ULj4fQq7ih8sPuP7B8/dlOmCcjNFy?=
 =?us-ascii?Q?/HtTGMbgvcdcLGeSO/qKOEdreXN4QiSh9a1T8ZJB6VuhZvNLUmu/Qw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5576.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SqaUp97HipAu9M74+yOIF6eFT1vQF6aINyoFgmsIh8MjbJIzcHLiQB9+KwOi?=
 =?us-ascii?Q?AzY4Y1clPh9PG0za1Drh0eqJnCoLqJPXY+UH1Ks9REFnUksEV+VAfz/y58/V?=
 =?us-ascii?Q?MzAndUsrfTYTuxOv9mOYykYMrsSg2J9gVKK2uWMv7nRzub5k7Xlqu7yeKlIf?=
 =?us-ascii?Q?Jq/vcPFUCt4/AQlqnlH+0CVNFfy3GLVS2nrZUobTs7KB/KdKC20H2aoP3057?=
 =?us-ascii?Q?OeYmZD2H13BGXDz0LtNtzarqXOS9DlAH3gwRBXBGrjVuArxerDFpfKhH1Qvc?=
 =?us-ascii?Q?mxK4X9hnoV7hM/1cO7X8W/xEqI1tjqlQcJZwLcdZNttKtWSIpQLnbyzOxH0m?=
 =?us-ascii?Q?aCi75DkczmEqECh+Q96a3PoTUWuDm5BfukKqUnHsPYHIIji7TTU5rX+5b6SH?=
 =?us-ascii?Q?5OzEInxx+eIdksD1ys24ek19ERlgqvuFM00Ph4rlNlR0lQzlxQLZPxqpF2/B?=
 =?us-ascii?Q?DmxstGvAP2eZZJya/0ntYZmM+mRGwF0NnSL3ALALwcLLT52mip7fpiIWbajl?=
 =?us-ascii?Q?KB7l+Tc6cvg8rYQogVbIr2JXaZ5uovZo9SHfuZwpOMcMxzgGPM4OZsYWdy5M?=
 =?us-ascii?Q?DlZPQPZ179MWUteio+5Cc8pnaL3mEWqAQmWuQSOQ3XFRf6/e1JVCcXN6jh/W?=
 =?us-ascii?Q?1I9kLCSMHBHCniax2wN84Lu1HDur4ttRIZP4lgucWzppgwCK9tv/zWZ5Jxc7?=
 =?us-ascii?Q?Py7Wg0KFRFMyRVWxha1silyiN6PEr/4fDQDhj/31TJeZeazbO+H1ptTLmcFM?=
 =?us-ascii?Q?H2L/WDC4vGEG8kTZlYkArWOeYM3nT99dmKB0356jVaT+rRgL9KIXyA2hir7X?=
 =?us-ascii?Q?kl03DARFTatDzHSiiElhGHOZrotepKJ3EeyHbtq9n1Hc5d+QqMF+tyemh3t3?=
 =?us-ascii?Q?HI0k/ljJQuaEs/CujfXn2SvH7hzuTnoI7gQhDBwPXPyBUcf2XELDBbaYX1tW?=
 =?us-ascii?Q?g1oaoChIBV9IM9Cirxon4NW0fLjNWknTF6A+89djNbfIMpSoVGX7SRUVIcn7?=
 =?us-ascii?Q?Y+cohsF+9gY7JpyK3vVC99Qqys/pUO8goK6c1A8gH3b00igzEw18/QEipKgR?=
 =?us-ascii?Q?EL1r2ZmyHqbvCSJU349hrJGrpRb/AbWYItuuj22Gymfhph0/ckxl8xyfpFy6?=
 =?us-ascii?Q?S5aK0kcGmQ2uacka1iTQXstHMQ3PL8O4PaZQr/n1M8MGzFrFA2lkIRM7BijO?=
 =?us-ascii?Q?3bN3W2PUFJC4rOu2PVj0keMzVsIKkkqE6bW+paqFeU4cIOCUYHD084ghm/JC?=
 =?us-ascii?Q?grRFG3vWKFdQ2McaZaJ3QFt1U2MVVoaYwiBbddhl7KImM2qcfS2RPZNvlZJJ?=
 =?us-ascii?Q?zPPsIftEDmFzREv32ozoq3a60mapPAmP4c7ylHsELnSDALaZwwUfV8ag3LdM?=
 =?us-ascii?Q?7N5FgID0ZuDLT1gW4zwusQECYl25qMKWI/c9Df8yNAWeqcco+z26SNtIHGTS?=
 =?us-ascii?Q?WP3rMtJRAfM3M5ry3VkJuMLVIUJ61GY1kyL4rF7ZhM6OxouXEWsDuiVzL0pA?=
 =?us-ascii?Q?9pBojLvGvB2qEVwH6MCAbXrNt8b0K09tlQIEHDWJF0cSdSxHTTZHaKFWyn7i?=
 =?us-ascii?Q?xzDgztsnTKMDR6xTDNte2UavC4p6njsJXmeU7gJ5?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a569911-9805-4a24-c972-08dde62e1081
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5576.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2025 12:26:07.8396
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ewKSQbc3/SSbQL/gfe/g2tjQ+OgxiVOuIysUvowWMHWrfEeqOlKT17++DjiDN0h9fEzrjUrKQOGNuvKb47tP3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR06MB7287

For ternary operators in the form of "a ? true : false", if 'a' itself
returns a boolean result, the ternary operator can be omitted. Remove
redundant ternary operators to clean up the code.

Signed-off-by: Liao Yuanhong <liaoyuanhong@vivo.com>
---
 drivers/pci/vgaarb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/vgaarb.c b/drivers/pci/vgaarb.c
index 78748e8d2dba..abc84ef35397 100644
--- a/drivers/pci/vgaarb.c
+++ b/drivers/pci/vgaarb.c
@@ -1477,7 +1477,7 @@ static void vga_arbiter_notify_clients(void)
 	if (!vga_arbiter_used)
 		return;
 
-	new_state = (vga_count > 1) ? false : true;
+	new_state = vga_count <= 1;
 
 	spin_lock_irqsave(&vga_lock, flags);
 	list_for_each_entry(vgadev, &vga_list, list) {
-- 
2.34.1


