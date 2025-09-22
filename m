Return-Path: <linux-pci+bounces-36634-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C59B8F7C7
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 10:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCC22A0123
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 08:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BF72FE04F;
	Mon, 22 Sep 2025 08:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="O82K2DlH"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010042.outbound.protection.outlook.com [52.101.84.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85C02FE049;
	Mon, 22 Sep 2025 08:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758529517; cv=fail; b=XJx2gGzYZcGT1OSEboqNqHBT7EcZhZjtG/JsFBM/oKApGDIgSwPmwlXy1lgsLoS+9v/ojfUwBrzcDT1fSYZcLJ893fyYQPqUvZvnDIT7Tgvfhcfj1AY+zWDIF5G8xMEm7fhGuywIUnLoRAegyPFOeSGDcYVTgpiarFMVzbMNNQU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758529517; c=relaxed/simple;
	bh=DRelEcYBSkVNI0CgHc9M1uCxmeLhjhnsZx4OgU8cF4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSVzJYiq1OIiCXOsM0i99E66wOHYLpbXGZE/Rymc56FWcM1unwb4Fq3q32llvq0z+rHugDoQbrsNgJcz/Y9Mk0axZz2fXu1RkBEsYimSHBGOmXRDPOzUgc7XzlLZwwfWShbyaJDq5wzvr+v0LZiYKCkyoFAYEmEuXhBB2h3zGok=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=O82K2DlH; arc=fail smtp.client-ip=52.101.84.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uq/QsKSoUJf9Zh0xXwsEroTaeSznmnT9V1E5cVpjcc405qP3ibK+z15ST2J/PA9M0i8lynn9CL+nBdP912bi15ZgrHfnJzbvmMpfYOQ4uGXUTNMxP08mUv524//rzrQghAu32iGBXeKoBF6TaGIYxrRh5Pipk64pyVz5gc2tnmGJ/RoubJyM/UfAtXJXRa0U2YMVHUo87JHy42isqNhafTbRpKRXQLtOHA9uPTAKAtE2B3LjcBMlNfMxdL5WPKoY1VjeK9a5TKfjRDaBl04a84Qi2K8GL6+P38RHUtYvGkBTZjT0YJnMC7mw4rZxqXYeUXKBWmPBjTfUJCFCeEpRgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=xjkboZx5CnKETT+U4S65k0T0OMZWRyAoYQM0Z2XmZ0qEi+GD/s5Ags0L1axKjJulEg01HZhnKgJfpPZK5N6t1BSOMoSdwLbuVJxVWnELxr+XRLzQrpssSW843fpSMXHCNR5YfK8uPTDoV6iX2YwXUV67bJJEJWItFvXaxZF0u6Kuf2/c8IQiuLSHefbs7ePPwUFvn13wUr/KOMddkoVh8P/WcA4tOlrCO9OZz92IqgCR+b9DFUyqjsxD4WSfxkK4gHEsRnNJxjkY+lLpamykUsnVMqZloKLZvcd1H+2jAep1SdmdO25VuK1xWHpkmAnYUqtbze/NdwCl7supDWoDTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcduZLoo/npSKNNeCAfoMdR5ukMyCAWcF1ZInVV/um4=;
 b=O82K2DlHZhr/0bXLW1tR4VwZ3oSmhErTBMiXSp0Fiw2uYKwmO5efWR4+wH0WmcjpiEooTY3SkiOza1KE0cSDWVbtYvLYMZKTxUkaNbT25osjaPQJbhMNFZvYw7BlgiCykx1BRTudhFAV+8BaDRLN+88EyJsloFYuvRiFW8bZ7lq6eoJ4ukkBueNmcVnfACFthg7TrfiOgwrNf5cL50K9cobpiEc7Q16BxcQ1kbl26mrs1QQhPFxIdQHMpSUHs2PoPnYoH1KsWGdMO7C3QjvWDeIx3ndC48ged5m+Vz6YXmQb8cfAzswT4IqOPw4lDbwt32aVAe4U9DCOaozkd1PgWw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by PA4PR04MB7727.eurprd04.prod.outlook.com (2603:10a6:102:e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.9; Mon, 22 Sep
 2025 08:25:12 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%3]) with mapi id 15.20.9160.008; Mon, 22 Sep 2025
 08:25:12 +0000
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
	Frank Li <Frank.Li@nxp.com>
