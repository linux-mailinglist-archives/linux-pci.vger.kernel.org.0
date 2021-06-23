Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3623B1C03
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 16:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbhFWOJg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 10:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbhFWOJe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 10:09:34 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E32B4C061574;
        Wed, 23 Jun 2021 07:07:15 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id e22so1861672pgv.10;
        Wed, 23 Jun 2021 07:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=soCohcC7CA1Ik7U//lEN/WZfU3/KME+fvdLQkdnU/gE=;
        b=F9PPdEjfhq2H4+x4fov8xKlD3i/yy0ejR9mzuG9OYPdbtU4IDAuBgLNbkXcGd66CtC
         JFHBQWbaJFn7VZgSPphNfvYHX79fMLEEweKaa9uKED01PGo0bdlho/h4CrCaKlDcThFi
         z9LeerzpylYhxBDS7KgeQl8pQbKsk8BQrq44wYHiDOK0Ow9gog59a/cj+ptviJTQU86W
         Z9iOo+iCJNy13jbsmvM4zD6P4YS+auJ4s74gFZGT9+OEQMDWIjQhnfpvmjibBUsGWY35
         ONq01WhAP/cReV7lbrpm+5OycaP7BdzPC1CDZWuRZBPV3Pbz0VOZ4B/m7Hlh0viTTWdO
         M9hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=soCohcC7CA1Ik7U//lEN/WZfU3/KME+fvdLQkdnU/gE=;
        b=FymO2rhwHucXQNfGwo+0JH1SnEs9nirv4w+4jGMFjKJRkYx6Kvj0Cu2xvxu0LeD/Bt
         s/KfhJiR3s0VZkxUAsC3XsBarJTYTS1DH5PfHR5aMyH49fpuTdP5697zUACfBY0XKMGG
         jc4Tce2mzS31T4nIwjaYxzfRIuUfdDJjdNjcxQGDzZqTbeNRWRE8Uttcka5IUto2DBaK
         EXOfTTizrVLkHtQMUr6C+6ODx5KWMQeRJCB2oM1K3KBmDuoeTsfgZJd8doRuyGTEn+ok
         lcPKTSDpTMhOCvJSRg8ubpTv7lsrSZVlHKt23TXN9vsY6wg1KN4CPlNIwhlZQ1dJiUIV
         H3sw==
X-Gm-Message-State: AOAM530mJ22V0MNcf+OxnkkKoZd5WmKkwewT51+66/5xndNOoPBi2jDp
        v5sPVpkRBNNWjJ/oe9so6a0=
X-Google-Smtp-Source: ABdhPJxxy7HaT33BNgmUVWVsi2Lfqbxonp35oAFv0OFaUXVqmHLU0pEzw+34ZPXKhq+dvDq6jSiWCA==
X-Received: by 2002:aa7:824a:0:b029:2ec:89ee:e798 with SMTP id e10-20020aa7824a0000b02902ec89eee798mr22454pfn.12.1624457235418;
        Wed, 23 Jun 2021 07:07:15 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id y66sm98392pgb.4.2021.06.23.07.07.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 07:07:15 -0700 (PDT)
Date:   Wed, 23 Jun 2021 19:37:11 +0530
From:   Amey Narkhede <ameynarkhede03@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     alex.williamson@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, Shanker Donthineni <sdonthineni@nvidia.com>,
        Sinan Kaya <okaya@kernel.org>, Len Brown <lenb@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v7 4/8] PCI/sysfs: Allow userspace to query and set
 device reset mechanism
Message-ID: <20210623140711.ur67lbbrsudgxrp4@archlinux>
References: <20210621193307.gt7iwwg6gqqojhfc@archlinux>
 <20210623120623.GA3295394@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623120623.GA3295394@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/23 07:06AM, Bjorn Helgaas wrote:
