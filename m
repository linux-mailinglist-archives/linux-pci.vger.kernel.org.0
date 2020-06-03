Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 550CB1ED05F
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jun 2020 14:58:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726021AbgFCM5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jun 2020 08:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgFCM5n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 3 Jun 2020 08:57:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76A28C08C5C0
        for <linux-pci@vger.kernel.org>; Wed,  3 Jun 2020 05:57:41 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id r125so1225170lff.13
        for <linux-pci@vger.kernel.org>; Wed, 03 Jun 2020 05:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dCxVfxCrSSvJ1heapBVBhtwf6LbvPjf1sTBIQx1UBaM=;
        b=IQUmjbdCDziM8wOcD5JwWxDWgCqYExkvwyTsNu4BaU5djWrB/6LZr5jocRhVSLt02u
         ss6vOIas9V/vMnYoRwNZWxX17OjcnTaCHJSzWAGCMJ1tQyHXIHTSkI8pdZro2Vs9TmJC
         ddhvuSG85jXvqykzYV+OyrsGIdePfWkqlTfXGyRNP6AFeBK9SU/UNOvMV7wNe2sxGHsZ
         FIo8hcWOjb6p6VYSWTrzkAs2akFq73RT+1iU82MqyvzCXaX8iOXTVh4iHFUQX9iKP67M
         iJVBizLXZ1bDRIRgaNJoBrUvn1yF+74hPocpaLC9OEuyqj/G7HX/WFTGEC5PkKEt90qF
         IGbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dCxVfxCrSSvJ1heapBVBhtwf6LbvPjf1sTBIQx1UBaM=;
        b=a1BQly+h8RPlVF4NU+umAinHVJGt9CDvg617WQQhVB5HewiViAZH7l6ZH/W5KsukI3
         xGCLc2iB41d1DzsuUfCR8sEogzEkB6Cd3ViFoIBN7MPGbzuILGsZ2aXhBoS3OuWoVhnY
         riifYzRAHio03MRz0R/SQ46xlnpfsZ+SB6XIw/kk3mKyRS7/Bc50SOPdOp6uYSGI/wcv
         SN9IsK2A+LibNTXrsL2trbvp4/Sh+xjtnh6V8MxZNuEtwja2G4f6o+szagIFxum29Z5z
         uRfsw1PMglF3Bgp+aW2nZDrCTRziFr5L0DS9IAOkGOmN10nMkbFKOMZmaOnzHH6ewe0H
         jL2Q==
X-Gm-Message-State: AOAM530CNuJNj0dUVvrARO/gkvgW25YIg8Z3J+E6QbOAZN+JfWx32qRB
        kBpNxr5r+SOiMWT6ApeVPE2012jwt0iQ/c1N8dHfTQ==
X-Google-Smtp-Source: ABdhPJzB+kUOYneJzg/WXbkmONQu6HxudYdBz/co21M/29F544KJW1AnlEw+zmhPMZGik7mL4D5BzVGhcIEOFgkmtH8=
X-Received: by 2002:ac2:5473:: with SMTP id e19mr2412645lfn.21.1591189059461;
 Wed, 03 Jun 2020 05:57:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F3jE-aE+N7hArV3iye+9c-COwbi3qPkRPxfrCnccnqrw@mail.gmail.com>
 <20200601232542.GA473883@bjorn-Precision-5520> <20200602050626.GA2174820@kroah.com>
 <CAA93t1puWzFx=1h0xkZEkpzPJJbBAF7ONL_wicSGxHjq7KL+WA@mail.gmail.com>
 <20200603060751.GA465970@kroah.com> <CACK8Z6EXDf2vUuJbKm18R6HovwUZia4y_qUrTW8ZW+8LA2+RgA@mail.gmail.com>
 <20200603121613.GA1488883@kroah.com>
In-Reply-To: <20200603121613.GA1488883@kroah.com>
From:   Rajat Jain <rajatja@google.com>
Date:   Wed, 3 Jun 2020 05:57:02 -0700
Message-ID: <CACK8Z6EzYxh8WS8h8y6WdF8PnwUixQvFy6JASuzJ_tRsVfu5Fw@mail.gmail.com>
Subject: Re: [RFC] Restrict the untrusted devices, to bind to only a set of
 "whitelisted" drivers
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rajat Jain <rajatxjain@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
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

