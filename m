Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C448736D56F
	for <lists+linux-pci@lfdr.de>; Wed, 28 Apr 2021 12:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhD1KI4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Apr 2021 06:08:56 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:16928 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbhD1KIz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Apr 2021 06:08:55 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FVZ5H6tzCzvSbV;
        Wed, 28 Apr 2021 18:05:39 +0800 (CST)
Received: from [127.0.0.1] (10.69.38.196) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.498.0; Wed, 28 Apr 2021
 18:08:02 +0800
Subject: Re: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC
To:     Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Sathyanarayanan Kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     Ethan Zhao <haifeng.zhao@intel.com>, Sinan Kaya <okaya@kernel.org>,
        "Ashok Raj" <ashok.raj@intel.com>, Keith Busch <kbusch@kernel.org>,
        <linux-pci@vger.kernel.org>, Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Stuart Hayes <stuart.w.hayes@gmail.com>,
        "Mika Westerberg" <mika.westerberg@linux.intel.com>,
        Linuxarm <linuxarm@huawei.com>
References: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
From:   Yicong Yang <yangyicong@hisilicon.com>
Message-ID: <4177f0be-5859-9a71-da06-2e67641568d7@hisilicon.com>
Date:   Wed, 28 Apr 2021 18:08:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <b70e19324bbdded90b728a5687aa78dc17c20306.1616921228.git.lukas@wunner.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.69.38.196]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lukas,

I've tested the patch on our board, but the hotplug will still be triggered sometimes.
seems the hotplug doesn't find the link down event is caused by dpc. Any further
test I can do?

Thanks.

