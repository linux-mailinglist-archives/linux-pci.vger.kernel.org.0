Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 669311BBE6A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 14:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726759AbgD1M7S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 08:59:18 -0400
Received: from mail-dm6nam12on2082.outbound.protection.outlook.com ([40.107.243.82]:10848
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726746AbgD1M7S (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Apr 2020 08:59:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PolgQ9rZdidVdOnkExu4mY8GyUiT2/LxOweVz3bwnIItzY8MOdY8NmEvbRhfzMzYGkzzVk8HAg6RqqvaRiDvwNF3BkU5ohP8Awb9ThEorm5uTkk81Wsl0i5QXEytI8Fr6/itKoBcciGyYL3Q8ngbObOr88VQJiucK5FoS3oCE7WclXbe+E2SaugI4i2ogRfEE7NQWNpgnyGA9LrplhZwy0UuaU6qdn7q0jXTqZ5whRq5IpvPDlsyGXCcvshpYkNt40ivHC8b+DT+YV5Sqt54VyaIte1Xrlu05vnO60kDEkPXsJL24UGVwU/CNocxC+EIfSzzeJGQ3ZQH+xDc+6L9tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1x0UhiqyyQ6OHvCo2JJSIDmFcTlAy4HCF6p5KYRE80=;
 b=ZpfuvGnjwsrvt/qcLpKd1CLIAwz9+HMfszETRpw6HSSuzustEud94NVzUNTwHRsqKHEqqBmtwQA/Sm7sBnQVDkyr0zTFbjrMT2g2B/a94hxph4fxgqTH+MOqIfaRSUndwS/ErNOyabqBBJAg/d7i6nOJRtkcPcaIBm/+RCz1k7uKnx2r9+wFc0cW/bZ9tW24VG6f6w/LD6cLBoUP1xGg3lWrjcYP62ZcUNXaJSgxfHpEVriJtygUNam56wuE6775p8k8VFoAponx2VqL2zMpVv4gZeSoZcOR7S6LRGbmxe5AoVLWLoUVmL3gzgT4Z4ADzmomFmUP1sBEkG1bkGyg7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R1x0UhiqyyQ6OHvCo2JJSIDmFcTlAy4HCF6p5KYRE80=;
 b=GyEsnsRpqqJbwhrKHo3EGRhO19wiEW06N0YgJCoOASVjTx2mFQsonMieX/UAMyRXL7hT4pByymvc1xDmHnCd07imY9IEmNHTtccE5j82ORPUdVXUuk2jKWXvKbwjitOwGukKFyioF1791KNPnsCf1gdMdHjciDfSyYZ/WTR3O4Q=
Authentication-Results: yadro.com; dkim=none (message not signed)
 header.d=none;yadro.com; dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4401.namprd12.prod.outlook.com (2603:10b6:5:2a9::15)
 by DM6PR12MB4403.namprd12.prod.outlook.com (2603:10b6:5:2ab::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.22; Tue, 28 Apr
 2020 12:59:12 +0000
Received: from DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766]) by DM6PR12MB4401.namprd12.prod.outlook.com
 ([fe80::7949:b580:a2d5:f766%3]) with mapi id 15.20.2937.026; Tue, 28 Apr 2020
 12:59:12 +0000
Subject: Re: [PATCH v8 00/24] PCI: Allow BAR movement during boot and hotplug
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>,
        linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Stefan Roese <sr@denx.de>, Andy Lavr <andy.lavr@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Rajat Jain <rajatja@google.com>, linux@yadro.com
References: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
From:   =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>
Message-ID: <7cd27165-0d30-0ef1-dde3-104c9878bd37@amd.com>
Date:   Tue, 28 Apr 2020 14:59:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
In-Reply-To: <20200427182358.2067702-1-s.miroshnichenko@yadro.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::17) To DM6PR12MB4401.namprd12.prod.outlook.com
 (2603:10b6:5:2a9::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2a02:908:1252:fb60:be8a:bd56:1f94:86e7] (2a02:908:1252:fb60:be8a:bd56:1f94:86e7) by AM0PR10CA0007.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::17) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2937.13 via Frontend Transport; Tue, 28 Apr 2020 12:59:10 +0000
