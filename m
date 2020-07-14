Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA5521FE6C
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jul 2020 22:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725955AbgGNUTp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Jul 2020 16:19:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbgGNUTp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Jul 2020 16:19:45 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC61C061794
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2020 13:19:44 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id q4so31750lji.2
        for <linux-pci@vger.kernel.org>; Tue, 14 Jul 2020 13:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XWpCwFxzq2ITP3K2PgbPEPYflHGc9CASEeamyGhecg4=;
        b=ktzGRdNHxUc/NOjGB1vSjjeBZhP/eN1zV/MJ3JD8wmxjdxCf0IQ+zpHExTOeKFCy+a
         lkIxtWm6PjqYkFHafKjnDH7YyMKXwotc5q6DnqSw3TopHIRLxHCs+deg6PTyFFdIXYFv
         k7EKTWOzzY2ectIvYgQJoT3PC8WtQ36MwQGEEdeS4yRKsH7OHceijsqk6ydBx4RUmYvR
         IZrllP4JBOp0cXppgKAXu1mmq6yPSvexe7a431gzpco6kw0dfLio0xngHrY49l7HSD+o
         /v/hKsd9rStGhPgfKDu4Tzc6hz5W+DzX3Fs66+EIKtMQGOTLMOIPGhjlXHu/EB8LfYrq
         3KdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XWpCwFxzq2ITP3K2PgbPEPYflHGc9CASEeamyGhecg4=;
        b=P2u+FdAwNvfM2zjch3KAIWi7aAzInmMUmfNgFLBZ/4HXs7gkUuGVbitmmCR7yWtd+7
         szzKXUCrxZ4sQyhZbT9/MMeL4nqCdpotKq12TJ8xcZUynnF/CLVFCMfpRfIlPmEczI6Y
         pLJnv/Lgw2pVIgEg0MM+WYHhaMSFOYIE3fNIBiU3dzMEBkzecDm+AO9daAFRiOjcF0P0
         ovyoz+mp2x6Gs/yGSnuNh7KNl7b9lLUG5fe60qccsDgLCXZxicmYwh3zV1ONcPBLwOA0
         6ATO2agE0NrlvR1l8mC/EweuiUGyIdA4O8DHfXyjr+gCtK9t1vO4R9T9Uw0cOBYvagwc
         9y/g==
X-Gm-Message-State: AOAM533cXixoCl8klj65YtAsFTyw8a0BixRJUgWFwssaBQOS1J2t2HmX
        TBDej9gKW7DSIVH2LWyMmGnYBtgWnXJNXkTaLjIx5w==
X-Google-Smtp-Source: ABdhPJyog1559G29m5pJ504Xf+0cH4eNg4/1fwwOhATAWoZMeuV+BZE2PrcQIEm6ttR2VLYvOaa4/0qm67q9Isa6wdw=
X-Received: by 2002:a2e:8199:: with SMTP id e25mr2844648ljg.307.1594757982632;
 Tue, 14 Jul 2020 13:19:42 -0700 (PDT)
MIME-Version: 1.0
References: <CACK8Z6F-8OZNJU8wqWuZq=moCaOi+3W=CzBeppfO31VZnkqBrg@mail.gmail.com>
 <20200711195346.GA132330@bjorn-Precision-5520>
In-Reply-To: <20200711195346.GA132330@bjorn-Precision-5520>
From:   Rajat Jain <rajatja@google.com>
Date:   Tue, 14 Jul 2020 13:19:05 -0700
Message-ID: <CACK8Z6HP1VHs4P=U6-+D_D8HrQ5D1P679P_=saNqUMXE-bNUjg@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for untrusted/external-facing
 devices
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Raj, Ashok" <ashok.raj@intel.com>,
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
        Rajat Jain <rajatxjain@gmail.com>,
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

Sent out v5 with this approach here:
https://patchwork.kernel.org/patch/11663515/

Thanks,

Rajat

>
>
> It's possible BIOS gives us devices with ATS enabled, and this might
> break them, but that seems like something we'd want to find out about.
>
> Bjorn
