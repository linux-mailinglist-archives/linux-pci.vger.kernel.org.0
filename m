Return-Path: <linux-pci+bounces-4586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C9D874298
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 23:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0673F1C22770
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 22:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FD41B5BF;
	Wed,  6 Mar 2024 22:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BNQhjo5y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7F41B5A0
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 22:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709763614; cv=none; b=HBVvdIkaSou3wLrOSv0YnZ+8lBLeLwcNnw4iuO/RpGgyvUKELfzhcBM1iYdnuRrT/pFhTuthftEukksrzmWYgis/pt4EH3DDfwEcou8lFsyU75Dg55nP/kYebswSvnnxx+/0hpc7hpBiQXGaKqifrxybGjeXaYi/RI7m/FhFi60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709763614; c=relaxed/simple;
	bh=9eJ6mZZzPaD7RfLL3v7WW0dvUrF/YHahPpVlszX4YKk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lMM3HF9/fH7LWv0ZBh8U+askAasFw1fQA5rRG1VUEC0ULTDY1Xi7ptyLYstE7eoABvaNdZya0gMKtQRmnNjyBl56xdIniRInHfkgrs6pLiMDmSGHQAZp1Ar1HpUIJkRXhyCEvaKxr8xmhiLLNtjvLWI7vloQMgkJzBPS4x6SGO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BNQhjo5y; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709763614; x=1741299614;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9eJ6mZZzPaD7RfLL3v7WW0dvUrF/YHahPpVlszX4YKk=;
  b=BNQhjo5ySQUWa/WIhd6AvJkql0k0cyU2T1Us+c7n/3ZI6Ir1JJnIweSD
   +ESw1xE7MiuHegoCCtGCnOALcW3p5GmNxsCYvpWHwhUKCIW8j2uue4744
   hS0Voo1UrL6Keh637Fjm9mZfm/xy0wUy1KLtIxBVfSIgV/CznDOWVHg7B
   98BzFd4Bf/fN8KnJxew6nt42czo9FPEi6j4eaNh71J6lgyILHaJoPomlV
   OflittA9ptXLH/l8R/09HflI7l6gIw2d04nH2eW9s7+T5HEuBMkSjJAYY
   OoLZHtWZkgYA8AYenj+Ow+DpPko74OtSRbLrC84m+YyWa6pg+BTzFhQbR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11005"; a="14980325"
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="14980325"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 14:20:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,209,1705392000"; 
   d="scan'208";a="9797956"
Received: from patelni-ubuntu-dev.ch.intel.com ([10.2.132.59])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2024 14:20:12 -0800
Message-ID: <46b737db266f08c6dc98c77044bab12491a4d971.camel@linux.intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Enable Hotplug based on BIOS setting on
 VMD rootports
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, linux-pci@vger.kernel.org, 
	"Rafael J. Wysocki"
	 <rjw@rjwysocki.net>, Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 06 Mar 2024 15:27:20 -0700
In-Reply-To: <af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
References: <20240207185549.GA910460@bhelgaas>
	 <af071f45513778a9392efb1a9f41f1e18d2670f0.camel@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

On Tue, 2024-02-13 at 10:47 -0700, Nirmal Patel wrote:
> On Wed, 2024-02-07 at 12:55 -0600, Bjorn Helgaas wrote:
> > On Tue, Feb 06, 2024 at 05:27:29PM -0700, Nirmal Patel wrote:
> > > ...
> > > Did you have a chance to look at my response on January 16th to
> > > your
> > > questions? I tried to summarize all of the potential problems and
> > > issues with different fixes. Please let me know if it is easier
> > > if
> > > I
> > > resend the explanation. Thanks.
> > 
> > I did see your Jan 16 response, thanks.
> > 
> > I had more questions after reading it, but they're more about
> > understanding the topology seen by the host and the guest:
> >   Jan 16: 
> > https://lore.kernel.org/r/20240117004933.GA108810@bhelgaas
> >   Feb  1: 
> > https://lore.kernel.org/r/20240201211620.GA650432@bhelgaas
> > 
> > As I mentioned in my second Feb 1 response
> > (https://lore.kernel.org/r/20240201222245.GA650725@bhelgaas), the
> > usual plan envisioned by the PCI Firmware spec is that an OS can
> > use
> > a
> > PCIe feature if the platform has granted the OS ownership via _OSC
> > and
> > a device advertises the feature via a Capability in config space.
> > 
> > My main concern with the v2 patch
> > (
> > https://lore.kernel.org/r/20231127211729.42668-1-nirmal.patel@linux.intel.com
> > )
> > is that it overrides _OSC for native_pcie_hotplug, but not for any
> > of
> > the other features (AER, PME, LTR, DPC, etc.)
> > 
> > I think it's hard to read the specs and conclude that PCIe hotplug
> > is
> > a special case, and I think we're likely to have similar issues
> > with
> > other features in the future.
> > 
> > But if you think this is the best solution, I'm OK with merging it.
Hi Bjorn,

We tried some other ways to pass the information about all of the flags
but I couldn't retrieve it in guest OS and VMD hardware doesn't have
empty registers to write this information. So as of now we have this
solution which only overwrites Hotplug flag. If you can accept it that
would be great.

Thanks
nirmal.

> I sincerely apologize for late responses. I just found out that my
> evolution mail client is automatically sending linux-pci emails to
> junk
> since January 2024.
> 
> At the moment Hotplug is an exception for us, but I do share your
> concern about other flags. We have done lot of testing and so far
> patch
> v2 is the best solution we have.
> 
> Thanks
> nirmal
> > Bjorn


