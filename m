Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C332C19057F
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 07:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725923AbgCXGKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 02:10:46 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38016 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgCXGKq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 02:10:46 -0400
Received: by mail-qk1-f196.google.com with SMTP id h14so18193028qke.5;
        Mon, 23 Mar 2020 23:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NHyvhEFOA+6ht5C5Md9yO/2NBro540fuAK71xdfGAyw=;
        b=gcAgnWaUi4IvLI3keqVWWIEPRpN5wENXb/k3U4hQ1wxVUGZjy35Q1DnW7yBDa28gqW
         4yVwTfMkRDLB4tyiRLTmHmgO9j/tc+0wsEaxDIb8sWervzIdgGakXaUNkZtFKj6bs5N4
         TOukkcEOGU6PGKai9pZ1/b9kC+veZJvFvfn0YT+qc45rWUQUCb5MvocCJcaYrOkfD5Nz
         /6PlKtjCTcbNCRWsEWgksBXiXUBNxGRzeb65+wB3O0Q1/4UD8f5MbtpKusDJ0NB/N1Dr
         Ki6+cXKTgQNxzEnrvURP/dQjRHoo22Ll6y3hMArE/YNtZ/20sp7GASaPwqGsqB2cj7aK
         L8/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NHyvhEFOA+6ht5C5Md9yO/2NBro540fuAK71xdfGAyw=;
        b=T0YduisK2P29R4qwrn7GzS+6Gli8AABjK/N9kSXb4qqB7Mkeyfw3BHMhOA1uO+uuI9
         zpVSbm/5uVfDTEwGHN+RPmCuT2ZAulU1y/XY/6mFggadE6C/pBaXXpwSK2j2B8ZH/E40
         LxmMwlF1NuffQeMbLQt/U7EjC/M5Yj7AdeRYpIJZUHxuykr4COT7aDOwpub+MmAsxaIa
         WmnaEOsk6FOGGO5qkRaccTVuOcKDPNHyEVMZ75KiqT7dCJ24NezS64SHZ/3Iw1msituY
         hgYGcdZWtm/jgad7DRd9EODRYXZY+XlcRA0MWNyeDi6gALD77YIUpoCS9+ZLBOhYQW1E
         rTXg==
X-Gm-Message-State: ANhLgQ0Set5UbNpcYxQcGpyPmUd1vJ2mOp+HPOcQ8s/ZtZaqkkLI4MI+
        jeM4CgmqZNng5teKTl+13Sruwi9sreMkgj2ISg4=
X-Google-Smtp-Source: ADFU+vsSdNX04/CnwDNqaQSoUMpaW5OmZpb0wl8ctm6k3wTZloWyqMcRPtERngxtZnn6mOwFSIjHuHYtVx9xxQdqjDg=
X-Received: by 2002:a37:66c9:: with SMTP id a192mr19240643qkc.10.1585030244645;
 Mon, 23 Mar 2020 23:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-2-skunberg.kelsey@gmail.com> <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
 <20200314112022.GA53794@kroah.com>
In-Reply-To: <20200314112022.GA53794@kroah.com>
From:   Kelsey <skunberg.kelsey@gmail.com>
Date:   Tue, 24 Mar 2020 00:10:33 -0600
Message-ID: <CAFVqi1T1Fipajca8exrzs6uQAorSZeke80LYy43aCBpT45nFdA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: sysfs: Define device attributes with DEVICE_ATTR*
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Bodong Wang <bodong@mellanox.com>,
        Don Dutile <ddutile@redhat.com>, rbilovol@cisco.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Mar 14, 2020 at 5:20 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Sat, Mar 14, 2020 at 12:51:47PM +0200, Ruslan Bilovol wrote:
