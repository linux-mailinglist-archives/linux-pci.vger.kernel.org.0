Return-Path: <linux-pci+bounces-730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E627080BC14
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 17:15:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 049491C20359
	for <lists+linux-pci@lfdr.de>; Sun, 10 Dec 2023 16:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAA5171DF;
	Sun, 10 Dec 2023 16:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RRolg0YH"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2064.outbound.protection.outlook.com [40.107.102.64])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D337FE;
	Sun, 10 Dec 2023 08:15:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m9jcXsMOJcheojG0j33JvAFnX7EPx9B7V+jF0QHUE/8QkYQhsna+sHd2EGwJ4Eb102vOI3ytz+1mjmaFQhs3MqLfRCM1b6kSJwoIJpmjscVw3slWRfG7THcTBP9gRGX6XkU/coC7kpjKOIeILu4WPi5RTJ7A1ovZwBJj/vgp4LQo/3AFYFSFtegLoo/DReTuJl6XXk8geacZcPnNJtEf+IN909RZSamjcJkN5Q3qThggdt305XLmGK6xoo4yQnirbCA4CqMvhS/E3uBuluNqkiIs0cQQpkOJSkmo2FqdOMSh3BsUwxZ0K96BhxOTFFmqln4nLep2AgO8UdCz6EKeQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jTOwWH8hZtBfEwSEXMP8D8XX9nppVNLQOx6Jg7+Cj6g=;
 b=MWCZywXwNZkafUgZHrLUTnNDwCyeektgyyckoS4zqz8tNzJ9xdhL08iCvOdph4GIy+9Jqh+ZJHgzh8vnEizdA5fl5Wi1areVrU6xB8F63zyDro97+PXajEb0GmqEfBMjn0ifl8F2s0JU+jyLg6MomDB/uSzDA76ju+REBFwBYwZWduy1Zv1Vgji4iqU4+9DdloYj+9dd7M4X7pRoLLviYfJavlcZRzVnw36EQM7waiiTggePeqTNRiWw0IV6orWZg/rje8WuOU9C7k/q7c9X4CKiunnGLa12reEtoIm7xrCYfu3kHp/tK9r568dmYIeYzBtv1CsUS6U1rBGmC7eULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTOwWH8hZtBfEwSEXMP8D8XX9nppVNLQOx6Jg7+Cj6g=;
 b=RRolg0YH/99AEkuOqWd8zhSXwRb0njLvSBx0dej8V8FvZvndKLVpqoda9YlV6ef9Jc/D2xkHjcJrzM+edl3Leu/UntJJN2jiaRWd4TgOJoVrgE/ZuxgooNuR3I/5AU85CkZLPGArYrsKIDOuN8aFzGX2eGEyWJ3k8/OmLlw9L8I=
Received: from CYZPR05CA0044.namprd05.prod.outlook.com (2603:10b6:930:a3::23)
 by BY5PR12MB4194.namprd12.prod.outlook.com (2603:10b6:a03:210::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Sun, 10 Dec
 2023 16:15:39 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:a3:cafe::89) by CYZPR05CA0044.outlook.office365.com
 (2603:10b6:930:a3::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.21 via Frontend
 Transport; Sun, 10 Dec 2023 16:15:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.144) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7091.18 via Frontend Transport; Sun, 10 Dec 2023 16:15:38 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Sun, 10 Dec
 2023 10:15:32 -0600
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Oleksandr Tyshchenko
	<oleksandr_tyshchenko@epam.com>, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Thomas
 Gleixner" <tglx@linutronix.de>, Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
CC: <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>, <xen-devel@lists.xenproject.org>, Alex Deucher
	<Alexander.Deucher@amd.com>, Christian Koenig <Christian.Koenig@amd.com>,
	Stewart Hildebrand <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou
	<xenia.ragiadakou@amd.com>, Honglei Huang <Honglei1.Huang@amd.com>, "Julia
 Zhang" <Julia.Zhang@amd.com>, Huang Rui <Ray.Huang@amd.com>, Jiqian Chen
	<Jiqian.Chen@amd.com>
