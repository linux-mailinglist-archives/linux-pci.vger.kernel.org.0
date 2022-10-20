Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1B460695E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Oct 2022 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJTULX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Oct 2022 16:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229835AbiJTULV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Oct 2022 16:11:21 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2051.outbound.protection.outlook.com [40.107.220.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF4C2CDF1;
        Thu, 20 Oct 2022 13:11:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TmQNAPGUY3oeHmE6ngxa5ZgD2cdT13GtTvK2whotXMZKpbonV7yjpCZFB2cLgIB4/lewlgO59mhw7BajoEm7xdoUaMDP4lUTClHLr39h8DP6KC6RLtV8RqOHg5LSUM0O4y2ooRw9DiCL9ralVn0kr7aOkaYk7usFi0DHsjSppaRCw+qhQSu7B0S8S9YS+E3HPbMVWjB4yqCDC/3uLbwt8kBhjn8gZSSUAK83N9n6uOIkmHIqUg4aOofCvCzt2fwhOviRcHzYz+Ar2y9BbLuLhbg6CQK8b5zbYg46OIQt0q/ZpTyazHUMgFlFttfsFwgO5Y0K2yQzkTYvISbzDC19Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BUS9s1VeYShY0WwOfm8bBjKu4I5JZ7gTSOcCH/rPo6g=;
 b=hiaVbSDMj0H1/uaKwNYkQCxFLIETqb5KYBV3sCKuvAuzkJV8CqLryVIXPJgKgcxYhBPrRe6aAFPVXdia7L2N561lQ0O5hySABVsHtMN1nlCaRYojheMhftAKiOpaSw7PIaHSaAJe7m9HNLrBcs6PVpXMRpmLjW9EMSn8I97IupsuDUPUu6oHrbZsbWRn8t5J/2iglHZK1264EWYc/wOJi2mjbqzTXYNv7K0KG3Zmdw0pGbdJdAh5kB8u/D7eOc+4ltAPk+x+shNOVcGmw7v/4cQuhIx/n4xWu/2KgDwBAojjChuwbf+u/EVCBAvEeZiGWIPwYTWiLnwSGUE47+7kBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.intel.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BUS9s1VeYShY0WwOfm8bBjKu4I5JZ7gTSOcCH/rPo6g=;
 b=4KVfK6FIuvpsN25lgBoQI4wNYDSjZXxkEApwhORpMoWYBs7CQxc4ZJkG7gPEYUZRwbZnZhxZa2OhbNYHeSiUqY/lPlpRv92hsP7Tf1tzrvbJA6gcCX8HpYzprZ4r19yhkXTSGxYMRDy+VcC0zqsjP3JJdybOiBxAoa085LKDzHY=
Received: from MW4P221CA0024.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::29)
 by SA0PR12MB4400.namprd12.prod.outlook.com (2603:10b6:806:95::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.35; Thu, 20 Oct
 2022 20:11:17 +0000
Received: from CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::90) by MW4P221CA0024.outlook.office365.com
 (2603:10b6:303:8b::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.34 via Frontend
 Transport; Thu, 20 Oct 2022 20:11:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT042.mail.protection.outlook.com (10.13.174.250) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 20:11:17 +0000
Received: from AUS-LX-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 15:11:16 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mario Limonciello <mario.limonciello@amd.com>
CC:     Mehta Sanju <Sanju.Mehta@amd.com>, <linux-acpi@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI/ACPI: Don't assume D3 support if a device is power manageable
Date:   Thu, 20 Oct 2022 15:11:11 -0500
Message-ID: <20221020201111.22861-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT042:EE_|SA0PR12MB4400:EE_
X-MS-Office365-Filtering-Correlation-Id: 4eaf24bc-01a4-43e1-42ac-08dab2d73f61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PLdyDZo7JY2lNd4/6FmOjamE1R9VBwc0fsK6Q36L3nEonSV8EPe0uIHTsh9zxgAzKNojpbl2+ejQqQx0FjzbTYm34czOqUTw0DCbFAvJrH008u7x+9R8qLQjq6MBhhY90ykBkkNyROHfGpsbSovUR+0DL+NXXYkOqjrB4cdrf2WC3ebEJNkNPbWd/UrRKvjvzcEaqGX0IdpByr/4K9GiNdkFejnUpDMquLTz2IzrTqyKbt2CRFmAou9D7qNCdtITSH9eXVFbi1nK63xQRDUDgR3iilZjoJy1O70MezS7nQ/DmFLj6KgoArOwRTVY9Wzekq5pJcX4WeTGetJVhoMGZLe0gKoOeVUlowEWZ8EF3c38U703TbbYVU4YxnAtMmRgcDrpQ2vZBwI7xOT0KcYstSDx0/04u2Q/ZWfUS4CXv1JbpookWPemWshHRD23teyU4Nnoij1TxYtjv9mQvpxKdWxZjbvkJYszQC+j8bdUFtoXPur959v37AmHL0RYcqol79Gor9ixnJgsM+R+gJeRygPqQgpwKl+1iUZtNi8k9QeZ/Y4NfXpsr9QtTUZSSt7hLbQryHUAvLVt8iiHwjOWSKWqTviU49AieRXqGSasCf06vGyfLhRQ6+2M5/sjstWlD6xMxsrLdsrEuOLa2x3QK6xOPJ9ME7xOk62+2lSiaP8+ljk9wAWf8+CUysn5a/IpkGqpdpQ+NPDsNQCZBRxX130S/7GGzoWaApTy18aoHWj1kGnOAplB7+/Mj9yjXJ4M04ABithkmlRYDzz2YgDRtfjqGPrIaLhP4BJm75IQUuER40E9WSFyc1y9/cZUUQOQ
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(346002)(376002)(39860400002)(136003)(396003)(451199015)(46966006)(40470700004)(36840700001)(2616005)(336012)(186003)(16526019)(426003)(40480700001)(7049001)(44832011)(6666004)(2906002)(1076003)(81166007)(356005)(36756003)(40460700003)(82740400003)(86362001)(82310400005)(47076005)(83380400001)(70206006)(66574015)(7696005)(70586007)(36860700001)(26005)(41300700001)(8676002)(4326008)(478600001)(316002)(8936002)(54906003)(110136005)(5660300002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 20:11:17.5835
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eaf24bc-01a4-43e1-42ac-08dab2d73f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT042.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4400
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
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
enter D3 via runtime PM, but the PCIe root port for tunneling
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
v1->v2:
 * Just return value of acpi_pci_power_manageable
 * Remove extra word in commit message
---
 drivers/pci/pci-acpi.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index a46fec776ad77..8c6aec50dd471 100644
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
@@ -1023,7 +1019,8 @@ bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	    obj->integer.value == 1)
 		return true;
 
-	return false;
+	/* Assume D3 support if the bridge is power-manageable by ACPI. */
+	return acpi_pci_power_manageable(dev);
 }
 
 int acpi_pci_set_power_state(struct pci_dev *dev, pci_power_t state)
-- 
2.34.1

