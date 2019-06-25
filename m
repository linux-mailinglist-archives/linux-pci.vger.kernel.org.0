Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6559555049
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 15:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfFYN0Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 09:26:16 -0400
Received: from hqemgate16.nvidia.com ([216.228.121.65]:4020 "EHLO
        hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfFYN0Q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jun 2019 09:26:16 -0400
Received: from hqpgpgate102.nvidia.com (Not Verified[216.228.121.13]) by hqemgate16.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5d1220f40001>; Tue, 25 Jun 2019 06:26:12 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate102.nvidia.com (PGP Universal service);
  Tue, 25 Jun 2019 06:26:13 -0700
X-PGP-Universal: processed;
        by hqpgpgate102.nvidia.com on Tue, 25 Jun 2019 06:26:13 -0700
Received: from [10.21.132.148] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 25 Jun
 2019 13:26:10 +0000
Subject: Re: [PATCH v2] PCI: PM: Skip devices in D0 for suspend-to-idle
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-tegra <linux-tegra@vger.kernel.org>
References: <1668247.RaJIPSxJUN@kreacher>
 <CAJZ5v0hdtXqoK84DpYtyMSCnkR9zOHFiUPAzWZDtkFmEjyWD1g@mail.gmail.com>
 <CAJZ5v0gGdXmgc_9r2rbiadq4e31hngpjYQ40QoC6C0z19da_hQ@mail.gmail.com>
 <2287147.DxjcvLeq6l@kreacher>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <779fb707-36a4-f442-b1a7-51aa60db6ff0@nvidia.com>
Date:   Tue, 25 Jun 2019 14:26:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <2287147.DxjcvLeq6l@kreacher>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL103.nvidia.com (172.20.187.11) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1561469172; bh=vPcaZ2cxaOTAYklcJ6bKYuKCXkYX3n+ZAqgIunxjAIg=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=jEj3/cki4KJQHYegQ6/wY9QsDEtzbBoRK1BOapObbjvye5hyAMjqWsAss4PJUtKQg
         zOuaJPAjT6jGtYD76SBemt+WWS2ogdFJoiiMYO9rDKZax2sTYpcZzZGkx/VbQStZGl
         0fX3LEAzH9LFgkuA3Phcy8Ygel5K/1Q8sJ+KdnsrFYJ9Cm/BSvI1DHSrOyo28/YyRo
         j5qu4SnIRbC+qjrgbD3+t421UWoseRMSN34uiHjBUzcwni4a8zPctxFpjfDk2E9A52
         38zcG+nlcKGqPikxzI4FtbKgcJ4XNuHdZ1SWGrYwdhL5s7+kgLw5h+/gU9DzJdf9uU
         vG79KO2fGR8cg==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 25/06/2019 00:09, Rafael J. Wysocki wrote:
> On Tuesday, June 25, 2019 12:20:26 AM CEST Rafael J. Wysocki wrote:
>> On Mon, Jun 24, 2019 at 11:37 PM Rafael J. Wysocki <rafael@kernel.org> wrote:
>>>
>>> On Mon, Jun 24, 2019 at 2:43 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>>>
>>>> Hi Rafael,
>>>>
>>>> On 13/06/2019 22:59, Rafael J. Wysocki wrote:
>>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>>
>>>>> Commit d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>>>>> attempted to avoid a problem with devices whose drivers want them to
>>>>> stay in D0 over suspend-to-idle and resume, but it did not go as far
>>>>> as it should with that.
>>>>>
>>>>> Namely, first of all, the power state of a PCI bridge with a
>>>>> downstream device in D0 must be D0 (based on the PCI PM spec r1.2,
>>>>> sec 6, table 6-1, if the bridge is not in D0, there can be no PCI
>>>>> transactions on its secondary bus), but that is not actively enforced
>>>>> during system-wide PM transitions, so use the skip_bus_pm flag
>>>>> introduced by commit d491f2b75237 for that.
>>>>>
>>>>> Second, the configuration of devices left in D0 (whatever the reason)
>>>>> during suspend-to-idle need not be changed and attempting to put them
>>>>> into D0 again by force is pointless, so explicitly avoid doing that.
>>>>>
>>>>> Fixes: d491f2b75237 ("PCI: PM: Avoid possible suspend-to-idle issue")
>>>>> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>> Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>>> Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>>>>
>>>> I have noticed a regression in both the mainline and -next branches on
>>>> one of our boards when testing suspend. The bisect is point to this
>>>> commit and reverting on top of mainline does fix the problem. So far I
>>>> have not looked at this in close detail but kernel log is showing ...
>>>
>>> Can you please collect a log like that, but with dynamic debug in
>>> pci-driver.c enabled?
>>>
>>> Note that reverting this commit is rather out of the question, so we
>>> need to get to the bottom of the failure.
>>
>> I suspect that there is a problem with the pm_suspend_via_firmware()
>> check which returns 'false' on the affected board, but the platform
>> actually removes power from devices left in D0 during suspend.
>>
>> I guess it would be more appropriate to check something like
>> pm_suspend_no_platform() which would return 'true' in the
>> suspend-to-idle patch w/ ACPI.
> 
> So I wonder if the patch below makes any difference?
> 
> ---
>  drivers/pci/pci-driver.c |    8 ++++----
>  include/linux/suspend.h  |   26 ++++++++++++++++++++++++--
>  kernel/power/suspend.c   |    3 +++
>  3 files changed, 31 insertions(+), 6 deletions(-)
> 
> Index: linux-pm/include/linux/suspend.h
> ===================================================================
> --- linux-pm.orig/include/linux/suspend.h
> +++ linux-pm/include/linux/suspend.h
> @@ -209,8 +209,9 @@ extern int suspend_valid_only_mem(suspen
>  
>  extern unsigned int pm_suspend_global_flags;
>  
> -#define PM_SUSPEND_FLAG_FW_SUSPEND	(1 << 0)
> -#define PM_SUSPEND_FLAG_FW_RESUME	(1 << 1)
> +#define PM_SUSPEND_FLAG_FW_SUSPEND	BIT(0)
> +#define PM_SUSPEND_FLAG_FW_RESUME	BIT(1)
> +#define PM_SUSPEND_FLAG_NO_PLATFORM	BIT(2)
>  
>  static inline void pm_suspend_clear_flags(void)
>  {
> @@ -227,6 +228,11 @@ static inline void pm_set_resume_via_fir
>  	pm_suspend_global_flags |= PM_SUSPEND_FLAG_FW_RESUME;
>  }
>  
> +static inline void pm_set_suspend_no_platform(void)
> +{
> +	pm_suspend_global_flags |= PM_SUSPEND_FLAG_NO_PLATFORM;
> +}
> +
>  /**
>   * pm_suspend_via_firmware - Check if platform firmware will suspend the system.
>   *
> @@ -268,6 +274,22 @@ static inline bool pm_resume_via_firmwar
>  	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_FW_RESUME);
>  }
>  
> +/**
> + * pm_suspend_no_platform - Check if platform may change device power states.
> + *
> + * To be called during system-wide power management transitions to sleep states
> + * or during the subsequent system-wide transitions back to the working state.
> + *
> + * Return 'true' if the power states of devices remain under full control of the
> + * kernel throughout the system-wide suspend and resume cycle in progress (that
> + * is, if a device is put into a certain power state during suspend, it can be
> + * expected to remain in that state during resume).
> + */
> +static inline bool pm_suspend_no_platform(void)
> +{
> +	return !!(pm_suspend_global_flags & PM_SUSPEND_FLAG_NO_PLATFORM);
> +}
> +
>  /* Suspend-to-idle state machnine. */
>  enum s2idle_states {
>  	S2IDLE_STATE_NONE,      /* Not suspended/suspending. */
> Index: linux-pm/kernel/power/suspend.c
> ===================================================================
> --- linux-pm.orig/kernel/power/suspend.c
> +++ linux-pm/kernel/power/suspend.c
> @@ -493,6 +493,9 @@ int suspend_devices_and_enter(suspend_st
>  
>  	pm_suspend_target_state = state;
>  
> +	if (state == PM_SUSPEND_TO_IDLE)
> +		pm_set_suspend_no_platform();
> +
>  	error = platform_suspend_begin(state);
>  	if (error)
>  		goto Close;
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -870,7 +870,7 @@ static int pci_pm_suspend_noirq(struct d
>  			pci_dev->bus->self->skip_bus_pm = true;
>  	}
>  
> -	if (pci_dev->skip_bus_pm && !pm_suspend_via_firmware()) {
> +	if (pci_dev->skip_bus_pm && pm_suspend_no_platform()) {
>  		dev_dbg(dev, "PCI PM: Skipped\n");
>  		goto Fixup;
>  	}
> @@ -925,10 +925,10 @@ static int pci_pm_resume_noirq(struct de
>  	/*
>  	 * In the suspend-to-idle case, devices left in D0 during suspend will
>  	 * stay in D0, so it is not necessary to restore or update their
> -	 * configuration here and attempting to put them into D0 again may
> -	 * confuse some firmware, so avoid doing that.
> +	 * configuration here and attempting to put them into D0 again is
> +	 * pointless, so avoid doing that.
>  	 */
> -	if (!pci_dev->skip_bus_pm || pm_suspend_via_firmware())
> +	if (!(pci_dev->skip_bus_pm && pm_suspend_no_platform()))
>  		pci_pm_default_resume_early(pci_dev);
>  
>  	pci_fixup_device(pci_fixup_resume_early, pci_dev);

I can confirm that above works for me. So ...

Tested-by: Jon Hunter <jonathanh@nvidia.com>

This looks better ...

[   52.545820] PM: suspend entry (deep)
[   52.549547] Filesystems sync: 0.000 seconds
[   52.553966] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   52.562375] OOM killer disabled.
[   52.565684] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   52.574426] printk: Suspending console(s) (use no_console_suspend to debug)
[   52.590255] r8169 0000:01:00.0 eth0: Link is Down
[   52.590483] pci_generic_config_write32: 22 callbacks suppressed
[   52.590488] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
[   52.794091] r8169 0000:01:00.0: PCI PM: Suspend power state: D3hot
[   52.794128] pcieport 0000:00:02.0: PCI PM: Suspend power state: D0
[   52.805674] Disabling non-boot CPUs ...
[   52.809257] Entering suspend state LP1
[   52.809284] Enabling non-boot CPUs ...
[   52.810184] CPU1 is up
[   52.810973] CPU2 is up
[   52.811819] CPU3 is up
[   52.822259] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
[   52.840085] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x4c may corrupt adjacent RW1C bits
[   52.840096] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x88 may corrupt adjacent RW1C bits
[   52.840101] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x90 may corrupt adjacent RW1C bits
[   52.840106] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x98 may corrupt adjacent RW1C bits
[   52.840111] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x9c may corrupt adjacent RW1C bits
[   52.840116] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0xa8 may corrupt adjacent RW1C bits
[   52.840121] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0xb0 may corrupt adjacent RW1C bits
[   52.840155] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[   52.840160] pci_bus 0000:00: 2-byte config write to 0000:00:02.0 offset 0x52 may corrupt adjacent RW1C bits
[   52.840184] pcieport 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
[   52.864252] tegra-pcie 1003000.pcie: Slot present pin change, signature: 00000004
[   53.024171] r8169 0000:01:00.0 eth0: Link is Down
[   53.376438] ata1: SATA link down (SStatus 0 SControl 300)
[   55.881131] r8169 0000:01:00.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx
[   56.012154] OOM killer enabled.
[   56.015295] Restarting tasks ... done.
[   56.019415] PM: suspend exit
[   56.045929] PM: suspend entry (deep)
[   56.049565] Filesystems sync: 0.000 seconds
[   56.053906] Freezing user space processes ... (elapsed 0.001 seconds) done.
[   56.062205] OOM killer disabled.
[   56.065462] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   56.074193] printk: Suspending console(s) (use no_console_suspend to debug)
[   56.096375] r8169 0000:01:00.0 eth0: Link is Down
[   56.304070] r8169 0000:01:00.0: PCI PM: Suspend power state: D3hot
[   56.304111] pcieport 0000:00:02.0: PCI PM: Suspend power state: D0
[   56.314134] tegra-pcie 1003000.pcie: PME Ack is not received on port: 1
[   56.325777] Disabling non-boot CPUs ...
[   56.328540] Entering suspend state LP1
[   56.328571] Enabling non-boot CPUs ...
[   56.329687] CPU1 is up
[   56.330694] CPU2 is up
[   56.331772] CPU3 is up
[   56.332396] tegra-pcie 1003000.pcie: probing port 1, using 1 lanes
[   56.350134] pcieport 0000:00:02.0: nv_msi_ht_cap_quirk didn't locate host bridge
[   56.374241] tegra-pcie 1003000.pcie: Slot present pin change, signature: 00000004
[   56.534158] r8169 0000:01:00.0 eth0: Link is Down
[   56.886516] ata1: SATA link down (SStatus 0 SControl 300)
[   59.417895] OOM killer enabled.
[   59.421025] Restarting tasks ... done.
[   59.425305] PM: suspend exit
[   60.756040] r8169 0000:01:00.0 eth0: Link is Up - 1Gbps/Full - flow control rx/tx

Thanks!
Jon

-- 
nvpublic
