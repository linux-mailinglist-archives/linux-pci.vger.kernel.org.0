Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FDBE28DAEF
	for <lists+linux-pci@lfdr.de>; Wed, 14 Oct 2020 10:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgJNIOx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Oct 2020 04:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728667AbgJNIOj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Oct 2020 04:14:39 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC2BC045863;
        Tue, 13 Oct 2020 22:44:47 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dt13so2984841ejb.12;
        Tue, 13 Oct 2020 22:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9FEXz9TALpS4VnOWywHf6XvGbN7t+GXYK/6dh6Hvl7E=;
        b=n9FsBztXtkY84KawmkJzmN4r4E8fb69RDfug3X/SUlXmCa0WHQ2EJecsWdQG1b6Ru7
         z8AWtpFgfgEwbZyjy02yh27/XZtPbkJEyLHunBkRPWupwlhOh+ojxSLkbvboeWH5w29x
         a7RVzLopeZ/tlZIhgagjl0mMMCGRsNd0uYwqnVwjASDTn+oSUs7B7Y9sH3XpCW8mNKeh
         zkXLNd3HS88t2nS9npcgj3HfmHxKhZ/s5t6wev8/jsWlY10u4bhdhGVDYdUl6SZLpZO4
         jnUkPPeLDuj+vFCCIBtCQkb3ufKu5woKYZU98fqnZ1mFbx1kQ1B6r4Auqo2geJ6XKCyS
         jkhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9FEXz9TALpS4VnOWywHf6XvGbN7t+GXYK/6dh6Hvl7E=;
        b=J6+TlGaoqDp0tXyroZhZVQZHWJa0PiR/JxGyakpntQuXzqoCjcoS+OUg4WrIAcbuoE
         bjVS3lQUphAbS1CnYJR+sHVjY0Szfs73busFigh+1QKNQok5O3oBqY3+VAOE21tnC3SU
         bDXhZWMNUkNacfWxLJ5hMWQjvqNVrwlGGbCiI+fL2fq+27iqOhh6GT3zTwGapNumfbH4
         xkKPMobYgpaVZM70IPTDqGAG/IR6hRwb5xs3lW90hhgw9eIO5ZHS8fQYQHqmBJUngrWi
         Z5iKxU/ecUHL/vc99vrCK6QhvJfwI+UkcSov+jeavhxRm8lBvkBMwHhuJ2iJ3PPR5HXU
         zJiA==
X-Gm-Message-State: AOAM532682qIMht+inUQZfAfJbjglBnUs6qbBEtOK8aPCigjs39TNGiT
        92L8XB663P1SSUdGQa6fAzmjcYp3MZIxnQjG9M9MEqUVFig=
X-Google-Smtp-Source: ABdhPJwz75guIyeRv7PqhWRB1inqybQWEg5C78ctdONpzkv/ze8Vr773qaXURmmEyHi4CBZ2oMncjxeprB+y0Z6w96I=
X-Received: by 2002:a17:906:8053:: with SMTP id x19mr3496392ejw.139.1602654286098;
 Tue, 13 Oct 2020 22:44:46 -0700 (PDT)
MIME-Version: 1.0
References: <5c5bca0bdb958e456176fe6ede10ba8f838fbafc.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <c6e3f1168d5d88b207b59c434792a10a7331bb89.1602263264.git.sathyanarayanan.kuppuswamy@linux.intel.com>
From:   Ethan Zhao <xerces.zhao@gmail.com>
Date:   Wed, 14 Oct 2020 13:44:34 +0800
Message-ID: <CAKF3qh1Y1eADo_Cuf_MqgNanYuwhjWWe23DvPVByt6gmaf5AGQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] PCI/ERR: Split the fatal and non-fatal error
 recovery handling
To:     sathyanarayanan.nkuppuswamy@gmail.com
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

On Mon, Oct 12, 2020 at 1:10 PM <sathyanarayanan.nkuppuswamy@gmail.com> wrote:
>
> From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
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
> handler for cleaning the affected devices/drivers and let error recovery
> handler own this functionality. So this patch reverts Commit bdb5ac85777d
> ("PCI/ERR: Handle fatal error recovery") and re-introduce the  "remove
> affected device + rescan"  functionality in fatal error recovery handler.

This patch only reverts the commit bdb5ac85777d ?
or you'd better separate the revert and code you added.

Thanks,
Ethan

>
> Also holding pci_lock_rescan_remove() will prevent the race between hotplug
> and DPC handler.
>
> Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
> Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> ---
>  Documentation/PCI/pci-error-recovery.rst | 47 ++++++++++------
>  drivers/pci/pcie/err.c                   | 71 +++++++++++++++++++-----
>  2 files changed, 87 insertions(+), 31 deletions(-)
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
> diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
> index 067c58728b88..c2ae4d08801a 100644
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
> @@ -146,6 +141,58 @@ static int report_resume(struct pci_dev *dev, void *data)
>         return 0;
>  }
>
> +static pci_ers_result_t pcie_do_fatal_recovery(struct pci_dev *dev,
> +                       pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
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
>  pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>                         pci_channel_state_t state,
>                         pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
> @@ -153,6 +200,9 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>         pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>         struct pci_bus *bus;
>
> +       if (state == pci_channel_io_frozen)
> +               return pcie_do_fatal_recovery(dev, reset_link);
> +
>         /*
>          * Error recovery runs on all subordinates of the first downstream port.
>          * If the downstream port detected the error, it is cleared at the end.
> @@ -163,16 +213,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
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
