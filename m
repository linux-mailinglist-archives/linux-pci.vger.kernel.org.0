Return-Path: <linux-pci+bounces-1696-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC4B824E8F
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 07:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50013285C14
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jan 2024 06:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C01E5CBE;
	Fri,  5 Jan 2024 06:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="PnEm8AkP"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2078.outbound.protection.outlook.com [40.107.237.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8454B610E;
	Fri,  5 Jan 2024 06:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nsWvq6KavCQe5g9hllVICUqZhNdKMSsQyNvouB0T82wmhk7L+7sHnypdgrvHuhmJWTcWGn5GHbjIChYc+qAcziSOby/9LX5cJVpyYfYGNBMgflpRdwtGnuhDqTml6bw7wxMsNIIHLm2ltI9C3UowpTxlBYp+a1LnXqJDIWWnTylFSn2TzbkYyfgKIc1vJIQWzx+ROkmt6aZkWxOUU+PUxOmVL1lQBt5VoAGUS4nnjSquIJZwvbhOgw+zOC3aZqi6OeLg0F5L9HLKjWMCL8C0EZFWHvU8FyTogHBKQbRe1+zPdT9lbW64CEw9mJkcp8JQtAcj0APvp6FwKwMF25PwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WU8XRv+JnqaDF1y6IiTVZ7L1pOo+p7PmuQARS50kZOk=;
 b=AntXcpL6/v/5oYvF0L2g41knNDvQyM5goqrTtbXekWQDpjorR+i1mzduzcwUMjghEjWau8j0lX74FYxy6AE+cXpkFdeWhBgY4WLrb2NlJy7N/qw0BTU2O9cMsmLraNsTThb9WpMyb3R7BIBW7nKaYgIdZRkcdiJm8FBsVy0iWs8VAFZJF23ZyBZYXW3w6BEVJf3ElU8v6bStb3hQmlUUOPPNzHvOG8jSmg8W0P/o3BbQTsg8ueyKzeo057G+kSg+DB6EidKcyBM3IjJ1BWvWkMEgupNpUXfjt21DDFB+OUxuShPTDqblURv4tLf2x9mZgpHAaMD8rWftan7ruqMbdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WU8XRv+JnqaDF1y6IiTVZ7L1pOo+p7PmuQARS50kZOk=;
 b=PnEm8AkPQFTT8HhRtigUTYQcXsJj1riscDanHnKVjgEoJ9KC74fFeb8VO94dvji3dPCCmwdHouMr48aPbcgFp49XKmYOwktDNltS+QZ8GfBnaMR2+o8H0YY88elQ8IPYuOskpxfVdgMEeoeymc/Zlac0Vg1qHezz8o4V2RSCWOc=
Received: from SJ0PR03CA0075.namprd03.prod.outlook.com (2603:10b6:a03:331::20)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16; Fri, 5 Jan
 2024 06:22:49 +0000
Received: from DS2PEPF0000343B.namprd02.prod.outlook.com
 (2603:10b6:a03:331:cafe::7) by SJ0PR03CA0075.outlook.office365.com
 (2603:10b6:a03:331::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.16 via Frontend
 Transport; Fri, 5 Jan 2024 06:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF0000343B.mail.protection.outlook.com (10.167.18.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Fri, 5 Jan 2024 06:22:48 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Fri, 5 Jan
 2024 00:22:32 -0600
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
Subject: [RFC KERNEL PATCH v4 0/3] Support device passthrough when dom0 is PVH on Xen
Date: Fri, 5 Jan 2024 14:22:14 +0800
Message-ID: <20240105062217.349645-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343B:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab493ed-44f6-4cfc-2b35-08dc0db6bd1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	v34HGsXe2tXTIZIqvabmf6fI8wZuYmrASPHsO/7Cg7LVh/1844Y2bJNQvb0oDqBWKsuR1boynog7BwBEJ+/PTQx6RPn7rYAs4urJS9Rmp+hCqxR0NaD2XjwM4VLEqeDsrW2ShdOUnj+4VaOgdJM7F2YliHAV0KsyvP+hyrmxUPZA5qJZox88apuNCyTWyc1H22ATidijxGw/qPaL//iPTon+WNZCgZWtN7mkx1CfDDL1Mb9G4UeqcK1MIIzVW2zIn2xb9TcVqqy4VawXYeMtawVzSh9Glz/nmjRFq3T1HxXPS4t+dXvpo7qb39QcQDrqpVAoL0Y6jyVNS8/V819+f5mXkvtmOAvhxRc6nU88n9dts9T9WNiJi4k7Sq3tIk7qMl4MTcIWk0FndtW3KXR8xTYQxyBGbvlXJpKehURVcNACSzDZjfEY6jaNl86r7W9cxpRfhrdP7O/6Hfy1aJWNGWfWGFmT9jciMKtgsY9hve6KjAyrg/VP8Erf1U2aAsv7jr6ASE9RnCGsKLl2hpak73tMW8l+2O2JsNZ7rmkQL5otafekWZhpQfLnpyfCempvkpvDcUl/MFg8nTm30x5dXG/09PZGFYDN7s6IqMl2mUHDBy/MtfuCTIqY1M7BHd/mQS76kohD/SbfsMT8hduT0pzk6cRPMArJC2scJ8QWJJvomEdiknc/g3f0dCN1ahYr2AFvZ+Z5hsoO/9Ii53569XLTXz4lcsohUOo9pE5pgnHCYyD3fAO7pxSuB5EweqHHI8GwR6yuYGGU9vybfiD32mtnAHcC9RM+YwswWaMtK70=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(376002)(39860400002)(346002)(396003)(230922051799003)(451199024)(82310400011)(186009)(64100799003)(1800799012)(46966006)(40470700004)(36840700001)(356005)(82740400003)(81166007)(36756003)(40480700001)(40460700003)(86362001)(1076003)(16526019)(26005)(2616005)(426003)(336012)(70586007)(110136005)(70206006)(6666004)(316002)(8936002)(966005)(478600001)(36860700001)(8676002)(7696005)(47076005)(83380400001)(54906003)(7416002)(2906002)(5660300002)(4326008)(41300700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2024 06:22:48.6663
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab493ed-44f6-4cfc-2b35-08dc0db6bd1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

Hi All,
This is v4 series to support passthrough on Xen when dom0 is PVH.
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

 arch/x86/xen/enlighten_pvh.c       | 90 ++++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |  3 +-
 drivers/pci/pci-sysfs.c            | 11 ++++
 drivers/xen/pci.c                  | 12 ++++
 drivers/xen/xen-pciback/pci_stub.c | 26 ++++++++-
 include/linux/acpi.h               |  1 +
 include/linux/pci.h                |  2 +
 include/xen/acpi.h                 |  6 ++
 include/xen/interface/physdev.h    |  7 +++
 include/xen/pci.h                  |  6 ++
 10 files changed, 160 insertions(+), 4 deletions(-)

-- 
2.34.1


