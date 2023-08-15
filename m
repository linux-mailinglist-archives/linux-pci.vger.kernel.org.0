Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC5E77D505
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240207AbjHOVVG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 17:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239976AbjHOVVD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 17:21:03 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2076.outbound.protection.outlook.com [40.107.223.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C2C138;
        Tue, 15 Aug 2023 14:21:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RI5+sewwyHAKOzAOMTY+E2ZnpYve/K9hto14YM0ArkLJ9IFiDcokbtXFzZULVjzr9FOoUmi3wcKpriPUiKmYQ6P2slGYNgnJu1zjEdTYACG7n/Mv6cNhCTk43nuNFpdcOOKFut7bOwubdWZYlFw1Ys1E+IRDE30sfUjoBkR2wYdFyyFk+kC91/toKj+pZJg7PHiTjs/0WecLtBF+VcVrUUnFNnP4hJSqG0tJM5YrAk+SNeEgce1UaFpZ+uGzG1bK85HcXCxGRuQpftTgSly4lApnFAgtI/Mv5117EwaJ0lIRYCr06nlfLD5L/E07qYqZCUfAMfhEKEsnWW4HYmOtiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iysh+Fj92oXMw8RV3ptTnLREUUiu7cjK8cLhsTh4V+4=;
 b=l0qTtVTFR8X8eonVWkt0DWXZ+unGAn34XWE0VRS5Rc6QZ28kqc2Jyq374UuSyvgck4Kz/EYiU5htY5bC9QYjlfimQbUsrvoUtCjj5BjyhYLZ2CsGDL8Ix+Pme/SSJeBoVZcNCf4E+bID6h5W+6INNYhLngpFTSDwDidQyX4BSk/LwiZpckyT3n7fbjkZa5M5NDX53WVVeI9SIZr9hM/Axa0uHaGOpyofuKFi9P0K8eUicSNn4PgUHGrOBZdkKZFKLuThpEg+AURwejSEjDHz5WbB0Aa8gDBI+J4Gc74RA6JrKV3W9cM41xO1lxzOH8fAenT2ZD1MlhLj/K75BpAXaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iysh+Fj92oXMw8RV3ptTnLREUUiu7cjK8cLhsTh4V+4=;
 b=DHX7mNK6O9gE6gZAtdFfaYfZftDF30KA3IRoIcSKNVGYFjoVZkf5BPdrU6UUVDrhrrLA29K3A6MH3RWKHh/Tn9IGPdcoRu2ozsCQRFmC+Fn191XKTSPiNoZyvODCzcLZXF2hZjqB8Fv4z7MrnTYvJHlLIHbQoyvxellodpedT1k=
Received: from MW4PR03CA0028.namprd03.prod.outlook.com (2603:10b6:303:8f::33)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:20:59 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::da) by MW4PR03CA0028.outlook.office365.com
 (2603:10b6:303:8f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 21:20:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 21:20:58 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 16:20:57 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 1/3] PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
Date:   Tue, 15 Aug 2023 21:20:41 +0000
Message-ID: <20230815212043.114913-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230815212043.114913-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: dab1509d-8dfe-4f6a-db48-08db9dd584e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Q8rE17DHwavh4jbTbOGsHf6fB852nWRVFUZRJ1OnuT5Apm0t3tsWlTzvnygJ5XYDlePqhHvIBie69OTc/NMklWrJM3ONUqR5+cL//iDuHr+WcJ8jOdYxFEOc/gbDgaB4NIZISNgv7G96kW7dMqsvJ+EOuFqc0E7VXIbhGNTHBxErzc41XagB5Jm0KQykyNXLBx09HshtOiv8vZhUF/1SOYsGkqIOX6MbzuTPCwxFghXY4Vk37joKS8wlHms1wNALLEgM2C8kABpRNEhgDR129TiIn6JW2Sj9JKwNSaQl+cwHCD8vXV8E6dTXhgmhMd6H+ysc5fvCpGnpqvNd6pMHgwZEkrmcUhZkgVfOySf4DRZGtpLb0/hf87Z8C6EZq72FN+TiR2w/imjR8Em3J2UUD/6G5VyaMAkRP+bvoldb+YQ7ZZID3HMnERsTNPeYXrEfwLGLBmQUVYg+tEZY8wOzRt0hToFUm6CwQE8qQvf7R2at6/YqBlJXVxQr89gLF6Z3Q1ZHtt6Sw5BySl2WPP9GKCrtsYGIEU70bfJjoe7fT5dkWGMo+c+qVOmcyikGzHGtg7p2aVYuno88gesxK7ijRm1RmoB/iWbgJNUsCgBS1DgNQyiCRCAlNFWtNiY0KlsoM3fR1Lv+opIh5jwhKLsvIaZnrtx+2DecIRcN5xznm0ubjOAjwKJjG/Xqc2kJp9DtSHv/TpnLT8zJP9rHHbRu94dvhkhf71cu+m5evq4uGWoiaZLqOV/DV37Za9zEfk2Zwze5xGLuevw3T281yzaxdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(46966006)(40470700004)(36756003)(110136005)(54906003)(82740400003)(7696005)(41300700001)(70206006)(4326008)(86362001)(70586007)(8676002)(966005)(336012)(40460700003)(16526019)(8936002)(26005)(1076003)(6666004)(5660300002)(426003)(2616005)(2906002)(81166007)(47076005)(316002)(478600001)(356005)(83380400001)(36860700001)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:20:58.4483
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dab1509d-8dfe-4f6a-db48-08db9dd584e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
surprise down error. This error is expected and is just a side-effect of
async remove.

