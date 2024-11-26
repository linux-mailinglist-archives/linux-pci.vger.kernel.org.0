Return-Path: <linux-pci+bounces-17325-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C59C49D92F3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 09:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E28D165863
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 07:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C697F1B87C0;
	Tue, 26 Nov 2024 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="KByZizsd"
X-Original-To: linux-pci@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011004.outbound.protection.outlook.com [52.101.70.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44E11B532F;
	Tue, 26 Nov 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732607925; cv=fail; b=Uzg2OOY0fKLS3ktE7bUgvZDShTWW/AXQijuHYwMHznFm7I1bPQimqTlt40eO+cLvMHIPIQaXbVTxUMuv2mr8oRIQzJUJoXlk3WyWvpJxAi8CuI5C98XPwwIuGOJzE9FLK9Bn0ZbEzEJOovRkHHIj5cQArDb8qRJYSY8sTyHjUFE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732607925; c=relaxed/simple;
	bh=BZLP3mMl8OE6ZEx+SJt0mzRm7+xntn8dAhQolWVM/0g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lt5CkgPu9anuR/rUyz92mj6v3iFrYl7DxbaqJfqfCQtnzC+jT9ZPZuiw6KQjTHTYMvPrpRGHkle0X/dz4aipfamFGT2EJ2P0Oh9grFwjzb8ZZp3SAZqSsZAhWz64TRAlx6FW3MSwwsJle3NDUynjLcol4yjI+v7jhHdt30uXRiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=KByZizsd; arc=fail smtp.client-ip=52.101.70.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S1umzTBTdUxb7yzJ437qJXHlUCHrmq6semEt+hfGxDCwSZiyzXaXIcGyQts9gx3VVMcnxCDJM1Qovh2We+Ql5Txu/t4bjzW23knyGmW5zTJVfdrO63AuO+j/UItvjZwqb5A1CiAjfmApixDBvScXHoSerx4wpJHbOgo9UdGD5+QwIIuctEGTgTYnL3wrhYY6X8mbyDKppt1ANGP9ig1+RaVn1XplbmvOeUmD73PqocyHOF1vYpSmDxPktWEsDI0DICCxa8eXYlEb6khmvzyouf09GdhNSs5anm60W7fAsS0KB0cS/HP8iDHfFwC/woZaKo+RoQ0JSKG4WtkdfuW57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w+OKB8DzfxagjRKA9ol6U2fawtn/kUe8NHHBHTyWjvE=;
 b=sXDBYTgNNkA8Qjsqux0zWnc1laZ78wlxKJ8UTOpVluFCRSQtUZTmK7B0le8QGkrzT15ev7fTXQgqciB3aZmmpTRELnpukL8jC73J/jK73YzJgxelI/T87OUb9e3xdbuxF++D798FPp95sPdth8O8G9NunpVri62ouQtoVJqRQyQUNEOOMuVCvI7GdguYP5SG6X1yYhi7oR7tSSXZkLkDWvmrSj3aTt+H3bGsEV/reOXGMsI5bW/z4UXb5Kqpig5CdER2QX4wktS2D9aZLO7gZ+/yRlOQl5mlzrHqBCVz/2AHsDFHGLsgNRmFIbJI33dPp4bdWj3FrSGfdi66liiBSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w+OKB8DzfxagjRKA9ol6U2fawtn/kUe8NHHBHTyWjvE=;
 b=KByZizsdS+6SBmxciGLE3UMVTE9RekkFB3040Zw8/4kS/wUBcCNhszwDvqRNRJy8CqDe1O3XPOpslgk+9uzwgmLmoFrzyL7cOPtLwMtWvBs0dkSxz9LaQGHbfLYiLkHT1PbZBXFnEo39a07Vn5VGm0Tdy+hJ2LzVclwNvBd0uvxxIUXS8T5r12X4WqB6kwWniB9ofDcZtZ+Jrve+s2j4Hy148BU9ritdMZhUKS4XgxiHw14a2vhaGtn3rUmd4PcCk51O5d+WRe0jxIq16Ga6YxXBSH776pf7cFHozrBmX9PqRFj2nEuLJmPfBBNCKJQmXqrGdJ2COQfH6OQucp2fMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by PAXPR04MB8489.eurprd04.prod.outlook.com (2603:10a6:102:1dd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.20; Tue, 26 Nov
 2024 07:58:39 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%4]) with mapi id 15.20.8182.019; Tue, 26 Nov 2024
 07:58:37 +0000
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
Subject: [PATCH v7 08/10] PCI: imx6: Use dwc common suspend resume method
Date: Tue, 26 Nov 2024 15:57:00 +0800
Message-Id: <20241126075702.4099164-9-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
References: <20241126075702.4099164-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0060.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::17) To AS8PR04MB8676.eurprd04.prod.outlook.com
 (2603:10a6:20b:42b::10)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8676:EE_|PAXPR04MB8489:EE_
