Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 713E2EF99
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 06:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbfD3E0a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Apr 2019 00:26:30 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:40895 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbfD3E03 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Apr 2019 00:26:29 -0400
Received: by mail-it1-f194.google.com with SMTP id k64so2601762itb.5
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2019 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t1AHa4y9HItu8pWR+Cc3jqH3r77ZUtY/LFLvQb33vwg=;
        b=jvQCAxGNAh6u7Q+yQEV6dMmG3ymyY5vcVzNfGa0WR47bFA2dos1g2PYidD9fR8BZFG
         sEKJ7ryTYwiCygqCq5gAW6TF2Hsdtzk1aleW1kegbyy682P695VLjikwx0G9ID1PucRK
         ItjHrGSZLd/G5QRj6vL2RqIIT3Ru5EYh0c0NKIioALX5V83TUI/JQltTJoRnDzC5QFo9
         VcH6md8PqT3PU1nB6qnVz0SZux6iDu/od193XYIFJhNeA3gvawy2/x2axbzDpefYv1iC
         yxbc8yj95N2Q18J+rsxIzKAE7TpbEr+ozEzwbvwKwhUgrxHMia/zbawfP4GnOqVYoLlf
         HDKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t1AHa4y9HItu8pWR+Cc3jqH3r77ZUtY/LFLvQb33vwg=;
        b=IbLAof6PhC+icooHWx+fe3PhImbmi9XDPdGhVKGGsIJwwTGO1VJxiA6eOA5PW4Jwy5
         XkMZoSRAIZso0HU5RIwy6ynngsmRIFc88yUpnsKM9damwNDkgNdQ3B7XHoCDwAFQr1M8
         dGarYgFh1FTMwWrGu90BzlvaBV3jb1DowXy/4GodTcJB8C9HkO0zA5KZ9Qntu4iNqXq5
         ShDcPYdfFrw5/yn94NQvW/LaMbXkDNt14Ux2N6ONTdL+ivHQQr7bKEWZ3dRQJLygwYVp
         s7vCdnvBOm0Yte4KeH18j/xA3XMUiE1/viptHbK59S3FB/z71SS0Vm9c4sNHQHrZ8lKs
         EElw==
X-Gm-Message-State: APjAAAUfJwCnUEnJaD3ORjqb5t0hmW2v8+Ntqw4l7FDESTY1LhjA2n0n
        sbDUCPlZiQ5iNZo9d6dH+/ONenWoXb1wu0+9gbbPfX/m
X-Google-Smtp-Source: APXvYqyI6lVgp9aOsLjj03ex4HBhpqIrxoMl1W0IkO6i89AEn/j+YFvp1mF4USodJGyF4UDAZ5kUTrXQ2Y8JQE8Nq/0=
X-Received: by 2002:a24:e85:: with SMTP id 127mr2033755ite.4.1556598388424;
 Mon, 29 Apr 2019 21:26:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190311115233.6514-1-s.miroshnichenko@yadro.com> <20190311115233.6514-3-s.miroshnichenko@yadro.com>
In-Reply-To: <20190311115233.6514-3-s.miroshnichenko@yadro.com>
From:   Oliver <oohall@gmail.com>
Date:   Tue, 30 Apr 2019 14:26:16 +1000
Message-ID: <CAOSf1CF5gVPdBZpbzr+8cp1dC6Ki+XtkfsSqdR0CP8pDPCnPYQ@mail.gmail.com>
Subject: Re: [PATCH v5 2/8] powerpc/powernv/pci: Suppress an EEH error when
 reading an empty slot
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-pci@vger.kernel.org,
        Stewart Smith <stewart@linux.vnet.ibm.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Russell Currey <ruscur@russell.cc>, linux@yadro.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 11, 2019 at 10:52 PM Sergey Miroshnichenko
