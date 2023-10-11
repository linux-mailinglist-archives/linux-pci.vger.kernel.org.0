Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 358877C5EA4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Oct 2023 22:46:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235236AbjJKUqa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Oct 2023 16:46:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjJKUqa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Oct 2023 16:46:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2050.outbound.protection.outlook.com [40.107.243.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E67F93;
        Wed, 11 Oct 2023 13:46:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SfZE9N7VSF9xGLz6IUUx26e4oJnkIxH12g7Xry17L8dvzkGgp1YVeic96J9Kr1TaAk9z+S1Ycw/aXPOKcRLbW4d5VBmigB99jSpzirfa3CLsEE9xrSdTehM3BknQyhRlcPSYFnvJXnsHpZxuNu3bhgiHV0An5n4WJE3gUkVDNIp20qWjnu5Nqx2bgG0vmPyk8aeND3YPFemXtSoKZ7XPcy8UAXdDq25q3RjCMsBS3nL1RM75RnQiSh5MHdGRCy6m7p4s3d3x4/DtFzvVuQQogT46fwIhiJ9ljrR9BAZSxaGjL9wPZIRKMMhgkWicFLjkdhCeDwycUIdoT0sd4lnwFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lR6wr6gwjpFRmP2bs97cTZ366ZF7Sv3qWRhcHk8zrVc=;
 b=EwcN/oc9f1pGQPMlEEvRr6gkOtn7lwgiDBkrhE0DFUBqZ1rz0knygRXJUHI3G2OwnFMbnAj+cA3vtQGvR4t3z9cCM5KXx48C0aWHG6LGAlTov3YPMWPp9xGBiGqPEFcNmOzcnN5y8AZQslCJ27loewHUJ0Q8Re8avG+WJy95M/r0IWTQ5D+MJBDaTSKHbMllbQMb0vKOvx9/5mxhhLDR7oewrP/uDJCj21L1mdd7K1HhdsfB5vFhrgAJ1aQSYaXaAgyUaHbRP9wDIPgunEDuptMDFNuNJllaIn/0LYGKOoYZJsZWeZuPjoo5k9A++5TKmI63M46eAg3yfBCnikON/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lR6wr6gwjpFRmP2bs97cTZ366ZF7Sv3qWRhcHk8zrVc=;
 b=P2xkKVFphaXzkhUALBAjd4hrYbJo4H94Kxina7Oo6Jag2maDBU+YRPtAYY/8NCsnZnx8oQx2cQzEMm1xhBGtlNOC122suiFke18G4nDOSs+3O635GRU0LcgVzWzzJILSg0xvQojM2aKxGA7mfr2sez3i5zLs1xTV0HM38Y2I5BY=
Received: from DM6PR14CA0048.namprd14.prod.outlook.com (2603:10b6:5:18f::25)
 by IA1PR12MB7759.namprd12.prod.outlook.com (2603:10b6:208:420::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.44; Wed, 11 Oct
 2023 20:46:24 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:18f:cafe::f9) by DM6PR14CA0048.outlook.office365.com
 (2603:10b6:5:18f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.28 via Frontend
 Transport; Wed, 11 Oct 2023 20:46:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.206) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Wed, 11 Oct 2023 20:46:24 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 11 Oct
 2023 15:46:23 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v5] PCI/DPC: Ignore Surprise Down error on hot removal
Date:   Wed, 11 Oct 2023 20:45:54 +0000
Message-ID: <20231011204554.120574-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|IA1PR12MB7759:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd5f60b-a3d2-4053-4cea-08dbca9b221f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I+ociW3GUCK5f4V9mQ2Yd7aYgi6OtiQGlsp+b9T76pofm9bdoEqTdIZxpzpt8UXcbwx9qTSjA431VBy21Vpl0fyQdxxLsKdxysa8/vYa49IUTkNG3uiIU+2p5XMTXpyhm7whukpxsVaV8Eh0gGOlalatkGoj6haAf7e9wt85Js7av+AcoQwcsvN4LlTeqoxyX0Gx3/rGORAtta57anFyjOpedGgmKxYIgmTubXIZVfaFgjbt3vWcNV8KdAW65mUzePr9dTO+zw1OG1U81sV5c4qqNqoEh/QdYknZrsXxlXviwM+5VExkcsBkGEnVMmaM+XTMPcLlyT26H8edrvl0iP6ieIfqBafZkMTFHqZNEzGB7Z7ABJbeue5IehF5liI/3QHtBQ3VOQoHpzm2DHa1fjHM0T5eTj3aGYvmweTmUt3UYGUW79PGvku+cld2NvI1c1Yik2q6IepWPOczj6yg6isyAVSm3h/kELbBfVJ5YYdLKpbzcJte37DtluTbtr66OfL/yQx/DQCq9vrPjfdBw3th8yR57sQgciiPzeycb9G4FBB4bDDIvBfcDqwf8Am4NauaD41S86lgS3j8R25Dv26Jhh/NvLKOQQtZdP43aCTftI/j2aaktBLjO2bWuipKW30MtwhwoqgH2A5FDFUYz4v4Dtq8do7xezw0ba+xN/S1uWfyvvHLkNVu6UuLNhK8TuHUdjZGjDTkqrwEFh5UvxPem20KA9D/O7fJt72i+mmyDv6CI4O/LSgag9uAPTMNzQllwJbMWxTDTMo8emOyyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(39860400002)(136003)(346002)(230922051799003)(82310400011)(64100799003)(1800799009)(186009)(451199024)(36840700001)(46966006)(40470700004)(83380400001)(7696005)(6666004)(86362001)(36756003)(336012)(426003)(2906002)(47076005)(966005)(41300700001)(5660300002)(478600001)(81166007)(16526019)(40460700003)(26005)(2616005)(356005)(36860700001)(40480700001)(8676002)(8936002)(4326008)(82740400003)(70586007)(110136005)(54906003)(70206006)(316002)(1076003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 20:46:24.3181
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd5f60b-a3d2-4053-4cea-08dbca9b221f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7759
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to PCIe r6.0 sec 6.7.6 [1], async removal with DPC may result in
surprise down error. This error is expected and is just a side-effect of
async remove.

Ignore surprise down error generated as a side-effect of async remove.
Typically, this error is benign as the pciehp handler invoked by PDC
or/and DLLSC alongside DPC, de-enumerates and brings down the device
appropriately. But the error messages might confuse users. Get rid of
these irritating log messages with a 1s delay while pciehp waits for
dpc recovery.

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
Reviewed-by: Lukas Wunner <lukas@wunner.de>
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

v5:
	$SUBJECT correction.
	Added "Reviewed-by" tag.
	No code changes. Re-spin on latest base to get Bjorn's
	attention.
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

