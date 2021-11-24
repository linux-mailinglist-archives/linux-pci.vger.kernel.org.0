Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 929E145B318
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 05:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhKXE2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 23:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbhKXE2N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 23:28:13 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D52FAC061574
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 20:25:04 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id gf14-20020a17090ac7ce00b001a7a2a0b5c3so3942786pjb.5
        for <linux-pci@vger.kernel.org>; Tue, 23 Nov 2021 20:25:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oUA8Wsclak+U+BKo3anA7eUCDjIS6oFdpVtQGpRCFOw=;
        b=Boj1VBOAoN9kzZAZggZT2qqsLCwoHTUSIrTtO9E47OyCabXtVKvBGH3lpH2Fbs/AYD
         IpRrkoPVZUQ2lHP7YQAu19D9o4PNJ1NcvWouLbdYNDCtLbjqQF6vRQSlGTJJmvtnTUtD
         M6NJUq9pDtgFcxM4MONehpImP4GQpA+jVcluBtRub+MMRezR5SelfFqHwc6+vbUSk50K
         KOGqeTr1bRlshAkyN2ijV5tzxU47aOokhsHCQKMhuXd31rUTzJFG3rQx+selsAAYRW80
         TFmzHc2Iqp/V9LIq6LxOfvIwv3lFPRxkS0gULHDL+vBC5Q1BlT4ksQKGTWZKkvHD7bWb
         WCrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oUA8Wsclak+U+BKo3anA7eUCDjIS6oFdpVtQGpRCFOw=;
        b=J1oYvfLwSrdhYhI3d9N6eM1twuXnquIp4K/SOH9M2Rx79pKKMbMG2UJY87rYQ30tTN
         5eBj4jAtv77EHoJ4MRkjZ8hCO1CE4y7XgFJqe9fQ89S/BhgtUBhynAlP3uHiITJvOTML
         bb+sZywIS3GL4u2EyPs1rsWg53e+YthixneOZ59uk/HBqc79S4ciNa6LMSXHSICSvu2d
         N/ttAz1fYe8QsgrNnBCV1AxDyV4VI6LsegOuqTY4Pk8+YjcltLuEBfC9gC0gy1q4RqzP
         yvP1W3pGdAPFaDSUsdxZp9+6TEEtGxKNqXUdOofKCz/YlGUbasHOOffLCLR1s5IUNw1t
         mHGg==
X-Gm-Message-State: AOAM532IApgIfOeABz6HI3cltZJBEQ1iI5S6ttFOA3uZP90TIOSQ7hGj
        GZeq0cfhWshNk23OJhzukk382XotxH66wqkhSBNP2w==
X-Google-Smtp-Source: ABdhPJzpod0HbuRzNgrM0gKCWf1c79NOrrpLPRpScdRVG7dCWXSm2s0mOdXoY9kP1veMv8LIgDmBK4MgsiJaKkUPeWY=
X-Received: by 2002:a17:902:7fcd:b0:142:8ab3:ec0e with SMTP id
 t13-20020a1709027fcd00b001428ab3ec0emr14254924plb.4.1637727904365; Tue, 23
 Nov 2021 20:25:04 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-3-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-3-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 23 Nov 2021 20:24:53 -0800
Message-ID: <CAPcyv4gcK_UCSjKq4LUz=AgrNsWPp+peOyzRo2NHa4Be=yCtUQ@mail.gmail.com>
Subject: Re: [PATCH 02/23] cxl: Flesh out register names
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
> Get a better naming scheme in place for upcoming additions.

I prefer that subject lines and changelog have at least one concrete
detail. Writing that out would identify that "rename REGLOC to
REG_LOCATOR", is separate from "drop the unused PCI_DVSEC_ID_CXL
definition", is different from "drop redundant prefixes of 'PCI' and
'DVSEC' from defines".

With some concrete details added to the changelog you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>


>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> Changes since RFCv2:
> Use some abbreviations (Jonathan)
> Prefix everything with CXL (Jonathan)
> Remove new additions (Dan)
>
> Original discussion motivating this occurred here:
> https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
> ---
>  drivers/cxl/pci.c | 14 +++++++-------
>  drivers/cxl/pci.h | 19 ++++++++++---------
>  2 files changed, 17 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8dc91fd3396a..a6ea9811a05b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -403,10 +403,10 @@ static int cxl_map_regs(struct cxl_dev_state *cxlds, struct cxl_register_map *ma
>  static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>                                 struct cxl_register_map *map)
>  {
> -       map->block_offset =
> -               ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> -       map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> -       map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +       map->block_offset = ((u64)reg_hi << 32) |
> +                           (reg_lo & CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK);
> +       map->barno = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BIR_MASK, reg_lo);
> +       map->reg_type = FIELD_GET(CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK, reg_lo);
>  }
>
>  /**
> @@ -427,15 +427,15 @@ static int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>         int regloc, i;
>
>         regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -                                          PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +                                          CXL_DVSEC_REG_LOCATOR);
>         if (!regloc)
>                 return -ENXIO;
>
>         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>
> -       regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> -       regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> +       regloc += CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET;
> +       regblocks = (regloc_size - CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET) / 8;
>
>         for (i = 0; i < regblocks; i++, regloc += 8) {
>                 u32 reg_lo, reg_hi;
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 7d3e4bf06b45..29b8eaef3a0a 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -7,17 +7,21 @@
>
>  /*
>   * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification
> + * Specification. Names are taken straight from the specification with "CXL" and
> + * "DVSEC" redundancies removed. When obvious, abbreviations may be used.
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK  GENMASK(31, 20)
>  #define PCI_DVSEC_VENDOR_ID_CXL                0x1E98
> -#define PCI_DVSEC_ID_CXL               0x0
>
> -#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID       0x8
> -#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET  0xC
> +/* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE                                  0
>
> -/* BAR Indicator Register (BIR) */
> -#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> +/* CXL 2.0 8.1.9: Register Locator DVSEC */
> +#define CXL_DVSEC_REG_LOCATOR                                  8
> +#define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET                  0xC
> +#define     CXL_DVSEC_REG_LOCATOR_BIR_MASK                     GENMASK(2, 0)
> +#define            CXL_DVSEC_REG_LOCATOR_BLOCK_ID_MASK                 GENMASK(15, 8)
> +#define     CXL_DVSEC_REG_LOCATOR_BLOCK_OFF_LOW_MASK           GENMASK(31, 16)
>
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
> @@ -28,7 +32,4 @@ enum cxl_regloc_type {
>         CXL_REGLOC_RBI_TYPES
>  };
>
> -#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> -#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> -
>  #endif /* __CXL_PCI_H__ */
> --
> 2.34.0
>
