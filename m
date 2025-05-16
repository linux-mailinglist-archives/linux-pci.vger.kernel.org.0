Return-Path: <linux-pci+bounces-27835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A79FAB9652
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 08:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854C93AE09E
	for <lists+linux-pci@lfdr.de>; Fri, 16 May 2025 06:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057071F4621;
	Fri, 16 May 2025 06:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LfNZh7S/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA9C1361
	for <linux-pci@vger.kernel.org>; Fri, 16 May 2025 06:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747378669; cv=none; b=tMG+k5oVjIpyFXIs/jHhqQXjc3t5twXTEzHFfkbKt5+ShMnfo801+157haHzue1A/ZQm+LDZw7aUrLUlqw6IPqBg+cWVXWpEr9vuiW749msl6y2n3Gx6O8x1I4NFuCUEzDA6Y+gn6IwAIFTNEGVNFjnKmyQVQfXqdkIRiu8l5a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747378669; c=relaxed/simple;
	bh=XnZoPswJ3bA6jxPLmT+F4YbPnOb8BlY1QlQMFMbPtUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wd/YCs7+HWUcSOMZPnd1wVRhUnjYdqM1CVSnXwYdkVYfn2+Sj7FDjv8VTnyUN7nGJGquGOU1qthMe1FCfIKBAHxYguMr6qoLdYKplnbTaFhyo75IJZGVpeWQ3wGxjXR/kzu3rksXLw9+zXsslQaaK0wlXLyQJkKeatpd2EwzU5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LfNZh7S/; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747378668; x=1778914668;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XnZoPswJ3bA6jxPLmT+F4YbPnOb8BlY1QlQMFMbPtUE=;
  b=LfNZh7S/8WBGxGGBCFtDNRjvO/FRbQREMtdamYhij8YCthX1i6PQZ4xM
   +qHy5PeQJXTDnjQN5ChiucOI7TyzzftVYO64FJK+zWCsc7CGKOBpPwMsl
   qRXUfqIMcYBeOVdPkJkUSMEnZ+1kNTwqso/guf7EJTkjAQWQBHXD7gG4c
   a1VruYWIRtZKq5omzlsuAoPqNK0cYrEO/WeJm7q0NljxKlRpjnoDvvmBN
   ghmSu3sJHehIfZei3QZQgIujMle3sRYAhvm1VdOlUPR8IW/uHQlE+Uuq0
   l9PEartM34UCeq7z+T547pLlAWkT8im6sTvYdx5ks000+zR86G7KQPSaE
   A==;
X-CSE-ConnectionGUID: rSGLGLjuSAKCtGSkSAByYA==
X-CSE-MsgGUID: 5It+M5QIRUSBGftWBwCjsQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="49324716"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="49324716"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 23:57:48 -0700
X-CSE-ConnectionGUID: Jx2SeMZOSiaiwQwTOC60xg==
X-CSE-MsgGUID: ejI5XwvHQCugMZNmKNCMtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138993620"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 15 May 2025 23:57:45 -0700
Date: Fri, 16 May 2025 14:52:06 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org, lukas@wunner.de,
	aneesh.kumar@kernel.org, suzuki.poulose@arm.com, sameo@rivosinc.com,
	aik@amd.com, jgg@nvidia.com, zhiw@nvidia.com
Subject: Re: [PATCH v3 12/13] PCI/TSM: support TDI related operations for
 host TSM driver
Message-ID: <aCbglieuHI1BJDkz@yilunxu-OptiPlex-7050>
References: <20250516054732.2055093-1-dan.j.williams@intel.com>
 <20250516054732.2055093-13-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516054732.2055093-13-dan.j.williams@intel.com>

On Thu, May 15, 2025 at 10:47:31PM -0700, Dan Williams wrote:
> From: Xu Yilun <yilun.xu@linux.intel.com>
> 
> Add kAPIs pci_tsm_{bind,unbind,guest_req}() for PCI devices.
> 
> pci_tsm_bind/unbind() are supposed to be called by kernel components
> which manages the virtual device. The verb 'bind' means VMM does extra
> configurations to make the assigned device ready to be validated by
> CoCo VM as TDI (TEE Device Interface). Usually these configurations
> include assigning device ownership and MMIO ownership to CoCo VM, and
> move the TDI to CONFIG_LOCKED TDISP state by LOCK_INTERFACE_REQUEST
> TDISP message. The detailed operations are specific to platform TSM
> firmware so need to be supported by vendor TSM drivers.
> 
> pci_tsm_guest_req() supports a channel for CoCo VM to directly talk
> to TSM firmware about further TDI operations after TDI is bound, e.g.
> get device interface report, certifications & measurements. So this kAPI
> is supposed to be called from KVM vmexit handler.

To clarify, this commit message is staled. We are proposing existing to
QEMU, then pass to TSM through IOMMUFD VDEVICE.

Thanks,
Yilun 

