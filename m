Return-Path: <linux-pci+bounces-15681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD21C9B75E9
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 08:59:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6ECDF1F21BD6
	for <lists+linux-pci@lfdr.de>; Thu, 31 Oct 2024 07:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A15F189B8E;
	Thu, 31 Oct 2024 07:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jBZ2Gizh"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2069.outbound.protection.outlook.com [40.107.249.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867F5192D60;
	Thu, 31 Oct 2024 07:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730361467; cv=fail; b=CqdfV5A62zDjhq06re4Gbc7e7E2/HOGI1VltYj14irq+SQ4jVYLG0figT2eGM+tpI8Z8RqUDMo2kcS0/E6zXfKcqLBbZU7s5iMDFd+6LD1roFnClw/MAeHd1ScDXURxA0tkAmPYycxOdtsJOt4AdGV8UQXyiywf3f4euiWd7PPY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730361467; c=relaxed/simple;
	bh=/UOT/gmjWF3ync39QjPot2t4u3shtCb3O6rjMfuTmPk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dAh3n/LzorGjA4MUjXwomBOeO0xEWyAdhWZWbqlvD2DZIhVlkmbDVLZjXhiunv6fy5rNmsZwqWL10PeGeJZQ22QBX4fkSjft4/c0akmnkVArm/TOsDKSFeXorgDOulir6EiQG28Xzv6omz7b//c00fAVPCvLfl0a5NdTH9duYh8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jBZ2Gizh; arc=fail smtp.client-ip=40.107.249.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ22O+HmrezJnvxvXPJwp7lEhlQCYwIYCFw2zCCIqcyZH4nUxbcZ8pqpn+9cPUs0zsI/rRpMvDrf9vmfGTHrYbc1iqYAuDi/yDY23aQB0WZcPqx8YSEZidOmw28wOLavAa8Sti2DOYF6NB+wO63NcmeZGrn+Ee2rvlYppzBI7VbTmrKUZLPgs6Jyk8K69CVqOXl27NkDeUIdS4BxSXt43pPIdmNk8NQzI1Vb6U7i8i+KHnF7EPTdVyucjSmazLNFaxxGDvwHBOkfCN3edemTN3YC/1KytChIUzy+/7keZFJnSDa5rpx8eAU1183p7bA7QKFvQg8ghjj+4ykrb/jsIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2x8nh85QHQ0gLLkdmuNiEltCwvMvKZrkBbGJybKd5og=;
 b=PfR9Lf26Et/GtPH0MLBovmxa4Juy2BvySIY2emOC/r70iTpvftmpwso8jiGlemmWVFKBuO6Y3cK7eRQLJOkMFOAJeUPpp0hSqLlMDGPHFdwlpRQyrHvVueivXwFSjYXxZ6N+F0+Qe6zBBD82M70GWgYJSEdpSyIuJho0g9c2WFtZDPB+RlPKRTHFmUbUp6oM0tENWh0jsn02Z/fJDS1MYI/p1Opoj8L2WAf+GHjbmCZalH+HdAyWeheRlvAlpBoYlvPLiolH6qO0Q1y/ZCKs1dGulDsVyEmZ8HFkdGlIBElAgyBwvxCHDRTxecH+IBP/nDupBtlIoOaY2yihkVWj9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2x8nh85QHQ0gLLkdmuNiEltCwvMvKZrkBbGJybKd5og=;
 b=jBZ2GizhmhkNjqtEFReazZesP38M4h5iGXSBpwnL3aoyQrBQHqM0pGZS2ScB5laIETlH/qNJwFzBaJAyMKEniXe+iYu5+tb999yaDM+oBK+B/xdbaKCUmkrBSDS9Dp5ChCgrbN1MoRu2+FAv1cyGNEvJ2KnrUklQtJH0k+nP9+G+FrAxmE/545QxWC2XaTcVT3IGeZu0JwuX+PVTv7T3RPgwysn5anv5DRbXjoDbg/jI3q1+g7A/07s2kYbybWpJR7RqLr0txmHI1dW0lrrNKcZ1WVzPx+HntGOu+hmv5zOOIx+295koVB3XkmMAaAhQxoymhhxFOGuo4JnozLJkTQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by DB9PR04MB8139.eurprd04.prod.outlook.com (2603:10a6:10:248::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.20; Thu, 31 Oct
 2024 07:57:41 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%6]) with mapi id 15.20.8114.015; Thu, 31 Oct 2024
 07:57:41 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: l.stach@pengutronix.de,
	bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	frank.li@nxp.com,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: imx@lists.linux.dev,
	kernel@pengutronix.de,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Frank Li <Frank.Li@nxp.com>,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v5 08/10] PCI: imx6: Use dwc common suspend resume method