X-Originating-IP: [2a02:908:1252:fb60:be8a:bd56:1f94:86e7]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 70915cae-a90b-4437-dad3-08d7eb73f2c1
X-MS-TrafficTypeDiagnostic: DM6PR12MB4403:
X-Microsoft-Antispam-PRVS: <DM6PR12MB440305A9324F813944BF4EB883AC0@DM6PR12MB4403.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-Forefront-PRVS: 0387D64A71
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4401.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(376002)(136003)(346002)(366004)(396003)(39860400002)(478600001)(7416002)(2616005)(66574012)(8676002)(6486002)(66946007)(31686004)(316002)(81156014)(66476007)(66556008)(86362001)(31696002)(54906003)(186003)(16526019)(30864003)(4326008)(5660300002)(8936002)(6666004)(2906002)(36756003)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5cQ9FbKWWc+cys6c3WM4aYa3mQSQ35og+4a4jOiNYlMDVrpedT+Qjbj9hcGOkpceNFqJnre9wwIb4CFSL7m29Vl3oWbx0y2A45Zw7NW760FIMbVv17GaynUjEBtstdqvnDb72AhvtSCgrfaNbB05adMtvQcL/b5QcpzcFG1qbkIrYodV8QdfAxugLrY9LHKaUBfPH3pRk7vatIZf65aBHcbfcv2yOW7YmozH4MGnHw/SLl27EnEV8WwrGPEUE2SzxxAlJi6TKK4EDzax+YGfiwWYuasPGLqWXGQ9TohPioTTYMugjZczHYJqQWoaVr3XTl0GUpDM9gZ3O+oFUJZX9G2SdLYbqye2nwyJ+7zQAOnXXXMFEwGUaielPGGMQTBzifF2BNGGR598QAfRZWzELe2WfKzu7qdFrzLwHVdAHLRHBsUxXr8JnNUgIRU+cmsQ
X-MS-Exchange-AntiSpam-MessageData: YuOkci2agSBYkqBHVauovQgVNzykzYuNUl+4NO1BEG0eM+5I0hsbFpq03KK8oj2/9oRbmVFvszs1cl0VBBa4v6Vb535e6nWPc2ly6KDwXYvcjYJZXrrFrC6weI3sNhOPM10f3ztl7DifZ6pIAcdP2oo6MjpxIBdzEq382+ceYStQOJjYJUPJgc7FWuKEqze+XVpEl+Nn0/8gt01ljyB5ptuaJ2LN1s0ASX5kitKu8FJ/6ceHHk3oTX3AhKSfK0qvnNebtGkVfYyLBCDGyDxM+WmMrrBUVlP1hCdlS2oaJmkKKTWwNAw9OeOGp1Nk2iyu4EUNGSZYbJCTbBZqoqSwvSot+WcMOH4MZGzFJF033p5+5LMF+YE1oJ86/HUdxGlvcrcknCTm7XzsyQ0T9iCfAXKKmgqOY4yhbpMds4bHWYN/I4HOrVoKmnMrOIv5pGbe9UOa021MARHYQA0GNC3RmrF/UWWqioysth4TtahmEgDR12CD7gT/8rWiPu6/6MGB0kojeoYNnGEuJ7moHZ5sUaYQvtEapT/du2fxsvDV55kfkyLUxRvGZrvrnrHCuApvXDrNXwRatcUd39jBY2xZyIqbjlN9OraHEJO6AuDVMKjGjyEXAebr0R+Zc9u/PXKBdGxyCxgYaDfW6vH+N8raAIEI1EGUxPs7tr9fKbw1R8hnpXprCRlaqAX1oMjy1RVYRF80L6hPwl90qQQWNRuOHlT46QwKPnzPuteB2CpxLGo3xkWXjmALpybM29kykhMCoK044ysOlth6g2MgAbXO8vXtL4Khe7B9TCW0bNjagKVxd6IsGe6YmTJFA9TVxOuZOM+HoSooIsDXkoIVWts5qPdKFw8P3wQNC37KtVdSS9s=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 70915cae-a90b-4437-dad3-08d7eb73f2c1
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2020 12:59:12.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I5dl4KtHG9H1vqFKOGQJqp2y9A3lpWi1LRYWRlXH9aBU1n2tby+nUfQz0DbqBeMz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4403
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Well that is a really nice surprise. Just FYI the situation with GPUs is 
essentially this:

