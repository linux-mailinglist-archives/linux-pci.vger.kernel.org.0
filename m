Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23EB277D507
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 23:21:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240217AbjHOVVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240204AbjHOVVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 17:21:05 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2075.outbound.protection.outlook.com [40.107.92.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6349983;
        Tue, 15 Aug 2023 14:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oL/8kNWlB5MPRiDosyTFAMi4OvO7+ztJtbblfMVsP8tBWI+UbGItujmMqUOY+nWRuVYvQk7UZKzHC0NB6fMDUg6xJccJoMa/JXFlp4KOhadRENlGg07a1pb8DU6LiWUIDclhsyBNSUxc13P6J5PugsF4vdH+WD+yy+vEddj7L0RhKArft7PfgypApZX1cEuZTcch9vEflw4DMlgsyQ3G+WM4l0lQFLgUWMf/1sSkYOdvT57DWaRxDWdlQpgKgGuTF4+6iGTe5wSYe7YvxkYtaQ48MS6HphDyyWf+0EjAhE0FysW6pBlb9k8DPkosnpPaJK/cwDgckraUSY5ECFFtWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cWprRObvXf9OMNdL4a+rtxGP6oo5OXfa43tOgS1W80o=;
 b=Cc3b359Voe0CBe35Czxr28DNBBFI8VfjeAu3UDnB8ob+IIyPTSqau1rGBhSC1hB7JC1O+fqufsmHq3rkFyBLe1fmkyET3slB7EyDibfoicY68Ur0DzQabMa4oh/MHo0OomecGk3vleUCcNZUgYZUuRj49aX/P2/u++cJtNMzOe4UvfKxHUkLDjRFXJllpyCAbAqjlCmnJzrYh5e/mRUosuhuK35MBQNUh7zCAJ5NI1oavx0mv+ospW1e17bdAGvcLn9UW1Vff5mnJDMiFK2xwqNfShpytOpJn671agUK1E0zHjxEFxztv1Zm0zus9YiHPmffrl76FdwHw2SyrYgatg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cWprRObvXf9OMNdL4a+rtxGP6oo5OXfa43tOgS1W80o=;
 b=XJfq+/9j/HImxz7IjljY3ASXz2mSYLZ+3VcF08R46XqRPw3U0YN+kEPvGQDqUgwnVUE9u6aT5/wh+5HzPfuya/ouUaupmRMWrmtCVkyTpZCGvZNwuZrCU8xta2MZN5sjgfPb6fLLX+SCspoJUEwVP98TFy0Oltw+5IbMPPRvvBA=
Received: from MW4PR03CA0027.namprd03.prod.outlook.com (2603:10b6:303:8f::32)
 by MN0PR12MB6126.namprd12.prod.outlook.com (2603:10b6:208:3c6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:21:01 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::5d) by MW4PR03CA0027.outlook.office365.com
 (2603:10b6:303:8f::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 21:21:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 21:21:01 +0000
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
Subject: [PATCH v4 2/3] PCI: Enable support for 10-bit Tag during device enumeration
Date:   Tue, 15 Aug 2023 21:20:42 +0000
Message-ID: <20230815212043.114913-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|MN0PR12MB6126:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fb83442-6391-43f4-8f0d-08db9dd58679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tVhZTYxqindjIRlIYI/BGwP+1ba9DaPbGxSCR1dnadNpwqeLDmrbdYioscGS96CWj5ZLYaAcishzNLGG4GKYziU3di+izjtu8bo1oPek+E0blYkwhDyBwA/1QhdjfA8Uh3sDeMDX9LbN9zp0qCAar7FjQNJD5aIDd6ltE1Y18AsDlPMCcAenp8HCLxMm+HHOmoar25HBSScRzyaWA2r/gVniS/y1RB4kgBdVazkjcyYHFEF5FlPVeglImuqllL/3hQJZZDXRqXe/YWkco7tW1Y+QE2U8fDlx7bNUYHDTRKG5LpjHju5pPttY8tXiTrPwFjz+FCJcXVxWOpP195JNckpGTxNoP6qBjymwjBe+l1X/6Rm4e1gQGXX0LqvSiF/GRz9/5PGydYHK9gM9urp/Bd7eETZGAVIl/Dw4z/+7RbvEtqUlB194u7nplYIP9Db4n39dQdQ5B9taSPbmT/7kWrQwMHIc1qMsBNwGc3R/kZFobdhVR7tKafW0idfno9NMyEYBcSWpn1fHzUE7dr3zHHuJGL3KOXuKRbVzucTehHTCXtqzYXNIgXF9XaN1a+oOEtt3jm+gcpOnoche9rKdPSPsuOqiSuLC2gRb4gdFfDwlFFYF/OgqZu6hmHzo1T33Kq4APpgl7DcnZJjcV1jokKW2DjfKooFexUIjO616dDwm+P7hIW5aN+d5KLcqr4chh86u0NkYdyFJTNbUIcQl1GgmsaxGIDl+LKWNo4gk9qs604C9welmhIz7DV+Ua2ONmfLSSoJt9eqc7LdlDCfI/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(396003)(346002)(376002)(1800799009)(82310400011)(186009)(451199024)(36840700001)(40470700004)(46966006)(2906002)(8936002)(8676002)(4326008)(966005)(478600001)(86362001)(83380400001)(110136005)(1076003)(54906003)(7696005)(426003)(16526019)(336012)(47076005)(5660300002)(40460700003)(41300700001)(316002)(70206006)(2616005)(36756003)(356005)(70586007)(6666004)(26005)(36860700001)(40480700001)(82740400003)(81166007)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:21:01.1046
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fb83442-6391-43f4-8f0d-08db9dd58679
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6126
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Enable support for PCI Express 10-bit Tag.

A requester may use 10-bit Tag only if its "10-bit Tag Requester Enable"
control bit (PCI_EXP_DEVCTL2_10BIT_TAG_REQ) is set. Enable 10-bit Tag
Requester Enable if the requester supports 10-bit Tag Requester capability
and its completer supports 10-bit Tag Completions.

Platform FW may enable 10-bit Tag Requester during boot for performance
reasons as per PCIe r6.0 sec 2.2.6.2 [1]. It states that "For platforms
where the RC supports 10-Bit Tag Completer capability, it is highly
recommended for platform firmware or operating software that configures
PCIe hierarchies to Set the 10-Bit Tag Requester Enable bit automatically
in Endpoints with 10-Bit Tag Requester capability".

And, failure to enable 10-bit Tag appropriately has led to issues reaching
to the device. The device became inaccessible and the port was not able to
be recovered without a system reset when a device with 10-bit Tag was
removed and replaced with a device that didn't support 10-bit Tag.

PCIe r6.0 sec 2.2.6.2 [1], also implies that:

* If a Requester sends a 10-Bit Tag Request to a Completer that lacks
10-Bit Completer capability, the returned Completion(s) will have Tags with
Tag[9:8] equal to 00b. Since the Requester is forbidden to generate these
Tag values for 10-Bit Tags, such Completions will be handled as Unexpected
Completions, which by default are Advisory Non-Fatal Errors. The Requester
must follow standard PCI Express error handling requirements.

* In configurations where a Requester with 10-Bit Tag Requester capability
needs to target multiple Completers, one needs to ensure that the Requester
sends 10-Bit Tag Requests only to Completers that have 10-Bit Tag Completer
capability.

Hence, ensure whether these capabilities are re-negotiated and enable them
appropriately, especially when a device is surprise removed and replaced
with a new one.

[1] PCI Express Base Specification Revision 6.0, Dec 16 2021.
    https://members.pcisig.com/wg/PCI-SIG/document/16609

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/pci/pci.c             | 59 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.h             |  1 +
 drivers/pci/probe.c           |  1 +
 include/uapi/linux/pci_regs.h |  3 ++
 4 files changed, 64 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0..7e640694fa03 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3795,6 +3795,65 @@ int pci_rebar_set_size(struct pci_dev *pdev, int bar, int size)
 	return 0;
 }
 
+/*
+ * pci_configure_ten_bit_tag - enable or disable 10-bit Tag Requester
+ * @dev: the PCI device
+ */
+void pci_configure_ten_bit_tag(struct pci_dev *dev)
+{
+	struct pci_dev *bridge;
+	u32 cap;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	bridge = dev->bus->self;
+	if (!bridge)
+		return;
+
+	/*
+	 * According to PCIe r6.0 sec 7.5.3.16, the result is undefined if
+	 * the value of this bit is changed while the Function has outstanding
+	 * Non-Posted Requests.
+	 */
+	if (!pci_wait_for_pending_transaction(dev)) {
+		pci_info(dev, "Transaction in progress, 10-bit Tag not configured properly\n");
+		return;
+	}
+
+	/*
+	 * According to PCIe r6.0 sec 7.5.3.15, Requester Supported can only be
+	 * set if 10-Bit Tag Completer Supported bit is set.
+	 */
+	pcie_capability_read_dword(bridge, PCI_EXP_DEVCAP2, &cap);
+	if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_COMP))
+		goto out;
+
+	if (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ) {
+		pcie_capability_read_dword(dev, PCI_EXP_DEVCAP2, &cap);
+
+		if (!(cap & PCI_EXP_DEVCAP2_10BIT_TAG_COMP))
+			goto out;
+
+		pcie_capability_set_word(bridge, PCI_EXP_DEVCTL2,
+					 PCI_EXP_DEVCTL2_10BIT_TAG_REQ);
+
+		if (cap & PCI_EXP_DEVCAP2_10BIT_TAG_REQ)
+			pcie_capability_set_word(dev, PCI_EXP_DEVCTL2,
+						 PCI_EXP_DEVCTL2_10BIT_TAG_REQ);
+		else
+			pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
+						   PCI_EXP_DEVCTL2_10BIT_TAG_REQ);
+		return;
+	}
+
+out:
+	pcie_capability_clear_word(bridge, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_10BIT_TAG_REQ);
+	pcie_capability_clear_word(dev, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_10BIT_TAG_REQ);
+}
+
 /**
  * pci_enable_atomic_ops_to_root - enable AtomicOp requests to root port
  * @dev: the PCI device
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index a4c397434057..dee6241878fc 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -239,6 +239,7 @@ int pci_setup_device(struct pci_dev *dev);
 int __pci_read_base(struct pci_dev *dev, enum pci_bar_type type,
 		    struct resource *res, unsigned int reg);
 void pci_configure_ari(struct pci_dev *dev);
+void pci_configure_ten_bit_tag(struct pci_dev *dev);
 void __pci_bus_size_bridges(struct pci_bus *bus,
 			struct list_head *realloc_head);
 void __pci_bus_assign_resources(const struct pci_bus *bus,
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8bac3ce02609..5a3c1ec6fad6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2476,6 +2476,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_pm_init(dev);		/* Power Management */
 	pci_vpd_init(dev);		/* Vital Product Data */
 	pci_configure_ari(dev);		/* Alternative Routing-ID Forwarding */
+	pci_configure_ten_bit_tag(dev); /* 10-bit Tag Requester */
 	pci_iov_init(dev);		/* Single Root I/O Virtualization */
 	pci_ats_init(dev);		/* Address Translation Services */
 	pci_pri_init(dev);		/* Page Request Interface */
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e5f558d96493..b0a41c987ac5 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -656,6 +656,8 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
+#define  PCI_EXP_DEVCAP2_10BIT_TAG_COMP 0x00010000 /* 10-bit Tag Completer */
+#define  PCI_EXP_DEVCAP2_10BIT_TAG_REQ  0x00020000 /* 10-bit Tag Requester */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
 #define  PCI_EXP_DEVCAP2_EE_PREFIX	0x00200000 /* End-End TLP Prefix */
@@ -668,6 +670,7 @@
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
+#define  PCI_EXP_DEVCTL2_10BIT_TAG_REQ  0x1000  /* Enable 10-bit Tag Requester */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
 #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
-- 
2.17.1

