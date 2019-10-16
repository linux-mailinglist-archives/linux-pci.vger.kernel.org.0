Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAB42D99B5
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2019 21:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436688AbfJPTJK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 15:09:10 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:59156 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2436686AbfJPTJJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Oct 2019 15:09:09 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9GIqlwh020913;
        Wed, 16 Oct 2019 12:08:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=qsKrB79KJi1H1WPzlpH/1omAsx3DWmVdkRrmyyCm8qY=;
 b=TRn1WTPOXuFzWkm6J+DhLYzxwJgbTBUXyQcuGTm02mgxTLledJIg12WUM757FpaycZyN
 qOfCUc2FxF/JqWqE1l9I+dqzyf6s3vj91aEy5J5hUzxd+094qb0ORdVrneQdTyEToQH7
 dZfXfD3U8md+8DUQO9dsym3uVgChs2Og+Dh3NyzYZqlSJ9jdYB8mHupcASgtXBipLWlc
 wZhK4PTTNd3vvC6mANdVeIT0iFuvEhvOn3V3Pmh21wiLCyx1LOdWiU9Pj73gOPwxM9oz
 4bEcpYDE0que/k1HSDlBRbf5Cl3Pz1AMsSaHev1izlUzgbHljVDId+9O5UpOKBdYrrc1 Lw== 
Received: from nam01-bn3-obe.outbound.protection.outlook.com (mail-bn3nam01lp2056.outbound.protection.outlook.com [104.47.33.56])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2vkbd29dkh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Oct 2019 12:08:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=luEg0ltM20lPHuoGrzMRY6DeHsbrCpi61FLxMoC/YELGJdLKAK7iTdwz6bD25vqFJ7g3rjKT4fHG1l5fNfpu1mV5a809R0QNq56S7XuVVa867f5akPQW1Q648tCmLiR3tSMLEvIL1Wk7SVYABkDND+RDyKJ0b948QIjyqpDGFFj676JpRHGEaJGcKUh3X6tKyY92xnbZtHxk0usHX7QvJyZQ8Inp0/Z+fPLgotVOc4JWAvc82uqxme4Y9jnUFKXRW5XWAnJVDn82TkW4fLk4pg2TGBcX+/l3fmZ0aKqOfVlglF8EmP1kcp9DaSUiAZC5hVSseo38icEJFdp0TdZzTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsKrB79KJi1H1WPzlpH/1omAsx3DWmVdkRrmyyCm8qY=;
 b=TEtKCYKWoZHkUHSv4VrPFzJ8F0tQ4X+NDoLzUoKoO8dLcdMstyxRtmezzB1R2IVp3ykrmxc5jcHrUGHoBwiPClPub+7NjQZHggb433lIDx0sLZPskdYVkvBNA/mPtGJtDzkfeOZqWkPFd+k2Oojc23IMJK33Fqu9efHisW69e1PsD975CAhN9W2lD4OsnMmxrAsok4rgTl8rGEpWM75qWV9tx4imwC5Ly/l5l5lWMqiQz3BiDmjLpyn7+9FRyeDIN+LgHgnYl4tlmA/6B+4NPTouzdWqnAlbSz71HUsBz33DCYoJs6ahq6W9oO1fz3NkMUWvXiuk477NxOdwKRYhnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsKrB79KJi1H1WPzlpH/1omAsx3DWmVdkRrmyyCm8qY=;
 b=ZqzcZrkFVHgIPWpf8Ms6MvN9vahXEwsT31gdpAzEptzf8XUPu9ceUONH9bblw85ibVGoGuwORGPS2xPNqwfLfHdO1b1KKvzWqcNLCz4lZ3dc5I88dCr42RRvTF9btOrxfJ3EL9Piv/euWTeg0J5+KroH8IXzzK5a4OsEFTEh5aU=
