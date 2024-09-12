Return-Path: <linux-pci+bounces-13133-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 820F6977161
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 21:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B53D21C24045
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 19:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442E31BFE0F;
	Thu, 12 Sep 2024 19:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gUkkfmYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96BF41C57B0
	for <linux-pci@vger.kernel.org>; Thu, 12 Sep 2024 19:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726168517; cv=none; b=OGJQGEgPXrRxijm3ID72Js3+cAX8ZMSIrYQfepc6syB3VdFuSzi6rOZ7uHAvP+O85uuGAzCgaHmuwQW3Daxhca/e3M4noOwiXu6RcuLKIs7QkDJJa4i0XFUHwgfklL4m1zEYaiCl//3xWl4cVizWhioiQZWzWW0jE/cK2cpG6N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726168517; c=relaxed/simple;
	bh=OCVy/HpiNpmW8f1ydsX/lKH6B7YQmt+sWxGU3Yp3ZFs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Rgl5zMge9E2/Olj2q0YuDQtXsX1MzUsiqgsVMqCpZx0pciOyLHP880bwaiGk4OQzs/x5dBu/vuFz2s+Jrq3IJIjfwrWwoj6ZZTv5S7ouZLMH4A3iImEfNkyGJqZluJHxm4gP/YUNcTn8+Z4qeVjNozgO0lk/vpVznMIkLX5VrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gUkkfmYb; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726168516; x=1757704516;
  h=date:from:to:cc:subject:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OCVy/HpiNpmW8f1ydsX/lKH6B7YQmt+sWxGU3Yp3ZFs=;
  b=gUkkfmYb+xz5wO7PZCttFSJi5Tq53LjF8cxNlUUW6pLLD/LUev/l9COc
   NSzcHyfwcKSujkokxMWt8MTvOkc64+WsFZ35mnq3RSk49t72Ht3WnuFQk
   JttCqTQQU6TciwfkFTEJtINsufb12gUSt3+hBhD4wArTl1tB2LXdTLKEB
   Kntbf/8fz/Z8qvL0M8DGV2G9NDSOGIdai46S2D0DO2LCnJUW/4K5xCYHn
   Wept6A23B0ChWSa8dfuosdmjSJKMxlDFLhWN4kcCy8x2LO6mv0sNGyds9
   yI0aTsxfS8L8RimmO83GnDBrfKwYUE07Lwgy/gfxE6cB/CPjQ1ZmCH3zX
   A==;
X-CSE-ConnectionGUID: MknnBWt2ScGHVfnGMVNLVQ==
X-CSE-MsgGUID: VHL4JZoaTmaT+i4hUSnHCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="24919541"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="24919541"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:15:16 -0700
X-CSE-ConnectionGUID: Q3Im/M+QTC2Vr5oaZ12PLw==
X-CSE-MsgGUID: kyBCE2skS9a6itCK+mZ53Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="98511273"
Received: from unknown (HELO localhost) ([10.2.132.131])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 12:15:14 -0700
Date: Thu, 12 Sep 2024 12:15:13 -0700
From: Nirmal Patel <nirmal.patel@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 <linux-pci@vger.kernel.org>, <paul.m.stillwell.jr@intel.com>
Subject: Re: [PATCH v2] PCI: vmd: Clear PCI_INTERRUPT_LINE for VMD
 sub-devices
Message-ID: <20240912121513.000054b3@linux.intel.com>
In-Reply-To: <66e32e8d5e19a_3263b29452@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240820223213.210929-1-nirmal.patel@linux.intel.com>
	<20240822094806.2tg2pe6m75ekuc7g@thinkpad>
	<20240822113010.000059a1@linux.intel.com>
	<20240912143657.sgigcoj2lkedwfu4@thinkpad>
	<66e320bd9c800_3263b29421@dwillia2-xfh.jf.intel.com.notmuch>
	<20240912172534.ma3jc7po3ca2ytlh@thinkpad>
	<66e32e8d5e19a_3263b29452@dwillia2-xfh.jf.intel.com.notmuch>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 11:10:21 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Manivannan Sadhasivam wrote:
> [..]
> > I don't think the issue should be constrained to VMD only. Based on
> > my conversation with Nirmal [1], I understood that it is SPDK that
> > makes wrong assumption if the device's PCI_INTERRUPT_LINE is
> > non-zero (and I assumed that other application could do the same).  
> 
> I am skeptical one can find an example of an application that gets
> similarly confused. SPDK is not a typical consumer of PCI device
> information.
> 
> > In that case, how it can be classified as the "idiosyncracy" of
> > VMD?  
> 
> If VMD were a typical PCIe switch, firmware would have already fixed
> up these values. In fact this problem could likely also be fixed in
> platform firmware, but the history of VMD is to leak workaround after
> workaround into the kernel.

This is not VMD leaking workaround in kernel, rather the patch is
trying to keep fix limited to VMD driver. I tried over 10 different
NVMes and only 1 vendor has PCI_INTERRUPT_LINE register set to 0xFF.
The platform firmware doesn't change that with or without VMD.

> 
> > SPDK is not tied to VMD, isn't it?  
> 
> It is not, but SPDK replaces significant pieces of the kernel with
> userspace drivers. In this respect a VMD driver quirk in SPDK is no
> different than the NVME driver quirks it already needs to carry in its
> userspace NVME driver.
> 
> Now, if you told me that the damage was more widespread than a project
> that is meant to replace kernel drivers, then a kernel fix should be
> explored. Until then, let SPDK carry the quirk until it becomes clear
> that there are practical examples of wider damage.


