Return-Path: <linux-pci+bounces-28188-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F37E9ABF034
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 11:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11BD17CAE9
	for <lists+linux-pci@lfdr.de>; Wed, 21 May 2025 09:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1820D23D2A8;
	Wed, 21 May 2025 09:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vz3JOf6G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760FD25393D
	for <linux-pci@vger.kernel.org>; Wed, 21 May 2025 09:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747820468; cv=none; b=CXXvWR06RoiwSR2kF4UCXgK25qDekvYJN2/nTAahD+E7bwpAEPwSlB4zxEJvxCjwGWus+SAx5L050GYU77GlVz3xzL7/wijIqKEr081JKehMsuSGH3Io7LfPw0OKDZeaYw8KwoxJulDa3FVrPscnM4pjA4fziyeFcz6uDW7ouDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747820468; c=relaxed/simple;
	bh=7cg2kugEmmL2lERRLDHGTr0rt4634yf3DzKja4v3AX8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWMl5PXCrfD5Zpv9GT2NpvXBBZv9EXOa/pmxKFMHXTEYlKA4Dioswe1RDdrrj720dXjfUmjv5t4N50dHNVGxJyUHe9bGd3CXHyEEoAskLrwJ2W2HGO5VbGT2jsOGUaQDZLQBEZK6RzIXY9ZeHiTxZ/vV08kQBSJOfTEM20s9Ypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vz3JOf6G; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747820466; x=1779356466;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7cg2kugEmmL2lERRLDHGTr0rt4634yf3DzKja4v3AX8=;
  b=Vz3JOf6GIZhkOcGXSaQ6OAg45Wamtbawdt0UzYDikHW75SvjzeVCRbU0
   p6IhUiK9oia3XgduNGEnOOLVWdz/Qj+8C8T3QCo3F0VVDpxJNskfcoIDn
   LxOCCbWpK+VkTh+HXJJAC+FW709/ohnOFLpQxL8GrHrYuFD+mnQ8bWojv
   j9Z6zXzdtgwBpeUJlMmnie4il83J0HnKtGuj1b2He8rAdBRtwOvZJbQ9G
   3NsjvkqO3C43LvM2tlZA3FfaeQMAMNsi5rzd5uLl3xl5i1s3s3SJV0VK5
   MPZyFevKyFG0iADoFP+FFbYq4SK2Ilm1FZw0MCXRSNMJdZLaD7UV+nj9L
   A==;
X-CSE-ConnectionGUID: W7o/c919SYu9T68OOTMkEg==
X-CSE-MsgGUID: IPGdFSnzTKy9kAVDxXnsGQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11439"; a="37410884"
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="37410884"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2025 02:41:05 -0700
X-CSE-ConnectionGUID: 5pF0oTwTSHWogEZ5f835YA==
X-CSE-MsgGUID: t6GWQvmLQ/yYQN4CeS4uYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,303,1739865600"; 
   d="scan'208";a="145121111"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa005.jf.intel.com with ESMTP; 21 May 2025 02:41:03 -0700
Date: Wed, 21 May 2025 17:35:08 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev,
	linux-pci@vger.kernel.org, gregkh@linuxfoundation.org,
	lukas@wunner.de, suzuki.poulose@arm.com, sameo@rivosinc.com,
	aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aC2eTGpODgYh7ND7@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
 <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
 <yq5awmab4uq6.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5awmab4uq6.fsf@kernel.org>

On Tue, May 20, 2025 at 12:47:05PM +0530, Aneesh Kumar K.V wrote:
> Xu Yilun <yilun.xu@linux.intel.com> writes:
> 
> > On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
> >> From: Xu Yilun <yilun.xu@linux.intel.com>
> >> 
> >> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
> >> 
> >> pci_tsm_bind/unbind() are supposed to be called by kernel components
> >> which manages the virtual device. The verb 'bind' means VMM does extra
> >> configurations to make the assigned device ready to be validated by
> >> CoCo VM as TDI (TEE Device Interface). Usually these configurations
> >> include assigning device ownership and MMIO ownership to CoCo VM, and
> >> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
> >> TDISP message. The detailed operations are specific to platform TSM
> >> firmware so need to be supported by vendor TSM drivers.
> >> 
> >> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
> >> to TSM firmware about further TDI operations after TDI is bound, e.g.
> >> get device interface report, certifications & measurements. So this kAPI
> >> is supposed to be called from KVM vmexit handler.
> >
> > To clarify, this commit message is staled. We are proposing existing to
> > QEMU, then pass to TSM through IOMMUFD VDEVICE.
> >
> 
> Can you share the POC code/git repo implementing that? I am looking for
> pci_tsm_bind()/pci_tsm_unbind() example usage.

The usage of these kAPIs should be in IOMMUFD, that's what I'm doing for
Stage 2 patchset. I need to rebase this series, adopt suggestions from
Jason, and make TDX Connect work to verify, so need more time...

Thanks,
Yilun

> 
> -aneesh

