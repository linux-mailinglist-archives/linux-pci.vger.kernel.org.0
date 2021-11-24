Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C369F45C718
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 15:18:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348792AbhKXOVS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 09:21:18 -0500
Received: from mga04.intel.com ([192.55.52.120]:58842 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1353502AbhKXOS4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 24 Nov 2021 09:18:56 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10177"; a="234009700"
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="234009700"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Nov 2021 06:15:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,260,1631602800"; 
   d="scan'208";a="650406325"
Received: from kuha.fi.intel.com ([10.237.72.166])
  by fmsmga001.fm.intel.com with SMTP; 24 Nov 2021 06:15:43 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Wed, 24 Nov 2021 16:15:42 +0200
Date:   Wed, 24 Nov 2021 16:15:42 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] device property: Remove device_add_properties()
Message-ID: <YZ5JDhOnDw+qqzJP@kuha.fi.intel.com>
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jsWVw4OyVbkdn2374tLAXAShZ_B3CKDmnQOE_QEXXPiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jsWVw4OyVbkdn2374tLAXAShZ_B3CKDmnQOE_QEXXPiQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 02:59:01PM +0100, Rafael J. Wysocki wrote:
> On Mon, Nov 15, 2021 at 1:10 PM Heikki Krogerus
> <heikki.krogerus@linux.intel.com> wrote:
> >
> > Hi,
> >
> > One more version. Hopefully the commit messages are now OK. No other
> > changes since v3:
> >
> > https://lore.kernel.org/lkml/20211006112643.77684-1-heikki.krogerus@linux.intel.com/
> >
> >
> > v3 cover letter:
> >
> > In this third version of this series, the second patch is now split in
> > two. The device_remove_properties() call is first removed from
> > device_del() in its own patch, and the
> > device_add/remove_properties() API is removed separately in the last
> > patch. I hope the commit messages are clear enough this time.
> >
> >
> > v2 cover letter:
> >
> > This is the second version where I only modified the commit message of
> > the first patch according to comments from Bjorn.
> >
> >
> > Original cover letter:
> >
> > There is one user left for the API, so converting that to use software
> > node API instead, and removing the function.
> >
> >
> > thanks,
> >
> > Heikki Krogerus (3):
> >   PCI: Convert to device_create_managed_software_node()
> >   driver core: Don't call device_remove_properties() from device_del()
> >   device property: Remove device_add_properties() API
> >
> >  drivers/base/core.c      |  1 -
> >  drivers/base/property.c  | 48 ----------------------------------------
> >  drivers/pci/quirks.c     |  2 +-
> >  include/linux/property.h |  4 ----
> >  4 files changed, 1 insertion(+), 54 deletions(-)
> 
> Has this been picked up already or am I expected to pick it up?

It hasn't been picked up by anybody, so if you can take these, that
would be great.

thanks,

-- 
heikki
