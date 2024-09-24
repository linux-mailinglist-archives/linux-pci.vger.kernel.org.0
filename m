Return-Path: <linux-pci+bounces-13411-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B94BD983CD6
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 08:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 46D0D282693
	for <lists+linux-pci@lfdr.de>; Tue, 24 Sep 2024 06:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F2387E574;
	Tue, 24 Sep 2024 06:15:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="e1/HJiRe"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2CC74418;
	Tue, 24 Sep 2024 06:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727158506; cv=fail; b=MRnzkuxZxFKcquMG1EZ0O59bCdqpHt9E+11Jbb4s7/95NiRIuZdWinVZWkvR9ib/lGMrGhJGagepKTVJyKoYWEFk95P2UpDhuRt7BnIMM1HxpsoxbTpukbvjt66isX1wO0D5N70cY5xLBeaHsQbq4mUT7oZCR+rVplzGAOiN8gs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727158506; c=relaxed/simple;
	bh=mZ4E7iwSyoZdE8j1KuFC2mYa6UqUiuUuOLp3FWmZoto=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HBxctgwASRdJwuN5E+4mB/XUu3zx2dxpN5UBChTeW7UpR4ylrJ6uXBPjvl9/FC3dyZA31ZkU2+Okm+Bp1APmH1g9RT0kVyNMYJHswj5lX9Vogmdd0PN6mT0F6H98U64OL2H0n7KMcq1pTDcafkVPP+FCpNE2flcTx4gkAvzqYDA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=e1/HJiRe; arc=fail smtp.client-ip=40.107.244.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rGVwHbaBdmqnckAlOWpo5yscyVPWAxdDXQERge646nUaMGZj5wTWVuDx4Xi0Rx7IXGgxQNGx2KD2/MkGxLSP9ua5rKcFC7YSuUhyr/kSaNE3QYlJVmjQCO8TNvY7RSQSvwHDf+p/ItPlMjw/ovjcrSNAJU8PujLMy+ID9beK6XK3H5mTf1atX1bC7rpTyobFWMvhxkV3FpWOtOrj3w0vSjMwVch6O4fqJ/d8+9KjnOJgBx6E9rL1s4eEtIPHr6BzUDjjYrfb4a72hw8U79Aoxh0fAO8KXN0DZwaiwd2adEZjXZAXxwH8SLMhBp7O38qla4OXZzLqGbofDuyIQpmIpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+P6yVMQhhmhdpElZWftDYs+hrztkKBINKK29tfnYhag=;
 b=wBWrJP6pdvD4dkorHw3+q/51sLnQDUjqGQyFSsZ9ZJpkrr9PzNxPJPt4NfISF8kL922HPlVbHv9ONhSH4nKjZTa+ANDIYPd5OYju0nctzvhbcGEFJOm/oZ9eK692DMG+GlcK9/joHsTUk0XqjW4Lx2GO2BU+eJtKNwu/2KCZQiKY+SF/ZEOlUuZTtlwFh6XwfPlKDw+U1N2FdVC2oRQBgPG+FMHsvoFcjy2V0+ladlml8AenBx0jWsdlqoK27fWMhv89UbyfOQa/hFyXD8GyyF0/4ZTfQIGjoE58TAe8QZZV5XTt334Jj14ZZXYNaqDBVr5DuIWtXNzmeGRP00qgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+P6yVMQhhmhdpElZWftDYs+hrztkKBINKK29tfnYhag=;
 b=e1/HJiRewK4Pxw7oJiC617iLTECuqIxBtAFfYki022fM86H43ZNCfwlxS9zXKVb09bVwQ+WdfR1C/m1bFC2DAJgtl4QkgSyMyPYjP4Qd6xX4al7+apiZ1FOfDVmku1JOqXKW3P802HoAZ5JDF3PaCD0KaYe3+f0frS6urtXxYgk=