Date: Thu, 31 Oct 2024 16:06:53 +0800
Message-Id: <20241031080655.3879139-9-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
References: <20241031080655.3879139-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0184.apcprd04.prod.outlook.com
 (2603:1096:4:14::22) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|DB9PR04MB8139:EE_
X-MS-Office365-Filtering-Correlation-Id: dcf341c7-0648-4fbb-e6c4-08dcf981b205
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|52116014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OXWnsfpL3U0TkUvy5O5VIH/utxvVYCT55T8yLB2Bbbynapqal43sd460IFhq?=
 =?us-ascii?Q?pBJxgiH3lxueTms5meLpUjGh8btrLOFMDvg3/IH0OF/ilCUE7m8T+6Kv+hPu?=
 =?us-ascii?Q?ES8YsdRaYcWkp3CMnQShXvE64whkFlUxLxO5Zg2Z7W+N/4aD1SuPtDOR2YUb?=
 =?us-ascii?Q?7nT8xI6xXsRkwNQ6arrVaW5atlPKTiH3+Wij6g4x9bvUAPodaulZun5k9BCt?=
 =?us-ascii?Q?/DdGakzxsajKyMqipS/fNE8Cpa4nVv6YZSRhH0ZFXCc1pIdiqbo1iY050EfU?=
 =?us-ascii?Q?URG9OjnmxQ+D2qavstv45D9oLw27Ys53V2AvMHsJCv64WSkIRVBzwQ+8Y7B3?=
 =?us-ascii?Q?2PZVt/COt6fhen09WY385ELetB2A4Kl9wiev1ijlGLBYMkxQY8xeTVMCKYi1?=
 =?us-ascii?Q?F4duKuxQuSx4/HuvlhTklPlj9RaWWxGj/+iYmH8FQngTLvCq0lusi5IHO4lS?=
 =?us-ascii?Q?o8b+6pX6xE2opsERQ5ohjz7uljz9dxf9Q1MlGI/ze9ETKqJ+aqcWj4vzmke6?=
 =?us-ascii?Q?wRP7SY5mvLzuskQhWlqkkzSKRu9biP/+PT4yMCXxCdEcbh1oRtHAKDi5A+6n?=
 =?us-ascii?Q?AwBGXkWTdEAeGbmLg/lTXHco1Gp2fhksXINUU3unDCWIR/m0eUk6HwPdrMUl?=
 =?us-ascii?Q?03kLFAiRi/mC4gImQWeLgqLdoTfa4iYCamJhhgPvGYGx2LaGY4pWa9j3qEpb?=
 =?us-ascii?Q?HvxvYDySyfQFL/5wfAQCo5HEHN1WkRyrUG3aoDqStOJ2KPJ/p/cXcV5asUOZ?=
 =?us-ascii?Q?S1z1jUr0KW54YYp3VLBrgjcr6TLlE6De9lKAzpy9L9c+kN50lqMQhQWZTdSX?=
 =?us-ascii?Q?FqMa51ig4VgE39ZI9vOiMfpPg0gPYeZAYr2aNJwExIA8aueJl2Qrjz/Y6lT0?=
 =?us-ascii?Q?LJqx9FgJiSpJHxAhuU1hpgXFiTOxwVDQEPX17IbBT5oum1xV1ouCAB4O55pW?=
 =?us-ascii?Q?qpMcokWm71JSP10qvlogiS6U+UiRUt5kaH0/3HHVTQ0DZE3KP9KP/FpGclp0?=
 =?us-ascii?Q?6m1SHv6sZ5hUoR379fgdT0bH1vFzvLMZ8cp2sytdQrb1fX7ROSb5KJP0y5L6?=
 =?us-ascii?Q?IaevaHVXKBxPY+V4cR1HijYb8tmuKWNXYigkkwmRUvyPX2+1mUWhberx+gWK?=
 =?us-ascii?Q?29POSfLm2lkzPEpGxU8fgsPDfamm4laVk9wadHsklr9YgsWCRtiiuRFZMRiA?=
 =?us-ascii?Q?wITxHGq9vt22S7kRr0fqgN0B/eMdMSPqBZGgV4J3xWOhixkkMN9RgO6E+g6s?=
 =?us-ascii?Q?scrwywDFQASw1qOibyNJcGFWXK/DiQ1nfXSarVEns3aYKUnGBPH9jiRqISci?=
 =?us-ascii?Q?AGFKmCV++DiYSxWuy5VGIzxkMCQAf2PECGZ8nNPwv3/mBX7PGcmMVZfJ1ABQ?=
 =?us-ascii?Q?E6uPENoTr4l6Zfb0MzMCwg8RRzMt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(52116014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?fjRY7+qEKYHPtnsY9J4pqOG4OSpEl+0q5Ejrq1wLcfXFkj7ysqzrrXVjoIiz?=
 =?us-ascii?Q?8+ePIMcF3s46dDBeOk0sNhoHgNhgJ2J1yhHRSCo0RKO7KYdOSEzh04CX+pvz?=
 =?us-ascii?Q?24fOnzjd3W/ThCpZRLU3tmB/Z9evhdWtTnveJWjVrHFLkn3Xbu9WWEpLAh2W?=
 =?us-ascii?Q?I9fOEzgsBENvGfiXjs5Fxr4zTNP6YiWGDYRnq3lRAKyz2k5iJkZ4wlNmQQue?=
 =?us-ascii?Q?PNdE61l8HGxy8B22m0w3DJQD+QDuEmF/QeMLkl2WSUlPo2Cz3/mS9lNRXHVS?=
 =?us-ascii?Q?dF/EyDo6CFeNvmiYrUG0348lY0w2rcKzxXDofmeAPKQIqY72zCyfBU79UnnW?=
 =?us-ascii?Q?5fYX9RyCxoPZX72YPe/n5AToQDgkdclXB6G0K9+5PcqarueQmuL2rgEZLpQp?=
 =?us-ascii?Q?mD7OBmvQrZ7opbyK7H+r6/5axrGMJ+Szbr5Z7dXDX96Xht9XzTdYNHe1SFNg?=
 =?us-ascii?Q?Wjpm8H+T0UzinoYFOZLOXckaDWCEwi8x7fFCUuORbfO7oZl1W3DYzRmdyFCW?=
 =?us-ascii?Q?H5gi6RfLQkhdptok53Ogy+S9c+2sH0vQ+Kr03rjYhMd12Toc7aatyGrxPBSO?=
 =?us-ascii?Q?surJAOv52DEL2ryjK/Xv4MxjQmT8FatG5wRSbaL254G73Nq3ZQhZJMuEKafV?=
 =?us-ascii?Q?rOWXLPXLHySeqdhKq6TZVpm7v78RxFNjqUr6Lr7NphhMuU6B06KksobaeN+y?=
 =?us-ascii?Q?EcAtNW/HtRQs5m6ErBFh5DC78PljwNLOKsdDPYpB6HBjLt/3KAmtdU6gU3LM?=
 =?us-ascii?Q?q31pZA88M58cWpiF1wzAVVzsI0yBlYKRrgPZx/N7wYaDilOXDvmQxR77pJv+?=
 =?us-ascii?Q?Ap6shDJRCpegURtPLjYmpnTQL2Lvvfe8ktZWSUf3tnGTEbOLoczY+PUCIyVE?=
 =?us-ascii?Q?Db33S8MK8i16IRm26vMJrKsZY6eNckwhCkar2lv1rgo2qFK5NTmnhdGX4433?=
 =?us-ascii?Q?GxdEFHp4+B2Sorp8S/2OgRLcLZa3bnXaML6jhladDMq5vM2+l7T9QtvOQBJJ?=
 =?us-ascii?Q?PB4sb9qMPCJijlx1jdw1cl6Nfw+vCo/+6nQNGFKqgWsDcFrkpX08YbGFJYpO?=
 =?us-ascii?Q?f4G6utgTMxj3rD+/HwCRBCs9GIRHZHgeJpZG+M/qVY+C1GCOLE94AhwH+XdM?=
 =?us-ascii?Q?LJXkE9ep9skIsNQ4k4lal/yWNm5AT/p6YY1G7is2bScwsUlMhXxL2S04U+Tx?=
 =?us-ascii?Q?eZGmth5T7PPMbE/zgKQhK7cSMu1pB5HMqef8MnQFgNjbrxpDjsEvuI5s5Udv?=
 =?us-ascii?Q?Y79it6sRjpKvahcSHy0on1TWpdfGEDIB7KxlSQ4Hqg3nErkGi6t/MAD75Y+H?=
 =?us-ascii?Q?UFxhxXUYNVTXih5oDSqcHjZJAO+aLeuKII/AeJQiTMj8lccpyRL3yioVkcWK?=
 =?us-ascii?Q?qfuo3cqbZEkUAQEZCuC8lKRfT5ZNW+tJjX0HaHamwBtMPDCN9XVzEIzHEx0k?=
 =?us-ascii?Q?Uu2X4uSAVP6zLPNaLMHnca9IcX/lnMMAl1Bt6JweLyOdgoNrvUVJJm3V5zrn?=
 =?us-ascii?Q?Lev8Tam12w307fGRXwlvdcOv0pG7zbwaHzNTkbGrX+yFYPkFRbxmPeXl3qYV?=
 =?us-ascii?Q?jlH+sYLt5yqTr0CfBTan91UPwpxlSGNBYU2iKdTG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dcf341c7-0648-4fbb-e6c4-08dcf981b205
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2024 07:57:41.4990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DtXLmAZzonssS/YwtKdLvTnNnY4TQ2ZdLIP+p2aWjyrIqzDgXl1uVJ+B4/7zjTgCHk9hxHEnbP+LQC7FAE4CVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8139

From: Frank Li <Frank.Li@nxp.com>

Call common dwc suspend/resume function. Use dwc common iATU method to
send out PME_TURN_OFF message. In Old DWC implementations,
PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
generic DWC implementation of sending the PME_Turn_Off message using a
dummy MMIO write cannot be used. Use previouse method to kick off
PME_TURN_OFF MSG for these platforms.

Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().

dw_pcie_suspend_noirq()
  dw_pcie_stop_link();
  pci->pp.ops->deinit();
    imx_pcie_host_exit();

Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
imx_pcie_start_link() by dw_pcie_resume_noirq() in
imx_pcie_resume_noirq().

dw_pcie_resume_noirq()
  pci->pp.ops->init();
    imx_pcie_host_init();
  dw_pcie_setup_rc();
  dw_pcie_start_link();
    imx_pcie_start_link();

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 96 ++++++++++-----------------
 1 file changed, 35 insertions(+), 61 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dbcf22e440e2..410a31e5f82a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -83,6 +84,7 @@ enum imx_pcie_variants {
 #define IMX_PCIE_FLAG_SUPPORT_64BIT		BIT(7)
 #define IMX_PCIE_FLAG_CPU_ADDR_FIXUP		BIT(8)
 #define IMX_PCIE_FLAG_CLOCKS_OPTIONAL		BIT(9)
+#define IMX_PCIE_FLAG_CUSTOM_PME_TURNOFF	BIT(10)
 
 #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
 
@@ -107,19 +109,18 @@ struct imx_pcie_drvdata {
 	int (*init_phy)(struct imx_pcie *pcie);
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
+	const struct dw_pcie_host_ops *ops;
 };
 
 struct imx_pcie {
 	struct dw_pcie		*pci;
 	struct gpio_desc	*reset_gpiod;
-	bool			link_is_up;
 	struct clk_bulk_data	clks[IMX_PCIE_MAX_CLKS];
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
 	struct reset_control	*pciephy_reset;
 	struct reset_control	*apps_reset;
-	struct reset_control	*turnoff_reset;
 	u32			tx_deemph_gen1;
 	u32			tx_deemph_gen2_3p5db;
 	u32			tx_deemph_gen2_6db;
@@ -898,13 +899,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
 		dev_info(dev, "Link: Only Gen1 is enabled\n");
 	}
 
-	imx_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
 
 err_reset_phy:
-	imx_pcie->link_is_up = false;
 	dev_dbg(dev, "PHY DEBUG_R0=0x%08x DEBUG_R1=0x%08x\n",
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG0),
 		dw_pcie_readl_dbi(pci, PCIE_PORT_DEBUG1));
@@ -1023,9 +1022,32 @@ static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
 	return cpu_addr - entry->offset;
 }
 
