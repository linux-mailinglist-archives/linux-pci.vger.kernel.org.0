Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FDC3FCE9C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Nov 2019 20:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbfKNTRt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 14:17:49 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25222 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726491AbfKNTRs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Nov 2019 14:17:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573759066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iO7IjIFxA01AP12H/14msCUb1F6tFNp4BMry0uJ072A=;
        b=XJjP5tDV5hTyiLgGoZDbQehhbViTUWP09PJaXZnAJqqWl3gEeYIunBcx2qkofSAuS5eikV
        jJIE5Aw61Y4fDkCT28UDichazHR7O5pUyvZxKo1UJgyo5r0zz+qBttS9GKRX9Lf0tY/zB4
        SKWQsSNVScxJ/UKmNhpeTwG3rhc7U7U=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-gdR71pB0PgicoP-t8o2eXw-1; Thu, 14 Nov 2019 14:17:45 -0500
Received: by mail-qt1-f197.google.com with SMTP id j18so4682366qtp.15
        for <linux-pci@vger.kernel.org>; Thu, 14 Nov 2019 11:17:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yzU2orsV1IQ0b605t7GrUNqdH9lGit9QLMaD0lmIB5c=;
        b=VkA814ac8pcmGIs09qOg76+bnNluhejylYYOwzsaMazYTKxWfVfMWeM48mm7gpNrdq
         lqEDPeURyEwjueGEG6R+s9cMFi36nwP0KK4OTKHpGShvSGUbQI6vkYDUX2X2h/fsFpJx
         8oyQSU/lvahGprJ+RzSqrDMLmaxAikTMcez6++NqDGLaViOe3xlpfNBP/i9DAcr87uqi
         BB/wirFKyAHbIxSPAXbj3KsYkUKZKw34cGe9ZXutFAXnvbgm3APVpx67har5zdcex2u1
         EWJb3z6FwAsRujseb8wvSbYIZKFwtFkcV5fZNO+DgQ3ULOqut/wuzah5fuPvHNEmLTpm
         CTzg==
X-Gm-Message-State: APjAAAXI7/T/zxPpLg4dFEMkEH+cKWByxttkiowP6CDFPTrxR+Px6alc
        3xlsexAi2KFcBLgUzIbm+LdwccSWK0gdiADJYIbu5Uhs8J5GL4nCgmYsuOP932ylyeYZEHXKWrY
        reKLcHZ81/7deAEdr5pmkCTP9uGiiHt8q47V7
X-Received: by 2002:ac8:75ce:: with SMTP id z14mr9911915qtq.130.1573759062328;
        Thu, 14 Nov 2019 11:17:42 -0800 (PST)
X-Google-Smtp-Source: APXvYqyBzlpxS0u5QYAn3+7xHyAlZnhB1xo77FSDY0Sd/oCUw4ff3cxInd+1N0Ly/+l1puO3E0enij5HXFW6Mn/Bh7c=
X-Received: by 2002:ac8:75ce:: with SMTP id z14mr9911890qtq.130.1573759062129;
 Thu, 14 Nov 2019 11:17:42 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com>
In-Reply-To: <20191017121901.13699-1-kherbst@redhat.com>
From:   Karol Herbst <kherbst@redhat.com>
Date:   Thu, 14 Nov 2019 20:17:30 +0100
Message-ID: <CACO55tuMvHtPSHmU_G_0f5P6O3Ao0OqVMDPvaaRCYrMSd29NMQ@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Lyude Paul <lyude@redhat.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>
X-MC-Unique: gdR71pB0PgicoP-t8o2eXw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

ping on the patch.

I wasn't able to verify this issue on any other bridge controller, so
it really might be only this one.

