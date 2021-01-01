Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 224E52E8538
	for <lists+linux-pci@lfdr.de>; Fri,  1 Jan 2021 18:40:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbhAARi1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Jan 2021 12:38:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:37960 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726798AbhAARi0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Jan 2021 12:38:26 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 859DE221E9;
        Fri,  1 Jan 2021 17:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609522666;
        bh=/AL+2blderBT7RQyiS+zdFi6qDMRoz8Drww6xSQunj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ds19deqXgUyJdPVUHaDDYV8nTSskwT3p/w+FzfhA+uPuI8PFbzoq4Aojmnosj0VvA
         hBdb8aYbG3qF2wleRSF/XEEbUUv4tr0IvPfrUIgvkmyAaVuFlwmFRWEXIvDKrmGj1z
         L2N75KR/Fv/iFJFk0rMt6IzIYkYzz95SBFJxTWYJlK6O/hk7SOiHSZbkCZ/0pbBb6C
         s+G8+8Y6mfSvYDEEUkrMyf2NsgsYpcI9lk1MhHjC2quoElfqQQmUBX/vKbxd8hfjhG
         0wz3GBE5ZgJLwRKaV0bexoYIScc/+U48x1U33NktP4G8I38UVdP0wp2BME/LPsWK50
         fNkmypLDJdftA==
Date:   Fri, 1 Jan 2021 11:37:44 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jari =?iso-8859-1?Q?H=E4m=E4l=E4inen?= <nuumiofi@gmail.com>
Cc:     Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [RFC PATCH 1/3] PCI: rockchip: provide workaround for bus scan
 crash with optional delay
Message-ID: <20210101173744.GA921848@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201231125214.25733-2-nuumiofi@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 31, 2020 at 02:52:12PM +0200, Jari Hämäläinen wrote:
> Some PCIe devices cause Rockchip PCIe controller to crash in bus scan.
> Crash may be avoided by delaying bus scan by time given from command line
> or from device tree. Needed amount of delay varies from device to device.
> Delay doesn't have to be exact. It just has to be long enough.

Is this a standard post-reset delay that the rockchip driver is
missing?  Maybe compare with other drivers to see if rockchip is
missing something.

Is this an erratum in the Rockchip IP?  If so, we should have a
specific description and a citation for it, and a workaround could be
done automatically without DT or command-line switches.

> The following lists few problematic PCIe devices with delays needed for
> stable bus scan surviving 100 sequential reboots in test loop executed on
> RockPro64 (RK3399 single-board computer):
> - LSI 9201-8i         / SAS2008 chipset [1000:0072]: 725 ms
> - LSI 9302-8i         / SAS3008 chipset [1000:0097]: 575 ms (1)
> - HP H220             / SAS2308 chipset [1000:0087]: 800 ms (2)
> - IBM ServeRAID M5110 / SAS2208 chipset [1000:005b]: 1050 ms (3)
> 
>   1) mpt3sas module has soft lockup bug on shutdown but device is usable
>   2) has infrequent crash on mpt3sas module load (2 of 662 reboots in all
>      test sessions with this device crashed on module load)
>   3) megaraid_sas module crashes on load so device remains unusable
>      (bus scan tested with module being blacklisted)
> 
> Side effect of delay, if set, is that it slows down system startup by the
> amount of delay.
> 
> Log excerpt showing a crash happening always on unpatched kernel with
> problematic PCIe devices listed above rendering them unusable:

It doesn't seem likely that the devices above are broken since we
don't have problems with them on other systems.  More likely to be
some Rockchip-specific thing, and the devices above are operating
within spec (possibly using more of the allowed post-reset time than
most devices).

> [    1.240649] SError Interrupt on CPU5, code 0xbf000002 -- SError

We really should know more about what the specific error is.  Most
errors on PCIe should be recoverable and they can happen at any time,
not just at boot-time.

This patch adds a boot-time delay.  At run-time, if we power-cycle or
reset a device and re-enumerate the bus, we would likely see the same
problem and this patch wouldn't help.

