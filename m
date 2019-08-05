Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC7BE826A6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Aug 2019 23:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbfHEVOr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Aug 2019 17:14:47 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:35229 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729383AbfHEVOr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Aug 2019 17:14:47 -0400
Received: by mail-ot1-f67.google.com with SMTP id j19so10642333otq.2;
        Mon, 05 Aug 2019 14:14:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K81VJiYZHz48k5xpZL9JVC+H5GcFEAdkpsb0gf8wQuM=;
        b=SMtfl8tVA71nFqJGEm+lxR2HMNcCzgcHWuldb5bGXwb1iSPuM9If0bbkc5FdTbxrJN
         6FjTMYRWrqnaWeLK4Mp9UgqiEiUrwxWBRbOw50IvEvKF1t2Gq7Rf3k8Kdl/1wDuKkimF
         0P+9eKadA4orH2fNnrOb98xaCxkWiW23rx+xH7unCaLHhG7y9iSa/6/OeRLB3EsfJzmJ
         dqhylpAPXI/73Web3YcSIHUVqQ2g8OQP0ayiEj7Ht9osqYNHY1LpjvfFq0WCd1hw2pht
         orTM+7SSVHXm4Hv9J8gr1Vm1hOGcWfzz6yzYkxQUA6oaTH05Mgk59pPcw4eZHAkQ73av
         tFww==
X-Gm-Message-State: APjAAAVQ+yjn7FqlrtILypAl4tRRBMLFDjHWqe1WYVIZzS0J9xLIkbx+
        KMvD80fx/wFNDzaf9L17oyKMx24IBUHoxmZR2h0=
X-Google-Smtp-Source: APXvYqxAOvq6brWaQzk/LEyKzX+snTQA2yXv4SbP05AZTRriz+D8QJvlIqBpei/jWnH2T4tFiMx8z/ExVaTjVwvcCJM=
X-Received: by 2002:a05:6830:8a:: with SMTP id a10mr2078732oto.167.1565039686381;
 Mon, 05 Aug 2019 14:14:46 -0700 (PDT)
MIME-Version: 1.0
References: <20190805205214.194981-1-helgaas@kernel.org> <20190805205214.194981-6-helgaas@kernel.org>
In-Reply-To: <20190805205214.194981-6-helgaas@kernel.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 5 Aug 2019 23:14:34 +0200
Message-ID: <CAJZ5v0iovG=96rz1B_Fcwi0ZMA3GipoW24zOC6JwZhU=5ZhooQ@mail.gmail.com>
Subject: Re: [PATCH 5/5] PCI / PM: Decode D3cold power state correctly
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
> Use pci_power_name() to print pci_power_t correctly.  This changes:
>
>   "state 0" or "D0"   to   "D0"
>   "state 1" or "D1"   to   "D1"
>   "state 2" or "D2"   to   "D2"
>   "state 3" or "D3"   to   "D3hot"
>   "state 4" or "D4"   to   "D3cold"
>
> Changes dmesg logging only, no other functional change intended.
>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  drivers/pci/pci.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index d8686e3cd5eb..17ae2615ac11 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -834,14 +834,16 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>                 return -EINVAL;
>
>         /*
> -        * Validate current state:
> -        * Can enter D0 from any state, but if we can only go deeper
> -        * to sleep if we're already in a low power state
> +        * Validate transition: We can enter D0 from any state, but if
> +        * we're already in a low-power state, we can only go deeper.  E.g.,
> +        * we can go from D1 to D3, but we can't go directly from D3 to D1;
> +        * we'd have to go from D3 to D0, then to D1.
>          */
>         if (state != PCI_D0 && dev->current_state <= PCI_D3cold
>             && dev->current_state > state) {
> -               pci_err(dev, "invalid power transition (from state %d to %d)\n",
> -                       dev->current_state, state);
> +               pci_err(dev, "invalid power transition (from %s to %s)\n",
> +                       pci_power_name(dev->current_state),
> +                       pci_power_name(state));
>                 return -EINVAL;
>         }
>
> @@ -896,8 +898,8 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
>         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
>         dev->current_state = pci_power_state(pmcsr);
>         if (dev->current_state != state && printk_ratelimit())
> -               pci_info(dev, "Refused to change power state, currently in D%d\n",
> -                        dev->current_state);
> +               pci_info(dev, "refused to change power state (currently %s)\n",
> +                        pci_power_name(dev->current_state));
>
>         /*
>          * According to section 5.4.1 of the "PCI BUS POWER MANAGEMENT
> --
> 2.22.0.770.g0f2c4a37fd-goog
>
