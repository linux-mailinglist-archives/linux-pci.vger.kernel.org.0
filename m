Return-Path: <linux-pci+bounces-8429-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD148FFD7F
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 09:51:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEBD61F233A9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 07:51:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA8315A872;
	Fri,  7 Jun 2024 07:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ETVl+EvC"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2081.outbound.protection.outlook.com [40.107.236.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B145715A86E;
	Fri,  7 Jun 2024 07:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717746692; cv=fail; b=IWDQNgyPW7FmC3kY57D2cLbfpArjadYWumxZcuAdakH5E3Z3xBhLT1QJ3of81tS54LfNiwkyIhVJesBD76AvXoTwC3mXJFGB/5A1I7XwN+9rbvSgl8V6m9P7XBbjCwqJvyL+9XgOERw83OcSjuNuu7Xf1GOBuJ2jTIXZKWuEncQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717746692; c=relaxed/simple;
	bh=9535yUrCJ/2F9Dw7R7wyym8KIFyh042E1U9r212USY4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TpVXYj6s+cOGPwfVgPoDbuh+0Ds+8O/kCE4qJlg3AaxPSh1eknadFyHxj7Ca8dfyzRejQiA616dIgw48HQl4KymySzNiUOPTDYUuJJQoJZ9vKVk9/wcWpqxtlLsZdIbc/OzsNV3XwR9rdV1eGrkpBA5ZqWG2PpNVv6ouu2vJOmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ETVl+EvC; arc=fail smtp.client-ip=40.107.236.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MMX4/znEupsgzpoFMvMV/WPDPPQ2UBL/cFEjzdhWkcQgDnodewZpgAMW7MwKFi4mVi6gngIRXT2w65wHM+Y6991C3HZf6yLwUAwOBllp3WAmPAcHpKKIrBBUpk80KG0+qvpYjYtCGQqxwPiLnlfO8sKpNpXVQSbZsGpo2Coc8kszFWUrpfIJCB/2NMOz2oqERuX+/LiOGgQXgaeQ+dat1X4JpoeeBquaccQGp2OySIlbE3Ti39P9lkZBzc9GS6IV/DObff/kVl5syNsmbPrwxhKZy5nJ6kE5OHDQcBUdkwGHWlUhgVPUMl880sn5LuLPDHx8NfDhs7RwswVkF7ITgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P0rNKlh4YHIIL4TR9dCsbVJChfs3QK+5ViLp0qK0wcg=;
 b=ODdt8svolw8jb5WBoXe/Re5p7BfK6hdvSNhQ6ARJFbj/I9y/OE5Stci9WtHlvDG5pWH979p4WE0p90YSPru7oy+nMNJ2pt302CMElJR5kRDFJmKitYDCDzdj7BnBJ3igfXh5/nbbiRLUjtrXg4XVS0avD4PrfuOuonnA7ePiyk5SD3XO5clXyU4dnL7Psg1gKGloKtz/4SsK7P7OUzvzCAzNL726uvC3cUJFChTHwnaJNWzNeWlY4wUUr6hObR4hG5OSstyq+Fe1JQIZzjBKPvmV3NDKl9yYR7lC4zQyhLvtyjrENSOfCFL86Zv2Xfa6OW7yYCrVgSO9ct1F7m37Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P0rNKlh4YHIIL4TR9dCsbVJChfs3QK+5ViLp0qK0wcg=;
 b=ETVl+EvCzNjfMzQj7tvapRQ5dhS98bL/5SZyeixjbRfDTmK03/XjFUQK1oWUFV1XwIlIc1QvpNhEo+WiiIKr53EI2lQFDUR7KMyLVDeN9PQIInCnOee8RK5h/9Q+NGTVj7I6dzrILBl6BYgKhM41xAKyBfJ8yfs85cZ87M9FhRA=
Received: from BN1PR13CA0023.namprd13.prod.outlook.com (2603:10b6:408:e2::28)
 by SA3PR12MB7860.namprd12.prod.outlook.com (2603:10b6:806:307::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Fri, 7 Jun
 2024 07:51:27 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:408:e2:cafe::41) by BN1PR13CA0023.outlook.office365.com
 (2603:10b6:408:e2::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.13 via Frontend
 Transport; Fri, 7 Jun 2024 07:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.0 via Frontend Transport; Fri, 7 Jun 2024 07:51:26 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 7 Jun
 2024 02:51:23 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC KERNEL PATCH v8 0/2] Support device passthrough when dom0 is PVH on Xen
