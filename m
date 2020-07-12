Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916CF21C6CD
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jul 2020 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727092AbgGLAJE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 20:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726939AbgGLAJE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Jul 2020 20:09:04 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C60ACC08C5DD;
        Sat, 11 Jul 2020 17:09:03 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id e12so7376117qtr.9;
        Sat, 11 Jul 2020 17:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=pou8Xfe98lnWE/rbRKHVE6SyHdTXSqWjqH3LyMm2g1g=;
        b=VS6vv99Vg+bqf95zuX4c+7cQB4qH9c0v2nf/YVV/5Qq7W4TIfgoKhTyLLt6gllzaD2
         2sDIc+gSeKdyaeH2/4iMGWnT8plbBkjDfLgFjWYViZMWB9YKL4GtSkZz70yQFAZAG8F2
         opo6cytCGbpzgnKdVEI2SGN+iIsXI4eU6XpBF1rWFlKxUtShEQYcsVEub/ttLfOP2cvw
         bklV724Jb7ZwSBei3wih3mzvvEvZ+YHxRc/+syR53QZY7B1+mMf8qr6TWML9wNpHoX2Y
         DFgWis5Phn93qJ3N9gOPk1mbtexwwRcKzyev5tpM9UO+t4bWtWEJ3h2vcNNjX8HbzcDU
         oLgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=pou8Xfe98lnWE/rbRKHVE6SyHdTXSqWjqH3LyMm2g1g=;
        b=RxFq4MDKn5EPmRWwDXyKf3tdWoVn+Usj4W3AJBnuOafkgPP20eA4M001LJyGFbxBtA
         /Q2M21i0Y42ocC+xHfhnaDlTbRYSefksmH/ohPR3hgTZZcDTu0qDHRq8MuIJ1qdFbI05
         A5FRAoEJH4RQglYYyIH9yUsMkeCkFr13op+RkiFI1DN/RxLZP6VLIqRgpQTfOaTJo69n
         +onCZ74frtEo6qg9CrrxMY7p8FKiyHdGh7zs+8UKih1H2YGcq5QcKquh+o3bCtwM3/am
         zmj76KjaLxmqZBnpdMqXOUkL1dfmkKNIgZsTJoHcbqZ3Lm4n/gRccnofAz2zZHklHNML
         2n9Q==
X-Gm-Message-State: AOAM531RjuJNpgjrQL8bu9Qy1fEldOiUxCAYgm2fR+3QmldHK+WVLtB/
        8F2TLeQTy8u0rEhlKqnjgqeQsd1oGqcKZehKBPI=
X-Google-Smtp-Source: ABdhPJwGbWSe6AmUoeoFkZuqf2GX8tN/l1kTz2CbVY36DMOxeSmlg58d0fnBi/IgFdweYfqb4tDywCSMUJqdan/2aY4=
X-Received: by 2002:ac8:518b:: with SMTP id c11mr76434264qtn.195.1594512542683;
 Sat, 11 Jul 2020 17:09:02 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
 <20200711195346.GA132330@bjorn-Precision-5520>
In-Reply-To: <20200711195346.GA132330@bjorn-Precision-5520>
Reply-To: rajatxjain@gmail.com
From:   Rajat Jain <rajatxjain@gmail.com>
Date:   Sat, 11 Jul 2020 17:08:51 -0700
Message-ID: <CAA93t1rjzTYmag1vTDT==7GQ8LLduc9Ne06btEEwiyBRtCeTNg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-pci <linux-pci@vger.kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        "Krishnakumar, Lalithambika" <lalithambika.krishnakumar@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 11, 2020 at 12:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Jul 10, 2020 at 03:53:59PM -0700, Rajat Jain wrote:
> > On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > > > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > > > When enabling ACS, enable translation blocking for external facing ports
> > > > > and untrusted devices.
> > > > >
> > > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > > ---
> > > > > v4: Add braces to avoid warning from kernel robot
> > > > >     print warning for only external-facing devices.
> > > > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > > > >     Minor code comments fixes.
> > > > > v2: Commit log change
> > > > >
> > > > >  drivers/pci/pci.c    |  8 ++++++++
> > > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > > >  2 files changed, 23 insertions(+)
> > > > >
> > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > index 73a8627822140..a5a6bea7af7ce 100644
> > > > > --- a/drivers/pci/pci.c
> > > > > +++ b/drivers/pci/pci.c
> > > > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > > > >     /* Upstream Forwarding */
> > > > >     ctrl |= (cap & PCI_ACS_UF);
> > > > >
> > > > > +   /* Enable Translation Blocking for external devices */
> > > > > +   if (dev->external_facing || dev->untrusted) {
> > > > > +           if (cap & PCI_ACS_TB)
> > > > > +                   ctrl |= PCI_ACS_TB;
> > > > > +           else if (dev->external_facing)
> > > > > +                   pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > > > > +   }
> > > >
> > > > IIUC, this means that external devices can *never* use ATS and
> > > > can never cache translations.
> >
> > Yes, but it already exists today (and this patch doesn't change that):
> > 521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"
> >
> > IMHO any external device trying to send ATS traffic despite having ATS
> > disabled should count as a bad intent. And this patch is trying to
> > plug that loophole, by blocking the AT traffic from devices that we do
> > not expect to see AT from anyway.
>
> Thinking about this some more, I wonder if Linux should:
>
>   - Explicitly disable ATS for every device at enumeration-time, e.g.,
>     in pci_init_capabilities(),
>
>   - Enable PCI_ACS_TB for every device (not just external-facing or
>     untrusted ones),
>
>   - Disable PCI_ACS_TB for the relevant devices along the path only
>     when enabling ATS.
>
> One nice thing about doing that is that the "untrusted" test would be
> only in pci_enable_ats(), and we wouldn't need one in
> pci_std_enable_acs().

Yes, this could work.

I think I had thought about this but I'm blanking out on why I had
given it up. I think it was because of the possibility that some
bridges may have "Translation blocking" disabled, even if not all
their descendents were trusted enough to enable ATS on them. But now
thinking about this again, as long as we retain the policy of not
enabling ATS on external devices (and thus enable TB for sure on
them), this should not be a problem. WDYT?

>
> It's possible BIOS gives us devices with ATS enabled, and this might
> break them, but that seems like something we'd want to find out about.
>

Why would they break? We'd disable ATS on each device as we enumerate
them, so they'd be functional, just with ATS disabled until it is
enabled again on internal devices as needed. Which would be WAI
behavior?

Thanks,
,
Rajat




> Bjorn
