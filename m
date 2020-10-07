Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C1D286549
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 18:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728062AbgJGQx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 12:53:29 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:41754 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbgJGQx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 12:53:29 -0400
Received: by mail-ot1-f66.google.com with SMTP id q21so2852483ota.8;
        Wed, 07 Oct 2020 09:53:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0A+i/MnG7ofk1/uow7Ro700CbvukkHEpDKrbjreJTRc=;
        b=QHWWg0b8jTnc9x1ukbEWEcd0ak2+6OsQiKET89hEQni5yX3hKHdkuCd1H1+3ioUcN0
         Gz9l9V20p+SUR5wmncysfoYoQf+hk97iyCkrIWNKF5AAROVfnfONOetp2fOXi7wk9/79
         4hdHY44nh1zMyYjRxmAML99por+CTqQBmrEXoxVC5Nic1rrDoHwTqgQ3iuEjQ8FqPAl7
         Y2oheFDKDkxso5hHHIAl1mgpbwl9kolslEF+hOEe8VZv0RjS9Kfp8SShALFMsCdvuqEO
         eaeOywcnKwNJxzSabcISDKifqQUImggOYDQZCaTEwa8UcsiIjPhHA8UkNfVQ8A7fDuof
         4uxQ==
X-Gm-Message-State: AOAM530ppGilp+870PRVH/jZOrNkl6g1zQXnxhJPldqgAB3Nevdm2hYn
        A+B4XTGbdbS0t92MU2JWFLEOXeT2GZXupXKcTKKxuLW/
X-Google-Smtp-Source: ABdhPJw4S694LNMITp3AqYQCdCiM9gQ1FgdvqLSxqsYd0Y4fue2dbiG3/bedis6HuatQ8Q8D2nJgp+iE5QSoLHuT9C8=
X-Received: by 2002:a9d:3626:: with SMTP id w35mr2533946otb.206.1602089607809;
 Wed, 07 Oct 2020 09:53:27 -0700 (PDT)
MIME-Version: 1.0
References: <20201007164851.1218-1-david.e.box@linux.intel.com>
In-Reply-To: <20201007164851.1218-1-david.e.box@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 7 Oct 2020 18:53:16 +0200
Message-ID: <CAJZ5v0gRph3UMffWqUVqTnDE149Ai-SbzmhjzZU1x=QOzAZeZA@mail.gmail.com>
Subject: Re: [PATCH] PCI: Disable PTM during suspend on Intel PCI bridges
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 7, 2020 at 6:49 PM David E. Box <david.e.box@linux.intel.com> wrote:
>
> On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
> Time Measurement (PTM) capability can prevent PCIe root ports from power
> gating during suspend-to-idle, causing increased power consumption on
> systems that suspend using Low Power S0 Idle [1]. The issue is yet to be
> root caused but believed to be coming from a race condition in the suspend
> flow as the incidence rate varies for different platforms on Linux but the
> issue does not occur at all in other operating systems. For now, disable
> the feature on suspend on all Intel root ports and enable again on resume.

IMV it should also be noted that there is no particular reason why PTM
would need to be enabled while the whole system is suspended.  At
least it doesn't seem to be particularly useful in that state.

> Link: https://www.uefi.org/sites/default/files/resources/Intel_ACPI_Low_Power_S0_Idle.pdf
> Bug: https://bugzilla.kernel.org/show_bug.cgi?id=209361
> Tested-by: Len Brown <len.brown@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/pci/quirks.c | 57 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index bdf9b52567e0..e82b1f60c7a1 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5632,3 +5632,60 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
>  }
>  DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
>                                PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
> +
> +#ifdef CONFIG_PCIE_PTM
> +/*
> + * On Intel Platform Controller Hubs (PCH) since Cannon Lake, the Precision
> + * Time Measurement (PTM) capability can prevent the PCIe root port from
> + * power gating during suspend-to-idle, causing increased power consumption.
> + * So disable the feature on suspend on all Intel root ports and enable
> + * again on resume.
> + */
> +static void quirk_intel_ptm_disable_suspend(struct pci_dev *dev)
> +{
> +       int pos;
> +       u32 ctrl;
> +
> +       if (!(dev->ptm_enabled && dev->ptm_root))
> +               return;
> +
> +       pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +       if (!pos)
> +               return;
> +
> +       pci_dbg(dev, "quirk: disabling PTM\n");
> +
> +       dev->ptm_enabled = 0;
> +       dev->ptm_root = 0;
> +
> +       pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
> +       ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
> +       pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> +}
> +
> +static void quirk_intel_ptm_enable_resume(struct pci_dev *dev)
> +{
> +       int pos;
> +       u32 ctrl;
> +
> +       pos = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
> +       if (!pos)
> +               return;
> +
> +       pci_dbg(dev, "quirk: re-enabling PTM\n");
> +
> +       pci_read_config_dword(dev, pos + PCI_PTM_CTRL, &ctrl);
> +       ctrl |= PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT;
> +       pci_write_config_dword(dev, pos + PCI_PTM_CTRL, ctrl);
> +
> +       dev->ptm_enabled = 1;
> +       dev->ptm_root = 1;
> +}
> +
> +DECLARE_PCI_FIXUP_CLASS_SUSPEND(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +                               PCI_CLASS_BRIDGE_PCI, 8,
> +                               quirk_intel_ptm_disable_suspend)
> +DECLARE_PCI_FIXUP_CLASS_RESUME(PCI_VENDOR_ID_INTEL, PCI_ANY_ID,
> +                              PCI_CLASS_BRIDGE_PCI, 8,
> +                              quirk_intel_ptm_enable_resume)
> +#endif
> --
> 2.20.1
>
