Return-Path: <linux-pci+bounces-1698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08635824E98
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 07:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93020285662
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 06:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6688E612F;
	Fri,  5 Jan 2024 06:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CyPIM26Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE3B1D68C;
	Fri,  5 Jan 2024 06:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N4m0EWegQmhRTrEJKBoaIufqDKD6u6YBNKO6kKi8bfKIDKM8bdB4zEBxtNMCResQEFt1yeDxiMWuSSIUxxDokrmZeNBvhuucH4XYn7BbXXS9mTDfUx9sHCkMka2grRiNBLKFJ38dkoEp8XciHPC7kjJMO4dzza8u9bkhKHJebh63VAiyiKXKC/a3rOQeTstXjnPx8ti8KBvSI8WIwjv2jLGVENgmTdkwT4+ZHnuO5Xg+nHbh2YuhLU+23wRkApesI8i2Aa+rdOQmwNIWiL61FX3J6e9MBlHNXlM0EG4AaiQjGeaR6t4ArytNtGQV4Jm9ZTrVwpAQKlPR65VpjAyLZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RXqnYEfJ7mLljaqmJdZX4G1SrM2H3l3MYlqNsjGgGEw=;
 b=Se7TC4lHN9t4D6zDAODmzGBShbg3TAcbH1WG9QSPsZyKUi21xuCGtqiz1YG+STkh5EaXy0KEQ1IJbEheohcsTf72DVdoc5MtePMWleRz5/0WFaWz53svl8j4zPDtqGgaqHA3ESHMu5ItSEAXMrR/uQQkJoGCavNsVRW7BdWR10QnEpzyrIHY5ovrwudVNqy1d3d4pIG3VqFzaFgEAO2t4xFH/KJTokiclo8/sQe6mH95AflXejpG5CoiS5+oxK7Ns074p1N5FHbMaeru6+f2t+u3LujxewQP5iAppJ4tIb0xzEHNc4YGBsQL2WPcI9KnluE8pWv3WlU7zur2hF2i8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RXqnYEfJ7mLljaqmJdZX4G1SrM2H3l3MYlqNsjGgGEw=;
 b=CyPIM26Q7Z6BHCq606/iJsRpGGDJyraG64OZZ+stjK7foZj+KBy6nRGSOvvUUF62W2/eT7JzCyFExp93tCPNFXkI6l8ktGYlOSIHTQUVUK0TE6EOq4uRecfkSyQ99NbkYAdEhzhOk+Y3n/3Ia/oj7O3pD6/MvoD7Xx9X06GucWE=
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7159.17; Fri, 5 Jan 2024 06:22:51 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::a7) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.14 via Frontend
 Transport; Fri, 5 Jan 2024 06:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 06:22:51 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 00:22:40 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, Boris Ostrovsky
	<boris.ostrovsky@oracle.com>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J
 . Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, "Stewart
 Hildebrand" <Stewart.Hildebrand@amd.com>, Huang Rui <Ray.Huang@amd.com>,
	Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v4 2/3] xen/pvh: Setup gsi for passthrough device
Date: Fri, 5 Jan 2024 14:22:16 +0800
Message-ID: <20240105062217.349645-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240105062217.349645-1-Jiqian.Chen@amd.com>
References: <20240105062217.349645-1-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|DM8PR12MB5430:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c29200f-2865-448f-2d8b-08dc0db6be87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	m7GCGwSKSpzWwXgiJPdhPrAVEEa/9pNiNOx2iHiZIiDPMfHVME0r/ACL9FPoy5bJAaQgUa3TjyucPiKWBznOSqoI67ZBeET90EeDc24T5noqjoMn+2xqZkih5n+2ojTW0FchkXN/eS3HqII54YYXMIdpOYV0b0Wft+Yna34gmeLcrYiGHw0CHzdIejn6wOalepBJPsESoXwWB49p1sQgfyQsslcDeklaWWzatqmTme2ch6oNl4cEAlEg6BZjhlB/EAb8krkNiYnXEgLMa2fcU4PLfoYH45PZ0OnmYawNdtw07tovQkAc3WSKOOhbY4MzA7zMI4F4mHAa9YACMwPCZZikip1u72SFy6p8oOC3QoLRNvCX4kLze77Jc6Zo47bG0AgCSpofLWMeJwrgSbtnmowAljdbcBy/9RyMRt8Zx/GcFIRAq0kpCEblMEKb3GvcLZuvf5/wN2YfHIrhRfRxXtCpY9kGwTnkshPd0kvxYnkFNkpYCUtGBV+XtMqTILZiEZzQovDHlucKpqJlp1a/LG1iwdFE93xtf2+mjDFYFkkHH8sJxP9s97dkvlAlaxX8jgxp1rVpqG8v9VcAS4VH6M78qshsc9IUfzxPcqskVF6UFhwE0J6gdd8EsuOJfjCs05dJgREYL1OKamL2yce+1TaFWfxkD1UyB4idhm/YK6s4JAQsbvxWphrvJ5Qlfxr+YH9ZsyROO31JLrTIDAls6p0gZJRmBeSJlndIn4EbKRJ96f1Jiz6Ui7DdehEc4C8SSKTmhATqWVii7b1pTz7prQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(451199024)(186009)(82310400011)(1800799012)(64100799003)(40470700004)(46966006)(36840700001)(2616005)(336012)(26005)(1076003)(426003)(7696005)(6666004)(16526019)(86362001)(83380400001)(4326008)(8676002)(8936002)(316002)(54906003)(7416002)(36756003)(2906002)(5660300002)(110136005)(478600001)(70206006)(70586007)(82740400003)(356005)(81166007)(47076005)(36860700001)(41300700001)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 06:22:51.0725
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c29200f-2865-448f-2d8b-08dc0db6be87
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR12MB5430

In PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assign a device to passthrough, proactively setup the gsi
of the device during that process.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 arch/x86/xen/enlighten_pvh.c       | 90 ++++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/xen-pciback/pci_stub.c |  8 +++
 include/linux/acpi.h               |  1 +
 include/xen/acpi.h                 |  6 ++
 5 files changed, 106 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index ada3868c02c2..ecadd966c684 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/pci.h>
 
 #include <xen/hvc-console.h>
 
@@ -25,6 +26,95 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
+typedef struct gsi_info {
+	int gsi;
+	int trigger;
+	int polarity;
+} gsi_info_t;
+
+struct acpi_prt_entry {
+	struct acpi_pci_id	id;
+	u8			pin;
+	acpi_handle		link;
+	u32			index;		/* GSI, or link _CRS index */
+};
+
+static int xen_pvh_get_gsi_info(struct pci_dev *dev,
+								gsi_info_t *gsi_info)
+{
+	int gsi;
+	u8 pin = 0;
+	struct acpi_prt_entry *entry;
+	int trigger = ACPI_LEVEL_SENSITIVE;
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
+
+	if (dev)
+		pin = dev->pin;
+	if (!dev || !pin || !gsi_info)
+		return -EINVAL;
+
+	entry = acpi_pci_irq_lookup(dev, pin);
+	if (entry) {
+		if (entry->link)
+			gsi = acpi_pci_link_allocate_irq(entry->link,
+							 entry->index,
+							 &trigger, &polarity,
+							 NULL);
+		else
+			gsi = entry->index;
+	} else
+		gsi = -1;
+
+	if (gsi < 0)
+		return -EINVAL;
+
+	gsi_info->gsi = gsi;
+	gsi_info->trigger = trigger;
+	gsi_info->polarity = polarity;
+
+	return 0;
+}
+
+static int xen_pvh_setup_gsi(gsi_info_t *gsi_info)
+{
+	struct physdev_setup_gsi setup_gsi;
+
+	if (!gsi_info)
+		return -EINVAL;
+
+	setup_gsi.gsi = gsi_info->gsi;
+	setup_gsi.triggering = (gsi_info->trigger == ACPI_EDGE_SENSITIVE ? 0 : 1);
+	setup_gsi.polarity = (gsi_info->polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
+
+	return HYPERVISOR_physdev_op(PHYSDEVOP_setup_gsi, &setup_gsi);
+}
+
+int xen_pvh_passthrough_gsi(struct pci_dev *dev)
+{
+	int ret;
+	gsi_info_t gsi_info;
+
+	if (!dev)
+		return -EINVAL;
+
+	ret = xen_pvh_get_gsi_info(dev, &gsi_info);
+	if (ret) {
+		xen_raw_printk("Fail to get gsi info!\n");
+		return ret;
+	}
+
+	ret = xen_pvh_setup_gsi(&gsi_info);
+	if (ret == -EEXIST) {
+		xen_raw_printk("Already setup the GSI :%d\n", gsi_info.gsi);
+		ret = 0;
+	} else if (ret)
+		xen_raw_printk("Fail to setup GSI (%d)!\n", gsi_info.gsi);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xen_pvh_passthrough_gsi);
+
 void __init xen_pvh_init(struct boot_params *boot_params)
 {
 	u32 msr;
diff --git a/drivers/acpi/pci_irq.c b/drivers/acpi/pci_irq.c
index ff30ceca2203..630fe0a34bc6 100644
--- a/drivers/acpi/pci_irq.c
+++ b/drivers/acpi/pci_irq.c
@@ -288,7 +288,7 @@ static int acpi_reroute_boot_interrupt(struct pci_dev *dev,
 }
 #endif /* CONFIG_X86_IO_APIC */
 
-static struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin)
 {
 	struct acpi_prt_entry *entry = NULL;
 	struct pci_dev *bridge;
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 46c40ec8a18e..22d4380d2b04 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -20,6 +20,7 @@
 #include <linux/atomic.h>
 #include <xen/events.h>
 #include <xen/pci.h>
+#include <xen/acpi.h>
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 #include <xen/interface/physdev.h>
@@ -435,6 +436,13 @@ static int pcistub_init_device(struct pci_dev *dev)
 			goto config_release;
 		pci_restore_state(dev);
 	}
+
+	if (xen_initial_domain() && xen_pvh_domain()) {
+		err = xen_pvh_passthrough_gsi(dev);
+		if (err)
+			goto config_release;
+	}
+
 	/* Now disable the device (this also ensures some private device
 	 * data is setup before we export)
 	 */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 4db54e928b36..7ea3be981cc3 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -360,6 +360,7 @@ void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
 
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin);
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index b1e11863144d..17c4d37f1e60 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -67,10 +67,16 @@ static inline void xen_acpi_sleep_register(void)
 		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 	}
 }
+int xen_pvh_passthrough_gsi(struct pci_dev *dev);
 #else
 static inline void xen_acpi_sleep_register(void)
 {
 }
+
+static inline int xen_pvh_passthrough_gsi(struct pci_dev *dev)
+{
+	return -1;
+}
 #endif
 
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1


