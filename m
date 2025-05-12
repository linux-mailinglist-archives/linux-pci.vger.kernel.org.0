Return-Path: <linux-pci+bounces-27594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2896AB3E16
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 18:52:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CE26188E89D
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 16:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5AC2528FC;
	Mon, 12 May 2025 16:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HVYuGRhz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEA6A86352;
	Mon, 12 May 2025 16:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747068757; cv=none; b=k+72m3EYnh0YakPEKblWqk0ZEV+lAdCYdRJji1YdD0O8/GQDOUJwa+QxJ+75PbplgogRE3V5mQsBu0PL0YBVvBSyGwhT7Apri/3hZy9Z9OlUZpCX8031dvvCvAsNS5cfKZ2V9yl9EDmgYLjRiZNBJ/0DmA4YXGjiuEIDapl84nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747068757; c=relaxed/simple;
	bh=zJdYMJvHAhiYNICNPNsqH0wboKMQjcSXHu6LIl5OWXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvikDwo/Y8KhQM5ICkNVdQLJGctLgOgv0XnnopY7xKTzOF3dKEU3D8V3+lVvhQ+BZQ5DK1K+KgG/OxV3YeruUayH9z2SeWXtfTJiPfoVAluBjtV2pSlIQ9q3ymsNCUyUt/I6n4tH41UhsXpzMOxeqVwcDJvTgyCeW5J8UM1CpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HVYuGRhz; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747068756; x=1778604756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=zJdYMJvHAhiYNICNPNsqH0wboKMQjcSXHu6LIl5OWXM=;
  b=HVYuGRhzzNMl5Vmet90ynDOG8GQWtYn0dDOM0tSnbLdVpMmJ7eSsqKbH
   yvtIdKv20wUhk5vSBvZG7n8CRcsoru3ftu8wJiyEQveKlWnK8/2cai0h1
   jXsupKK2jgljBJrJtn8AN9frHve8m/171mkiGqRaWKkdw/LyPdE738g1c
   ZC2c2DR3A+nUluTMwnczMpPgJ1MnRvkSQ06Vr/QVgqL/WSnq5NisD+gXz
   yOs8/rvxkPE9KDDxLvrYOtI07psKnx7nmUlavjYOrxzgwQjjVU15RYyk2
   Naiz0pfM9/YRykan6N4emlRJolfQ/4o+DXuF/7MQwduAqA1Mm5exHlUHT
   A==;
X-CSE-ConnectionGUID: j/U7GCE2RB6B1V7ZLD4Mfg==
X-CSE-MsgGUID: QtItMCc4SoKW7969fIKcig==
X-IronPort-AV: E=McAfee;i="6700,10204,11431"; a="48746422"
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="48746422"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 09:52:35 -0700
X-CSE-ConnectionGUID: EZtLRt6xQlWRKBPzEUstcA==
X-CSE-MsgGUID: EStaK6KASbaX2HgLRFV9VA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,282,1739865600"; 
   d="scan'208";a="137941382"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2025 09:52:33 -0700
Date: Mon, 12 May 2025 19:52:29 +0300
From: Raag Jadav <raag.jadav@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: mahesh@linux.ibm.com, oohall@gmail.com, bhelgaas@google.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	ilpo.jarvinen@linux.intel.com, lukas@wunner.de,
	aravind.iddamsetty@linux.intel.com, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3] PCI: Prevent power state transition of erroneous
 device
Message-ID: <aCInTU5BmL0botSd@black.fi.intel.com>
References: <20250504090444.3347952-1-raag.jadav@intel.com>
 <CAJZ5v0hgpq0VmO_rDnEjDQniUiLJP3yo3-Rpy1NNxA_k8VAS2A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0hgpq0VmO_rDnEjDQniUiLJP3yo3-Rpy1NNxA_k8VAS2A@mail.gmail.com>