+/*
+ * In Old DWC implementations, PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2
+ * register is reserved. So the generic DWC implementation of sending the
+ * PME_Turn_Off message using a dummy MMIO write cannot be used.
+ */
+static void imx_pcie_pme_turn_off(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
+
+	regmap_set_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+	regmap_clear_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_PM_TURN_OFF);
+
+	usleep_range(PCIE_PME_TO_L2_TIMEOUT_US/10, PCIE_PME_TO_L2_TIMEOUT_US);
+}
+
+
 static const struct dw_pcie_host_ops imx_pcie_host_ops = {
 	.init = imx_pcie_host_init,
 	.deinit = imx_pcie_host_exit,
+	.pme_turn_off = imx_pcie_pme_turn_off,
+};
+
+static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
+	.init = imx_pcie_host_init,
+	.deinit = imx_pcie_host_exit,
 };
 
 static const struct dw_pcie_ops dw_pcie_ops = {
@@ -1146,43 +1168,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
 	return 0;
 }
 
-static void imx_pcie_pm_turnoff(struct imx_pcie *imx_pcie)
-{
-	struct device *dev = imx_pcie->pci->dev;
-
-	/* Some variants have a turnoff reset in DT */
-	if (imx_pcie->turnoff_reset) {
-		reset_control_assert(imx_pcie->turnoff_reset);
-		reset_control_deassert(imx_pcie->turnoff_reset);
-		goto pm_turnoff_sleep;
-	}
-
-	/* Others poke directly at IOMUXC registers */
-	switch (imx_pcie->drvdata->variant) {
-	case IMX6SX:
-	case IMX6QP:
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF);
-		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
-				IMX6SX_GPR12_PCIE_PM_TURN_OFF, 0);
-		break;
-	default:
-		dev_err(dev, "PME_Turn_Off not implemented\n");
-		return;
-	}
-
-	/*
-	 * Components with an upstream port must respond to
-	 * PME_Turn_Off with PME_TO_Ack but we can't check.
-	 *
-	 * The standard recommends a 1-10ms timeout after which to
-	 * proceed anyway as if acks were received.
-	 */
-pm_turnoff_sleep:
-	usleep_range(1000, 10000);
-}
-
 static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 {
 	u8 offset;
@@ -1206,36 +1191,26 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
 	imx_pcie_msi_save_restore(imx_pcie, true);
-	imx_pcie_pm_turnoff(imx_pcie);
-	imx_pcie_stop_link(imx_pcie->pci);
-	imx_pcie_host_exit(pp);
-
-	return 0;
+	return dw_pcie_suspend_noirq(imx_pcie->pci);
 }
 
 static int imx_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
 
