Return-Path: <linux-pci+bounces-6474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E21228AA745
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 05:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 128061C209C3
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 03:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DA7D1095C;
	Fri, 19 Apr 2024 03:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bFBSlXLQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B74C8FF;
	Fri, 19 Apr 2024 03:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497809; cv=fail; b=OOAu1pgFrILcFEs6M3crPEAnVNSXpwnNVolZSWMQ84CaWe/5aCp0lVIJx9Y/nxEsHWMPSFp36RNt742JXE8i1pBMuGYr2X0aSb+VbjMAo2NVV9S+50mo+TbzUayUkZZT2xiFJFMuoG1ieKnAJ1P1RHVebDifisOtqeiSQIfl3Es=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497809; c=relaxed/simple;
	bh=TXMiNvh0VO/5mjFj73gDDPssazD7Ienm7AuHcYPkbX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mZh0Jrb0xG645ISb84DwoLhdKA41bVgTBvKy1ZdEk18i97kbCqw8/0bc7VH20AXrUnaVNrbCb7DpBruM7x0rOIWnbm88AnT1/R+KXdmA8UsVjhPWSyMSXgd5H5WnjeRYCG43kK6MSZYcfxH3hVxBa9hsKNdCV22+tB6DjvW3x0A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bFBSlXLQ; arc=fail smtp.client-ip=40.107.93.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMALzLdiL29migiT8Ei+bXTD6vaVif0K3vrATKLUgBPVId/eVvxeA/zVP7Op6WgIODBWsELSuzjobTp3heUeX4ulWO5KX8rf6saHfdjkp0UKhzt9pprW2teNqIVz44X1nIStuGWCeIcBsO9Kh19VMM7HuOb6Rp/eOuEYAI2G4c9Yi5ImH7i3W87OJUGxFmcATVQGoL3wsAvPAHwM2LJp1lSiLanLyq3VcAzz+A653jJMOwXzWnLINoSv+zo4eqinQQxsaWWmkgU0iFvmTa39K3ERKablozmnnal+daBcyKT9EBb1oxsbpH298AXG7+5gaB5CvuyX9cp09k7j/Zv2jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TrsH2kqfUbago2wYG2lTp8qlxKK3xB7MTeNRFg867cs=;
 b=UImrf7Ql0xDcUJqwD6BA4PHCKDCm1PXz3mimvc5BWZvssJosD5AwDlxbRWSM8PC1EHJqTtvxV69XbCAfYfLvz1JjbHTk3hJcbnj2jTu1e0UPvYW36e79VjCXTC+CfGeHnQm+ZpAHM1sEUmJ4rtDFX2eX06j0VHvXCsvJ70Vg7yuiHtpGtETeNgkKZJ7ckmrFvqcI9gmeO896QOCCpSbF5jSk4zm8CI7fP/zisq5QiycGIGI2Il4GYquyv00eRYiWIlM1r2XcGIVj0yz8tFbaWhLkKvW8EZHmIPo5XY2JP7xHHza1T1LOpbNEamLI7+u9O/J9CQ8VFIFmxADi4Wjjfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrsH2kqfUbago2wYG2lTp8qlxKK3xB7MTeNRFg867cs=;
 b=bFBSlXLQVO3BmiuAcDERRIP4XdB5wGj8zYXILR6mRe9pOmcnrXPdchEB82VAqGzeTQ7wcKFoqmHILWCA4/OONbDLuVxy7WvHEi4toETAENK07jk9oa+tZskhYOropqbVUiWmU5ivzr7gL1o9sCPrhQwpuCri97Qg5Pk9lruvNlg=
