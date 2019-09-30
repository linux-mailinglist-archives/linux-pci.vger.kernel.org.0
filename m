Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9497C255C
	for <lists+linux-pci@lfdr.de>; Mon, 30 Sep 2019 18:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732367AbfI3Qni (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Sep 2019 12:43:38 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:18268 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727767AbfI3Qnh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Sep 2019 12:43:37 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id x8UGVj4b024727;
        Mon, 30 Sep 2019 09:43:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=IoxuLupymjxSF+rMFb4PPIJrfPfjVt2Hgwkbn0wcaww=;
 b=KRANxh+F6r+JeCM68kg5W4puu7zUjAdSjkkOtSCTLHwIW26dVMZ3A1WNXiroBsPJzGT7
 PcwNJxkFepi6OdIWpatdrV4MC1folH4lwQ61EvPKHaQo3o53hUp6znFMD1q74G1vp5tx
 6ByO1ZuP47l5uacOR36eozl+tEB4Y7sZBZISY2umH+vaN/YHfViy+Yhqyd3Vi6+c4keq
 xHVOfDSVgESyYTMvNnjiLqfgaRNXvSFM5jr+hARVB88TPToEF5+1yqDtdG57M2rddR+K
 ixyE5718hw2oEeJZuueONFDRjg6DAeY6Dz8HDHdsVV2GELehaELPudcK6DDf8nV0TSTv PQ== 
Received: from nam05-co1-obe.outbound.protection.outlook.com (mail-co1nam05lp2058.outbound.protection.outlook.com [104.47.48.58])
        by mx0a-0014ca01.pphosted.com with ESMTP id 2va4337ma7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Mon, 30 Sep 2019 09:43:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUfSG/7qxF4EZZBSzc3E5jRDtgOvuzmZP73Or13s9Yb+PFzwpO4Kp/0Q3lzgdL90iy5HH8/c5CLNNU7ZnZ95I8VrNabtPDAXIDR17dES6PBBbYekuub+q75vS/+32BuwNtrYr+PBPLlMpCKA8YXtGpVC5Ni5xAjawdGsvoBCe7mlk2jTDF7DvAEOOj03VYckcFf8erTh8/bzNqdE5/m33bJg7E9ZOaVO4CXd7Q8q0Hi1yQDasV/nsTqU/q/PUZvGbfjvaWJ2QfrLb2ep0HDV5DnzpFokY6QyW2vgU4BfYYuknnnOwfVKqx68Uxl0Mlf4JsnFf33y3VEPSWKjGi2Igg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoxuLupymjxSF+rMFb4PPIJrfPfjVt2Hgwkbn0wcaww=;
 b=FL+SCQdqfPJFYDp+LoI2cMso9zTlEErB+J/x6seyK6ZXQ4BvThxAUBidLfZdp7jbrVveXHrP5O7RI5UAp1NKR3JHj7154R+6tIYAn7BK0a8pAVEVobmYQRE3eMiL+m9gtSPlj6FmeAeds2LWGOZm7ySIbNLF/6RLXc9DN2NszAuSNPSA358+8ZUW73rKrHu2Vx/5m+ZIX113Azt72F/Ys9IcIiDmCmd68rFnYBKWBuGWX7QJ/Za3B8LFcupLl+oo1dqZJR57oj6WpUp0uimwbmloMEoGebjqZ6TEWsjXbXOArQ7+YezKzG80f0Ih0wXtWWKJIV17tAnlM0nUpsU+BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 158.140.1.28) smtp.rcpttodomain=arm.com smtp.mailfrom=cadence.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IoxuLupymjxSF+rMFb4PPIJrfPfjVt2Hgwkbn0wcaww=;
 b=jlK7c4k3LGn3vrKAt3k3JbTUKKQ1323kk9PxlGFjNA6VKklK0oawFw3riRJ/8F2btT/UC7CaGqCOhM83sx7vAHYJQ9kSKA/ql76E9dK3uyLbOkZ634jeTOA6nfLZTJ4FlRpVM6ocMnH9WyyoHW4zXIZ7WxZqBZKilpZvXtxSvoI=
