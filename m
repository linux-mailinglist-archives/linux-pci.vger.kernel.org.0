Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 378C74D05E
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 16:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbfFTO1K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 10:27:10 -0400
Received: from foss.arm.com ([217.140.110.172]:41226 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726675AbfFTO1K (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jun 2019 10:27:10 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 297A9344;
        Thu, 20 Jun 2019 07:27:09 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C90013F718;
        Thu, 20 Jun 2019 07:27:07 -0700 (PDT)
Date:   Thu, 20 Jun 2019 15:27:02 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Manikanta Maddireddy <mmaddireddy@nvidia.com>
Cc:     thierry.reding@gmail.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, jonathanh@nvidia.com, vidyas@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH V6 04/27] PCI: tegra: Mask AFI_INTR in runtime suspend
Message-ID: <20190620142702.GA31996@e121166-lin.cambridge.arm.com>
References: <20190618180206.4908-1-mmaddireddy@nvidia.com>
 <20190618180206.4908-5-mmaddireddy@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190618180206.4908-5-mmaddireddy@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 18, 2019 at 11:31:43PM +0530, Manikanta Maddireddy wrote:
> AFI_INTR is unmasked in tegra_pcie_enable_controller(), mask it to avoid
> unwanted interrupts raised by AFI after pex_rst is asserted.
> 
> Following sequence triggers such scenario,
>  - tegra_pcie_remove() triggers runtime suspend
>  - pex_rst is asserted in runtime suspend
>  - PRSNT_MAP bit field in RP_PRIV_MISC register changes from EP_PRSNT to
>    EP_ABSNT
>  - This is sensed by AFI and triggers "Slot present pin change" interrupt
>  - tegra_pcie_isr() function accesses AFI register when runtime suspend
>    is going through power off sequence
> 
> rmmod pci-tegra
>  pci_generic_config_write32: 108 callbacks suppressed
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4c may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x90 may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4 may corrupt adjacent RW1C bits
>  igb 0002:04:00.1: removed PHC on enP2p4s0f1
>  igb 0002:04:00.0: removed PHC on enP2p4s0f0
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4c may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x9c may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x88 may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x90 may corrupt adjacent RW1C bits
>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4 may corrupt adjacent RW1C bits
>  rcu: INFO: rcu_preempt self-detected stall on CPU
>  SError Interrupt on CPU0, code 0xbf000002 -- SError
>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next-20190405-00027-gcd8110499e6f-dirty #42
>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>  pstate: 20000085 (nzCv daIf -PAN -UAO)
>  pc : tegra_pcie_isr+0x58/0x178 [pci_tegra]
>  lr : tegra_pcie_isr+0x40/0x178 [pci_tegra]
>  sp : ffff000010003da0
>  x29: ffff000010003da0 x28: 0000000000000000
>  x27: ffff8000f9e61000 x26: ffff000010fbf420
>  x25: ffff000011427f93 x24: ffff8000fa600410
>  x23: ffff00001129d000 x22: ffff00001129d000
>  x21: ffff8000f18bf3c0 x20: 0000000000000070
>  x19: 00000000ffffffff x18: 0000000000000000
>  x17: 0000000000000000 x16: 0000000000000000
>  x15: 0000000000000000 x14: ffff000008d40a48
>  x13: ffff000008d40a30 x12: ffff000008d40a20
>  x11: ffff000008d40a10 x10: ffff000008d40a00
>  x9 : ffff000008d409e8 x8 : ffff000008d40ae8
>  x7 : ffff000008d40ad0 x6 : ffff000010003e58
>  x5 : ffff8000fac00248 x4 : 0000000000000000
>  x3 : ffff000008d40b08 x2 : fffffffffffffff8
>  x1 : ffff000008d3f4e8 x0 : 00000000ffffffff
>  Kernel panic - not syncing: Asynchronous SError Interrupt
>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next-20190405-00027-gcd8110499e6f-dirty #42
>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>  Call trace:
>   dump_backtrace+0x0/0x158
>   show_stack+0x14/0x20
>   dump_stack+0xa8/0xcc
>   panic+0x140/0x2f4
>   nmi_panic+0x6c/0x70
>   arm64_serror_panic+0x74/0x80
>   __pte_error+0x0/0x28
>   el1_error+0x84/0xf8
>   tegra_pcie_isr+0x58/0x178 [pci_tegra]
>   __handle_irq_event_percpu+0x70/0x198
>   handle_irq_event_percpu+0x34/0x88
>   handle_irq_event+0x48/0x78
>   handle_fasteoi_irq+0xb4/0x190
>   generic_handle_irq+0x24/0x38
>   __handle_domain_irq+0x5c/0xb8
>   gic_handle_irq+0x58/0xa8
>   el1_irq+0xb8/0x180
>   cpuidle_enter_state+0x138/0x358
>   cpuidle_enter+0x18/0x20
>   call_cpuidle+0x1c/0x48
>   do_idle+0x230/0x2d0
>   cpu_startup_entry+0x20/0x28
>   rest_init+0xd4/0xe0
>   arch_call_rest_init+0xc/0x14
>   start_kernel+0x444/0x470
> 
> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> ---
> V6: No change
> 
> V5:
> * Added blank line before block-style comment
> 
> V4: No change
> 
> V3:
> * Update the commit log and comment to reflect why this fix is required
> * MSI interrupt is not disabled
> 
> V2: This is new patch in V2
> 
>  drivers/pci/controller/pci-tegra.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index bb3c0af9c830..0453bfb2726e 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -1622,6 +1622,15 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
>  	return 0;
>  }
>  
> +static void tegra_pcie_disable_interrupts(struct tegra_pcie *pcie)
> +{
> +	u32 value;
> +
> +	value = afi_readl(pcie, AFI_INTR_MASK);
> +	value &= ~AFI_INTR_MASK_INT_MASK;
> +	afi_writel(pcie, value, AFI_INTR_MASK);
> +}
> +
>  static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
>  				      u32 *xbar)
>  {
> @@ -2467,6 +2476,12 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
>  
>  	tegra_pcie_disable_ports(pcie);
>  
> +	/*
> +	 * AFI_INTR is unmasked in tegra_pcie_enable_controller(), mask it to
> +	 * avoid unwanted interrupts raised by AFI after pex_rst is asserted.
> +	 */
> +	tegra_pcie_disable_interrupts(pcie);

When do you re-enable it ? I assume it is enabled by default for
a reason, so if you disable on suspend you renable it on resume.

Please explain or I will drop this patch from the series.

Lorenzo

> +
>  	if (pcie->soc->program_uphy) {
>  		err = tegra_pcie_phy_power_off(pcie);
>  		if (err < 0)
> -- 
> 2.17.1
> 