mestuary:/$ [12508.408576] pcieport 0000:00:10.0: DPC: containment event, status:0x1f21 source:0x0000
[12508.423016] pcieport 0000:00:10.0: DPC: unmasked uncorrectable error detected
[12508.434277] pcieport 0000:00:10.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer ID)
[12508.447651] pcieport 0000:00:10.0:   device [19e5:a130] error status/mask=00008000/04400000
[12508.458279] pcieport 0000:00:10.0:    [15] CmpltAbrt              (First)
[12508.467094] pcieport 0000:00:10.0: AER:   TLP Header: 00000000 00000000 00000000 00000000
[12511.152329] pcieport 0000:00:10.0: pciehp: Slot(0): Link Down
[12511.388205] ixgbe 0000:01:00.0: can't change power state from D3hot to D0 (config space inaccessible)
[12511.490722] ixgbe 0000:01:00.0: Adapter removed
[12511.571802] ixgbe 0000:01:00.0: This device is a pre-production adapter/LOM. Please be aware there may be issues associated with your hardware.  If you are experiencing problems please contact your Intel or hardware representative who provided you with this hardware.
[12511.689904] ixgbe 0000:01:00.1: Adapter removed
[12511.703633] ixgbe 0000:01:00.1: complete
[12511.734077] pcieport 0000:00:10.0: AER: device recovery successful
[12511.752283] pci 0000:01:00.1: Removing from iommu group 1
[12511.930548] ixgbe 0000:01:00.0: removed PHC on eth0
[12511.983798] ixgbe 0000:01:00.0 eth0: failed to kill vid 0081/0
[12512.270555] ixgbe 0000:01:00.0: complete
[12512.319535] pci 0000:01:00.0: Removing from iommu group 0
[12512.423942] pcieport 0000:00:10.0: pciehp: Slot(0): Link Up
[12512.575864] pci 0000:01:00.0: config space:
[12512.587835] 00000000: 86 80 fb 10 00 00 10 00 01 00 00 02 10 00 80 00
[12512.595837] 00000010: 0c 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
[12512.603156] 00000020: 0c 00 00 00 00 00 00 00 00 00 00 00 e5 19 11 d1
[12512.610427] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 00 01 00 00
[12512.617756] 00000040: 01 50 23 48 00 20 00 00 00 00 00 00 00 00 00 00
[12512.625913] 00000050: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
[12512.635334] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.643118] 00000070: 11 a0 3f 00 04 00 00 00 04 20 00 00 00 00 00 00
[12512.651065] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.658785] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.666393] 000000a0: 10 e0 02 00 c2 8c 00 10 10 28 0b 00 82 34 02 00
[12512.674528] 000000b0: 00 00 21 10 00 00 00 00 00 00 00 00 00 00 00 00
[12512.682119] 000000c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
[12512.690464] 000000d0: 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.698428] 000000e0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.705934] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.715052] pci 0000:01:00.0: [8086:10fb] type 00 class 0x020000
[12512.724293] pci 0000:01:00.0: reg 0x10: [mem 0x00000000-0x003fffff 64bit pref]
[12512.733908] pci 0000:01:00.0: reg 0x18: [io  0x0000-0x001f]
[12512.742396] pci 0000:01:00.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[12512.751081] pci 0000:01:00.0: reg 0x30: [mem 0x00000000-0x003fffff pref]
[12512.792689] pci 0000:01:00.0: PME# supported from D0 D3hot
[12512.804557] pci 0000:01:00.0: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
[12512.814171] pci 0000:01:00.0: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[12512.827902] pci 0000:01:00.0: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[12512.836379] pci 0000:01:00.0: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[12512.870888] pci 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:10.0 (capable of 32.000 Gb/s with 5.0 GT/s PCIe x8 link)
[12512.920266] pci 0000:01:00.1: config space:
[12512.931033] 00000000: 86 80 fb 10 00 00 10 00 01 00 00 02 10 00 80 00
[12512.938796] 00000010: 0c 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00
[12512.946276] 00000020: 0c 00 00 00 00 00 00 00 00 00 00 00 e5 19 11 d1
[12512.954328] 00000030: 00 00 00 00 40 00 00 00 00 00 00 00 00 02 00 00
[12512.961790] 00000040: 01 50 23 48 00 20 00 00 00 00 00 00 00 00 00 00
[12512.969775] 00000050: 05 70 80 01 00 00 00 00 00 00 00 00 00 00 00 00
[12512.978551] 00000060: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12512.986856] 00000070: 11 a0 3f 00 04 00 00 00 04 20 00 00 00 00 00 00
[12512.994985] 00000080: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12513.002444] 00000090: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12513.009887] 000000a0: 10 e0 02 00 c2 8c 00 10 10 28 0b 00 82 34 02 00
[12513.018682] 000000b0: 00 00 21 10 00 00 00 00 00 00 00 00 00 00 00 00
[12513.026392] 000000c0: 00 00 00 00 1f 00 00 00 00 00 00 00 00 00 00 00
[12513.033932] 000000d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12513.041488] 000000e0: 03 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12513.048815] 000000f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[12513.058054] pci 0000:01:00.1: [8086:10fb] type 00 class 0x020000
[12513.067153] pci 0000:01:00.1: reg 0x10: [mem 0x00000000-0x003fffff 64bit pref]
[12513.076650] pci 0000:01:00.1: reg 0x18: [io  0x0000-0x001f]
[12513.087241] pci 0000:01:00.1: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[12513.097474] pci 0000:01:00.1: reg 0x30: [mem 0x00000000-0x003fffff pref]
[12513.131437] pci 0000:01:00.1: PME# supported from D0 D3hot
[12513.144237] pci 0000:01:00.1: reg 0x184: [mem 0x00000000-0x00003fff 64bit pref]
[12513.153708] pci 0000:01:00.1: VF(n) BAR0 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR0 for 64 VFs)
[12513.166783] pci 0000:01:00.1: reg 0x190: [mem 0x00000000-0x00003fff 64bit pref]
[12513.175242] pci 0000:01:00.1: VF(n) BAR3 space: [mem 0x00000000-0x000fffff 64bit pref] (contains BAR3 for 64 VFs)
[12513.232409] pcieport 0000:00:10.0: ASPM: current common clock configuration is inconsistent, reconfiguring
[12513.251438] pci 0000:01:00.0: BAR 0: assigned [mem 0x40000000000-0x400003fffff 64bit pref]
[12513.262964] pci 0000:01:00.0: BAR 6: assigned [mem 0xe0000000-0xe03fffff pref]
[12513.271543] pci 0000:01:00.1: BAR 0: assigned [mem 0x40000400000-0x400007fffff 64bit pref]
[12513.282159] pci 0000:01:00.1: BAR 6: assigned [mem 0xe0400000-0xe07fffff pref]
[12513.291436] pci 0000:01:00.0: BAR 4: assigned [mem 0x40000800000-0x40000803fff 64bit pref]
[12513.303741] pci 0000:01:00.0: BAR 7: assigned [mem 0x40000804000-0x40000903fff 64bit pref]
[12513.314687] pci 0000:01:00.0: BAR 10: assigned [mem 0x40000904000-0x40000a03fff 64bit pref]
[12513.324784] pci 0000:01:00.1: BAR 4: assigned [mem 0x40000a04000-0x40000a07fff 64bit pref]
[12513.335219] pci 0000:01:00.1: BAR 7: assigned [mem 0x40000a08000-0x40000b07fff 64bit pref]
[12513.345013] pci 0000:01:00.1: BAR 10: assigned [mem 0x40000b08000-0x40000c07fff 64bit pref]
[12513.355348] pci 0000:01:00.0: BAR 2: assigned [io  0x1000-0x101f]
[12513.362686] pci 0000:01:00.1: BAR 2: assigned [io  0x1020-0x103f]
[12513.371030] pcieport 0000:00:10.0: PCI bridge to [bus 01]
[12513.378104] pcieport 0000:00:10.0:   bridge window [io  0x1000-0x1fff]
[12513.386432] pcieport 0000:00:10.0:   bridge window [mem 0xe0000000-0xe07fffff]
[12513.395226] pcieport 0000:00:10.0:   bridge window [mem 0x40000000000-0x40000dfffff 64bit pref]
[12513.450094] ixgbe 0000:01:00.0: Adding to iommu group 0
[12513.502381] ixgbe 0000:01:00.0: enabling device (0140 -> 0142)
[12514.300429] ixgbe 0000:01:00.0: Multiqueue Enabled: Rx Queue count = 4, Tx Queue count = 4 XDP Queue count = 0
[12514.318622] ixgbe 0000:01:00.0: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:10.0 (capable of 32.000 Gb/s with 5.0 GT/s PCIe x8 link)
[12514.336916] ixgbe 0000:01:00.0: MAC: 2, PHY: 19, SFP+: 5, PBA No: FFFFFF-0FF
[12514.345832] ixgbe 0000:01:00.0: 40:7d:0f:97:06:f8
[12514.680098] ixgbe 0000:01:00.0: Intel(R) 10 Gigabit Network Connection
[12514.731201] libphy: ixgbe-mdio: probed
[12514.777044] ixgbe 0000:01:00.1: Adding to iommu group 1
[12514.843097] ixgbe 0000:01:00.1: enabling device (0140 -> 0142)
[12516.608090] ixgbe 0000:01:00.1: Multiqueue Enabled: Rx Queue count = 4, Tx Queue count = 4 XDP Queue count = 0
[12516.626321] ixgbe 0000:01:00.1: 4.000 Gb/s available PCIe bandwidth, limited by 2.5 GT/s PCIe x2 link at 0000:00:10.0 (capable of 32.000 Gb/s with 5.0 GT/s PCIe x8 link)
[12516.644830] ixgbe 0000:01:00.1: MAC: 2, PHY: 1, PBA No: FFFFFF-0FF
[12516.652816] ixgbe 0000:01:00.1: 40:7d:0f:97:06:f9
[12516.992943] ixgbe 0000:01:00.1: Intel(R) 10 Gigabit Network Connection
[12517.046108] libphy: ixgbe-mdio: probed