X-MS-Office365-Filtering-Correlation-Id: 9600350a-d2ba-45b9-2f49-08dd0df02219
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?D2yHNax5RTCAgL/neX7PXXTJCRotTbDlxrpe4yrxF+Vwx50wwk4S8ENFklGO?=
 =?us-ascii?Q?QxMzJBOnB02bysa/Gbe+z7pNICpDO4N2L5i/HAIDlt+8HSJyAtlQGh82+GDc?=
 =?us-ascii?Q?VYyEPGx++i10WCPmFj0Ld/7HDLwf60xJPqlF6JDSxYUl5/mH/tUZ94wtAXoo?=
 =?us-ascii?Q?9ibw1Ffg5Ol+kIYQi5JBLJr6Ajnx7ZP4j+T/5rveJxaV0MUHjeZWW+bQAPhL?=
 =?us-ascii?Q?jHQIGwn1rEC5ahaEsLrzjOSPdktC0Wz0HQS4RXhcDeq3/oIspxghifis9/96?=
 =?us-ascii?Q?KOKzk/c1LAQrwRMmaXzoFzKy6RbVd3ZFsjeatgOJowjgy21bYxJnVNBUCLmW?=
 =?us-ascii?Q?8EJmlgkbEDefM0iZnLIvTkoBkO7pfFwwiifPojKsMEds/5kPOiR4l7vOGNio?=
 =?us-ascii?Q?OR78XbtvBZdR6l8Qkcq6EQTpAEnaaGsFbHpNSwD6gB7CTt0NWYnvMq9t5V9p?=
 =?us-ascii?Q?52sUo3SdVq97u6d3Z0vLihDaYLn9NsQzfxaxp5cJF97yOQJRAdYGFWAopjEc?=
 =?us-ascii?Q?yV22NbEwiTHrnsVyI0DxzobNNHhp67zL3DLyAbcnQmQdfsMkVp39F5sQrw6l?=
 =?us-ascii?Q?3faaSL7kR6S7lQmZZqRFv5Q1wVIaQ5ehi4KEPvqDNeMPvOVCUSDoeDkGv31A?=
 =?us-ascii?Q?k4aigWLLjNySlmJmae143RggZcYbitBgio2yH8F/E9OTLGIPCyO+AA5WymL2?=
 =?us-ascii?Q?alBTbliNn/sCh7cNs77N0kHqqWr+RkZRFue3CS1WZb9dgN9UnJ4hKM4k7rVP?=
 =?us-ascii?Q?Qyv37aU3SB4GJ1E43QJx5uzLOqpeli/ZdijrBVNf1kr9aEoMBeWZty/Pfczq?=
 =?us-ascii?Q?B+eKdAAvSoj+/3onqD0xi7Zm5RBHMVlgeh21Vammq00EMtoGtN6Kkm/sXLQ4?=
 =?us-ascii?Q?u/7ZAMFTLv35JRGv8eoUv1whSVHpdb90UQ7Bn4wOV6nnz2DawzB0T92v6Qeq?=
 =?us-ascii?Q?gajo660xZDlPE9RGLzH75Gu1+7jKsFOD/ocA1FSkBoByahjI1wt8wNwzzxvZ?=
 =?us-ascii?Q?YIZ1JEiD9ghZUNzYgYeszBjFrFDMy9kGqnb5GR2ZRcdEbJ2lQvYPIegLSXu8?=
 =?us-ascii?Q?Vul0gpppMUUwH6jMWyxvIoFnyiA7RLrWUFAk0/91D0OffSQhfGaoQEMjWNE1?=
 =?us-ascii?Q?CPJCAQYkExxde2AFTXnZeXuMiTb1UC2UFEHbPhi1pljPHDo4MUKWjpHWIciU?=
 =?us-ascii?Q?c27ptpuol30n1G5QkGPkZMQdpBkCFofomiBhc8AoChk8Ii8Va+oYWqZ3w5eN?=
 =?us-ascii?Q?gkV7E+kG31ZyJ4+C77eT4A5t/uU7CuXN3kxMd7+ZbiJ95NWeyfx1XlP6cdYj?=
 =?us-ascii?Q?2B2l7hl6VQZwGoSBP+EVdRFqvWWmpVu3G3WshaNANgYxwEOIOhR4pV8YPw8i?=
 =?us-ascii?Q?/PnSOrpyqgRbMb1Pe/GyU9hDKpnutGKtIWtedc9NtLRDvLO6MvX8L/k9Syk4?=
 =?us-ascii?Q?TMcBzxV1Kfs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WuEhwjlj1xnlJOWD7f97WU8QFJNzoNQp7AF9Z6K8FZqIZVx3chURSzK6qc+K?=
 =?us-ascii?Q?ioydpZyXgUg2MFW3Sm9xLgEGH2xeQq/+wLgcess5n8SJ3SN0zqLR31En7XO1?=
 =?us-ascii?Q?LFqq2HFfwJV75Ghj3u6JMLqvL01GAS7c807Jc9srRyfPWuUnvGEhAlTDrGxN?=
 =?us-ascii?Q?c6/FuEM0VXhWwcACwYHhjiyOA4oCddGgEadhkDWhBupFxVuiZlFAH4Cmqaoy?=
 =?us-ascii?Q?DGYxAiVEgZQFfkidtnwFzf63d/99u4L9Wda0kIjaRm08gPqRkNKmNbX/7GKS?=
 =?us-ascii?Q?LoNqKMCNC2QsA6WIPFsW9DXHvvNYjVwVR+lQdWYBbK7Of2okAuf2uzEDxc+W?=
 =?us-ascii?Q?kgTGk38tVS36DyfPFS5U/A+LzggQwz7Faz3RBMi8b4iNljPvKUiTAqzwVLu6?=
 =?us-ascii?Q?5Ua0aaZMAzNBohhQh1/LUIKV99FFqpDVADuDJnowfXZB9hmv0k1akVQQBGhh?=
 =?us-ascii?Q?PHzP7+jGPRzOYoxyJypbD3JmL3aH5JCad4CK/6yDPsln+zdc1MNFphTtAxnN?=
 =?us-ascii?Q?Fo6swlGs4amIcLPJRr3GynDDS+J3PYUndnjYrj17P4sa6/KPIpRnHn8RSzQ0?=
 =?us-ascii?Q?51MtnhgkGT6GM6YwW5rX7breKH6XKUrJJlP+w3H6AaMFqq0jX2ZnkVJUHtZN?=
 =?us-ascii?Q?xgUxfNJICA6rT9E/8aq2POFyzVnKUsYXh4hTimepBiq5loqQDzc6f3S0Ql1R?=
 =?us-ascii?Q?V93YY0To5Rw9uCd/ap1eelY5EH9XixPyu19cnxj57mVCUif8ZVU6Hi+S56AA?=
 =?us-ascii?Q?wqB+u7KU8Woh/TPRpBZXPsvbYtalTzcq9wthMRQqD306MT9Ehvmn5sHcqduj?=
 =?us-ascii?Q?wti9Ht3pL/5+0+L3jlBZO2uFt761WQUlvvDmPXKz5dLjfINHyLBg1OuG2Goj?=
 =?us-ascii?Q?dU2smMDfLrojMPjOApdv4v7Mb1YAbcO/pGzi9BvVzBESPwhgzYmlBZJlQpo/?=
 =?us-ascii?Q?Zpo2/1k/iK9ksbyw4LHMasTIivZfFgMkW39ngmdkkV7kTq7NiUJtqZi05X+j?=
 =?us-ascii?Q?/tmuSGvvvVMi7s0KB2D06rUJvuU+xlMv3JgkApV5Sy3cpf7UTubhYWHrwHUj?=
 =?us-ascii?Q?z4W/cmrY5JeSfhFk1pVOXeJoZdtbLQAlikWEDnGs0cibTK501ZUyKTg9MxFA?=
 =?us-ascii?Q?owIgQ5gdVJecp5xIRqUPdhWS6SG0gFeNQRbvYOJGtfCBCFMvQ9Rid23gKs/J?=
 =?us-ascii?Q?514NSdO6+PYv2E5nQMatJvmKHLHKpo1u7A65BoUg12gZ1QKHm/rWS8J3MSrE?=
 =?us-ascii?Q?FYAwe4JvW+1FMF/sXu99sfh4jZP3cvaKb4zVuuqvz6ba0zGy4d8WhDQblPjN?=
 =?us-ascii?Q?DkmwH3ljHSH9/3d1UMcWMm78bAQHQccghu18PGShqpqO+x1Cv8ivVAcM7IZ7?=
 =?us-ascii?Q?/s//b4VQxZQoLIJS+53HAGSVtTXrGh1MfseuFeAHndB4jwKdjSuvfQnRA2ZY?=
 =?us-ascii?Q?BC+2xi4SGx+uz2GocH4ijvtXgQ0oSSONKajY/gNNasefL6RKGRFnhm/MGknR?=
 =?us-ascii?Q?0oVfqyE61zzPq2U6+rGMXmzFtK2ppCPNyRAbW8f1kliD4I8/t/I7hzv8knLw?=
 =?us-ascii?Q?xC2yyQ8aYyElfM7+qoAvPS4t116rXrf6MMTma5lk?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9600350a-d2ba-45b9-2f49-08dd0df02219
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2024 07:58:37.4304
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8Wx+AYziR1x9uLuEKsv/bvWp0Fj3P9weS5nQA97eZmAIEB4kGfZIZHbJe1CH+6BXIhIUYFNG19GFlDmCwuwnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8489

