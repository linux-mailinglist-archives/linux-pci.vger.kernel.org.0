Return-Path: <linux-pci+bounces-6472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2FA8AA73F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 05:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C31A281555
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 03:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C9489473;
	Fri, 19 Apr 2024 03:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FdXIN8Vz"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2076.outbound.protection.outlook.com [40.107.100.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0437C;
	Fri, 19 Apr 2024 03:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713497804; cv=fail; b=aVBU/4XLyTPJ2Jh1fmRUeYs65tOeZR0DL/JR1i/nhsp0gJoV3fZoS6fN08ZIZFrwrUF+UwZjs4Dr1R1rcZU9BM8e+/0tqayAM69ekbjK77aW+oHt9vXI0rfnN1jcTF+WktfFSfrklWWohUTtj/y3Vxdk3SKG7Mw9b5z6q7cadyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713497804; c=relaxed/simple;
	bh=aR/H2YBexbSCOh/wHA1U6QJFY/RPDwvnFOl/gQy8FPQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UW9fYuAxMrWEtHd/4rEOXs1PGMy7+MgVnuQh+7kik/NcCEUyftOLgK9XsavJu5Fc1pq7Dq6X2u9hLQsK4m7+GzMZl5WMxKG98juLMsXYn9ufHxNWQybvWrY22Lw80YYhvVZmgO7ZfHqd0B7YtGXPMJxfjtNSO3UlhllMCKFG6CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FdXIN8Vz; arc=fail smtp.client-ip=40.107.100.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iz+sylOrH5xpc5yCs3hTmTjcAoZRFZvEPypEw3/DUjtGeqzupzB/vsv/3Z4CA35JHIJohu/p9HtpYtwtjyhAteVb66WLVPKVR8nI/5XPJSIc6hL44hM3wrdNEzuDXP66VxZKb9xD/UtJMUMjjyZt/SdddYg778uPFqzg7zozWqLGnh9njUHdIPzw/uQmfP/Z7u0g+RW/2oCixiGnmNug4BslpqxZfo5RfZ6bh79PLuIz8pIDs8nNkUQkiePvn3qp8GBu59NchHbUiFrM2fUnF53rGX8Q692mGAcA5SwclXBvzK1oLOacLlAXJdy1FgXzjIElDpCQzmVq4kJ3kUnFBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OE3zS+divbEyPQev8eVUhdfvjNnIXK0fM+wL5pfQVW4=;
 b=LPKKVuMRVY8fJgORhyasgvCXKzt6o0F97PmPE4YQbSFiBXsOFJOlW/Tklxc3rskCERtgxRZjb44I+eFF7L3qFEuRADJSvylT5t8xnpAHUHtZ6uv0C05/jSo+TX7D6oi650JADCDZJWI5PuzaXdHtwrwRfod2JTI3RBjNIaqGE79Ryfc6OBpusVad8Zfdp0svv58fUe/togvTjdMqGys1slxbOO7P3lmAqsHTuwXcnCBNo50dqz44IpG0tMdwtdqug54xhmvb9Oug1lLXjUe7I859TSUdxhn0YwQSf7hn80JpLjiIxKBc0FoGIXBdHRWKhSjRmjEeoLvcB8RqUEsWTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OE3zS+divbEyPQev8eVUhdfvjNnIXK0fM+wL5pfQVW4=;
 b=FdXIN8VzjjgSuTohOQQneUBs8ezosl3vkConFj3yKz2QUBaC1l97N1XuPWG9DScr8Hq4iNtaYM2zczUtNIfTaKeuDfxZCId0fpkfuE1yFS6nkh4lAB5/Y5bARxRT9GonCGKmaqLd5s0nxxmXhgM04SpJcs2sausV2e/WbNA744g=
