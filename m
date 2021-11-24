Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0975445CFF6
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 23:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245598AbhKXWVu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 17:21:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243516AbhKXWVt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 17:21:49 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505A3C06173E
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:18:38 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id y14-20020a17090a2b4e00b001a5824f4918so6152809pjc.4
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:18:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t136RXUUjljW+zq+0uABWBZU7E88tMGuF++JYX1S51w=;
        b=RsBMDNpQ094UksOy23GRpmiXc2C9+Ne9lh98ax8D8VVELglTix32+b9fzA5X0uRWrU
         NCIJ+eQ2C5GI4r+10ghhCEnbQ4mR7kPlQPPZLtMnfBC6AuclcDxklfCkJVfFtbieB+Dk
         S3QuNYG0r5BQLa4eqOrYJMcIBsE4RIyGL360Vtr00sprQmKtIuxa/J7JIqqs+K0Sd0Wq
         oeecZY4NikmNaKr9sSfCTmPX533FmOmtUTzCvI9N5oTfq/6M5Pm/Vm5aivVqKlou33E0
         1PPl+8IDBMyDDACKRFAO92VrR8OmMyU9R832mAihE18S3aGRjQF2DQaBEQOe0fOLgtN2
         Hyaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t136RXUUjljW+zq+0uABWBZU7E88tMGuF++JYX1S51w=;
        b=YFOedNowIP2ufOU0ui6ifm33AWV+Dm0cLKi3BtvXNbTNyT2aScq0jvRNpa+zYwOUPv
         ftZCE9SH9ga8yy8jqs5ftqWiTIcWxY8pkJITqOteQafSimzSCk+K7OTy8ZOnP2qvmTch
         9WEc/jA1zcJ4u4clPf3jXQgRgiwTUznjPgHWEw2dT0H+btR7ySJK4tE+w/DM5qaUx5Kw
         xRHhlDi/EnQ3DyU3p7yD/ds1A3E+TkJqJeank0Mn0UTZLsQmQh1gR0eDoNz+aa8Sdklg
         NJwyCTkoj88d1Hjq+CAlT+QgWvkrgCwcBdyE6RmrJrWxqP+FK+YRapeAwDJy9iVzuBtd
         oPFg==
X-Gm-Message-State: AOAM531biVolitoNWPg/SkVqaOK9sd3XLjPbJOpdIU8Fo/U4WJEeGsAc
        QXJMtV62YSc00TWEf5ldqxClCtusNxsE4Hp1BuEl4w==
X-Google-Smtp-Source: ABdhPJwzZ+etC3NasPHDxICacataNUohNOput2FltlBEMwd2pZ5AxT9KapbtXD7bbmb8I/niJVyJiPfXACUugzFcJ8s=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr23105992plb.4.1637792317776; Wed, 24
 Nov 2021 14:18:37 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-9-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-9-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 14:18:27 -0800
Message-ID: <CAPcyv4j2r-B9MM9F_Qsmwt2ezC_uytHYQPUGk7v2_6+4ySGkZg@mail.gmail.com>
Subject: Re: [PATCH 08/23] cxl/acpi: Map component registers for Root Ports
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Nov 19, 2021 at 4:03 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> This implements the TODO in cxl_acpi for mapping component registers.
> cxl_acpi becomes the second consumer of CXL register block enumeration
> (cxl_pci being the first). Moving the functionality to cxl_core allows
> both of these drivers to use the functionality. Equally importantly it
> allows cxl_core to use the functionality in the future.
>
> CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
> distinction being they're a part of the CXL 2.0 host bridge. While
> mapping their component registers is not immediately useful for the CXL
> drivers, the movement of register block enumeration into core is a vital
> step towards HDM decoder programming.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since RFCv2:
> - Squash commits together (Dan)
> - Reword commit message to account for above.
> ---
>  drivers/cxl/acpi.c      | 10 ++++++--
>  drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  4 +++
>  drivers/cxl/pci.c       | 52 ---------------------------------------
>  drivers/cxl/pci.h       |  4 +++
>  5 files changed, 70 insertions(+), 54 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3163167ecc3a..7cfa8b568013 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "pci.h"
>
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  #define CFMWS_INTERLEAVE_WAYS(x)       (1 << (x)->interleave_ways)
> @@ -134,11 +135,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>
>  __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>  {
> +       resource_size_t creg = CXL_RESOURCE_NONE;
>         struct cxl_walk_context *ctx = data;
>         struct pci_bus *root_bus = ctx->root;
>         struct cxl_port *port = ctx->port;
>         int type = pci_pcie_type(pdev);
>         struct device *dev = ctx->dev;
> +       struct cxl_register_map map;
>         u32 lnkcap, port_num;
>         int rc;
>
> @@ -152,9 +155,12 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>                                   &lnkcap) != PCIBIOS_SUCCESSFUL)
>                 return 0;
>
> -       /* TODO walk DVSEC to find component register base */
> +       rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +       if (!rc)
> +               creg = cxl_reg_block(pdev, &map);