Received: from BYAPR07CA0086.namprd07.prod.outlook.com (2603:10b6:a03:12b::27)
 by DM6PR07MB4507.namprd07.prod.outlook.com (2603:10b6:5:c8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.17; Wed, 16 Oct
 2019 19:08:48 +0000
Received: from CO1NAM05FT013.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::207) by BYAPR07CA0086.outlook.office365.com
 (2603:10b6:a03:12b::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2347.16 via Frontend
 Transport; Wed, 16 Oct 2019 19:08:48 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx2.cadence.com (158.140.1.28) by
 CO1NAM05FT013.mail.protection.outlook.com (10.152.96.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2367.5 via Frontend Transport; Wed, 16 Oct 2019 19:08:47 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id x9GJ8is2024941
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Oct 2019 12:08:46 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Oct 2019 21:08:43 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Oct 2019 21:08:43 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9GJ8hE2007562;
        Wed, 16 Oct 2019 20:08:43 +0100
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9GJ8g7k007561;
        Wed, 16 Oct 2019 20:08:42 +0100
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v2] PCI: cadence: Refactor driver to use as a core library
Date:   Wed, 16 Oct 2019 20:08:32 +0100
Message-ID: <1571252912-7354-1-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(396003)(346002)(376002)(36092001)(199004)(189003)(6916009)(50226002)(305945005)(51416003)(356004)(6666004)(86362001)(4326008)(8936002)(16586007)(246002)(107886003)(316002)(7636002)(54906003)(30864003)(42186006)(8676002)(48376002)(76130400001)(70586007)(336012)(70206006)(26005)(478600001)(36756003)(426003)(2616005)(47776003)(476003)(486006)(2906002)(126002)(5660300002)(2351001)(14444005)(87636003)(186003)(26826003)(50466002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4507;H:sjmaillnx2.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9683149f-351f-488f-5615-08d7526c45b0
X-MS-TrafficTypeDiagnostic: DM6PR07MB4507:
X-Microsoft-Antispam-PRVS: <DM6PR07MB4507B1B0A25476EEBACE76C2A1920@DM6PR07MB4507.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-Forefront-PRVS: 0192E812EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFLbC/0Ahy3Y1Uq51S7rM3OvQK6pjBLvAW9sW+HRKA8x1HM2cKbs5eRk9a5/fH6GlxVMdhupjJPJLpIiDc754BASc/kXZWSqX2+Ie9mT6dvFizxDp4l+rzFJCzbAQKnZvlXwlfY+G3e+qq5v6pstItsj9WM5bXWIK3z7HJ7D3bYSRhoiZ3P/oYdAYJ8/1gPUwdzNSzGp0sGQJh+6ZzEMY6frNjr7XWYBwZQRBMd0XIprkIbfTScftOo1io7GvGsi4UO0Bpdj/YeNMU3GZcYnmOIpuNj9Cq7fsmUnuf/e3yYonxmBEiANe06idNkYMdDyDIUD/GWe48IhNxzMJ0OlbsTwdUKADBVzkRX1D2/xUwO5ExQraQUzfWIx4nO8aOaeF2+qUftUA/JlPR/X0AzajR8/Q6nh1Tu4E3/u6Qk585s=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2019 19:08:47.4263
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9683149f-351f-488f-5615-08d7526c45b0
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4507
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-16_07:2019-10-16,2019-10-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 bulkscore=0
 adultscore=0 mlxlogscore=999 suspectscore=1 phishscore=0 spamscore=0
 mlxscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-1908290000 definitions=main-1910160154
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the platform related APIs/Structures in the driver is extracted
 out to a separate file (pcie-cadence-plat.c). This enables the
 driver to be used as a core library, which could now be used by
 other platform drivers. Testing done using simulation environment.

Signed-off-by: Tom Joseph <tjoseph@cadence.com>
---
 drivers/pci/controller/Kconfig             |  28 +++++
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pcie-cadence-ep.c   |  96 +---------------
 drivers/pci/controller/pcie-cadence-host.c |  96 ++--------------
 drivers/pci/controller/pcie-cadence-plat.c | 174 +++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h      |  82 ++++++++++++++
 6 files changed, 297 insertions(+), 180 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-cadence-plat.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index fe9f9f1..cafbed0 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -48,6 +48,34 @@ config PCIE_CADENCE_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCIE_CADENCE_PLAT
+	bool
+
+config PCIE_CADENCE_PLAT_HOST
+	bool "Cadence PCIe platform host controller"
+	depends on OF
+	depends on PCI
+	select IRQ_DOMAIN
+	select PCIE_CADENCE
+	select PCIE_CADENCE_HOST
+	select PCIE_CADENCE_PLAT
+	help
+	  Say Y here if you want to support the Cadence PCIe platform controller in
+	  host mode. This PCIe controller may be embedded into many different
+	  vendors SoCs.
+
+config PCIE_CADENCE_PLAT_EP
+	bool "Cadence PCIe platform endpoint controller"
+	depends on OF
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE
+	select PCIE_CADENCE_EP
+	select PCIE_CADENCE_PLAT
+	help
+	  Say Y here if you want to support the Cadence PCIe  platform controller in
+	  endpoint mode. This PCIe controller may be embedded into many
+	  different vendors SoCs.
+
 endmenu
 
 config PCIE_XILINX_NWL
diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
index d56a507..676a41e 100644
--- a/drivers/pci/controller/Makefile
+++ b/drivers/pci/controller/Makefile
@@ -2,6 +2,7 @@
 obj-$(CONFIG_PCIE_CADENCE) += pcie-cadence.o
 obj-$(CONFIG_PCIE_CADENCE_HOST) += pcie-cadence-host.o
 obj-$(CONFIG_PCIE_CADENCE_EP) += pcie-cadence-ep.o
+obj-$(CONFIG_PCIE_CADENCE_PLAT) += pcie-cadence-plat.o
 obj-$(CONFIG_PCI_FTPCI100) += pci-ftpci100.o
 obj-$(CONFIG_PCI_HYPERV) += pci-hyperv.o
 obj-$(CONFIG_PCI_MVEBU) += pci-mvebu.o
diff --git a/drivers/pci/controller/pcie-cadence-ep.c b/drivers/pci/controller/pcie-cadence-ep.c
index def7820..1c173da 100644
--- a/drivers/pci/controller/pcie-cadence-ep.c
+++ b/drivers/pci/controller/pcie-cadence-ep.c
@@ -17,35 +17,6 @@
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_NONE		0x1
 #define CDNS_PCIE_EP_IRQ_PCI_ADDR_LEGACY	0x3
 
-/**
- * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
- * @pcie: Cadence PCIe controller
- * @max_regions: maximum number of regions supported by hardware
- * @ob_region_map: bitmask of mapped outbound regions
- * @ob_addr: base addresses in the AXI bus where the outbound regions start
- * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
- *		   dedicated outbound regions is mapped.
- * @irq_cpu_addr: base address in the CPU space where a write access triggers
- *		  the sending of a memory write (MSI) / normal message (legacy
- *		  IRQ) TLP through the PCIe bus.
- * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
- *		  dedicated outbound region.
- * @irq_pci_fn: the latest PCI function that has updated the mapping of
- *		the MSI/legacy IRQ dedicated outbound region.
- * @irq_pending: bitmask of asserted legacy IRQs.
- */
-struct cdns_pcie_ep {
-	struct cdns_pcie		pcie;
-	u32				max_regions;
-	unsigned long			ob_region_map;
-	phys_addr_t			*ob_addr;
-	phys_addr_t			irq_phys_addr;
-	void __iomem			*irq_cpu_addr;
-	u64				irq_pci_addr;
-	u8				irq_pci_fn;
-	u8				irq_pending;
-};
-
 static int cdns_pcie_ep_write_header(struct pci_epc *epc, u8 fn,
 				     struct pci_epf_header *hdr)
 {
@@ -424,28 +395,17 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
 	.get_features	= cdns_pcie_ep_get_features,
 };
 
-static const struct of_device_id cdns_pcie_ep_of_match[] = {
-	{ .compatible = "cdns,cdns-pcie-ep" },
-
-	{ },
-};
 
-static int cdns_pcie_ep_probe(struct platform_device *pdev)
+int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = ep->pcie.dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	struct cdns_pcie_ep *ep;
-	struct cdns_pcie *pcie;
-	struct pci_epc *epc;
+	struct cdns_pcie *pcie = &ep->pcie;
 	struct resource *res;
+	struct pci_epc *epc;
 	int ret;
-	int phy_count;
-
-	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
-	if (!ep)
-		return -ENOMEM;
 
-	pcie = &ep->pcie;
 	pcie->is_rc = false;
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
@@ -474,19 +434,6 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 	if (!ep->ob_addr)
 		return -ENOMEM;
 
-	ret = cdns_pcie_init_phy(dev, pcie);
-	if (ret) {
-		dev_err(dev, "failed to init phy\n");
-		return ret;
-	}
-	platform_set_drvdata(pdev, pcie);
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		goto err_get_sync;
-	}
-
 	/* Disable all but function 0 (anyway BIT(0) is hardwired to 1). */
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, BIT(0));
 
