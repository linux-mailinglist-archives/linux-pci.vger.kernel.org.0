Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3EED3A7945
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jun 2021 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhFOIr3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Jun 2021 04:47:29 -0400
Received: from foss.arm.com ([217.140.110.172]:56892 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230332AbhFOIr3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Jun 2021 04:47:29 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4522D6E;
        Tue, 15 Jun 2021 01:45:24 -0700 (PDT)
Received: from [192.168.0.110] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC4F53F694;
        Tue, 15 Jun 2021 01:45:22 -0700 (PDT)
Subject: Re: [PATCH v4] PCI: of: Clear 64-bit flag for non-prefetchable memory
 below 4GB
To:     Punit Agrawal <punitagrawal@gmail.com>, helgaas@kernel.org,
        robh+dt@kernel.org
Cc:     maz@kernel.org, leobras.c@gmail.com,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, wqu@suse.com, robin.murphy@arm.com,
        pgwipeout@gmail.com, ardb@kernel.org, briannorris@chromium.org,
        shawn.lin@rock-chips.com, Bjorn Helgaas <bhelgaas@google.com>
References: <20210614230457.752811-1-punitagrawal@gmail.com>
From:   Alexandru Elisei <alexandru.elisei@arm.com>
Message-ID: <888ca9e9-a1c0-3992-7c01-bbb7400e8dc0@arm.com>
Date:   Tue, 15 Jun 2021 09:46:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614230457.752811-1-punitagrawal@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Punit,

Thank you for working on this!

On 6/15/21 12:04 AM, Punit Agrawal wrote:
> Alexandru and Qu reported this resource allocation failure on
> ROCKPro64 v2 and ROCK Pi 4B, both based on the RK3399:
>
>   pci_bus 0000:00: root bus resource [mem 0xfa000000-0xfbdfffff 64bit]
>   pci 0000:00:00.0: PCI bridge to [bus 01]
>   pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
>   pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
>
> "BAR 14" is the PCI bridge's 32-bit non-prefetchable window, and our
> PCI allocation code isn't smart enough to allocate it in a host
> bridge window marked as 64-bit, even though this should work fine.
>
> A DT host bridge description includes the windows from the CPU
> address space to the PCI bus space.  On a few architectures
> (microblaze, powerpc, sparc), the DT may also describe PCI devices
> themselves, including their BARs.
>
> Before 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource
> flags for 64-bit memory addresses"), of_bus_pci_get_flags() ignored
> the fact that some DT addresses described 64-bit windows and BARs.
> That was a problem because the virtio virtual NIC has a 32-bit BAR
> and a 64-bit BAR, and the driver couldn't distinguish them.
>
> 9d57e61bf723 set IORESOURCE_MEM_64 for those 64-bit DT ranges, which
> fixed the virtio driver.  But it also set IORESOURCE_MEM_64 for host
> bridge windows, which exposed the fact that the PCI allocator isn't
> smart enough to put 32-bit resources in those 64-bit windows.
>
> Clear IORESOURCE_MEM_64 from host bridge windows since we don't need
> that information.

I've tested the patch on my rockpro64. Kernel built from tag v5.13-rc6:

[    0.345676] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
x4 link)
[    0.359300] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
[    0.359343] pci 0000:00:00.0: BAR 14: no space for [mem size 0x00100000]
[    0.359365] pci 0000:00:00.0: BAR 14: failed to assign [mem size 0x00100000]
[    0.359387] pci 0000:01:00.0: BAR 0: no space for [mem size 0x00004000 64bit]
[    0.359407] pci 0000:01:00.0: BAR 0: failed to assign [mem size 0x00004000 64bit]
[    0.359428] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.359862] pcieport 0000:00:00.0: PME: Signaling with IRQ 76
[    0.360190] pcieport 0000:00:00.0: AER: enabled with IRQ 76

Kernel built from tag v5.13-rc6 with this patch applied:

[    0.345434] pci 0000:01:00.0: 8.000 Gb/s available PCIe bandwidth, limited by
2.5 GT/s PCIe x4 link at 0000:00:00.0 (capable of 31.504 Gb/s with 8.0 GT/s PCIe
x4 link)
[    0.359081] pci_bus 0000:01: busn_res: [bus 01-1f] end is updated to 01
[    0.359128] pci 0000:00:00.0: BAR 14: assigned [mem 0xfa000000-0xfa0fffff]
[    0.359155] pci 0000:01:00.0: BAR 0: assigned [mem 0xfa000000-0xfa003fff 64bit]
[    0.359217] pci 0000:00:00.0: PCI bridge to [bus 01]
[    0.359239] pci 0000:00:00.0:   bridge window [mem 0xfa000000-0xfa0fffff]
[    0.359422] pcieport 0000:00:00.0: enabling device (0000 -> 0002)
[    0.359687] pcieport 0000:00:00.0: PME: Signaling with IRQ 76
[    0.360001] pcieport 0000:00:00.0: AER: enabled with IRQ 76

And the NVME on the PCIE expansion card works as expected:

Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>

Thanks,

Alex

>
> Fixes: 9d57e61bf723 ("of/pci: Add IORESOURCE_MEM_64 to resource flags for 64-bit memory addresses")
> Reported-at: https://lore.kernel.org/lkml/7a1e2ebc-f7d8-8431-d844-41a9c36a8911@arm.com/
> Reported-by: Alexandru Elisei <alexandru.elisei@arm.com>
> Reported-by: Qu Wenruo <wqu@suse.com>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Punit Agrawal <punitagrawal@gmail.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> ---
> Hi,
>
> The patch is an updated version to fix the PCI allocation issues on
> RK3399 based platforms. Previous postings can be found at [0][1][2].
>
> The updated patch instead of clearing the 64-bit flag for
> non-prefetchable memory below 4GB does it unconditionally on the basis
> that PCI allocation logic cannot deal with the 64-bit flag (although
> it should be able to). The result is a simpler patch that restores the
> input to the allocation logic to be identical to before 9d57e61bf723.
>
> Tested locally on a RockPro64 on top of v5.13-rc6. Please consider
> merging.
>
> Thanks,
> Punit
>
> Changes:
> v4:
>
> * Updated Patch 1 based on Bjorn's suggestion. Also dropped the
>   Tested-by tags due to the change of logic
> * Dropped patch 2 and 3 from the series as it's not critical to the
>   series
> * Dropped the device tree changes (Patch 4) as they are already queued
>   in the soc tree
>
> v3:
> * Improved commit log for clarity (Patch 1)
> * Added Tested-by tags
>
> v2:
> * Check ranges PCI / bus addresses rather than CPU addresses
> * (new) Restrict 32-bit size warnings on ranges that don't have the 64-bit attribute set
> * Refactor the 32-bit size warning to the range parsing loop. This
>   change also prints the warnings right after the window mappings are
>   logged.
>
> [0] https://lore.kernel.org/linux-arm-kernel/20210527150541.3130505-1-punitagrawal@gmail.com/
> [1] https://lore.kernel.org/linux-pci/20210531221057.3406958-1-punitagrawal@gmail.com/
> [2] https://lore.kernel.org/linux-pci/20210607112856.3499682-1-punitagrawal@gmail.com/
>
>  drivers/pci/of.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index 85dcb7097da4..a143b02b2dcd 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -353,6 +353,8 @@ static int devm_of_pci_get_host_bridge_resources(struct device *dev,
>  				dev_warn(dev, "More than one I/O resource converted for %pOF. CPU base address for old range lost!\n",
>  					 dev_node);
>  			*io_base = range.cpu_addr;
> +		} else if (resource_type(res) == IORESOURCE_MEM) {
> +			res->flags &= ~IORESOURCE_MEM_64;
>  		}
>  
>  		pci_add_resource_offset(resources, res,	res->start - range.pci_addr);
