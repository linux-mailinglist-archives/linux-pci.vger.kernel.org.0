Return-Path: <linux-pci+bounces-13075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E9B976571
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD5301C22053
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 09:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C2719F100;
	Thu, 12 Sep 2024 09:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="w6YTj2W/"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2055.outbound.protection.outlook.com [40.107.94.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 032D119E97B;
	Thu, 12 Sep 2024 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133073; cv=fail; b=Ws4fpADevenytKHoP7BlYufTlT0NG70uKTrMP6lzp+P42b+H4B+dVGX8OcirX1Pif44wNA8aTB7JxawckK+BpH4hOecaWDRkJ2H0kNkB2Y/p8LWEh/KoZe7DEAYsc6/Vdf+mrQULWhJAfkFr/fVTBHK+i9hoZruT4T7IOfmjuXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133073; c=relaxed/simple;
	bh=NSz5A+pKGxvKIvGgPDP4tCuLdNMj97er3MSeHJjWVmM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uv9jF7nbw/d8Mi9Iq7LibW4ef0YA7NEtWpmiSOIMExGeuHNmTcGvOKBqFYqhggQuzWqv4RoEki7/DLVVYGMPV72bPyhrrtVvjtinyHQ4UXdWS6KVXrPpd2Z2dNmT8WY9MZPP/4+2tKYYikgB+Y+X8z7Gc3R2g320j5iVklpFKv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=w6YTj2W/; arc=fail smtp.client-ip=40.107.94.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=soF/7JbsPYs2FiECj6WzDRWVx8CW4G8CmveZIVeTw9g9zIQ919sqBvqF/ue2NZnZgkNjM2vBX/DvomeNWNlz5abA9x3eWR/ILdZaYMnNHSHt42ge62ElUHCgCWBziadrKeRWLZu4oiCfgK4fBEQOgAYvWbLMNzdmIAN6PFwMbGT3YU0MPftKgwGgaCaXBM/5nySykMCjPobr+08KN4cXVL6ZaZmjVowUWaoeQtPji/Do9slflCidzQDcJCsyRt+YGlFsdMH2fGKfciMnJ+zpQdB/qPgmT2f0MOm8O7evAwokxNrguRZRnkRE35ddw3TXeGNH5+531cZ843QiD82IvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VoRjaM5eHB5wA0PEqYUhMxGvKJWObMEd8EVOz5Lzs3k=;
 b=UFecN9xItaFZH+fSVIs/K7EHVy9jPEbo/+CKBrVX/MVAWmxRIHNzhcXoF/wO5/wCEDeLY0seFjV2jJ9hcPqp++h45+VOeOgRu0t1ueCsu1xvVB7DhU/wkSRnn5YausLisN7kOVmipYSSgq9ZzNDTlsZlAt9wiNuqm/cng+RPVGBL5QCKVBJuPd/rFP0STb7bzxQhWNzFG/4mrOjScKyp3qleMHcNhCSri+2ZT1bxrBB8fXOfHm3rXjnbMguGLOntdibOoVBVzS+Vq1UNRrmVlRQN7b7I9MD3jMSNs3gIMfJPbiHPSrzmy55RvIGWB0cqvWx91noCuw6L9oQnUb8djA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VoRjaM5eHB5wA0PEqYUhMxGvKJWObMEd8EVOz5Lzs3k=;
 b=w6YTj2W/D5kduozQt5c7pURNhVL/LEE4Kg7HEqwdtJZDjELHysyaPkcUxn7DG8ZDU7sorDdLgLb7LdtvmDdRXh7Lp11IztLB1QOldz9xvxU7Po56dlTlvWcQVDyVxIHrmMa0TW10Ixzw8aHOFsxMYC0JM8izkmCBjSyfCeZJn9A=
Received: from BYAPR05CA0075.namprd05.prod.outlook.com (2603:10b6:a03:e0::16)
 by DM4PR12MB6423.namprd12.prod.outlook.com (2603:10b6:8:bd::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7962.17; Thu, 12 Sep 2024 09:24:25 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::ad) by BYAPR05CA0075.outlook.office365.com
 (2603:10b6:a03:e0::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:24:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:24:25 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 04:24:22 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v9 2/3] xen/pvh: Setup gsi for passthrough device
Date: Thu, 12 Sep 2024 17:23:50 +0800
Message-ID: <20240912092352.1602724-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240912092352.1602724-1-Jiqian.Chen@amd.com>
References: <20240912092352.1602724-1-Jiqian.Chen@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|DM4PR12MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d4ca877-9c35-4470-0c2f-08dcd30cb1a2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DcL9Jj+YqAGZLbISZFgvW5+WNbOD9b2Q3jbTBY4A9gIUWHLZDRRIFYBBT1zK?=
 =?us-ascii?Q?rXZs1e1O3JjX/8E+LVf4/Sa1g7CxIGI8TKl2QL0TOpteIuLxZI+AOViY2ToC?=
 =?us-ascii?Q?i5zL7YhvPbpfo92EqTBiIfSdN9tV5Rs8HxK5APZOSU9eUqhljPNaBLVKHcCP?=
 =?us-ascii?Q?BE4XmiuBsd6bR0icI9x1uKTGXe8UztTU1FjOJkTC81GugyecKPs5ZTdvWcXb?=
 =?us-ascii?Q?vUiyH/H61SO8zGpoqxSqUuvsHB13TlsLkZwBPPuyjI5rEIYGULr1am/T5Dq2?=
 =?us-ascii?Q?VdKcLb/Nmt8qmDtVYRIdt3wxlFOoW76kslcom7+FfvVKKVajfV2SUBtvin/5?=
 =?us-ascii?Q?/wDuwlO92ZFtU4lDfRc81UOt+PWoKCW4Yn3rBK4mEEZ9BpLbbi/foUH0/3pT?=
 =?us-ascii?Q?TVTPl50hENEuuVM+QpxSdNy2HkvkIlAm0KM84mlbIgSqcssD/SO2/Jpyepnf?=
 =?us-ascii?Q?SG/iQOYeJk2RPe/6HVxYWrYwU1uT5GCmKa5RVTnI137ntHgmAIMHuP/dmJQh?=
 =?us-ascii?Q?oOyUol9XYzbyLCOACdhk07D0Ybi6kijlnzov36yNdfhaD12huDEAJMFSz8ZS?=
 =?us-ascii?Q?sP7q3nsViyNiWeela5vTPkU2pItHYxQZ6f3lMw/AZxJlpdgnQfSoZn1hXVrT?=
 =?us-ascii?Q?kkYAfoIuR89V7bceOU2190eLUazXgZyb0d+iwhWs8G2LGgm50BqpjH6MYc/+?=
 =?us-ascii?Q?gTkVCuErN/Em2mjFxQpIynf00wKGrGSfpY1tTuKqQfhvg4rghtzhCvMJrwdy?=
 =?us-ascii?Q?POLYkZVbLa2VVQn8JKdZTnPfDknEeHisIKDtcY7/CMLBlf9UPk9tIQ6Inkm6?=
 =?us-ascii?Q?GzlpxeNOMLN8u/fwArvPBogEARSAZIA0dIEKhAxGthoKttGZUtX7lNni9MBx?=
 =?us-ascii?Q?opAu1sc8IH1AxXvvX13547BW7k8YfFU/IIExsJsC+wH/j+i1qqe0y9nNZYZH?=
 =?us-ascii?Q?No7M4S1EHLhzN12Fx6GNUeXwZIdCiHMzAtQSlmpA0PICxHOCveH4vKE4Gkuj?=
 =?us-ascii?Q?59R9AWhW90zhVMNsAaXMBZohidSGt3kpiD3ZDxVhg/oA0GBRfDSARqAlYEn8?=
 =?us-ascii?Q?69T04AIa5wy49FJTO7v4WouZdwIFOYYbIg9cZtmM8uM9u7cWeyYfayIwaKNt?=
 =?us-ascii?Q?1sknlsYH52VHnXslR8bH0pYty3QxmqzoOmzHkciRI8LAObI0v9SkRBsMas+n?=
 =?us-ascii?Q?ST+3J1EJqeGWeQ6UwWkrmhBaen8BU334PlSAe+Q2kYHWmrB7TfajWPcXryTQ?=
 =?us-ascii?Q?jqQ5Xg8lDcIwESrEd4GgVOUvlM7t7H5rUoiAyOTzQfeo/3BeV/oGJU552Hm3?=
 =?us-ascii?Q?CDAH3ETcWXyX+m0tbE5BvYVqUhB7O9w9Pkm7XwYwpRBD84ZzYpFOHsLSr2L+?=
 =?us-ascii?Q?xM7TeLtePNyt9O4lXg/lYot76gQx5CTDzQ57toSbK6XIuVh1gUYCLbEr5AtF?=
 =?us-ascii?Q?mVvY+Wn0LBE18Lq9z3o2c1bWH2Oz3iWb6nPCHONNpER6Hiw0Hae00g=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:24:25.0523
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d4ca877-9c35-4470-0c2f-08dcd30cb1a2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6423

In PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assigning a device to passthrough, proactively setup the gsi
of the device during that process.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
v8->v9 changes:
Moved the calling of xen_acpi_get_gsi_info under check "if (xen_initial_domain() && xen_pvh_domain())" to prevent it is called in PV dom0.
Removed Reviewed-by of Stefano.

v7->v8 changes:
Used CONFIG_XEN_ACPI instead of CONFIG_ACPI to wrap codes.

v6->v7 changes:
Moved the implementation of function xen_acpi_get_gsi_info to file drivers/xen/acpi.c, that modification is more convenient for the subsequent patch to obtain gsi.

v5->v6 changes:
No.

v4->v5 changes:
Added Reviewed-by of Stefano.

v3->v4 changes:
Removed map_pirq from xen_pvh_passthrough_gsi since let pvh calls map_pirq here is not right.

v2->v3 changes:
Abandoned previous implementations that called unmask_irq, and change to do setup_gsi and map_pirq for passthrough device in pcistub_init_device.
---
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202406090859.KW3eeESv-lkp@intel.com/
---
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202405172132.TazuVpPo-lkp@intel.com/
---
 arch/x86/xen/enlighten_pvh.c       | 23 ++++++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/acpi.c                 | 50 ++++++++++++++++++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 20 ++++++++++++
 include/linux/acpi.h               |  1 +
 include/xen/acpi.h                 | 18 +++++++++++
 6 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/arch/x86/xen/enlighten_pvh.c b/arch/x86/xen/enlighten_pvh.c
index 728a4366ca85..bf68c329fc01 100644
--- a/arch/x86/xen/enlighten_pvh.c
+++ b/arch/x86/xen/enlighten_pvh.c
@@ -4,6 +4,7 @@
 #include <linux/mm.h>
 
 #include <xen/hvc-console.h>
+#include <xen/acpi.h>
 
 #include <asm/bootparam.h>
 #include <asm/io_apic.h>
@@ -28,6 +29,28 @@
 bool __ro_after_init xen_pvh;
 EXPORT_SYMBOL_GPL(xen_pvh);
 
+#ifdef CONFIG_XEN_DOM0
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
+#endif
+
 /*
  * Reserve e820 UNUSABLE regions to inflate the memory balloon.
  *
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
index 3e162c1753e2..8ce27333f54b 100644
--- a/drivers/xen/xen-pciback/pci_stub.c
+++ b/drivers/xen/xen-pciback/pci_stub.c
@@ -21,6 +21,9 @@
 #include <xen/events.h>
 #include <xen/pci.h>
 #include <xen/xen.h>
+#ifdef CONFIG_XEN_ACPI
+#include <xen/acpi.h>
+#endif
 #include <asm/xen/hypervisor.h>
 #include <xen/interface/physdev.h>
 #include "pciback.h"
@@ -367,6 +370,9 @@ static int pcistub_match(struct pci_dev *dev)
 static int pcistub_init_device(struct pci_dev *dev)
 {
 	struct xen_pcibk_dev_data *dev_data;
+#ifdef CONFIG_XEN_ACPI
+	int gsi, trigger, polarity;
+#endif
 	int err = 0;
 
 	dev_dbg(&dev->dev, "initializing...\n");
@@ -435,6 +441,20 @@ static int pcistub_init_device(struct pci_dev *dev)
 			goto config_release;
 		pci_restore_state(dev);
 	}
+
+#ifdef CONFIG_XEN_ACPI
+	if (xen_initial_domain() && xen_pvh_domain()) {
+		err = xen_acpi_get_gsi_info(dev, &gsi, &trigger, &polarity);
+		if (err) {
+			dev_err(&dev->dev, "Fail to get gsi info!\n");
+			goto config_release;
+		}
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
index 0687a442fec7..02ded9f53a6b 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -362,6 +362,7 @@ void acpi_unregister_gsi (u32 gsi);
 
 struct pci_dev;
 
+struct acpi_prt_entry *acpi_pci_irq_lookup(struct pci_dev *dev, int pin);
 int acpi_pci_irq_enable (struct pci_dev *dev);
 void acpi_penalize_isa_irq(int irq, int active);
 bool acpi_isa_irq_available(int irq);
diff --git a/include/xen/acpi.h b/include/xen/acpi.h
index b1e11863144d..3bcfe82d9078 100644
--- a/include/xen/acpi.h
+++ b/include/xen/acpi.h
@@ -67,10 +67,28 @@ static inline void xen_acpi_sleep_register(void)
 		acpi_suspend_lowlevel = xen_acpi_suspend_lowlevel;
 	}
 }
+int xen_pvh_setup_gsi(int gsi, int trigger, int polarity);
+int xen_acpi_get_gsi_info(struct pci_dev *dev,
+						  int *gsi_out,
+						  int *trigger_out,
+						  int *polarity_out);
 #else
 static inline void xen_acpi_sleep_register(void)
 {
 }
+
+static inline int xen_pvh_setup_gsi(int gsi, int trigger, int polarity)
+{
+	return -1;
+}
+
+static inline int xen_acpi_get_gsi_info(struct pci_dev *dev,
+						  int *gsi_out,
+						  int *trigger_out,
+						  int *polarity_out)
+{
+	return -1;
+}
 #endif
 
 #endif	/* _XEN_ACPI_H */
-- 
2.34.1


