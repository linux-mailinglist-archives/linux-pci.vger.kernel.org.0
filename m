Return-Path: <linux-pci+bounces-33694-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5E6B1FFD0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 09:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D5C189C3F7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 07:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C25D1FAC34;
	Mon, 11 Aug 2025 07:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DI6aGK1S"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6851990B7;
	Mon, 11 Aug 2025 07:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754895740; cv=none; b=U5ZFpu3A6lZlhyqIMcqsNVATLMT9J94M9Srj159BRpwB5P+bVqeVK+DDahgezdLVd157jNW618bfEeT177SZEUSJQtOGg5nsT01Ydi78EZp7dLo9420RJkefSEETNGsEbaK2FYW02IeGR7ogodExVvvi1zGjvwTAOqDWeApiQ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754895740; c=relaxed/simple;
	bh=8vBS4MHzTEGOI7swyoOU8HSSUjTBEjChHSjxrVJLK84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JnhQAxFfP+fEPJbfA2k/S22p++BVxWkb+YkfOlU7eWo2pdD/nrnMByBqT5UNwLhCFUaA7kF7RKamIyXoz23lc3KvUYZA5fRN9K2NE5Sxh5iOBkTk6lFJHIPebiBjaf8ivt57b7DYojiztHmCjqsy+o3C6U8V9cQdf+B/CroEdaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DI6aGK1S; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754895739; x=1786431739;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8vBS4MHzTEGOI7swyoOU8HSSUjTBEjChHSjxrVJLK84=;
  b=DI6aGK1SqP38HoyyYwISiE0WQhX5MiWyfcX9q2L1ArXv9RFvJAJnjVGU
   EQU5O067GK4BKs9UfiQn7qWwCRWlNfgTMotKXZkwSaLM3MbjmDz01qw06
   tJ/OIhh0jtTWGmX9czPuLFQl70nqYuaZ0dE9KZbLlIc7KNvCO/2GvFxBk
   bTRvlpBNhbJwtZR/uywUKP7pR8kMDKMxlSfH2uHEo8C2IijQ9ZlEbeHZ5
   2d357I0JcpwFAGZQUB43vGdbpZYbtPCqvMEptNxjlddWmmlWuU3L7Cg64
   mvdh/oAF5PGBen+ZvTxJUlt8qiKyLEoXUk1pucigY7Rcu9sqXNUTPP+gb
   A==;
X-CSE-ConnectionGUID: hO+dK5haSmqVA4IMQ3DhzQ==
X-CSE-MsgGUID: 5L6WN+y6TayuDZgUO5wbhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="68220544"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="68220544"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 00:02:18 -0700
X-CSE-ConnectionGUID: PtGethz0Qx2gfMYM0c1QPw==
X-CSE-MsgGUID: 2hmoJOUAQHevxNgPCR0Sdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="165485432"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa009.jf.intel.com with ESMTP; 11 Aug 2025 00:02:16 -0700
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id 64AE793; Mon, 11 Aug 2025 09:02:14 +0200 (CEST)
Date: Mon, 11 Aug 2025 09:02:14 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Mario Limonciello <superm1@kernel.org>,
	"Rangoju, Raju" <raju.rangoju@amd.com>, linux-usb@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	andreas.noever@gmail.com, michael.jamet@intel.com,
	westeri@kernel.org, YehezkelShB@gmail.com, bhelgaas@google.com,
	Sanath.S@amd.com
Subject: Re: [PATCH 0/3] thunderbolt: Update XDomain vendor properties
 dynamically
Message-ID: <20250811070214.GT476609@black.igk.intel.com>
References: <2025080628-viral-untruth-4811@gregkh>
 <20250807051533.GG476609@black.igk.intel.com>
 <2025080758-supervise-craftily-9b7f@gregkh>
 <17ed42fe-9d8d-46da-8434-f508ec5932fa@kernel.org>
 <20250808044538.GK476609@black.igk.intel.com>
 <2025080822-cardboard-aloha-3c5d@gregkh>
 <20250808091313.GN476609@black.igk.intel.com>
 <2025080832-poker-rectal-0895@gregkh>
 <20250811045307.GP476609@black.igk.intel.com>
 <2025081128-cartwheel-grandly-a9be@gregkh>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2025081128-cartwheel-grandly-a9be@gregkh>

On Mon, Aug 11, 2025 at 07:28:21AM +0200, Greg KH wrote:
> On Mon, Aug 11, 2025 at 06:53:07AM +0200, Mika Westerberg wrote:
> > On Fri, Aug 08, 2025 at 04:13:28PM +0100, Greg KH wrote:
> > > > 0004 USB4
> > > > 
> > > > sounds good to me. In USB4 there is no "root hub". It's called host router
> > > > (but we do have device routers that are called USB4 hubs for added
> > > > confusion ;-).
> > > > 
> > > > But I'm fine with other numbers too, does not matter if you want to save it
> > > > for some future USB variant.
> > > 
> > > Ok, use 0004 for this.  But what should I use for the text string here
> > > in the usb.ids file?
> > 
> > Thanks! I'll cook up a patch changing these.
> > 
> > I don't think it should be in usb.ids because it is not visible anywhere
> > except over USB4 link (between hosts). You don't see this through USB 2.x
> > or 3.x.
> 
> It goes in usb.ids as that is what I use to keep track of all of the
> assigned product ids for this vendor :)

Right, got it.

> So, should I use "USB 4.0 host link" or something else?

USB4 Connection Manager