Received: from SJ0PR13CA0069.namprd13.prod.outlook.com (2603:10b6:a03:2c4::14)
 by SJ2PR12MB7868.namprd12.prod.outlook.com (2603:10b6:a03:4cd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Tue, 24 Sep
 2024 06:14:59 +0000
Received: from SJ5PEPF000001F7.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::c) by SJ0PR13CA0069.outlook.office365.com
 (2603:10b6:a03:2c4::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.17 via Frontend
 Transport; Tue, 24 Sep 2024 06:14:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F7.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.15 via Frontend Transport; Tue, 24 Sep 2024 06:14:58 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Sep
 2024 01:14:56 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>
CC: <xen-devel@lists.xenproject.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Jiqian Chen
	<Jiqian.Chen@amd.com>
Subject: [KERNEL PATCH v10 0/3] Support device passthrough when dom0 is PVH on Xen
Date: Tue, 24 Sep 2024 14:14:34 +0800
Message-ID: <20240924061437.2636766-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F7:EE_|SJ2PR12MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e6a56aa-8ad3-416f-ea3c-08dcdc6037d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jA+GadcbgkrC20ReBMz7guhGYOC8vrX4+F9HBI9G27er7Z0b23ne1cmOTfsb?=
 =?us-ascii?Q?1W7h+FXtMgNWQK9rYQYQxx+SJNhL8x2oZBNdp46Lmhk2Ki6rNvk4pt8+P3rU?=
 =?us-ascii?Q?nrL36mw7tfihZMZQrLbjBqbfmRlE1oMQ+lZeK1uh/6teI/bhbuA6hJYrBLv0?=
 =?us-ascii?Q?pwWf3OyfnSUBEUP46fjuQm95evvzzp75wB5u4pZg3Sbk8rSwsQXaTf09eDo2?=
 =?us-ascii?Q?tW6giLinRoielijZIjBnxLqt5EIwNu8hJeRRLgjL43ck+9VADH3/lk92/gWf?=
 =?us-ascii?Q?glgxOE18rmqxPypjbDGGAkB1NRnz6bAIatKs5dBPjTJvSwP5KGVk0YEUloC5?=
 =?us-ascii?Q?7UZkKaKdcZThtyGE/Ps9KFU0M80k+fAtbjPxzZmOzMqpjGCeq8EvVFVljy+3?=
 =?us-ascii?Q?SGUtYqgehvv+aZeOkVSPWIcWnVZwW9M8rP/7lwARS8pQd8Hyktkk+GNGa5Ls?=
 =?us-ascii?Q?s6P/5QjAWYgbmb5tr09FnuyYx5IjS03qHWsRTilOwOSogBKYaBGFUUKosBDo?=
 =?us-ascii?Q?pEXOpWI19kj/aB4/nWqV+amGTgqtV69h3w0PCPsbd3SXXpH+Z7doBHaKRfF4?=
 =?us-ascii?Q?qn+8y8oapyQ8s0UfBWh8YLDM0ctwiIXxb76AcP8HAd5Opkm5kz7QLdE16Csn?=
 =?us-ascii?Q?psazFqiAmjfKcKYZ9pdN1jUc7ujNbPyPc9OcttTVeVMOTfyx0dHb6FGjV8dn?=
 =?us-ascii?Q?gWTkQ4qMyqYVIW0xwtSnMEfLGWgjCUpDzmAR5oTe9rBgLsKwQEqkJFNxkm3t?=
 =?us-ascii?Q?oV6W98V62T7XUONhTwszvKmFpdZU73B/ygs/jhmX3bSJnDavCcyPqclSdztA?=
 =?us-ascii?Q?ukDvwfYPPsvMhnC+jfK0IzudfVRiZesfLbGH5aJCptm0IR9ekXCuBMCPSr8r?=
 =?us-ascii?Q?fbO0fYF4oNyRC5uUx7+mQyOuNP5iEjSLCrXSlayTvYc2l+ohJ/feIa6hcvE7?=
 =?us-ascii?Q?rJkittBxAMqbAJpqjI0n1YVM+OTFShnGhi+hKallriVLfQqQUtf5Ge/ltriL?=
 =?us-ascii?Q?cv7OxzZmcuiMXkCVvzHTTKa6ChCQPbh4KRjDKQxBfnYl1U3AQB9hkrYuE8Ix?=
 =?us-ascii?Q?H8CaEiOgjEEf8/TR1KVNEpMqphVLEcGf2ipspZYgE9UYyAzdEUUyADLzv9dF?=
 =?us-ascii?Q?IuaqVRfF/9BL4VskUay4JQkaWBJCHObaCTv72aQAmxoUFyYRSWPLb+P7ZfGD?=
 =?us-ascii?Q?DZ6UcdYK8+c1TwQVCtWJY7qzWiyz5feK/T84V6P+IdAWwnGTW3q6EfRrxHH7?=
 =?us-ascii?Q?3SFc/SCvHBiyUzVyEiUrm6v8dWx/SDgPD05F/YIa67sLQ9YrQ3zYY82kqVeE?=
 =?us-ascii?Q?Oy0dGcwcLd8gnqyy4Ib4mlb4VlaHgrUjyImtuBHgSlV8Ns43bKpIDNm/18OH?=
 =?us-ascii?Q?7sTzQwp+ELQt+h0qsP3HshZMr4uM?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2024 06:14:58.9967
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6a56aa-8ad3-416f-ea3c-08dcdc6037d3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7868

Hi All,
This is v10 series to support passthrough on Xen when dom0 is PVH.
v9->v10 changes:
* patch#1: Added Reviewed-by of Stefano.
* patch#2: Added Reviewed-by of Stefano.
* patch#3: Changed the macro wrapping "pcistub_get_gsi_from_sbdf" from "CONFIG_XEN_PCIDEV_BACKEND" to "CONFIG_XEN_ACPI".
           Added "imply CONFIG_XEN_PCIDEV_BACKEND" for CONFIG_XEN_PRIVCMD Kconfig definition.
           Added check "if (IS_REACHABLE(CONFIG_XEN_PCIDEV_BACKEND))" before calling pcistub_get_gsi_from_sbdf.


Best regards,
Jiqian Chen



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
 drivers/xen/Kconfig                |  1 +
 drivers/xen/acpi.c                 | 50 ++++++++++++++++++++
 drivers/xen/pci.c                  | 13 +++++
 drivers/xen/privcmd.c              | 32 +++++++++++++
 drivers/xen/xen-pciback/pci_stub.c | 76 +++++++++++++++++++++++++++---
 include/linux/acpi.h               |  1 +
 include/uapi/xen/privcmd.h         |  7 +++
 include/xen/acpi.h                 | 27 +++++++++++
 include/xen/interface/physdev.h    | 17 +++++++
 include/xen/pci.h                  |  6 +++
 12 files changed, 248 insertions(+), 7 deletions(-)

-- 
2.34.1


