Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D38518D76
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 17:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbfEIP5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 11:57:45 -0400
Received: from hqemgate15.nvidia.com ([216.228.121.64]:15107 "EHLO
        hqemgate15.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfEIP5p (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 May 2019 11:57:45 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqemgate15.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5cd44dd20000>; Thu, 09 May 2019 08:57:06 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 May 2019 08:57:43 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 May 2019 08:57:43 -0700
Received: from [10.24.71.213] (10.124.1.5) by HQMAIL101.nvidia.com
 (172.20.187.10) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 May
 2019 15:57:38 +0000
Subject: Re: [PATCH V2 04/28] PCI: tegra: Disable PCIe interrupts in runtime
 suspend
To:     Thierry Reding <thierry.reding@gmail.com>
CC:     <bhelgaas@google.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <jonathanh@nvidia.com>,
        <lorenzo.pieralisi@arm.com>, <vidyas@nvidia.com>,
        <linux-tegra@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>
References: <20190423092825.759-1-mmaddireddy@nvidia.com>
 <20190423092825.759-5-mmaddireddy@nvidia.com> <20190509141059.GD8907@ulmo>
X-Nvconfidentiality: public
From:   Manikanta Maddireddy <mmaddireddy@nvidia.com>
Message-ID: <79b89690-37b5-41ad-8613-cd5495ec6103@nvidia.com>
Date:   Thu, 9 May 2019 21:27:04 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190509141059.GD8907@ulmo>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL101.nvidia.com (172.20.187.10)
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1557417426; bh=j82w8rngfA+rXCFacWvrsJysWm1eaJvgH2iiRXJ+/G4=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:
         Content-Transfer-Encoding:Content-Language;
        b=hyVSYXoqsTeAkraA7O9iyzvyvDRrh1k+1+MhXqoinZSl//4KMSP0rK0eR0RW4UO55
         8+7QcYc2cTmdeI3VCBl/HDPBRoviGvdW3OxD/7jneKCwzySlY89XmAwAR7JjguHj33
         7pP1V3AyjMyarInKWs4TaOzuOAXsEjzynx70MUDpxRMQU2rh7ZRLULqkpYqqHE5PLl
         xqV/jWqkz5O14FcrmBgNAW04boqLacnHtAC1REk/IRGB+Rg88a82QEL69vLerBBDX/
         aVWBtJisB7u3qVoquhpdjaUA+XhQpflACr1U2M41Iff9d0Iwp7X3aTzW3af7cwf7Ei
         yK3QjaZ874t0A==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 09-May-19 7:40 PM, Thierry Reding wrote:
> On Tue, Apr 23, 2019 at 02:58:01PM +0530, Manikanta Maddireddy wrote:
>> Disable PCIe interrupts in runtime suspend to avoid executing irq handler
>> and power off sequence in parallel.
>>
>> Following sequence triggers such scenario,
>>  - tegra_pcie_remove() triggers runtime suspend
>>  - pex_rst is asserted in runtime suspend
>>  - PRSNT_MAP bit field in RP_PRIV_MISC register changes from EP_PRSNT to
>>    EP_ABSNT
>>  - This is sensed by AFI and triggers "Slot present pin change" interrupt
>>  - tegra_pcie_isr() function accesses AFI register when runtime suspend
>>    is going through power off sequence
> This sounds like more of a workaround than a proper solution. If the
> above sequence crashes, it means that we have a bug somewhere in that
> sequence. By the time the controller is runtime suspended, we should
> have shut everything down already.
>
> That said, from the looks of it, I think we may be able to fix this by
> moving the pm_runtime_*() calls in tegra_pcie_remove() below the
> tegra_pcie_put_resources(). At that point, nothing should be accessing
> any registers anymore.
>
> Thierry

This crash is observed after applying 5/28 patch because,
 - In the previous sequence AFI is asserted before PEX reset,
so AFI doesn't raise interrupt
 - Whereas in 5/28 patch, PEX reset is asserted before AFI,
so AFI raises interrupt

I believe this patch is correct fix & not workaround because,
 - tegra_pcie_pm_resume() -> tegra_pcie_enable_controller() is clearing
AFI_INTR_MASK
 - In tegra_pcie_pm_suspend() this patch is doing opposite of above
programming, which is masking AFI_INTR_MASK

Moving pm_runtime_put() after tegra_pcie_put_resources() will not be
inline with init sequence in probe because tegra_pcie_get_resources()
is done before pm_runtime_get().

Manikanta 

>> rmmod pci-tegra
>>  pci_generic_config_write32: 108 callbacks suppressed
>>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4c may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x90 may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:02.0 offset 0x4 may corrupt adjacent RW1C bits
>>  igb 0002:04:00.1: removed PHC on enP2p4s0f1
>>  igb 0002:04:00.0: removed PHC on enP2p4s0f0
>>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4c may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x9c may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x88 may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x90 may corrupt adjacent RW1C bits
>>  pci_bus 0002:00: 2-byte config write to 0002:00:01.0 offset 0x4 may corrupt adjacent RW1C bits
>>  rcu: INFO: rcu_preempt self-detected stall on CPU
>>  SError Interrupt on CPU0, code 0xbf000002 -- SError
>>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next-20190405-00027-gcd8110499e6f-dirty #42
>>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>>  pstate: 20000085 (nzCv daIf -PAN -UAO)
>>  pc : tegra_pcie_isr+0x58/0x178 [pci_tegra]
>>  lr : tegra_pcie_isr+0x40/0x178 [pci_tegra]
>>  sp : ffff000010003da0
>>  x29: ffff000010003da0 x28: 0000000000000000
>>  x27: ffff8000f9e61000 x26: ffff000010fbf420
>>  x25: ffff000011427f93 x24: ffff8000fa600410
>>  x23: ffff00001129d000 x22: ffff00001129d000
>>  x21: ffff8000f18bf3c0 x20: 0000000000000070
>>  x19: 00000000ffffffff x18: 0000000000000000
>>  x17: 0000000000000000 x16: 0000000000000000
>>  x15: 0000000000000000 x14: ffff000008d40a48
>>  x13: ffff000008d40a30 x12: ffff000008d40a20
>>  x11: ffff000008d40a10 x10: ffff000008d40a00
>>  x9 : ffff000008d409e8 x8 : ffff000008d40ae8
>>  x7 : ffff000008d40ad0 x6 : ffff000010003e58
>>  x5 : ffff8000fac00248 x4 : 0000000000000000
>>  x3 : ffff000008d40b08 x2 : fffffffffffffff8
>>  x1 : ffff000008d3f4e8 x0 : 00000000ffffffff
>>  Kernel panic - not syncing: Asynchronous SError Interrupt
>>  CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W         5.1.0-rc3-next-20190405-00027-gcd8110499e6f-dirty #42
>>  Hardware name: NVIDIA Jetson TX1 Developer Kit (DT)
>>  Call trace:
>>   dump_backtrace+0x0/0x158
>>   show_stack+0x14/0x20
>>   dump_stack+0xa8/0xcc
>>   panic+0x140/0x2f4
>>   nmi_panic+0x6c/0x70
>>   arm64_serror_panic+0x74/0x80
>>   __pte_error+0x0/0x28
>>   el1_error+0x84/0xf8
>>   tegra_pcie_isr+0x58/0x178 [pci_tegra]
>>   __handle_irq_event_percpu+0x70/0x198
>>   handle_irq_event_percpu+0x34/0x88
>>   handle_irq_event+0x48/0x78
>>   handle_fasteoi_irq+0xb4/0x190
>>   generic_handle_irq+0x24/0x38
>>   __handle_domain_irq+0x5c/0xb8
>>   gic_handle_irq+0x58/0xa8
>>   el1_irq+0xb8/0x180
>>   cpuidle_enter_state+0x138/0x358
>>   cpuidle_enter+0x18/0x20
>>   call_cpuidle+0x1c/0x48
>>   do_idle+0x230/0x2d0
>>   cpu_startup_entry+0x20/0x28
>>   rest_init+0xd4/0xe0
>>   arch_call_rest_init+0xc/0x14
>>   start_kernel+0x444/0x470
>>
>> Signed-off-by: Manikanta Maddireddy <mmaddireddy@nvidia.com>
>> ---
>> V2: This is new patch in V2
>>
>>  drivers/pci/controller/pci-tegra.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
>> index bb3c0af9c830..8c0ad038699d 100644
>> --- a/drivers/pci/controller/pci-tegra.c
>> +++ b/drivers/pci/controller/pci-tegra.c
>> @@ -1622,6 +1622,18 @@ static int tegra_pcie_disable_msi(struct tegra_pcie *pcie)
>>  	return 0;
>>  }
>>  
>> +static void tegra_pcie_disable_interrupts(struct tegra_pcie *pcie)
>> +{
>> +	u32 value;
>> +
>> +	value = afi_readl(pcie, AFI_INTR_MASK);
>> +	value &= ~AFI_INTR_MASK_INT_MASK;
>> +	afi_writel(pcie, value, AFI_INTR_MASK);
>> +
>> +	if (IS_ENABLED(CONFIG_PCI_MSI))
>> +		tegra_pcie_disable_msi(pcie);
>> +}
>> +
>>  static int tegra_pcie_get_xbar_config(struct tegra_pcie *pcie, u32 lanes,
>>  				      u32 *xbar)
>>  {
>> @@ -2466,6 +2478,11 @@ static int __maybe_unused tegra_pcie_pm_suspend(struct device *dev)
>>  		tegra_pcie_pme_turnoff(port);
>>  
>>  	tegra_pcie_disable_ports(pcie);
>> +	/*
>> +	 * disable interrupts to avoid executing irq handler in parallel
>> +	 * to power off sequence.
>> +	 */
>> +	tegra_pcie_disable_interrupts(pcie);
>>  
>>  	if (pcie->soc->program_uphy) {
>>  		err = tegra_pcie_phy_power_off(pcie);
>> -- 
>> 2.17.1
>>

