Return-Path: <linux-pci+bounces-33941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 80AE0B249E8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 14:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C57F18932AC
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 12:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A39CF2DCF5F;
	Wed, 13 Aug 2025 12:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IY0ZZqgD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CC727602D;
	Wed, 13 Aug 2025 12:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755089691; cv=none; b=BVJjzaXIqlk3Gu97YWPLxYJOk0tU84kTIqDtsVlvmakQj5StGZUWvz5y7WAQmcvG9N23RxEvfpzca9GfhydlAQFZomMeDmA/0dLQonWLweaJblE+czTSos7QGXlCpXq/Qkhzyt2uJhDW4FzImJNeqic6QKWIxI0KWqwFsu6j+/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755089691; c=relaxed/simple;
	bh=yX64wkEiRVLBeyc3qQ2oLgH4oEtjcIE2idzHItV67io=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BszXXg72WjXmXU6bARSyO4o/oDUGNo8m4lXav2vkqOFEdTBRCloixz4dYS6/3/RnlsPbLl9R0QRZJnJIsyb21cCpf95eTEJtaGcdZ8hJB7eigD+iv1vEWVzSzfes+LSD+6U6O+B+Ou2ow0JlBGlYB4uwAWtOpD5nJB0KYVaOiNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IY0ZZqgD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755089690; x=1786625690;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yX64wkEiRVLBeyc3qQ2oLgH4oEtjcIE2idzHItV67io=;
  b=IY0ZZqgDKJnFOxRyMGaOSbVVZfym9usp4AROXpK+Wcur4y2mb7CWQksa
   eEdboSgyiugYoWDs+rz07U/JsWLTfF//gepJ5R+HI2RPYT/jeAB8Z8eEd
   tcM6/vIEjhaGdYVCQOFoqscob+rgemD9FA6cWlRjVuBhh+4TnO3zGsNQM
   vY+CZWfTKmG0B5sN7i+Mmoe2pijB7d3pVJOYlIloWlF0g+oGz1FJ9IBQ3
   vE57Pq456sVEKetnKIY9QF7QItQN9XbPETUukkSz/wttIoBy18T2kKS1E
   JYnXU2uotowwkLrFfeGTe4PbzUFNYyFwjUpHc+j5tG/SojjYZqoNwS8Wb
   Q==;
X-CSE-ConnectionGUID: kTGicZcnRZSF4v2lUPuD0Q==
X-CSE-MsgGUID: sBU2tfXKSbOu+0OhOBaSlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="61183331"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="61183331"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 05:54:47 -0700
X-CSE-ConnectionGUID: FTG1wQLORl2/VJ7Xu2vX0Q==
X-CSE-MsgGUID: Pe2i+pe8SfKTU/fIlRrLCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166729068"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 05:54:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1umB04-00000005RGW-1CDD;
	Wed, 13 Aug 2025 15:54:40 +0300
Date: Wed, 13 Aug 2025 15:54:40 +0300
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
	Longbin Li <looong.bin@gmail.com>, Han Gao <rabenda.cn@gmail.com>
Subject: Re: [PATCH 3/4] irqchip/sg2042-msi: Fix broken affinity setting
Message-ID: <aJyLEManKJ2P8HYV@smile.fi.intel.com>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-4-inochiama@gmail.com>
 <aJoBdHlV6ZKcFry5@black.igk.intel.com>
 <gnk4w7lmgvgwh3kdu3fn4c3frcyivkeukxrq63s223v4t7khcw@ft26odg7qtu6>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gnk4w7lmgvgwh3kdu3fn4c3frcyivkeukxrq63s223v4t7khcw@ft26odg7qtu6>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Aug 12, 2025 at 06:37:35AM +0800, Inochi Amaoto wrote:
> On Mon, Aug 11, 2025 at 04:43:00PM +0200, Andy Shevchenko wrote:
> > On Thu, Aug 07, 2025 at 07:23:24PM +0800, Inochi Amaoto wrote:
> > > When using NVME on SG2044, the NVME always complains "I/O tag XXX
> > > (XXX) QID XX timeout, completion polled", which is caused by the
> > > broken handler of the sg2042-msi driver.
> > > 
> > > As PLIC driver can only setting affinity when enabling, the sg2042-msi
> > > does not properly handled affinity setting previously and enable irq in
> > > an unexpected executing path.
> > > 
> > > Since the PCI template domain supports irq_startup/irq_shutdown, set
> > > irq_chip_[startup/shutdown]_parent for irq_startup/irq_shutdown. So
> > > the irq can be started properly.
> > 
> > > Fixes: e96b93a97c90 ("irqchip/sg2042-msi: Add the Sophgo SG2044 MSI interrupt controller")
> > > Reported-by: Han Gao <rabenda.cn@gmail.com>
> > 
> > Closes ?
> 
> I got a direct private email from Han, so I think there is no pulic
> Closes.

It's better to follow current practise (by at least some of the fix code
authors) to make this as a comment in the patch (text, that goes after '---'
but before actual diff).

No need to resent just for that, as you basically explained it here.
(but it seems we will have a new version anyway)

-- 
With Best Regards,
Andy Shevchenko



