Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 615ED13789D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2020 22:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgAJVmV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jan 2020 16:42:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:54302 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726952AbgAJVmU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jan 2020 16:42:20 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D827208E4;
        Fri, 10 Jan 2020 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1578692539;
        bh=hIzU4mV0UiX2r78ystdbwRn98I/yb2Bum4Wkbub1PMw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=xHtiYsmg998YCYOMFwksrXD+qR2rdJFgCqeVCl8BEOdENgohkdJFWoUU0wwWClbsP
         DrdCWvcj5K/LFalhUVIIhqfe1lGdVNKHCm4AQ/zVXYF4ZSsOeGz6VSZCB3jxWrcoV4
         OlDidMAcch7rhKACCLlckct4xHP1dRAN/I9QG39s=
Date:   Fri, 10 Jan 2020 15:42:17 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kairui Song <kasong@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        kexec@lists.infradead.org, Jerry Hoemann <jerry.hoemann@hpe.com>,
        Baoquan He <bhe@redhat.com>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Subject: Re: [RFC PATCH] PCI, kdump: Clear bus master bit upon shutdown in
 kdump kernel
Message-ID: <20200110214217.GA88274@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191225192118.283637-1-kasong@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Deepa (also working in this area)]

On Thu, Dec 26, 2019 at 03:21:18AM +0800, Kairui Song wrote:
> There are reports about kdump hang upon reboot on some HPE machines,
> kernel hanged when trying to shutdown a PCIe port, an uncorrectable
> error occurred and crashed the system.

Details?  Do you have URLs for bug reports, dmesg logs, etc?

> On the machine I can reproduce this issue, part of the topology
> looks like this:
> 
> [0000:00]-+-00.0  Intel Corporation Xeon E7 v3/Xeon E5 v3/Core i7 DMI2
>           +-01.0-[02]--
>           +-01.1-[05]--
>           +-02.0-[06]--+-00.0  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.1  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.2  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.3  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.4  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.5  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            +-00.6  Emulex Corporation OneConnect NIC (Skyhawk)
>           |            \-00.7  Emulex Corporation OneConnect NIC (Skyhawk)
>           +-02.1-[0f]--
>           +-02.2-[07]----00.0  Hewlett-Packard Company Smart Array Gen9 Controllers
> 
> When shutting down PCIe port 0000:00:02.2 or 0000:00:02.0, the machine
> will hang, depend on which device is reinitialized in kdump kernel.
> 
> If force remove unused device then trigger kdump, the problem will never
> happen:
> 
>     echo 1 > /sys/bus/pci/devices/0000\:00\:02.2/0000\:07\:00.0/remove
>     echo c > /proc/sysrq-trigger
> 
>     ... Kdump save vmcore through network, the NIC get reinitialized and
>     hpsa is untouched. Then reboot with no problem. (If hpsa is used
>     instead, shutdown the NIC in first kernel will help)
> 
> The cause is that some devices are enabled by the first kernel, but it
> don't have the chance to shutdown the device, and kdump kernel is not
> aware of it, unless it reinitialize the device.
> 
> Upon reboot, kdump kernel will skip downstream device shutdown and
> clears its bridge's master bit directly. The downstream device could
> error out as it can still send requests but upstream refuses it.

Can you help me understand the sequence of events?  If I understand
correctly, the desired sequence is:

  - user kernel boots
  - user kernel panics and kexecs to kdump kernel
  - kdump kernel writes vmcore to network or disk
  - kdump kernel reboots
  - user kernel boots

But the problem is that as part of the kdump kernel reboot,

  - kdump kernel disables bus mastering for a Root Port
  - device below the Root Port attempts DMA
  - Root Port receives DMA transaction, handles it as Unsupported
    Request, sends UR Completion to device
  - device signals uncorrectable error
  - uncorrectable error causes a crash (Or a hang?  You mention both
    and I'm not sure which it is)

Is that right so far?

> So for kdump, let kernel read the correct hardware power state on boot,
> and always clear the bus master bit of PCI device upon shutdown if the
> device is on. PCIe port driver will always shutdown all downstream
> devices first, so this should ensure all downstream devices have bus
> master bit off before clearing the bridge's bus master bit.
> 
> Signed-off-by: Kairui Song <kasong@redhat.com>
> ---
>  drivers/pci/pci-driver.c | 11 ++++++++---
>  drivers/pci/quirks.c     | 20 ++++++++++++++++++++
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index 0454ca0e4e3f..84a7fd643b4d 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -18,6 +18,7 @@
>  #include <linux/kexec.h>
>  #include <linux/of_device.h>
>  #include <linux/acpi.h>
> +#include <linux/crash_dump.h>
>  #include "pci.h"
>  #include "pcie/portdrv.h"
>  
> @@ -488,10 +489,14 @@ static void pci_device_shutdown(struct device *dev)
>  	 * If this is a kexec reboot, turn off Bus Master bit on the
>  	 * device to tell it to not continue to do DMA. Don't touch
>  	 * devices in D3cold or unknown states.
> -	 * If it is not a kexec reboot, firmware will hit the PCI
> -	 * devices with big hammer and stop their DMA any way.
> +	 * If this is kdump kernel, also turn off Bus Master, the device
> +	 * could be activated by previous crashed kernel and may block
> +	 * it's upstream from shutting down.
> +	 * Else, firmware will hit the PCI devices with big hammer
> +	 * and stop their DMA any way.
>  	 */
> -	if (kexec_in_progress && (pci_dev->current_state <= PCI_D3hot))
> +	if ((kexec_in_progress || is_kdump_kernel()) &&
> +			pci_dev->current_state <= PCI_D3hot)
>  		pci_clear_master(pci_dev);

I'm clearly missing something because this will turn off bus mastering
in cases where we previously left it enabled.

I was assuming the crash was related to a device doing DMA when the
Root Port had bus mastering disabled.  But that must be wrong.

I'd like to understand the crash/hang better because the quirk
especially is hard to connect to anything.  If the crash is because of
an AER or other PCIe error, maybe another possibility is that we could
handle it better or disable signaling of it or something.

>  }
>  
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 4937a088d7d8..c65d11ab3939 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -28,6 +28,7 @@
>  #include <linux/platform_data/x86/apple.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/switchtec.h>
> +#include <linux/crash_dump.h>
>  #include <asm/dma.h>	/* isa_dma_bridge_buggy */
>  #include "pci.h"
>  
> @@ -192,6 +193,25 @@ static int __init pci_apply_final_quirks(void)
>  }
>  fs_initcall_sync(pci_apply_final_quirks);
>  
> +/*
> + * Read the device state even if it's not enabled. The device could be
> + * activated by previous crashed kernel, this will read and correct the
> + * cached state.
> + */
> +static void quirk_read_pm_state_in_kdump(struct pci_dev *dev)
> +{
> +	u16 pmcsr;
> +
> +	if (!is_kdump_kernel())
> +		return;
> +
> +	if (dev->pm_cap) {
> +		pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +		dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +	}
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, quirk_read_pm_state_in_kdump);
> +
>  /*
>   * Decoding should be disabled for a PCI device during BAR sizing to avoid
>   * conflict. But doing so may cause problems on host bridge and perhaps other
> -- 
> 2.24.1
> 
