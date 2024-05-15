Return-Path: <linux-pci+bounces-7474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7779C8C60FE
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 08:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F9AB281AC9
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 06:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8240862;
	Wed, 15 May 2024 06:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="c0h5DGPd"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E0982A1B8;
	Wed, 15 May 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755834; cv=fail; b=dlgD/aHHvKgBguyiPb75qvHbSNk/LvJ2t3GKm5uNgepwgJKLO0UYx9IawO0i/OI6Yi8RbpPJEKgAXQPv2RKodDfn4rnb7yuKF+2Xl3NhjnMqMALahY7O2JVzWGA6KrAQU/3J8G8R1IV1IshX0MmM/4SkrYxntnPwxl/J8ECVm68=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755834; c=relaxed/simple;
	bh=7WkIS6ZyeP4LQbmDM8+o45w8gF3uMPng7FGF9Xmv8Nc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=O1x71dKxgwMkl8vDAIfYCCuWZNmhHxmVQ/KufZb6+PY7Glv5brCQG1nf3vSId8rEIUo2VTK+KHITbNZCV1PL4Bqi/OS5Xi6rnFObGNaZdsUyUKe9nPtbTNLgW6Xp1sDhiifcXJsm0lvabTMiYAhKDHTWy1Dy9bp4CIT4/VZeVtk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=c0h5DGPd; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fgychTMBqg3dLP9Rpi7XD6+K1Xuryn7R5YsfNG+XGJdLhT3U3bDhh1Axe80XC8jZYhqzjSMj67GsV+2mQkXCwqriJnq0OKCaoRpCdIOwViV0FIUGXfvohxgrMq7XbLk3rnP3dgUcAH9d9UhrQ0n0F65YdFLgfPl8HeamAr3wROfcY643hXRo7yV8lNbCP7bQHqIqbbDyjuZ1n74uyTx1HCidaSgwSZrWfZXtyk0vVwlxRJT/KPjM5GIsLoOCQ37vKpekwF75u4lTWpAPHdO6j73sarkn8w+4B01jBYTo33jYnElEM75CMZS87EMKCJ4SAC/z7jGikL7pP8zA7vkK6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8u1a9zv+ID5+qnxPmAar9kgCl4ZyYytPz2Gob4RuFsw=;
 b=YKD23F813a+pkS5YMnFTdKc525Uf09a+3+8vjuGhaAgXUGjfg+FZ9f//CiRd1qWyHxHNMcyhmxi6ORlSZFeg9X5dKA1zFnHJMTe5VvvqUlsJJfhcpbxY2fH/Jf1MrW4sJOv28ecl+A/KAZrnt5WxEbZPa1zMHBEaf1khbzjyww9hNMy5axfsKkDvTKm5sMttyHIce6FMluozjZmnyDSBdQLBscfXyDQGYZlo9mlieN4vXWatfLuOBK55tRLGd3WfnVO5ZAasa0jLbXo/Q7fQtv7u+uEX8RLZ8emHCnt0xV1aBL6NJlyHoJVsXwo7ljzvEUv8UDmXyZjITB0fe93eSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8u1a9zv+ID5+qnxPmAar9kgCl4ZyYytPz2Gob4RuFsw=;
 b=c0h5DGPdF0mmlJH5qViVeZejRPqb5imY18Hcjjjic8Avcb9BgTY1XAffeqwe4LshooDkZKQ5OmXrN8jjgJvhx6Lf+6/qxRoQdbWTs3WzgBnfrmmQcn6TbCrEr27e+3wjTNDETH9jq26glv8pBsnFFBf/FUIrSKx5CNe2fDlXUCA=
Received: from MW4PR04CA0047.namprd04.prod.outlook.com (2603:10b6:303:6a::22)
 by BY5PR12MB4050.namprd12.prod.outlook.com (2603:10b6:a03:207::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Wed, 15 May
 2024 06:50:29 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:303:6a:cafe::1a) by MW4PR04CA0047.outlook.office365.com
 (2603:10b6:303:6a::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27 via Frontend
 Transport; Wed, 15 May 2024 06:50:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Wed, 15 May 2024 06:50:29 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 15 May
 2024 01:50:25 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC KERNEL PATCH v7 0/2] Support device passthrough when dom0 is PVH on Xen
