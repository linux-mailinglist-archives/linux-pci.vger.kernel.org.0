Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9DB219F61C
	for <lists+linux-pci@lfdr.de>; Mon,  6 Apr 2020 14:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728061AbgDFMwo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Apr 2020 08:52:44 -0400
Received: from foss.arm.com ([217.140.110.172]:45338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728055AbgDFMwo (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Apr 2020 08:52:44 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E373531B;
        Mon,  6 Apr 2020 05:52:43 -0700 (PDT)
Received: from [10.57.55.221] (unknown [10.57.55.221])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 42E563F52E;
        Mon,  6 Apr 2020 05:52:42 -0700 (PDT)
Subject: Re: [BUG] PCI: rockchip: rk3399: pcie switch support
To:     Soeren Moch <smoch@web.de>, Shawn Lin <shawn.lin@rock-chips.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <4d03dd8c-14f9-d1ef-6fd2-095423be3dd3@web.de>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <3e9d2c53-4f0d-0c97-fbfa-6d799e223747@arm.com>
Date:   Mon, 6 Apr 2020 13:52:36 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <4d03dd8c-14f9-d1ef-6fd2-095423be3dd3@web.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020-04-04 7:41 pm, Soeren Moch wrote:
> I want to use a PCIe switch on a RK3399 based RockPro64 V2.1 board.
> "Normal" PCIe cards work (mostly) just fine on this board. The PCIe
> switches (I tried Pericom and ASMedia based switches) also work fine on
> other boards. The RK3399 PCIe controller with pcie_rockchip_host driver
> also recognises the switch, but fails to initialize the buses behind the
> bridge properly, see syslog from linux-5.6.0.
> 
> Any ideas what I do wrong, or any suggestions what I can test here?

See the thread here:

https://lore.kernel.org/linux-pci/CAMdYzYoTwjKz4EN8PtD5pZfu3+SX+68JL+dfvmCrSnLL=K6Few@mail.gmail.com/

The conclusion there seems to be that the RK3399 root complex just 
doesn't handle certain types of response in a sensible manner, and 
there's not much that can reasonably be done to change that.

Robin.

> 
> Thanks,
> Soeren
> 
> 
> Apr  4 19:50:38 rockpro64 kernel: [   74.501951] rockchip-pcie
> f8000000.pcie: f8000000.pcie supply vpcie1v8 not found, using dummy
> regulator
> Apr  4 19:50:38 rockpro64 kernel: [   74.502906] rockchip-pcie
> f8000000.pcie: f8000000.pcie supply vpcie0v9 not found, using dummy
> regulator
> Apr  4 19:50:38 rockpro64 kernel: [   74.572050] rockchip-pcie
> f8000000.pcie: host bridge /pcie@f8000000 ranges:
> Apr  4 19:50:38 rockpro64 kernel: [   74.573018] rockchip-pcie
> f8000000.pcie: Parsing ranges property...
> Apr  4 19:50:38 rockpro64 kernel: [   74.573040] rockchip-pcie
> f8000000.pcie:      MEM 0x00fa000000..0x00fbdfffff -> 0x00fa000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.574080] rockchip-pcie
> f8000000.pcie:       IO 0x00fbe00000..0x00fbefffff -> 0x00fbe00000
> Apr  4 19:50:38 rockpro64 kernel: [   74.575420] rockchip-pcie
> f8000000.pcie: PCI host bridge to bus 0000:00
> Apr  4 19:50:38 rockpro64 kernel: [   74.576247] pci_bus 0000:00: root
> bus resource [bus 00-1f]
> Apr  4 19:50:38 rockpro64 kernel: [   74.576930] pci_bus 0000:00: root
> bus resource [mem 0xfa000000-0xfbdfffff]
> Apr  4 19:50:38 rockpro64 kernel: [   74.577739] pci_bus 0000:00: root
> bus resource [io  0x0000-0xfffff] (bus address [0xfbe00000-0xfbefffff])
> Apr  4 19:50:38 rockpro64 kernel: [   74.578876] pci_bus 0000:00:
> scanning bus
> Apr  4 19:50:38 rockpro64 kernel: [   74.578918] pci 0000:00:00.0:
> [1d87:0100] type 01 class 0x060400
> Apr  4 19:50:38 rockpro64 kernel: [   74.579734] pci 0000:00:00.0:
> supports D1
> Apr  4 19:50:38 rockpro64 kernel: [   74.580252] pci 0000:00:00.0: PME#
> supported from D0 D1 D3hot
> Apr  4 19:50:38 rockpro64 kernel: [   74.580952] pci 0000:00:00.0: PME#
> disabled
> Apr  4 19:50:38 rockpro64 kernel: [   74.585475] pci_bus 0000:00: fixups
> for bus
> Apr  4 19:50:38 rockpro64 kernel: [   74.585491] pci 0000:00:00.0:
> scanning [bus 00-00] behind bridge, pass 0
> Apr  4 19:50:38 rockpro64 kernel: [   74.585497] pci 0000:00:00.0:
> bridge configuration invalid ([bus 00-00]), reconfiguring
> Apr  4 19:50:38 rockpro64 kernel: [   74.586562] pci 0000:00:00.0:
> scanning [bus 00-00] behind bridge, pass 1
> Apr  4 19:50:38 rockpro64 kernel: [   74.586725] pci_bus 0000:01:
> scanning bus
> Apr  4 19:50:38 rockpro64 kernel: [   74.586792] pci 0000:01:00.0:
> [1b21:1182] type 01 class 0x060400
> Apr  4 19:50:38 rockpro64 kernel: [   74.587785] pci 0000:01:00.0: Max
> Payload Size set to 256 (was 128, max 256)
> Apr  4 19:50:38 rockpro64 kernel: [   74.588625] pci 0000:01:00.0:
> enabling Extended Tags
> Apr  4 19:50:38 rockpro64 kernel: [   74.589487] pci 0000:01:00.0: PME#
> supported from D0 D3hot D3cold
> Apr  4 19:50:38 rockpro64 kernel: [   74.590199] pci 0000:01:00.0: PME#
> disabled
> Apr  4 19:50:38 rockpro64 kernel: [   74.590344] pci 0000:01:00.0: 2.000
> Gb/s available PCIe bandwidth, limited by 2.5 GT/s x1 link at
> 0000:00:00.0 (capable of 4.000 Gb/s with 5 GT/s x1 link)
> Apr  4 19:50:38 rockpro64 kernel: [   74.598206] pci_bus 0000:01: fixups
> for bus
> Apr  4 19:50:38 rockpro64 kernel: [   74.598226] pci 0000:01:00.0:
> scanning [bus 00-00] behind bridge, pass 0
> Apr  4 19:50:38 rockpro64 kernel: [   74.598231] pci 0000:01:00.0:
> bridge configuration invalid ([bus 00-00]), reconfiguring
> Apr  4 19:50:38 rockpro64 kernel: [   74.599163] pci 0000:01:00.0:
> scanning [bus 00-00] behind bridge, pass 1
> Apr  4 19:50:38 rockpro64 kernel: [   74.599443] pci_bus 0000:02:
> scanning bus
> Apr  4 19:50:38 rockpro64 kernel: [   74.599460] Internal error:
> synchronous external abort: 96000210 [#1] PREEMPT SMP
> Apr  4 19:50:38 rockpro64 kernel: [   74.600271] Modules linked in:
> pcie_rockchip_host(+) brcmfmac brcmutil
> Apr  4 19:50:38 rockpro64 kernel: [   74.600978] CPU: 3 PID: 565 Comm:
> modprobe Not tainted 5.6.0 #1
> Apr  4 19:50:38 rockpro64 kernel: [   74.601607] Hardware name: Pine64
> RockPro64 v2.1 (DT)
> Apr  4 19:50:38 rockpro64 kernel: [   74.602147] pstate: 60000085 (nZCv
> daIf -PAN -UAO)
> Apr  4 19:50:38 rockpro64 kernel: [   74.602666] pc :
> rockchip_pcie_rd_conf+0x120/0x228 [pcie_rockchip_host]
> Apr  4 19:50:38 rockpro64 kernel: [   74.603373] lr :
> rockchip_pcie_rd_conf+0x94/0x228 [pcie_rockchip_host]
> Apr  4 19:50:38 rockpro64 kernel: [   74.604064] sp : ffffffc011003500
> Apr  4 19:50:38 rockpro64 kernel: [   74.604419] x29: ffffffc011003500
> x28: 0000000000000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.604986] x27: 0000000000000001
> x26: 0000000000000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.605552] x25: 0000000000000000
> x24: ffffffc011003644
> Apr  4 19:50:38 rockpro64 kernel: [   74.606117] x23: ffffff80f1792000
> x22: ffffffc011003584
> Apr  4 19:50:38 rockpro64 kernel: [   74.606683] x21: ffffff80e98313c0
> x20: 0000000000000004
> Apr  4 19:50:38 rockpro64 kernel: [   74.607249] x19: ffffffc012200000
> x18: 00000000fffffff0
> Apr  4 19:50:38 rockpro64 kernel: [   74.607815] x17: 0000000000000000
> x16: 0000000000000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.608381] x15: ffffffc010b77c00
> x14: ffffffc010be2e28
> Apr  4 19:50:38 rockpro64 kernel: [   74.608947] x13: 0000000000000000
> x12: ffffffc010be2000
> Apr  4 19:50:38 rockpro64 kernel: [   74.609512] x11: ffffffc010b77000
> x10: ffffffc010be2470
> Apr  4 19:50:38 rockpro64 kernel: [   74.610079] x9 : 0000000011821b21
> x8 : 0000000000000001
> Apr  4 19:50:38 rockpro64 kernel: [   74.615455] x7 : 0000000000000000
> x6 : 0000000000000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.621487] x5 : 0000000000200000
> x4 : 0000000000000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.627519] x3 : 0000000000c00008
> x2 : 000000000080000b
> Apr  4 19:50:38 rockpro64 kernel: [   74.633551] x1 : ffffffc015c00008
> x0 : ffffffc012000000
> Apr  4 19:50:38 rockpro64 kernel: [   74.639583] Call trace:
> Apr  4 19:50:38 rockpro64 kernel: [   74.645785]
> rockchip_pcie_rd_conf+0x120/0x228 [pcie_rockchip_host]
> Apr  4 19:50:38 rockpro64 kernel: [   74.656354]
> pci_bus_read_config_dword+0x80/0xd0
> Apr  4 19:50:38 rockpro64 kernel: [   74.665083]
> pci_bus_generic_read_dev_vendor_id+0x30/0x1a8
> Apr  4 19:50:38 rockpro64 kernel: [   74.674722]
> pci_bus_read_dev_vendor_id+0x48/0x68
> Apr  4 19:50:38 rockpro64 kernel: [   74.683382]
> pci_scan_single_device+0x7c/0xd8
> Apr  4 19:50:38 rockpro64 kernel: [   74.691690]  pci_scan_slot+0x34/0x118
> Apr  4 19:50:38 rockpro64 kernel: [   74.699155]
> pci_scan_child_bus_extend+0x60/0x2cc
> Apr  4 19:50:38 rockpro64 kernel: [   74.707774]
> pci_scan_bridge_extend+0x340/0x578
> Apr  4 19:50:38 rockpro64 kernel: [   74.716224]
> pci_scan_child_bus_extend+0x20c/0x2cc
> Apr  4 19:50:38 rockpro64 kernel: [   74.724943]
> pci_scan_bridge_extend+0x340/0x578
> Apr  4 19:50:38 rockpro64 kernel: [   74.733320]
> pci_scan_child_bus_extend+0x20c/0x2cc
> Apr  4 19:50:38 rockpro64 kernel: [   74.741998]
> pci_scan_child_bus+0x10/0x18
> Apr  4 19:50:38 rockpro64 kernel: [   74.749739]
> pci_scan_root_bus_bridge+0x78/0xd0
> Apr  4 19:50:38 rockpro64 kernel: [   74.757988]
> rockchip_pcie_probe+0x830/0xb90 [pcie_rockchip_host]
> Apr  4 19:50:38 rockpro64 kernel: [   74.768042]
> platform_drv_probe+0x50/0xa0
> Apr  4 19:50:38 rockpro64 kernel: [   74.775758]  really_probe+0xd8/0x300
> Apr  4 19:50:38 rockpro64 kernel: [   74.782939]
> driver_probe_device+0x54/0xe8
> Apr  4 19:50:38 rockpro64 kernel: [   74.790661]
> device_driver_attach+0x6c/0x78
> Apr  4 19:50:38 rockpro64 kernel: [   74.798461]  __driver_attach+0x54/0xd0
> Apr  4 19:50:38 rockpro64 kernel: [   74.805744]  bus_for_each_dev+0x70/0xc0
> Apr  4 19:50:38 rockpro64 kernel: [   74.813119]  driver_attach+0x20/0x28
> Apr  4 19:50:38 rockpro64 kernel: [   74.820101]  bus_add_driver+0x178/0x1d8
> Apr  4 19:50:38 rockpro64 kernel: [   74.827249]  driver_register+0x60/0x110
> Apr  4 19:50:38 rockpro64 kernel: [   74.834308]
> __platform_driver_register+0x44/0x50
> Apr  4 19:50:38 rockpro64 kernel: [   74.842299]
> rockchip_pcie_driver_init+0x20/0x1000 [pcie_rockchip_host]
> Apr  4 19:50:38 rockpro64 kernel: [   74.852443]  do_one_initcall+0x74/0x1a8
> Apr  4 19:50:38 rockpro64 kernel: [   74.859430]  do_init_module+0x50/0x1f0
> Apr  4 19:50:38 rockpro64 kernel: [   74.866276]  load_module+0x1c0c/0x2158
> Apr  4 19:50:38 rockpro64 kernel: [   74.873100]
> __do_sys_finit_module+0xd0/0xe8
> Apr  4 19:50:38 rockpro64 kernel: [   74.880480]
> __arm64_sys_finit_module+0x1c/0x28
> Apr  4 19:50:38 rockpro64 kernel: [   74.888157]
> el0_svc_common.constprop.1+0x7c/0xe8
> Apr  4 19:50:38 rockpro64 kernel: [   74.896000]  do_el0_svc+0x18/0x20
> Apr  4 19:50:38 rockpro64 kernel: [   74.902285]
> el0_sync_handler+0x12c/0x1b0
> Apr  4 19:50:38 rockpro64 kernel: [   74.909380]  el0_sync+0x114/0x140
> Apr  4 19:50:38 rockpro64 kernel: [   74.915692] Code: a8c37bfd d65f03c0
> f94002a0 8b130013 (b9400273)
> Apr  4 19:50:38 rockpro64 kernel: [   74.925210] ---[ end trace
> 181d7993f92f3f3d ]---
> 
