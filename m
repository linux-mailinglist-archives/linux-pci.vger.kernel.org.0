Return-Path: <linux-pci+bounces-34357-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B11B2D5CA
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0924178BF4
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1222D94BA;
	Wed, 20 Aug 2025 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="DmSGSnN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010024.outbound.protection.outlook.com [52.101.84.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B632DA744;
	Wed, 20 Aug 2025 08:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755677502; cv=fail; b=SCXjFVlk2+/Tt9bIuFw7wW71VCwuRLtdThmFqb2zURmjaQ8bJ7rbU0vht56UmZhMQ0bYQ0RfHynCHGtwFDZWvdfI5BWcQvktQal/L5L8NQR2edvHXK6nbXiHqQ4Ue4k+SntF9uQnNPUWU/Sa2LnZXEWvBPcLWsA8jV6RXdG8/44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755677502; c=relaxed/simple;
	bh=JWrwUSOENCFns4yvw6vMp9uKghO/Aw5hyhYEDRAdkr4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=RiAi3WgQVAyx0u8MG8fuA5uE8uymWPgNxZNJGhnbRdEK2sva/SSNzpIMujy3rXZ5l4yCa97txCFTQ58G2e1ylZ8Nv2O/2LBmDDSjdVmwzKGLT0r5yE0+ZunRnFA2Rn7twgn2wRcYJeUenKMitEq1ZlgmWXqX8r5QS9vAs8VFRhw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=DmSGSnN4; arc=fail smtp.client-ip=52.101.84.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ib8gvC1XGsxE6LRFuVbcz3x6iYw25xInF+yz1QhAORzQImoT0JpPx06qjYYmUyTJwhRK4zjQmf+Y6Mj9IuS85fBcCS68XdIVUkzWj53RZs7WGUTQ+Gvn97ZcP0RCJufVbnQN0DQCtbT3J2jBCosmYSLGgNooNu2lz/oV53/xmN/JCVi4jnRveG91qGy13+wBEZHzYi0ow4dvjK2Iol4bsTSVk4iHdnkpOr3VEYllNgiErNlbdAIxMC9sFoT0urAaLCFE8HI8MvTpfmBqtIK4irQNB8OGJbefx6kDJA2MxRLqBfU8WemQFaN7+Q438YEVtfZmmm1xjDbzFcOEWgKfmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p/BpOfEDoyhdPz2imWxfBWvdHexxlD/4/sV2cIjSdSA=;
 b=QcK668eDiRyf0aJ1GYTUI17Ma5rOt+F9SViWmZVZe+Am3dUW3q3DRdMd3GAuG8mTiB0WGtpf4DfhZEXEJGeR368trPUb2aNIFA14i4wu9zygP8nKbpM88UFbVV2TYbu+ge1qGe41bPwEIwBMP5xejKtEDfiFL7CIcnnv/1YPZszFWaP1AyqRQhAO/8oEdn0yXRYzzAi+nN4y50amOn2+QFCpJxwgwYTeZQLDhUT4U2rBF+FHJKLgBUZ0J1sRQZqgSmMewgTKEawNAFUfVwmqHn2UD6ubuTLmch5u5BI4SX1RR69+qtM6Q5s7qvcda8g/VIYxhs3iZo4eTJK2Sb3nYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p/BpOfEDoyhdPz2imWxfBWvdHexxlD/4/sV2cIjSdSA=;
 b=DmSGSnN4TnWBvXmN4USVQKNy/6y8yAObxPIoDMSZTiL5J8oN6oOTmjHcc6yq1czlldbCNUvsccgcofliHoHf6JpkMRO5rlU3jasjmH0ysc3NWr3c1TaEm5PjZ3cUS7NE5rJgpiPdc+AUPYUdM32k2CGee3KPMVExYVuR3R6wqMzYBn3um/TSxTj/phheIUKwEM7ixZa/nTqBcIZ33/YD36qxbw+dWPiOnVim8nZIAY5B+ZGrWiUN85EFz5mzylMv5Yh7A2w5Lrcaxw0p8nezqf8HXI4Dn7SLcfzRi8C3UDMe1CMXn/Mu8MiilzE53oIG8iPAsJtTisJICpR5qmMzkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by AM0PR04MB6913.eurprd04.prod.outlook.com (2603:10a6:208:184::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.12; Wed, 20 Aug
 2025 08:11:36 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9052.013; Wed, 20 Aug 2025
 08:11:36 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
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
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 2/2] PCI: imx6: Add a method to handle CLKREQ# override active low
Date: Wed, 20 Aug 2025 16:10:48 +0800
Message-Id: <20250820081048.2279057-3-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
References: <20250820081048.2279057-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0002.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::16) To AS8PR04MB8833.eurprd04.prod.outlook.com
 (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|AM0PR04MB6913:EE_
X-MS-Office365-Filtering-Correlation-Id: 69eab001-8cbc-4767-50f3-08dddfc12ec2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|7416014|19092799006|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+Oy0OplLvnB9iPKh8FQKQhL72zPnbV0KSzS56YnKJ2/Ni8UqHERG8fi9Gj4M?=
 =?us-ascii?Q?ORzlXmImONoDEMuqm1OEPfGITgR3CfvUk7F7Damc7K6vjA3I3BL/+c9vPMrG?=
 =?us-ascii?Q?o2NZqsmpyt7p8A5uqvS9pDipab3+AXqjxEkFO7eaEtkwlnTu4PAGvoRjrhLz?=
 =?us-ascii?Q?FoaWFAVdKBfnzOkJfzxgtkyVgv8IA/32MLGyFLVv5uOlP4sBvoMiQ+lWnoBv?=
 =?us-ascii?Q?sgpKa1gMgPINyXKA+xVlhfqUTEZKOHEPhWu9PCZ0hMSzXcwrLTZhKoXK5/fB?=
 =?us-ascii?Q?DMzV7QciexCaNQSPn8bTx3OZArw8Yps8813ZcUyIo7dT4fRsTKJoOB0IA5fw?=
 =?us-ascii?Q?O0I1bemB0jTp0cQdziX0L4WzbI1maD982ZpKQPUa1DhKPkx9Mgx5xunlIf+u?=
 =?us-ascii?Q?SNane6cyPAn/cXn+2Sw760ZUbU34vGtcsbJIYm65C2jj7jECy5YfQnPCogrC?=
 =?us-ascii?Q?eCxuZfIndPqydHxKQ1ZMRmvioySHlqCmnlfUEkhDHFC7LgW+Z9ztDbn7zCvF?=
 =?us-ascii?Q?2LEUhJMvL4RtnE2VKokRiaPPzxd6YuT3aPiv6Dn2MRPnVnINxbQ32q1qXQei?=
 =?us-ascii?Q?evaJnqu6VGh6ywU51ZpGNAlTgD+ZcENaQsT1kfwMFUVoC11ifiOlL7+IdTAj?=
 =?us-ascii?Q?CQDyrUiwv6gmclpySkhdB/bwY70l0xeH3PXjgG0xJiuNSvf7EUNXfJZjtxcA?=
 =?us-ascii?Q?yCjTphViq+EooUdG90Fa8BKP1pgj3gMx6SaRBhWH0QB35QBTukE3o5HHLVkl?=
 =?us-ascii?Q?p9YLkG8GamCUYIUikmM8qHwZEFSWFHBxK4++5/0qP9yMCFKpfAhy3ZxMyYoO?=
 =?us-ascii?Q?2cFjIazDAZ4TPQw1ORHadM2xHy3IpFfIkX8HrKPS4lG47KViv+GPHDbJtF//?=
 =?us-ascii?Q?K+77Qpla+Xj3vZgHmlreRjT708xDI6Qmcw3nSKOzz4wezVPf06yDiCn6xg1U?=
 =?us-ascii?Q?mwj9wLWMZRDptoQr2Ht+xw8vbeGp/Dud2jYLIQafcBluyFhkdUNEPrShGdjC?=
 =?us-ascii?Q?x7b116wNfmnWqY4xIb67SAUMOZ1VrGztv49uxdPF/Q6elOKlV0x+rFwZ/ugT?=
 =?us-ascii?Q?CqdT3efRPoXFLjzq5bSyZvW9KV+iDIHA0wLJB7NcbrIm1tGOHoVFHAwHeo4K?=
 =?us-ascii?Q?HTQZGca5T+qD5m5n9nghj2srsAILzYw97rcqx+O+cwa4FjwoPtTY0EDEwuGW?=
 =?us-ascii?Q?hJxD6ZmAi01nI+iW+TgeWkukQFhQrWBtOB+A8BOrKbOuYWicSMQ8Q5eI1ufb?=
 =?us-ascii?Q?9OjmFEKL1lNJAQklIGNEqlOw0wtjS6QIl8qe1FUbYDcqIUStfmscylKzQuAF?=
 =?us-ascii?Q?k++56So0bH1JpkNsQP3aKgk4u6/aIEIe2GbwAq35fvAw6wwwKrd1T5dHAmTy?=
 =?us-ascii?Q?GxPWifFko653KtNOnXtz+iY6iix+HY8pLlvTUUI/jUW5nImACXLZmcKkvAsW?=
 =?us-ascii?Q?0lJkMin7z5lodKBIYcgGICYiQ5keNejD4dCbOROOAyw49ESEl+vEpvHk7I9l?=
 =?us-ascii?Q?RBDrWb2bJaiyoC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(7416014)(19092799006)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8CZhXK+qxuCT4Jzh6ug/gW8C9LQhJOlpO88cQwuLjpnw3s3GeNeLE9LT8VQb?=
 =?us-ascii?Q?V7Ury5ccoA05iXbQQL0G6v2USc3PK3rX5JGm9ZIq9tSuEPtv7WrF2oSes7e5?=
 =?us-ascii?Q?nvQyIY7XHoK5oyY70hymWQWhSdJH6qa9h8SAg31wi0sohsByZEiHgfhPFguB?=
 =?us-ascii?Q?sQpw6kcoIOshvm/KfM6BPeJ7UYt1Gp6JHlg9a0GYhY3RoljrbIlzw2gAesWF?=
 =?us-ascii?Q?wnpCSz+nNoSOKN1f9q9IdUI/p29UPgJbfngrIWPDDkTCABCtG+hDQznQkERv?=
 =?us-ascii?Q?Aah3z3NQ0k0y1AG/7bIqwuea08P4cvnN2H+Z1gudbvjUlJkOy+mbnswljm7k?=
 =?us-ascii?Q?3Gbcc6mgA/q/HouD9GKWg5Q4/NP3X3nmLCldQhevAd4KKh+7cxW3US/d4Rdx?=
 =?us-ascii?Q?/DroztAxTTCAtyu3MwDFRR7BRgbrDglANRog+IWXswg9YgqbKe0Qwc58b1qK?=
 =?us-ascii?Q?RXoIwE9E5fimCSyPcJuMxn9c7GifK/eBUOpvOQhQXDxAiETNvmvy4itFDHGy?=
 =?us-ascii?Q?DLtZbfb0yOCEZbFi9Bb9RYTsgY7x3om9sKvwQTk56fRpmMocuNXYZ9SEIZp1?=
 =?us-ascii?Q?93Iy7M+uhpweiu5NeXGNCsh16KqIsWgIHs6NfzrY9MBsg6RkvWqniiU/QiUl?=
 =?us-ascii?Q?4tr7Z9Xs+VhQDKcnawYzhwv2jcK3rkdqp5Oh5Ow67cnYqaFdvYD3oz5bXZFz?=
 =?us-ascii?Q?5YeA8U7L1pygi8nMNHD/QtQnkXYGf7G1c1hdXOWsxplQJv9JWRBChBPNAnVL?=
 =?us-ascii?Q?JwUk6+cTrXmwGAaDO0V3d+zjqINlapTVN0BpOJJC0imkxNsYiD6p+EOluphD?=
 =?us-ascii?Q?O859shhfM2Wggn5kmQz+dqTMXSuG/1TOLvzS6NHc7mvWF8tJMHTSMXStXzkQ?=
 =?us-ascii?Q?7vJpYG78N0fYf4UCJl5WxC4NbBLimUWr1jXr7A5CBR8RcfkAw8k/0Y1Celu2?=
 =?us-ascii?Q?hQdT7bU1I/M/yDBulJcUBlBvzO60uJFFKRIWWyllo2b8utSzbUZemVpBBmnd?=
 =?us-ascii?Q?MFsOc+H3iZpe6LdXYeXrkQIZngBY+emoWRFyyzWWhsEJ6vj/kr8Blofr1feO?=
 =?us-ascii?Q?F6mJ7EJyF9P6jgbJitw/LmZ0fkqwnMypAl+3CzlEcRz4yOloNaSJBdaNNprs?=
 =?us-ascii?Q?GhKycKkFtyWiz6rOzet8p1mBiNCvtPbp3RbKCiuww5J78jyFZ+OnJhmscvpc?=
 =?us-ascii?Q?tYtJCOCSBTooj7zaBcSrVFKf/VQqo7ebLoWrQ6lRfKQohkMeFxeBsuVrQUdl?=
 =?us-ascii?Q?9VtZ9qOFaTallLld9Jgc9QScHWqQYUMRaJTEHUQjIdU3hog2k+2015tRIPNw?=
 =?us-ascii?Q?5nw0jVDtIDiU6l/PgLWYHIhij+QGIEmp7Xjfp3LcRiOnqvXfaR6oqF4YtNbc?=
 =?us-ascii?Q?5m/H6vBJ+PcE6S1dVbynkI6hTy8d73N0KBYDHOlhfZYuyqWKXn6FqIQeA/wW?=
 =?us-ascii?Q?p49Hz2CrQshnd2HtPcmn1lWbRpDfDFOIZpdW60hr0RRYKOy+yWupRf+r9VOr?=
 =?us-ascii?Q?smLLPEvgWibG9uQz55UjtnrRyBmIlklatjWtkokEyu8nagU6kFFQVO7q/bOF?=
 =?us-ascii?Q?WeqiHe0KGmae6lUCZ3/uRHBsfmPrGnNEMWnRDC6f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69eab001-8cbc-4767-50f3-08dddfc12ec2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:11:36.5559
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WXYV+1HN/cfYS3PY2Qy/Vu2TmpkEhaDmpCwrNWdftKBGTwXeLBOtC085AbgifzCmy66crMPAOaP/uw6vmRSYJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6913

The CLKREQ# is an open drain, active low signal that is driven low by
the card to request reference clock.

Since the reference clock may be required by i.MX PCIe host too. To make
sure this clock is available even when the CLKREQ# isn't driven low by
the card(e.x no card connected), force CLKREQ# override active low for
i.MX PCIe host during initialization.

The CLKREQ# override can be cleared safely when supports-clkreq is
present and PCIe link is up later. Because the CLKREQ# would be driven
low by the card in this case.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 80e48746bbaf6..a73632b47e2d3 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -52,6 +52,8 @@
 #define IMX95_PCIE_REF_CLKEN			BIT(23)
 #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
 #define IMX95_PCIE_SS_RW_REG_1			0xf4
+#define IMX95_PCIE_CLKREQ_OVERRIDE_EN		BIT(8)
+#define IMX95_PCIE_CLKREQ_OVERRIDE_VAL		BIT(9)
 #define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
 
 #define IMX95_PE0_GEN_CTRL_1			0x1050
@@ -136,6 +138,7 @@ struct imx_pcie_drvdata {
 	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
 	int (*core_reset)(struct imx_pcie *pcie, bool assert);
 	int (*wait_pll_lock)(struct imx_pcie *pcie);
+	void (*clr_clkreq_override)(struct imx_pcie *pcie);
 	const struct dw_pcie_host_ops *ops;
 };
 
@@ -149,6 +152,7 @@ struct imx_pcie {
 	struct gpio_desc	*reset_gpiod;
 	struct clk_bulk_data	*clks;
 	int			num_clks;
+	bool			supports_clkreq;
 	struct regmap		*iomuxc_gpr;
 	u16			msi_ctrl;
 	u32			controller_id;
@@ -267,6 +271,13 @@ static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
 			   IMX95_PCIE_REF_CLKEN,
 			   IMX95_PCIE_REF_CLKEN);
 
+	/* Force CLKREQ# low by override */
+	regmap_update_bits(imx_pcie->iomuxc_gpr,
+			   IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL);
 	return 0;
 }
 
