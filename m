Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA24F9A1B3
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 23:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfHVVKa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 17:10:30 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:41139 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730991AbfHVVKa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 17:10:30 -0400
Received: by mail-oi1-f195.google.com with SMTP id g7so5463557oia.8;
        Thu, 22 Aug 2019 14:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=722k5ddNheSppDzrG90q8EFQ8uGNK424zDmyHBRv/xk=;
        b=sQ2/Kgp64yj3UAzuBYxwngzdEsHH68xa0fs511sEE7FtajN+DcF1jQOnBWTeCAwwop
         pGu30/wuYeVTLFG5Fy/hP3qmpKk/s/cL28i5K2pxyFhNOCHMFSUhv6v4JomnSyG87xE1
         J0VY5ivLVW5m5dIn5Tyy5HSF85sLplKjOokZM0KygO5aR+qV1eEX4SAyLVXR/4cPVfBk
         d/Sftdg/wypUFxiCcFUAot2RcoAhuGC96MxT1COkz0WT7F52AUEZUKcQA79xPHXI2Dn9
         CVijj2x673H//O8eNn0wuPu0IuWBmWiS0XNmePGTHnl2rZLPozQANXUREqck2Eio086G
         eE2Q==
X-Gm-Message-State: APjAAAVxoKcx6P0vbNKiGYizjfPYfTh3eRMFJMchzbeQvR+Hhi1S5FUE
        /FujHt6ThG5kcPV9GYrhUerSjSeUuXjmO/+kmoA=
X-Google-Smtp-Source: APXvYqzipBbFAy30yqllDRxVg2wDXWGv50k8XyQth34p3InV0dg8l5sHIhCCRt/28NsM9VDdy0aBudPzL12G7mXE8DE=
X-Received: by 2002:aca:4dd8:: with SMTP id a207mr756501oib.115.1566508228550;
 Thu, 22 Aug 2019 14:10:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190822200551.129039-1-helgaas@kernel.org> <20190822200551.129039-4-helgaas@kernel.org>
In-Reply-To: <20190822200551.129039-4-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 22 Aug 2019 23:10:17 +0200
Message-ID: <CAJZ5v0joSqE5hwHGEPoVG0xDb_wnhS8EjnYZe+EuukBgDpzwQg@mail.gmail.com>
Subject: Re: [PATCH 3/3] PCI / PM: Return error when changing power state from D3cold
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

On Thu, Aug 22, 2019 at 10:06 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> From: Bjorn Helgaas <bhelgaas@google.com>
>
> pci_raw_set_power_state() uses the Power Management capability to change a
> device's power state.  The capability is in config space, which is
> accessible in D0, D1, D2, and D3hot, but not in D3cold.
>
> If we call pci_raw_set_power_state() on a device that's in D3cold, config
> reads fail and return ~0 data, which we erroneously interpreted as "the
> device is in D3hot", leading to messages like this:
>
>   pcieport 0000:03:00.0: Refused to change power state, currently in D3
>
> The PCI_PM_CTRL has several RsvdP fields, so ~0 is never a valid register
> value.  Notice if we get that data, print a more informative message, and
> return an error.
>
> Changing the power state of a device from D3cold must be done by a platform
> power management method or some other non-config space mechanism.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 5f0a3145c3f2..41112af189a8 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -853,6 +853,12 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>                 return -EIO;
>
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +       if (pmcsr == (u16) PCI_ERROR_RESPONSE) {
> +               pci_err(dev, "can't access config space to change power state from %s to %s\n",
> +                       pci_power_name(dev->current_state),
> +                       pci_power_name(state));
> +               return -EIO;
> +       }
>
>         /*
>          * If we're (effectively) in D3, force entire word to 0.
> @@ -893,8 +899,9 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
>         if (dev->current_state != state && printk_ratelimit())
> -               pci_info(dev, "refused to change power state (currently %s)\n",
> -                        pci_power_name(dev->current_state));
> +               pci_info(dev, "refused to change power state from %s to %s\n",
> +                        pci_power_name(dev->current_state),
> +                        pci_power_name(state));
>
>         /*
>          * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> --
> 2.23.0.187.g17f5b7556c-goog
>