> On Tue, Jun 22, 2021 at 01:03:07AM +0530, Amey Narkhede wrote:
> > On 21/06/21 02:07PM, Bjorn Helgaas wrote:
> > > On Mon, Jun 21, 2021 at 10:58:54PM +0530, Amey Narkhede wrote:
> > > > On 21/06/21 08:01AM, Bjorn Helgaas wrote:
> > > > > On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > > > > > On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > > > > > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > > > > > Add reset_method sysfs attribute to enable user to
> > > > > > > > query and set user preferred device reset methods and
> > > > > > > > their ordering.
> > > > >
> > > > > > > > +	if (sysfs_streq(options, "default")) {
> > > > > > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > > > > > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > > > > > > +		goto set_reset_methods;
> > > > > > > > +	}
> > > > > > >
> > > > > > > If you use pci_init_reset_methods() here, you can also get this case
> > > > > > > out of the way early.
> > > > > > >
> > > > > > The problem with alternate encoding is we won't be able to know if
> > > > > > one of the reset methods was disabled previously. For example,
> > > > > >
> > > > > > # cat reset_methods
> > > > > > flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> > > > > > # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> > > > > > # cat reset_methods
> > > > > > bus
> > > > > >
> > > > > > Now if an user wants to enable flr
> > > > > >
> > > > > > # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> > > > > > OR
> > > > > > # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> > > > > >
> > > > > > either they need to write "default" first then flr or we will need to
> > > > > > reprobe reset methods each time when user writes to reset_method attribute.
> > > > >
> > > > > Not sure I completely understand the problem here.  I think relying on
> > > > > previous state that is invisible to the user is a little problematic
> > > > > because it's hard for the user to predict what will happen.
> > > > >
> > > > > If the user enables a method that was previously "disabled" because
> > > > > the probe failed, won't the reset method itself just fail with
> > > > > -ENOTTY?  Is that a problem?
> > > > >
> > > > I think I didn't explain this correctly. With current implementation
> > > > its not necessary to explicitly set *order of availabe* reset methods.
> > > > User can directly write a single supported reset method only and then perform
> > > > the reset. Side effect of that is other methods are disabled if user
> > > > writes single or less than available number of supported reset method.
> > > > Current implementation is able to handle this case but with new encoding
> > > > we'll need to reprobe reset methods everytime because we have no way
> > > > of distingushing supported and currently enabled reset method.
> > >
> > > I'm confused.  I thought the point of the nested loops to find the
> > > highest priority enabled reset method was to allow the user to control
> > > the order.  The sysfs doc says writing "reset_method" sets the "reset
> > > methods and their ordering."
> > >
> > > It seems complicated to track "supported" and "enabled" separately,
> > > and I don't know what the benefit is.  If we write "reset_method" to
> > > enable reset X, can we just probe reset X to see if it's supported?
> >
> > Although final result is same whether user writes a supported reset method or
> > their ordering that is,
> > # echo bus > reset_methods
> > and
> > # echo bus,flr > reset_methods
> >
> > are the same but in the first version, users don't have to explicitly
> > set the ordering if they just want to perform bus reset.
> > Current implementation allows the flexibility for switching between
> > first and second option.
>
> Sorry, I can't quite make sense of the above.
>
> Your doc implies the following are different:
>
>   # echo bus,flr > reset_methods
>   # echo flr,bus > reset_methods
>
> Are they?  If you don't need to provide control over the order of
> trying resets, this can all be simplified quite a bit.
>
> Bjorn
The v1 of the patch series allowed only single reset method to be
written instead of ordering of all supported reset methods.
With your example, current implementation allows both writing single
value and list of supported reset methods.

# echo bus > reset_methods
and
# echo bus,flr > reset_methods

OR

# echo flr > reset_methods
and
echo flr,bus > reset_methods

Its more of a preference than a functional point. Ultimately the
__pci_reset_function_locked() function will only perform 'bus' reset in
this example because we make sure 'reset_methods' file only contains
valid device supported reset methods all the time so
__pci_reset_function_locked() won't go into -ENOTTY case but with new
encoding theres no way to make sure `reset_methods`sysfs attribute will
contain valid supported reset methods all the time because of the reset
methods can be masked implicitly if user uses first option of writing
only single value.

My point is current implementation allows more flexibility for the user.

Thanks,
Amey
