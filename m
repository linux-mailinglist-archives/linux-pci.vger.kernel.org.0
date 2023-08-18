Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C44B7780585
	for <lists+linux-pci@lfdr.de>; Fri, 18 Aug 2023 07:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356843AbjHRFPx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Aug 2023 01:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356508AbjHRFPX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Aug 2023 01:15:23 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A2726B6;
        Thu, 17 Aug 2023 22:15:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ImAx0XHXweq9cxFzwr/38kpHevq4xVbdblWlY4eY2lhnY2sDEAz4tGzvAfm2khQQ3T9sOhJRQi9BFnJgDUTNr68d5VDjZ+UwGMiEa9iiBMm43FduywxkE2O1CM0zrSpljhw6G5VNyLzZwweXhYWoequMkiJRKBC3T30MAgx9d9jU1yU2OzZGRiLXuA9kc91UDpJzTTKAyRsowJYIdrPrt2cb49oavd0WbKH2+Ysdz7t2rkf7KhLru06yNwzz5bF0Q2k5m9/6R5P7yD7RuiBJWX2faRElZyU7LMtnl26bCJMzufFSMA+xaO9r3UwniolV5405wrzXnfHUJ0+x4uYgSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6mdpErebdeUHIqJqXzE4h8gfzDj6nsgjdNisiSYee2M=;
 b=ItxB9DbmieBzS/7lNZlfGpiJX8M0gRkXW3OCM8IEYyv9712WUdsgzYFXOIdP9eN/YCwNEHs+cW33uG7/ZjlUplzGkQJxySuEk4lTVuDWNRYwfAc6x+BvmrC3jdhPzYUUuD5cv02CgCgulcbMh9P68N3YO/GpqFvzgVaDfLxvtbkcoJp42nNEvq/3qBdZCgT0rnKF/Uq1TOH62UVTT/X0YOJRHsH4LDbik+7xdAAxGcAPWK2dcNG5pRjPhUXCwlocEAO/ZNqAcCARTz0BDKJzKeB6IGAyyx59mjfXVR7TmxdHRtWxDtLpK1oiuHFhgP8js7+pznfusD6nNVWWZryvpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mdpErebdeUHIqJqXzE4h8gfzDj6nsgjdNisiSYee2M=;
 b=xbgoxgWZBlHK0lcc1p9FE4WFjfIsfJPZ9RAxb9lVoVkn3Z0p1TLa5Sw6sxksrmH7D7PZGNU7wY054xMGHMB91T6SKTG3gtT0slq5lHvS7XmInRjrxv4EstoGgVFlUicONWVrFvLixJMSQXd2g6oKHn6tPXPPhv4Tk4OC/m4q7BM=
Received: from SN7PR04CA0194.namprd04.prod.outlook.com (2603:10b6:806:126::19)
 by SA1PR12MB7367.namprd12.prod.outlook.com (2603:10b6:806:2b5::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Fri, 18 Aug
 2023 05:15:09 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:126:cafe::7c) by SN7PR04CA0194.outlook.office365.com
 (2603:10b6:806:126::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.17 via Frontend
 Transport; Fri, 18 Aug 2023 05:15:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Fri, 18 Aug 2023 05:15:09 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 18 Aug
 2023 00:15:07 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>,
        <linux-acpi@vger.kernel.org>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Iain Lane" <iain@orangesquash.org.uk>,
        Shyam-sundar S-k <Shyam-sundar.S-k@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v13 12/12] PCI: ACPI: Limit the Intel specific opt-in to D3 to 2024
Date:   Fri, 18 Aug 2023 00:13:19 -0500
Message-ID: <20230818051319.551-13-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230818051319.551-1-mario.limonciello@amd.com>
References: <20230818051319.551-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SA1PR12MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e262cff-f303-4be1-12d1-08db9faa17bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6GYZafMXTYjq2f0Gk9HfJWdLzCfZARHLscM/nu4D4J3PWWnsoVnp58mO2bQ/j7OM1mkFrUDJpLlLKNjOtnfnpIt5a21ir+eaRraBUOJ+Es0qA234tjXwEudwU7+r0VprHgE5H1igKGM6BcsGlWxu3BnYYc1Z/IMrhhXlOWmyBayBmz+9/+YdvBLPWY15X1dvi0DJJcWqPtiTKMlQpWyzzZaAmR8WcNfXudiFSwfZFQgQs/wvn7dWy9shcP/GuGLZ8V6+I4fJPXEiZo/b10cd5awMVDhJAAPkVEs8to7DCo6ztBi0zFaHN7ZXE9AgyCXXpXXvxMhqfF32JRVvVwZx9sS7KnNSnAVUcjdD/veUuncqJAWzn+Z44hL88+f0r9wbD5g4vXAJAKx9oFwXEVTwHHXwXe3paLPX9HSfYNkTDRLgDUxnntuLh3yzkFa7fdn4wsBd+0KlsM8DSVKzg1WlW1UjWjlefEn3kcuioOv5BDG2aznOfbQUXL2ABKpn4eWprJ0MddfV8aOAJQgcPP1drg++5eRhHMn5BPkYw8uKwi+52vWdakQKw0FVATWmrMw86KNKRHF55tlxO3vNTcwSHEMXpzIonGfI0zGvriJYl5s2yiMt9zzSTAytx/G25XaomgNLsNT6voLuyM3gTo1hTUARG0lqcKePQDvBmb811KXNJMYi/oeqFaouhe4k+fEBWU0w5XMg8Mcf2IRZtZVnKIGiQkiFVTT0oxysp73TeluUZX0Ewaz6xPCdDDNw146by7BPCwc4RVlqC6oqoFG77Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(136003)(396003)(39860400002)(451199024)(1800799009)(82310400011)(186009)(40470700004)(36840700001)(46966006)(86362001)(36756003)(82740400003)(356005)(81166007)(40480700001)(2616005)(5660300002)(44832011)(110136005)(16526019)(70586007)(478600001)(70206006)(7696005)(6666004)(54906003)(316002)(26005)(1076003)(4326008)(8676002)(8936002)(41300700001)(40460700003)(47076005)(336012)(36860700001)(83380400001)(426003)(4744005)(2906002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 05:15:09.3668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e262cff-f303-4be1-12d1-08db9faa17bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7367
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Intel systems that need to have PCIe ports in D3 for low power idle
specify this by constraints on the ACPI PNP0D80 device. As this information
is queried, limit the DMI BIOS year check to stop at 2024. This will
allow future systems to rely on the constraints check to set up policy
like non-Intel systems do.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
v12->v13:
 * New patch
---
 drivers/pci/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 0fc8d35154f97..5b9e11e254f34 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3049,10 +3049,11 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 			return true;
 
 		/*
-		 * It is safe to put Intel PCIe ports from 2015 or newer
+		 * It is safe to put Intel PCIe ports from 2015 to 2024
 		 * to D3.
 		 */
 		if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
+		    dmi_get_bios_year() <= 2024 &&
 		    dmi_get_bios_year() >= 2015)
 			return true;
 		break;
-- 
2.34.1