Date: Fri, 7 Jun 2024 15:51:06 +0800
Message-ID: <20240607075109.126277-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|SA3PR12MB7860:EE_
X-MS-Office365-Filtering-Correlation-Id: 79878ae9-8039-442d-e60f-08dc86c6a289
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8TvU9vdS00BOx6p+248e3Htxc6+U902JaIcSj8sjITpBSuRtoykDkGympfnI?=
 =?us-ascii?Q?z0Het+eipdV1h8LBKXI9b8DQFnKncZmTnmfv2GcceDP5ij/z+GF2UaWzk+s+?=
 =?us-ascii?Q?iIVTygvekYcCuRSSUppszxPX9MJm7kNiC3sa8ZDw9ZZVDhJ1OPCLa9XYV0Dy?=
 =?us-ascii?Q?V0rSFJvLddl0xaX0kodKE2ysPZYSYNkchYFbjZfl5eeBfyjmAwFljNka32mg?=
 =?us-ascii?Q?RcBHtVxpvu32UNGkDbnOgCp9y0l9QocIElbhkCeowCNKb3P3ZbCeXeqNGp4j?=
 =?us-ascii?Q?vElMXDnVo5vF33B0uvtu5cn/e8zWHKn7RNBHnjZzY6yB76EPofNFYWMPNJ+F?=
 =?us-ascii?Q?32NF/dx4NI2LeoexDaFl8YPZwtcDOZmF8CpEJlSO2hLs/mmVOcC6UZO6JGFT?=
 =?us-ascii?Q?iKrlsxm0H0TkyYf6IVtP52wwGRVjva63wJk77zHENpXc9dasFa9kw3E7fRN0?=
 =?us-ascii?Q?AFtddfa/jlf4e0m+9tTysGt56oS8Rgt0KYKKoBuzYCuUeoHKk2PAv1zyyF5L?=
 =?us-ascii?Q?DlZduqlFUCECSfs5vWq5Gq0LLVC5+iDSsADUS5EBvAd/Wrm+hRetNjc55qYW?=
 =?us-ascii?Q?+efKKcau1e/iBKwGDeN/9VSTIpAGz2dtAQC+CsNh1y/O+Qqup6DfdRewLnC8?=
 =?us-ascii?Q?tDviS4nkx2p4GUPQtXZT4VuGi35OfhRM79XvWC/rZZMLs/oRZ4JMND/Q8joQ?=
 =?us-ascii?Q?ZTRxAuQ51eXLD9kvy8NUNHbCA9NHBRlH6KsMaunYdu5yLedJY2hS1Wt+vdkA?=
 =?us-ascii?Q?DeuURXVehJrMt9Xn0JmOYbGZsA7iPn79m3uTP3BTObS/ChrOPLMaALllvimr?=
 =?us-ascii?Q?d1q987htENKt2f4x3jf4+vHLUnj2FeIiFhUqqvCJlh4Uzft1B39J+65lOtGK?=
 =?us-ascii?Q?CpgmL4aYazzGDb0CYwyAw3Fu59/t7mL+NP+DCj6Ysq817pplDHhWI6LAAV2e?=
 =?us-ascii?Q?lzFFFpZSAjhyRlK3B4iWalQYEocgiRUAnAAuL4Pa4xI7nkii+JYhVNUhqMBa?=
 =?us-ascii?Q?KzKaRKef2rHa9bQdqqs2mhts2KtS9H4xBb0JNK6BsKGvyj8gYf74vC19CJ87?=
 =?us-ascii?Q?2vn+hdAfkQjyYcAcIBky9StbobyHBEb7RBoSVM+STBlOZR1bRJNW4/pLr+Ls?=
 =?us-ascii?Q?8ATb/Zn/TcUKEqHmAM2hskXTUKtPnQ3uGXbNbeFyx717NIZ/tOFYCdHQaD+E?=
 =?us-ascii?Q?n85VQ4Lrna0oqWB8kKx/Pq+5Sk5UxEKFrH4y4MU8y7gah3m7oOojrl2ZISvL?=
 =?us-ascii?Q?JClbPFa7vEs5NjaKTJFMuPZ6NCxig6NLl1IgfV0KeMnPrFdSXrF63M9zw+p0?=
 =?us-ascii?Q?brXzCbPk78pn5rc8p+BkV6g6SuwTpKE+8LwJBxUchkuz/qA4K6Cqq0SDt+KI?=
 =?us-ascii?Q?5rPKVs5J1K5cCTVkntQB8bU5TOyrBxbSO45iy0zuoVMZNXDprUU6NmGz/VMz?=
 =?us-ascii?Q?WyaGZWo66aI=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2024 07:51:26.7579
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79878ae9-8039-442d-e60f-08dc86c6a289
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7860

