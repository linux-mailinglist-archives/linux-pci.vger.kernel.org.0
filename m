Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A53F8738F3A
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 20:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230518AbjFUSxI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 14:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231550AbjFUSxB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 14:53:01 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD83199B;
        Wed, 21 Jun 2023 11:52:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JmxatZT2OpWHzHDWZn3P6R7qOKg42y+imqJiJU7vDTZfZGjBRpXsYJHO61k0aIsZETZXE90Zn/NwBp6khHvPfm5WUvQABC6iRB9PCxMQukQVMyFywj1Sdf/sjC9MMH552jfDMFhf3P3wPe+hIC3v5x1KGG/P1IUBMTtlCp6SHQMT967FrRc/zU/6mlsvceKpQI7oxQmDT4Iy1J/KO8g7CxJZWpsIqPwARfDq+mAwuGs38DUGop5klSoLpo/mDo1woZZJIw1r+xYlyhqbmUi+vxZMBjmmmjOU7zyAkuXmX73XnMNknumcSZMlB7Zej1Uwz8fgqYCXSaYlsYajfwtaDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhHmFwSHvWZXFAuUVeIaaDvrn7rpDuXcxvDDmpZMcq8=;
 b=SiUB9IabHRAvYKJ5VCZuy5nWZ3hBXU8qxSLvFtF+sDmSqFYFi6dT7sz2o4oj9y0WtiGuDGBr7RokqUsdSPTLHdKk5VFtSQ0/jbjazZE46MbCdreEIQIA2VXY6yRpQ7YJilfB2v/m61lmSNEwMlwG0Wp1S6zCo+NR3n2LYFTloykiV2yk6lsZQ7V6/FSixlqPnl5V2Z6JIN6LYD0Ca4qno5IicMKebCltW/O2MiyB19zFMv23CzcXTCUkaeLFSHDMeDvN82IkTPZF4j60mx4NtBFgIV9/kamxfECCHaGsD9QY0QhHSaWnH3xzmzvuajSHpF8F1T3/9TSQTvul6/R80A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhHmFwSHvWZXFAuUVeIaaDvrn7rpDuXcxvDDmpZMcq8=;
 b=WcP6kKzcXdxcL1Vh/Xgbwx3CpXMR6BFdqI+oKtLFpTcxUnDHie7w0AdIrt5sC+dSCT5ET8fE0FHQ9BT4B6nNS40TAA3GHf/Zt2tjBb7g0JJ59kQwqdqa2aef/uOtdkBlm3AynMKZ97eL+3lKF8HUG3QQ/8iC/hcM1wbL8QTaFr8=
