Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C965D7672E3
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 19:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236052AbjG1RHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 13:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234437AbjG1RHP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 13:07:15 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A8133A8B;
        Fri, 28 Jul 2023 10:07:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DctaeYjkBAYxMcj/66f2YY+vk6VhegDIkZXT6igXsVIr7NAkQPc9RtA2ef/FWLKbZhXyE5Tc3DO/zxMwdZ1xshMMhNxL1Am9Aw3HRXeWGfNtlV83TnLAlZfnxXWHn0HESvFXGTTOU/lC9BpKi2zeGHUItDzpjBokYumm89jy57Bp63gAxTnofjNHvtK4IArawqTOJx0q26ls3u7pt51We2t2eJnd8mwPIGT1Sn4aZSggfwadWUfwEjssJmf7BMhCz4Zpq80gkNzzp26K3V6MVXrv1k7EQ35sCsXW5mkjg1w66PD6uSI0+fx0lHGGYVMgdwVqoSvLnLHbpgTUXqbFXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LsNs3+RFfiY/iKi6qTA8+Ipu+qkjh/WS4+AwQNiyk+A=;
 b=QWazV1XSA7uT+WcU7AY5WtAzduzBWwCBCJW1qXos2Y7g/cUknwK96ozM84JX/tEfxq1pj8zmdF36KOZ2CH0kS4DM0GiavLYp1A2EqTeA5WgSbNnMN3+sK0oXG9SnHq8KHJLev/eV2W8T3z/s/Jum/VS9o9LkllVsCGW+3PjnWek1fA+FFQuSFPKMM/4FJVvjz4kljhIUIUlcyR8rsx8hIciGQlcl03D85GLmJf05b7H7tqFCoItS3DgXfkkIXonnzEANn/LktCD4QxlqKVpFiczsV81KkykdXBF2opDlCg0aIrrceIrkSOrhwUoMg0wYengK2S19dbqZmdGe+SuZdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LsNs3+RFfiY/iKi6qTA8+Ipu+qkjh/WS4+AwQNiyk+A=;
 b=zWqHwggtE7W72lEI4il9zT0LqK+AGLLZ1HAL46Kc+CdHMqn5l53uNtv97dyR6v5sMTTvsqVeSN7Y2XG4ujMB/eNJsNKGxwoBIT1mTalWNcaCFXwkNsNYV7FD/9cyb01ttT56n+rm5ysNPwMnqJ9ZpDSuOazMUW1iwIKg80Mugu8=
Received: from BN9PR03CA0437.namprd03.prod.outlook.com (2603:10b6:408:113::22)
 by IA1PR12MB6331.namprd12.prod.outlook.com (2603:10b6:208:3e3::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 17:07:05 +0000
Received: from BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::b5) by BN9PR03CA0437.outlook.office365.com
 (2603:10b6:408:113::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29 via Frontend
 Transport; Fri, 28 Jul 2023 17:07:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT112.mail.protection.outlook.com (10.13.176.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6631.35 via Frontend Transport; Fri, 28 Jul 2023 17:07:05 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 12:07:03 -0500
Received: from xsjlizhih40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Fri, 28 Jul 2023 12:07:02 -0500
From:   Lizhi Hou <lizhi.hou@amd.com>
To:     <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <robh@kernel.org>
CC:     Lizhi Hou <lizhi.hou@amd.com>, <max.zhen@amd.com>,
        <sonal.santan@amd.com>, <stefano.stabellini@xilinx.com>
Subject: [PATCH V12 3/5] PCI: Add quirks to generate device tree node for Xilinx Alveo U50
Date:   Fri, 28 Jul 2023 10:06:56 -0700
Message-ID: <1690564018-11142-4-git-send-email-lizhi.hou@amd.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
References: <1690564018-11142-1-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT112:EE_|IA1PR12MB6331:EE_
X-MS-Office365-Filtering-Correlation-Id: 07cede8a-8736-4c7b-f901-08db8f8d118b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /DZnJOtALtgKYB0YxUjDt2KTiR03XL7meyqPTeuwo84FAlN68xgDxXKrVXpwJ9ZlsTmTg+94uEgUYm8z18Gz0fNaxyD+v/+6+DncD4l7kkd7y8U9ZNE2ZqSZ5AkLkwY3abp0T7TZb55O9LaVeaCGUa0E2VYOAWq05s1vR1FFlTZlDucGJumKTFTQCAVHPQ/yFbMofLdI0IU5sZCMdJU1ndlgTbm1jlzjQhoisELx3ZpN9ojRF8Zs9A7BVsWlyXo/XmA1uPZ4O5wZH95tU+r7D/0dl9G9wxn9rSMuAgI2xavtIs1eTlqglKG6NTANf9uUD56YW0AXuWGiuwfHbiMu0MrAsT0eR8bWLUT0/vvg+4iVIbeOMmnUJXp5EvygeSHSQ45J+yf2BKyJRhzoUYJ+S2vP//zVgjFO713TWjlhmxBLVeZeUYm8sjpej6ZobB2dalnTQzrc+oJybQ/NP+tb/VxdxFIch1ppGRfTaGxVj9eqzzSEHoCJ0Df/dGti/BjVAdKR9ZaT4bT5W+ZqyMLSJr3B0DKV3kVp2LBdRKVyYQN6QxDthfZu35bMUUO8sGP5eASn1fE1HaIZLAkMF9L0SXgnMikzQzejTShpBzdEIkoWohYfeDS4T4PZZchv5r5riryfT+FkP7QimgHJuabAWMAhBknu1wXK/AHUtjAC3uJKOCYdIzAcdxiKvNNSlN/PO7ZZOGVveN1/pjGKjF7VTLgT/gFqg0AQat3Aqv/5YK/ZzfI8RWHD0aJkrvSgWaw5coa8OYpc6yIRphw5nAOxhA==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(2906002)(316002)(8936002)(8676002)(40460700003)(5660300002)(44832011)(41300700001)(36756003)(40480700001)(86362001)(6666004)(426003)(81166007)(54906003)(82740400003)(478600001)(356005)(26005)(186003)(336012)(110136005)(2616005)(70206006)(70586007)(36860700001)(47076005)(4326008)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 17:07:05.0135
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 07cede8a-8736-4c7b-f901-08db8f8d118b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT112.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
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

