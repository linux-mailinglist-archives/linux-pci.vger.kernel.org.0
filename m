Return-Path: <linux-pci+bounces-11672-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D21D951C53
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 15:55:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3EB61F2119D
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2024 13:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3857394;
	Wed, 14 Aug 2024 13:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="V0riqr0o"
X-Original-To: linux-pci@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2054.outbound.protection.outlook.com [40.107.92.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5E7C1B0126;
	Wed, 14 Aug 2024 13:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723643753; cv=fail; b=h62Tw3fg1e9svfZzuEoQxAHQzYsC22bzniBgQuV0fARNowp9oH++jvv3Os07Lf7BDg/S9BBcacKh4QIOe+V1CTY0maYjQRO+Xw+zQ+4nDP+Qh5HzEockTdyEaptigsKXxfAMdY9cLLyLKB1kMEgKFwvt9ck2zbBIqudnigE9f54=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723643753; c=relaxed/simple;
	bh=IMI4A/qtPF/JmD5/DOT/ZpNqJYieZ7fMYKERjVojYAs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=BuIhXgk3066afns9ALTaKel3i9UnsE7jvG+7gaE+AtPq8nrymJ6+2V9ZFg6Xd8swzKU+K6t4+uaySsWj1vByYnaoURuTCswJCmYUNS/OVR3fw3ZLIasx7G3tdJxmj27dRzHV8M+FWl3urStK1tdq84NAGcADfJHLuai7h/tteQ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=V0riqr0o; arc=fail smtp.client-ip=40.107.92.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aYwPliYAuiBbKyhObhKWnrctEHFLoI3LgGwghb06ZIXwnvjmr0zZgBmRU+PK+4ewmAPCia73YtkrFY+tK2O+HM3RlzdQ4c7GOTxZ6WSB6QzvLRNGUuzz8qxkmORXEYd7GXzcu2xcrC2JezWtfuB7nza3/+BhSkzwcizsgcfaERYxy9FKXr62kB7FY3UovblczTHqGNUBsaEbUUD4THorPNwFEK81tnGvJ70CeoBD7h9Xb4Fh6TX8W+Lpj6UuLk5TGjQXgtLutZr1dpVvZVbeXveMR9NF90R38llJs6spQ3pvF5x4vnB/8Ra7TZVJwsiumSM59jHFWWDMOBIc0lIMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9cRT9WbnPaUoi7cnReUQI+3dHtXKU/8A2cU8OT3LzXg=;
 b=hklbmUo9+TrIp5EtsuCENZWsQmWhBV2zAmhC7Zw1tDy+bIAZDK+IhLAz6w6SU6tDh0KJCW30sLoXHXM3xr6vlye0lElgiwVvp2ZMU7SFCx0GSqG43jik5fZ9XAxDp77JH0kNpxVxAqZ3eaIBKsfNqHFi7e1OlnPoMdJxBOGsWI0+8emHOum09l1OW899Ymrs7fKdbA31w62Hn3Rw3LltNACHzfdASzrCB3v68x7SHM7vvxGDQs6Zc+43l0/caWJ32xG62TrKL0I+3jz/yis9s4y1KjVnjz1kmHmYeg1iziS3qXCiLRxPNwIZhvPbznHnLM3KXUWASk1fsnNJI9nfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9cRT9WbnPaUoi7cnReUQI+3dHtXKU/8A2cU8OT3LzXg=;
 b=V0riqr0ogGixm3Iv2MyP0yywgZ6xFKmXsV3GfMloCVKa2AApkhy5jylcN33yz+AoRN+3ZF2gypv5n+NQP+7eKp+5d30Yzg/4r2FsKqyOTj29gzw2e6Q/v1NmXBCsK8F/mi9+YmrwmeGf5Pb1jO+Y4wYPk8D21BB3CzBhCf6WNOU=
Received: from BN9PR03CA0884.namprd03.prod.outlook.com (2603:10b6:408:13c::19)
 by SA1PR12MB7317.namprd12.prod.outlook.com (2603:10b6:806:2ba::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 14 Aug
 2024 13:55:48 +0000
Received: from BL02EPF00029928.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::24) by BN9PR03CA0884.outlook.office365.com
 (2603:10b6:408:13c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.33 via Frontend
 Transport; Wed, 14 Aug 2024 13:55:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00029928.mail.protection.outlook.com (10.167.249.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 14 Aug 2024 13:55:48 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 08:55:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 Aug
 2024 08:55:27 -0500
Received: from [172.23.60.101] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 14 Aug 2024 08:55:26 -0500
Message-ID: <88b86f1a-76e2-491f-bbd8-5d9332659d01@amd.com>
Date: Wed, 14 Aug 2024 09:55:26 -0400
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] PCI: Align small BARs
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?=
	<ilpo.jarvinen@linux.intel.com>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240808215329.GA155982@bhelgaas>
Content-Language: en-US
From: Stewart Hildebrand <stewart.hildebrand@amd.com>
In-Reply-To: <20240808215329.GA155982@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB05.amd.com: stewart.hildebrand@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00029928:EE_|SA1PR12MB7317:EE_
X-MS-Office365-Filtering-Correlation-Id: bc6372b4-57e0-4fce-1d1a-08dcbc68cd09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	KItojA+f+g0qSmuwsUHEz8KTOFt/2BMIpJIrN36hjQuROr+bp+QBheJVJ9pvDM3ES+NsRRSYSzZPx+Wup3PaiAWLxocHP2y7xXsO0KM+9YjYuIOIE7d4JIpC2FzvKrDlGC55uWbXc/Doxc6Th9NOEs3C3f059ETbiY9SqcgsB1NBYh2m/Ua4iEazyku+gZaQPvihGqKRIGqv/OldUQeh+6yfY3liQmcxSXkRcDV4m3DgMXVLspd2LGW8YLC5IAYg+UOGPPGM9nx+9JcXFC99INML5AbKKilMZyvd9jKDNY3WUo1KX0y1IPPHbKEVbqpZahbC8NhGvubAnz9qTew/WDQbcwesBOvUuXcZmt4MWvIF67nKdUH5oGHK56WDTs/3s3MIV3hW7ZAajFFqZm8DdduVWCPbfT7pU++g1eqXUNYJoYRyw++/7AwATUngztn6XXjUbQQPofQvJ1TvstDy4WOhlCzYbHSLa6lefxJ+ge/mJdpWxnnmT6ZPVVFPQT1ASwnxDjPYwQ2dwjKljgeRxg6k1ESz8NiD/llQsqOL9MY7aqQdHkT/FdDAZ3QzXYJ1LO4OszLeQ4s8vU9OGv+NVry9PRdEMLWCaXV8lrGz9E54nneAjnw2b7c0fcey76b7YShCFywxo7PEqCg4MMiSpsjDH7x7j+xcRXlTp1fihSahufMCDgNMPg1HnoVM1+YM9gPKTyCUax7wm2syaEGBYg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2024 13:55:48.1690
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc6372b4-57e0-4fce-1d1a-08dcbc68cd09
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF00029928.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7317

Hi Bjorn,

Thanks for the feedback!

On 8/8/24 17:53, Bjorn Helgaas wrote:
> On Wed, Aug 07, 2024 at 11:17:17AM -0400, Stewart Hildebrand wrote:
>> In this context, "small" is defined as less than max(SZ_4K, PAGE_SIZE).
>>
>> Issues observed when small BARs are not sufficiently aligned are:
>>
>> 1. Devices to be passed through (to e.g. a Xen HVM guest) with small
>> BARs require each memory BAR to be page aligned. Currently, the only way
>> to guarantee this alignment from a user perspective is to fake the size
>> of the BARs using the pci=resource_alignment= option. This is a bad user
>> experience, and faking the BAR size is not always desirable. For
>> example, pcitest is a tool that is useful for PCI passthrough validation
>> with Xen, but pcitest fails with a fake BAR size.
> 
> I guess this is the "money" patch for the main problem you're solving,
> i.e., passthrough to a guest doesn't work as you want?

Haha, yup!

> Is it the case that if you have two BARs in the same page, a device
> can't be passed through to a guest at all?

If the conditions are just right, passing through such a device could
maybe work, but in practice it's problematic and unlikely to work
reliably across different configurations.

Let me show example 1, from a real device that I'm working with.
Scrubbed/partial output from lspci -vv, from the host's point of view:

	Region 0: Memory at d1924600 (32-bit, non-prefetchable) [size=256]
	Region 1: Memory at d1924400 (32-bit, non-prefetchable) [size=512]
	Region 2: Memory at d1924000 (32-bit, non-prefetchable) [size=1K]
	Region 3: Memory at d1920000 (32-bit, non-prefetchable) [size=16K]
	Region 4: Memory at d1900000 (32-bit, non-prefetchable) [size=128K]
	Region 5: Memory at d1800000 (32-bit, non-prefetchable) [size=1M]
	Capabilities: [b0] MSI-X: Enable- Count=2 Masked-
		Vector table: BAR=0 offset=00000080
		PBA: BAR=0 offset=00000090
	Capabilities: [200 v1] Single Root I/O Virtualization (SR-IOV)
		IOVCap:	Migration-, Interrupt Message Number: 000
		IOVCtl:	Enable- Migration- Interrupt- MSE- ARIHierarchy+
		IOVSta:	Migration-
		Initial VFs: 4, Total VFs: 4, Number of VFs: 0, Function Dependency Link: 00
		VF offset: 6, stride: 1, Device ID: 0100
		Supported Page Size: 00000553, System Page Size: 00000001
		Region 0: Memory at 00000000d0800000 (64-bit, non-prefetchable)
		VF Migration: offset: 00000000, BIR: 0
	Kernel driver in use: pci-endpoint-test
	Kernel modules: pci_endpoint_test

BARs 0, 1, and 2 are small, and the host firmware placed them on the
same page. The host firmware did not page align the BARs.

The hypervisor can only map full pages. The hypervisor cannot map
partial pages. It cannot map a guest page offset from a host page where
the offset is smaller than PAGE_SIZE.

To pass this device through (physfn) as-is, the hypervisor would need to
preserve the page offsets of each BAR and propagate them to the guest,
taking translation into account. The guest (both firmware + OS)
necessarily has to preserve the offsets as well. If the page offsets
aren't preserved, the guest would be accessing the wrong data.

We can't reliably predict what the guest behavior will be.

SeaBIOS aligns BARs to 4k [1].

[1] https://review.coreboot.org/plugins/gitiles/seabios/+/refs/tags/rel-1.16.3/src/fw/pciinit.c#28

Xen's hvmloader does not align BARs to 4k. A patch was submitted to fix
this, but it wasn't merged upstream [2].

[2] https://lore.kernel.org/xen-devel/20200117110811.43321-1-roger.pau@citrix.com/

Arm guests don't usually have firmware to initialize BARs, so it's
usually up to the OS (which may or may not be Linux).

The point is that there is not a consistent BAR initialization
strategy/convention in the ecosystem when it comes to small BARs.

The host doesn't have a way to enforce the guest always map the small
BARs at the required offsets. IMO the most sensible thing to do is not
impose any sort of arbitrary page offset requirements on guests because
it happened to suit the host.

If the host were to use fake BAR sizes via the current
pci=resource_alignment=... option, the fake BAR size would propagate to
the guest (lying to the guest), pcitest would break, and the guest can't
do anything about it.

To avoid these problems, small BARs should be predictably page aligned
in both host and guest.

> Or is it just that all
> devices with BARs that share a page have to be passed through to the
> same guest, sort of like how lack of ACS can force several devices to
> be in the same IOMMU isolation group?

This case is much worse. If two devices have BARs sharing a page in a
passthrough scenario, it's a security issue because guest can access
data of another device. See XSA-461 / CVE-2024-31146 [3]. Aside: I was
unaware that there was a XSA/CVE associated with this until after the
embargo was lifted.

[3] https://lore.kernel.org/xen-devel/E1seE0f-0001zO-Nj@xenbits.xenproject.org/

For completeness, see example 2:

01:00.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe800000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c000 [size=256]
        Memory at 7050000000 (64-bit, prefetchable) [size=32]

01:01.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe801000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c100 [size=256]
        Memory at 7050000020 (64-bit, prefetchable) [size=32]

01:02.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe802000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c200 [size=256]
        Memory at 7050000040 (64-bit, prefetchable) [size=32]

01:03.0 Unclassified device [00ff]: Red Hat, Inc. QEMU PCI Test Device
        Subsystem: Red Hat, Inc. QEMU Virtual Machine
        Flags: fast devsel
        Memory at fe803000 (32-bit, non-prefetchable) [size=4K]
        I/O ports at c300 [size=256]
        Memory at 7040000000 (64-bit, prefetchable) [size=256M]

This example can reproduced with Qemu's pci-testdev and a SeaBIOS hack.
Add this to your usual qemu-system-x86_64 args:

    -device pcie-pci-bridge,id=pcie.1 \
    -device pci-testdev,bus=pcie.1,membar=32 \
    -device pci-testdev,bus=pcie.1,membar=32 \
    -device pci-testdev,bus=pcie.1,membar=32 \
    -device pci-testdev,bus=pcie.1,membar=268435456

Apply this SeaBIOS hack:

diff --git a/src/fw/pciinit.c b/src/fw/pciinit.c
index b3e359d7..769007a4 100644
--- a/src/fw/pciinit.c
+++ b/src/fw/pciinit.c
@@ -25,7 +25,7 @@
 #include "util.h" // pci_setup
 #include "x86.h" // outb

-#define PCI_DEVICE_MEM_MIN    (1<<12)  // 4k == page size
+#define PCI_DEVICE_MEM_MIN    (0)
 #define PCI_BRIDGE_MEM_MIN    (1<<21)  // 2M == hugepage size
 #define PCI_BRIDGE_IO_MIN      0x1000  // mandated by pci bridge spec


If you want to trigger the bridge window realloc (where BAR alignments
currently get lost), also apply this hack to SeaBIOS in the same file:

@@ -1089,6 +1089,7 @@ pci_region_map_one_entry(struct pci_region_entry *entry, u64 addr)
         pci_config_writew(bdf, PCI_MEMORY_LIMIT, limit >> PCI_MEMORY_SHIFT);
     }
     if (entry->type == PCI_REGION_TYPE_PREFMEM) {
+        limit = addr + PCI_BRIDGE_MEM_MIN - 1;
         pci_config_writew(bdf, PCI_PREF_MEMORY_BASE, addr >> PCI_PREF_MEMORY_SHIFT);
         pci_config_writew(bdf, PCI_PREF_MEMORY_LIMIT, limit >> PCI_PREF_MEMORY_SHIFT);
         pci_config_writel(bdf, PCI_PREF_BASE_UPPER32, addr >> 32);

> I think the subject should mention the problem to help motivate this.
> 
> The fact that we address this by potentially reassigning every BAR of
> every device, regardless of whether the admin even wants to pass
> through a device to a guest, seems a bit aggressive to me.

Patch [7/8] should limit the impact somewhat, but yes, it's quite
aggressive... Perhaps such a change in default should be paired with the
ability to turn it off via pci=realloc=off (or similar), and/or Kconfig.

> Previously we haven't trusted our reassignment machinery enough to
> enable it all the time, so we still have the "pci=realloc" parameter.
> By default, I don't think we even move devices around to make space
> for a BAR that we failed to allocate.

One exception is SR-IOV device resources when
CONFIG_PCI_REALLOC_ENABLE_AUTO=y.

> I agree "pci=resource_alignment=" is a bit user-unfriendly, and I
> don't think it solves the problem unless we apply it to every device
> in the system.

Right.

>> 2. Devices with multiple small BARs could have the MSI-X tables located
>> in one of its small BARs. This may lead to the MSI-X tables being mapped
>> in the same 4k region as other data. The PCIe 6.1 specification (section
>> 7.7.2 MSI-X Capability and Table Structure) says we probably should
>> avoid that.
> 
> If you're referring to this:
> 
>   If a Base Address Register or entry in the Enhanced Allocation
>   capability that maps address space for the MSI-X Table or MSI-X PBA
>   also maps other usable address space that is not associated with
>   MSI-X structures, locations (e.g., for CSRs) used in the other
>   address space must not share any naturally aligned 4-KB address
>   range with one where either MSI-X structure resides. This allows
>   system software where applicable to use different processor
>   attributes for MSI-X structures and the other address space.

Yes, that's the correct reference.

> I think this is technically a requirement about how space within a
> single BAR should be organized, not about how multiple BARs should be
> assigned.  I don't think this really adds to the case for what you're
> doing, so we could just drop it.

I'm OK to drop the reference to the spec. For completeness, example 1
above was what led me to mention it: This device has the MSI-X tables
located in BAR 0, which is mapped in the same 4k region as other data.

>> To improve the user experience (i.e. don't require the user to specify
>> pci=resource_alignment=), and increase conformance to PCIe spec, set the
>> default minimum resource alignment of memory BARs to the greater of 4k
>> or PAGE_SIZE.
>>
>> Quoting the comment in
>> drivers/pci/pci.c:pci_request_resource_alignment(), there are two ways
>> we can increase the resource alignment:
>>
>> 1) Increase the size of the resource.  BARs are aligned on their
>>    size, so when we reallocate space for this resource, we'll
>>    allocate it with the larger alignment.  This also prevents
>>    assignment of any other BARs inside the alignment region, so
>>    if we're requesting page alignment, this means no other BARs
>>    will share the page.
>>
>>    The disadvantage is that this makes the resource larger than
>>    the hardware BAR, which may break drivers that compute things
>>    based on the resource size, e.g., to find registers at a
>>    fixed offset before the end of the BAR.
>>
>> 2) Retain the resource size, but use IORESOURCE_STARTALIGN and
>>    set r->start to the desired alignment.  By itself this
>>    doesn't prevent other BARs being put inside the alignment
>>    region, but if we realign *every* resource of every device in
>>    the system, none of them will share an alignment region.
>>
>> Changing pcibios_default_alignment() results in the second method of
>> alignment with IORESOURCE_STARTALIGN.
>>
>> The new default alignment may be overridden by arches by implementing
>> pcibios_default_alignment(), or by the user on a per-device basis with
>> the pci=resource_alignment= option (although this reverts to using
>> IORESOURCE_SIZEALIGN).
>>
>> Signed-off-by: Stewart Hildebrand <stewart.hildebrand@amd.com>
>> ---
>> Preparatory patches in this series are prerequisites to this patch.
>>
>> v2->v3:
>> * new subject (was: "PCI: Align small (<4k) BARs")
>> * clarify 4k vs PAGE_SIZE in commit message
>>
>> v1->v2:
>> * capitalize subject text
>> * s/4 * 1024/SZ_4K/
>> * #include <linux/sizes.h>
>> * update commit message
>> * use max(SZ_4K, PAGE_SIZE) for alignment value
>> ---
>>  drivers/pci/pci.c | 8 +++++++-
>>  1 file changed, 7 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
>> index af34407f2fb9..efdd5b85ea8c 100644
>> --- a/drivers/pci/pci.c
>> +++ b/drivers/pci/pci.c
>> @@ -31,6 +31,7 @@
>>  #include <asm/dma.h>
>>  #include <linux/aer.h>
>>  #include <linux/bitfield.h>
>> +#include <linux/sizes.h>
>>  #include "pci.h"
>>  
>>  DEFINE_MUTEX(pci_slot_mutex);
>> @@ -6484,7 +6485,12 @@ struct pci_dev __weak *pci_real_dma_dev(struct pci_dev *dev)
>>  
>>  resource_size_t __weak pcibios_default_alignment(void)
>>  {
>> -	return 0;
>> +	/*
>> +	 * Avoid MSI-X tables being mapped in the same 4k region as other data
>> +	 * according to PCIe 6.1 specification section 7.7.2 MSI-X Capability
>> +	 * and Table Structure.
>> +	 */
> 
> I think this is sort of a "spec compliance" comment that is not the
> *real* reason we want to do this, i.e., it doesn't say that by doing
> this we can pass through more devices to guests.
> 
> Doing this in pcibios_default_alignment() ends up being a very
> non-obvious way to make this happen.  We have to:
> 
>   - Know what the purpose of this is, and the current comment doesn't
>     point to that.
> 
>   - Look at all the implementations of pcibios_default_alignment()
>     (thanks, powerpc).
> 
>   - Trace up through pci_specified_resource_alignment(), which
>     contains a bunch of code that is not relevant to this case and
>     always just returns PAGE_SIZE.
> 
>   - Trace up again to pci_reassigndev_resource_alignment() to see
>     where this finally applies to the resources we care about.  The
>     comment here about "check if specified PCI is target device" is
>     actively misleading for the passthrough usage.
> 
> I hate adding new kernel parameters, but I kind of think this would be
> easier if we added one that mentioned passthrough or guests and tested
> it directly in pci_reassigndev_resource_alignment().
> 
> This would also be a way to avoid the "Can't reassign resources to
> host bridge" warning that I think we're going to see all the time.

I did actually prepare a pci=resource_alignment=all patch, but I
hesitated to send it because of the discussion at [4]. I'll send it with
the next revision of the series.

[4] https://lore.kernel.org/linux-pci/20160929115422.GA31048@localhost/

I'd like to also propose introducing a Kconfig option, e.g.
CONFIG_PCI_PAGE_ALIGN_BARS, selectable by menuconfig or other usual
means.

>> +	return max(SZ_4K, PAGE_SIZE);
>>  }
>>  
>>  /*
>> -- 
>> 2.46.0
>>


