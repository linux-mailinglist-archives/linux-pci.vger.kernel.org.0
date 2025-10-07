Return-Path: <linux-pci+bounces-37647-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89BF5BC02AB
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 07:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3717D3C1FE4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 05:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4B8155C88;
	Tue,  7 Oct 2025 05:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UIoOd3cq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 174FF1E511;
	Tue,  7 Oct 2025 05:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759813214; cv=none; b=jOHEal9kLsdEGINGW1MWEiDTixZ3n0G/eGiZDFBWFkPmavks7KgTrbNq55HugfmeYJ5x5+FYwr616p7+cJgzPSEUqbjWb9DSCGtCrhFFDvn7/MgBVsi3/+T+mjUhx1lREQNjgHJs1f99wleVNc7Qs3O5SSx6UDTwCLcYKI0MFF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759813214; c=relaxed/simple;
	bh=RRW8gejwszwXbYJMA5aGPaiY4+xT+oMnY+DLrP0mF6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMcCevRZrM9nZYUOFi+tOa345YqxEtXD9lL8wkrHZNVvc5nhtbsPHPBxLFQ3VeHVl7slzHw5S1xn+tJcG4QiOER9zcrhXifnfThg0ojacTy4jzRqJsh7ZrwUFlBtGnGx5Uq8kF4wX5cWcGUMSzSK6bGZNBfi8C4MrZy1Wr1N/+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UIoOd3cq; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759813213; x=1791349213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RRW8gejwszwXbYJMA5aGPaiY4+xT+oMnY+DLrP0mF6Y=;
  b=UIoOd3cqedFJMlfnrStr8smXb9h7clMyIkkF8Jt9VHZyM/BbcWwMmvYQ
   UqsllNssmRyyu2wWSNb4qAJgqFu/UN92Ku/uIvIeBg/Wfm5gOFGJgrc6m
   LpnmAOFXrtaRzcatctG8zZDTMRWRQpRKty/ZVIDpX6XgyQgS9C7p0IVDV
   +wUuhDhhc5oDGd4SdTwVsCfWzAOgBuRCIjxwNh5jCpq0dqST8eKgAHkQB
   U2jPuXsgcJvz2v7TUNjGa7A4OMeNqgaq3kjVXa3W1QC/9W60ljlkjGh5M
   AcUAaZrAN/NIv4NGNyFUfywwMPSQaUIXmnjpdcz7NgjB5DL6z+MR+BnRi
   g==;
X-CSE-ConnectionGUID: UvoLs2iZQAyRaF/jQxqsfw==
X-CSE-MsgGUID: NVLnnByhQ9y5Wdqno022UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11574"; a="62035933"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62035933"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2025 22:00:12 -0700
X-CSE-ConnectionGUID: qCQmHVd3QD21jHU2ah0sTw==
X-CSE-MsgGUID: m2t+dmmnT/yp6NfcUwn4LA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="180105473"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa008.jf.intel.com with ESMTP; 06 Oct 2025 22:00:10 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id A048895; Tue, 07 Oct 2025 07:00:08 +0200 (CEST)
Date: Tue, 7 Oct 2025 07:00:08 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] PCI/PM: Avoid redundant delays on D3hot->D3cold
Message-ID: <20251007050008.GE2912318@black.igk.intel.com>
References: <20251003154008.1.I7a21c240b30062c66471329567a96dceb6274358@changeid>
 <20251006135222.GD2912318@black.igk.intel.com>
 <aOQLRhot8-MtXeE3@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aOQLRhot8-MtXeE3@google.com>

Hi,

On Mon, Oct 06, 2025 at 11:32:38AM -0700, Brian Norris wrote:
> Hi Mika,
> 
> On Mon, Oct 06, 2025 at 03:52:22PM +0200, Mika Westerberg wrote:
> > On Fri, Oct 03, 2025 at 03:40:09PM -0700, Brian Norris wrote:
> > > From: Brian Norris <briannorris@google.com>
> > > 
> > > When transitioning to D3cold, __pci_set_power_state() will first
> > > transition a device to D3hot. If the device was already in D3hot, this
> > > will add excess work:
> > > (a) read/modify/write PMCSR; and
> > > (b) excess delay (pci_dev_d3_sleep()).
> > 
> > How come the device is already in D3hot when __pci_set_power_state() is
> > called? IIRC PCI core will transition the device to low power state so that
> > it passes there the deepest possible state, and at that point the device is
> > still in D0. Then __pci_set_power_state() puts it into D3hot and then turns
> > if the power resource -> D3cold.
> > 
> > What I'm missing here?
> 
> Some PCI drivers call pci_set_power_state(..., PCI_D3hot) on their own
> when preparing for runtime or system suspend, so by the time they hit
> pci_finish_runtime_suspend(), they're in D3hot. Then, pci_target_state()
> may still pick a lower state (D3cold).

Ah, right. Thanks for clarification.

Yeah, I agree with Bjorn and Mani that those calls should go away (PCI core
does that already). That makes driver writes life simpler wrt. PCI PM.

