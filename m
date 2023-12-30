Return-Path: <linux-pci+bounces-1569-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 132BF82070E
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 16:58:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7751F21A29
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 15:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9EC68F77;
	Sat, 30 Dec 2023 15:58:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FCE9461;
	Sat, 30 Dec 2023 15:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 41C0B300002D0;
	Sat, 30 Dec 2023 16:58:10 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 2FA672CD0A; Sat, 30 Dec 2023 16:58:10 +0100 (CET)
Date: Sat, 30 Dec 2023 16:58:10 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, Krzysztof Wilczy??ski <kw@linux.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	Alex Deucher <alexdeucher@gmail.com>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH v3 07/10] PCI/LINK: Re-add BW notification portdrv as
 PCIe BW controller
Message-ID: <20231230155810.GB25718@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-8-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929115723.7864-8-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 29, 2023 at 02:57:20PM +0300, Ilpo Järvinen wrote:
> This mostly reverts b4c7d2076b4e ("PCI/LINK: Remove bandwidth
> notification"), however, there are small tweaks:
> 
> 1) Call it PCIe bwctrl (bandwidth controller) instead of just
>    bandwidth notifications.
> 2) Don't print the notifications into kernel log, just keep the current
>    link speed updated.
> 3) Use concurrency safe LNKCTL RMW operations.
> 4) Read link speed after enabling the notification to ensure the
>    current link speed is correct from the start.
> 5) Add local variable in probe for srv->port.
> 6) Handle link speed read and LBMS write race in
>    pcie_bw_notification_irq().
> 
> The reason for 1) is to indicate the increased scope of the driver. A
> subsequent commit extends the driver to allow controlling PCIe
> bandwidths from user space upon crossing thermal thresholds.
> 
> While 2) is somewhat unfortunate, the log spam was the source of
> complaints that eventually lead to the removal of the bandwidth
> notifications driver (see the links below for further information).
> After re-adding this driver back the userspace can, if it wishes to,
> observe the link speed changes using the current bus speed files under
> sysfs.

Good commit message.


> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -137,6 +137,14 @@ config PCIE_PTM
>  	  This is only useful if you have devices that support PTM, but it
>  	  is safe to enable even if you don't.
>  
> +config PCIE_BW
> +	bool "PCI Express Bandwidth Change Notification"
> +	depends on PCIEPORTBUS
> +	help
> +	  This enables PCI Express Bandwidth Change Notification.  If
> +	  you know link width or rate changes occur to correct unreliable
> +	  links, you may answer Y.
> +

For an end user browsing Kconfig entries, this isn't as helpful as it
could be.  Maybe mention that autonomous link changes are automatically
picked up and observable through sysfs (name the relevant attributes).


> --- /dev/null
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -0,0 +1,131 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * PCI Express Link Bandwidth Notification services driver
> + * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> + *
> + * Copyright (C) 2019, Dell Inc
> + *
> + * The PCIe Link Bandwidth Notification provides a way to notify the
> + * operating system when the link width or data rate changes.  This
> + * capability is required for all root ports and downstream ports
> + * supporting links wider than x1 and/or multiple link speeds.

Capitalize Root Ports and Downstream Ports.
Reference the spec section prescribing this.


> +static bool pcie_link_bandwidth_notification_supported(struct pci_dev *dev)
> +{
> +	int ret;
> +	u32 lnk_cap;

Inverse Christmas tree?


> +static void pcie_enable_link_bandwidth_notification(struct pci_dev *dev)
> +{
> +	u16 link_status;
> +	int ret;
> +
> +	pcie_capability_write_word(dev, PCI_EXP_LNKSTA, PCI_EXP_LNKSTA_LBMS);
> +	pcie_capability_set_word(dev, PCI_EXP_LNKCTL, PCI_EXP_LNKCTL_LBMIE);

I'm wondering why we're not enabling LABIE as well?
(And clear LABS.)

Can't it happen that we miss bandwidth changes unless we enable that
as well?


> +static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
> +{
> +	struct pci_dev *port = srv->port;
> +	int ret;
> +
> +	/* Single-width or single-speed ports do not have to support this. */
> +	if (!pcie_link_bandwidth_notification_supported(port))
> +		return -ENODEV;

I'm wondering if this should be checked in get_port_device_capability()
instead?


> +	ret = request_irq(srv->irq, pcie_bw_notification_irq,
> +			  IRQF_SHARED, "PCIe BW ctrl", srv);

Is there a reason to run the IRQ handler in hardirq context
or would it work to run it in an IRQ thread?  Usually on systems
than enable PREEMPT_RT, a threaded IRQ handler is preferred,
so unless hardirq context is necessary, I'd recommend using
an IRQ thread.

Thanks,

Lukas

