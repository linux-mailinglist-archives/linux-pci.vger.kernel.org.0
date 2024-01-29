Return-Path: <linux-pci+bounces-2672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 553FB83FBA8
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 02:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78001F214D6
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jan 2024 01:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0DAD53C;
	Mon, 29 Jan 2024 01:16:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2084.outbound.protection.partner.outlook.cn [139.219.17.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7985D299;
	Mon, 29 Jan 2024 01:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706490971; cv=fail; b=KDp3VB3jSEb7UmuYzpa5Jaof2NW16W/UcVTdrTXuu31a7KzYasCTV5eRJ8fI8x5rJa8XHakrA++5Lm4i8sm8EEYHiRULFdEfBIJOnC+HBunjUiPk/M0xY0/8WopdQ3zYgSae3qUU35jxNZ/Ala9DFFd0Vocx4RlO35L7Ct2n6+w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706490971; c=relaxed/simple;
	bh=6IWs/9L5/U7olRhCkLt+mH+c3E5Xoo0SyzW6LQLbL8c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MjIFjPOzXpePctG54zupPV5pJ+QvO17fJUpd5J6ErXTCh0J49ypKMQa4L5A3/9Ja9jv6+yj1PalGG7NopX+6uogdtc7+jEXfdd2Tud2RSlcOXXZp4i4gm1j3WpxqciDHmGht3iwTA3mZnHtuNLivD+ag1kP+pBOAiOuLl2GhZ/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WP32VN3NTfLPQnIzB3pKsvEEdZlkUaLsnWeF59Q3xedwoOAUrwJzmp7b/0ievvXAnFpk7OsFNqy5AMYgdoFkSombUTxBv1UDt7xuOLgZgPWjjlORccZTB36+DXKI6gl2LMWNMT1ZebR6VqzpZ2VfvMCrUrPDuZtnjA2jo42FhHSHdtqczOMuBUVc7snZM7cnaJOlzjdKflH9JJ4i0K0BSzKFWmtqagLBAHLzlO315VnUfRcP3w5MZ7Z+opJUsJAUsu4514VJ8BcbXzLmwPqFclnjmoed/pxQmwR5PjyCBQj7W98fdzvrh//BJRpAnzJsI3UUR1t06JkfGqbX5s5q7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H1L2zCinMaKZ61leC9g0xpthGdFxAFSQ7l+a9Zn1/VQ=;
 b=JwbF63A8TOx73cQZjK4+hUOTrRpfZL0IXrXrywbjk48SUjSNKS3OFBDIRdb7qx4UlgTRam+N9fVKeE+fle+2h7Zy481t3330QCjn/3LB+wJaegOluWpVSeH5XsA5XzJVGzkiaATY4quKIPa6AevCQazYmuWCmw3Wj2E8FPhYoWVFuaDZlq5vHpim5OPUGuTBW5bBVt1E7x0CZeP2os4q84xc3MQyzSengqGa8FVdbr9c43sCO9c4rJPnsQ3kpUlv9hmOTOg4bEcasXEFQ8ysx3VzjMx0wdRoSOezonkOnHvfiwGitPZ8aH7FCzvvuswylITITTWFejI4RDQDbd0hJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0630.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.28; Mon, 29 Jan
 2024 01:00:14 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::1ea1:19d5:efef:6fc6]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::1ea1:19d5:efef:6fc6%4])
 with mapi id 15.20.7228.029; Mon, 29 Jan 2024 01:00:14 +0000
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
Subject: [PATCH v14,RESEND 08/22] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
Date: Mon, 29 Jan 2024 08:59:53 +0800
Message-Id: <20240129005958.3613-7-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 24fb2ba4-3b80-43f5-6a39-08dc2065a71b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	jzMwlu+LhyacPBaPTmQgGKixstUJFTn/iCrCE7Jea0tqfDaoVQAcbk9yiwy36Fji4cP1yB2onD7BEFpm9AGV/hf4DgWEFVRkE23NROByqq3D+TjinStCyAUec5hZxRFifqqYD8JzcEZaANnONeGVLLZRcqLhX2GdqDXr1lr8G9ne0v5RiUwUkOjldvNvYofI3TW6Ppiadzc0efeXCciL2TfjQZQvymfTCA2QPorw1AIibpMMF+VztqhRzcs37suo4rAkSdMnBiueC+Ih6BC81jg+IzoQQ4npS9L24E7vGsKrZJlfLokDZB1eWqTsJz4UN+5H5EoLXMDWndBeKe9bcXTYNR5ZDXUrReUari2nIxGaeRIhEzWQ84n0uKrem+CersKWtv8KZA/dk/mj7LlZjOBw0F8o1l+TdcVtT0vWhGNswUs7HXs6XMEULWbbbdKdAgsDEiWzkRZ/XgDY7pun5nGwUEpRJVKoKznED2ISeLdBagGTE3PgNG9EI3xeX2DwJOcTYrRmvcCgqsUgrsFrNwx4yrOT01mnm7jTwEr6XxL3BHn97mGjujXMzQgyS63z
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(136003)(39830400003)(396003)(346002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(83380400001)(41320700001)(40180700001)(86362001)(40160700002)(36756003)(38350700005)(1076003)(38100700002)(2616005)(26005)(107886003)(2906002)(52116002)(508600001)(6666004)(41300700001)(110136005)(66946007)(66556008)(66476007)(54906003)(5660300002)(8936002)(4326008)(44832011)(8676002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6DdxzyoAENBIoMnGdMg0ieJIUIxhQbUZn+8v/jklJSG7InEXIUaWKyVbd5h1?=
 =?us-ascii?Q?i0JNH+AhG6SQTRArVhEhJ8UlCefrY4zbroIGlkPkY1UskFDaAXAOAvF59D17?=
 =?us-ascii?Q?I3AYFjrv2wEKQDsBVZKmES6dPz7kcDGNd0TQKCmeqXdrVdnwV07w1CU+ApAA?=
 =?us-ascii?Q?QbB36sW8K3fg6caHhZIlQtCjYd6S/koHSVjoNSCltMVysK3nKFgAHJyq/EGN?=
 =?us-ascii?Q?OMneAnC9shLaLb1/jHqCi9wJY+crj+A/aBI0eeVix/idVlYQuKstIeMro7O8?=
 =?us-ascii?Q?ZHywuUyqRjZwPkzbX0Rqt4ub5jz5JOXfrgOI7X8CZFGrqcDPPE80T7fPUFgq?=
 =?us-ascii?Q?fx5P8VZWeJdnejRZcVOPhm6KGHzWTIhiOhypkzBeykGGhKBRPt4YkzexZdKj?=
 =?us-ascii?Q?4Q/md9ydwTCka2PPaauMYPhZfLl0bor2djVgY45zUT/vk+GFZYdxcjKPPi/o?=
 =?us-ascii?Q?1Kz+5ISStNVvjA0zq0ydMDSU0AGiXK0AGjdHgbYlCiGITyrD6tF3FfnWo5Sj?=
 =?us-ascii?Q?/y6sfhxl/c6TSNsPZmCCLGYuLO+Hzr+nVHxmUWduTOzyW0B5GlEaKV2XtERK?=
 =?us-ascii?Q?eughLVsZSds/ZWrJaFqY/mOKYJ6PKsH9YXfPlRTkFfqkJY02CTVJLru3Rrn6?=
 =?us-ascii?Q?wscNlvSVyWW43diqrFBuRE8fh1Pon/tIyXw1l6vAb/LGdVncXV69OcPx9VKm?=
 =?us-ascii?Q?66r3X7EuvmfE/ncshcPJ4AkqiFCnfC24vRO9ZQirHy6NaAh3M+P438jbWk9t?=
 =?us-ascii?Q?O7A9sf1N0Xgya9YoMpm/6YoY18YMj7/eJ/e0Z3Sl/Bg0oO7QZRkp3zKLFu3q?=
 =?us-ascii?Q?sKt24Kmm8SRcaOgFQbXlGiU2DsZ89aCfJFkl3Z6SV0JjPggb3ZSZMTP4aRDw?=
 =?us-ascii?Q?fIx6aIjE0sAVtOdkc7qycEK1CqEb3nzNCEMFD2l6ImIiq5ojhNkGKJClr1QZ?=
 =?us-ascii?Q?GiZCpvX2P/5A7XYVlz0VH0Z1qt+brlAz4d3E1Ji57xrvaTpJisOln/tE4CL2?=
 =?us-ascii?Q?Sj9WH1mj7RC8aWm3TYlH6riT89aUbfd3d9SFxR+XedCW80M8C2aDE+pOlVYU?=
 =?us-ascii?Q?9nYH1uG3y0VQm7TD4J8i80g47S4I+fBMIWVqCQ9gi1XhgpQEvAMPKviOQUsJ?=
 =?us-ascii?Q?ukK+s7uoIvhOfAPiRybdAkMCEUHRpQu8Gq/aFpkDaERTwHtZDxz+4AY2OUt1?=
 =?us-ascii?Q?hKCiJuM3b3xSfrKHDRuw7AaP8xpGolXvaOkT+n6hPiSqWO0IkEsGplBOQAT/?=
 =?us-ascii?Q?/0gJsewWSEzWTN/yKmw1XrK4gwAYXgAKYeVI6iI+R59CwpdH+JhjnrqWLYxQ?=
 =?us-ascii?Q?bD78mZUan1IixXDFjujjWFW/gjJIfHnTwqlkmeM3fL5Kmo6836ZUGObSYmCM?=
 =?us-ascii?Q?tImAYfBarKymWjm588eifgqXshGJ08ZO1+ZGW1MCFsHFzVjxn+OBDh2cfl2u?=
 =?us-ascii?Q?Ay74GliwMub0KRF3gXVqC00/Nvs/+iEsag9njlUukZNHJ6O7jSz5x2tGVq+D?=
 =?us-ascii?Q?P63JL/HNBzzBaxE7WDfZX/3DGWa90UMUxOxQWKhZPBahJfq5D3AZd9PVkwXj?=
 =?us-ascii?Q?ce9FJb1O4R47eea5mZTuCgc8QeqN+mf0hF3J+99JGnE1S8zKvPiIxOLja9UY?=
 =?us-ascii?Q?kA=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 24fb2ba4-3b80-43f5-6a39-08dc2065a71b
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 01:00:14.8060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m6h7guV/WWW7GZUi8sPdkGYHxkb7bU25/Pae+rMP6YlkF3ho1fRK+FKIxq4rUIOzyZ+OjljuX+0nhwgxOw2Uqkp+HyeA1uQoYIdJ1qVnJP4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0630

If other vendor do not select PCI_HOST_COMMON, the driver data is not
struct pci_host_bridge.

Move calling platform_get_drvdata() to mc_platform_init().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 9b367927cd32..805870aed61d 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int plda_pcie_setup_iomems(struct platform_device *pdev,
+static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
 	u32 index = 1;
@@ -1018,6 +1017,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	int ret;
@@ -1031,7 +1031,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1


