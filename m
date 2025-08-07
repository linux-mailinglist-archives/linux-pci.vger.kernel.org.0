Return-Path: <linux-pci+bounces-33522-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36530B1D306
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 09:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3F62188E853
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 07:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EDD233713;
	Thu,  7 Aug 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="guR9cags"
X-Original-To: linux-pci@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011071.outbound.protection.outlook.com [40.107.130.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61A2230274;
	Thu,  7 Aug 2025 07:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754550598; cv=fail; b=VmLIW93j5UkTa9M+KB1GYLesVHfT2f7St/tVBVmEiXOlw9M+J4XYEstvEbCajIzv8aPlc+JQbfE0KGKrSOWOM0ON4H1z2RYk3hPy7iGGaNZqymes7HiWag0A0GagyVwu+YL/YZ9NpVckP88Q1gTmJ5JsO2nNYDzyWokxwZdp/Wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754550598; c=relaxed/simple;
	bh=3St8Ocdj9FK7XCvRgdbfcQkR6G5/TXFSvF5r8DKstzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gdbJ8NWH5qiW+e3ME0uJwwTZzUB8X7PgKp5XsovteBlEkgwWUN4kFiP5n/ajN1zO2CmtJGKtB2kg8VTRruPMxlNbv1pjftJZQB4NaGTRCcSL/k7j1NCoahI+MJ+t/6WW/zuDyiAtobnpO33HvCS4HDnlu0ZD6glYWd++P9LSrSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=guR9cags; arc=fail smtp.client-ip=40.107.130.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfmTiLhK3wQGZYTBWJgh1IttqiwPB4IRa9Cj8201DC3yT+qwV6rgT7OQesEY8fAPUfnTzmQyWm56UPecWeEQEyzizIh6r5vbEhQ7cM8Jyo4pC0WAWausay6FvnUbp/0F2QcwT84x3o4Vo2tbTRFZjxc3K5cf5RZrL7UVm/uUy6psEwAFp8aF03u4EWZP8QnAhdjFt4JH2YpP1bqdXAJ2dUe+riaN8w9adgctcGu/CUjAIAgPF2eYEWCt1V4WPN2kr8d5hYNpqQuuxwphfunoPDTNOhVABLiHOE9Wkn7Psgztpsbt0pjmqxy4nSfIZZO3PM9745LlMcjbBeH5HtAjeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z5hlfoyIT+I5f55nCNfMrrYTGm0TlgxVvpty0tFsp3g=;
 b=h/QR8pCM+7yGnRSmcpYP3Jw/AR3cFf22gnfwB95icgTIi4xYwGhDmycUwIfOggnzvYaIb4A7G7fk3nUwZF619eAV8TktrpO8G+qGTdygA/oMGocjRQCRXExDKkOvqvUmpZ0utNCQv1LsEasPdDv2NxSQuhGxGdOBc+4DA8/hYkv1J0rj0yZ0XhkdwhMkgfupLzdnqIGF/h+i6UDy58ok8bo7mTIlXy+B9Lqg0Fx2JFlvuhU/a5jcwq6b2jNcstXUGDwk9y1MvIh2+CnZvvbjp6DGoTmSs330IPnCjh7/BJe3wnpyAOSn6P6agdDaZXJRerlZnfFuVYX75B1tipcQvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z5hlfoyIT+I5f55nCNfMrrYTGm0TlgxVvpty0tFsp3g=;
 b=guR9cags5FqL6tz9Gn8X8mm4UzcL9WOQ5OkrlxCaIW6QC7Fy6zzJILTXAxe4a7eWeLIutvxSrORgHAMigGPE14yUDVAm+oA2iD5Eq1VKPa6KCVqE1S68wcmnUTeztGmksvqCrX2zxLmmEzjrgFpPM/Pex2zryyBsFkZzaDSplq+avwoPDx7hX6xQvZJNCuzM2gdAYK9NPA568nu1FJOLlaTSkTc63PDCvNFxgXtjQ6fI6k7/zKC4SbvQsAvFWuRGu9wU6hPPv6JSjLDbHaYS6LphiJ6dzo+KYa1tfz8cSPYI5uDD/uzLuR9jdchh9bRjZsqcMVbsrU7PaSxnVtOyEw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
 by DU4PR04MB10814.eurprd04.prod.outlook.com (2603:10a6:10:58d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.16; Thu, 7 Aug
 2025 07:09:55 +0000
Received: from AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86]) by AS8PR04MB8833.eurprd04.prod.outlook.com
 ([fe80::209c:44e4:a205:8e86%4]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 07:09:55 +0000
From: Richard Zhu <hongxing.zhu@nxp.com>
To: frank.li@nxp.com,
	Zhiqiang.Hou@nxp.com,
	bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com,
	Jonthan.Cameron@huawei.com,
	lukas@wunner.de,
	feng.tang@linux.alibaba.com,
	jingoohan1@gmail.com,
	mani@kernel.org,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	robh@kernel.org
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v1 1/2] PCI/portdrv: Use get_service_irqs() callback to get PME/AER irqs
Date: Thu,  7 Aug 2025 15:09:16 +0800
Message-Id: <20250807070917.2245463-2-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
References: <20250807070917.2245463-1-hongxing.zhu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0037.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::6)
 To AS8PR04MB8833.eurprd04.prod.outlook.com (2603:10a6:20b:42c::19)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8833:EE_|DU4PR04MB10814:EE_
