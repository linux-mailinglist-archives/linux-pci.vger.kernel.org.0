Return-Path: <linux-pci+bounces-732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAF0F80BC1C
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 17:16:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFE21F20F09
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 16:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46031182DC;
	Sun, 10 Dec 2023 16:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MLxN6e6Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A8FA;
	Sun, 10 Dec 2023 08:15:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PfqbCwPVUJ+Y86f4IlIm0klx9RE8h/+d22GupL4sfNeIlMVaJPd32JfEYRuKe/GTGSf3+Fxe+DFDX7t9hdQ9QvG6hDSS/wV5wcyBgzxKnKrMeInCpQHzUOQYUzyl+/s2QU0efsJUE30N/2V5DqJHlsNpBipmpSIBeECJYkP/9mUirCpSaIC0oLmXIYp7Cot3xSrsdlTsTlLkVB8B44PM6KZdCxJIVsdn58RaemTy0CuAm4+FtvbG5Q0kEdQ+Z0hK//u9jvf7JmYuv2WPVBbuRwV8n615bNmrYv/3VvZJ7DAlFvV5ZD0M7xaJzay/RaHaO483PpVBgfux/MmudpLTBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7ZzpD1Q9U1FBd+Cui/rhmlxEnZC6P7a6CPX3YbcNCVg=;
 b=YTVhdXMFxxkOsdFJFvrtW8yKIdnTgZxCmdsH3DcnXCvBuprQupSxSEPTukTZr73YgjhI/HOe9j4LvZ8S+DURyX9eC0TZ2hG/YIIVM7MFiCqZhElXYbT3xMwxFaAGpngGuaA606+C7l/kzp5S2C8tiqhZBWTtfJa5QCQqO85GlD2c/6hFS4b9+FvJNsc7rbycAi+nMAx1VMB0A08EZXE1jPnvRyFoloBeDgM7j67RatwMFiGTZ1rOtLhrbC8O55beZ5JGIwkIeGEIZSKEvNoS+nUrNnZuFNrporYIOn38+hnzINonDzlVsYXNoR32R/iMDnip4a8iPVKh6PmGZ4mT4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7ZzpD1Q9U1FBd+Cui/rhmlxEnZC6P7a6CPX3YbcNCVg=;
 b=MLxN6e6ZzFCUfT2P6aRtvwpUy1pg30VtMWaLy6eGM6p6+3wkKmj7FpeIJCc/fdclJPhjTKZczqloDxBbzaUSaAzZjqNM81i68sTMI4Pmtefztcl5Eghb0bevHxhr7jqci+ywoU0AH/ATt6Em3+sfJT3mQm2oKW6Um1YPp1/7tI8=
