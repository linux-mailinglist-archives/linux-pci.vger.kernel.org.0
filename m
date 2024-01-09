Return-Path: <linux-pci+bounces-1928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B31682870D
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 14:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A53CE28200B
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 13:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF5839846;
	Tue,  9 Jan 2024 13:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WUx2fbyd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B3738FB6;
	Tue,  9 Jan 2024 13:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704806915; x=1736342915;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=d0c39di4Tp+tTMxJU6IKH8pkB8MqvtYukGD8nh4iNwQ=;
  b=WUx2fbydqiDPV4UMGtDduot8mwoq2nxm0lwwz2Tf3P8wnRL3TCUu9UqZ
   V8LbQ2Ty/g3GzZixl/eXqTbL9xnpjkYXCa4S3brRfnjNWl2DzgOLZ/SEf
   C/1L7F0HjJwHRQdfGVaoqd8MY0M9zwwLosB/ayix5mYp4pzgtxSOzTZN2
   GJpNj4pjlScF0rS0L+VIPmnSxEn40pwAGPNZqLElQp4bBoswJM4q1s10s
   EPfSLkbFhNM4fTtPiam0+FEW7BiRTDl2dpDJBIP3I3KYCur0B25rcxl+Y
   9b1t5qgbY2uOQXlGA+OuJEWnUuJSiH2ZJN6Lc4voacWJXwUUPO3iT5s4+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="388637096"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="388637096"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:28:34 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="905162112"
X-IronPort-AV: E=Sophos;i="6.04,183,1695711600"; 
   d="scan'208";a="905162112"
Received: from bhaddad-mobl.amr.corp.intel.com ([10.251.212.73])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 05:28:29 -0800
Date: Tue, 9 Jan 2024 15:28:27 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, 
    =?ISO-8859-2?Q?Krzysztof_Wilczy=F1ski?= <kw@linux.com>, 
    Lukas Wunner <lukas@wunner.de>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>, Alex Deucher <alexdeucher@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v4 6/8] PCI/link: Re-add BW notification portdrv as PCIe
 BW controller
In-Reply-To: <bcc6f870-88b2-95a8-ab6d-f1bef6448524@quicinc.com>
Message-ID: <bbd5c6b1-1a13-829e-87e2-b021614ac0d6@linux.intel.com>
References: <20240105112547.7301-1-ilpo.jarvinen@linux.intel.com> <20240105112547.7301-7-ilpo.jarvinen@linux.intel.com> <bcc6f870-88b2-95a8-ab6d-f1bef6448524@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1281701406-1704806913=:1696"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1281701406-1704806913=:1696
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 9 Jan 2024, Krishna Chaitanya Chundru wrote:
> On 1/5/2024 4:55 PM, Ilpo Järvinen wrote:
> > This mostly reverts b4c7d2076b4e ("PCI/LINK: Remove bandwidth
> > notification") and builds PCIe bandwidth controller on top of it.
> > 
> > The PCIe bandwidth notification were first added in the commit
> > e8303bb7a75c ("PCI/LINK: Report degraded links via link bandwidth
> > notification") but later had to be removed. The significant changes
> > compared with the old bandwidth notification driver include:
> > 
> > 1) Don't print the notifications into kernel log, just keep the Link
> >     Speed cached into the struct pci_bus updated. While somewhat
> >     unfortunate, the log spam was the source of complaints that
> >     eventually lead to the removal of the bandwidth notifications driver
> >     (see the links below for further information).
> > 
> > 2) Besides the Link Bandwidth Management Interrupt, enable also Link
> >     Autonomous Bandwidth Interrupt to cover the other source of
> >     bandwidth changes.
> > 
> > 3) Use threaded IRQ with IRQF_ONESHOT to handle Bandwidth Notification
> >     Interrupts to address the problem fixed in the commit 3e82a7f9031f
> >     ("PCI/LINK: Supply IRQ handler so level-triggered IRQs are acked")).
> > 
> > 4) Handle Link Speed updates robustly. Refresh the cached Link Speed
> >     when enabling Bandwidth Notification Interrupts, and solve the race
> >     between Link Speed read and LBMS/LABS update in
> >     pcie_bandwidth_notification_irq_thread().
> > 
> > 5) Use concurrency safe LNKCTL RMW operations.
> > 
> > 6) The driver is now called PCIe bwctrl (bandwidth controller) instead
> >     of just bandwidth notifications because of increased scope and
> >     functionality within the driver.
> > 
> > PCIe bandwidth controller introduces an in-kernel API to set PCIe Link
> > Speed. This new API is intended to be used in an upcoming commit that
> > adds a thermal cooling device to throttle PCIe bandwidth when thermal
> > thresholds are reached. No users are introduced in this commit yet.
> > 
> > The PCIe bandwidth control procedure is as follows. The highest speed
> > supported by the Port and the PCIe device which is not higher than the
> > requested speed is selected and written into the Target Link Speed in
> > the Link Control 2 Register. Then bandwidth controller retrains the
> > PCIe Link.
> > 
> > Bandwidth Notifications enable the cur_bus_speed in the struct pci_bus
> > to keep track PCIe Link Speed changes. While Bandwidth Notifications
> > should also be generated when bandwidth controller alters the PCIe Link
> > Speed, a few platforms do not deliver LMBS interrupt after Link
> > Training as expected. Thus, after changing the Link Speed, bandwidth
> > controller makes additional read for the Link Status Register to ensure
> > cur_bus_speed is consistent with the new PCIe Link Speed.
> > 
> > Link:
> > https://lore.kernel.org/all/20190429185611.121751-1-helgaas@kernel.org/
> > Link:
> > https://lore.kernel.org/linux-pci/20190501142942.26972-1-keith.busch@intel.com/
> > Link: https://lore.kernel.org/linux-pci/20200115221008.GA191037@google.com/
> > Suggested-by: Lukas Wunner <lukas@wunner.de>
> > Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

> > +/**
> > + * pcie_bwctrl_set_current_speed - Set downstream Link Speed for PCIe Port
> > + * @srv:	PCIe Port
> > + * @speed_req:	requested PCIe Link Speed
> > + *
> > + * Attempts to set PCIe Port Link Speed to @speed_req. @speed_req may be
> > + * adjusted downwards to the best speed supported by both the Port and PCIe
> > + * Device underneath it.
> > + *
> > + * Return:
> > + * * 0 		- on success
> > + * * -EINVAL 	- @speed_req is not a PCIe Link Speed
> > + * * -ETIMEDOUT	- changing Link Speed took too long
> > + * * -EAGAIN	- Link Speed was changed but @speed_req was not achieved
> > + */
> > +int pcie_bwctrl_set_current_speed(struct pcie_device *srv, enum
> > pci_bus_speed speed_req)
> 
> we want to use this API from PCIe client driver, but can't use API as client
> driver is not aware of pcie_device structure,
> 
> can you please make changes in this API so that PCIe client drivers can also
> use it. And also can you please export this API.

I'll make v5 interface based on struct pci_dev *. It will require looking 
up the internal data structure though.

-- 
 i.

--8323329-1281701406-1704806913=:1696--

