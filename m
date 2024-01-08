Return-Path: <linux-pci+bounces-1799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6972826C8B
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:24:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6072D28349C
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 102B914292;
	Mon,  8 Jan 2024 11:23:46 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2054.outbound.protection.partner.outlook.cn [139.219.146.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053FB22065;
	Mon,  8 Jan 2024 11:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WhRWu3ETNsVVYYFb+ne7/tHCmGKTZsc1Hhvkn1fLqNYPnyqZr+KrgmxRDCkIUNp1NIIMHGfgMt9lwl/5LS1w92HLiVZCUw+nT0uDv9JZE9rY2EU2k6M+0yxMejzTrdkl0TKnavwaqiXzxI5o7XO8HaFLpO+Qbf9eejbBBi70A7Pxb1/B7nXi4jCZujItLr3eQqeJUu6opGwWi6y8A13Y50lOxwO1Uea9CtszABeBi3WRul1GfMZ52greZs0xslX6sJeA9P4VdONj+EfdftrsdtcMw+UGmA7WDVPnG7CRwsPrbdOK5Uq2LI2AcnYAVi+hHDbv0eOaCjKX7qkJXgKfnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K4MD2usSBbRdsd/hhE4tw5xP1KyGga5Ecw5HSB56sQQ=;
 b=ZUhQWQlBkwKkVtiyD37bqg7+1jeAuSEjCC/PkIkNlvqoVkebET6k0wdLWxyi1Z69XtDNLUh10YO8S+yqSmr5qUmZ9yX4a8Qtuc1piRRCwE2+rzmw5XgJblhYYTyyQ5C2ozcMUuZeP7Xc5BaSDRHHcytcxs/daGThL8LnY46Knr0HiPVf3CO8gakMLO7I1gBtUKsyWHvIc758uun1otz29PkO2WIjTV3d65v0YtlgRl6werl+RMkQo+xlPp/l/kw99wSGCgXuKIdHrh9QrNsyWIKv8JRNWo5RI7a1Vm8oFR/1ATCWI5MK5/g6rDMlQb9Rref303NXmJCACJIQ9TaywQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:55 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:55 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Conor Dooley <conor@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v14 17/22] pci: plda: Add event bitmap field to struct plda_pcie_rp
