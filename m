Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CC5422A0A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Oct 2021 16:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbhJEOG5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Oct 2021 10:06:57 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:35566 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhJEOGv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Oct 2021 10:06:51 -0400
Received: by mail-oi1-f173.google.com with SMTP id n64so26372120oih.2;
        Tue, 05 Oct 2021 07:05:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VqvpTXzBkK0TeJQ5NfJBE7Up3bi+uOXfzRb6NfJA9+A=;
        b=0JXY7CKXim6dA9eF6zWi7PMesmYmzAGpWk2yZtYSEWnQY+SMrAsN6PuiVgryA8TIDq
         28/31tGdcexTpO2mBY5/Nq0dQYZr2FejfH9BPOw4fAiTZAT05LOv7GyBBqekEgNeOcrM
         iB32wZ0KUP5ImY8qzBchIQk8up1bd04MtVDRvUbs6Ig7IR2nkROeCydLvI3C/E0Aum3B
         N7d2sMIUTDg/4b05n+MrJn92UOUJ422AgnFHfdBcKbFbx0pyuYxWwZ73WhH1VRy860Nw
         HlqI5TFlpeIUgQMoArzUAyjWaJbuhfTnPlZCOCPAOEB+VCHO+PgJUhAnhw4oJS3xcBVd
         VTsg==
X-Gm-Message-State: AOAM530h7Zj0qwQ6JjqH9bUjjzg71CYzy32eNFq6Q6uW8rfH4FcWORH7
        KpqL4k3ApzSCJt8NPU/CBBl+Lje7krXdCD9Y8vc=
X-Google-Smtp-Source: ABdhPJzg7hjsJnLo8gTqhqPlm4UooDTKVfkEg0I5yOb33mZHpCsYlbx6OskoQuoLl5Cik7GrbDqCVhGxKhFE0TpjU9Q=
X-Received: by 2002:a05:6808:1816:: with SMTP id bh22mr2607411oib.69.1633442700589;
 Tue, 05 Oct 2021 07:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20210930121246.22833-2-heikki.krogerus@linux.intel.com>
 <20210930150402.GA877907@bhelgaas> <YVbku7IQatCydZ+V@kuha.fi.intel.com>
In-Reply-To: <YVbku7IQatCydZ+V@kuha.fi.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Tue, 5 Oct 2021 16:04:48 +0200
Message-ID: <CAJZ5v0g7YBVAhJEWo25GdCic6nAUrwhne9rT1LfUznMKn2NGnA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: Convert to device_create_managed_software_node()
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 1, 2021 at 12:36 PM Heikki Krogerus
<heikki.krogerus@linux.intel.com> wrote:
>
> On Thu, Sep 30, 2021 at 10:04:02AM -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 30, 2021 at 03:12:45PM +0300, Heikki Krogerus wrote:
> > > In quirk_huawei_pcie_sva(), use device_create_managed_software_node()
> > > instead of device_add_properties() to set the "dma-can-stall"
> > > property.
> > >
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Acked-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> > > Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > ---
> > > Hi,
> > >
> > > The commit message now says what Bjorn requested, except I left out
> > > the claim that the patch fixes a lifetime issue.
> >
> > Thanks.
> >
> > The commit log should help reviewers determine whether the change is
> > safe and necessary.  So far it doesn't have any hints along that line.
> >
> > Comparing device_add_properties() [1] and
> > device_create_managed_software_node() [2], the only difference in this
> > case is that the latter sets "swnode->managed = true".  The function
> > comment says "managed" means the lifetime of the swnode is tied to the
> > lifetime of dev, hence my question about a lifetime issue.
> >
> > I can see that one reason for this change is to remove the last caller
> > of device_add_properties(), so device_add_properties() itself can be
> > removed.  That's a good reason for wanting to do it, and the commit
> > log could mention it.
>
> Fair enough. I need to explain the why as well as the what.
>
> I'll improve the commit message, but just to be clear, the goal is
> actually not to get rid of device_add_properties(). It is removed in
> the second patch together with device_remove_properties() because
> there are simply no more users for that API.
>
> > But it doesn't help me figure out whether it's safe.  For that,
> > I need to know the effect of setting "managed = true".  Obviously
> > it means *something*, but I don't know what.  It looks like the only
> > test is in software_node_notify():
> >
> >   device_del
> >     device_platform_notify_remove
> >       software_node_notify_remove
> >         sysfs_remove_link(dev_name)
> >         sysfs_remove_link("software_node")
> >         if (swnode->managed)                 <--
> >           set_secondary_fwnode(dev, NULL)
> >           kobject_put(&swnode->kobj)
> >     device_remove_properties
> >       if (is_software_node())
> >         fwnode_remove_software_node
> >           kobject_put(&swnode->kobj)
> >         set_secondary_fwnode(dev, NULL)
> >
> > I'm not sure what's going on here; it looks like some redundancy with
> > multiple calls of kobject_put() and set_secondary_fwnode().  Maybe you
> > are in the process of removing device_remove_properties() as well as
> > device_add_properties()?
>
> It'll get removed, but that's not the goal. The goal is to get rid of
> the call to it in device_del(), so not the function itself. That call
> is the problem here as explained in commit 151f6ff78cdf ("software
> node: Provide replacement for device_add_properties()").
>
> I'll split the second patch, and first only remove that
> device_remove_properties() call from device_del(), and only after
> that remove the functions themselves.

So I'm expecting a v3 of this.
