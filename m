Return-Path: <linux-pci+bounces-4479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237C5870B89
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 21:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B6941F22259
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 20:26:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630F17BB1B;
	Mon,  4 Mar 2024 20:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="s4qi1hdD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2076.outbound.protection.outlook.com [40.107.6.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8607BB04;
	Mon,  4 Mar 2024 20:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709583951; cv=fail; b=P5IIEFtMijesPGfZjlOtqZkW0Elrt6HNrJQtmcdY/GJrVc4ezj0DqMnhQlMWHXtitXh9/oss/nuLWH/uSOulGBpYABLjf80kuGnMjVMybXoYirtnYGZmnfgcqU7l6iwR+CIFRzgfEKCD2JgCygyyPs4Ov6DRmnzuDAUzAfFSMrA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709583951; c=relaxed/simple;
	bh=7LEmma9asVcc2UpABKTIPCze0Rfq/WnOrCDirUI9M1s=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=s/NtdjXZY/FF+M6/hbjoVcogKYfmfAIXx9HlLHRIiWaaxibiZcCHXsYl3yN2FlRSZWb/Ln8+w1+Qm+Z1rzB5Qb+GbR2N2Fd2kgc9Tr4A0c0Nd09Il+blaM2VuHu1cLOqeEDeHjZ2Ut3kqSKAASHlCPZcLSHdl9HcEPhLDZinHvo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=s4qi1hdD; arc=fail smtp.client-ip=40.107.6.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AX5LDRgubqUwWA6jttaeeX2uAxBsiZSfMlqw0WMM4cjcupms3gUP0JYTL2QGisZxs4En2CXx5i03kSN+/3eJi8gh1oLd7uPZKTWfMKE41UxDIQtjl3BjWZzNh6wEJsY1Y4KdMcPPHBl0l+b1asJ2ruUZMq7GJjMKLlt03lODYLTXqxUha3k/atKv1Hjh11vnSIskrOFwa/KshDDSbrySXBCCceddfzZSOvYwMNCqcETjZmItcHcLhf2QhexQRGWyZcGzAEN8+U3vlFued3JkqGN2bRjHAGhHFbIzPCuTH0nXTynyrtnRpQXShNMdvMFydv1QKt3ZRM/pjmAsGRUlEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bYoXCN2Cg7BevWD2QEgj8BjNP6h0jRB2sBiityVf9KU=;
 b=YbORUbHmdTFYUHda8tORRd7naRNHZCTloIct924/SziZrIn+AC0hrqo+HSGrvwdWOClEkTDPBAwjHwa+zXY3ZnTU+fcMD0Ln528/6qMMfjPW1OxANs+ZCRS+Z4m45Hu7FaESeucA5SiJnGzDJkeFdckSPhrmrtAauEwLDjdQjIP8MDZfObKsQh7AR+Q/tL+/IOJXPTHw/7tD81SmSShceoGc2TVouRNG62UBul3VWpv8KTSmojpYOftmU5JB5AeqbJaef+jRiTytVkPNfBepAyrPKHApRz50E/yzBikWA0lSy8A6HhJ20enVnAiyZ6YE8mTPMcsH+3FPfR6WG3Vq2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bYoXCN2Cg7BevWD2QEgj8BjNP6h0jRB2sBiityVf9KU=;
 b=s4qi1hdDvSlNDmXm7XQEEbEdLUcY0JNMAcUQ/wUOc/xFZUOomCnoMw8HbsTmhmVnGICKQboheBde+AdbwWMGVxX4UYzQFVNKIH/zR8ZSQ3pjLtguZZ2g/hRqAoskATCGM+Lm+wK+xhRsQ42sVjC+12vbd8BSiLaTNTkMy91lYaA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB9083.eurprd04.prod.outlook.com (2603:10a6:10:2f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:25:45 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::3168:91:27c6:edf6%3]) with mapi id 15.20.7339.033; Mon, 4 Mar 2024
 20:25:45 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 04 Mar 2024 15:25:08 -0500
Subject: [PATCH v2 3/6] MAINTAINERS: pci: imx: update imx6* to imx* since
 rename driver file
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci2_upstream-v2-3-ad07c5eb6d67@nxp.com>
References: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
In-Reply-To: <20240304-pci2_upstream-v2-0-ad07c5eb6d67@nxp.com>
To: Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Liam Girdwood <lgirdwood@gmail.com>, 
 Mark Brown <broonie@kernel.org>