Subject: [PATCH v4 1/3] PCI: dwc: Invoke post_init in dw_pcie_resume_noirq()
Date: Mon, 22 Sep 2025 16:24:31 +0800
Message-Id: <20250922082433.1090066-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
References: <20250922082433.1090066-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0016.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::17) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|PA4PR04MB7727:EE_
X-MS-Office365-Filtering-Correlation-Id: 411ef943-9d24-4663-5c47-08ddf9b18c33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|52116014|7416014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?VB8ciODe29Lsdhh7WZpgAqtFnKjoBW9jh3eNuW2qtTDPv64uPo12wNW9SoPN?=
 =?us-ascii?Q?RpLfq29FvWuaIiC4tC3j8i1o1N260rlXicneibzTqgJZaEzz3Abv6VpQlvGK?=
 =?us-ascii?Q?/L6GR+OK7etcvQ5HKSw0cYqccyO06ZYhuKI7BYyxYNpZZrNwW1ir5uOuG3wS?=
 =?us-ascii?Q?1oNApMQulXrR8/1N5nlPns2ofaga18Rg2nuUxPJGyFRSZTdiiTB7VRGKGJR8?=
 =?us-ascii?Q?BJ7PnVfDNEadgaYmf0yegkunAbQEtpkfbpsvOfut1wo4a/smA7NNEPDupvta?=
 =?us-ascii?Q?uhapU8WJo5Ade6DAhE20c8KqbSkiNbOQcF9PfmEto8QjDmBItIRZiaAXHVAA?=
 =?us-ascii?Q?7RpZViIRILdtu036JJT68RqRH9Ir1T6tebRNn3J1eYXama4PJ9ype9hGc+52?=
 =?us-ascii?Q?F+EFnzv2O3Sn4vytjyB+tY+bFtY3KGmI5Eecvi+7iXwPyyDzvxhfNy65AVZu?=
 =?us-ascii?Q?vbG1/Vg94rF013tNLjVcaX85SD7YKPbHcxeyVLMJQBXHXgPVsTrwFr38qZjh?=
 =?us-ascii?Q?vK4bs1bUMavr67SLS5K0LYi88DDmF5dbSRKMyadALLAaHWDbZ8j8BShViU2r?=
 =?us-ascii?Q?t79TTj+56stypKPcOdqoKf5ZYvgZO4mlqrKwiVpI28jIpm16PIzHnGSKVr7B?=
 =?us-ascii?Q?N9XujDY8BRFxxjL0fmvmuX6os85/FBtu6SgpfM2EtQGgj2O9bhveU7YjsDXf?=
 =?us-ascii?Q?V46xfNej5rhN/u1SYcj5kfgHj2K87+BscKcFi1dPoIoREbg1nSNRxwHP1PcG?=
 =?us-ascii?Q?liubOjHT57nr35Lz36BxoC1OwSiigHRoiDbMWlNxy+vWtGp8nVLiAr8ckpus?=
 =?us-ascii?Q?Nd/wQ6lSOwQq9zuxqMX494rHhS6XGlupFVqgAi1fbVdi2CJelY5QGVer3Zgs?=
 =?us-ascii?Q?tcUxvm/b9wb0OM//bzCgx+WHxubrHLAFrrQU5pQoA9zwTcyExHeuHFwjh61n?=
 =?us-ascii?Q?gQbeWKD3a0BEHpmHARQnTAeXS7FoMXICyqTloh+2VHxbbZqFb/TC0qXXxFYJ?=
 =?us-ascii?Q?uZuoy4vLFOSDt2XAtJz0/PkJVZbPoqRdbQ7wL7pYVOOVy/1PPRW+3Aujxk5R?=
 =?us-ascii?Q?py+s6l06RxFc9OSKBnJllqMj98h3vkkRE01y9tdWcehN2fYnAKBj2EoDEZ1J?=
 =?us-ascii?Q?jPDugU6b79glGrt7uddR9/y5luJ69PErJq/mVFsg+Z4xgU8un1bF8iHzNUez?=
 =?us-ascii?Q?RjWGSa/j2ohAAOq+ZZqAC2Nl/AJvmGYPR2NNMfAjJtq/j01xiANupOyMLgCY?=
 =?us-ascii?Q?jDPQirJnCZDJc1GTYMkaQEHadIZiRDiytWWQn9kD96m+zYLmcxzLhFv6g4Sm?=
 =?us-ascii?Q?t5Anw2PJSyUEzMmVwzXfA1ZACzDfieMWJYamB5OF8ZUqE+hmTE0oQiJJG1p/?=
 =?us-ascii?Q?rI8HC+R/VzWd+aPESGVzBCujyDjk6IMXoEzCmuIzK+a66tW9ZJpDIqUQviQi?=
 =?us-ascii?Q?Ev9aAIAhEAu02JXiE5Qq9K8vYiRv0Zk38Eg0uje7WKCurx7KhQ4IsqWahtWt?=
 =?us-ascii?Q?e9I04NowRoYvhWw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(52116014)(7416014)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cY2nHwmEWuZTtDa1vNyh/VbEt3igyDKCUJs49XUsgz2ot5SUBZIQ6uR3V5uF?=
 =?us-ascii?Q?odnQ98pRWw2Qbofs2tCDRqFoO7QTJev9Lxq0MaZuky3YxEO2yASMWiDVr5A0?=
 =?us-ascii?Q?AmlfFipWIFjgEmwfYa3L22tyJTxkNUmgaoEyG7+CYY5jVsBVwEXg6V3TNVoo?=
 =?us-ascii?Q?ADfJd91elfXW3RVml+1rP72NFdTasXH9nxy62drC2cCPh2fBrJHxfqjQGT2W?=
 =?us-ascii?Q?mI2pYnsoDO1wquQ2SJpNO9sXshiTu/B0w3g2G797/hKdCL0sWAfXQdM7h7f5?=
 =?us-ascii?Q?ktVWXQDVGuiF1Q3prDC+Dn076W7VlCgYoS70WXyBW1WlrgUwo/xwkIqmDcSX?=
 =?us-ascii?Q?ejnevldmEyw/1mmd3eYcW8Y8KDvg4VYh5M0tojHb04v2fKk0A+ClA5Vqja1c?=
 =?us-ascii?Q?lHAgteXLh7g6rhQRZ8YgW4IUw1AUCUGLL5m7r6HDTRB61bpfYnkkHvQpQ+sr?=
 =?us-ascii?Q?d284SAENmDYTQ8+o98cm4PG3HqWpKjHLHHRPuN+Y7R40z3nyYDfKT9z1hbrH?=
 =?us-ascii?Q?1x3a6Uq9itVM4uMVafzZL98L+KvBuCg1I58aUhAU1MZYNeGO3iCOwMFck/uI?=
 =?us-ascii?Q?/PxQuvyAxN7A/aVzz6QeHJXvJjaUQ+tlVdrnxRAKTnR/nIvvJ1kpaleekIgS?=
 =?us-ascii?Q?xn/uktKjMph6KmXYz/bxZn5N369vPp3L4NvU3PdWhixN4niZN20xaJgv2LiY?=
 =?us-ascii?Q?I6gocutWPSCYa/XIH83FX+JFdGGKl27kA7fdw+ASgXmJ/vjz6Sd0e+QEo3YH?=
 =?us-ascii?Q?Vw7BO0om/hwrv/+Wt49KyEu+L3zv/DpaHWCw8+N6YpvCOZEGXqlQoSQU0w2e?=
 =?us-ascii?Q?RAxj54WYMDVM+0EjEQJs1Ku/d7ahEAzJN1hEgMM9MbVpQO7jg/LoOKcTl0ia?=
 =?us-ascii?Q?IbLM9lSrWzRLZihNNfefQiaTZuVJMteP/lVT3BkMWf5kpam6JsCQVKDTgHha?=
 =?us-ascii?Q?CC08QSQUu8nv16k3tg0XdP5NDNkuB/tefx51/aafk6s0PZ1GbWjd8FvFzkrF?=
 =?us-ascii?Q?WALfdVpTLWBCCwsBwzqGpx20mXsUmK6tJTRnCHEe8AHjV4j3iCLSXgglXSyG?=
 =?us-ascii?Q?PhzMTC0sAqOh4+XZHwY9AhK+dFf8UjzEZUvI0ZJSIBTa+2YXFjdzznX6gNBM?=
 =?us-ascii?Q?eoswFiHcvWSNABI3CFPrMS77BfGnnoKc/wg8cXm2CMWOUskGJHulB4kA3Mtk?=
 =?us-ascii?Q?QT7CKvR4VgSeKs3aRm5CnPVSE8IKbzue05fVkjwRbHxoR6W0syKKSuUyes6Q?=
 =?us-ascii?Q?VsGMGVjgVfZL4oUkW8LwJ/lm7uBS+NvNFzru6uvWFP7rDZ6JhnHz569OyFlv?=
 =?us-ascii?Q?KAx1Qt7+lJjOo81oNI8klkElX2SqMRJUEMO9bdawoTncJ9Nnl+nbfNyDr0AK?=
 =?us-ascii?Q?2M/xjY7Sh71g0pNp4WIEqFJK6ThnG8LDULB4BvOkk23ixoHuWzKDeahhsVuE?=
 =?us-ascii?Q?t+WeQG+heyLC93xMZ15R1MZO3GWDpNydGyKW+kV8Qdu+PO1ZQXrimQznJUwp?=
 =?us-ascii?Q?581nSjAMFlZc6nUFzdnW9dkO0pTOFYx9M3+XByHOAwbRdmIDh/Ys4RFrWLNj?=
 =?us-ascii?Q?zSG4UpeKFrcXPPD5HcsDiucSITEQb3JcNpPsnBmP?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 411ef943-9d24-4663-5c47-08ddf9b18c33
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2025 08:25:12.2583
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRryiuixWa8RG9eZsft3UFJnxVg2DxJT+rJX02bLfJs6SZPZA8+AizFCqEeaU6NHQYgG0P4aDlgZAwG2OZTbCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7727

If the ops has post_init callback, invoke it in dw_pcie_resume_noirq().

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 952f8594b501..f24f4cd5c278 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -1079,6 +1079,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	if (ret)
 		return ret;
 
+	if (pci->pp.ops->post_init)
+		pci->pp.ops->post_init(&pci->pp);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
-- 
2.37.1


