Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BEFB2F33AB
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 16:11:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbhALPKh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 10:10:37 -0500
Received: from mail-ot1-f50.google.com ([209.85.210.50]:40652 "EHLO
        mail-ot1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbhALPKh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 10:10:37 -0500
Received: by mail-ot1-f50.google.com with SMTP id j12so2533191ota.7;
        Tue, 12 Jan 2021 07:10:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pcBO8sb+sjMk4k1VoOwa7CYilVT8or8BtnTAcb+KTi0=;
        b=Kg8mRJ+5zEXQIAe9kzv4295YZTfT2Ox4KLU71P5o+4vDN7yyydPoADqkeuPW8CfcAR
         hVpI1NoLz5OlGvagP5Yr4NtAcfxEim+Cli6U2bB05DgLlZXp673SZJrvJU5xUGWrwlcB
         7on/fu2D70qwFSclM88KxKvC8CEUYHKG+nzhdBJnbUGn+6YzWyPZfkiNmfb0qMwf1rCG
         LQmY3Xj7hMzqQKfFukuno+C6bApxfJNJFF+mXxGYCNL5txb2zV2BRVeaJHKdRY+UtswU
         1CcUdbZELex0/ltOcAQJ9kGxiJ4tL5zwwPNNqkDL4wkl9abONFGJ3MhwTgv2YDE247vT
         1V5A==
X-Gm-Message-State: AOAM533fdS/A9E5cNs/33e0j7zzN8hvo2csJ7TLv1ezFRVAshvlV8xaG
        IgiEkiwL0bgyGdDoi+Cif4OXAxeYloE0OHFwDZA=
X-Google-Smtp-Source: ABdhPJxgU2dXiNT7ZtWi3jUG5xk7B0nDa0SML3GpZSS2q5p3NREhYf/aB7ySz0uZ1hnWp0j9+CpSF3pswwPSZnvG9+w=
X-Received: by 2002:a9d:208a:: with SMTP id x10mr3011720ota.260.1610464196160;
 Tue, 12 Jan 2021 07:09:56 -0800 (PST)
MIME-Version: 1.0
References: <20210111225121.820014-1-ben.widawsky@intel.com> <20210111225121.820014-4-ben.widawsky@intel.com>
In-Reply-To: <20210111225121.820014-4-ben.widawsky@intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 12 Jan 2021 16:09:44 +0100
Message-ID: <CAJZ5v0g1knRiK16H1z6xHXwuiZOA_Se43tDyF_sQZdDFvUcPxA@mail.gmail.com>
Subject: Re: [RFC PATCH v3 03/16] cxl/acpi: add OSC support
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Vishal Verma <vishal.l.verma@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Something has gone wrong with CCing this to linux-acpi, but no worries.

On Tue, Jan 12, 2021 at 1:29 AM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> From: Vishal Verma <vishal.l.verma@intel.com>
>
> Add support to advertise OS capabilities, and request OS control for CXL
> features using the ACPI _OSC mechanism. Advertise support for all
> possible CXL features, and attempt to request control for all possible
> features.
>
> Based on a patch by Sean Kelley.
>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  Documentation/cxl/memory-devices.rst |  15 ++
>  drivers/cxl/acpi.c                   | 260 ++++++++++++++++++++++++++-
>  drivers/cxl/acpi.h                   |  20 +++
>  3 files changed, 292 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
> index aa4262280c67..6ce88f9d5f4f 100644
> --- a/Documentation/cxl/memory-devices.rst
> +++ b/Documentation/cxl/memory-devices.rst
> @@ -13,3 +13,18 @@ Driver Infrastructure
>  =====================
>
>  This sections covers the driver infrastructure for a CXL memory device.
> +
> +ACPI CXL
> +--------
> +
> +.. kernel-doc:: drivers/cxl/acpi.c
> +   :doc: cxl acpi
> +
> +.. kernel-doc:: drivers/cxl/acpi.c
> +   :internal:
> +
> +External Interfaces
> +===================
> +
> +.. kernel-doc:: drivers/cxl/acpi.c
> +   :export:
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 0f1ba9b3f1ed..af9c0dfdee20 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -11,7 +11,258 @@
>  #include <linux/pci.h>
>  #include "acpi.h"
>
> -/*
> +/**
> + * DOC: cxl acpi
> + *
> + * ACPI _OSC setup: The exported function cxl_bus_acquire() sets up ACPI
> + * Operating System Capabilities (_OSC) for the CXL bus. It declares support
> + * for all CXL capabilities, and attempts to request control for all possible
> + * capabilities. The resulting support and control sets are saved in global
> + * variables cxl_osc_support_set and cxl_osc_control_set. The internal
> + * functions cxl_osc_declare_support(), and cxl_osc_request_control() can be
> + * used to update the support and control sets in accordance with the ACPI
> + * rules for _OSC evaluation - most importantly, capabilities already granted
> + * should not be rescinded by either the OS or firmware.
> + */
> +
> +static u32 cxl_osc_support_set;
> +static u32 cxl_osc_control_set;
> +static DEFINE_MUTEX(acpi_desc_lock);
> +
> +struct pci_osc_bit_struct {
> +       u32 bit;
> +       char *desc;
> +};
> +
> +static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
> +       { CXL_OSC_PORT_REG_ACCESS_SUPPORT, "CXLPortRegAccess" },
> +       { CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT, "CXLPortDevRegAccess" },
> +       { CXL_OSC_PER_SUPPORT, "CXLProtocolErrorReporting" },
> +       { CXL_OSC_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
> +};
> +
> +static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
> +       { CXL_OSC_MEM_ERROR_CONTROL, "CXLMemErrorReporting" },
> +};
> +
> +static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
> +
> +static void decode_osc_bits(struct device *dev, char *msg, u32 word,
> +                           struct pci_osc_bit_struct *table, int size)
> +{
> +       char buf[80];
> +       int i, len = 0;
> +       struct pci_osc_bit_struct *entry;
> +
> +       buf[0] = '\0';
> +       for (i = 0, entry = table; i < size; i++, entry++)
> +               if (word & entry->bit)
> +                       len += scnprintf(buf + len, sizeof(buf) - len, "%s%s",
> +                                        len ? " " : "", entry->desc);
> +
> +       dev_info(dev, "_OSC: %s [%s]\n", msg, buf);
> +}
> +
> +static void decode_cxl_osc_support(struct device *dev, char *msg, u32 word)
> +{
> +       decode_osc_bits(dev, msg, word, cxl_osc_support_bit,
> +                       ARRAY_SIZE(cxl_osc_support_bit));
> +}
> +
> +static void decode_cxl_osc_control(struct device *dev, char *msg, u32 word)
> +{
> +       decode_osc_bits(dev, msg, word, cxl_osc_control_bit,
> +                       ARRAY_SIZE(cxl_osc_control_bit));
> +}
> +
> +static acpi_status acpi_cap_run_osc(acpi_handle handle, const u32 *capbuf,
> +                                   u8 *uuid_str, u32 *retval)

A nit: This is only called twice, every time with the same UUID, so it
would be good to avoid passing the UUID to this function.

> +{
> +       struct acpi_osc_context context = {
> +               .uuid_str = uuid_str,
> +               .rev = 1,
> +               .cap.length = 20,
> +               .cap.pointer = (void *)capbuf,
> +       };
> +       acpi_status status;
> +
> +       status = acpi_run_osc(handle, &context);
> +       if (ACPI_SUCCESS(status)) {
> +               /* pointer + offset to DWORD 5 */
> +               *retval = *((u32 *)(context.ret.pointer + 16));
> +               kfree(context.ret.pointer);
> +       }
> +       return status;
> +}
> +

The rest of the patch looks OK to me.
