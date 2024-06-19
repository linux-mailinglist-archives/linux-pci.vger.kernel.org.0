Return-Path: <linux-pci+bounces-8975-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 599B390EA62
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 14:07:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D6791C216E7
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 12:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B330B13D297;
	Wed, 19 Jun 2024 12:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bov0gpWJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AEF20B34
	for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2024 12:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798859; cv=none; b=hUX4jFbf+9PIbs+VUz4JRIt/wfW6R5wBtOA6trCNJYxVH47NmEZaFUfU2+p+L0W0b83Xr5Egw0HS87hlVPLGhhIcOWRoowoYJGiFtgHMJQucbkiLm3VK6AhTdSkMeqyqmKYY6GhFkwhlcaY6eOlNBylELnfCj70qhQacY1KSm3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798859; c=relaxed/simple;
	bh=JIJyUxg1hHLWpaDrTaYtA6wRXVsS7EVlY5UzlQ+9j0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lB5i+18Yz5eSb77yQ5RUlJRFJHFKZVfFC/qiNWJOQS+xBDsd8FQIgnWtB5eLmOwX21wa5l22/4o5ZuOSlsLknhtuxNufGSoYQkC1kLsRuIxlE8T9nV1sENGzh5+BPJwW10zv4OnC/4U2LIu54aVS3+tmO0iSKud/g/1jW137vXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bov0gpWJ; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718798858; x=1750334858;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JIJyUxg1hHLWpaDrTaYtA6wRXVsS7EVlY5UzlQ+9j0w=;
  b=bov0gpWJ4yTqykNdP1QN1RM6XUJJrRwQzqVDCqlSpzf6zJUrrTGPrhNh
   NAMmTbTHhPfkXVWDqNFc3nCk84jRvfCriNO7kcasoSvKHokbnnomyKkVQ
   oaPMfB4GC9mUxKA2rS0sVe/KN/FWJMZPH34HVYdYfZZlCS9nqLG8hrl6U
   7R4SKrHoaqhN3963NaCRxBOACdcn7gUS/NOHvH2N/cDCDPA8/J0xJt33h
   0kjHrAf18XZJdkwSpuq2aa5G3n8bTziU2bP6jBLAovGQ5Z1qkggzcLrP6
   Zt3PBhIVDbev3SlApet0LnqucGVm+5J4SZerOEaGt1o+WtNEVumhzmwq0
   A==;
X-CSE-ConnectionGUID: taSrTxEgTUOekkmg4GhRsA==
X-CSE-MsgGUID: wvm/v1KfTTSc52rrkqBUnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11107"; a="15863503"
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="15863503"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:07:37 -0700
X-CSE-ConnectionGUID: NMSa17feRLGJIhE2td29RQ==
X-CSE-MsgGUID: HqkS+z8QQlGEqpoHKpH1vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,250,1712646000"; 
   d="scan'208";a="41739113"
Received: from mtkaczyk-mobl.ger.corp.intel.com (HELO localhost) ([10.246.1.223])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2024 05:07:34 -0700
Date: Wed, 19 Jun 2024 14:07:29 +0200
From: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Dan Williams <dan.j.williams@intel.com>, stuart hayes
 <stuart.w.hayes@gmail.com>, linux-pci@vger.kernel.org, Arnd Bergmann
 <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Ilpo Jarvinen
 <ilpo.jarvinen@linux.intel.com>, Keith Busch <kbusch@kernel.org>, Marek
 Behun <marek.behun@nic.cz>, Pavel Machek <pavel@ucw.cz>, Randy Dunlap
 <rdunlap@infradead.org>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <20240619140729.000020d1@linux.intel.com>
In-Reply-To: <ZnKgCos9ZwVzcKuS@wunner.de>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
	<20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
	<05455f36-7027-4fd6-8af7-4fe8e483f25c@gmail.com>
	<Zm1uCa_l98yFXYqf@wunner.de>
	<20240618105653.0000796d@linux.intel.com>
	<20ba8352-c1ce-45ba-8cb7-7ef4c02b3352@gmail.com>
	<6671e0d13f20_31012949a@dwillia2-xfh.jf.intel.com.notmuch>
	<ZnKgCos9ZwVzcKuS@wunner.de>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 11:08:26 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Tue, Jun 18, 2024 at 12:32:33PM -0700, Dan Williams wrote:
> > It strikes me that playing these initcall games is a losing battle and
> > that this case would be best served by late loading of NPEM
> > functionality.
> > 
> > Something similar is happening with PCI device security where the
> > enabling depends on a third-party driver for a platform
> > "security-manager" (TSM) to arrive.
> > 
> > The approach there is to make the functionality independent of
> > device-discovery vs TSM driver load order. So, if the TSM driver is
> > loaded early then pci_init_capabilities() can immediately enable the
> > functionality. If the TSM driver is loaded *after* some devices have already
> > gone through pci_init_capabilities(), then that event is responsible for
> > doing for_each_pci_dev() to catch up on devices that missed their
> > initial chance to turn on device security details.
> > 
> > So, for NPEM, the thought would be to implement the same rendezvous
> > flow, i.e. s/TSM/NPEM/.  
> 
> A different viewpoint is that these issues are caused by the
> "division of labor" between OS kernel and platform firmware.
> 
> In the NPEM case, Dell servers require the OS to call firmware
> to change LEDs.  But before OS can do that, OS has to initialize
> a certain other interface with firmware.
> 
> In the TSM case, Intel TDX Connect or AMD SEV-TIO require OS to
> ask firmware to perform certain authentication steps with devices,
> wherefore OS has to provide another interface to facilitate
> communication with the device.
> 
> It's a complexity nightmare exacerbated by vendor-specific quirks.
> 
> Which is why I'm arguing that firmware functionality (e.g. TDX module)
> should be constrained to the absolute minimum and the OS should be
> in control of as much as possible.  That's the approach Apple has
> been following as it's the only way to achieve their close interplay
> between hardware and software without making things too complex.
> 
> It seems what's keeping this series from working on Dell servers is
> primarily that the driver wants to read out LED status on probe.
> So I've recommended to Mariusz off-list to do that lazily if possible,
> i.e. on first read of a LED's status.
> 
> Then if users do try to read or write LED status on Dell servers without
> loading IPMI modules first, they get to keep the pieces, sorry. :(

> 
Initially, I thought that Dan suggestion is the best option but after taking
into account use cases of the driver and times provided by Stuart - lazy
loading wins.

As a led application maintainer, I can accept fact that I cannot impose led for
a while and errors will be reported, that is fine. I can left a hint why it is
happening to user.

I would be a nightmare to get new LED controller after some time if LED
interface appearance is delayed. It is much worse from user perspective because
no device means that I have no information in userland. I cannot determine if
something is going to be up soon so I will report disks as not supported -
unnecessary maintenance hell. I may receive a lot of issues.

Stuart, please give me some time to apply suggestions and introduce lazy
approach. I'm working on it!

Thanks,
Mariusz

