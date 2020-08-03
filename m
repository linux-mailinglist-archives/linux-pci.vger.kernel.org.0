Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E42E23A068
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 09:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725867AbgHCHfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 03:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725806AbgHCHfV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 03:35:21 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F07DC06174A
        for <linux-pci@vger.kernel.org>; Mon,  3 Aug 2020 00:35:21 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id j8so25215657ioe.9
        for <linux-pci@vger.kernel.org>; Mon, 03 Aug 2020 00:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qC7Eorsl9zkF3gmLSSjlCkDc4Lqwlol5oKVC+pduNKE=;
        b=mavAQ4BTdqmKtvTTp4cHnMJ452k/MceL6zJM/REw/MAxxK6JlOdb2LrjJ6B0JW606s
         vwCGNbvU+pDkpg5wL4udYpYYvsGrdbqShJcoC8/AbFruvl+RRtMqpTnT8lESd73Rw2ap
         ydAfiYC/Ra0tLcUvUmaT371Lo8OeqZz+pykYrqodzdJnLYATWlfAeLyABB+ujfYs8zVw
         2ufZPeFTRbopMPgXd88ulGgdMmgfBpXE9pMEcM3KGgF1s0fI3DdpV43eFJNlBugGgsgD
         GzazFKfB0IEWUqQtgklYLYLOxRHSkhZv8jRT6VyFY7A6p68JvGSgo807iAGARC2bUjRP
         VzBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qC7Eorsl9zkF3gmLSSjlCkDc4Lqwlol5oKVC+pduNKE=;
        b=quVJChOwIJoLzoE6Ehjl98awdgSCiK0oS5BRL4KdLEumoNnkAGIoM+CRUFz/+yEZvB
         nD4FsqVu+LgvLO6zVSPMtoypB3BJ4Acr8lYxnHuqXboeKYnopWPvcoLkEclEnaP+3lnJ
         oAUxTWUjuHlyZIYX2rt7HFaky18H/gqPj1/Xk4du6lc0SWasi6pw+yhAxX/UqQyW6ywT
         jRJaQuDJs37KOegdgcgbqwmaFYsiLR/+hepzssAv4KXsMavX7Cq115E8UcvgdTIYehk/
         jwwzen1AWAH8w8XPwl9HCsIAPCK4B8xb86QkPA817vFm89B4R7ZahU6/67vYgz7unKR+
         AnIg==
X-Gm-Message-State: AOAM533es55SBaPJoXTc/Uf56cyc8Kwdf0w8vXCtAUWpn0IbLgbf8bWR
        TBImbSJtYAtOfPyDSMW3Fb8OyzpTXg2sGs3MW4465b+c
X-Google-Smtp-Source: ABdhPJzPHgQu3pu5237f85qkNjWwqL+VLtML/cwrs+ApJ+7SanaQnlgKHAXRK6SwLpWKYBWLuwC0reitsDOY6+AgCjg=
X-Received: by 2002:a5d:848d:: with SMTP id t13mr3720345iom.73.1596440120745;
 Mon, 03 Aug 2020 00:35:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200430131520.51211-1-maxg@mellanox.com> <20200430131520.51211-2-maxg@mellanox.com>
