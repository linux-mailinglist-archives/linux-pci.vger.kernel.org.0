Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9507A28E2D3
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 17:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbgJNPH6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 11:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730429AbgJNPH6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 11:07:58 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19620C061755;
        Wed, 14 Oct 2020 08:07:58 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id md26so5286685ejb.10;
        Wed, 14 Oct 2020 08:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tz0eqfslGCtD/lQYwWiAEiQqoA126gnp/sZfpKuGHgA=;
        b=mqX1xatjNt26Vz+Qc5Dwti3ufvgYkhZ3rEqxzGO78GH25CM61y5X3THKIjQ10sX+KV
         HiBuV/IhYshNoPAIIWpUdR3fya/i91Zvc5I1bvmYhjSxcBNV9D1cGqGMWPviFUDmwMFd
         CLSeSGENk0SlX3YyLJgDxmmCPYL2qom6FrFqjg2IG/9ccYub5b19U0xVF8YaZXPtMj5b
         W/OsF/wD6b7H2GQ57ts2l5P25s0HRPD+TH15UGx4g8gfKg/7o1KWw5S6dNPDzqVAVeXh
         EiZWs596Z+1gK9xbPcHHxOEtV349+Io/ad1NxFvWONp7qSXIP1NaH4cl6D6n90n8sM7F
         bogQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tz0eqfslGCtD/lQYwWiAEiQqoA126gnp/sZfpKuGHgA=;
        b=XYilnk0s6Jcju8A7Vn0z5LAGkTztvwEJhFKMq5PHa+ARQ7t4FgLGEPDXRgmFYGM/pO
         LUtgRuTbhpsjTagKUSUovarFOdzILD3pzeELTRHL9A7In8+gaf8vhRXOk46tmXaDvp20
         D2oUPThZsjqkeei2T6KJnBPKmzaQUenj6zmEKvoNCbMFdQERqXf6IObRUXJaQhK20R5I
         nQ5NV06yoUDapcEaw83DTATAWeP3aEbihZvwJa8pYO6/YlMhBEYhOmimUhDOoLPdl4Qm
         hGd/e1tfkYEhcX1hxXnAY7NiHZT1x2/zn/Pi3/MBMxKUXyoPA44z6cX3KlGnqxu4vM7G
         cW0w==
X-Gm-Message-State: AOAM530zQ25FON3VjcWiub6fR/iqvtjbrBTeRR2WBm5cEN9jyZLBKuPH
        m2OGC2lOomL5dfm3IA1VHXKBQuXJQ6AhzBkWW7I=
X-Google-Smtp-Source: ABdhPJxjMRN+Iy/BacyyZj2A5KOSvEws9JwhqkTXaBV9VY0W96297nLgwKcqubXDKoi/gWH7OmY8511yk85Lq2OUkhc=
X-Received: by 2002:a17:906:6409:: with SMTP id d9mr5737742ejm.344.1602688076530;
 Wed, 14 Oct 2020 08:07:56 -0700 (PDT)
