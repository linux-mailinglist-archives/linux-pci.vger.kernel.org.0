Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6CB38B337
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 17:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhETP2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 11:28:00 -0400
Received: from mail-lj1-f178.google.com ([209.85.208.178]:47083 "EHLO
        mail-lj1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232073AbhETP14 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 11:27:56 -0400
Received: by mail-lj1-f178.google.com with SMTP id e11so20203490ljn.13;
        Thu, 20 May 2021 08:26:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kc33j5rybEcJBbwaVSn/MKbn2ie8ghQMdP8M0Psq8wk=;
        b=PAXXKAxQZL8MgVTPG3wd/ik7ROof50zC6pBok7aZEp1Xk5lBvyyVEUQluC4Icyh91A
         z33RFFRJ3uw+27i1Uh4GN24wmdkHIsWsiWf0eN0oozGqYKWACbQys+x6e30b17O9YN/1
         h57CL0NjzxR9S7Fry0DKmF7egeDnH8jms96oSWlWMToXNeHSQpZcBZiUyuxuxcYtEKHS
         TDxTC3oec7ucfSrT0me6mZdXmHtJWj+KfMqJ3VdVdBR0z63kBWjQbDzbJGr2necHTJXG
         vDpGYwDdWVJiANSyQvngEwnuwb8tCc0HdOj7sJ83r8naEBrxBTMVS95UA6ZHVCpuybq/
         4viA==
X-Gm-Message-State: AOAM532OauOBIT8vTLH/QzQIzf76AIKeDG+uQ2DzM6OzfzIG882KnftN
        dWq8phAY4BhC9P7VFYrCnui1CVpFEhMPuCJy
X-Google-Smtp-Source: ABdhPJzLKjnWJGPgefuPGvfAqGJD6/I7WNJ+GdpiINjv+0jV4gYUiaoQS+UwM24HNEemR+2jO1znhw==
X-Received: by 2002:a2e:9d09:: with SMTP id t9mr841682lji.213.1621524393713;
        Thu, 20 May 2021 08:26:33 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id j1sm328967lfg.166.2021.05.20.08.26.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 08:26:33 -0700 (PDT)
Date:   Thu, 20 May 2021 17:26:32 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 3/7] PCI: Add new array for keeping track of
 ordering of reset methods
Message-ID: <20210520152632.GC641812@rocinante.localdomain>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-4-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519235426.99728-4-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

[...]
> +/*
> + * The ordering for functions in pci_reset_fn_methods
> + * is required for reset_methods byte array defined
> + * in struct pci_dev
> + */

A small nitpick: missing period at the end of the sentence in the
comment above, and in other comments too.  Might add for completeness
and consistency.

[...]
> +typedef int (*pci_reset_fn_t)(struct pci_dev *, int);
> +
> +struct pci_reset_fn_method {
> +	pci_reset_fn_t reset_fn;
> +	char *name;
> +};

Question about the custom type definition above: would it be really
needed?  It there is only potentially a limited use for it, then perhaps
it would not be useful to have one?

Linus also has some preference on usage of custom types, as per:

  https://yarchive.net/comp/linux/typedefs.html

But, in the end, this really boils down to a matter of style and/or
preference.

[...]
> +#define PCI_RESET_FN_METHODS 5

Not sure if worth changing name of this constant, but what about the
following:

  #define PCI_RESET_FN_METHODS_NUM 5

Or even perhaps:

  #define PCI_RESET_METHODS_NUM 5

So it's a little bit more self-explanatory.  This would be in the
similar notion, as per:

  https://elixir.bootlin.com/linux/v5.13-rc2/source/include/linux/pci.h#L115

[...]
> +	u8 reset_methods[PCI_RESET_FN_METHODS];	/* Array for storing ordering of reset methods */

This comment reads somewhat awkward - we know that an array would be
used, most likely, for storing things, thus what about the following:

  /* Reset methods ordered by priority */

Just a suggestion, though.

Krzysztof
