Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 93B8515B82B
	for <lists+linux-pci@lfdr.de>; Thu, 13 Feb 2020 05:10:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729722AbgBMEKG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Feb 2020 23:10:06 -0500
Received: from mail-eopbgr150078.outbound.protection.outlook.com ([40.107.15.78]:23428
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729407AbgBMEKF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Feb 2020 23:10:05 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TS8aBSJ1UuBBRHZxSruDBEzaCMGH7JpX5Bcb3VD9rz5XYtC+TtQiFhx28ncqzhJnna4L0g2OfunTKR6jqt4mUJ8VwtGoOyIOIZtpCVy42o+7vr/sUoQq8odZoixK2ZfRXFzmexKutJZJIqaWnNgTjbZB9QTbJ34FIWymvBnlnhv6x96p9H03wGBx0KlVUpzkPFX2ty5tga2lqVRAopN4sl7TkiS/qdjeMP5fdOVB2u613XT+2PjTRQDSBMzvb8YxBaRPFP7CRwaqTj28/MhZygscZnaqTeMAEMVzy/DFkVgS32XryzWuiuu7ZkbeETO3k76RsGjG9x3o7618VIGb3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgMzdizRhpEhuRxESop9DYMGAk+LXhQrH1XmHl+up+I=;
 b=QFcP9zOywcuM8rhusGC3CrYEo3t97RBsDvfXMIw4aq1/ATLR2Mjdw/3CPa/opRcwxcqngwisyDE/degrrMe4WXqhbeEgMwilE5s723sYWQmv38dPiLL52SPhomOdq8+xcg3RtcLBeDz51E/XH7eg8XkPnfN3JSK1hFZe36ZEXM/VpobbKvAX/ubUy8KyGylu85su1vJFy9UKzNqweJP67E1wW9AOLYT+uRGc3U0AhTBd+K9+Rddm5+FQ7QSWyw7gvpjMBDAwGcVFNb5D5YVBRqslVu/882dicXt3QJqmoit8NwThFB15mIR8TawsY6x1Wah+xGASFUAB90eHAlOO/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IgMzdizRhpEhuRxESop9DYMGAk+LXhQrH1XmHl+up+I=;
 b=qi08in6bJ36+T97xj8TtRflQ9uKcUg3eTiCfyUkvuUyHaZAUbT3u2gz9/UMrhOU/HfysV9vQiwZ+cSQh8f/Eb5WdsqXRTIrau3/+X2dHMwTCnYon3g4JtSzf/rmmuODbe5efcXO868lJypQxG+2lePcOuPLOx0J6q/phsv7FIjM=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7084.eurprd04.prod.outlook.com (52.135.63.71) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.23; Thu, 13 Feb 2020 04:09:59 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2707.030; Thu, 13 Feb 2020
 04:09:59 +0000
From:   Zhiqiang Hou <Zhiqiang.Hou@nxp.com>
To:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org, andrew.murray@arm.com,
        arnd@arndb.de, mark.rutland@arm.com, l.subrahmanya@mobiveil.co.in,
        shawnguo@kernel.org, m.karthikeyan@mobiveil.co.in,
        leoyang.li@nxp.com, lorenzo.pieralisi@arm.com,
        catalin.marinas@arm.com, will.deacon@arm.com
Cc:     Mingkai.Hu@nxp.com, Minghuan.Lian@nxp.com, Xiaowei.Bao@nxp.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: [PATCHv10 03/13] PCI: mobiveil: Collect the interrupt related operations into a function
Date:   Thu, 13 Feb 2020 12:06:34 +0800
Message-Id: <20200213040644.45858-4-Zhiqiang.Hou@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: HK2PR04CA0069.apcprd04.prod.outlook.com
 (2603:1096:202:15::13) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
MIME-Version: 1.0
Received: from localhost.localdomain (119.31.174.73) by HK2PR04CA0069.apcprd04.prod.outlook.com (2603:1096:202:15::13) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.24 via Frontend Transport; Thu, 13 Feb 2020 04:09:53 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.73]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 3190ae7e-e02c-4992-0eb6-08d7b03a9778
X-MS-TrafficTypeDiagnostic: DB8PR04MB7084:|DB8PR04MB7084:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR04MB70849603EC2C959DD4D97F83841A0@DB8PR04MB7084.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-Forefront-PRVS: 031257FE13
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(136003)(396003)(39860400002)(346002)(189003)(199004)(36756003)(6506007)(5660300002)(26005)(66476007)(7416002)(66556008)(66946007)(6512007)(4326008)(52116002)(6666004)(16526019)(86362001)(478600001)(1076003)(2616005)(956004)(6486002)(69590400006)(81156014)(8676002)(81166006)(8936002)(186003)(2906002)(316002)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7084;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
Received-SPF: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gVMkDB997TTci/K1E3+3ErbXEkgNo+Lpqby0AClo7XmzNrEqczeaqYTM7/dvFXq8KFI8Mhmz0iQ94Y3b3qniEoI1zhHgwsj7DjUcWs4vLTGejtHVDmIsgpak3nQWnyCecfQMWqplqiwDH/K6M7tD2L0bdIhTaOCyA6Xh/afuCXh4otDklLsvgmAnOctpMGJWPs7SG+JpGT27ouKN+xe82Hm94mMDiYQHq1CT+EMH5DR03oUA/2XGGaz0Bd66nkKbQ//q5DDHx/CiC2bnz0qGZEgsfDBvakSrjTnV96KF0H2GQj1iI1b3ywApS+eP+vEWQl+nooFI+pGB4qQmHF59Idt0x0Uq1x3HxXOdkJt+L6hmiUPDkNOKAPQ7GbeIPJoph3Z5mdubMFPV0MWi7LJVsyESRAHXGtOzkDsUwsFpd6Nlik14V8VdD2tP+/wdJk5SfPcqB6sBVzaNH794vwp47GOmdiLWcoRyzW0JvVqHjWgaGyXAtiwHdE8GsrVHP9zNK0c7bomMRbuhKPLCcENf1aDeIsjjQAwmt4pOnLclY5TiP7FiwvrzlDEaq4+2yIGnFaN7rUjmpOFevKM9cWXV/w==
X-MS-Exchange-AntiSpam-MessageData: T+VQppsdudpdil4m7yeDxyRt/6S/9YWpWIwCVOY9b7tZdYW9XicQtnUXQAXH5HBpSLhBa7U2TJTUZW/EbVSjN6ozbS5tqAkCAB63xwgSxP+kJJ4uNLkKO9EhA83H+8aTFobWA79xjliZ/WyT65qFDg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3190ae7e-e02c-4992-0eb6-08d7b03a9778
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2020 04:09:59.4672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYouU61tq/fRCoLbesRvPmqTM5XO5hwR0jb8JNbfS4fk5Vng2ZNjClDvsjrYNvUY5Bf+FUB6DKxVVlUMABhaDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7084
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Collect the interrupt initialization related operations into
a new function such that it is more readable.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V10:
 - Refined the subject and change log.

 drivers/pci/controller/pcie-mobiveil.c | 65 +++++++++++++++++---------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controller/pcie-mobiveil.c
