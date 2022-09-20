Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 362585BDA47
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 04:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiITCla (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Sep 2022 22:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiITCl2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Sep 2022 22:41:28 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA56B51405;
        Mon, 19 Sep 2022 19:41:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GnieWtXYPJAZoyiqTeN1rBaTpGqXa+RvGMXXhVFIN88oAh+teafys1P2f/VCxeH4oCPMyufMFxGdX3oHZk7BO66VtBsoXKGBICmZNhycmjZKnhcGD/FLz4VzD3oYic2yPeujrsYotkIfSKBgxCCqmxNkAgBxu1J0bDtGTSYEN77cT2LJa05jcDWZsJZ3fGnocbc1GfTugXp4t5Kr/eOgJJWrewnMGGpEDBBei72I1cAvBKSeGOAyQXUf0bAGm4M8q1HpSzGOHAhz0k0bnsjlgQF7vpjzj40uUk/7NWAU18wRnkPHRfekrs1IwoziplfCaNT0FnInWD3zT4C4PkplkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn6yxmMCdyxR93viznGHqfyK4PWqqQQCGwONBSFGepM=;
 b=FZCTVVthWWtT+Mu14b/GVkyU7CMwYle2dd5bt8jvBhs7cSnSZ0ciGKruclb2lawwLAnmVnT+OswpZ9NQ4BLNg+AEBpCIJ7MNutGaA6bT48s6DGK4qH9wJLTjRVeHwBy78Ye0u/yDBoeFGMifsnJVT2vaTBr7Z5+s7fgi0TUZn9IIdiZectZceTMBV+eg7arYMoIV0N7nHh7qiyG6XFTnN9vdjPvLJUN6DKFBzkoUkfwCqfb0+Z1xmXQVjhXsfufXBJV5Imo8kSmGQzaJmayu7bY2FrrQkrROOA/lJ6CbmAui0cm6FNU4K5SIFd/48ixDGtS4aiaP7oNPbvhzoLcXBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn6yxmMCdyxR93viznGHqfyK4PWqqQQCGwONBSFGepM=;
 b=j2Pq5CPIEbasBTlm5Ty6U5xBFTy4f6IU0IwRM3y/0xGA8djJ9QSzX91C3ishexg073K/CbDSFlo/WjlpKhvxkHqQMrpdUmyrM2vt4rVqbKWBTsm9ypo+MYpwaFQdt3zh+uOORqa8N1WdMI7rE9YoDRhw6J5B71QEEkdgAb+RfK0=
Received: from DM6PR08CA0007.namprd08.prod.outlook.com (2603:10b6:5:80::20) by
 DM6PR12MB4124.namprd12.prod.outlook.com (2603:10b6:5:221::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5632.21; Tue, 20 Sep 2022 02:41:22 +0000
Received: from DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:80:cafe::fe) by DM6PR08CA0007.outlook.office365.com
 (2603:10b6:5:80::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5632.21 via Frontend
 Transport; Tue, 20 Sep 2022 02:41:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT059.mail.protection.outlook.com (10.13.172.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Tue, 20 Sep 2022 02:41:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 21:41:21 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 19 Sep
 2022 21:41:10 -0500
Received: from mark-SkyRiver-slmb.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 19 Sep 2022 21:41:08 -0500
From:   Rui Ma <Rui.Ma@amd.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rui Ma <Rui.Ma@amd.com>
Subject: [PATCH] drivers/pci: Decrease VF memory BAR size to Save host memory occupied by PTEs:
Date:   Tue, 20 Sep 2022 10:41:08 +0800
Message-ID: <20220920024108.418496-1-Rui.Ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT059:EE_|DM6PR12MB4124:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a5e9fb7-2c0a-4256-4135-08da9ab19ad4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a1xYonGmArczlttcB+GnuYmpU48EZFeepGAZR7NB51ksYJ+VBXnjQB5uQ5MZl6bZnRZ/SCA7Om6wrtG6Yp6aiXn3uLBp425hOklIJgWP7L8GNDrMAdox8jwA2Q1k+7llG4Fgo46ipmatmfTFEMihk5x+5QC22P6B9R44T3mLTZAGEYewlw08G+YtjaZQqHnvSKcb5Z7tJvMrSFD5Mc1BO4Hy8oWlp7zpXJ1e/sVAcfnjL9wk0Ugl7kIGKeLa0FQD8tbjyzsXSl+z3Z+bqMxNRLUXc7YqXmS2qr4VR9Md/UUFUtpgv+g8glApVfZIuWbs+Ae3jG82TnaHl6fqPlopEFE6FjMXvKAdhzRH6TZHl5y+QB2mNoBCNqweZwzCKQJCiPbItuQVsJrZ2hqCSEwzrlFwWCQIIAXTobY2Va4jJS/UQLBPZ5uQcvXNHCunAAFSVKmSD69fuVwKqgAC59qsI0hDGvBY4cMK5h1lm/6sWnwywcN2ueqwr8LV27n3PO2dGlBZy2OzErOO84tjLnu/UthfQrNxF6cB5GTuZINISQfgb4B4PdGFAkY0igGXU1HnjuQ0/wPSqBhyVDe2ZYnA9r6t5SgfALJbbVwvyLommVGvb+DPuk1o6j8j5A0WSQ/muP+sR512iAnO13yz+RmK4pLvwnB/K5E7AOXVI7ZWzffCFzMQs7SSLdcg4UzTAP6zVkD5SSalwgk97iLHcVflWjX4JflMEXM2QeusynqNF5HUzU++05ml3U2svzfN6F4djPNvmbrEhPygy67afymgbdRazDvID70sVFkkcXUhFQoyj5hSzHhf+49i9PxebUBB
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(376002)(136003)(346002)(396003)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(4326008)(7696005)(36860700001)(2906002)(36756003)(40480700001)(8936002)(356005)(86362001)(26005)(8676002)(70586007)(478600001)(81166007)(41300700001)(70206006)(82740400003)(83380400001)(426003)(186003)(82310400005)(2616005)(1076003)(336012)(40460700003)(5660300002)(6916009)(54906003)(316002)(47076005)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2022 02:41:22.2899
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a5e9fb7-2c0a-4256-4135-08da9ab19ad4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4124
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VRAM space is fixed, as the number of VFs increases, the actual BAR
memory space used by each VF decreases. However, the BAR memory mapping is
always based on the initial size of the VRAM. So do not map this unneeded
memory can save host memory occupied by PTEs. Although each PTE only
occupies a few bytes of space on its own, a large number of PTEs can still
take up a lot of space.

Signed-off-by: Rui Ma <Rui.Ma@amd.com>
---
 drivers/pci/iov.c    | 11 +++++++++--
 drivers/pci/pci.h    | 15 +++++++++++++++
 drivers/pci/quirks.c | 38 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..d623f46669b6 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -295,6 +295,11 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct resource *res;
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
+    /*
+     * Some SRIOV device's Bar is too large and occupy too much rmap size.
+     * Resize the request resource of VF.
+     */
+	u16 shift = 1;
 
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
@@ -328,8 +333,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 		virtfn->resource[i].name = pci_name(virtfn);
 		virtfn->resource[i].flags = res->flags;
 		size = pci_iov_resource_size(dev, i + PCI_IOV_RESOURCES);
+		shift = 1;
+		shift = virtfn_get_shift(dev, iov->num_VFs, i);
 		virtfn->resource[i].start = res->start + size * id;
-		virtfn->resource[i].end = virtfn->resource[i].start + size - 1;
+		virtfn->resource[i].end = virtfn->resource[i].start + (size >> (shift - 1)) - 1;
 		rc = request_resource(res, &virtfn->resource[i]);
 		BUG_ON(rc);
 	}
@@ -680,12 +687,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
 	msleep(100);
 	pci_cfg_access_unlock(dev);
 
+	iov->num_VFs = nr_virtfn;
 	rc = sriov_add_vfs(dev, initial);
 	if (rc)
 		goto err_pcibios;
 
 	kobject_uevent(&dev->dev.kobj, KOBJ_CHANGE);
-	iov->num_VFs = nr_virtfn;
 
 	return 0;
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..befc67a280eb 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -603,6 +603,21 @@ static inline int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 }
 #endif
 
+struct virtfn_get_shift_methods {
+	u16 vendor;
+	u16 device;
+	u16 (*get_shift)(struct pci_dev *dev, u16 arg, int arg2);
+};
+
+#ifdef CONFIG_PCI_QUIRKS
+u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2);
+#else
+static inline u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
+{
+	return (u16)1;
+}
+#endif
+
 #if defined(CONFIG_PCI_QUIRKS) && defined(CONFIG_ARM64)
 int acpi_get_rc_resources(struct device *dev, const char *hid, u16 segment,
 			  struct resource *res);
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index da829274fc66..82502c5923e4 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4085,6 +4085,44 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
 	return -ENOTTY;
 }
 
