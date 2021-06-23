Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6CE3B1FF3
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jun 2021 19:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbhFWR7C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Jun 2021 13:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229726AbhFWR7B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 23 Jun 2021 13:59:01 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E511C061574;
        Wed, 23 Jun 2021 10:56:44 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id g4so1968958pjk.0;
        Wed, 23 Jun 2021 10:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DwIfz4asrkwuxmRED1rKoCWobK2Fs+gtJGcm4ugHhII=;
        b=PHqpv/vNsxYvJHoQSOgvoOhS2E+KYn3GN3ju0fpcgknzl1CoZUxMDbGHy+R0QS7sbJ
         GvxL0GhIO2pdxKiKSPZ7bg+7vs3eqR8Fo2PJARXdK60ONkH7y9ZYub7eGaf0vAbAJl8f
         SS8igeh3Nxx1iiulRk1RF0TYCYWlZDoS+QaMdEJgcnLp6cj5GMLaMQO8oqpNDeE4Zkn7
         geSe4mKXZ5JvhH6wkr6npq556Cio4UiQDbjItlGC3FvsbSkA3vW35SDMXtz1q5/PZZ1H
         fer/NIKB83NX39zc4A9BawKRCAJXPTWSloy33/YnEKNKHkDjqjm/Zdtmi9Sm+zhgQiS9
         elzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DwIfz4asrkwuxmRED1rKoCWobK2Fs+gtJGcm4ugHhII=;
        b=D4sSYaDHMT6Yqvh20k+9WPp9AcQM91vARl99LsviHtBcns3knZqoRsPcK+qcqyuXrN
         LqnHdzBjE26UgnhXVuJv7jd1VjGQad3mQRhposfKzFRk63vqE6hIDWtx5pMEzHnGA46Y
         qwnb058Z3L+pjk2eUMAUqRfX9MOXhhLxOybT5UUbcwWDwb/8STgkUjL5qGeMWVwEleBy
         tbWtehQsV1unR+NzUUmmVNIpOdoC+VDz56Z2PxbOOZX5DuD+8AVPaX/MTyupT5PiLFMN
         1zwO4TQhM93WcVZ/bcqZdReF5/4Ahb/BCu3UxYFG7nBgXg4H5Q8hSRxXClObJ4OAXCeX
         sCTQ==
X-Gm-Message-State: AOAM530WK2UlEzX9pewqqDIcJVjbGmjfZIuOuoksAVF6fNyhhu/LBdad
        dWVKqNhY2N9fbfpiPapnafQ=
X-Google-Smtp-Source: ABdhPJw0z77xCN6a0ourMoOmBDy05HNNfjyZ/s97855wAhkT9/fPiX2al4ZePASUYQkPMvC1DvTZUQ==
X-Received: by 2002:a17:90a:d102:: with SMTP id l2mr866909pju.225.1624471003738;
        Wed, 23 Jun 2021 10:56:43 -0700 (PDT)
Received: from localhost ([103.248.31.165])
        by smtp.gmail.com with ESMTPSA id i20sm480012pfo.130.2021.06.23.10.56.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:56:43 -0700 (PDT)
Date:   Wed, 23 Jun 2021 23:26:41 +0530
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
Message-ID: <20210623175641.obsq2w2vlsppmyna@archlinux>
References: <20210621193307.gt7iwwg6gqqojhfc@archlinux>
 <20210623120623.GA3295394@bjorn-Precision-5520>
 <20210623140711.ur67lbbrsudgxrp4@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210623140711.ur67lbbrsudgxrp4@archlinux>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21/06/23 07:37PM, Amey Narkhede wrote:
