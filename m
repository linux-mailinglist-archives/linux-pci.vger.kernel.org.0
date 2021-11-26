Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73B3745F151
	for <lists+linux-pci@lfdr.de>; Fri, 26 Nov 2021 17:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbhKZQLn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 11:11:43 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:58338 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349878AbhKZQJm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 11:09:42 -0500
X-Greylist: delayed 689 seconds by postgrey-1.27 at vger.kernel.org; Fri, 26 Nov 2021 11:09:42 EST
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 31F8D622BD;
        Fri, 26 Nov 2021 15:55:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F053AC93056;
        Fri, 26 Nov 2021 15:54:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1637942099;
        bh=hZFOAgiJVQnfmrgUwan3LR/PjCNrPklpuClliU9Y9Zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wDPU0xZ7KgwIlai6F/wOHWFHR58Y0icz2RZy4QzfUrVrX9kfnL5VrlT/bjzGT21hp
         /egLvX0QNmUOTXtfs2eTLRZ9Zc1hmKrCl+QHJF/ruMoFeCXbMNpaGAF/LiryBUlKp/
         iA1whC0nAvd8PxM+H5om8H/9z75MSItduLWPrR/8=
Date:   Fri, 26 Nov 2021 16:54:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] device property: Remove device_add_properties()
Message-ID: <YaEDUA+I3GstUoUQ@kroah.com>
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jsWVw4OyVbkdn2374tLAXAShZ_B3CKDmnQOE_QEXXPiQ@mail.gmail.com>
 <YZ5JDhOnDw+qqzJP@kuha.fi.intel.com>
 <CAJZ5v0iVTGbgdU5Ux992fYim8zpV_GstJhYMLStr7YcQNWFPyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0iVTGbgdU5Ux992fYim8zpV_GstJhYMLStr7YcQNWFPyQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 03:30:53PM +0100, Rafael J. Wysocki wrote:
> On Wed, Nov 24, 2021 at 3:15 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > On Wed, Nov 24, 2021 at 02:59:01PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Nov 15, 2021 at 1:10 PM Heikki Krogerus
> > > <heikki.krogerus@linux.intel.com> wrote:
> > > >
> > > > Hi,
> > > >
> > > > One more version. Hopefully the commit messages are now OK. No other
> > > > changes since v3:
> > > >
> > > > https://lore.kernel.org/lkml/20211006112643.77684-1-heikki.krogerus@linux.intel.com/
> > > >
> > > >
> > > > v3 cover letter:
> > > >
> > > > In this third version of this series, the second patch is now split in
> > > > two. The device_remove_properties() call is first removed from
> > > > device_del() in its own patch, and the
> > > > device_add/remove_properties() API is removed separately in the last
> > > > patch. I hope the commit messages are clear enough this time.
> > > >
> > > >
> > > > v2 cover letter:
> > > >
> > > > This is the second version where I only modified the commit message of
> > > > the first patch according to comments from Bjorn.
> > > >
> > > >
> > > > Original cover letter:
> > > >
> > > > There is one user left for the API, so converting that to use software
> > > > node API instead, and removing the function.
> > > >
> > > >
> > > > thanks,
> > > >
> > > > Heikki Krogerus (3):
> > > >   PCI: Convert to device_create_managed_software_node()
> > > >   driver core: Don't call device_remove_properties() from device_del()
> > > >   device property: Remove device_add_properties() API
> > > >
> > > >  drivers/base/core.c      |  1 -
> > > >  drivers/base/property.c  | 48 ----------------------------------------
> > > >  drivers/pci/quirks.c     |  2 +-
> > > >  include/linux/property.h |  4 ----
> > > >  4 files changed, 1 insertion(+), 54 deletions(-)
> > >
> > > Has this been picked up already or am I expected to pick it up?
> >
> > It hasn't been picked up by anybody, so if you can take these, that
> > would be great.
> 
> OK, applied as 5.17 material now.
> 
> Greg, please let me know if you'd rather take these patches yourself
> and I'll drop them in that case.

No problem, you can take them, thanks!

greg k-h
