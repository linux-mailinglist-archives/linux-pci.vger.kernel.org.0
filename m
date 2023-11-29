Return-Path: <linux-pci+bounces-251-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B114C7FE193
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 22:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66B772824E0
	for <lists+linux-pci@lfdr.de>; Wed, 29 Nov 2023 21:10:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BC45CD3E;
	Wed, 29 Nov 2023 21:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rm7Fc17L"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C99B10DB;
	Wed, 29 Nov 2023 13:10:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HoCE8gPQ8eyNHLoL1wgaxmQPyjHHMdsKWqbXf5euzv75txWI9kK8rAOtJroSEH2KiDdEZK4EilZlvc/97rHBb2Ae1GHEJ0iTn4yI1iNPAElYUaafhBKtwVaRt4EeBaw6D0gQYekhBxlrXbaLcgZqCxse2jiSg7u5xYz4D2/DTVdaiX4pVWzSDAFBZCIb4yjJxVrryHAiS/2ty51WitWaXCMygIGF/3mxC5tOM6fzsBqfOnfO43ReOeHjtZOoEgl+X5Dv93NB569pOQ73wugrbx2EiABXIDuGzWPcpic/SzMvCVXHBk+S+GWAefph08a5OTSYzYmeamaLi8PklW9QJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ejVubRgadwqHt5IMl/SXZ/ivPrQ5Ox6qSkNXSVOtQ7o=;
 b=AztAHDKsnu1VAlrtP0p3e7uTl+tbeKsfStKI0fd3SvUgqVvhsEP07KmXIMbdRQ636dobU6XWXqac+Y2KbrJ6zbx4cot3suP3LPLGxD/S78+MM9gxe1m3T/dB7pSw9QRn65Ei8QowZ3xNbZnFvHaijxgbGJAEdrQrUfPC4lsVyoEl7pzfRoVOGB3D77Hkf4sM6ogOht5V4k+cOCyx77rTCUuzSRbXcmJWZc22V2rUngS90Xrm0SDz6csou+2lWQK0uGC2N2JsHb7ej/Wf6eh0KKklOO9TluybHPFYB7JtvOArA0oWMZI6qXA5CiqB8d6BiQH7WrGuM+AaSmJYZNaacw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ejVubRgadwqHt5IMl/SXZ/ivPrQ5Ox6qSkNXSVOtQ7o=;
 b=rm7Fc17LALz50H8YucnezrZCcVkAXd9rUgUhpR3Lb6baeZrpy8VvfHbv1yara4Brs5TZn3imwmYnMf1ycySBIHegcLJcVKYV9Y+SqH0qkMw3OlDNWkdlbXl/qy8zYQIftWG37UOOs86hwQMTLhf0VF5ngX7WTxFZwXnCbqq+CWs=
Received: from DS7PR05CA0057.namprd05.prod.outlook.com (2603:10b6:8:2f::21) by
 CY5PR12MB6203.namprd12.prod.outlook.com (2603:10b6:930:24::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7025.28; Wed, 29 Nov 2023 21:10:14 +0000
Received: from DS3PEPF000099E2.namprd04.prod.outlook.com
 (2603:10b6:8:2f:cafe::a1) by DS7PR05CA0057.outlook.office365.com
 (2603:10b6:8:2f::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.22 via Frontend
 Transport; Wed, 29 Nov 2023 21:10:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099E2.mail.protection.outlook.com (10.167.17.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7046.17 via Frontend Transport; Wed, 29 Nov 2023 21:10:14 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 29 Nov
 2023 15:10:13 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Oliver O'Halloran <oohall@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v6] PCI/DPC: Ignore Surprise Down error on hot removal
Date: Wed, 29 Nov 2023 21:10:03 +0000
Message-ID: <20231129211003.154341-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E2:EE_|CY5PR12MB6203:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ddb337d-64a4-4ef3-cc17-08dbf11f94fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	l3OXcPmsPlK/uLzV37U9FoOGu0Rv2geay0wDf+Gnkts5ubnBvGmSmHtz709T37ppHVofr4YbgBHRpuIgT0VpXLoAFfKK3CXQMJXcdqprr1jpvvFYPLnWEOozSWsEBSj/3XEvlgCHNn7o4vmagFhXKSWPUQIHa2PgEeqUujbFulgHaq0nw9ewtLmZ0WLCji4Wu/kHX0IwhVAqrWF5bFoCiMN9BtDBVCay+6/ZlHmzjXVuOwhHLroagvj3/RcUaYkiDw4vtqoPWnJj1mul/mnRaANCtZr+Tj0dWbo9eflfjmxhpefJgVi9Qx+g6aBW1xBzFo7nz546rqgU3o0mRn0ZHktyNIgRJyQd1uoYlnyWPpbyZJozHUzgzeeDYpbhlRAMx4z8quDH88Z6lShyszp307o+kw5MkL2jKN+52dF7xA6h5HooZxdY0+1+lOaoofuWMBPhX+63N/k8BatuviNU7voxscx/d7GGN4fvekI8o84IYiTAo1NsZ4HEbRGbuUYQAfKiDln97MRiheNuAf2D7pr0n4rKAK2mtVdtylzutR9EU5FTvNRDRt2UHmaFMQA8esMYYY90fIqZGbOUP4fYaNtOeBds2DMeFfOI5U+Dqum6LDW0xSAVm6Cs3mi5uro3eWK9/CAKBcRuqJ42zF5cqu9GvLKyYLXV3ODvTDrvfLzvnuBHdLUbgfG0p7Wd3TuvhjKpBZU46VkUSbKEznXvUfiwyksvbcy2R4/WFysS9Fx63NsSY0Bpvo16o1EcU8etBYcdYYoujnMdgcpXr4Y5GD9ylO/03z3/VTwSKks1Yt0Xn4yUT4PQNmztFyaOecIg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(2616005)(36756003)(41300700001)(1076003)(81166007)(47076005)(356005)(40480700001)(26005)(16526019)(86362001)(83380400001)(5660300002)(2906002)(82740400003)(426003)(336012)(202311291699003)(7696005)(40460700003)(6666004)(8936002)(36860700001)(4326008)(8676002)(478600001)(966005)(70206006)(54906003)(70586007)(110136005)(316002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 21:10:14.7813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ddb337d-64a4-4ef3-cc17-08dbf11f94fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6203

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
---
 drivers/pci/pcie/dpc.c | 67 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 94111e438241..e8ede4875ccc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -303,10 +303,77 @@ void dpc_process_error(struct pci_dev *pdev)
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


