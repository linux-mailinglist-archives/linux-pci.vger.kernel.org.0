Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8B1F5C4A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jun 2020 21:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbgFJT5O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Jun 2020 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgFJT5N (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Jun 2020 15:57:13 -0400
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com [IPv6:2607:f8b0:4864:20::f43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B619C03E96B;
        Wed, 10 Jun 2020 12:57:13 -0700 (PDT)
Received: by mail-qv1-xf43.google.com with SMTP id r16so1629392qvm.6;
        Wed, 10 Jun 2020 12:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=e7DTymW0dlvUI6UcJcAeZHCURN97Q9zDso/sHlDXRNA=;
        b=UlN/C4YYYCXVSwrKjjY3uOG/wP63W4GdE1l5KDxKe8xiggNNm3xqvFGL1N44md5YZ3
         VDoCVM46iPmYU8mpemi+nbgUZcUkSqcX9UhF613wB5Dc4ooVEWBmxwKh/nY2Nh2LxKTO
         +RGatdPg5pWR4DsAUaN6NAlJCi1CSFPtQxcvwu/xjAEhsCZQEz9RLeeP2fJxh0EBqhGB
         +kdiyWBeQoDR/PHlV62/5sW+ECZc29FlXzwA6HZ6zsm052EyOd0M+IxJtSgJGxf6lAmY
         lvYyXgBsMdZAm5Dirf2hxBmO6X2rkG5BWZ++xB1Ur6VG2KGpfVVmwvQp7bGTgGAqXoYA
         /hFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=e7DTymW0dlvUI6UcJcAeZHCURN97Q9zDso/sHlDXRNA=;
        b=nq43tVZjOyvOxhQe+9rg++T1R51PCLx0kHXZa4aylhiGvpTtiiAY0/pNpT4BOlPNqp
         Yz9Ue8NTACSKeD5u2l8wysQOvie9qeavnTNqmnWGt8rZsN+9Jc0cXLxSN+VdkNMewTHK
         33XZOJPvnSYVORwXWM9MORnwFBZ41nqhyjO7a+8PsquBpyAMHPknkaCmBp5ZvJgR8X8c
         r1YQWcmKHOop2kazLzcEKQ8bqOc+6HPBpNLjYU39lYsrHzSYZdcMwE7w3Vlf9x/Ttxn0
         yDuOlxp5iPbAuektjQKo4gpt3x2QV5YW8jJGOP3b4ydiC/c2LxpjBod37hnskja1JQcv
         KxlQ==
X-Gm-Message-State: AOAM533KhHC5EpTklGl9TZxcBIIVNSp496gXhSEZeu06KR0a2DjtL80M
        8I156piwxcf1rMNHR/+b0CEYME8xqP7iDJ3V9WzBd54mdOU=
X-Google-Smtp-Source: ABdhPJysrd/Lk7ZFl9lvvRPWP6l9wx2xRBJWOVf6T/AKiULdAUcsa+SId5libD1DvTqTsaPkNdCuToAw+q/94pXF54w=
X-Received: by 2002:ad4:4627:: with SMTP id x7mr3830646qvv.54.1591819032442;
 Wed, 10 Jun 2020 12:57:12 -0700 (PDT)
MIME-Version: 1.0
References: <20200607113632.GA49147@kroah.com> <20200609210400.GA1461839@bjorn-Precision-5520>
 <CAOSf1CGMwHGSn18MeKYr2BESfLwq3Q8_0fC6yhiQRrAXeSosqQ@mail.gmail.com>
In-Reply-To: <CAOSf1CGMwHGSn18MeKYr2BESfLwq3Q8_0fC6yhiQRrAXeSosqQ@mail.gmail.com>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Wed, 10 Jun 2020 12:57:00 -0700
Message-ID: <CAA93t1r37y-Shr+-oHoBoLSbE1vAguwdE2ak2F6L4Ecm5+3JKQ@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     "Oliver O'Halloran" <oohall@gmail.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Jain <rajatja@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Zubin Mithra <zsm@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 9, 2020 at 6:34 PM Oliver O'Halloran <oohall@gmail.com> wrote:
>
> On Wed, Jun 10, 2020 at 7:04 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > To sketch this out, my understanding of how this would work is:
> >
> >   - Expose the PCI pdev->untrusted bit in sysfs.  We don't expose this
> >     today, but doing so would be trivial.  I think I would prefer a
> >     sysfs name like "external" so it's more descriptive and less of a
> >     judgment.
> >
> >     This comes from either the DT "external-facing" property or the
> >     ACPI "ExternalFacingPort" property.
>
> I don't think internal / external is the right distinction to be
> making. We have a similar trust issue with the BMC in servers even
> though they're internal devices. They're typically network accessible
> and infrequently updated so treating them as trustworthy isn't a great
> idea. We have been slowly de-privileging the BMC over the last few
> years, but the PCIe interface isn't locked down enough for my liking
> since the SoCs we use do allow software to set the VDID and perform
> arbitrary DMAs (thankfully limited to 32bit). If we're going to add in
> infrastructure for handling possibly untrustworthy PCI devices then
> I'd like to use that for BMCs too.
>
> >   - All devices present at boot are enumerated.  Any statically built
> >     drivers will bind to them before any userspace code runs.
> >
> >     If you want to keep statically built drivers from binding, you'd
> >     need to invent some mechanism so pci_driver_init() could clear
> >     drivers_autoprobe after registering pci_bus_type.
> >
> >   - Early userspace code prevents modular drivers from automatically
> >     binding to PCI devices:
> >
> >       echo 0 > /sys/bus/pci/drivers_autoprobe
> >
> >     This prevents modular drivers from binding to all devices, whether
> >     present at boot or hot-added.
>
> I don't see why this is preferable to just disabling autoprobe for
> untrusted devices. That would dovetail nicely with Rajat's whitelist
> idea if we want to go down that route and I think we might want to.
> The BMC usually provides some form of VGA console and we'd like that
> to continue working out-of-the-box without too much user (or distro)
> intervention.

I wouldn't mind introducing a kernel parameter to disable auto-probing
of untrusted devices if there is a wider agreement here.
The only notch is that in my opinion, if present, that parameter
should disable auto-probing for "external" devices only (i.e.
"external-facing" devices should still be auto-probed).

Thanks,

Rajat

>
> Oliver
