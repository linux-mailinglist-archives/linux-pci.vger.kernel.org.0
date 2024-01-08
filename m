Return-Path: <linux-pci+bounces-1804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 27331826D02
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:39:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8620CB20AB2
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB2E14AA7;
	Mon,  8 Jan 2024 11:39:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2048.outbound.protection.partner.outlook.cn [139.219.17.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F186C224E9;
	Mon,  8 Jan 2024 11:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fnll+4r0l1nTz0/+ZOCrXR9lHwxEXMt+zIkUynhmrcLQkzEvuY2upGaGwYH1e7IMSBcBfmBV9rST05Rfe/GnUL8B+Bxb5YXLZ1LPJdzFDuGUOCxax+xSoMxdLDWABbiO+PlS4Qzjpf+idf+tBefCh9Tm/vbelChcLzCH6QJpAXgpFgoHyAj9UuZQsoa8+dPd05SmDdW+KhvFUy4cv071kkmMRxcIXoSz9zXzArSmSDLfvP2lPtEucafYs12M5B1ldARjum+5lqurCrZjjFEqWjLC/KdVVPTWdunCRsQ105VKvQlBLB1YVJvJph/YhTRWjaMKN34bcsyJUHLQ/YwgxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pc2T6SbVvFNGAc7jANlqkHZ/EYw1YXpAsFWAuojjcfk=;
 b=nEBWNET509afv5ZYoZzR+tMBQPNby11dT4b+qDRZKul9Headx+bGwNbuG3DwzQq73SPTDmmFcXGovZbT5P9Y03iK23bNfGpOI/v9zh+NWFZ4K3cESBvBWPX3oxZTaVThyPkSf9yb3iDdV5eRdrN3IhCtn9kiAXy6tqt7/ImTXPMu87D7kqJSKayEyTLxrJHN5zQfZzRtB7wYgSr8l/lMzgoGRqTd63JSvl6sGu38T+qTpKZrtRcEgCvP+qJGt8il+65ukQVG97f/TO9wNEeuYcejaNzccg8/2u7Y+8qLZZMHNHZXEbQ3QzsMqSjy2DV7Z6bpJRbt0fmw/0RIvNqu7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:36 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:36 +0000
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
Subject: [PATCH v14 07/22] PCI: microchip: Rename two setup functions
Date: Mon,  8 Jan 2024 19:05:57 +0800
Message-Id: <20240108110612.19048-8-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: d990fe60-f60a-4683-a69f-08dc1039e16b
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Tsa9W6i36SJnTtdqbz0/lMWP5ZMfpA0HL++t0pzkQUdAs8DbDTdRiJtqOMxPApzapHkSeQ1xCHrJHkG430u6b3Y95L5Tbx0o2JAThtrfsRKCRgPNMRBT6KcYVIo1IfZl4AvA1S0b1r6VtbTvVUprHB467Kg/yqad80tBFI/CiyhY82b0SWCVo4j+nPF7ueBio4GKUhejcj+wLeC1RGk7nfmgF4pJM/nX3JTAIjKoQVvXznF3Ll8/qyPHchF35rrSamnlT8WwusXz9ijJg5Vj+BXiCUzJYnZoWsjyLz0B6sj8+j26SHIZQpw4OqTBP0SKTLIARJQymMJQfrdzGr1XeoAur7noQSu9wRcyY96b34WZQxc5+bXJJrJyUeR9bhcuRxnkVbA/1mECEAzPAJ+7slW/loZFfofHRe+oC3qlUVGGPunb1xgYODYbbzKcbARF+snqHsnVnkMmXeFHoCfm4n0hgKxIFOsTX6NSyXvSbthJp2zBppYk2cL+RF8A51orLEamo7Z7/muAk3H3ArQv7uv/M3OGSbtexJ9XuRPV4MsL9cmEoJUVSNrLrdfm1Fk
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9J8nJdbFmKRHmMiEOlE9U/xzcszmKAWOVwA6kmfFJDkRjCmH172SmOGBqPuz?=
 =?us-ascii?Q?d5GFiBbRqPqRcc5IE1Wz3T3oCk7Z84O5A1ItYNO/AkUAAdaOmKFsMhU14rwT?=
 =?us-ascii?Q?auQwV9Gb+5JiT+X1V7DFyYUbM3CQQA77j/nfvbbukaM4wvh0Gwo/YM5WrD3G?=
 =?us-ascii?Q?te4VsTx/2sxwEK7A/ZF35K4TPFYirgFiaNll0YX9aoXpdAjeZI7T7RXQSinT?=
 =?us-ascii?Q?UcKkWhMhiI9qsN69AFDjdvdaKNnKi64GxkkjcXj7iQIVdsSAcwUm5/V0pJML?=
 =?us-ascii?Q?P7vog9OuiGj35HIHY67MtMljadNsmbZL20pusjn67AokIUV9EAHXTBLII9lo?=
 =?us-ascii?Q?8snJGXSDiBrD46GBjCaVKa47TSIG2WRIUxRuyrQBqOR+EQr3v6/YKrb/usHM?=
 =?us-ascii?Q?lbkyS5cnMtxOE4W2JqlIMYBhLBs5gALwjTcRW8egQHBGJgvLNyTVzqOO0dHa?=
 =?us-ascii?Q?uUGWcM5N/mw1kYHJ53cryAAKZWDmWrT9UdaP1WO8iToPV54jHyAXswrbBIJA?=
 =?us-ascii?Q?y44vrVhMTlj6CcZVcLPULwfpa2Oqk0pFBJ9uEPF1H9YxSqxB1X5hIC1Ikim8?=
 =?us-ascii?Q?l2iHwnqzKM5MQ4sO0m2a+8yBhy3gGCWkT9fYKAIjxeyLzhC0RrzIXtTBOCS4?=
 =?us-ascii?Q?8rz+Ii6bWUnA5VPYCIPkUjyqNKjUtWPe5vn46vSbwxgBzpV1JT+3Tth3x2Bh?=
 =?us-ascii?Q?tgmKDH3EPlRcsMY/zBkGrpxRQSIuk7tQam9yDrlxyWpIu64IDZPJXk65zq9M?=
 =?us-ascii?Q?QXmEHZudYDd0BB+3Oq/nuW6GXhXPgg6osT3uuvl3p1veQmqftFAoKI1d92KX?=
 =?us-ascii?Q?uOpCbdP8r9+v0Tzl3+yB/cY7p/DmlvqAFRmVrjl5U6d7swrskGlXbeGW7HkY?=
 =?us-ascii?Q?kSNWF/cv+OG5lGMq4c5IqPCJAPdZ9Yyv241TdIjgaMTYk4wODeT606yd/u8b?=
 =?us-ascii?Q?+Auf8kY++3wtmvn+Nnwdr4CDfVaaWu7oU7ri5hzoBCtKUa5aLjtzCImjbgly?=
 =?us-ascii?Q?3J+FB7R16iHcW86Y7ERThC7/7pP5OAgF+OTQy6NO9+Q4aL1zK0JPZgn7K+FB?=
 =?us-ascii?Q?CM0gHhKsKA9jiuMxrWrSxgFoZJoPAsGsBeubPqtjtQ5/0QJ6r8Lg93/k+g6A?=
 =?us-ascii?Q?o4etm8QjcA//yMwf2wOVIQXJlBf3OH6NVujCo1U39lTtOySVi7WULxf6xi0D?=
 =?us-ascii?Q?E/tjWYYrADGxcGK318FMZQk+FPmuOm8TeG+1c9jpXBqtlwpsrgOmUU9tlXg6?=
 =?us-ascii?Q?4ty9Qy7fI40JTdT4bJGEpUzhlH02jaeYiuYe3h1Gf8NzsOcIRqHoyw+QPEIh?=
 =?us-ascii?Q?gznGL9ob82VkUK3eyg4XB1oUKIOWHIYwEDFXIJynnEVTAXHQ/XBWS5FvU++r?=
 =?us-ascii?Q?er0rR2/mVISqdEw/TWfwIikfM0Lq/PNVU1Hv1YdAiWTHUPrmaAvYHXXipGGS?=
 =?us-ascii?Q?2p2/0nViWWoB23bs4H2HrwcZCZ3Hzy5L2Z6/RSh2zX67Hxy2vONnL31XefXh?=
 =?us-ascii?Q?Wq3EJBCHgbPIz4naggNJk/Ir8AJKe+3jvMoz6Zwtk1f1BrlkG/SVhzA6aw+n?=
 =?us-ascii?Q?MDRs3yOar0SYzoJqLZm4rt/1TXCcGroMoWpW3XP075Fr8eDp3fWYOupZiLXj?=
 =?us-ascii?Q?9A=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d990fe60-f60a-4683-a69f-08dc1039e16b
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:36.2244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UPo3ikEas0OCFUubGrjmdRLi1bT1F/tREpoAqxff8zYAZv0B3LQiBA6Qcy0ttYQGxfWjl9sXybJ4v9xAzAZ9BGBOJPk0CBeKTXzYHQ9zPkc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

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


