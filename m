Return-Path: <linux-pci+bounces-31447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00DA7AF815B
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 21:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E1211C40C24
	for <lists+linux-pci@lfdr.de>; Thu,  3 Jul 2025 19:30:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195822F2736;
	Thu,  3 Jul 2025 19:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cEiKHGt4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905042F2C7D
	for <linux-pci@vger.kernel.org>; Thu,  3 Jul 2025 19:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751571001; cv=none; b=AY9JgAo0htLjluxjE7A+fz2tD4UNFS9RKG+UhZ1tWJ6QKPk8eg9MhZhMNooc2lOBLk0ussYwLrSaDKdNemeMbiZYL6f/rjvR+Q8q+W/fJ0hQxjaHTZuGEsOQClRSQ41m6r8Fu8psjVoMnVmXm/fBBLSgsaCaxh/EaMW2zH7K5Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751571001; c=relaxed/simple;
	bh=S5LofzUEXpq1vyCwo3YZcP+hQsGsFW0lU5QbNdytI7I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddFsB1lXEFPCKqemmiDmLq1jom80FdLVLrIcBWtLHqedmo+LuhjrFCFYflezQMRDfrNhtFjnf5i1+3v7Kmv1/IPQWWEEcNgXPlmfWaV4sFUV6lsT/HWQ+4fafYy9rVk7ZEQlEYCxK5VIj78QWM5Ywl/Pu4cvi+oKv6a8FfG1P5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cEiKHGt4; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751571000; x=1783107000;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S5LofzUEXpq1vyCwo3YZcP+hQsGsFW0lU5QbNdytI7I=;
  b=cEiKHGt4uhUoqQJrj50jHHAsYspKmgmVIW5/yhkQgN0oZ3VFin1bxYuZ
   KuxN9MuZwcBRR6ERl1mAOapcZRHczReK1F3gNZssOgYPXdHJ0/da0IarB
   lIZtT7WhJBUxuyvKQczAJKRrTZQI8diom5zjvxu65bgUVlHLiIhaxwDSD
   lcICqnP6LuG7mpqqSp4VdnvC0PqK8rF4YPnAb5lj+6Z7GCUze6T56YUdJ
   SdcUN/ywTaQkylBZNuW0Lr8MTq7T3V5BNqg7Pm9KvFEMh/GK4zNQRXiHK
   CDd1CkQJCS/4YwvMd6YchP7UjYQkyOg1VQhg3jBiCvppqFO76VsjWt/zq
   A==;
X-CSE-ConnectionGUID: WGTmeNBLSCqFzyS/qJ3AuA==
X-CSE-MsgGUID: bZ2qWoJcSwSIkRQ1FsHTIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="54024336"
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="54024336"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:30:00 -0700
X-CSE-ConnectionGUID: gJ+8UEYCShSEF1UXpBmqjg==
X-CSE-MsgGUID: ktih2KroQKWMHOuYOaJtxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,285,1744095600"; 
   d="scan'208";a="185399038"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 12:29:58 -0700
Date: Thu, 3 Jul 2025 12:29:57 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: David Airlie <airlied@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>,
	Ben Hutchings <ben@decadent.org.uk>, Joerg Roedel <joro@8bytes.org>,
	Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
	Ahmed Salem <x0rw3ll@gmail.com>, Borislav Petkov <bp@alien8.de>,
	Hans de Goede <hdegoede@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] agp/amd64: Check AGP Capability before binding to
 unsupported devices
Message-ID: <aGbaNd3qCK3WvAe-@tassilo>
References: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b29e7fbfc6d146f947603d0ebaef44cbd2f0d754.1751468802.git.lukas@wunner.de>


I suspect these days it would be also reasonable to drop it this old
hack.

If any of these old chipsets are still missing I would rather adds its
PCI-ID.

There will be certainly not any new unknown ones for these old CPUs.

Also there shouldn't be that many high speed devices that need the 
old 4GB IOMMU anyways, and for low speed ones it's fine to use swiotlb
instead.

-Andi


