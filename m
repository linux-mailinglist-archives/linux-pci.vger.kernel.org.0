Return-Path: <linux-pci+bounces-1547-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9271F81FF6A
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 13:24:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 483FE1F243BA
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 12:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15C6D11197;
	Fri, 29 Dec 2023 12:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="efqfWp81"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBDB11C80;
	Fri, 29 Dec 2023 12:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703852674; x=1735388674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=aurePmLofIA0vQ9MuqkyTIcVPSgmqQEk9JYs9fwJovo=;
  b=efqfWp81sh2CoVmPO7Oh5xlyCNFurVqe/pP/cUR8RoSwq3yqGn6UvN3P
   GRKF5uFd6BuIMsx2BSpMOQVQ9l5+7qSqMcwQ7rHYMw8YDtidrMiKg0J6B
   PWZWBt/HKCKtsZ2BaR9twpGwGxONAcC7PUmh2F5ozxdwcsVecngir3IQ7
   w35RqbG8m/MR+NWhTeguesVTCHcmldBxmu00LM9F8MlnmKddrJndNb6ry
   dxsMXxGiBx2bPE3mek/xrIIE5zIvcn/97RBto/mI86iYcQDuDhmnPAOkJ
   zfRSR9sazZ36gTyGtM6fzYwpwidgFFnuekaBsqIKjgs+pwHd1CcbzFvow
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="381617786"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="381617786"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2023 04:24:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10937"; a="807679892"
X-IronPort-AV: E=Sophos;i="6.04,314,1695711600"; 
   d="scan'208";a="807679892"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 29 Dec 2023 04:24:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 4A158241; Fri, 29 Dec 2023 14:24:29 +0200 (EET)
Date: Fri, 29 Dec 2023 14:24:29 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <20231229122429.GH2543524@black.fi.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>

Hi Ilpo,

On Thu, Dec 28, 2023 at 06:57:00PM +0200, Ilpo Järvinen wrote:
> Hi all,
> 
> Here's a series that contains two fixes to PCI bridge window sizing
> algorithm. Together, they should enable remove & rescan cycle to work
> for a PCI bus that has PCI devices with optional resources and/or
> disparity in BAR sizes.
> 
> For the second fix, I chose to expose find_empty_resource_slot() from
> kernel/resource.c because it should increase accuracy of the cannot-fit
> decision (currently that function is called find_resource()). In order
> to do that sensibly, a few improvements seemed in order to make its
> interface and name of the function sane before exposing it. Thus, the
> few extra patches on resource side.
> 
> Unfortunately I don't have a reason to suspect these would help with
> the issues related to the currently ongoing resource regression
> thread [1].
> 
> [1] https://lore.kernel.org/linux-pci/ZXpaNCLiDM+Kv38H@marvin.atrad.com.au/
> 
> v2:
> - Add "typedef" to kerneldoc to get correct formatting
> - Use RESOURCE_SIZE_MAX instead of literal
> - Remove unnecessary checks for io{port/mem}_resource
> - Apply a few style tweaks from Andy
> 
> Ilpo Järvinen (7):
>   PCI: Fix resource double counting on remove & rescan
>   resource: Rename find_resource() to find_empty_resource_slot()
>   resource: Document find_empty_resource_slot() and resource_constraint
>   resource: Use typedef for alignf callback
>   resource: Handle simple alignment inside __find_empty_resource_slot()
>   resource: Export find_empty_resource_slot()
>   PCI: Relax bridge window tail sizing rules

Thanks for doing this! :)

All look good to me,

Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>