Hi All,
This is v8 series to support passthrough on Xen when dom0 is PVH.
v7->v8 change:
* patch#1: This is the patch#1 of v6, because it is reverted from the staging branch due to the API changes on Xen side.
           Add pci_device_state_reset_type_t to distinguish the reset types.
* patch#2: is the patch#1 of v7. Use CONFIG_XEN_ACPI instead of CONFIG_ACPI to wrap codes.
* patch#3: is the patch#2 of v7. In function privcmd_ioctl_gsi_from_dev, return -EINVAL when not confige CONFIG_XEN_ACPI.
           use PCI_BUS_NUM PCI_SLOT PCI_FUNC instead of open coding.


Best regards,
Jiqian Chen



v6->v7 change:
* the first patch of v6 was already merged into branch linux_next.
* patch#1: is the patch#2 of v6. move the implementation of function xen_acpi_get_gsi_info to
           file drivers/xen/acpi.c, that modification is more convenient for the subsequent
           patch to obtain gsi.
* patch#2: is the patch#3 of v6. add a new parameter "gsi" to struct pcistub_device and set
           gsi when pcistub initialize device. Then when userspace wants to get gsi by passing
           sbdf, we can return that gsi.


v5->v6 change:
* patch#3: change to add a new syscall to translate irq to gsi, instead adding a new gsi sysfs.


v4->v5 changes:
* patch#1: Add Reviewed-by Stefano
* patch#2: Add Reviewed-by Stefano
* patch#3: No changes


v3->v4 changes:
* patch#1: change the comment of PHYSDEVOP_pci_device_state_reset; use a new function
           pcistub_reset_device_state to wrap __pci_reset_function_locked and xen_reset_device_state,
           and call pcistub_reset_device_state in pci_stub.c
* patch#2: remove map_pirq from xen_pvh_passthrough_gsi


v2->v3 changes:
* patch#1: add condition to limit do xen_reset_device_state for no-pv domain in pcistub_init_device.
* patch#2: Abandoning previous implementations that call unmask_irq. To setup gsi and map pirq for
           passthrough device in pcistub_init_device.
* patch#3: Abandoning previous implementations that adds new syscall to get gsi from irq. To add a new
           sysfs for gsi, then userspace can get gsi number from sysfs.


Below is the description of v2 cover letter:
This series of patches are the v2 of the implementation of passthrough when dom0 is PVH on Xen.
We sent the v1 to upstream before, but the v1 had so many problems and we got lots of suggestions.
I will introduce all issues that these patches try to fix and the differences between v1 and v2.

Issues we encountered:
1. pci_stub failed to write bar for a passthrough device.
Problem: when we run \u201csudo xl pci-assignable-add <sbdf>\u201d to assign a device, pci_stub will
call \u201cpcistub_init_device() -> pci_restore_state() -> pci_restore_config_space() ->
pci_restore_config_space_range() -> pci_restore_config_dword() -> pci_write_config_dword(), the pci
config write will trigger an io interrupt to bar_write() in the xen, but the bar->enabled was set before,
the write is not allowed now, and then when bar->Qemu config the passthrough device in xen_pt_realize(),
it gets invalid bar values.

Reason: the reason is that we don't tell vPCI that the device has been reset, so the current cached state
in pdev->vpci is all out of date and is different from the real device state.

