Return-Path: <linux-pci+bounces-7553-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A658C7394
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 11:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABD5B1F21A04
	for <lists+linux-pci@lfdr.de>; Thu, 16 May 2024 09:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE4214373C;
	Thu, 16 May 2024 09:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="egavPOmt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D4C13FD93;
	Thu, 16 May 2024 09:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715851010; cv=none; b=jHDgCNkf+TXZhvuFYCQ2cztCSMKsY+s36dpsa5YbQsodHMg/siQLpGKHf3oExbLmuttZFnGP7ZX5BwmYbKgcplrrDAuS1+gdU/KIk1d2KvsLbM+x9A93t1nONAGOQAa+6juiNcaDbJdMyVT7wHtgQe+H1OmSczl5+ko/iVpzp9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715851010; c=relaxed/simple;
	bh=lA0mEkkthuAzLNhfY+nauDBWLKVi/ZHDTnhFtqsiVNY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPrnp+p6Y/BqbUEQKUyZms+Jq3a8y21nPRZYHOoWxD7g2JEhlDaiJsNLNNmnEpyDXN7rqNFwX0cVi6hLcop3m6jXS0lGxpLjSLiLWmq3sfxRzOnZ3kMmfKQv0nfGEPpKQPkg1sNyqPJlyR96Lky9o3R4nyCuL91pD4WF4rV47hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=egavPOmt; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715851010; x=1747387010;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lA0mEkkthuAzLNhfY+nauDBWLKVi/ZHDTnhFtqsiVNY=;
  b=egavPOmtcnm8+Y1CQ9yGBVFhyEuDEYnZDaEgFUw3bumnQTqhokLpJXmb
   jWtjyCptRPFnouqH0Gi9Q/ocBhHhF7xTI6yj92RoEmmfe1joTOEA0+oQp
   5iXjHvv3cPANZppgh5vZiRDf9ELchQIRSSQckh6bY//UGj3sG/2/oVGHU
   FzCSwXJKGHWvwrjiUgDJkgZi0BGPxxOgnPNzjF9vHxFKtJfax+GKObiX8
   Md1vRkWBlIOoDE7PGO88ydG4wI1/9pul6xCh6pMMDLUaaBFOE6ePTF6JV
   TlZo5FyGq0i2zpTQIRf497W1wzUOMb8lELV/Qv9R9UpMcrmshVvKVugn2
   w==;
X-CSE-ConnectionGUID: nw67oWgvQ/at6IEdZKSPig==
X-CSE-MsgGUID: XSr9eIGVTpiyLptSn84ZYw==
X-IronPort-AV: E=McAfee;i="6600,9927,11074"; a="15730948"
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="15730948"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2024 02:16:49 -0700
X-CSE-ConnectionGUID: GyNBFYroRG+Dd2Sf3yVgKw==
X-CSE-MsgGUID: dhNiDgy5QuyT+Omac80vtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,164,1712646000"; 
   d="scan'208";a="35877817"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 16 May 2024 02:16:46 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 93F4497D; Thu, 16 May 2024 12:16:45 +0300 (EEST)
Date: Thu, 16 May 2024 12:16:45 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240516091645.GB1421138@black.fi.intel.com>
References: <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
 <20240511043832.GD4162345@black.fi.intel.com>
 <20240511054323.GE4162345@black.fi.intel.com>
 <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+Y6NJF+sJs_zQEF7se5QVMBAhoXJR3Y7x0PHfnBQZyCBbbrQg@mail.gmail.com>

Hi,

On Wed, May 15, 2024 at 02:53:54PM -0400, Esther Shimanovich wrote:
> > For the clarity, Intel integrated Thunderbolt 3 controller first in Ice
> > Lake, then Thunderbolt 4 controller in Tiger Lake and forward (Alder
> > Lake, Raptor Lake, Meteor Lake). Anything else, including Comet Lake and
> > the like are using discrete controllers such as Alpine Ridge, Titan
> > Ridge (both Thunderbolt 3) and Maple Ridge (Thunderbolt 4), and Barlow
> > Ridge (Thunderbolt 5) where the controller is either soldered on the
> > motherboard or connected to a PCIe slot.
> 
> Thanks for the explanation!
> This patch worked smoothly on the device I tried. I'd be happy to go
> forward with this patch, and test it on more devices.
> Is that fine? Or should I try something else on the build I made with
> Lukas's commits?

I suggest trying on more devices just to be sure it covers all of them.

