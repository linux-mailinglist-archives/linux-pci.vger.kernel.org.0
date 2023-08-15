Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A02477D504
	for <lists+linux-pci@lfdr.de>; Tue, 15 Aug 2023 23:21:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240215AbjHOVVH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 17:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240203AbjHOVVF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 17:21:05 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2047.outbound.protection.outlook.com [40.107.243.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FC16138;
        Tue, 15 Aug 2023 14:21:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g7zCP6W+j1AH+ponLBE3SJK4v4jJjHMZNJPYZ8nixZ31cbwVZfZDwDqIA+JFyp/RY9xv9c1NuwV87YhaqSPccqjqrjZiTw7Wd6sofPvMnUVL7IGkqS0KdqKY4esgcZnwjIEewf1/DH3KJFct2YZnSc8x0ZFK/yoyWMW+6cnESCGe90hQo1poJDUqWXzV04nDeH6ONfcFr6RRR1r5rdizXKCYFPyb9mLZO0y0k6I4VmiQQQYXL00o+KEW5FjnsXsx9QVILvBiyCryYGwufkq+LIXQBoZlVjFg64Vypnb4H3L4AROLidXGjQnWewYUxu4u+RaRnPofZCow+jCNNPk3YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XJ5wtd0uDmNqrU8869kbaysOfypNnpBIdyeK5Md+pZ4=;
 b=iyc0/Jo1KELWj5Xc+Vy0wY5BuIGcUf/tNCeakBJSuDEIt2WFuyTiWI5/zt+9yI94hhzjJm/5YUgURp08RNOvhAYwC5GDnS3XKOH7FcIMA3K8zAJWZdejscTwVOyt0oyZ6FoL2LZUNacNBSneG6kzqquqapJOt4fg4R4yt52CW/JxlIZRQIM4PXG/dqlTikrvGvW04iiOBtGMN1hqgeaNR68rGnmttj2/pKh6p7IY9jdHvqkmVenB1avMM8uGXvAJTWQJDdBCWZLpMhD0bUvRQh1Lz5rWvj94GBb/ZybZNdsGgFbENwBfU3yitaxkcwV+e5KimW50sBi1jiaDlS0jLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XJ5wtd0uDmNqrU8869kbaysOfypNnpBIdyeK5Md+pZ4=;
 b=yvgGFoEHETrNbgRYOM4jm0VHaCSzsbhucd2ljaNO/N74xzT06xscDh7KaTp/9PIsbm8kPtPCFhC/KzqZfbbrF/nSwvUqgRWVlu+CoRI8rcDQqE4y4lataLGwoxpUu2HSDX1XuZmLOYmOvId5q61e8QU5sLPlSkUL0S0RM6/hXqQ=
Received: from MW4PR03CA0019.namprd03.prod.outlook.com (2603:10b6:303:8f::24)
 by PH0PR12MB7816.namprd12.prod.outlook.com (2603:10b6:510:28c::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 21:21:02 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:303:8f:cafe::d8) by MW4PR03CA0019.outlook.office365.com
 (2603:10b6:303:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Tue, 15 Aug 2023 21:21:02 +0000
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
 2023 16:20:58 -0500
From:   Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
To:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Kuppuswamy Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Subject: [PATCH v4 3/3] PCI: pciehp: Clear AtomicOps unconditionally on hot remove.
Date:   Tue, 15 Aug 2023 21:20:43 +0000
Message-ID: <20230815212043.114913-4-Smita.KoralahalliChannabasappa@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|PH0PR12MB7816:EE_
X-MS-Office365-Filtering-Correlation-Id: 5fa7dcc9-a66d-4c79-274e-08db9dd586f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BUwzEEvfEcwoUp6vkBJfvR3FFpJfvw+7gWnNjMIf/hiQyPYRfhmOtkAIExV5dunsnap+EVOg8E6po48pFNlnw2KWrxXEWhQ1gIMHLjog9tgkH1S+zCg1vIMUvnjDkvRbMMcOtRtxo4hrQDz/EZMRHXsSnoSS0yXjLGnfEi0ro2NCELhSSrcRTYd1S6KtQInobbX3grGWyt9Lx+I3HIEJ32J5DSxfwu9xnxz1631mJ6fX7p4VDuicZ/Q9a+xnqj/0guhata4HMwJB3Cz9u69NN7zZUnFWqp2URJNgPVTU3PUirsGV+oKtb0PUjVFX840Q1DZdfVLV5Zn1Emi02gJI8vWMZ0lNdp3grzmzvz06X5XlRmHyyjwlIVSh3pMHfvLj7FMWvnX8wBL2AAaXTMtituGDf/cFabgxlvb6lRC3uoH00RUJzX0rpKvIp1o1W9LkUVUtHyCE8RGUZPSLsR6dC4bU3UO5316OWW82+m/x3GzKH8gOgKwUe+0ZXPujYw+bnEfSRw5WxAMhH//LZFBbRZrdk2QshERupLa4X00/79BzmIR5C0AXtsm6qy2Ejkrw9g5gYQuHmZyk+uWjUEvyzjQ+M2kMzrVgOGyPAma/QA0PXltq1YuIlK/th7nInVjimymadRJXS2B42qWK+hVNjbVtAlk0CFdttxRkqoZ+a/YC/sbXWfO2ttRxkZySXfjUmEAYCvmTFD1z2b3YqwMEA7MOArORrfNT6+R2WVrh9GbeW7n/PPtU9I1Lkxu959nN
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(1800799009)(82310400011)(186009)(451199024)(46966006)(36840700001)(40470700004)(70586007)(70206006)(41300700001)(8936002)(16526019)(110136005)(7696005)(54906003)(356005)(40480700001)(6666004)(5660300002)(81166007)(86362001)(36756003)(336012)(8676002)(2906002)(316002)(4326008)(966005)(1076003)(478600001)(426003)(83380400001)(40460700003)(2616005)(82740400003)(26005)(36860700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 21:21:01.9171
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fa7dcc9-a66d-4c79-274e-08db9dd586f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7816
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On a hot-plug, the optional capabilities ARI Forwarding Enable, AtomicOp
Requester Enable and 10-Bit Tag Requester Enable in DEVCTL2 must be
re-negotiated between endpoint and root port for optimal operation.

PCIe r6.0 sec 6.13 and 6.15 [1], points out that following a hot-plug
event, clear the ARI Forwarding Enable bit and AtomicOp Requester Enable
as its not determined whether the next device inserted will support these
capabilities. AtomicOp capabilities are not supported on PCI Express to
PCI/PCI-X Bridges and any newly added component may not be an ARI device.

The enablement and disablement of ARI Forwarding Enable and 10-bit Tag
Requester Enable is already been taken care in pci_configure_ari() and
pci_configure_ten_bit_tag() respectively.

AtomicOp requests are not enabled indiscriminately by PCI core as there
could be devices where AtomicOps are nominally supported but untested or
broken. Additionally, there is no explicit capability bit to determine
the support for AtomicOps Requester.

Moreover, it is difficult to determine if the AtomicOps are enabled by
reading the "AtomicOp Requester Enable" Device Control 2 register as
the PCIe r6.0 sec 7.5.3.16 [1], states "AtomicOps Requester Enable is
permitted to be RW even if no AtomicOp Requester capabilities are
supported by the Endpoint or Root Port", thereby substantiating devices
that hardwires this bit to '1' is also valid. Hence, clear AtomicOp
Requester Enable unconditionally on hot remove.

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
v4:
	Cleared only AtomicOps instead of all three bits.
	Removed brackets.
	Moved clearing at the end after pci_unlock_rescan_remove().
---
 drivers/pci/hotplug/pciehp_pci.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_pci.c b/drivers/pci/hotplug/pciehp_pci.c
index ad12515a4a12..a3adbe89239c 100644
--- a/drivers/pci/hotplug/pciehp_pci.c
+++ b/drivers/pci/hotplug/pciehp_pci.c
@@ -134,4 +134,7 @@ void pciehp_unconfigure_device(struct controller *ctrl, bool presence)
 	}
 
 	pci_unlock_rescan_remove();
+
+	pcie_capability_clear_word(ctrl->pcie->port, PCI_EXP_DEVCTL2,
+				   PCI_EXP_DEVCTL2_ATOMIC_REQ);
 }
-- 
2.17.1