Date: Mon,  8 Jan 2024 19:06:07 +0800
Message-Id: <20240108110612.19048-18-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240108110612.19048-1-minda.chen@starfivetech.com>
References: <20240108110612.19048-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:5::19) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0797:EE_
X-MS-Office365-Filtering-Correlation-Id: 820ef93e-0853-4224-ce5a-08dc1039ed16
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	q5Ei0ykGaYbqehL/3sj55/l/M2yq15Q3WZRrjgC9Sq+tZcaMzBr93xdM/qkhlMBO+jvqioUQBQ2dL9TkDVWHCNdXDCpZw7qBX4apF6eUxskB1YIhDdRf6NYCM7GZSYGgz54yEoeDb9I2wCtjh5GgH0IcF7AY8f/1xLMK5gKN7L/haT9y2tz2pq0ZUBfkvPber5K1GMnWR46cyRa5jfJkIC8DyvgbH2/SpyjYu41ockiCVS/DfJnhMAEAB8X3qzSOVd3oZ2BrlfPzH6Uukg4gR3gR7d20jxi02NDONQPS7RCNSOyetmozfYh8Fafk5juN1rnjrpF1bTYkTCy6AOmHaXEgCVqC4qz5YAiKUgtMMj3DoEQrN7JhDx/y/5eWQvx8o3m6tMayfRVBHbN+bVrfsRGJcS/fbGn+BK4vaJGrxxFQE/hyyz/ErIkHfNcDnfULpH46GZ/8vjnjtw47+Q1UB2D17btAQBiLDZKt8NeXqq+ZWKKDeOJHJVhYV4yTlpX/Hm9dI5ezM86agEMR/P32440Yxws7S/TWb/CA6ui+ruJ9O82J86TnzkZjx3aprazd
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PRvcDt+P4cCs5MBqAw6VZlBZhlKb/Sx9ZRtfELKd0/yuCwoGMSss8pE8Nefo?=
 =?us-ascii?Q?Ixl/8j5uSgqJf0P+qtopbjQyj4lw832KBiIO/Hv2C/Ew8pB7PSVhbhI889n8?=
 =?us-ascii?Q?Kf/+eEyfEtVAfCtGoUfyiNcZPQwHXtdzQEtddFD2mSnvhESX+7UVAjZ3byAZ?=
 =?us-ascii?Q?MB3Bzs9kAG4UeoA/E7q1MtXLUNrPhTSlehbck8OjhSioves7KtBR8Hl04qZ2?=
 =?us-ascii?Q?Lzdpl4r3siIGysaHJLo0+5jC1pcuGVZ6zil05xAhGodHvy9ZDgcMEcIlGyC4?=
 =?us-ascii?Q?FUtzdMRV0IuCgHjcqGwkR9hUlmC4oFCyX0wmhqqT3QUOaW3cvBjMbu1Ynz9U?=
 =?us-ascii?Q?VGZySJAUsCB4nDkCW6Y2kcs3aDNpN2MzA/UVHkT+jbIlqFoMMEE34v/A4UBH?=
 =?us-ascii?Q?CT+u30yzLet3ETNcpzvizxhAcMzXbdpoE61IR1sYNxz4wEfpGObRJ+NedCeH?=
 =?us-ascii?Q?oH4WKDVDJAOG8nl3+M5/cCzH8LjsPlyuGp+HUK832hP513/YL/ZXeaedL0Ix?=
 =?us-ascii?Q?Z+zlJKgDQYaCK6gIf5rG5dU1/hanB9NkKRbggfxw4qGyFbmlTfqkkT71fWEq?=
 =?us-ascii?Q?JkEjp0eV64IC/0dkxyttU4GEPo3xUxikLsQkTjlq0nnJsPrcxtzbOtbQNfjk?=
 =?us-ascii?Q?rtnWWmNxEup4q+CpD1cUPSrhQVEvSE+T0gDACLMf4k1MkWBgZKg5ThoT4QiI?=
 =?us-ascii?Q?JYZ64q+e91seXetm37VQOpNCeOWxuCv8sBUCyrLOr5AtVsj2Db4CMvY2MGvt?=
 =?us-ascii?Q?6KSR8ixVB0QXdk0B5f7x1wx4qE8sk39Ql1HDjrUL8cxU9pSbk3PaXTduxzHi?=
 =?us-ascii?Q?Q2tIx5Sar7DFo4ODJhi7GO+xrm4JZHpaWSHrcbC3jMfdI4yJqfSyL79YitSd?=
 =?us-ascii?Q?Day2HjLCvfAtLrCMn9V1q+hp+imxeVyETACk0JtWJexgICz4iPhDR91LhlXA?=
 =?us-ascii?Q?Ms75fV1CFNYPCxUajHuXKtcxVXtsY/8SJ9EpbOISAfFy4/KAkI2R0zM3HUpz?=
 =?us-ascii?Q?EIZGQszWB+8SfsyfQQx7D5Kqx/E4tCMm26QiazZcxI1Q22x3ft9kjIwBi4jE?=
 =?us-ascii?Q?tl4fMQ4OyGm/7XKjwv8a08n5MImJtOa3IS/gGb+jHG5y9ORplsMy2t+J7LjB?=
 =?us-ascii?Q?oQ/cRlnKv2lY/2tXYpB9DbQtcucim0fgOBfjRfHpV73SS01UGPeA8tEdI5nB?=
 =?us-ascii?Q?+goUGCUEalnjxbC25v1ovQhW3yNxreKEqm+0zcnmQZRlFxbYwv1tN1NZljUF?=
 =?us-ascii?Q?WTiVXUsDCJfqHH5/ljNlKqfqtdpZR2Z5MpcLPUhGt8frEL2FZvXIuaXuP1HT?=
 =?us-ascii?Q?2zx3hOI7TvVxvKOqisJWyKv/AKXFIeRTs13L22gME4Y3w5tGRGXRNiyoQ2/l?=
 =?us-ascii?Q?fT5d8DvEagi/jlLtu4tLS9gE4wEQdrCC36i5+/+VM0Psq8/bLwZovPu5WEi9?=
 =?us-ascii?Q?XE6FoGmb46JyxfFjsonJgqFT7dIRZk+LcuSHVchXXD94fJhANfjyNQq9qRkx?=
 =?us-ascii?Q?iohLrR6fCrFQll5PIgto/LJXXptkNzpha33GSK0VcFev6jKvPBEltkXAxjxF?=
 =?us-ascii?Q?ATmrFC1bc5LIEzUHaTeyoEDRGpG30YNwbWTzrOr5ibvLMjCRWvX08fjNi/BF?=
 =?us-ascii?Q?3g=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 820ef93e-0853-4224-ce5a-08dc1039ed16
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:55.8195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cPFmXoSY1P0ZMBj6/Zn6goBsx2474dtYrofyKDxB7rNSb/NtN3RPjhRN9XtrY9SVvpYWtsr8m8FGMpJHqUok5O6C+47HljMksYck1RnWUTs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

