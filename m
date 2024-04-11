Return-Path: <linux-pci+bounces-6120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBF28A12C9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 13:16:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 276A9282989
	for <lists+linux-pci@lfdr.de>; Thu, 11 Apr 2024 11:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 181F2147C7E;
	Thu, 11 Apr 2024 11:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qq11f7nu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521E13BACD;
	Thu, 11 Apr 2024 11:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712834184; cv=none; b=giiuij21oN2nFr8Z68I4poiwO6kS+P5ESUFtSY8vHVMKr7Hcv5mf0d7tQKSUfEgI/qVCUs3QojKqx7WOPHBnmssMmNnIWoLmwqk4v70zY0k/CUthha2H5REf4Z3kyZiGCBlU89lq4KUbX7eB/j0fg5+frUGDK7h8e5lmKYU7uYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712834184; c=relaxed/simple;
	bh=EMjB2PkfxOKh9q7sZ971SXpVJUsNb9m2hkWniDsCrtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZambIofvl5wH0iS2KKFxQWEvmlGABLzvLyQHasXkFmwCfEpQS84cvOHaQ+7by+wSfJa/w145oJ9ldkEgZjpsPHp/WNhJeoDj7+KtCr1v1B85FFQqVQ5ttr2XU6nQtE0BwD6YGo4k+RHVnDYbjFi/rMTwfLyepuQcbdeFGn1Ar2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qq11f7nu; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712834183; x=1744370183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=EMjB2PkfxOKh9q7sZ971SXpVJUsNb9m2hkWniDsCrtw=;
  b=Qq11f7nub21JM3jAz44rxBrbQbzmjPzA5Frw8fiBhP/YFOfaBj/kldrJ
   dQW83Ve/tGEh/XZ56vJ6KN7xUXNG1iXs/Mnr3vgCXiw0DiAUm3vXVV00K
   PaPEEmQu3exgomKbte7m2Gcys47CO5svPa6DMAOFHYN8Witw3RQWEUE8h
   rBhv01vTlmJ65Go/o1AKxTBvdcDq/zahBmTjwd3Dlf60075C4hfCKmANl
   zEo/F3M74EyigY6egXeuDKAKlLDRef7BJlYvqV5UGfUgggrW39TzO9y4I
   mRmkkMs30LDZC2VOmKfPwH0HnmaiwF7QCd1PqSPDGTfUoLgR3TCSpRBnX
   Q==;
X-CSE-ConnectionGUID: pIY/55BtTvG2lW7xiGozvg==
X-CSE-MsgGUID: PTeUaSOeSgOwos87kB2sKQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="30717975"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="30717975"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:16:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="915460597"
X-IronPort-AV: E=Sophos;i="6.07,193,1708416000"; 
   d="scan'208";a="915460597"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2024 04:16:18 -0700
Received: from andy by smile with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1rusPf-00000003KVn-2ah1;
	Thu, 11 Apr 2024 14:16:15 +0300
Date: Thu, 11 Apr 2024 14:16:15 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Igor Mammedov <imammedo@redhat.com>, Lukas Wunner <lukas@wunner.de>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>, linuxarm@huawei.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 0/7] PCI: Solve two bridge window sizing issues
Message-ID: <ZhfGf4ycvv6LcKlv@smile.fi.intel.com>
References: <20231228165707.3447-1-ilpo.jarvinen@linux.intel.com>
 <20240409155305.00003022@huawei.com>
 <76a2504d-f68b-4d39-8aa5-92c5ef3f2ae3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <76a2504d-f68b-4d39-8aa5-92c5ef3f2ae3@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 11, 2024 at 01:41:10PM +0300, Ilpo Järvinen wrote:
> On Tue, 9 Apr 2024, Jonathan Cameron wrote:
> > On Thu, 28 Dec 2023 18:57:00 +0200
> > Ilpo Järvinen <ilpo.jarvinen@linux.intel.com> wrote:

...

> E.g., there are
> zero pci_dbg()s in pci_bus_distribute_available_resources(). So unless the
> window is adjusted, we have zero information on what's going on so no
> surprise why everyone is "drawing a blank". :-(

Perhaps it's a good time to start trace events / points for PCI (if not yet)?

Just my 2c.

-- 
With Best Regards,
Andy Shevchenko