Received: from BYAPR07CA0052.namprd07.prod.outlook.com (2603:10b6:a03:60::29)
 by CY4PR07MB3526.namprd07.prod.outlook.com (2603:10b6:910:75::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2284.20; Mon, 30 Sep
 2019 16:43:23 +0000
Received: from CO1NAM05FT058.eop-nam05.prod.protection.outlook.com
 (2a01:111:f400:7e50::203) by BYAPR07CA0052.outlook.office365.com
 (2603:10b6:a03:60::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2178.19 via Frontend
 Transport; Mon, 30 Sep 2019 16:43:22 +0000
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 cadence.com discourages use of 158.140.1.28 as permitted sender)
Received: from sjmaillnx1.cadence.com (158.140.1.28) by
 CO1NAM05FT058.mail.protection.outlook.com (10.152.96.176) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.2327.7 via Frontend Transport; Mon, 30 Sep 2019 16:43:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id x8UGhJ0v020518
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 30 Sep 2019 09:43:20 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Sep 2019 18:43:18 +0200
Received: from lvlogina.cadence.com (10.165.176.102) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Sep 2019 18:43:18 +0200
Received: from lvlogina.cadence.com (localhost.localdomain [127.0.0.1])
        by lvlogina.cadence.com (8.14.4/8.14.4) with ESMTP id x8UGhIcj010645;
        Mon, 30 Sep 2019 17:43:18 +0100
Received: (from tjoseph@localhost)
        by lvlogina.cadence.com (8.14.4/8.14.4/Submit) id x8UGhHIW010639;
        Mon, 30 Sep 2019 17:43:17 +0100
From:   Tom Joseph <tjoseph@cadence.com>
To:     <linux-pci@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, Tom Joseph <tjoseph@cadence.com>
Subject: [PATCH] PCI:cadence:Driver refactored to use as a core library.
Date:   Mon, 30 Sep 2019 17:42:48 +0100
Message-ID: <1569861768-10109-1-git-send-email-tjoseph@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:158.140.1.28;IPV:CAL;SCL:-1;CTRY:US;EFV:NLI;SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(36092001)(199004)(189003)(26005)(30864003)(186003)(8676002)(6666004)(305945005)(5660300002)(51416003)(76130400001)(8936002)(4326008)(70206006)(70586007)(47776003)(7636002)(54906003)(2351001)(16586007)(107886003)(86362001)(50226002)(42186006)(50466002)(6916009)(36756003)(316002)(356004)(486006)(14444005)(26826003)(2616005)(426003)(478600001)(336012)(2906002)(476003)(87636003)(126002)(48376002)(246002);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR07MB3526;H:sjmaillnx1.cadence.com;FPR:;SPF:SoftFail;LANG:en;PTR:corp.cadence.com;A:1;MX:1;
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 69149b48-4ebf-442b-4626-08d745c54ea2
X-Microsoft-Antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328);SRVR:CY4PR07MB3526;
X-MS-TrafficTypeDiagnostic: CY4PR07MB3526:
X-Microsoft-Antispam-PRVS: <CY4PR07MB3526B4260EC414016BC66E7DA1820@CY4PR07MB3526.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-Forefront-PRVS: 01762B0D64
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Message-Info: pvgOp6+mHmA1RFiY9jko3pODPyz+2NAr/Gaq9/H9Qaf73kZaJN3PIakjKUk7DtxnpWMjTk8rWwlhtt8quFwnZDC8QCa59hgvRFcFTL7jtPHw3Tl2jQ83AwhNJDCuebdTqz9dPj7xsbpNJp9hTJ0sAwlTQAsif9JSQp5T6u78tQYh9BlH6S9vrO4NCvcbeY++XvV3MAf4flaOIdrSEjOGyantsEy7wmdtsK1xdiwnRPNBvmKQvHpvp7gQVY4bpS1tJlRPEQC0HNcEv89hI8gvobBfDQH7jfCvlN85k8suVCxqwqu66ugO81ixXU3H1ZgakxJULUHZxliEGFZ0ohNpru1PtcyppvDpr2hoFh3O/f7z5fv+yTCt8T+2xb91SNcVXj5rZaib0I+RhHNtmxqEkMxB4PEKhuJqiT834kr1TB8=
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2019 16:43:22.5435
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69149b48-4ebf-442b-4626-08d745c54ea2
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.28];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR07MB3526
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,1.0.8
 definitions=2019-09-30_10:2019-09-30,2019-09-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 spamscore=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 suspectscore=1 impostorscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1908290000 definitions=main-1909300160
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All the platform related APIs/Structures in the driver has been extracted
 out to a separate file (pcie-cadence-plat.c). This will enable the
 driver to be used as a core library, which could be used by other
 platform drivers.Testing was done using simulation environment.