On Thu, Oct 17, 2019 at 2:19 PM Karol Herbst <kherbst@redhat.com> wrote:
>
> Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher dev=
ice
> states.
>
> v2: convert to pci_dev quirk
>     put a proper technical explanation of the issue as a in-code comment
> v3: disable it only for certain combinations of intel and nvidia hardware
> v4: simplify quirk by setting flag on the GPU itself
>
> Signed-off-by: Karol Herbst <kherbst@redhat.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Lyude Paul <lyude@redhat.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Mika Westerberg <mika.westerberg@intel.com>
> Cc: linux-pci@vger.kernel.org
> Cc: linux-pm@vger.kernel.org
> Cc: dri-devel@lists.freedesktop.org
> Cc: nouveau@lists.freedesktop.org
> ---
>  drivers/pci/pci.c    |  7 ++++++
>  drivers/pci/quirks.c | 53 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci.h  |  1 +
>  3 files changed, 61 insertions(+)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index b97d9e10c9cc..02e71e0bcdd7 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *d=
ev, pci_power_t state)
>            || (state =3D=3D PCI_D2 && !dev->d2_support))
>                 return -EIO;
>
> +       /*
> +        * check if we have a bad combination of bridge controller and nv=
idia
> +         * GPU, see quirk_broken_nv_runpm for more info
> +        */
> +       if (state !=3D PCI_D0 && dev->broken_nv_runpm)
> +               return 0;
> +
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>
>         /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44c4ae1abd00..0006c9e37b6f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5268,3 +5268,56 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(=
struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>                               PCI_CLASS_DISPLAY_VGA, 8,
>                               quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Some Intel PCIe bridges cause devices to disappear from the PCIe bus =
after
> + * those were put into D3cold state if they were put into a non D0 PCI P=
M
> + * device state before doing so.
> + *
> + * This leads to various issue different issues which all manifest diffe=
rently,
> + * but have the same root cause:
> + *  - AIML code execution hits an infinite loop (as the coe waits on dev=
ice
> + *    memory to change).
> + *  - kernel crashes, as all pci reads return -1, which most code isn't =
able
> + *    to handle well enough.
> + *  - sudden shutdowns, as the kernel identified an unrecoverable error =
after
> + *    userspace tries to access the GPU.
> + *
> + * In all cases dmesg will contain at least one line like this:
> + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3=
'
> + * followed by a lot of nouveau timeouts.
> + *
> + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of=
 the
> + * PCIe bridge controller in order to power down the GPU.
> + * Nonetheless, there are other code paths inside the ACPI firmware whic=
h use
> + * other registers, which seem to work fine:
> + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> + *  - 0xb0 bit 0x10 (link disable)
> + * Changing the conditions inside the firmware by poking into the releva=
nt
> + * addresses does resolve the issue, but it seemed to be ACPI private me=
mory
> + * and not any device accessible memory at all, so there is no portable =
way of
> + * changing the conditions.
> + *
> + * The only systems where this behavior can be seen are hybrid graphics =
laptops
> + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this =
issue
> + * only occurs in combination with listed Intel PCIe bridge controllers =
and
> + * the mentioned GPUs or if it's only a hw bug in the bridge controller.
> + *
> + * But because this issue was NOT seen on laptops with an Nvidia Pascal =
GPU
> + * and an Intel Coffee Lake SoC, there is a higher chance of there being=
 a bug
> + * in the bridge controller rather than in the GPU.
> + *
> + * This issue was not able to be reproduced on non laptop systems.
> + */
> +
> +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> +{
> +       struct pci_dev *bridge =3D pci_upstream_bridge(dev);
> +
> +       if (bridge->vendor =3D=3D PCI_VENDOR_ID_INTEL &&
> +           bridge->device =3D=3D 0x1901)
> +               dev->broken_nv_runpm =3D 1;
> +}
> +DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
> +                             PCI_BASE_CLASS_DISPLAY, 16,
> +                             quirk_broken_nv_runpm);
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index ac8a6c4e1792..903a0b3a39ec 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -416,6 +416,7 @@ struct pci_dev {
>         unsigned int    __aer_firmware_first_valid:1;
>         unsigned int    __aer_firmware_first:1;
>         unsigned int    broken_intx_masking:1;  /* INTx masking can't be =
used */
> +       unsigned int    broken_nv_runpm:1;      /* some combinations of i=
ntel bridge controller and nvidia GPUs break rtd3 */
>         unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O wi=
ndows */
>         unsigned int    irq_managed:1;
>         unsigned int    has_secondary_link:1;
> --
> 2.21.0
>