Subject: [RFC KERNEL PATCH v3 0/3] Support device passthrough when dom0 is PVH on Xen
Date: Mon, 11 Dec 2023 00:15:16 +0800
Message-ID: <20231210161519.1550860-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|BY5PR12MB4194:EE_
X-MS-Office365-Filtering-Correlation-Id: 54fc3b0f-085f-4440-ea61-08dbf99b3fbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OnKY+i+xrHNIxEqLrC8OE39aFpZ4DACvtP7roWk6CNTUV3A0Y67EE3WnLXlDaTo0HOFx2r4legQA+8dc8MO8fVL+MdvDLKVPhmd/YsPeLKBuI0t2xid9/vQLI/NK7bUbjHkqLxXF/NzIwlrYaykpD/petx9hVn/uv+Cxad+GV2OsHzJgSKdjVyWfLFeBtnnKT1NYFatcNtTdCsjyVzWLPxta24mI81VkAf6jBC40H79rhcYELZy/WUd9ChaqvBmxIJv5su1gHpmLyhWzcF8KxKC5KUs0YtHQK0e4WFOxt1gwiZmqND8lp1pXN+5/4rRx7a5O6r5zsP0lZmQY+bsgzFvXGvEqtUnqzytzMgncToHhtdfXmIpVTJcrci/cADtYB5/avL5z846azjLnDiGl6khUIXs4GwBjYgLd8zDYdR6z+Lx/U1mlQDyRe12QrDLYZUKWIr90HF2tpAfe6CNP9/EZD8pZOhNxBnRPPlch9zn5ECpnSwbw1B944vP0oJE4T/mmTrZiRtyC46pUukHSg3gXUtigROEfUHq+7AoKSkqGnsDeubCzYzMxaZnpKN2g2HhipSDZm/oar2VP1JU8Ot5bUNHQc3tNSTf08rF0/q84dWN/f9QmNZDqidz1kC1e+zbZMeTNOtuiWDEeOscpJ2Up1zRR0fIwxCxVhSK8UucFtwbiEG+I0ueK5i+X1mMks/HJIOxlTuyeyoOko78zaveRFi1U7S8hNTnrW2Vk3DOa2/2+ITrKvki1Gk0Unlr7Wazh5rFaJP7nw6DZ9k5sHw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(136003)(376002)(39850400004)(346002)(230922051799003)(451199024)(64100799003)(82310400011)(1800799012)(186009)(46966006)(36840700001)(36860700001)(5660300002)(1076003)(47076005)(336012)(26005)(2616005)(16526019)(36756003)(426003)(7416002)(70586007)(70206006)(54906003)(966005)(40480700001)(2906002)(83380400001)(82740400003)(81166007)(41300700001)(356005)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(110136005)(316002)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2023 16:15:38.6752
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54fc3b0f-085f-4440-ea61-08dbf99b3fbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4194

Hi All,

This is v3 series to support passthrough on Xen when dom0 is PVH.
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
Problem: when we run “sudo xl pci-assignable-add <sbdf>” to assign a device, pci_stub will
call “pcistub_init_device() -> pci_restore_state() -> pci_restore_config_space() ->
pci_restore_config_space_range() -> pci_restore_config_dword() -> pci_write_config_dword()”,
the pci config write will trigger an io interrupt to bar_write() in the xen, but the
bar->enabled was set before, the write is not allowed now, and then when Qemu config the
passthrough device in xen_pt_realize(), it gets invalid bar values.

Reason: the reason is that we don't tell vPCI that the device has been reset, so the current
cached state in pdev->vpci is all out of date and is different from the real device state.

