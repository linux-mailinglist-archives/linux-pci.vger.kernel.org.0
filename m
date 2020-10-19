Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E48292881
	for <lists+linux-pci@lfdr.de>; Mon, 19 Oct 2020 15:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbgJSNqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Oct 2020 09:46:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgJSNqp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Oct 2020 09:46:45 -0400
Received: from localhost (83-86-74-64.cable.dynamic.v4.ziggo.nl [83.86.74.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 114A422268;
        Mon, 19 Oct 2020 13:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603115204;
        bh=SSi7/lPpg93zvX4ef4Gp1/L433ZTE79+nFhtyAnpYqo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DZBTMBDM6CPqELhcRAiWDMeQ7qjrzt3GOhjPUl4tZ/47E/i/H4S2u1AFMWyIWTNR1
         5EIOBM/Zkyqha3VEy7KkL5cHyiHplelrtRv770wOW7+eCU7W7apAGTkgmxQ7k6yKjC
         /9uwYwfyIqpOGsYE0YOZfD0m9aiVNzkCandV4zto=
Date:   Mon, 19 Oct 2020 15:47:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Allen <allen.lkml@gmail.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        ast@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Allen Pais <apais@linux.microsoft.com>,
        Allen Pais <allen.pais@lkml.com>
Subject: Re: [RFC] PCI: allow sysfs file owner to read the config space with
 CAP_SYS_RAWIO
Message-ID: <20201019134729.GA3259788@kroah.com>
References: <20201016055235.440159-1-allen.lkml@gmail.com>
 <20201016062027.GB569795@kroah.com>
 <CAOMdWSJDJ-uXpis1WbG3LnOG7bMiif5Q4Maafv_a=55Y_qypfQ@mail.gmail.com>
 <20201019131613.GA3254417@kroah.com>
 <CAOMdWS+F=cCK=Rgy-0xk4_mqUFMn1PQBWR8u3JwqTP2AVifxsA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMdWS+F=cCK=Rgy-0xk4_mqUFMn1PQBWR8u3JwqTP2AVifxsA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 19, 2020 at 06:51:39PM +0530, Allen wrote:
> > > > >
> > > > >  Access to pci config space is explictly checked with CAP_SYS_ADMIN
> > > > > in order to read configuration space past the frist 64B.
> > > > >
> > > > >  Since the path is only for reading, could we use CAP_SYS_RAWIO?
> > > >
> > > > Why?  What needs this reduced capability?
> > >
> > > Thanks for the review.
> > >
> > > We need read access to /sys/bus/pci/devices/,  We need write access to config,
> > > remove, rescan & enable files under the device directory for each PCIe
> > > functions & the downstream PCIe port.
> > >
> > > We need r/w access to sysfs to unbind and rebind the root complex.
> >
> > That didn't answer my question at all.
> 
> Sorry about that, breaking it down:
> 
> When the machine first boots, the VFIO device bindings under /dev/vfio
> are not present.
> 
> root@localhost:/tmp# ls -l /dev/vfio/
> total 0
> crw-rw-rw-. 1 root root 10, 196 Jan  5 01:47 vfio
> 
> We have an agent which needs to run the following commands (We get
> access denied here and need permissions to do this).
> echo -n xxxx yyyy > /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id
> echo -n xxxx yyyy > /sys/module/vfio_pci/drivers/pci:vfio-pci/new_id
> 
> And we want to avoid handing CAP_SYS_ADMIN here. Which is why the
> thought about CAP_SYS_RAWIO.

But that is not what you were asking this patch to do at all.  So why
bring it up?

new_id is NOT for "raw io" control, that should be only for admin
priviliges.

And just because the vfio driver "abuses" this
traditionally-debug-functionality doesn't mean you get to abuse the
permission levels either.

> > Why can't you have the process that wants to do all of the above, have
> > admin rights as well?  Doing all of that is _very_ low-level and can
> > cause all sorts of horrible things to happen to your machine, and is not
> > really "raw io" in the traditional sense at all, right?
> 
> 
> If the above approach is going to cause the system to do horrible things,
> then I'll drop the idea.

Of course it can cause the system to do horrible things, try it yourself
and see!

greg k-h
