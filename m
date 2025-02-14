Return-Path: <linux-pci+bounces-21481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C215DA3631C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1D2F16ECA1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE90267AE5;
	Fri, 14 Feb 2025 16:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PjCwvRAu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED002753FD;
	Fri, 14 Feb 2025 16:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550595; cv=none; b=Z2TXDZU63zMlE0QmXkQl0WrFPftwKooRr3fcc/xCxATgi7lFfC1BL2Q09SR5IODscWfTOL1YpPUOEzdXow8+IBUeYkB+v9Z7PxmFAYdLR9WemZTnkMrXALZIXaA+ojNZqtHq8+E/yZ5s5hEiwwcC2AX8JTkBAeGmZPVqL0k2J7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550595; c=relaxed/simple;
	bh=4wnU/qWMOp5jEapFPdVzMSzoA3DPqJt1dDDol0w3OY8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tDrtd2a30TrVdGMnLrfBon8qckgSqQEC7iVjkMdzcv7hXGQT7xjgbnuFbTWfKhkL/BJCJx3JS6QuCUJbSgKEIu5fA79OTP7cQPTfr2lTYeElgV15tuAWT06TtGXmz3y6JJVZB/PNfaSWmDcKhcIshh+VXZATSEcqH8jnRzErMeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PjCwvRAu; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739550594; x=1771086594;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4wnU/qWMOp5jEapFPdVzMSzoA3DPqJt1dDDol0w3OY8=;
  b=PjCwvRAuvcvKT8OJr1DKhrE19z5FM6ZTb55AucceBHEOdFsx1oqMXWhn
   9ZpelKVnAQqbn/R2hThrD35Q7fBqdsu8Ns6BdW3KIoq9YPLP7PxM9gJpK
   PD3+/m5GYlcofZwRbDB4Jv9CnDTbTnNYqQHdTviOcJUKvAj/+EAAq3S+I
   gLrhA9Z+atqzm1QqfqxC7n//jgOtifX+70of/bOhsCTQsZz98LSMAST1F
   I7Kmv24IhgVspetQaAF2alED5B/yfzZZ5WraPTthjpLXd4zHgNuLxCOKQ
   cj5tEWnmCkHDm7patM2Ad8/3aYkS334k8LWLNzu/UkUXSvXkvuaq7IA65
   g==;
X-CSE-ConnectionGUID: SO2qqjG5Q4GA2Pj8s3sRsg==
X-CSE-MsgGUID: P8p/XNJ3TD65pLxejUISiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11345"; a="40447380"
X-IronPort-AV: E=Sophos;i="6.13,286,1732608000"; 
   d="scan'208";a="40447380"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2025 08:29:53 -0800
X-CSE-ConnectionGUID: T584mMUeTmqd6JV8/2Embw==
X-CSE-MsgGUID: VrKmQHZmRUyj2M0vTnSRsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="118697344"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa005.jf.intel.com with ESMTP; 14 Feb 2025 08:29:50 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 63020123; Fri, 14 Feb 2025 18:29:48 +0200 (EET)
Date: Fri, 14 Feb 2025 18:29:48 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Kenneth Crudup <kenny@panix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, ilpo.jarvinen@linux.intel.com,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?utf-8?B?TmlrbMSBdnMgS2/EvGVzxYZpa292cw==?= <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250214162948.GJ3713119@black.fi.intel.com>
References: <20250210210502.GA15655@bhelgaas>
 <21b72adf-aac6-49fa-af40-6db596c87432@panix.com>
 <20250211055722.GW3713119@black.fi.intel.com>
 <83d9302a-f743-43e4-9de2-2dd66d91ab5b@panix.com>
 <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>

Hi,

On Thu, Feb 13, 2025 at 11:19:35AM -0800, Kenneth Crudup wrote:
> 
> On 2/13/25 05:59, Mika Westerberg wrote:
> 
> > Hi,
> 
> As Murphy's would have it, now my crashes are display-driver related (this
> is Xe, but I've also seen it with i915).
> 
> Attached here just for the heck of it, but I'll be better testing the NVMe
> enclosure-related failures this weekend. Stay tuned!

Okay, I checked quickly and no TB related crash there but I was actually
able to reproduce hang when I unplug the device chain during suspend. I did
not yet have time to look into it deeper. I'm sure this has been working
fine in the past as we tested all kinds of topologies including similar to
this.

I will be out next week for vacation but will continue after that if the
problem is not alraedy solved ;-)

