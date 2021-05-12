Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6068F37F01F
	for <lists+linux-pci@lfdr.de>; Thu, 13 May 2021 01:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhELXxu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 May 2021 19:53:50 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:40542 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233586AbhELXdk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 May 2021 19:33:40 -0400
Received: by mail-wm1-f42.google.com with SMTP id y124-20020a1c32820000b029010c93864955so508696wmy.5;
        Wed, 12 May 2021 16:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1H+d0FBxQyBmCizFzbRyEoxvV7pCSwkXkm1m5umLuY4=;
        b=N8gDeDCeXiCLYx1kdeuLqy/l7jZ4CZq4uN00fnTbQ0fmjmSByuOA2dOKwQlwyT9KeD
         SOYvvYqNrGHHagmL1qSEo/+fRquqVfm2xJW7qSLQi2mgSKQ2MuKVCGjlUR6lbXzgO5EL
         FIl4PCL1dw48U5pYY911drh3VclTCZ1o/5r0et+NhjoH0J5VJG2wS2dpOQe+mPVPAJgr
         oTQmOKoBcruDgfRdEvwJ7EBagbzKRv1fCKQVrOO+/GuCS2YofdjGDJFU/U8L8jQWwvks
         LMF8xeHqswcfRPsA9JJTwYAvQGVcscZ7xr0/0j+6TSidUplvp4c5u1Gox94uBMsEQOiq
         fW0w==
X-Gm-Message-State: AOAM531SNwHaN1snxTLh37NjhHqlc206h837jWJ1rco+adFyTA7cUloa
        VS5WYr+jCDNqsWXPn3NqwYGjVcuMuiwkd6vz
X-Google-Smtp-Source: ABdhPJyrWHK5hpJkgZiC7V6D/0QFJqr9C2oF38e/hMrtNMBBAj4fwLxfq8HoFrOyuq300gy/4GFR6g==
X-Received: by 2002:a05:600c:293:: with SMTP id 19mr41463394wmk.144.1620862348337;
        Wed, 12 May 2021 16:32:28 -0700 (PDT)
Received: from rocinante.localdomain ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id e12sm1123249wrm.80.2021.05.12.16.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 16:32:27 -0700 (PDT)
Date:   Thu, 13 May 2021 01:32:25 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Rajat Jain <rajatja@google.com>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        "open list:ULTRA-WIDEBAND (UWB) SUBSYSTEM:" 
        <linux-usb@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Subject: Re: [PATCH v2 1/2] driver core: Move the "removable" attribute from
 USB to core
Message-ID: <20210512233225.GA137103@rocinante.localdomain>
References: <20210424021631.1972022-1-rajatja@google.com>
 <20210512010049.GA89346@rocinante.localdomain>
 <CAA93t1ohAFM1U2xTvbd1J1dUCaZwh6GYNGib_AM0J7+qHwSf1A@mail.gmail.com>
 <CACK8Z6HuKqgYQZGJZGQGr5FC96naV+1yXZuwYTy5Ydb5=k40KA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACK8Z6HuKqgYQZGJZGQGr5FC96naV+1yXZuwYTy5Ydb5=k40KA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Rajat,

> Posted a v3 of this patch here:
> https://lore.kernel.org/patchwork/patch/1428133/

I saw!  Thank you!

I also found the original conversation around the main idea that's
driving the work done here, as per:

  https://lore.kernel.org/lkml/20200601232542.GA473883@bjorn-Precision-5520/

This helped to fill-in some missing pieces, so to speak, I've bad.

[...]
> > > > @@ -2504,8 +2523,16 @@ static int device_add_attrs(struct device *dev)
> > > >                       goto err_remove_dev_online;
> > > >       }
> > > >
> > > > +     if (type && type->supports_removable) {
> > > > +             error = device_create_file(dev, &dev_attr_removable);
> > > > +             if (error)
> > > > +                     goto err_remove_dev_waiting_for_supplier;
> > > > +     }
> > > > +
> > > >       return 0;
> > >
> > One of my primary considerations was also that the existing UAPI for
> > the USB's "removable" attribute shouldn't be changed. Currently, it
> > exists for all USB devices, so I think the current code / check is OK.
[...]

We wouldn't change addition of this attribute to the USB devices - after
the lift to the device core it still has to work as before, as you say.

Just to clarify.   What I was wondering is whether we should add this new
sysfs object so that every device now would get this attribute going
forward, regardless of whether it would have the "type->supports_removable"
set.

We would then have a lot of devices with this attribute set to
"unknown", and then were the is an actual support it would then be
either "fixed" or "removable".

Having said that, Bjorn pointed out to me that this might be
not necessarily desirable.

We were also wondering if we should only set DEVICE_REMOVABLE for
devices known to be behind an external-facing port, and let everything
else be set to "unknown" (or whatever the default would be).

Krzysztof
