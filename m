Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86F667490C2
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jul 2023 00:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjGEWBl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Jul 2023 18:01:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjGEWBk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 5 Jul 2023 18:01:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C821E9F;
        Wed,  5 Jul 2023 15:01:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5C93D6173D;
        Wed,  5 Jul 2023 22:01:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF84C433C7;
        Wed,  5 Jul 2023 22:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688594497;
        bh=JhzkH2YdPO3GQOfHGMSYMJsXn9PHFJBdcpVhY6A9apA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=pJk2ShldXJ2dkQnuPI/oJ1Ta/diLXBcorCDWG6BrvZstC11qsKAKAYJmrMtZzz54Y
         n+A006ZHr+3mTltI/ME2tEC9tPcgzJxJU3BfXbBZkgiRJoi7WrM4shJ56eiNdJ/VJM
         rKTxeQteeDIKUpUYudlIWwyTc1EgIv6hva5+5jE7RYreGsKB9u37BQi3lB341gkNY8
         ha2wVLpo9A4sHK/tMeSqIRc6GTvxtU1EzP34zoXGiq7y5AwFo26yPIQL2FEe8KiRhy
         AxsMvtXZYxjAiN4oOsVqQP6kGMXa6vlMsZCTqQV4528eUerLIa+8I1kJta8D7KIvo5
         +UB9AEQm1YrpQ==
Date:   Wed, 5 Jul 2023 17:01:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc:     mika.westerberg@linux.intel.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Ask for a regression issue of vfio-pci driver with Intel DG2
 (A770) discrete graphics card from Linux 6.1
Message-ID: <20230705220135.GA75408@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c836bf88-d961-040d-b15e-52feb8e11f8d@intel.com>
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 03, 2023 at 01:37:42PM +0300, Gwan-gyeong Mun wrote:
> Since Linux 6.2 kernel (same happens in Linux 6.4.1), loading vfio-pci
> driver to a specific HW (Intel DG2 A770) target does not work properly.
> (It works fine on Linux 6.1 kernel with the same HW).

Thank you very much for the report!

Does this problem only happen with vfio-pci?  d8d2b65a940b appeared in
v6.2-rc1 (Dec 25, 2022), so I would think somebody would have used DG2
on a v6.2 or newer kernel.

Can you please collect the complete "sudo lspci -vv" output (not just
the DG2 items)?  We need info about the switch ports and all the
capabilities, since d8d2b65a940b has to do with switch ports, AER, and
MSI.

Also, please collect the complete dmesg log with v6.4.1 (which does
not work) and v6.4.1 with d8d2b65a940b reverted (which should work).

I know you said that on v6.4.1 with d8d2b65a940b reverted, the system
boots but there's still a problem with suspend.  I'm intentionally
ignoring this problem for now.  After we figure out the boot-time
problem with the DG2 being left in D3cold, we can come back to the
suspend problem.

Bjorn

