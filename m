Return-Path: <linux-pci+bounces-2676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3F6C83FBD3
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:33:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82730282631
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFDAAD27A;
	Mon, 29 Jan 2024 01:33:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2088.outbound.protection.partner.outlook.cn [139.219.146.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB730D27E;
	Mon, 29 Jan 2024 01:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706492016; cv=fail; b=KOIFI5pU0iyo9n88bbSUKXD7giHwfyETg37c1x3wDoGpzSxvqSw4sv0WzRPTo4jmrrKgiTk1aKIr5X11bMOLQ09uaj0tZpx0Gd7p7LelSmCBCRunjbt/qyaMwdPXNyn24KSpnCQaZB0sbi6CAzzO7aFEjLR3Gm6PRbuAZGshTcI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706492016; c=relaxed/simple;
	bh=Wq4Z/mmbsWDKhaXfuZB64deZXyVlxQgOmWnGhLzld0w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MfGDhW6sGa4KbT+XQX7GgrQzkSePEE2lyWvn/Ri75fBKfEnaaMhNLNTmqfm5p7nobn27AQaFA4bVJFkELA4MRImRMZ4OaR9sur5KjRZcH+UriLGfPnW8H7qbE/1SwqZtSET6+cTOkN6OpT8mOgzjKXOQcPevKWu9V/RHip+0ZfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km9KOjXi8bxbfJEwpus3ek/h2j1tPxOqCYbR8QOU8mh4hOaGMKFfVc6kqrPry4Ag3h19OP/V2NzNQAkyM9u+Qsm246GN13IZxZauEYHuu7CUV/jw+Sk1UtHn8FF6QK6sE6lTWKlxuZo7ha23DMrUNWy36+FpaxtLxgVGDW2rYeJ7gHsaUEjgfLMVA0FS5hFqodKgQFKCg2GQ+za+V4hSFhm7+We/KNn1yr9gvrtSXXhGbm99PzpFksncTo8ouQMAsUNSSH5YzeP9PCi+0COqwkM0dxl7yc/m1R4q6ilC4yUZY8BcyZiiUJZWVgGqi388Z6yTOiVQqGdV++m0RHDfzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc2T6SbVvFNGAc7jANlqkHZ/EYw1YXpAsFWAuojjcfk=;
 b=Piibm6atR1mK/iTBUgK2rV5tUSkwu4la2ImA9dz84AZ3Z8cAmQ1pbfrJYJLgo8MJNBGyjWt2bluXC7c2OAxVXOE42+OuabLMJVY8ZVCZ1Cyuv2gwmXBH6RKiaD62GIwH/2Bpk+wT+v5RrAaIxLGB0Hmpai2eHM6VdUpLb94kRSZ8TndnGfef94GHHUH5mWRx0RFVqGDNN2osUW9gbFgmi/l/RXn3mYqT6Zkmh7amQIuUz5+7ZnR68zJikQxoTA1H1smkH8P8iZee4woGV6wm7DPIYwl/wPj6i09CL35SY8UW1tMPivC5an82moyQ5EiS1ISbLlHBtns2DbKX8L3C1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:13 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:13 +0000
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
Subject: [PATCH v14,RESEND 07/22] PCI: microchip: Rename two setup functions
Date: Mon, 29 Jan 2024 08:59:52 +0800
Message-Id: <20240129005958.3613-6-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240129005958.3613-1-minda.chen@starfivetech.com>
References: <20240129005958.3613-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0010.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::19) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0630:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fe42758-e9f6-4055-da68-08dc2065a644
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rzPzAp0Vkssk5U6gcw6bK5awj4fpOPMIO/SheX+6E4eHhwQ2XyVBHkdPhJ2yGSCpnzJKS84W38hNYi6cpC97x3Hy3Ail1YUBPMo0EKhIGdJoz7azszeSQuzzKK2LXVT4Ienq8Y9/CrZn3RLiop/6eUDAkS8WpIj//W+o1Wk2glf0/WZtGMuxCteLTPEXWX6SDtW5LwMbZlviZKSPqksr5mVnIOSnhxVeE1tEcR7nHQzhYdx5ZWT1NkAzNnf5VoVMKtOzIKRMazcmWeg4ERJb7D9pRvOGs9cEcMqp1KPvWR05i9bseXStH5jEzBDQGGMUxSIPujNwGqyrXQlNjqpTM3FnOj4X3oR4xpSFq5m4O4FhKUe1ivJo7ux2U7vN59wTQORrp8Hc3oLowh+fdzO6+SvMm44XEJDCLYl0iPFIbvkDAWX6+iWEuYGglfhSHWI2+d6JjznTd+bo2zwrSTz9f8WAiyql54SBoSF1tLQo7bIYvZoPRcRp5nlnRlcEXh5vEqCN2Tx8Puaahc/OjX7i+JWiy8ll5h8lOrG8xVc534Hd2uYbl6SyNO/49EsSSJQz
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?t8paODpAQc+EwPIIz/znKVLyqCyAz9cguEd280gP3PYmaWhYANdR7ZoTuwPB?=
 =?us-ascii?Q?XcLIpG5xKoxTOsHTIpbHgnclGPF9mQtXrV7VbfyY7eXeQCHIDDET1wvv2AVe?=
 =?us-ascii?Q?EvHHOtxtPhcVacWhkEnYTtSBSvG1/TAy3IbFc7G0A8g7FWqmDNXWvJG3oXk3?=
 =?us-ascii?Q?Gmf6SIXBXOwMQninlIVbBr0Ql7/frBblqIi40tarkVxy7/eEho3f3wbO5C/V?=
 =?us-ascii?Q?4zeTthsd7SiYSfsTnL/SeUeNbPhQzHe3fE4g9UYezYbjwyYd7cUK1AZHQgfM?=
 =?us-ascii?Q?vkEayh+CcuvRridXzHbmj41uWQWoCYZToQbIeX2nsWwn6XEgJvkWiLwQCLZK?=
 =?us-ascii?Q?+U17H4wEuIfxSv0W/XVUoSIilngQRmvo3FHpWySbwR1BE7RwfP3D/G9SOyhA?=
 =?us-ascii?Q?j8oXDi+BH+7Q2rqpa2PAdlXmjEL/Y7VOJUmLj+IgE0KS2m1YJGvzS7hDwnPM?=
 =?us-ascii?Q?ashYGWD5vG1b3Ec8j0viTqf+/XTYEdTItXCYwWU/LtUcoOukl+JrPGVZiZ0/?=
 =?us-ascii?Q?aEEWticVjXkWJQ15eCfbmDeIOWBlPH38btO3nx3FzWH+6PcdEc1XyZ8ILKfA?=
 =?us-ascii?Q?nRndjN5Zvi6e59Buprh3z8Hsgcugq6ScRcO5qms5d1Yjh83g4cP+UsZXQNi1?=
 =?us-ascii?Q?iir5kLl0ylbI0weFlCnM0E5dZOku6J1aj1uYUjX56mEip224BcQ0RXMFa9l/?=
 =?us-ascii?Q?+vekD0hYK4VgLEGoC+J0z5fqowoJFHFVa88v/62sBwuaVqqP6jqDuired1F/?=
 =?us-ascii?Q?Gpj9h3nyX1LQFhheEbQsq/p9pFlPXYo2SygTiDO7rNhw5428DgADdXryPihQ?=
 =?us-ascii?Q?0XCFr09jXAHXMJIzyrSYC+Nzgt9JFmAOtlq5fUd0JZRXT0z0oUzRzsjXZqLZ?=
 =?us-ascii?Q?ARMe20HPziqxPz/Kzp7gbK4o6npyISO7yXV/Vw0bzYvUgdxj552YUkP97Tul?=
 =?us-ascii?Q?rZ50XNWClvfpKyn/K8Fpkz6APXQqrfs/+vKAoh1LBRn6LFpNPwl2HBr/+Xyg?=
 =?us-ascii?Q?Sb/O5wT6vZzjWy0owp66Q8erob8psjjWsNkLWjynRhzVxE/BPIohf0RF1RVF?=
 =?us-ascii?Q?D8we8B4dCWQlQmTR0tgF9mNnjWhDAPFsfi3E4AihiAlmH4059RVCKhTsJ6Ch?=
 =?us-ascii?Q?lw9YHtwjyAd4nz0yXusFQzPDmuZwJRgmuBuSdEI6XQWGaY1O4/ewvVDPb1+b?=
 =?us-ascii?Q?2FLntVvfd5l/NDUr1FYpKKosv5Id6VmZpaYz+JSMSZH2acvGyteCluNRVO/7?=
 =?us-ascii?Q?jiVIEpZxKJ3BQaTmjjJusbYTKyQvRJgBUfdbTC5nW1m9BH5gDgI6Zs8jRkah?=
 =?us-ascii?Q?MIgXaxHfRxbbXd11by0wpi43/kNnXeFDxZ3dz+GtfNdFcchwNGiasp+J43VD?=
 =?us-ascii?Q?QW1ZDD4On0nRFQgzFTgCK3t2zZLu2V0cU+7SRctgsQQDczUZ9U5Qb8CiNy7Z?=
 =?us-ascii?Q?g+P8lA7uy6W261TdD5HNtwed7hc5+utXJCkceANmrulEYQ+Pawqo7q2DI8qO?=
 =?us-ascii?Q?wF6Nf4i7TxrZvIdnwVlXoGOwKhvQQMTcLVWDcXG7uIU7bkux5yR1icHlvBar?=
 =?us-ascii?Q?a7diCvPWOuXjC1Eu5mUDv8AqVQ9zgPkwnHCpYtX+d1tGYcZbv66+U21Uj6TV?=
 =?us-ascii?Q?XA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fe42758-e9f6-4055-da68-08dc2065a644
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:13.4600
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWlhorAeZ4naVaqpSI1mUQMqleuSMMOcs5n9EA+lPFklrv+9XXnOok8vkawACcakXFb1h3wZjyAdcNxofA69dh3kRjZ3OVUQQsFzpMZievk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