a) The BAR to access video memory with the CPU is by default only 256MB 
in size for backward compatibility with 32bit Windows 7 and older.

b) Modern GPUs easily have 16GB of video memory, but most of that used 
to be accessed only rarely by the CPU. Unfortunately this has changed 
recently by getting more modern graphics APIs in userspace (Vulkan).

c) Both NVidia as well as AMD used to have a mechanism to map different 
stuff into the 256MB window, but AMD dropped this ability quite some 
time ago because it was rather inefficient.

d) Instead for hard of the last 5 years AMD implements the PCI standard 
for dynamic BAR resizing. So what we do is to extend the 256MB BAR into 
16GB (or whatever is needed) once the OS is started and the driver loads.

The problem with this approach is that sometimes bridges can't be 
reconfigured and BARs resized because we have other BARs currently in 
use under the same bridge.

So long story short you have fixed my BAR resizing problem with this 
patchset as well :D

Am 27.04.20 um 20:23 schrieb Sergei Miroshnichenko:
> Currently PCI hotplug works on top of resources which are usually reserved
> not by the kernel, but by BIOS, bootloader, firmware, etc. These resources
> are gaps in the address space where BARs of new devices may fit, and extra
> bus number per port, so bridges can be hot-added. This series aim the BARs
> problem: it shows the kernel how to redistribute them on the run, so the
> hotplug becomes predictable and cross-platform. A follow-up patchset will
> propose a solution for bus numbers.
>
> To arrange a space for BARs of new hotplugged devices, the kernel can pause
> the drivers of working PCI devices and reshuffle the assigned BARs. When a
> driver is un-paused by the kernel, it should ioremap() the new addresses of
> its BARs.
>
> Drivers indicate their support of the feature by implementing the new hooks
> .rescan_prepare() and .rescan_done() in the struct pci_driver. If a driver
> doesn't yet support the feature, BARs of its devices will be considered as
> immovable and handled in the same way as resources with the PCI_FIXED flag:
> they are guaranteed to remain untouched.

Could we let rescan_prepare() optionally return an error and then 
consider the BARs in question not movable for the current rescan? 
Alternatively would it be allowed in the implementation of the 
rescan_prepare() callback to update the PCI_FIXED flags on the BARs?

Problem is that we can't know beforehand if a BAR is currently in use or 
not or if we can block the uses until the rescan is completed.

Additional to that I'm not an expert on the PCI code outside of the 
stuff that I wrote/touched. Still trying to go over the set in the next 
couple of days, but don't expect more than an Acked-by from me.

Cheers,
Christian.

