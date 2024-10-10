Return-Path: <linux-pci+bounces-14132-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 840DB997C02
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 06:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DDC1C22A3D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 04:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCCE619D072;
	Thu, 10 Oct 2024 04:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Uo7clEvs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0827339AB;
	Thu, 10 Oct 2024 04:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728535930; cv=none; b=rqFLxHlsiB8M9S/Mfy3/FfE9/E8s9LOoIfOLzcBjy2eJyQJZQvPfukpc8mnNeW3bxHub9Dy4Jf/j1hicgvXejjq6CDQx1lgQXoIPLOFNaK3AneSggqHqGbHo02f5EQNyviDXBUkuArbYycLoLfX/5oUK0Z+baBYFVNdwle1Wshw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728535930; c=relaxed/simple;
	bh=vG+z0hB9QOJAHw7x1DQKho8mZLiIEA5OhquV4KvSbaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZwSNEpOAEn8Q6tTYPnHNcUNjU0txABZTOikZqSIs0Zo2Ua9Zbh/2mr3vr/bPxJUAggCjU3Dxx7y6boLYPeCCOOeQDR6zv/GnsIMhkFlF7R3mAPhoT3bF2aW3ko/G20tVTV/B05Er7JsFyatlxGzDQ0yEqKwYzdnvkCGGOQWExhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Uo7clEvs; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728535929; x=1760071929;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vG+z0hB9QOJAHw7x1DQKho8mZLiIEA5OhquV4KvSbaI=;
  b=Uo7clEvsazoVhJBGvKkdJhIAys22eRiBJ0OXT1SpifV84PPEw/359RM5
   m3+P+JPluDOnnqH0RSxwRrtt2dta6xSKwR6ScsZVaxW8pG83Lf0sbkOH5
   Zii5E4XOQ6p+RGD7HTg+VdmI+HR+M8tQtCaQX/aqP+XwyWSE3q2QLdjKq
   a1dSH7vkVNk56wB20u6es+lbBzafGrKbEE+6Wcak/6MMtRcdOI95zJ6aR
   h8ytr8xOxp523WQKEenCbBN1oBsuG/yqJpvtFIxFw9QMEiIfxcZ0YpohJ
   /Q7b2g5NBaInP2/VJ9NsHEGfLiRKOLC0zLa3nAixIbMefqbJkulxYTsO7
   g==;
X-CSE-ConnectionGUID: 83kku5j0S2SmU9k1GTuENQ==
X-CSE-MsgGUID: qrKsjTjdRGGTgC/nIR/+Zw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="39264005"
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="39264005"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 21:52:08 -0700
X-CSE-ConnectionGUID: /DGeCitOQ7+oGY3FaPEeUA==
X-CSE-MsgGUID: J+o820GlQ96eYYYvJipFbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,191,1725346800"; 
   d="scan'208";a="77296249"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa008.jf.intel.com with ESMTP; 09 Oct 2024 21:52:05 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 7D3ED192; Thu, 10 Oct 2024 07:52:04 +0300 (EEST)
Date: Thu, 10 Oct 2024 07:52:04 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kai-Heng Feng <kaihengfeng@gmail.com>, bhelgaas@google.com,
	mario.limonciello@amd.com, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI/PM: Put devices to low power state on shutdown
Message-ID: <20241010045204.GE275077@black.fi.intel.com>
References: <20240913080123.GP275077@black.fi.intel.com>
 <20241009222403.GA507767@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241009222403.GA507767@bhelgaas>

