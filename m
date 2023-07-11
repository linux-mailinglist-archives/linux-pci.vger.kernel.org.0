Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26EB474E387
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jul 2023 03:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjGKBi1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jul 2023 21:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjGKBi0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 10 Jul 2023 21:38:26 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2076.outbound.protection.outlook.com [40.107.244.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5764CEA;
        Mon, 10 Jul 2023 18:38:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IuC8aQeqKDfHhlGlqjwzkJru41k2xmT1s2/xP+Toe6IJ43kV13RAcmCJC8rt4ioH0K6mVs8yhYndaJKlVB5jJU0ehtRnyWXjKJ6GnrfhSYsYv7E8kIEJjXv9BQf5rt7g3Ghwgr8PuX0dehbuVBcIWz1h7OE3vDKyNJmSDChEX0+KAKDJ7fyvAOxWdQGOaXtCYX/JhZelpu0wIrhQdDiyaphrlpQgWXFIjmdSy3ejhAQabz06R7w7t2Y/PrnRj+tJo2f8aMUdIN/tiKHQtTTj1Zm0nH6RzveC6Fdax4f1uNMCVDBz4Vd9TnpRtjXEq4wjMcVEgKmhNlSQgy8cXvyhvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1anTshY9C9Ufkx6GGkQZ1hmb/VgNZ5K1T57bpVYOmpM=;
 b=KcWtcBT4I1VzE8PxLKeaJKct0fiKZmjFJBAuVq7ZRGLtBptN8/PwimJ8kgr21M/pswcFWQ/LI7TOCW7G9UOcySgKsOqHYDyBT2f9BT8kYsWv+/YYDGbdTq9wragCZyL20qDq52ASDqt7+LYRALxe/ul7r1fwZ2WyCAUV0VxebfSpjifGz07S7zHUe9brGvkq57nbyfVWYKUfn7dnBDeP8lCvD6Mg3uPk3ttJD4wKymAkzqCVOKDknBDUEmk7PMXWGnk/iVN5ZCn9Enqe8xLFpYfne4bnxRtfdqFGllxc0EsKaf2+yMUCrGt53bjHouGcW0qtmvFj4QP4lrj0QgilSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1anTshY9C9Ufkx6GGkQZ1hmb/VgNZ5K1T57bpVYOmpM=;
 b=2BMtQeMwNayeeM+T+0uQAMKy1TZH2PRwDuEwt1oB21cSNb/Lg6CPnvfqFp3rRWLpevJoC9x5hR/f2xFQbpiK5IALW8Tllsv0aynVUFsRLa852JyhGmm9NuheOZm+KdCd+4d0fa/zjPcNDS3Dl2ABsnfn9PKcKzlhGHHjhU6Eb/U=
Received: from MW4PR03CA0047.namprd03.prod.outlook.com (2603:10b6:303:8e::22)
 by PH7PR12MB9065.namprd12.prod.outlook.com (2603:10b6:510:1f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.30; Tue, 11 Jul
 2023 01:38:22 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::ca) by MW4PR03CA0047.outlook.office365.com
 (2603:10b6:303:8e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.31 via Frontend
 Transport; Tue, 11 Jul 2023 01:38:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.19 via Frontend Transport; Tue, 11 Jul 2023 01:38:21 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 10 Jul
 2023 20:38:20 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Len Brown <lenb@kernel.org>, <linux-acpi@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH v7 1/2] PCI: Refactor pci_bridge_d3_possible()
Date:   Mon, 10 Jul 2023 19:53:24 -0500
Message-ID: <20230711005325.1499-2-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230711005325.1499-1-mario.limonciello@amd.com>
References: <20230711005325.1499-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB9065:EE_
X-MS-Office365-Filtering-Correlation-Id: 2806e301-b4b2-4407-b758-08db81af8301
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nLJlllrtw+PoIBVOvL9gtXpSwYwqAt3yS0CZpBnDotDU5UJRTnX5Xr0SJO172f5mzZWH7qQ/x4swdaalzEmmlC/EMlhxeLji4t3v9V3sgXZgm+iKMQ7ObChJvxq01jf76JkhdfReUO2VVMqd3Ij3zv9iWo4zTSGzZlpEFT9lIpwpTm3TwZk4gL/7096YP72w0n7qc/NHQojqcMYAVI3M9fww++b09zfnhYDWM0rh9q7K0HJZx69vyHX3NSyKnckPmVIAzJAJATmU/R8NdLvo1BKbVIvjF/Kf1OIMjw0aMGqNT29G++IMFdNS6wdXAxD0x5n1g909dyhgDA7LA4cB+FMtxeXH1u6pI2d3iHFXBujcXNacA1Avm5IWBvzyi3CDIEAMbQaCu3zz7WM9IdAEGqLkEViRZ/WhvbxAd7EIQjMJ5FULPgXfUd2zM2db2D1RqL0La8eGkDfjoO90QuaGYyUfKzrJazeFZbWX/2pZUfW5k2ksNKJ2tarde9MhSI7p9TljiVvlbhtQp+Ym6ZMBUjRy+DZksiEJsrQ6QFhDKeezJTfn8k5TGGvXj782yRd4ukIfbGLSpAo/NvEy9OsIA2AflaDSxrbTOrsx03jjeb3nJ9y1zkqf8P8V2Uo0+imYCOsuOcmJeIvOEyX/FCpclx8El19yyQSDJbKiAg1hgGTP/5LzADyQHW7Vwq2Nx9oNx3kW/T3V//Eo9tnPi66DBfK5lnYMWAHcB4ML90BWLbdkwv230y3sjOA4nYOdpGyAgtJeUEH27Erk2bVSZBj18Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(346002)(136003)(376002)(396003)(39860400002)(451199021)(46966006)(40470700004)(36840700001)(82310400005)(86362001)(82740400003)(40460700003)(40480700001)(36756003)(7696005)(110136005)(54906003)(70586007)(70206006)(81166007)(356005)(478600001)(36860700001)(26005)(1076003)(186003)(2616005)(16526019)(44832011)(316002)(2906002)(5660300002)(8936002)(8676002)(426003)(336012)(83380400001)(4326008)(41300700001)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2023 01:38:21.8526
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2806e301-b4b2-4407-b758-08db81af8301
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9065
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All of the cases handled by pci_bridge_d3_possible() are specific
to these branches:
```
	case PCI_EXP_TYPE_ROOT_PORT:
	case PCI_EXP_TYPE_UPSTREAM:
	case PCI_EXP_TYPE_DOWNSTREAM:
```
Drop a level of indentation by returning false in the default case
instead.  No intended functional changes.

Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/pci/pci.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 60230da957e0c..f916fd76eba79 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3004,48 +3004,48 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
 	case PCI_EXP_TYPE_ROOT_PORT:
 	case PCI_EXP_TYPE_UPSTREAM:
 	case PCI_EXP_TYPE_DOWNSTREAM:
-		if (pci_bridge_d3_disable)
-			return false;
+		break;
+	default:
+		return false;
+	}
 