MIME-Version: 1.0
References: <546d346644654915877365b19ea534378db0894d.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <d97541df3b44822e0d085ffa058e9e7c0ba05214.1602663397.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 14 Oct 2020 23:07:44 +0800
Message-ID: <CAKF3qh3nnLaKUAbBdhdXwzknasTWmLFTjB7gz65vjzpHP4Y46Q@mail.gmail.com>
Subject: Re: [PATCH v6 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     Kuppuswamy Sathyanarayanan <sathyanarayanan.nkuppuswamy@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Sinan Kaya <okaya@kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ashok Raj <ashok.raj@intel.com>,
        "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 14, 2020 at 5:00 PM Kuppuswamy Sathyanarayanan
<sathyanarayanan.nkuppuswamy@gmail.com> wrote:
>
> Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> merged fatal and non-fatal error recovery paths, and also made
> recovery code depend on hotplug handler for "remove affected
> device + rescan" support. But this change also complicated the
> error recovery path and which in turn led to the following
> issues.
>
> 1. We depend on hotplug handler for removing the affected
> devices/drivers on DLLSC LINK down event (on DPC event
> trigger) and DPC handler for handling the error recovery. Since
> both handlers operate on same set of affected devices, it leads
> to race condition, which in turn leads to  NULL pointer
> exceptions or error recovery failures.You can find more details
> about this issue in following link.
>
> https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t
>
> 2. For non-hotplug capable devices fatal (DPC) error recovery
> is currently broken. Current fatal error recovery implementation
> relies on PCIe hotplug (pciehp) handler for detaching and
> re-enumerating the affected devices/drivers. So when dealing with
> non-hotplug capable devices, recovery code does not restore the state
> of the affected devices correctly. You can find more details about
> this issue in the following links.
>
> https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
> https://lore.kernel.org/linux-pci/12115.1588207324@famine/
> https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/
>
> In order to fix the above two issues, we should stop relying on hotplug
  Yes, it doesn't rely on hotplug handler to remove and rescan the device,
but it couldn't prevent hotplug drivers from doing another replicated
removal/rescanning.
it doesn't make sense to leave another useless removal/rescanning there.
Maybe that's why these two paths were merged to one and made it rely on
hotplug.

> handler for cleaning the affected devices/drivers and let error recovery
> handler own this functionality. So this patch reverts Commit bdb5ac85777d
> ("PCI/ERR: Handle fatal error recovery") and re-introduce the  "remove
> affected device + rescan"  functionality in fatal error recovery handler.
>
> Also holding pci_lock_rescan_remove() will prevent the race between hotplug
> and DPC handler.
>
> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Reviewed-by: Sinan Kaya <okaya@kernel.org>
> ---
>  Changes since v4:
>   * Added new interfaces for error recovery (pcie_do_fatal_recovery()
>     and pcie_do_nonfatal_recovery()).
>
>  Changes since v5:
>   * Fixed static/non-static declartion issue.
>
>  Documentation/PCI/pci-error-recovery.rst | 47 ++++++++++------
>  Documentation/PCI/pcieaer-howto.rst      |  2 +-
>  drivers/pci/pci.h                        |  5 +-
>  drivers/pci/pcie/aer.c                   | 10 ++--
>  drivers/pci/pcie/dpc.c                   |  2 +-
>  drivers/pci/pcie/edr.c                   |  2 +-
>  drivers/pci/pcie/err.c                   | 70 ++++++++++++++++++------
>  7 files changed, 94 insertions(+), 44 deletions(-)
>
> diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
> index 84ceebb08cac..830c8af5838b 100644
> --- a/Documentation/PCI/pci-error-recovery.rst
> +++ b/Documentation/PCI/pci-error-recovery.rst
> @@ -115,7 +115,7 @@ The actual steps taken by a platform to recover from a PCI error
>  event will be platform-dependent, but will follow the general
>  sequence described below.
>
> -STEP 0: Error Event
> +STEP 0: Error Event: ERR_NONFATAL
>  -------------------
>  A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
>  is isolated, in that all I/O is blocked: all reads return 0xffffffff,
> @@ -160,10 +160,10 @@ particular, if the platform doesn't isolate slots), and recovery
>  proceeds to STEP 2 (MMIO Enable).
>
>  If any driver requested a slot reset (by returning PCI_ERS_RESULT_NEED_RESET),
> -then recovery proceeds to STEP 4 (Slot Reset).
> +then recovery proceeds to STEP 3 (Slot Reset).
>
>  If the platform is unable to recover the slot, the next step
> -is STEP 6 (Permanent Failure).
> +is STEP 5 (Permanent Failure).
>
>  .. note::
>
> @@ -198,7 +198,7 @@ reset or some such, but not restart operations. This callback is made if
>  all drivers on a segment agree that they can try to recover and if no automatic
>  link reset was performed by the HW. If the platform can't just re-enable IOs
>  without a slot reset or a link reset, it will not call this callback, and
> -instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
> +instead will have gone directly to STEP 3 (Slot Reset)
>
>  .. note::
>
> @@ -233,18 +233,12 @@ The driver should return one of the following result codes:
>
>  The next step taken depends on the results returned by the drivers.
>  If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
> -proceeds to either STEP3 (Link Reset) or to STEP 5 (Resume Operations).
> +proceeds to STEP 4 (Resume Operations).
>
>  If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
> -proceeds to STEP 4 (Slot Reset)
> +proceeds to STEP 3 (Slot Reset)
>
> -STEP 3: Link Reset
> -------------------
> -The platform resets the link.  This is a PCI-Express specific step
> -and is done whenever a fatal error has been detected that can be
> -"solved" by resetting the link.
> -
> -STEP 4: Slot Reset
> +STEP 3: Slot Reset
>  ------------------
>
>  In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
> @@ -322,7 +316,7 @@ PCI card types::
>         +               pdev->needs_freset = 1;
>         +
>
> -Platform proceeds either to STEP 5 (Resume Operations) or STEP 6 (Permanent
> +Platform proceeds either to STEP 4 (Resume Operations) or STEP 5 (Permanent
>  Failure).
>
>  .. note::
> @@ -332,7 +326,7 @@ Failure).
>     However, it probably should.
>
>
> -STEP 5: Resume Operations
> +STEP 4: Resume Operations
>  -------------------------
>  The platform will call the resume() callback on all affected device
>  drivers if all drivers on the segment have returned
> @@ -344,7 +338,7 @@ a result code.
>  At this point, if a new error happens, the platform will restart
>  a new error recovery sequence.
>
> -STEP 6: Permanent Failure
> +STEP 5: Permanent Failure
>  -------------------------
>  A "permanent failure" has occurred, and the platform cannot recover
>  the device.  The platform will call error_detected() with a
> @@ -367,6 +361,27 @@ errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
>  for additional detail on real-life experience of the causes of
>  software errors.
>
> +STEP 0: Error Event: ERR_FATAL
> +--------------------
> +PCI bus error is detected by the PCI hardware. On powerpc, the slot is
> +isolated, in that all I/O is blocked: all reads return 0xffffffff, all
> +writes are ignored.
> +
> +STEP 1: Remove devices
> +---------------------
> +Platform removes the devices depending on the error agent, it could be
> +this port for all subordinates or upstream component (likely downstream
> +port)
> +
> +STEP 2: Reset link
> +---------------------
> +The platform resets the link.  This is a PCI-Express specific step and is
> +done whenever a fatal error has been detected that can be "solved" by
> +resetting the link.
> +
> +STEP 3: Re-enumerate the devices
> +---------------------
> +Initiates the re-enumeration.
>
>  Conclusion; General Remarks
>  ---------------------------
> diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
> index 0b36b9ebfa4b..9528cfd9449b 100644
> --- a/Documentation/PCI/pcieaer-howto.rst
> +++ b/Documentation/PCI/pcieaer-howto.rst
> @@ -206,7 +206,7 @@ error_detected(dev, pci_channel_io_frozen) to all drivers within
>  a hierarchy in question. Then, performing link reset at upstream is
>  necessary. As different kinds of devices might use different approaches
>  to reset link, AER port service driver is required to provide the
> -function to reset link via callback parameter of pcie_do_recovery()
> +function to reset link via callback parameter of pcie_do_fatal_recovery()
>  function. If reset_link is not NULL, recovery function will use it
>  to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
>  and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index fa12f7cbc1a0..b3e1571107b5 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -555,8 +555,9 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
>  #endif
>
>  /* PCI error reporting and recovery */
> -pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -                       pci_channel_state_t state,
> +pci_ers_result_t pcie_do_nonfatal_recovery(struct pci_dev *dev);
> +
> +pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>                         pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
>
>  bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 65dff5f3457a..f3e70bb9b30d 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -947,9 +947,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>                 if (pcie_aer_is_native(dev))
>                         pcie_clear_device_status(dev);
>         } else if (info->severity == AER_NONFATAL)
> -               pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
> +               pcie_do_nonfatal_recovery(dev);
>         else if (info->severity == AER_FATAL)
> -               pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
> +               pcie_do_fatal_recovery(dev, aer_root_reset);
>         pci_dev_put(dev);
>  }
>
> @@ -985,11 +985,9 @@ static void aer_recover_work_func(struct work_struct *work)
>                 }
>                 cper_print_aer(pdev, entry.severity, entry.regs);
>                 if (entry.severity == AER_NONFATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_normal,
> -                                        aer_root_reset);
> +                       pcie_do_nonfatal_recovery(pdev);
>                 else if (entry.severity == AER_FATAL)
> -                       pcie_do_recovery(pdev, pci_channel_io_frozen,
> -                                        aer_root_reset);
> +                       pcie_do_fatal_recovery(pdev, aer_root_reset);
>                 pci_dev_put(pdev);
>         }
>  }
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index daa9a4153776..74e7d1da3cf0 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -233,7 +233,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
>         dpc_process_error(pdev);
>
>         /* We configure DPC so it only triggers on ERR_FATAL */
> -       pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
> +       pcie_do_fatal_recovery(pdev, dpc_reset_link);
>
>         return IRQ_HANDLED;
>  }
> diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
> index a6b9b479b97a..87379bc566f6 100644
> --- a/drivers/pci/pcie/edr.c
> +++ b/drivers/pci/pcie/edr.c
> @@ -183,7 +183,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
>          * or ERR_NONFATAL, since the link is already down, use the FATAL
>          * error recovery path for both cases.
>          */
> -       estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
> +       estate = pcie_do_fatal_recovery(edev, dpc_reset_link);
>
>  send_ost:
>
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 315a4d559c4c..fa50366a9632 100644
> --- a/drivers/pci/pcie/err.c
> +++ b/drivers/pci/pcie/err.c
> @@ -79,11 +79,6 @@ static int report_error_detected(struct pci_dev *dev,
>         return 0;
>  }
>
> -static int report_frozen_detected(struct pci_dev *dev, void *data)
> -{
> -       return report_error_detected(dev, pci_channel_io_frozen, data);
> -}
> -
>  static int report_normal_detected(struct pci_dev *dev, void *data)
>  {
>         return report_error_detected(dev, pci_channel_io_normal, data);
> @@ -146,9 +141,59 @@ static int report_resume(struct pci_dev *dev, void *data)
>         return 0;
>  }
>
> -pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> -                       pci_channel_state_t state,
> +pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
>                         pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> +{
> +       struct pci_dev *udev;
> +       struct pci_bus *parent;
> +       struct pci_dev *pdev, *temp;
> +       pci_ers_result_t result;
> +
> +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
> +               udev = dev;
> +       else
> +               udev = dev->bus->self;
> +
> +       parent = udev->subordinate;
> +       pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
> +
> +        pci_lock_rescan_remove();
   Though here you have lock, but hotplug will do another
'pci_stop_and_remove_bus_device()'
   without merging it with the hotplug driver, you have no way to
remove the replicated actions in
  hotplug handler.


  Thanks,
  Ethan
> +        pci_dev_get(dev);
> +        list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
> +                                        bus_list) {
> +               pci_stop_and_remove_bus_device(pdev);
> +       }
> +
> +       result = reset_link(udev);
> +
> +       if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
> +               /*
> +                * If the error is reported by a bridge, we think this error
> +                * is related to the downstream link of the bridge, so we
> +                * do error recovery on all subordinates of the bridge instead
> +                * of the bridge and clear the error status of the bridge.
> +                */
> +               pci_aer_clear_fatal_status(dev);
> +               if (pcie_aer_is_native(dev))
> +                       pcie_clear_device_status(dev);
> +       }
> +
> +       if (result == PCI_ERS_RESULT_RECOVERED) {
> +               if (pcie_wait_for_link(udev, true))
   And another  pci_rescan_bus() like in the hotplug handler.
> +                       pci_rescan_bus(udev->bus);
> +               pci_info(dev, "Device recovery from fatal error successful\n");
> +        } else {
> +               pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
> +               pci_info(dev, "Device recovery from fatal error failed\n");
> +        }
> +
> +       pci_dev_put(dev);
> +       pci_unlock_rescan_remove();
> +
> +       return result;
> +}
> +
> +pci_ers_result_t pcie_do_nonfatal_recovery(struct pci_dev *dev)
>  {
>         pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>         struct pci_bus *bus;
> @@ -164,16 +209,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>         bus = dev->subordinate;
>
>         pci_dbg(dev, "broadcast error_detected message\n");
> -       if (state == pci_channel_io_frozen) {
> -               pci_walk_bus(bus, report_frozen_detected, &status);
> -               status = reset_link(dev);
> -               if (status != PCI_ERS_RESULT_RECOVERED) {
> -                       pci_warn(dev, "link reset failed\n");
> -                       goto failed;
> -               }
> -       } else {
> -               pci_walk_bus(bus, report_normal_detected, &status);
> -       }
> +       pci_walk_bus(bus, report_normal_detected, &status);
>
>         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>                 status = PCI_ERS_RESULT_RECOVERED;
> --
> 2.17.1
>
