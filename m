Return-Path: <linux-pci+bounces-6628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9039E8B0C3A
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 16:15:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74AC41C221E3
	for <lists+linux-pci@lfdr.de>; Wed, 24 Apr 2024 14:15:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB1D15E800;
	Wed, 24 Apr 2024 14:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dVGnSlhR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A632E15E812;
	Wed, 24 Apr 2024 14:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713968128; cv=none; b=iuuBpAlvhX6zL5KMEmChC6pFOCoz/ER0ATbaUaUwlgknKEzo3HN0iH9DzwAHFwDFA22ub4ocs3VaMPC2MVPo3TjEZjifhkCsj5BXbIgDwHF5KOEsnzaGsO59zT7RqQcq2LZ6ofcKQIXCfaPerVwQhl09R3aqBNHgSwsBjo394yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713968128; c=relaxed/simple;
	bh=gMosq5KDq4+veBQ/DQ6irfWO7y5x/xROAoojLy7Xjtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xqot1J7XnNe4ohPiXxKNA567iCtHelpBmbiGFNoHHekeQJuiXw9mWLgRuStCWrUvU1iywWe6hqHInKAo3FQrm6cDEuohei/oO9Lo+7ENFyZxJR4lP+p0yRsb55x2uPT8IgoPWiFvg48oPug29izoASbaYRa41g9v/C8ySFxAWJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dVGnSlhR; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713968126; x=1745504126;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gMosq5KDq4+veBQ/DQ6irfWO7y5x/xROAoojLy7Xjtg=;
  b=dVGnSlhRZV7nhbWNdiW3nqfhhKx2kJ7Genk8wkXUFBhL8E7k9h9lSIOs
   uSdudpEtYFiY6AIooMhGghqmaNcLfcurq7jKdAdXmpZPYuLtcQJmnQ8H6
   RBJG4AsRvB1xgLPrv5pRslU+F1+u6aSORZi6OIaycav8P1sh8fKQU/UMP
   Z26E8gXX0zNi5N3GtPWRmXKuTCFdpcoHN1YU5KNlcBLp/LyNlnPINGY68
   5zhz4owj6aee8+43IWpbZWGyad52lzi8mfjg82Mfbl8d4eUjpg485TOce
   nOfsfkG7nfLX3x/g1sSV4kevKfqZAUUYyuSI1GxqGYGRGtPzSrBL11eYh
   A==;
X-CSE-ConnectionGUID: Q8On72LzTR2w/shEfOD7tQ==
X-CSE-MsgGUID: DUJi485yTBCzk3Ik2nNjJQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11054"; a="9452609"
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="9452609"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:15:25 -0700
X-CSE-ConnectionGUID: 1PwAzvoPSYuU9xCed7iHNw==
X-CSE-MsgGUID: H6Za2bLiQaqX+cjCsv32Mw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,226,1708416000"; 
   d="scan'208";a="29527516"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 07:15:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rzdOz-00000000ffl-36yR;
	Wed, 24 Apr 2024 17:15:13 +0300
Date: Wed, 24 Apr 2024 17:15:13 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Frank Li <Frank.li@nxp.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
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
Subject: Re: [PATCH v2 3/4] PCI: imx6: Convert to agnostic GPIO API
Message-ID: <ZikT8QczxkIXoOlc@smile.fi.intel.com>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-4-andriy.shevchenko@linux.intel.com>
 <ZigSiCBIwoEIPYoG@lizhi-Precision-Tower-5810>
 <ZigUL7exXBSbWDIR@smile.fi.intel.com>
 <ZigXJJj4e+oaANAt@lizhi-Precision-Tower-5810>
 <ZigYqtyn4BTbWgRu@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZigYqtyn4BTbWgRu@lizhi-Precision-Tower-5810>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 23, 2024 at 04:23:06PM -0400, Frank Li wrote:
> On Tue, Apr 23, 2024 at 04:16:36PM -0400, Frank Li wrote:

...


> Reviewed-by: Frank Li <Frank.Li@nxp.com>

Thank you!

-- 
With Best Regards,
Andy Shevchenko



