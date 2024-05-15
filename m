Return-Path: <linux-pci+bounces-7475-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4811C8C6101
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 08:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE57F1F21F85
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 06:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D908C40862;
	Wed, 15 May 2024 06:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f1Vff4JH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA2B44316B;
	Wed, 15 May 2024 06:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755838; cv=fail; b=nnrESaKBszthY6kfbCJFZRHES3OE1lOA3mojhPKN6AP6HCpJQ+QcW0ZXOYImuGcCY5tE9MmA8639dfH6UDqgLqXhdkD2EOsYGPc2fpFYZGeL1nPoXfU6iYCXkzEcTA9v2k7fXQ0VzntmhBfunV3J3LJ6gwRwSNXPezMqq5bDL6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755838; c=relaxed/simple;
	bh=THzrM8ahxTJKIjtidhfoGJUyqYfC0kP1YTE8AmC4Ix8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FviSpFmmviR1zyfXWh76jYHVq2YYIklHp869u5fkEE3aabSAnnHcZvdqZoSgFCZbDlaaAf68x5MW1WHz8E32unsfIo7oTx08Qf7kBlxk8yg/Uo2KezWiIR9eEjocWV0yhevYCg08stuXHFecUTObjYBad9+Nt/EKsALGHhWgk74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f1Vff4JH; arc=fail smtp.client-ip=40.107.95.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQoA78y8HFU9ZFsEaRg5bbN31t/SNV528CmgOUxgyhnK4rGOFRcJo24xWF1B42xyoINcCqnl1Q++EEJPj9fej7unkoKL3yzHUJe7YGuTO3HqMYu5rrj0SBb645opa0yM4hlaxlEbA+5JK2WoetCLJBwvgscDj34l2dsEsb+pYB0/cuX9B3kXNrYeIXTdodKyTPxNsj6TPWXhyHcI4CmTDHO47nB6wPJBNspdIXtgFceLhBKHrNALmwdKR0Hqa4h1YRY2+hw+19AFIOPsXPpyQ+L5WCntB9TY+3s3VUxAklM6xqhd053PjSZnBwAYJO44a+gaokoZ1Geu6AAuXTnnHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0DMDL2cmntv+GEqtM+DWFLmEeuaMCIJxvPHhNL1Yxc=;
 b=AghRJXHQRqutfEbZkB+0/jsgsfkbk5vPelaNr83SAJk/jrOryJEHbxPGtMy4Q/Mf2jQXZimFiKLZip07W85LTfLh2DUKimm04bMRAkse0XNHgjgBqVtJ6SPrqQ7Ur/lfinWJIydUltAMaeg/of16vSox7lRbJ9jVIP4UYA6CLlIjZdRtrSenb/kYQGnHHvmplyD0uA4tgncW6M1VL3yDzsHogVkoMC/VWWDR+PP7HO35obXvOgaMLK/7umNkxogUnmAUm6/ycOQk5uQwusAIIVK9Na4uEYJG3rs1kAJf5L2YKFA8WTx2xJp30kGu/UQzlgUDvuyUYeeKQqJy8seGxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0DMDL2cmntv+GEqtM+DWFLmEeuaMCIJxvPHhNL1Yxc=;
 b=f1Vff4JHSba/TSjjQQogNcw3u08/wTKC7Guim6RtAzUGYKpE7cdiU/5MXV1OfBeeXLV24u0xEXaz46n9z5RDJAQE1QLW3ux4D8k9zei8Rtobp18WbDRvAm9GfeKMdSO1xMSCQEh7v87Z6tSrtplEMMgas6UzxQ1VESFl7rVbeqs=
Received: from SJ0PR05CA0069.namprd05.prod.outlook.com (2603:10b6:a03:332::14)
 by MW4PR12MB7032.namprd12.prod.outlook.com (2603:10b6:303:1e9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Wed, 15 May
 2024 06:50:33 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:a03:332:cafe::c5) by SJ0PR05CA0069.outlook.office365.com
 (2603:10b6:a03:332::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.26 via Frontend
 Transport; Wed, 15 May 2024 06:50:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 06:50:32 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 01:50:28 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
	<ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v7 1/2] xen/pvh: Setup gsi for passthrough device
