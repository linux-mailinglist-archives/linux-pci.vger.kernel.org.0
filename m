Return-Path: <linux-pci+bounces-44078-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC053CF674C
	for <lists+linux-pci@lfdr.de>; Tue, 06 Jan 2026 03:23:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB7AD30B06D4
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jan 2026 02:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3255523958A;
	Tue,  6 Jan 2026 02:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUupo1dn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CC423E23C;
	Tue,  6 Jan 2026 02:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767665789; cv=none; b=G52pAfLIOjVyjF7QWGji94py1jLT7wqKB0isSMZJjtlm6O35++4SHD/5hBzMO5VG3ue+FCyYu2PZQUk0mj9ZxBZy4rxsGnqNCOcMPQGMxAZtjY4XaJEHrg/CbUBGcJ/xVzbvVYhBTaf9bs/wl6B2CNagTvubwIQVJSXMdn+YoNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767665789; c=relaxed/simple;
	bh=CiGB+4rzK6i1SwpdmNWJEsX7ZPU/57gFdBA5bjM8wkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ToEaOXnwSCOE7iJX6JmRHa3X9eneJN4UUmKCL/FYI07MdvL2Qll4Hv9iT7CcL3PvwM2NIVmw+A0WwhKmNK5lXAmIRepIUNfQtZReLbol8xG3Geqy2u5Zwb3cCuvqo/osctNsFq/hZjIyKN3bW5WLkaEc0AqkTumDMBChEEVxQqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUupo1dn; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767665786; x=1799201786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CiGB+4rzK6i1SwpdmNWJEsX7ZPU/57gFdBA5bjM8wkc=;
  b=DUupo1dnPtACqO9azyN/LJ5+3mUJNp0u+EOfeDXZ1Sed7BnV7u5qobaU
   tlcQ80X3AgeUxMvxctu5pVoKj+fUVWw9b3uIN3AmfjxxLr3PqOWUDU4km
   6xsjL4YclaDN1yfpv3FDEtiSESYza3QZ1IYvR4y8IwC6dJbsOSFFYmfzB
   PLhFLvYT9T8FoSL0qGKleErZxUA6/IwWVYOePaI1iURw8EWbDqkjmDU44
   vmzsxHne9b6HB9+0leoMzgZLXw6UXw7LNHhyulEKrLNjtHHm7gJORNzY0
   QMklV/pVb4n2N6H0NMz4+10i+peceS60htsz1fEAtNi7rmP7KW5jRrPFJ
   Q==;
X-CSE-ConnectionGUID: 8s4um1ZzQdO+KQYnKSGZMg==
X-CSE-MsgGUID: g+ahbyenSSKHTVNIK6sUAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="72878903"
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="72878903"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 18:16:26 -0800
X-CSE-ConnectionGUID: B5ift3HpSHenLLSUIrgfrg==
X-CSE-MsgGUID: 3gsgizM/Sy2o0F/RJSXaRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,204,1763452800"; 
   d="scan'208";a="202781306"
Received: from yilunxu-optiplex-7050.sh.intel.com (HELO localhost) ([10.239.159.165])
  by fmviesa008.fm.intel.com with ESMTP; 05 Jan 2026 18:16:24 -0800
Date: Tue, 6 Jan 2026 09:59:17 +0800
From: Xu Yilun <yilun.xu@linux.intel.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	dan.j.williams@intel.com, yilun.xu@intel.com,
	baolu.lu@linux.intel.com, zhenzhong.duan@intel.com,
	linux-kernel@vger.kernel.org, yi1.lai@intel.com, helgaas@kernel.org
Subject: Re: [PATCH v2] PCI/IDE: Fix duplicate stream symlink names for TSM
 class devices
Message-ID: <aVxsdZlrh87tWuFk@yilunxu-OptiPlex-7050>
References: <20260105093516.2645397-1-yilun.xu@linux.intel.com>
 <20260105101317.00003ade@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105101317.00003ade@huawei.com>

On Mon, Jan 05, 2026 at 10:13:17AM +0000, Jonathan Cameron wrote:
> On Mon,  5 Jan 2026 17:35:16 +0800
> Xu Yilun <yilun.xu@linux.intel.com> wrote:
> 
> > The name streamH.R.E is used for 2 symlinks:
> > 
> >   1. TSM class devices: /sys/class/tsm/tsmN/streamH.R.E
> >   2. host bridge devices: /sys/devices/pciDDDD:BB/streamH.R.E
> 
> For those who have managed to completely forget, it would be useful
> to just mention what H R and E are. Given the docs
> say H is the host bridge number I'm a little confused why it
> isn't unique. At least at first glance I'd expect to see

No, the Documentation/ABI/testing/sysfs-devices-pci-host-bridge says
H represents a Stream ID slot (or a Stream index) within the host
bridge's context, not the host bridge index itself. So do R/E.

> stream0.0.0 and stream 1.0.0 your example.
> Maybe H isn't unique across segments / PCI Domains? (DDDD in the above)
> Maybe it should be?

No. The counter of H along with the pciDDDD:BB/available_secure_streams,
indicate the platform hardware limitation on the maximum number of
Streams a host bridge can support. It should not be a global counter
across System.

Thanks,
Yilun

