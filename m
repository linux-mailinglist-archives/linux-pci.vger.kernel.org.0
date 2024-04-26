Return-Path: <linux-pci+bounces-6692-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 722F38B39F5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 16:28:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F53289F80
	for <lists+linux-pci@lfdr.de>; Fri, 26 Apr 2024 14:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEBA14AD30;
	Fri, 26 Apr 2024 14:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxMAa3Mv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0955114884C;
	Fri, 26 Apr 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714141623; cv=none; b=Ez62bh5OZ4fcQqSCH0Q/bL2BlhbqrGrloHQI60+JN96gS6LL7fwKQ0o8xJlrlkFamCd+YlnRHOUKRoOC+ijQ6cLlRt71KAOmaZMTH9LvZAWpY8D8lTbOnnhSjHoJV1DCsdE2EBYFwGkLzJZFmTHR+wGY+RPepwwMtLlPk3sHNP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714141623; c=relaxed/simple;
	bh=RJXu2LkQVK1cV7mKmI83/hFP8kY8ALJVxwCc+HYZvWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aurOd/J2/oJI/MqJX2sSjKTS7QpfwH5xlx9cS8fxlH5/4TiZUaHljr3JFeFitylKSRVjqdrxtCRPn1BsJGQsS97aiMvF/zQv+ScLU3Df8y1nkAZc09/OXJFD/SJj27Kvi6+sdBbJwJaz5Q5H8vTPYplEpyHgIa/3A9sckPkakWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxMAa3Mv; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714141622; x=1745677622;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJXu2LkQVK1cV7mKmI83/hFP8kY8ALJVxwCc+HYZvWc=;
  b=MxMAa3Mv1bteFmPr1x98U8/NhY5q6LcEipJis6NMAN+2Zr27D4yWCzEC
   HDKj/EWfNLthV9zu907x/IpxcTsUVQcKq0ikX0G54VvT7Fq2Z9vkLAvbH
   BFOjjZiNK+qXOCqMV0azcnhCJp6dpcwohKss6natXWWkJr0uZmKl/6A79
   BkhQyxhawHRQeLAfdCk6xqdNcQ55m6UgcODDOvm9jsGKUnJSqWhCar80D
   7//7MWJHnX/r1P4ZEmb1wmYkL/p9R0MyrECSpT/8o3p4bSISuxcg8FqGk
   9UXmNIaFpfKQVbgwM/DPubLT2pOteV1u2K11hgnUW+/ZkoEcknikzd787
   w==;
X-CSE-ConnectionGUID: QJs1rEmQQfK1AoV0+BjXZA==
X-CSE-MsgGUID: 5G8GpWDYSMmylPkzMHXwYA==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="9748621"
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="9748621"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:27:01 -0700
X-CSE-ConnectionGUID: Z9MPD8bKRLWZvyNzP7TRqA==
X-CSE-MsgGUID: UCa/xp75QjicJtuXgCc+2g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,232,1708416000"; 
   d="scan'208";a="56607339"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 07:26:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s0MXJ-00000001LQV-3ha8;
	Fri, 26 Apr 2024 17:26:49 +0300
Date: Fri, 26 Apr 2024 17:26:49 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org
Cc: Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 0/4] PCI: controller: Move to agnostic GPIO API
Message-ID: <Ziu5qSjWLPoM9mbg@smile.fi.intel.com>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 08:19:03PM +0300, Andy Shevchenko wrote:
> Convert the PCI controller drivers to use GPIO agnostic API.
> While at it, remove of_gpio.h leftover from some of the drivers.

So, can we move forward with this series and its prerequisite?

-- 
With Best Regards,
Andy Shevchenko



