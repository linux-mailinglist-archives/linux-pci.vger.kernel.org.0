Return-Path: <linux-pci+bounces-33752-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E82BB20C5D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFECF424245
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:39:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A95C255E27;
	Mon, 11 Aug 2025 14:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="af1qJXa+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC61211A19;
	Mon, 11 Aug 2025 14:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754923174; cv=none; b=LJ2dRZj4/wVZwssKqdUXVgzYzxoGL1jzWofsygL+ujRRq8n4ArE4gjtNOoeNYHi9n369fTOfuOg5wADeJ+bSRz47cWGx9fTqoCUPHuhW4ilvpMjLFZ51Q6ke8tuc0UrGHFWDdajpF1k3tK3A5h+b/xhsQVyKmfUXSrwHjofWMpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754923174; c=relaxed/simple;
	bh=yK6rDPSgFLQb1GYEgO6lg7WokH7Te7oZfFnIgEfutoA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJM4fHpN2XF6ZOPqYIZrYl88RsS3ho0cERtXBmKRFAQ1NIKCTBJ6driZO/KWXMrR/BUyczFgXuxIAEFXuptRtZc9DuzW/Tagz5J0aVpkOXwpxN9CU8KwPyuIH8HvU5EawvYcDTIreQrAYEGm14jLS83t5tBoC57JLPNtBNBr++4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=af1qJXa+; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754923172; x=1786459172;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yK6rDPSgFLQb1GYEgO6lg7WokH7Te7oZfFnIgEfutoA=;
  b=af1qJXa+VL8LhUdmqHZaOxGqUJhnTuQvxQ7t6GgAuEnNcCALhg/wmo1c
   CSItr8oiW72ZvZPwptsdpypbxjeXYalgSkqZ+sN+2D0Y5MOUPLvk3Qxat
   TEzFvacXlMtkDF+EFNW0EIKwF8DlfFGRfhmDkT1xlpux1ncyGGtg5UZKW
   EgyXkKO++3ahDNqagcUSGheS5K/d2Eupo5a1YE142jWIZy095/AyAsXXs
   E4fDYFZPKd/tOTljKtZlmlaD0LFy2s7wpgdCr6ElJbH/AkHl9Y+qG7EM/
   EpAK+FAJHk0G1Jg/VBNIKJuyQ2EfyhGbJBu168RMhIgzpIkmBkSGt71Td
   A==;
X-CSE-ConnectionGUID: 0xWgYaQHSeKg3jLN25sd/g==
X-CSE-MsgGUID: UJMGGI8fTiOXS2rYtbXzGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57097878"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="57097878"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2025 07:39:32 -0700
X-CSE-ConnectionGUID: TbIeAuvuQEOXd2NjxV2dbQ==
X-CSE-MsgGUID: KAbOKEnrRumqcoTvJMv91w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; 
   d="scan'208";a="203118342"
Received: from black.igk.intel.com ([10.91.253.5])
  by orviesa001.jf.intel.com with ESMTP; 11 Aug 2025 07:39:28 -0700
Received: by black.igk.intel.com (Postfix, from userid 1003)
	id 0421694; Mon, 11 Aug 2025 16:39:27 +0200 (CEST)
Date: Mon, 11 Aug 2025 16:39:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Bjorn Helgaas <bhelgaas@google.com>, Marc Zyngier <maz@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Jonathan Cameron <Jonathan.Cameron@huwei.com>,
	Nicolin Chen <nicolinc@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Chen Wang <unicorn_wang@outlook.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, Yixun Lan <dlan@gentoo.org>,
	Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/4] genirq: Add irq_chip_(startup/shutdown)_parent
Message-ID: <aJoAnkBfLqKc7Frd@black.igk.intel.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250807112326.748740-2-inochiama@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 07, 2025 at 07:23:22PM +0800, Inochi Amaoto wrote:
> Add helper irq_chip_startup_parent and irq_chip_shutdown_parent. The

irq_chip_startup_parent() and irq_chip_shutdown_parent()

> helper implement the default behavior in case irq_startup or irq_shutdown

In the same way...

> is not implemented for the parent interrupt chip, which will fallback
> to irq_chip_enable_parent or irq_chip_disable_parent if not available.

In the same way...


...

> +/**
> + * irq_chip_startup_parent - Startup the parent interrupt
> + * @data:	Pointer to interrupt specific data
> + *
> + * Invokes the irq_startup() callback of the parent if available or falls
> + * back to irq_chip_enable_parent().

kernel-doc validator is not happy: Missing Return section.

> + */

-- 
With Best Regards,
Andy Shevchenko