Received: from BYAPR02CA0036.namprd02.prod.outlook.com (2603:10b6:a02:ee::49)
 by SN7PR12MB7203.namprd12.prod.outlook.com (2603:10b6:806:2aa::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Wed, 21 Jun
 2023 18:52:54 +0000
Received: from MWH0EPF000971E8.namprd02.prod.outlook.com
 (2603:10b6:a02:ee:cafe::94) by BYAPR02CA0036.outlook.office365.com
 (2603:10b6:a02:ee::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21 via Frontend
 Transport; Wed, 21 Jun 2023 18:52:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E8.mail.protection.outlook.com (10.167.243.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6521.17 via Frontend Transport; Wed, 21 Jun 2023 18:52:54 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 21 Jun
 2023 13:52:52 -0500
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
Subject: [PATCH v3 2/2] PCI: pciehp: Clear the optional capabilities in DEVCTL2 on a hot-plug
Date:   Wed, 21 Jun 2023 18:51:52 +0000
Message-ID: <20230621185152.105320-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E8:EE_|SN7PR12MB7203:EE_
X-MS-Office365-Filtering-Correlation-Id: 19b5df84-a93c-40c7-fe98-08db7288b8b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /0FuQScoi3BySsUb4TrRYwtD6F9BIsb5wr6PsMhfS+r35SxuslmxatTe0zC7snfA6DM6FfNsxj/AZnYyyoZ+QIHm1AY2QTCHA2pBpb844P4fFS9ZBUwLMQLnSs/YMcXXqz6YuEYep7b38uV2Nc5uOH9Kv4NwGvXWK1vk5dBr+j+gfebnogqcK37mYLM+OwBEiBnvmBKojIAsZC7ksCi2i3DXsO5IpybE2mi5hEtdPi1Z5mf6dfhZdw1yefqc+vCNOkDLOmRfhscOpDCQQDEQDygCd5YWAU5x4zO2/RdTfW6ZXX29A7FnH9eOMNnuBQxx/Of0qJbP89lmnZPOWv5vIe4mkV3I8x9IH/Rl624rBZ9OcR4DuBiEMYUl9r2I34EYgiTlP7mUtY43fif+Kg5CHnBWb3VQ7PU4KpCCmKU3ZOc54oS3WZ+k0/+77D2SdxbJkvSTHPFbw/6ybrO/5N2wE+7RCr+RbYjG5mMsZ8swwAFp+9NrARInZ35mA6VjiPtvNlYPoSt749D0xpsEP0LX+kUAxKbHiRDt2PuQObVJ0bZPKZlqUuzAGBXUx4BKRmUJetajbHHyMvCpqd7OFMhsr4PHKIt1D0MK7w8NxEbuk8gNl4tXyg7RShHveyxR1FFR+F2RytKJGkVUSVt3RI5508cOm75X+ybgrSu9GtMeUAPIR/NcBaptA+Fc1WCa3QXpVneh3gHFh+MXtvUvOES/6QsmCI/dWRbKsNO8KNv/iAHOgQx85mvxX7MObVWrPwr7c+2/+khVKsTFeAYEKN0E2w==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(396003)(136003)(346002)(376002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(81166007)(478600001)(70206006)(7696005)(36756003)(83380400001)(110136005)(54906003)(70586007)(40460700003)(4326008)(316002)(86362001)(26005)(36860700001)(16526019)(186003)(2616005)(966005)(1076003)(356005)(336012)(82740400003)(8936002)(8676002)(41300700001)(2906002)(5660300002)(426003)(47076005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2023 18:52:54.1417
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19b5df84-a93c-40c7-fe98-08db7288b8b3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7203
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

Clear the optional capabilities ARI Forwarding Enable, AtomicOp Requester
Enable and 10-Bit Tag Requester Enable in DEVCTL2 unconditionally on a
hot-plug event. These are the bits which are negotiated between endpoint
and root port and should be re-negotiated and set up for optimal operation
on a hot add.

According to implementation notes in 2.2.6.2, of PCIe Base Specification
[1], "For platforms where the RC supports 10-Bit Tag Completer capability,
it is highly recommended for platform firmware or operating software that
configures PCIe hierarchies to Set the 10-Bit Tag Requester Enable bit
automatically in Endpoints with 10-Bit Tag Requester capability. This
enables the important class of 10-Bit Tag capable adapters that send
Memory Read Requests only to host memory". Hence, it must be noted that
Platform FW may enable these bits if endpoint supports them at boot time
for performance reasons even if Linux hasn't defined them.

Issues are being observed where a device became inaccessible and the port
was not able to be recovered without a system reset when a device with
10-bit tags was removed and replaced with a device that didn't support
10-bit tags.

Section 2.2.6.2, in PCIe Base Specification also implies that:

* If a Requester sends a 10-Bit Tag Request to a Completer that lacks
10-Bit Completer capability, the returned Completion(s) will have Tags
with Tag[9:8] equal to 00b. Since the Requester is forbidden to generate
these Tag values for 10-Bit Tags, such Completions will be handled as
Unexpected Completions, which by default are Advisory Non-Fatal Errors.
The Requester must follow standard PCI Express error handling
requirements.

* In configurations where a Requester with 10-Bit Tag Requester capability
needs to target multiple Completers, one needs to ensure that the Requester
sends 10-Bit Tag Requests only to Completers that have 10-Bit Tag Completer
capability.

Additionally, Section 6.13 and 6.15 of the PCIe Base Spec points out that
following a hot-plug event, clear the ARI Forwarding Enable bit and
AtomicOp Requester Enable as its not determined whether the next device
inserted will support these capabilities. AtomicOp capabilities are not
supported on PCI Express to PCI/PCI-X Bridges and any newly added
component may not be an ARI device.

[1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
    https://members.pcisig.com/wg/PCI-SIG/document/16609

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
v2:
	Clear all optional capabilities in Device Control 2 register
	instead of individually clearing ARI Forwarding Enable,
	AtomicOp Requestor Enable and 10-bit Tag Requestor Enable.
v3:
	Restore clearing only ARI, Atomic Op and 10 bit tags as these are
	the optional capabilities.
	Provide all necessary information in commit description.
	Clear register bits of the hotplug port.
---
 drivers/pci/hotplug/pciehp_pci.c | 4 ++++
 include/uapi/linux/pci_regs.h    | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..e27fd2bc4ceb 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -102,6 +102,10 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 
 	pci_lock_rescan_remove();
 
+	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_DEVCTL2,
+				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ |
+				    PCI_EXP_DEVCTL2_TAG_REQ_EN));
+
 	/*
 	 * Stopping an SR-IOV PF device removes all the associated VFs,
 	 * which will update the bus->devices list and confuse the
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index dc2000e0fe3a..6fbc47f23d52 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -668,6 +668,7 @@
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
+#define  PCI_EXP_DEVCTL2_TAG_REQ_EN	0x1000  /* Allow 10 Tags for Requester */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
 #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
-- 
2.17.1

