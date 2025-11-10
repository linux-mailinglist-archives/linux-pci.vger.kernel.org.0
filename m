Return-Path: <linux-pci+bounces-40670-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A10C44F56
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 06:07:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0F453AF554
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 05:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF134D395;
	Mon, 10 Nov 2025 05:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lo1XK50G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA361CAA85
	for <linux-pci@vger.kernel.org>; Mon, 10 Nov 2025 05:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762751199; cv=none; b=EdsHYzAiANhkD1jFjt448BEIFxdYXpl8DoPidesTfunWNTRZVsa7m106zMRnQLMoeviU7q+d8qf1mS9VBxwAJrzuPDnRwSO4Ume+dhd2hDo27pdnv0zqFIElY6hXG/FWR+YjuM8uhmfBmrcCsqf22+zydMjPiuHFzuTWYvp1eyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762751199; c=relaxed/simple;
	bh=3syPyEjwbe0v4OHKiHnXH5KoxOW5Bm2iafe6a+6WjXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AFEJBnKoVNymDNqfIoMe5n61r+E16sEE8dFDdNGukxIyhpY1ER8i/8XyWmG8Yfb0No41GMmT/foCB4rAGS935mlOuCgkehbLgP6Ea1dy/M0YCr4acmsmFAHZxP0rGtdbeEXwaaK5dRqdcPQbkYeLFFbAOhvt3zRjUn6tT9mp6+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lo1XK50G; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762751198; x=1794287198;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3syPyEjwbe0v4OHKiHnXH5KoxOW5Bm2iafe6a+6WjXQ=;
  b=lo1XK50Gp824P3Lukwgyi3+d/0kDkGeskUXDYtSsJzKopIcw3WGjdiLV
   dFSqRLOS8YITufbUJiHrFKYhI90AKOc2bLCF7t6s9YyLWDOv/kmUkh+ry
   bbZInAlyX4TakhMDo9vcvHL0yf5Ypv7xXOmnXPPUPHc0BtXEOoZGq35S2
   CTeXHZfLLOHAqE1M+cC0a95A222jmIqqfiwlMcYFpIjQS1hFf2K7XdIsc
   rQ5jzrJ4c6tENP3yd1E0KAaX9roPmpFo/TkB1cpB1nwoBr+kr5IoJX1wX
   tKQwQ/QpxWTbqsrwDXop3EFPeNwtIBEjUTK5xVBxdYfi8llsP646DXnAl
   A==;
X-CSE-ConnectionGUID: 1Zn17buMTG2thLZVB7szRQ==
X-CSE-MsgGUID: mbjvOsVYS3yKbihqvzLucA==
X-IronPort-AV: E=McAfee;i="6800,10657,11608"; a="90268531"
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="90268531"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 21:06:37 -0800
X-CSE-ConnectionGUID: yHl7i017T9OVxxMKYzDFqg==
X-CSE-MsgGUID: Up2VqSVgRl28BO7AAPzh1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,292,1754982000"; 
   d="scan'208";a="187829459"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by orviesa006.jf.intel.com with ESMTP; 09 Nov 2025 21:06:35 -0800
Date: Mon, 10 Nov 2025 12:52:14 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-pci@vger.kernel.org, linux-coco@lists.linux.dev,
	gregkh@linuxfoundation.org, aik@amd.com, aneesh.kumar@kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v8 9/9] PCI/TSM: Report active IDE streams
Message-ID: <aRFvfnTy9Yn9E4Eu@yilunxu-OptiPlex-7050>
References: <20251031212902.2256310-1-dan.j.williams@intel.com>
 <20251031212902.2256310-10-dan.j.williams@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251031212902.2256310-10-dan.j.williams@intel.com>

On Fri, Oct 31, 2025 at 02:29:01PM -0700, Dan Williams wrote:
> Given that the platform TSM owns IDE Stream ID allocation, report the
> active streams via the TSM class device. Establish a symlink from the
> class device to the PCI endpoint device consuming the stream, named by
> the Stream ID.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Reviewed-by: Alexey Kardashevskiy <aik@amd.com>

Reviewed-by: Xu Yilun <yilun.xu@linux.intel.com>

> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

