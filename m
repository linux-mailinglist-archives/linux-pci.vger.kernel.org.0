Return-Path: <linux-pci+bounces-5306-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B185088F838
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 07:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D264C1C23210
	for <lists+linux-pci@lfdr.de>; Thu, 28 Mar 2024 06:57:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AF223768;
	Thu, 28 Mar 2024 06:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D6i/RBwi"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3FA4F898;
	Thu, 28 Mar 2024 06:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711609037; cv=fail; b=SZTdIVEL0xhGjJFPu7bU3AePZQw+VPb+GRWWL5zSCpHM9yJgS5yjAAv2403bbVK8Pq/GVjmtFYBPatywwiedI8t+T3llaQT0cnWMb+y8R1OCHWKwasBrutCEgE7OzfikMdS5OGgfCqjxvklsj9r+HdjK3ZCr9aK86W0QlBXz7jY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711609037; c=relaxed/simple;
	bh=pLdZdeaWp9cnI3TMEyOcpO1Hnl3e6CFYPPqjA00Awvg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J2qsS79x4NunK2/d8m91KWP0nQ7aQAf08iiQGW8PyDkcEZdFrUKoomotdzFWEJa85je+cskDwlGhE1XzLKFLbbjK5EodRxpRTZoe5zvG8Yz+tOxgaaRRmQLia5S2RAi7dmzc/tPLn0gLhXOwByZXZ3BzEX9mJbZaqaM11SuRia4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D6i/RBwi; arc=fail smtp.client-ip=40.107.237.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AtZFt0IxYHgItse27FCHsFxRIIGThckNW7utmemJ4fqYk0FZHDrvEw6wADCXB+uPSp2zUKa6tbfDA5Rl25TF25UqhBePrNJrSnGuXATsHUKYr1vddifO7TBZciPwLrrQNCmv7rh1dKm7x/EI+CGZ9tfeSogFYzHNmFO/g8pTkF4JX+MvKUjVML+lOkGaf42mx4BwiU3b93im6mzzP5vum7D4gJigBfSMLGCJ3q6UatGHOyFDVc2ZsUTPlTJiIOjc2CFzmg7mX5IttXg5cjZXYBocIt0MMjao8UivulNSxQa85AEGiu0Do5hx/jvhKLjPPWa8D33pYhbKFtXUSFvMVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=273GWbU6VWbGodhCopaUDbY7XBraT91TwLrR/sYxOpM=;
 b=by+oFFmFBxCjbiNn9GNW9vfLT4aJfncdRA0Q06x2wD1Eq7Nn8L0lANR+OW5/3KnsAQUxrUL+gPMiHVdxdIVUtctDfJX6flLtCshmgCDStdx+pbpMg8LcnMX2pwInJUazpyslT7fTAhW3Y4/r3VXQ086MDwIirQp8BU+J6y8JkfrO/TBDDqSzWbB6NpHu51IRpREC3XEd5rWhTVNrvhsES8J7jwMKLYwE0S66R3N1dPMEEzifn/5OuvCQfsxHwZiSMdVQMSxDWvg1K5mRxRVBd274NSGK5lY9V8R4fb+X9iYyKLK8isMvXpf0ughgpHfeE0BLofPc0coAUYiqI9T40A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=273GWbU6VWbGodhCopaUDbY7XBraT91TwLrR/sYxOpM=;
 b=D6i/RBwilg2pSxSu0PWifsO9uzeaf7yoLE+yyQDYENktQ9odPH+q7AvabJK9MAvTYfJUScbPgX2ajDfAXOlNp44eU2YbQHyKnIawVOzgRi52+W5+nfXVV1QH5hcKn/kg3cLEWHZrBshfGGxyrvvFDAWw176nv1mCXuFLxgvLTjg=
