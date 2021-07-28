Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD723D96A4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 22:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhG1UXH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 16:23:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:53342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhG1UXG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 16:23:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8945860F5E;
        Wed, 28 Jul 2021 20:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627503784;
        bh=IZKviyNvA8qCDPgEtTdBEe4q653tjvzIedoyZEITG0I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qEJWSFuS/tFFj7gwilRIyS2qb1vlIZvZk15+A5ndtBGJMWx6M8Bwz1eQpH5btfj0K
         oepk9btELOpBnq3D4Fp3te7rwyBLqKR4kZYSxk3CoZAlMAmfpIDLwiFV+PmvXLKxah
         AaBnkcFL+2GWV+9p6oeENJ84biTnQRFaKZNbl4cBydaIhIMyHImnIy9ULm7bZPLa6M
         Hu0Ak9ALx7treaU5G105Fq3AqSmCQVcUu2o5WpFdfi9FbHLjeXLIdSc6DgOrkAEGaA
         wRVKmy2VNJs3ADBsmLJts1Zp49atR0L0EK58rb5muTx667Zc38bPywLviuItqkwUV8
         u0FJiupqWW4gg==
Date:   Wed, 28 Jul 2021 15:23:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shanker R Donthineni <sdonthineni@nvidia.com>
Cc:     Amey Narkhede <ameynarkhede03@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Sinan Kaya <okaya@kernel.org>,
        Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v10 1/8] PCI: Add pcie_reset_flr to follow calling
 convention of other reset methods
Message-ID: <20210728202303.GA847802@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <709c80db-3420-917d-31de-a5161aaf30ac@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 28, 2021 at 01:54:16PM -0500, Shanker R Donthineni wrote:
> On 7/27/21 5:12 PM, Bjorn Helgaas wrote:
> > On Fri, Jul 09, 2021 at 06:08:06PM +0530, Amey Narkhede wrote:
> >> Add has_pcie_flr bitfield in struct pci_dev to indicate support for PCIe
> >> FLR to avoid reading PCI_EXP_DEVCAP multiple times.
> >>
> >> Currently there is separate function pcie_has_flr() to probe if PCIe FLR
> >> is supported by the device which does not match the calling convention
> >> followed by reset methods which use second function argument to decide
> >> whether to probe or not. Add new function pcie_reset_flr() that follows
> >> the calling convention of reset methods.
> >>
> >> Signed-off-by: Amey Narkhede <ameynarkhede03@gmail.com>
> >> ---
> >>  drivers/crypto/cavium/nitrox/nitrox_main.c |  4 +-
> >>  drivers/pci/pci.c                          | 59 +++++++++++-----------
> >>  drivers/pci/pcie/aer.c                     | 12 ++---
> >>  drivers/pci/probe.c                        |  6 ++-
> >>  drivers/pci/quirks.c                       |  9 ++--
> >>  include/linux/pci.h                        |  3 +-
> >>  6 files changed, 45 insertions(+), 48 deletions(-)
> >>
> >> diff --git a/drivers/crypto/cavium/nitrox/nitrox_main.c b/drivers/crypto/cavium/nitrox/nitrox_main.c
> >> index facc8e6bc..15d6c8452 100644
> >> --- a/drivers/crypto/cavium/nitrox/nitrox_main.c
> >> +++ b/drivers/crypto/cavium/nitrox/nitrox_main.c
> >> @@ -306,9 +306,7 @@ static int nitrox_device_flr(struct pci_dev *pdev)
> >>               return -ENOMEM;
> >>       }
> >>
> >> -     /* check flr support */
> >> -     if (pcie_has_flr(pdev))
> >> -             pcie_flr(pdev);
> >> +     pcie_reset_flr(pdev, 0);
> > I'm not really a fan of exposing the "probe" argument outside
> > drivers/pci/.  I think this would be the only occurrence.  Is there a
> > way to avoid that?
> >
> > Can we just make pcie_flr() do the equivalent of pcie_has_flr()
> > internally?
> >
> I like your suggestion don't change the existing definition of
> pcie_has_flr()/pcie_flr() and define a new function pcie_reset_flr()
> to fit into the reset framework. This way no need to modify
> logic/drivers outside of driver/pci/xxx.
> 
> int pcie_reset_flr(struct pci_dev *dev, int probe)
> {
>         if (!pcie_has_flr(dev))
>                 return -ENOTTY;
> 
>         if (probe)
>                 return 0;
> 
>         return pcie_flr(dev);
> }

Can't remember the whole context of this in the series, but I assume
this would be static?

> And add a new patch to begging of the series for caching 'devcap' in
> pci_dev structure.
> 
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -333,6 +333,7 @@ struct pci_dev {
>         struct rcec_ea  *rcec_ea;       /* RCEC cached endpoint association */
>         struct pci_dev  *rcec;          /* Associated RCEC device */
>  #endif
> +       u32             devcap;         /* Cached PCIe device capabilities */
>         u8              pcie_cap;       /* PCIe capability offset */
>         u8              msi_cap;        /* MSI capability offset */
>         u8              msix_cap;       /* MSI-X capability offset */
> 
> 
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -31,6 +31,7 @@
>  #include <linux/vmalloc.h>
>  #include <asm/dma.h>
>  #include <linux/aer.h>
> +#include <linux/bitfield.h>
>  #include "pci.h"
> 
>  DEFINE_MUTEX(pci_slot_mutex);
> @@ -4630,13 +4631,10 @@ EXPORT_SYMBOL(pci_wait_for_pending_transaction);
>   */
>  bool pcie_has_flr(struct pci_dev *dev)
>  {
> -       u32 cap;
> -
>         if (dev->dev_flags & PCI_DEV_FLAGS_NO_FLR_RESET)
>                 return false;
> 
> -       pcie_capability_read_dword(dev, PCI_EXP_DEVCAP, &cap);
> -       return cap & PCI_EXP_DEVCAP_FLR;
> +       return !!FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap);

Nice, thanks for reminding me of FIELD_GET().  I like how that works
without having to #define *_SHIFT values.  I personally don't care for
"!!" and would probably write something like:

  return FIELD_GET(PCI_EXP_DEVCAP_FLR, dev->devcap) == 1;

>  }
> 
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -19,6 +19,7 @@
>  #include <linux/hypervisor.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/bitfield.h>
>  #include "pci.h"
> 
>  #define CARDBUS_LATENCY_TIMER  176     /* secondary latency timer */
> @@ -1498,8 +1499,8 @@ void set_pcie_port_type(struct pci_dev *pdev)
>         pdev->pcie_cap = pos;
>         pci_read_config_word(pdev, pos + PCI_EXP_FLAGS, &reg16);
>         pdev->pcie_flags_reg = reg16;
> -       pci_read_config_word(pdev, pos + PCI_EXP_DEVCAP, &reg16);
> -       pdev->pcie_mpss = reg16 & PCI_EXP_DEVCAP_PAYLOAD;
> +       pci_read_config_dword(pdev, pos + PCI_EXP_DEVCAP, &pdev->devcap);
> +       pdev->pcie_mpss = FIELD_GET(PCI_EXP_DEVCAP_PAYLOAD, pdev->devcap);
> 