Signed-off-by: Tom Joseph <tjoseph@cadence.com>
---
 drivers/pci/controller/Kconfig             |  35 +++++++
 drivers/pci/controller/Makefile            |   1 +
 drivers/pci/controller/pcie-cadence-ep.c   |  78 ++-------------
 drivers/pci/controller/pcie-cadence-host.c |  77 +++------------
 drivers/pci/controller/pcie-cadence-plat.c | 154 +++++++++++++++++++++++++++++
 drivers/pci/controller/pcie-cadence.h      |  69 +++++++++++++
 6 files changed, 278 insertions(+), 136 deletions(-)
 create mode 100644 drivers/pci/controller/pcie-cadence-plat.c

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index fe9f9f1..c175b21 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -48,6 +48,41 @@ config PCIE_CADENCE_EP
 	  endpoint mode. This PCIe controller may be embedded into many
 	  different vendors SoCs.
 
+config PCIE_CADENCE_PLAT
+	bool "Cadence PCIe endpoint controller"
+	depends on OF
+	depends on PCI_ENDPOINT
+	select PCIE_CADENCE
+	help
+	  Say Y here if you want to support the Cadence PCIe  controller in
+	  endpoint mode. This PCIe controller may be embedded into many
+	  different vendors SoCs.
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
index def7820..617a71f 100644
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
@@ -396,6 +367,9 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
 		cfg |= BIT(epf->func_no);
 	cdns_pcie_writel(pcie, CDNS_PCIE_LM_EP_FUNC_CFG, cfg);
 
+	if (pcie->ops->cdns_start_link)
+		return  pcie->ops->cdns_start_link(pcie, true);
+
 	return 0;
 }
 
@@ -424,30 +398,18 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
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
+	struct device *dev = ep->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	struct cdns_pcie_ep *ep;
-	struct cdns_pcie *pcie;
+	struct cdns_pcie *pcie = &ep->pcie;
 	struct pci_epc *epc;
 	struct resource *res;
 	int ret;
 	int phy_count;
 
-	ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
-	if (!ep)
-		return -ENOMEM;
-
-	pcie = &ep->pcie;
-	pcie->is_rc = false;
-
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "reg");
 	pcie->reg_base = devm_ioremap_resource(dev, res);
 	if (IS_ERR(pcie->reg_base)) {
@@ -537,29 +499,3 @@ static int cdns_pcie_ep_probe(struct platform_device *pdev)
 
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
index 97e2510..55c2085 100644
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
@@ -233,27 +201,23 @@ static int cdns_pcie_host_init(struct device *dev,
 	return err;
 }
 
-static int cdns_pcie_host_probe(struct platform_device *pdev)
+int cdns_pcie_host_setup(struct cdns_pcie_rc *rc)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = rc->dev;
+	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
 	struct pci_host_bridge *bridge;
 	struct list_head resources;
-	struct cdns_pcie_rc *rc;
 	struct cdns_pcie *pcie;
 	struct resource *res;
 	int ret;
 	int phy_count;
 
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
@@ -303,6 +267,14 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 		goto err_get_sync;
 	}
 