X-MS-Office365-Filtering-Correlation-Id: ee48c165-4265-4f23-48bd-08ddd5816920
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|19092799006|376014|52116014|1800799024|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fRp9EEnd0OskyJfve506cm702jvA7F4Csmrcx8QBV2HOPK3LWVfg5r62ByPa?=
 =?us-ascii?Q?dp+Q8QViJ6lA/sZsSL4fQLR2LEIcED+fLAahCFNQ6RrblEqd1xiekRyEJeia?=
 =?us-ascii?Q?FaABEGopIiXG4XuXD6CKP8enTEeSmtOcc4SgN/DReBlj4hWLK+gMP2Cxyyis?=
 =?us-ascii?Q?Ca166tTOSjEyuVS+CV2qeb/5rZSq69T4SDTBWmUHkBbQHd2/S0P/CL89Iqkf?=
 =?us-ascii?Q?jiKNtQrqQbi8St3+WURUGbsARDdX1fZ9d/PwZTNiMSdbBpuDzy959C0RBPfM?=
 =?us-ascii?Q?s0rjk0Gl+Bst7YiV6dsnF0YK6jLLZnhGkQfGlZuCk9gzix/MZr4YMedo50xg?=
 =?us-ascii?Q?U80klQdJG/o8ZPaaFKoXzYwxaij9hq4TYaKwrIYLUr4ck8gor8SCO1Q7QuY7?=
 =?us-ascii?Q?uwXF13gU4iCXeOvX+3oGrWdjUsAEL/P9dn7Ae2v7gEnDXcYo/vndXCBcQVoP?=
 =?us-ascii?Q?ZrEDUi3wfzpu72YKVUpmehUZew53m79voYFwraZBV4lcpFvxHozRfIqfWmwA?=
 =?us-ascii?Q?Z5XpvDKG+bxPPucqLlBLQrzJmDES/Q9qERwvXcVHD0OdMQ8zTLL7/Da5Qpjj?=
 =?us-ascii?Q?91KajIaGKXAgQ2DtnZCWpF6Tov0tRF0KdLFefB3RoijqbDyibtkOSf8R7EU3?=
 =?us-ascii?Q?NhzumucRsbVXbCineeOhEowOyTpsQTklr9P4aPWidfppc57Yzq9k00h9qpGr?=
 =?us-ascii?Q?SA7qstXTwpcE4EkM7htGFSZF3e0ZecUVmvLAc44GM5oBjjRgT12TCOzJoAut?=
 =?us-ascii?Q?/+3YB52RDiNqL/6nIxBllSRKIs5l4qJteJGseoVm8YsoA/1U+ld+L4TFwWlI?=
 =?us-ascii?Q?9R3OIZr38Ea0dj3f8gZwCAOHzUxrYpDW1z5E6t5DVxMN5Umeow8lXZwdYJ/z?=
 =?us-ascii?Q?g3AQB4hoCL75bQ1N0qVB6PTvDTotqHSoYbt0sAk/kPW52K7NfyqZa004LlXk?=
 =?us-ascii?Q?yuDE3Fe/r3V39BE8NvPuU9jHpMay+LNpbr8NO27bIlWU6hcOOpF9IByf9Ew/?=
 =?us-ascii?Q?Lm6IKrRRjDt0Mo/9sCIvXaclxtBptTvQ+tBDNYuElDFzhivOOdLnGmHzxtWz?=
 =?us-ascii?Q?B0bYXwAoXKZLWQxQyvifBpTcYKrpivNkD7tGTKSY14Id5XQTHgBl+AUWYtC/?=
 =?us-ascii?Q?LHerwyeVXiwvQ/sYtnWzm0vr/8asC1X1Ootwv+tR8SxACtZmC9ytefiECchZ?=
 =?us-ascii?Q?AI19wqh0bpjS/EuxYdPC+cBx0hSGBTgd81c/TVUl9ebUFzk/gSHJxzG1odqt?=
 =?us-ascii?Q?PZ0NJeH3tczbodTv/SpVX9VF3+5kFpH6u5u9XoaoVx/CoqRywxR9TdJ5Wa/y?=
 =?us-ascii?Q?Tq4+IpRscu4ZOU+LZ1i9E0T/RdABfDgWSG5zqjukXLIMGq0FPAIWF/9tsiIZ?=
 =?us-ascii?Q?k8V93apgCf7qz7SCd39nXAqkdHrHt8sngNHvEPM8AuF4sPndtH5xhf7Mh3mv?=
 =?us-ascii?Q?M4qr5C53X2ggDg99VF/sMaq+B6+SjICrOv6h2Ki1PRnDVxRsLTGDAY0jlA/+?=
 =?us-ascii?Q?+QG1FNPvv7W8twM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8833.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(19092799006)(376014)(52116014)(1800799024)(366016)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9y1G9T3AnO1vg+vY1tJx7FlRhy5hB0Ngm1Q6VIA2HACCfHAwTwN27rmeg57t?=
 =?us-ascii?Q?A1JFsSWCEtL5sPeSFnQa4zKwl8XEmwivFkyd8DxJ48m638ahtgeyEVw+H9n3?=
 =?us-ascii?Q?/D1BmDFjpIlReDqKj2clnix6GTGCeNTS32lvohwJ0X0V1Bc7U+ogXl/ryP2v?=
 =?us-ascii?Q?xX99DBpoMMnOVKEaSfpcJTa+c141TpjPh0GKayan5KORs8HTnMmJsK///bHJ?=
 =?us-ascii?Q?1/VU8onCcWJqwxQEUYLMnNYvZFBxvB40uPf7XQ33ZTX7EUcMA6Zu8ITksT7m?=
 =?us-ascii?Q?HrTgD49oUX7rOU8u9MBfxhFWgSy00ktNgR7uu/2H67xJA/+xtthb1OFBvmF2?=
 =?us-ascii?Q?TVnoieRKIi2b/4SieCvS5oXTXhBnXuM/mEnWvfMXuI1gxSqsxkaBT0MK3fEn?=
 =?us-ascii?Q?ilEjB7PrXtbJRIAl9bDRrpgPZBaXwNo5BYgJorcP8zt+D6v+KlW6Wt7Lbq/N?=
 =?us-ascii?Q?Sy8gUzDHc+zI8oKB/7cENbHm3EqaP0N7mGH3z8YX+/lWN914hFvmqE7mJcnd?=
 =?us-ascii?Q?+lIeVVMt6uTcDKmUxnPge471yezQu/04ZfRG6Hk91WbQuG4OCSrELQr3XbSl?=
 =?us-ascii?Q?mYI6vbXVDI9ztUNUK9L6Lt+4gmD+cj5NGbS/SSGpKJdHVlDXvEqfV22ufIKt?=
 =?us-ascii?Q?BvdRc6o7WGVTFx32fIgFwDSBa/4HS5NQBy2OE4aE6rTY2IbwxcNtW5XgpNLN?=
 =?us-ascii?Q?yieUaf8YUOxEinHBekwcbswc+b4vhAZa+CFicqqtYevOG+ZfjPFYAGjCYDQQ?=
 =?us-ascii?Q?wnGHU3RBj8z6p4wIVacHlSSdZeveCVZJrMPruDGheeJPoSwjRhZsLpNKlIdM?=
 =?us-ascii?Q?zj+If1JWo6ZMx999WqdoIsm/5iygZpFN6pGb+Twt+1XvzPCMQfy5UrNlGPfD?=
 =?us-ascii?Q?UJcRKYcppTHzVoPmEP2c/r0C7M21/l8qZo310WUQZ4Mw4VSyw2t9L+8qh8zl?=
 =?us-ascii?Q?c899YY3ZhjVEn/Ym0tmX3r+lImCtU4d1ypP0On4v0C+GtQwolGgkdKEwt7i/?=
 =?us-ascii?Q?qIv5RntM+uX3jGkGuOoGeRE+C1Mm8qkp41yu+NAp7OCecQf4UQHqCSAHxQpN?=
 =?us-ascii?Q?XAM/Xv2Y0DNC5d6tRZsBvxVriY2ETl3iWWvDNiqTk7i+Wq8AZza91lNNv1zp?=
 =?us-ascii?Q?0omN4Z2bRTqw3e53UJFqh7VKBITgb9IYuo74BpUgU1qdqNSir0aN8+DRK9DD?=
 =?us-ascii?Q?oRkVB6cBv5l4eQaC++SmPnA7s1odFVprXbWcMZUxPMEbOGnM+Zh45cvhSPJ/?=
 =?us-ascii?Q?7Lr4sVuLSCS86TT/eiRgxhXVgsPew6t6wjkr1ht+Gap0EN7YuwMDMzaa2he2?=
 =?us-ascii?Q?GXQhxcK9r8wrZpAFHNZ1TYW7czC2fVvqqBhxsa8YmiLM7R22gyxtjfb1z0Tu?=
 =?us-ascii?Q?P6ZKDhvsX+y4I1/Ztrn4dTH4rc+6GPHx/BwKZIvpR7gZyywk0EmSdTs9pB6K?=
 =?us-ascii?Q?7hpWSuzpG8zTPoXk0GRe7sQzsrpqnYTbWjZfP+agCKGBjtFwzoaW+M4YwvX+?=
 =?us-ascii?Q?C2We7ADJTviHO9Os2tDqkfWhL5Bmh2I3VmSkPZuw69ActkRjrKm9+4/18lfd?=
 =?us-ascii?Q?6Xecn37U1oq5GB3S5kJvemKoBM1rCKnc+jwKFHeV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee48c165-4265-4f23-48bd-08ddd5816920
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8833.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2025 07:09:54.9054
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AU+HkRuPpORqjFdg4+9BtMOFY9UHRHrWyh6lZo4x8etgEu7VrjeK50MqrEZ7Fod2x495gu7BwsBtuiaU7/dQbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10814