Received: from SJ0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:a03:331::8)
 by SN7PR12MB7812.namprd12.prod.outlook.com (2603:10b6:806:329::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.43; Fri, 19 Apr
 2024 03:36:44 +0000
Received: from SJ5PEPF000001CE.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::d5) by SJ0PR03CA0063.outlook.office365.com
 (2603:10b6:a03:331::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.30 via Frontend
 Transport; Fri, 19 Apr 2024 03:36:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CE.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 03:36:44 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 22:36:40 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>, Huang Rui
	<ray.huang@amd.com>
Subject: [RFC KERNEL PATCH v6 3/3] xen/privcmd: Add new syscall to get gsi from irq
Date: Fri, 19 Apr 2024 11:36:16 +0800
Message-ID: <20240419033616.607889-4-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240419033616.607889-1-Jiqian.Chen@amd.com>
References: <20240419033616.607889-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CE:EE_|SN7PR12MB7812:EE_
X-MS-Office365-Filtering-Correlation-Id: 4140075f-2dcc-449d-b2e2-08dc6021ef85
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qCoDbzT3dA3YI352qyd7ZF+UOoe1knwr+Mb92/8u4yyOWpGerUQlhQvjI98Q?=
 =?us-ascii?Q?1u/33fa59PlPavQbkdx1D1tGzyXJcVBs6HFHizb2rnwG3ycQ24XBnRQ6e5cY?=
 =?us-ascii?Q?PKFgT4I1/SspMMzUqeit+zeghMzqI/nUnMfG93O6VCwDTyI9RGm7sZb9jPTv?=
 =?us-ascii?Q?/1l2yX6VjSijN3NWEQmaZBg+LhRuPaTNyU9SRzPO1RdyQDq1gJfAaTio5g4P?=
 =?us-ascii?Q?TLnypU6Js6Ok/zHiorDHFpU4W1co5DbRIfb78Orz+drvlFjmFwppiKivejUq?=
 =?us-ascii?Q?MUPVvviTGGtYHOdE3G+eUo0mtRBUMipjVXUHjtLGxPcJ6euX5hbwgWa6cEw3?=
 =?us-ascii?Q?qicVbUM6xrM0agrnwOwL/gvJF6osVJIiEmUSzqcvQUMNZb2KKIbLQLt1d7eP?=
 =?us-ascii?Q?rt1zIyFVUfTkE1VevI+hcYp1rArCNSq6mo/Ar3KGv5OxYQfzsj/9YMbMv9ae?=
 =?us-ascii?Q?fCsCkGDBcw+vLaowXXhm8nJb/xkfZDe8Whc1k7Zvq6+mHSvA5InMUP8PSGYM?=
 =?us-ascii?Q?tl/YAGZ05ZHk2KtQmCxhf7S4boXi1f+9/F5DSHgBVKubkIhdBzqwJzUcXK2U?=
 =?us-ascii?Q?yJejKpl4gvwQup+XTJWM0s0qWQCwAYoRtcCLGrrE7QV2FRQ4Vuuar3l9Y3aZ?=
 =?us-ascii?Q?5/F/qboc5Lwjto4h0r2b4iHs2puQwNmLoq51qWl8KyriddoTk5wtK7QnJSBO?=
 =?us-ascii?Q?1XWuQ0Hpt1u8tIYc3IhFVIXDixaBLg9VQmpQfySuJrugZeSF5Hrpo2o8xEvM?=
 =?us-ascii?Q?0dg4igRtSfqxBFeHMBMcHxvvbB9QykiYSuFsuAoEDodn4gkkG97uUx/Ut/RY?=
 =?us-ascii?Q?9rPOzmBBL4OsTnCGXYywdOhNhKrmQ1+ZHsKg5V716i7h4dPR5JSasfBZSsqH?=
 =?us-ascii?Q?teYTtxw7+6ucbvwDubKp6+slByjh6ZZutOW98ai+RJOMAY0uJj9mMKvQbe5o?=
 =?us-ascii?Q?1WR0KNTB4SPwblMMg0ur2qiIwcRbZf9cnvqtCv6ya0U4T6m5q/YQbssFyYhr?=
 =?us-ascii?Q?CalN3aZ8RwX1nviVJK5rerlu+Z0Ees8f+ztDYEsvrT5hWI3tfjl4nrRESYWm?=
 =?us-ascii?Q?PsHE4ia6t/Edde+6W/nE7Xr7NQbzT56fC4Vii0U9yMYlXjIMhEnVXGwaAxrU?=
 =?us-ascii?Q?UZFFmeCyIAq4t+UPjykt+bFBg68efyhKRvyeu+CdkVnJuIaLn7r9PK0lcGEP?=
 =?us-ascii?Q?7QTZd/nB0iyspvkugFFizCZbPNUnZ0dNTmoy5ryLHW5/KycEqcoTZ8iDuPsi?=
 =?us-ascii?Q?lGpjtZBB9CB0nxQL0k8qLzHPi7iORj3p6AsDuZJlvaVzyDMMYz11OdLHi/bR?=
 =?us-ascii?Q?Htxvl0vYQuy4+5yUF71qRGl5gZvm3F9KTQ/9TEtUT/UHl9x+uTS7dr9PgKKN?=
 =?us-ascii?Q?+wp5ramO1IrsKAWcTE1AoNugGbYR?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(376005)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:36:44.7221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4140075f-2dcc-449d-b2e2-08dc6021ef85
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7812

In PVH dom0, it uses the linux local interrupt mechanism,
when it allocs irq for a gsi, it is dynamic, and follow
the principle of applying first, distributing first. And
the irq number is alloced from small to large, but the
applying gsi number is not, may gsi 38 comes before gsi 28,
it causes the irq number is not equal with the gsi number.
And when passthrough a device, QEMU will use device's gsi
number to do pirq mapping, but the gsi number is got from
file /sys/bus/pci/devices/<sbdf>/irq, irq!= gsi, so it will
fail when mapping.
And in current linux codes, there is no method to translate
irq to gsi for userspace.

For above purpose, record the relationship of gsi and irq
when PVH dom0 do acpi_register_gsi_ioapic for devices and
adds a new syscall into privcmd to let userspace can get
that translation when they have a need.

Co-developed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Jiqian Chen <Jiqian.Chen@amd.com>
---
 arch/x86/include/asm/apic.h      |  8 +++++++
 arch/x86/include/asm/xen/pci.h   |  5 ++++
 arch/x86/kernel/acpi/boot.c      |  2 +-
 arch/x86/pci/xen.c               | 21 +++++++++++++++++
 drivers/xen/events/events_base.c | 39 ++++++++++++++++++++++++++++++++
 drivers/xen/privcmd.c            | 19 ++++++++++++++++
 include/uapi/xen/privcmd.h       |  7 ++++++
 include/xen/events.h             |  5 ++++
 8 files changed, 105 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index 9d159b771dc8..dd4139250895 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -169,6 +169,9 @@ extern bool apic_needs_pit(void);
 
 extern void apic_send_IPI_allbutself(unsigned int vector);
 
+extern int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
+				    int trigger, int polarity);
+
 #else /* !CONFIG_X86_LOCAL_APIC */
 static inline void lapic_shutdown(void) { }
 #define local_apic_timer_c2_ok		1
