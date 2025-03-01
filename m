Return-Path: <linux-pci+bounces-22693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CB9A4A995
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 08:52:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8194D189A70E
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 07:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE1A1C5D5C;
	Sat,  1 Mar 2025 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hU/aXJFb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E91E1C57B2
	for <linux-pci@vger.kernel.org>; Sat,  1 Mar 2025 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740815559; cv=none; b=G553DsbXZORHBW+y0AuQGT943Q9dlcS4psfNEytR1DNHK46HYdo047kNfpJvHk1u3cKfAuHOch+S7smWZUDO3qf3F63WKHqsnULhGW18B6F/q0Uf+WoCpwFwsfUdlmsp2jVBNFC/ETf7HHmzlKCnWR/2/91hHzLacMHHlfGdDbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740815559; c=relaxed/simple;
	bh=YrCg9Q1reqKYec70+ZAloj7cM6t8AfCJPMkafKM/5+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bEf/E3osNKtTnkY1jnfhei+V7f47OscgZGRn38xR3OUgZJBu9CmPtYDknNDoPk9gCbSXXm7CtyeT11Ct0iWgZn3JbF3WL1ucwQ+p7WBL2VLxXpIVXYDtj3PLyHkIcmvjI9+IBJIOxwi/R53cgN3k5bOuPKJB9ihsUa7dcupfrDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hU/aXJFb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740815558; x=1772351558;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YrCg9Q1reqKYec70+ZAloj7cM6t8AfCJPMkafKM/5+c=;
  b=hU/aXJFbmqUjtR79Rrj/dAZrB2r0TJJ8bH0/1ccHPlE7D1EDxJzUX6u4
   ZpKQjeROHSXpFJNrjYFXZ2T+nLIMcADJgTGLp5po+gugYCHuSRpf21xoK
   R4LycLLS3uyR/Ui/mu4qMM0t5YigiVJzQ6gOfd+tg3ZrMnhw7IuubP6WV
   ABf+YMkSzIbEZ6NP8tggZlAl3ehMhfiGLdARUoDMFXT09LIqHRF3NEB06
   HHOF6IGUfipSUXsPfxSY00b7piL7ImEEQbLYSvP5BGqozECJUMv4M7iau
   VHAvz4UJ8+/kCTZx9oAI52/9GiIJsEUC5SVdWhzsInQNTV9OdRghyFGB9
   w==;
X-CSE-ConnectionGUID: QSFibbUNRx21fT57odWOJw==
X-CSE-MsgGUID: Pj0qZ3sdQCq8+y+lNsYp1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="41871500"
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="41871500"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 23:52:37 -0800
X-CSE-ConnectionGUID: rxxZ4Dy7SNCzHZjmHtIkTQ==
X-CSE-MsgGUID: 62Lm16AxQKGoBUZ0jBkzfA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,324,1732608000"; 
   d="scan'208";a="117721122"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 28 Feb 2025 23:52:34 -0800
Date: Sat, 1 Mar 2025 15:50:35 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	Lukas Wunner <lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org
Subject: Re: [PATCH 05/11] PCI/TSM: Authenticate devices via platform TSM
Message-ID: <Z8K8S+yeXToetCaT@yilunxu-OptiPlex-7050>
References: <173343739517.1074769.13134786548545925484.stgit@dwillia2-xfh.jf.intel.com>
 <173343742510.1074769.16552514658771224955.stgit@dwillia2-xfh.jf.intel.com>
 <efc5ba59-964d-4988-a412-47f5297fedd3@amd.com>
 <yq5aeczrww9j.fsf@kernel.org>
 <Z71umSkkyV0rAC25@yilunxu-OptiPlex-7050>
 <yq5a4j0gc3fp.fsf@kernel.org>
 <Z8AHtcYgz2JukdfM@yilunxu-OptiPlex-7050>
 <yq5aa5a78p8d.fsf@kernel.org>
 <Z8EQsFiVAxtWfulx@yilunxu-OptiPlex-7050>
 <yq5a4j0e8kn0.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5a4j0e8kn0.fsf@kernel.org>

> >> >> For the current CCA implementation bind is equivalent to VDEV_CREATE
> >> >> which doesn't mark the device LOCKED. Marking the device LOCKED is
> >> >> driven by the guest as shown in the steps below.
> >> >
> >> > Could you elaborate why vdev create & LOCK can't be done at the same
> >> > time, when guest requests "lock"? Intel TDX also requires firmware calls
> >> > like tdi_create(alloc metadata) & tdi_bind(do LOCK), but I don't see
> >> > there is need to break them out in different phases.
> >> >
> >>
> >> Yes, that is possible and might be what I will end up doing. Right now
> >> I have kept the interface flexible enough as I am writing these changes.
> >
> > Good to know that, thanks.
> >
> >> Device can possibly be presented in locked state to the guest.
> >
> > This is also what I did before. But finally I dropped (or pending) this
> > "early binding" support. There are several reset operations during VM
> > setup and booting, especially the ones in bios. They breaks LOCK state
> > and I have to make VFIO suppress the reset, or reset & recover, but that
> > seems not worth the effort.
> >
> > May wanna know how you see this problem.
> 
> Currently, my approach involves a split vdev_create and a TDISP lock, which is
> why I haven't encountered the issue mentioned above. The current changes
> implement vdev_create via the VMM, while the guest makes an RSI call to
> switch the device to the locked state.
> 
> I chose to separate vdev_create and TDISP lock into two distinct steps
> to simplify the process and better align it with the RMM spec [1].
> 
> I noticed that SEV-TIO performs a KVM_EXIT_VMGEXIT, which carries out a
> similar operation unless it has already been handled during VM startup.
> From your reply above, I understand there was a proposal to combine
> VDEV_CREATE and TDISP_LOCK. However, you also mentioned that if we
> present the device in a locked state to a VM early in the boot process,
> we might unintentionally break the TDISP lock state.

That doesn't break the proposal to combine VDEV CREATE & LOCK. We end up
make VMM do nothing about Secure at VM boot, just normal shared passthrough.
VMM does VDEV create & LOCK in a batch when guest asks for bind (or lock
or connect, or whatever verb).

I think if any device specific thing must be done *between* VDEV CREATE
and LOCK, then they must be separated. But I haven't found yet.

Thanks,
Yilun

> 
> I will look up the previous discussions to better understand the
> rationale behind combining vdev_create and lock.
> 
> [1] https://developer.arm.com/-/cdn-downloads/permalink/Architectures/Armv9/DEN0137_1.1-alp12.zip
> 
> -aneesh

