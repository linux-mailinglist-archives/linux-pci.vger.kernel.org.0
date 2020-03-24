Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0300E191DC7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 00:54:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgCXXyN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Mar 2020 19:54:13 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41492 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgCXXyN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Mar 2020 19:54:13 -0400
Received: by mail-qk1-f193.google.com with SMTP id q188so593043qke.8;
        Tue, 24 Mar 2020 16:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bWdQrSC8E4qph62LTErgxscMGGiPy7reC5vJ9ah9h8k=;
        b=nNAICxcBx0Pd+m7pJ2cu767ivyvG+BJBZ7CnmIRNMGl1+j5Qv4Hioi0DGMhn0udMwC
         0Sj+v2o4t2wmAjP4WNZr8YjuKF1Rq0hxXvGvKD6ZGXd3QbJ9okgMYT1FwxIUeRJFSXdS
         i4d9ZDEUQ7jrRM371rEkYhxGU655fTzy1yJ2aOcv4/wlSL3m8g6ARfwOz++ZSbRJIHr/
         9hR8rmjizVcSSdAncaxPMSx6ERntT2iXWLX3bpMk+OjPExyiTGAXjg0QeUibDEy5V7js
         H2VvNMBkK3akQBiiot6BhL7noTLbdljNVc/SORkSDu9mXccRtM7u8/ogVMZ48YmqCETs
         eptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bWdQrSC8E4qph62LTErgxscMGGiPy7reC5vJ9ah9h8k=;
        b=HeYIaUgSKBj9WoGDUy6dmgSXvfXAU5T2+hunSDj5MdaBe5AMkO+Vv1leLBufb1FfLP
         bQWGUQRpHBp4di0cEmDetjrbqYuAsbXqGmjyJUFYdjIGuClD89EDlMvZswUNykG53dnP
         H1c3tIFGPt6j9o8Plm/zdl40J0oC/66WDRPI0Q2dJob1VofCEQqIHMa4v7yyZwG5FS1g
         7e9n/2zopgvtc9hXfqO6ENpDJGu1Mh/FUyWEyFjgtn3JyqsYS3SQ9p3HPel18t90+h/d
         Gd/tV+yXltHQFXQ0YuUxyRAr7IdvooQr83YWBephPdw4pQvjIhsf9utb6IkxJL8ybLfP
         43eg==
X-Gm-Message-State: ANhLgQ3CKM5FEB1zRlo6viAdYgr84QQ/X1hgM3H+PJQXc53fmQZTeRrG
        1aTW/31Ji1xAlRJHMGKKLGGBQ6ZKWRWJlwTQIX8=
X-Google-Smtp-Source: ADFU+vu8TmmTFhtp932LiK5RXfQw1JiikKNrT3JD96Mn5TJPqPZzPw9VhGygP/zkNCp4+8rHf5Myv3bSXCNTnDLS6WY=
X-Received: by 2002:a37:4015:: with SMTP id n21mr447066qka.76.1585094051677;
 Tue, 24 Mar 2020 16:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-2-skunberg.kelsey@gmail.com> <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
 <20200314112022.GA53794@kroah.com> <CAFVqi1T1Fipajca8exrzs6uQAorSZeke80LYy43aCBpT45nFdA@mail.gmail.com>
 <20200324062422.GA1977781@kroah.com>
In-Reply-To: <20200324062422.GA1977781@kroah.com>
From:   Kelsey <skunberg.kelsey@gmail.com>
Date:   Tue, 24 Mar 2020 17:53:59 -0600
Message-ID: <CAFVqi1Sqnn6L9xLQ0=BZp6D=aYz74tRMP0WYEXXVsz2cYXaoHA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] PCI: sysfs: Define device attributes with DEVICE_ATTR*
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
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

