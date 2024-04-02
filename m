Return-Path: <linux-pci+bounces-5546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 568C68956DD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:35:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 76BB71C22233
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E09BA1304B9;
	Tue,  2 Apr 2024 14:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="qV8UsHIi"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2124.outbound.protection.outlook.com [40.107.7.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D3512BF18;
	Tue,  2 Apr 2024 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068463; cv=fail; b=BrQzH2qW3LB0zPxUSmBmacjq3TPjsU/NX0URWGcBPxNRMyzFX8Vbo+F3oac6xQGQt2wQLTInz9RjTaDktum0gjY4FFyZiaAR0OFfhUVkVIZSeOraLAKFs+inJMnQA6/y7dnCqipSZfRnfsxXee5uL3CFgOyNzsz10wANS4bsums=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068463; c=relaxed/simple;
	bh=1r2H1hqe2HsquQcW5xHXQOeJXeR6VzCgSFRI6Lw/PzM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=WaBsAiRnz1mY9m6etFJmG4hvC2KxaLEqxgsOEGQeck/7GgDpH4pbhXCFcg1uXF6Q8Dexado5RHIySlYznFYMY3zX/oVGpFi+l67CwXDLkWZW/CgPV7deiTAtH/f8Ou4OL50CKkCfkmJNA9y7P+LWRF+2Eiy/f/Lahxfw9H1z/is=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=qV8UsHIi; arc=fail smtp.client-ip=40.107.7.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S3fDtIHLQfhC50Nomt+QFbGmUUODXx2M9uYY7maNIxp05kGI+/0VnOC2syK0xXHGhPsvNncG1lNizU8BiDZoF1J+6Lc4I9e4R7cPuOWpRrvR9BHVlwfGO216RU5N/4OSMYPPFTtlHWsrnXZVlxY0xLDjjRgfZej3srRmq8qDWdD5UjTH0oE1PTAQ3TEzjwugUzGS9DMRR80cWq0/YdWpmykqim149P+93NYNxwRvkuSB9EUceOppZaeQj4E+SoTrKcoQQ7im3I1S0wFJTm50Tk0bxbRHNyyu4SrCEyEMBy8MUDJkI4reEyOzvOzyu/4zdWnHlUPMSGxichgVuYDDWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BTPBXfAX1P6YHzKk8sQ6o3YDjVYk1m+DwbidtzQix0E=;
 b=QtnooFjNX3Sk3Rxi5yJmfVovnJ8MP5s5rZOvoG4yK4wU4WCOJbMx+YFRm2So9htixspubFxODz6jC4mdcg0SUF7a4p96BimIa/RePVyC6i/krsug3GNf3bRcA6irYGDyPG19ipr8x4BWBhciMRt4mVi9koq4AmZkuoJe/sBVUB8qX74l8/mZnUOAeYuNrGeHXpH8pve8j4xYKQwiLk4AeaoVsajQuqssSc3YJYAHmAHsn5iBGH2NNK6rlK2+xWMwq9ImxQdwQoEialQP0yUqggCo1BhqmDTl7ACV9xLl88qKZ+I317Wvzq04dFM3fcFeh5TmTkUqHx1OoNrOvUs3Ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BTPBXfAX1P6YHzKk8sQ6o3YDjVYk1m+DwbidtzQix0E=;
 b=qV8UsHIi58jcqnr/J66MwYD6vGIYfmtjXlQtoKxRTDo3+jw+5K5v1kE1LQqgPwm7pDZ+MONY5lFE7XHJpIry2oelcsbYAHb0oOdSrCGzA6VPHtxALiGNaVQS5C8vBLkSpl+Dlts76DAZZluTMOmBXDcC66CmJK4bt9R2HUEkLdY=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:17 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:17 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:40 -0400
Subject: [PATCH v3 04/11] PCI: imx6: Rename pci-imx6.c to pcie-imx.c
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-4-803414bdb430@nxp.com>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
In-Reply-To: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, devicetree@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=1420;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=1r2H1hqe2HsquQcW5xHXQOeJXeR6VzCgSFRI6Lw/PzM=;
 b=4vhMeFDdU4NfO4+DzVp1yOWAc8rlHxNKTnSn9X8PeoVpCKKpakXUwcSjOV9n951ZSEvB9VC9e
 wuJVFHNPLCoCWWvPxFBUZuvzgN4TZZiYnh29mE/+VS2V5ncioDv3qtD
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: PH7PR17CA0011.namprd17.prod.outlook.com
 (2603:10b6:510:324::20) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB10036:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	xCbr/eX4PYoPSp08dDDAYwZk3H0xSzqnfq7dUn8CKGDOFD7Ckk+QIQgGHvNXRLSilwQS7JN6tXhldZGHDnDxaTkuMNeQQwxs2aTXqAGTBo1AgWBdiFlm+mkxrlWhSpasAxj3ZUyOzHCK2PDpt6JIFiEaamiBp8+ABqIPA8wM9WEOnc77Ew5rK7MhfXavJjq/gtN1N7ttsR0aHd+Gvu/BpMqFW7CG+Do77VqLRFCYKjRjab8vm3DHToJyh7yN46uDnAuhgj2HL9nsVZ6B//JKWbCDA+3dvLP9BAu0NKnqx+II4cq68d09oO92qPLHPa4f0XYHKvyWHRMzEitmh3XrnP8cQJHIhlV8q59u/uyYNLs4hh7RZ3b2jLtn7XbOSqpGOTLbUk0G/0oN6/NjfJvgA4FiuQCWMDbwPeGMpEn/jXmZUv98ZgQX6I1CJFWqVF+WfBKqPCFM1hcp7Gc5M9v0NbCrlaGMXiJY+CIT8tO+5UeFXNydyOMGG2OctNMCW0eRq//MHdpNVJGy4XPq8V0IssHzSNAmmWlXrk58EYIG6ngJdLl9HrCy7TQunvZUEpxYk3SwiaGSpQzBox7cVL2l7hpCWgzWtRAsAKSgwosqmMhnqe4lPDsjOQOq8nIi9aNKoBpsIVeP1D989eWEavLto7REgSHX5F/4NsuPmj3zEOHFQD2uuONarS6CqbdB1oj04h4miU16oc5+2wwlPJyvKHeY7u6Kht2SLPDlEcreI18=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L3JvRDN5L1F3ald6WHRqbHpsZFVuL05nSEs5Wjk0SC9IUVdUK0wxZ1djRUFQ?=
 =?utf-8?B?dXZLa080VlVDREwwc2ZVUldYMndJWVlRUDYrenIxeWdBOStBRDFkWitybEVV?=
 =?utf-8?B?NVZIOWZiL3gyeDF0MWUxbmt2U0hiTy83LzhQR3hpY21HeUowdzJxL0lpZEJv?=
 =?utf-8?B?Tk96ekI3Y0lFMGZGa1RhaS9nMHRKZ2lNUHgrOE45c0dSZ0RadTBZZFgwcXZq?=
 =?utf-8?B?KytYdjBDNy93WlU1MXA5UnNSMlBUcjd5TjFmNXU4d0gzSlJ5NG03Tk1IMDMy?=
 =?utf-8?B?RDA1YkZKMER0QlJJRUVRL3JHL2NIWXNZV2YxMzdMZlB0NWxHSnR6Rk0vU21N?=
 =?utf-8?B?UmRncVVqTFRUNXVGSGdDTnZTeFQ0RWE4Y1dhZDBjN21NMnhYdVlYTlEvRCtx?=
 =?utf-8?B?TEVZM2FIb3YwdDNVUVl4UkFRdEQ1OWlrOU80TUxDenVUR1FSVlNHdmxiWHoy?=
 =?utf-8?B?VmttckJLUHF4c1BvNytKak9FK3NURHhQdkNTRWZZSitUK1h3Sm9sWUZ2aStz?=
 =?utf-8?B?bE9HQnpXdkhJTTUvK3hKNFFJdExKVUx3aEpkaTVWdnlLeXFCUUVOd055anEx?=
 =?utf-8?B?SXI3UlFCdjZ3ZkZ3RXlCNUFVOEg4TUlqOHRVK2tKbjBGZExqWS9RNFFHZXNr?=
 =?utf-8?B?ejFMQW44Zlc0QjFnbWVrZTlRZFZKYkp0MTgvMXBDQjllZXpoLzUrd29LUXQv?=
 =?utf-8?B?Rk9nTzJ3WDZPZ2lZZ0xFS1k4TUVlRHAyOHh4eG9iWCswL2FLdENRMHZvaGN3?=
 =?utf-8?B?bzJkRDl5YmFDd2xwTjdDZWgralVqU2ZmMVJQU1I4ckU5eFAvQWFBTS84T3dR?=
 =?utf-8?B?Mmk2T3RQbVlEUTAwMUtHcVBIZTNpUXNTazZXOEFMVk1vR1ovY1VoWUtxTWtU?=
 =?utf-8?B?aEVhUlFvQkRjUm9FZytjdjk0NlJldzNzNU1oRkVFNXZOMDY3bGsyRHc4d2h5?=
 =?utf-8?B?SmdNbDJ1dUYzVW4xMCtUazRWb0R0eDl3OEhjWnJpQkp2Z3NZR1NmVnpYSm1L?=
 =?utf-8?B?ampDZjE3aSsxcWlaTHVJa2pDWHgyWm13ajNFOE8randHcXpuTTdINDZYSEVn?=
 =?utf-8?B?L2ZEZzJhUUh1V2hubUlRdENvMG9RR0tFMUphbDFKT1Y1YVZaTSsrTVVCK281?=
 =?utf-8?B?OGZFZWtLczJMWFJ0SWlPdjd4TXU2aGp4TC9tRDg4R2JtQm5rMjNWYmRrMEUv?=
 =?utf-8?B?d2EwRm8xNWFJdkFJdEl0bmowcm4yakJqaDZyM0kzVUhpQWg4UlQ1U2VSSmto?=
 =?utf-8?B?RCt0bThUOWxuU29JWm9zQTY5cW9QZ0hWNlRHOEhVdi9SZ3NWancraVg1ZU1H?=
 =?utf-8?B?VGJBUVBreHlhb1hWNG56L1ZyT3BGbWsvQ204M1Exb25mbkp1dWpBL0lBZFBu?=
 =?utf-8?B?dTNBMEJrdXRUQ0VRbHVRcXNUR2N2MHNaemN5anFlb0dmRU9TUG1QSklzbTI2?=
 =?utf-8?B?L042TzJNazg1MC9Pb1RQaktwYU9zZXNjZWRwZmFMbHpsdmVLQ0Z0Q2pCVjdo?=
 =?utf-8?B?QUtSMHRmd0RyazN6TlJVdkxobjVsNndBb0E1RnJ3NUc1ZW85QUJnYzk2SXBs?=
 =?utf-8?B?L3ByZWdKWFdmemFJWGxBRHNCMXBwOUJnSSsrUUFHb0tQTnFaS3lQc3VLT3ZK?=
 =?utf-8?B?djFGdUNYN2FQeDFKVkxPNms3RnNEZUViakM2WmpPOEFrMnh2aGF5ZFovN3g4?=
 =?utf-8?B?QXk4c1ptMmVsU0RCd0QrdlkxNC9jU1ZnaWhxOEhWREpqUS9PSW41WWxaOEVP?=
 =?utf-8?B?SjBOR1VuK2djRUZXNFJ5Slp2ay9DT0lEbnlWeDlaNGlKZUd3NmhqdDhkNXVH?=
 =?utf-8?B?U3NhZnYrb3haZ3RYcGZPcWdOTFhCR2RPY0FnUmtrbDhqUWRZWUZOZ1ptcGhv?=
 =?utf-8?B?TlJ0SGtpOTVBUVVCOFM5bHluRjlCNzVWelZrVSs4RzNqaFFuM3ZRL2F6L0pT?=
 =?utf-8?B?UCtoRVRKRFIxL1lhRFpKTEdZRWJZdE1oVjBITVp0TEltRjNkTnEySmsyU0Ex?=
 =?utf-8?B?R241Y1BKSmh2a1NFVUcrUnhLbFBVbGZlc2tSWWJjN0sxUTlheVVjMklCQVJF?=
 =?utf-8?B?c2FiZlovZDhCYjBMdVhESWdlV3dFU2xQUi9nTkdVRXlzalNmaGZSelU1M3Yz?=
 =?utf-8?Q?2TQA=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d800e46-4824-4d87-ee6b-08dc5321fa14
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:17.6350
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qh29KrfikLEnw/rVOgOB0eFIuaagOm3HlDko3vMBnQRKeLgBmH6wEvqA7jZrLFSBQNQ6LF/A37WH4gepv7T+hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

Update the filename from 'pci-imx6.c' to 'pcie-imx.c' to accurately reflect
its applicability to all i.MX chips (i.MX6x, i.MX7x, i.MX8x, i.MX9x).
Eliminate the '6' to prevent confusion. Additionally, correct the prefix
from 'pci-' to 'pcie-'.

Retain the previous configuration CONFIG_PCI_IMX6 unchanged to maintain
compatibility.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/Makefile                   | 2 +-
 drivers/pci/controller/dwc/{pci-imx6.c => pcie-imx.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bac103faa5237..eaea7abbabc2c 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
 obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
 obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCIE_FU740) += pcie-fu740.o
-obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
+obj-$(CONFIG_PCI_IMX6) += pcie-imx.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
 obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pcie-imx.c
similarity index 100%
rename from drivers/pci/controller/dwc/pci-imx6.c
rename to drivers/pci/controller/dwc/pcie-imx.c

-- 
2.34.1


