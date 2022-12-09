Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32534648915
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 20:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbiLITjP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 14:39:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbiLITiy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 14:38:54 -0500
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2070.outbound.protection.outlook.com [40.107.237.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F8A8492;
        Fri,  9 Dec 2022 11:38:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVHzGuWLmYnrkIOSbu9bS13iB38e9tW0g766z+KuGhtlcF3DjKnNv8YdpL0PN9N/1TGKInzqRs8CuqpRfuxGF+2x3NPVdMfYABou+QArMLA+NWhN0mkxLW4thEosuleSt7tiKzqcUGpzzy2xYkqENXjRbW7GQj2RoJ+M/UJD7fQYjvlKKn+QmKIxNmBppvPK0lkyOC9Up6rGInzlVTiF0OvmNAKvhr15jCmJOc0uKAn0Wn8TN5iDRRoAsgaK5cMX/zYY2ZQOgs7tx6XP+Gm9SI/79V4ty/n1vIccVr5sxcd6ZoOf10Gykp0CCopDFEHN/mn547o0kfLG+mEj1s5jyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=Bm5V4c09ISNLFPeJy49MZ89lkMilwbxLKEDbpRqTRT4gwmXkEkE4aoUYv9bMUif94WhTo/0X5/f++I/tryYTkYSIIPTAAWxneXYDWJFjCYVnk/Spon4UtwtRxF2rT6iHGsqs9ecxouKJWuhUYAZol7lDHIC8QdO6IzI9HTBSz7ti+9Jw+j37DcluT+TZhp2rj9X1bxcY0G3KjBvrXfVsaRm7RyIWp1DBe4KNJhn0jI/fxI6h5LaawkDKfbUWQQQexwlQz6FKRczW1MaZE7iwsZzuQTzoNAhp5fEjtleuSFxz+N9B7vo0SGvGgeiF32stGPgT8EHRdqZ2ZhGQYAscyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=2E6BCnUuz4ClOnlrHXvIRmrAAv5R3jUt0gNcJctNrQpfOCPYqxjbp0Hz7G9PCQPw19vc8i0LjshnJJeOKwunBIxLg16xFaf1uP3hiTQB7sG8uQEfGabtKBgAzBhvg0LN0HvoNp4Op1jJHKkKrluNsezRb5pV/W7LJvCdWRwnzE0=
Received: from BN9PR03CA0977.namprd03.prod.outlook.com (2603:10b6:408:109::22)
 by BL1PR12MB5287.namprd12.prod.outlook.com (2603:10b6:208:317::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.16; Fri, 9 Dec
 2022 19:38:46 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:109:cafe::54) by BN9PR03CA0977.outlook.office365.com
 (2603:10b6:408:109::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.18 via Frontend
 Transport; Fri, 9 Dec 2022 19:38:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5901.17 via Frontend Transport; Fri, 9 Dec 2022 19:38:46 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 13:38:46 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 9 Dec
 2022 13:38:46 -0600
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 9 Dec 2022 13:38:45 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH V5 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Fri, 9 Dec 2022 11:38:14 -0800
Message-ID: <1670614694-68049-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1670614694-68049-1-git-send-email-lizhi.hou@amd.com>
References: <1670614694-68049-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT004:EE_|BL1PR12MB5287:EE_
X-MS-Office365-Filtering-Correlation-Id: 340440f2-887f-4ed7-5138-08dada1cfd32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwHkSkc+MnM9dV/eJ+m0gsN3wUA1F/TUie8X5XiZVxW4DK9h6VtFuDkiUFXUBKcOU9Uaa+mgxeZ7X3xsH8L6p2LuAp6P0nNYu7IdZHL5MwcgMRzvvhmRyVoXp/aTJyOOjbWCg9BHnXvZNvUMPMZUbmsAu3eZK86B9Oz8+Trka9F0mMg6v79QNtgE6fnUdFOtsz6sx0f2OGTAsiV4yu/H60Ns7+gQCcYveFKympOWr/Yhz14Ksucimh0UQxV1UzgCR6C3EWP5T/Yp7yL4ZZOUu0FM6q4aB4FkVP9R4l96aFngjkhkZR0xb2REfTTdv2WLExjmVKpUXgpejXCIjOE2u5ELa1IFB8WJA0pycNlwy7K8BA8S8uMcQC+EDAY7mkw0cbPTW00oOQX4U33kPb1SLKJ/gCmCfuAZ2Cdg1HyKiJnK3FEwp1Xj2WnpNe+mhueL645PlYKmUgmJwlZM1X7TB4DL1A47egFhn7qjW2T/dUBmvVPKT9j4AjY3WJe3qjiUXgDT3svzjAFffNkanADYLwkBk+htpscntvpM1urfe7IkgqO/bQeB1O9s2td/HzXzeHtwL1VGq8eXh+jCOAegJHvTd1+GGRbETcZebidvahvd52rXg4neNq0gQv1GapSR6FHLc05rNl2ARX2eFGW9Leub+ZoscrOolB7tDtQ8wnJ00AfgUCPioMMwwfRjy+JYO2V1J8tqndsB8W19IjTb7i7bgInC9rw2Xotkt+p9Okc=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(39860400002)(396003)(346002)(451199015)(40470700004)(36840700001)(46966006)(4326008)(44832011)(36756003)(70586007)(54906003)(110136005)(316002)(5660300002)(70206006)(41300700001)(8676002)(478600001)(2906002)(26005)(82740400003)(426003)(47076005)(2616005)(186003)(336012)(82310400005)(40460700003)(8936002)(36860700001)(40480700001)(6666004)(86362001)(81166007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2022 19:38:46.7750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 340440f2-887f-4ed7-5138-08dada1cfd32
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5287
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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

To generate device tree node for U50 card, added PCI quirks to call
of_pci_make_dev_node() for U50.

Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
Signed-off-by: Sonal Santan <sonal.santan@amd.com>
Signed-off-by: Max Zhen <max.zhen@amd.com>
Reviewed-by: Brian Xu <brian.xu@amd.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..5d76932f59ec 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,14 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+/*
+ * For PCI device which have multiple downstream devices, its driver may use
+ * a flattened device tree to describe the downstream devices.
+ * To overlay the flattened device tree, the PCI device and all its ancestor
+ * devices need to have device tree nodes on system base device tree. Thus,
+ * before driver probing, it might need to add a device tree node as the final
+ * fixup.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5020, of_pci_make_dev_node);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_XILINX, 0x5021, of_pci_make_dev_node);
-- 
2.17.1

