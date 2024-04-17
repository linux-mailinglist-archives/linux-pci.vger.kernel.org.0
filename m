Return-Path: <linux-pci+bounces-6369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653EB8A8993
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 19:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878891C23786
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 17:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8FB171E68;
	Wed, 17 Apr 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="m8HDRPFJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2070.outbound.protection.outlook.com [40.107.241.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64006171E5E;
	Wed, 17 Apr 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373221; cv=fail; b=anpkpACpT4Zqfq8qMn0oND019FVskSUP9xt2/6oMqgomJwIFmzpsmVGvbdOd800hD82vMfll2bQHdz+IfL2ciZT5fFxhDK36m0uXIOnFWdLR+hTLiekRxuqTMJW+b3WydeoqnRniBqp6qg3cGpjriUDj4BUJflBc/OpnSqi6+p8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373221; c=relaxed/simple;
	bh=iaMVhIlaxnDKrjo/B86UwmBA4lUHgRwjSU/hHDluay0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Cu7ApNHwv5TYcNlBxttGNWVM8xCG7lg8aJ44z9dkiWh5cL5qb3b90Y4Kmxsp+oHp0KuA6yfDu+wJ2M2pDuk/eOSQPJzjRIwwA4Yk83ScuiRHDP2GfiUSG+r9wk7jA7Gnn9kdOxeLUsI3sOxkai1jUVMnrpzKIMMZHnAzhkdW0Cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=m8HDRPFJ; arc=fail smtp.client-ip=40.107.241.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J6zcTXs0DDLHgwbs+vbC52ysB4Zz/lx9U7PRl5wrJiTIpzfIHqxMAbIbSX1XJ04GKGXsovznyIysRK5UGkD9MuZ/m/A3HzgVNPt+mKkwcHadhosCKD8vAA7YIwJgH3+708MaML8c/h+2yc3aAgCFV7a7TOlt5NSXKOngeZcI6Fh+ccMh74AgFmxiq4O4fKoTPAr9SjTxuzaTRUPw9zxPqqFNYJMetCUL34yU0Gzf+rUEnyFGlx5+QldyqpaAcbyOyQBESycPsGPONeyzWJMbTE6kalP8igw0Oh6UofzZz/QwzuJPeP7YmdCmzehDYLLz7OvK0kR+rhaB+a4bC10vsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=b4B2ON+T1XLZzgPdwu2/kLdBLqnx9bAaLhUe8G2eGuyOo9ro2VsWMYOY126MknzMIv2WkD3v6YNVR75NlWzRXD8Dn2VCF9VjK2fnLfKFURuJnTB0xOmvICdli5nuQiSfNrgoUvf1HQIFI4u8AoGzys+6A71LYMhchjGol4RzAAo9Fgznywr7KpIfjWoZ9e7lG0wug5YiTvRnjDxUitRHXPhGUMtg2MluykgGAKCo/DKcXenwLFJK4WUm7WnU/r4KkAsIr1919B0ZpIZ4FjBtGLQise9cMLNdmB58Bl0KAr7PdEEsdyH+pwD26LD/ZNWh5OX4T+DBixUAnvVmOxbdPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wqraZNkbMXJ8bdVBUWBtPeGCWP+ilAu0pVj9SSD+e7E=;
 b=m8HDRPFJ6mPzlHVfsaTlAvdi574rCDkVpUG4ET4qK/8ej/ER1pHF7UtNHACv9z8/sCi+6JztEqIJlxz0HEp0BdLnCMJ27XzhtgMbBVSP4lKjprn2tP3IpLhcFg9LL3WF0OQTTh1rVCt9vDK/BLEbzqgvnd3LcpKpwCXyigmZ6Lo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PAXPR04MB8080.eurprd04.prod.outlook.com (2603:10a6:102:1c9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.51; Wed, 17 Apr
 2024 17:00:16 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7452.049; Wed, 17 Apr 2024
 17:00:16 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 17 Apr 2024 12:59:41 -0400
Subject: [PATCH v7 3/5] PCI: dwc: Add outbound MSG TLPs support
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240417-pme_msg-v7-3-9c6208cda90f@nxp.com>
References: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
In-Reply-To: <20240417-pme_msg-v7-0-9c6208cda90f@nxp.com>
To: Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, imx@lists.linux.dev
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Frank Li <Frank.Li@nxp.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Serge Semin <fancer.lancer@gmail.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713373200; l=2940;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Vx141tscxeq3VO/J2v1vu73YFB2QjcNfIuChtPapKMY=;
 b=1LJpCmMiRrn4ck/tPFNQIu4iwmBkMQrz/+4zZ7FIRF6o62nq/4aB+jeLcansIJ5XeQNg+sqTF
 mLo9gUEvsstAX93OIU72wiVKR343Sg+6xwkUHvJu3WYySNWXyB3Z/gc
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0012.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PAXPR04MB8080:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf56f52-e684-4e94-ef21-08dc5effdb05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	JO7+L8Y3052c0eqeXF+2FbdkgnX8i0jfgtCkCY2vMI/rfmtXdb4Hj0jp6O25loMaa2NY1qt5iJ7fvIGyUDmYQWPbh9ltSAlRrskVa0iKNv1K1fR15VSTQYo2ewuPtsR88i0Xd7fzQd1e4Z8QmdXAK4htp4SAWtHOLtMmPOpwWkIKp1pCMc0evYFo1Lod5Y5v5uvW2eMmuRkn0JNB/TIuy/fi/1UTvZkywimT+v5BaSU+NatnlcCibzwDUl0R27lk7C6eZU41lZWk+F4UDcm3/vh5pgLCwlVIejPIxgHEjcsfb13iBRFXCAY1Vv363CYqDcrSTSNyhU0dU9eyYISq2KxAU6GCpfBArCSZTEYo6r6Z0KNNo/gohQfja/pKTOzqgnwitmVX+QX3bvr+4YRvwcdzReSau9SFU/N8kJ6h7rHRbkpfQ8rldyo3DPNRulkGGA8bXpXASQqAqcbJ82Aduk/sMR5Jn8umbGlDyrWC8PksL6SNV3RCzdIhMtp7Mw0kQdZGGvi48UBYFA/++U/hWiQ8MBA6w8fSFJDnQ3uMEW+/pFe3F8BcmtPOVmpIOHbK8lsoFcQBRf59rMTHNnQ0K5IlC2q9JmJRNjhVQA34MhO/l63GcYSoehKhiHgMIRwzrxBGHMKPlUGa33P5LEEzFFg0loNqsG3sAZDBubtw8DMlKsNablsjpM53JqRRENtR/CkKLGVWR4c5d5t37P0GlbcE9eCAIsLhM229ZUYC06E=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(52116005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UlZvYVJyTzlxd2M2ZDJXVVQ2TmJvZFpKVVFVYyttbUxpbDZpUDNtZUl6UEtR?=
 =?utf-8?B?Z1hUNDYvZjQ0cm94bVFDakYwK29oYnJFSHJibjczbmFOQnI4a2R6TjczSFl3?=
 =?utf-8?B?M0wxcm1jN2NLaHdjUW1rczFQaVFnN2p3NEF1QkNZbzJ0M2I1cGtmenpDMFAz?=
 =?utf-8?B?Y0RiVU41U2ZodE11T3BNaXQvNURUY3RsVTN5RXdISTF3NS9vRXdvT2VQT29Q?=
 =?utf-8?B?NjJYTDJXZ2xXRktHejd4alFJZ05OY2RPUGhZdUhtZnhveUVUQm1wSEwrOGpu?=
 =?utf-8?B?bHlhZFlBeTQ1L2k2TEliYVE0M01kSld5bEdIN1U2MW5QWFlMSmZqcjlFS0Mw?=
 =?utf-8?B?Q24yOTNHaWRmQUJ1YVNvTEpNdGhWTEYzaytvYXVURFFOZ2sxZXpzNzJlZUdN?=
 =?utf-8?B?STZ0T0VYdGFGbEZsOUpEd1R6RVRwdVR0eE5wTisvenVJR1krWUdZMlRzWVVr?=
 =?utf-8?B?SmsrTTFuSm1SZFJCVEZRMzQ0Qmh6ZWlMWS9rYTU4MnpxUVVLeUJpdTdHdzRG?=
 =?utf-8?B?VFBLMGhvQ0tGbndxZU1nMmNqTUtXR1pLbHBnTHZ6Z2laMG5veXVWRVpoRm95?=
 =?utf-8?B?YmhhanMvdWtUYk1rNmQvb1pWTk1zL1NqRzNtQUdGZTZ5UHFPbk9nVlhYWVM4?=
 =?utf-8?B?dVFiaVN1MDcrdUJwVXZOYkdXYXViekxPOU1YUzAybWMxbXdTRUE5ZXdrUWp6?=
 =?utf-8?B?VmxobVFOdkJhSEhvemFTRW9NTUVQdVpmendOeXRnM1Z6ZXVDNWFWNWJkSFpx?=
 =?utf-8?B?ZitYeGJaMlZibmV4WkFtcVR3WHZXUWE1Y3A0RHBKMFFMcm1lWXJiNG5ja0pJ?=
 =?utf-8?B?cFdJRng5RUp4cWJvdGRvZWs2ZlZQN29xdDdISHFIYUVoM1VIVjArdUg5Mk14?=
 =?utf-8?B?ejFZV3AxUVNxcHVVRG5QTGdIbE03R2hCY2ptMVljUVkxU0VaUHM0ZTFENTJE?=
 =?utf-8?B?QXFXZVV5MlVBbHRsVmk1YitVV1ZhK1Q4STNJMWI3emdlcVpvNmcySGRpek9h?=
 =?utf-8?B?bVUwZ2IzYkdRbkRyelRXanNOb3puL3NLZy8yRS9KU1lCY1FDUUE1R2s0Mit1?=
 =?utf-8?B?ejFQYjltYmp5UkcwTzZpMFFYNWhNY0VoNVpiSDVnQWhJa0svTmJ6dkxQNEF1?=
 =?utf-8?B?ZVZzVXhtT2R1cG5hclBpRzdqOWROYmYxQWFVTVF6M1ROdkdFMnBYczVWMFFk?=
 =?utf-8?B?T3EvMEdUeTEzTkJxTW9NT1U4Q0pHOUhtdGZ4TXdaYm1qcTRjYWdRUDZORjl2?=
 =?utf-8?B?R1pFZ1hjQTQyN0daTnJzSHhlNDZCb2d0bGlmNENDUTZKeDdsVFhlRU9KeTN6?=
 =?utf-8?B?dDBubHFEMG9iTWJDNjk3N0FZbHMrNWxseVR5cXB3YkJkZ0E3c2xLTmt1KzRh?=
 =?utf-8?B?S0d4ZGo0a3BxNUNqTFZ5dzFhaDRhenF4SjZ5bC9ESVZNU0czdzhmaE5RcVZ4?=
 =?utf-8?B?eEN3Q2RPeTdEUU0zZkE5VWFTRm4wNGlxcTUxaTVCLytTczRjenVRcGdKRVVz?=
 =?utf-8?B?RWp0UWNYM25TTWg4VDVlU1JlRjN4YlFCVWd2M2RreW8vWlphRnYxVXlCN0Nz?=
 =?utf-8?B?TlVoeHRXVnpxZ29GQWRaVThkbmRWTmErZnAxWTdWN0F0VHpkUUtVa0pPbVBs?=
 =?utf-8?B?NjcyZUFvUXBQZHhGc21UY1pQREg0ZTQ1akhXamJUMTh5T2ppM1VwUnhIVEhF?=
 =?utf-8?B?dmg2SjdsU3cvajBMSU9EeSs2WFhsMXJGSW53NlYyTGV4N3JLSk11L2tYRG1E?=
 =?utf-8?B?UXV1ZlBxd0VOdGR5ZSsxTFdEQURGZW9TMmhBZXh5K01qRXhSTnduUU9DTGxm?=
 =?utf-8?B?TjVYZkhFVlc2RWVwWUVDVnVKK2lTaUlOZlQzUnhYU2ZjdStFdXRMU1dyZzhK?=
 =?utf-8?B?OVVkcFZGa210VVc1M0FkM3V1SUhUOXJkbVRaYmtXdE9kSVBKK09ya29tVEVz?=
 =?utf-8?B?K0lvNWN3dDFGenpYb3VJSW1mNVlhbzRTMnpBRzB0ZS8zYU1VRkFIVWpFdUtY?=
 =?utf-8?B?T2Q0QTN5ejN4NXNscnEwdGtSME9STHVFL3JJUnNUNkpPVEhMeTErMFVmQzJu?=
 =?utf-8?B?NXZQZHlSZ3lmeVEyc0RvOUQ5Y0NyWHhyQVR1cTZobGJyRGY1TzFuaVpYM0xI?=
 =?utf-8?Q?63ktYJF4S70r81WVJe0HWvH1q?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf56f52-e684-4e94-ef21-08dc5effdb05
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2024 17:00:16.4904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jj4Je8nM5pFBX5ClqWv69yRJya4oGMactUjKm0PItcgvQsXllvAihYG66yyPdgWXmpVIWxPZfFwyXeowF0+ZHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8080

From: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Add "code" and "routing" into struct dw_pcie_ob_atu_cfg for triggering
INTx IRQs by iATU in the PCIe endpoint mode in near the future.
PCIE_ATU_INHIBIT_PAYLOAD is set to issue TLP type of Msg instead of
MsgD. So, this implementation supports the data-less messages only
for now.

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++--
 drivers/pci/controller/dwc/pcie-designware.h | 4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index df2575ec5f44c..ba909fade9db1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -499,7 +499,7 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_UPPER_TARGET,
 			      upper_32_bits(atu->pci_addr));
 
-	val = atu->type | PCIE_ATU_FUNC_NUM(atu->func_no);
+	val = atu->type | atu->routing | PCIE_ATU_FUNC_NUM(atu->func_no);
 	if (upper_32_bits(limit_addr) > upper_32_bits(cpu_addr) &&
 	    dw_pcie_ver_is_ge(pci, 460A))
 		val |= PCIE_ATU_INCREASE_REGION_SIZE;
@@ -507,7 +507,12 @@ int dw_pcie_prog_outbound_atu(struct dw_pcie *pci,
 		val = dw_pcie_enable_ecrc(val);
 	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL1, val);
 
-	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, PCIE_ATU_ENABLE);
+	val = PCIE_ATU_ENABLE;
+	if (atu->type == PCIE_ATU_TYPE_MSG) {
+		/* The data-less messages only for now */
+		val |= PCIE_ATU_INHIBIT_PAYLOAD | atu->code;
+	}
+	dw_pcie_writel_atu_ob(pci, atu->index, PCIE_ATU_REGION_CTRL2, val);
 
 	/*
 	 * Make sure ATU enable takes effect before any subsequent config
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index d21db82e586d5..703b50bc5e0f1 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -148,11 +148,13 @@
 #define PCIE_ATU_TYPE_IO		0x2
 #define PCIE_ATU_TYPE_CFG0		0x4
 #define PCIE_ATU_TYPE_CFG1		0x5
+#define PCIE_ATU_TYPE_MSG		0x10
 #define PCIE_ATU_TD			BIT(8)
 #define PCIE_ATU_FUNC_NUM(pf)           ((pf) << 20)
 #define PCIE_ATU_REGION_CTRL2		0x004
 #define PCIE_ATU_ENABLE			BIT(31)
 #define PCIE_ATU_BAR_MODE_ENABLE	BIT(30)
+#define PCIE_ATU_INHIBIT_PAYLOAD	BIT(22)
 #define PCIE_ATU_FUNC_NUM_MATCH_EN      BIT(19)
 #define PCIE_ATU_LOWER_BASE		0x008
 #define PCIE_ATU_UPPER_BASE		0x00C
@@ -303,6 +305,8 @@ struct dw_pcie_ob_atu_cfg {
 	int index;
 	int type;
 	u8 func_no;
+	u8 code;
+	u8 routing;
 	u64 cpu_addr;
 	u64 pci_addr;
 	u64 size;

-- 
2.34.1


