Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE8B2858E4
	for <lists+linux-pci@lfdr.de>; Wed,  7 Oct 2020 08:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726009AbgJGG54 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Oct 2020 02:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJGG5z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Oct 2020 02:57:55 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79055C061755
        for <linux-pci@vger.kernel.org>; Tue,  6 Oct 2020 23:57:55 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l11so1135150wmh.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Oct 2020 23:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RvBs0NtTAlv1X8xK9DK+JUwuX3FHUjdEnezntOoMEhA=;
        b=JwqsHdhVrikUVbP0FWDt07MtnZYB96hY71/Y68TVyo1SQGK/zTc/DNxqV/dMEa43sg
         3QThoq2ZuHl6TB+oa06cxhQ8FmXnQ0PxtbavNFPBPR+z+0Po5Vx4wRUePTdSh8ZkJX9I
         sTHowo/fiEPo359XnMKIJdw2Jvf1IugLpTZNwD2YakusslSi5YO+OCZBqFQR6kYq10Nr
         cPOwDM20Mz+3agmGmuj7yTCin1kuiHws8iVF9SI+pKVltmPzGlTujXiDZFYH+XWXXKZo
         VdbPN8FNCeDGBdqfoMki5kQ7VCNRck35KMyLY3fyU9QRKm+dzgT33EXKUogZDUn9bRyA
         To+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RvBs0NtTAlv1X8xK9DK+JUwuX3FHUjdEnezntOoMEhA=;
        b=TiPjXXoX9/zo7zf625sXjr/4AZWWdK+GBHBjiGd+xPG4SXMdVQ65rR/euq85/WP1yy
         5NwZmoqSEpDO0292dseE78UMO0SRv586CpFs1kGS2fdwU3qUV5yT29qF9BED47dWuaIw
         6bJw1R2lIrH4HvpAaPWlt3hUtod3GrrlYUwBWqsWepq1s96tEKK0sdF+OGOOXNCVYN6c
         frq6dF7iQHVv3Fwl3+UHCnrA1b+jqOqpRLTuoMUV5FTdyAWLt/qLlo1T350S9BTMo5n2
         OzeV1apjgYR9YwdER54RXTA171mcjWYwPMpHPJCenL9M2o5iHvkTGuwQqVAZSThrLSzr
         t5Hg==
X-Gm-Message-State: AOAM533lZ8DI4vOfM/QQprh75Q9lqKq0aiDUdJnmdCvHe66EsjaL8lP2
        ZhwRtZgsMki8SwaJwirE9VAs/g==
X-Google-Smtp-Source: ABdhPJyh6b3ua7kPCSvwZfZ/YfLpCWrAPpOCrD+jrkhwaT4WP7jgf0le8jwzj9Kr0Q6KhQTU/8JMzA==
X-Received: by 2002:a1c:49c2:: with SMTP id w185mr1599561wma.70.1602053874162;
        Tue, 06 Oct 2020 23:57:54 -0700 (PDT)
Received: from dell ([91.110.221.236])
        by smtp.gmail.com with ESMTPSA id g4sm1505929wrm.18.2020.10.06.23.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 23:57:53 -0700 (PDT)
Date:   Wed, 7 Oct 2020 07:57:51 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        hdegoede@redhat.com, alexey.budankov@linux.intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V8 2/5] mfd: Intel Platform Monitoring Technology support
Message-ID: <20201007065751.GA1763265@dell>
References: <20201003013123.20269-1-david.e.box@linux.intel.com>
 <20201003013123.20269-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201003013123.20269-3-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 02 Oct 2020, David E. Box wrote:

> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring facilities. PMT supports
> multiple types of monitoring capabilities. This driver creates platform
> devices for each type so that they may be managed by capability specific
> drivers (to be introduced). Capabilities are discovered using PCIe DVSEC
> ids. Support is included for the 3 current capability types, Telemetry,
> Watcher, and Crashlog. The features are available on new Intel platforms
> starting from Tiger Lake for which support is added. This patch adds
> support for Tiger Lake (TGL), Alder Lake (ADL), and Out-of-Band Management
> Services Module (OOBMSM).
> 
> Also add a quirk mechanism for several early hardware differences and bugs.
> For Tiger Lake and Alder Lake, do not support Watcher and Crashlog
> capabilities since they will not be compatible with future product. Also,
> fix use a quirk to fix the discovery table offset.
> 
> Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  MAINTAINERS             |   5 +
>  drivers/mfd/Kconfig     |  10 ++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/intel_pmt.c | 226 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 242 insertions(+)
>  create mode 100644 drivers/mfd/intel_pmt.c

I Acked this back in August.

Any reason why you didn't carry it forward?

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
