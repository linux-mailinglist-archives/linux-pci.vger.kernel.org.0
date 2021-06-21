Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D38A3AF62F
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jun 2021 21:33:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFUTfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 15:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbhFUTfZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 15:35:25 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD499C061574;
        Mon, 21 Jun 2021 12:33:10 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id x21-20020a17090aa395b029016e25313bfcso668555pjp.2;
        Mon, 21 Jun 2021 12:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9LziRyqrNgKF/SJRQo0FBh+YflGxcn2NbuYHi3dgeo0=;
        b=KSaQprJvkgBw9WmwAZuufcTpuejwPMEyYfGHuijPyB/LTdSmGS9RzYZTR8CddgPfuj
         JUATOxsUuNzXZFy4O3M0S0cBOgWS1nLcGU3v7E5UX54dZxqHC6n8lTk4mF4GeT5lUw//
         RrSR72YZOT2/+jXNp57c5orTrv0G+wXqpgKlf4AkGnexWFT6dZxGSaTXIoyap4+/sh/q
         /n0z4EFbBy9vHzEXjhUZzR+1OY3gVQP79K6mutW56ioUyLStU3yG/uRPjZy4PPQDO4OM
         tKvFBrn8KQ+iLLVoiwAYTMbuhS6YlSsCzttaG9o9sVDnKHtRZqhtdItZzmV1t201Qyzj
         q/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9LziRyqrNgKF/SJRQo0FBh+YflGxcn2NbuYHi3dgeo0=;
        b=dVS8Y6AyqoHV4kJryZLVJWer3LNJlKDFWuRwkFuk0PCVNpQk/Jx5sG80rnE9zvvqoI
         nY14MsIL4Q5mp4+txho6am2xe8fJNikELb2Qxh/ripngwu7+mt50E5uZKbyr1F4hFH6j
         BJQeTnXSfU9du6fR0PJ6HV/tOljg58Wx3EJmfXdpxsS2sNT2XGkLQJqI/Sz5FhnA+c3b
         nnXi2tBMuZY6RKLaRvdLSodRidLHkv3GISudOsVU4Swoz4l0le8AKAqncAaXl9PV4A2g
         Pyk2H8IL7eg0VcnUH0GDsN20/51VED6v0WFJvLZH9FdKJVphp2GHVxXln5DmgSh04hWn
         gZqQ==
X-Gm-Message-State: AOAM533tTgXzypFFI/JgsI99fdXbstms8abSK6pe8cAgTL5dQGbaKZEv
        zYs3jrIxly9HkkUcmfRc09A=
X-Google-Smtp-Source: ABdhPJxuwOk22Ju5jiC4MfLYT7X/KEpDj7GR6Dlhp6xbnbfoZFaRMMIX4+r9FN6ShzefForaiOgLRw==
X-Received: by 2002:a17:902:d909:b029:11d:65e5:ac34 with SMTP id c9-20020a170902d909b029011d65e5ac34mr19511590plz.83.1624303990303;
        Mon, 21 Jun 2021 12:33:10 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id i3sm3221808pgc.92.2021.06.21.12.33.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 12:33:09 -0700 (PDT)
Date:   Tue, 22 Jun 2021 01:03:07 +0530
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
Message-ID: <20210621193307.gt7iwwg6gqqojhfc@archlinux>
References: <20210621172854.3ycsprg2wwx45xgm@archlinux>
 <20210621190705.GA3292470@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621190705.GA3292470@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/21 02:07PM, Bjorn Helgaas wrote:
> On Mon, Jun 21, 2021 at 10:58:54PM +0530, Amey Narkhede wrote:
> > On 21/06/21 08:01AM, Bjorn Helgaas wrote:
> > > On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > > > On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > > > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > > > Add reset_method sysfs attribute to enable user to
> > > > > > query and set user preferred device reset methods and
> > > > > > their ordering.
> > >
> > > > > > +	if (sysfs_streq(options, "default")) {
> > > > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > > > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > > > > +		goto set_reset_methods;
> > > > > > +	}
> > > > >
> > > > > If you use pci_init_reset_methods() here, you can also get this case
> > > > > out of the way early.
> > > > >
> > > > The problem with alternate encoding is we won't be able to know if
> > > > one of the reset methods was disabled previously. For example,
> > > >
> > > > # cat reset_methods
> > > > flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> > > > # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> > > > # cat reset_methods
> > > > bus
> > > >
> > > > Now if an user wants to enable flr
> > > >
> > > > # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> > > > OR
> > > > # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> > > >
> > > > either they need to write "default" first then flr or we will need to
> > > > reprobe reset methods each time when user writes to reset_method attribute.
> > >
> > > Not sure I completely understand the problem here.  I think relying on
> > > previous state that is invisible to the user is a little problematic
> > > because it's hard for the user to predict what will happen.
> > >
> > > If the user enables a method that was previously "disabled" because
> > > the probe failed, won't the reset method itself just fail with
> > > -ENOTTY?  Is that a problem?
> > >
> > I think I didn't explain this correctly. With current implementation
> > its not necessary to explicitly set *order of availabe* reset methods.
> > User can directly write a single supported reset method only and then perform
> > the reset. Side effect of that is other methods are disabled if user
> > writes single or less than available number of supported reset method.
> > Current implementation is able to handle this case but with new encoding
> > we'll need to reprobe reset methods everytime because we have no way
> > of distingushing supported and currently enabled reset method.
>
> I'm confused.  I thought the point of the nested loops to find the
> highest priority enabled reset method was to allow the user to control
> the order.  The sysfs doc says writing "reset_method" sets the "reset
> methods and their ordering."
>
> It seems complicated to track "supported" and "enabled" separately,
> and I don't know what the benefit is.  If we write "reset_method" to
> enable reset X, can we just probe reset X to see if it's supported?
>
> Bjorn
Although final result is same whether user writes a supported reset method or
their ordering that is,
# echo bus > reset_methods
and
# echo bus,flr > reset_methods

are the same but in the first version, users don't have to explicitly
set the ordering if they just want to perform bus reset.
Current implementation allows the flexibility for switching between
first and second option.

Does this address your doubt?

Thanks,
Amey
