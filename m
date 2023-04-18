Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9787D6E6DDC
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbjDRVFv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjDRVFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:05:47 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2086.outbound.protection.outlook.com [40.107.96.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBFB49031;
        Tue, 18 Apr 2023 14:05:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h0iEvH/U0HPV1aVZSvCW25cBHeNRJ0z7ak2Gk+HwGZli9i7g1jGUTTdubIGImkhmqdXdZKXz+Eobl8OLPeBi0DFExtElq50/SOd/UVsB/5pdWvCLFTzzz3HmeQyaP9Wrf04pIVXKnwx7s7FoWZBAdL4SSM+oW/vdzVezEWaG6iPE1vMS0UsDpREuXUxmneUD2RVvK4gG1g2C+yPy+qew4zSiQy3SsqU3MSzpJx3tVCWVLuutfRnTradc1IAkJueqxjsk9B+4Qr81AF/RVz4mVMvPlGfMD7gMJ9Tsy1g6IcCzT/n/9yJ1Xt1Jr64qVAiNX543ytvn6LCbBdFDOG/z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUPcbBKETtUo3RZHR2pekMCFyls3hE1EC7o6j1moNmg=;
 b=FZ6HUtymrCUVgFHYHH9cVFvbtDNgbSo7H9l1ROxxCfPuOKuxVRpXz+QAobSuJ7hC9ajYNXDvSwSb8uJJQjJltpurv2qAO2113+2xyHr4XLE5BQpHZfsemwZVqAG1xlYaXm33snCep4ds2SBdRcVjWir91T+0BSOW+v+OSEG5zIG7NN1MGadEhT+uWGz5BSutFTnRkXcN3mFrWQUtOU7gsyMqTkGhmg3ZTO3AbwVUlDqnEE+ot24bCcOzFka9lX2XV4DP1qDNSeuVS/3Oiq6rSw7MVhEACIPB7PowWPuBl8MXsItRyWCeP2UI+Wcy/VOus8Il7WthzomA9l7DAlYpNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUPcbBKETtUo3RZHR2pekMCFyls3hE1EC7o6j1moNmg=;
 b=ZPyBErovOazOPxEf+o9zGqTauLr4Xl0SRVEMzCRA04PxLTOmN7fIDHPVAgOZzLm2vUfcRymAICAJg2LDkKns6Km2uBqMdONaVnv32S2cCbn4/jRqTNJnjOenELb1tvf/EE9BVKStlFH8e3HMob8beDqfLL7r08W5SxH0Xv4c/1k=
Received: from MW4PR03CA0223.namprd03.prod.outlook.com (2603:10b6:303:b9::18)
 by LV2PR12MB5872.namprd12.prod.outlook.com (2603:10b6:408:173::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.45; Tue, 18 Apr
 2023 21:05:43 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b9:cafe::52) by MW4PR03CA0223.outlook.office365.com
 (2603:10b6:303:b9::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.46 via Frontend
 Transport; Tue, 18 Apr 2023 21:05:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.20 via Frontend Transport; Tue, 18 Apr 2023 21:05:42 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 18 Apr
 2023 16:05:41 -0500
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
Subject: [PATCH v2 1/2] PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
Date:   Tue, 18 Apr 2023 21:05:25 +0000
Message-ID: <20230418210526.36514-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230418210526.36514-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT003:EE_|LV2PR12MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 95197c22-df2c-42ad-1bfb-08db4050abcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NwBWlp5l6tk03CBMksHAXqcKNkA/ICWE/XFDSBM+EpI9eC0HHf4BRG5Mqxl1j68UngHe3KvE0ujC/XCo6UjJvE5cFV1pCZaBFnCxnc9V70Ns76lj2+1SER+Mi8dI7+Qb4XuUYmK+xFfHikdnax2Suq4u8FP/bkSeDy7P7tjXzeAsg4nUQGNloGEg6XpFlT7CHWE4uaAy3cSItWrxDY1+K7TxbaHrQsC+6EwuWuOAFBTP2Fx4FpIv1GtimzxHhpS5bemKk5VyQO0cmPThmYhlcspaQJUAdJmUE04v9rMG2A0RYNq7Z5B9t0iCNxW2WQB+BKZzBjR0NApdH8ZS50ygMZfbCWHkOyEjF7k5ImwNyy0jdkBvlqnoOpN2qnm/YR1z50lWp7ylwOa8c+l1VxH4/bsApd/e5aPZoLCvOVj1Zy/AgBGMQbMtaWqaMa7GNYD03pEskWYz48t3qver3tO4pWbisT7+Okzhe3qaA8Qke+mBRi26WjjlRzjG0FAOKYdXOm6AkwGeHSEdMACds2PMz9xWRB9uujWUMiEFgo+61e4tqAOCz1oqzOdponEWDY+9seMj4z2FpTtPyISIM+dtHIMMLhmA6vsOGrzCsiOWv10qELZsAKb3xtbmG/oJyyEHx6AneDHLy+M/xZdYYyRNJfSUEoPyf6FvneVCHOjCPbwoo2mmwUND7ZqgTsT8Zd5TVyrMswANRnk60rCewJctjY2J/a3K1hTa4xtuiDT1VCH3GZ+6vfJyIsRorW5kYBasr0SC13HsOQc2SCvqCBCj/g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(40470700004)(36840700001)(356005)(82740400003)(26005)(1076003)(40460700003)(81166007)(336012)(40480700001)(47076005)(426003)(16526019)(83380400001)(36860700001)(186003)(2616005)(5660300002)(8936002)(8676002)(2906002)(36756003)(41300700001)(316002)(86362001)(6666004)(478600001)(966005)(7696005)(70206006)(4326008)(70586007)(54906003)(110136005)(82310400005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2023 21:05:42.4308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95197c22-df2c-42ad-1bfb-08db4050abcd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5872
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to Section 6.7.6 of PCIe Base Specification [1], async removal
with DPC and EDR may be unexpected and may result in a Surprise Down error.
This error is just a side effect of hot remove. Most of the time, these
errors will be abstract to the OS as current systems rely on Firmware-First
model for AER and DPC, where the error handling (side effects of async
remove) and other necessary HW sequencing actions is taken care by the FW
and is abstract to the OS. However, FW-First model poses issues while
rolling out updates or fixing bugs as the servers need to be brought down
for firmware updates.

Add support for async hot-plug with native AER and DPC/EDR. Here, OS is
responsible for handling async add and remove along with handling of AER
and DPC events which are generated as a side-effect of async remove.

The implementation is as follows: On an async remove a DPC is triggered
along with a Presence Detect State change. Determine it's an async remove
by checking for DPC Trigger Status in DPC Status Register and Surprise Down
Error Status in AER Uncorrected Error Status to be non-zero. If true, treat
the DPC event as a side-effect of async remove, clear the error status
registers and continue with hot-plug tear down routines. If not, follow the
existing routine to handle AER and DPC errors.

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

Please note that, I have provided explanation why I'm not setting the
Surprise Down bit in uncorrectable error mask register in AER.
https://lore.kernel.org/all/fba22d6b-c225-4b44-674b-2c62306135ed@amd.com/

Also, while testing I noticed PCI_STATUS and PCI_EXP_DEVSTA will be set
on an async remove and will not be cleared while the device is brought
down. I have included clearing them here in order to mask any kind of
appearance that there was an error and as well duplicating our BIOS
functionality. I can remove if its not necessary.

On AMD systems we observe Presence Detect State change along with DPC
event on an async remove. Hence, the errors observed are benign on AMD
systems and the device will be brought down normally with PDSC. But the
errors logged might confuse users.
---
 drivers/pci/pcie/dpc.c | 50 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index a5d7c69b764e..78559188b9ac 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -293,10 +293,60 @@ void dpc_process_error(struct pci_dev *pdev)
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
+static void dpc_handle_surprise_removal(struct pci_dev *pdev)
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
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_TRIGGER);
+}
+
+static bool dpc_is_surprise_removal(struct pci_dev *pdev)
+{
+	u16 status;
+
+	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
+
+	if (!(status & PCI_ERR_UNC_SURPDN))
+		return false;
+
+	dpc_handle_surprise_removal(pdev);
+
+	return true;
+}
+
 static irqreturn_t dpc_handler(int irq, void *context)
 {
 	struct pci_dev *pdev = context;
 
+	if (dpc_is_surprise_removal(pdev))
+		return IRQ_HANDLED;
+
 	dpc_process_error(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-- 
2.17.1

