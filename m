Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E85F0439F8
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2019 17:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732779AbfFMPRs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jun 2019 11:17:48 -0400
Received: from mail-ua1-f66.google.com ([209.85.222.66]:37239 "EHLO
        mail-ua1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732174AbfFMNPo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 13 Jun 2019 09:15:44 -0400
Received: by mail-ua1-f66.google.com with SMTP id z13so7028826uaa.4
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2019 06:15:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vjw9J2oXStQCU9P5lbu9C2xf4fwigy02IvhWajVC4kM=;
        b=FSVJ0Dlz44SsNIdikWCLx4GMw+4EjfFik/p3pMNXowbgJRZV6D4ltiN/ITPf5Udbnh
         gFaYZYHPEmGa02MgeapXZGVRsSu7159dybFn61QTbAeK8ZF1HPtlcBD3uNc7PLZYRQ0Y
         rmERU5aEJ0Fv3UcXsp3KXTBp3Px9aoSM7ZaWy/H5ICVbz1ZyiyPk95YLeaPkZFtlC4MD
         rcskrsR+nmO8HWx1TqnTKdL+MEoYeZtRmzUA7KpahABAbK3drZYvDrySw5AacNxFPOsf
         Z3bFeVWGAwZsBbpgjtMqTBHIVXYp2vFPaUHqRQzEAOMP+ytMwkZhXVMG8dUzKszPXe3E
         EPRg==
X-Gm-Message-State: APjAAAVV0CzRRH5PqV4B296QnQ3slccC9AGe1gcD/b5OboRT6KyeQoIK
        xv7Jhxu5jjrHQRltzaG+Up7xAz1Xj5d+vMsrPuE=
X-Google-Smtp-Source: APXvYqxUSeoNWh85EEp7APXK1+Vnq2gHCst08gQhDjV9OOzUKfzXAeC4iQBkTn4Z+ehvaUOfSK6qJURpACyifK/B8FY=
X-Received: by 2002:ab0:2442:: with SMTP id g2mr13025536uan.47.1560431742948;
 Thu, 13 Jun 2019 06:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20190613063514.15317-1-drake@endlessm.com>
In-Reply-To: <20190613063514.15317-1-drake@endlessm.com>
From:   Ilia Mirkin <imirkin@alum.mit.edu>
Date:   Thu, 13 Jun 2019 09:15:31 -0400
Message-ID: <CAKb7UvjAGtQrcgO=GE8JHuy=mgCtOr+eTinBVwekXGHiam1t1A@mail.gmail.com>
Subject: Re: [PATCH] PCI: Expose hidden NVIDIA HDA controllers
To:     Daniel Drake <drake@endlessm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>, linux@endlessm.com,
        nouveau <nouveau@lists.freedesktop.org>,
        Lukas Wunner <lukas@wunner.de>,
        Aaron Plattner <aplattner@nvidia.com>,
        Peter Wu <peter@lekensteyn.nl>,
        Karol Herbst <kherbst@redhat.com>,
        Maik Freudenberg <hhfeuer@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 13, 2019 at 2:35 AM Daniel Drake <drake@endlessm.com> wrote:
>
> From: Lukas Wunner <lukas@wunner.de>
>
> The integrated HDA controller on Nvidia GPUs can be hidden with a bit in
> the GPU's config space. Information about this scheme was provided by
> NVIDIA on their forums.
>
> Many laptops now ship with this device hidden, meaning that Linux users
> of affected platforms (where the HDMI connector comes off the NVIDIA GPU)
> cannot use HDMI audio functionality.
>
> Avoid this issue by exposing the HDMI audio device on device enumeration
> and resume.
>
> The GPU and HDA controller are two functions of the same PCI device
> (VGA class device on function 0 and audio device on function 1).
> The multifunction flag in the GPU's Header Type register is cleared when
> the HDA controller is hidden and set if it's exposed, so reread the flag
> after exposing the HDA.
>
> According to Ilia Mirkin, the HDA controller is only present from MCP89
> onward, so do not touch config space on older GPUs.

Actually GF100 also has it, and has a lower PCI ID than MCP89. But I
don't think it really matters - I can't imagine anyone played HDA
hiding tricks on that power-hungry monster. I'd appreciate it if you
could reword this sentence to imply that it's on PCI IDs >= MCP89's
rather than GPUs newer than MCP89. GT215 was released before MCP89,
I'm fairly sure, but its PCI ID comes later, for example. [Wikipedia
says November 17, 2009 for GT215 vs some point in 2010 for MCP89.]
Maybe like

"..., the HDA controller is only present on GPUs with PCI IDs values
from MCP89's and onward, so ..."

