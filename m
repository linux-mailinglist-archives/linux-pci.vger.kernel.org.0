Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 892CB82696
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 23:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729383AbfHEVJd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 17:09:33 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:46394 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727460AbfHEVJd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2019 17:09:33 -0400
Received: by mail-ot1-f66.google.com with SMTP id z23so58933939ote.13;
        Mon, 05 Aug 2019 14:09:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u8bxOMeGLT5P0IYiyeO0d/qtKTj57RXiZ7koi+6Rsuo=;
        b=Ck9KLslKCbLxFM7gMiDfNTGGteDt+7GWrD0SuYWv1TmmGFz4KbsbZNGKWPzmKzibf1
         bNtAMJcwn2OoHdoJ1Ko4vOFjDkPywKyrKi0/yJ2WJ781VbDFRUf/W3spO7oID32nI10x
         bwHXhdooqRBuuX8orlEdj6Lj6BiukchWpXnNkMC8tHFemKE6dVI6yPp2eS1QZIA5Xz4N
         cl7NyLkFazxPwk6RoIBQyGk2l3yag7eYv1Sfb9fgSE0SKJV36EPWPH8EI+n94enlncAl
         JBCxiuJktNBMzFcuW2D2cAuXE7ekv7j4LqUfwv3uxJVTnEgfAQ9H8ePKK0zaX4K9EHny
         LUNQ==
X-Gm-Message-State: APjAAAUwB26RUxI4TzKrP+BV/DUHKqSsm6/sMvkkof+QYf5pnfq7ydGM
        eCrkRA0m0cJLKyR04Q1gTC90hDjAW1uHcsvaL4s=
X-Google-Smtp-Source: APXvYqw/SQy6W2jedqhm2cG7np0A3itg86sqA1XfbvH7jvoGlXCkaKJYPYiD5s0gaXUN7CvhULr4nNhCvKIG0/n57EE=
X-Received: by 2002:a9d:6b96:: with SMTP id b22mr1161384otq.262.1565039371849;
 Mon, 05 Aug 2019 14:09:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190805205214.194981-1-helgaas@kernel.org> <20190805205214.194981-5-helgaas@kernel.org>
In-Reply-To: <20190805205214.194981-5-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Aug 2019 23:09:19 +0200
Message-ID: <CAJZ5v0jFPU38zDugumJB0iq5d-LctcMCdygTrFU4=gYP3UJ+oA@mail.gmail.com>
Subject: Re: [PATCH 4/5] PCI / PM: Check for error when reading Power State
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> The Power Management Status Register is in config space, and reads while
> the device is in D3cold typically return ~0 data (PCI_ERROR_RESPONSE).  If
> we just look at the PCI_PM_CTRL_STATE_MASK bits, that is 0x3, which looks
> like D3hot, not D3cold.
>
> Check the entire register for PCI_ERROR_RESPONSE so we can distinguish
> D3cold from D3hot.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/pci.c   |  6 +++---
>  include/linux/pci.h | 13 +++++++++++++
>  2 files changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index af6a97d7012b..d8686e3cd5eb 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -894,7 +894,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>                 udelay(PCI_PM_D2_DELAY);
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -       dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +       dev->current_state = pci_power_state(pmcsr);

But pci_raw_set_power_state() should not even be called for devices in
D3_cold, so this at best is redundant.

>         if (dev->current_state != state && printk_ratelimit())
>                 pci_info(dev, "Refused to change power state, currently in D%d\n",
>                          dev->current_state);
> @@ -942,7 +942,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
>                 u16 pmcsr;
>
>                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +               dev->current_state = pci_power_state(pmcsr);

The if () branch above should cover the D3cold case, shouldn't it?

>         } else {
>                 dev->current_state = state;
>         }
> @@ -1677,7 +1677,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
>         if (dev->pm_cap) {
>                 u16 pmcsr;
>                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> +               dev->current_state = pci_power_state(pmcsr);

So this appears to be only case in which pci_power_state(pmcsr) is
useful at all.

It might be better to use the code from it directly here IMO.

>         }
>
>         if (atomic_inc_return(&dev->enable_cnt) > 1)
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d64fd3788061..fdfe990e9661 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -152,6 +152,19 @@ static inline const char *pci_power_name(pci_power_t state)
>         return pci_power_names[1 + (__force int) state];
>  }
>
> +/*
> + * Convert a Power Management Status Register value to a pci_power_t.
> + * Note that if we read the register while the device is in D3cold, we
> + * typically get PCI_ERROR_RESPONSE, which looks like D3hot (0x3) if we
> + * only look at the PCI_PM_CTRL_STATE_MASK bits.
> + */
> +static inline pci_power_t pci_power_state(u16 pmcsr)
> +{
> +       if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> +               return PCI_D3cold;
> +       return pmcsr & PCI_PM_CTRL_STATE_MASK;
> +}
> +
>  #define PCI_PM_D2_DELAY                200
>  #define PCI_PM_D3_WAIT         10
>  #define PCI_PM_D3COLD_WAIT     100
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