On 2021/3/28 16:52, Lukas Wunner wrote:
> Downstream Port Containment (PCIe Base Spec, sec. 6.2.10) disables the
> link upon an error and attempts to re-enable it when instructed by the
> DPC driver.
> 
> A slot which is both DPC- and hotplug-capable is currently brought down
> by pciehp once DPC is triggered (due to the link change) and brought up
> on successful recovery.  That's undesirable, the slot should remain up
> so that the hotplugged device remains bound to its driver.  DPC notifies
> the driver of the error and of successful recovery in pcie_do_recovery()
> and the driver may then restore the device to working state.
> 
> Moreover, Sinan points out that turning off slot power by pciehp may
> foil recovery by DPC:  Power off/on is a cold reset concurrently to
> DPC's warm reset.  Sathyanarayanan reports extended delays or failure
> in link retraining by DPC if pciehp brings down the slot.
> 
> Fix by detecting whether a Link Down event is caused by DPC and awaiting
> recovery if so.  On successful recovery, ignore both the Link Down and
> the subsequent Link Up event.
> 
> Afterwards, check whether the link is down to detect surprise-removal or
> another DPC event immediately after DPC recovery.  Ensure that the
> corresponding DLLSC event is not ignored by synthesizing it and
> invoking irq_wake_thread() to trigger a re-run of pciehp_ist().
> 
> The IRQ threads of the hotplug and DPC drivers, pciehp_ist() and
> dpc_handler(), race against each other.  If pciehp is faster than DPC,
> it will wait until DPC recovery completes.
> 
> Recovery consists of two steps:  The first step (waiting for link
> disablement) is recognizable by pciehp through a set DPC Trigger Status
> bit.  The second step (waiting for link retraining) is recognizable
> through a newly introduced PCI_DPC_RECOVERING flag.
> 
> If DPC is faster than pciehp, neither of the two flags will be set and
> pciehp may glean the recovery status from the new PCI_DPC_RECOVERED flag.
> The flag is zero if DPC didn't occur at all, hence DLLSC events are not
> ignored by default.
> 
> This commit draws inspiration from previous attempts to synchronize DPC
> with pciehp:
> 
> By Sinan Kaya, August 2018:
> https://lore.kernel.org/linux-pci/20180818065126.77912-1-okaya@kernel.org/
> 
> By Ethan Zhao, October 2020:
> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/
> 
> By Sathyanarayanan Kuppuswamy, March 2021:
> https://lore.kernel.org/linux-pci/59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com/
> 
> Reported-by: Sinan Kaya <okaya@kernel.org>
> Reported-by: Ethan Zhao <haifeng.zhao@intel.com>
> Reported-by: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ashok Raj <ashok.raj@intel.com>
> Cc: Keith Busch <kbusch@kernel.org>
> ---
>  drivers/pci/hotplug/pciehp_hpc.c | 36 ++++++++++++++++
>  drivers/pci/pci.h                |  4 ++
>  drivers/pci/pcie/dpc.c           | 73 +++++++++++++++++++++++++++++---
>  3 files changed, 108 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index fb3840e222ad..9d06939736c0 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -563,6 +563,32 @@ void pciehp_power_off_slot(struct controller *ctrl)
>  		 PCI_EXP_SLTCTL_PWR_OFF);
>  }
>  
> +static void pciehp_ignore_dpc_link_change(struct controller *ctrl,
> +					  struct pci_dev *pdev, int irq)
> +{
> +	/*
> +	 * Ignore link changes which occurred while waiting for DPC recovery.
> +	 * Could be several if DPC triggered multiple times consecutively.
> +	 */
> +	synchronize_hardirq(irq);
> +	atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> +	if (pciehp_poll_mode)
> +		pcie_capability_write_word(pdev, PCI_EXP_SLTSTA,
> +					   PCI_EXP_SLTSTA_DLLSC);
> +	ctrl_info(ctrl, "Slot(%s): Link Down/Up ignored (recovered by DPC)\n",
> +		  slot_name(ctrl));
> +
> +	/*
> +	 * If the link is unexpectedly down after successful recovery,
> +	 * the corresponding link change may have been ignored above.
> +	 * Synthesize it to ensure that it is acted on.
> +	 */
> +	down_read(&ctrl->reset_lock);
> +	if (!pciehp_check_link_active(ctrl))
> +		pciehp_request(ctrl, PCI_EXP_SLTSTA_DLLSC);
> +	up_read(&ctrl->reset_lock);
> +}
> +
>  static irqreturn_t pciehp_isr(int irq, void *dev_id)
>  {
>  	struct controller *ctrl = (struct controller *)dev_id;
> @@ -706,6 +732,16 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
>  				      PCI_EXP_SLTCTL_ATTN_IND_ON);
>  	}
>  
> +	/*
> +	 * Ignore Link Down/Up events caused by Downstream Port Containment
> +	 * if recovery from the error succeeded.
> +	 */
> +	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
> +	    ctrl->state == ON_STATE) {
> +		events &= ~PCI_EXP_SLTSTA_DLLSC;
> +		pciehp_ignore_dpc_link_change(ctrl, pdev, irq);
> +	}
> +
>  	/*
>  	 * Disable requests have higher priority than Presence Detect Changed
>  	 * or Data Link Layer State Changed events.
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 9684b468267f..e5ae5e860431 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -392,6 +392,8 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
>  
>  /* pci_dev priv_flags */
>  #define PCI_DEV_ADDED 0
> +#define PCI_DPC_RECOVERED 1
> +#define PCI_DPC_RECOVERING 2
>  
>  static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
>  {
> @@ -446,10 +448,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
>  void pci_dpc_init(struct pci_dev *pdev);
>  void dpc_process_error(struct pci_dev *pdev);
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
> +bool pci_dpc_recovered(struct pci_dev *pdev);
>  #else
>  static inline void pci_save_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
>  static inline void pci_dpc_init(struct pci_dev *pdev) {}
> +static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
>  #endif
>  
>  #ifdef CONFIG_PCIEPORTBUS
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index e05aba86a317..da47c448db8a 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -71,6 +71,57 @@ void pci_restore_dpc_state(struct pci_dev *dev)
>  	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
>  }
>  
> +static DECLARE_WAIT_QUEUE_HEAD(dpc_completed_waitqueue);
> +
> +#ifdef CONFIG_HOTPLUG_PCI_PCIE
> +static bool dpc_completed(struct pci_dev *pdev)
> +{
> +	u16 status;
> +
> +	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
> +	if ((status != 0xffff) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
> +		return false;
> +
> +	if (test_bit(PCI_DPC_RECOVERING, &pdev->priv_flags))
> +		return false;
> +
> +	return true;
> +}
> +
> +/**
> + * pci_dpc_recovered - whether DPC triggered and has recovered successfully
> + * @pdev: PCI device
> + *
> + * Return true if DPC was triggered for @pdev and has recovered successfully.
> + * Wait for recovery if it hasn't completed yet.  Called from the PCIe hotplug
> + * driver to recognize and ignore Link Down/Up events caused by DPC.
> + */
> +bool pci_dpc_recovered(struct pci_dev *pdev)
> +{
> +	struct pci_host_bridge *host;
> +
> +	if (!pdev->dpc_cap)
> +		return false;
> +
> +	/*
> +	 * Synchronization between hotplug and DPC is not supported
> +	 * if DPC is owned by firmware and EDR is not enabled.
> +	 */
> +	host = pci_find_host_bridge(pdev->bus);
> +	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
> +		return false;
> +
> +	/*
> +	 * Need a timeout in case DPC never completes due to failure of
> +	 * dpc_wait_rp_inactive().
> +	 */
> +	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
> +			   msecs_to_jiffies(3000));
> +
> +	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +}
> +#endif /* CONFIG_HOTPLUG_PCI_PCIE */
> +
>  static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>  {
>  	unsigned long timeout = jiffies + HZ;
> @@ -91,8 +142,11 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
>  
>  pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  {
> +	pci_ers_result_t ret;
>  	u16 cap;
>  
> +	set_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
> +
>  	/*
>  	 * DPC disables the Link automatically in hardware, so it has
>  	 * already been reset by the time we get here.
> @@ -106,18 +160,27 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
>  	if (!pcie_wait_for_link(pdev, false))
>  		pci_info(pdev, "Data Link Layer Link Active not cleared in 1000 msec\n");
>  
> -	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
> -		return PCI_ERS_RESULT_DISCONNECT;
> +	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev)) {
> +		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +		ret = PCI_ERS_RESULT_DISCONNECT;
> +		goto out;
> +	}
>  
>  	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
>  			      PCI_EXP_DPC_STATUS_TRIGGER);
>  
>  	if (!pcie_wait_for_link(pdev, true)) {
>  		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> +		clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +		ret = PCI_ERS_RESULT_DISCONNECT;
> +	} else {
> +		set_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
> +		ret = PCI_ERS_RESULT_RECOVERED;
>  	}
> -
> -	return PCI_ERS_RESULT_RECOVERED;
> +out:
> +	clear_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
> +	wake_up_all(&dpc_completed_waitqueue);
> +	return ret;
>  }
>  
>  static void dpc_process_rp_pio_error(struct pci_dev *pdev)
> 

