Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F2C21C702
	for <lists+linux-pci@lfdr.de>; Sun, 12 Jul 2020 04:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgGLC6l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Jul 2020 22:58:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726948AbgGLC6l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 11 Jul 2020 22:58:41 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1ABD206F4;
        Sun, 12 Jul 2020 02:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594522720;
        bh=GCEYp34kfSIsAhwGdytjjpiuDjkxNS2Pq5Ga4nERay0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T7qkaNOSVPVMA1p+OUXR50mxJVKqp+kGpnsAUcwYjmoxKigEkZ+C9uni48nxvzaCc
         vAD4IUBoFIROp4tLxDovrohgR/tnB9hES1edKw0SsJHM9b8vFAzpkFRAVOCGPqNZr3
         feY7YyKAtniCs6zD1STAzEXbVZz+eK3O5AsWgdgg=
Date:   Sat, 11 Jul 2020 21:58:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rajat Jain <rajatxjain@gmail.com>
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
        Oliver O'Halloran <oohall@gmail.com>,
        Saravana Kannan <saravanak@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: Re: [PATCH v4 4/4] PCI/ACS: Enable PCI_ACS_TB for
 untrusted/external-facing devices
Message-ID: <20200712025838.GA147150@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA93t1rjzTYmag1vTDT==7GQ8LLduc9Ne06btEEwiyBRtCeTNg@mail.gmail.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Jul 11, 2020 at 05:08:51PM -0700, Rajat Jain wrote:
> On Sat, Jul 11, 2020 at 12:53 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Jul 10, 2020 at 03:53:59PM -0700, Rajat Jain wrote:
> > > On Fri, Jul 10, 2020 at 2:29 PM Raj, Ashok <ashok.raj@intel.com> wrote:
> > > > On Fri, Jul 10, 2020 at 03:29:22PM -0500, Bjorn Helgaas wrote:
> > > > > On Tue, Jul 07, 2020 at 03:46:04PM -0700, Rajat Jain wrote:
> > > > > > When enabling ACS, enable translation blocking for external facing ports
> > > > > > and untrusted devices.
> > > > > >
> > > > > > Signed-off-by: Rajat Jain <rajatja@google.com>
> > > > > > ---
> > > > > > v4: Add braces to avoid warning from kernel robot
> > > > > >     print warning for only external-facing devices.
> > > > > > v3: print warning if ACS_TB not supported on external-facing/untrusted ports.
> > > > > >     Minor code comments fixes.
> > > > > > v2: Commit log change
> > > > > >
> > > > > >  drivers/pci/pci.c    |  8 ++++++++
> > > > > >  drivers/pci/quirks.c | 15 +++++++++++++++
> > > > > >  2 files changed, 23 insertions(+)
> > > > > >
> > > > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > > > index 73a8627822140..a5a6bea7af7ce 100644
> > > > > > --- a/drivers/pci/pci.c
> > > > > > +++ b/drivers/pci/pci.c
> > > > > > @@ -876,6 +876,14 @@ static void pci_std_enable_acs(struct pci_dev *dev)
> > > > > >     /* Upstream Forwarding */
> > > > > >     ctrl |= (cap & PCI_ACS_UF);
> > > > > >
> > > > > > +   /* Enable Translation Blocking for external devices */
> > > > > > +   if (dev->external_facing || dev->untrusted) {
> > > > > > +           if (cap & PCI_ACS_TB)
> > > > > > +                   ctrl |= PCI_ACS_TB;
> > > > > > +           else if (dev->external_facing)
> > > > > > +                   pci_warn(dev, "ACS: No Translation Blocking on external-facing dev\n");
> > > > > > +   }
> > > > >
> > > > > IIUC, this means that external devices can *never* use ATS and
> > > > > can never cache translations.
> > >
> > > Yes, but it already exists today (and this patch doesn't change that):
> > > 521376741b2c2 "PCI/ATS: Only enable ATS for trusted devices"
> > >
> > > IMHO any external device trying to send ATS traffic despite having ATS
> > > disabled should count as a bad intent. And this patch is trying to
> > > plug that loophole, by blocking the AT traffic from devices that we do
> > > not expect to see AT from anyway.
> >
> > Thinking about this some more, I wonder if Linux should:
> >
> >   - Explicitly disable ATS for every device at enumeration-time, e.g.,
> >     in pci_init_capabilities(),
> >
> >   - Enable PCI_ACS_TB for every device (not just external-facing or
> >     untrusted ones),
> >
> >   - Disable PCI_ACS_TB for the relevant devices along the path only
> >     when enabling ATS.
> >
> > One nice thing about doing that is that the "untrusted" test would be
> > only in pci_enable_ats(), and we wouldn't need one in
> > pci_std_enable_acs().
> 
> Yes, this could work.
> 
> I think I had thought about this but I'm blanking out on why I had
> given it up. I think it was because of the possibility that some
> bridges may have "Translation blocking" disabled, even if not all
> their descendents were trusted enough to enable ATS on them. But now
> thinking about this again, as long as we retain the policy of not
> enabling ATS on external devices (and thus enable TB for sure on
> them), this should not be a problem. WDYT?

I think I would feel better if we always enabled Translation Blocking
except when we actually need it for ATS.  But I'm not confident about
how all the pieces of ATS work, so I could be missing something.

> > It's possible BIOS gives us devices with ATS enabled, and this
> > might break them, but that seems like something we'd want to find
> > out about.
> 
> Why would they break? We'd disable ATS on each device as we
> enumerate them, so they'd be functional, just with ATS disabled
> until it is enabled again on internal devices as needed. Which would
> be WAI behavior?

If BIOS handed off with ATS enabled and we somehow relied on it being
already enabled, something might break if we start disabling ATS.
Just a theoretical possibility, doesn't seem likely to me.

Bjorn