From: Frank Li <Frank.Li@nxp.com>

Call common dwc suspend/resume function. Use dwc common iATU method to
send out PME_TURN_OFF message. In Old DWC implementations,
PCIE_ATU_INHIBIT_PAYLOAD bit in iATU Ctrl2 register is reserved. So the
generic DWC implementation of sending the PME_Turn_Off message using a
dummy MMIO write cannot be used. Use previouse method to kick off
PME_TURN_OFF MSG for these platforms.

SRC(System Reset Control) interface is used to toggle 'turnoff_reset' to
send PME_TURN_OFF and since the DWC implementation is used, it is not
needed now.

Replace the imx_pcie_stop_link() and imx_pcie_host_exit() by
dw_pcie_suspend_noirq() in imx_pcie_suspend_noirq().

Since dw_pcie_suspend_noirq() already does these, see below call stack:
dw_pcie_suspend_noirq()
  dw_pcie_stop_link();
    imx_pcie_stop_link();
  pci->pp.ops->deinit();
    imx_pcie_host_exit();

Replace the imx_pcie_host_init(), dw_pcie_setup_rc() and
imx_pcie_start_link() by dw_pcie_resume_noirq() in
imx_pcie_resume_noirq().

Since dw_pcie_resume_noirq() already does these, see below call stack:
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
index 743a71789d17..87dac4ac9d10 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -33,6 +33,7 @@
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
 
