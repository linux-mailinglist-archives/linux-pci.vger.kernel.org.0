Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BF8B62390C
	for <lists+linux-pci@lfdr.de>; Thu, 10 Nov 2022 02:42:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232382AbiKJBmo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Nov 2022 20:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232378AbiKJBmm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Nov 2022 20:42:42 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C745C27CEC;
        Wed,  9 Nov 2022 17:42:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ajol2A/cuuAzS0e8WgkyjPZv5GLr4U2g4xmCy9msnicIFwShVgjfCWoOpS1109foyDYWoxHleV1JQAfxyIXbczM/szYXD7mEnsdm70aP2G3OHpB4hO9L+5oSI3yqTMSSsvFVZ6CJRdkKlu6JONBzpdFD9QsIiEbd9tiuI7JGehe9nk/R9HwtlucO1njRGawdQbEvxy63wxbZinmklwZkfnf8WtSowrlfMjDjkES73OAqSl8Ng6jktB+dcrLNJQaT4KMp9vDGCqlzNFfq0llgPQ6LRBbP1HLEFUjU5Qq4VX2n7ysWjZxqzx4B5i+uv+m/snQLxf9TIkiJwU6gPnSQew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=Iyjz5z6MAED55Leve1/kqn7kdrjk9V+B1D60pOWuFhSKvSIDxzIszlDBy1NdYSwOqIsw2+Cy8lOqRfxwUbFZLIZ7V/LhCuta1JXHqferCEuhDmA30EKFVv6LxMjPHFProilkLho80z0MuJ62an/nt719xgyjd1PNz1FIFekcDz4zZLPHa96dLjqKxHXH/J8hIOk/OWA4pA1QQDSUvVqYua0EAKpmr3aQxe8Mz3kTVVvsbBc79c1jrFymWOQVvgFRv0R+r0MEdvRbM2zgbKs9f/Sysq16OZ0T2WkPNOOU53vRDAqY4qdXQU2uroAzUaMUl2DaJOrSNq6gGsSkNkPBkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4kE3EEoROF8TRC85LHQNVGLLOGk4/ncwzq/kMy+zm2w=;
 b=kf5KREra3jGr91mwmBwskH3NWzCpQ32ECQN6CFDPc3AvrZYtMvol8u4wY/69dSSkRgAKdZ2W4Eyws2fyULRRKJNyqjwpPXNB3dWUoTad4dM0feqL8V1XGp7woc5OiN/0CI18PKQ0tjCQ0g7DX94TZwPTcKhHN6ZkE2X1BbPJ5Pc=
Received: from MW4PR04CA0238.namprd04.prod.outlook.com (2603:10b6:303:87::33)
 by DM4PR12MB6304.namprd12.prod.outlook.com (2603:10b6:8:a2::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5791.27; Thu, 10 Nov 2022 01:42:36 +0000
Received: from CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:87:cafe::eb) by MW4PR04CA0238.outlook.office365.com
 (2603:10b6:303:87::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Thu, 10 Nov 2022 01:42:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT069.mail.protection.outlook.com (10.13.174.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Thu, 10 Nov 2022 01:42:36 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 19:42:32 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 17:42:31 -0800
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 19:42:30 -0600
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>,
        <frowand.list@gmail.com>, <helgaas@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <clement.leger@bootlin.com>,
        <max.zhen@amd.com>, <sonal.santan@amd.com>, <larry.liu@amd.com>,
        <brian.xu@amd.com>, <stefano.stabellini@xilinx.com>,
        <trix@redhat.com>
Subject: [PATCH RFC V4 3/3] PCI: Add PCI quirks to generate device tree node for Xilinx Alveo U50
Date:   Wed, 9 Nov 2022 17:42:18 -0800
Message-ID: <1668044538-27334-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
References: <1668044538-27334-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT069:EE_|DM4PR12MB6304:EE_
X-MS-Office365-Filtering-Correlation-Id: 8fa28c46-b6c0-4624-099a-08dac2bcd873
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qs8wGf08lchV1ti5HIIEvh6I9tJ9qjdLuj2CwbQEX6vJx5PylGD1kWJEY4iZ1qJsu+dl4K7oXKc6yvyC2YecHVndITOEy3YDECowLNZ7JCX8vp8oqXUQnGvW0c94r81WPUNcDhu7OC1+GMYyc+4GI4AL+Kb+9MhqARW0ZvNwUZOP8fh5AWQTxkw8nC6jpfLn46KSaWRt45mA3z1gLp0jO9e5ffPCm85Hju2MklG9anbMeAfiI/uhgg9dIkcWZ+RfMITB7wJXQWJgvSQ5eMZu7sowWGbZbPs1vi2oOWqmeQZrWXE606PaoYdex9YONmIGj9uvI+saldnysaNtU/kE7hqIyurLCyIGnIuN7FZdoWb7beVG/yRA55Usn05Xra7qgFeGyNXFG9Ts5wCvg6k9x2uGlJ0U+7tHHW1RlbMsArxC8gd87ZdIxXbyVdZ/WzvR1bCVA4AvDrm3KLLp3FlbKI7lBPeHOICw31hxG1pxgHm9yKdQ7C+b4viyUIg/jcFOjkTAPN5LWWm8fThpsXfW/JEMHvwXourWq3dNzVYa7vTt41oxk/YpEeAfBYnvW7Mvjevgs6Nc6xJoo1YSBbaGGcKAPMe8keEZNZxy65OEaNE8PXfkuFYtiv8fY00FHqouuQ2c5ccn3W5z//fjU9J++69rQWWJRQx6vU8JBr3PArMAJ+VkbOn0ecctXEeHWe7+99XdkBLbrN55l+Yt16zSMzsB5RyYq0pPCnOL/CQ259k/to2PObdyRrhGCKEbQYvX6Coa+LyE/0btOfdwtXSUPxNfFlZm3tne1zY0AzehjyCn7UKDNUcAnqefyfv51DDN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(36840700001)(46966006)(40470700004)(82740400003)(36860700001)(356005)(40480700001)(81166007)(336012)(426003)(186003)(2616005)(36756003)(47076005)(82310400005)(6666004)(26005)(2906002)(478600001)(44832011)(8936002)(110136005)(54906003)(316002)(40460700003)(86362001)(8676002)(5660300002)(4326008)(41300700001)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2022 01:42:36.5998
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fa28c46-b6c0-4624-099a-08dac2bcd873
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT069.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6304
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

