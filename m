Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBA1D1905AA
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 07:24:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725959AbgCXGYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 02:24:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:47646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725867AbgCXGYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 24 Mar 2020 02:24:25 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D6B9D20663;
        Tue, 24 Mar 2020 06:24:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585031064;
        bh=JWBbZp/FZwETgxZHD80t5s+4NDrNkBwhJtrwKMbbg3s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eK2jNhJ6cQ944Zk0r8aRAj6KRP/foNFXYue74cZLZx4Pv3PZib0FakK/jHS0q+T/d
         BRKmtMetxRDLl6Luhg/jDu+UilJYjd0R0loy3VzxgNhljfLyglKz64W8ZGK318sML8
         d38xT2SSaQ+tY5Nxb1sM5F2D8u5TnFNV+taC3Usk=
Date:   Tue, 24 Mar 2020 07:24:22 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Kelsey <skunberg.kelsey@gmail.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Don Dutile <ddutile@redhat.com>, rbilovol@cisco.com
Subject: Re: [PATCH v3 1/4] PCI: sysfs: Define device attributes with
 DEVICE_ATTR*
Message-ID: <20200324062422.GA1977781@kroah.com>
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-2-skunberg.kelsey@gmail.com>
 <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
 <20200314112022.GA53794@kroah.com>
 <CAFVqi1T1Fipajca8exrzs6uQAorSZeke80LYy43aCBpT45nFdA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFVqi1T1Fipajca8exrzs6uQAorSZeke80LYy43aCBpT45nFdA@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Mar 24, 2020 at 12:10:33AM -0600, Kelsey wrote:
> On Sat, Mar 14, 2020 at 5:20 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Sat, Mar 14, 2020 at 12:51:47PM +0200, Ruslan Bilovol wrote:
> > > On Thu, Aug 15, 2019 at 7:01 PM Kelsey Skunberg
> > > <skunberg.kelsey@gmail.com> wrote:
> > > >
> > > > Defining device attributes should be done through the helper
> > > > DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
> > > > __ATTR* to now use its equivalent DEVICE_ATTR*.
> > > >
> > > > Example of old:
> > > >
> > > > static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);
> > > >
> > > > Example of new:
> > > >
> > > > static DEVICE_ATTR_RO(_name);
> > > >
> > > > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > > > ---
> > > >  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
> > > >  1 file changed, 27 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > index 965c72104150..8af7944fdccb 100644
> > > > --- a/drivers/pci/pci-sysfs.c
> > > > +++ b/drivers/pci/pci-sysfs.c
> > > > @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
> > > >         }
> > > >         return count;
> > > >  }
> > > > -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> > > > -                                                       (S_IWUSR|S_IWGRP),
> > > > -                                                       NULL, dev_rescan_store);
> > > > +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
> > > >
> > > >  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > > >                             const char *buf, size_t count)
> > > > @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > > >                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> > > >         return count;
> > > >  }
> > > > -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> > > > -                                                       (S_IWUSR|S_IWGRP),
> > > > -                                                       NULL, remove_store);
> > > > +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> > > > +                                 remove_store);
> > > >
> > > >  static ssize_t dev_bus_rescan_store(struct device *dev,
> > > >                                     struct device_attribute *attr,
> > > > @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
> > > >         }
> > > >         return count;
> > > >  }
> > > > -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> > > > +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
> > >
> > > This patch renamed 'rescan' to 'bus_rescan' and broke my userspace application.
> > > There is also mismatch now between real functionality and documentation
> > > Documentation/ABI/testing/sysfs-bus-pci which still contains old "rescan"
> > > descriptions.
> > >
> > > Another patch from this patch series also renamed 'rescan' to 'dev_rescan'
> > >
> > > Here is a comparison between two stable kernels (with and without this
> > > patch series):
> > >
> > > v5.4
> > > # find /sys -name '*rescan'
> > > /sys/devices/pci0000:00/0000:00:01.2/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:01.0/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:04.0/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:00.0/dev_rescan
> > > /sys/devices/pci0000:00/pci_bus/0000:00/bus_rescan
> > > /sys/devices/pci0000:00/0000:00:01.3/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:03.0/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:01.1/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:02.0/dev_rescan
> > > /sys/devices/pci0000:00/0000:00:05.0/dev_rescan
> > > /sys/bus/pci/rescan
> > >
> > > v4.19
> > > # find /sys -name '*rescan'
> > > /sys/devices/pci0000:00/0000:00:01.2/rescan
> > > /sys/devices/pci0000:00/0000:00:01.0/rescan
> > > /sys/devices/pci0000:00/0000:00:04.0/rescan
> > > /sys/devices/pci0000:00/0000:00:00.0/rescan
> > > /sys/devices/pci0000:00/pci_bus/0000:00/rescan
> > > /sys/devices/pci0000:00/0000:00:01.3/rescan
> > > /sys/devices/pci0000:00/0000:00:03.0/rescan
> > > /sys/devices/pci0000:00/0000:00:01.1/rescan
> > > /sys/devices/pci0000:00/0000:00:02.0/rescan
> > > /sys/devices/pci0000:00/0000:00:05.0/rescan
> > > /sys/bus/pci/rescan
> > >
> > > Do we maintain this kind of API as non-changeable?
> >
> > Yeah, that's a bug and should be fixed, sorry for missing that on
> > review.
> >
> > Kelsey, can you fix this up?
> >
> > thanks,
> >
> > greg k-h
> 
> I'd be happy to help get this fixed up.
> 
> Would it be proper to go back to using DEVICE_ATTR() for 'bus_rescan'
> and 'dev_rescan' in order to change their names back to 'rescan'?

Yes.

thanks,

greg k-h