On Mon, May 12, 2025 at 01:56:06PM +0200, Rafael J. Wysocki wrote:
> On Sun, May 4, 2025 at 11:06 AM Raag Jadav <raag.jadav@intel.com> wrote:
> >
> > If error flags are set on an AER capable device, most likely either the
> > device recovery is in progress or has already failed. Neither of the
> > cases are well suited for power state transition of the device, since
> > this can lead to unpredictable consequences like resume failure, or in
> > worst case the device is lost because of it. Leave the device in its
> > existing power state to avoid such issues.
> >
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > ---
> >
> > v2: Synchronize AER handling with PCI PM (Rafael)
> > v3: Move pci_aer_in_progress() to pci_set_low_power_state() (Rafael)
> >     Elaborate "why" (Bjorn)
> 
> I think this is reasonable, so
> 
> Acked-by: Rafael J. Wysocki <rafael@kernel.org>

Thank you!

> (and you might as well CC it to linux-pm@vger.kernel.org>).

Cc'ing linux-pm list as requested by Rafael.

> > More discussion on [1].
> > [1] https://lore.kernel.org/all/CAJZ5v0g-aJXfVH+Uc=9eRPuW08t-6PwzdyMXsC6FZRKYJtY03Q@mail.gmail.com/
> >
> >  drivers/pci/pci.c      | 12 ++++++++++++
> >  drivers/pci/pcie/aer.c | 11 +++++++++++
> >  include/linux/aer.h    |  2 ++
> >  3 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 4d7c9f64ea24..25b2df34336c 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -9,6 +9,7 @@
> >   */
> >
> >  #include <linux/acpi.h>
> > +#include <linux/aer.h>
> >  #include <linux/kernel.h>
> >  #include <linux/delay.h>
> >  #include <linux/dmi.h>
> > @@ -1539,6 +1540,17 @@ static int pci_set_low_power_state(struct pci_dev *dev, pci_power_t state, bool
> >            || (state == PCI_D2 && !dev->d2_support))
> >                 return -EIO;
> >
> > +       /*
> > +        * If error flags are set on an AER capable device, most likely either
> > +        * the device recovery is in progress or has already failed. Neither of
> > +        * the cases are well suited for power state transition of the device,
> > +        * since this can lead to unpredictable consequences like resume
> > +        * failure, or in worst case the device is lost because of it. Leave the
> > +        * device in its existing power state to avoid such issues.
> > +        */
> > +       if (pci_aer_in_progress(dev))
> > +               return -EIO;
> > +
> >         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> >         if (PCI_POSSIBLE_ERROR(pmcsr)) {
> >                 pci_err(dev, "Unable to change power state from %s to %s, device inaccessible\n",
> > diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> > index a1cf8c7ef628..4040770df4f0 100644
> > --- a/drivers/pci/pcie/aer.c
> > +++ b/drivers/pci/pcie/aer.c
> > @@ -237,6 +237,17 @@ int pcie_aer_is_native(struct pci_dev *dev)
> >  }
> >  EXPORT_SYMBOL_NS_GPL(pcie_aer_is_native, "CXL");
> >
> > +bool pci_aer_in_progress(struct pci_dev *dev)
> > +{
> > +       u16 reg16;
> > +
> > +       if (!pcie_aer_is_native(dev))
> > +               return false;
> > +
> > +       pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &reg16);
> > +       return !!(reg16 & PCI_EXP_AER_FLAGS);
> > +}
> > +
> >  static int pci_enable_pcie_error_reporting(struct pci_dev *dev)
> >  {
> >         int rc;
> > diff --git a/include/linux/aer.h b/include/linux/aer.h
> > index 02940be66324..e6a380bb2e68 100644
> > --- a/include/linux/aer.h
> > +++ b/include/linux/aer.h
> > @@ -56,12 +56,14 @@ struct aer_capability_regs {
> >  #if defined(CONFIG_PCIEAER)
> >  int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
> >  int pcie_aer_is_native(struct pci_dev *dev);
> > +bool pci_aer_in_progress(struct pci_dev *dev);
> >  #else
> >  static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
> >  {
> >         return -EINVAL;
> >  }
> >  static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
> > +static inline bool pci_aer_in_progress(struct pci_dev *dev) { return false; }
> >  #endif
> >
> >  void pci_print_aer(struct pci_dev *dev, int aer_severity,
> > --
> > 2.34.1
> >