Hi Greg,

Thanks for looking into this thread.

On Wed, Jun 3, 2020 at 5:16 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jun 03, 2020 at 04:51:18AM -0700, Rajat Jain wrote:
> > Hello,
> >
> > >
> > > > Thanks for the pointer! I'm still looking at the details yet, but a
> > > > quick look (usb_dev_authorized()) seems to suggest that this API is
> > > > "device based". The multiple levels of "authorized" seem to take shape
> > > > from either how it is wired or from userspace choice. Once authorized,
> > > > USB device or interface is authorized to be used by *anyone* (can be
> > > > attached to any drivers). Do I understand it right that it does not
> > > > differentiate between drivers?
> > >
> > > Yes, and that is what you should do, don't fixate on drivers.  Users
> > > know how to control and manage devices.  Us kernel developers are
> > > responsible for writing solid drivers and getting them merged into the
> > > kernel tree and maintaining them over time.  Drivers in the kernel
> > > should always be trusted, ...
> >
> > 1) Yes, I agree that this would be ideal, and this should be our
> > mission. I should clarify that I may have used the wrong term
> > "Trusted/Certified drivers". I didn't really mean that the drivers may
> > be malicious by intent. What I really meant is that a driver may have
> > an attack surface, which is a vulnerability that may be exploited.
>
> Any code has such a thing, proving otherwise is a tough problem :)
>
> > Realistically speaking, finding vulnerabilities in drivers, creating
> > attacks to exploit them, and fixing them is a never ending cat and
> > mouse game. At Least "identifying the vulnerabilities" part is better
> > performed by security folks rather than driver writers.
>
> Are you sure about that?  It's hard to prove a negative :)
>
> > Earlier in the
> > thread I had mentioned certain studies/projects that identified and
> > exploited such vulnerabilities in the drivers. I should have used the
> > term "Vetted Drivers" maybe to convey the intent better - drivers that
> > have been vetted by a security focussed team (admin). What I'm
> > advocating here is an administrator's right to control the drivers
> > that he wants to allow for external ports on his systems.
>
> That's an odd thing, but sure, if you want to write up such a policy for
> your systems, great.  But that policy does not belong in the kernel, it
> belongs in userspace.

Agree.

>
> > 2) In addition to the problem of driver negligences / vulnerabilities
> > to be exploited, we ran into another problem with the "whitelist
> > devices only" approach. We did start with the "device based" approach
> > only initially - but quickly realized that anything we use to
> > whitelist an external device can only be based on the info provided by
> > *that device* itself. So until we have devices that exchange
> > certificates with kernel [1], it is easy for a malicious device to
> > spoof a whitelisted device (by presenting the same VID:DID or any
> > other data that is used by us to whitelist it).
> >
> > [1] https://www.intel.com/content/www/us/en/io/pci-express/pcie-device-security-enhancements-spec.html
> >
> > I hope that helps somewhat clarify how / why we reached here?
>
> Kind of, I still think all you need to do is worry about controlling the
> devices and if a driver should bind to it or not.

Agree. That is precisely what this RFC had in mind: (1) controlling
whether a device is authorized and if so (2) What drivers can bind to
it.

>  Again, much like USB
> has been doing for a very long time now.  The idea of "spoofing" ids
> also is not new, and has been around for a very long time as well, and
> again, the controls that the USB core gives you allows you to make any
> type of policy decision you want to, in userspace.
>
> So please, in summary:
>         - don't think this is some new type of thing, it's an old issue
>           transferred to yet-another-hardware-bus.  Not to say this is
>           not important, just please look at the work that others have
>           done in the past to help mitigate and solve this (reading the
>           Wireless USB spec should help you out here too, as they
>           detailed all of this.)
>         - do copy what USB did, by moving that logic into the driver
>           core so that all busses who want to take advantage of this
>           type of functionality, easily can do so.

Understood, will keep that in mind. I may first present a "PCI
subsystem only" draft just to get a feel for it, since that is more
familiar to me and also already has some bits and pieces we need for
this.

Thanks & Best Regards,

Rajat

>
> thanks,
>
> greg k-h
