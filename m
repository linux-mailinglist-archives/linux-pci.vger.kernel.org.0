Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1BE192C02
	for <lists+linux-pci@lfdr.de>; Wed, 25 Mar 2020 16:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbgCYPPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Mar 2020 11:15:31 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:38371 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCYPPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 25 Mar 2020 11:15:31 -0400
Received: by mail-qk1-f195.google.com with SMTP id h14so2901750qke.5;
        Wed, 25 Mar 2020 08:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jZXSt/VrIZOV3oVnNKDvW8RIpCUfTNMiDOfSBRU0VB8=;
        b=TUUuszWOWR6k65Zd0oivopeWcUF500AHJzVV/Sg/CpVv17RUNlIFHVn4+EWYExw7ty
         yMWJ+T2Eb13M8tbgnO1WKSWhSIbFWyVKJoSJFRcLTlRhf4gqMAnEqqmHSw0ugi6tGra2
         t51Z+y/0Lik3mf/08yI055P9RJxkWa2/lthUuipGLrsoEHpLsH1DmMJfuHLmu8QrbkDg
         AEzWKxSKD+0RY4j3b7B/w6jBk1hRbiDInW2f/lIWUQ7xm0qS2lRKVB6MYgJ+WsbQvYLE
         AX4yEiAtHPdhAaVHeYCCyoPPq61xeqbQkk/H92vINT6vG88BUODo1cOFIMKAhA3HdVWM
         7Vbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jZXSt/VrIZOV3oVnNKDvW8RIpCUfTNMiDOfSBRU0VB8=;
        b=BFBXmEnjmkbhi/1KTvwcFZFrZT9KUyiIwDVyEdiVjFOc/86H+CV4R6EdTEFB6pwNK5
         Ql/XqUfk65IMyLXGR87uf8MMSlrzKqRDzjS4F7as/7bdm8MLtyVvQGplKYYhUZqdDxmv
         ZFpkCaLPP5n+mS+TE6+Po3H4rJ555AY+QnuBIIMHelsg0Ol5KFNM4CMzDiJ9PTyzMS1q
         c13VzV64XMLIwhoX4UyRv5yI52TxLZWhvRIP8umkBGKe0EeqX+nJJGA0U1sTr5vJCNL5
         zyo8iX30+hujfGiGEThiaH3a9P4afMTCDTNH7CkiZqEL0qPf8fiu4Qo4n76e7z87TiNg
         8+7Q==
X-Gm-Message-State: ANhLgQ30Sv8cdSLhZVcL/Yq+AuJnLuw6MSOWwD1nYZzwNEjRMmd6hQPK
        xzQhLPkfZmv673dLjJAOi/EUWZ0WyKVEr8++tg8=
X-Google-Smtp-Source: ADFU+vuJ7cSsW/s0dJZEJ+X32pL4tMEYdYJsFWLyBOG7k1gGNBggZT56570m3UBaDVEQQV25CNBhzuPkaa5pD09x55A=
X-Received: by 2002:a37:66c9:: with SMTP id a192mr3397481qkc.10.1585149328778;
 Wed, 25 Mar 2020 08:15:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190813204513.4790-1-skunberg.kelsey@gmail.com>
 <20190815153352.86143-2-skunberg.kelsey@gmail.com> <CAB=otbSYozS-ZfxB0nCiNnxcbqxwrHOSYxJJtDKa63KzXbXgpw@mail.gmail.com>
 <20200314112022.GA53794@kroah.com> <CAFVqi1T1Fipajca8exrzs6uQAorSZeke80LYy43aCBpT45nFdA@mail.gmail.com>
 <20200324062422.GA1977781@kroah.com> <CAFVqi1Sqnn6L9xLQ0=BZp6D=aYz74tRMP0WYEXXVsz2cYXaoHA@mail.gmail.com>
 <20200325071702.GB2978943@kroah.com>
In-Reply-To: <20200325071702.GB2978943@kroah.com>
From:   Kelsey <skunberg.kelsey@gmail.com>
Date:   Wed, 25 Mar 2020 09:15:17 -0600
Message-ID: <CAFVqi1SpeYzixp3vLGGzkOaibF3kmV-u3oF02QoKHjfZ2vEPtg@mail.gmail.com>
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