Solution: to solve this problem, the first patch of kernel(xen/pci: Add xen_reset_device_state
function) and the fist patch of xen(xen/vpci: Clear all vpci status of device) add a new
hypercall to reset the state stored in vPCI when the state of real device has changed.
Thank Roger for the suggestion of this v2, and it is different from v1
(https://lore.kernel.org/xen-devel/20230312075455.450187-3-ray.huang@amd.com/), v1 simply allow
domU to write pci bar, it does not comply with the design principles of vPCI.

2. failed to do PHYSDEVOP_map_pirq when dom0 is PVH
Problem: HVM domU will do PHYSDEVOP_map_pirq for a passthrough device by using gsi. See
xen_pt_realize->xc_physdev_map_pirq and pci_add_dm_done->xc_physdev_map_pirq. Then
xc_physdev_map_pirq will call into Xen, but in hvm_physdev_op(), PHYSDEVOP_map_pirq is not allowed.

Reason: In hvm_physdev_op(), the variable "currd" is PVH dom0 and PVH has no X86_EMU_USE_PIRQ flag,
it will fail at has_pirq check.

Solution: I think we may need to allow PHYSDEVOP_map_pirq when "currd" is dom0 (at present dom0 is
PVH). The second patch of xen(x86/pvh: Open PHYSDEVOP_map_pirq for PVH dom0) allow PVH dom0 do
PHYSDEVOP_map_pirq. This v2 patch is better than v1, v1 simply remove the has_pirq check(xen
https://lore.kernel.org/xen-devel/20230312075455.450187-4-ray.huang@amd.com/).

3. the gsi of a passthrough device doesn't be unmasked
 3.1 failed to check the permission of pirq
 3.2 the gsi of passthrough device was not registered in PVH dom0

Problem:
3.1 callback function pci_add_dm_done() will be called when qemu config a passthrough device for domU.
This function will call xc_domain_irq_permission()-> pirq_access_permitted() to check if the gsi has
corresponding mappings in dom0. But it didn’t, so failed. See
XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH dom0 and it return irq is 0.
3.2 it's possible for a gsi (iow: vIO-APIC pin) to never get registered on PVH dom0, because the
devices of PVH are using MSI(-X) interrupts. However, the IO-APIC pin must be configured for it to be
able to be mapped into a domU.

Reason: After searching codes, I find "map_pirq" and "register_gsi" will be done in function
vioapic_write_redirent->vioapic_hwdom_map_gsi when the gsi(aka ioapic's pin) is unmasked in PVH dom0.
So the two problems can be concluded to that the gsi of a passthrough device doesn't be unmasked.

Solution: to solve these problems, the second patch of kernel(xen/pvh: Unmask irq for passthrough
device in PVH dom0) call the unmask_irq() when we assign a device to be passthrough. So that
passthrough devices can have the mapping of gsi on PVH dom0 and gsi can be registered. This v2 patch
is different from the v1(
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/,
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/ and
xen https://lore.kernel.org/xen-devel/20230312075455.450187-5-ray.huang@amd.com/),
v1 performed "map_pirq" and "register_gsi" on all pci devices on PVH dom0, which is unnecessary and
may cause multiple registration.

4. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device’s gsi to pirq in function
xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq, but qemu
pass irq to it and treat irq as gsi, it is got from file /sys/bus/pci/devices/xxxx:xx:xx.x/irq in
function xen_host_pci_device_get(). But actually the gsi number is not equal with irq. On PVH dom0,
when it allocates irq for a gsi in function acpi_register_gsi_ioapic(), allocation is dynamic, and
follow the principle of applying first, distributing first. And if you debug the kernel codes(see
function __irq_alloc_descs), you will find the irq number is allocated from small to large by order,
but the applying gsi number is not, gsi 38 may come before gsi 28, that causes gsi 38 get a smaller
irq number than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want to use gsi,
we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall to get gsi from irq)
records all the relations in acpi_register_gsi_xen_pvh() when dom0 initialize pci devices, and provide
a syscall for userspace to get the gsi from irq. The third patch of xen(tools: Add new function to get
gsi from irq) add a new function xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success. This v2
patch is the same as v1(
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-6-ray.huang@amd.com/ and
xen https://lore.kernel.org/xen-devel/20230312075455.450187-6-ray.huang@amd.com/)

About the v2 patch of qemu, just change an included head file, other are similar to the v1 (
qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.

Jiqian Chen (3):
  xen/pci: Add xen_reset_device_state function
  xen/pvh: Setup gsi and map pirq for passthrough device
  PCI/sysfs: Add gsi sysfs for pci_dev

 arch/x86/xen/enlighten_pvh.c       | 116 +++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |   3 +-
 drivers/pci/pci-sysfs.c            |  11 +++
 drivers/xen/pci.c                  |  12 +++
 drivers/xen/xen-pciback/pci_stub.c |  12 +++
 include/linux/acpi.h               |   1 +
 include/linux/pci.h                |   2 +
 include/xen/acpi.h                 |   1 +
 include/xen/interface/physdev.h    |   8 ++
 include/xen/pci.h                  |   6 ++
 10 files changed, 171 insertions(+), 1 deletion(-)

-- 
2.34.1


