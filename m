Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58E3B103227
	for <lists+linux-pci@lfdr.de>; Wed, 20 Nov 2019 04:45:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727357AbfKTDpl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 22:45:41 -0500
Received: from mail-eopbgr00072.outbound.protection.outlook.com ([40.107.0.72]:56708
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727262AbfKTDpl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 19 Nov 2019 22:45:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=naO5F40ECGaHSGgXCEuaJraPJ8nDdel4P8VDSkFc3IVoSR5j/U4Q3CBsEVyolZwIQx8P3RerQmRnGWIc0z+t3s1piYiB5AFN32jZ+n+F/7IFlCGn5SrrmIEDWtSWEuoXccqSQDf76vqR5zR24E6iCXSLee64cODaZ/cDXeDAQsGVmNZIJNYtQGImyPnumJKz4BASeZfhmlErd9zTWWY5eUMxWq4eTegWhtmgxtzo2X8x8O48e4z3Cp+0wM+8TzXCk8ZxyhyIoEpTPcat9DJ22vw95/4Sc6zs71d0L4NT/MHT28IGv46U8+ZFGXBzCcdf+Mnf3+Xq/YI61NSdluLYdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYpAL7e6n70SIIHc5c1GGW0XI3T+z4Snl9EO8Aqf9gk=;
 b=FAAkNYAaF64tYja/nSd7ijLfSu6TY+nYFWmDYt0bpO83AUMDeboUqV5rN9Q2L48gnaW0thQi/W8ZD49Tr/HnzHgKZ/+D+ZdkMaYb2Takkqc+wwLzfSSDyh/PQJHZWqeKHJlyjrTUBrdpBQA/94j8JwMyGus0KQkkBIvuaAAlHYYYEbsfQMmQWRg/RFIEWG9x/szft1SLgBHxKTnY3binJOP28fPX6DX1zW+HMVKFoMbG8wrCSkxd4Zuj3PQGwdiAs/qBIhuc1wFTUtrIjmPoGhIE67DzQKMBX/5Zn/o4/ulMWUf3M8mfVAsEZSV5viIm1phpeT/Vly9kcUQY/y6gvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYpAL7e6n70SIIHc5c1GGW0XI3T+z4Snl9EO8Aqf9gk=;
 b=StgkCfx52p8E678ROcO4smaOb1njxHFvLOdXU3y+eZwVrzz7PkoOXHIWH2XDuBEx5jBKcEkcyNoZ05tfFKzEcTtDODNDI8Mm3jg4zPZ7iCmcFlGcF9OKENKLZhm0B7Xo4/51bh5PmngJd0oUnZeNmedIE16I0ObB7nHMBOGW+V4=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB5657.eurprd04.prod.outlook.com (20.179.9.138) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Wed, 20 Nov 2019 03:45:37 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::898f:3cd6:c225:7219%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 03:45:37 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
Subject: [PATCHv9 03/12] PCI: mobiveil: Collect the interrupt related
 operations into a routine
Thread-Topic: [PATCHv9 03/12] PCI: mobiveil: Collect the interrupt related
 operations into a routine
Thread-Index: AQHVn1T4QPVpuPxbfUOAcnzZ5mJ3hg==
Date:   Wed, 20 Nov 2019 03:45:37 +0000
Message-ID: <20191120034451.30102-4-Zhiqiang.Hou@nxp.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
In-Reply-To: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: HK2PR02CA0199.apcprd02.prod.outlook.com
 (2603:1096:201:20::11) To DB8PR04MB6747.eurprd04.prod.outlook.com
 (2603:10a6:10:10b::31)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 47d60390-524f-4943-1242-08d76d6c1ab4
x-ms-traffictypediagnostic: DB8PR04MB5657:|DB8PR04MB5657:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB56572B3650B5DD0C3FAD227F844F0@DB8PR04MB5657.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4125;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(346002)(396003)(39860400002)(136003)(376002)(199004)(189003)(2201001)(54906003)(86362001)(36756003)(256004)(7736002)(305945005)(6116002)(66066001)(3846002)(110136005)(316002)(71190400001)(7416002)(1076003)(71200400001)(52116002)(2501003)(4326008)(5660300002)(66476007)(476003)(64756008)(66556008)(11346002)(446003)(76176011)(2616005)(66946007)(6512007)(66446008)(8676002)(386003)(6506007)(2906002)(99286004)(102836004)(6486002)(81166006)(81156014)(8936002)(50226002)(186003)(26005)(478600001)(14454004)(486006)(6436002)(25786009)(921003)(1121003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB5657;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZaGBaJFoNQTmn+cyyJx7Rbgo5Es5J8WM9tRgL0Vd2JNNL5SwoJ+MZS+HTS1Jk/Zqhykk94mItc5N8ihFZQfqna/WTtbaj1S8ua1y0K33mfrWvix6ZMyRmP2SBx2CqpAVSCF6Vhd+fcWPYOvgjwqgQZ6+DoC+Fh7rufMvhVKLarWXm6OobSbBv0WfCRE3Fc3/L+UZAY16yDt5KWIzmAUmbsXKy5CuspafEzLdWZmVGwp1At+ZdVTQFWSo+7uCYMl+wv+BKcdase8W41ouvwEkg/L/C0SKphUOzLBggSHTjgSXL75mFcZzJYvAxW2ACqCM2pFdIvl3uk1fiHRPBck2e3SkpzjI3BS5RsVE47tY/H8QLBNjLGqsxyfuzr61KEZMrC9QBf+qLlS9V4NXmqo4h8fJAMuYAjjoRX/QEneN3/Xm0heyPMXDx+3/+IW0NhU1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d60390-524f-4943-1242-08d76d6c1ab4
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 03:45:37.0747
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdPEZPWEacOlux5nXLOQ1PFOeWTcFfdUuE/aSN9gw0RgfM2LggcDifRSPDRjzXWsUMn84jg3/pd7C8/Imu8VtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB5657
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Collect the interrupt initialization related operations into
a new routine to make it more readable.

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V9:
 - New patch splited from the #1 of V8 patches to make it easy to review.

 drivers/pci/controller/pcie-mobiveil.c | 65 +++++++++++++++++---------
 1 file changed, 42 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/controller/pcie-mobiveil.c b/drivers/pci/controlle=
r/pcie-mobiveil.c
index 97f682ca7c7a..512b27a0536e 100644
--- a/drivers/pci/controller/pcie-mobiveil.c
+++ b/drivers/pci/controller/pcie-mobiveil.c
@@ -454,12 +454,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie=
 *pcie)
 		return PTR_ERR(pcie->csr_axi_slave_base);
 	pcie->pcie_reg_base =3D res->start;
=20
-	/* map MSI config resource */
-	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
-	pcie->apb_csr_base =3D devm_pci_remap_cfg_resource(dev, res);
-	if (IS_ERR(pcie->apb_csr_base))
-		return PTR_ERR(pcie->apb_csr_base);
-
 	/* read the number of windows requested */
 	if (of_property_read_u32(node, "apio-wins", &pcie->apio_wins))
 		pcie->apio_wins =3D MAX_PIO_WINDOWS;
@@ -467,12 +461,6 @@ static int mobiveil_pcie_parse_dt(struct mobiveil_pcie=
 *pcie)
 	if (of_property_read_u32(node, "ppio-wins", &pcie->ppio_wins))
 		pcie->ppio_wins =3D MAX_PIO_WINDOWS;
=20
-	rp->irq =3D platform_get_irq(pdev, 0);
-	if (rp->irq <=3D 0) {
-		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
-		return -ENODEV;
-	}
-
 	return 0;
 }
