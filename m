Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823094EE6D7
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 05:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234813AbiDADl7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Mar 2022 23:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiDADl7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Mar 2022 23:41:59 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2075.outbound.protection.outlook.com [40.107.236.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82EE553711;
        Thu, 31 Mar 2022 20:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gj2pr6o4pP/iCx2ZJLf50UJkcIfSgsFcQZwkPOKyueFDtsU2WIoYEOdGzK8+kGT/s0ihBvjy65yKv+xTtplvEu3uQWR/HJq1/4TwPkMV+G50U4876lubGLMVmsXsManQNpk6sYmvsm0cbBANu3jhNuSJv9LkiZR/We3s5d2Ker3D9b7R9vmcAwChRyQW/Ksc3UsNoFmkUusxS74LCRlx9zRJjbfpC46ppBBBP2M1r/xLq7K6C5RzexB2ba3K/hhiRKQHJkfSiLNzvsiGZ0ULYucjVCTeoOYWGJbK+n5/epgxw7PWe1y+1Wki6oRAZ8xmoKPo5gFmGWd3ERbJQpOssQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uPu30ew9Wba6AMfRVqL0J4HXPvjbOfBYtfTuKUfe97k=;
 b=Ch+9YLQc9Qt7yF/ZuMDKc+D19sMgX0quhoHJSMEnhJyEbblDvUTLvOk2NUFOyCvZKwGRLoWp3X/L1pN4z1G9KprDcLZvGMKW/05QjrGLGL6TxZBRLAaA7dWQpI1/FBIUUpP8a92RmDSsawjUX8t/ewV04nY53Z+q57/qFJou2aqCgt7+CfIOrXYCW+PFwApj3j+L9sAMn8AkU0fmQmi7eL+mODjeFPkrakbtgDSXWd84Xpc+GlICGtuV4dqN829AGHDYZuLH2Uy7YJBulCfnAcC8a76Yz6kFnANIDImB7DQEKRPsoEwd2C539qt71sXS7ssBreF36tpMqGMUenEY8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uPu30ew9Wba6AMfRVqL0J4HXPvjbOfBYtfTuKUfe97k=;
 b=g106VagapFI50FHWD3T6NPl2rF3B1hKBL+C9F6QoERIU8YDmoac8ySXR5ts7TqLklsgqgPloS0I6El+9eODfyRdMW9cQOTrGo0lkwx0S0Y5/AznUK+YnS3GJtdhfR6W0VOos//lu4XF4GlZqSOzJEmm8tx8/GqfWyxYFi5nynws=
Received: from DS7PR03CA0001.namprd03.prod.outlook.com (2603:10b6:5:3b8::6) by
 CY4PR1201MB0118.namprd12.prod.outlook.com (2603:10b6:910:20::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 1 Apr
 2022 03:40:07 +0000
Received: from DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3b8:cafe::de) by DS7PR03CA0001.outlook.office365.com
 (2603:10b6:5:3b8::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.13 via Frontend
 Transport; Fri, 1 Apr 2022 03:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT034.mail.protection.outlook.com (10.13.173.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5123.19 via Frontend Transport; Fri, 1 Apr 2022 03:40:07 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 31 Mar
 2022 22:40:05 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
CC:     <linux-pm@vger.kernel.org>, <Sanju.Mehta@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v6] PCI / ACPI: Assume "HotPlugSupportInD3" only if device can wake from D3
Date:   Thu, 31 Mar 2022 22:40:03 -0500
Message-ID: <20220401034003.3166-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d462672-828a-4667-afc5-08da139150ee
X-MS-TrafficTypeDiagnostic: CY4PR1201MB0118:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB0118F3AD918DB4F24B023D7EE2E09@CY4PR1201MB0118.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oB2uSfk+bIaFOdQwIcDa+jMozDVGxGs5bekFsFKfaiAHa1MFjQF9FLENu9zH0qFHol8WitzGzNNwT7UpfSPqU3JBrP7bWiinlzRC6vgl2QL6ZySyZV3k6wXZ/6Hr8PP0ONFPGdIprxHScSpD+fmvuwMmXDi9bMFGVPL9GQHII3zP7I31Ed6mo2l76KLx9DQEmahhdFqEm3DdZV+xvAKzjbW/bw1cxcRJuxKQGFOHrKtN8cebyY+L69AzI3FRHel54HKOSsAXr4xQeQtFRq4id5HRYmYIdFkxq+rOBfPO5zJKBJf+2+qKk3orgE+wlVZpQMvpZaKqZ9scBCrLFEGcNSMeTdb2o0jMVYMrE2dPkWDICasiKTD/DaPWyiAGlWfDBWmWErEEJaslXjWVu4416SjXZkyKVkx0Mw+ITb9+qeLjjl0bifihFcaBC1hyFaE7AbosWMjw0SDwSLVx/lyR3L56pIqngWth7P6iPtJ7NpWeMW/j35huExVmfqNEcu4UM40+NNsVeXmPQk66ptLwRu8CKfGAwlXgr4AVk+/OfGhzh/aMXNfXO7ySz8Sl3kxSxt+gqIu/2BmL7y+nUTqdjCZg9hvSYoPmrfN/VRGd7RYYrwC+onUrI7kFeyj8D07rdJaeX0ucn5X3LZRgddb0zhs5phHsD0u4FAvi6KVdz7B/wXk6LkMt/Q8IHkNzri7bWuBlcCe1xDU7BgaORe0T7NhQegIFJ2uKsNNydtcuy8ee6pRnAWio6vKMC52o6nR/Rgxh8gA5LCFcDIzhcltWB8GL5iE9S5Pz18nLIgoevDWXR4YQmKH7oIufgYbnl4dSaGeXeClkK6iDYtjM9t6+Ag==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(6029001)(4636009)(46966006)(36840700001)(40470700004)(8676002)(7696005)(966005)(70586007)(4326008)(47076005)(508600001)(70206006)(40460700003)(36860700001)(83380400001)(86362001)(36756003)(82310400004)(336012)(426003)(2616005)(26005)(44832011)(2906002)(316002)(5660300002)(8936002)(186003)(81166007)(110136005)(54906003)(356005)(1076003)(16526019)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2022 03:40:07.4258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d462672-828a-4667-afc5-08da139150ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB0118
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

acpi_pci_bridge_d3(dev) returns "true" if "dev" is a hotplug bridge
that can handle hotplug events while in D3.  Previously this meant:

 1) "dev" has a _PS0 or _PR0 method, or

 2) The Root Port above "dev" has a _DSD with a "HotPlugSupportInD3"
    property with value 1.