+#include "../../pci.h"
 #include "pcie-designware.h"
 
 #define IMX8MQ_GPR_PCIE_REF_USE_PAD		BIT(9)
@@ -112,19 +113,18 @@ struct imx_pcie_drvdata {
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
@@ -903,13 +903,11 @@ static int imx_pcie_start_link(struct dw_pcie *pci)
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
@@ -1014,9 +1012,31 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
 		regulator_disable(imx_pcie->vpcie);
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
@@ -1143,43 +1163,6 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
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
@@ -1203,7 +1186,6 @@ static void imx_pcie_msi_save_restore(struct imx_pcie *imx_pcie, bool save)
 static int imx_pcie_suspend_noirq(struct device *dev)
 {
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
@@ -1218,9 +1200,7 @@ static int imx_pcie_suspend_noirq(struct device *dev)
 		imx_pcie_assert_core_reset(imx_pcie);
 		imx_pcie->drvdata->enable_ref_clk(imx_pcie, false);
 	} else {
-		imx_pcie_pm_turnoff(imx_pcie);
-		imx_pcie_stop_link(imx_pcie->pci);
-		imx_pcie_host_exit(pp);
+		return dw_pcie_suspend_noirq(imx_pcie->pci);
 	}
 
 	return 0;
@@ -1230,7 +1210,6 @@ static int imx_pcie_resume_noirq(struct device *dev)
 {
 	int ret;
 	struct imx_pcie *imx_pcie = dev_get_drvdata(dev);
-	struct dw_pcie_rp *pp = &imx_pcie->pci->pp;
 
 	if (!(imx_pcie->drvdata->flags & IMX_PCIE_FLAG_SUPPORTS_SUSPEND))
 		return 0;
@@ -1250,17 +1229,12 @@ static int imx_pcie_resume_noirq(struct device *dev)
 		ret = dw_pcie_setup_rc(&imx_pcie->pci->pp);
 		if (ret)
 			return ret;
-		imx_pcie_msi_save_restore(imx_pcie, false);
 	} else {
-		ret = imx_pcie_host_init(pp);
+		ret = dw_pcie_resume_noirq(imx_pcie->pci);
 		if (ret)
 			return ret;
-		imx_pcie_msi_save_restore(imx_pcie, false);
-		dw_pcie_setup_rc(pp);
-
-		if (imx_pcie->link_is_up)
-			imx_pcie_start_link(imx_pcie->pci);
 	}
+	imx_pcie_msi_save_restore(imx_pcie, false);
 
 	return 0;
 }
