Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 631D2413E18
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbhIUXlL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 19:41:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbhIUXlK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 19:41:10 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E9C061574
        for <linux-pci@vger.kernel.org>; Tue, 21 Sep 2021 16:39:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id k23so774797pji.0
        for <linux-pci@vger.kernel.org>; Tue, 21 Sep 2021 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JL2bpCjLqUpgKJA8Tzj2daf3JAJbG6UZxkshNhMjfEo=;
        b=ik+hMU4pkpHc98C/RoFerDGUXryCYhOE2lDEJTzwtRX/jJa+a1fnDxcAOt09xiNdCI
         T2EiEBq9+J8uL4xKcv9dna+QOognhz6g8IGeVGhMheSaLKbFmitNAiVfUQTuDAtCmEg0
         II2SPHcpTslX2qRLrlKKISOjtEbuqyCaGMRICWHlIx+VlSsDtDgqrBeIUWgo6CtzX1aa
         OM7f1RPVAzG8DT67c/3Mgffr3RtAeXJoCc/USu3gjDlfDEoGtJqFbKJF3leE5+rbulfn
         Gl/JdV3W6p/lEjmz/SH0jhqjcjemZHNDRO0JBJl6HbzbPFacsiWmZGfUtgBt8IdUncOn
         BEmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JL2bpCjLqUpgKJA8Tzj2daf3JAJbG6UZxkshNhMjfEo=;
        b=GEGmtQR33/16Zn7xw0uDdHMFr+ozdY5GtjwBSu4DVGTfVQazJOLgZkRIjz8WD/JjUZ
         XNHo3LmQRPwBcgE7O4HEuGtMaegas3idH+pHXgOhMvAZD81pApnKoM9jenexMJOFCSKd
         l6o+tdmK5CuOoKrd25El+spbPBr2hGjm/haCSfjqK1OxnlDmoi68ceP6obrAf52TZoMi
         4tPEZhYMFgMWIUKhqVhTWQOz+vE6Vc97yKgPvve1LBftcWeg89nN6VsWZS461YEne3TL
         voa/2uBLml6hA/t9pRs5JeWGRZnJcQ5zEB2lFDVc8qerfmZYz3TQdyqynBOGG1Dx0Mzw
         nCnQ==
X-Gm-Message-State: AOAM533wXPyF889oOILsc4+CTging5F7iOdAqmfZ9ocwiVV9jussyfeN
        hM/m8eSYFtF9ejufspiHg8BzAbpGl+yWtu16CvZS9A==
X-Google-Smtp-Source: ABdhPJyygFZSjZ27gZF9fXTmves6igJFNXGS6ss2KHX68wT9tKlcv2ygmeNytnvYOFlcXlt+4C0e8+g3vW9XX0R/2KA=
X-Received: by 2002:a17:90a:f18f:: with SMTP id bv15mr7858242pjb.93.1632267581029;
 Tue, 21 Sep 2021 16:39:41 -0700 (PDT)
MIME-Version: 1.0
References: <20210921220459.2437386-1-ben.widawsky@intel.com> <20210921220459.2437386-4-ben.widawsky@intel.com>
In-Reply-To: <20210921220459.2437386-4-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 16:39:30 -0700
Message-ID: <CAPcyv4hK6=mxqwEZEyKH1LHBWaQKUaEoOxoAgZvL5aQ-dOswRg@mail.gmail.com>
Subject: Re: [PATCH 3/7] cxl/pci: Refactor cxl_pci_setup_regs
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