Received: from CY8PR11CA0046.namprd11.prod.outlook.com (2603:10b6:930:4a::6)
 by IA1PR12MB7519.namprd12.prod.outlook.com (2603:10b6:208:418::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 16:15:50 +0000
Received: from CY4PEPF0000E9D2.namprd03.prod.outlook.com
 (2603:10b6:930:4a:cafe::e4) by CY8PR11CA0046.outlook.office365.com
 (2603:10b6:930:4a::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32 via Frontend
 Transport; Sun, 10 Dec 2023 16:15:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D2.mail.protection.outlook.com (10.167.241.145) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 16:15:49 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 10:15:43 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <xen-devel@lists.xenproject.org>, Alex Deucher
	<Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
	<xenia.ragiadakou@amd.com>, Honglei Huang <Honglei1.Huang@amd.com>, "Julia
 Zhang" <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v3 2/3] xen/pvh: Setup gsi and map pirq for passthrough device
Date: Mon, 11 Dec 2023 00:15:18 +0800
Message-ID: <20231210161519.1550860-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
References: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D2:EE_|IA1PR12MB7519:EE_
X-MS-Office365-Filtering-Correlation-Id: ef4d8cc1-c0af-4dd5-99af-08dbf99b4644
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rLD43QNXwEf9iZU2ACpTh2OyKu1vfqhy8LHHGgJC1/egSOQpVjtONHY6dPyJF72SNm5RQBEZmtO/QPYDK/jo0bOSpcFx6HWn8IyJ+uzsvXLMhGDjeP44Kz0USFqsois5BsZZ8xxHXN7LeRzFItHkBNWP1ntmKBhrzSGQ589K3M7jDArvCIKuYCDRFyIqfsJtnwjlHWdMZA5sec4cuGgJT2oy9VOb7L/hM5TlWHL/I7McObsrSobpspL/9CNLffOCmHfIBYeioGEPjjGMooL9AYy5NhHrf2xuqKqPI6Ky9sbbBBxvT1Ldgq819WoEMh7MQfEJcVmgnyeBKiymOfhhx1K7nomgZpniCQGGO5s3Gjwgjn1VuZHcJoT1zyIFOVlQ9d5BWbohtU3hrZXP1yLp5MF3ozgjaAGvAf6k0aI+u03HPQIJQmm1Jp5vuG2kQrekwTmtyBvZbrN7Jy4oZ9T7WM/WSprdn7TzsS/dXFNJbrQlrX6QhF+/J0IRCATd1MuDEGPv04wgF0f19TCEdnhblwH56kxUoMpQUlFAC2ZJ7HY/0OUY96chLLDPs51wNiTKEdO+vT032s4tP71sWpRUDfkRgid6y5MgqTSAG2FA9upAuJkgR23bJwIzwnMmnQTkdTmfcgR/qH4KaQQMBOdf8gJQPZ4+PxEh/fHCjTu9LboW8vK1EqdzaGXNIOeyAAgFc8Unu2fMtX+xDeUFmu0VTLyh1/s0NkVJ1xSJ6Pk0bJhuNZ+qPCU4XiwDf19wx6n2fQdYemw5DBJhMQXbTGY0Tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(346002)(396003)(136003)(230922051799003)(82310400011)(64100799003)(186009)(1800799012)(451199024)(46966006)(40470700004)(36840700001)(40460700003)(1076003)(26005)(16526019)(2616005)(336012)(426003)(7696005)(6666004)(36860700001)(83380400001)(47076005)(5660300002)(7416002)(41300700001)(2906002)(4326008)(478600001)(8676002)(8936002)(70206006)(70586007)(110136005)(316002)(54906003)(82740400003)(81166007)(86362001)(356005)(36756003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 16:15:49.6111
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef4d8cc1-c0af-4dd5-99af-08dbf99b4644
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7519

When dom0 is PVH, the gsi isn't be unmasked, that causes two
problems.

First, in PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assign a device to passthrough, proactively setup the gsi
of the device during that process.

Second, for hvm guest, it allocates a pirq and irq for a
passthrough device by using gsi, before that, the gsi must first
have a mapping in dom0, see Xen code
pci_add_dm_done->xc_domain_irq_permission, it calls into Xen and
check whether dom0 has the mapping. But currently PVH dom0 uses
the kernel local interrupt mechanism instead of the pirq. So if
passthrough a device to guest on PVH dom0, it will fail at the
permission checking.

When assign a device to passthrough, proactively map priq for the
gsi of the device during that process.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 arch/x86/xen/enlighten_pvh.c       | 116 +++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |   2 +-
 drivers/xen/xen-pciback/pci_stub.c |   8 ++
 include/linux/acpi.h               |   1 +
 include/xen/acpi.h                 |   1 +
 5 files changed, 127 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index ada3868c02c2..d74a221bfb81 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/acpi.h>
 #include <linux/export.h>
+#include <linux/pci.h>
 
 #include <xen/hvc-console.h>
 
@@ -25,6 +26,121 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
+typedef struct gsi_info {
+	u32 gsi;
+	int trigger;
+	int polarity;
+	int pirq;
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
+		return -EINVAL;
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
+static int xen_pvh_map_pirq(gsi_info_t *gsi_info)
+{
+	struct physdev_map_pirq map_irq;
+	int ret;
+
+	if (!gsi_info)
+		return -EINVAL;
+
+	map_irq.domid = DOMID_SELF;
+	map_irq.type = MAP_PIRQ_TYPE_GSI;
+	map_irq.index = gsi_info->gsi;
+	map_irq.pirq = gsi_info->gsi;
+
+	ret = HYPERVISOR_physdev_op(PHYSDEVOP_map_pirq, &map_irq);
+	gsi_info->pirq = map_irq.pirq;
+
+	return ret;
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
+		ret = 0;
+		xen_raw_printk("Already setup the GSI :%u\n", gsi_info.gsi);
+	} else if (ret) {
+		xen_raw_printk("Fail to setup gsi (%d)!\n", gsi_info.gsi);
+		return ret;
+	}
+
+	ret = xen_pvh_map_pirq(&gsi_info);
+	if (ret)
+		xen_raw_printk("Fail to map pirq for gsi (%d)!\n", gsi_info.gsi);
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
index 24f599eaec14..c3aeefbf4ba1 100644
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
@@ -427,6 +428,13 @@ static int pcistub_init_device(struct pci_dev *dev)
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
index 54189e0e5f41..a211bdcdd6ff 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -360,6 +360,7 @@ void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
 
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin);
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index b1e11863144d..ce7f5554f88e 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -67,6 +67,7 @@ static inline void xen_acpi_sleep_register(void)
 		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 	}
 }
+int xen_pvh_passthrough_gsi(struct pci_dev *dev);
 #else
 static inline void xen_acpi_sleep_register(void)
 {
-- 
2.34.1


