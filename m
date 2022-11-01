Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F7461421A
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 01:08:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiKAAI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 20:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiKAAI0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 20:08:26 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2072.outbound.protection.outlook.com [40.107.220.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A035101DC;
        Mon, 31 Oct 2022 17:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D7wNGGUg1p+p4Q8VzWSIXQW44mcvoCizxGYVJCtjYDbvpTklmAP8XwYB9M0A5JFAKIVUs1pHudn5M9DmR/9dmnL1wYVyvcNARu+dT0HjQQ3niQCjSfHY7hHEKxHrnM8RKjxMYjs49HXgrE+S9UWQCMmZskRDVjDFE6Y3rDZ66E0iBTO9pOTl3rJgyPYNlGht0ZDcGPpxfBm/GXobHcmYAsFdpdfQHBm6pQDc2pRCGeCixmPw4d/rp86o2o2xHqAYCAMzJaysHNuuKvc8VnV/IXO50CS50ly+qu1ifA+2K4By2koUcYeIM/zjrqwqYsq0ITmQuSOiptbgGUqwH+5NZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfOOmN51K53AfQU5ADr2DhIunsP/rwKAIiWQP8NZ0DE=;
 b=l9V7V8GiUTNBIvOTA8xuLhROJ1KTgXbXOYBsRbzrXvJO35jiW3T9+an+azaOQZnXFdrA/P0o01T5CmJlmBcoXL+d8aphxUqFNSOJYhNg4yVRqZrwktIl+hLXkembzr+1St/K1ZVGbmMV9PS5OHDGgAnCPG5zxzJ21tR/NlwfmsO/kMEMzMmhUlYnO+AyZbyFiktH/9q+SfIQyDfwZ4/ntaAH8yjyfVrUmQjBil/cUqiqooe7fWbx2ccJ5ZHmj2Z3ZVvM1HHBEy6nUtIqsyDGjuEvrJJBzi/358cnY060cRwubSndoz0dnJLOZgPCDkQ8jJJAeaymyxZelpB249f0tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfOOmN51K53AfQU5ADr2DhIunsP/rwKAIiWQP8NZ0DE=;
 b=DNeGmAuvEu0EpEDFGJNIuOMm2u4qJgVXRbMAqAi2qvaLbIpXOjeC+/7az6N4/KF1hhjTXQvLGRIxCcPEqhMT+oAGxHFHtQ/6Y4XC8FmnVi2Sjns2D+UFROTE5Gkw8wxPequPqGwHSMOxMkVB/eDdnKfM8JQ4JU1FeUsTzQjhNss=
Received: from MW4PR03CA0254.namprd03.prod.outlook.com (2603:10b6:303:b4::19)
 by MW3PR12MB4460.namprd12.prod.outlook.com (2603:10b6:303:2f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 00:08:20 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::99) by MW4PR03CA0254.outlook.office365.com
 (2603:10b6:303:b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.14 via Frontend
 Transport; Tue, 1 Nov 2022 00:08:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 00:08:20 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 19:08:19 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <oohall@gmail.com>,
        "Mahesh J Salgaonkar" <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Fontenot Nathan <Nathan.Fontenot@amd.com>,
        "Smita Koralahalli" <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH 1/2] PCI: pciehp: Add support for OS-First Hotplug and AER/DPC
Date:   Tue, 1 Nov 2022 00:07:18 +0000
Message-ID: <20221101000719.36828-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20221101000719.36828-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT045:EE_|MW3PR12MB4460:EE_
X-MS-Office365-Filtering-Correlation-Id: 935d5ed3-c626-4b7d-6a2e-08dabb9d2f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nZ/EJ4Jr6OpBELQm6b6D7GisSxwYkpZFYwj6DpiEYMMImOpZVmwHzSqA/zmOAJIxPDmV7+ImkFsMGwtk2cXsFwdTJ2umzM6GSZfR0fiYtSbagCIq5UGVVrau0ynNRJhTHWM2zKicSyJNmpSGIK+ZzU+dhcsYy9TW3Lwu8FZtxUOquNDXTP64OvIhvCX3QA+Ywoe42hv2BscCGyAxCjPv0Z9jm5oWrcpug1aViUeLLkY1aHrEiY3mcI4UoPrTXRUxc3KQ+vvqRlGAOp84P5PAD1BgtM+0VDO30pytEu9c+QSeHWuGA5mzzvvpdl/+LdMhGpFnP7ZsM8eEas2C8QuXEvCwDqqDhuRC1xktnB/fh1bdbLPLsrZpSowJrMiWhhvH3UgspRMf8GU366Vk3fZR1Do/F4afAx8RZGADLj+cFUXRH645Du6s72Zf0DX2MsBuMy2l6BaP0KQIZWlPFZYtMZjQpUhXvF0frpdqObs7qGk4TdXxKWQlZKtKp7hD2L3KYk1rf2firRUZ3gVbkUMcSGsgdbmZ9ezoR8IgXZnHxiqcUilxkVznmCw/qRvt0VvEqlbZy3xE4NF6+Q8SFh32JF24FZjnESpoaSBFTx7hzA0LZEPKVA8kTgYnyBeYJ6B9+QCPBl5QOSSELuEYL5kcfoKgbLGkM+SvG6n2+kBMeSqhsTNXewK0i1C5K0oqjoYj/1aW85gqxD0r72/4iPRF00b/NNaEjqmhGfBvnfkvp4ByEyAi7lUBId3vNjW9LSeSzb7y3VXm2zsDiWKEWY9fqh9AN1K4OCGzwHRScwlH5QTsueecXoFZwG/f0Q22RFFsUGuC23kRxOy/GlFG6d8cBw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(426003)(356005)(81166007)(36756003)(82740400003)(40480700001)(40460700003)(86362001)(2906002)(966005)(70586007)(316002)(2616005)(8676002)(54906003)(110136005)(478600001)(41300700001)(8936002)(5660300002)(7696005)(4326008)(82310400005)(70206006)(186003)(36860700001)(26005)(1076003)(16526019)(47076005)(336012)(83380400001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 00:08:20.5529
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 935d5ed3-c626-4b7d-6a2e-08dabb9d2f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4460
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Current systems support Firmware-First model for hot-plug. In this model,
firmware holds the responsibilty for executing the HW sequencing actions on
an async or surprise add and removal events. Additionally, according to
Section 6.7.6 of PCIe Base Specification [1], firmware must also handle
the side-effects (DPC/AER events) reported on an async removal and is
abstract to the OS.

This model however, poses issues while rolling out updates or fixing bugs
as the servers need to be brought down for firmware updates. Hence,
introduce support for OS-First hot-plug and AER/DPC. Here, OS is
responsible for handling async add and remove along with handling of
AER/DPC events which are generated as a side-effect of async remove.

The implementation is as follows: On an async remove a DPC is triggered as
a side-effect along with an MSI to the OS. Determine it's an async remove
by checking for DPC Trigger Status in DPC Status Register and Surprise
Down Error Status in AER Uncorrected Error Status to be non-zero. If true,
treat the DPC event as a side-effect of async remove, clear the error
status registers and continue with hot-plug tear down routines. If not,
follow the existing routine to handle AER/DPC errors.

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
pcieport 0000:00:01.4: pciehp: Slot(16): Card present
pci 0000:04:00.0: [8086:0a54] type 00 class 0x010802
pci 0000:04:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
pci 0000:04:00.0: Max Payload Size set to 512 (was 128, max 512)
pci 0000:04:00.0: enabling Extended Tags
pci 0000:04:00.0: Adding to iommu group 37
pci 0000:04:00.0: BAR 0: assigned [mem 0xf2400000-0xf2403fff 64bit]
pcieport 0000:00:01.4: PCI bridge to [bus 04]
pcieport 0000:00:01.4:   bridge window [io 0x1000-0x1fff]
pcieport 0000:00:01.4:   bridge window [mem 0xf2400000-0xf24fffff]
pcieport 0000:00:01.4:   bridge window [mem 0x20080800000-0x200809fffff 64bit pref]
nvme nvme1: pci function 0000:04:00.0
nvme 0000:04:00.0: enabling device (0000 -> 0002)
nvme nvme1: 128/0/0 default/read/poll queues

[1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
    https://members.pcisig.com/wg/PCI-SIG/document/16609

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/pci/pcie/dpc.c | 61 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index f5ffea17c7f8..e422876f51ad 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -293,10 +293,71 @@ void dpc_process_error(struct pci_dev *pdev)
 	}
 }
 
+static void pci_clear_surpdn_errors(struct pci_dev *pdev)
+{
+	u16 reg16;
+	u32 reg32;
+
+	pci_read_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, &reg32);
+	pci_write_config_dword(pdev, pdev->dpc_cap + PCI_EXP_DPC_RP_PIO_STATUS, reg32);
+
+	pci_read_config_word(pdev, PCI_STATUS, &reg16);
+	pci_write_config_word(pdev, PCI_STATUS, reg16);
+
+	pcie_capability_read_word(pdev, PCI_EXP_DEVSTA, &reg16);
+	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, reg16);
+}
+
+static void pciehp_handle_surprise_removal(struct pci_dev *pdev)
+{
+	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
+		return;
+
+	/*
+	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
+	 * removal might be unexpected, errors might be reported as a side
+	 * effect of the event and software should handle them as an expected
+	 * part of this event.
+	 */
+	pci_aer_raw_clear_status(pdev);
+	pci_clear_surpdn_errors(pdev);
+
+	/*
+	 * According to Section 6.13 and 6.15 of the PCIe Base Spec 6.0,
+	 * following a hot-plug event, clear the ARI Forwarding Enable bit
+	 * and AtomicOp Requester Enable as its not determined whether the
+	 * next device inserted will support these capabilities. AtomicOp
+	 * capabilities are not supported on PCI Express to PCI/PCI-X Bridges
+	 * and any newly added component may not be an ARI device.
+	 */
+	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
+				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ));
+
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_TRIGGER);
+}
+
+static bool pciehp_is_surprise_removal(struct pci_dev *pdev)
+{
+	u16 status;
+
+	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
+
+	if (!(status & PCI_ERR_UNC_SURPDN))
+		return false;
+
+	pciehp_handle_surprise_removal(pdev);
+
+	return true;
+}
+
 static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct pci_dev *pdev = context;
 
+	if (pciehp_is_surprise_removal(pdev))
+		return IRQ_HANDLED;
+
 	dpc_process_error(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-- 
2.17.1

