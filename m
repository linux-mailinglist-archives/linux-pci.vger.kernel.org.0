Return-Path: <linux-pci+bounces-12843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D7D96DEFC
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 17:56:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 192381F23D8F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 15:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185D919E7D8;
	Thu,  5 Sep 2024 15:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGQUZ47q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CAF39FC5;
	Thu,  5 Sep 2024 15:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725551793; cv=none; b=IqIav5pWa7uXAcJfmcf2newbCM3pP3T54nLrbpeuDk87CEXnyOenJx0oGCHudUpuMrhnwc/Gh0ku0RwynzoEfynaRqqvxRl2WSDNQyM+hk0gjofRJmrekHDedNDEjD4QmdbcKGKvURvah2uWocZnmNOXXCQJvqtEbi7MyUKViUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725551793; c=relaxed/simple;
	bh=SbiTllZxgjb4Z1LIvyrQY8muQQ4twsbvg/wM/LIgpFA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LG8hQlUdjAT0wKD76bpEbXs5t3jEhh+UhoKtDye/hUJSN7aRO42L1Ak2mEAVoW4KWTz/r/PU+EP0CmHf3/XlQq6KJkSWynEgxHBijl899RIzTiSumlGvAy2iSN/O2+rdi/KZ+iebNtLNUC+Pdf1Vyw5O06xuCtXaLZsAEoHByLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGQUZ47q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3910CC4CEC3;
	Thu,  5 Sep 2024 15:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725551791;
	bh=SbiTllZxgjb4Z1LIvyrQY8muQQ4twsbvg/wM/LIgpFA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PGQUZ47qOlkivM3ccuS+8SWeD5qbn9BbY+rd3e0/I8zh9E6QuDm97fyLOEntEp8v5
	 agrNCunp5cXCKs+3qJ/BJJHWNzieyJtIvqvVB2mkbrIjwb9WR9k4BA1uY3yvI0DtIQ
	 d6CPoeY565B6eMnx8OPGQV7eoQRTjGs+7PI6Bm8g65QS9Hfj35yaLxB/bkFQNbRxo3
	 Hgh2e037JwEvcipMqA7efA0ZJqUHx9CxdisiZtbSsBh1Jk3ErfqCYLysYpq3nWo0yc
	 HRwpfHAsSyMB8oXi8HLEyOqUcyEb7m9rpuPz34H629j7JWlhamoDe4HA+S8T9+nqpg
	 bQTmWM8O7oSNA==
Date: Thu, 5 Sep 2024 10:56:29 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
Cc: Tony Hutter <hutter2@llnl.gov>, bhelgaas@google.com, minyard@acm.org,
	linux-pci@vger.kernel.org, openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <20240905155629.GA389032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905081925.00001d14@linux.intel.com>

On Thu, Sep 05, 2024 at 08:19:25AM +0200, Mariusz Tkaczyk wrote:
> On Tue, 3 Sep 2024 17:18:20 -0500
> Bjorn Helgaas <helgaas@kernel.org> wrote:
> 
> > On Tue, Aug 27, 2024 at 02:03:48PM -0700, Tony Hutter wrote:
> > > Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> > > The driver provides hotplug attention status callbacks for the 24 NVMe
> > > slots on the E1000.  This allows users to access the E1000's locate and
> > > fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> > > entries.  This driver uses IPMI to communicate with the E1000 controller to
> > > toggle the LEDs.  
> > 
> > I hope/assume the interface is the same as one of the others, i.e.,
> > the existing one added for NVMe behind VMD by
> > https://git.kernel.org/linus/576243b3f9ea ("PCI: pciehp: Allow
> > exclusive userspace control of indicators") or the new one for NPEM
> > and the _DSM at
> > https://lore.kernel.org/linux-pci/20240814122900.13525-3-mariusz.tkaczyk@linux.intel.com/
> > 
> > I suppose we intend that the ledmon utility will be able to drive
> > these LEDs?  Whatever the user, we should try to minimize the number
> > of different interfaces for this functionality.
> 
> Ledmon won't support it, at least not in current form. Ledmon
> support for pciehp attention is limited to VMD, i.e. first we must
> find VMD driver then we are looking for slot/attention.  I'm not
> familiar with any attempt to add support for this in ledmon.
> 
> From the end user perspective, I don't like pciehp/attention because
> we are refereeing to pciehp driver not pcieport and to determine
> proper slot we need to do additional matching by slot/address. I
> would be simpler.
> https://github.com/intel/ledmon/blob/main/src/lib/vmdssd.c#L100

All I'm trying to say is that NPEM, the related _DSM, and the VMD
special case are all ways to control NVMe slot IDs.  This Cray thing
is another.  We already have two user interfaces (the NPEM/_DSM one
and the VMD one), and I'd like to avoid adding a third.

