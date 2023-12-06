Return-Path: <linux-pci+bounces-576-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0477807439
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 16:59:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CADF1C20ACB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EC245C14;
	Wed,  6 Dec 2023 15:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oDVjupvD"
X-Original-To: linux-pci@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2082.outbound.protection.outlook.com [40.107.21.82])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C51A5;
	Wed,  6 Dec 2023 07:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5L6VjDZDeki3u8Uctqob4cgyCnX9QYUCBzoCwlhz9by7CVyuPqGqx4vWSveiiWXyPEBGBKsR8WfIAWkJJgzN6wzX5Sr79pCAEM27oQQDr+P2CihmkaozFBJBaRvN4UnpbB5qim+wmmI7uYucS7MDUgSlN9fKjfPeU23TeKbl4NYZPWN3g851EkGqk6QLq0ulWmAJ7VQVtelw8Bd7nu3yvfjuwNbJZ5B6rvn3vvTU6x7qeijk+DHeYQfrqGasfgmeAx7giLuJZxCVV0nXioQQf4NfPRewCLrjAx7LDAuHz1gpuW2Q4wTZXM+K31Eed9TfSAKdr2sUnQ9e0JHYHoAnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jviUz8KcWIzmXgQFJ9JrfZ9d5CCv5eulcWs9kGqJk68=;
 b=bYtkdJBnWZJhRrLqWpljxSQyF6HFE4kN8v3Bxtl3VOB6vczbjP4h4sNdN/tjjhEBJSocLgUG3EQYhorB/krI5QeSJqTfW3cwBXe1cA4wCcLOLq9+TzyWcfmc1Fl/l4Lt5EpaAKAgNfQ58qRrqOSfAPQdpW/vcDLOy7itZtVcSY/NqAENIGV7+Lj1G1wULrUFLoba5mlnMr6tU5N8HlVbdbG+RnlW6wF/4LcnK1cfW5YNkPc3C0R7nhUcFcnEZAbe83vuQrXMlF/J/uHrEx48jp4wDPfCDU1pDuErarOWqhCzt6EJK+RP1KeaGRZyavQB1J/Bezmxz+O17h0oWdekog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jviUz8KcWIzmXgQFJ9JrfZ9d5CCv5eulcWs9kGqJk68=;
 b=oDVjupvDJjaGoaef8OvO5hgPS56KjMWsPbApSTGdGNNu2B++pGyb5GZ4yctum3Tvs27dzpfOLH1t9ku+4Bw1j7rtmEiN70/yTYZPE2Bj2xgk5DoykBhE7x2tn1xO7aCdcW2+ondW24FaEwiCVUgFc/kRnf9lygXY/I843yAnF54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DB9PR04MB8123.eurprd04.prod.outlook.com (2603:10a6:10:243::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.24; Wed, 6 Dec
 2023 15:59:24 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::95f5:5118:258f:ee40%6]) with mapi id 15.20.7068.022; Wed, 6 Dec 2023
 15:59:23 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	linux-pci@vger.kernel.org (open list:PCI DRIVER FOR IMX6),
	linux-arm-kernel@lists.infradead.org (moderated list:PCI DRIVER FOR IMX6),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 0/9] PCI: imx6: Clean up and add imx95 pci support
Date: Wed,  6 Dec 2023 10:58:54 -0500
Message-Id: <20231206155903.566194-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR21CA0015.namprd21.prod.outlook.com
 (2603:10b6:a03:114::25) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DB9PR04MB8123:EE_