@@ -528,38 +475,5 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
  err_init:
 	pm_runtime_put_sync(dev);
 
- err_get_sync:
-	pm_runtime_disable(dev);
-	cdns_pcie_disable_phy(pcie);
-	phy_count = pcie->phy_count;
-	while (phy_count--)
-		device_link_del(pcie->link[phy_count]);
-
 	return ret;
 }
-
-static void cdns_pcie_ep_shutdown(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct cdns_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_put_sync(dev);
-	if (ret < 0)
-		dev_dbg(dev, "pm_runtime_put_sync failed\n");
-
-	pm_runtime_disable(dev);
-
-	cdns_pcie_disable_phy(pcie);
-}
-
-static struct platform_driver cdns_pcie_ep_driver = {
-	.driver = {
-		.name = "cdns-pcie-ep",
-		.of_match_table = cdns_pcie_ep_of_match,
-		.pm	= &cdns_pcie_pm_ops,
-	},
-	.probe = cdns_pcie_ep_probe,
-	.shutdown = cdns_pcie_ep_shutdown,
-};
-builtin_platform_driver(cdns_pcie_ep_driver);
diff --git a/drivers/pci/controller/pcie-cadence-host.c b/drivers/pci/controller/pcie-cadence-host.c
index 97e2510..5081908 100644
--- a/drivers/pci/controller/pcie-cadence-host.c
+++ b/drivers/pci/controller/pcie-cadence-host.c
@@ -11,33 +11,6 @@
 
 #include "pcie-cadence.h"
 