Rename two setup functions to plda prefix. Prepare to re-use these two
setup function.

For two setup functions names are similar, rename mc_pcie_setup_windows()
to plda_pcie_setup_iomems().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index a554a56cc0e8..9b367927cd32 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -838,9 +838,9 @@ static int mc_pcie_init_irq_domains(struct plda_pcie_rp *port)
 	return mc_allocate_msi_domains(port);
 }
 
-static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
-				 phys_addr_t axi_addr, phys_addr_t pci_addr,
-				 size_t size)
+static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
+				   phys_addr_t axi_addr, phys_addr_t pci_addr,
+				   size_t size)
 {
 	u32 atr_sz = ilog2(size) - 1;
 	u32 val;
@@ -876,8 +876,8 @@ static void mc_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int mc_pcie_setup_windows(struct platform_device *pdev,
-				 struct plda_pcie_rp *port)
+static int plda_pcie_setup_iomems(struct platform_device *pdev,
+				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
 	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
@@ -888,9 +888,9 @@ static int mc_pcie_setup_windows(struct platform_device *pdev,
 	resource_list_for_each_entry(entry, &bridge->windows) {
 		if (resource_type(entry->res) == IORESOURCE_MEM) {
 			pci_addr = entry->res->start - entry->offset;
-			mc_pcie_setup_window(bridge_base_addr, index,
-					     entry->res->start, pci_addr,
-					     resource_size(entry->res));
+			plda_pcie_setup_window(bridge_base_addr, index,
+					       entry->res->start, pci_addr,
+					       resource_size(entry->res));
 			index++;
 		}
 	}
@@ -1023,15 +1023,15 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	int ret;
 
 	/* Configure address translation table 0 for PCIe config space */
-	mc_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
-			     cfg->res.start,
-			     resource_size(&cfg->res));
+	plda_pcie_setup_window(bridge_base_addr, 0, cfg->res.start,
+			       cfg->res.start,
+			       resource_size(&cfg->res));
 
 	/* Need some fixups in config space */
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = mc_pcie_setup_windows(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(pdev, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