Cc: linux-pci@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709583933; l=1049;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=7LEmma9asVcc2UpABKTIPCze0Rfq/WnOrCDirUI9M1s=;
 b=6vxP3+92740+jYD/IDmpYE8t9jY7e9aKX4CS1qrQ9g2HaUAmaQC6rNrZz1qnhxLgZ/aL3uI0m
 ncpeR9fRDOGC8VtmFWAUqAKurhRi/IsVlbncCdspbZu7mpliM1gdkfQ
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SN7PR04CA0118.namprd04.prod.outlook.com
 (2603:10b6:806:122::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB9083:EE_
X-MS-Office365-Filtering-Correlation-Id: 20d3ff15-42dd-442b-ea6f-08dc3c894575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2+LyMCnvGeFDO1Ya7+BXE36e5SU6A6QTs8UpxhC4XtJNJx5tUDEjKJTOjBeGS+gpNGj+hCROo2iF8geZ7dPjqEjqEGKNoMLIO0L9WG/ZJMyiJkMDpeNsyK+16DQQ4viXZGp12eeAV10OUSEfjRxWPUuE00gzyPY6v+VS32SHm3B67nkBu71mU0CuooCA7s0z/0hjpZwcshWII5L48oZvcNGJTN31lHdd2Xm859afjY54lWzTcU5BqcfRClhDvj0f6xaMH87oQ1C+ImR7XlreyMiIyCrRUc1/W0whxOpQnzTbXNqZ+2YmMY5R3+TgtYqmEN7LBdWjFqjw/7A65Y2ztkmShY/eNqB5f+pPaL5gHzW0tU4VyxPUbE79cvq/NQw8SGRIj88pznAZH2c91dEBCGdSlU38lBJpNzh6amXxbeLdNr3yESug9SwaDp2yJkc3Jkpa9QqNxaTpHKDfy1rtXXHktjusubdoAq2vyCnnlrzDvxFhgVY+MXIGByp0PnPB/SwVP+lHzufYlwPuDdnwNMxI1GWmt3QLhkmPzfLa13c+up8I2Gf3f0HPRDVezAGJTLX6aVMnhcsDYIlbYGkJCMMAmrI8CP6R2F2UR5l/OuCftuaPXMtKMnpnu/ew8dFYqZTra6gzp6/gy5NVFSAf5wc5EhsQe5K5GZiO454seywarfa4NBtlczYZ7jZ2JqMc4TTYP38PH3n0FoJqWQEVnh8LbWpoGa9Hs8kjiyip2/I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(921011)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SlFabmpuQVYraUlSeGxGb05WVGtjdEdjQWxvOG12OUFpZkxobVA5UVBacVQr?=
 =?utf-8?B?NXFrSzJyRjM0SkdPVW5hTVlzMUJWQjExVFhqMk9ZWG5iMjhhZzk3VEZuRzZs?=
 =?utf-8?B?Vzh5Z1pwdk1IYnNMUUs0cW5Qd05xVFgyUVA0N2tEYkZhUWVLREUyeWNETjha?=
 =?utf-8?B?RVlqWTJjUVR6dXJqdkNkUkxnMkh0dGZRbHVXMk5xbHUvVGRGK3NQN21TVlBR?=
 =?utf-8?B?U0NyYUFvZ0Q2TXdvaGF6S3ptcWVSWXN3WFkxd0tFZDA2RG1KRFdLSC90eUNL?=
 =?utf-8?B?VlRNWDk3bW0zMm1zcERLNkJmaXhQMUtrNXlWbEYrVlVlWVJBYWZsTkNmRjhm?=
 =?utf-8?B?dGZBaTk3TTdTRy96dElSdG1FVGR0RkxkdllKYjB1ZHUvY0FTK3p3Qm95L2d3?=
 =?utf-8?B?ZlJ5dzVnRnkxd1EvL1J5UjRFRzNEQkRuU1NlZlh5LzN0RE1Zb09vb3NSNHV1?=
 =?utf-8?B?b2sybk4vNEtZTUZSVWN0R0EweFJodjhFYUhNSFNDalg3RkNsSGlSNkdJNEJw?=
 =?utf-8?B?M2MrSVpzcC9uSndIbXA3RUN3bkxMUU5KTnNwdVh6L0ZPY1ZnOWYrY0ltMTM4?=
 =?utf-8?B?WG9tTjBSSTJMMkc3MXRidlE1S253WURSWUIwVmJoZzNNVWJRQWI3cVdpeVE4?=
 =?utf-8?B?cXc5VytxdXg1QUJaRXZZamk0bmlDZkhicWdwZjhUZy92TGxiZ3A0R3FYTm83?=
 =?utf-8?B?Y0xMTlZ0SjFjenFjYWVuQkVHUE95cVdXSjArQ0laelMzM2tacXZDRExxMWtI?=
 =?utf-8?B?SXZDaC9Tell5RnNKaDZyYy95SXFsZFpVdURPS0dyZnoyZHBWRE11K3ppZ01j?=
 =?utf-8?B?K0doRTNicGM5OEVhcngyNFl0N1Z4d0hyM05HZkNDR3l0bTc1Q21EUnlKdjFQ?=
 =?utf-8?B?Szg5VlNWREFORlZlRHJBbElJMUsvM3l0TW16bWFrM0xGRHVTRGpsZDdITHFr?=
 =?utf-8?B?MldpQWxvSHRSM21YUy9KNmI5cTdKMkw1aTYyY0pHZVFkRWRVTGlaUU85N0Y2?=
 =?utf-8?B?UHBDUFBsOVNydE9KUTgzKzdsYmxDVDBsUVBCUWJyUGgrODdaU0JSU2J0clZp?=
 =?utf-8?B?aUtPbXhQRkEvTHlnbFQ4SlJhMjBrMFJ4NVR3S29iWk5xcDJ2a052bkl4Wjlw?=
 =?utf-8?B?b1QzUVplMkpZcWJmbGZFOWRMdk9SdThneUhBQlJidGlZb1E1WUJVZUZvTlMw?=
 =?utf-8?B?RG4xNmZONFFzbFlZUlhIdy9TNGpFZVNOMURMY3h3aWdKZWZ1OWJjVm1PUGJM?=
 =?utf-8?B?bzNPQmtHcXEvdnJqZ2Y1MUhtM1owWTZxTVIyYmFlL1FHcWpuVzFudEhRQzNQ?=
 =?utf-8?B?eTh0d3NJQWEzbGVlSlhoeEdtK21VQkpVRklzekVkc3VhTlkwN1paNFlEaldO?=
 =?utf-8?B?U1dLTTNEcE5GNkFTZzVTdFV5RUg4TWJySEJlVXcxaGJwdXY1UGRxaTZOUm8r?=
 =?utf-8?B?d29Rb2hYenFKdC9iOXVSOElHdy9rRzh5dElHL25FM01qcFQwMWlEU3VRaGEz?=
 =?utf-8?B?UkNraGExRWlnMUk1RjQ4Z0h6REM3SSs1cWZ5Q3BEQUxGdzJzaGdMWE1ka0I2?=
 =?utf-8?B?UlhpemVVbC9jUElhYzBJcUJFRGZlcUNhbm1SazlhekM1dURLS3VwdlBOck8y?=
 =?utf-8?B?VFFUVWwvM0plR2RDYnNlYTRPSzliczhKSyttdEYxVk5Uc1lxU3BKT21WQWk2?=
 =?utf-8?B?aFAvV1ZHNU81dFg3N0Z2b0hxbE1qa0cwZXZPanVhZ3BHS1J5bnhlT1hKNnN5?=
 =?utf-8?B?Mmt0QzhLZ0lmWU1PelpWZFdSWVR6NHB4K3V0bWk1UlhPdTdVbnAwOVNwb0RH?=
 =?utf-8?B?VHRXNW50S2ZhSzZhaGhTWjVNSVdLWVFaMmZlZVNlOTcrQW1aQWZhUUl3OG1U?=
 =?utf-8?B?dlhUYkh5cU9qd2dxNW5tU2FmOGUwWnBla0Z2MkFkbktXQ1djOURIMGUyK05I?=
 =?utf-8?B?bWs3QmJ1aXRrbFY2QmZHTUVvMkhvRk9ScjY0Si9rbVlkT3pIbXlzSVhXZjZM?=
 =?utf-8?B?RW9NMXV5NnEzREQyV05YVURIaGltUmlmTTI3R004bUpJc1hyT1Z4eWk1ZDJH?=
 =?utf-8?B?VzdSd2l4WXNFOUtvZ05tdzhRa1phSWlhZFF2NjJLZ3dmOU92T3lqTzlTMDRn?=
 =?utf-8?Q?g0tfTXdlzB+RSOS0Cnd1NS3df?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20d3ff15-42dd-442b-ea6f-08dc3c894575
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:25:45.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g9PMB/xlWxmsa9B7IDBIjSm5gqIeUpukHiD7dMYIVHHqvjDgfLAWdpQHbD1rL1IsfqTFmG74IGBj+OP87PEUHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9083

Add me to imx pcie driver maintainer.
Add mail list imx@lists.linux.dev.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d1052fa6a692..59a409dd604d8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16736,14 +16736,16 @@ F:	drivers/pci/controller/pci-host-generic.c
 
 PCI DRIVER FOR IMX6
 M:	Richard Zhu <hongxing.zhu@nxp.com>
+M:	Frank Li <Frank.Li@nxp.com>
 M:	Lucas Stach <l.stach@pengutronix.de>
 L:	linux-pci@vger.kernel.org
+L:	imx@lists.linux.dev
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-common.yaml
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie-ep.yaml
 F:	Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml
-F:	drivers/pci/controller/dwc/*imx6*
+F:	drivers/pci/controller/dwc/*imx*
 
 PCI DRIVER FOR INTEL IXP4XX
 M:	Linus Walleij <linus.walleij@linaro.org>

-- 
2.34.1


