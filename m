Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC463C843E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jul 2021 14:04:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbhGNMHU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Jul 2021 08:07:20 -0400
Received: from mail-ot1-f48.google.com ([209.85.210.48]:37842 "EHLO
        mail-ot1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbhGNMHU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Jul 2021 08:07:20 -0400
Received: by mail-ot1-f48.google.com with SMTP id e1-20020a9d63c10000b02904b8b87ecc43so2202448otl.4;
        Wed, 14 Jul 2021 05:04:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5e9knfz3JG2gvEu2JVirrsq3sLTuduOyNuC1JgchsD0=;
        b=J+2TzqKqZXfTSoQnbwcAmHcwBFa0dmaZCyzZGSISr+sg/nyiEA/dFdY5N8EppxOqjh
         OOfSiPQ+4OebJWLV7k+YU+KsBok/7l79vV6YpAQ2wiBtdj25VKbo6E9fVNEfJDfa1LA5
         6CVOrsf6wlCpkcrKWygyoeLa9Oq0C0dgnU5fWTxDrPFtT3pHYBNt4KZYuBBbkhliOhro
         4L2ZoZwKji2rk1KJ20Ll4588m+wx2bLoru2dFmipflIKroVwwRqYlJ7npFRBxS/LpeaJ
         dR4IChYVJu88B06rB4n4FSHvv19ktlM47opLUo543W8tCnyMOiTGvJVe9olIYgDT60XJ
         inAA==
X-Gm-Message-State: AOAM5310gkHHzg83KZZPq8y3IQ6/WNMaDWBg+eFAvGmkK6BajkHh+usN
        PtplrttQow0S+Fpb2z3cyLqNW+qhAY5nHnpwYhU=
X-Google-Smtp-Source: ABdhPJyH6gHb9v+2jbbt+B7bBKNZJC6DMtAQiA/tEoDx2TTr3eweGm/4CmAvbMEjhoEXHsTd6x99boZ+xpCTfJGbb1c=
X-Received: by 2002:a9d:2968:: with SMTP id d95mr7885578otb.321.1626264268335;
 Wed, 14 Jul 2021 05:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210714085512.2176-1-joro@8bytes.org> <20210714085512.2176-2-joro@8bytes.org>
In-Reply-To: <20210714085512.2176-2-joro@8bytes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 14 Jul 2021 14:04:17 +0200
Message-ID: <CAJZ5v0if-5A0vZSTeDvqLtqE2jZrKjCFcRouR2uFgycZ7CdWkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 14, 2021 at 10:55 AM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> The acpi_pci_osc_support() does an _OSC query with _OSC supported set
> to what the OS supports but a zero _OSC control value, only to later
> claim the features Linux wants to control with an extra _OSC query.
>
> Nothing between the two _OSC querys depends on the result of the first
> one (if successfull), and if the supported query fails the control
> query will fail too. So it is a good code simplification to combine
> these two querys into one.
>
> As a result the acpi_pci_osc_support() function can be removed and
> acpi_pci_query_osc() be simplified because it no longer called with a
> NULL pointer for *control. Also some code duplication in the existing
> error paths was consolidated.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>
> ---
>  drivers/acpi/pci_root.c | 114 ++++++++++++++++++----------------------
>  1 file changed, 52 insertions(+), 62 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d7deedf3548e..c703832b7f7f 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -201,31 +201,20 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>
>         support &= OSC_PCI_SUPPORT_MASKS;
>         support |= root->osc_support_set;
> +       *control &= OSC_PCI_CONTROL_MASKS;
>
>         capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>         capbuf[OSC_SUPPORT_DWORD] = support;
> -       if (control) {
> -               *control &= OSC_PCI_CONTROL_MASKS;
> -               capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
> -       } else {
> -               /* Run _OSC query only with existing controls. */
> -               capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
> -       }
> +       capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
>
>         status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
>         if (ACPI_SUCCESS(status)) {
>                 root->osc_support_set = support;
> -               if (control)
> -                       *control = result;
> +               *control = result;
>         }
>         return status;
>  }
>
> -static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
> -{
> -       return acpi_pci_query_osc(root, flags, NULL);
> -}
> -
>  struct acpi_pci_root *acpi_pci_find_root(acpi_handle handle)
>  {
>         struct acpi_pci_root *root;
> @@ -348,7 +337,8 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * _OSC bits the BIOS has granted control of, but its contents are meaningless
>   * on failure.
>   **/
> -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32
> +                                           *mask, u32 req, u32 support)
>  {
>         struct acpi_pci_root *root;
>         acpi_status status;
> @@ -372,7 +362,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>
>         /* Need to check the available controls bits before requesting them. */
>         while (*mask) {
> -               status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> +               status = acpi_pci_query_osc(root, support, mask);
>                 if (ACPI_FAILURE(status))
>                         return status;
>                 if (ctrl == *mask)
> @@ -402,7 +392,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                                  bool is_pcie)
>  {
> -       u32 support, control, requested;
> +       u32 support, control = 0, requested;
>         acpi_status status;
>         struct acpi_device *device = root->device;
>         acpi_handle handle = device->handle;
> @@ -435,59 +425,49 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 support |= OSC_PCI_EDR_SUPPORT;
>
>         decode_osc_support(root, "OS supports", support);
> -       status = acpi_pci_osc_support(root, support);
> -       if (ACPI_FAILURE(status)) {
> -               *no_aspm = 1;
>
> -               /* _OSC is optional for PCI host bridges */
> -               if ((status == AE_NOT_FOUND) && !is_pcie)
> +       if (!pcie_ports_disabled) {

If pcie_ports_disabled is set, we don't want to request any control
from the platform firmware at all and, specifically, we don't want to
evaluate _OSC with the OSC_QUERY_ENABLE clear in
capbuf[OSC_QUERY_DWORD].

I'm not sure how this is achieved after your changes.

> +               if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> +                       decode_osc_support(root, "not requesting OS control; OS requires",
> +                                       ACPI_PCIE_REQ_SUPPORT);
>                         return;
> +               }
>
> -               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -                        acpi_format_exception(status));
> -               return;
> -       }
> -
> -       if (pcie_ports_disabled) {
> -               dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> -               return;
> -       }
> -
> -       if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> -               decode_osc_support(root, "not requesting OS control; OS requires",
> -                                  ACPI_PCIE_REQ_SUPPORT);
> -               return;
> -       }
> -
> -       control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -               | OSC_PCI_EXPRESS_PME_CONTROL;
> +               control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> +                       | OSC_PCI_EXPRESS_PME_CONTROL;
>
> -       if (IS_ENABLED(CONFIG_PCIEASPM))
> -               control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> +               if (IS_ENABLED(CONFIG_PCIEASPM))
> +                       control |= OSC_PCI_EXPRESS_LTR_CONTROL;
>
> -       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -               control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +               if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +                       control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>
> -       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> -               control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +               if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> +                       control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>
> -       if (pci_aer_available())
> -               control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +               if (pci_aer_available())
> +                       control |= OSC_PCI_EXPRESS_AER_CONTROL;
>
> -       /*
> -        * Per the Downstream Port Containment Related Enhancements ECN to
> -        * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> -        * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> -        * and EDR.
> -        */
> -       if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> -               control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +               /*
> +                * Per the Downstream Port Containment Related Enhancements ECN to
> +                * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> +                * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> +                * and EDR.
> +                */
> +               if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> +                       control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +       }
>
> +       /* Need an _OSC call even with pcie_ports_disabled set */
>         requested = control;
>         status = acpi_pci_osc_control_set(handle, &control,
> -                                         OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> +                                         OSC_PCI_EXPRESS_CAPABILITY_CONTROL,
> +                                         support);
> +
>         if (ACPI_SUCCESS(status)) {
> -               decode_osc_control(root, "OS now controls", control);
> +               if (control)
> +                       decode_osc_control(root, "OS now controls", control);
> +
>                 if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>                         /*
>                          * We have ASPM control, but the FADT indicates that
> @@ -498,10 +478,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                         *no_aspm = 1;
>                 }
>         } else {
> -               decode_osc_control(root, "OS requested", requested);
> -               decode_osc_control(root, "platform willing to grant", control);
> -               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -                       acpi_format_exception(status));
> +               /* Platform wants to control PCIe features */
> +               root->osc_support_set = 0;
>
>                 /*
>                  * We want to disable ASPM here, but aspm_disabled
> @@ -511,6 +489,18 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                  * root scan.
>                  */
>                 *no_aspm = 1;
> +
> +               /* _OSC is optional for PCI host bridges */
> +               if ((status == AE_NOT_FOUND) && !is_pcie)
> +                       return;
> +
> +               if (requested) {
> +                       decode_osc_control(root, "OS requested", requested);
> +                       decode_osc_control(root, "platform willing to grant", control);
> +               }
> +
> +               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> +                       acpi_format_exception(status));
>         }
>  }
>
> --
> 2.31.1
>