On Tue, Sep 21, 2021 at 3:05 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> In preparation for moving parts of register mapping to cxl_core, the
> cxl_pci driver is refactored to utilize a new helper to find register
> blocks by type.
>
> cxl_pci scanned through all register blocks and mapping the ones that
> the driver will use. This logic is inverted so that the driver
> specifically requests the register blocks from a new helper. Under the
> hood, the same implementation of scanning through all register locator
> DVSEC entries exists.
>
> There are 2 behavioral changes (#2 is arguable):
> 1. A dev_err is introduced if cxl_map_regs fails.
> 2. The previous logic would try to map component registers and device
>    registers multiple times if there were present and keep the mapping
>    of the last one found (furthest offset in the register locator).
>    While this is disallowed in the spec, CXL 2.0 8.1.9: "Each register
>    block identifier shall only occur once in the Register Locator DVSEC
>    structure" it was how the driver would respond to the spec violation.
>    The new logic will take the first found register block by type and
>    move on.

Yeah, I think it's silly to try to predict how hardware might violate
the specification. Just wait until there is a known shipping device
with a problem and then add a quirk to the driver.

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/pci.c | 113 ++++++++++++++++++++++++++--------------------
>  1 file changed, 65 insertions(+), 48 deletions(-)
>
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index ccc7c2573ddc..6e5c026f5262 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -428,46 +428,28 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
>         *reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
>  }
>
> -/**
> - * cxl_pci_setup_regs() - Setup necessary MMIO.
> - * @cxlm: The CXL memory device to communicate with.
> - *
> - * Return: 0 if all necessary registers mapped.
> - *
> - * A memory device is required by spec to implement a certain set of MMIO
> - * regions. The purpose of this function is to enumerate and map those
> - * registers.
> - */
> -static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
> +static int find_register_block(struct pci_dev *pdev, enum cxl_regloc_type type,
> +                              struct cxl_register_map *map)
>  {
> -       void __iomem *base;
> +       int regloc, i, rc = -ENODEV;
>         u32 regloc_size, regblocks;
> -       int regloc, i, n_maps, ret = 0;
> -       struct device *dev = cxlm->dev;
> -       struct pci_dev *pdev = to_pci_dev(dev);
> -       struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
> +
> +       memset(map, 0, sizeof(*map));

Is this necessary? It seems this fills in all fields on success, why
does it need to zero-init?

>
>         regloc = cxl_pci_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> -       if (!regloc) {
> -               dev_err(dev, "register location dvsec not found\n");
> +       if (!regloc)
>                 return -ENXIO;
> -       }
> -
> -       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> -               return -ENODEV;
>
> -       /* Get the size of the Register Locator DVSEC */
>         pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>         regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>
>         regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
>         regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
>
> -       for (i = 0, n_maps = 0; i < regblocks; i++, regloc += 8) {
> +       for (i = 0; i < regblocks; i++, regloc += 8) {
>                 u32 reg_lo, reg_hi;
> -               u8 reg_type;
> +               u8 reg_type, bar;
>                 u64 offset;
> -               u8 bar;
>
>                 pci_read_config_dword(pdev, regloc, &reg_lo);
>                 pci_read_config_dword(pdev, regloc + 4, &reg_hi);
> @@ -475,39 +457,74 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
>                 cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
>                                           &reg_type);
>
> -               /* Ignore unknown register block types */
> -               if (reg_type > CXL_REGLOC_RBI_MEMDEV)
> -                       continue;
> +               if (reg_type == type) {
> +                       map->barno = bar;
> +                       map->block_offset = offset;
> +                       map->reg_type = reg_type;
> +                       rc = 0;
> +                       break;

As this patch is already adding helpers, perhaps rather than a loop
break, make the loop a helper so it can just "return 0;" directly:

Something like:

pci_request_mem_regions(...);
rc = __find_register_block(...);
pci_release_mem_regions(...);

...although, now that I see it written that way I think the request +
release regions should probably just be dropped. It's not like any of
the register enumeration would collide with someone else who already
has the registers mapped. The collision only comes when the registers
are mapped for their final usage, and that will have more precision in
the request.

> +               }
> +       }
>
> -               base = cxl_pci_map_regblock(cxlm, bar, offset);
> -               if (!base)
> -                       return -ENOMEM;
> +       pci_release_mem_regions(pdev);
>
> -               map = &maps[n_maps];
> -               map->barno = bar;
> -               map->block_offset = offset;
> -               map->reg_type = reg_type;
> +       return rc;
> +}
>
> -               ret = cxl_probe_regs(cxlm, base + offset, map);
> +/**
> + * cxl_pci_setup_regs() - Setup necessary MMIO.
> + * @cxlm: The CXL memory device to communicate with.
> + *
> + * Return: 0 if all necessary registers mapped.
> + *
> + * A memory device is required by spec to implement a certain set of MMIO
> + * regions. The purpose of this function is to enumerate and map those
> + * registers.
> + */
> +static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
> +{
> +       int rc, i;
> +       struct device *dev = cxlm->dev;
> +       struct pci_dev *pdev = to_pci_dev(dev);
> +       const enum cxl_regloc_type types[] = { CXL_REGLOC_RBI_MEMDEV,
> +                                              CXL_REGLOC_RBI_COMPONENT };
>
> -               /* Always unmap the regblock regardless of probe success */
> -               cxl_pci_unmap_regblock(cxlm, base);
> +       if (pci_request_mem_regions(pdev, pci_name(pdev)))
> +               return -ENODEV;
>
> -               if (ret)
> -                       return ret;
> +       for (i = 0; i < ARRAY_SIZE(types); i++) {
> +               struct cxl_register_map map;
> +               void __iomem *base;
>
> -               n_maps++;
> -       }
> +               rc = find_register_block(pdev, types[i], &map);
> +               if (rc) {
> +                       dev_err(dev, "Couldn't find %s register block\n",
> +                               types[i] == CXL_REGLOC_RBI_MEMDEV ?
> +                                             "device" :
> +                                             "component");
> +                       break;
> +               }
>
> -       pci_release_mem_regions(pdev);
> +               base = cxl_pci_map_regblock(cxlm, map.barno, map.block_offset);
> +               if (!base) {
> +                       rc = -ENOMEM;
> +                       break;
> +               }
>
> -       for (i = 0; i < n_maps; i++) {
> -               ret = cxl_map_regs(cxlm, &maps[i]);
> -               if (ret)
> +               rc = cxl_probe_regs(cxlm, base + map.block_offset, &map);

It strikes me as odd @map has everything except a copy of @base. I
wonder if this patch becomes easier to read if patch4 comes before
this one and all the map_offset usage is dropped because @map can
carry the required information directly. I'm not sure this suggestion
is a win. I'm struggling to make sense of diff in isolation so will
need to circle back when I can apply this and look at the result, for
now it's just these edge comments.