@@ -183,6 +186,11 @@ static inline void apic_intr_mode_init(void) { }
 static inline void lapic_assign_system_vectors(void) { }
 static inline void lapic_assign_legacy_vector(unsigned int i, bool r) { }
 static inline bool apic_needs_pit(void) { return true; }
+static inline int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
+				    int trigger, int polarity)
+{
+	return (int)gsi;
+}
 #endif /* !CONFIG_X86_LOCAL_APIC */
 
 #ifdef CONFIG_X86_X2APIC
diff --git a/arch/x86/include/asm/xen/pci.h b/arch/x86/include/asm/xen/pci.h
index 9015b888edd6..aa8ded61fc2d 100644
--- a/arch/x86/include/asm/xen/pci.h
+++ b/arch/x86/include/asm/xen/pci.h
@@ -5,6 +5,7 @@
 #if defined(CONFIG_PCI_XEN)
 extern int __init pci_xen_init(void);
 extern int __init pci_xen_hvm_init(void);
+extern int __init pci_xen_pvh_init(void);
 #define pci_xen 1
 #else
 #define pci_xen 0
@@ -13,6 +14,10 @@ static inline int pci_xen_hvm_init(void)
 {
 	return -1;
 }
+static inline int pci_xen_pvh_init(void)
+{
+	return -1;
+}
 #endif
 #ifdef CONFIG_XEN_PV_DOM0
 int __init pci_xen_initial_domain(void);
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 85a3ce2a3666..72c73458c083 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -749,7 +749,7 @@ static int acpi_register_gsi_pic(struct device *dev, u32 gsi,
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
-static int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
+int acpi_register_gsi_ioapic(struct device *dev, u32 gsi,
 				    int trigger, int polarity)
 {
 	int irq = gsi;
diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 652cd53e77f6..f056ab5c0a06 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -114,6 +114,21 @@ static int acpi_register_gsi_xen_hvm(struct device *dev, u32 gsi,
 				 false /* no mapping of GSI to PIRQ */);
 }
 
+static int acpi_register_gsi_xen_pvh(struct device *dev, u32 gsi,
+				    int trigger, int polarity)
+{
+	int irq;
+
+	irq = acpi_register_gsi_ioapic(dev, gsi, trigger, polarity);
+	if (irq < 0)
+		return irq;
+
+	if (xen_pvh_add_gsi_irq_map(gsi, irq) == -EEXIST)
+		printk(KERN_INFO "Already map the GSI :%u and IRQ: %d\n", gsi, irq);
+
+	return irq;
+}
+
 #ifdef CONFIG_XEN_PV_DOM0
 static int xen_register_gsi(u32 gsi, int triggering, int polarity)
 {
@@ -558,6 +573,12 @@ int __init pci_xen_hvm_init(void)
 	return 0;
 }
 
+int __init pci_xen_pvh_init(void)
+{
+	__acpi_register_gsi = acpi_register_gsi_xen_pvh;
+	return 0;
+}
+
 #ifdef CONFIG_XEN_PV_DOM0
 int __init pci_xen_initial_domain(void)
 {
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index 27553673e46b..80d4f7faac64 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -953,6 +953,43 @@ int xen_irq_from_gsi(unsigned gsi)
 }
 EXPORT_SYMBOL_GPL(xen_irq_from_gsi);
 
+int xen_gsi_from_irq(unsigned irq)
+{
+	struct irq_info *info;
+
+	list_for_each_entry(info, &xen_irq_list_head, list) {
+		if (info->type != IRQT_PIRQ)
+			continue;
+
+		if (info->irq == irq)
+			return info->u.pirq.gsi;
+	}
+
+	return -1;
+}
+EXPORT_SYMBOL_GPL(xen_gsi_from_irq);
+
+int xen_pvh_add_gsi_irq_map(unsigned gsi, unsigned irq)
+{
+	int tmp_irq;
+	struct irq_info *info;
+
+	tmp_irq = xen_irq_from_gsi(gsi);
+	if (tmp_irq != -1)
+		return -EEXIST;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (info == NULL)
+		panic("Unable to allocate metadata for GSI%d\n", gsi);
+
+	info->type = IRQT_PIRQ;
+	info->irq = irq;
+	info->u.pirq.gsi = gsi;
+	list_add_tail(&info->list, &xen_irq_list_head);
+
+	return 0;
+}
+
 static void __unbind_from_irq(struct irq_info *info, unsigned int irq)
 {
 	evtchn_port_t evtchn;
@@ -2295,6 +2332,8 @@ void __init xen_init_IRQ(void)
 	xen_init_setup_upcall_vector();
 	xen_alloc_callback_vector();
 
+	if (xen_pvh_domain())
+		pci_xen_pvh_init();
 
 	if (xen_hvm_domain()) {
 		native_init_IRQ();
diff --git a/drivers/xen/privcmd.c b/drivers/xen/privcmd.c
index 67dfa4778864..11feed529e1d 100644
--- a/drivers/xen/privcmd.c
+++ b/drivers/xen/privcmd.c
@@ -842,6 +842,21 @@ static long privcmd_ioctl_mmap_resource(struct file *file,
 	return rc;
 }
 
+static long privcmd_ioctl_gsi_from_irq(struct file *file, void __user *udata)
+{
+	struct privcmd_gsi_from_irq kdata;
+
+	if (copy_from_user(&kdata, udata, sizeof(kdata)))
+		return -EFAULT;
+
+	kdata.gsi = xen_gsi_from_irq(kdata.irq);
+
+	if (copy_to_user(udata, &kdata, sizeof(kdata)))
+		return -EFAULT;
+
+	return 0;
+}
+
 #ifdef CONFIG_XEN_PRIVCMD_EVENTFD
 /* Irqfd support */
 static struct workqueue_struct *irqfd_cleanup_wq;
@@ -1529,6 +1544,10 @@ static long privcmd_ioctl(struct file *file,
 		ret = privcmd_ioctl_ioeventfd(file, udata);
 		break;
 
+	case IOCTL_PRIVCMD_GSI_FROM_IRQ:
+		ret = privcmd_ioctl_gsi_from_irq(file, udata);
+		break;
+
 	default:
 		break;
 	}
diff --git a/include/uapi/xen/privcmd.h b/include/uapi/xen/privcmd.h
index 8b8c5d1420fe..61f0ffbec077 100644
--- a/include/uapi/xen/privcmd.h
+++ b/include/uapi/xen/privcmd.h
@@ -126,6 +126,11 @@ struct privcmd_ioeventfd {
 	__u8 pad[2];
 };
 
+struct privcmd_gsi_from_irq {
+	__u32 irq;
+	__u32 gsi;
+};
+
 /*
  * @cmd: IOCTL_PRIVCMD_HYPERCALL
  * @arg: &privcmd_hypercall_t
@@ -157,5 +162,7 @@ struct privcmd_ioeventfd {
 	_IOW('P', 8, struct privcmd_irqfd)
 #define IOCTL_PRIVCMD_IOEVENTFD					\
 	_IOW('P', 9, struct privcmd_ioeventfd)
+#define IOCTL_PRIVCMD_GSI_FROM_IRQ				\
+	_IOC(_IOC_NONE, 'P', 10, sizeof(struct privcmd_gsi_from_irq))
 
 #endif /* __LINUX_PUBLIC_PRIVCMD_H__ */
diff --git a/include/xen/events.h b/include/xen/events.h
index 3b07409f8032..411298ae7fb0 100644
--- a/include/xen/events.h
+++ b/include/xen/events.h
@@ -127,6 +127,11 @@ int xen_pirq_from_irq(unsigned irq);
 /* Return the irq allocated to the gsi */
 int xen_irq_from_gsi(unsigned gsi);
 
+/* Return the gsi from irq */
+int xen_gsi_from_irq(unsigned irq);
+
+int xen_pvh_add_gsi_irq_map(unsigned gsi, unsigned irq);
+
 /* Determine whether to ignore this IRQ if it is passed to a guest. */
 int xen_test_irq_shared(int irq);
 
-- 
2.34.1