> [    1.240653] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.10.2-stable #1
> [    1.240656] Hardware name: Pine64 RockPro64 v2.0 (DT)
> [    1.240659] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
> [    1.240661] pc : rockchip_pcie_rd_conf+0x178/0x268
> [    1.240664] lr : rockchip_pcie_rd_conf+0x1b8/0x268
> [    1.240666] sp : ffff8000119db850
> [    1.240669] x29: ffff8000119db850 x28: 0000000000000000
> [    1.240676] x27: 0000000000000000 x26: 0000000000000000
> [    1.240682] x25: ffff8000119db984 x24: 0000000000000000
> [    1.240688] x23: 0000000000000000 x22: ffff000040ba0b80
> [    1.240694] x21: ffff8000119db8d4 x20: 0000000000000004
> [    1.240700] x19: 0000000000100000 x18: ffffffffffffffff
> [    1.240706] x17: 0000000031cae143 x16: 000000008c75157c
> [    1.240712] x15: ffff800011729908 x14: ffff000040c87a1c
> [    1.240718] x13: ffff000040c87293 x12: 0000000000000038
> [    1.240724] x11: 0000000005f5e0ff x10: 7f7f7f7f7f7f7f7f
> [    1.240729] x9 : 0000000001001d87 x8 : 000000000000ea60
> [    1.240735] x7 : ffff8000119db984 x6 : 0000000000000000
> [    1.240741] x5 : 0000000000000000 x4 : 0000000000c00008
> [    1.240747] x3 : ffff800017000000 x2 : 000000000080000a
> [    1.240753] x1 : 0000000000000000 x0 : ffff800014000000
> [    1.240759] Kernel panic - not syncing: Asynchronous SError Interrupt
> [    1.240763] CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.10.2-stable #1
> [    1.240765] Hardware name: Pine64 RockPro64 v2.0 (DT)
> [    1.240768] Call trace:
> [    1.240770]  dump_backtrace+0x0/0x1e8
> [    1.240772]  show_stack+0x18/0x60
> [    1.240775]  dump_stack+0xd8/0x130
> [    1.240777]  panic+0x15c/0x380
> [    1.240779]  add_taint+0x0/0xb0
> [    1.240782]  arm64_serror_panic+0x78/0x88
> [    1.240784]  do_serror+0x3c/0x68
> [    1.240787]  el1_error+0x84/0x104
> [    1.240789]  rockchip_pcie_rd_conf+0x178/0x268
> [    1.240791]  pci_bus_read_config_dword+0xa4/0x150
> [    1.240794]  pci_bus_generic_read_dev_vendor_id+0x30/0x1b0
> [    1.240797]  pci_bus_read_dev_vendor_id+0x4c/0x78
> [    1.240800]  pci_scan_single_device+0x80/0x100
> [    1.240802]  pci_scan_slot+0x38/0x130
> [    1.240805]  pci_scan_child_bus_extend+0x58/0x348
> [    1.240807]  pci_scan_bridge_extend+0x304/0x5a0
> [    1.240810]  pci_scan_child_bus_extend+0x20c/0x348
> [    1.240812]  pci_scan_root_bus_bridge+0x64/0xf0
> [    1.240815]  pci_host_probe+0x18/0xc8
> [    1.240817]  rockchip_pcie_probe+0x34c/0x4b8
> [    1.240820]  platform_drv_probe+0x54/0xa8
> [    1.240822]  really_probe+0x29c/0x4f8
> [    1.240824]  driver_probe_device+0xfc/0x168
> [    1.240827]  device_driver_attach+0x74/0x80
> [    1.240829]  __driver_attach+0xb8/0x168
> [    1.240832]  bus_for_each_dev+0x7c/0xd8
> [    1.240834]  driver_attach+0x24/0x30
> [    1.240837]  bus_add_driver+0x15c/0x240
> [    1.240839]  driver_register+0x64/0x120
> [    1.240841]  __platform_driver_register+0x44/0x50
> [    1.240844]  rockchip_pcie_driver_init+0x1c/0x28
> [    1.240846]  do_one_initcall+0x60/0x1d8
> [    1.240849]  kernel_init_freeable+0x234/0x2b4
> [    1.240851]  kernel_init+0x14/0x118
> [    1.240854]  ret_from_fork+0x10/0x34
> [    1.240878] SMP: stopping secondary CPUs
> [    1.240881] Kernel Offset: disabled
> [    1.240883] CPU features: 0x0240022,2100200c
> [    1.240886] Memory Limit: none
> 
> Signed-off-by: Jari Hämäläinen <nuumiofi@gmail.com>
> ---
>  .../admin-guide/kernel-parameters.txt          |  8 ++++++++
>  drivers/pci/controller/pcie-rockchip-host.c    | 18 ++++++++++++++++++
>  drivers/pci/controller/pcie-rockchip.c         |  5 +++++
>  drivers/pci/controller/pcie-rockchip.h         |  2 ++
>  4 files changed, 33 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index c722ec19cd00..fda9bb9c85c3 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3823,6 +3823,14 @@
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>  			all PCIe root ports use INTx for all services).
>  
> +	pcie_rockchip_host.bus_scan_delay_ms=
> +			[PCIE] delay before PCIe bus scan in milliseconds.
> +			If set to greater than or equal to 0 this parameter will
> +			override delay set in device tree. Values less than 0
> +			are ignored. This parameter provides a workaround for
> +			some devices causing a crash in bus scan.
> +			Default: -1
> +
>  	pcmv=		[HW,PCMCIA] BadgePAD 4
>  
>  	pd_ignore_unused
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
> index f1d08a1b1591..14733c92b25c 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -24,6 +24,7 @@
>  #include <linux/kernel.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/module.h>
> +#include <linux/moduleparam.h>
>  #include <linux/of_address.h>
>  #include <linux/of_device.h>
>  #include <linux/of_pci.h>
> @@ -39,6 +40,9 @@
>  #include "../pci.h"
>  #include "pcie-rockchip.h"
>  
> +static int bus_scan_delay_ms = -1;
> +module_param(bus_scan_delay_ms, int, 0444);
> +
>  static void rockchip_pcie_enable_bw_int(struct rockchip_pcie *rockchip)
>  {
>  	u32 status;
> @@ -941,6 +945,7 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct pci_host_bridge *bridge;
>  	int err;
> +	u32 delay = 0;
>  
>  	if (!dev->of_node)
>  		return -ENODEV;
> @@ -992,6 +997,19 @@ static int rockchip_pcie_probe(struct platform_device *pdev)
>  	bridge->sysdata = rockchip;
>  	bridge->ops = &rockchip_pcie_ops;
>  
> +	/*
> +	 * Work around a crash caused by some devices on bus scan by applying a
> +	 * delay if one is given. Prefer command line value over device tree.
> +	 */
> +	if (bus_scan_delay_ms >= 0)
> +		delay = bus_scan_delay_ms;
> +	else
> +		delay = rockchip->bus_scan_delay_ms;
> +	if (delay > 0) {
> +		dev_info(dev, "delay bus scan for %u ms\n", delay);
> +		msleep(delay);
> +	}
> +
>  	err = pci_host_probe(bridge);
>  	if (err < 0)
>  		goto err_remove_irq_domain;
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 904dec0d3a88..2e49e9204894 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -149,6 +149,11 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  		return PTR_ERR(rockchip->clk_pcie_pm);
>  	}
>  
> +	err = of_property_read_u32(node, "rockchip,bus-scan-delay-ms",
> +				   &rockchip->bus_scan_delay_ms);
> +	if (err)
> +		rockchip->bus_scan_delay_ms = 0;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_parse_dt);
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 1650a5087450..18f37820b35b 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -300,6 +300,8 @@ struct rockchip_pcie {
>  	phys_addr_t msg_bus_addr;
>  	bool is_rc;
>  	struct resource *mem_res;
> +	/* bus scan delay for crash causing devices' workaround */
> +	u32 bus_scan_delay_ms;
>  };
>  
>  static u32 rockchip_pcie_read(struct rockchip_pcie *rockchip, u32 reg)
> -- 
> 2.29.2
> 
