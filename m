Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D5E37B363
	for <lists+linux-pci@lfdr.de>; Wed, 12 May 2021 03:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229934AbhELBWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 May 2021 21:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhELBWN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 11 May 2021 21:22:13 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1FFFC061574;
        Tue, 11 May 2021 18:21:06 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id a11so20066008ioo.0;
        Tue, 11 May 2021 18:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=xHB79h3azR5FeMjEmcCPhDImC0Y4yGYd2UePCCok+Yk=;
        b=hs/+cVBOSW7PlZMHmRTOYtJtIVu2rlvGv3R47l+DA3AbIoaiucWINPHfjHAAyjym9u
         BjGpDfu/6UyTVd4e1XzviXRMJVcb0nyCdoXsFMm+TEM6nbcqUM5kiwD7JVWUsx9MctsO
         dDY3fLp/owMmpcsocQ77AdmL5cD4Ea83Eu8b3Mv7Qn29ponki2kJBTkCKvKG/Mc2AiYQ
         Jw982PkGrYGyRK6vApFSPbsuDYkkuTolnOQ3Ie2hBjgXkGozPwZhnpj4Z2Duo/Ak4xpB
         LwaqBvzybfjCup79ycD/p2J1kZrZUpuoH0V6jm7F4aflxMCQke49ech3V0OMnbg456Bc
         BCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc:content-transfer-encoding;
        bh=xHB79h3azR5FeMjEmcCPhDImC0Y4yGYd2UePCCok+Yk=;
        b=s2YfHIqYpFaPDIpxSxtdQqb8ILVVEVXYKjdWP4AeutEQROpX830B22K4lxfpLZdO4O
         4Ne0cWpmMF7nYcbh64lcl6mGSrVxwtmM1TfZaFCFB3VlTmrU0uV5qM1UTDF6r/Vkwmis
         Vbd0AGr3TGrW+/FAlL6GDfWyKdRCD906prKQDpwQNr+tAwNL66Nfc/ck+CzuModj5bUe
         esavTKg2x9hS3f1G7wLFwFP92m17u0oqdV+uQ1D9gIBZ813YVSEFJp0SPDYdxhJbOST3
         0LCp+2X18P5WocFh9Acd2Gb1ZfaWBxwu8WraMAA6J4etb2GsjWmLkIft77bW8YB+SP6s
         /EzQ==
X-Gm-Message-State: AOAM533ThI/pYjHXnwTffYTI6/u3HEN2vz8v6oT+ulg/vybX9YHKGNuq
        7W1t9RUbBBev5c5+nvM0Np3kx3vtGAzPGGSNcCw=
X-Google-Smtp-Source: ABdhPJxlHtrpYE70KZn4ngNfhszJFq6xOhz4O+aQO+XlpdIGNgIvqx4Xqm3oplcbM9d5K88ia2JaumE452mFYHvZHLE=
X-Received: by 2002:a02:970c:: with SMTP id x12mr2948729jai.21.1620782466199;
 Tue, 11 May 2021 18:21:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210424021631.1972022-1-rajatja@google.com> <20210512010049.GA89346@rocinante.localdomain>
In-Reply-To: <20210512010049.GA89346@rocinante.localdomain>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Tue, 11 May 2021 18:20:55 -0700
Message-ID: <CAA93t1ohAFM1U2xTvbd1J1dUCaZwh6GYNGib_AM0J7+qHwSf1A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] driver core: Move the "removable" attribute from
 USB to core
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Rajat Jain <rajatja@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>, linux-usb@vger.kernel.org,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jesse Barnes <jsbarnes@google.com>,
        Dmitry Torokhov <dtor@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krzysztof,

Thanks a lot for your comments. Please see inline.

On Tue, May 11, 2021 at 6:00 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> Hi Rajat,
>
> I have few questions below, but to add in advance, I might be confusing
> the role that "type->supports_removable" and "dev->removable" plays
> here, and if so then I apologise.
>
> [...]
> > @@ -2504,8 +2523,16 @@ static int device_add_attrs(struct device *dev)
> >                       goto err_remove_dev_online;
> >       }
> >
> > +     if (type && type->supports_removable) {
> > +             error =3D device_create_file(dev, &dev_attr_removable);
> > +             if (error)
> > +                     goto err_remove_dev_waiting_for_supplier;
> > +     }
> > +
> >       return 0;
>
> Would a check for "dev->removable =3D=3D DEVICE_REMOVABLE" here be more
> appropriate?
>
> Unless you wanted to add sysfs objects when the device hints that it has
> a notion of being removable even though it might be set to "unknown" or
> "fixed" (if that state is at all possible then), and in which case using
> the dev_is_removable() helper would also not be an option since it does
> a more complex check internally.
>
> Technically, you could always add this sysfs object (similarly to what
> USB core did) as it would then show the correct state depending on
> "dev->removable".
>
> Also, I suppose, it's not possible for a device to have
> "supports_removable" set to true, but "removable" would be different
> than "DEVICE_REMOVABLE", correct?

No, that is not true.

device_type->supports_removable=3D1 indicates that the bus / subsystem
is capable of differentiating between removable and fixed devices.
It's essentially describing a capability of the bus / subsystem. This
flag needs to be true for a subsystem for any it's devices'
dev->removable field to be considered meaningful.

OTOH, the dev->removable =3D> indicates the location of the device IF
device_type->supports location is true. Yes, it can be fixed /
removable / unknown (whatever the bus decides) if the
device_type->supports_location is true.

One of my primary considerations was also that the existing UAPI for
the USB's "removable" attribute shouldn't be changed. Currently, it
exists for all USB devices, so I think the current code / check is OK.

>
> [...]
> > +enum device_removable {
> > +     DEVICE_REMOVABLE_UNKNOWN =3D 0,
> > +     DEVICE_REMOVABLE,
> > +     DEVICE_FIXED,
> > +};
>
> I know this was moved from the USB core, but I personally find it
> a little bit awkward to read, would something like that be acceptable?
>
> enum device_removable {
>         DEVICE_STATE_UNKNOWN =3D 0,
>         DEVICE_STATE_REMOVABLE,
>         DEVICE_STATE_FIXED,
> };
>
> The addition of state to the name follows the removable_show() function
> where the local variable is called "state", and I think it makes sense
> to call this as such.  What do you think?

I think I made a mistake by using the "state" as the local variable
there. I will change it to "location". I'm happy to change the enums
above to DEVICE_LOCATION_REMOVABLE* etc if there is a wider consensus
on this. IMHO, the current shorter one also looks OK.

>
> > +static inline bool dev_is_removable(struct device *dev)
> > +{
> > +     return dev && dev->type && dev->type->supports_removable
> > +         && dev->removable =3D=3D DEVICE_REMOVABLE;
> > +}
>
> Similarly to my question about - would a simple check to see if
> "dev->removable" is set to "DEVICE_REMOVABLE" here be enough?

No, as I mentioned above, the dev->removable field should be
considered meaningful only if device_type->supports_location is true.
So the check for supports_removable is needed here.

Please feel free to send me more thoughts.

Thanks & Best Regards,

Rajat


>
> Krzysztof