> The configuration and hardware information used is described in [1].
> 
> Starting with the Linux 6.2 kernel, the following log is output to dmesg
> when a problem occurs.
> ...
> [ 15.049948] pcieport 0000:00:01.0: Data Link Layer Link Active not set in
> 1000 msec
> [ 15.050024] pcieport 0000:01:00.0: Unable to change power state from D3cold
> to D0, device inaccessible
> [ 15.051067] pcieport 0000:02:01.0: Unable to change power state from D3cold
> to D0, device inaccessible
> [ 15.052141] pcieport 0000:02:04.0: Unable to change power state from D3cold
> to D0, device inaccessible
> [ 17.286554] vfio-pci 0000:03:00.0: not ready 1023ms after resume; giving up
> [ 17.286553] vfio-pci 0000:04:00.0: not ready 1023ms after resume; giving up
> [ 17.286576] vfio-pci 0000:03:00.0: Unable to change power state from D3cold
> to D0, device inaccessible
> [ 17.286578] vfio-pci 0000:04:00.0: Unable to change power state from D3cold
> to D0, device inaccessible
> ...
> 
> And if you check the DG2 hardware using the "lspci -nnv" command, you will
> see that "Flags:" is displayed as "!!! Unknown header type 7f" as shown
> below. [2]
> The normal output log looks like [3].
> 
> This issue has been occurring since the patch below was applied. [4]
> 
> d8d2b65a940bb497749d66bdab59b530901d3854 is the first bad commit
> commit d8d2b65a940bb497749d66bdab59b530901d3854
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Dec 9 11:01:00 2022 -0600
> 
>     PCI/portdrv: Allow AER service only for Root Ports & RCECs
> 
> 
> Rolling back the [4] patch makes it work on boot with the latest version of
> the kernel, but the same problem still occurs after "suspend to s2idle".
> This problem existed even before applying [4].
> 
> Suspend has been tested with the following command.
> $ systemctl suspend -i
> 
> $ cat /sys/power/mem_sleep
> [s2idle] deep
> 
> 
> Here is the log that is issued when testing suspend to s2idle. [5]
> 
> 
> Br,
> 
> G.G.
> 
> 
> [1] Env:
> 
> NUC: intel-nuc-13-extreme-kit-nuc13rngi7 (https://ark.intel.com/content/www/us/en/ark/products/229784/intel-nuc-13-extreme-kit-nuc13rngi7.html)
> (MB: Z690, CPU: RPL-S i13700k)
> 
> PCIE Card: Intel A770 GPU
> 
> Add boot parameter: intel_iommu=on iommu=pt
> 
> $ lspci -nn |grep DG2
> 03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A770]
> [8086:56a0] (rev 08)
> 04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller
> [8086:4f90]
> 
> 
> $ cat /etc/modprobe.d/vfio.conf
> 
> options vfio-pci ids=8086:56a0,8086:4f90
> softdep drm pre: vfio-pci
> 
> [2]
> 03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A770]
> [8086:56a0] (rev 08) (prog-if 00 [VGA controller])
> 	Subsystem: Intel Corporation Device [8086:1020]
> 	!!! Unknown header type 7f
> 	Memory at 93000000 (64-bit, non-prefetchable) [size=16M]
> 	Memory at 6000000000 (64-bit, prefetchable) [size=16G]
> 	Expansion ROM at 94000000 [disabled] [size=2M]
> 	Kernel driver in use: vfio-pci
> 	Kernel modules: i915
> 
> 04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller
> [8086:4f90]
> 	Subsystem: Intel Corporation Device [8086:1020]
> 	!!! Unknown header type 7f
> 	Memory at 94300000 (64-bit, non-prefetchable) [size=16K]
> 	Kernel driver in use: vfio-pci
> 	Kernel modules: snd_hda_intel
> 
> 
> [3]
> 03:00.0 VGA compatible controller [0300]: Intel Corporation DG2 [Arc A770]
> [8086:56a0] (rev 08) (prog-if 00 [VGA controller])
> 	Subsystem: Intel Corporation Device [8086:1020]
> 	Flags: bus master, fast devsel, latency 0, IOMMU group 19
> 	Memory at 93000000 (64-bit, non-prefetchable) [size=16M]
> 	Memory at 6000000000 (64-bit, prefetchable) [size=16G]
> 	Expansion ROM at 94000000 [disabled] [size=2M]
> 	Capabilities: <access denied>
> 	Kernel driver in use: vfio-pci
> 	Kernel modules: i915
> 
> 04:00.0 Audio device [0403]: Intel Corporation DG2 Audio Controller
> [8086:4f90]
> 	Subsystem: Intel Corporation Device [8086:1020]
> 	Flags: fast devsel, IOMMU group 20
> 	Memory at 94300000 (64-bit, non-prefetchable) [disabled] [size=16K]
> 	Capabilities: <access denied>
> 	Kernel driver in use: vfio-pci
> 	Kernel modules: snd_hda_intel
> 
> 
> [4]
> commit d8d2b65a940bb497749d66bdab59b530901d3854
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Fri Dec 9 11:01:00 2022 -0600
> 
>     PCI/portdrv: Allow AER service only for Root Ports & RCECs
> 
>     Previously portdrv allowed the AER service for any device with an AER
>     capability (assuming Linux had control of AER) even though the AER
> service
>     driver only attaches to Root Port and RCECs.
> 
>     Because get_port_device_capability() included AER for non-RP, non-RCEC
>     devices, we tried to initialize the AER IRQ even though these devices
>     don't generate AER interrupts.
> 
>     Intel DG1 and DG2 discrete graphics cards contain a switch leading to a
>     GPU.  The switch supports AER but not MSI, so initializing an AER IRQ
>     failed, and portdrv failed to claim the switch port at all.  The GPU
> itself
>     could be suspended, but the switch could not be put in a low-power state
>     because it had no driver.
> 
>     Don't allow the AER service on non-Root Port, non-Root Complex Event
>     Collector devices.  This means we won't enable Bus Mastering if the
> device
>     doesn't require MSI, the AER service will not appear in sysfs, and the
> AER
>     service driver will not bind to the device.
> 
>     Link: https://lore.kernel.org/r/20221207084105.84947-1-mika.westerberg@linux.intel.com
>     Link:
> https://lore.kernel.org/r/20221210002922.1749403-1-helgaas@kernel.org
>     Based-on-patch-by: Mika Westerberg <mika.westerberg@linux.intel.com>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     Reviewed-by: Kuppuswamy Sathyanarayanan
> <sathyanarayanan.kuppuswamy@linux.intel.com>
> 
> diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
> index a6c4225505d5..8b16e96ec15c 100644
> --- a/drivers/pci/pcie/portdrv.c
> +++ b/drivers/pci/pcie/portdrv.c
> @@ -232,7 +232,9 @@ static int get_port_device_capability(struct pci_dev
> *dev)
>         }
> 
>  #ifdef CONFIG_PCIEAER
> -       if (dev->aer_cap && pci_aer_available() &&
> +       if ((pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT ||
> +             pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC) &&
> +           dev->aer_cap && pci_aer_available() &&
>             (pcie_ports_native || host->native_aer))
>                 services |= PCIE_PORT_SERVICE_AER;
>  #endif
> 
> 
> [5]
> [   71.995824] PM: suspend entry (s2idle)
> [   72.000793] Filesystems sync: 0.004 seconds
> [   72.153926] Freezing user space processes
> [   72.156234] Freezing user space processes completed (elapsed 0.002
> seconds)
> [   72.156244] OOM killer disabled.
> [   72.156246] Freezing remaining freezable tasks
> [   72.157616] Freezing remaining freezable tasks completed (elapsed 0.001
> seconds)
> [   72.157619] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [   73.756457] ACPI: EC: interrupt blocked
> [   75.103988] ucsi_acpi USBC000:00: ucsi_handle_connector_change:
> GET_CONNECTOR_STATUS failed (-5)
> [   84.052478] ACPI: EC: interrupt unblocked
> [   86.085388] pcieport 0000:00:01.0: Data Link Layer Link Active not set in
> 1000 msec
> [   86.085523] pcieport 0000:01:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [   86.086984] pci 0000:02:01.0: Unable to change power state from D3cold to
> D0, device inaccessible
> [   86.087005] pci 0000:02:04.0: Unable to change power state from D3cold to
> D0, device inaccessible
> [   88.335403] vfio-pci 0000:04:00.0: not ready 1023ms after resume; waiting
> [   88.335427] vfio-pci 0000:03:00.0: not ready 1023ms after resume; waiting
> [   89.375444] vfio-pci 0000:04:00.0: not ready 2047ms after resume; waiting
> [   89.375471] vfio-pci 0000:03:00.0: not ready 2047ms after resume; waiting
> [   91.615418] vfio-pci 0000:04:00.0: not ready 4095ms after resume; waiting
> [   91.615439] vfio-pci 0000:03:00.0: not ready 4095ms after resume; waiting
> [   95.882059] vfio-pci 0000:04:00.0: not ready 8191ms after resume; waiting
> [   95.882081] vfio-pci 0000:03:00.0: not ready 8191ms after resume; waiting
> [  104.202062] vfio-pci 0000:04:00.0: not ready 16383ms after resume;
> waiting
> [  104.202066] vfio-pci 0000:03:00.0: not ready 16383ms after resume;
> waiting
> [  121.482058] vfio-pci 0000:04:00.0: not ready 32767ms after resume;
> waiting
> [  121.482067] vfio-pci 0000:03:00.0: not ready 32767ms after resume;
> waiting
> [  155.615409] vfio-pci 0000:04:00.0: not ready 65535ms after resume; giving
> up
> [  155.615412] vfio-pci 0000:03:00.0: not ready 65535ms after resume; giving
> up
> [  155.633757] i915 0000:00:02.0: [drm] GT0: GuC firmware
> i915/tgl_guc_70.bin version 70.5.1
> [  155.633761] i915 0000:00:02.0: [drm] GT0: HuC firmware i915/tgl_huc.bin
> version 7.9.3
> [  155.636177] i915 0000:00:02.0: [drm] GT0: HuC: authenticated!
> [  155.636860] i915 0000:00:02.0: [drm] GT0: GUC: submission enabled
> [  155.636860] i915 0000:00:02.0: [drm] GT0: GUC: SLPC enabled
> [  155.637228] i915 0000:00:02.0: [drm] GT0: GUC: RC enabled
> [  155.661583] nvme nvme0: Shutdown timeout set to 10 seconds
> [  155.663188] nvme nvme0: 24/0/0 default/read/poll queues
> [  155.674267] iwlwifi 0000:00:14.3: WRT: Invalid buffer destination
> [  155.823379] ucsi_acpi USBC000:00: possible UCSI driver bug 1
> [  155.823390] ucsi_acpi USBC000:00: failed to re-enable notifications (-22)
> [  155.833326] iwlwifi 0000:00:14.3: WFPM_UMAC_PD_NOTIFICATION: 0x1f
> [  155.833358] iwlwifi 0000:00:14.3: WFPM_LMAC2_PD_NOTIFICATION: 0x0
> [  155.833367] iwlwifi 0000:00:14.3: WFPM_AUTH_KEY_0: 0x90
> [  155.833377] iwlwifi 0000:00:14.3: CNVI_SCU_SEQ_DATA_DW9: 0x960
> [  155.942363] ata6: SATA link down (SStatus 4 SControl 300)
> [  155.942537] ata5: SATA link down (SStatus 4 SControl 300)
> [  156.030241] mei_hdcp 0000:00:16.0-b638ab7e-94e2-4ea2-a552-d1c54b627f04:
> bound 0000:00:02.0 (ops i915_hdcp_ops [i915])
> [  156.030830] OOM killer enabled.
> [  156.030831] Restarting tasks ...
> [  156.030894] mei_pxp 0000:00:16.0-fbf6fcf1-96cf-4e2e-a6a6-1bab8cbe36b1:
> bound 0000:00:02.0 (ops i915_pxp_tee_component_ops [i915])
> [  156.031827] done.
> [  156.031837] random: crng reseeded on system resumption
> [  156.036058] PM: suspend exit
> [  158.962881] wlp0s20f3: authenticate with 4c:ed:fb:a0:7f:6c
> [  158.966647] wlp0s20f3: send auth to 4c:ed:fb:a0:7f:6c (try 1/3)
> [  159.001337] wlp0s20f3: authenticated
> [  159.001858] wlp0s20f3: associate with 4c:ed:fb:a0:7f:6c (try 1/3)
> [  159.002882] wlp0s20f3: RX AssocResp from 4c:ed:fb:a0:7f:6c (capab=0x11
> status=0 aid=1)
> [  159.010807] wlp0s20f3: associated
> [  159.159528] IPv6: ADDRCONF(NETDEV_CHANGE): wlp0s20f3: link becomes ready
> [  287.875205] vfio-pci 0000:04:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [  287.936500] vfio-pci 0000:04:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [  289.414087] vfio-pci 0000:03:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
> [  289.475297] vfio-pci 0000:03:00.0: Unable to change power state from
> D3cold to D0, device inaccessible
