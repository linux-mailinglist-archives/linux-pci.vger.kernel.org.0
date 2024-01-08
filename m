Return-Path: <linux-pci+bounces-1806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC67826D0D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02D32282F3E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024AE14AAE;
	Mon,  8 Jan 2024 11:41:17 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2062.outbound.protection.partner.outlook.cn [139.219.17.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393E02575A;
	Mon,  8 Jan 2024 11:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZEPKMo6gnsGBfIXXwHZOAR1FgavqhtO8x5OKmCK3LXfKvic4dCUv0C6mPZlmDf/jKF0P3BC+zt0y2FrrBRQmFGxonwlPe/16dTC7we6pFqP8uBvZT16yqo9iDmXMrgcRKskbzFQXdvW16YFrV5jCBcQmpOHkWbDDrezUc0KEkD8A6bq5jqOgb8V9ghaBHKZDRcgFRb5hUkgp/aYjl9YDLkLE+2/IwLn2iX126sOLcDE3v8y6XIm8hATMifj6siA9+si940Po54FVrxyQg0bCOcXnl0ep6A7PilmSNX+wx3r8QG3+rwgyIXW5t8+Z/HQUaNWLQUBEaKRpj89RrJjJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nkG8h4qt+ikCnMOfDNuKvK03jp9mjC84c+mENU+9eY0=;
 b=R4t5KlfvB22hH1J/QoCrx1Abb4s+cNZYRembb/a63sNmM6Q8WocNl4Jsb6+FQG2Mmnai5tPf9wgi6lXyJVWjBoZIVJg9LabSnQe7rR1GwFxAav7b6RbKZ1W1VT8EMIyBc9I4T2hlxPFg0HHqMn7pU80jQm120o3+7QFqSNPw7/2lYOwczWINi0PRrdwTe9x4Jmq4FXCaBOV2nboHxIMHXM7VnODNeah7sPFZ3IfrgkX4uiNMQZnKuwG/8ttWd0nChGXpYKh4ym2tfHSxIlPemqkArmOWscWjL7oX0AlzfDOeJ8VAsNirb/ReGrZhnJi+lWYXrjJbGG1Ljo6o0Fn/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:48 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:48 +0000
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
Subject: [PATCH v14 13/22] PCI: microchip: Add INTx and MSI event num to struct plda_event
Date: Mon,  8 Jan 2024 19:06:03 +0800
Message-Id: <20240108110612.19048-14-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 7269e5c9-e233-40bd-ce10-08dc1039e86e
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AFncDXgSIhPMe+9mfYBofhNjpJwrumPujnht0XZjJyU6aOgZSawepop0Fa7dJApkQVmt/KxkthMwfxaMPk4yUHFJnItaj4ELhWuVWqOfc7+f6WoU7cUAiR2PBk/v/hYO+Tw6+IiQUH2iUn962/pn7ki0fzr6GdDjZd4oQ8TPY6vuUTJf3HUpEocxZpOgjuZHot7VhCQGkv928Zq0PWpG4WhFlrZ+dyk+wIrFF+WQvRGsUcKwinLm7Xo6z0Ot/kjK4E8ubc1//q9JYp6IqlpvW0sIlI22Xb3VN+laG22+CzB9Tg/dQtbE8uGFcM8h3I+Sm/F8mS3KSUZ3FW2jyfu1r2XXlTn8i5qqX/j/A7ecIMcy11b2UXISLXzx8dGYYfQcgFIq4uKp/48VRHHhoPwqPsRXpjLstUk8EpurKACZbbegC3usjhz37WrUnDpBsjkD5wPLKxBwhRsiXllw0D8wAY8HipgpsOzjs8F2pr+Q9yfGp/9WdL5vADDOdhFE4TboQd3gtbR6QIsvwNjkTMFBIyU/in+ZxrVOr8/ujME2Vq0xdFwesvgk18b580LpWI3o
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lDELTZ3+VelIhNr7grYYxVwp2bUBxwpJ2rE/WkOhcuMmLH2K4lcOqBbSx/3z?=
 =?us-ascii?Q?LqAW8BNQV5UTcuVUivZQypLhqP5h2MZERIOcrzaEAgroEFO29q8BFnSBprP4?=
 =?us-ascii?Q?wzjBkOSSpeSUfQcbysSgl8fSv8kr5nBObYC6BCUCCKsu59UyzM+zw6k1jFnj?=
 =?us-ascii?Q?zQ7TKqHrVNymN6gAm5uLqdeuqZZB631+BNFpmJp5hUgICWjv7U3O/ejNiIbj?=
 =?us-ascii?Q?DF8biB79hjqYmlI/6cKt2rpLDz8g1qih55Gq8bQz7avalT0JsRe/2MXD+9Zp?=
 =?us-ascii?Q?/CrzvfSqZzJycoI7bI6msYJtwcFfjfKLSJn2DhWVN4xPk5RRZAe0kAot6zCQ?=
 =?us-ascii?Q?Tc34WtRjtmfJ4DZUJm7J4NxTJuNAiFaoMPBb8cxqdkROC+Xbcjqtxo0A9e+N?=
 =?us-ascii?Q?QKEilHL44eUAGUm/qKB/9o1RWlRHL0UxxBkWytZvQBmE3zp3C/SbF4oM4dzp?=
 =?us-ascii?Q?92efcCnVcZe1I1474TKktNvAy09GpVS7rRJ8M+lV2W1CeZFNnvJ33tYSSUo/?=
 =?us-ascii?Q?0utewehduFfhY7JNpEUa03KT01cIKsnyfC4B2fkyE4kSZwSNsIw/RBm76Bn9?=
 =?us-ascii?Q?7FGKtQEurMx/7tr3VBAIIC0h5oAIDmCzIecIqZzzZung2QNZcstYrjU2vuef?=
 =?us-ascii?Q?hi81KyBfkCvLvTsIxP09kfRq77VyZBmrCZqL+vulIkgTLYGIFh/CPdtvQry5?=
 =?us-ascii?Q?q/El+2lQ3kv/ksTrJ8hDqxlCdtlvuSoRsJOcUXSQZENV0jQ1dozKX5p/qf7l?=
 =?us-ascii?Q?QeBxjuOeKj1e+U1Z00ySzykKrLioyMWVnTkSekZ+1a9B5KyGufiw/f7riWyN?=
 =?us-ascii?Q?u6Eg/TzGlUPVjVm1gpqdeP3483IO9NqVqmd5mnP3R1mi60gMBy0x5QJNkFxW?=
 =?us-ascii?Q?lUFFJNsXk3SGtfwUlI/eorb+K7bkifMixuulHB58/WvCdPx8V2Ni1GWuDjrM?=
 =?us-ascii?Q?YS5KmUJavBr/NWph9XxjRJQInHqjApZyOE8wK1QMvelQJ/TGndn6pG8tJtWt?=
 =?us-ascii?Q?WGRasmyTZANmA/2H2xZQlRt0c9z7C/U0wpMYEGHlOsrwfIzupmQ15L6Cjx7g?=
 =?us-ascii?Q?Bd7/ltkK5rfglK9UJt1g3uYoUBcm06VG4HVDABz2GgJ8v6SoYXRs+mzOTvoP?=
 =?us-ascii?Q?lFnHaiGkRUEIkmywZ5N0VNo4qXNnEciguhT8hI7L2rGiLMBS18+1hLl+rwHE?=
 =?us-ascii?Q?9R/KaZG5b178oatw8IRapeCSneZOz9+msrVJgsVBxgOyvZiAkTbSEprI9FMT?=
 =?us-ascii?Q?XjwmAIfy+qgQP8K5cnNNWBhBt9mTbe4wjBctBpBPRdMdqrElpMsXu8IYshUi?=
 =?us-ascii?Q?8SSJheYctuTWMdVOEu0AlZwnlcJha3VMD+BD7pjQ+FdiOvlGhTSu5L1OEbXB?=
 =?us-ascii?Q?u2ikpftPqrVukXB1RFSdGszJORq696E9FM6Ni5MZ6HsiNCev1pO72gGxWhIj?=
 =?us-ascii?Q?UckWiGDzCMM9zKVmHa19uBBO1zFh6R88CMvbVWCu14yRk1fEEl/0tmUClJRP?=
 =?us-ascii?Q?Y0Iye+EslGy/hj0BnywcV4oZK9kT2QoFyFdnDEfzFc/zC/4ncpMsstO3+g7N?=
 =?us-ascii?Q?KlkmwosocF8+6wfS/a/P8pcB9jB5Vzl4npDRSXgDf9OAlkRZKAmVSiYy81VO?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7269e5c9-e233-40bd-ce10-08dc1039e86e
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:47.9513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5Hg3acHJr0DoczAsZG2NqSsmutA8k90L5Ou8Un1gmktmcUl5WqiiXsMAgZDJZME+iZL1+n1vqfzs1VrjPfyWYuRZeEDUooEZ+wpEIfJVK0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

The INTx and MSI interrupt event num is different in Microchip and
StarFive platform.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 ++++--
 drivers/pci/controller/plda/pcie-plda.h           | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index bf5ce33ee275..8a51d3aa7e88 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -817,6 +817,8 @@ static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
 
 static const struct plda_event mc_event = {
 	.request_event_irq = mc_request_event_irq,
+	.intx_event        = EVENT_LOCAL_PM_MSI_INT_INTX,
+	.msi_event         = EVENT_LOCAL_PM_MSI_INT_MSI,
 };
 
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
@@ -960,7 +962,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	}
 
 	intx_irq = irq_create_mapping(port->event_domain,
-				      EVENT_LOCAL_PM_MSI_INT_INTX);
+				      event->intx_event);
 	if (!intx_irq) {
 		dev_err(dev, "failed to map INTx interrupt\n");
 		return -ENXIO;
@@ -970,7 +972,7 @@ static int plda_init_interrupts(struct platform_device *pdev,
 	irq_set_chained_handler_and_data(intx_irq, plda_handle_intx, port);
 
 	msi_irq = irq_create_mapping(port->event_domain,
-				     EVENT_LOCAL_PM_MSI_INT_MSI);
+				     event->msi_event);
 	if (!msi_irq)
 		return -ENXIO;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index 16b81b23c213..0efe64d5f688 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -130,6 +130,8 @@ struct plda_pcie_rp {
 struct plda_event {
 	int (*request_event_irq)(struct plda_pcie_rp *pcie,
 				 int event_irq, int event);
+	int intx_event;
+	int msi_event;
 };
 
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-- 
2.17.1


