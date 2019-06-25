Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4D952910
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2019 12:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbfFYKI4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jun 2019 06:08:56 -0400
Received: from mga18.intel.com ([134.134.136.126]:1243 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726274AbfFYKI4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 25 Jun 2019 06:08:56 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jun 2019 03:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,415,1557212400"; 
   d="scan'208";a="182855506"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 25 Jun 2019 03:08:51 -0700
Received: by lahna (sSMTP sendmail emulation); Tue, 25 Jun 2019 13:08:51 +0300
Date:   Tue, 25 Jun 2019 13:08:51 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/3] PCI / ACPI: Use cached ACPI device state to get
 PCI device power state
Message-ID: <20190625100851.GB2640@lahna.fi.intel.com>
References: <20190618161858.77834-1-mika.westerberg@linux.intel.com>
 <20190620141541.GA257318@google.com>
 <CAJZ5v0hfCnyuAA7kC5-fXRo-Mf0jvGZQASV9T4iK8QxsqHMN_g@mail.gmail.com>
 <1858642.x2LvR771H8@kreacher>
 <20190625094559.GY2640@lahna.fi.intel.com>
 <CAJZ5v0gca0ey-NonUS4vgsv-kXwvnUzhGcDJpVotwscU3wc-nQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gca0ey-NonUS4vgsv-kXwvnUzhGcDJpVotwscU3wc-nQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 25, 2019 at 12:00:57PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jun 25, 2019 at 11:46 AM Mika Westerberg
> <mika.westerberg@linux.intel.com> wrote:
> >
> > On Mon, Jun 24, 2019 at 01:14:47PM +0200, Rafael J. Wysocki wrote:
> > > > The problem here is that acpi_device_get_power() really only should be
> > > > used for two purposes: (1) To initialize adev->power.state, or to
> > > > update it via acpi_device_update_power(), and (2) by the
> > > > "real_power_state" sysfs attribute (of ACPI device objects).  The
> > > > adev->power.state value should be used anywhere else, in principle, so
> > > > the Mika's patch is correct.
> > >
> > > Well, it is an improvement, but it is not sufficient.
> > >
> > > > [Note that adev->power.state cannot be updated after calling
> > > > acpi_device_get_power() to the value returned by it without updating
> > > > the reference counters of the power resources that are "on" *exactly*
> > > > because of the problem at hand here.]
> > >
> > > That is obviously correct, but ->
> > >
> > > > > but that's just an idle thought, not a suggestion.
> > > >
> > > > After the initialization of the ACPI subsystem, the authoritative
> > > > source of the ACPI device power state information is
> > > > adev->power.state.  The ACPI subsystem is expected to update this
> > > > value as needed going forward (including system-wide transitions like
> > > > resume from S3).
> > >
> > > -> the "resume from S3 or hibernation" case needs special handling, because
> > > in that case the device power state need not reflect the information the ACPI
> > > subsystem has.  That only matters if adev->power.state is ACPI_STATE_D0 and
> > > the device is actually *not* in D0, because in that case acpi_device_set_power()
> > > will not work.
> >
> > I guess you are talking about the special-cased devices that we leave in
> > D0 when system suspend (via firmware) is entered?
> >
> > > So that case is not covered currently (it should be rare in practice,
> > > though, if it happens at all), so something like the patch below (untested) may
> > > be needed in addition to the Mika's patch.
> >
> > Looks good to me.
> 
> I actually decided to address this issue in acpi_device_set_power() as
> it may affect devices beyond PCI in principle.  I will send a patch
> for that shortly.

Thanks!

> > > Still, there is also the "power state not matching" case in pci_pm_complete() that's
> > > need to be covered and the non-PCI ACPI PM has a similar issue in theory, so I
> > > need to think about this a bit more.
> >
> > Do you want me to hold off sending an updated version of the patch
> > series while we figure this one out or is it fine if I send it out now
> > and we can add further details on top?
> 
> It is independent of the other fix, so it can be sent now just fine IMO.

OK, I'll send it out in a minute.
