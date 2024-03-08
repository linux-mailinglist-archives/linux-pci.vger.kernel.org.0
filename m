Return-Path: <linux-pci+bounces-4664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE7BE876401
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 13:09:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D0841F21ABC
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 12:09:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E41EB56746;
	Fri,  8 Mar 2024 12:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MIqkmyMZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD61535CA;
	Fri,  8 Mar 2024 12:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899776; cv=none; b=JfGVB+GrFbwIeuE3DQrYonaRc1pZTfTCpDq/0EUJdxayvcevvzPNWG+bcKL8rRUF0wnn6D9MS3GW/jy/W7yBelu/M1BHXqBAppYo+hcnsBxg7RQ+pnSBAbv1SYOIygs0Zrawtvl54p3nmNmhUPZXEdX7XvrQvqiImUXxyb/EtXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899776; c=relaxed/simple;
	bh=47pcurjwzPpbUDu63TliTFtfRuG+YF86mZd6kUPfo2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SJ5si2yT9p5/Kz+qpAefaihH+f0HfcPNXfpkMYWzC+vFQdPSdssBSUG3jBC+B6uo7CdYwUNMUYKWffQVp1XF7JAz93aqwMbc+HXHpZtjr9zNcNGqe2gK2oHZACLUJ/Lou2RMVVQZ1Zh3yBMKMRWcQ80eVDO+1Gek8eDrEr4uEBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MIqkmyMZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709899775; x=1741435775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=47pcurjwzPpbUDu63TliTFtfRuG+YF86mZd6kUPfo2M=;
  b=MIqkmyMZaWOrBrbYOOkLyPd7VF1MZf9fiYVbfVtpdM98O11ksx1G0FIz
   boV3fIkVVgzqYOYzS7ZfX1Uh+lbeycijk0eUsTuWdNiXzG21YXrbLHbA+
   m4JBb5DH1PZSNQ5gxB/XTA5dcEF0PrnEO7PT5DE7hBREsVhy0i62ePzID
   sKeogHpnEnMs6efw4YFNKr96labs0iJZBvoi+NKAl8QDjX9gSWepPPhCG
   xapENMc8MHaaFOkVdnL0IbxjG+1QzOIpEl7v0aFxAt9zPMnk5gAFCX1E7
   HnaKExYCdd6CDwz7YBAU74f3CzV4YtFQwo3pYi1qUsIjueLStVQXhZngZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="30058154"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="30058154"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 04:09:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11006"; a="914244912"
X-IronPort-AV: E=Sophos;i="6.07,109,1708416000"; 
   d="scan'208";a="914244912"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2024 04:09:28 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1riZ2T-0000000Apo3-2KVa;
	Fri, 08 Mar 2024 14:09:25 +0200
Date: Fri, 8 Mar 2024 14:09:25 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-amlogic@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v1 1/1] PCI: dwc: Remove unused of_gpio.h
Message-ID: <Zer_9VTVJqCNoOFG@smile.fi.intel.com>
References: <20240307122840.3682287-1-andriy.shevchenko@linux.intel.com>
 <20240308095547.GI3789@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308095547.GI3789@thinkpad>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Mar 08, 2024 at 03:25:47PM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 07, 2024 at 02:28:40PM +0200, Andy Shevchenko wrote:
> > of_gpio.h is deprecated and subject to remove.
> > The driver doesn't use it, simply remove the unused header.

> What about the rest?
> 
> drivers/pci/controller/dwc/pcie-kirin.c
> drivers/pci/controller/dwc/pci-imx6.c

Have you chance to look at them?

> There is also one non-dwc driver:
> 
> drivers/pci/controller/pci-aardvark.c

Keyword: non-dwc.
This patch is for DesignWare controllers that confirmed not using the header.

> It is better to remove it from all PCI drivers in a single patch.

I disagree on this. These are different drivers and even inside DesignWare not
all of them can be converted with a simple change like this one.

That said, please consider applying this one as is.

-- 
With Best Regards,
Andy Shevchenko



