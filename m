Return-Path: <linux-pci+bounces-3195-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDF6184C947
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 12:13:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E02BB2224E
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 11:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8988D17721;
	Wed,  7 Feb 2024 11:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sR2cXY2u"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277741B7E1;
	Wed,  7 Feb 2024 11:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707304396; cv=fail; b=E2DNI/17BjzTRFhjI1qXDJsjRYcz7VWS1Fw8SKgbNY8kJATTt+CxcheZ7Kfb5MTuvwBsdOAZxLghxxN6OBF2HCmg0rks3rjUp8cuRPCbDKH/DP1dU8rsgQNZyFPG3YKrsyR1Nsy2bDJuHdkKbM7rCCFWTpf9K55iFIecTWVxtFU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707304396; c=relaxed/simple;
	bh=GkOmwpKTrnp7IuYuSHvW2+DLbN8hAieO1D6SOAdMlss=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dgGusQPuQtl0t9gPiG/Vv2rLaWlU7D7LE6ofzsoA0lyBbPzdwH04WDz2g+88Ma9cgEu2uyFWtkl1F1jSbMpYNcY/pZWySxE1KuKut+kaKh19avlYMgiG/hd7vtzHvU/e1tjwUMCqb76/ZPMctY1sWFO/J32lRCtZT0UM15cmSss=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sR2cXY2u; arc=fail smtp.client-ip=40.107.100.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DfxM/EOiyxQtASMFllNdmOQJRQJVJ2aGAO2AZug5IoPOEXYYcYF7qqVB9WRdC6NFmsuhdy6ZtpalIJONuuSBOidjcPuLuMps+cZwuFP/wcxJdeaMbACTbIhDAt1PlGSFda2QD4pH0zNln4mahQCY1AXlAVO/p4yuuZQ1yRMgtZBpD18LFxzoCyV3wyaDqq5yaYizVRZf5bMm4OoT/9I5qJvZonGjc5plW/TAHsSphdp2w5awGocTQp3L8ZCzmPs9iBDSHFlwkFYaSGW0eecd7wqOXjrK2UAlGwfgIKZQx+zXG53lJ7hsgUdGMzp8kr3co4GJp94wyl/ssVoLFAdZzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zi+Fj5XDjm86f+qa5tirUM+/QboG7lc5D7g0Hzd9O3Y=;
 b=iw+qiiR6e4wRXyKmrZIwcPtsIsuPugLIFLVk5FQaYk53ldWconJf0RL/CRD3DXTLayYCYoug3e9VHo23rt8IQCDzqTneNHkyaUYivP9UMh3lXwgulyp/iVt6X1xZX7I3Wtb6yXx6SJFuUxC0fBnbvdHnPOx7TUXAkmPMjKIEubQqN834H3s5Aj2U+AYAb2e8oarzZLkmgBqjU/39jznJtFLgHGvWMKwKWBlhGCj3SlOJ0jtBzwVFosb331BwARp9alg28m0brm4YVQTbRcYt6hFWrk0VOjhwgvpDAEOFZpmkA5/cce8J/YWrHHO/zyVb4Aw7O4b28kRNLH54Xxi3eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zi+Fj5XDjm86f+qa5tirUM+/QboG7lc5D7g0Hzd9O3Y=;
 b=sR2cXY2uN6xlaMJqt9ly9hZ4QBK1uOzzpM9y3YpmeXSOaF7Q0W9qCj5JHEaRKRfoqapb8uSgA1wTw4QD+Qa8i48iHGwCy16atykG3FII7WNmqcVXYuAgtsgK4uYYEFkMTwm16k1L/YCpW3fGQxCi3efq/IVuNiSir5HDWE2RV5M=
Received: from MN2PR16CA0020.namprd16.prod.outlook.com (2603:10b6:208:134::33)
 by SA1PR12MB7174.namprd12.prod.outlook.com (2603:10b6:806:2b1::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.14; Wed, 7 Feb
 2024 11:13:09 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:134:cafe::8f) by MN2PR16CA0020.outlook.office365.com
 (2603:10b6:208:134::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Wed, 7 Feb 2024 11:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Wed, 7 Feb 2024 11:13:09 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 7 Feb
 2024 05:13:08 -0600
From: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Mahesh J Salgaonkar
	<mahesh@linux.ibm.com>, Lukas Wunner <lukas@wunner.de>, Yazen Ghannam
	<yazen.ghannam@amd.com>, Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v8] PCI/DPC: Ignore Surprise Down error on hot removal
Date: Wed, 7 Feb 2024 11:12:56 +0000
Message-ID: <20240207111256.110982-1-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SA1PR12MB7174:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e3196e6-cf17-4f03-182d-08dc27cdc411
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PYdHgc2/KlJH3jtJWrTHqaAuxlHO50XsTu8pE4+IMyExzmSnaN0nxrvnz8BFlwBLVocIqtDBqcZUv57d1kofkFvnFMhePGt8zAh/1urRq4DNYzaD381O8Exnj+NtdMyR4j3NnW/lU9IcS6ZI/kC6JAgNZCd/prUgLdJcJgj4RkKhDzzkyhMvNX9olf7vmZKlxI2qEHIdidwnI4VJSEA+Hwc44fyyudo3F9DC6yKQRNav4gGQJdRbQC4ddGksCTgf2O4Gz4+sWvdsGbPw9+sLCZjNTFiQMpJR65WT91ZR7JhdTIR07Kn9oExKkf/Vv/B+4Pxq2ehtPw3LhfSXd/F6B/cieR6CqJu13ifr4Bklm/9j9oSmRl0m2CLwdHOSxe+ecwVhfaFz2h35uuLjhziZnGR3T17tW40bgJy6/4Iwe02Nv4VbdrOwGkChM3HKmQVtnrjAqoUzkc75Mcl+lIdSw4ms7iC3YWNJYBqUx1yFiUBjoi2xI5Rbd/mBkC8Qbg2ub2NIUgICFspO5ViIP4HOpRLtGHQPaZ4kqMbQCol///ZwsZLAmUmNdRRTqLpvzW6SvP8xUJIPd8+sYsmgy7Yyzej3dUL1iavkmBmQCDOI0GAaRyDdlaVzcK9Lx93AjzqmloNQp6HwBhfdddO6+sdroTuDdwDG30bXCD9SdAVbinECYM3efbwQbqlhq9PFC27Oduf5oKhO20cjIp1HaL/MMj1gHUbobIBETeFziwPRaAOJbs5O8YqSSrFd+CSeY2NhgZx5OvyOoo/JxwCyHuiYRg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(82310400011)(451199024)(1800799012)(40470700004)(36840700001)(46966006)(478600001)(86362001)(41300700001)(966005)(82740400003)(36860700001)(83380400001)(356005)(81166007)(40460700003)(40480700001)(47076005)(336012)(426003)(26005)(8676002)(6666004)(316002)(7696005)(4326008)(16526019)(5660300002)(8936002)(54906003)(70206006)(110136005)(36756003)(70586007)(2906002)(1076003)(2616005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 11:13:09.0531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e3196e6-cf17-4f03-182d-08dc27cdc411
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7174

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
---
 drivers/pci/pcie/dpc.c | 64 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 94111e438241..ba7240a2ba2f 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -303,10 +303,74 @@ void dpc_process_error(struct pci_dev *pdev)
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