> On 21/06/23 07:06AM, Bjorn Helgaas wrote:
> > On Tue, Jun 22, 2021 at 01:03:07AM +0530, Amey Narkhede wrote:
> > > On 21/06/21 02:07PM, Bjorn Helgaas wrote:
> > > > On Mon, Jun 21, 2021 at 10:58:54PM +0530, Amey Narkhede wrote:
> > > > > On 21/06/21 08:01AM, Bjorn Helgaas wrote:
> > > > > > On Sat, Jun 19, 2021 at 07:29:20PM +0530, Amey Narkhede wrote:
> > > > > > > On 21/06/18 03:00PM, Bjorn Helgaas wrote:
> > > > > > > > On Tue, Jun 08, 2021 at 11:18:53AM +0530, Amey Narkhede wrote:
> > > > > > > > > Add reset_method sysfs attribute to enable user to
> > > > > > > > > query and set user preferred device reset methods and
> > > > > > > > > their ordering.
> > > > > >
> > > > > > > > > +	if (sysfs_streq(options, "default")) {
> > > > > > > > > +		for (i = 0; i < PCI_RESET_METHODS_NUM; i++)
> > > > > > > > > +			reset_methods[i] = reset_methods[i] ? prio-- : 0;
> > > > > > > > > +		goto set_reset_methods;
> > > > > > > > > +	}
> > > > > > > >
> > > > > > > > If you use pci_init_reset_methods() here, you can also get this case
> > > > > > > > out of the way early.
> > > > > > > >
> > > > > > > The problem with alternate encoding is we won't be able to know if
> > > > > > > one of the reset methods was disabled previously. For example,
> > > > > > >
> > > > > > > # cat reset_methods
> > > > > > > flr,bus 			# dev->reset_methods = [3, 5, 0, ...]
> > > > > > > # echo bus > reset_methods 	# dev->reset_methods = [5, 0, 0, ...]
> > > > > > > # cat reset_methods
> > > > > > > bus
> > > > > > >
> > > > > > > Now if an user wants to enable flr
> > > > > > >
> > > > > > > # echo flr > reset_methods 	# dev->reset_methods = [3, 0, 0, ...]
> > > > > > > OR
> > > > > > > # echo bus,flr > reset_methods 	# dev->reset_methods = [5, 3, 0, ...]
> > > > > > >
> > > > > > > either they need to write "default" first then flr or we will need to
> > > > > > > reprobe reset methods each time when user writes to reset_method attribute.
> > > > > >
> > > > > > Not sure I completely understand the problem here.  I think relying on
> > > > > > previous state that is invisible to the user is a little problematic
> > > > > > because it's hard for the user to predict what will happen.
> > > > > >
> > > > > > If the user enables a method that was previously "disabled" because
> > > > > > the probe failed, won't the reset method itself just fail with
> > > > > > -ENOTTY?  Is that a problem?
> > > > > >
> > > > > I think I didn't explain this correctly. With current implementation
> > > > > its not necessary to explicitly set *order of availabe* reset methods.
> > > > > User can directly write a single supported reset method only and then perform
> > > > > the reset. Side effect of that is other methods are disabled if user
> > > > > writes single or less than available number of supported reset method.
> > > > > Current implementation is able to handle this case but with new encoding
> > > > > we'll need to reprobe reset methods everytime because we have no way
> > > > > of distingushing supported and currently enabled reset method.
> > > >
> > > > I'm confused.  I thought the point of the nested loops to find the
> > > > highest priority enabled reset method was to allow the user to control
> > > > the order.  The sysfs doc says writing "reset_method" sets the "reset
> > > > methods and their ordering."
> > > >
> > > > It seems complicated to track "supported" and "enabled" separately,
> > > > and I don't know what the benefit is.  If we write "reset_method" to
> > > > enable reset X, can we just probe reset X to see if it's supported?
> > >
> > > Although final result is same whether user writes a supported reset method or
> > > their ordering that is,
> > > # echo bus > reset_methods
> > > and
> > > # echo bus,flr > reset_methods
> > >
> > > are the same but in the first version, users don't have to explicitly
> > > set the ordering if they just want to perform bus reset.
> > > Current implementation allows the flexibility for switching between
> > > first and second option.
> >
> > Sorry, I can't quite make sense of the above.
> >
> > Your doc implies the following are different:
> >
> >   # echo bus,flr > reset_methods
> >   # echo flr,bus > reset_methods
> >
> > Are they?  If you don't need to provide control over the order of
> > trying resets, this can all be simplified quite a bit.
> >
> > Bjorn
> The v1 of the patch series allowed only single reset method to be
> written instead of ordering of all supported reset methods.
> With your example, current implementation allows both writing single
> value and list of supported reset methods.
>
> # echo bus > reset_methods
> and
> # echo bus,flr > reset_methods
>
> OR
>
> # echo flr > reset_methods
> and
> echo flr,bus > reset_methods
>
# echo flr,bus and echo bus,flr are different.

> Its more of a preference than a functional point. Ultimately the
> __pci_reset_function_locked() function will only perform 'bus' reset in
> this example because we make sure 'reset_methods' file only contains
> valid device supported reset methods all the time so
> __pci_reset_function_locked() won't go into -ENOTTY case but with new
Oops I'm wrong here. __pci_reset_function_locked() can return -ENOTTY
and follow through if a reset fails.

Rest of the point should hold.
> encoding theres no way to make sure `reset_methods`sysfs attribute will
> contain valid supported reset methods all the time because of the reset
> methods can be masked implicitly if user uses first option of writing
> only single value.
>
> My point is current implementation allows more flexibility for the user.
>
> Thanks,
> Amey
