Return-Path: <linux-pci+bounces-7167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A55118BE336
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6065B283097
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 13:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EF515E5B8;
	Tue,  7 May 2024 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZbChpJAr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2585915DBDD;
	Tue,  7 May 2024 13:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715087572; cv=none; b=YBdvhw7uimx6WbttXgr2I4/pwkE/07OpdQK6jjv44VTPIy1DX55xGF5HPXHxpYKzIx13ubuOkTgqFND5hWQAN8jlTMK2vpXZ6MfMPcmrltqJnjRPlY6v5sc43L+hBYtFUQBVfZY79tlhU2T9Tc4C4rUKfFWjdRO19X3YvkrY9r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715087572; c=relaxed/simple;
	bh=a6gSLSNzkB7vq5lvXJKxfEYqY5Zj8C4OuyJc6Y6NlXY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KrpkVfnJky6YgXfsTJwoURDCiQCAOKKQ5+HR5O1/GC8BXFef2iW8YnUe0MZYmLKaB6HaRBVLfgiyINHe43g14VWAGJkQs4HInOXUB+v22r18Vak5VNv/jsoVUmYHkJvImL4cty2Ij6nmMK/CgHX19n0nXNdc3Tl32LwZiSwCfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZbChpJAr; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715087571; x=1746623571;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=a6gSLSNzkB7vq5lvXJKxfEYqY5Zj8C4OuyJc6Y6NlXY=;
  b=ZbChpJArKKyAZtijh9SZK5lQT+/9D+Z3PF2ie8fJU9RldW+A5gjAGaQe
   /Y+C2Y+6ve62ddd4yC0eZJOQjvOjXwF5i4qwK3vCx7x8foz8Rnhp5egCK
   /5FkFpJ6rxTvYntGyU7WETqNyNY7rO4wVQ7TPwZ3JTl7fGFp8b22R9/3g
   kFpUZGJbH7F8BvnxZpOENEwjtc2zkemH7ibSS/wywW+aNHZqIE/iOapMq
   0lucxkxRsRzh4SzG8ej5lt6syH+EmYdNTGnSE9X7uC2WeyiYyi0j30li3
   P2RYwZQPka8IIMNSKXKjmDxVfxxBWT4NF72DsSSsA1X14Hw2NSU6zDSfy
   w==;
X-CSE-ConnectionGUID: N9U1l4zQQm2ybNIbe0Jzvw==
X-CSE-MsgGUID: kerm2+NSRcmgoLVbalMd8Q==
X-IronPort-AV: E=McAfee;i="6600,9927,11065"; a="21483943"
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="21483943"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:12:50 -0700
X-CSE-ConnectionGUID: Fu6nYwQcTgeZWSY044wYqQ==
X-CSE-MsgGUID: MsXTeSYhRgedCqb9bG/apQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,261,1712646000"; 
   d="scan'208";a="28920705"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 06:12:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1s4KcY-000000052fm-0iB8;
	Tue, 07 May 2024 16:12:38 +0300
Date: Tue, 7 May 2024 16:12:37 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
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
Subject: Re: [PATCH v4 0/5] PCI: controller: Move to agnostic GPIO API
Message-ID: <ZjooxTO3wb2ItvGv@smile.fi.intel.com>
References: <20240506142142.4042810-1-andriy.shevchenko@linux.intel.com>
 <CACRpkda=a3X=jyZKQoOFrfgzpE2C+rZ9UC1VDnCvGL7QP4x4BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACRpkda=a3X=jyZKQoOFrfgzpE2C+rZ9UC1VDnCvGL7QP4x4BA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 07, 2024 at 12:03:50PM +0200, Linus Walleij wrote:
> On Mon, May 6, 2024 at 4:22 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> 
> > In v4:
> > - added tag (Mani)
> > - fixed a polarity bug in iMX.6 driver (Linus)
> 
> Looks good now. The series:
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Thank you!

> Perhaps the use of  _raw accessors could be avoided in 5/5 by some
> elaborart polarity quirk but I'm no perfectionist and it can be fixed later.

After your comment I was thinking the same, and came to the similar conclusion,
we might fix this later as in comparison to iMX.6 case this requires an
additional code to be added to gpiolib-of.c.

-- 
With Best Regards,
Andy Shevchenko



