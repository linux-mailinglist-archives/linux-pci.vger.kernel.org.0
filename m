Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48276C234C
	for <lists+linux-pci@lfdr.de>; Mon, 20 Mar 2023 22:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjCTU7t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Mar 2023 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjCTU7s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Mar 2023 16:59:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0870334026;
        Mon, 20 Mar 2023 13:59:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 460426182E;
        Mon, 20 Mar 2023 20:59:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44D52C433EF;
        Mon, 20 Mar 2023 20:59:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679345979;
        bh=RSEgHvtt3CggVhM3Oq6w2XSZQEHDdD+8wzZxlP4dmH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WmMyNozfbwl692K876/r+x8HJJghuCPAqMJAzA917D2JHSjKUuBiIv4VYUEGZpQ/C
         8W2Ss49KTE8Wl3SO/fu2kydd2TMAAb2rcCZOPxN390DR0dRi2Tjhi8xrc19iocHBW/
         WbltPF631voPaw21dowIfWe17TA6JOKYusqtf7fOucDpam0s5RTE5OTsunGioJpD8a
         F3dIZvBTTLFJIqgyDORiLFQMQwMF3rH0x8jAodHjlFqr0ty7kdDGbIxupY0OJSYJWM
         zlj/64QY1yMrIuN+J/WXF0bQNiAzM06v/TcGatfuWPIhgUbvR97zzKCBU5EN0WDqiz
         CmPSOmKNSRAJg==
Received: by pali.im (Postfix)
        id 350C260F; Mon, 20 Mar 2023 21:59:36 +0100 (CET)
Date:   Mon, 20 Mar 2023 21:59:36 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Jon Hunter <jonathanh@nvidia.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Marek =?utf-8?B?QmVow7pu?= <marek.behun@nic.cz>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Assign PCI domain by ida_alloc()
Message-ID: <20230320205936.wd6pj3trljsduj5c@pali>
References: <20220702204737.7719-1-pali@kernel.org>
 <20220714184130.5436-1-pali@kernel.org>
 <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b529cb69-0602-9eed-fc02-2f068707a006@nvidia.com>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