On Wed, Mar 25, 2020 at 1:17 AM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Mar 24, 2020 at 05:53:59PM -0600, Kelsey wrote:
> > On Tue, Mar 24, 2020 at 12:24 AM Greg Kroah-Hartman
> > <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Tue, Mar 24, 2020 at 12:10:33AM -0600, Kelsey wrote:
> > > > On Sat, Mar 14, 2020 at 5:20 AM Greg Kroah-Hartman
> > > > <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > On Sat, Mar 14, 2020 at 12:51:47PM +0200, Ruslan Bilovol wrote:
> > > > > > On Thu, Aug 15, 2019 at 7:01 PM Kelsey Skunberg
> > > > > > <skunberg.kelsey@gmail.com> wrote:
> > > > > > >
> > > > > > > Defining device attributes should be done through the helper
> > > > > > > DEVICE_ATTR_RO(), DEVICE_ATTR_WO(), or similar. Change all instances using
> > > > > > > __ATTR* to now use its equivalent DEVICE_ATTR*.
> > > > > > >
> > > > > > > Example of old:
> > > > > > >
> > > > > > > static struct device_attribute dev_name_##_attr=__ATTR_RO(_name);
> > > > > > >
> > > > > > > Example of new:
> > > > > > >
> > > > > > > static DEVICE_ATTR_RO(_name);
> > > > > > >
> > > > > > > Signed-off-by: Kelsey Skunberg <skunberg.kelsey@gmail.com>
> > > > > > > ---
> > > > > > >  drivers/pci/pci-sysfs.c | 59 +++++++++++++++++++----------------------
> > > > > > >  1 file changed, 27 insertions(+), 32 deletions(-)
> > > > > > >
> > > > > > > diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> > > > > > > index 965c72104150..8af7944fdccb 100644
> > > > > > > --- a/drivers/pci/pci-sysfs.c
> > > > > > > +++ b/drivers/pci/pci-sysfs.c
> > > > > > > @@ -464,9 +464,7 @@ static ssize_t dev_rescan_store(struct device *dev,
> > > > > > >         }
> > > > > > >         return count;
> > > > > > >  }
> > > > > > > -static struct device_attribute dev_rescan_attr = __ATTR(rescan,
> > > > > > > -                                                       (S_IWUSR|S_IWGRP),
> > > > > > > -                                                       NULL, dev_rescan_store);
> > > > > > > +static DEVICE_ATTR(rescan, (S_IWUSR | S_IWGRP), NULL, dev_rescan_store);
> > > > > > >
> > > > > > >  static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > > > > > >                             const char *buf, size_t count)
> > > > > > > @@ -480,9 +478,8 @@ static ssize_t remove_store(struct device *dev, struct device_attribute *attr,
> > > > > > >                 pci_stop_and_remove_bus_device_locked(to_pci_dev(dev));
> > > > > > >         return count;
> > > > > > >  }
> > > > > > > -static struct device_attribute dev_remove_attr = __ATTR_IGNORE_LOCKDEP(remove,
> > > > > > > -                                                       (S_IWUSR|S_IWGRP),
> > > > > > > -                                                       NULL, remove_store);
> > > > > > > +static DEVICE_ATTR_IGNORE_LOCKDEP(remove, (S_IWUSR | S_IWGRP), NULL,
> > > > > > > +                                 remove_store);
> > > > > > >
> > > > > > >  static ssize_t dev_bus_rescan_store(struct device *dev,
> > > > > > >                                     struct device_attribute *attr,
> > > > > > > @@ -504,7 +501,7 @@ static ssize_t dev_bus_rescan_store(struct device *dev,
> > > > > > >         }
> > > > > > >         return count;
> > > > > > >  }
> > > > > > > -static DEVICE_ATTR(rescan, (S_IWUSR|S_IWGRP), NULL, dev_bus_rescan_store);
> > > > > > > +static DEVICE_ATTR(bus_rescan, (S_IWUSR | S_IWGRP), NULL, dev_bus_rescan_store);
> > > > > >
> > > > > > This patch renamed 'rescan' to 'bus_rescan' and broke my userspace application.
> > > > > > There is also mismatch now between real functionality and documentation
> > > > > > Documentation/ABI/testing/sysfs-bus-pci which still contains old "rescan"
> > > > > > descriptions.
> > > > > >
> > > > > > Another patch from this patch series also renamed 'rescan' to 'dev_rescan'
> > > > > >
> > > > > > Here is a comparison between two stable kernels (with and without this
> > > > > > patch series):
> > > > > >
> > > > > > v5.4
> > > > > > # find /sys -name '*rescan'
> > > > > > /sys/devices/pci0000:00/0000:00:01.2/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:01.0/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:04.0/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:00.0/dev_rescan
> > > > > > /sys/devices/pci0000:00/pci_bus/0000:00/bus_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:01.3/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:03.0/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:01.1/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:02.0/dev_rescan
> > > > > > /sys/devices/pci0000:00/0000:00:05.0/dev_rescan
> > > > > > /sys/bus/pci/rescan
> > > > > >
> > > > > > v4.19
> > > > > > # find /sys -name '*rescan'
> > > > > > /sys/devices/pci0000:00/0000:00:01.2/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:01.0/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:04.0/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:00.0/rescan
> > > > > > /sys/devices/pci0000:00/pci_bus/0000:00/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:01.3/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:03.0/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:01.1/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:02.0/rescan
> > > > > > /sys/devices/pci0000:00/0000:00:05.0/rescan
> > > > > > /sys/bus/pci/rescan
> > > > > >
> > > > > > Do we maintain this kind of API as non-changeable?
> > > > >
> > > > > Yeah, that's a bug and should be fixed, sorry for missing that on
> > > > > review.
> > > > >
> > > > > Kelsey, can you fix this up?
> > > > >
> > > > > thanks,
> > > > >
> > > > > greg k-h
> > > >
> > > > I'd be happy to help get this fixed up.
> > > >
> > > > Would it be proper to go back to using DEVICE_ATTR() for 'bus_rescan'
> > > > and 'dev_rescan' in order to change their names back to 'rescan'?
> > >
> > > Yes.
> > >
> > > thanks,
> > >
> > > greg k-h
> >
> >
> > Ack. Sent a patch out. Will stay posted in case any updates need to be made.
> >
> > commit 4cb9e42d3226 ("PCI: sysfs: Change bus_rescan and dev_rescan to rescan")
>
> That's your local commit, not the commit in Linus's tree :)
>
> greg k-h

hah, whoops! Wanted to reference the patch name and didn't think that
through. Maybe would have been better to reference a link to the patch
anyways. :)

https://lore.kernel.org/r/20200324234848.8299-1-skunberg.kelsey@gmail.com

- Kelsey
