Return-Path: <linux-pci+bounces-5543-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB4D8956D1
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 16:34:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 513AB1C21FAC
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2E212BF2E;
	Tue,  2 Apr 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="hEpXEfhQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C781812BF1F;
	Tue,  2 Apr 2024 14:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068447; cv=fail; b=FHLLkLy61higWMq2IPt2BFAX+ktbZIp+8+jIUDpZpGkjt0iPjNR51mAZxRJYTJPubnLo+ZsT8qdIyg6eAGdSpYz/6yiepNe9zegvicCFoH2fS7Gr1Muv4LAgXXwO18AxNLoP4DZXMIE/hKj9QT+pdbhdHPgz+nDM17lw8Ir/q4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068447; c=relaxed/simple;
	bh=oFrhAvDkPiH6FbfwAFFAWfQ0yeoJKFHcVP/7+dgzo9c=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=X9GoH8V4YpuIkeTlYaHkUyKsd8shKf6eekddNW863Q7reT8bpkxIUUMGOmtJd1LcZDcQWgSAonZT7U1we5nto0W/ziDvbvmKZqGg18Wj7L+zutEhHzRp/7MXP9AahP+0+Bk7wEbMPo4Ldqv6OIGB0IaeSsWsNcArdIdAVrhfefI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=hEpXEfhQ; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y+vMPWW6BQfCD1Lrqwbr9k8JwNkgzkuaSQXWxOr0CtRKLU2ksMAlTQVcPsz3Go7N96fBLUqG3SMnglq55Y9dJt6G8j09rvE/anQaxevPajhB48JIMYUJS8DiNhD5xwurKipLx7CoQChYS1NMy+UBqccF4KMlvxDwSoCSUWN1lL22bstPM6djgs98Zm06z3xRsNjcBnOC9pWgfETgQwqCL7qfDfyevxu5PeaP8PvO6HNMTqd18JQYQcrlEI5ks+FKxFSFCRqZxE+JoZgpx/kP4Tr3aKQifv2DeEPh7F+ryJntgEMUj6CmphxhnYimOS7nQhUdaUcEO2tfYj4DFTP50Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4vLlHnnd8Qn9a+QeAE6o98MddlwPO0KdwdJnOc0DDO4=;
 b=X5XvygU9ZB6OQm8jjrBSAhvmVGOOjTiL/LF/0Yf4ipkMT5EH8Jkj+T41514QWvHXQHr5CoLVwfdahB2gZEJUl8BiJdEubQKN8VYiCp7clwyf6iHTh+gNrkjRtXJaCvN9OM77IS5EhrCC/POMKh9bOqvhgUriR+l+6gtI4haJIcvhQ+yxznAFwxPipa5ihLzpDctinYci2e5bfxwAOyMxztg51yoPF5G2hzl0AgDASXP9bWg7B8OUC1BrIBfpDK7fdP0zSAUiOMDpmxC6sJpiOyH38TbZdp+JCpULCzIBLJelOUwGVvfyPVKeK1OsIlNs5ImResCBvnkH4S7Hg3SS9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4vLlHnnd8Qn9a+QeAE6o98MddlwPO0KdwdJnOc0DDO4=;
 b=hEpXEfhQwr4j6owQP/tTxgISp64JoLyhdDp21t2XDkog5btB9rXBuPJJvKcnzM+k3YehJAZxtB6EUNHZbZXuYhphVbn4hsr3EDCYmvmMFfKb2wM3oq7m0PKKVMTNLg6xJr7fVAJjmxm/WBHJ4ggZ1tdej13xYYczpt4C0bTF5Bc=
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB10036.eurprd04.prod.outlook.com (2603:10a6:10:4c8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 2 Apr
 2024 14:34:02 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7409.042; Tue, 2 Apr 2024
 14:34:02 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 02 Apr 2024 10:33:37 -0400
Subject: [PATCH v3 01/11] PCI: imx6: Fix PCIe link down when i.MX8MM and
 i.MX8MP PCIe is EP mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240402-pci2_upstream-v3-1-803414bdb430@nxp.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712068432; l=1447;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=fwfTwuHirPmN80ucIsnsea1YVqO/3pyYDwX/hpNsE20=;
 b=cpf7wDfc70epJ405TgW9w1xF69ts6WwKiBCrhfK6qmo9vv6iY8JdfL2ONvarN7FGHxNWS9VUb
 jiOAQ9oa2LyCqRrsidXc1mVL87qSv+r6u0/7HCKRH2f/71LQ+4m4mRS
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
	kMJLPmZ6SUQnonnygLA3TvOSk9Mqw2DpxMizJxNjYqSGcsR0bpQNhXhCG0DG9uHhEXARtgGC3JUwoUner5ygsuLtB6kj0mu3D3otoH11wqbdDCXcwwK3PS+d9Hp/bTh8sRI8TVV/+0JHNXqevmCZCjbM5nnacrXIWyyncEl8bfu5WY1Cp0E8fQP+SoibVDH4/jBm1o2hnRegdeJIv5cxJM/DkeMJ7D5KSKO3CYexriP2PJ59rLCgSHJs46HN8TiQxe8MXEzLhVYW2CxV52WSJpfYllqQ80OTY5Ws8DrQTJSpaT+SthmZrt/NsCbw5R7L3AD4dI1GOW8paOOPhOiX0c82qd2bkyHozWcDUV/nI3+D0tdBDZBDt5Ydg0zMms7qhLTD1FMXs1f3eSaGuzTsMwANXBYU6tWDwJcG6O9xJYA6cMirEQYwFPvZRPYQZ0xyHA4yNW92tRdx/Z2KxZE1TYHXVY9+dYQ1HZ0C9uNWZjXFRvP0LWdxtq9QnDYpwUWHQmB9QuHoqp8J8+NzMm+GXjQg+4NooCnzZDCtPykXGFDHTY0EH1m9Kk1iSbFFoYJ3KuzJ/J/TwUwrKBAO51FLY5sixn/B0E5YfxSCEOe1DlSv5Cew355/ouwWFWOFj2NH0pPfHPtqyBSp2RSC3UkU8GiWYddpetHYaYKPrj4bLSJf740akY+mkZLYbDheieEtJzpSFqpi6+xhtPxdPNrpO6Cg36o0pThwqAQFVDFwvvg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(7416005)(376005)(52116005)(1800799015)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Mnpacy9XcFNlTjhjendoTlJvOGNSQVAzQ2RHcEFUbUhaWXZ5WVlBQTJnUDAx?=
 =?utf-8?B?eURadXZhaEJwT0tHMzNxZEduTkI0a1BpUDJGOENjc1NxTjVTSVZLWXBEYWZ0?=
 =?utf-8?B?cS95amJsY3pvbnhIY0NsOVZwUzhvcFJLb3EvMzRrMGRuMGFSQkdrWUx4VDlR?=
 =?utf-8?B?cmJKUXBrYTNOWGlmWE1CSDVqN1c3b3c2UjR3NlVpWi9BNkdMejVUSWRJMkdS?=
 =?utf-8?B?TVZNVUxiZFJ3TXJrQTcwS3FVY0NWaDFXZTNsWHh5dTZibkUwSWR4Ymw2UTN4?=
 =?utf-8?B?ZHZad2Izd0ZVY09DcWE4TWZ0U2xDSGhzclB0YzRCZmFYazJqeDJBUGhDVEl5?=
 =?utf-8?B?MEtkT0ZraFh5emFCMXdoSDUxbDlFTDVxL3plQXRqS0x6RldQZGl2QTd2Ymha?=
 =?utf-8?B?MGZBK0xxNVJ0ZEV2TEtMYXNoM3hRWU12ZFFlRU96VmV0a2VhVitnSlZUa0FK?=
 =?utf-8?B?TkdkUDRkOTVRanpPamlDQUNlTFhjY2I0NE5rVVBtOWNyN3ZoUFFHY0tlRldo?=
 =?utf-8?B?M3Z0cXZqSlE4L0pXV2JoTDhIUEtvREdVK21ialdZSURleDk4eUZzSThiMU9M?=
 =?utf-8?B?RGwvZDJwMnlBNko1QUpvS2FkUUFxQ01sV240V1FVZFlMUEszbUdkUTVvS0J5?=
 =?utf-8?B?U1dZSnNieUJSMGtvNXZsaWpvUXBCaHRRVFRtL0V4SEtBSWRTMWlRc016Vjda?=
 =?utf-8?B?NW1nbzZ4UkE0Qk9rNEhyUFJ6M2prQUhyY3pTQTdZWUl5cGZBR2w4MEhIVlVT?=
 =?utf-8?B?ZkY2Y2wxY1Vsbm4xVEl0ZUxoMzIwakpLVjNBSWVzY1NnLzVtbTg2VmZPcnk4?=
 =?utf-8?B?R0hCd3NCZnh2eDNXRmxXWFpKbnN3VVcxZnhxV2tYUlA0TkRTZy9BMURid1Fy?=
 =?utf-8?B?SmthU3BIRFhOVktaRy9tbVViVy9QYkxrUk9mcENWbVQ3bzBIYklzZUJ6dUxm?=
 =?utf-8?B?RW5palVlOFM0c0hJcGVGM3NqemlFaUJORDRYcngralRWTTVsUVpaUjdTRjRH?=
 =?utf-8?B?aC9GMmFia25BUHdIZFB1Vy9EN0dhWmd3QWYyYU1BY01SbmZmT0hFMVVOYkZG?=
 =?utf-8?B?Z0tGRTh1dllOUiswdGovNHU3M3hvMXd1eWNaQ1h6WGVwV2ZrRXFzUDdibXVm?=
 =?utf-8?B?bFRXczIzNHA5NTIzUGVEOUY0Y3Z1MVZFTFVpY0NFWnlCb0Ziamk3YklidU5q?=
 =?utf-8?B?VmVoWnNMeWw0WURwWHJIOGdkR2NycXhaYW5XUFovaUpnWTg4L2RHeFczU0xX?=
 =?utf-8?B?RVpqRHVmaGVNWi80dVI5ZWpIdFlNeE5NcVdsOE5oZUFwaFlWU3NoSHhXY2pl?=
 =?utf-8?B?ck14U3R4WkRybUNXUXJLdlVBamd0ZlF3MnoxZS80dFM4Z25qRVpQNW1TaFdj?=
 =?utf-8?B?QUxMK3R4cUlOYXNoTHd0VmRXY3oxdFBDclRQenJGWE43aE1kckNXNHZLdzVr?=
 =?utf-8?B?b1U4cWcveGhWVmsrdXZRWFdGQmdqTHFUTkJEcm45OHpVa0szVFpiNUFzWTFR?=
 =?utf-8?B?d2l0ZVVENnVsTThjWTNGT3dvMHg4K2lGdTNNcUpOOGw1MUx3anMyRUNEak92?=
 =?utf-8?B?QUNmNnhGenJPUW9jR2FQZXNCNHM3RnBQTlZIc3UvN0dzeDFCdjdmKzl1N3Vt?=
 =?utf-8?B?UktTZ1FlQmNyOVVtM2t4d3JQRTNmSlRMSWQ5RjN3MENKcjFUTWMwNnBvUnRC?=
 =?utf-8?B?Uzg4MzBqczZ4bWEyOUZUQ3ovSEFlV2lkOVlaNWN2U085NEtiZ21ZNGtlbnZo?=
 =?utf-8?B?SzIyaWM4aExUSm52TzB0M1RwNkJRT3BGYXBobHlYUTArUnNUeUYzcGJXZjB2?=
 =?utf-8?B?bzk4ZkQ3WXgveFAzVWlGWkwxaDlKOStLZ3hmcFlwdGJmN3prN1M1TEl1Zm1H?=
 =?utf-8?B?bmgvLzJnTGJVRWxwa2NmMXIySlF1NzkwdUU2RFpOblR4enpiVmF1OFA2U1J2?=
 =?utf-8?B?L1FMNXE1dkpMeHV5VHJWaTZmZ1RVZ3UrNEptaFljQ0FvM2QzTVVMR3FCK0Zj?=
 =?utf-8?B?N21iS2FOVnY5WkFYRGJwRGN0SGRHMnNOMThxWk1TT2grNStDRnplMWdTb05R?=
 =?utf-8?B?eHlUUmIzbk0zTDhZSW1KZVRkNStxLzJ0UVArbWIyY3FheTBJN29Ubk9SVXk2?=
 =?utf-8?Q?conV/ow4SJPccr5Z591rZP5Nw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2006daf0-3c94-4a70-f873-08dc5321f0f6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2024 14:34:02.2358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F8HfaRU52B3LBcW/m6t1CbuWa8UQlRw9gEg41cHByAVsZ1QPKPrhLAo/Djj0Ua4QXxqGwFSD8JZdGhQu3aLZEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB10036

From: Richard Zhu <hongxing.zhu@nxp.com>

Both IMX8MM_EP and IMX8MP_EP have the "IMX6_PCIE_FLAG_HAS_APP_RESET"
set indeed. Otherwise, the LTSSM_EN bit wouldn't be asserted anymore.
That's the root cause that PCIe link is down when i.MX8MM and i.MX8MP
PCIe are in the EP mode.

Fixes: 0c9651c21f2a ("PCI: imx6: Simplify reset handling by using *_FLAG_HAS_*_RESET")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 99a60270b26cd..e43eda6b33ca7 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1568,7 +1568,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MM_EP] = {
 		.variant = IMX8MM_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mm-iomuxc-gpr",
 		.clk_names = imx8mm_clks,
@@ -1579,7 +1580,8 @@ static const struct imx6_pcie_drvdata drvdata[] = {
 	},
 	[IMX8MP_EP] = {
 		.variant = IMX8MP_EP,
-		.flags = IMX6_PCIE_FLAG_HAS_PHYDRV,
+		.flags = IMX6_PCIE_FLAG_HAS_APP_RESET |
+			 IMX6_PCIE_FLAG_HAS_PHYDRV,
 		.mode = DW_PCIE_EP_TYPE,
 		.gpr = "fsl,imx8mp-iomuxc-gpr",
 		.clk_names = imx8mm_clks,

-- 
2.34.1