-/**
- * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
- * @pcie: Cadence PCIe controller
- * @dev: pointer to PCIe device
- * @cfg_res: start/end offsets in the physical system memory to map PCI
- *           configuration space accesses
- * @bus_range: first/last buses behind the PCIe host controller
- * @cfg_base: IO mapped window to access the PCI configuration space of a
- *            single function at a time
- * @max_regions: maximum number of regions supported by the hardware
- * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
- *                translation (nbits sets into the "no BAR match" register)
- * @vendor_id: PCI vendor ID
- * @device_id: PCI device ID
- */
-struct cdns_pcie_rc {
-	struct cdns_pcie	pcie;
-	struct device		*dev;
-	struct resource		*cfg_res;
-	struct resource		*bus_range;
-	void __iomem		*cfg_base;
-	u32			max_regions;
-	u32			no_bar_nbits;
-	u16			vendor_id;
-	u16			device_id;
-};
-
 static void __iomem *cdns_pci_map_bus(struct pci_bus *bus, unsigned int devfn,
 				      int where)
 {
@@ -92,11 +65,6 @@ static struct pci_ops cdns_pcie_host_ops = {
 	.write		= pci_generic_config_write,
 };
 
-static const struct of_device_id cdns_pcie_host_of_match[] = {
-	{ .compatible = "cdns,cdns-pcie-host" },
-
-	{ },
-};
 
 static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 {
@@ -136,10 +104,10 @@ static int cdns_pcie_host_init_root_port(struct cdns_pcie_rc *rc)
 static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
 {
 	struct cdns_pcie *pcie = &rc->pcie;
-	struct resource *cfg_res = rc->cfg_res;
 	struct resource *mem_res = pcie->mem_res;
 	struct resource *bus_range = rc->bus_range;
-	struct device *dev = rc->dev;
+	struct resource *cfg_res = rc->cfg_res;
+	struct device *dev = pcie->dev;
 	struct device_node *np = dev->of_node;
 	struct of_pci_range_parser parser;
 	struct of_pci_range range;
@@ -233,27 +201,22 @@ static int cdns_pcie_host_init(struct device *dev,
 	return err;
 }
 
-static int cdns_pcie_host_probe(struct platform_device *pdev)
+int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = rc->pcie.dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct list_head resources;
-	struct cdns_pcie_rc *rc;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
-	int phy_count;
 
-	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+	bridge = pci_host_bridge_from_priv(rc);
 	if (!bridge)
 		return -ENOMEM;
 
-	rc = pci_host_bridge_priv(bridge);
-	rc->dev = dev;
-
 	pcie = &rc->pcie;
-	pcie->is_rc = true;
 
 	rc->max_regions = 32;
 	of_property_read_u32(np, "cdns,max-outbound-regions", &rc->max_regions);
@@ -287,21 +250,8 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		dev_err(dev, "missing \"mem\"\n");
 		return -EINVAL;
 	}
-	pcie->mem_res = res;
 
-	ret = cdns_pcie_init_phy(dev, pcie);
-	if (ret) {
-		dev_err(dev, "failed to init phy\n");
-		return ret;
-	}
-	platform_set_drvdata(pdev, pcie);
-
-	pm_runtime_enable(dev);
-	ret = pm_runtime_get_sync(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_get_sync() failed\n");
-		goto err_get_sync;
-	}
+	pcie->mem_res = res;
 
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
@@ -326,37 +276,5 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
  err_init:
 	pm_runtime_put_sync(dev);
 
- err_get_sync:
-	pm_runtime_disable(dev);
-	cdns_pcie_disable_phy(pcie);
-	phy_count = pcie->phy_count;
-	while (phy_count--)
-		device_link_del(pcie->link[phy_count]);
-
 	return ret;
 }
-
-static void cdns_pcie_shutdown(struct platform_device *pdev)
-{
-	struct device *dev = &pdev->dev;
-	struct cdns_pcie *pcie = dev_get_drvdata(dev);
-	int ret;
-
-	ret = pm_runtime_put_sync(dev);
-	if (ret < 0)
-		dev_dbg(dev, "pm_runtime_put_sync failed\n");
-
-	pm_runtime_disable(dev);
-	cdns_pcie_disable_phy(pcie);
-}
-
-static struct platform_driver cdns_pcie_host_driver = {
-	.driver = {
-		.name = "cdns-pcie-host",
-		.of_match_table = cdns_pcie_host_of_match,
-		.pm	= &cdns_pcie_pm_ops,
-	},
-	.probe = cdns_pcie_host_probe,
-	.shutdown = cdns_pcie_shutdown,
-};
-builtin_platform_driver(cdns_pcie_host_driver);
diff --git a/drivers/pci/controller/pcie-cadence-plat.c b/drivers/pci/controller/pcie-cadence-plat.c
new file mode 100644
index 0000000..f5c6bf6
--- /dev/null
+++ b/drivers/pci/controller/pcie-cadence-plat.c
@@ -0,0 +1,174 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Cadence PCIe platform  driver.
+ *
+ * Copyright (c) 2019, Cadence Design Systems
+ * Author: Tom Joseph <tjoseph@cadence.com>
+ */
+#include <linux/kernel.h>
+#include <linux/of_address.h>
+#include <linux/of_pci.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/of_device.h>
+#include "pcie-cadence.h"
+
+/**
+ * struct cdns_plat_pcie - private data for this PCIe platform driver
+ * @pcie: Cadence PCIe controller
+ * @is_rc: Set to 1 indicates the PCIe controller mode is Root Complex,
+ *         if 0 it is in Endpoint mode.
+ */
+struct cdns_plat_pcie {
+	struct cdns_pcie        *pcie;
+	bool is_rc;
+};
+
+struct cdns_plat_pcie_of_data {
+	bool is_rc;
+};
+
+static const struct of_device_id cdns_plat_pcie_of_match[];
+
+static int cdns_plat_pcie_probe(struct platform_device *pdev)
+{
+	const struct cdns_plat_pcie_of_data *data;
+	struct cdns_plat_pcie *cdns_plat_pcie;
+	const struct of_device_id *match;
+	struct device *dev = &pdev->dev;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie_ep *ep;
+	struct cdns_pcie_rc *rc;
+	int phy_count;
+	bool is_rc;
+	int ret;
+
+	match = of_match_device(cdns_plat_pcie_of_match, dev);
+	if (!match)
+		return -EINVAL;
+
+	data = (struct cdns_plat_pcie_of_data *)match->data;
+	is_rc = data->is_rc;
+
+	pr_debug(" Started %s with is_rc: %d\n", __func__, is_rc);
+	cdns_plat_pcie = devm_kzalloc(dev, sizeof(*cdns_plat_pcie), GFP_KERNEL);
+	if (!cdns_plat_pcie)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, cdns_plat_pcie);
+	if (is_rc) {
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_HOST))
+			return -ENODEV;
+
+		bridge = devm_pci_alloc_host_bridge(dev, sizeof(*rc));
+		if (!bridge)
+			return -ENOMEM;
+
+		rc = pci_host_bridge_priv(bridge);
+		rc->pcie.dev = dev;
+		cdns_plat_pcie->pcie = &rc->pcie;
+		cdns_plat_pcie->is_rc = is_rc;
+
+		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		if (ret) {
+			dev_err(dev, "failed to init phy\n");
+			return ret;
+		}
+		pm_runtime_enable(dev);
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			dev_err(dev, "pm_runtime_get_sync() failed\n");
+			goto err_get_sync;
+		}
+
+		ret = cdns_pcie_host_setup(rc);
+		if (ret)
+			goto err_init;
+	} else {
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
+			return -ENODEV;
+
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+
+		ep->pcie.dev = dev;
+		cdns_plat_pcie->pcie = &ep->pcie;
+		cdns_plat_pcie->is_rc = is_rc;
+
+		ret = cdns_pcie_init_phy(dev, cdns_plat_pcie->pcie);
+		if (ret) {
+			dev_err(dev, "failed to init phy\n");
+			return ret;
+		}
+
+		pm_runtime_enable(dev);
+		ret = pm_runtime_get_sync(dev);
+		if (ret < 0) {
+			dev_err(dev, "pm_runtime_get_sync() failed\n");
+			goto err_get_sync;
+		}
+
+		ret = cdns_pcie_ep_setup(ep);
+		if (ret)
+			goto err_init;
+	}
+
+ err_init:
+	pm_runtime_put_sync(dev);
+
+ err_get_sync:
+	pm_runtime_disable(dev);
+	cdns_pcie_disable_phy(cdns_plat_pcie->pcie);
+	phy_count = cdns_plat_pcie->pcie->phy_count;
+	while (phy_count--)
+		device_link_del(cdns_plat_pcie->pcie->link[phy_count]);
+
+	return 0;
+}
+
+static void cdns_plat_pcie_shutdown(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_pcie *pcie = dev_get_drvdata(dev);
+	int ret;
+
+	ret = pm_runtime_put_sync(dev);
+	if (ret < 0)
+		dev_dbg(dev, "pm_runtime_put_sync failed\n");
+
+	pm_runtime_disable(dev);
+
+	cdns_pcie_disable_phy(pcie);
+}
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_host_of_data = {
+	.is_rc = true,
+};
+
+static const struct cdns_plat_pcie_of_data cdns_plat_pcie_ep_of_data = {
+	.is_rc = false,
+};
+
+static const struct of_device_id cdns_plat_pcie_of_match[] = {
+	{
+		.compatible = "cdns,cdns-pcie-host",
+		.data = &cdns_plat_pcie_host_of_data,
+	},
+	{
+		.compatible = "cdns,cdns-pcie-ep",
+		.data = &cdns_plat_pcie_ep_of_data,
+	},
+	{},
+};
+
+static struct platform_driver cdns_plat_pcie_driver = {
+	.driver = {
+		.name = "cdns-pcie",
+		.of_match_table = cdns_plat_pcie_of_match,
+		.pm	= &cdns_pcie_pm_ops,
+	},
+	.probe = cdns_plat_pcie_probe,
+	.shutdown = cdns_plat_pcie_shutdown,
+};
+builtin_platform_driver(cdns_plat_pcie_driver);
diff --git a/drivers/pci/controller/pcie-cadence.h b/drivers/pci/controller/pcie-cadence.h
index ae6bf2a..62e9dcd 100644
--- a/drivers/pci/controller/pcie-cadence.h
+++ b/drivers/pci/controller/pcie-cadence.h
@@ -190,6 +190,8 @@ enum cdns_pcie_rp_bar {
 	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
 #define CDNS_PCIE_MSG_NO_DATA			BIT(16)
 
+struct cdns_pcie;
+
 enum cdns_pcie_msg_code {
 	MSG_CODE_ASSERT_INTA	= 0x20,
 	MSG_CODE_ASSERT_INTB	= 0x21,
@@ -221,6 +223,11 @@ enum cdns_pcie_msg_routing {
 	MSG_ROUTING_GATHER,
 };
 
+
+struct cdns_pcie_common_ops {
+	int	(*cdns_start_link)(struct cdns_pcie *pcie, bool start);
+	bool	(*cdns_is_link_up)(struct cdns_pcie *pcie);
+};
 /**
  * struct cdns_pcie - private data for Cadence PCIe controller drivers
  * @reg_base: IO mapped register base
@@ -231,13 +238,71 @@ enum cdns_pcie_msg_routing {
 struct cdns_pcie {
 	void __iomem		*reg_base;
 	struct resource		*mem_res;
+	struct device		*dev;
 	bool			is_rc;
 	u8			bus;
 	int			phy_count;
 	struct phy		**phy;
 	struct device_link	**link;
+	const struct cdns_pcie_common_ops *ops;
 };
 
+/**
+ * struct cdns_pcie_rc - private data for this PCIe Root Complex driver
+ * @pcie: Cadence PCIe controller
+ * @dev: pointer to PCIe device
+ * @cfg_res: start/end offsets in the physical system memory to map PCI
+ *           configuration space accesses
+ * @bus_range: first/last buses behind the PCIe host controller
+ * @cfg_base: IO mapped window to access the PCI configuration space of a
+ *            single function at a time
+ * @max_regions: maximum number of regions supported by the hardware
+ * @no_bar_nbits: Number of bits to keep for inbound (PCIe -> CPU) address
+ *                translation (nbits sets into the "no BAR match" register)
+ * @vendor_id: PCI vendor ID
+ * @device_id: PCI device ID
+ */
+struct cdns_pcie_rc {
+	struct cdns_pcie	pcie;
+	struct resource		*cfg_res;
+	struct resource		*bus_range;
+	void __iomem		*cfg_base;
+	u32			max_regions;
+	u32			no_bar_nbits;
+	u16			vendor_id;
+	u16			device_id;
+};
+
+/**
+ * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
+ * @pcie: Cadence PCIe controller
+ * @max_regions: maximum number of regions supported by hardware
+ * @ob_region_map: bitmask of mapped outbound regions
+ * @ob_addr: base addresses in the AXI bus where the outbound regions start
+ * @irq_phys_addr: base address on the AXI bus where the MSI/legacy IRQ
+ *		   dedicated outbound regions is mapped.
+ * @irq_cpu_addr: base address in the CPU space where a write access triggers
+ *		  the sending of a memory write (MSI) / normal message (legacy
+ *		  IRQ) TLP through the PCIe bus.
+ * @irq_pci_addr: used to save the current mapping of the MSI/legacy IRQ
+ *		  dedicated outbound region.
+ * @irq_pci_fn: the latest PCI function that has updated the mapping of
+ *		the MSI/legacy IRQ dedicated outbound region.
+ * @irq_pending: bitmask of asserted legacy IRQs.
+ */
+struct cdns_pcie_ep {
+	struct cdns_pcie	pcie;
+	u32			max_regions;
+	unsigned long		ob_region_map;
+	phys_addr_t		*ob_addr;
+	phys_addr_t		irq_phys_addr;
+	void __iomem		*irq_cpu_addr;
+	u64			irq_pci_addr;
+	u8			irq_pci_fn;
+	u8			irq_pending;
+};
+
+
 /* Register access */
 static inline void cdns_pcie_writeb(struct cdns_pcie *pcie, u32 reg, u8 value)
 {
@@ -306,6 +371,23 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
 
+#ifdef CONFIG_PCIE_CADENCE_HOST
+int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
+#else
+static inline int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
+{
+	return 0;
+}
+#endif
+
+#ifdef CONFIG_PCIE_CADENCE_EP
+int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
+#else
+static inline int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
+{
+	return 0;
+}
+#endif
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
-- 
2.2.2

