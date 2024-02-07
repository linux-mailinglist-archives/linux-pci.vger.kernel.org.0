Return-Path: <linux-pci+bounces-3217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C52284D105
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 19:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A49B1F22EDB
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 18:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD5218289A;
	Wed,  7 Feb 2024 18:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HHGybyUi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2073.outbound.protection.outlook.com [40.107.220.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D80882D8E;
	Wed,  7 Feb 2024 18:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329953; cv=fail; b=hylPkqTaPeyl6jRHsn/PkIEmbuk687A28B2X2fvcsGwQ2VmOX8EemsbjAX2WtcKkZrklHMiHmjdx12VCt6M/RLlwRxGZeHrstXkKD9pRMIykeCVZSkLYuS0qD0SGbp4bO1b6nVGeLpYGXsdIKy5su/ScY77rP4yaDFv/ZRd5oeY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329953; c=relaxed/simple;
	bh=j4nVcHFZ5cjss67dU05dAsDBJy7+H09d2nEaGSNgyZg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GPI6cZ4bhOKAIoKtiLR9+BTk0o03akp0ydXFOidxS4KmTp3q5Xud7mzUzhJDueMPm4zKh47J/8mz5O0UezFCMN5Mm2nTl64GzdN7zWfLIU5RYRG929H3daaSmzFQdYMa+LBRWysijkE+qCbUsYATnHSvSe5YyvwCB4AVFZhWx4M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HHGybyUi; arc=fail smtp.client-ip=40.107.220.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZPm82qCDYvNHD2k6QGgJki1YS4Bs9WGx8OtEshO4uyLd2rqV7M6mDBmzY3vNMkIGmGcOVg6Tvc7YswExUirLDcpewJPoLje0KgbiWu7mMX/YaIs28OC+vvjtTjhsMwWEnL8eil0NYxB3wQgR3FD1IxtnwK9oCrL0Q88P1PnvoNNZjqdCFtLdYS3IUECTOCmUdCrMQt8QfYaXQLIiYBsNhr3977adcEOzaFhqckOqKMZlq8e+eUmUsnqihSqI+FLrrzV6sQxOGOf5YDM+DFW8dNUCwKrmI6JIJ3PTMfxlLHVNw4kYStmFz1ltZrfJ3EYmhZ1FJa0R3mDZB8a0WVHMqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lO66k5iwNLMB31YnzP1dNcNLNUU4hn1b+fFiDIWKyUc=;
 b=Q/CK9v8t0+tzPYRUN8PPHaHfAXNDcaQ2O2/Z6fdNmoyuQ2eDZkmO1x4SJ0xqxb2Ru6JNnDUUz+zcNNU0obVFqUL7uKcLnPEIC3YGkyJvCIqjcIUm8UNHVx4DbImSYuWRr8T+E5Uf26/LPJ2paY5+RH/i9ejzA5CjDAbhgcSDWtetFknVxOtAFBJ5p8ztk6GUJAHClQtyhKiHkoYVRMbNMkWDCeI9Tb3KPwBDJE5kx2d3p1jAkZ3j/usVunQk4cXwg1OZlCfPXlvKxeg/fqBgEhbu7O3bI1b7eHDkp8itUAeeX6Yq6CM5JmxkkhtQa/NzrKUzAvYXvKgfBAKwogcQrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lO66k5iwNLMB31YnzP1dNcNLNUU4hn1b+fFiDIWKyUc=;
 b=HHGybyUiE0Y1RhrZeeG4YcAHU/iGEnzha34lIllu1qY2ntrEIX0Yeb6yomgkneWk57ElKsGODgX9d+tRfHv1TEIk6TrxYn6C1mJh4aBCnnXxcQHLKt0p4yGzneqRWtUqa7QRtDgOkcIJH0Ykay20gfKMDmCKCoM3PG78jo0JHYY=
Received: from DM5PR08CA0043.namprd08.prod.outlook.com (2603:10b6:4:60::32) by
 DM8PR12MB5398.namprd12.prod.outlook.com (2603:10b6:8:3f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7270.14; Wed, 7 Feb 2024 18:19:07 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:4:60:cafe::52) by DM5PR08CA0043.outlook.office365.com
 (2603:10b6:4:60::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37 via Frontend
 Transport; Wed, 7 Feb 2024 18:19:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 18:19:07 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 12:19:05 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v9] PCI/DPC: Ignore Surprise Down error on hot removal
Date: Wed, 7 Feb 2024 18:18:54 +0000
Message-ID: <20240207181854.121335-1-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|DM8PR12MB5398:EE_
X-MS-Office365-Filtering-Correlation-Id: 2786a269-0b6f-4cd7-fb01-08dc28094608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1yMFUCE1AfPjiat2Lf0iAphSHObsLPKv+kQqMGpOh4pdIeStv87sqMQs7euW/liAajEI1mbakw1x1ViKFP3ZY8/+y0h/Bvx0q8NX0LR0mvzXlBtsdDqUpbuZjjTKYk2Skl8U/TCyJOfPSw/5NFZ/6yLo53egyvcwg1xNGN37szn5ZySt6TGB6KynkPr8J7Z+LsR9TKpQ3OrCOm37/qqfh/EK3rQ1b+xavaKGHX9tbFmWmCF0QBl1GtdLZW2mWhtyZzG3WRkY58hIP9c1UqcFoMPr/updoKWQC1r5fsAZRpM46tkqA0S/PgBn6hzsDjGY4+Xq7rw4/tz5rI6Jl70h4JyA8/BChd7dO168rpLIx4teGgb4Jc9vfH3hrDShXLenrnWw6qiBrHVgUnysrLNQC1QmPF7RNe4vr6vCtTddB9LX3ZFleGmr61Bq6o6U+LU1MV+bEyfuMrz/b3K0OVtACfbPuZWNtQOZnRxAF5UUiB83n4B2kSErcqp7k+seJPPLi3OinhEZpixDk/HpUfrkoN9/zkysd1ufCTgTzOnpbdrWKsgzZ0Zk3BMBTmA3/t+tlwAkrj/O9jPk62M/MqkCLGoJ23TQaLKtnL66K13UiZR0YJI/RjlfXk0aWa8+xiwnA6Z3ZW75RUU4Jyb5rs1pgQ/iGoIV3JyUZqbxHw1J40k7Drf9A8a6RYo7kUHw2q3BNVwKkJCX55dl01U5RBWQ3raBXKcfm1WYyNsnq1as1PEdXMbELwQy61JvGPPoMXnlDX1m5+8rtGxZDRGzljxxZw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(451199024)(186009)(1800799012)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(966005)(36860700001)(41300700001)(7696005)(26005)(70206006)(6666004)(2616005)(16526019)(5660300002)(478600001)(86362001)(8936002)(426003)(4326008)(336012)(8676002)(47076005)(2906002)(70586007)(54906003)(316002)(110136005)(81166007)(82740400003)(356005)(83380400001)(36756003)(1076003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 18:19:07.0828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2786a269-0b6f-4cd7-fb01-08dc28094608
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5398

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

v8:
	Just return "status & PCI_ERR_UNC_SURPDN" instead of true and
	false and allow C to handle the conversion to bool. (Ilpo)

v9:
	Handle errors from pci_write_config_word().
	Write 1 to clear PIO_STATUS.
---
 drivers/pci/pcie/dpc.c | 60 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 94111e438241..17f166504b54 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -303,10 +303,70 @@ void dpc_process_error(struct pci_dev *pdev)
 	}
 }
 
+static void pci_clear_surpdn_errors(struct pci_dev *pdev)
+{
+	if (pdev->dpc_rp_extensions)
+		pci_write_config_dword(pdev, pdev->dpc_cap +
+				       PCI_EXP_DPC_RP_PIO_STATUS, ~0);
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
+	if (pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS,
+				 &status))
+		return false;
+
+	return status & PCI_ERR_UNC_SURPDN;
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


