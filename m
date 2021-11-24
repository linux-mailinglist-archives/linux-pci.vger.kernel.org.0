Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD7945C761
	for <lists+linux-pci@lfdr.de>; Wed, 24 Nov 2021 15:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355281AbhKXOeT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Nov 2021 09:34:19 -0500
Received: from mail-ot1-f46.google.com ([209.85.210.46]:33767 "EHLO
        mail-ot1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355291AbhKXOeR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Nov 2021 09:34:17 -0500
Received: by mail-ot1-f46.google.com with SMTP id 35-20020a9d08a6000000b00579cd5e605eso4628670otf.0;
        Wed, 24 Nov 2021 06:31:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Eu+An0Wqru+XdtHm5aswYmIMkbkLQ/vDJ7BbpIzejgY=;
        b=dhf1et9u+aBAe6OJaosUpujhMPG8Uq+zGrKPrv3SATjp+dt7R13kgFn8gGjPyOYqUU
         f1BI8ZJv627/T6AWFbsea0FWg9UlxLgk9x5nGHBPQjx85jZZlTuKlHHP0r9S5RG48BuL
         zY796UZsQttqdBDyBk2pHsHxH08INjk7R63uhZt1jilmpIRaPlWeAxV6Fiid3hAP0hko
         jfEt6QRb4wfYclNW4E+reeYayiSh0YPMtOKKyIiwbIk8rJwcoUuKmh+Hn5efAFigOvJB
         j0+Ni8UpwyD7obSI2ysHYsIGIZq8d78T3kNSOSSRUUQjzTdmm5GNLUEVdGKeb29CPMRv
         9pBg==
X-Gm-Message-State: AOAM533knLgwo9qvFvcporjJwH7rY2iby/p/P4cM0we6KSJs+X7viVIl
        Ecl+6+8eyCtPrOyrHvRYM3LcWF1iirUUHvPb8xc=
X-Google-Smtp-Source: ABdhPJwX7bYX4mz2i102YPzMsCTko0M9Zf3tb8+uTM3gOJzmPVzH9nqXlHDbfVzH9wnaKnx/7DdUyn0dmrw9BQCacFA=
X-Received: by 2002:a05:6830:1e57:: with SMTP id e23mr13455332otj.16.1637764264752;
 Wed, 24 Nov 2021 06:31:04 -0800 (PST)
MIME-Version: 1.0
References: <20211115121001.77041-1-heikki.krogerus@linux.intel.com>
 <CAJZ5v0jsWVw4OyVbkdn2374tLAXAShZ_B3CKDmnQOE_QEXXPiQ@mail.gmail.com> <YZ5JDhOnDw+qqzJP@kuha.fi.intel.com>
In-Reply-To: <YZ5JDhOnDw+qqzJP@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 24 Nov 2021 15:30:53 +0100
Message-ID: <CAJZ5v0iVTGbgdU5Ux992fYim8zpV_GstJhYMLStr7YcQNWFPyQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] device property: Remove device_add_properties()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 24, 2021 at 3:15 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Wed, Nov 24, 2021 at 02:59:01PM +0100, Rafael J. Wysocki wrote:
> > On Mon, Nov 15, 2021 at 1:10 PM Heikki Krogerus
> > <heikki.krogerus@linux.intel.com> wrote:
> > >
> > > Hi,
> > >
> > > One more version. Hopefully the commit messages are now OK. No other
> > > changes since v3:
> > >
> > > https://lore.kernel.org/lkml/20211006112643.77684-1-heikki.krogerus@linux.intel.com/
> > >
> > >
> > > v3 cover letter:
> > >
> > > In this third version of this series, the second patch is now split in
> > > two. The device_remove_properties() call is first removed from
> > > device_del() in its own patch, and the
> > > device_add/remove_properties() API is removed separately in the last
> > > patch. I hope the commit messages are clear enough this time.
> > >
> > >
> > > v2 cover letter:
> > >
> > > This is the second version where I only modified the commit message of
> > > the first patch according to comments from Bjorn.
> > >
> > >
> > > Original cover letter:
> > >
> > > There is one user left for the API, so converting that to use software
> > > node API instead, and removing the function.
> > >
> > >
> > > thanks,
> > >
> > > Heikki Krogerus (3):
> > >   PCI: Convert to device_create_managed_software_node()
> > >   driver core: Don't call device_remove_properties() from device_del()
> > >   device property: Remove device_add_properties() API
> > >
> > >  drivers/base/core.c      |  1 -
> > >  drivers/base/property.c  | 48 ----------------------------------------
> > >  drivers/pci/quirks.c     |  2 +-
> > >  include/linux/property.h |  4 ----
> > >  4 files changed, 1 insertion(+), 54 deletions(-)
> >
> > Has this been picked up already or am I expected to pick it up?
>
> It hasn't been picked up by anybody, so if you can take these, that
> would be great.

OK, applied as 5.17 material now.

Greg, please let me know if you'd rather take these patches yourself
and I'll drop them in that case.

Thanks!