A couple comments: the difference between cxl_find_regblock() and
cxl_reg_block() is not obvious from the names. Setting aside why one
is regblock and the other is reg_block I would expect a name like
cxl_regmap_to_base() is easier to read.

It occurs to me that if cxl_find_regblock() failures are optional it
would be nice if cxl_regmap_to_base() returns CXL_RESOURCE_NONE if the
map is not populated. Then this can unconditionally call
cxl_regmap_to_base().

> +
>         port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -       rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> +       rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
>         if (rc) {
>                 ctx->error = rc;
>                 return rc;
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index e37e23bf4355..41a0245867ea 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -5,6 +5,7 @@
>  #include <linux/slab.h>
>  #include <linux/pci.h>
>  #include <cxlmem.h>
> +#include <pci.h>
>
>  /**
>   * DOC: cxl registers
> @@ -247,3 +248,56 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>         return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
> +
> +static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> +                               struct cxl_register_map *map)
> +{
> +       map->block_offset = ((u64)reg_hi << 32) |
> +                           (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +       map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +       map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> +}
> +
> +/**
> + * cxl_find_regblock() - Locate register blocks by type
> + * @pdev: The CXL PCI device to enumerate.
> + * @type: Register Block Indicator id
> + * @map: Enumeration output, clobbered on error
> + *
> + * Return: 0 if register block enumerated, negative error code otherwise
> + *
> + * A CXL DVSEC may additional point one or more register blocks, search
> + * for them by @type.
> + */
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                     struct cxl_register_map *map)
> +{
> +       u32 regloc_size, regblocks;
> +       int regloc, i;
> +
> +       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> +                                          CXL_DVSEC_REG_LOCATOR);
> +       if (!regloc)
> +               return -ENXIO;
> +
> +       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> +       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> +
> +       regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> +       regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> +
> +       for (i = 0; i < regblocks; i++, regloc += 8) {
> +               u32 reg_lo, reg_hi;
> +
> +               pci_read_config_dword(pdev, regloc, &reg_lo);
> +               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> +
> +               cxl_decode_regblock(reg_lo, reg_hi, map);
> +
> +               if (map->reg_type == type)
> +                       return 0;
> +       }
> +
> +       return -ENODEV;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_regblock, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ab4596f0b751..7150a9694f66 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -145,6 +145,10 @@ int cxl_map_device_regs(struct pci_dev *pdev,
>                         struct cxl_device_regs *regs,
>                         struct cxl_register_map *map);
>
> +enum cxl_regloc_type;
> +int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                     struct cxl_register_map *map);
> +
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 711bf4514480..d2c743a31b0c 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -433,58 +433,6 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
>         return 0;
>  }
>
> -static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
> -                               struct cxl_register_map *map)
> -{
> -       map->block_offset = ((u64)reg_hi << 32) |
> -                           (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> -       map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> -       map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
> -}
> -
> -/**
> - * cxl_find_regblock() - Locate register blocks by type
> - * @pdev: The CXL PCI device to enumerate.
> - * @type: Register Block Indicator id
> - * @map: Enumeration output, clobbered on error
> - *
> - * Return: 0 if register block enumerated, negative error code otherwise
> - *
> - * A CXL DVSEC may point to one or more register blocks, search for them
> - * by @type.
> - */
> -static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> -                            struct cxl_register_map *map)
> -{
> -       u32 regloc_size, regblocks;
> -       int regloc, i;
> -
> -       regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -                                          CXL_DVSEC_REG_LOCATOR);
> -       if (!regloc)
> -               return -ENXIO;
> -
> -       pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
> -       regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
> -
> -       regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> -       regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
> -
> -       for (i = 0; i < regblocks; i++, regloc += 8) {
> -               u32 reg_lo, reg_hi;
> -
> -               pci_read_config_dword(pdev, regloc, &reg_lo);
> -               pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> -
> -               cxl_decode_regblock(reg_lo, reg_hi, map);
> -
> -               if (map->reg_type == type)
> -                       return 0;
> -       }
> -
> -       return -ENODEV;
> -}
> -
>  static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
>                           struct cxl_register_map *map)
>  {
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 8ae2b4adc59d..a4b506bb37d1 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -47,4 +47,8 @@ enum cxl_regloc_type {
>         CXL_REGLOC_RBI_TYPES
>  };
>
> +#define cxl_reg_block(pdev, map)                                               \
> +       ((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \
> +                          (map)->block_offset))
> +

I see no reason for this to be macro. It's also a bug timebomb if
someone in the future does something like:

    cxl_reg_block(pdev, map++);

...because the macro references its arguments more than once.
