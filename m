Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B09034BC2F6
	for <lists+linux-pci@lfdr.de>; Sat, 19 Feb 2022 00:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiBRXnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Feb 2022 18:43:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239400AbiBRXnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Feb 2022 18:43:19 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32422BDC3
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 15:43:01 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id p23so9156103pgj.2
        for <linux-pci@vger.kernel.org>; Fri, 18 Feb 2022 15:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whNrfqumba6KC2p9V6Pih5sz382GhTFok83j4GryLwE=;
        b=CUnXvna/nzoToDBNZHEzzpgX9e9lvq6R5InCaM/8HF+c7M9qkefrBPgyeiu5SgKjwk
         jEZEUbXNb6amnFGNQzFKtKgy4IJ10aeKpa8wfzSW2C6y+Vd/+2SiGAjXMB3g2sFwqHSo
         Za+If67L34iRq0VJSFjud16DUVXwrH4EtEpl8mWvfxEbPF3dHM64vQ+DAqaPBwVjZJ8R
         Keeq+HV319aTYJohVMKRB7mh+p5elAQIdI1oNh2ZqwV8wtajiKftYdDj/AttAHquQqDu
         N5vpefmxuZHO6pcjQRG5aDIGXR/EqqNOUTLUKQCTC3vCo6VPyV7pW49Omlz2eqRGqdGO
         iyhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whNrfqumba6KC2p9V6Pih5sz382GhTFok83j4GryLwE=;
        b=wylU+/XnAJrXizZfyVfvsclTD+G0EDFEvv4ps2ytXDhz5bowSt5VAnUlzc3BGc+5e7
         Q1tcKGsYnZivMVvsh3dpiGwazPxUIhWuoNRzmIWs4IJBBi0GBMKAX0yWlrB5f4fXVpXj
         89DB1G2ratQxnK4DQqnxqpWcwYhczFtcTZRpd73WZ2FtcIlBEH/AR2amOYpJ8u1JyYdd
         vUNdR5apUThdZ7MWO5BD43dD8T/gxx3T8KolWLf8QxhneVoIWvFZD/o7FEBWR3UUWQvL
         t42wp6nRVaQThae+NXwUZOBI6ws/X5KCww8KQNqPcz0m9tEKgsmmfyMMP0pTGGBPzvvf
         XWsA==
X-Gm-Message-State: AOAM533YuHSBFyb9VZxeZQM+Y8hk99+7xeEiu+6haELxDdqoLvtv0go4
        LXv5fF9n+yXs+acPSKeH8VUQ8V4/K2lzxHB5Yan0Lg==
X-Google-Smtp-Source: ABdhPJzZmMN0+mLLFV6zFhJAgugkrkGZAZ9hJGF12JTGW372UotC0sF+5W85WXQp3DLcCjcKKLEsii9H7AGCDkc/R9o=
X-Received: by 2002:a62:ab09:0:b0:4e0:d967:318f with SMTP id
 p9-20020a62ab09000000b004e0d967318fmr10148714pff.86.1645227781372; Fri, 18
 Feb 2022 15:43:01 -0800 (PST)
MIME-Version: 1.0
References: <20220128002707.391076-1-ben.widawsky@intel.com> <20220128002707.391076-11-ben.widawsky@intel.com>
In-Reply-To: <20220128002707.391076-11-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Fri, 18 Feb 2022 15:42:50 -0800
Message-ID: <CAPcyv4hF=DWWszAhrOTiBLFxm5s8gcJ_TcdVz9UNfYEuXNiJTw@mail.gmail.com>
Subject: Re: [PATCH v3 10/14] cxl/region: Collect host bridge decoders
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, patches@lists.linux.dev,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 27, 2022 at 4:27 PM Ben Widawsky <ben.widawsky@intel.com> wrote:
>
> Part of host bridge verification in the CXL Type 3 Memory Device
> Software Guide calculates the host bridge interleave target list (6th
> step in the flow chart), ie. verification and state update are done in
> the same step. Host bridge verification is already in place, so go ahead
> and store the decoders with their target lists.
>
> Switches are implemented in a separate patch.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/region.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 145d7bb02714..b8982be13bfe 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -428,6 +428,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>                 return simple_config(cxlr, hbs[0]);
>
>         for (i = 0; i < hb_count; i++) {
> +               struct cxl_decoder *cxld;
>                 int idx, position_mask;
>                 struct cxl_dport *rp;
>                 struct cxl_port *hb;
> @@ -486,6 +487,18 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>                                                 "One or more devices are not connected to the correct Host Bridge Root Port\n");
>                                         goto err;
>                                 }
> +
> +                               if (!state_update)
> +                                       continue;
> +
> +                               if (dev_WARN_ONCE(&cxld->dev,
> +                                                 port_grouping >= cxld->nr_targets,
> +                                                 "Invalid port grouping %d/%d\n",
> +                                                 port_grouping, cxld->nr_targets))
> +                                       goto err;
> +
> +                               cxld->interleave_ways++;
> +                               cxld->target[port_grouping] = get_rp(ep);

There is not enough context in the changelog to understand what this
code is doing, but I do want to react to all this caching of objects
without references. I'd prefer helpers that walk the device that are
already synced with device_del() events than worry about these caches
and when to invalidate their references.

>                         }
>                 }
>         }
> @@ -538,7 +551,7 @@ static bool rootd_valid(const struct cxl_region *cxlr,
>
>  struct rootd_context {
>         const struct cxl_region *cxlr;
> -       struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> +       const struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
>         int count;
>  };
>
> @@ -564,7 +577,7 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *cxlr,
>         struct rootd_context ctx;
>         struct device *ret;
>
> -       ctx.cxlr = cxlr;
> +       ctx.cxlr = (struct cxl_region *)cxlr;

If const requires casting then don't use const.

>
>         ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
>         if (ret)
> --
> 2.35.0
>
