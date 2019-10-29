Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA796E8768
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 12:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727681AbfJ2LqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 07:46:09 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:29074 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727498AbfJ2LqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Oct 2019 07:46:09 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x9TBTNvf031757;
        Tue, 29 Oct 2019 04:45:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=6B2BayCcTyj/NogkNTRe5bZD9OP+TkNum3IrGRvVh7Q=;
 b=FRkKf3pLFvHxCr5S63qmBhlfZjBXJaY+NK5wyCIdCG8l/O6U7JIznnQUmeMpzyV9TXN9
 WubQ2L1K2FC2ST1iXwF0BXvLOI5AAgqSsV17WX8ck2zDQEpBanLlW6Em1zkZPZYD4Dj8
 7HZEywQjGJ/Vvd1DQbD6aoxEq8e4lq6LJIhJRvXTPIQaxKuvvX3QZ9UF6EGUwuCX6r/E
 9ZsUMeTJcq0wP55N4yF9U7fGspNYCW2PrYuna6oAV3ZFCExz+7DV1tN664ulUd32Bgv9
 f9j6h7Z/vAd2KzA6D5NuAQYrzRWN6u6gZOzo5+RvNCrGfMfk+VSgtQiYs9/A3eyIPlvq Nw== 
Received: from nam03-co1-obe.outbound.protection.outlook.com (mail-co1nam03lp2057.outbound.protection.outlook.com [104.47.40.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 2vvhqx9ma8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 29 Oct 2019 04:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k5pHQ5CkTK5e7Wa4eJzabgMDbkt+t8EmxMi7639LoLrab9sl1D6C2Nthf/SHMS3W0Cb35Fe4fR5uPSeiAwxVDHJCNUa3dnhrL3lDnAhtPHIwDozyMNeW1N1fO6AmpQdfjQZitz3c/yFP4+oENpGh4EqqAiqV9qV1hF5yeFZXc/VI8jtNe1XsAoXpvu5uLeVVhBgP+RoXKiVA9Tgodu5kCKFWul3r/u/EG8dEXALWFubRNaJ4T8KEMM36joT3eIXLVf1nSArSHLOt5Spe5l56vV/8g++m9jF1JXtsZhJpe/iGxMc5sXDadmytN6WJPAsY3TPIR/oODLwPmhe1wwYbcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B2BayCcTyj/NogkNTRe5bZD9OP+TkNum3IrGRvVh7Q=;
 b=YsJUHeFLSH95c59/h7qtL51ddpRKPzSEqcgmR+pjat74aIdZ64KxKo+3QUrKDegyFaQlxCKh5t5Z4pmtfSIXhQETFYtrSgQCRe7eh4LwqRneN9CPOnrnhvBbjLqvivAv0/6QD2umnPvIDQzddyBBneSLFrNVtdsme5UmZktxc+utGyeqgSGp0LBgNzK9WLxUxHyDmFeliATGPRWdaJh36HrGLIm4pB+RQF/mO86+qGxTS7+YrVAIAYPrHLPwGe9u1EntbjA1zvGF97a4phd8gwDYLA7Xa8wZFeRVk8aUsH8Sl44UoHLvjqkmZY+gEDJBuVpE35sGsDEQmrJWxDRpwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6B2BayCcTyj/NogkNTRe5bZD9OP+TkNum3IrGRvVh7Q=;
 b=EOsZ39f732nJ9usPB0dEJ5rGrc3cTBmKmrEwkNAx9E6IBnjrachw02uPh/CH+titf8vLmAc8P/XtOZdxk+mDuWEQR4/WEUfY01gTLwNO2my8BUKHamnpYosbL8mtJpeJaHL82/XWXqSbh8Aekb4IfDP/JVHQtZDjmfnl8VKTKmc=
Received: from CH2PR07CA0018.namprd07.prod.outlook.com (2603:10b6:610:20::31)
 by DM6PR07MB4410.namprd07.prod.outlook.com (2603:10b6:5:c0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24; Tue, 29 Oct
 2019 11:45:55 +0000
Received: from DM3NAM05FT026.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e51::201) by CH2PR07CA0018.outlook.office365.com
 (2603:10b6:610:20::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2387.22 via Frontend
 Transport; Tue, 29 Oct 2019 11:45:54 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 DM3NAM05FT026.mail.protection.outlook.com (10.152.98.136) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2387.9 via Frontend Transport; Tue, 29 Oct 2019 11:45:54 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x9TBjpTI023182
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 29 Oct 2019 04:45:53 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Tue, 29 Oct 2019 12:45:52 +0100
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Tue, 29 Oct 2019 12:45:51 +0100
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x9TBjo4p008279;
        Tue, 29 Oct 2019 11:45:50 GMT
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x9TBjoJp008276;
        Tue, 29 Oct 2019 11:45:50 GMT
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH v3 1/2] PCI: cadence: Refactor driver to use as a core library
Date:   Tue, 29 Oct 2019 11:45:11 +0000
Message-ID: <1572349512-7776-2-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
References: <1572349512-7776-1-git-send-email-tjoseph@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(346002)(39860400002)(136003)(396003)(376002)(199004)(189003)(36092001)(486006)(11346002)(446003)(5660300002)(2616005)(8936002)(76176011)(86362001)(54906003)(14444005)(336012)(7636002)(50226002)(70586007)(51416003)(70206006)(305945005)(426003)(36756003)(8676002)(16586007)(316002)(42186006)(2351001)(126002)(476003)(356004)(246002)(6666004)(48376002)(107886003)(30864003)(4326008)(50466002)(47776003)(26005)(76130400001)(186003)(6916009)(26826003)(87636003)(478600001)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR07MB4410;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.Cadence.COM;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c10c398-a4e1-42ec-45b3-08d75c658e6d
X-MS-TrafficTypeDiagnostic: DM6PR07MB4410:
X-Microsoft-Antispam-PRVS: <DM6PR07MB4410CA946D34944B05F646F6A1610@DM6PR07MB4410.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-Forefront-PRVS: 0205EDCD76
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cqIPf2dTO3gyXroYXlru+bsL2qkpZY/PtYDoTmejZJh9Xc8T2RqsBDuOvEn1Y8gtdiYoeX2MQotzoGTbD7qTfCAX42Y8PuljMmhzVVDJPrB9ZLYQAcLqalRiZ0o1mxs+D/l2jkJUieGZLsDvtFH+oWD8slUkYc0sb4a3AVMQNoBX+LZW4DXJcsh7vWPx6F2yQrE16RF6gZQA4/Tvn9FnB/8LG8iQVwWSeOUdxib4dzMoe6fuhyLSVK+eTpPDHYlTpaY2cwCjyHzSEX+hWMr7Ov8ft2Ax1a095uWOPHgaRiIgE/CVblVLndoOT/54EUztFQDMTVpQyTxm4cYcYpXRoawNi93zQusHcxXGpYJeWrMhJbM1nnmBbU2j5NTRG23PtgZgcof8FpS9cQ4p0mHregh5MKDSt3Uqz+QXiM5b5jpb669hAFT+rpH7L+P0JRBj7hqLENbnJKKJQo226JLUZQ==
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2019 11:45:54.5571
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c10c398-a4e1-42ec-45b3-08d75c658e6d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4410
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-10-29_03:2019-10-28,2019-10-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 phishscore=0 malwarescore=0 suspectscore=1 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1910290118
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Cadence PCIe host and endpoint IP may be embedded into a variety of
SoCs/platforms. Let's extract the platform related APIs/Structures in the
current driver to a separate file (pcie-cadence-plat.c), such that the
common functionality can be used by future platforms.

Signed-off-by: Tom Joseph <tjoseph@cadence.com>
---
 drivers/pci/controller/Kconfig             |  31 +++--
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pcie-cadence-ep.c   |  96 +---------------
 drivers/pci/controller/pcie-cadence-host.c |  95 ++--------------
 drivers/pci/controller/pcie-cadence-plat.c | 174 +++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h      |  77 +++++++++++++
 6 files changed, 287 insertions(+), 187 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-cadence-plat.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index fe9f9f1..57d52f6 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -28,23 +28,38 @@ config PCIE_CADENCE
 	bool
 
 config PCIE_CADENCE_HOST
-	bool "Cadence PCIe host controller"
+	bool
 	depends on OF
-	depends on PCI
 	select IRQ_DOMAIN
 	select PCIE_CADENCE
-	help
-	  Say Y here if you want to support the Cadence PCIe controller in host
-	  mode. This PCIe controller may be embedded into many different vendors
-	  SoCs.
 
 config PCIE_CADENCE_EP
-	bool "Cadence PCIe endpoint controller"
+	bool
 	depends on OF
 	depends on PCI_ENDPOINT
 	select PCIE_CADENCE
+
+config PCIE_CADENCE_PLAT
+	bool
+
+config PCIE_CADENCE_PLAT_HOST
+	bool "Cadence PCIe platform host controller"
+	depends on OF
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
+	select PCIE_CADENCE_EP
+	select PCIE_CADENCE_PLAT
 	help
-	  Say Y here if you want to support the Cadence PCIe  controller in
+	  Say Y here if you want to support the Cadence PCIe  platform controller in
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
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
index 97e2510..8a42afd 100644
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
@@ -233,25 +201,21 @@ static int cdns_pcie_host_init(struct device *dev,
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
 	pcie->is_rc = true;
 
@@ -287,21 +251,8 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
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
@@ -326,37 +277,5 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
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
index ae6bf2a..c98e858 100644
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
@@ -231,13 +233,71 @@ enum cdns_pcie_msg_routing {
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
+};
+
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
 };
 
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
@@ -306,6 +366,23 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
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

