Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A403777D0DA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 19:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238806AbjHORUk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 13:20:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238855AbjHORUZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 13:20:25 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F091FED;
        Tue, 15 Aug 2023 10:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T9tLVnQQmxbLC7JngTMCARVqmF7Jlg0skbCcbhToZ86+TrUF6v+ocOk/kSFQjvlUbBhFzsKsmwm1ZFXCZKgnu4BMhETHDxn0RtnwTiAcE3B/3nRmUmg1PKsoMAySA2Rerx/GE3//G6YmBmEmHC+fkJWHmU6hUwxlLxtDblZOBCOcURudA7VuWjssPAb928NJMJR/wXfcmEnopphFOYuEulAER3//LXGI6OTkc89kS0Au/MZKAORwHVT+N2A8s+yt7dtCSkk9NwWscTF8vRY6Gga/MHHrdpm8s9SLTl4Phz+CfAPGCeIDd+qZ08qv7nuw0t3B7jbj9JPfTbtfmt9x9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsNs3+RFfiY/iKi6qTA8+Ipu+qkjh/WS4+AwQNiyk+A=;
 b=BqPF0U/wVHohrgWCYWp31mxB5ZwLEHW033RRhXIItQD3SGyl+ETJOW2OFxSjShpUD/CdRS2RiNojvR7iWMNPjJdWOAc7qPNIKFT7oYK61RHit+pkCBeUqVLV2H23Vb1UyMZk9cPB05nk+X1OZkkoE9mZLf5RNyDNCvfPWsKVbQv4u6JyQa1R2q9G1uq+H4PcSoyl5h06uOYgvprD5aRYhfBSTJUZwv0WwGWsUTAHor2kNzffNNgJ8W/jJYifV4JpJPWLMZ/TPkBTFt6Cgudjoes1hs351OMNGp78yV863xOeKbi2nyBeOdy5/Oa7+uI6zqj2DMaAg0cgQrnHRCiwXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsNs3+RFfiY/iKi6qTA8+Ipu+qkjh/WS4+AwQNiyk+A=;
 b=4+6OXSlZwR5l7n/MTqJCjgNXZE4+HzxVawySHzIleqYyAjXFEruTqhIi4r+CHU/8Q+/kwz6tyEJRBaWMZWM/VVV6Q3LPU6pfow4ZEb0IO3htsaOlVmKiWrLvSknRZIQA8B+Kr2imUqQ0EMOgK8KfeKgYMDJ64vub5pCTuLrPFG0=
Received: from SN7PR04CA0023.namprd04.prod.outlook.com (2603:10b6:806:f2::28)
 by PH7PR12MB9175.namprd12.prod.outlook.com (2603:10b6:510:2e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 17:20:12 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:f2:cafe::38) by SN7PR04CA0023.outlook.office365.com
 (2603:10b6:806:f2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 17:20:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.14 via Frontend Transport; Tue, 15 Aug 2023 17:20:12 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 12:20:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 15 Aug
 2023 12:20:11 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 15 Aug 2023 12:20:10 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V13 3/5] PCI: Add quirks to generate device tree node for Xilinx Alveo U50
Date:   Tue, 15 Aug 2023 10:19:58 -0700
Message-ID: <1692120000-46900-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|PH7PR12MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: 476571ec-7c26-4d47-9180-08db9db3e221
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sLIBME/NEls+iDFXA95ZiPbe82eXoojPTYUu4fruOjtnBhgnpqoYRsr2hQ9aPSMRcMoDlqzbXqflVOmSWT7OZYEtzkxkVoqJszzd1uJSGiFGFP7+18tYdbwroq12QshIoL8kAlM8Q8Ya7/pc8fqHvY7Ub9HCUHsZCecosF8kqoA9Zqvh57be0N1H02Yo5T5BsvrSD0lwKaO6Er60KOUOYrpCES6YiElR3g//33VGoKgvVuHobtVU1kSI187sc7YKzwrX6paXaz5GMED+32aRFR4dEqEZquowFwQAJeO4uXEH8pXwIHQI52lYIBE3jXycCeZR/UwMEw2ddYDy8pg4fMbXUoyAShrqU0ttSE7hGV4EhgN3uNaeEi3QtygbkCKmnbhlMOknGgtwtQl7MIpEJWz4tNyz0IGIXWon/2na6Q86TcOhmY0W9VJWgRUYh8xSrmfSHZWCOYkfnuMWyuD8lOgvaPoWqtrmJj4PyoevANVZYsBWKd6/h68JowBrKfc3XgIBe9tQJaAXuGvJ3kDLJrFw2YYDp1dUySJBU7tthi5VMfWpywETtRdRiobwMx+LDlQp3uE+Z+nZEgB7b9bGf1Sl3z6heGJwxJCirwT6FBqGyjPsF07CCeZK4rXhS7W8NATblNL0fZ9DCPCI2HMJ8RlTj68wgRKULP2gHrMVvh/zS5C30TQyicnYL7fBDzH+swaG6HYAJcFt/tbt9Lc9/oCVWliNeKa1S4tOMhwbJOn+7aTXohG1wIyy5WyYQfbdFAIOBzADCiXRAihttvWWeg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(1800799009)(186009)(82310400011)(451199024)(46966006)(40470700004)(36840700001)(110136005)(2616005)(26005)(41300700001)(2906002)(54906003)(356005)(6666004)(40460700003)(426003)(336012)(8936002)(82740400003)(4326008)(8676002)(40480700001)(70586007)(36860700001)(316002)(70206006)(86362001)(36756003)(478600001)(81166007)(44832011)(47076005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 17:20:12.0989
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 476571ec-7c26-4d47-9180-08db9db3e221
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9175
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Xilinx Alveo U50 PCI card exposes multiple hardware peripherals on
its PCI BAR. The card firmware provides a flattened device tree to
describe the hardware peripherals on its BARs. This allows U50 driver to
load the flattened device tree and generate the device tree node for
hardware peripherals underneath.

To generate device tree node for U50 card, add PCI quirks to call
of_pci_make_dev_node() for U50.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 321156ca273d..6c0e7b6bbdd1 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -6138,3 +6138,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
 #endif
+
+/*
+ * For a PCI device with multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
-- 
2.34.1