For PLDA DMA interrupts are not all implemented. The non-implemented
interrupts should be masked. So add a bitmap field to mask the non-
implemented interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 1 +
 drivers/pci/controller/plda/pcie-plda-host.c      | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 105964306b71..48f60a04b740 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -636,6 +636,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 
 	port->plda.event_ops = &mc_event_ops;
 	port->plda.event_irq_chip = &mc_event_irq_chip;
+	port->plda.events_bitmap = GENMASK(NUM_EVENTS - 1, 0);
 
 	/* Address translation is up; safe to enable interrupts */
 	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
diff --git a/drivers/pci/controller/plda/pcie-plda-host.c b/drivers/pci/controller/plda/pcie-plda-host.c
index 98c51e594efe..a040e7e5492f 100644
--- a/drivers/pci/controller/plda/pcie-plda-host.c
+++ b/drivers/pci/controller/plda/pcie-plda-host.c
@@ -290,6 +290,7 @@ static void plda_handle_event(struct irq_desc *desc)
 
 	events = port->event_ops->get_events(port);
 
+	events &= port->events_bitmap;
 	for_each_set_bit(bit, &events, port->num_events)
 		generic_handle_domain_irq(port->event_domain, bit);
 
@@ -420,8 +421,9 @@ int plda_init_interrupts(struct platform_device *pdev,
 {
 	struct device *dev = &pdev->dev;
 	int irq;
-	int i, intx_irq, msi_irq, event_irq;
+	int intx_irq, msi_irq, event_irq;
 	int ret;
+	u32 i;
 
 	if (!port->event_ops)
 		port->event_ops = &plda_event_ops;
@@ -439,7 +441,7 @@ int plda_init_interrupts(struct platform_device *pdev,
 	if (irq < 0)
 		return -ENODEV;
 
-	for (i = 0; i < port->num_events; i++) {
+	for_each_set_bit(i, &port->events_bitmap, port->num_events) {
 		event_irq = irq_create_mapping(port->event_domain, i);
 		if (!event_irq) {
 			dev_err(dev, "failed to map hwirq %d\n", i);
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 6672a231a4bc..443109d04d59 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -159,6 +159,7 @@ struct plda_pcie_rp {
 	const struct plda_event_ops *event_ops;
 	const struct irq_chip *event_irq_chip;
 	void __iomem *bridge_addr;
+	unsigned long events_bitmap;
 	int num_events;
 };
 
-- 
2.17.1


