Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E68E46F47C
	for <lists+linux-pci@lfdr.de>; Thu,  9 Dec 2021 21:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbhLIUEF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Dec 2021 15:04:05 -0500
Received: from mail-wm1-f45.google.com ([209.85.128.45]:50920 "EHLO
        mail-wm1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhLIUEF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Dec 2021 15:04:05 -0500
Received: by mail-wm1-f45.google.com with SMTP id 133so5192235wme.0;
        Thu, 09 Dec 2021 12:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gbPA524UXn7VLl57ldF8UrIDv0OwWD8ZPIHj4sbJMHY=;
        b=c5/a4RF+Pa+qj4tA1e1a6HHwsdRFPTz5H2DxosPSkw6agG8jQG0v25oS3Zvcs5eUHj
         y8VF+w+pQE30EIwiqsaRYPhoVUt/wPTkfSP76VE01pVVt32FMBq7QOzV+0T79peCow0i
         N7mFGVfxP4UA3q8+qvytw4xRBOHrn+XY9l3qK58I800qYvveF6m/8cZ2zIzEMvKIcByP
         V8H6hbN3DcfLI0jTdxR+r9gZfzyOuYBWFeagBTj1foF9Qaw1kG7YiJzAhw7/PAmBljF0
         sF2VVUeLMI50erAvXzuNB2eBXeKQd7KD7MxftjoC7M9+C6JbYWp5lWf5MVBidtFUYNBz
         3w5Q==
X-Gm-Message-State: AOAM531S36qanfwTzEmVhjBIxbD0Lj2jf2G2M85lLV3I6UBGrXwC6/o7
        Spd62AvkLa8ILD/dlNFBeBU=
X-Google-Smtp-Source: ABdhPJx6sMuEBLALN8hgbd7SLjIKAmBQ8tdQEFM4sJ8pcNaZlwU0Ti2nIO/OgD6qvG//K7wC7NF3pg==
X-Received: by 2002:a1c:20d3:: with SMTP id g202mr9954102wmg.129.1639080030214;
        Thu, 09 Dec 2021 12:00:30 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e8sm617025wrr.26.2021.12.09.12.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 12:00:29 -0800 (PST)
Date:   Thu, 9 Dec 2021 21:00:28 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Joe Perches <joe@perches.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jean Delvare <jdelvare@suse.de>
Subject: Re: [PATCH v2 1/1] PCI: Introduce pci_bus_*() printing macros when
 device is not available
Message-ID: <YbJgXKf6NkbHgy5A@rocinante>
References: <20211209182711.28709-1-andriy.shevchenko@linux.intel.com>
 <411886e9e89f797d3f9513245f94b2a5f4a33e7d.camel@perches.com>
 <YbJaFM0vlkdTwxUS@smile.fi.intel.com>
 <47d32a2f648281c6a1731266d1a5d00da3d1a875.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47d32a2f648281c6a1731266d1a5d00da3d1a875.camel@perches.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Andy and Joe,

[...]
> > > > +#define pci_bus_printk(level, bus, devfn, fmt, arg...) \
> > > > +	printk(level "pci %04x:%02x:%02x.%d: " fmt, \
> > > > +	       pci_domain_nr(bus), bus->number, PCI_SLOT(devfn), PCI_FUNC(devfn), ##arg)
> > > 
> > > I have a small preference for using ... and __VA_ARGS___
> > 
> > It contradicts what other macros in the pci.h do.
> > So I will stick with current solution for the sake of consistency.
> 
> There's always this possibility.
> 
> And this: (cheers)
> ---
>  include/linux/pci.h | 58 ++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 33 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index 0ce26850470ef..1dc34f6eaeda7 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -2456,30 +2456,38 @@ void pci_uevent_ers(struct pci_dev *pdev, enum  pci_ers_result err_type);
>  /* Provide the legacy pci_dma_* API */
>  #include <linux/pci-dma-compat.h>
>  
> -#define pci_printk(level, pdev, fmt, arg...) \
> -	dev_printk(level, &(pdev)->dev, fmt, ##arg)
> -
> -#define pci_emerg(pdev, fmt, arg...)	dev_emerg(&(pdev)->dev, fmt, ##arg)
> -#define pci_alert(pdev, fmt, arg...)	dev_alert(&(pdev)->dev, fmt, ##arg)
> -#define pci_crit(pdev, fmt, arg...)	dev_crit(&(pdev)->dev, fmt, ##arg)
> -#define pci_err(pdev, fmt, arg...)	dev_err(&(pdev)->dev, fmt, ##arg)
> -#define pci_warn(pdev, fmt, arg...)	dev_warn(&(pdev)->dev, fmt, ##arg)
> -#define pci_notice(pdev, fmt, arg...)	dev_notice(&(pdev)->dev, fmt, ##arg)
> -#define pci_info(pdev, fmt, arg...)	dev_info(&(pdev)->dev, fmt, ##arg)
> -#define pci_dbg(pdev, fmt, arg...)	dev_dbg(&(pdev)->dev, fmt, ##arg)
> -
> -#define pci_notice_ratelimited(pdev, fmt, arg...) \
> -	dev_notice_ratelimited(&(pdev)->dev, fmt, ##arg)
> -
> -#define pci_info_ratelimited(pdev, fmt, arg...) \
> -	dev_info_ratelimited(&(pdev)->dev, fmt, ##arg)
> -
> -#define pci_WARN(pdev, condition, fmt, arg...) \
> -	WARN(condition, "%s %s: " fmt, \
> -	     dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
> -
> -#define pci_WARN_ONCE(pdev, condition, fmt, arg...) \
> -	WARN_ONCE(condition, "%s %s: " fmt, \
> -		  dev_driver_string(&(pdev)->dev), pci_name(pdev), ##arg)
> +#define pci_printk(level, pdev, fmt, ...)				\
> +	dev_printk(level, &(pdev)->dev, fmt, ##__VA_ARGS__)
> +
> +#define pci_emerg(pdev, fmt, ...)					\
> +	dev_emerg(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_alert(pdev, fmt, ...)					\
> +	dev_alert(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_crit(pdev, fmt, ...)					\
> +	dev_crit(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_err(pdev, fmt, ...)						\
> +	dev_err(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_warn(pdev, fmt, ...)					\
> +	dev_warn(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_notice(pdev, fmt, ...)					\
> +	dev_notice(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_info(pdev, fmt, ...)					\
> +	dev_info(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_dbg(pdev, fmt, ...)						\
> +	dev_dbg(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +
> +#define pci_notice_ratelimited(pdev, fmt, ...)				\
> +	dev_notice_ratelimited(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +#define pci_info_ratelimited(pdev, fmt, ...)				\
> +	dev_info_ratelimited(&(pdev)->dev, fmt, ##__VA_ARGS__)
> +
> +#define pci_WARN(pdev, condition, fmt, ...)				\
> +	WARN(condition, "%s %s: " fmt,					\
> +	     dev_driver_string(&(pdev)->dev), pci_name(pdev),		\
> +	     ##__VA_ARGS__)
> +#define pci_WARN_ONCE(pdev, condition, fmt, ...)			\
> +	WARN_ONCE(condition, "%s %s: " fmt,				\
> +		  dev_driver_string(&(pdev)->dev), pci_name(pdev),	\
> +		  ##__VA_ARGS__)
>  
>  #endif /* LINUX_PCI_H */

I think both things look nice!

So perhaps meet in-between here?  Two patches in a small series: one adds
new useful macros from Andy, and the other updates current macros as per
Joe's feedback/preference?  I am sure Bjorn wouldn't mind (hopefully).

	Krzysztof
