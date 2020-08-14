Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8C9244BE8
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 17:23:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHNPXU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 11:23:20 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39173 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726270AbgHNPXU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 11:23:20 -0400
Received: by mail-ot1-f66.google.com with SMTP id z18so7846145otk.6;
        Fri, 14 Aug 2020 08:23:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m4s76eJi1HyL+NXonoWfmZoTC1Xq7QOIoC3N0JmmMDQ=;
        b=nsJ8MtTlxLYYW403Jk1F/38ursLHq25yGpXJP+1jcGPKtUxf5ZtNp5o9ozl43Mlrqt
         IveSAKxQNTGOkR3TnJ6xy2DK1Gl7VSsIR48PFQvaCoDRQQrB7BF55zbrMNLAQhdiCuQy
         tZWjakdHYs+ERyOmTtBeVr6yvMus6KItoS5ee3ejMB/SnOzjxKIbODqpQicA2nkDR+N5
         DtyWe6962yV3iaGb/0nlulGCoBP4ZV2mW4SYqKqM8d/p5qhLkvciXZ9xPrgdUzXIlWdl
         JWCXDWv9sOmilKBsIFwpJPgqwWT2Oi7P27SxPtzJEHxJxSNnpxWfKv0C41P2ETxLy6X7
         ZjOA==
X-Gm-Message-State: AOAM5322wSLwcz4YkELKI6YDD7oAlmjD6nMHF+riHST9YoTfhTy0oVhq
        LOKrM/ODWWP4LhHY8G2ZQZY3/ZZLGRwoHa2GizQ=
X-Google-Smtp-Source: ABdhPJyuU8RKO2uVZAaubWhnCLHenAsYFpioXVUF+4OfePM8DUuQRDy4EDVjxwiGjDsC8ZLu8eZoxKLj/sl+oZxrqG0=
X-Received: by 2002:a05:6830:1e5c:: with SMTP id e28mr2193175otj.118.1597418599210;
 Fri, 14 Aug 2020 08:23:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200813175729.15088-1-andriy.shevchenko@linux.intel.com> <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20200813175729.15088-3-andriy.shevchenko@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Aug 2020 17:23:07 +0200
Message-ID: <CAJZ5v0iDZ6UZK_WW6pvWCqsrUH3uqfjRXSoMDTsAcbXoBuMYqw@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] resource: Introduce resource_union() for
 overlapping resources
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Aug 13, 2020 at 7:57 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> Some already present users may utilize resource_union() helper.
> Provide it for them and for wider use in the future.
>
> Deliberately avoid min()/max() macro as they are still parts of
> kernel.h which is quite a burden to be included here in order
> to avoid circular dependencies.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Cc: Mika Westerberg <mika.westerberg@linux.intel.com>
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-pci@vger.kernel.org
> ---
>  include/linux/ioport.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index 0193987b9968..c98df0ec7422 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -232,6 +232,16 @@ static inline bool resource_overlaps(struct resource *r1, struct resource *r2)
>         return (r1->start <= r2->end && r1->end >= r2->start);
>  }
>
> +static inline bool
> +resource_union(struct resource *r1, struct resource *r2, struct resource *r)
> +{
> +       if (!resource_overlaps(r1, r2))
> +               return false;

I tend to add empty lines after return statements like this to make
them more clearly visible.

> +       r->start = r2->start < r1->start ? r2->start : r1->start;
> +       r->end = r2->end > r1->end ? r2->end : r1->end;

Well, what about using min() and max() here?

> +       return true;
> +}
> +
>  /* Convenience shorthand with allocation */
>  #define request_region(start,n,name)           __request_region(&ioport_resource, (start), (n), (name), 0)
>  #define request_muxed_region(start,n,name)     __request_region(&ioport_resource, (start), (n), (name), IORESOURCE_MUXED)
> --
> 2.28.0
>
