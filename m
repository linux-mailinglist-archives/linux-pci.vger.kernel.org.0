Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01D7A148E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 05:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjIODsC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Sep 2023 23:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjIODsB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Sep 2023 23:48:01 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2042.outbound.protection.outlook.com [40.107.243.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF97268A
        for <linux-pci@vger.kernel.org>; Thu, 14 Sep 2023 20:47:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fyrFzhsNLQGTvVNE3Anu6ePE4M6Pv1Qu3cPihc0HBSHvBSs8jfBIX0GisE7PsOHxA0FQe2ZjZ3xcZOOQM3rxXC4YxjrTrtLSEPubawDgE3aQLo73NRYBl5y4HxDJfqX9XmnGRGSheNoMiE3tB+/gJwzUHekoTdbsezP6XBnBYdHH6225c4y0LUId0hSCtNGyEEQ2958MunbQyHcVPgZuM0woSt0hLAJAzGZK6ke9g2eU+druWfYtuG8z2kCLmoczCHVoVb8Y+dNXdAhneqoBcTmrbNbFSrvurUcLQjIU9/+mvFGM2tb9+mS5InEenQdYmmCMpM7ifpXzxKFYLFfetA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FgronEOfItiiC43Q6JAvapnqM7Zx8h8Xs3VP4Owv7q8=;
 b=YmVqBPpF8eVt5+W82KV58ke+qrH4iSn+z8V45rrkiwEO3POFK4dSZGgjhbxlWR3hhuRGn6JX+GSWVAfFUn4uaXHstCJXloDyRe2rt7l2PsfdRWzEGWwa4VRZhB/kRgj2M93p1FqwmfZcrBOCcvRgVxqnqWYHhoD4i2L8X7rqkKYMYdYiIBt2KHydUCXJY30ywUsaNpPHCtFAdoMrWZ5uB/9uE+mLgPht9GAr5AqNkTtQMPtTkwrpsYboWFA6ecKxicRs6XbO/IM7NLgDPqXQfXPrbyxA5GZCS5jZQFFIGdqv4/HxmD1sTLtwzrueCWe2tuTT8KoHTz2OQVC/pizgHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FgronEOfItiiC43Q6JAvapnqM7Zx8h8Xs3VP4Owv7q8=;
 b=Albr9O2l1fB3qdLZWrKAM646BnLQXYVLidFwWk7UVeV2q0t+MXP4Aq0VHbqhZlmrhknsf3tBhWjme7RhvwZpJbydqOOn6eKGU8qXgHcBFxp0bCpi3SiAUdi2ZTA76iSshHYG7lLLP80AunGTnFA0MMnx5AmlTM44GkFKD7EF+uE=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.20; Fri, 15 Sep
 2023 03:47:46 +0000
Received: from MN1PEPF0000ECD5.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::d8) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.21 via Frontend
 Transport; Fri, 15 Sep 2023 03:47:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD5.mail.protection.outlook.com (10.167.242.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.19 via Frontend Transport; Fri, 15 Sep 2023 03:47:45 +0000
Received: from AUS-P9-MLIMONCI.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 14 Sep
 2023 22:47:41 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
CC:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        <iain@orangesquash.org.uk>,
        Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v19 1/2] PCI: Move the `PCI_CLASS_SERIAL_USB_USB4` definition to common header