Received: from BN7PR02CA0008.namprd02.prod.outlook.com (2603:10b6:408:20::21)
 by PH7PR12MB5925.namprd12.prod.outlook.com (2603:10b6:510:1d8::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 06:57:11 +0000
Received: from BN2PEPF000044A5.namprd04.prod.outlook.com
 (2603:10b6:408:20:cafe::6e) by BN7PR02CA0008.outlook.office365.com
 (2603:10b6:408:20::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 06:57:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A5.mail.protection.outlook.com (10.167.243.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 06:57:10 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 01:57:06 -0500
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
	Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC KERNEL PATCH v5 0/3] Support device passthrough when dom0 is PVH on Xen
Date: Thu, 28 Mar 2024 14:56:43 +0800
Message-ID: <20240328065646.354782-1-Jiqian.Chen@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A5:EE_|PH7PR12MB5925:EE_
X-MS-Office365-Filtering-Correlation-Id: 888fe74a-700a-4cea-f84c-08dc4ef44a8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	HgZUZST/R0HcwDjruN1lqM/2ALz1RSyEfSbVrUG4q94FbgCaKgOgYgarzAb96wtPXa60MFiGi4/t359g2IUreSrwGiGAccvQA6H7R0lTnF1B2212+H28Av0u2rak3+I1i6R+giRhIzojQ/gXqWjHy79nH9pVRidm8rf1Mha9OFe2HvF1dXmGqGSfQt0wSxacttqLliIark3rzgdqXQoXEzYqtIHMoaio5PJwskd158M6tCfV4CtizLuGsrU/MKFPQ92+rQpfevnol6TPugLviFsPnjHg31fzJ5VrKmHKkp9Wj9yhOWLZPQNWt/bQx5yCot+WZsOu1fuw4mUqznDeYcIgvDPKDYLOD/Ab+ZBgpwVSv8KQTElltbxxOprtfQNSb1kMYGmU3rZ9uieEYjrytCOEy+daTydnrDazgDFaIu2P3gPOstrOyx/eyBFpls5UnD2HE8nyiyTSe8M3zyAdPZbrYggn8Blw6/flEtLWN0ZGdaT7jJUKtI8TKJC1ZkmD3ZvYsIHlLYycVixGW9FDt9lXQBcwkMyVCFzn1hE5UOzGaK1CkAG59wnf6oJH0OLTOgx7TPV3Z10U8hxm54E1pJBZTRAvVKypxEyIT2Mh4MoBYNxAFRi83DZrb8cV0lqTHGOqE3wxGRsaZW3CHQcJwWJFbcmuY3+oE+eK2r2MR7Omhm5B5j6+xYFF6PiUlu5s/DDyM37nHg58DF14Kss1Dg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(376005)(1800799015)(7416005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 06:57:10.9169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 888fe74a-700a-4cea-f84c-08dc4ef44a8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5925

Hi All,
This is v5 series to support passthrough on Xen when dom0 is PVH.
patch#2 change function acpi_pci_irq_lookup from a static function to non-static, need ACPI Maintainer to give some comments.
patch#3 linux internal changes, need PCI and ACPI Maintainer to give more comments.
v4->v5 changes:
* patch#1: Add Reviewed-by Stefano
* patch#2: Add Reviewed-by Stefano
* patch#3: No changes

v3->v4 changes:
* patch#1: change the comment of PHYSDEVOP_pci_device_state_reset; use a new function pcistub_reset_device_state to wrap __pci_reset_function_locked and xen_reset_device_state, and call pcistub_reset_device_state in pci_stub.c
* patch#2: remove map_pirq from xen_pvh_passthrough_gsi

v3 link:
https://lore.kernel.org/lkml/20231210161519.1550860-1-Jiqian.Chen@amd.com/T/#t
v2->v3 changes:
* patch#1: add condition to limit do xen_reset_device_state for no-pv domain in pcistub_init_device.
* patch#2: Abandoning previous implementations that call unmask_irq. To setup gsi and map pirq for passthrough device in pcistub_init_device.
* patch#3: Abandoning previous implementations that adds new syscall to get gsi from irq. To add a new sysfs for gsi, then userspace can get gsi number from sysfs.


v2 link:
https://lore.kernel.org/lkml/20231124103123.3263471-1-Jiqian.Chen@amd.com/T/#t

Below is the description of v2 cover letter:
This series of patches are the v2 of the implementation of passthrough when dom0 is PVH on Xen.
We sent the v1 to upstream before, but the v1 had so many problems and we got lots of suggestions.
I will introduce all issues that these patches try to fix and the differences between v1 and v2.

Issues we encountered:
1. pci_stub failed to write bar for a passthrough device.
Problem: when we run “sudo xl pci-assignable-add <sbdf>” to assign a device, pci_stub will call “pcistub_init_device() -> pci_restore_state() -> pci_restore_config_space() ->
pci_restore_config_space_range() -> pci_restore_config_dword() -> pci_write_config_dword()”, the pci config write will trigger an io interrupt to bar_write() in the xen, but the
bar->enabled was set before, the write is not allowed now, and then when 
bar->Qemu config the
passthrough device in xen_pt_realize(), it gets invalid bar values.

Reason: the reason is that we don't tell vPCI that the device has been reset, so the current cached state in pdev->vpci is all out of date and is different from the real device state.

Solution: to solve this problem, the first patch of kernel(xen/pci: Add xen_reset_device_state
function) and the fist patch of xen(xen/vpci: Clear all vpci status of device) add a new hypercall to reset the state stored in vPCI when the state of real device has changed.
Thank Roger for the suggestion of this v2, and it is different from v1 (https://lore.kernel.org/xen-devel/20230312075455.450187-3-ray.huang@amd.com/), v1 simply allow domU to write pci bar, it does not comply with the design principles of vPCI.

2. failed to do PHYSDEVOP_map_pirq when dom0 is PVH
Problem: HVM domU will do PHYSDEVOP_map_pirq for a passthrough device by using gsi. See xen_pt_realize->xc_physdev_map_pirq and pci_add_dm_done->xc_physdev_map_pirq. Then xc_physdev_map_pirq will call into Xen, but in hvm_physdev_op(), PHYSDEVOP_map_pirq is not allowed.

Reason: In hvm_physdev_op(), the variable "currd" is PVH dom0 and PVH has no X86_EMU_USE_PIRQ flag, it will fail at has_pirq check.

Solution: I think we may need to allow PHYSDEVOP_map_pirq when "currd" is dom0 (at present dom0 is PVH). The second patch of xen(x86/pvh: Open PHYSDEVOP_map_pirq for PVH dom0) allow PVH dom0 do PHYSDEVOP_map_pirq. This v2 patch is better than v1, v1 simply remove the has_pirq check(xen https://lore.kernel.org/xen-devel/20230312075455.450187-4-ray.huang@amd.com/).

3. the gsi of a passthrough device doesn't be unmasked
 3.1 failed to check the permission of pirq
 3.2 the gsi of passthrough device was not registered in PVH dom0

Problem:
3.1 callback function pci_add_dm_done() will be called when qemu config a passthrough device for domU.
This function will call xc_domain_irq_permission()-> pirq_access_permitted() to check if the gsi has corresponding mappings in dom0. But it didn’t, so failed. See XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH dom0 and it return irq is 0.
3.2 it's possible for a gsi (iow: vIO-APIC pin) to never get registered on PVH dom0, because the devices of PVH are using MSI(-X) interrupts. However, the IO-APIC pin must be configured for it to be able to be mapped into a domU.

Reason: After searching codes, I find "map_pirq" and "register_gsi" will be done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when the gsi(aka ioapic's pin) is unmasked in PVH dom0.
So the two problems can be concluded to that the gsi of a passthrough device doesn't be unmasked.

Solution: to solve these problems, the second patch of kernel(xen/pvh: Unmask irq for passthrough device in PVH dom0) call the unmask_irq() when we assign a device to be passthrough. So that passthrough devices can have the mapping of gsi on PVH dom0 and gsi can be registered. This v2 patch is different from the v1( kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/,
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/ and xen https://lore.kernel.org/xen-devel/20230312075455.450187-5-ray.huang@amd.com/),
v1 performed "map_pirq" and "register_gsi" on all pci devices on PVH dom0, which is unnecessary and may cause multiple registration.

4. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device’s gsi to pirq in function xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq, but qemu pass irq to it and treat irq as gsi, it is got from file /sys/bus/pci/devices/xxxx:xx:xx.x/irq in function xen_host_pci_device_get(). But actually the gsi number is not equal with irq. On PVH dom0, when it allocates irq for a gsi in function acpi_register_gsi_ioapic(), allocation is dynamic, and follow the principle of applying first, distributing first. And if you debug the kernel codes(see function __irq_alloc_descs), you will find the irq number is allocated from small to large by order, but the applying gsi number is not, gsi 38 may come before gsi 28, that causes gsi 38 get a smaller irq number than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want to use gsi, we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall to get gsi from irq) records all the relations in acpi_register_gsi_xen_pvh() when dom0 initialize pci devices, and provide a syscall for userspace to get the gsi from irq. The third patch of xen(tools: Add new function to get gsi from irq) add a new function xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success. This v2 patch is the same as v1( kernel https://lore.kernel.org/xen-devel/20230312120157.452859-6-ray.huang@amd.com/ and xen https://lore.kernel.org/xen-devel/20230312075455.450187-6-ray.huang@amd.com/)

About the v2 patch of qemu, just change an included head file, other are similar to the v1 ( qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.


Jiqian Chen (3):
  xen/pci: Add xen_reset_device_state function
  xen/pvh: Setup gsi for passthrough device
  PCI/sysfs: Add gsi sysfs for pci_dev

 arch/x86/xen/enlighten_pvh.c       | 92 ++++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |  3 +-
 drivers/pci/pci-sysfs.c            | 11 ++++
 drivers/xen/pci.c                  | 12 ++++
 drivers/xen/xen-pciback/pci_stub.c | 26 ++++++++-
 include/linux/acpi.h               |  1 +
 include/linux/pci.h                |  2 +
 include/xen/acpi.h                 |  6 ++
 include/xen/interface/physdev.h    |  7 +++
 include/xen/pci.h                  |  6 ++
 10 files changed, 162 insertions(+), 4 deletions(-)

-- 
2.34.1