=20
@@ -618,9 +606,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	pab_ctrl |=3D (1 << AMBA_PIO_ENABLE_SHIFT) | (1 << PEX_PIO_ENABLE_SHIFT);
 	mobiveil_csr_writel(pcie, pab_ctrl, PAB_CTRL);
=20
-	mobiveil_csr_writel(pcie, (PAB_INTP_INTX_MASK | PAB_INTP_MSI_MASK),
-			    PAB_INTP_AMBA_MISC_ENB);
-
 	/*
 	 * program PIO Enable Bit to 1 and Config Window Enable Bit to 1 in
 	 * PAB_AXI_PIO_CTRL Register
@@ -670,9 +655,6 @@ static int mobiveil_host_init(struct mobiveil_pcie *pci=
e)
 	value |=3D (PCI_CLASS_BRIDGE_PCI << 16);
 	mobiveil_csr_writel(pcie, value, PAB_INTP_AXI_PIO_CLASS);
=20
-	/* setup MSI hardware registers */
-	mobiveil_pcie_enable_msi(pcie);
-
 	return 0;
 }
=20
@@ -873,6 +855,46 @@ static int mobiveil_pcie_init_irq_domain(struct mobive=
il_pcie *pcie)
 	return 0;
 }
=20
+static int mobiveil_pcie_interrupt_init(struct mobiveil_pcie *pcie)
+{
+	struct platform_device *pdev =3D pcie->pdev;
+	struct device *dev =3D &pdev->dev;
+	struct root_port *rp =3D &pcie->rp;
+	struct resource *res;
+	int ret;
+
+	/* map MSI config resource */
+	res =3D platform_get_resource_byname(pdev, IORESOURCE_MEM, "apb_csr");
+	pcie->apb_csr_base =3D devm_pci_remap_cfg_resource(dev, res);
+	if (IS_ERR(pcie->apb_csr_base))
+		return PTR_ERR(pcie->apb_csr_base);
+
+	/* setup MSI hardware registers */
+	mobiveil_pcie_enable_msi(pcie);
+
+	rp->irq =3D platform_get_irq(pdev, 0);
+	if (rp->irq <=3D 0) {
+		dev_err(dev, "failed to map IRQ: %d\n", rp->irq);
+		return -ENODEV;
+	}
+
+	/* initialize the IRQ domains */
+	ret =3D mobiveil_pcie_init_irq_domain(pcie);
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
 int mobiveil_pcie_host_probe(struct mobiveil_pcie *pcie)
 {
 	struct root_port *rp =3D &pcie->rp;
@@ -906,15 +928,12 @@ int mobiveil_pcie_host_probe(struct mobiveil_pcie *pc=
ie)
 		return ret;
 	}
=20
-	/* initialize the IRQ domains */
-	ret =3D mobiveil_pcie_init_irq_domain(pcie);
+	ret =3D mobiveil_pcie_interrupt_init(pcie);
 	if (ret) {
-		dev_err(dev, "Failed creating IRQ Domain\n");
+		dev_err(dev, "Interrupt init failed\n");
 		return ret;
 	}
=20
-	irq_set_chained_handler_and_data(rp->irq, mobiveil_pcie_isr, pcie);
-
 	/* Initialize bridge */
 	bridge->dev.parent =3D dev;
 	bridge->sysdata =3D pcie;
--=20
2.17.1

