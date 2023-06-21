Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16110738F37
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 20:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231491AbjFUSxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 14:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjFUSw7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 14:52:59 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on20609.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::609])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339861A3;
        Wed, 21 Jun 2023 11:52:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b73KqpFlzxNUl0jL810kLCEZmfd+DCzJQTNb63aDETTtLEQm3KoYBcujHzhIxmP2qAOgs+7dtVsLi00FKbqGr06iN0h80sXXZk9lazfVj2wycR1AmIWnOHraaostpsc9sNA8vSv2dYxFvogaoWjDkJRoQrrffMf484cFog53sqwAiBbECN/vDWyVim6PDx3vjA8LiLpNqwVnAOY5qIsBkn/2yOBzLRA+4W3RL9WPAXSF6OCV+8Qzu51xieif4s37PvBVE1admcgp6Ie3HGdAg1l085PfG+tPTMrtLDN+PkCIwu+h9I79uhWSoLJ5CtnqXYdNQR4DDeL/E59LdA/GPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7bN4HSmSVttb4pezCSDkcoFDaWtS/U8Kyqwu8e9plVI=;
 b=D1BSwSFC1UvaKvx+rXZaekI0hytqLU4rozWvSDzE/QDnqhkVfS7g4+OWH2RfCzUyFLf4gZlcVFaLSOGYhgkuW5Rg98K5iuAJpG2cRsULpw/wrickEt9hr3zOv7Soo0vMZzwpfUhZzfrTeZsmKpFuaVm0yIqPWHBjfjgxtd220pJ3aCWdBgtX8xsCc2WFAZZy5fTXMkkzThL/pMOvs9350ea5MRC/NEdJ4noIDOGQ3PTHTph9001MNWRrLzUoiosSWlnGlfZdieNdRhtVv3qw6tZeY16zRb1Qi7CKhYEw9K9UASJM7nvV9sQ0xEDZGfCExBJ2r5Qezaarmft58vIlAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7bN4HSmSVttb4pezCSDkcoFDaWtS/U8Kyqwu8e9plVI=;
 b=3aFCIvq9fvaBysBleuALcSZllOTak1zhaXAuIzhtOaB2mdvz3WWh/f/QczIv8sqzJ424tv6VeNDsxSSBM0Fw7nNdmLom725UTAqRTkISTemt3PuqfbvXhbIsUzWmglIeTD4AY206EpO3t0i7n574wYRi9khrudvaxhOaK5AnOPs=
Received: from BYAPR02CA0002.namprd02.prod.outlook.com (2603:10b6:a02:ee::15)
 by DM6PR12MB4877.namprd12.prod.outlook.com (2603:10b6:5:1bb::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 18:52:53 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::62) by BYAPR02CA0002.outlook.office365.com
 (2603:10b6:a02:ee::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23 via Frontend
 Transport; Wed, 21 Jun 2023 18:52:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 18:52:51 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 13:52:51 -0500
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
Subject: [PATCH v3 1/2] PCI: pciehp: Add support for async hotplug with native AER and DPC/EDR
Date:   Wed, 21 Jun 2023 18:51:51 +0000
Message-ID: <20230621185152.105320-2-Smita.KoralahalliChannabasappa@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20230621185152.105320-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|DM6PR12MB4877:EE_
X-MS-Office365-Filtering-Correlation-Id: 249d0cd5-a9fd-4c64-48eb-08db7288b75a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AEeZoRZd4NC1+n7DxsixpVor2UiSP596gbio8K71wiYbFiYyfsGZ9RZDshjqyds1Yq/1Bd4gkXx6SQKCSlkFwP0caFCu4bOky/XfJfSuy8J0LkjQrlOWv2tZJp3kKlINAHxemH8NH7ZuySuAsQa3lC2iWYr1W1elUCFfF6BWGmwYGtKyMnBO6r2+/XBzFhMCfZZgh8ChsJQrXwFEFddeIk5Dzql/2t9VLUY09b/FA0WGDjc7pNDIkLVkXJuCFicY9Yt1I/BWqJ4qrfio9XJDGgmRZyVpZwaEu24/n52CkPU4xDVjiYqPFxIGz5F20+EN66y4lThllSqmyYhIBzLsNdSNdIJhIAnA03We2hgIUOBRsdFW2TYyfMd+n2UhTLihYbJDCSjTNIlcCfE0OmOAKMq7/JeSk0UXygLym2et80qln4mmpDs0pW8h2ywHMORsPYG1QmL2ttPsYoZySaN8/L1bKcN34oalcIizFXYaarM8YKLfLd8z61CFN43CJHdGSl0GgE38+LFJ8KIUCRFqI/i8RmwmpA9awMYcu8qPZa1q33zPn/UaHfSyVQcTnkGBr2TUoiiV97BbhFFWlTtwQI2Joc216oWJpagQQim2PfpK8aeps7xBRCNIsrkW3FBDb+LUdKbULjToCwzTXa9CExI8/oqT+dpv1ONBJU9JLKqvIMAPbu3VfmqKrxDZyQN5GfvEkDYLnV0BCIfJi0mJqgW3NGkLsDocDmai6K/hH2ghDpM6+YYdbo1Kp/qbkdb+EpdbspnaPykwfgBpFDRqmQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(136003)(346002)(451199021)(46966006)(36840700001)(40470700004)(54906003)(110136005)(478600001)(4326008)(26005)(966005)(16526019)(186003)(7696005)(1076003)(70586007)(2906002)(82310400005)(41300700001)(8936002)(70206006)(8676002)(5660300002)(316002)(82740400003)(356005)(81166007)(2616005)(86362001)(36756003)(40480700001)(47076005)(426003)(83380400001)(336012)(36860700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:52:51.8760
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 249d0cd5-a9fd-4c64-48eb-08db7288b75a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4877
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

According to Section 6.7.6 of PCIe Base Specification [1], async removal
with DPC may result in surprise down error. This error is expected and
is just a side-effect of async remove.

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
---
 drivers/pci/pcie/dpc.c | 58 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..5153ac8ea91c 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -292,10 +292,68 @@ void dpc_process_error(struct pci_dev *pdev)
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
+	pcie_capability_write_word(pdev, PCI_EXP_DEVSTA, PCI_EXP_DEVSTA_FED);
+}
+
+static void dpc_handle_surprise_removal(struct pci_dev *pdev)
+{
+	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
+		pci_err(pdev, "failed to retrieve DPC root port on async remove\n");
+		goto out;
+	}
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
+	pci_read_config_word(pdev, pdev->aer_cap + PCI_ERR_UNCOR_STATUS, &status);
+
+	if (!pdev->is_hotplug_bridge)
+		return false;
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
+	 * According to Section 6.7.6 of the PCIe Base Spec 6.0, since async
+	 * removal might be unexpected, errors might be reported as a side
+	 * effect of the event and software should handle them as an expected
+	 * part of this event.
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