-	ret = imx_pcie_host_init(pp);
+	ret = dw_pcie_resume_noirq(imx_pcie->pci);
 	if (ret)
 		return ret;
 	imx_pcie_msi_save_restore(imx_pcie, false);
-	dw_pcie_setup_rc(pp);
-
-	if (imx_pcie->link_is_up)
-		imx_pcie_start_link(imx_pcie->pci);
 
 	return 0;
 }
@@ -1267,11 +1242,14 @@ static int imx_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx_pcie_host_ops;
 
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	pci->pp.ops = &imx_pcie_host_dw_pme_ops;
+	if (imx_pcie->drvdata->ops)
+		pci->pp.ops = imx_pcie->drvdata->ops;
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1345,13 +1323,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		break;
 	}
 
-	/* Grab turnoff reset */
-	imx_pcie->turnoff_reset = devm_reset_control_get_optional_exclusive(dev, "turnoff");
-	if (IS_ERR(imx_pcie->turnoff_reset)) {
-		dev_err(dev, "Failed to get TURNOFF reset control\n");
-		return PTR_ERR(imx_pcie->turnoff_reset);
-	}
-
 	if (imx_pcie->drvdata->gpr) {
 	/* Grab GPR config register range */
 		imx_pcie->iomuxc_gpr =
@@ -1430,6 +1401,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 	} else {
+		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
 			return ret;
@@ -1494,6 +1466,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx6sx_pcie_init_phy,
 		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1511,6 +1484,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