Some PCI host bridges have limitation that AER/PME can't work over MSI.
Vendors route the AER/PME via the dedicated SPI interrupt which is only
handled by the controller driver.

Add the generic get_service_irqs() callback for bridge, to let portdrv
can fetch the vendor specific AER/PME interrupter by it.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/pcie/portdrv.c | 7 +++++++
 include/linux/pci.h        | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index e8318fd5f6ed5..035e6425ce034 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -176,11 +176,18 @@ static int pcie_port_enable_irq_vec(struct pci_dev *dev, int *irqs, int mask)
  */
 static int pcie_init_service_irqs(struct pci_dev *dev, int *irqs, int mask)
 {
+	struct pci_host_bridge *host_bridge = pci_find_host_bridge(dev->bus);
 	int ret, i;
 
 	for (i = 0; i < PCIE_PORT_DEVICE_MAXSERVICES; i++)
 		irqs[i] = -1;
 
+	if (host_bridge->get_service_irqs) {
+		ret = host_bridge->get_service_irqs(host_bridge, irqs, mask);
+		if (ret > 0)
+			return 0;
+	}
+
 	/*
 	 * If we support PME but can't use MSI/MSI-X for it, we have to
 	 * fall back to INTx or other interrupts, e.g., a system shared
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 05e68f35f3923..e681f2e6adc17 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -597,6 +597,7 @@ struct pci_host_bridge {
 	u8 (*swizzle_irq)(struct pci_dev *, u8 *); /* Platform IRQ swizzler */
 	int (*map_irq)(const struct pci_dev *, u8, u8);
 	void (*release_fn)(struct pci_host_bridge *);
+	int (*get_service_irqs)(struct pci_host_bridge *bridge, int *irqs, int mask);
 	int (*enable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void (*disable_device)(struct pci_host_bridge *bridge, struct pci_dev *dev);
 	void		*release_data;
-- 
2.37.1


