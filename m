Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6D03FE296
	for <lists+linux-pci@lfdr.de>; Wed,  1 Sep 2021 20:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244718AbhIAS4I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Sep 2021 14:56:08 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36550 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347184AbhIASyg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Sep 2021 14:54:36 -0400
Received: by mail-oi1-f173.google.com with SMTP id s20so615461oiw.3;
        Wed, 01 Sep 2021 11:53:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FQvE5qqZIT/3rySEUdT9VMQxZS5n7lBZyNfmVX8wxEM=;
        b=PtYZ8+al/ZBJu/nXROEmwZwuLHdTU9D2gbFvxEq/1tHClDp1P7fSWCyMhxXf6btOlP
         TXUMiSDJdGb1S/39cU9o6ejA8pqH+I9hG6P4wNM6IWLdnJL6nO4+Tj4I1f5wVJkuY2er
         qHNXRGLpus6hUm+lP4xtRSvlH85EF/yAdRP5fSHxYNSB9j7bLGDuFNmdGL/qMbO43o/V
         06qF0NUUGgIAdWzu6v2n8UUBc15vgWxdHb0XVjCz0G/uKBwOrnFzWmrqpTEXu7LgCGGu
         i9z1+7SDQDgzHHD+i7OVY2eyhF+7poMXlfwEdQNRBxBdOh7T1FC2g3H9DTzA5Zj+PDLz
         s3FA==
X-Gm-Message-State: AOAM531dC+V1QYx4jetfQQvUIBoDuGa7zh20SbReTkEPV/J3srpfNefZ
        kbvKJyAU5FAHiL3Zzv/Zs8WdNz+ygL/j/59ZJQZLP1XT
X-Google-Smtp-Source: ABdhPJxw0UlgCiTAcLGipUkztf2JN2g4Gi7lcZcN8VThhrAl16F7OOiBE3tHOovk2C6OzqiGAtOUPHry+x5ARbXpgrk=
X-Received: by 2002:aca:afcd:: with SMTP id y196mr776417oie.71.1630522417861;
 Wed, 01 Sep 2021 11:53:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210824122054.29481-1-joro@8bytes.org> <20210824122054.29481-2-joro@8bytes.org>
In-Reply-To: <20210824122054.29481-2-joro@8bytes.org>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 1 Sep 2021 20:53:26 +0200
Message-ID: <CAJZ5v0iVKbL-4LngH7MeSZ69qArLC0488UR+kSnsPTsBD8qZnQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI/ACPI: Remove OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joerg Roedel <jroedel@suse.de>,
        Bjorn Helgaas <helgass@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 24, 2021 at 2:21 PM Joerg Roedel <joro@8bytes.org> wrote:
>
> From: Joerg Roedel <jroedel@suse.de>
>
> These masks are only used internally in the PCI Host Bridge _OSC
> negotiation code, which already makes sure nothing outside of these
> masks is set. Remove the masks and simplify the code.
>
> Suggested-by: Bjorn Helgaas <helgass@kernel.org>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Rafael J. Wysocki <rafael@kernel.org>

> ---
>  drivers/acpi/pci_root.c | 9 +++------
>  include/linux/acpi.h    | 2 --
>  2 files changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index d7deedf3548e..0c3030a58219 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -199,18 +199,15 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>         acpi_status status;
>         u32 result, capbuf[3];
>
> -       support &= OSC_PCI_SUPPORT_MASKS;
>         support |= root->osc_support_set;
>
>         capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
>         capbuf[OSC_SUPPORT_DWORD] = support;
> -       if (control) {
> -               *control &= OSC_PCI_CONTROL_MASKS;
> +       if (control)
>                 capbuf[OSC_CONTROL_DWORD] = *control | root->osc_control_set;
> -       } else {
> +       else
>                 /* Run _OSC query only with existing controls. */
>                 capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
> -       }
>
>         status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
>         if (ACPI_SUCCESS(status)) {
> @@ -357,7 +354,7 @@ static acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 r
>         if (!mask)
>                 return AE_BAD_PARAMETER;
>
> -       ctrl = *mask & OSC_PCI_CONTROL_MASKS;
> +       ctrl = *mask;
>         if ((ctrl & req) != req)
>                 return AE_TYPE;
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index 72e4f7fd268c..c6dba5f21384 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -577,7 +577,6 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_MSI_SUPPORT                    0x00000010
>  #define OSC_PCI_EDR_SUPPORT                    0x00000080
>  #define OSC_PCI_HPX_TYPE_3_SUPPORT             0x00000100
> -#define OSC_PCI_SUPPORT_MASKS                  0x0000019f
>
>  /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
>  #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL      0x00000001
> @@ -587,7 +586,6 @@ extern u32 osc_sb_native_usb4_control;
>  #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL     0x00000010
>  #define OSC_PCI_EXPRESS_LTR_CONTROL            0x00000020
>  #define OSC_PCI_EXPRESS_DPC_CONTROL            0x00000080
> -#define OSC_PCI_CONTROL_MASKS                  0x000000bf
>
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK           0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
> --
> 2.32.0
>
