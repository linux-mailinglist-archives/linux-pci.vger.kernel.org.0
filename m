Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E84C545D26C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Nov 2021 02:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347340AbhKYB3t (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 20:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbhKYB1t (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 20:27:49 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 145E4C08ECBD
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 16:34:20 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id m24so3196409pls.10
        for <linux-pci@vger.kernel.org>; Wed, 24 Nov 2021 16:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=u4KIN2dv3zujSKlFX2maO2xnyNaGGDuJrxaXEWwcRpQ=;
        b=vC2csGsqUGxpMVK1Wrd1CpFBkezStgqStPUWia/9biTRwxrW4G8n4JJEQDizEKJOcv
         fSCgNVr1cO2vHRirG8kUOoW3PbuB7xneC+5/oJXcBCQl9wwNTa+OCqF6gdjdUhe/gn37
         y5VJ3006d/FcLdWFhff/IBEl3I0VcjiQsvy8M89oQ/LORrfjQ6Ei2Sc04MuyNUEAeyMy
         t2KyeybrUQ/UrEz/A23wBbKQoyl5Y/FzlGMr27Dvetr64FG1LHOQDy+nfBZB+01CzD0F
         Zrl1xOVx/7b6ZTMHitEa+hY9x1Gcnv+hHC7yr3u2hZGv77C4r7Byi7XX41JJ2iEalbqJ
         a7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=u4KIN2dv3zujSKlFX2maO2xnyNaGGDuJrxaXEWwcRpQ=;
        b=GwanwiZXBlUbbCDw6BbhpZnUHaNLtkltqaGu36fkUTjlQI957PcRr6IibEe6vS93NS
         3lL3StWsNWppMJJeewe91pjItP2EsoghhzaaTxR94flJPWAY+4ipD34Cmwd8Bt5qV0iV
         0aq2lotfEeKYfJOKxekjsTR2BQ0OvZG6LbLhD0TCnBAKp7hGhm0oL9z4x3ttspK6K2G4
         qjY/1RwPYC6FYDw36zivdIDNw0EDsidhw21W6Wnm1xIDmwrcJnfxGh7WbOB3Whd14xrD
         exhrPgDfhI1LvVMLdXLSYXnotxRlY7wZ21nKjenBCYfzlC8JyRCTvmf2kxplAb8MlPDP
         fqmQ==
X-Gm-Message-State: AOAM533vdxaROJrkvzRY1eAU5xCqUVnZtqceB39CTd0ZIGUVRfoJcMG4
        +b6qSgyq4yfRBh1Fdcx9HDKW3B9FLxih2sWi3Hhteg==
X-Google-Smtp-Source: ABdhPJz9397l5v8CijNctOC/Xc8xCBkGt3KFU1rVNNw+qoHCx9npaqi3bSQRtCCdWAGomHBvocbkphEOI7tefDIf3OE=
X-Received: by 2002:a17:90b:1e07:: with SMTP id pg7mr1640070pjb.93.1637800459614;
 Wed, 24 Nov 2021 16:34:19 -0800 (PST)
MIME-Version: 1.0
References: <20211120000250.1663391-1-ben.widawsky@intel.com> <20211120000250.1663391-14-ben.widawsky@intel.com>
In-Reply-To: <20211120000250.1663391-14-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 24 Nov 2021 16:34:09 -0800
Message-ID: <CAPcyv4jjVvCn2848-m8BOEHOW+20a=o3zC4Msr+Exa4n_g75Mg@mail.gmail.com>
Subject: Re: [PATCH 13/23] cxl/core: Move target population locking to caller
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
> In preparation for a port driver that enumerates a descendant port +
> decoder hierarchy, arrange for an unlocked version of cxl_decoder_add().
> Otherwise a port-driver that adds a child decoder will deadlock on the
> device_lock() in ->probe().
>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
>
> ---
>
> Changes since RFCv2:
> - Reword commit message (Dan)
> - Move decoder API changes into this patch (Dan)
> ---
>  drivers/cxl/core/bus.c | 59 +++++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h      |  1 +
>  2 files changed, 45 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 16b15f54fb62..cd6fe7823c69 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -487,28 +487,22 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>  {
>         int rc = 0, i;
>
> +       device_lock_assert(&port->dev);
> +
>         if (!target_map)
>                 return 0;
>
> -       device_lock(&port->dev);
> -       if (list_empty(&port->dports)) {
> -               rc = -EINVAL;
> -               goto out_unlock;
> -       }
> +       if (list_empty(&port->dports))
> +               return -EINVAL;
>
>         for (i = 0; i < cxld->nr_targets; i++) {
>                 struct cxl_dport *dport = find_dport(port, target_map[i]);
>
> -               if (!dport) {
> -                       rc = -ENXIO;
> -                       goto out_unlock;
> -               }
> +               if (!dport)
> +                       return -ENXIO;
>                 cxld->target[i] = dport;
>         }
>
> -out_unlock:
> -       device_unlock(&port->dev);
> -
>         return rc;
>  }
>
> @@ -571,7 +565,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
>
>  /**
> - * cxl_decoder_add - Add a decoder with targets
> + * cxl_decoder_add_locked - Add a decoder with targets
>   * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
>   * @target_map: A list of downstream ports that this decoder can direct memory
>   *              traffic to. These numbers should correspond with the port number
> @@ -581,12 +575,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
>   * is an endpoint device. A more awkward example is a hostbridge whose root
>   * ports get hot added (technically possible, though unlikely).
>   *
> - * Context: Process context. Takes and releases the cxld's device lock.
> + * This is the locked variant of cxl_decoder_add().
> + *
> + * Context: Process context. Expects the cxld's device lock to be held.
>   *
>   * Return: Negative error code if the decoder wasn't properly configured; else
>   *        returns 0.
>   */
> -int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
>  {
>         struct cxl_port *port;
>         struct device *dev;
> @@ -619,6 +615,39 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>
>         return device_add(dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
> +
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * This is the unlocked variant of cxl_decoder_add_locked().
> + * See cxl_decoder_add_locked().
> + *
> + * Context: Process context. Takes and releases the cxld's device lock.

No, it takes the port's lock to walk its dport list.

Otherwise, looks good to me:

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
