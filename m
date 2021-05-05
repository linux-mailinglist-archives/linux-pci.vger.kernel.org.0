Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0583733B3
	for <lists+linux-pci@lfdr.de>; Wed,  5 May 2021 04:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbhEECNe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 May 2021 22:13:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229799AbhEECNe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 May 2021 22:13:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3399F611CB;
        Wed,  5 May 2021 02:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620180758;
        bh=3MH+IfwCtYy+KGwAHtO23xU0Cn26SwyyNWf7lqR1zT8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=elB3NjpgrYKCLLTt8S0bH6TPRyVGuvc1kPJH49JTIW3XtxuGtwa52ttsnOfDR1BVY
         fb8TR/GZW4vIhOSG62+rsoz2ORZ5ogsiLxfYXAQ30T5FZjo0pFhp9vRmMuwehlfFBK
         dA7odjOdJhFAZFxCnSlTC7ZM3W1KEAQnEnp2TT24134x4Z7pS9AwBearh2m1epymgY
         NJ9g7wvpZuzqSxeW+H7YcOqBvX4pRAeEhWm9LIIekk1TCLoY2nXFqnFw1NQq7VJW0e
         Cf03M8v8pwkVIjubLb9pj4oYrfHH2okFDh6dvfpDaqV4qo+55c6AW6LSztlwSnuDQL
         zf8Or7KdMVKsQ==
Date:   Tue, 4 May 2021 21:12:36 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Vikram Sethi <vsethi@nvidia.com>,
        Amey Narkhede <ameynarkhede03@gmail.com>
Subject: Re: [PATCH v4 2/2] PCI: Enable NO_BUS_RESET quirk for Nvidia GPUs
Message-ID: <20210505021236.GA1244944@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <478efe56-fb64-6987-f64c-f3d930a3b330@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 03, 2021 at 09:07:11PM -0500, Shanker R Donthineni wrote:
> On 5/3/21 5:42 PM, Bjorn Helgaas wrote:
> > Obviously _RST only works for built-in devices, since there's no AML
> > for plug-in devices, right?  So if there's a plug-in card with this
> > GPU, neither SBR nor _RST will work?
> These are not plug-in PCIe GPU cards, will exist on upcoming server
> baseboards. ACPI-reset should wok for plug-in devices as well as long
> as firmware has _RST method defined in ACPI-device associated with
> the PCIe hot-plug slot.

Maybe I'm missing something, but I don't see how _RST can work for
plug-in devices.  _RST is part of the system firmware, and that
firmware knows nothing about what will be plugged into the slot.  So
if system firmware supplies _RST that knows how to reset the Nvidia
GPU, it's not going to do the right thing if you plug in an NVMe
device instead.

Can you elaborate on how _RST would work for plug-in devices?  My only
point here is that IF this GPU is ever on a plug-in card, neither _RST
nor SBR would work, so we'd have to use whatever other reset methods
*do* work (I guess only FLR?)

> I've verified PCIe plug-in feature using SYSFS interface.
> 
> 1) Remove device using sysfs interface
>   root@test:/sys/bus/pci# echo 1 > devices/0005:01:00.0/remove
>   root@test:/sys/bus/pci# lspci -s 0005:01:00.0
>  
> 2) Rescan PCI bus using sysfs interface
>   root@test:/sys/bus/pci# echo 1 > devices/0005:00:00.0/rescan
>   root@test:/sys/bus/pci# lspci -s 0005:01:00.0
>   0005:01:00.0 3D controller: NVIDIA Corporation Device 2341 (rev a1)
> 
> 3) List current reset methods
>   root@jetson:/sys/bus/pci# cat devices/0005:01:00.0/reset_method
>   acpi,flr
> 
> Example AML code:
>  // Device definition for slot/devfn
>   Device(GPU0) {
>      Name(_ADR,0x00000000)
>      Method (_RST, 0)
>      {
>         printf("Entering ACPI _RST method")
>         // RESET code
>         printf("Exiting ACPI _RST method")
>      }
>   }
> 
> 4) Issue device reset from the userspace
>  root@test:/sys/bus/pci# echo 1 > devices/0005:01:00.0/reset
> 
> dmesg:
>  [ 6156.426303] ACPI Debug:  "Entering PCI9 _RST method"
>  [ 6156.427007] ACPI Debug:  "Exiting PCI9 _RST method"
> 
> > I'm wondering if we should log something to dmesg in
> > quirk_no_bus_reset(), quirk_no_pm_reset(), quirk_no_flr(), etc., just
> > so we have a hint about the fact that resets won't work quite as
> > expected on these devices.
> Yes, it would be very useful to know what PCI quirks were applied
> during boot.  Should I create a separate patch for adding pci_info()
> or include as part of this patch?

Don't include it as part of this patch.  It's a separate logical
change so should be a separate patch.  We can worry about that later.

>  --- a/drivers/pci/quirks.c
>  +++ b/drivers/pci/quirks.c
>  @@ -3556,6 +3556,7 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_MELLANOX, PCI_ANY_ID,
>   static void quirk_no_bus_reset(struct pci_dev *dev)
>   {
>          dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
>        +pci_info(dev, "Applied NO_BUS_RESET quirk\n");
>   }
> 
>   /*
>  @@ -3598,6 +3599,7 @@ static void quirk_no_pm_reset(struct pci_dev *dev)
>           */
>          if (!pci_is_root_bus(dev->bus))
>                  dev->dev_flags |= PCI_DEV_FLAGS_NO_PM_RESET;
>         +pci_info(dev, "Applied NO_PM_RESET quirk\n");
>   }
> 
>   /*
>  @@ -5138,6 +5140,7 @@ DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
>   static void quirk_no_flr(struct pci_dev *dev)
>   {
>          dev->dev_flags |= PCI_DEV_FLAGS_NO_FLR_RESET;
>         +pci_info(dev, "Applied NO_FLR_RESET quirk\n");
>   }
> 
> 
