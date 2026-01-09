Return-Path: <linux-pci+bounces-44349-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E3709D087E6
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 11:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A50F03091BC6
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 10:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B24329390;
	Fri,  9 Jan 2026 10:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SwdQ+0rC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7B42A80;
	Fri,  9 Jan 2026 10:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767953327; cv=none; b=YqMA8MQPxaqn95PaiGuOBKhzW9FRiODKFHE8jNz1R67+Rll2O43czPuQwQiF0fs1nS21J02TmHHPF2iFKfbnzCwE0KzN1Kv54xz2k8kRQeMIICszufYWNnYa3A7D102Z1/sjaPhcVHoMjfP+G8jFFVwrvNLGAc8xrU82+hXNEew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767953327; c=relaxed/simple;
	bh=wSpJdpCgwYI70QDx2H55GLcEmOq8lwxjbpazYvK7aFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZSiVEv3io0e8NF3Y+ODNWXxpEnqCO0n8f93qNlm/NhPoLUloS0rg5nPqF8yPNx01lO/sqQcrhUPgggUuDg9TruQAC4us+jTGMula0Biw8WslRvyI/obwrhM2jkBUY1SEXvbCGCo1ULCWRGMKeV+ID9x54ZapeqVuyFPGtofvOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SwdQ+0rC; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767953327; x=1799489327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wSpJdpCgwYI70QDx2H55GLcEmOq8lwxjbpazYvK7aFc=;
  b=SwdQ+0rCrwBL7yMEZURtBmGgzQ1z1hPVp40dHcTdzByoNQ+QCgAInnIV
   TdFqMh8ntaaE35eERyEG2dXH7sZZhQsD/m+FJUxJ1O4Tzpcd/FsF5GRab
   OCLq+8VMs4Y4FX3t4bUBQ5utJF0RH87Gh6Tyt22CS6/EE5ERaW9j3WvA5
   HX+HBidDtHLLajBxG5EuukSSkoVeP+4K66dwxXzHzPX4hIc8DjF7AKiYI
   Mbi5qZZseXOx5HH4rmRmiytzknuouo0O3/DjmFnEhUjz1AveKwvZVbYdn
   XiYMDjzjxgoYsGP//y5zRmEz+Tp5yxem+dmjE3CI8qBsN5C22jBbxzEv4
   g==;
X-CSE-ConnectionGUID: H3okMfmrSN+vq6PlxjV25Q==
X-CSE-MsgGUID: RWCfEPeLTtGQZTAsTliV4g==
X-IronPort-AV: E=McAfee;i="6800,10657,11665"; a="69073303"
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="69073303"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 02:08:46 -0800
X-CSE-ConnectionGUID: fau+vArzSbCFPShL6lag4g==
X-CSE-MsgGUID: jCJZ+NxqRlua/HZuD/aEDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,212,1763452800"; 
   d="scan'208";a="234624792"
Received: from black.igk.intel.com ([10.91.253.5])
  by fmviesa001.fm.intel.com with ESMTP; 09 Jan 2026 02:08:42 -0800
Received: by black.igk.intel.com (Postfix, from userid 1001)
	id BD9F094; Fri, 09 Jan 2026 11:08:40 +0100 (CET)
Date: Fri, 9 Jan 2026 11:08:40 +0100
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
Cc: YehezkelShB@gmail.com, andreas.noever@gmail.com, bhelgaas@google.com,
	bp@alien8.de, dave.hansen@linux.intel.com,
	feng.tang@linux.alibaba.com, hpa@zytor.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	lukas@wunner.de, mahesh@linux.ibm.com, mingo@redhat.com,
	oohall@gmail.com, sathyanarayanan.kuppuswamy@linux.intel.com,
	tglx@linutronix.de, westeri@kernel.org, x86@kernel.org
Subject: Re: [PATCH v4] PCI/portdev: Disable AER for Titan Ridge 4C 2018
Message-ID: <20260109100840.GV2275908@black.igk.intel.com>
References: <20260109065746.GT2275908@black.igk.intel.com>
 <20260109081419.2746-1-atharvatiwarilinuxdev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260109081419.2746-1-atharvatiwarilinuxdev@gmail.com>

On Fri, Jan 09, 2026 at 08:14:19AM +0000, Atharva Tiwari wrote:
> unfourtunatly the GRUB problem isint fixed, and the solution i see, is to
> wipe the drive which i cant do currently, because of my data

Okay but how do you then test the patch you keep sending several version if
you cannot boot to a new kernel?