Date: Wed, 15 May 2024 14:50:09 +0800
Message-ID: <20240515065011.13797-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|BY5PR12MB4050:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f0f5bb-3de9-4562-742a-08dc74ab4ee7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/V96+cHaacDH9fm2Z+RMeiJZ6HoOjD/MHrZ/dvlYik934EJ+vEY1wsZeBDi6?=
 =?us-ascii?Q?+ShzFp91Ya7vDc9Uuo3GqxYdlpGPhRe8i1JdAfYA6Bt1yx/wDqe2RKNbutkA?=
 =?us-ascii?Q?0Drc4Vqr9eQYo62tW2oBBEIMupD6ce9ImzUeJEMAeMBnl5EXo67Rynyj4xtg?=
 =?us-ascii?Q?r5OyRUmAPMPZHOSkIiytySSlpG7s6/40OkcHS3S2hoxBDcTICo70vvXS/OGk?=
 =?us-ascii?Q?Y2aU2TdKxdRvf52OLIawKPGrmxCkpNKXRDCEgkkhwb0Nd8r679nUAfFp+B16?=
 =?us-ascii?Q?UwOoW1nxESWTAI6tX3z94s1nnU8FAWGMMQFjYnbRFeoK/0u/du08YBCmS441?=
 =?us-ascii?Q?1nvSIh942eKb7p+uXRLn8216ZAsUwVl5HSh8fCQ5T7W018OWLP34J0QtjfF+?=
 =?us-ascii?Q?wA8c8A0fnhLm69Jjg7Wf+tYRmULYHyIPgdpkoQ/bgXMOX2PC7XC48ZIXH/Rz?=
 =?us-ascii?Q?jq/MlkyRLzbOKgBeFiVUn5a59EybrZaKKWG2gMvfB7aUWfi8joNHh0gnHhnN?=
 =?us-ascii?Q?L7PbW0ku0XEL4pvxdTQu8mvVgrnXteYVGHGWd8AS3QeRy6Qbj0KczRm1vwOq?=
 =?us-ascii?Q?yAXkJuVh/sNPnC3NocKehOX871dD1L01+gQXD6ozSRzquS+TlMS/8wxGV3Nj?=
 =?us-ascii?Q?qV/YBE9lF+q+N5B1AyyMaRtGt0ojPcjFncK/mgzMB8ccQmAExR7y6cczFu12?=
 =?us-ascii?Q?hhUTBGKZsWjlQMDNS5s5kke6r7t45bvrtiktEIDoiVFp0JH50igBPNUAZlGa?=
 =?us-ascii?Q?GUqzNXskQ6hSeO9ZV+PB0be8c1vl3hXOEGgZC6rMWbNoAKfOxsl2MG/WsqK/?=
 =?us-ascii?Q?ZKOSvBPv9YU4GI7nF/TydUQqPdl7sBI3ntFrGlqOAl6tV53ExBmWkddhlviQ?=
 =?us-ascii?Q?bTR5O+sQq3PjVlQl9G0m28rL0QMgMx5zFN/g8zQ7I3o/hdzs/WV79i7xVpEv?=
 =?us-ascii?Q?Qm9a+ba2NCqHHDo7gQqKVLvZpAJ30oHPbFGtKLT6uAXKZ8wsiMljCn3YPzM8?=
 =?us-ascii?Q?lGFBArqREDWbY5zsjdLv1KI9lmVRTNW0SDQU2rBJUcy76gcMmf0pI/FUTSkB?=
 =?us-ascii?Q?fyKkq4qUaTbGu2ANFdDM0oaaybigyExhc5RKCx+nFLrDKMPOoMvG+Kk//Cqn?=
 =?us-ascii?Q?iV4ml/NwyAVkPPWVKd33QDXXbUQP0lD3UA7G7age8SPJkiEvPmHtiIxBbX3h?=
 =?us-ascii?Q?CpTxBCEpAiv+Z4oSWt5ExDNTylPbUPp2FWrRsgSw8uAY4VB1dJJ/oITyys3r?=
 =?us-ascii?Q?29ytAUyLFiuo2fyaHCGh2ZdokBlEkJHhrlaHIFl4ctWEm4UhxVjR4B8TS0W7?=
 =?us-ascii?Q?lqRZM1e+hOPdY4Z6GuSscYU48t+zYQX0V3NQGgA0axK1/w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 May 2024 06:50:29.0382
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f0f5bb-3de9-4562-742a-08dc74ab4ee7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4050

Hi All,
This is v7 series to support passthrough on Xen when dom0 is PVH.
v6->v7 change:
* the first patch of v6 was already merged into branch linux_next.
* patch#1: is the patch#2 of v6. move the implementation of function xen_acpi_get_gsi_info to
           file drivers/xen/acpi.c, that modification is more convenient for the subsequent
           patch to obtain gsi.
* patch#2: is the patch#3 of v6. add a new parameter "gsi" to struct pcistub_device and set
           gsi when pcistub initialize device. Then when userspace wants to get gsi by passing
           sbdf, we can return that gsi.


Best regards,
Jiqian Chen




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

Jiqian Chen (2):
  xen/pvh: Setup gsi for passthrough device
  xen/privcmd: Add new syscall to get gsi from dev

 arch/x86/xen/enlighten_pvh.c       | 21 +++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/acpi.c                 | 50 +++++++++++++++++++++++++
 drivers/xen/privcmd.c              | 28 ++++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 59 ++++++++++++++++++++++++++++--
 include/linux/acpi.h               |  1 +
 include/uapi/xen/privcmd.h         |  7 ++++
 include/xen/acpi.h                 | 12 ++++++
 8 files changed, 176 insertions(+), 4 deletions(-)

-- 
2.34.1


