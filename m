Return-Path: <linux-pci+bounces-24878-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE6EA73CAE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 18:47:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2B1217AA7B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B36E2192EB;
	Thu, 27 Mar 2025 17:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OX0LUJ1u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FDA218E9F;
	Thu, 27 Mar 2025 17:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743097622; cv=none; b=b/BEOFGAIMR63SmW/JEuywsxYYDEDSjUJGXOAL3DSqLPgwYcW3QyG2ISPeV+kHH/Gx2xxDMQmwCM8Id1ZJThQJiq3Kgyfprrbw9a3C9h/CnoOceiJ0lS2mnOwLd17Gt0Ee7Ea1WTN8upH6HD/F6Vqte1MebewHCwMpRzAMNu8eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743097622; c=relaxed/simple;
	bh=PuAIS/JsIUueJLGNnALxueXhQ7khqT+A2jT2PC01oqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHGG9XcWlTq4zAmdD8MyEB+OXBi+B2QDyEzGmE2dmBL7a4StJM9zNiJKv8+9y73CXaxBLZCEgImwxcyQXN9v4Hd6qCOAhNxgtrgoZoBW6CHzTKgem4H9CFNzZoFg7Io+nNQ71G/REZ+E1xSX3XJf2gmBeGmaJYx0uHcjHFmAS3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OX0LUJ1u; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743097621; x=1774633621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=PuAIS/JsIUueJLGNnALxueXhQ7khqT+A2jT2PC01oqI=;
  b=OX0LUJ1uNNak7gOEH+ceANkrr3M++JRcz4pyKELqbPnp30m2tS3ZgQx1
   +gSYzp+Dq2MlsyIDYMicAECPtVaeQlvb2V+UUy2sbh+zcolnmLPFzc45A
   WTWM/nrDei8Tbdaj9o3Jd/85fmrKKMD8TbU8ty+2fCSVdlDNiS2SCus/9
   h+jFivC+h653GPmJ5MQgegkwQTxGIAQ20++sutdl6R1DIIDWgsXUnxpmM
   h2min2lIp2cXmhf+42cgxDEUbPFuSVmMvui45iULoiuB3p4nM+A+DdiOe
   7P3qrUpp50eGk+lC9FqFACKkyrSlvw6PgeVL4nc1G0lYdZkxj+Wr35OT9
   w==;
X-CSE-ConnectionGUID: +2yvaGXTSFK4qJhXZ37v+g==
X-CSE-MsgGUID: mhk7q4AgSCmw3AIBFeKK3A==
X-IronPort-AV: E=McAfee;i="6700,10204,11385"; a="43686552"
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="43686552"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:47:00 -0700
X-CSE-ConnectionGUID: 8Fo5dK/JQeCmoQLRUXydAw==
X-CSE-MsgGUID: tpovV7BaTaOah5o6HqMYFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,281,1736841600"; 
   d="scan'208";a="156151405"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 10:46:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1txrJe-00000006VEt-2puX;
	Thu, 27 Mar 2025 19:46:54 +0200
Date: Thu, 27 Mar 2025 19:46:54 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ashish Kalra <Ashish.Kalra@amd.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, jgross@suse.com,
	roger.pau@citrix.com, pstanner@redhat.com,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Subject: Re: [PATCH RESEND v2] PCI/MSI: Fix x86 VMs crash due to
 dereferencing NULL MSI domain
Message-ID: <Z-WPDm9PcPLt9Hu6@smile.fi.intel.com>
References: <20250327162946.11347-1-Ashish.Kalra@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327162946.11347-1-Ashish.Kalra@amd.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Mar 27, 2025 at 04:29:46PM +0000, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> Moving pci_msi_ignore_mask to per MSI domain flag is causing a panic
> with SEV-SNP VMs under KVM while booting and initializing virtio-scsi
> driver as below :


Isn't it already fixed (in current Linus' master branch?

-- 
With Best Regards,
Andy Shevchenko



