Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727B361421E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Nov 2022 01:08:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229929AbiKAAIq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Oct 2022 20:08:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiKAAI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Oct 2022 20:08:27 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D8501274C;
        Mon, 31 Oct 2022 17:08:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIEUudF4H6aybkCaPBXVQ4c+08dSIVtzLYDzJLxJ+HMS4KqBMsIp5ZcXQ7qGW3ijyv4l447a4OmWL7KAH9r6SOILHEVvaL1Hr+x/svhveMRT1YfgPD4ILxPTaozVr/NNd3PN6+Z06STeDDr5rn0KvwPgEss20YeoFRJmN/ys1jVVDUK09hddRI0DSNwN2wlO9C2GL+6wjrzY9jhYA6bYonN858waB0KD/YSO7qAk09A3n9hAok6PrxA9T65X8UDv9ue1KyyirQtVUztaDV/j3yPyYEsBUFjmBP4ROcs5KNqNrmEAf+R7US3yM6MLTEOPbBU4R+LkqgYjF8IqI7bVtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cWJzDMZpOrsQ51GHHzkjNef53mdTyoqh33A6NJGnwk=;
 b=W3fBqhma14MVvnIgaDMeZYJy9aGPb6rtkWetgBEHG1wcfCAhGNuwijpWdaRaf8u7arXqOMhjRItNSq9fdZZkokPkFwFfaCcQjPsMmmSmgWqcNerIIyq7ouTx2+/+SCsY+R/vxwmxkHH00gJPXG0g1ulnQ55KuRPnfK6/WRUgPt8Lk9FkBpnLO9IvIDFPZVHDwiuswYLBaV61DPELnj6bO8Lm3QcZCqhy07OzrzCyZB8dSERWh0XCu27Xw2uMylM9oYyeCAQrzdHh/IgMBdDb6u1dbH2GerGv24dCnup1J/nN34uo7GgHifCg1WSVT8KhWVE1TH5WcZ2fVYxSknglzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cWJzDMZpOrsQ51GHHzkjNef53mdTyoqh33A6NJGnwk=;
 b=D5ghAgsuCNTWvzoiRkyRc46sjgzDinAJbasd+w0NuEWp28PTGIrBSKIVpF6Xh9HQeXvRrosM3Ftt34HcqOw5udcnGIWWW0xgqWBAyx1lEK2/qrKdWC7OjYxQgxjKYAuC23csCMrVzp2+pKW14pmnIpO2kXfF5jrqN7dWnCQyUss=
Received: from MW4PR04CA0216.namprd04.prod.outlook.com (2603:10b6:303:87::11)
 by PH8PR12MB6673.namprd12.prod.outlook.com (2603:10b6:510:1c0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Tue, 1 Nov
 2022 00:08:24 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::2c) by MW4PR04CA0216.outlook.office365.com
 (2603:10b6:303:87::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19 via Frontend
 Transport; Tue, 1 Nov 2022 00:08:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5769.14 via Frontend Transport; Tue, 1 Nov 2022 00:08:24 +0000
Received: from ethanolx50f7host.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 31 Oct
 2022 19:08:21 -0500
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
Subject: [PATCH 2/2] PCI:pciehp: Clear 10-bit tags unconditionally on a hot-plug event
Date:   Tue, 1 Nov 2022 00:07:19 +0000
Message-ID: <20221101000719.36828-3-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|PH8PR12MB6673:EE_
X-MS-Office365-Filtering-Correlation-Id: 637601dc-b3de-4580-8048-08dabb9d3199
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icIqI6oc6nOSotqGltCC/htx2628iZsOKWXGyd84Yv3yttJ38dNdPhYmK4yw22oXVIJGGr+3ydRSCe8VSQLX5FFQdmWbLkLwP2GoQYl0XLhUzlbS5vGP3++DBxxx03BWF+f7Zn18fo880/E6dByzxNM3gB+CIlOqQeDvDRpkEDKCnAF5Ba8YnxUsmDYkPjvL4iBKbLTuTW5snBgbmmhlX618Zc/fP6szFGImBp7DdQZTEcNGTkpf5j3s4BJf8YCT5q3tryGCgCYgPk+jgBJtVpXOfIrH0vOZKtYiA++WFq9O2JpVQMqtaFuN3hf8sMQmrJhnmkfS6EnFyzrLKwkgzn4dA1AODtpSkwtV4G6ZB0yH0CzLswa5gEgdFJXHBk7eIVi6S1Z2mTO5yu9rp6huj8Y0twPKo3fk6MtSNDamf2/WR5Dh3IFvufgBiRTawfkixI1PIcWBzaLeEXQzruuPlaE494uqM6J+8kmXs8r5zE+hoUeg+8V3tPcGdp/jZpBLNax5b93Z/SOl9Th6yLMRSmZlMb2xo5OkjItw/3k+JDbqvs4Mj3cRpNl5DVXIuP9sat+sXNGa3LvTOzZlLkwUPkP3ZLij7uDrzqS4AAsEuGvu/7VxVNfadQbQg3DvjKTVTCP6PDtBN0PIUIUlvb31RPMYlx5+n7vsVskLCepkIU36+v+e7wGo5kqwl/v6M5ksC3505xATUK4IJokrQjWd8rfMjgNOnpebYnjKszwENNxPamahLYyEvYMAQRz/CsOgkq8m54IinVEHn6qoTAyzkqJw0T43QmUGTentU6BmmCE=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(396003)(136003)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(40480700001)(478600001)(54906003)(70586007)(316002)(70206006)(110136005)(86362001)(7696005)(4326008)(8676002)(426003)(47076005)(82310400005)(2906002)(336012)(36860700001)(26005)(40460700003)(41300700001)(356005)(81166007)(1076003)(16526019)(186003)(2616005)(82740400003)(83380400001)(8936002)(36756003)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2022 00:08:24.1187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637601dc-b3de-4580-8048-08dabb9d3199
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6673
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Clear 10-bit tags unconditionally as there is no guarantee that the next
device inserted will support this feature.

Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
---
 drivers/pci/pcie/dpc.c        | 3 ++-
 include/uapi/linux/pci_regs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e422876f51ad..8e02a32134ab 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -331,7 +331,8 @@ static void pciehp_handle_surprise_removal(struct pci_dev *pdev)
 	 * and any newly added component may not be an ARI device.
 	 */
 	pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
-				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ));
+				   (PCI_EXP_DEVCTL2_ARI | PCI_EXP_DEVCTL2_ATOMIC_REQ |
+				    PCI_EXP_DEVCTL2_TAG_REQ_EN));
 
 	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 57b8e2ffb1dd..65e1075b7db1 100644
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

