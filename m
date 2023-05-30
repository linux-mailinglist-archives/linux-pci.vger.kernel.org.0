Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B55AE7169E5
	for <lists+linux-pci@lfdr.de>; Tue, 30 May 2023 18:40:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjE3Qkn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 May 2023 12:40:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjE3Qkm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2023 12:40:42 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C038E;
        Tue, 30 May 2023 09:40:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=auoYI/7tR/q/htwnsxypEFjjd3ANBIx/PntSX8pUDUPRrqPAPZUYnhU6q7SI5XBsgLSb6Q6R4Nr3Z6rQB0h47O00/DjwQLrAQ0E2whROCc5t7vWveKuIWw2lWyXJhYXoa62t8dV1g/63bEr76IslPbHik8O+r8nzbFA/Eaefaz1y/RpGlFKL2neLSi5n9NFszHu/+TOVVs3wq1ckBw2x5Zm+zaRPn9/tZZpc3txEaqHyLpC9M9yYc5zqkebIYvpWoU+54hfybZ2XvR42ADCBourUMy09oZbo17W0HK9l/SwtTwpzMAA4kEtUxRHYqicKDrDrMec1x+anEivY+nO6qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yPd8OTGDycxlNwmgaxjuPJhy0mVv8FZr21RzRhTXfz8=;
 b=NdS1wN16xtB/fW6Sxitkk//isfrzSY4RbEAUhCKSwAa3G6/z8pN4H6+K3idR38treXY2vkd4RSf98DxC12oIw2XlpGANQGMJExcLQoMZC3mxyoqLI4ZmF12BGVesgwE08391xFnS/rWSuGqYLBPXqumrQDKggHTWoiObbg+iCWni+EiKouUjI96i7HsJ7Kx3pW3ZiEFTs0hzmTwtjfETDh/hgAPMmWBBHrnQQqaKXTIq3diUpSWZXBitWvy8WunGwiqcdSVd8dL6AJrRKgX3Ld9bRZeN8rNiY0vpe1SK3Nkmu8r9RckttuT9Mv8S/Pq6kPEmFnlh4yjGcCFQs6Q7pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yPd8OTGDycxlNwmgaxjuPJhy0mVv8FZr21RzRhTXfz8=;
 b=mlMypBv+5PIM+voLwkDgsn3y+c8cYZdFHMXbiPK+HCiczMuhbdQrkVCDTUDwDXncao/+E7T41Km01ZE7wshlHoIROMl9dcmXv2Cxi7HRYx9qZC4CW7svKJiuwb/3plY+nmVEGV1lVB83UfxOic/qaZ961+nmHrRd+23h4n8L6zE=
Received: from BN9PR03CA0444.namprd03.prod.outlook.com (2603:10b6:408:113::29)
 by PH8PR12MB8430.namprd12.prod.outlook.com (2603:10b6:510:259::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22; Tue, 30 May
 2023 16:40:38 +0000
Received: from BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:113:cafe::e3) by BN9PR03CA0444.outlook.office365.com
 (2603:10b6:408:113::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23 via Frontend
 Transport; Tue, 30 May 2023 16:40:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT023.mail.protection.outlook.com (10.13.177.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.22 via Frontend Transport; Tue, 30 May 2023 16:40:37 +0000
Received: from SITE-L-T34-2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 30 May
 2023 11:40:35 -0500
From:   Mario Limonciello <mario.limonciello@amd.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        S-k Shyam-sundar <Shyam-sundar.S-k@amd.com>,
        Natikar Basavaraj <Basavaraj.Natikar@amd.com>,
        Deucher Alexander <Alexander.Deucher@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH v5 1/2] PCI: Refactor pci_bridge_d3_possible()
Date:   Tue, 30 May 2023 11:39:46 -0500
Message-ID: <20230530163947.230418-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT023:EE_|PH8PR12MB8430:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f4084fd-1b5f-41f1-f8c0-08db612c993c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ncbdg4dC8gpBttNSn0rC3eVfWU54EL5VIGsTFJFv3a9ZG6XyeO2KLQQb/ZpGdc6y5zljUeVHX+D35/aw9+ufnF0ApvPJkYe4EuKiBFUYToAmJBo6YCDVW7SWvGD1vzss37TKNUIZMGEONJsPg+3C3+uNEvuu42oZmQUTs0RWkWH03nfkEj7LDo3KwfSS+cyomZ+PcVqIoWL5bx1Lp6mOVN4uRt3O894BXVLbnOVYY8bBwRVwy0HsOSQF+qhhoDwl9y3fDi2XsfRWDw9XS36JNvG8HoqQzK7QnPqG3Gt8MZ4DvwDgjBpXW4rQlXABbE4VX+fdXeU54JYU1d0BVjp1DV+L2Z/mmKdw+6HxVo/r6fgMfGCax3Idrlmz4Xh4W9fX85SSEhb0EWZZvige2X609cslXpBCc1YikMEUf5A9lQdSII37kHjyobTIgDHVf0MkG9wE7D8JlMdu1VdhpBjyloWpYsL+d07kqG0mZeWO5dc2uU30k47sefFFB8yyvFHA1XhLpiz52/+L0adbs5W18pmZopN0cpTGmXV7tYcN1laDxMcE7uub+hRW89dnDCiPC93iQof/sya/ht3SRsWfU6tS0QZum0TRYiGtsCgqaSdZHfQIIGvAiGqLxmtqAncUXJNzMSCNOqf92V9ejFwr2GQBuzkj0IPU5TIXFzD0fN0o5kSG55KT2VK7ndt5f+VNpPSGSdtRilKrPufT0wvYTI6C02KGyHs5cZv9ujNrSl9OT/YnqhiGKGZp/qdV7nxR2Ibr2McR5Fzq0rbYa3Mz3A==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230028)(4636009)(136003)(396003)(346002)(39860400002)(376002)(451199021)(46966006)(40470700004)(36840700001)(7696005)(356005)(81166007)(40460700003)(26005)(40480700001)(6666004)(1076003)(82740400003)(36756003)(5660300002)(478600001)(36860700001)(186003)(16526019)(86362001)(2616005)(336012)(426003)(4326008)(70586007)(70206006)(6916009)(47076005)(54906003)(41300700001)(2906002)(82310400005)(316002)(83380400001)(8936002)(8676002)(44832011)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2023 16:40:37.9952
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f4084fd-1b5f-41f1-f8c0-08db612c993c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT023.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB8430
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
v4->v5:
 * Add tags
v3->v4:
 * New patch
---
 drivers/pci/pci.c | 68 +++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 5ede93222bc1..d1fa040bcea7 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2978,48 +2978,48 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
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

base-commit: 7877cb91f1081754a1487c144d85dc0d2e2e7fc4
-- 
2.34.1

