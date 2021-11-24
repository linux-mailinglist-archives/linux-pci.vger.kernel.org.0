Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16A2F45D02F
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 23:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232289AbhKXWpU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 17:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230265AbhKXWpU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 17:45:20 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3FE2C061574
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:42:09 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id h24so3662824pjq.2
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 14:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+1Q4ZlGTBOATTQOQ5br1/BXNrVoSlyGXFm1sTwcyv0U=;
        b=7+nerVzgcqxel+bXeYjFSJU+3pF4llyEQqlFiRz0Qvx4BJQ2O42+FrhOjxghVmPsyP
         TKHmlfnXTVHkhG/YqfV9QI6RaK4wbgb1jMfplXUJneNUzj/37BboiXEQnECYLR1m68RR
         /XacUZeOWjM5EuSCSjp5Mi6vME9kKh2/GG+rBH9zJWrFyJadbogJMNyvU51OvnAJ9evi
         fZ7hIZ12Jq1ooD04BKoOU16UvprvsmpN1b/c9nnXrNxzp00Me7dpD5uh7uXhTgQAIKWV
         PVZkyDxQVWYR+haC303hwJ8SJ4NQh20mc2CEGjgan1/QFDA+MThMXKKgPVxFnp2+XwzW
         Rcuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+1Q4ZlGTBOATTQOQ5br1/BXNrVoSlyGXFm1sTwcyv0U=;
        b=OcDVI9LgYXTZPqpTIvO+4Frj0bE0oFF3JWFhHD55xpHAarV2t0cHOrjwILOAOZNOtj
         VZ1WWyRlYp407rA5LTc5VwKFFDcKS3pT6ukVZMs83SZOm1Za/FSni673BTwLZ/Y1SHQ/
         EDEgX1wCOTt7Re9Q3LL8lHGOtuQucJKRiVA+fVfQRY5wbxzRmkKLox/CLiemZD/i+aIZ
         IcRbBJrApyxsxldRgdmiXZ3JHx0h+2T46KvmC4UBW6em6v9pC1+rg/Ssg+4rXHl5Wt2o
         s8mQI7KjwwG4pSE4Dv9f0+DXVqco11tl3x0B1rkD13l8E1JZhDDiNBryC2Cs8G2d4Whs
         90Qw==
X-Gm-Message-State: AOAM5339EbCjBwU1xNMOC+4idoe+NwWzaHiK+9wExXoy/V6Zou+XG+ao
        SPAMk9PrbYQbmq/vHZbDqphF2tiBKFcReRCZPSDu2Q==
X-Google-Smtp-Source: ABdhPJxE9W91V3eeKsJuJKXRLIxfPSh5eIk7JcMf91gbC2VJEJ+4woxlRUWD0vPepwePG8nqOb+XN0Jm5gz5sqDCJK4=
X-Received: by 2002:a17:90b:1e49:: with SMTP id pi9mr779516pjb.220.1637793729510;
 Wed, 24 Nov 2021 14:42:09 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-11-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-11-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 14:41:59 -0800
Message-ID: <CAPcyv4h3hjhG9Z8o5roUw2k9Dcxe5w1PKukOCONedU7gcH4C1Q@mail.gmail.com>
Subject: Re: [PATCH 10/23] cxl/core: Convert decoder range to resource
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
> CXL decoders manage address ranges in a hierarchical fashion whereby a
> leaf is a unique subregion of its parent decoder (midlevel or root). It
> therefore makes sense to use the resource API for handling this.
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
> Changes since RFCv2
> - Switch to DEFINE_RES_MEM from NAMED variant (Dan)
> - Differentiate CFMWS resources and other decoder resources (Ben)
> - Make decoder resources be range, nor resource (Dan)
> - Set decoder name in cxl_decoder_add() (Dan)
> ---
>  drivers/cxl/acpi.c     | 16 ++++++----------
>  drivers/cxl/core/bus.c | 19 +++++++++++++++++--
>  drivers/cxl/cxl.h      |  8 ++++++--
>  3 files changed, 29 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 7cfa8b568013..3415184a2e61 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -108,10 +108,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>
>         cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>         cxld->target_type = CXL_DECODER_EXPANDER;
> -       cxld->range = (struct range){
> -               .start = cfmws->base_hpa,
> -               .end = cfmws->base_hpa + cfmws->window_size - 1,
> -       };
> +       cxld->platform_res = (struct resource)DEFINE_RES_MEM(cfmws->base_hpa,
> +                                                            cfmws->window_size);
>         cxld->interleave_ways = CFMWS_INTERLEAVE_WAYS(cfmws);
>         cxld->interleave_granularity = CFMWS_INTERLEAVE_GRANULARITY(cfmws);
>
> @@ -127,8 +125,9 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>                 return 0;
>         }
>         dev_dbg(dev, "add: %s node: %d range %#llx-%#llx\n",
> -               dev_name(&cxld->dev), phys_to_target_node(cxld->range.start),
> -               cfmws->base_hpa, cfmws->base_hpa + cfmws->window_size - 1);
> +               dev_name(&cxld->dev),
> +               phys_to_target_node(cxld->platform_res.start), cfmws->base_hpa,
> +               cfmws->base_hpa + cfmws->window_size - 1);

Since you converted to resource you can us %pr:

        dev_dbg(dev, "add: %s node: %d range %pr\n", dev_name(&cxld->dev),
                phys_to_target_node(cxld->platform_res.start),
                &cxld->platform_res);


>
>         return 0;
>  }
> @@ -267,10 +266,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>         cxld->interleave_ways = 1;
>         cxld->interleave_granularity = PAGE_SIZE;
>         cxld->target_type = CXL_DECODER_EXPANDER;
> -       cxld->range = (struct range) {
> -               .start = 0,
> -               .end = -1,
> -       };
> +       cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
>
>         device_lock(&port->dev);
>         dport = list_first_entry(&port->dports, typeof(*dport), list);
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 17a4fff029f8..8e80e85350b1 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -46,8 +46,14 @@ static ssize_t start_show(struct device *dev, struct device_attribute *attr,
>                           char *buf)
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       u64 start = 0;

No need to init to zero.

>
> -       return sysfs_emit(buf, "%#llx\n", cxld->range.start);
> +       if (is_root_decoder(dev))
> +               start = cxld->platform_res.start;
> +       else
> +               start = cxld->decoder_range.start;
> +
> +       return sysfs_emit(buf, "%#llx\n", start);
>  }
>  static DEVICE_ATTR_RO(start);
>
> @@ -55,8 +61,14 @@ static ssize_t size_show(struct device *dev, struct device_attribute *attr,
>                         char *buf)
>  {
>         struct cxl_decoder *cxld = to_cxl_decoder(dev);
> +       u64 size = 0;

Same "no init" comment.

>
> -       return sysfs_emit(buf, "%#llx\n", range_len(&cxld->range));
> +       if (is_root_decoder(dev))
> +               size = resource_size(&cxld->platform_res);
> +       else
> +               size = range_len(&cxld->decoder_range);
> +
> +       return sysfs_emit(buf, "%#llx\n", size);
>  }
>  static DEVICE_ATTR_RO(size);
>
> @@ -548,6 +560,9 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>         if (rc)
>                 return rc;
>
> +       if (is_root_decoder(dev))
> +               cxld->platform_res.name = dev_name(dev);

Maybe a comment about why the resource wants the name of the decoder?
Just to help explain the motivation to separate this initialization
step from the rest of the resource init.


Other than that you can add:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
