Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B413FE29E
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 20:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhIAS5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 14:57:14 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:34738 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243041AbhIAS5O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 14:57:14 -0400
Received: by mail-ot1-f53.google.com with SMTP id k12-20020a056830150c00b0051abe7f680bso1000330otp.1;
        Wed, 01 Sep 2021 11:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E9bqJvVk7sefatZNeeY+ec6MRgFjX45AV2lWjhc9EJ0=;
        b=Qsywx38aXHHz84MDPrJ90HpFxUU6HZjSSySKsTHWzABVp6qK75cqDLbvILsuK+9pOd
         Af/QJyQ0hbOPVC0Xvd8PNsqMXaJzuV51r5T1LbtiPIApQE9D9Qvl906IQX141r+CdrFD
         qw3QJk9hmI5xw/dy0qQagZt1kzCph+FoRQJ1Vjoa1HE6ds4iwJ9oWlMH4Je9pyXONWCB
         lZ0YdLcNztwAnb+ArV5z7ZfHk96gqtUSd/p37sfeMkNcztgRBiT1aYx7Yv9Y/7k+IeAN
         hfYQmb2dCRuyvq2znTDJsRG9MKDUz6mcMzv7wRF8/Al/06lWG00eE9Rn4sPHcP5QtZJt
         I71g==
X-Gm-Message-State: AOAM533jRcwcxbIDofxQmwpqQcI8tuLMMXJOsWqxTRdI9qY6KleNOUwF
        mEid8eambNYIGqT/nASK+XmcN2AcDsWTOkPov4RZ30UF
X-Google-Smtp-Source: ABdhPJzgMGwOX1BcY9pT+XeTDoymIb/6s7rE5aq1NTVs8WdEfv3qMDD+qdeRlVkTzECtzzclaOKoh3DlpRE2kyzBT24=
X-Received: by 2002:a9d:7115:: with SMTP id n21mr766215otj.321.1630522576937;
 Wed, 01 Sep 2021 11:56:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org> <20210824122054.29481-3-joro@8bytes.org>
In-Reply-To: <20210824122054.29481-3-joro@8bytes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 20:56:05 +0200
Message-ID: <CAJZ5v0gHEY1FW7A-rytBkSrxidusd3jNPJOke6QWxwoE5VXeiA@mail.gmail.com>
Subject: Re: [PATCH v3 2/4] PCI/ACPI: Move supported and control calculations
 to separaten functions
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

On Tue, Aug 24, 2021 at 2:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> Move the calculations of supported and controled _OSC features out of
> negotiate_os_control into separate functions.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/pci_root.c | 93 ++++++++++++++++++++++++-----------------
>  1 file changed, 55 insertions(+), 38 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index 0c3030a58219..ed4e6b55e9bc 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -396,6 +396,59 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>         return AE_OK;
>  }
>
> +static u32 calculate_support(void)
> +{
> +       u32 support;
> +
> +       /*
> +        * All supported architectures that use ACPI have support for
> +        * PCI domains, so we indicate this in _OSC support capabilities.
> +        */
> +       support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
> +       support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
> +       if (pci_ext_cfg_avail())
> +               support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> +       if (pcie_aspm_support_enabled())
> +               support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> +       if (pci_msi_enabled())
> +               support |= OSC_PCI_MSI_SUPPORT;
> +       if (IS_ENABLED(CONFIG_PCIE_EDR))
> +               support |= OSC_PCI_EDR_SUPPORT;
> +
> +       return support;
> +}
> +
> +static u32 calculate_control(void)
> +{
> +       u32 control;
> +
> +       control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> +               | OSC_PCI_EXPRESS_PME_CONTROL;
> +
> +       if (IS_ENABLED(CONFIG_PCIEASPM))
> +               control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> +
> +       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +               control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +
> +       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> +               control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +
> +       if (pci_aer_available())
> +               control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +
> +       /*
> +        * Per the Downstream Port Containment Related Enhancements ECN to
> +        * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> +        * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> +        * and EDR.
> +        */
> +       if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> +               control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +
> +       return control;
> +}
> +
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                                  bool is_pcie)
>  {
> @@ -416,20 +469,7 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 return;
>         }
>
> -       /*
> -        * All supported architectures that use ACPI have support for
> -        * PCI domains, so we indicate this in _OSC support capabilities.
> -        */
> -       support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
> -       support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
> -       if (pci_ext_cfg_avail())
> -               support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> -       if (pcie_aspm_support_enabled())
> -               support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> -       if (pci_msi_enabled())
> -               support |= OSC_PCI_MSI_SUPPORT;
> -       if (IS_ENABLED(CONFIG_PCIE_EDR))
> -               support |= OSC_PCI_EDR_SUPPORT;
> +       support = calculate_support();
>
>         decode_osc_support(root, "OS supports", support);
>         status = acpi_pci_osc_support(root, support);
> @@ -456,31 +496,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                 return;
>         }
>
> -       control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -               | OSC_PCI_EXPRESS_PME_CONTROL;
> -
> -       if (IS_ENABLED(CONFIG_PCIEASPM))
> -               control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> -
> -       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -               control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> -
> -       if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> -               control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> -
> -       if (pci_aer_available())
> -               control |= OSC_PCI_EXPRESS_AER_CONTROL;
> -
> -       /*
> -        * Per the Downstream Port Containment Related Enhancements ECN to
> -        * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> -        * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> -        * and EDR.
> -        */
> -       if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> -               control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +       requested = control = calculate_control();
>
> -       requested = control;
>         status = acpi_pci_osc_control_set(handle, &control,
>                                           OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
>         if (ACPI_SUCCESS(status)) {
> --
> 2.32.0
>
