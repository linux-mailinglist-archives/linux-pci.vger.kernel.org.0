Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37F144A9EFF
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 19:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377523AbiBDS3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 13:29:10 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:6113
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232631AbiBDS3K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Feb 2022 13:29:10 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C8RyRi5bK09KOJt6/FHPaPuT/qtCMuqOQy33bttjfzOt0Rqe0gxUB2UxvfKRqGYZvqRkGpTy+PiHUY3LmM2pN+Q5wlgyX1uSAoyQWRNdjNOS4O2bng0F4UGwICllNoTlBYtjq9AjCfh0J5GhlPShOWGwVRe+6MXFJTVefs9thHqZYoBhWEL4QEEfV+rsC6CfDfMHuC2Ffw83wX5EaHck/TCXTjNRD9eRwrvbq9pAwUxd+z6tgYnshCncx0TruW/1zP9w2C4nittBpMcpmzj8oLsOkOI6qxhTQI1dFw8bNBLxWp3Q3jXUOS8J+RCv8uPbp4l4fz54QlQRU+Y6bvqgFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gT/iv2t52FK7/q+SVg9B54JJ4gy7vDKUe7VK2LiPD4=;
 b=G3tQzwU1w0gdFgtc88Bec2fCaUuTWoD7l1AJodiF+dovHagg2JayLfT5z5duTiANwvrylFC7kDX+RrB2f1jQBm2FFCp1rtbvuGkPFgtIarv6Ni2Lx0TsNH/BTjC/VD8BJ7hbJYveq51Wj2Vn2xoILlPkq4/RqdCjs6X2/deuJ91Cmupdc8NAoh/SX7cOAba4vdRORx4VkRpeOD8U57YLRISHkjuem9O+I5RTtTg0iQeCcMdLbiMbN/dSdnxdHk8cKHHnK+hBgQsgtJDfGMnvcSh1xD8z0OIyRzeW6/Q/mOHZxdUIBpOHBpBWEu72C9ctM1dvhZGN8EyXD7NxOHRyew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gT/iv2t52FK7/q+SVg9B54JJ4gy7vDKUe7VK2LiPD4=;
 b=UCDuaomW4nhxoOoySFkHhEpxztw6h5cn3jEEboCGpR3TlAFP1M9r1hoWP4wmoVrKmwiRya5BgNSbNR/ldjG6scZZyjBJgh1UkAmuDCehR5fG/7pH27Cm5BvvIvR0ILJuW7pvtB5MA1qmkeC2DDgSmESFgEn5ZgLZYT9iu33HteA=
Received: from BN9PR03CA0808.namprd03.prod.outlook.com (2603:10b6:408:13f::33)
 by DM4PR12MB5200.namprd12.prod.outlook.com (2603:10b6:5:397::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Fri, 4 Feb
 2022 18:29:08 +0000
Received: from BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13f:cafe::f3) by BN9PR03CA0808.outlook.office365.com
 (2603:10b6:408:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12 via Frontend
 Transport; Fri, 4 Feb 2022 18:29:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT047.mail.protection.outlook.com (10.13.177.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4951.12 via Frontend Transport; Fri, 4 Feb 2022 18:29:08 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Fri, 4 Feb
 2022 12:29:07 -0600
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>
CC:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        <Alexander.Deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 2/2] pci: mark USB4 devices as "is_thunderbolt"
Date:   Fri, 4 Feb 2022 12:28:20 -0600
Message-ID: <20220204182820.130339-3-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220204182820.130339-1-mario.limonciello@amd.com>
References: <20220204182820.130339-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f99c469-2652-4b9a-66d5-08d9e80c3b53
X-MS-TrafficTypeDiagnostic: DM4PR12MB5200:EE_
X-Microsoft-Antispam-PRVS: <DM4PR12MB5200112B970B49460A9C72A6E2299@DM4PR12MB5200.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FgR8zAyg40jj/f3qm2kOrZNz1fAqcTYk0DcajrmCxUQT327XEcqwEnyWnoKvWAM6NCsUHCZ32urbMefH1phdiivcoaEklHjOUCdtaPwYSpQ9w8z7iJ6mSuNsby0i7d6TzcJbGqJDHXvGAZSjOB3sXYQfnJ2hdL8c4MS70cDp/VgAvBA4FiY6/CYQpidVaomWWTEpapuKOHELEpA47Kd4dqq3k6+JrC/WJ8CyUXjCukZgau7LcAto/VhQb/RBreqykkWTdc3P0sV+WZy7zfk+Z0Uua79Y7skOa1WV9LtzQLAW66kR3bsoBt/08Dg1gcG4rfUEBJLVSW2dn6CK0ceRvUegwXHB/Wj72T+HDOzucOHczoLA59FciDgU/0w1QDdknLsoVE0jjyKK5JHUWMg6LHOB6ZLAY9SqAR1q6SRAgqBNgj24gMwACu5zOPVPQ7jqLj5zrwfa9NbeiUOa5m6Bqi2pNBEjgIjZt60ID0ElrcAALjNmXQOg9MhyzM4OWUmA05Ob2zo9W1fCcKcxGTw6831pzXR3rESWgOdP2Bvdyk/4oNhbWCeRo45bJP7L5Z4b5WYAdtBTV/536ZjH4S4k/JkwkOnlycs4RYMddb3/HhD8H2bTLmHrwCiwH++OIgba/9UJJm7GPgivG4n1asA3Ke/XNt2ia+srpeLq84xGXGtIM/x+57hHcVaiKXHj4WSvANVk1xoIpXrmJNh8TpL05g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(83380400001)(54906003)(336012)(508600001)(110136005)(82310400004)(5660300002)(4744005)(70206006)(86362001)(8676002)(16526019)(81166007)(1076003)(26005)(186003)(2616005)(2906002)(4326008)(8936002)(44832011)(70586007)(356005)(316002)(40460700003)(36860700001)(36756003)(47076005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:29:08.1427
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f99c469-2652-4b9a-66d5-08d9e80c3b53
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT047.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5200
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Downstream drivers use this information to declare functional
differences in how the drivers performed by knowing that they are
connected to an upstream TBT/USB4 port.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/probe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 17a969942d37..b59f6c05e606 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1581,9 +1581,9 @@ static void set_pcie_thunderbolt(struct pci_dev *dev)
 {
 	u16 vsec;
 
-	/* Is the device part of a Thunderbolt controller? */
+	/* Is the device part of a Thunderbolt or USB4 controller? */
 	vsec = pci_find_vsec_capability(dev, PCI_VENDOR_ID_INTEL, PCI_VSEC_ID_INTEL_TBT);
-	if (vsec)
+	if (vsec || dev->class == PCI_CLASS_SERIAL_USB_USB4)
 		dev->is_thunderbolt = 1;
 }
 
-- 
2.34.1