In-Reply-To: <20200430131520.51211-2-maxg@mellanox.com>
From:   "Oliver O'Halloran" <oohall@gmail.com>
Date:   Mon, 3 Aug 2020 17:35:09 +1000
Message-ID: <CAOSf1CGv=0bwShzzK5zP3dtKg=RxeTFvq52j-Vi4GDfZ4UpBJA@mail.gmail.com>
Subject: Re: [PATCH 2/2 v2] powerpc/powernv: Enable and setup PCI P2P
To:     Max Gurtovoy <maxg@mellanox.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        linux-pci <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        israelr@mellanox.com, idanw@mellanox.com, vladimirk@mellanox.com,
        shlomin@mellanox.com, Frederic Barrat <fbarrat@linux.ibm.com>,
        Carol L Soto <clsoto@us.ibm.com>, aneela@mellanox.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 30, 2020 at 11:15 PM Max Gurtovoy <maxg@mellanox.com> wrote:
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 57d3a6a..9ecc576 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -3706,18 +3706,208 @@ static void pnv_pci_ioda_dma_bus_setup(struct pci_bus *bus)
>         }
>  }
>
> +#ifdef CONFIG_PCI_P2PDMA
> +static DEFINE_MUTEX(p2p_mutex);
> +
> +static bool pnv_pci_controller_owns_addr(struct pci_controller *hose,
> +                                        phys_addr_t addr, size_t size)
> +{
> +       int i;
> +
> +       /*
> +        * It seems safe to assume the full range is under the same PHB, so we
> +        * can ignore the size.
> +        */
> +       for (i = 0; i < ARRAY_SIZE(hose->mem_resources); i++) {
> +               struct resource *res = &hose->mem_resources[i];
> +
> +               if (res->flags && addr >= res->start && addr < res->end)
> +                       return true;
> +       }
> +       return false;
> +}
> +
> +/*
> + * find the phb owning a mmio address if not owned locally
> + */
> +static struct pnv_phb *pnv_pci_find_owning_phb(struct pci_dev *pdev,
> +                                              phys_addr_t addr, size_t size)
> +{
> +       struct pci_controller *hose;
> +
> +       /* fast path */
> +       if (pnv_pci_controller_owns_addr(pdev->bus->sysdata, addr, size))
> +               return NULL;

Do we actually need this fast path? It's going to be slow either way.
Also if a device is doing p2p to another device under the same PHB
then it should not be happening via the root complex. Is this a case
you've tested?

> +       list_for_each_entry(hose, &hose_list, list_node) {
> +               struct pnv_phb *phb = hose->private_data;
> +
> +               if (phb->type != PNV_PHB_NPU_NVLINK &&
> +                   phb->type != PNV_PHB_NPU_OCAPI) {
> +                       if (pnv_pci_controller_owns_addr(hose, addr, size))
> +                               return phb;
> +               }
> +       }
> +       return NULL;
> +}
> +
> +static u64 pnv_pci_dma_dir_to_opal_p2p(enum dma_data_direction dir)
> +{
> +       if (dir == DMA_TO_DEVICE)
> +               return OPAL_PCI_P2P_STORE;
> +       else if (dir == DMA_FROM_DEVICE)
> +               return OPAL_PCI_P2P_LOAD;
> +       else if (dir == DMA_BIDIRECTIONAL)
> +               return OPAL_PCI_P2P_LOAD | OPAL_PCI_P2P_STORE;
> +       else
> +               return 0;
> +}
> +
> +static int pnv_pci_ioda_enable_p2p(struct pci_dev *initiator,
> +                                  struct pnv_phb *phb_target,
> +                                  enum dma_data_direction dir)
> +{
> +       struct pci_controller *hose;
> +       struct pnv_phb *phb_init;
> +       struct pnv_ioda_pe *pe_init;
> +       u64 desc;
> +       int rc;
> +
> +       if (!opal_check_token(OPAL_PCI_SET_P2P))
> +               return -ENXIO;
> +

> +       hose = pci_bus_to_host(initiator->bus);
> +       phb_init = hose->private_data;

You can use the pci_bus_to_pnvhb() helper

> +
> +       pe_init = pnv_ioda_get_pe(initiator);
> +       if (!pe_init)
> +               return -ENODEV;
> +
> +       if (!pe_init->tce_bypass_enabled)
> +               return -EINVAL;
> +
> +       /*
> +        * Configuring the initiator's PHB requires to adjust its TVE#1
> +        * setting. Since the same device can be an initiator several times for
> +        * different target devices, we need to keep a reference count to know
> +        * when we can restore the default bypass setting on its TVE#1 when
> +        * disabling. Opal is not tracking PE states, so we add a reference
> +        * count on the PE in linux.
> +        *
> +        * For the target, the configuration is per PHB, so we keep a
> +        * target reference count on the PHB.
> +        */

This irks me a bit because configuring the DMA address limits for the
TVE is the kernel's job. What we really should be doing is using
opal_pci_map_pe_dma_window_real() to set the bypass-mode address limit
for the TVE to something large enough to hit the MMIO ranges rather
than having set_p2p do it as a side effect. Unfortunately, for some
reason skiboot doesn't implement support for enabling 56bit addressing
using opal_pci_map_pe_dma_window_real() and we do need to support
older kernel's which used this stuff so I guess we're stuck with it
for now. It'd be nice if we could fix this in the longer term
though...

> +       mutex_lock(&p2p_mutex);
> +
> +       desc = OPAL_PCI_P2P_ENABLE | pnv_pci_dma_dir_to_opal_p2p(dir);
> +       /* always go to opal to validate the configuration */
> +       rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id, desc,
> +                             pe_init->pe_number);
> +       if (rc != OPAL_SUCCESS) {
> +               rc = -EIO;
> +               goto out;
> +       }
> +
> +       pe_init->p2p_initiator_count++;
> +       phb_target->p2p_target_count++;
> +
> +       rc = 0;
> +out:
> +       mutex_unlock(&p2p_mutex);
> +       return rc;
> +}
> +
> +static int pnv_pci_dma_map_resource(struct pci_dev *pdev,
> +                                   phys_addr_t phys_addr, size_t size,
> +                                   enum dma_data_direction dir)
> +{
> +       struct pnv_phb *target_phb;
> +
> +       target_phb = pnv_pci_find_owning_phb(pdev, phys_addr, size);
> +       if (!target_phb)
> +               return 0;
> +
> +       return pnv_pci_ioda_enable_p2p(pdev, target_phb, dir);
> +}
> +
> +static int pnv_pci_ioda_disable_p2p(struct pci_dev *initiator,
> +               struct pnv_phb *phb_target)
> +{
> +       struct pci_controller *hose;
> +       struct pnv_phb *phb_init;
> +       struct pnv_ioda_pe *pe_init;
> +       int rc;
> +
> +       if (!opal_check_token(OPAL_PCI_SET_P2P))
> +               return -ENXIO;

This should probably have a WARN_ON() since we can't hit this path
unless the initial map succeeds.

> +       hose = pci_bus_to_host(initiator->bus);
> +       phb_init = hose->private_data;

pci_bus_to_pnvhb()

> +       pe_init = pnv_ioda_get_pe(initiator);
> +       if (!pe_init)
> +               return -ENODEV;
> +
> +       mutex_lock(&p2p_mutex);
> +
> +       if (!pe_init->p2p_initiator_count || !phb_target->p2p_target_count) {
> +               rc = -EINVAL;
> +               goto out;
> +       }
> +
> +       if (--pe_init->p2p_initiator_count == 0)
> +               pnv_pci_ioda2_set_bypass(pe_init, true);
> +
> +       if (--phb_target->p2p_target_count == 0) {
> +               rc = opal_pci_set_p2p(phb_init->opal_id, phb_target->opal_id,
> +                                     0, pe_init->pe_number);
> +               if (rc != OPAL_SUCCESS) {
> +                       rc = -EIO;
> +                       goto out;
> +               }
> +       }
> +
> +       rc = 0;
> +out:
> +       mutex_unlock(&p2p_mutex);
> +       return rc;
> +}
> +
> +static void pnv_pci_dma_unmap_resource(struct pci_dev *pdev,
> +                                      dma_addr_t addr, size_t size,
> +                                      enum dma_data_direction dir)
> +{
> +       struct pnv_phb *target_phb;
> +       int rc;
> +
> +       target_phb = pnv_pci_find_owning_phb(pdev, addr, size);
> +       if (!target_phb)
> +               return;
> +
> +       rc = pnv_pci_ioda_disable_p2p(pdev, target_phb);
> +       if (rc)
> +               dev_err(&pdev->dev, "Failed to undo PCI peer-to-peer setup for address %llx: %d\n",
> +                       addr, rc);

Use pci_err() or pe_err().