index 01df04ea5b48..9449528bb14f 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -454,12 +454,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 		return PTR_ERR(pcie->csr_axi_slave_base);
 	pcie->pcie_reg_base = res->start;
 
-	/* map MSI config resource */
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
-	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->apb_csr_base))
-		return PTR_ERR(pcie->apb_csr_base);
-
 	/* read the number of windows requested */
 	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
 		pcie->apio_wins = MAX_PIO_WINDOWS;
@@ -467,12 +461,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie *pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins = MAX_PIO_WINDOWS;
 
-	rp->irq = platform_get_irq(pdev, 0);
-	if (rp->irq <= 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
-		return -ENODEV;
-	}
-
 	return 0;
 }
 
@@ -618,9 +606,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	pab_ctrl |= (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
 	mobiveil_csr_writel(pcie, pab_ctrl, PAB_CTRL);
 
-	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-			    PAB_INTP_AMBA_MISC_ENB);
-
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
 	 * PAB_AXI_PIO_CTRL Register
@@ -670,9 +655,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pcie)
 	value |= (PCI_CLASS_BRIDGE_PCI << 16);
 	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
 
-	/* setup MSI hardware registers */
-	mobiveil_pcie_enable_msi(pcie);
-
 	return 0;
 }
 
@@ -873,6 +855,46 @@ static int mobiveil_pcie_init_irq_domain(struct mobiveil_pcie *pcie)
 	return 0;
 }
 
+static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	struct platform_device *pdev = pcie->pdev;
+	struct device *dev = &pdev->dev;
+	struct mobiveil_root_port *rp = &pcie->rp;
+	struct resource *res;
+	int ret;
+
+	/* map MSI config resource */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
+	pcie->apb_csr_base = devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
+	/* setup MSI hardware registers */
+	mobiveil_pcie_enable_msi(pcie);
+
+	rp->irq = platform_get_irq(pdev, 0);
+	if (rp->irq <= 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
+		return -ENODEV;
+	}
+
+	/* initialize the IRQ domains */
+	ret = mobiveil_pcie_init_irq_domain(pcie);
+	if (ret) {
+		dev_err(dev, "Failed creating IRQ Domain\n");
+		return ret;
+	}
+
+	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
+
+	/* Enable interrupts */
+	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
+			    PAB_INTP_AMBA_MISC_ENB);
+
+
+	return 0;
+}
+
 static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
 	struct mobiveil_root_port *rp = &pcie->rp;
@@ -906,15 +928,12 @@ static int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 		return ret;
 	}
 
-	/* initialize the IRQ domains */
-	ret = mobiveil_pcie_init_irq_domain(pcie);
+	ret = mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Interrupt init failed\n");
 		return ret;
 	}
 
-	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
-
 	/* Initialize bridge */
 	bridge->dev.parent = dev;
 	bridge->sysdata = pcie;
-- 
2.17.1

