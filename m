Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7403FE30F
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 21:32:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344608AbhIATcv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 15:32:51 -0400
Received: from mail-oo1-f41.google.com ([209.85.161.41]:43970 "EHLO
        mail-oo1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244842AbhIATcu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 15:32:50 -0400
Received: by mail-oo1-f41.google.com with SMTP id y16-20020a4ad6500000b0290258a7ff4058so209362oos.10;
        Wed, 01 Sep 2021 12:31:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b7NxDX0Jgp22/kVGMB1nWmyMaD1Bg4FZTH3WEct9lqY=;
        b=oUQ8SdnRRM67NnICZ8PPKkvi5ZsV3LkNESCrkWx8eVJgPfbvEVZNh2iMBYPvABo0qg
         9uNrW/Iv5wc/5lHJFaaUEAdgmRM9vTSBY3t0lFXWgR4rg9UxudeMoodDkDy91WY7Wtyv
         vh1k4SmSn0Clvp7x1SwuNTvYhC9MV9JuD24cXyWeoxDtZ2sD6PpZoYjMO1AlFqjbntk7
         sXo6uc/InP1izaXtkE1FRGGqEQ/Pe22LkZheQzyCDWayT6hzPt7uvaR6uAYUixgR/vex
         iOMC80hBSwW7fR/B0wX21EhloJKWtgghfoA77hyNBw6t+HfMWlOk/kSVs6fduyqDNOSq
         uv4w==
X-Gm-Message-State: AOAM5317KQEcgQnHKLIpR1TJGayVOO7t3rAHXaYyFhyUPVnswKDVqvct
        2scv1IwCE6rgUGpyH+CPR/rYWLGywn/n95xgfuc=
X-Google-Smtp-Source: ABdhPJwBNtz8TxaF5pnDsgmMoITlpBvrIt1Pfe1QYXrD8NaCogysKqL3TeDYMiIA9W7aOBtSw9yF1iEIuNzHFt773WY=
X-Received: by 2002:a4a:a552:: with SMTP id s18mr832630oom.1.1630524713082;
 Wed, 01 Sep 2021 12:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org> <20210824122054.29481-5-joro@8bytes.org>
In-Reply-To: <20210824122054.29481-5-joro@8bytes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 21:31:42 +0200
Message-ID: <CAJZ5v0hUvzhG4u+rwTLCFdcWS-ubPvSxsx_kcUGvQHtQoApNwg@mail.gmail.com>
Subject: Re: [PATCH v3 4/4] PCI/ACPI: Check for _OSC support in acpi_pci_osc_control_set()
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
> Get rid of acpi_pci_osc_support() and check for _OSC supported features
> directly in acpi_pci_osc_control_set(). There is no point in doing an
> unconditional _OSC query with control=0 even when the kernel later wants
> to take control over more features.
>
> This safes one _OSC query and simplifies the code by getting rid of

s/safes/saves/

> the acpi_pci_osc_support() function. As a side effect, the !control
> checks in acpi_pci_query_osc() can also be removed.
>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Apart from the typo above, I haven't found any issues in the patch, so

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/pci_root.c | 81 ++++++++++++++++-------------------------
>  1 file changed, 32 insertions(+), 49 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index f12e512bcddc..ab2f7dfb0c44 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -203,26 +203,16 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>
>         capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>         capbuf[OSC_SUPPORT_DWORD] = support;
> -       if (control)
> -               capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
> -       else
> -               /* Run _OSC query only with existing controls. */
> -               capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
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
> @@ -345,8 +335,9 @@ EXPORT_SYMBOL_GPL(acpi_get_pci_dev);
>   * _OSC bits the BIOS has granted control of, but its contents are meaningless
>   * on failure.
>   **/
> -static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> +static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 support)
>  {
> +       u32 req = OSC_PCI_EXPRESS_CAPABILITY_CONTROL;
>         struct acpi_pci_root *root;
>         acpi_status status;
>         u32 ctrl, capbuf[3];
> @@ -354,22 +345,16 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>         if (!mask)
>                 return AE_BAD_PARAMETER;
>
> -       ctrl = *mask;
> -       if ((ctrl & req) != req)
> -               return AE_TYPE;
> -
>         root = acpi_pci_find_root(handle);
>         if (!root)
>                 return AE_NOT_EXIST;
>
> -       *mask = ctrl | root->osc_control_set;
> -       /* No need to evaluate _OSC if the control was already granted. */
> -       if ((root->osc_control_set & ctrl) == ctrl)
> -               return AE_OK;
> +       ctrl   = *mask;
> +       *mask |= root->osc_control_set;
>
>         /* Need to check the available controls bits before requesting them. */
> -       while (*mask) {
> -               status = acpi_pci_query_osc(root, root->osc_support_set, mask);
> +       do {
> +               status = acpi_pci_query_osc(root, support, mask);
>                 if (ACPI_FAILURE(status))
>                         return status;
>                 if (ctrl == *mask)
> @@ -377,7 +362,11 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>                 decode_osc_control(root, "platform does not support",
>                                    ctrl & ~(*mask));
>                 ctrl = *mask;
> -       }
> +       } while (*mask);
> +
> +       /* No need to request _OSC if the control was already granted. */
> +       if ((root->osc_control_set & ctrl) == ctrl)
> +               return AE_OK;
>
>         if ((ctrl & req) != req) {
>                 decode_osc_control(root, "not requesting control; platform does not support",
> @@ -470,7 +459,7 @@ static bool os_control_query_checks(struct acpi_pci_root *root, u32 support)
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                                  bool is_pcie)
>  {
> -       u32 support, control, requested;
> +       u32 support, control = 0, requested = 0;
>         acpi_status status;
>         struct acpi_device *device = root->device;
>         acpi_handle handle = device->handle;
> @@ -490,28 +479,15 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>         support = calculate_support();
>
>         decode_osc_support(root, "OS supports", support);
> -       status = acpi_pci_osc_support(root, support);
> -       if (ACPI_FAILURE(status)) {
> -               *no_aspm = 1;
> -
> -               /* _OSC is optional for PCI host bridges */
> -               if ((status == AE_NOT_FOUND) && !is_pcie)
> -                       return;
> -
> -               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -                        acpi_format_exception(status));
> -               return;
> -       }
> -
> -       if (!os_control_query_checks(root, support))
> -               return;
>
> -       requested = control = calculate_control();
> +       if (os_control_query_checks(root, support))
> +               requested = control = calculate_control();
>
> -       status = acpi_pci_osc_control_set(handle, &control,
> -                                         OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> +       status = acpi_pci_osc_control_set(handle, &control, support);
>         if (ACPI_SUCCESS(status)) {
> -               decode_osc_control(root, "OS now controls", control);
> +               if (control)
> +                       decode_osc_control(root, "OS now controls", control);
> +
>                 if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>                         /*
>                          * We have ASPM control, but the FADT indicates that
> @@ -522,11 +498,6 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                         *no_aspm = 1;
>                 }
>         } else {
> -               decode_osc_control(root, "OS requested", requested);
> -               decode_osc_control(root, "platform willing to grant", control);
> -               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> -                       acpi_format_exception(status));
> -
>                 /*
>                  * We want to disable ASPM here, but aspm_disabled
>                  * needs to remain in its state from boot so that we
> @@ -535,6 +506,18 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
>                  * root scan.
>                  */
>                 *no_aspm = 1;
> +
> +               /* _OSC is optional for PCI host bridges */
> +               if ((status == AE_NOT_FOUND) && !is_pcie)
> +                       return;
> +
> +               if (control) {
> +                       decode_osc_control(root, "OS requested", requested);
> +                       decode_osc_control(root, "platform willing to grant", control);
> +               }
> +
> +               dev_info(&device->dev, "_OSC: platform retains control of PCIe features (%s)\n",
> +                        acpi_format_exception(status));
>         }
>  }
>
> --
> 2.32.0
>
