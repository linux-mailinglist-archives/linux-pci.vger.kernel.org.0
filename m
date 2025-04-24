Return-Path: <linux-pci+bounces-26659-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A439BA9A08D
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 07:38:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAA984434DC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Apr 2025 05:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2301819D07E;
	Thu, 24 Apr 2025 05:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B2xSENkG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987181386DA;
	Thu, 24 Apr 2025 05:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745473115; cv=none; b=rrhMZJZ9CeAizoZEcyjQNckkcyBVA4NYjnE5WKVeXVsBj5se9IfA2cIi7ec1fo0aaYAl7eDPnUnlLy1uVjvHlqZSn62D5R0Eu1vc7WP2k5CIMQ5jjYe3Qr3wxUh12pQHYeB23COzOiiW6//HOmFdFdwKwdV15f+UcqCn9htyEq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745473115; c=relaxed/simple;
	bh=iXmhH7LEvP+a3WzJpLspoqdnHe3eFZ45TzT0/aJEZqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DObrNCo6PvBTg4Bb1ML2bsLcuyiBa/Qmr/H7SUjSWnC5SkbhTAzl8viZaHi0HzJgyF7R0hX3uwdpMKBK8/aDN46IjeoEi6aiJPkZ5tml/7TF9sy559e5c905wrCRIyHsOegtFTjlaTxQV7p8dHg6CO9rhu4BhUjNzVDWXDFzVLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B2xSENkG; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745473113; x=1777009113;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=iXmhH7LEvP+a3WzJpLspoqdnHe3eFZ45TzT0/aJEZqY=;
  b=B2xSENkGE6mJH1T70rAiIBABc+kmNn4ADd992hTzJnnPFi0QgeeXyKAu
   XDXlCHGOmDB7RrJTcBna/92AXgUFzAaYR9MBY58gQ1vJZfynR4XZDfaiH
   i5bsbM6rX+oBMgltJI2fccMb1r46wmcE/s5IVNJ+7upjfl49RLN15lpVZ
   G6IzbBHz2M0rL1lJzJneAOQbzSBiZ6kkxRK4yjgkGfB7Q6GaeMhBplG5x
   GlggIAnzWGLeuyiUWv9ADu6B1UG9BTEX7OKGLymZNl79OKc7dVDnLu16s
   PedryFHiYGTdLbpEtdB1vuapv0nfXjDSyIkkoMMQMH9LcI/j/7nqnymy0
   A==;
X-CSE-ConnectionGUID: RearEhf4TYWZS8aDKUhHgA==
X-CSE-MsgGUID: BSI/i4dGQYS7Q7qLcofHTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47103881"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47103881"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:38:32 -0700
X-CSE-ConnectionGUID: rLXYlPurRbSNNVVcMG7GdA==
X-CSE-MsgGUID: pFfJjTHSToCtKd/oQDNncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="132350680"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 22:38:29 -0700
Date: Thu, 24 Apr 2025 08:38:26 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com
Subject: Re: [PATCH v2] PCI/PM: Avoid suspending the device with errors
Message-ID: <aAnOUouuqOC3-Yb8@black.fi.intel.com>
References: <20250422135341.2780925-1-raag.jadav@intel.com>
 <CAJZ5v0gBxkFF-BTTsAM_LHSGq9uuWF2Fq3-jDYPkOhWK4b+qaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0gBxkFF-BTTsAM_LHSGq9uuWF2Fq3-jDYPkOhWK4b+qaw@mail.gmail.com>

On Wed, Apr 23, 2025 at 02:41:52PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 22, 2025 at 3:55 PM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > If an error is triggered before or during system suspend, any bus level
> > power state transition will result in unpredictable behaviour by the
> > device with failed recovery. Avoid suspending such a device and leave
> > it in its existing power state.
> >
> > This only covers the devices that rely on PCI core PM for their power
> > state transition.
> >
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >
> > v2: Synchronize AER handling with PCI PM (Rafael)
> >
> > More discussion on [1].
> > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> >
> >  drivers/pci/pci-driver.c |  3 ++-
> >  drivers/pci/pcie/aer.c   | 11 +++++++++++
> >  include/linux/aer.h      |  2 ++
> >  3 files changed, 15 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> > index f57ea36d125d..289a1fa7cb2d 100644
> > --- a/drivers/pci/pci-driver.c
> > +++ b/drivers/pci/pci-driver.c
> > @@ -884,7 +884,8 @@ static int pci_pm_suspend_noirq(struct device *dev)
> >                 }
> >         }
> >
> > -       if (!pci_dev->state_saved) {
> > +       /* Avoid suspending the device with errors */
> > +       if (!pci_aer_in_progress(pci_dev) && !pci_dev->state_saved) {
> 
> Apart from the potential raciness mentioned by Bjorn, doing it just
> here is questionable because this is not the only place where the PCI
> device power state can change.
> 
> It would be better to catch this in pci_set_low_power_state() IMO.

I'm not sure if we should prevent power state transition for the users
that explicitly want to transition.

Also, the device state can potentially be corrupted because of the errors,
so we'd probably want to avoid pci_save_state() as well, which is what
I attempted here.

Raag