On Monday 20 March 2023 20:26:05 Jon Hunter wrote:
> Hi Pali,
> 
> After this change was made we are seeing the following bug
> report on a Tegra234 Jetson Orin board ...
> 
> [   17.172346] tegra194-pcie 141a0000.pcie: host bridge /pcie@141a0000 ranges:
> [   17.172470] tegra194-pcie 141a0000.pcie:      MEM 0x2800000000..0x2b27ffffff -> 0x2800000000
> [   17.172519] tegra194-pcie 141a0000.pcie:      MEM 0x2b28000000..0x2b2fffffff -> 0x0040000000
> [   17.172548] tegra194-pcie 141a0000.pcie:       IO 0x003a100000..0x003a1fffff -> 0x003a100000
> [   17.173449] tegra194-pcie 141a0000.pcie: iATU: unroll T, 8 ob, 2 ib, align 64K, limit 32G
> [   18.279048] tegra194-pcie 141a0000.pcie: Phy link never came up
> [   19.279285] tegra194-pcie 141a0000.pcie: Phy link never came up
> [   19.279599] tegra194-pcie 141a0000.pcie: PCI host bridge to bus 0005:00
> [   19.279613] pci_bus 0005:00: root bus resource [bus 00-ff]
> [   19.279622] pci_bus 0005:00: root bus resource [mem 0x2800000000-0x2b27ffffff pref]
> [   19.279631] pci_bus 0005:00: root bus resource [mem 0x2b28000000-0x2b2fffffff] (bus address [0x40000000-0x47ffffff])
> [   19.279639] pci_bus 0005:00: root bus resource [io  0x200000-0x2fffff] (bus address [0x3a100000-0x3a1fffff])
> [   19.279687] pci 0005:00:00.0: [10de:229a] type 01 class 0x060400
> [   19.279886] pci 0005:00:00.0: PME# supported from D0 D3hot
> [   19.283256] pci 0005:00:00.0: PCI bridge to [bus 01-ff]
> [   19.283590] pcieport 0005:00:00.0: Adding to iommu group 26
> [   19.283991] pcieport 0005:00:00.0: PME: Signaling with IRQ 174
> [   19.284429] pcieport 0005:00:00.0: AER: enabled with IRQ 174
> [   19.285003] pci_bus 0005:01: busn_res: [bus 01-ff] is released
> [   19.285591] pci 0005:00:00.0: Removing from iommu group 26
> [   19.285751] pci_bus 0005:00: busn_res: [bus 00-ff] is released
> [   19.285870] ==================================================================
> [   19.293351] BUG: KFENCE: use-after-free read in pci_bus_release_domain_nr+0x10/0x70
> 
> [   19.302817] Use-after-free read at 0x000000007f3b80eb (in kfence-#115):
> [   19.309677]  pci_bus_release_domain_nr+0x10/0x70
> [   19.309691]  dw_pcie_host_deinit+0x28/0x78
> [   19.309702]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
> [   19.309734]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
> [   19.309752]  platform_probe+0x90/0xd8
> [   19.309764]  really_probe+0xb8/0x298
> [   19.309777]  __driver_probe_device+0x78/0xd8
> [   19.309788]  driver_probe_device+0x38/0x120
> [   19.309799]  __device_attach_driver+0x94/0xe0
> [   19.309812]  bus_for_each_drv+0x70/0xc8
> [   19.309822]  __device_attach+0xfc/0x188
> [   19.309833]  device_initial_probe+0x10/0x18
> [   19.309844]  bus_probe_device+0x94/0xa0
> [   19.309854]  deferred_probe_work_func+0x80/0xb8
> [   19.309864]  process_one_work+0x1e0/0x348
> [   19.309882]  worker_thread+0x48/0x410
> [   19.309891]  kthread+0xf4/0x110
> [   19.309904]  ret_from_fork+0x10/0x20
> 
> [   19.311457] kfence-#115: 0x00000000063a155a-0x00000000ba698da8, size=1072, cache=kmalloc-2k
> 
> [   19.311469] allocated by task 96 on cpu 10 at 19.279323s:
> [   19.311562]  __kmem_cache_alloc_node+0x260/0x278
> [   19.311571]  kmalloc_trace+0x24/0x30
> [   19.311580]  pci_alloc_bus+0x24/0xa0
> [   19.311590]  pci_register_host_bridge+0x48/0x4b8
> [   19.311601]  pci_scan_root_bus_bridge+0xc0/0xe8
> [   19.311613]  pci_host_probe+0x18/0xc0
> [   19.311623]  dw_pcie_host_init+0x2c0/0x568
> [   19.311630]  tegra_pcie_dw_probe+0x610/0xb28 [pcie_tegra194]
> [   19.311647]  platform_probe+0x90/0xd8
> [   19.311653]  really_probe+0xb8/0x298
> [   19.311663]  __driver_probe_device+0x78/0xd8
> [   19.311672]  driver_probe_device+0x38/0x120
> [   19.311682]  __device_attach_driver+0x94/0xe0
> [   19.311694]  bus_for_each_drv+0x70/0xc8
> [   19.311702]  __device_attach+0xfc/0x188
> [   19.311713]  device_initial_probe+0x10/0x18
> [   19.311724]  bus_probe_device+0x94/0xa0
> [   19.311733]  deferred_probe_work_func+0x80/0xb8
> [   19.311743]  process_one_work+0x1e0/0x348
> [   19.311753]  worker_thread+0x48/0x410
> [   19.311763]  kthread+0xf4/0x110
> [   19.311771]  ret_from_fork+0x10/0x20
> 
> [   19.311782] freed by task 96 on cpu 10 at 19.285833s:
> [   19.311799]  release_pcibus_dev+0x30/0x40
> [   19.311808]  device_release+0x30/0x90
> [   19.311814]  kobject_put+0xa8/0x120
> [   19.311832]  device_unregister+0x20/0x30
> [   19.311839]  pci_remove_bus+0x78/0x88
> [   19.311850]  pci_remove_root_bus+0x5c/0x98
> [   19.311860]  dw_pcie_host_deinit+0x28/0x78
> [   19.311866]  tegra_pcie_deinit_controller+0x1c/0x38 [pcie_tegra194]
> [   19.311883]  tegra_pcie_dw_probe+0x648/0xb28 [pcie_tegra194]
> [   19.311900]  platform_probe+0x90/0xd8
> [   19.311906]  really_probe+0xb8/0x298
> [   19.311916]  __driver_probe_device+0x78/0xd8
> [   19.311926]  driver_probe_device+0x38/0x120
> [   19.311936]  __device_attach_driver+0x94/0xe0
> [   19.311947]  bus_for_each_drv+0x70/0xc8
> [   19.311956]  __device_attach+0xfc/0x188
> [   19.311966]  device_initial_probe+0x10/0x18
> [   19.311976]  bus_probe_device+0x94/0xa0
> [   19.311985]  deferred_probe_work_func+0x80/0xb8
> [   19.311995]  process_one_work+0x1e0/0x348
> [   19.312005]  worker_thread+0x48/0x410
> [   19.312014]  kthread+0xf4/0x110
> [   19.312022]  ret_from_fork+0x10/0x20

Based on the above trace it looks like a double free of "pp->bridge"
structure.

Also, which kernel version are you using? Because from above third
trace it looks like that dw_pcie_host_deinit() calls first
pci_remove_root_bus() function and then (from first strace) it also
calls pci_bus_release_domain_nr() function.

Source code of the dw_pcie_host_deinit() is there:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c
But I do not see where dw_pcie_host_deinit() calls
pci_bus_release_domain_nr() function as visible in the first trace.

> [   19.313579] CPU: 10 PID: 96 Comm: kworker/u24:2 Not tainted 6.2.0 #4
> [   19.320171] Hardware name:  /, BIOS 1.0-d7fb19b 08/10/2022
> [   19.325852] Workqueue: events_unbound deferred_probe_work_func
> [   19.331919] ==================================================================
> 
> After reverting this change I no longer see this issue.
> Let me know if you have any thoughts.
> 
> Thanks
> Jon
> -- 
> nvpublic
