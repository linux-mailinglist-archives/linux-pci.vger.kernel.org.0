Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2755838B24D
	for <lists+linux-pci@lfdr.de>; Thu, 20 May 2021 16:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231252AbhETO4P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 May 2021 10:56:15 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45]:42658 "EHLO
        mail-ej1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbhETO4P (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 May 2021 10:56:15 -0400
Received: by mail-ej1-f45.google.com with SMTP id lg14so25748781ejb.9;
        Thu, 20 May 2021 07:54:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3YFOofnGkedJCrPa1Dyp3yag+zkaw/LioaIxjLT1KkA=;
        b=EMutIRPQhBWuWmxj6dNnACRSWqWfgNsM4Q4nLRjpH5beuWT9N0ayupSFppfAKpY5HZ
         jD+fUZqvK/jyeo1MFx2KtYqv4CqKuUqGgZoJQFMZIpmZzE1l+1GYS6v0vQYxR1Uz1op+
         tC1h02Y0H0PRWKAn7GtIg8KDKKMdMYgL08w6gcsklQIFtzxbWdQSghOWuzgiUfF+boGq
         nr0XSKq8MjWpWXha1cmqv/THqw0E2UAn1doPgFGpPc9TQyYBw4Nk+1yrdRKx2GXDJOHP
         1NoVkcY7xPpUKOHA16eB4EBz+VELN1QxmB1awOV3QVFCi8+AtBjioTeblKGb7CJvC2c4
         3EbA==
X-Gm-Message-State: AOAM531mrVVM4S5XU8CtR/8E0upy2nRvRI6QvDIyiMRVM2hI70zmYiVi
        XFFIzELnezvwQa2as+JmrN8=
X-Google-Smtp-Source: ABdhPJxFzFRDJ82YXhEHXTg6p8sgmyDlbhVkEbIn88qrKu87hu44yiezneYiYUxFmTdZFE3aBKC/1w==
X-Received: by 2002:a17:906:7e0f:: with SMTP id e15mr5021933ejr.398.1621522492790;
        Thu, 20 May 2021 07:54:52 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id yr15sm1563389ejb.16.2021.05.20.07.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 07:54:51 -0700 (PDT)
Date:   Thu, 20 May 2021 16:54:50 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Amey Narkhede <ameynarkhede03@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, alex.williamson@redhat.com,
        raphael.norwitz@nutanix.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/7] PCI: merge slot and bus reset
 implementations
Message-ID: <20210520145450.GA641812@rocinante.localdomain>
References: <20210519235426.99728-1-ameynarkhede03@gmail.com>
 <20210519235426.99728-2-ameynarkhede03@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210519235426.99728-2-ameynarkhede03@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Amey,

Thank you for working on this!  Few comments and suggestions below.

[...]
> Link: https://lkml.org/lkml/2021/3/23/911

Linking to lkml.org is fine, however it became a canon now to link to
lore, so this would be:

  https://lore.kernel.org/lkml/20210323100625.0021a943@omen.home.shazbot.org/

I personally find it a bit easier to read on lore compared to lkml.org
when it goes to a large and long running threads.

[...]
> +int pci_reset_bus_function(struct pci_dev *dev, int probe)
> +{
> +	int rc = pci_dev_reset_slot_function(dev, probe);
> +
> +	if (rc != -ENOTTY)
> +		return rc;
> +	return pci_parent_bus_reset(dev, probe);
> +}

Depends on the style, but I would suggest using a boolean type for the
probe argument here and in the other functions that enable or disable
something.  I makes the intent clear, and this is also a popular pattern
you can see throughout the PCI tree.

Also, I would suggest adding a newline to separate final return, so that
it's easier to read the code, and to keep things consistent.

[...]
> -	rc = pci_dev_reset_slot_function(dev, 0);
> -	if (rc != -ENOTTY)
> -		return rc;
> -	return pci_parent_bus_reset(dev, 0);
> +	return pci_reset_bus_function(dev, 0);

See above about using boolean type here.

[...]
> -	rc = pci_dev_reset_slot_function(dev, 1);
>  	if (rc != -ENOTTY)
>  		return rc;
>  
> -	return pci_parent_bus_reset(dev, 1);
> +	return pci_reset_bus_function(dev, 1);

Same as above.

Krzysztof