>
> This quirk is limited to NVIDIA PCI devices with the VGA Controller
> device class. This is expected to correspond to product configurations
> where the NVIDIA GPU has connectors attached. Other products where the
> device class is 3D Controller are expected to correspond to configurations
> where the NVIDIA GPU is dedicated (dGPU) and has no connectors.
>
> It's sensible to avoid exposing the HDA controller on dGPU setups,
> especially because we've seen cases where the PCI BARs are not set
> up correctly by the platform in this case, causing Linux to log
> errors if the device is visible. This assumption of device class
> accurately corresponding to product configuration is true for 6 of 6
> laptops recently checked at the Endless lab, and there are also signs of
> agreement checking the data from 74 previously tested products, however
> Ilia Mirkin comments that he's seen cases where it is not true. Anyway, it
> looks like this quirk should fix audio support for the majority of
> affected users.

Yeah, this is fine. We used to have code which prevented enabling the
display portion when 3d class != VGA. We had to change it :) So I'm
definitely not making things up... However whether any of those people
*also* had HDA hiding issues -- unknown. And it wouldn't make things
any worse for them.

Not sure if mapping a BAR is an option at this super-early stage in
the kernel, but if it were, you could have logic which checked whether
the DISPLAY unit is fused off or not. Probably not worth the
complication though.

>
> This commit takes inspiration from an earlier patch by Daniel Drake.
>
> Link: https://devtalk.nvidia.com/default/topic/1024022
> Bugzilla: https://bugs.freedesktop.org/show_bug.cgi?id=75985
> Cc: Aaron Plattner <aplattner@nvidia.com>
> Cc: Peter Wu <peter@lekensteyn.nl>
> Cc: Ilia Mirkin <imirkin@alum.mit.edu>
> Cc: Karol Herbst <kherbst@redhat.com>
> Cc: Maik Freudenberg <hhfeuer@gmx.de>
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Tested-by: Daniel Drake <drake@endlessm.com>
> ---
>  drivers/pci/quirks.c    | 28 ++++++++++++++++++++++++++++
>  include/linux/pci_ids.h |  1 +
>  2 files changed, 29 insertions(+)
>
> Submitting Lukas's patch from over a year ago.
>
> It got held up before on patch dependencies (which are now all merged)
> and also the concern around the device class assumption not being true
> in all cases. However, there hasn't been any progress towards finding a
> better approach, and we don't have any logs to hand from the cases where
> this isn't true, so I think we should go with this approach which will
> work in the (vast?) majority of cases.
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 0f16acc323c6..52046b517e2e 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -4971,6 +4971,34 @@ DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_AMD, PCI_ANY_ID,
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
>                               PCI_CLASS_MULTIMEDIA_HD_AUDIO, 8, quirk_gpu_hda);
>
> +/*
> + * Many laptop BIOSes hide the integrated HDA controller on NVIDIA GPUs
> + * via a special bit. This prevents Linux from seeing and using it.
> + * Unhide it here.
> + * https://devtalk.nvidia.com/default/topic/1024022
> + */
> +static void quirk_nvidia_hda(struct pci_dev *gpu)
> +{
> +       u8 hdr_type;
> +       u32 val;
> +
> +       /* there was no integrated HDA controller before MCP89 */
> +       if (gpu->device < PCI_DEVICE_ID_NVIDIA_GEFORCE_320M)
> +               return;
> +
> +       /* bit 25 at offset 0x488 hides or exposes the HDA controller */
> +       pci_read_config_dword(gpu, 0x488, &val);
> +       pci_write_config_dword(gpu, 0x488, val | BIT(25));
> +
> +       /* the GPU becomes a multifunction device when the HDA is exposed */
> +       pci_read_config_byte(gpu, PCI_HEADER_TYPE, &hdr_type);
> +       gpu->multifunction = !!(hdr_type & BIT(7));
> +}
> +DECLARE_PCI_FIXUP_CLASS_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +                              PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
> +DECLARE_PCI_FIXUP_CLASS_RESUME_EARLY(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +                              PCI_BASE_CLASS_DISPLAY, 16, quirk_nvidia_hda);
> +
>  /*
>   * Some IDT switches incorrectly flag an ACS Source Validation error on
>   * completions for config read requests even though PCIe r4.0, sec
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 70e86148cb1e..66898463b81f 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1336,6 +1336,7 @@
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP78S_SMBUS    0x0752
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP77_IDE       0x0759
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP73_SMBUS     0x07D8
> +#define PCI_DEVICE_ID_NVIDIA_GEFORCE_320M           0x08A0
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA     0x0D85
>
> --
> 2.20.1
>
