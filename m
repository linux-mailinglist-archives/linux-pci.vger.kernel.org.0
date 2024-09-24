Return-Path: <linux-pci+bounces-13413-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AE6B983CDF
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:15:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E19C51C21AA1
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 06:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7948383A17;
	Tue, 24 Sep 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ynAxTSmS"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2087.outbound.protection.outlook.com [40.107.95.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3A74964D;
	Tue, 24 Sep 2024 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158514; cv=fail; b=or2ubuFLQTf6UDw9gwL0ARUM4WfMfC3zLlPWj8AkYcaeR8qzoKZ/pzwnNAdVNfcsrzcLmNdzFt/9oyAJ6wRMAgj+JnoqHbsofqP6yxK32VOvCjSzecIGqUaFhrYME6+qq5DTtJlTr3S5uLIwCRKItiSPuZaYtrjU9345AKIpGIs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158514; c=relaxed/simple;
	bh=O5sVKAVSj1SECIAKAceUjzDO42LQdd9FkSYNtf+P/GU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DY+BJToZKEG7scVKy1jmR7kklVMOZcyYUgWho17rGLIgyReCpH4TeSvql4QsgQf4j+zEuuSWeV40Rsu1nkNIl27y+RDTlxAG967Fv45Gt9Sp9nHy2Lo5HvOvaCNzWmzv0O70V0e2vSf238zzPm8PYpgznnOOAb9goBUj/mRxp0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ynAxTSmS; arc=fail smtp.client-ip=40.107.95.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SfpU1GOV7Ek2Eaiemwxfb3eZkVmmS2tw2prjyOhUVjICl44zgVBrpsbM4oh8lrRM5VeTCKksnVAoJ1qK9WlJXKc5++EjxREh5GeKLjmJlUwzkOB6P4DKK3mtZgwQWxExpJXZULCRqs8QKMrJLssfXm8Kv/6m6ypyWcHWU75Y3/HILydk9YTdf9t6alV9YGEZxybIYINUTjURljDwQMlgPw86/Tq/oDTy7emcH+28IBgnYZ0lisP09L56CnZx8CE18FqTVhDeOiL0nPLpRxWYdLR0nG0LQJ/cCmQLeGLosEVU6D3jQVCQ6klffV3Ub2rmEe/XBLMb/iq1aTMOMaKbsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M1vzlihP9DyssCZ7QmmrO6JjnMD+yxhWmdBPz/lDfb8=;
 b=HddQHhCNJBYyHXtcftXF/x2Wi6U4ygfiF0Vvdal04T/y7o/ddh2ZKLKwf/SU/Xsu6oIaUPGFVX47TNtRSyGCSZCDmSyD6Y4rxAFYCmz/Xph5VwGb5drb941WHYzSAVe7AYi9NCJJ/0gVxrctpFykRpiqvFA71VFXBpKofAGF+qqiZPWBDAIQdI0P/TuI7iIjEXaB7TLT411aMLBReKuzsDO9oFxZkmd5Ad+RRZYGhx46i+eVw0q5uY6wAuo5QReO1ve1zcJ8fi8zE8+2fDlR8BONt258uhH9X6wZomLQXz/r00/Gjm55trpKng/qYY42TiS+AZS8fORa7wVATYdWbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M1vzlihP9DyssCZ7QmmrO6JjnMD+yxhWmdBPz/lDfb8=;
 b=ynAxTSmSU54f1see1ampO6hs1llVY3YqozIGd1qPopqa1KrpKH2/eT9LjQpWez7862tLEEVSYA8TIfjbKF/JSX54V2gLHY1p7xrXpHfVy5Asmg5+3EqjKiM2g2+TxzxRu7jYoGftAsjqIs8c285Gzj99oH0CyYxHeHdOqUKFu3I=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by DS0PR12MB7655.namprd12.prod.outlook.com (2603:10b6:8:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.26; Tue, 24 Sep
 2024 06:15:06 +0000
Received: from SJ5PEPF000001F3.namprd05.prod.outlook.com
 (2603:10b6:303:83:cafe::a5) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27 via Frontend
 Transport; Tue, 24 Sep 2024 06:15:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F3.mail.protection.outlook.com (10.167.242.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Tue, 24 Sep 2024 06:15:05 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 01:15:01 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>, Huang Rui <ray.huang@amd.com>
Subject: [KERNEL PATCH v10 2/3] xen/pvh: Setup gsi for passthrough device
Date: Tue, 24 Sep 2024 14:14:36 +0800
Message-ID: <20240924061437.2636766-3-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240924061437.2636766-1-Jiqian.Chen@amd.com>
References: <20240924061437.2636766-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F3:EE_|DS0PR12MB7655:EE_
X-MS-Office365-Filtering-Correlation-Id: aeb7c041-de07-4e1f-1823-08dcdc603bf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?YfKLOI/NFD/eyozKUGoLprXEpWLBLBEAPnzWMRWJnX0zKw/mS86A8NlavzBM?=
 =?us-ascii?Q?PnTGwHITskVEgy7dAXTEbSo5koHjCOeQNGY8SQNi7iEJTA7CcuY8ktv2Me4a?=
 =?us-ascii?Q?TTwC5wIV6ykDOPs2G73Ocxbk2Tbcw6WrAkoS9DkTDFR84lD9U6j9ClTikFdd?=
 =?us-ascii?Q?Db0fi96PS2B2LVUr0BLXG9Ncz4VZ8IYF6KQuCfQbpDFA7YfV1p8Wzyi2NdAr?=
 =?us-ascii?Q?+MOlzxX+X8dFC/RqPuSeCVDref5MnaMNzY5RckmtSuOYhxWRUasJHUv7F4i2?=
 =?us-ascii?Q?0MCLSdQ9WQHvOrp94pOh+Z1WgI4xnR5mA+liDxXG8hd97VetCHNlWQF09jR3?=
 =?us-ascii?Q?Obnq/wjO/m7VIoJVLhwa7cu3I4oxkLvQbjglil9ihz5ugw7bAk5tqe/EH4CE?=
 =?us-ascii?Q?qENQIJ/7/PPqOv6J6hjVS3LIYiS0hQ1ujEyTJr2D4hv3Pxx4J/iLJ46iwDth?=
 =?us-ascii?Q?M2D4KfF9NhT7iMdSNoM4APXm/R7813hRYWGqSu6jxWYDTOKtx782AAv7HUFs?=
 =?us-ascii?Q?V2jVfRXi8sJ2XSUJlt+dMNS8pmL4oHtVyiLRG+sBZ9nqKk+AFHXzz3AVwdAh?=
 =?us-ascii?Q?plOPY0OXMuLdwYAbCaHeaEB6CxsmbaSQ4ww8rVFpdM19SmdT+zdOF8HHw5LT?=
 =?us-ascii?Q?1UGHOC7fGzZWCnAuSxhhy7lTBkTYhqcHIQhvrnvS39Cx/5o0/xbBYOKO5LY2?=
 =?us-ascii?Q?rBQBJ38zkkoTnwLqw+5GVr4wJX2wJvUJ6vB1/dOYHyM0jaKL7CODCYF4xl6Y?=
 =?us-ascii?Q?Yv3OXBWncni3vmKwZGoIpTA9IvjmRt6UgV+X5OaNPTGTJdifb9bevD2qt6l7?=
 =?us-ascii?Q?uEGRIXEPGuodBBiG2hroNq0qGwjhJiSIzY0d21QuRZFnacDafWtMP+0HUi1r?=
 =?us-ascii?Q?VEPzVWk1fstzvF4q9+TN7Wp3pgLOL0MZ7TurWoHIt+xPgV/mwx2pbYT0UvFe?=
 =?us-ascii?Q?Mat89L6hszZPncb59Qt4jX9twJYmy8VlVNhbFGwZ5FQ4wKJ9P9JLB1oFv9NH?=
 =?us-ascii?Q?fHJI8/Nr6lIZl76dtwnryfXX6ktuhLpBdgXal+eVPA/OpnzEFPC5egzpJuiJ?=
 =?us-ascii?Q?l0nfg688DXH+aRojHK6ppqNEyozbowXYeub3Wgy3pdkHA5WtfeXrq0tpv35q?=
 =?us-ascii?Q?uBvNu9Cn8LNeXUYjdNzWE5UJHZD97UnyqMoJUURg/c69OmnY7zh2KcjVTc9B?=
 =?us-ascii?Q?QXaWzXUg3bDz1s+Dl5aMRuIxLCcqaYcDzUI9dEkb3qKkM/pSm5ezFgiU7vuf?=
 =?us-ascii?Q?oBEGo1DzvUi+ERyUWZPpv0aMnye9sziW+dhlQYvW0dygWGFeJzhIr8ySxi9X?=
 =?us-ascii?Q?8KygHGNLRDuYHJMaXBCI1pxaqC3gjnE4ECkjZVBf4ms2jzZGq72q+jZstZ8Z?=
 =?us-ascii?Q?RqmQDMgfXEowNlLhbg4Xu4QZ47gncfTDwvvaF4FC1jeG8au1N0MNXhC7QGMV?=
 =?us-ascii?Q?8NnHJ63UKFTcEUVf+ckJfr72YQSIxWS/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:15:05.8898
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb7c041-de07-4e1f-1823-08dcdc603bf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7655

In PVH dom0, the gsis don't get registered, but the gsi of
a passthrough device must be configured for it to be able to be
mapped into a domU.

When assigning a device to passthrough, proactively setup the gsi
of the device during that process.

Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Signed-off-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
---
v9->v10 changes:
Added Reviewed-by of Stefano.

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