Date: Wed, 15 May 2024 14:50:10 +0800
Message-ID: <20240515065011.13797-2-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240515065011.13797-1-Jiqian.Chen@amd.com>
References: <20240515065011.13797-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|MW4PR12MB7032:EE_
X-MS-Office365-Filtering-Correlation-Id: 793a59ad-cbba-492c-754c-08dc74ab50ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|376005|82310400017|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BiwMgfZHtnz/lwEJzBjQILySzL9iirr9tnAVxQAwk4Ey0qhwshXV5ZwElOwu?=
 =?us-ascii?Q?o5reCALQIluqmFhi/WgRRv5YiZuhSBAmlWG3bwqPnUbBGzSmFRHJsrN9AXyf?=
 =?us-ascii?Q?NVF8PQSkFc3P6epfhSehVmtaUJK2NdMhx81aXuelTfzi/7qTZS/p2Nsqjaxx?=
 =?us-ascii?Q?94ORvqWuXIUZIfSMZfkFIqhU2khXop8EZ9/DenlGepeaaKftNclT7S6N4VCV?=
 =?us-ascii?Q?oDliIrMgsQZQLTAR31LpTdnq/UmjQiC+bQTTfJd8eW8QDRCCAbOLQZiRAMlf?=
 =?us-ascii?Q?0Ye72GK5fcEKiPhkx8Qpqs8ABKwv7eJQaTZxp7IL2drqjpqpku3O5OJp5BhY?=
 =?us-ascii?Q?JdELPhmVM8CLcLQMUTcu+Ub/3ZCC9CQdrzQFiD+RNORQm3RCAGjhjTZDvoGW?=
 =?us-ascii?Q?9gc/2ZGiaUNGHc8GChSQmbHDF9qSGcc1I/8E0KL5cLEyClpMcJkUcXBoAYbk?=
 =?us-ascii?Q?w0NZyw4aZFNBHfpsDyHc2ARUT607bSpjrh1AQp312QUs6ZlZ8bYikp4Vj5Tc?=
 =?us-ascii?Q?fCuPsTKo+REU/zjbyXfEEsE5yaVyvhLJl4EG01wBrt8o1HXzp7VlhX/Teb83?=
 =?us-ascii?Q?rgwOTL+Nr1j0Z+9tiFnWsqMk5scGPLnCx7dzg2NkTsMLshLknXzeqnDYab5m?=
 =?us-ascii?Q?dght+PxgJbspmpuhXUbQd0gm3Yn+JnC8TN5b0bhEjEQHJ5FiiEOJiROhCV70?=
 =?us-ascii?Q?3yoDCIfgKuZVVqxL9rWfWMh/euyP5155OmjUYr3MWKW3VAGC9yL9AQ6GbjTg?=
 =?us-ascii?Q?bBGQNzCGDo+eN0aeUpZIgc0fyjhHLY15BxARpcsTigabvrWbLCCvKxa5zcV1?=
 =?us-ascii?Q?dTvZXq+OmM/EC8mTKFZj9T7NLspyQ0ogfZcobgusN+aWNDhedqVSPR4/iMNG?=
 =?us-ascii?Q?E7xWHGDXX+NdQRFEqxt9Nt2AQiTdUWECMoyGRts499IPuAvA0gE+LlDEiNeh?=
 =?us-ascii?Q?K8NpKuazJLgrfqYm7N1QKaZusgrdYmhRd5Zw/hDeiokvUZEf+oWEouEDD4Jx?=
 =?us-ascii?Q?bNTCkKicMeLMsO/2dLbBK/TjBG5oMW41MDhpJSI96rpsMzISnvc/sxEoGMDr?=
 =?us-ascii?Q?q/X16C+D88fjWdU/OCclNU5sausoUGq49UFY/MT1K7DDC2L/GfK5/pSFiWQw?=
 =?us-ascii?Q?h21iG0vlcH5P9g5B+OskKgCIBPed4cWn8ejK4LHYce7ZNSFGvb0ZEXdjFZva?=
 =?us-ascii?Q?oc3Jzit4HOVRrw1mLkOiU3gS6ZDQltwVycvVmQDIL+wZEpPTiCShrHflL34N?=
 =?us-ascii?Q?glWAhc59X9pXtyIUIvPH0mYutGVZrcpzxAuha0kMqvqsPJ2JRFMB80pPd2nt?=
 =?us-ascii?Q?DMjsW+0m0DSv2ytTcSbK3cBcGo2PLwXe1ZNnUEb0t0Hsr0sKF8VAzGJsdH2a?=
 =?us-ascii?Q?Iahse5Mm0uMqixn5lrM2gHwrmPBq?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400017)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 06:50:32.4396
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 793a59ad-cbba-492c-754c-08dc74ab50ee
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7032

In PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assign a device to passthrough, proactively setup the gsi
of the device during that process.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
 arch/x86/xen/enlighten_pvh.c       | 21 +++++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/acpi.c                 | 50 ++++++++++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 21 +++++++++++++
 include/linux/acpi.h               |  1 +
 include/xen/acpi.h                 | 10 ++++++
 6 files changed, 104 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 27a2a02ef8fb..711cdcbc6916 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h>
 
 #include <xen/hvc-console.h>
+#include <xen/acpi.h>
 
 #include <asm/bootparam.h>
 #include <asm/io_apic.h>