> > On Thu, Aug 15, 2019 at 7:01 PM Kelsey Skunberg
> > <skunberg.kelsey@gmail.com> wrote:
> > >
> > > Defining device attributes should be done through the helper
> > > DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
> > > __ATTR* to now use its equivalent DEVICE_ATTR*.
> > >
> > > Example of old:
> > >
> > > static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);
> > >
> > > Example of new:
> > >
> > > static DEVICE_ATTR_RO(_name);
> > >
> > > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > > ---
> > >  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
> > >  1 file changed, 27 insertions(+), 32 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > index 965c72104150..8af7944fdccb 100644
> > > --- a/drivers/pci/pci-sysfs.c
> > > +++ b/drivers/pci/pci-sysfs.c
> > > @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
> > >         }
> > >         return count;
> > >  }
> > > -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> > > -                                                       (S_IWUSR|S_IWGRP),
> > > -                                                       NULL, dev_rescan_store);
> > > +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
> > >
> > >  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > >                             const char *buf, size_t count)
> > > @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > >                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> > >         return count;
> > >  }
> > > -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> > > -                                                       (S_IWUSR|S_IWGRP),
> > > -                                                       NULL, remove_store);
> > > +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> > > +                                 remove_store);
> > >
> > >  static ssize_t dev_bus_rescan_store(struct device *dev,
> > >                                     struct device_attribute *attr,
> > > @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
> > >         }
> > >         return count;
> > >  }
> > > -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> > > +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
> >
> > This patch renamed 'rescan' to 'bus_rescan' and broke my userspace application.
> > There is also mismatch now between real functionality and documentation
> > Documentation/ABI/testing/sysfs-bus-pci which still contains old "rescan"
> > descriptions.
> >
> > Another patch from this patch series also renamed 'rescan' to 'dev_rescan'
> >
> > Here is a comparison between two stable kernels (with and without this
> > patch series):
> >
> > v5.4
> > # find /sys -name '*rescan'
> > /sys/devices/pci0000:00/0000:00:01.2/dev_rescan
> > /sys/devices/pci0000:00/0000:00:01.0/dev_rescan
> > /sys/devices/pci0000:00/0000:00:04.0/dev_rescan
> > /sys/devices/pci0000:00/0000:00:00.0/dev_rescan
> > /sys/devices/pci0000:00/pci_bus/0000:00/bus_rescan
> > /sys/devices/pci0000:00/0000:00:01.3/dev_rescan
> > /sys/devices/pci0000:00/0000:00:03.0/dev_rescan
> > /sys/devices/pci0000:00/0000:00:01.1/dev_rescan
> > /sys/devices/pci0000:00/0000:00:02.0/dev_rescan
> > /sys/devices/pci0000:00/0000:00:05.0/dev_rescan
> > /sys/bus/pci/rescan
> >
> > v4.19
> > # find /sys -name '*rescan'
> > /sys/devices/pci0000:00/0000:00:01.2/rescan
> > /sys/devices/pci0000:00/0000:00:01.0/rescan
> > /sys/devices/pci0000:00/0000:00:04.0/rescan
> > /sys/devices/pci0000:00/0000:00:00.0/rescan
> > /sys/devices/pci0000:00/pci_bus/0000:00/rescan
> > /sys/devices/pci0000:00/0000:00:01.3/rescan
> > /sys/devices/pci0000:00/0000:00:03.0/rescan
> > /sys/devices/pci0000:00/0000:00:01.1/rescan
> > /sys/devices/pci0000:00/0000:00:02.0/rescan
> > /sys/devices/pci0000:00/0000:00:05.0/rescan
> > /sys/bus/pci/rescan
> >
> > Do we maintain this kind of API as non-changeable?
>
> Yeah, that's a bug and should be fixed, sorry for missing that on
> review.
>
> Kelsey, can you fix this up?
>
> thanks,
>
> greg k-h

I'd be happy to help get this fixed up.

Would it be proper to go back to using DEVICE_ATTR() for 'bus_rescan'
and 'dev_rescan' in order to change their names back to 'rescan'?

The name changes were done so the correct *_store() would still be
called. When using DEVICE_ATTR() the *_store() name is passed as the
last argument, as seen here:

    static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);

When using the helper, only the name is passed and it assumes default
<name>_show(), as seen here:

    static DEVICE_ATTR_WO(dev_rescan);   # (This would assume
dev_rescan_store())

This can be verified in Documentation/filesystems/sysfs.txt.

There is already a rescan attribute using rescan_store(), so changing
at least one of these to DEVICE_ATTR_WO(rescan) would be conflicting.

I understand it's ideal to stay away from using DEVICE_ATTR() unless
an unusual mode is needed. Would having a different name vs
name_store() be another reason to justify using DEVICE_ATTR()?

Thank you Ruslan for pointing this out!

- Kelsey