This did not consider_S0W, which tells us the deepest D-state from
which a device can wake itself (ACPI v6.4, sec 7.3.20).

On some platforms, e.g., AMD Yellow Carp, firmware may supply
"HotPlugSupportInD3" even though the platform does not supply power
resources through _PRW and _S0W tells us the device cannot wake from
D3hot.  With the previous code, these devices could be put in D3hot
and hotplugged devices would not be recognized without manually
rescanning.

If _S0W exists and says the Root Port cannot wake itself from D3hot,
return "false" to indicate that "dev" cannot handle hotplug events
while in D3.

 1) "dev" has a _PS0 or _PR0 method, or

 2a) The Root Port above "dev" has _PRW and

 2b) If the Root Port above "dev" has _S0W, it can wake from D3hot or
     D3cold and

 2c) The Root Port above "dev" has a _DSD with a
     "HotPlugSupportInD3" property with value 1.

Windows 10 and Windows 11 both will prevent the bridge from going in D3
when the firmware is configured this way and this change aligns the
handling of the situation to be the same.

Link: https://uefi.org/htmlspecs/ACPI_Spec_6_4_html/07_Power_and_Performance_Mgmt/device-power-management-objects.html?highlight=s0w#s0w-s0-device-wake-state
Link: https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
Fixes: 26ad34d510a87 ("PCI / ACPI: Whitelist D3 for more PCIe hotplug ports")
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
--
v5->v6:
 * Re-order checks to only check for _DSD if necessary as suggested by Bjorn.
 * Adjust commit message wording
 * Drop rewording comment patch, just apply it while moving text to avoid
   ping-ponging the same lines in the commits.
v4-v5:
 * Don't fail if _S0W is missing
---
 drivers/pci/pci-acpi.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1f15ab7eabf8..5ab797e2709d 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -976,7 +976,9 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 {
 	const union acpi_object *obj;
 	struct acpi_device *adev;
+	unsigned long long state;
 	struct pci_dev *rpdev;
+	acpi_status status;
 
 	if (acpi_pci_disabled || !dev->is_hotplug_bridge)
 		return false;
@@ -985,12 +987,6 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (acpi_pci_power_manageable(dev))
 		return true;
 
-	/*
-	 * The ACPI firmware will provide the device-specific properties through
-	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
-	 * for the root port and if it is set we know the hierarchy behind it
-	 * supports D3 just fine.
-	 */
 	rpdev = pcie_find_root_port(dev);
 	if (!rpdev)
 		return false;
@@ -999,6 +995,23 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	if (!adev)
 		return false;
 
+	/*
+	 * If the bridge can't wake from D3hot, it can't signal hotplug
+	 * events in D3hot.
+	 */
+	if (!adev->wakeup.flags.valid)
+		return false;
+
+	status = acpi_evaluate_integer(adev->handle, "_S0W", NULL, &state);
+	if (ACPI_SUCCESS(status) && state < ACPI_STATE_D3_HOT)
+		return false;
+
+	/*
+	 * The ACPI firmware will provide the device-specific properties through
+	 * _DSD configuration object. Look for the 'HotPlugSupportInD3' property
+	 * for the root port and if it is set we make an assumption that the
+	 * hierarchy behind it supports D3 as well.
+	 */
 	if (acpi_dev_get_property(adev, "HotPlugSupportInD3",
 				   ACPI_TYPE_INTEGER, &obj) < 0)
 		return false;
-- 
2.34.1

