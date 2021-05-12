Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBD3137B33C
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 03:00:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229736AbhELBCB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 21:02:01 -0400
Received: from mail-ej1-f47.google.com ([209.85.218.47]:38410 "EHLO
        mail-ej1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbhELBCB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 21:02:01 -0400
Received: by mail-ej1-f47.google.com with SMTP id b25so32416749eju.5;
        Tue, 11 May 2021 18:00:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=w5T9ZppkqLGlw3eNUaMbpVD5FujhFVJDEVceVQJsQxo=;
        b=PghfrQL2RSuE6A4U5f/W4k/JlnG+1WedYj1I9fOrEtgvWz7ondhm1NlIq6UjD4eNbb
         zERtaIROr9WiJ84esGCxXXX+rgnUomEp5TkPimaeNXX1hMArKlCcZIJytXcro9sd9DTY
         cRsz6UySs3pzcKY6ikxoMwoKmV5v44NO7qb8wBzbzV0PvZ/0ZgwQr5Cv0FME9w0v0+Lj
         n9+VF1TysyHPxcRLZB7crrW4csILbUxk/vPU/cIJR+CE+92xuFMCGTao7nt4IZhYxxzg
         rqMo+coegGtL9dMTYIOx0Hx4m7P78lFzB68hAlvyl2tS8sKL85J9uACXRDcIcrS6zw+J
         KDjA==
X-Gm-Message-State: AOAM531iC86yoXue02/pFczawXTW991gWwRkyb4+vmbkyi0IO+CEqxE/
        uxC+LYstV0aOIkWx2h/ulU4=
X-Google-Smtp-Source: ABdhPJzdayMEz2R8eKVIC+R0Mz0wUdi04OZcpUFEPErnRFhfCLxIg6YElc3jCwfMQKuH79ADXhuVCw==
X-Received: by 2002:a17:906:22c6:: with SMTP id q6mr34522665eja.275.1620781252296;
        Tue, 11 May 2021 18:00:52 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id u13sm15872171edq.55.2021.05.11.18.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 May 2021 18:00:51 -0700 (PDT)
Date:   Wed, 12 May 2021 03:00:49 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-usb@vger.kernel.org, helgaas@kernel.org,
        rajatxjain@gmail.com, jsbarnes@google.com, dtor@google.com
Subject: Re: [PATCH v2 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <20210512010049.GA89346@rocinante.localdomain>
References: <20210424021631.1972022-1-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210424021631.1972022-1-rajatja@google.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajat,

I have few questions below, but to add in advance, I might be confusing
the role that "type->supports_removable" and "dev->removable" plays
here, and if so then I apologise.

[...]
> @@ -2504,8 +2523,16 @@ static int device_add_attrs(struct device *dev)
>  			goto err_remove_dev_online;
>  	}
>  
> +	if (type && type->supports_removable) {
> +		error = device_create_file(dev, &dev_attr_removable);
> +		if (error)
> +			goto err_remove_dev_waiting_for_supplier;
> +	}
> +
>  	return 0;

Would a check for "dev->removable == DEVICE_REMOVABLE" here be more
appropriate?

Unless you wanted to add sysfs objects when the device hints that it has
a notion of being removable even though it might be set to "unknown" or
"fixed" (if that state is at all possible then), and in which case using
the dev_is_removable() helper would also not be an option since it does
a more complex check internally.

Technically, you could always add this sysfs object (similarly to what
USB core did) as it would then show the correct state depending on
"dev->removable".

Also, I suppose, it's not possible for a device to have
"supports_removable" set to true, but "removable" would be different
than "DEVICE_REMOVABLE", correct?

[...]
> +enum device_removable {
> +	DEVICE_REMOVABLE_UNKNOWN = 0,
> +	DEVICE_REMOVABLE,
> +	DEVICE_FIXED,
> +};

I know this was moved from the USB core, but I personally find it
a little bit awkward to read, would something like that be acceptable?

enum device_removable {
	DEVICE_STATE_UNKNOWN = 0,
	DEVICE_STATE_REMOVABLE,
	DEVICE_STATE_FIXED,
};

The addition of state to the name follows the removable_show() function
where the local variable is called "state", and I think it makes sense
to call this as such.  What do you think?

> +static inline bool dev_is_removable(struct device *dev)
> +{
> +	return dev && dev->type && dev->type->supports_removable
> +	    && dev->removable == DEVICE_REMOVABLE;
> +}

Similarly to my question about - would a simple check to see if
"dev->removable" is set to "DEVICE_REMOVABLE" here be enough?

Krzysztof
