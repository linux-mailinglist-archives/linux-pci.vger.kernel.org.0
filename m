Return-Path: <linux-pci+bounces-26832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EE6A9DD11
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FFC37A1E34
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E7201F3B96;
	Sat, 26 Apr 2025 20:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LeCyze1A"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04B3208D0;
	Sat, 26 Apr 2025 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745698701; cv=none; b=EwdMbu/GtKGw6KBQk5HFk9TtySwxX6MeylPLZxwFrv5sF8LzO8RJcMnak1Hiz5x9CugGzjuob0M1KGJ4ul/siOOEC1bwLWVf9bfj5tZyqsRSgXl8gjWm1Iv32OhzeinifxluiPEYtwcQoLwERIAKJrmAuif7VrBVoxhv72ZzWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745698701; c=relaxed/simple;
	bh=4Fk/IkIuStiddSyfw197+X3em/h6D+b1+cRGuM95Ow8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dB4S/bkVs+AbWsV4/c3DBB+jPnSFkWabIx50V+xX+mTBjUE53JVb5q7InaPFWXAhw9zvJVPTTkApm/lvwNnKepGjQRIKf1CTD1few6++B7QEHWklKyzOGOyIDD/i6JRFa+R3CAIAp3QdprEVDvMZSZwgaSEBY9tb/6xL2Pvm3/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LeCyze1A; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745698700; x=1777234700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=4Fk/IkIuStiddSyfw197+X3em/h6D+b1+cRGuM95Ow8=;
  b=LeCyze1A3Y/m5PFAz72BJqKkL4LK51BR19oiW34wsvVQzc+ek0cqOl6Z
   tOfdKMUYOq9f6/nYTfDgljf8b3xMQyyIHEglhjXacCJCI4YabF7mZBazg
   I0RqVqa0qVDCSkzMUruHfJ3XaR2TRb6I9nKu09ayqsr0y8sSAUSFWqDwc
   MBmwhT1dfQOexIAHfNePiwRzM9NS8bKtvNswmDId4galVQLQ6/vUuMwV/
   TJJ7mDz0UZnAvH2kzGE0OvA4/F2ItQRT6XSLAYyiPhMAyDcDxyCI6KBjp
   oIyYCp410ue7LoMgU/AonVi3kX22yEFploXVz1QUMc1As9vhUbq3kZm6G
   Q==;
X-CSE-ConnectionGUID: ydnlnfgHTKyHfrbFho249A==
X-CSE-MsgGUID: tTcAwgKZQCKI8Bx/jramJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11415"; a="72703998"
X-IronPort-AV: E=Sophos;i="6.15,242,1739865600"; 
   d="scan'208";a="72703998"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 13:18:19 -0700
X-CSE-ConnectionGUID: nTYR6p5rSLqV/3tlqZDhAw==
X-CSE-MsgGUID: GVwQoFHATSuMmBPdXcFyHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,242,1739865600"; 
   d="scan'208";a="134107962"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 13:18:16 -0700
Date: Sat, 26 Apr 2025 23:18:13 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Message-ID: <aA0_hUh9cUuP-tgV@black.fi.intel.com>
References: <20250422135341.2780925-1-raag.jadav@intel.com>
 <CAJZ5v0gBxkFF-BTTsAM_LHSGq9uuWF2Fq3-jDYPkOhWK4b+qaw@mail.gmail.com>
 <aAnOUouuqOC3-Yb8@black.fi.intel.com>
 <CAJZ5v0gQ-6ZehL5HNhFvOWDEyXdS++uaMn1AOB7whoMTKzj-ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gQ-6ZehL5HNhFvOWDEyXdS++uaMn1AOB7whoMTKzj-ZQ@mail.gmail.com>

On Thu, Apr 24, 2025 at 01:02:58PM +0200, Rafael J. Wysocki wrote:
> On Thu, Apr 24, 2025 at 7:38 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > On Wed, Apr 23, 2025 at 02:41:52PM +0200, Rafael J. Wysocki wrote:
> > > On Tue, Apr 22, 2025 at 3:55 PM Raag Jadav <raag.jadav@intel.com> wrote:
> > > >
> > > > If an error is triggered before or during system suspend, any bus level
> > > > power state transition will result in unpredictable behaviour by the
> > > > device with failed recovery. Avoid suspending such a device and leave
> > > > it in its existing power state.
> > > >
> > > > This only covers the devices that rely on PCI core PM for their power
> > > > state transition.
> > > >
> > > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > > ---
> > > >
> > > > v2: Synchronize AER handling with PCI PM (Rafael)
> > > >
> > > > More discussion on [1].
> > > > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> > > >
> > > >  drivers/pci/pci-driver.c |  3 ++-
> > > >  drivers/pci/pcie/aer.c   | 11 +++++++++++
> > > >  include/linux/aer.h      |  2 ++
> > > >  3 files changed, 15 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > > > index f57ea36d125d..289a1fa7cb2d 100644
> > > > --- a/drivers/pci/pci-driver.c
> > > > +++ b/drivers/pci/pci-driver.c
> > > > @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
> > > >                 }
> > > >         }
> > > >
> > > > -       if (!pci_dev->state_saved) {
> > > > +       /* Avoid suspending the device with errors */
> > > > +       if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
> > >
> > > Apart from the potential raciness mentioned by Bjorn, doing it just
> > > here is questionable because this is not the only place where the PCI
> > > device power state can change.
> > >
> > > It would be better to catch this in pci_set_low_power_state() IMO.
> >
> > I'm not sure if we should prevent power state transition for the users
> > that explicitly want to transition.
> >
> > Also, the device state can potentially be corrupted because of the errors,
> > so we'd probably want to avoid pci_save_state() as well, which is what
> > I attempted here.
> 
> But it's not what the changelog is saying.
> 
> If you want to avoid pci_save_state(), there are also other places
> when it is called and then you also may want to avoid the transition
> because if the state is not saved, it won't be possible to restore it.

Yes, above logic will skip both pci_save_state() and pci_prepare_to_sleep()
and in turn set skip_bus_pm flag to prevent power state transition.

Considering we're targeting only system PM cases, I could find pci_save_state()
being used in pci_pm_suspend_noirq() and pci_pm_freeze_noirq() (excluding
legacy suspend). pci_pm_freeze_noirq() doesn't seem to attempt any power state
transition by itself, so any other cases that you think are worth being covered
here?

Raag

