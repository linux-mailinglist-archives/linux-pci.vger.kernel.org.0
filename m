Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC26945D09B
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 23:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345960AbhKXW63 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 17:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345381AbhKXW62 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 17:58:28 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7986BC061574
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:55:18 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id j5-20020a17090a318500b001a6c749e697so5099723pjb.1
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:55:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sEkXTr1CVlB4OvzJNloCs5luN2SOG/AE8/F/zeex2Q8=;
        b=Vh4LeKm6XE23WW2uQBz8rJeoRE5Lz3+Gl+1q/Er3IUj1MxuNT4zjPpngzSk84mYb+B
         KJf+RswKjhj5X4pevNp9HtWcuXJ2sF5qLKDmxT/a+x11yqzTY0Ds1vozSZ5E6LlaiaYK
         hs+WXsmMtL0fclpZogZ29AfesB1zkHPUezzwdDh206re0sbnpkrIkTEZ4u8USfYO9L48
         Qgig3/Jm9NchgBCK2beQIXxOCpegxifNuNg3C//jQcPZP3qduimzUstbjxTu6XezbTSp
         DK8wVmmY9h4LRjwGY6kF2zSFEVV+cf5xXNXTtAdL3Ml1L+5tKcisVpESHYa/YkYXH+PO
         I+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sEkXTr1CVlB4OvzJNloCs5luN2SOG/AE8/F/zeex2Q8=;
        b=0tqf0/zvFusXUlHUOYNmJDLur+Tue+VVCMmKp9RCTz3raiFgHtGcF9F7P6yQTFr+fk
         KBm8dNnDSM1B2/wBuQXCqAEVPk8H+9Fj/uU+2Zylrni3UV98vqDbTK9YGAkF1TR8vyGh
         nmtzQLdGMhouN6AgE7DXLWyPaKHTonel1UYq9Dtd2AFAQd5Ta+j+PM9wHqrd6ccXSMBL
         GXPvnqS7eG9Yu1O4ynfjUX75p+YrWloxcqKJF0X+vGe5ZW1BCZj3EJn21U8cz22nCU3q
         DdV7EhN/cuBVzizvJlzQfVROFY7HLe6nJeGpAUipShF1pBikv7+AO8er+gqb8zVmERKb
         cTZA==
X-Gm-Message-State: AOAM530JK2pQhzDx0D4sJrQa8mGDTsErs85fRwSAEsyxSQLGrPZedlqU
        fvMtVxo6G6AozcjcsVf1gXBMOMKyG9f6R00pguP7dPK67lI=
X-Google-Smtp-Source: ABdhPJxzAggYjDjVpJuE9CXjDLPIcFWy84MuHHNMSY9727LcP9eEGNmGHhtJPJlJsdXpkc9UB+ATvaMt0RMJKhjh1vo=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr834434pjb.93.1637794517965;
 Wed, 24 Nov 2021 14:55:17 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-12-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-12-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 14:55:07 -0800
Message-ID: <CAPcyv4gh+Q0e56do-AuKeu4WFWVhutFjX475=5rQKazT_kcxTw@mail.gmail.com>
Subject: Re: [PATCH 11/23] cxl/core: Document and tighten up decoder APIs
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
> Since the code to add decoders for switches and endpoints is on the
> horizon it helps to have properly documented APIs. In addition, the
> decoder APIs will never need to support a negative count for downstream
> targets as the spec explicitly starts numbering them at 1, ie. even 0 is
> an "invalid" value which can be used as a sentinel.

Looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
>
> This is respun from a previous incantation here:
> https://lore.kernel.org/linux-cxl/20210915155946.308339-1-ben.widawsky@intel.com/
> ---
>  drivers/cxl/core/bus.c | 33 +++++++++++++++++++++++++++++++--
>  drivers/cxl/cxl.h      |  3 ++-
>  2 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 8e80e85350b1..1ee12a60f3f4 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -495,7 +495,20 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>         return rc;
>  }
>
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
> +/**
> + * cxl_decoder_alloc - Allocate a new CXL decoder
> + * @port: owning port of this decoder
> + * @nr_targets: downstream targets accessible by this decoder. All upstream
> + *             ports and root ports must have at least 1 target.
> + *
> + * A port should contain one or more decoders. Each of those decoders enable
> + * some address space for CXL.mem utilization. A decoder is expected to be
> + * configured by the caller before registering.
> + *
> + * Return: A new cxl decoder to be registered by cxl_decoder_add()
> + */
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +                                     unsigned int nr_targets)
>  {
>         struct cxl_decoder *cxld, cxld_const_init = {
>                 .nr_targets = nr_targets,
> @@ -503,7 +516,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>         struct device *dev;
>         int rc = 0;
>
> -       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets < 1)
> +       if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
>                 return ERR_PTR(-EINVAL);
>
>         cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> @@ -535,6 +548,22 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
>
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * Certain types of decoders may not have any targets. The main example of this
> + * is an endpoint device. A more awkward example is a hostbridge whose root
> + * ports get hot added (technically possible, though unlikely).
> + *
> + * Context: Process context. Takes and releases the cxld's device lock.
> + *
> + * Return: Negative error code if the decoder wasn't properly configured; else
> + *        returns 0.
> + */
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  {
>         struct cxl_port *port;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index ad816fb5bdcc..b66ed8f241c6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -288,7 +288,8 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> -struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port, int nr_targets);
> +struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> +                                     unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
>
> --
> 2.34.0
>