Date:   Thu, 14 Sep 2023 21:33:53 -0500
Message-ID: <20230915023354.939-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230915023354.939-1-mario.limonciello@amd.com>
References: <20230915023354.939-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD5:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d03d2f4-de9b-4b1d-eac7-08dbb59e85ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3DQn6KqwMax6fmPUl/7TxG2L8f6XOSoDICmYXMb0aa6o1llj2qSULfMg8qufDykfuMJoDJmA/40gRy7W1wfGOaB/di111hyzn9J9LBZW5Idmql6x9uDqwcEUJwtDKNFmCb25hRrJkPWhaR2D4bilFe99XXoXlrDGf4OgneysM6FyY8OXzLfVYarmHfSMhZA0fVea4QwLSnZRSQ5CRCJBQM9xys2iUbb7/BfXmoyOejHk30YEhdDTpKT9ErOf3SAPN0UUcu69zx8KqDu4niCE5/ALFOPJXNkVQ+go+8FCw/PcxxV/Wxm1DDI8FeYoqZyAbETXwhhOF+fE+7hFW++z7Vlf2HpKQT4eimd1sq19UPspUZY+8j6gAhzMFq4e+UvUleX+GE/opgQ1XRpaB2j98bIf0poOwM8kMx73cWm44FYT5XpIO67JY1PzKR4EG65aOkcEneIlVs7wyGoq2rAuApHjKV0GCsrrUKFzM1OW/vM1nSFOLY38cmc8PUykCXS9Tf0zPtMBLTKdXltbdQQ5MKDoI+bvCkqR3m/TSnNLClBfZ9qxRZS9eN+0f6PMEMXLfJWuNs7qH5fTG7A68NqQPR1zo/R8ma806lpuQpbS1Whx5QMQaFsI8q7XaDxEH8Pig8DeyMTGZ+rTu6sQyIOUuznVnpvdVjajtwCDUPfs9M9LBFShphUgdwx6YoIwqPjK26gXSPhh+0qXeIxWQGzvuyvBiCQXqz14WfKZ6THgwZGAy70ZNFuVAu2v1Fcv7TZ6n//vhB382b6AZa/PQl7hLF8y3aHoOy3a2kOkA/uQcLo=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(39860400002)(376002)(82310400011)(1800799009)(186009)(451199024)(40470700004)(36840700001)(46966006)(40460700003)(47076005)(44832011)(5660300002)(40480700001)(8676002)(8936002)(41300700001)(54906003)(4326008)(316002)(110136005)(70206006)(36860700001)(70586007)(426003)(336012)(6666004)(83380400001)(2906002)(7696005)(82740400003)(36756003)(81166007)(356005)(86362001)(1076003)(16526019)(26005)(2616005)(478600001)(81973001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 03:47:45.9010
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d03d2f4-de9b-4b1d-eac7-08dbb59e85ed
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

`PCI_CLASS_SERIAL_USB_USB4` may be used by code outside of thunderbolt.
Move the declaration into the common pci_ids.h header.

Cc: stable@vger.kernel.org
Acked-by: Mika Westerberberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/thunderbolt/nhi.h | 2 --
 include/linux/pci_ids.h   | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/nhi.h b/drivers/thunderbolt/nhi.h
index 0f029ce75882..675ddefe283c 100644
--- a/drivers/thunderbolt/nhi.h
+++ b/drivers/thunderbolt/nhi.h
@@ -91,6 +91,4 @@ extern const struct tb_nhi_ops icl_nhi_ops;
 #define PCI_DEVICE_ID_INTEL_RPL_NHI0			0xa73e
 #define PCI_DEVICE_ID_INTEL_RPL_NHI1			0xa76d
 
-#define PCI_CLASS_SERIAL_USB_USB4			0x0c0340
-
 #endif
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 5fb3d4c393a9..29aeac53dc41 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -121,6 +121,7 @@
 #define PCI_CLASS_SERIAL_USB_OHCI	0x0c0310
 #define PCI_CLASS_SERIAL_USB_EHCI	0x0c0320
 #define PCI_CLASS_SERIAL_USB_XHCI	0x0c0330
+#define PCI_CLASS_SERIAL_USB_USB4	0x0c0340
 #define PCI_CLASS_SERIAL_USB_DEVICE	0x0c03fe
 #define PCI_CLASS_SERIAL_FIBER		0x0c04
 #define PCI_CLASS_SERIAL_SMBUS		0x0c05
-- 
2.34.1

