Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1B2C5E9BA3
	for <lists+linux-pci@lfdr.de>; Mon, 26 Sep 2022 10:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbiIZIHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 04:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbiIZIH2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 04:07:28 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on20630.outbound.protection.outlook.com [IPv6:2a01:111:f400:7e8a::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EC0A326FE;
        Mon, 26 Sep 2022 01:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FIWHTyO8mkcGqnLG3WaxsSoQ3tBGfpo5O5WC3ELSa18kKjiMuD5/PE7DHkA20mD8u2YDpc+POo6kr2j50rDa7Xgf41dqGHyXFbMcfYZJb6fLFnNSTsPMqzB6bIyTls6TzO0tYD8Kgk0tvTvWaSW4ItiwPKfznhdn70XwKq9YO4JoUCXHV2Z+SHxgjdAQ+ygrCrKeM7Qv5F8s76VqdLh9gWanMk8/KUYK/a7ODwV9MBOxCIf/rhxyY5ZBD5oP4NsqBLgYw24yhXjqXwxu5lpqRGIrU3cg3AnBYTJ4p09D6k0fwuGohxCcPEaqNjkNydJq5SWcKdFhVKsotBOKdF72yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zwQiZde0q90E1eQZijKSP2WvqEUjAPdVjortGVppVIk=;
 b=RrjDW6T2k0yZOPY/oKNqAkbg5sSLXTtbgQ2fbxbpC4jipwFQ6cVbLr0IoK5Ycue8xCYlSDauF98SQEljzuJyLktXrliYvuxv98X3/t8zrBALqBtmVPi/CNIvMO360F6xckQwo9av8vnV7EPWFWaMDm/XzRtOE9+cbgKavq4BytQ6HTYDRzlBtT4GhpozJbIcoWs+0JgV2KAr8sUt0+Sae0LnVoJ46qfqD3xKdcE4KdmS2YmsCQAVRjfyikOP9C7WzdkmNI0DNlIp4Df+NrD0unUgBVzNwAFM8RtwYZRTtNLFy5QANAipoYNaYZVEPAwRhDpWMYd3Qpu5VfdHPz8FGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=google.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zwQiZde0q90E1eQZijKSP2WvqEUjAPdVjortGVppVIk=;
 b=qLueTSytDVd03+H2KXAzwgOPeGmxS3KYOoHLCDlu8jqI1cb3Toe6PDpwR0S1f03cjbw/SBB/VoZ/BYnY8ypuXITxaYdqZ1QaT9x/gDmKOKcM5ugRnxK6wFEetHz5q6dpbvgszeUtcMh4Zje6hiDY9FsNr95XbDJPjHakeN7bZJ4=
Received: from MW4PR04CA0248.namprd04.prod.outlook.com (2603:10b6:303:88::13)
 by MN2PR12MB4536.namprd12.prod.outlook.com (2603:10b6:208:263::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25; Mon, 26 Sep
 2022 08:05:56 +0000
Received: from CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:88:cafe::d2) by MW4PR04CA0248.outlook.office365.com
 (2603:10b6:303:88::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5654.25 via Frontend
 Transport; Mon, 26 Sep 2022 08:05:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT086.mail.protection.outlook.com (10.13.175.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5654.14 via Frontend Transport; Mon, 26 Sep 2022 08:05:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 26 Sep
 2022 03:05:45 -0500
Received: from mark-SkyRiver-slmb.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28
 via Frontend Transport; Mon, 26 Sep 2022 03:05:43 -0500
From:   Rui Ma <Rui.Ma@amd.com>
To:     <bhelgaas@google.com>, <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rui Ma <Rui.Ma@amd.com>
Subject: [PATCH] PCI/IOV: Decrease VF memory BAR size to save host memory occupied by PTEs
Date:   Mon, 26 Sep 2022 16:05:42 +0800
Message-ID: <20220926080542.920427-1-Rui.Ma@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT086:EE_|MN2PR12MB4536:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d7aae5e-7297-4bca-9350-08da9f95f0bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZIUtWoPXgv7D5IiY5OemCBFNwx9askTtBWKhHnmNpFTb0phcm6sxeWu66KnM7MEjdRgR1UmV0/w14oCvsU4+1zqtot75Nj3OXevt6FkxH6xCKrKWQIrun4K+IYrotOfZwUQFVithLQzx0K/nghgadyhR4qT1T69djfkxILl9VgCBnChAV2ibpFQZ65Qj/vhmb0SDwqymANuX/iBrszrXKnP7uy8halgFBWA1LizFviOkezNfJWNNCCC+hL/RiZF3jbao8kZxS+yWn/6CW6slVeFDQc1gDzUw1i3h3BY7J9K/ADgIYiARDDOhXagk7TA4iydUDzSPnwBZ77bYa4sA3o0rZyx6MP2sSFt4kj4LJptNcJ2HXwg6GVEhnXcpKO9IIrV+Bc+w+eOHlmkVHH+G3l3Yt8V8o7H6+HnkQU8sK+z29trtSJCxBVSUpMH+95nUaok6CKPVrHnj6h5JR2U+IQxlDxHbaG1kCOlcvNg1orMrLCq2XXI7O5A0CnSL+CwCc8H4KrtUWv5MUs7uyvBrW7jVbRnTpGOM1Z8/peu+665RLpE2H1AGKcAMHL1riJ/fDco7OMANZ3pMBM73cd9ZGiPFVOdJMXoBMfO4lkQ9rqse8Z1r9ksIzdCrzOmz2fEisKB/SZvHDKX6XzLPIG2dYUNMUd0VE3uyVjNnsmmZm67Qbt3gnZ6Vii0jYut/wdqkGBr2ZT6rnmLRRV8v4nzpcqrjZvEa/Rohxk6q2+nqMqqTSnE5w7u/+Pr48Cp3L/J4UIdRftO3DcmxEB0pLa+OV/NqpIuZxw+KPkpdiYeBhCxD+F32DG2gW7FU8XR19IpC
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(40460700003)(82310400005)(41300700001)(7696005)(8936002)(26005)(36860700001)(5660300002)(47076005)(83380400001)(36756003)(81166007)(2906002)(356005)(186003)(426003)(336012)(82740400003)(2616005)(1076003)(478600001)(110136005)(54906003)(316002)(40480700001)(86362001)(8676002)(4326008)(70586007)(70206006)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Sep 2022 08:05:56.2461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7aae5e-7297-4bca-9350-08da9f95f0bc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT086.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4536
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In SR_IOV scene, when the device physical space(such as Video RAM)is fixed,
as the number of VFs increases, the actual BAR memory space used by each VF
decreases. However, the BAR memory mapping is always based on the initial
device physical device. So do not map this unneeded memory can save host
memory occupied by PTEs. Although each PTE only occupies a few bytes of
space on its own, a large number of PTEs can still take up a lot of space.

Signed-off-by: Rui Ma <Rui.Ma@amd.com>
---
 drivers/pci/iov.c    | 14 ++++++++++++--
 drivers/pci/pci.h    | 15 +++++++++++++++
 drivers/pci/quirks.c | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
index 952217572113..6b9f9b6b9be1 100644
--- a/drivers/pci/iov.c
+++ b/drivers/pci/iov.c
@@ -296,6 +296,14 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
 	struct pci_sriov *iov = dev->sriov;
 	struct pci_bus *bus;
 
+    /*
+     * Some SR-IOV device's BAR map range is larger than they can actually use.
+     * This extra BAR space occupy too much reverse mapping size(physical page
+     * back to the PTEs). So add a divisor shift parameter to resize the
+     * request resource of VF.
+     */
+	u16 shift = 1;
+
 	bus = virtfn_add_bus(dev->bus, pci_iov_virtfn_bus(dev, id));
 	if (!bus)
 		goto failed;
@@ -328,8 +336,10 @@ int pci_iov_add_virtfn(struct pci_dev *dev, int id)
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
@@ -680,12 +690,12 @@ static int sriov_enable(struct pci_dev *dev, int nr_virtfn)
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
index da829274fc66..add587919705 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -4085,6 +4085,43 @@ int pci_dev_specific_reset(struct pci_dev *dev, bool probe)
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
+	pci_info(dev, "BAR %d get shift: %d.\n", bar_num, shift);
+	return shift;
+}
+
+static const struct virtfn_get_shift_methods virtfn_get_shift_methods[] = {
+	{ PCI_VENDOR_ID_ATI, 0x73a1, divided_by_VF},
+	{ 0 }
+};
+
+/*
+ * Get shift num to calculate SR-IOV device BAR. Sometimes the BAR size for
+ * SR-IOV device is too large and we want to calculate the size to define
+ * the end of virtfn.
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

