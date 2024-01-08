Return-Path: <linux-pci+bounces-1805-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E104A826D09
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 12:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 669571F22038
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 11:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D110314ABC;
	Mon,  8 Jan 2024 11:40:36 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2053.outbound.protection.partner.outlook.cn [139.219.17.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673E614AAE;
	Mon,  8 Jan 2024 11:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nNSrxoW480dcSq2maj/fJ3SHoia9EDzinyXewvOLsOYBgr5VZzEyhzkZ6gBxea4WaWJh7E5HC3JV03mSapRSN0nxlhvnaVZIhSdvraIUj4eZMLkk6Z7tyE5ouBz7FK+FiNc8oVCZJ+EKVVe78OA6qEXQHfBOV2IY0RnwZxn0kVuY4LN6/vzIJPkdcVj+8+s6eAZjop7S9E9OyZXhr7aBpj6RWyvsY9AhZLoxYKp9mq6UCGO50He5h3j3S+fSa5xCLqTkGMldg9/YwNdfB96/VroSRrIoJxM0Dsn4s7S4Bw7NUk0PuyyHUHSXgk/vHIErXTWJw8GSKAw7jl6AXrCtaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pb6Em/BmQcD7nzISggViwkd990VUOTxwxw4eGNuviyQ=;
 b=gcSH8haaBzWI4PylBn+zm+gONHcY2r2l/Ik3UHZ/+EuaAoh/ucaTrHWZ/hkH5XtuGBx9gYSbxraOr5mYkKbwylPrFl6TfqDyD2/UXkLDaM8InSKaqyGdHYWhJq7LzTiefUxmlMf1vlnSSQ68Y12qxM3t3ejU3ZmOs9uQhRXTdLf6K9QbgVgKRuYnPCpH1a3BfE+csU5ykNEhVdotWlyk/0Ml7/3cQK6rHWoXOhe4WhoiRli9uD8QBQsbj+G7nYbL/m2kaBd8atGbaxIRSqJBCBm3p5NdbTe3Q7BPcIGOBufE3LcSAVMDkYKfssFelS/coETY1C1Ndt8z+yUaNaQM9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0797.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.32; Mon, 8 Jan
 2024 11:06:46 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::e6aa:baea:fd8c:4cd2]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::e6aa:baea:fd8c:4cd2%7])
 with mapi id 15.20.7135.032; Mon, 8 Jan 2024 11:06:46 +0000
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
Subject: [PATCH v14 12/22] PCI: microchip: Add request_event_irq() callback function
Date: Mon,  8 Jan 2024 19:06:02 +0800
Message-Id: <20240108110612.19048-13-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1b70f64c-6715-4a11-0958-08dc1039e740
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AAkhzz77rVhxzkbhXFnt4rTTxoTgsGsZWGUVLm0/uyvuMUc3cAmAswXKsGMxURwQorp5huvP+E8KrXahzWrLRxZRfdlkZsfKXYjuGBH1zEq8VI8oKZgd1+jjb1L0gOgLrCb/SE0qITzH+J5eBZrMG4pPfv4m4BRIL2rkfm9YLF1I4z9JdLhNBpi08AbTKpKwgZsKLvo37r0o6Mdr/x58Qm2IBNSseHHhz4bbXPFkksTVhMP8lP9onUGTHMyGmgYM3SmBKH4GCuj9avI/wdWyzcw50Wi0WHFl8gZkE3yf2LZZ5VO9Q9AeKP4EZfvKjAr5IF9PqwRkkyoscSNztWt42Mm1MYtVvtDeZqjaAYOl7snp6mYADrrUeMxvc/lOWnC8BtokvzAvc7rspHLL4PWek8uQQjGY4NYsjo7HvSJTtVTCkVImUyNGBnYzXmsyu3iw5oJ7jTAwIebVtxj97JejgvXXu0WsRH4kjOhZ8GCIyjlAuDrKvNadpFco0ECibf9oN6O5gRRejqHApnlOLMU/odrjxzu3f9V2+TJJXOESVPFtiNSZGelfHHT5k+93eVRg
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(136003)(39830400003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(8936002)(41320700001)(1076003)(107886003)(26005)(2616005)(83380400001)(44832011)(8676002)(4326008)(86362001)(52116002)(508600001)(66476007)(6666004)(66946007)(66556008)(54906003)(110136005)(40160700002)(38100700002)(38350700005)(2906002)(5660300002)(7416002)(40180700001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5AmbcUv6nEMSnQ0O+Pw37Eh8xmxjRg/bJXknrRSxiUf5CCK/gBIO4C4ufU6R?=
 =?us-ascii?Q?bmvfedzaO49dbhhFoAfkak1gl62DgFnWt8e2M5IEkbLQoyGycsmSoRthK74i?=
 =?us-ascii?Q?gmhK9s/jg8HXVXXwKFV0aj0vHenduj5g731j2WhLMRNaz98T2ac4v8F2seGw?=
 =?us-ascii?Q?A3tAFhq0mvjCh2tck+/Slr3hSt6TW6+OmHPX6TGmgTeJu24nNC3X5hAEdVnv?=
 =?us-ascii?Q?LbLw6DTr7K5pUGT4vTl0d4+FDyGgPeR/cmJ6VrwfLvs7w51Y4y8Ug4O96o7E?=
 =?us-ascii?Q?OCSAW2P6h9Ukizt5mXQ602aVduO1KIO2wullWcbaY6G5lKptHEYdr45SedHv?=
 =?us-ascii?Q?22fdgjSdqtXUPfb6WfCzYYLVNnAztOdAtQ6HdJ5zx6L3pOQijhIif7kL5MWp?=
 =?us-ascii?Q?aM1jgWD/VuZGtiWTUL2ttcN6QvineU1ZPrmBe4+hELiBe2wjvZExeVFhb8B8?=
 =?us-ascii?Q?DsDLJM5DDiaz+rxngv2fhEYPIkXt5S1/tTpamOw0C+1Z0BCCMliNPpUPHWWf?=
 =?us-ascii?Q?5Gg7oSPW1RUzdHhLmp/QgxpWvipxC3SF13ntOt/Fwph6r7I07gwrjokrqay3?=
 =?us-ascii?Q?3IYpsqLlzs03/IRNJ/nMUXZgluUCxlkaqg4qUjndC9N8r09xhYP212+Lttjj?=
 =?us-ascii?Q?miDZ0z1FkFBK7ge0fcYSSiOa3zNBLjUgyOmxqAAwVtVFv4eQ2ZEf9HtQra1J?=
 =?us-ascii?Q?RmRO+9sVVojolAs1mMPYIiY8aOMXOV0e8JSd3BxVHnjPpEaylGb1CAoOjLj+?=
 =?us-ascii?Q?vGamVmH7aWDDDpCCpmzhOLUNj7tMhFx5EfAd2B1BLLxW1SiXV60MaXWij1LB?=
 =?us-ascii?Q?n/Pu5QsW8cPGdDvHpF6+sA5a345UEyZ35BD9CbHpwrzsv+MDFlK+R2rmTOhR?=
 =?us-ascii?Q?8/jglM3l75DZ5Lev53XfJ7C+ZPntpIL9WALWxkvv0QgyFLw0sOsz0zUJqQdc?=
 =?us-ascii?Q?zixIVbl/rPmp00HlWvgRUnPs5tKf3+0GFoajFm+5ZSm57Na4luLpdPv20l41?=
 =?us-ascii?Q?ff2weJdrcvJVuXhU+S+4MZQnlHvIiCRE94enitl1/bR/2AqkuWkua3C9gfsD?=
 =?us-ascii?Q?4QYELqHRDyM9/WhrXUeK53qKfzGx4INFhuwxYMDpRQdQWkLaj1UJunrxY/6O?=
 =?us-ascii?Q?FSf9ObYpqwfRCwxJx5DMV4UFf6G6u74rCKRJOwLb3GY+MyBKLUcei72DnyLR?=
 =?us-ascii?Q?wAWA7T/cLZ7SqhTucAgyF+QI1Mwh3gnugfIysDb+/7tRIz9eRlHrjncnOEhH?=
 =?us-ascii?Q?c0W9361CV26Vvi1p6ttk3o4icLbHcmKhFIeFsPi1y0UjqTInL5AamPuZ2GGv?=
 =?us-ascii?Q?HMJrgWZKG9bZQwkI2TU2bx3UrV3COz+OmsbhThCe4tgmQVtn4sheQ/0oS7kj?=
 =?us-ascii?Q?97+URsgj06VBKZtmqyIvZzGZNWXzHoShLLTLIgKecFbrQ23eQ++B5hAHTQ5R?=
 =?us-ascii?Q?CXDhJ6v4/grgsFMAq3L8ejKephnkRdwlnqjdaRe7g5KXy7ijtHWvS3AwA6RP?=
 =?us-ascii?Q?/R+Tz36XMRVd75MPPVdVe7lH+zOQ/YQgoeTG+glJxVDtfAYwWvVZvMZUq39g?=
 =?us-ascii?Q?X8YdUfffeonM7r6sx/vvg7rFmFhGw/aJ41GKcHYo2Hl6R19L+rFDgLcpVbwH?=
 =?us-ascii?Q?tw=3D=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b70f64c-6715-4a11-0958-08dc1039e740
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2024 11:06:46.0278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cGfH8itZEs1gYQ8LbGuOL/Pi9viMeY80lx0ABocOhbgc78oSRf3wUn9i+pq7+2aYcawf+4vItxeykxENUzMFnD2v7ZYD/5ATz5iYKhR6DCQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0797

As PLDA dts binding doc(Documentation/devicetree/bindings/pci/
plda,xpressrich3-axi-common.yaml) showes, PLDA PCIe contains an interrupt
controller. Microchip Polarfire PCIe add some PCIe interrupts base on
PLDA IP interrupt controller.

Microchip Polarfire PCIe additional intrerrupts:
EVENT_PCIE_L2_EXIT
EVENT_PCIE_HOTRST_EXIT
EVENT_PCIE_DLUP_EXIT
EVENT_SEC_TX_RAM_SEC_ERR
EVENT_SEC_RX_RAM_SEC_ERR
....

Both codes of register interrupts and mc_event_handler() contain
additional interrupts symbol names, these can not be re-used. So add a
new plda_event_handler() functions, which implements PLDA interrupt
defalt handler. Add request_event_irq() callback function to
compat Microchip Polorfire PCIe additional interrupts.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../pci/controller/plda/pcie-microchip-host.c | 31 ++++++++++++++++---
 drivers/pci/controller/plda/pcie-plda.h       |  5 +++
 2 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index 0a5cd8b214cd..bf5ce33ee275 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -642,6 +642,11 @@ static irqreturn_t mc_event_handler(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t plda_event_handler(int irq, void *dev_id)
+{
+	return IRQ_HANDLED;
+}
+
 static void plda_handle_event(struct irq_desc *desc)
 {
 	struct plda_pcie_rp *port = irq_desc_get_handler_data(desc);
@@ -803,6 +808,17 @@ static int mc_pcie_init_clks(struct device *dev)
 	return 0;
 }
 
+static int mc_request_event_irq(struct plda_pcie_rp *plda, int event_irq,
+				int event)
+{
+	return devm_request_irq(plda->dev, event_irq, mc_event_handler,
+				0, event_cause[event].sym, plda);
+}
+
+static const struct plda_event mc_event = {
+	.request_event_irq = mc_request_event_irq,
+};
+
 static int plda_pcie_init_irq_domains(struct plda_pcie_rp *port)
 {
 	struct device *dev = port->dev;
@@ -904,7 +920,9 @@ static void mc_disable_interrupts(struct mc_pcie *port)
 	writel_relaxed(GENMASK(31, 0), bridge_base_addr + ISTATUS_HOST);
 }
 
-static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_rp *port)
+static int plda_init_interrupts(struct platform_device *pdev,
+				struct plda_pcie_rp *port,
+				const struct plda_event *event)
 {
 	struct device *dev = &pdev->dev;
 	int irq;
@@ -928,8 +946,13 @@ static int plda_init_interrupts(struct platform_device *pdev, struct plda_pcie_r
 			return -ENXIO;
 		}
 
-		ret = devm_request_irq(dev, event_irq, mc_event_handler,
-				       0, event_cause[i].sym, port);
+		if (event->request_event_irq)
+			ret = event->request_event_irq(port, event_irq, i);
+		else
+			ret = devm_request_irq(dev, event_irq,
+					       plda_event_handler,
+					       0, NULL, port);
+
 		if (ret) {
 			dev_err(dev, "failed to request IRQ %d\n", event_irq);
 			return ret;
@@ -983,7 +1006,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 		return ret;
 
 	/* Address translation is up; safe to enable interrupts */
-	ret = plda_init_interrupts(pdev, &port->plda);
+	ret = plda_init_interrupts(pdev, &port->plda, &mc_event);
 	if (ret)
 		return ret;
 
diff --git a/drivers/pci/controller/plda/pcie-plda.h b/drivers/pci/controller/plda/pcie-plda.h
index adfca9f28458..16b81b23c213 100644
--- a/drivers/pci/controller/plda/pcie-plda.h
+++ b/drivers/pci/controller/plda/pcie-plda.h
@@ -127,6 +127,11 @@ struct plda_pcie_rp {
 	int num_events;
 };
 
+struct plda_event {
+	int (*request_event_irq)(struct plda_pcie_rp *pcie,
+				 int event_irq, int event);
+};
+
 void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 			    phys_addr_t axi_addr, phys_addr_t pci_addr,
 			    size_t size);
-- 
2.17.1


