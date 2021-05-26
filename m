Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB43391074
	for <lists+linux-pci@lfdr.de>; Wed, 26 May 2021 08:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232773AbhEZGOW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 May 2021 02:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232734AbhEZGOW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 May 2021 02:14:22 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1926C061574;
        Tue, 25 May 2021 23:12:50 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id i13so39068592edb.9;
        Tue, 25 May 2021 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=KNeF+g461fpgxRYmnstS5ppuY31ZASI7tPk72C8x1S8=;
        b=XLV68V9RZEKeGyKoZniOprO0CbfyrfTH1jGuz5RV9RwK8Typ6UAwQSKaf9QSGcvgqn
         gNQaynmPm1hLsBetx0IPTIjxi8bl2UzUOtCQPBEFCGv3/MbD/2PappcTU8hBVZ91F0eM
         VQVkKQc1SZrJwl/Bnm/jO3z4anevu3pbt8jhP02neUkzqmuooN2j4gBQbh3dGVjqgw9G
         jXzw/Z4M6NkRPx+4f2DJYaJh0fgaqKdI4kwmgMiGmXookb6os/QjHJDFGoyWSD/ysDUF
         NJfWCH1jRtakxNpJ8OiMYfkEo0xvHLn781Ll770txxFsNQu1kIMRA90c2VevkU0g31p+
         7W5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=KNeF+g461fpgxRYmnstS5ppuY31ZASI7tPk72C8x1S8=;
        b=j3rT5UL/I9j6Lf9R2LVe8iX/sO+C6R9zuLbB+jdEDZHFfSIDRJki71bJaG67c+RxL/
         84RXXy6W+h9T2zEfbrLCqTHK2bfG2MjbDcdY97xH8u9W7gBjvQSB6japmZZ7AXUXho7w
         JzUBYKnIWcZs5AuMAnbyZ+mlIiSRAWgZoV0He/IMi2kMC577705YNy8zg0SXxy8/INGU
         1IXsGRJlGIGi9J27383YIZDc7L8Ly/sdORXsyEc96eJWKr1FeA5LyQg9x1xUloWFZqkz
         S/Fs35zgXMJORIhqYzS4KguHB1Uzk4sNnjoUwD7Y7PWVN5H6wlkf92a0zs8V/vq5A4Fx
         1yQA==
X-Gm-Message-State: AOAM530kZ6+yJXNRtg8BHzRkQmot9BYehTxkbZRQvPuUu8bpjeu/NoMF
        ZoNaKE7kxiU8OPrrRfYZMyiLAyrr69ZGDMbYWP8=
X-Google-Smtp-Source: ABdhPJyPC7GP/PR2PgqT7NE7/jQOMzBMFenlZAj725Ee+JP3nxSRZmJ6XlXWchjjVu5P8WFzmiFnPcFm+p92n7JeyEY=
X-Received: by 2002:a05:6402:5a:: with SMTP id f26mr35855254edu.306.1622009569417;
 Tue, 25 May 2021 23:12:49 -0700 (PDT)
MIME-Version: 1.0
References: <20210525125925.112306-1-lambert.q.wang@gmail.com> <20210525132035.GA66609@rocinante.localdomain>
In-Reply-To: <20210525132035.GA66609@rocinante.localdomain>
From:   Lambert Wang <lambert.q.wang@gmail.com>
Date:   Wed, 26 May 2021 14:12:38 +0800
Message-ID: <CAATamay8WTiJnB=5OLYdFTqVUcRF9LarN6_1Eej3QUgFzWRnkA@mail.gmail.com>
Subject: Re: [PATCH] pci: add pci_dev_is_alive API
To:     =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi  Krzysztof and Bjorn,

Thanks for your comments and your time.Your questions are answered inline.

I have checked and tested *pci_device_is_present* as pointed out by Bjorn.
I think that API could satisfy my needs.

So this patch request could be dropped. Sorry for the inconvenience.

On Tue, May 25, 2021 at 9:20 PM Krzysztof Wilczy=C5=84ski <kw@linux.com> wr=
ote:
>
> Hi Lambert,
>
> Thank you for sending the patch over!
>
> To match the style of other patches you'd need to capitalise "PCI" in
> the subject, see the following for some examples:
>
>  $ git log --oneline drivers/pci/pci.c
>
> Also, it might be worth mentioning in the subject that this is a new API
> that will be added.
>

I will be careful on the styles of patch title and description in my
future patches.

> > Device drivers use this API to proactively check if the device
> > is alive or not. It is helpful for some PCI devices to detect
> > surprise removal and do recovery when Hotplug function is disabled.
> >
> > Note: Device in power states larger than D0 is also treated not alive
> > by this function.
> [...]
>
> Question to you: do you have any particular users of this new API in
> mind?  Or is this solving some problem you've seen and/or reported via
> the kernel Bugzilla?
>

The user is our new PCI driver under development for WWAN devices .
Surprise removal could happen under multiple circumstances.
e.g. Exception, Link Failure, etc.

We wanted this API to detect surprise removal or check device recovery
when AER and Hotplug are disabled.

I thought the API could be commonly used for many similar devices.

> > +/**
> > + * pci_dev_is_alive - check the pci device is alive or not
> > + * @pdev: the PCI device
>
> That would be "PCI" in the function brief above.  Also, try to be
> consistent and capitalise everything plus add missing periods, see the
> following for an example on how to write kernel-doc:
>
>   https://www.kernel.org/doc/html/latest/doc-guide/kernel-doc.html#functi=
on-documentation
>
> > + * Device drivers use this API to proactively check if the device
> > + * is alive or not. It is helpful for some PCI devices to detect
> > + * surprise removal and do recovery when Hotplug function is disabled.
>
> As per my question above - what users of this new API do you have in
> mind?  Are they any other patches pending adding users of this API?
>
> > + * Note: Device in power state larger than D0 is also treated not aliv=
e
> > + * by this function.
> > + *
> > + * Returns true if the device is alive.
> > + */
> > +bool pci_dev_is_alive(struct pci_dev *pdev)
> > +{
> > +     u16 vendor;
> > +
> > +     pci_read_config_word(pdev, PCI_VENDOR_ID, &vendor);
> > +
> > +     return vendor =3D=3D pdev->vendor;
> > +}
> > +EXPORT_SYMBOL(pci_dev_is_alive);
>
> Why not use the EXPORT_SYMBOL_GPL()?
>
>         Krzysztof