X-MS-Office365-Filtering-Correlation-Id: e9acbfed-3f47-41f7-909b-08dbf67450c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cor1PTRSyNkNGMLAei7rux54q87NuMtQ4P7MY9akmE6OpQUm7JhcgxM99/BmUmSgmULceCX6el1hgEs5/pYnmjms6EinYYZsEsxjpJiW3VhZqAfnytrOPSPRvzP80f4c8FJQKWC4rWx5GLHmKdMIedpEtO0dERW1NB25ozPAgTUTfydC6TzUIXnqPjidGVJKAOnCDGZ9yxiegDJRdo1P8V2w0+IPrx7KMVjJ5oabxupDYsSXd0HA8Z9sW07yn3gZzE5iEdvKBFgXhNaViGQJFGyu0bIWbHNTT/0yPtEsEY5mFVmNHEojGbBeGZ+512Jj264tUiBbCgmo5flYb4lMiVCDxVxMPWu5sFii6OklT+PxIsSv0cHC+9nUZi20y2ZT0e53m+Du5MeRYeZRGdjp+kb4hYlmVf39Bdq47Wa5GlP6Q4KS9IvywqQp0LvzJmnKpqQIDDwtZsSaB8gyo4Af9K09yFIGP+bSYA4rxA03oQ3xtSQErlgIXnDK6xTTsrvXPRNnhGO0kSVEHDwzZuadDy692vjQL5Zx0ZDscfcKK+euOwd5Z/gBTiz3hN0Mzhqy6eQvNdjBo29nP4B+8b0Nzh6dqq1ICok1rKzUmPM0LAXxtZP29PfXDVekGwogvRqrktiE5JZlCq0gfkARfOM7rA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(346002)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(1076003)(41300700001)(83380400001)(36756003)(6666004)(52116002)(6506007)(2616005)(26005)(6512007)(478600001)(4744005)(921008)(38350700005)(6486002)(7416002)(316002)(66946007)(66556008)(66476007)(86362001)(38100700002)(110136005)(2906002)(8936002)(8676002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eyHhdGZsLkO33Y6Ki9Qlzt2vFuj1H3ZnymZdJx+9E4FllXwHL8BhMwB1a3JL?=
 =?us-ascii?Q?BhXMIgX7PXmQQBpwyYK/iSOYiplaxRQNKmRn8Kkkvbn8cBD6Y+TcU16EH3JT?=
 =?us-ascii?Q?0cy5C2kQjejtBTLaQyiMreySdlc0C3hqM8WLSkB4ym0kMKmoYK3fQr687i0e?=
 =?us-ascii?Q?q8p9SJJyM8HedwuSoh0UsADszQk6vwPAu8Q4LTZUCBFySSgNh1MFgoCkbkU5?=
 =?us-ascii?Q?igCkFONWOxuULWX4yXfKV2U3hTTHJQtfxBUVXFZUxAhQejp1o33UsfuC2rWg?=
 =?us-ascii?Q?e8hfBweE3xCBbSvxE1v0v3RuHMhoo7qruSfAxpxtGxDjbGaRrnra5hLdFdQe?=
 =?us-ascii?Q?aw+bZujmWLGn6T5HuDxklHPsfMcxJI7xGGjEkbINUUa1baUByHQuIWjjxXoi?=
 =?us-ascii?Q?dKzUe0bI5AG/qFx6ys3TpEdtFcVxdGEkli7PA9klrY4hT1DuHFv9fgwzUmCq?=
 =?us-ascii?Q?peMC68nwXGUXga9R0uP5FeyPXX/prpTNcuNBFqSYxSyXFuLnSJqDfbcVNVHR?=
 =?us-ascii?Q?2f3OHnDuMwAH6JvnaO8n+Y9vxi5gzhhrfqLxvveSYVtQx+iKSqSjkm6xuFPh?=
 =?us-ascii?Q?Qeomuthlhk8hnirrNFsrcDPympTuN8QWR0MUPy63WrH+2gTJ1XqAmI0yQduS?=
 =?us-ascii?Q?zG5WWukKzOy8j1tm/hms6hP1AwNvWOC9iQmE1tiCi5RcgHxrdQnjPsqDnc3+?=
 =?us-ascii?Q?B8ewmmnvp/w/CJsbk+5FC4jeNSbXzbIPheOYYt9IrpS6pSK9T1nn9lGq2Ghu?=
 =?us-ascii?Q?Bb4wArwELQJWh9cLa2ob20ruV0yB///i9aWUtItj/GY9zpPzbIigRbwC2tE4?=
 =?us-ascii?Q?ilypcOlNT5nQe+APKd9TruuH+rIqcU+ff1q7vB0kzBJky1+/8zMyo/C7ojxI?=
 =?us-ascii?Q?puXx3DhZNbwTVPXK4e5fxAgKMNoa1w5vu0lc8wHGvPEbXRoCVzxn8wvV4rMs?=
 =?us-ascii?Q?zfbtVej/sY9pkehF1KKnpm+cIG7Rsg4DSWIqRwz1clJfgj2kInOaHyfNbGVw?=
 =?us-ascii?Q?BXzOALRYsGMYhcp8tGJ4NW+rZsYM8qLd2vCFPFUktZqIXm3ixQB97DTcU2Ak?=
 =?us-ascii?Q?LBCaJQYxerkES537jg00itc6C9j+YcSt2YG1rPLPmLkPrKhK2CW5em3I+KrK?=
 =?us-ascii?Q?uwVHb27tZ8A0LNb6n4tuy9xOnTEQZMnzwYsU5bnYuT1oS005JY48nv26NK/W?=
 =?us-ascii?Q?e46ktR4aNa+oX9W4tGgJ1lspoUZVLM1bzsjH1ebVpPsuTsfuMQKLZMslN/M7?=
 =?us-ascii?Q?JwasU8bZtjWrKiXdbIGiS/yhTSd2xwYDsaHFGLa9Lirm6/1xpZrvUYnvt9Ja?=
 =?us-ascii?Q?XuDfppwSERWVLWfXy708thE7ppE/yZvglqC19h55kn7CvCUOxdPX2SONtH6d?=
 =?us-ascii?Q?VeBDuuztx8R3TpTGrRGNJxDjzgYhsV56VHAzRh4RGJCieU5z67wJ2brULzY/?=
 =?us-ascii?Q?dkBIkPKUBx6Dhh4bVlc+ZDB6cz34Q4KkaNrvtYh4pKBbiXS7y8O6CiPE4CIl?=
 =?us-ascii?Q?vkrl9XURqDsIF6xDmro90XS26CgEpUnwEC8Dp+sn8L63wOieNqfYHQqz5dJ1?=
 =?us-ascii?Q?BkwG5znyl/8n8/tggrE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9acbfed-3f47-41f7-909b-08dbf67450c7
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 15:59:23.8230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xuAlNpAoS674dJ68XlXl3XrSiCaLHttn0CQ2BGrL54hDrkpxRHgYqmNlhFp2nHAFjCpp9epqGwuYCBVJJN75LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8123

first 6 patches use drvdata: flags to simplify some switch-case code.
Improve maintaince and easy to read code.

Then add imx95 basic pci host function.

@richard and #shenwei

This just precode, please review it as draft ideas.

Frank Li (8):
  PCI: imx6: Simplify clock handling by using HAS_CLK_* bitmask
  PCI: imx6: Simplify phy handling by using by using
    IMX6_PCIE_FLAG_HAS_PHY
  PCI: imx6: Simplify reset handling by using by using
    *_FLAG_HAS_*_RESET
  PCI: imx6: Using "linux,pci-domain" as slot ID
  PCI: imx6: Simplify ltssm_enable() by using ltssm_off and ltssm_mask
  PCI: imx6: Simplify configure_type() by using mode_off and mode_mask
  PCI: imx6: Simplify switch-case logic by involve init_phy callback
  PCI: imx6: Add iMX95 PCIe support

Richard Zhu (1):
  dt-bindings: imx6q-pcie: Add imx95 pcie compatible string

 .../bindings/pci/fsl,imx6q-pcie.yaml          |   1 +
 drivers/pci/controller/dwc/pci-imx6.c         | 513 ++++++++++--------
 2 files changed, 302 insertions(+), 212 deletions(-)

-- 
2.34.1


