Return-Path: <linux-pci+bounces-11067-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D2F94365B
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 21:21:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B117E2836D2
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 19:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D534F3E47B;
	Wed, 31 Jul 2024 19:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LiEo/Iq7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094761805E
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 19:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722453688; cv=none; b=oYI9w4l3x0yTn1RfcHEncU8fGWG5/O0HmsDFVFuN/zmGPPla+0HMxNp13UQ4FueBdJaOE0Hb2cbScFsJF64e+aFkyjYhw8LR3Zo/7eFI2duEYzXOcZXoQ387wgmCWDvvZOQ3fqYNUvkB1Tu1s/O2K2PUX4j8D1Pq7mwclneb2E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722453688; c=relaxed/simple;
	bh=6IvWwpyjqfXLTR+20e8TFSvRWCLrzm6hoo1iBeVsowA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Upg0xl8R+Pdv/Ica8QWABd23sZRKNZ0RnemrVi0p8a5V7mO2c/zDOWM++p9+aZArDmvlMnjQY4xmUSjb7MDLzoV+OpQUG6WaSQzhJX34dxxFiEdZroC5Z+7P6n7VRG0QiNBIhor22mtSmg/WdMs8bLFa7tkoxUCq2JZ11Vjt1Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LiEo/Iq7; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722453687; x=1753989687;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6IvWwpyjqfXLTR+20e8TFSvRWCLrzm6hoo1iBeVsowA=;
  b=LiEo/Iq76u0aYuvB6+zs/rbE2/owp2DKL6Wss9kD5GRNohObzw5GJndY
   EArLZLngW1MKZjqOcqJbQ9TYq8cl5rX4W/11VrTxt4M1PUFODHFEZs+9R
   BGw4cq+QSYQsU0ZrpX6+NmUV5okmO9SmiTXT0zU056ScCMLW1/5dobs1C
   eBJhDNs36ZWzG20s7MVYOr7hRHSr1yQtPD6K50fQFdyyMqHuEUpvxQ0cn
   PuYC7+fnFg+RGWKQlkVqJFHjlQw2Q69QV19/4PBYlRkHwhFNGWF9thJTi
   Ip6uzMYgYPbVyEewb0M5+F6YznaV+4BaJnzxF5MksHhhufpFfHHflNvo2
   A==;
X-CSE-ConnectionGUID: 08EFMU6HQOKo7vLM5S6LDw==
X-CSE-MsgGUID: 6o1fnsP/R/ioMF0Blh7Mmg==
X-IronPort-AV: E=McAfee;i="6700,10204,11150"; a="31749586"
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="31749586"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 12:21:26 -0700
X-CSE-ConnectionGUID: 7HV5NXGgQwO9tFR9o9sL0w==
X-CSE-MsgGUID: KnGvafMYSAuFMTCzNV8B+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,251,1716274800"; 
   d="scan'208";a="85409033"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2024 12:21:25 -0700
Date: Wed, 31 Jul 2024 12:21:24 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-pci@vger.kernel.org, paul.m.stillwell.jr@intel.com, Jim Harris
 <james.r.harris@intel.com>
Subject: Re: [PATCH] PCI: fixup PCI_INTERRUPT_LINE for VMD downstream
 devices
Message-ID: <20240731122124.00005889@linux.intel.com>
In-Reply-To: <ZqFJr7Y3Vemjv2SC@infradead.org>
References: <20240724170040.5193-1-nirmal.patel@linux.intel.com>
	<ZqFJr7Y3Vemjv2SC@infradead.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Jul 2024 11:36:31 -0700
Christoph Hellwig <hch@infradead.org> wrote:

> On Wed, Jul 24, 2024 at 10:00:40AM -0700, Nirmal Patel wrote:
> > +#if IS_ENABLED(CONFIG_VMD)
> > +/* 
> > + * VMD does not support legacy interrupts for downstream devices.
> > + * So PCI_INTERRPUT_LINE needs to be initialized to 0 to ensure OS
> > + * doesn't try to configure a legacy irq.
> > + */  
> 
> The wording is a bit weird, Linux is the OS normally.  Or is this
> about guest OSes in virtualized environments?  Given how VMD bypasses
> a lot of boundaries can we even assign individual devices to VFIO?
> And if so is that actually safe or should we prohibit it?
> 

This is for host OS. I will add better description as suggested by
Mani. 

