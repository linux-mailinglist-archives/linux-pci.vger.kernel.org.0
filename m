Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 858A2E5428
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2019 21:15:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfJYTPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Oct 2019 15:15:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38540 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbfJYTPh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Oct 2019 15:15:37 -0400
Received: by mail-pl1-f193.google.com with SMTP id w8so1759441plq.5;
        Fri, 25 Oct 2019 12:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kD+tjQBMZ/Kzwr3+FKFta1lL67FtvDA1KxEZTDOTl4g=;
        b=NInZl2n0t1/gDeExYL1/6yisd3c76oTrodWsybCBjzFNHXvRAnp0Pte+mvw41k9r8l
         RcmhKAC9J5xZlCFgK+NnYmlkjz6sKwY8X2WhbZaid6oy9m7YRKKBFaNRYR8VhCt4JTMP
         r/kqjo+jqbCFZcQxE/aahJJJmPDhAjY6yXQb/Yf5BKi0q6X1354LcotBRpVRdDcPVG9t
         Dn9ImqfYsF4bfLUt2hOrnpLyjiFyVPPzZj8oImWavp2Vov4382BMN8Dlyt185eBblw0o
         yzNFeoc1NWwB8H03DeZ06WlD5lYYbXT2Du3xvpI8YflZhHdnr67rHirhEtQHJZgy2egA
         yQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kD+tjQBMZ/Kzwr3+FKFta1lL67FtvDA1KxEZTDOTl4g=;
        b=Fw3NyqPmCgevsNfL6tOg+GDM1Ml5vYVBOLCJSYxto4/K91JyX6T3S9yH1eWEKRparr
         WNV+KSh3+L4ssaL6J0YehrzJ4ituYW7Yus1KWwUGKboOTfcrpU4Gca4Ij9jCCdNSO4Yv
         QyXAbwiHKboq9cFbz0J6PA6L4zExlosEfmDKEhnPcl3NPx/n5ZQgd1RP0oX6mKMFTL0y
         ahf8RSfDQvYqOv7aBFn58I1xbqDf00k9ciCST6FhVXFX3ZAzuBxMsWWPL2QWj5jEIizh
         3GAV+Q18H27PRA5Re4qYGcysOFfbzp8rVCXMuGWOqJE2TJzXeyiZA+l6ic7EZssx6WGQ
         VZXA==
X-Gm-Message-State: APjAAAWNpEvls8jxYvi8IZ1JAbl8nUI0GpUCGdFYbV63DNt9IvRjYNxf
        fXpTCSUPMjwAe9Ba/mlzGH7K24l65xD7E1iDaNf8X9Y49Mk=
X-Google-Smtp-Source: APXvYqy1owYNaCwZnUik5nuZ5m6K8hOhekiWMgYF8Uq9aL+MLtKWvGLynxF5xPCuaZ326S5yFfYCQtsZd6OXwt1OxCw=
X-Received: by 2002:a17:902:9881:: with SMTP id s1mr5731612plp.18.1572030936171;
 Fri, 25 Oct 2019 12:15:36 -0700 (PDT)