<s.miroshnichenko@yadro.com> wrote:
>
> Reading an empty slot returns all ones, which triggers a false
> EEH error event on PowerNV. This patch unfreezes the bus where
> it has happened.
>
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  arch/powerpc/include/asm/ppc-pci.h   |  1 +
>  arch/powerpc/kernel/pci_dn.c         |  2 +-
>  arch/powerpc/platforms/powernv/pci.c | 31 +++++++++++++++++++++++++---
>  3 files changed, 30 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/ppc-pci.h b/arch/powerpc/include/asm/ppc-pci.h
> index f191ef0d2a0a..a22d52a9bb1f 100644
> --- a/arch/powerpc/include/asm/ppc-pci.h
> +++ b/arch/powerpc/include/asm/ppc-pci.h
> @@ -40,6 +40,7 @@ void *traverse_pci_dn(struct pci_dn *root,
>                       void *(*fn)(struct pci_dn *, void *),
>                       void *data);
>  extern void pci_devs_phb_init_dynamic(struct pci_controller *phb);
> +struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus);
>
>  /* From rtas_pci.h */
>  extern void init_pci_config_tokens (void);
> diff --git a/arch/powerpc/kernel/pci_dn.c b/arch/powerpc/kernel/pci_dn.c
> index ab147a1909c8..341ed71250f1 100644
> --- a/arch/powerpc/kernel/pci_dn.c
> +++ b/arch/powerpc/kernel/pci_dn.c
> @@ -40,7 +40,7 @@
>   * one of PF's bridge. For other devices, their firmware
>   * data is linked to that of their bridge.
>   */
> -static struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
> +struct pci_dn *pci_bus_to_pdn(struct pci_bus *bus)
>  {
>         struct pci_bus *pbus;
>         struct device_node *dn;
> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
> index 41a381dfc2a1..8cc6661781e2 100644
> --- a/arch/powerpc/platforms/powernv/pci.c
> +++ b/arch/powerpc/platforms/powernv/pci.c
> @@ -761,6 +761,21 @@ static inline pnv_pci_cfg_check(struct pci_dn *pdn)
>  }
>  #endif /* CONFIG_EEH */
>
> +static int get_bus_pe_number(struct pci_bus *bus)
> +{
> +       struct pci_dn *pdn = pci_bus_to_pdn(bus);
> +       struct pci_dn *child;
> +
> +       if (!pdn)
> +               return IODA_INVALID_PE;
> +
> +       list_for_each_entry(child, &pdn->child_list, list)
> +               if (child->pe_number != IODA_INVALID_PE)
> +                       return child->pe_number;
> +
> +       return IODA_INVALID_PE;
> +}
> +
>  static int pnv_pci_read_config(struct pci_bus *bus,
>                                unsigned int devfn,
>                                int where, int size, u32 *val)
> @@ -772,9 +787,19 @@ static int pnv_pci_read_config(struct pci_bus *bus,
>
>         *val = 0xFFFFFFFF;
>         pdn = pci_get_pdn_by_devfn(bus, devfn);
> -       if (!pdn)
> -               return pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
> -                                           where, size, val);
> +       if (!pdn) {
> +               int pe_number = get_bus_pe_number(bus);
> +
> +               ret = pnv_pci_cfg_read_raw(phb->opal_id, bus->number, devfn,
> +                                          where, size, val);
> +
> +               if (!ret && (*val == EEH_IO_ERROR_VALUE(size)) && phb->unfreeze_pe)
> +                       phb->unfreeze_pe(phb, (pe_number == IODA_INVALID_PE) ?
> +                                        phb->ioda.reserved_pe_idx : pe_number,
> +                                        OPAL_EEH_ACTION_CLEAR_FREEZE_ALL);
> +
> +               return ret;
> +       }
>
>         if (!pnv_pci_cfg_check(pdn))
>                 return PCIBIOS_DEVICE_NOT_FOUND;
> --
> 2.20.1
>

Reviewed-by: Oliver O'Halloran <oohall@gmail.com>
