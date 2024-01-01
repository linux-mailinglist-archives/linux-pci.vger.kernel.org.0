Return-Path: <linux-pci+bounces-1583-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A78214C4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 18:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D90A1F213BF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 17:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80C918F68;
	Mon,  1 Jan 2024 17:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O0+gfchX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4698F58;
	Mon,  1 Jan 2024 17:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704130653; x=1735666653;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=/xQIdGCr1YyxtCKT7Xy+2JZl4Bdz3JUlbKLluPBaW2A=;
  b=O0+gfchXlt222RhTbXxRKVH8cQQia2WxJiFeB99oUySi7oq/Et5JIGDA
   6E3TvLA+GIjAg+QhUexqRqmS9vBvymhyUzFLGdoI84LTzPOU0fRi5AwtN
   k2/QmIG8QQoY0U7cK3M20P00hcdJcsHVMXAgis1ZrSNtzt27G/QBFF152
   9lD1LraKBamVAA8JwalfMOnzrQqsG5u4cto3q1+3mnP3I8497VmAlDnK5
   eQXcAMoI5v4F42OUamzSZgwQxgwp3IZPVXxgU8+mbO/e3UW2MsXfzFW+5
   GHzoOTfKA8yYMCL1QXzluNuXig7E9/dXiUrL+fR+eQuKvklXHy0H5SDuK
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="400614056"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="400614056"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 09:37:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="729281984"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="729281984"
Received: from amazouz-mobl.ger.corp.intel.com ([10.251.210.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 09:37:28 -0800
Date: Mon, 1 Jan 2024 19:37:25 +0200 (EET)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>, 
    Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, 
    Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>, 
    Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
    Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
    Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
    "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
    Bjorn Helgaas <bhelgaas@google.com>, LKML <linux-kernel@vger.kernel.org>, 
    Alex Deucher <alexdeucher@gmail.com>, 
    Daniel Lezcano <daniel.lezcano@linaro.org>, 
    Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 07/10] PCI/LINK: Re-add BW notification portdrv as
 PCIe BW controller
In-Reply-To: <20231230155810.GB25718@wunner.de>
Message-ID: <ada759ad-c2e-41d7-e15f-a7a3dc208771@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com> <20230929115723.7864-8-ilpo.jarvinen@linux.intel.com> <20231230155810.GB25718@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1494370019-1704130652=:7866"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1494370019-1704130652=:7866
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 30 Dec 2023, Lukas Wunner wrote:

> On Fri, Sep 29, 2023 at 02:57:20PM +0300, Ilpo Järvinen wrote:
> > This mostly reverts b4c7d2076b4e ("PCI/LINK: Remove bandwidth
> > notification"), however, there are small tweaks:
> > 
> > 1) Call it PCIe bwctrl (bandwidth controller) instead of just
> >    bandwidth notifications.
> > 2) Don't print the notifications into kernel log, just keep the current
> >    link speed updated.
> > 3) Use concurrency safe LNKCTL RMW operations.
> > 4) Read link speed after enabling the notification to ensure the
> >    current link speed is correct from the start.
> > 5) Add local variable in probe for srv->port.
> > 6) Handle link speed read and LBMS write race in
> >    pcie_bw_notification_irq().
> > 
> > The reason for 1) is to indicate the increased scope of the driver. A
> > subsequent commit extends the driver to allow controlling PCIe
> > bandwidths from user space upon crossing thermal thresholds.
> > 
> > While 2) is somewhat unfortunate, the log spam was the source of
> > complaints that eventually lead to the removal of the bandwidth
> > notifications driver (see the links below for further information).
> > After re-adding this driver back the userspace can, if it wishes to,
> > observe the link speed changes using the current bus speed files under
> > sysfs.
> 
> Good commit message.
> 

> > --- /dev/null
> > +++ b/drivers/pci/pcie/bwctrl.c
> 
> > +static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
> > +{
> > +	u16 link_status;
> > +	int ret;
> > +
> > +	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
> > +	pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LBMIE);
> 
> I'm wondering why we're not enabling LABIE as well?
> (And clear LABS.)
> 
> Can't it happen that we miss bandwidth changes unless we enable that
> as well?

Thanks. Reading the spec, it sounds like both are necessary to not miss 
changes.

> > +static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
> > +{
> > +	struct pci_dev *port = srv->port;
> > +	int ret;
> > +
> > +	/* Single-width or single-speed ports do not have to support this. */
> > +	if (!pcie_link_bandwidth_notification_supported(port))
> > +		return -ENODEV;
> 
> I'm wondering if this should be checked in get_port_device_capability()
> instead?

I can move the check there.

> > +	ret = request_irq(srv->irq, pcie_bw_notification_irq,
> > +			  IRQF_SHARED, "PCIe BW ctrl", srv);
> 
> Is there a reason to run the IRQ handler in hardirq context
> or would it work to run it in an IRQ thread?  Usually on systems
> than enable PREEMPT_RT, a threaded IRQ handler is preferred,
> so unless hardirq context is necessary, I'd recommend using
> an IRQ thread.

Can I somehow postpone the decision between IRQ_NONE / IRQ_HANDLED
straight into the thread_fn? One LNKSTA read is necessary to decide 
that.

I suppose the other write + reread of LNKSTA could be moved into
thread_fn even if the first read would not be movable.


-- 
 i.

--8323329-1494370019-1704130652=:7866--