MIME-Version: 1.0
References: <20191025190047.38130-1-stuart.w.hayes@gmail.com> <20191025190047.38130-2-stuart.w.hayes@gmail.com>
In-Reply-To: <20191025190047.38130-2-stuart.w.hayes@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 25 Oct 2019 22:15:24 +0300
Message-ID: <CAHp75Vd46k06WbU24Gq-+2GnzjvM0hTkMVK6+z842piDFJ-mOw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for disabling in-band presence
To:     Stuart Hayes <stuart.w.hayes@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 25, 2019 at 10:00 PM Stuart Hayes <stuart.w.hayes@gmail.com> wrote:
>
> From: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>
> The presence detect state (PDS) is normally a logical or of in-band and
> out-of-band presence. As of PCIe 4.0, there is the option to disable
> in-band presence so that the PDS bit always reflects the state of the
> out-of-band presence.
>
> The recommendation of the PCIe spec is to disable in-band presence
> whenever supported.
>

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/hotplug/pciehp.h     | 1 +
>  drivers/pci/hotplug/pciehp_hpc.c | 9 ++++++++-
>  include/uapi/linux/pci_regs.h    | 2 ++
>  3 files changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
> index 654c972b8ea0..27e4cd6529b0 100644
> --- a/drivers/pci/hotplug/pciehp.h
> +++ b/drivers/pci/hotplug/pciehp.h
> @@ -83,6 +83,7 @@ struct controller {
>         struct pcie_device *pcie;
>
>         u32 slot_cap;                           /* capabilities and quirks */
> +       unsigned int inband_presence_disabled:1;
>
>         u16 slot_ctrl;                          /* control register access */
>         struct mutex ctrl_lock;
> diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
> index 1a522c1c4177..dc109d521f30 100644
> --- a/drivers/pci/hotplug/pciehp_hpc.c
> +++ b/drivers/pci/hotplug/pciehp_hpc.c
> @@ -811,7 +811,7 @@ static inline void dbg_ctrl(struct controller *ctrl)
>  struct controller *pcie_init(struct pcie_device *dev)
>  {
>         struct controller *ctrl;
> -       u32 slot_cap, link_cap;
> +       u32 slot_cap, slot_cap2, link_cap;
>         u8 poweron;
>         struct pci_dev *pdev = dev->port;
>         struct pci_bus *subordinate = pdev->subordinate;
> @@ -869,6 +869,13 @@ struct controller *pcie_init(struct pcie_device *dev)
>                 FLAG(link_cap, PCI_EXP_LNKCAP_DLLLARC),
>                 pdev->broken_cmd_compl ? " (with Cmd Compl erratum)" : "");
>
> +       pcie_capability_read_dword(pdev, PCI_EXP_SLTCAP2, &slot_cap2);
> +       if (slot_cap2 & PCI_EXP_SLTCAP2_IBPD) {
> +               pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_IBPD_DISABLE,
> +                                     PCI_EXP_SLTCTL_IBPD_DISABLE);
> +               ctrl->inband_presence_disabled = 1;
> +       }
> +
>         /*
>          * If empty slot's power status is on, turn power off.  The IRQ isn't
>          * requested yet, so avoid triggering a notification with this command.
> diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> index 29d6e93fd15e..ea1cf9546e4d 100644
> --- a/include/uapi/linux/pci_regs.h
> +++ b/include/uapi/linux/pci_regs.h
> @@ -604,6 +604,7 @@
>  #define  PCI_EXP_SLTCTL_PWR_OFF        0x0400 /* Power Off */
>  #define  PCI_EXP_SLTCTL_EIC    0x0800  /* Electromechanical Interlock Control */
>  #define  PCI_EXP_SLTCTL_DLLSCE 0x1000  /* Data Link Layer State Changed Enable */
> +#define  PCI_EXP_SLTCTL_IBPD_DISABLE   0x4000 /* In-band PD disable */
>  #define PCI_EXP_SLTSTA         26      /* Slot Status */
>  #define  PCI_EXP_SLTSTA_ABP    0x0001  /* Attention Button Pressed */
>  #define  PCI_EXP_SLTSTA_PFD    0x0002  /* Power Fault Detected */
> @@ -676,6 +677,7 @@
>  #define PCI_EXP_LNKSTA2                50      /* Link Status 2 */
>  #define PCI_CAP_EXP_ENDPOINT_SIZEOF_V2 52      /* v2 endpoints with link end here */
>  #define PCI_EXP_SLTCAP2                52      /* Slot Capabilities 2 */
> +#define  PCI_EXP_SLTCAP2_IBPD  0x0001  /* In-band PD Disable Supported */
>  #define PCI_EXP_SLTCTL2                56      /* Slot Control 2 */
>  #define PCI_EXP_SLTSTA2                58      /* Slot Status 2 */
>
> --
> 2.18.1
>


-- 
With Best Regards,
Andy Shevchenko