-		/*
-		 * Hotplug ports handled by firmware in System Management Mode
-		 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
-		 */
-		if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
-			return false;
+	if (pci_bridge_d3_disable)
+		return false;
 
-		if (pci_bridge_d3_force)
-			return true;
+	/*
+	 * Hotplug ports handled by firmware in System Management Mode
+	 * may not be put into D3 by the OS (Thunderbolt on non-Macs).
+	 */
+	if (bridge->is_hotplug_bridge && !pciehp_is_native(bridge))
+		return false;
 
-		/* Even the oldest 2010 Thunderbolt controller supports D3. */
-		if (bridge->is_thunderbolt)
-			return true;
+	if (pci_bridge_d3_force)
+		return true;
 
-		/* Platform might know better if the bridge supports D3 */
-		if (platform_pci_bridge_d3(bridge))
-			return true;
+	/* Even the oldest 2010 Thunderbolt controller supports D3. */
+	if (bridge->is_thunderbolt)
+		return true;
 
-		/*
-		 * Hotplug ports handled natively by the OS were not validated
-		 * by vendors for runtime D3 at least until 2018 because there
-		 * was no OS support.
-		 */
-		if (bridge->is_hotplug_bridge)
-			return false;
+	/* Platform might know better if the bridge supports D3 */
+	if (platform_pci_bridge_d3(bridge))
+		return true;
 
-		if (dmi_check_system(bridge_d3_blacklist))
-			return false;
+	/*
+	 * Hotplug ports handled natively by the OS were not validated
+	 * by vendors for runtime D3 at least until 2018 because there
+	 * was no OS support.
+	 */
+	if (bridge->is_hotplug_bridge)
+		return false;
 
-		/*
-		 * It should be safe to put PCIe ports from 2015 or newer
-		 * to D3.
-		 */
-		if (dmi_get_bios_year() >= 2015)
-			return true;
-		break;
-	}
+	if (dmi_check_system(bridge_d3_blacklist))
+		return false;
 
-	return false;
+	/*
+	 * It should be safe to put PCIe ports from 2015 or newer
+	 * to D3.
+	 */
+	return dmi_get_bios_year() >= 2015;
 }
 
 static int pci_dev_check_d3cold(struct pci_dev *dev, void *data)
-- 
2.34.1