Received: from BY5PR03CA0027.namprd03.prod.outlook.com (2603:10b6:a03:1e0::37)
 by IA1PR12MB6019.namprd12.prod.outlook.com (2603:10b6:208:3d5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.52; Fri, 19 Apr
 2024 03:36:35 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9c) by BY5PR03CA0027.outlook.office365.com
 (2603:10b6:a03:1e0::37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.33 via Frontend
 Transport; Fri, 19 Apr 2024 03:36:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 03:36:35 +0000
Received: from cjq-desktop.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 18 Apr
 2024 22:36:31 -0500
From: Jiqian Chen <Jiqian.Chen@amd.com>
To: Juergen Gross <jgross@suse.com>, Stefano Stabellini
	<sstabellini@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Rafael J .
 Wysocki" <rafael@kernel.org>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?=
	<roger.pau@citrix.com>
CC: <xen-devel@lists.xenproject.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-acpi@vger.kernel.org>, Huang Rui
	<Ray.Huang@amd.com>, Jiqian Chen <Jiqian.Chen@amd.com>
Subject: [RFC KERNEL PATCH v6 0/3] Support device passthrough when dom0 is PVH on Xen
Date: Fri, 19 Apr 2024 11:36:13 +0800
Message-ID: <20240419033616.607889-1-Jiqian.Chen@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|IA1PR12MB6019:EE_
X-MS-Office365-Filtering-Correlation-Id: 991c37bc-a64e-4af7-3a81-08dc6021e9ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eBaOPBirJcWaMR8EBRKgFZFw4ZanXMvtwbymRDG1HHahPLfBfmM1lPp63Tu3?=
 =?us-ascii?Q?f6BBOReqj9LT8FEMTn6Dj8pT2caiun7wU5PcmbZfDm2gBFyXMpFlBu8hK/Ru?=
 =?us-ascii?Q?fbwpLRHRT4nFPQnAn3y9qJ6KU2nNkvkwjkEbX/HWob6GqzFbJqSupl//oH8S?=
 =?us-ascii?Q?iR5Pe+/s1XAYUz6qR2KHxVvby+OG5LuIOSfpTezqCfRmlyW9zjrwJP5945oK?=
 =?us-ascii?Q?4vsiu8f+6bT7FPtaGwGfkPJs3sjmavGGtr9x/LE34hL6nkk5Zlils6S7gDDi?=
 =?us-ascii?Q?g7adPuupUPCp/MLpU8joR9qkkrQWj+ZHagub+XNiDa+TaLwqFT+GShrTa3+z?=
 =?us-ascii?Q?+HR+air/SLK87ceg4DjzfZrjHx+EmZw+rS2sjyRDxhPGFzjYWTNndPS9GT5Y?=
 =?us-ascii?Q?OZIuRSueCGuxGjzY9UrWU6lZ9On3f2JuqwBRFcUskiAjpHzZayUvbeUTDrdE?=
 =?us-ascii?Q?lIXlCDdZRMLvcYjdnz4yeVenbs6FNPrHhQh0S7JehL2CLvEZEE0pJ6R26Y/G?=
 =?us-ascii?Q?NRn+ByxgDnZ8OqNoQxlp5R61c1AFIVj44neEvROS+GayYFw4pKfk/zAqLGXp?=
 =?us-ascii?Q?wS9qYxKAuLzAAuvMN2h2UWbGQbZWJws9ERz4RE6gRS1P+iEAOs7aN4NlpBFR?=
 =?us-ascii?Q?71idHgUha/BzzdyDuao+igxMIzETMMUodEmjd9R5BlDFiYu8p1ne7+qFxfLs?=
 =?us-ascii?Q?zXNtgaD+hiD1e4LLLGFQvmS1xoY5Q0txAsXg2YVretag294DTPEPpCzzfSVg?=
 =?us-ascii?Q?NjlBzG2YKnP0v8jW6a7z27OY9CDJC0Fg+6F/RcTgoTJTZz8VABcAS5x2bw7E?=
 =?us-ascii?Q?5nM4WbAaoIxDx8PH1e1F7KjjczRNhAIEPIFJvTFZQMpDWtTpUHHv0Hx8cTFJ?=
 =?us-ascii?Q?7BmbUD7UizgqRVzp5BgESsE/YDWcO8TrFqvO8MDLDUjfOisfXK+eaOBuGsdZ?=
 =?us-ascii?Q?uzGQQzxHDypN9/H/gwIbflCCA2xv6Rdvxq9jge8ta1M+bS1KgjHwMvszoL62?=
 =?us-ascii?Q?7zRue+VygC+h8vInZHoR66IA8VwtVmO+iTOIkdPImLDHBhPy1Vafzhc7yBrb?=
 =?us-ascii?Q?gceWKpmCieAai9gam3di7vJpejtOhqYDt0pJmhC8F9fVjd5dF6wKZoYerBfp?=
 =?us-ascii?Q?rk4x5r7cwpdRY5SmWatKllAoTzfz2btIq/9CkfxumTqHSteFFWIBw79kwh2G?=
 =?us-ascii?Q?WKZ98zGF7zBJCTh0xAvGKWA7VZwDCZN0Hv/vAkmU0g9sRv72TpQjHgWfEWog?=
 =?us-ascii?Q?B46Ra9ZbAChjjDw/lEUDn4Ntu6OV354IvIQImsXI5CF/WESsfubhoufLQPEQ?=
 =?us-ascii?Q?mq4PWbYloBiwYiaaqMONZ6QM/WkUttoawFmRwaRB33m1JDzmUe+5Hde2SkCL?=
 =?us-ascii?Q?gfF5Le0q3NILIQS960pTlXdFDN9+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 03:36:35.1311
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 991c37bc-a64e-4af7-3a81-08dc6021e9ce
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6019

Hi All,
This is v6 series to support passthrough on Xen when dom0 is PVH.
v5->v6 change:
* patch#3: change to add a new syscall to translate irq to gsi, instead adding a new gsi sysfs.


Best regards,
Jiqian Chen


v4->v5 changes:
* patch#1: Add Reviewed-by Stefano
* patch#2: Add Reviewed-by Stefano
* patch#3: No changes


v3->v4 changes:
* patch#1: change the comment of PHYSDEVOP_pci_device_state_reset; use a new function pcistub_reset_device_state to wrap __pci_reset_function_locked and xen_reset_device_state, and call pcistub_reset_device_state in pci_stub.c
* patch#2: remove map_pirq from xen_pvh_passthrough_gsi


v2->v3 changes:
* patch#1: add condition to limit do xen_reset_device_state for no-pv domain in pcistub_init_device.
* patch#2: Abandoning previous implementations that call unmask_irq. To setup gsi and map pirq for passthrough device in pcistub_init_device.
* patch#3: Abandoning previous implementations that adds new syscall to get gsi from irq. To add a new sysfs for gsi, then userspace can get gsi number from sysfs.


Below is the description of v2 cover letter:
This series of patches are the v2 of the implementation of passthrough when dom0 is PVH on Xen.
We sent the v1 to upstream before, but the v1 had so many problems and we got lots of suggestions.
I will introduce all issues that these patches try to fix and the differences between v1 and v2.

Issues we encountered:
1. pci_stub failed to write bar for a passthrough device.
Problem: when we run \u201csudo xl pci-assignable-add <sbdf>\u201d to assign a device, pci_stub will call \u201cpcistub_init_device() -> pci_restore_state() -> pci_restore_config_space() ->
pci_restore_config_space_range() -> pci_restore_config_dword() -> pci_write_config_dword()\u201d, the pci config write will trigger an io interrupt to bar_write() in the xen, but the
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
This function will call xc_domain_irq_permission()-> pirq_access_permitted() to check if the gsi has corresponding mappings in dom0. But it didn\u2019t, so failed. See XEN_DOMCTL_irq_permission->pirq_access_permitted, "current" is PVH dom0 and it return irq is 0.
3.2 it's possible for a gsi (iow: vIO-APIC pin) to never get registered on PVH dom0, because the devices of PVH are using MSI(-X) interrupts. However, the IO-APIC pin must be configured for it to be able to be mapped into a domU.

Reason: After searching codes, I find "map_pirq" and "register_gsi" will be done in function vioapic_write_redirent->vioapic_hwdom_map_gsi when the gsi(aka ioapic's pin) is unmasked in PVH dom0.
So the two problems can be concluded to that the gsi of a passthrough device doesn't be unmasked.

Solution: to solve these problems, the second patch of kernel(xen/pvh: Unmask irq for passthrough device in PVH dom0) call the unmask_irq() when we assign a device to be passthrough. So that passthrough devices can have the mapping of gsi on PVH dom0 and gsi can be registered. This v2 patch is different from the v1( kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/,
kernel https://lore.kernel.org/xen-devel/20230312120157.452859-5-ray.huang@amd.com/ and xen https://lore.kernel.org/xen-devel/20230312075455.450187-5-ray.huang@amd.com/),
v1 performed "map_pirq" and "register_gsi" on all pci devices on PVH dom0, which is unnecessary and may cause multiple registration.

4. failed to map pirq for gsi
Problem: qemu will call xc_physdev_map_pirq() to map a passthrough device\u2019s gsi to pirq in function xen_pt_realize(). But failed.

Reason: According to the implement of xc_physdev_map_pirq(), it needs gsi instead of irq, but qemu pass irq to it and treat irq as gsi, it is got from file /sys/bus/pci/devices/xxxx:xx:xx.x/irq in function xen_host_pci_device_get(). But actually the gsi number is not equal with irq. On PVH dom0, when it allocates irq for a gsi in function acpi_register_gsi_ioapic(), allocation is dynamic, and follow the principle of applying first, distributing first. And if you debug the kernel codes(see function __irq_alloc_descs), you will find the irq number is allocated from small to large by order, but the applying gsi number is not, gsi 38 may come before gsi 28, that causes gsi 38 get a smaller irq number than gsi 28, and then gsi != irq.

Solution: we can record the relation between gsi and irq, then when userspace(qemu) want to use gsi, we can do a translation. The third patch of kernel(xen/privcmd: Add new syscall to get gsi from irq) records all the relations in acpi_register_gsi_xen_pvh() when dom0 initialize pci devices, and provide a syscall for userspace to get the gsi from irq. The third patch of xen(tools: Add new function to get gsi from irq) add a new function xc_physdev_gsi_from_irq() to call the new syscall added on kernel side.
And then userspace can use that function to get gsi. Then xc_physdev_map_pirq() will success. This v2 patch is the same as v1( kernel https://lore.kernel.org/xen-devel/20230312120157.452859-6-ray.huang@amd.com/ and xen https://lore.kernel.org/xen-devel/20230312075455.450187-6-ray.huang@amd.com/)

About the v2 patch of qemu, just change an included head file, other are similar to the v1 ( qemu https://lore.kernel.org/xen-devel/20230312092244.451465-19-ray.huang@amd.com/), just call
xc_physdev_gsi_from_irq() to get gsi from irq.

Jiqian Chen (3):
  xen/pci: Add xen_reset_device_state function
  xen/pvh: Setup gsi for passthrough device
  xen/privcmd: Add new syscall to get gsi from irq

 arch/x86/include/asm/apic.h        |  8 +++
 arch/x86/include/asm/xen/pci.h     |  5 ++
 arch/x86/kernel/acpi/boot.c        |  2 +-
 arch/x86/pci/xen.c                 | 21 +++++++
 arch/x86/xen/enlighten_pvh.c       | 92 ++++++++++++++++++++++++++++++
 drivers/acpi/pci_irq.c             |  2 +-
 drivers/xen/events/events_base.c   | 39 +++++++++++++
 drivers/xen/pci.c                  | 12 ++++
 drivers/xen/privcmd.c              | 19 ++++++
 drivers/xen/xen-pciback/pci_stub.c | 26 ++++++++-
 include/linux/acpi.h               |  1 +
 include/uapi/xen/privcmd.h         |  7 +++
 include/xen/acpi.h                 |  6 ++
 include/xen/events.h               |  5 ++
 include/xen/interface/physdev.h    |  7 +++
 include/xen/pci.h                  |  6 ++
 16 files changed, 253 insertions(+), 5 deletions(-)

-- 
2.34.1


