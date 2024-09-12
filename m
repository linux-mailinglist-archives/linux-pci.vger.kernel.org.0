Return-Path: <linux-pci+bounces-13073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB41976569
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:24:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA041C221D6
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 09:24:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A526192B97;
	Thu, 12 Sep 2024 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YMwWoUYU"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 393F818A6A9;
	Thu, 12 Sep 2024 09:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726133068; cv=fail; b=LurMhhUFZpWLGdwDNelguhb8LavS4zJLw8stOQOJRMFIOJScUuYTnzH3i99A68S51ak2eUiDieoQqbc1gPiypByDg1IalzmLKbxMXlTC9/+Ku1gtHCjX2qX07FpGnRP68+vc663U2VTvBWdLq35zG3zG8SBLiKH7D6QzRKkVjxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726133068; c=relaxed/simple;
	bh=XBSeKc8PXZdxAQcm5q9o8UZQRY21vQtxs96BAc4YwEA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bq4wYDaWSyhr3JfigLGNNyT2kSTUwTWJooBSWyumk/vMBrB5C8hoaBXu2oVdUTJvxwWDqCftF3BbhRFoL8xS8MnW0oaCwAVpL8knP6A7YeMzCPfZPAVyLAFscfT8P/TfNZ1YT5K59TfGzPD3RtdaTcdfZayl65Z29yc6fgsQK8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YMwWoUYU; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H1TstHCQXQE4XOa5FudRa+a70aMZH+UcfyzHdaOO99yIfvK7p0GbVraEXLHyvbIRGGv/E46Eyd6w1G4YDHKItAy4vmZB0Fuhnuoj/kpdbxHY0fXrDg+cmZD6TZC1NOvbK0DzEMc1HmgjjAMFpF1Jeqa0NufnNoP58Hl6RSZz+5VbVbQpXiK6PcaAAAcwIkooq47RIB3A/NwBGpddiBJWCjDPxDQ3t3MFxe2UeO61Q35DjogDeYgHOOMhVybRIvBkguFb7i8gurOIVmngWeB6T7R1SLHtlHbkxK8ql91phTX3PvvrF3PqxtFMZYdCaoH89PC00h4CLH2wlJ5j8yf9dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HH6qo5day7pauzTzadMU40eFPaASgq+P43OYbiwWyck=;
 b=Uw0RzlHkfMMSgmp/6ChCXVw6k+Q/QMsheS9OUL9DE6+LwY9oaiDCUirS+lZtYykSe8z7pLYdX2wj5nLJ6bl8Z9f2oVT0BbneWlolFw3i6PMe2RXeQj7zkY5yWUYoFayGp8n/LxxtrUQgLc2vDKv4l40Tb2Ru8wrR84Ru2o6/sxg/xF31QaNTNZ3fZr4qL3dUiJ0VX7RM3jYQt2/2gx0AP6bwg4rZjMUJxZuUOi/3bfjWGmNjXQ8Rzwt/koi/E6XuEmSJHrzv7FZ0KcdeF1V+8rXq4H43Zer5UydKdfHvmjC4XqbNs0j8YpcOM02kZXh7EutpUZ9BoGwpH1MMUP8DBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HH6qo5day7pauzTzadMU40eFPaASgq+P43OYbiwWyck=;
 b=YMwWoUYUmX/N8BVE7hchDGb7gmRiLszbR0JIsPBZf5qJskp0RhbcUUZ2ACPgdoA6qQrTAgQCm21DyI0ZpleWGqreZowyCO/kvRlb4LOInQme3LI+IWJF0i/084gBU1Ujmsey9rfJcFpMaiTSCCaWqxnlKy+fIaZy1OPAhgBExZo=
Received: from BYAPR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:e0::37)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.18; Thu, 12 Sep
 2024 09:24:20 +0000
