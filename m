Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 807BD102D33
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 21:06:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfKSUGk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Nov 2019 15:06:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42960 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbfKSUGk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Nov 2019 15:06:40 -0500
Received: by mail-lj1-f193.google.com with SMTP id n5so24805930ljc.9;
        Tue, 19 Nov 2019 12:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ozTKJ2rIRG9nHA+tMxCQpcyR7fs60WJFT2iDBkxCrc=;
        b=ZL6BOPq0/1KVhaECgSsxziPcOkvFxCuctCJ9rq8sLs/yLOhBxMcaQvuoy+IDEqD27D
         sSHx/DHVjZznHM0IAyxS8uZp0SmGoJlXJIubk/aTtK+nyJqN7qbGU9k0yZq6F3axHLoR
         I7LCwhSLHWb05G9GLhB0j4DA2AcS6BAHEAZKnw/mM3h+jex3SyIg1hAeyEdfHqBjAxar
         8MdCnxa2QwtuDrx/3aLqSbJS6DBN5x3o3B8q+CPFKESr0wngpwxLhX5aiF7fSavMZ2EG
         ChetJ0Big0TYLMLJajdWXtmZn4EmS5XFmk662U4arRsb0GUpQPR05c1BUF4hG8afVPRH
         vaQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ozTKJ2rIRG9nHA+tMxCQpcyR7fs60WJFT2iDBkxCrc=;
        b=iahwsUXeXURpLOVn2klqpZBkrRnGCppYvqYYZu/wiGsK0+N5auR3aV42GLTo+a7owk
         on+mfnkimBpTCeRTcMCjhusPGfg0MHSskJnHfO7vki4O3ny+l0xwEAGIK3pzmBoO9sHJ
         bqy6eW1RF3KU9euAhG5t/84gTxg1H1U0lvNXs7BFzIbd0uSGqdA0eg6sA+Iu+NCF9zy/
         YN53ak+YFm+cD9UhY7xhwiGuxeFJRu0sh9u8p39/lL+8dcfUYhnIMwqoYCEFysNnGCtv
         KFK/wJw8pQDuKCHObPwUw8pPCfQuFBKCjRZ58lLudOIG0eNpFXlx2p05saDKJRFsFUVN
         4xzg==
X-Gm-Message-State: APjAAAVHGnkULXl3ngTRv+RFsFWRYcmc2BJvC2xBvregSvHhbkTtu0mk
        nSAB629dr5We7DnCGHxvSlLrilA0WD7PZl9icyQ=
X-Google-Smtp-Source: APXvYqxCtBrAFAKyz1SDQAYnzSvQxMY0cyWFJoF6LQeB2TSVVGaggbw8jwL0kptUtrgQCGDaLvHaKnfBd6oNfvmJjBU=
X-Received: by 2002:a2e:7c12:: with SMTP id x18mr5487839ljc.130.1574193996900;
 Tue, 19 Nov 2019 12:06:36 -0800 (PST)
MIME-Version: 1.0
References: <20191017121901.13699-1-kherbst@redhat.com>
In-Reply-To: <20191017121901.13699-1-kherbst@redhat.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Wed, 20 Nov 2019 06:06:25 +1000
Message-ID: <CAPM=9tx64hrB=EASnXtWdQynqK=dxHZz9qEobsBtoZK+aqUm_w@mail.gmail.com>
Subject: Re: [PATCH v4] pci: prevent putting nvidia GPUs into lower device
 states on certain intel bridges
To:     Karol Herbst <kherbst@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        nouveau <nouveau@lists.freedesktop.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Oct 2019 at 22:19, Karol Herbst <kherbst@redhat.com> wrote:
>
> Fixes state transitions of Nvidia Pascal GPUs from D3cold into higher device
> states.


Can we get this acked/committed? At this stage I think we've done all
we can unless Intel actually escalate this internally and work out how
the hw is broken.

Dave.
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
> @@ -850,6 +850,13 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>            || (state == PCI_D2 && !dev->d2_support))
>                 return -EIO;
>
> +       /*
> +        * check if we have a bad combination of bridge controller and nvidia
> +         * GPU, see quirk_broken_nv_runpm for more info
> +        */
> +       if (state != PCI_D0 && dev->broken_nv_runpm)
> +               return 0;
> +
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>
>         /*
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 44c4ae1abd00..0006c9e37b6f 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5268,3 +5268,56 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
>  DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
>                               PCI_CLASS_DISPLAY_VGA, 8,
>                               quirk_reset_lenovo_thinkpad_p50_nvgpu);
> +
> +/*
> + * Some Intel PCIe bridges cause devices to disappear from the PCIe bus after
> + * those were put into D3cold state if they were put into a non D0 PCI PM
> + * device state before doing so.
> + *
> + * This leads to various issue different issues which all manifest differently,
> + * but have the same root cause:
> + *  - AIML code execution hits an infinite loop (as the coe waits on device
> + *    memory to change).
> + *  - kernel crashes, as all pci reads return -1, which most code isn't able
> + *    to handle well enough.
> + *  - sudden shutdowns, as the kernel identified an unrecoverable error after
> + *    userspace tries to access the GPU.
> + *
> + * In all cases dmesg will contain at least one line like this:
> + * 'nouveau 0000:01:00.0: Refused to change power state, currently in D3'
> + * followed by a lot of nouveau timeouts.
> + *
> + * ACPI code writes bit 0x80 to the not documented PCI register 0x248 of the
> + * PCIe bridge controller in order to power down the GPU.
> + * Nonetheless, there are other code paths inside the ACPI firmware which use
> + * other registers, which seem to work fine:
> + *  - 0xbc bit 0x20 (publicly available documentation claims 'reserved')
> + *  - 0xb0 bit 0x10 (link disable)
> + * Changing the conditions inside the firmware by poking into the relevant
> + * addresses does resolve the issue, but it seemed to be ACPI private memory
> + * and not any device accessible memory at all, so there is no portable way of
> + * changing the conditions.
> + *
> + * The only systems where this behavior can be seen are hybrid graphics laptops
> + * with a secondary Nvidia Pascal GPU. It cannot be ruled out that this issue
> + * only occurs in combination with listed Intel PCIe bridge controllers and
> + * the mentioned GPUs or if it's only a hw bug in the bridge controller.
> + *
> + * But because this issue was NOT seen on laptops with an Nvidia Pascal GPU
> + * and an Intel Coffee Lake SoC, there is a higher chance of there being a bug
> + * in the bridge controller rather than in the GPU.
> + *
> + * This issue was not able to be reproduced on non laptop systems.
> + */
> +
> +static void quirk_broken_nv_runpm(struct pci_dev *dev)
> +{
> +       struct pci_dev *bridge = pci_upstream_bridge(dev);
> +
> +       if (bridge->vendor == PCI_VENDOR_ID_INTEL &&
> +           bridge->device == 0x1901)
> +               dev->broken_nv_runpm = 1;
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
>         unsigned int    broken_intx_masking:1;  /* INTx masking can't be used */
> +       unsigned int    broken_nv_runpm:1;      /* some combinations of intel bridge controller and nvidia GPUs break rtd3 */
>         unsigned int    io_window_1k:1;         /* Intel bridge 1K I/O windows */
>         unsigned int    irq_managed:1;
>         unsigned int    has_secondary_link:1;
> --
> 2.21.0
>
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
