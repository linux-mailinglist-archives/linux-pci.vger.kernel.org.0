Return-Path: <linux-pci+bounces-1579-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C10821481
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 17:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B41BB21202
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 16:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BC8463A7;
	Mon,  1 Jan 2024 16:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCAVo10G"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FA6F63C7;
	Mon,  1 Jan 2024 16:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704127193; x=1735663193;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=S8I8/xcvQ90BCmeW2g6usrmvW8e/hziS5RmiC66MkmA=;
  b=XCAVo10GggaMPRdezkjbyLD7140IWKEk1RziqXR8kCdOML+XGIARt5K0
   EVgKxssGkGcDTCTjjfk6JFM5RCYc3nuaaNnS5yq/6PWBgyf/y7uchOrlW
   Mx9emV4ienKKzq4+gnh7H43PxeARgqTCLvRprWCvp2B0ol4tkF38dblWe
   Eg9XGjfatv3pza62YBiAyNukhZqKqEjm66fz57nwsDWyAaiGMPcXqDU/D
   qboC92GupSTmjdO3ucU28QUHD53PXh7LYKkmLu8vluViJrehTFpN1LFuy
   ZEU+GSOMPN5KyA6p0TyrYCz7MryWUf5fC3azbNkPsH9TMU56sfqwDsXOL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="376964818"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="376964818"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 08:39:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="755705282"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="755705282"
Received: from amazouz-mobl.ger.corp.intel.com ([10.251.210.158])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 08:39:47 -0800
Date: Mon, 1 Jan 2024 18:39:44 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
    LKML <linux-kernel@vger.kernel.org>, Alex Deucher <alexdeucher@gmail.com>
Subject: Re: [PATCH v3 09/10] thermal: Add PCIe cooling driver
In-Reply-To: <20231230190859.GA14758@wunner.de>
Message-ID: <b28c56af-35e2-cc68-939c-d1da5e82518c@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com> <20230929115723.7864-10-ilpo.jarvinen@linux.intel.com> <20231230190859.GA14758@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-987063157-1704127191=:2521"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-987063157-1704127191=:2521
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 30 Dec 2023, Lukas Wunner wrote:

> On Fri, Sep 29, 2023 at 02:57:22PM +0300, Ilpo Järvinen wrote:
> > @@ -253,8 +255,16 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
> >  	pcie_enable_link_bandwidth_notification(port);
> >  	pci_info(port, "enabled with IRQ %d\n", srv->irq);
> >  
> > +	data->cdev = pcie_cooling_device_register(port, srv);
> > +	if (IS_ERR(data->cdev)) {
> > +		ret = PTR_ERR(data->cdev);
> > +		goto disable_notifications;
> > +	}
> >  	return 0;
> 
> Now wait a minute, if you can't register the cooling device,
> you still want to provide accurate link speeds to the user
> in sysfs, right?  At least that's what you promise in Kconfig.

When thermal side is not even configured, it returns NULL which is not 
ERR.

I guess I can change the behavior for the real ERR cases (I was bit on 
borderline what to do with those failures).

> > --- /dev/null
> > +++ b/drivers/thermal/pcie_cooling.c
> > @@ -0,0 +1,107 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * PCIe cooling device
> > + *
> > + * Copyright (C) 2023 Intel Corporation.
> 
> Another trailing period I'd remove.
> 
> I take it this patch (only) allows manual bandwidth throttling
> through sysfs, right?  And emergency throttling is introduced
> separately on top of this?

Only sysfs throttling is introduced by this series, there's no emergency 
throttling in the series. Also, many things have been simplified in this 
series because more complex things would be only justified with 
the emergency throttling and would just raise questions 'why is this and 
that being done' (e.g., the critical section was enlarged as per your 
request where if there would be emergency throttlink doesn't make sense to 
wait until the end of the link training before "emergency throttling" can 
attempt to lower the link speed).


-- 
 i.

--8323329-987063157-1704127191=:2521--

