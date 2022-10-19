Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA0604F3E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Oct 2022 19:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbiJSR7y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Oct 2022 13:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230253AbiJSR7x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Oct 2022 13:59:53 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49F90AD981;
        Wed, 19 Oct 2022 10:59:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUtXUsjpMcDkfCsu/V9Dnw2/Befx/II/griv8rdj5ywxbfZ44Q1YL3QHHSXeHtsGQmVCoe8rp2tMd05nU9f0w+S8k4NEiudenN+zbhX+qgv1dC4PcM6FFQXE8NacTzh67aFjnI3dQqMhM8YbNLMmFh5VkZzxHX7kVLJQ6tvp6bEZxB86XwDaUNBGYjmNOK1ERTkJCQXkwiGZSGU+DH8hWCQqrlZ7efZ4v9NDuxrYzt9ipYK/7Un9TrfD0YH05Rrkse7l2RRdW18beKvQ3Q8LB+fz1nTiR8wZge+Hcznz9CSVgjnEm0u9tdfTnoXsWrZplUxeq25CeSrVsczt2AA4Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ymeqdzgUQw/wG9xypKNzqPVmNMNYTGUE2RnqrWTvwY=;
 b=E+8/wUMqexs1DJ0o5tMHnx5UMKUBq9usYOdHTMiM9ezDep+EoxMx9pAwm0ysWjKjJCDaPiTcIwT+ru0J+2EN4DO+lCjR7Vu3/uatZvk+O36vhUKlmbgUDuiH8U3lD9yx9y+D1lKePqiWLWUaTjZBYTOl7S8RF21sLtydf7XOto9mo7vO3G7nQsUgQtrd5L1aFsMcMoMpySbZwhcTMIeDCRLT5uNHQv+t2orXAh+MHja0feWLBB0lD7cLmfsZ0gjx6p/VdB9w18fFBcO42SW/ZiMfkOf2l9vwVP2M1K0PoaJp5e9covwByQ996gJxHneW4cq6u3bO1Fm1thOqKOR7lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ymeqdzgUQw/wG9xypKNzqPVmNMNYTGUE2RnqrWTvwY=;
 b=rouJZtwmQxIOrmmu/8GZyOMSbIVFsQd+WuiyH+dHklGHCbOTIUIBVoABz78yhnj+vzQecI5GzrU4SK08IigldpOqjZ1WuHT+pKhSe5umgD3gtt5+mvM/GexiX4Ugl9drKxp/En+eZYluLUMSZWKHk3gwOlmkBrwKlp87M1ouPMo=
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by PH7PR12MB7283.namprd12.prod.outlook.com (2603:10b6:510:20a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26; Wed, 19 Oct
 2022 17:59:47 +0000
Received: from DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::e5) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Wed, 19 Oct 2022 17:59:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT016.mail.protection.outlook.com (10.13.173.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Wed, 19 Oct 2022 17:59:47 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 19 Oct
 2022 12:59:46 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Mehta Sanju <Sanju.Mehta@amd.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/ACPI: Don't assume D3 support if a device is power manageable
Date:   Wed, 19 Oct 2022 12:59:31 -0500
Message-ID: <20221019175931.3941-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT016:EE_|PH7PR12MB7283:EE_
X-MS-Office365-Filtering-Correlation-Id: 190d5f12-5a9f-41be-d6c6-08dab1fbb5fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bq1KwvXI2dG78XAWuadb1SZ84alXIkNdJlEejbYS7gfq8cxmObHZjt4fxQ9inYnmGt5vjLS/uNQa7Sg8VFN4SCBK9+5vOjzxh2u4+vvQ1Vz7JDRqqYGhu1LgchIJMaQwrPA7HTUN0U62opIVjDT4dH5y/arD3omMUWpBZ79pbw5PIi3hSAdXXB0bMR+d2j0oCmlCzNpmbHNmbvy3RXBuj6HEekyCyc2B0ukSOSdvGYBP2M6uRkknwZnernrNMcy5T+wY9NyjoGhBVGTca/siTPs8TXKUYdMToaOOyk/2kW0/sJFc3rlke7ppiEBGopS2SeB/rmPnJYvGfnVseDiFEL3chUgN4Fp6L3o7Vt8dKH/eBhYTm2kKpXKa2feqW2DsRbmx1g8x7lafoUxrekNewKvsEs5/MXnDHQyG21PKyJ/dTjlwsWwVr5YXsCQ0XjQs4Yh+jrM3dYUBIFgxuaIXJfcahm1QKpsQqqThOldS2jlpWYRKtdTHqPBxNkIFNoRezOFBcrKwX0C/Qp6Ec+1DRvz9qejSPRr7dPP8eaEQlrqd+kaDzV6ASK0hQwt85vVsz5MzkvZXmbvrTyLY9+MpnIwh7izzqBqiy2n8ZoqZYBrxap41cjbMWx6Drz7ADbuvBBD5H/Kb78R4u1agOjzmu04GbDGQRImUvuR2Tdqvc8rocm7/w6AMamaYzz0IKgA/yFIx1t2FfmNuVlVPJXd4QJmiAVWRBbo6p/lo2JOrJuARC1MN1U9F5hu5kq3yJkaCjZH4MIdwlI7zZNW5qP//RA3jc4cl6KYjyKYujVG12/tNKyZlsLErevotlHNc9aaA
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(136003)(39860400002)(396003)(451199015)(46966006)(40470700004)(36840700001)(41300700001)(40460700003)(186003)(26005)(336012)(44832011)(478600001)(1076003)(2616005)(16526019)(6666004)(36756003)(2906002)(4326008)(7049001)(5660300002)(82310400005)(8936002)(86362001)(7696005)(82740400003)(110136005)(36860700001)(54906003)(316002)(47076005)(8676002)(40480700001)(81166007)(70206006)(83380400001)(426003)(66574015)(70586007)(356005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2022 17:59:47.3653
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 190d5f12-5a9f-41be-d6c6-08dab1fbb5fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT016.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7283
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On some firmware configurations where D3 is not supported for
"AMD Pink Sardine" the PCIe root port for tunneling will still be
opted into runtime PM since `acpi_pci_bridge_d3` returns true.

This later causes the device link between the USB4 router and the
PCIe root port for tunneling to misbehave.  The USB4 router may
enters D3 via runtime PM, but the PCIe root port for tunneling
remains in D0.  The expectation is the USB4 router should also
remain in D0 since the PCIe root port for tunneling remained in D0.

`acpi_pci_bridge_d3` has a number of checks, but starts out with an
assumption that if a device is power manageable introduced from
commit c6e331312ebf ("PCI/ACPI: Whitelist hotplug ports for D3 if power
managed by ACPI") that it will support D3.  This is not a valid
assumption, as the PCIe root port for tunneling has power resources
but does not support D3hot or D3cold.

Instead of making this assertion from the power resources check
immediately, move the check to later on, which will have validated
that D3hot or D3cold can actually be reached.

This fixes the USB4 router going into D3 when the firmware says that
the PCIe root port for tunneling can't handle it.

Fixes: dff6139015dc6 ("PCI/ACPI: Allow D3 only if Root Port can signal and wake from D3")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci-acpi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a46fec776ad77..1e774a4645663 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -984,10 +984,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
 
-	/* Assume D3 support if the bridge is power-manageable by ACPI. */
-	if (acpi_pci_power_manageable(dev))
-		return true;
-
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
@@ -1023,6 +1019,10 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	    obj->integer.value == 1)
 		return true;
 
+	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	if (acpi_pci_power_manageable(dev))
+		return true;
+
 	return false;
 }
 
-- 
2.34.1