+static u16 divided_by_VF(struct pci_dev *dev, u16 num_VFs, int bar_num)
+{
+	u16 shift = 1;
+
+	if (bar_num == 0) {
+		while ((1 << shift) <= num_VFs)
+			shift += 1;
+	}
+	pci_info(dev, "Bar %d get shift: %d.\n", bar_num, shift);
+	return shift;
+}
+
+static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
+	{ PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
+	{ 0 }
+};
+
+/*
+ * Get shift num to calculate SRIOV device bar.
+ * Sometimes the bar size for SRIOV device is too large
+ * and we want to calculate the size to define the end
+ * of virtfn.
+ */
+u16 virtfn_get_shift(struct pci_dev *dev, u16 arg1, int arg2)
+{
+	const struct virtfn_get_shift_methods *i;
+
+	for (i = virtfn_get_shift_methods; i->get_shift; i++) {
+		if ((i->vendor == dev->vendor ||
+		     i->vendor == (u16)PCI_ANY_ID) &&
+		    (i->device == dev->device ||
+		     i->device == (u16)PCI_ANY_ID))
+			return i->get_shift(dev, arg1, arg2);
+	}
+
+	return (u16)1;
+}
+
 static void quirk_dma_func0_alias(struct pci_dev *dev)
 {
 	if (PCI_FUNC(dev->devfn) != 0)
-- 
2.25.1