@@ -27,6 +28,26 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
+int xen_pvh_setup_gsi(int gsi, int trigger, int polarity)
+{
+	int ret;
+	struct physdev_setup_gsi setup_gsi;
+
+	setup_gsi.gsi = gsi;
+	setup_gsi.triggering = (trigger == ACPI_EDGE_SENSITIVE ? 0 : 1);
+	setup_gsi.polarity = (polarity == ACPI_ACTIVE_HIGH ? 0 : 1);
+
+	ret = HYPERVISOR_physdev_op(PHYSDEVOP_setup_gsi, &setup_gsi);
+	if (ret == -EEXIST) {
+		xen_raw_printk("Already setup the GSI :%d\n", gsi);
+		ret = 0;
+	} else if (ret)
+		xen_raw_printk("Fail to setup GSI (%d)!\n", gsi);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xen_pvh_setup_gsi);
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
diff --git a/drivers/xen/acpi.c b/drivers/xen/acpi.c
index 6893c79fd2a1..9e2096524fbc 100644
--- a/drivers/xen/acpi.c
+++ b/drivers/xen/acpi.c
@@ -30,6 +30,7 @@
  * IN THE SOFTWARE.
  */
 
+#include <linux/pci.h>
 #include <xen/acpi.h>
 #include <xen/interface/platform.h>
 #include <asm/xen/hypercall.h>
@@ -75,3 +76,52 @@ int xen_acpi_notify_hypervisor_extended_sleep(u8 sleep_state,
 	return xen_acpi_notify_hypervisor_state(sleep_state, val_a,
 						val_b, true);
 }
+
+struct acpi_prt_entry {
+	struct acpi_pci_id      id;
+	u8                      pin;
+	acpi_handle             link;
+	u32                     index;
+};
+
+int xen_acpi_get_gsi_info(struct pci_dev *dev,
+						  int *gsi_out,
+						  int *trigger_out,
+						  int *polarity_out)
+{
+	int gsi;
+	u8 pin;
+	struct acpi_prt_entry *entry;
+	int trigger = ACPI_LEVEL_SENSITIVE;
+	int polarity = acpi_irq_model == ACPI_IRQ_MODEL_GIC ?
+				      ACPI_ACTIVE_HIGH : ACPI_ACTIVE_LOW;
+
+	if (!dev || !gsi_out || !trigger_out || !polarity_out)
+		return -EINVAL;
+
+	pin = dev->pin;
+	if (!pin)
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
+	*gsi_out = gsi;
+	*trigger_out = trigger;
+	*polarity_out = polarity;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xen_acpi_get_gsi_info);
diff --git a/drivers/xen/xen-pciback/pci_stub.c b/drivers/xen/xen-pciback/pci_stub.c
index 46c40ec8a18e..2b90d832d0a7 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -21,6 +21,9 @@
 #include <xen/events.h>
 #include <xen/pci.h>
 #include <xen/xen.h>
+#ifdef CONFIG_ACPI
+#include <xen/acpi.h>
+#endif
 #include <asm/xen/hypervisor.h>
 #include <xen/interface/physdev.h>
 #include "pciback.h"
@@ -367,6 +370,9 @@ static int pcistub_match(struct pci_dev *dev)
 static int pcistub_init_device(struct pci_dev *dev)
 {
 	struct xen_pcibk_dev_data *dev_data;
+#ifdef CONFIG_ACPI
+	int gsi, trigger, polarity;
+#endif
 	int err = 0;
 
 	dev_dbg(&dev->dev, "initializing...\n");
@@ -435,6 +441,21 @@ static int pcistub_init_device(struct pci_dev *dev)
 			goto config_release;
 		pci_restore_state(dev);
 	}
+
+#ifdef CONFIG_ACPI
+	err = xen_acpi_get_gsi_info(dev, &gsi, &trigger, &polarity);
+	if (err) {
+		dev_err(&dev->dev, "Fail to get gsi info!\n");
+		goto config_release;
+	}
+
+	if (xen_initial_domain() && xen_pvh_domain()) {
+		err = xen_pvh_setup_gsi(gsi, trigger, polarity);
+		if (err)
+			goto config_release;
+	}
+#endif
+
 	/* Now disable the device (this also ensures some private device
 	 * data is setup before we export)
 	 */
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 34829f2c517a..f8690b02bba4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -361,6 +361,7 @@ void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
 
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin);
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index b1e11863144d..9b50027113f3 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -67,10 +67,20 @@ static inline void xen_acpi_sleep_register(void)
 		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 	}
 }
+int xen_pvh_setup_gsi(int gsi, int trigger, int polarity);
 #else
 static inline void xen_acpi_sleep_register(void)
 {
 }
+
+static inline int xen_pvh_setup_gsi(int gsi, int trigger, int polarity)
+{
+	return -1;
+}
 #endif
 
+int xen_acpi_get_gsi_info(struct pci_dev *dev,
+						  int *gsi_out,
+						  int *trigger_out,
+						  int *polarity_out);
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1