+	if (pcie->ops->cdns_start_link) {
+		ret =  pcie->ops->cdns_start_link(pcie, true);
+		if (ret) {
+			dev_err(dev, "Failed to start link\n");
+			return ret;
+		}
+	}
+
 	ret = cdns_pcie_host_init(dev, &resources, rc);
 	if (ret)
 		goto err_init;
@@ -335,28 +307,3 @@ static int cdns_pcie_host_probe(struct platform_device *pdev)
 
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
index 0000000..274615d
--- /dev/null
+++ b/drivers/pci/controller/pcie-cadence-plat.c
@@ -0,0 +1,154 @@
+// SPDX-License-Identifier: GPL-2.0
+// Copyright (c) 2019 Cadence
+// Cadence PCIe platform  driver.
+// Author: Tom Joseph <tjoseph@cadence.com>
+
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
+ * @regmap: pointer to PCIe device
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
+int cdns_plat_pcie_link_control(struct cdns_pcie *pcie, bool start)
+{
+	pr_debug(" %s called\n", __func__);
+	return 0;
+}
+
+bool cdns_plat_pcie_link_status(struct cdns_pcie *pcie)
+{
+	pr_debug(" %s called\n", __func__);
+	return 0;
+}
+
+static const struct cdns_pcie_common_ops cdns_pcie_common_ops = {
+	.cdns_start_link = cdns_plat_pcie_link_control,
+	.cdns_is_link_up = cdns_plat_pcie_link_status,
+};
+
+static int cdns_plat_pcie_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct cdns_plat_pcie *cdns_plat_pcie;
+	const struct of_device_id *match;
+	const struct cdns_plat_pcie_of_data *data;
+	struct pci_host_bridge *bridge;
+	struct cdns_pcie_rc *rc;
+	struct cdns_pcie_ep *ep;
+	int ret;
+	bool is_rc;
+
+	match = of_match_device(cdns_plat_pcie_of_match, dev);
+	if (!match)
+		return -EINVAL;
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
+		rc->dev = dev;
+		rc->pcie.ops = &cdns_pcie_common_ops;
+		cdns_plat_pcie->pcie = &rc->pcie;
+		cdns_plat_pcie->is_rc = is_rc;
+
+		ret = cdns_pcie_host_setup(rc);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (!IS_ENABLED(CONFIG_PCIE_CADENCE_PLAT_EP))
+			return -ENODEV;
+
+		ep = devm_kzalloc(dev, sizeof(*ep), GFP_KERNEL);
+		if (!ep)
+			return -ENOMEM;
+		ep->dev = dev;
+		ep->pcie.ops = &cdns_pcie_common_ops;
+		cdns_plat_pcie->pcie = &ep->pcie;
+		cdns_plat_pcie->is_rc = is_rc;
+
+		ret = cdns_pcie_ep_setup(ep);
+		if (ret < 0)
+			return ret;
+	}
+	return 0;
+}
+
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
index ae6bf2a..3df902a 100644
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
@@ -236,8 +243,67 @@ struct cdns_pcie {
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
+	struct device		*dev;
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
+	struct device		*dev;
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
@@ -306,6 +372,9 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
 	return readl(pcie->reg_base + CDNS_PCIE_EP_FUNC_BASE(fn) + reg);
 }
 
+int cdns_pcie_host_setup(struct cdns_pcie_rc *rc);
+int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep);
+
 void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 fn,
 				   u32 r, bool is_io,
 				   u64 cpu_addr, u64 pci_addr, size_t size);
-- 
2.2.2