@@ -1291,11 +1265,15 @@ static int imx_pcie_probe(struct platform_device *pdev)
 
 	pci->dev = dev;
 	pci->ops = &dw_pcie_ops;
-	pci->pp.ops = &imx_pcie_host_ops;
 
 	imx_pcie->pci = pci;
 	imx_pcie->drvdata = of_device_get_match_data(dev);
 
+	if (imx_pcie->drvdata->ops)
+		pci->pp.ops = imx_pcie->drvdata->ops;
+	else
+		pci->pp.ops = &imx_pcie_host_dw_pme_ops;
+
 	/* Find the PHY if one is defined, only imx7d uses it */
 	np = of_parse_phandle(node, "fsl,imx7d-pcie-phy", 0);
 	if (np) {
@@ -1368,13 +1346,6 @@ static int imx_pcie_probe(struct platform_device *pdev)
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
@@ -1454,6 +1425,7 @@ static int imx_pcie_probe(struct platform_device *pdev)
 		if (ret < 0)
 			return ret;
 	} else {
+		pci->pp.use_atu_msg = true;
 		ret = dw_pcie_host_init(&pci->pp);
 		if (ret < 0)
 			return ret;
@@ -1519,6 +1491,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx6sx_pcie_init_phy,
 		.enable_ref_clk = imx6sx_pcie_enable_ref_clk,
 		.core_reset = imx6sx_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX6QP] = {
 		.variant = IMX6QP,
@@ -1536,6 +1509,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
 		.init_phy = imx_pcie_init_phy,
 		.enable_ref_clk = imx6q_pcie_enable_ref_clk,
 		.core_reset = imx6qp_pcie_core_reset,
+		.ops = &imx_pcie_host_ops,
 	},
 	[IMX7D] = {
 		.variant = IMX7D,
-- 
2.37.1