Received: from CO1PEPF000044F0.namprd05.prod.outlook.com
 (2603:10b6:a03:e0:cafe::4e) by BYAPR05CA0096.outlook.office365.com
 (2603:10b6:a03:e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Thu, 12 Sep 2024 09:24:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F0.mail.protection.outlook.com (10.167.241.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Thu, 12 Sep 2024 09:24:19 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 12 Sep
 2024 04:24:16 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>
Subject: [KERNEL PATCH v9 0/3] Support device passthrough when dom0 is PVH on Xen
Date: Thu, 12 Sep 2024 17:23:48 +0800
Message-ID: <20240912092352.1602724-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F0:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 4963cc14-ac3a-494e-6c2c-08dcd30cae58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qyb1ZafBwg4ousBh/KbA3op7NlYdQIG54CQiTqAreO5OWWZKCK4BkqBdv5VS?=
 =?us-ascii?Q?r7opxOwTW8aPZcSAIYXGLe/GjnSh407+YuWWa02FmsUXeGpVMy8VPpyJenwI?=
 =?us-ascii?Q?pUFY3T0Q7rGLZ1eCagezsMKGgLmkpQqwy68AjPetMMdSrpNXDz3CRDWIDQH7?=
 =?us-ascii?Q?EiV+VLT54uOvum6TYATRSlse108jsrGisleP4UNNAIglPUenZaW2CdBmFzdV?=
 =?us-ascii?Q?vKkJuVCh0KQBdZG2vkXG1DfeIid/FdF79q/rUkcawtJMUDBvVPEPcKF7B6Kz?=
 =?us-ascii?Q?BKsZkXy2bZrYnJIjjylKQCBmsPVcbMJGfE8mBxyLjqlcG2rW+yjxpD+Pr4rq?=
 =?us-ascii?Q?IrHcyVqhdS7sv+BMD53yeYWAfeqau3zY8FWFnDO6UoTM1LBnYfataFIt6LNw?=
 =?us-ascii?Q?ji5PC2BC0anf+/vF63YGwdwCWRwoZ7fNXYTbZND0qgQcrGX3+gUxBTCiLUml?=
 =?us-ascii?Q?PRsOzpKmvoeUqSVwec4IliwOvXfZ2FAPu++dzQyBeq9+W46oMAgAXnYKpJ+J?=
 =?us-ascii?Q?Bmf+ATBulE+zy//Sl0lEwePAQDfirUYkp6R15bZ7KkSoaclPqdjoNrEZ7dkr?=
 =?us-ascii?Q?uMR3IYNpw3YH4bgTx119aycUHUgg1gDOSU2XFGPEicUkoaX6FB/BvVQWuoHZ?=
 =?us-ascii?Q?3uP8eZhthB8aDl3m0ezHVQCluJr/9g8RPVb44nf6i5GcGXBTwzZSPLr3wH2L?=
 =?us-ascii?Q?zDVB8U1eq4bSIudo3CK3TplalSHPLobu6GwTkrSNDae4krlc+x2HZEkdETwY?=
 =?us-ascii?Q?ihM1sqCV5MxIm77TRv+XeqAdejJeF9gcmitu+CcELLC6cvLKkL2YCBkYLvg5?=
 =?us-ascii?Q?uOoHhb4e4rt7bz1Aj8JfFbYH9RnpQyES+L706Pmj8eNQKjxYSCsZ2o71nNum?=
 =?us-ascii?Q?WBLq2YJIhkL6BLuELgkt/8oqYbPdVXEbIuiDCipnIS7ydCPVptXLH3aY/R/n?=
 =?us-ascii?Q?14rW24iz1tfqQ8+8cgFONecKXE2GRtLeqhCoAINE7bjRoqSFd5BfdAjWGFeN?=
 =?us-ascii?Q?bp9e9ajGFGU3FvkYaq5WNzHPbz1pKqEX69DISMAZKnNYxcPQN6aF7DyoLGvL?=
 =?us-ascii?Q?t5X+oy/zoadsGA3xaTmLTAJQqkYdvdAdfVnCY1DuzbqR/Gxmgn18074jxT+I?=
 =?us-ascii?Q?3ovGE3WLYYGTjg2bPs/TroVGwam8mKwvVTE2Wb2ZeGmOLZF473tZ3V9O4osr?=
 =?us-ascii?Q?U7Kv1xn4K6J/bspnTs00DJNevzdVWsXOdmqPgbwafUhMHImTuDDtuLgBXQHg?=
 =?us-ascii?Q?dJxJT2c6pLCAzOs2SSc7/rXybec1uiDZerodOWAi/RoNP6NreJpkV38Mj4qI?=
 =?us-ascii?Q?xAziUP7vOkB0C00B2ARfmBLJOgsjvtMHg/wTVLPauZRwQlbuEcZjNRSr4Yfk?=
 =?us-ascii?Q?i5sV5IXRVyIX4bbxEX8dYEbAYNQGNWVLht+DyM8mB+PReDGXAPBgkZ9CvB35?=
 =?us-ascii?Q?t3w5cFteT5eC96cs/YPIP9SNr1T0deNOggvAdICaTbjFzBRPXt9iYg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 09:24:19.5366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4963cc14-ac3a-494e-6c2c-08dcd30cae58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239

Hi All,
This is v9 series to support passthrough on Xen when dom0 is PVH.
Due to the dependency codes on Xen side have been merged, so I continue to upstream this series.
Although all patches of v8 have got "Reviewed-by", too much time has passed and there are some changes
in the code, so I didn't add "Reviewed-by". Please review them again.

v8->v9 changes:
* patch#1: Due to the struct and name of the hypercall changed on Xen side, I did the corresponding
           changes. But no function changes actually.
* patch#2: Moved the calling of xen_acpi_get_gsi_info under check "if (xen_initial_domain() && xen_pvh_domain())"
           to prevent it is called in PV dom0.
* patch#3: Changed the syscall name from "IOCTL_PRIVCMD_GSI_FROM_DEV" to "IOCTL_PRIVCMD_PCIDEV_GET_GSI".
           Also changed the other functions name.
           Changed the macro wrapping "pcistub_get_gsi_from_sbdf" from "CONFIG_XEN_ACPI" to "CONFIG_XEN_PCIDEV_BACKEND"
           to fix compile errors reported by CI robot.
           Changed the parameter gsi of struct privcmd_pcidev_get_gsi from int to u32.


Best regards,
Jiqian Chen



v7->v8 change:
* patch#1: This is the patch#1 of v6, because it is reverted from the staging branch due to the
           API changes on Xen side.
           Add pci_device_state_reset_type_t to distinguish the reset types.
* patch#2: is the patch#1 of v7. Use CONFIG_XEN_ACPI instead of CONFIG_ACPI to wrap codes.
* patch#3: is the patch#2 of v7. In function privcmd_ioctl_gsi_from_dev, return -EINVAL when not
           confige CONFIG_XEN_ACPI.
           Used PCI_BUS_NUM PCI_SLOT PCI_FUNC instead of open coding.


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
  xen/pci: Add a function to reset device for xen
  xen/pvh: Setup gsi for passthrough device
  xen/privcmd: Add new syscall to get gsi from dev

 arch/x86/xen/enlighten_pvh.c       | 23 +++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/acpi.c                 | 50 ++++++++++++++++++++
 drivers/xen/pci.c                  | 13 +++++
 drivers/xen/privcmd.c              | 30 ++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 76 +++++++++++++++++++++++++++---
 include/linux/acpi.h               |  1 +
 include/uapi/xen/privcmd.h         |  7 +++
 include/xen/acpi.h                 | 27 +++++++++++
 include/xen/interface/physdev.h    | 17 +++++++
 include/xen/pci.h                  |  6 +++
 11 files changed, 245 insertions(+), 7 deletions(-)

-- 
2.34.1


