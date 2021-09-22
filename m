Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1D40413EAC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 02:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbhIVAqk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 20:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbhIVAqk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Sep 2021 20:46:40 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB649C061575
        for <linux-pci@vger.kernel.org>; Tue, 21 Sep 2021 17:45:10 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so1058874otb.10
        for <linux-pci@vger.kernel.org>; Tue, 21 Sep 2021 17:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q1iP5KefHqJWJ5qGAUDoYDJOyAD6pRFAZFOdaM0VUL4=;
        b=jEV6CpbXyr07JLXO1bp0yl7i+yms+T5LIGT6MwHF6pP/qG0RKnqzaXHP3PbaieYwko
         eiScBzgb/WsN+NvJnLl4t8FPVlcFSgH/ZYjXW0/dbKO8sDVbmqypt0rMXr/wg/O17Tkw
         VCUIukQzVQgK1p7wiXp5KbANB4eSFvjqbS6OufBZMTspLK6VKofrcLONrnjzcIffavOC
         sNTa24qsbj2zFf23cxhht8n9gEF7RhZZo41SmCRXkMlwxpqSt58N/iAWCoubiKQXzd6R
         P/Cfteln8igvgHe402qPDEmVCaUsIYLBxJvVa7PNvlpLnWka4d7kIA4Xvn0Ali7BjTJS
         KdGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q1iP5KefHqJWJ5qGAUDoYDJOyAD6pRFAZFOdaM0VUL4=;
        b=DKXugHWFxVJiSrs0U6w6TqWeX0PX+eWkcQw8K/0pPXsgQ15pJSwGH33bBguiCil+He
         Pygxk57OdksRSb59sP/CYR+t8zKtTXTPu9Feq7/SOgB2HZ4M3T6uTfi6Wb32ztlNdEIV
         pGxw94TWzSKo6A5kaYKFrR5v0k7/6XujsUWbMyo3Goa/UaSI9qT/Ck/UuJ1c/m/RjTUz
         r5HDhO7Vvui5eFZBrzBxDgPSIrqHhQiauQUM/YDBtm+RvEpnz2CVa5wn/gjmIaMPLTft
         tSEwrL+G+8+CBLT3Kihk8uJ7WXUMsStIVqn4ULpoOoLnQ7bKhg2SRWA2QxM3APBkz47L
         SrQA==
X-Gm-Message-State: AOAM530qXi0B0gS+Wr32WOvbM95O/RnOWOUM9lWvT7FyJa0ozM5lROHK
        RMnmXkLNmldep2CG5z8gvJQHc2YxDzZM8lkY21lXf8kipRWvfQ==
X-Google-Smtp-Source: ABdhPJwmYVkzrdW65h9xNSUrnW1faCzIMwKQt+WpaGKLoqWCC3rgZnXMLk+Dnzi5GMg1Owh3toA9VWsUpQuh0BoWQos=
X-Received: by 2002:a9d:6359:: with SMTP id y25mr28065477otk.274.1632271510013;
 Tue, 21 Sep 2021 17:45:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210921220459.2437386-1-ben.widawsky@intel.com> <20210921220459.2437386-8-ben.widawsky@intel.com>
In-Reply-To: <20210921220459.2437386-8-ben.widawsky@intel.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Tue, 21 Sep 2021 17:44:58 -0700
Message-ID: <CAPcyv4h4QHAQF+ogMvOXrkdyR5Jceo8yp7TQNN+836=v0QwdDw@mail.gmail.com>
Subject: Re: [PATCH 7/7] ocxl: Use pci core's DVSEC functionality
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Linux PCI <linux-pci@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
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
> Reduce maintenance burden of DVSEC query implementation by using the
> centralized PCI core implementation.
>
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: Frederic Barrat <fbarrat@linux.ibm.com>
> Cc: Andrew Donnellan <ajd@linux.ibm.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/misc/ocxl/config.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
> index a68738f38252..e401a51596b9 100644
> --- a/drivers/misc/ocxl/config.c
> +++ b/drivers/misc/ocxl/config.c
> @@ -33,18 +33,7 @@
>
>  static int find_dvsec(struct pci_dev *dev, int dvsec_id)
>  {
> -       int vsec = 0;
> -       u16 vendor, id;
> -
> -       while ((vsec = pci_find_next_ext_capability(dev, vsec,
> -                                                   OCXL_EXT_CAP_ID_DVSEC))) {
> -               pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
> -                               &vendor);
> -               pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
> -               if (vendor == PCI_VENDOR_ID_IBM && id == dvsec_id)
> -                       return vsec;
> -       }
> -       return 0;
> +       return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_IBM, dvsec_id);
>  }

What about:

arch/powerpc/platforms/powernv/ocxl.c::find_dvsec_from_pos()

...?  With that converted the redundant definitions below:

OCXL_EXT_CAP_ID_DVSEC
OCXL_DVSEC_VENDOR_OFFSET
OCXL_DVSEC_ID_OFFSET

...can be cleaned up in favor of the core definitions.