Solution: to solve this problem, the first patch of kernel(xen/pci: Add xen_reset_device_state
function) and the fist patch of xen(xen/vpci: Clear all vpci status of device) add a new hypercall to
reset the state stored in vPCI when the state of real device has changed.
Thank Roger for the suggestion of this v2, and it is different from v1
(https://lore.kernel.org/xen-devel/20230312075455.450187-3-ray.huang@amd.com/), v1 simply allow domU to
write pci bar, it does not comply with the design principles of vPCI.

2. failed to do PHYSDEVOP_map_pirq when dom0 is PVH
Problem: HVM domU will do PHYSDEVOP_map_pirq for a passthrough device by using gsi. See
xen_pt_realize->xc_physdev_map_pirq and pci_add_dm_done->xc_physdev_map_pirq. Then xc_physdev_map_pirq
will call into Xen, but in hvm_physdev_op(), PHYSDEVOP_map_pirq is not allowed.

Reason: In hvm_physdev_op(), the variable "currd" is PVH dom0 and PVH has no X86_EMU_USE_PIRQ flag, it
will fail at has_pirq check.

Solution: I think we may need to allow PHYSDEVOP_map_pirq when "currd" is dom0 (at present dom0 is PVH).
The second patch of xen(x86/pvh: Open PHYSDEVOP_map_pirq for PVH dom0) allow PVH dom0 do
PHYSDEVOP_map_pirq. This v2 patch is better than v1, v1 simply remove the has_pirq check
(xen https://lore.kernel.org/xen-devel/20230312075455.450187-4-ray.huang@amd.com/).

3. the gsi of a passthrough device doesn't be unmasked
 3.1 failed to check the permission of pirq
 3.2 the gsi of passthrough device was not registered in PVH dom0

Problem:
3.1 callback function pci_add_dm_done() will be called when qemu config a passthrough device for domU.
This function will call xc_domain_irq_permission()-> pirq_access_permitted() to check if the gsi has
corresponding mappings in dom0. But it didn\u2019t, so failed. See
XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH dom0 and it return irq is 0.
3.2 it's possible for a gsi (iow: vIO-APIC pin) to never get registered on PVH dom0, because the
devices of PVH are using MSI(-X) interrupts. However, the IO-APIC pin must be configured for it to be
able to be mapped into a domU.

Reason: After searching codes, I find "map_pirq" and "register_gsi" will be done in function
vioapic_write_redirent->vioapic_hwdom_map_gsi when the gsi(aka ioapic's pin) is unmasked in PVH dom0.
So the two problems can be concluded to that the gsi of a passthrough device doesn't be unmasked.

Solution: to solve these problems, the second patch of kernel(xen/pvh: Unmask irq for passthrough device
in PVH dom0) call the unmask_irq() when we assign a device to be passthrough. So that passthrough devices
can have the mapping of gsi on PVH dom0 and gsi can be registered. This v2 patch is different from the
v1( kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/,
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/ and
xen https://lore.kernel.org/xen-devel/20230312075455.450187-5-ray.huang@amd.com/),
v1 performed "map_pirq" and "register_gsi" on all pci devices on PVH dom0, which is unnecessary and may
cause multiple registration.

4. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device\u2019s gsi to pirq in function
xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq, but qemu pass
irq to it and treat irq as gsi, it is got from file /sys/bus/pci/devices/xxxx:xx:xx.x/irq in function
xen_host_pci_device_get(). But actually the gsi number is not equal with irq. On PVH dom0, when it
allocates irq for a gsi in function acpi_register_gsi_ioapic(), allocation is dynamic, and follow the
principle of applying first, distributing first. And if you debug the kernel codes(see
function __irq_alloc_descs), you will find the irq number is allocated from small to large by order, but
the applying gsi number is not, gsi 38 may come before gsi 28, that causes gsi 38 get a smaller irq number
than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want to use gsi, we
can do a translation. The third patch of kernel(xen/privcmd: Add new syscall to get gsi from irq) records
all the relations in acpi_register_gsi_xen_pvh() when dom0 initialize pci devices, and provide a syscall
for userspace to get the gsi from irq. The third patch of xen(tools: Add new function to get gsi from irq)
add a new function xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success. This v2 patch
is the same as v1( kernel https://lore.kernel.org/xen-devel/20230312120157.452859-6-ray.huang@amd.com/ and
xen https://lore.kernel.org/xen-devel/20230312075455.450187-6-ray.huang@amd.com/)

About the v2 patch of qemu, just change an included head file, other are similar to the v1 (
qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.

Jiqian Chen (3):
  xen/pci: Add xen_reset_device_function_state
  xen/pvh: Setup gsi for passthrough device
  xen/privcmd: Add new syscall to get gsi from dev

 arch/x86/xen/enlighten_pvh.c       | 23 +++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/acpi.c                 | 50 +++++++++++++++++++
 drivers/xen/pci.c                  | 25 ++++++++++
 drivers/xen/privcmd.c              | 28 +++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 77 +++++++++++++++++++++++++++---
 include/linux/acpi.h               |  1 +
 include/uapi/xen/privcmd.h         |  7 +++
 include/xen/acpi.h                 | 19 ++++++++
 include/xen/interface/physdev.h    |  7 +++
 include/xen/pci.h                  |  6 +++
 11 files changed, 238 insertions(+), 7 deletions(-)

-- 
2.34.1