@@ -1298,6 +1309,18 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
 }
 
+static void imx8mm_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	imx8mm_pcie_enable_ref_clk(imx_pcie, false);
+}
+
+static void imx95_pcie_clr_clkreq_override(struct imx_pcie *imx_pcie)
+{
+	regmap_update_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
+			   IMX95_PCIE_CLKREQ_OVERRIDE_EN |
+			   IMX95_PCIE_CLKREQ_OVERRIDE_VAL, 0);
+}
+
 static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1322,6 +1345,12 @@ static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
 		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 		dw_pcie_dbi_ro_wr_dis(pci);
 	}
+
+	/* Clear CLKREQ# override if supports_clkreq is true and link is up */
+	if (dw_pcie_link_up(pci) && imx_pcie->supports_clkreq) {
+		if (imx_pcie->drvdata->clr_clkreq_override)
+			imx_pcie->drvdata->clr_clkreq_override(imx_pcie);
+	}
 }
 
 /*
@@ -1745,6 +1774,8 @@ static int imx_pcie_probe(struct platform_device *pdev)
 	pci->max_link_speed = 1;
 	of_property_read_u32(node, "fsl,max-link-speed", &pci->max_link_speed);
 
+	imx_pcie->supports_clkreq =
+		of_property_read_bool(node, "supports-clkreq");
 	imx_pcie->vpcie = devm_regulator_get_optional(&pdev->dev, "vpcie");
 	if (IS_ERR(imx_pcie->vpcie)) {
 		if (PTR_ERR(imx_pcie->vpcie) != -ENODEV)
@@ -1873,6 +1904,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_mask[1] = IMX8MQ_GPR12_PCIE2_CTRL_DEVICE_TYPE,
 		.init_phy = imx8mq_pcie_init_phy,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MM] = {
 		.variant = IMX8MM,
@@ -1883,6 +1915,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8MP] = {
 		.variant = IMX8MP,
@@ -1893,6 +1926,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.mode_off[0] = IOMUXC_GPR12,
 		.mode_mask[0] = IMX6Q_GPR12_DEVICE_TYPE,
 		.enable_ref_clk = imx8mm_pcie_enable_ref_clk,
+		.clr_clkreq_override = imx8mm_pcie_clr_clkreq_override,
 	},
 	[IMX8Q] = {
 		.variant = IMX8Q,
@@ -1913,6 +1947,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.core_reset = imx95_pcie_core_reset,
 		.init_phy = imx95_pcie_init_phy,
 		.wait_pll_lock = imx95_pcie_wait_for_phy_pll_lock,
+		.clr_clkreq_override = imx95_pcie_clr_clkreq_override,
 	},
 	[IMX8MQ_EP] = {
 		.variant = IMX8MQ_EP,
-- 
2.37.1