Add support to handle the surprise down error generated as a side-effect
of async remove. Typically, this error is benign as the pciehp handler
invoked by PDC or/and DLLSC alongside DPC, de-enumerates and brings down
the device appropriately. But the error messages might confuse users. Get
rid of these irritating log messages with a 1s delay while pciehp waits
for dpc recovery.

The implementation is as follows: On an async remove a DPC is triggered
along with a Presence Detect State change and/or DLL State Change.
Determine it's an async remove by checking for DPC Trigger Status in DPC
Status Register and Surprise Down Error Status in AER Uncorrected Error
Status to be non-zero. If true, treat the DPC event as a side-effect of
async remove, clear the error status registers and continue with hot-plug
tear down routines. If not, follow the existing routine to handle AER and
DPC errors.

Please note that, masking Surprise Down Errors was explored as an
alternative approach, but left due to the odd behavior that masking only
avoids the interrupt, but still records an error per PCIe r6.0.1 Section
6.2.3.2.2. That stale error is going to be reported the next time some
error other than Surprise Down is handled.

Dmesg before:

  pcieport 0000:00:01.4: DPC: containment event, status:0x1f01 source:0x0000
  pcieport 0000:00:01.4: DPC: unmasked uncorrectable error detected
  pcieport 0000:00:01.4: PCIe Bus Error: severity=Uncorrected (Fatal), type=Transaction Layer, (Receiver ID)
  pcieport 0000:00:01.4:   device [1022:14ab] error status/mask=00000020/04004000
  pcieport 0000:00:01.4:    [ 5] SDES (First)
  nvme nvme2: frozen state error detected, reset controller
  pcieport 0000:00:01.4: DPC: Data Link Layer Link Active not set in 1000 msec
  pcieport 0000:00:01.4: AER: subordinate device reset failed
  pcieport 0000:00:01.4: AER: device recovery failed
  pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
  nvme2n1: detected capacity change from 1953525168 to 0
  pci 0000:04:00.0: Removing from iommu group 49

Dmesg after:

 pcieport 0000:00:01.4: pciehp: Slot(16): Link Down
 nvme1n1: detected capacity change from 1953525168 to 0
 pci 0000:04:00.0: Removing from iommu group 37

[1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
    https://members.pcisig.com/wg/PCI-SIG/document/16609

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Indentation is taken care. (Bjorn)
	Unrelevant dmesg logs are removed. (Bjorn)
	Rephrased commit message, to be clear on native vs FW-First
	handling. (Bjorn and Sathyanarayanan)
	Prefix changed from pciehp_ to dpc_. (Lukas)
	Clearing ARI and AtomicOp Requester are performed as a part of
	(de-)enumeration in pciehp_unconfigure_device(). (Lukas)
	Changed to clearing all optional capabilities in DEVCTL2.
	OS-First -> native. (Sathyanarayanan)

v3:
	Added error message when root port become inactive.
	Modified commit description to add more details.
	Rearranged code comments and function calls with no functional
	change.
	Additional check for is_hotplug_bridge.
	dpc_completed_waitqueue to wakeup pciehp handler.
	Cleared only Fatal error detected in DEVSTA.

v4:
	Made read+write conditional on "if (pdev->dpc_rp_extensions)"
	for DPC_RP_PIO_STATUS.
	Wrapped to 80 chars.
	Code comment for clearing PCI_STATUS and PCI_EXP_DEVSTA.
	Added pcie_wait_for_link() check.
	Removed error message for root port inactive as the message
	already existed.
	Check for is_hotplug_bridge before registers read.
	Section 6.7.6 of the PCIe Base Spec 6.0 -> PCIe r6.0 sec 6.7.6.
	Made code comment more meaningful.
---
 drivers/pci/pcie/dpc.c | 69 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..25e9ddeeb271 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -292,10 +292,79 @@ void dpc_process_error(struct pci_dev *pdev)
 	}
 }
 
+static void pci_clear_surpdn_errors(struct pci_dev *pdev)
+{
+	u16 reg16;
+	u32 reg32;
+
+	if (pdev->dpc_rp_extensions) {
+		pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
+				      &reg32);
+		pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS,
+				       reg32);
+	}
+
+	/*
+	 * In practice, Surprise Down errors have been observed to also set
+	 * error bits in the Status Register as well as the Fatal Error
+	 * Detected bit in the Device Status Register.
+	 */
+	pci_read_config_word(pdev, PCI_STATUS, &reg16);
+	pci_write_config_word(pdev, PCI_STATUS, reg16);
+
+	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
+}
+
+static void dpc_handle_surprise_removal(struct pci_dev *pdev)
+{
+	if (!pcie_wait_for_link(pdev, false)) {
+		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
+		goto out;
+	}
+
+	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
+		goto out;
+
+	pci_aer_raw_clear_status(pdev);
+	pci_clear_surpdn_errors(pdev);
+
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_TRIGGER);
+
+out:
+	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
+	wake_up_all(&dpc_completed_waitqueue);
+}
+
+static bool dpc_is_surprise_removal(struct pci_dev *pdev)
+{
+	u16 status;
+
+	if (!pdev->is_hotplug_bridge)
+		return false;
+
+	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
+			     &status);
+
+	if (!(status & PCI_ERR_UNC_SURPDN))
+		return false;
+
+	return true;
+}
+
 static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct pci_dev *pdev = context;
 
+	/*
+	 * According to PCIe r6.0 sec 6.7.6, errors are an expected side effect
+	 * of async removal and should be ignored by software.
+	 */
+	if (dpc_is_surprise_removal(pdev)) {
+		dpc_handle_surprise_removal(pdev);
+		return IRQ_HANDLED;
+	}
+
 	dpc_process_error(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-- 
2.17.1

