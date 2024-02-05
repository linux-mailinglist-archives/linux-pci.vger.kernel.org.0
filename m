Return-Path: <linux-pci+bounces-3120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F0C84A460
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 20:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFC5F289AE0
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 19:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D2114463F;
	Mon,  5 Feb 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZLhyK2E4"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1E4131E52;
	Mon,  5 Feb 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707159830; cv=fail; b=IiCvsizJHdt7ymTjPX9Ev2FOKqd5yu1UxvoXIr7M/dD9LcFBfA5LZKvmUdAXAZ1ejdEywRjis7PDZH1OObrPl456RHbd0OGCTEy+J1IRfflRO//N5cxVbKG++quTNOoAp6Rw787rpfomkrQir9PBMgerp0uSa/iuAeOOHJY0WWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707159830; c=relaxed/simple;
	bh=Ob494HV12XXXfV06nU6cZ+wzM+8EsMOFoKTAUpLMzq0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RS/UnYKiowKDzrINVPB9ML5v4rrbrwt6NIFKOBXUi0TH2ge2YFyTh/qHi6bucnzc/lGzQ2nhdwGoaMUj9kLQZoUpbbGGSfZFlZiK4QP/iRBUIonWMXtWeLQ1HQ/UlTg3D2OuquKAFrlI8fe+b2upUvWR8QT9QsOu1XVl/TMFm6Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZLhyK2E4; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PZ4TK8XrtjbD3qNeVgXExGYtPzTnJHdahQZvVcp3uLm1x96xK9cJOLlANfa6cs/1JfGs91eCLxS9ReZwskbWH1Z+xAlvXWm5WvRb+wRtja+DeitSdgFSJTBN+B+evJnZqvz9JBwc6vklwYnC8DxMeTUzj28UflJte3fceP+uMi7NyEO5p+Zqzg6/oBQNK/JVxlep+nejKJ83aMvZz+lZwz3plvJN1xlx3iJdePH9sCr9Ok+OKMZvOPCHvdgnZtEYGrfN4fUnMPCEIsZhN/T3NLthMUuLiUgXAfCignukrxcKlug8Dh68sgSsnuxoFhH3UqhsmFBCnkHzev27E446iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZG4MryKVgObhBrXJ7b4sSFevtDUegKmw73FiZSXyvys=;
 b=kFkcJhMTL74vr32MnHdLTNk+0l9CaufIsF+tsE+pkZDOMIGKkK0LShFL4ejb4d7jSQvklGiStPPovQkYLgi+zFiG39yDi2IXUfB1j/5cItbOuD7SD1aPohGdlySTfIltLD1RzEmYTFOE/3VNV3mOY1HynNJ3e7JAv2YiWKna+ON71pdR6Ooimdd4wGLGtu4bdzi9/FMOtjhwyoHCZrjMh/Bq9DQ+2/kqkn75Qi2EQmZJubLjukMPMD1uTiCbgk7SYWZLaWzrlnHVxBIoTFjqqKMUJ5qAr7panErDjNxb/P+6Y/BXa/PdWQCpYXsYkSJkv6Z23o0Zu4kqnRjFt0mapw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZG4MryKVgObhBrXJ7b4sSFevtDUegKmw73FiZSXyvys=;
 b=ZLhyK2E4C2pZ8zoMjAimLIsFR5G0Hldy8nTEh1GfoAfmJZczN2vr8E6QeoZuD5tUCS9EujE4Q6G5sK5Ate84VqVMVj+bMks1074So4b4+cfx7mQKs0bywqIjME9yT3dvXaOl7Ep7/L4DhWPUtKE2NclEETiSub6qVzVp/lejZvU=