>
> Tested on a number of x86_64 machines without any special kernel command
> line arguments:
>   - PC: i7-5930K + ASUS X99-A;
>   - PC: i5-8500 + ASUS Z370-F;
>   - Supermicro Super Server/H11SSL-i: AMD EPYC 7251;
>   - HP ProLiant DL380 G5: Xeon X5460;
>   - Dell Inspiron N5010: i5 M 480;
>   - Dell Precision M6600: i7-2920XM.
>
> Also tested on a Power8 (Vesnin) and Power9 (Nicole) ppc64le machines, but
> with extra patchset, its next version is to be sent upstream a bit later.
>
> First two patches of this series are independent bugfixes, both are not
> related directly to the movable BARs feature, but without them the rest of
> this series will not work as expected.
>
> Patches 03-15 implement the essentials of the feature.
>
> Patches 16-21 are performance improvements for movable BARs and pciehp.
>
> Patch 22 enables the feature by default.
>
> Patches 23-24 add movable BARs support to nvme and portdrv.
>
> This patchset is a part of our work on adding support for hotplugging
> chains of chassis full of other bridges, NVME drives, SAS HBAs, GPUs, etc.
> without special requirements such as Hot-Plug Controller, reservation of
> bus numbers or memory regions by firmware, etc.
>
> Added Stefan Roese and Andy Lavr to CC, thank you for trying this on your
> hardware!
>
> Added Christian König and Ard Biesheuvel to CC, because of the recent
> "PCI: allow pci_resize_resource() to be used on devices on the root bus"
> thread, which covers a similar problem.
>
> Changes since v7:
>   - Added some documentation;
>   - Replaced every occurrence of the word "immovable" with "fixed";
>   - Don't touch PNP, ACPI resources anymore;
>   - Replaced double rescan with triple rescan:
>     * first try every BAR;
>     * if that failed, retry without BARs which weren't assigned before;
>     * if that failed, retry without BARs of hotplugged devices;
>   - Reassign BARs during boot only if BIOS assigned not all requested BARs;
>   - Fixed up PCIBIOS_MIN_MEM instead of ignoring it;
>   - Now the feature auto-disables in presence of a transparent bridge;
>   - Improved support of runtime PM;
>   - Fixed issues with incorrectly released bridge windows;
>   - Fixed calculating bridge window size.
>   
> Changes since v6:
>   - Added a fix for hotplug on AMD Epyc + Supermicro H11SSL-i by ignoring
>     PCIBIOS_MIN_MEM;
>   - Fixed a workaround which marks VGA BARs as immovables;
>   - Fixed misleading "can't claim BAR ... no compatible bridge window" error
>     messages;
>   - Refactored the code, reduced the amount of patches;
>   - Exclude PowerPC-specific arch patches, they will be sent separately;
>   - Disabled for PowerNV by default - waiting for the PCIPOCALYPSE patchset.
>   - Fixed reports from the kbuild test robot.
>
> Changes since v5:
>   - Simplified the disable flag, now it is "pci=no_movable_buses";
>   - More deliberate marking the BARs as immovable;
>   - Mark as immovable BARs which are used by unbound drivers;
>   - Ignoring BAR assignment by non-kernel program components, so the kernel
>     is able now to distribute BARs in optimal and predictable way;
>   - Move here PowerNV-specific patches from the older "powerpc/powernv/pci:
>     Make hotplug self-sufficient, independent of FW and DT" series;
>   - Fix EEH cache rebuilding and PE allocation for PowerNV during rescan.
>
> Changes since v4:
>   - Feature is enabled by default (turned on by one of the latest patches);
>   - Add pci_dev_movable_bars_supported(dev) instead of marking the immovable
>     BARs with the IORESOURCE_PCI_FIXED flag;
>   - Set up PCIe bridges during rescan via sysfs, so MPS settings are now
>     configured not only during system boot or pcihp events;
>   - Allow movement of switch's BARs if claimed by portdrv;
>   - Update EEH address caches after rescan for powerpc;
>   - Don't disable completely hot-added devices which can't have BARs being
>     fit - just disable their BARs, so they are still visible in lspci etc;
>   - Clearer names: fixed_range_hard -> immovable_range, fixed_range_soft ->
>     realloc_range;
>   - Drop the patch for pci_restore_config_space() - fixed by properly using
>     the runtime PM.
>
> Changes since v3:
>   - Rebased to the upstream, so the patches apply cleanly again.
>
> Changes since v2:
>   - Fixed double-assignment of bridge windows;
>   - Fixed assignment of fixed prefetched resources;
>   - Fixed releasing of fixed resources;
>   - Fixed a debug message;
>   - Removed auto-enabling the movable BARs for x86 - let's rely on the
>     "pcie_movable_bars=force" option for now;
>   - Reordered the patches - bugfixes first.
>
> Changes since v1:
>   - Add a "pcie_movable_bars={ off | force }" command line argument;
>   - Handle the IORESOURCE_PCI_FIXED flag properly;
>   - Don't move BARs of devices which don't support the feature;
>   - Guarantee that new hotplugged devices will not steal memory from working
>     devices by ignoring the failing new devices with the new PCI_DEV_IGNORE
>     flag;
>   - Add rescan_prepare()+rescan_done() to the struct pci_driver instead of
>     using the reset_prepare()+reset_done() from struct pci_error_handlers;
>   - Add a bugfix of a race condition;
>   - Fixed hotplug in a non-pre-enabled (by BIOS/firmware) bridge;
>   - Fix the compatibility of the feature with pm_runtime and D3-state;
>   - Hotplug events from pciehp also can move BARs;
>   - Add support of the feature to the NVME driver.
>
> Sergei Miroshnichenko (24):
>    PCI: Fix race condition in pci_enable/disable_device()
>    PCI: Ensure a bridge has I/O and MEM access for hot-added devices
>    PCI: hotplug: Initial support of the movable BARs feature
>    PCI: Add version of release_child_resources() aware of fixed BARs
>    PCI: hotplug: Fix reassigning the released BARs
>    PCI: hotplug: Recalculate every bridge window during rescan
>    PCI: hotplug: Don't allow hot-added devices to steal resources
>    PCI: Reassign BARs if BIOS/bootloader had assigned not all of them
>    PCI: hotplug: Try to reassign movable BARs only once
>    PCI: hotplug: Calculate fixed parts of bridge windows
>    PCI: Include fixed BARs into the bus size calculating
>    PCI: hotplug: movable BARs: Compute limits for relocated bridge
>      windows
>    PCI: Make sure bridge windows include their fixed BARs
>    PCI: hotplug: Add support of fixed BARs to pci_assign_resource()
>    PCI: hotplug: Sort fixed BARs before assignment
>    x86/PCI/ACPI: Fix up PCIBIOS_MIN_MEM if value computed from e820 is
>      invalid
>    PCI: hotplug: Configure MPS after manual bus rescan
>    PCI: hotplug: Don't disable the released bridge windows immediately
>    PCI: pciehp: Trigger a domain rescan on hp events when enabled movable
>      BARs
>    PCI: Don't claim fixed BARs
>    PCI: hotplug: Don't reserve bus space when enabled movable BARs
>    PCI: hotplug: Enable the movable BARs feature by default
>    PCI/portdrv: Declare support of movable BARs
>    nvme-pci: Handle movable BARs
>
>   Documentation/PCI/pci.rst                     |  55 +++
>   .../admin-guide/kernel-parameters.txt         |   1 +
>   arch/powerpc/platforms/powernv/pci.c          |   2 +
>   arch/powerpc/platforms/pseries/setup.c        |   2 +
>   arch/x86/pci/acpi.c                           |  15 +
>   drivers/nvme/host/pci.c                       |  21 +-
>   drivers/pci/bus.c                             |   2 +-
>   drivers/pci/hotplug/pciehp_pci.c              |   5 +
>   drivers/pci/iov.c                             |   2 +
>   drivers/pci/pci.c                             |  33 +-
>   drivers/pci/pci.h                             |  33 ++
>   drivers/pci/pcie/portdrv_pci.c                |  11 +
>   drivers/pci/probe.c                           | 399 +++++++++++++++++-
>   drivers/pci/setup-bus.c                       | 301 ++++++++++---
>   drivers/pci/setup-res.c                       |  75 +++-
>   include/linux/pci.h                           |  20 +
>   16 files changed, 905 insertions(+), 72 deletions(-)
>
>
> base-commit: 6a8b55ed4056ea5559ebe4f6a4b247f627870d4c