On Tue, Mar 24, 2020 at 12:24 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 24, 2020 at 12:10:33AM -0600, Kelsey wrote:
> > On Sat, Mar 14, 2020 at 5:20 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Sat, Mar 14, 2020 at 12:51:47PM +0200, Ruslan Bilovol wrote:
> > > > On Thu, Aug 15, 2019 at 7:01 PM Kelsey Skunberg
> > > > <skunberg.kelsey@gmail.com> wrote:
> > > > >
> > > > > Defining device attributes should be done through the helper
> > > > > DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
> > > > > __ATTR* to now use its equivalent DEVICE_ATTR*.
> > > > >
> > > > > Example of old:
> > > > >
> > > > > static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);
> > > > >
> > > > > Example of new:
> > > > >
> > > > > static DEVICE_ATTR_RO(_name);
> > > > >
> > > > > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > > > > ---
> > > > >  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
> > > > >  1 file changed, 27 insertions(+), 32 deletions(-)
> > > > >
> > > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > > index 965c72104150..8af7944fdccb 100644
> > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
> > > > >         }
> > > > >         return count;
> > > > >  }
> > > > > -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> > > > > -                                                       (S_IWUSR|S_IWGRP),
> > > > > -                                                       NULL, dev_rescan_store);
> > > > > +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
> > > > >
> > > > >  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > > > >                             const char *buf, size_t count)
> > > > > @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > > > >                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> > > > >         return count;
> > > > >  }
> > > > > -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> > > > > -                                                       (S_IWUSR|S_IWGRP),
> > > > > -                                                       NULL, remove_store);
> > > > > +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> > > > > +                                 remove_store);
> > > > >
> > > > >  static ssize_t dev_bus_rescan_store(struct device *dev,
> > > > >                                     struct device_attribute *attr,
> > > > > @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
> > > > >         }
> > > > >         return count;
> > > > >  }
> > > > > -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> > > > > +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
> > > >
> > > > This patch renamed 'rescan' to 'bus_rescan' and broke my userspace application.
> > > > There is also mismatch now between real functionality and documentation
> > > > Documentation/ABI/testing/sysfs-bus-pci which still contains old "rescan"
> > > > descriptions.
> > > >
> > > > Another patch from this patch series also renamed 'rescan' to 'dev_rescan'
> > > >
> > > > Here is a comparison between two stable kernels (with and without this
> > > > patch series):
> > > >
> > > > v5.4
> > > > # find /sys -name '*rescan'
> > > > /sys/devices/pci0000:00/0000:00:01.2/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:01.0/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:04.0/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:00.0/dev_rescan
> > > > /sys/devices/pci0000:00/pci_bus/0000:00/bus_rescan
> > > > /sys/devices/pci0000:00/0000:00:01.3/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:03.0/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:01.1/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:02.0/dev_rescan
> > > > /sys/devices/pci0000:00/0000:00:05.0/dev_rescan
> > > > /sys/bus/pci/rescan
> > > >
> > > > v4.19
> > > > # find /sys -name '*rescan'
> > > > /sys/devices/pci0000:00/0000:00:01.2/rescan
> > > > /sys/devices/pci0000:00/0000:00:01.0/rescan
> > > > /sys/devices/pci0000:00/0000:00:04.0/rescan
> > > > /sys/devices/pci0000:00/0000:00:00.0/rescan
> > > > /sys/devices/pci0000:00/pci_bus/0000:00/rescan
> > > > /sys/devices/pci0000:00/0000:00:01.3/rescan
> > > > /sys/devices/pci0000:00/0000:00:03.0/rescan
> > > > /sys/devices/pci0000:00/0000:00:01.1/rescan
> > > > /sys/devices/pci0000:00/0000:00:02.0/rescan
> > > > /sys/devices/pci0000:00/0000:00:05.0/rescan
> > > > /sys/bus/pci/rescan
> > > >
> > > > Do we maintain this kind of API as non-changeable?
> > >
> > > Yeah, that's a bug and should be fixed, sorry for missing that on
> > > review.
> > >
> > > Kelsey, can you fix this up?
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> > I'd be happy to help get this fixed up.
> >
> > Would it be proper to go back to using DEVICE_ATTR() for 'bus_rescan'
> > and 'dev_rescan' in order to change their names back to 'rescan'?
>
> Yes.
>
> thanks,
>
> greg k-h


Ack. Sent a patch out. Will stay posted in case any updates need to be made.

commit 4cb9e42d3226 ("PCI: sysfs: Change bus_rescan and dev_rescan to rescan")

Thanks!

- Kelsey