On Wed, Oct 09, 2024 at 05:24:03PM -0500, Bjorn Helgaas wrote:
> On Fri, Sep 13, 2024 at 11:01:23AM +0300, Mika Westerberg wrote:
> > On Fri, Sep 13, 2024 at 02:00:58PM +0800, Kai-Heng Feng wrote:
> > > On Fri, Sep 13, 2024 at 12:57 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > On Thu, Sep 12, 2024 at 11:00:43AM +0800, Kai-Heng Feng wrote:
> > > > > On Thu, Sep 12, 2024 at 3:05 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > On Fri, Jul 12, 2024 at 02:24:11PM +0800, Kai-Heng Feng wrote:
> > > > > > > Some laptops wake up after poweroff when HP Thunderbolt
> > > > > > > Dock G4 is connected.
> > > > > > >
> > > > > > > The following error message can be found during shutdown:
> > > > > > > pcieport 0000:00:1d.0: AER: Correctable error message received from 0000:09:04.0
> > > > > > > pcieport 0000:09:04.0: PCIe Bus Error: severity=Correctable, type=Data Link Layer, (Receiver ID)
> > > > > > > pcieport 0000:09:04.0:   device [8086:0b26] error status/mask=00000080/00002000
> > > > > > > pcieport 0000:09:04.0:    [ 7] BadDLLP
> > > > > > >
> > > > > > > Calling aer_remove() during shutdown can quiesce the error
> > > > > > > message, however the spurious wakeup still happens.
> > > > > > >
> > > > > > > The issue won't happen if the device is in D3 before
> > > > > > > system shutdown, so putting device to low power state
> > > > > > > before shutdown to solve the issue.
> > > > > > >
> > > > > > > I don't have a sniffer so this is purely guesswork,
> > > > > > > however I believe putting device to low power state it's
> > > > > > > the right thing to do.
> > > > > >
> > > > > > My objection here is that we don't have an explanation of
> > > > > > why this should matter or a pointer to any spec language
> > > > > > about this situation, so it feels a little bit random.
> > ...
> 
> > I don't mean to confuse you guys but with this one too, I wonder if you
> > tried to "disable" the device instead of putting it into D3? On another
> > thread (Mario at least is aware of this) I mentioned that our PCIe SV
> > folks identified a couple issues in Linux implementation around power
> > management and one thing that we are missing is to disable I/O and MMIO
> > upon entering D3.
> > ...
> 
> This is really interesting -- did they discover a functional problem,
> or did they just notice that we don't follow the PCI PM spec?

The latter.

> > +++ b/drivers/pci/pci.c
> > @@ -2218,6 +2218,13 @@ static void do_pci_disable_device(struct pci_dev *dev)
> >  		pci_command &= ~PCI_COMMAND_MASTER;
> >  		pci_write_config_word(dev, PCI_COMMAND, pci_command);
> >  	}
> > +	/*
> > +	 * PCI PM 1.2 sec 8.2.2 says that when a function is put into D3
> > +	 * the OS needs to disable I/O and MMIO space in addition to bus
> > +	 * mastering so do that here.
> > +	 */
> > +	pci_command &= ~(PCI_COMMAND_IO | PCI_COMMAND_MEMORY);
> > +	pci_write_config_word(dev, PCI_COMMAND, pci_command);
> >  
> >  	pcibios_disable_device(dev);
> >  }
> 
> This do_pci_disable_device() proposal is interesting.
> 
> pci_enable_device() turns on PCI_COMMAND_MEMORY and PCI_COMMAND_IO,
> which enables the device to respond to MMIO and I/O port accesses to
> its BARs from the driver.  It also makes sure the device is in D0,
> because BAR access only works in D0.
> 
> pci_set_master() turns on PCI_COMMAND_MASTER, which enables the device
> to perform DMA (including generating MSIs).
> 
> pci_disable_device() *sounds* like it should be the opposite of
> pci_enable_device(), but it's currently basically the same as
> pci_clear_master(), which clears PCI_COMMAND_MASTER to prevent DMA.
> I didn't know about this text in 8.2.2, and I wish I knew why we
> don't currently clear PCI_COMMAND_MEMORY and PCI_COMMAND_IO.
> 
> If we want to pursue this, I think it should be split to its own patch
> and moved out of pci_disable_device() because I don't think this path
> necessary implies putting the device in D3, so I think it would fit
> better with the spec if we cleared PCI_COMMAND_MEMORY and
> PCI_COMMAND_IO in a path that explicitly does put it in D3.
> 
> I think there's a significant chance of breaking something because
> drivers are currently able to access BARs after pci_disable_device(),
> and there are a LOT of callers.  But if there's a problem it would
> fix, we should definitely explore it.

At the moment it does not seem to fix anything as far as I can tell so
not sure how important it is. Of course from spec perspective we should
probably deal with it.

