Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B94A939DC47
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 14:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhFGM2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 08:28:02 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:34813 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGM17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 08:27:59 -0400
Received: by mail-oi1-f175.google.com with SMTP id u11so17840384oiv.1;
        Mon, 07 Jun 2021 05:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wdDQeamXj3jujBs4RjQQaDnJ/RZcKu30A1Qy5s12Tes=;
        b=YQJDbPGFlNtR+JRpTN5RUEcb8D0XCtZGJp+MPHDbWkSPyptLVLUQh2bYFk/mkdAL95
         KKeFFaXcUp8pWQJlro+umXhq3baZiJGR46w7npkduEUT5xQKWRIslq5KcWVsZMg0pb3U
         U+w+F6SmSNc25TZVyuSGWJZ22c0DEUNr6C8hnaszHzX9BzbEDl/eFc9NcCvd6ltXUoao
         PFEBlXfOGzBomdSVBw58e8VNJL6Ue+pUNcCkX203TG5O3vAT06AWrF5pS+loV7dKYEKQ
         R19ZAWHqDLQMuVtjmDYPdx/L9TaTvVIpyVriAa+Z0D91dyQL/a8Q9FPHcSeX7qyrcx6J
         Y45g==
X-Gm-Message-State: AOAM530Z2/EQZD4WlArweD9qGQ8lGC6GFJ+6iYbf1EEP/WN7oDfR2suz
        4n/uTnVz5XoKLDGSdE3fc3j/tiEBtWpaCtuYWt0wz5dz
X-Google-Smtp-Source: ABdhPJwoaBZv7KKaH8+C73eOiaH8ws7ekLvWI90Xhn47MqQb7zpZZ0upw9cGxPZIHqB0eNeXnpyhm/FVK0jWh5NMs+M=
X-Received: by 2002:aca:b406:: with SMTP id d6mr11140293oif.71.1623068759929;
 Mon, 07 Jun 2021 05:25:59 -0700 (PDT)
MIME-Version: 1.0
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
 <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 7 Jun 2021 14:25:48 +0200
Message-ID: <CAJZ5v0jhh8EXNY9C1_HpD7tdW9s5uNkKdyLOEDAgeK4yHpFXdA@mail.gmail.com>
Subject: Re: [PATCH v5 1/6] cxl/acpi: Local definition of ACPICA infrastructure
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 6, 2021 at 8:05 AM Dan Williams <dan.j.williams@intel.com> wrote:
>
> The recently released CXL specification change (ECN) for the CXL Fixed
> Memory Window Structure (CFMWS) extension to the CXL Early Discovery
> Table (CEDT) enables a large amount of functionality. It defines the
> root of a CXL memory topology and is needed for all OS flows for CXL
> provisioning CXL memory expanders. For ease of merging and tree
> management add the new ACPI definition locally (drivers/cxl/acpi.h) in
> such a way that they will not collide with the eventual arrival of the
> definitions through the ACPICA project to their final location
> (drivers/acpi/actbl1.h).

I've just applied the ACPICA series including this change which can be
made available as a forward-only branch in my tree, if that helps.

> The definitions in drivers/cxl/acpi.h can be dropped post -rc1.
>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Co-developed-by: Alison Schofield <alison.schofield@intel.com>
> Co-developed-by: Erik Kaneda <erik.kaneda@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>  create mode 100644 drivers/cxl/acpi.h
>
> diff --git a/drivers/cxl/acpi.h b/drivers/cxl/acpi.h
> new file mode 100644
> index 000000000000..1482c19e7227
> --- /dev/null
> +++ b/drivers/cxl/acpi.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2021 Intel Corporation. */
> +#ifndef __CXL_ACPI_H__
> +#define __CXL_ACPI_H__
> +
> +#ifndef ACPI_CEDT_CHBS_VERSION_CXL20
> +/*
> + * NOTE: These definitions are temporary and to be deleted in v5.14-rc1
> + * when the identical definitions become available from
> + * include/acpi/actbl1.h.
> + */
> +
> +#define ACPI_CEDT_TYPE_CFMWS 1
> +#define ACPI_CEDT_TYPE_RESERVED 2
> +
> +#define ACPI_CEDT_CHBS_VERSION_CXL11 (0)
> +#define ACPI_CEDT_CHBS_VERSION_CXL20 (1)
> +
> +#define ACPI_CEDT_CHBS_LENGTH_CXL11 (0x2000)
> +#define ACPI_CEDT_CHBS_LENGTH_CXL20 (0x10000)
> +
> +struct acpi_cedt_cfmws {
> +       struct acpi_cedt_header header;
> +       u32 reserved1;
> +       u64 base_hpa;
> +       u64 window_size;
> +       u8 interleave_ways;
> +       u8 interleave_arithmetic;
> +       u16 reserved2;
> +       u32 granularity;
> +       u16 restrictions;
> +       u16 qtg_id;
> +       u32 interleave_targets[];
> +};
> +
> +/* Values for Interleave Arithmetic field above */
> +
> +#define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO (0)
> +
> +/* Values for Restrictions field above */
> +
> +#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2 (1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3 (1 << 1)
> +#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE (1 << 2)
> +#define ACPI_CEDT_CFMWS_RESTRICT_PMEM (1 << 3)
> +#define ACPI_CEDT_CFMWS_RESTRICT_FIXED (1 << 4)
> +#endif /* ACPI_CEDT_CHBS_VERSION_CXL20 */
> +#endif /* __CXL_ACPI_H__ */
>