Received: from MW4PR03CA0360.namprd03.prod.outlook.com (2603:10b6:303:dc::35)
 by CH3PR12MB9195.namprd12.prod.outlook.com (2603:10b6:610:1a3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.11; Mon, 5 Feb
 2024 19:03:44 +0000
Received: from CO1PEPF000042AB.namprd03.prod.outlook.com
 (2603:10b6:303:dc:cafe::37) by MW4PR03CA0360.outlook.office365.com
 (2603:10b6:303:dc::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Mon, 5 Feb 2024 19:03:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042AB.mail.protection.outlook.com (10.167.243.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Mon, 5 Feb 2024 19:03:43 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Mon, 5 Feb
 2024 13:03:42 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, Yazen Ghannam
	<yazen.ghannam@amd.com>
Subject: [PATCH v7] PCI/DPC: Ignore Surprise Down error on hot removal
Date: Mon, 5 Feb 2024 19:03:21 +0000
Message-ID: <20240205190321.103164-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AB:EE_|CH3PR12MB9195:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbf5eb1-1aed-4950-f8d6-08dc267d2c2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rVajrXhqA3yI05J8zabnTpBZwIH8Cni5/Qkhw5iR986QW5j6mxTJsr5DSDi7vRwcBKRU5H9hdGCr7cjdyRCQsKVhJOhtBjzzL6hNitjGGVoUzLTQq/sUpYM0LZgGscCS4Rr06AGdC6F3RfuuQdXBce/hNciqwPRlGwg8fTmAz6It/1uTnjyaRmBqeZUaFO11T4THnmfTUBzREbl+eE5J4Y7zDO7PeR7kLpII0MAImf89/BsE1MZs/olWh4+QM1tJvOy6f6170M5tcu36NQ/8UQYfezRiJiwjzDI//IWXADRd6LMjO/ECcmCWGgHcgmcLHGFv0WNH6TtdETjtKHjA3Yw8UGGmee51GwSem84b4jZTLB64QoGmvRlTo80fj+3OT2IdjrJBlHpj2v6NKc1bxNpWyIQfdu0jwh9FTbMD3hnGrRMewEnDCv/gPpyA0aeY/hPcgqrOQ8fQPSKmINMYb5lOJU7ZnnA7/aqfkIR5fVaLRvLG5+ckzwfekqLtlG54I2oIW2fTe2Uqwe+4+Koi958+C5TQhL9v9jTTGPCUqMZFLvFsrj4Y2qG8YNv4z4A2IGIAZmWhGFINDiakugR2V1VmqttFIQKFnk/YljwOaKi8T6pz62Olj0XVbblCK5T9De3GukHs/0YvZpV6T7MkCTDcxdknA4HwjTgVGQjNtR6ZcDbwjKk4vMcz5qdjzEM1NGPCOmdJrp4EBCCLG6vRFJ7X8WNxzEiAnkuAOz7STqUBAg3DTNXrRguHnYDfk39wIVswc/LMQXD3D34KwEprdg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(396003)(39860400002)(346002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(82310400011)(46966006)(40470700004)(36840700001)(7696005)(40480700001)(36756003)(40460700003)(316002)(478600001)(336012)(2906002)(86362001)(356005)(36860700001)(54906003)(16526019)(81166007)(41300700001)(26005)(426003)(83380400001)(110136005)(47076005)(1076003)(70586007)(70206006)(82740400003)(8676002)(6666004)(2616005)(966005)(8936002)(5660300002)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:03:43.2314
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbf5eb1-1aed-4950-f8d6-08dc267d2c2f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000042AB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9195

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
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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

v6:
	Change to write 1's to clear error. (Sathyanarayanan)

v7:
	No changes. Rebasing on pci main branch as per Bjorn comments.
---
 drivers/pci/pcie/dpc.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f5ffea17c7f8..7e1da22cbeec 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -293,10 +293,77 @@ void dpc_process_error(struct pci_dev *pdev)
 	}
 }
 
+static void pci_clear_surpdn_errors(struct pci_dev *pdev)
+{
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
+	pci_write_config_word(pdev, PCI_STATUS, 0xffff);
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


