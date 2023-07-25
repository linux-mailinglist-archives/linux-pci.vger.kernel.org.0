Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B086A7625BC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jul 2023 00:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjGYWPl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 18:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjGYWPi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 18:15:38 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F37B6;
        Tue, 25 Jul 2023 15:15:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jstuEQa1OwCpDN5REfjrtVlPWnFuFP44Ul1UVPGBBtH5QMacbQ8JHNf1wRIXjasmTlY8LYs3sOPqejdIgzslUpmJ3VeoeYqpqsv255Vo+BsbSIApxbCYE+TjoKocF4uiB9naSJzmyfKYWTQLD+YUtRZxj2ZnZHWyg6EgJ5G4hxdzKMv8ylhIFaHzve7J4dbOyYFIYsCvF8fmiLT4zZcjakBKg9unnOefuc0wj2mrjmLhzVtEUe2gZVTwC25/l4av7pGmVs1Mm30pJKu5cNte2ysZEm3/zdkaSw7IdgHfUk9fJlhmX/CNb7gVlJncuZNU4W8iA31D5hdEPR0TM25v+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsNs3+RFfiY/iKi6qTA8+Ipu+qkjh/WS4+AwQNiyk+A=;
 b=PWTS+d7wv87+hdkPdc+gQBI+xfAi2OoIUn9/LrJnsQkC+UeeOh/JtjDsCDmwWBkig5HsT0pzPxGCqleDmzW6eMyLZMCjCg/t1szJI5AqLixPDabo+VVzLHCHmYDyMTbnZONs1zSCS1Ue+UEvx528xW1+zbSU1pGexuxtCw3rnc4AaY85UBYPYpD9IJMLlctBQ/vjYynaZ7HqvCKR28IiwbGtuDd9q5db6fTMVAYy97zvdBxcigs6WOmDhMYM9RoJBofA29k23zA4+rpxmsMXvY89O1JDg+l5GmRSPWNQuQ5tSEUJqNeFKiQ8AmORSvXEsthNJVXMTCVGGuMwQmPSNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsNs3+RFfiY/iKi6qTA8+Ipu+qkjh/WS4+AwQNiyk+A=;
 b=nzwHUt7wPgesHX5e4/dYPmPYtrAvUlqUTOvxsjVgIbZLFq8oIZS6lSe+vu7uv/3PudxutJbtEGs8ipSoINQdml78GX6APMF9lghKFyrywSfbzMKcRtZiSQZVzvvUOt2LpbgrjnEsn28omPmBYqUGQT2JipJYX3EYBM1spJr5IU4=
Received: from MW4PR03CA0041.namprd03.prod.outlook.com (2603:10b6:303:8e::16)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 22:15:33 +0000
Received: from CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::8d) by MW4PR03CA0041.outlook.office365.com
 (2603:10b6:303:8e::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33 via Frontend
 Transport; Tue, 25 Jul 2023 22:15:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT053.mail.protection.outlook.com (10.13.175.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.29 via Frontend Transport; Tue, 25 Jul 2023 22:15:33 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 17:15:32 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 25 Jul
 2023 15:15:32 -0700
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 25 Jul 2023 17:15:31 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V11 3/5] PCI: Add quirks to generate device tree node for Xilinx Alveo U50
Date:   Tue, 25 Jul 2023 15:15:16 -0700
Message-ID: <1690323318-6103-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
References: <1690323318-6103-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT053:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 61f7ea85-aa94-4fb6-6ecf-08db8d5caa30
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WxxK7bSlWY1Z8Iw/WwYge5DFpFhifS6wbb687flAx8G/2oOAIhlzwJ3H0aAIp54/gjUg/lgEekUdIQ5nS6hsFNTgoPkdn1X8kafm5xbLDNm2EM62ibAYh7RMcBozx1ehnHHN/+Me1YT2vOP2a1vY/9Wm4qAAu960uMhfYgyoUelm1Wk6nYJVP/Sx0gU86E8UuV8gvFhKkwoeJzV1i9Kw5ZlXe5xAWmhs2UP1P99PRQdUY7MLH/jj+J2elfWoXNJs27yRpSW2kDoLLSJNaYRH45OxOXnHyKjdhBjInaC3v0mJ/0C4RVeCapExGblXcR6KPCOW3qPjnrUZrIBmrfSAatnhhJsBoI/CIYtHUkoyobkIF42E928XLq98y8EhZI2n2JTJrc3lH4FfcftXtBNbZxZFF8dkCif+JFxTAb+QKWfsL7vxkK8oYEFGjVK5MEPnqwqXU6wqjo1WCBOr9NLXtjhBUtwfMw3rFXc7ll0TARdC4xKCkQTrgJWpT1FmiivH0u9MfWHNOxBMo9MAYfoksKPk+LvUyWR+MrDQ8ZJ5fr+c0wxXp8Xd/NHb8Fc8gcj/bwOzC+J3gdYKCwX3OXrDF8Ni9Pf7cIVT+NvAYUOn0pIBBN8/EwQp9xMOBojUv7x3KUSih+CrqCt/Lv2/H+8Cu5WzPT3Dx0kg+OIsmxELIwpKcizHqreU6Yy+TJ5LvwnsxNhTgtbv3AmGNKySURmrpOoQyj7e++vu38Onn9XKHwZOsh2bVAkZOpSI80/2KnB5j1wipzbu2L6UBmu31DQC4g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(82310400008)(46966006)(36840700001)(40470700004)(2906002)(26005)(336012)(186003)(81166007)(356005)(41300700001)(36860700001)(47076005)(4326008)(2616005)(426003)(40480700001)(5660300002)(40460700003)(70586007)(44832011)(70206006)(316002)(36756003)(8676002)(8936002)(86362001)(54906003)(82740400003)(6666004)(110136005)(478600001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 22:15:33.3303
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61f7ea85-aa94-4fb6-6ecf-08db8d5caa30
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

