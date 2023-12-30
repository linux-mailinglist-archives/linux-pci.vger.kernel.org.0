Return-Path: <linux-pci+bounces-1570-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89C6B820833
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 19:49:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D5D1C21834
	for <lists+linux-pci@lfdr.de>; Sat, 30 Dec 2023 18:49:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79BE9BE49;
	Sat, 30 Dec 2023 18:49:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97627BA53;
	Sat, 30 Dec 2023 18:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1BA8530001EA5;
	Sat, 30 Dec 2023 19:49:05 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 0D64AFE7B1; Sat, 30 Dec 2023 19:49:05 +0100 (CET)
Date: Sat, 30 Dec 2023 19:49:05 +0100
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
Subject: Re: [PATCH v3 08/10] PCI/bwctrl: Add "controller" part into PCIe
 bwctrl
Message-ID: <20231230184905.GA6104@wunner.de>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com>
 <20230929115723.7864-9-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230929115723.7864-9-ilpo.jarvinen@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Sep 29, 2023 at 02:57:21PM +0300, Ilpo Järvinen wrote:
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16569,6 +16569,13 @@ F:	include/linux/pci*
>  F:	include/uapi/linux/pci*
>  F:	lib/pci*
>  
> +PCIE BANDWIDTH CONTROLLER
> +M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> +L:	linux-pci@vger.kernel.org
> +S:	Supported
> +F:	drivers/pci/pcie/bwctrl.c
> +F:	include/linux/pci-bwctrl.h
> +

Maybe add this already in the preceding patch.


> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -138,12 +138,13 @@ config PCIE_PTM
>  	  is safe to enable even if you don't.
>  
>  config PCIE_BW
> -	bool "PCI Express Bandwidth Change Notification"
> +	bool "PCI Express Bandwidth Controller"

I'd fold this change into the preceding patch.
Deleting a line introduced by the preceding patch isn't great.

Never mind that the patch isn't a clean revert that way.
Your approach of making changes to the original version
of the bandwith monitoring driver and calling out those
changes in the commit message seems fine to me.


>  	depends on PCIEPORTBUS
>  	help
> -	  This enables PCI Express Bandwidth Change Notification.  If
> -	  you know link width or rate changes occur to correct unreliable
> -	  links, you may answer Y.
> +	  This enables PCI Express Bandwidth Controller. The Bandwidth
> +	  Controller allows controlling PCIe link speed and listens for link
> +	  peed Change Notifications. If you know link width or rate changes
> +	  occur to correct unreliable links, you may answer Y.

It would be neater if you could avoid deleting lines introduced by
the preceding patch.  Ideally you'd add a new paragraph, thus only
add new lines but not delete any existing ones.


> --- a/drivers/pci/pcie/bwctrl.c
> +++ b/drivers/pci/pcie/bwctrl.c
> @@ -1,14 +1,16 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * PCI Express Link Bandwidth Notification services driver
> + * PCIe bandwidth controller
> + *

Again, fold this change into the preceding patch please.

>   * Author: Alexandru Gagniuc <mr.nuke.me@gmail.com>
>   *
>   * Copyright (C) 2019, Dell Inc
> + * Copyright (C) 2023 Intel Corporation.

For extra neatness, drop the comma in the preceding patch and
the period in this patch.


> - * The PCIe Link Bandwidth Notification provides a way to notify the
> - * operating system when the link width or data rate changes.  This
> - * capability is required for all root ports and downstream ports
> - * supporting links wider than x1 and/or multiple link speeds.
> + * The PCIe Bandwidth Controller provides a way to alter PCIe link speeds
> + * and notify the operating system when the link width or data rate changes.
> + * The notification capability is required for all Root Ports and Downstream
> + * Ports supporting links wider than x1 and/or multiple link speeds.

Again, adding a new paragraph and not deleting lines introduced by
the preceding patch would be much nicer.


> +#include <linux/bitops.h>
> +#include <linux/errno.h>
> +#include <linux/mutex.h>
> +#include <linux/pci.h>
> +#include <linux/pci-bwctrl.h>
> +#include <linux/types.h>
> +
> +#include <asm/rwonce.h>
> +

Which of these are necessary for functionality introduced by this
patch and which are necessary anyway and should be moved to the
preceding patch?


> +/**
> + * struct bwctrl_service_data - PCIe Port Bandwidth Controller

Code comment at the top of this file says "PCIe bandwidth controller",
use here as well for neatness.


> +static u16 speed2lnkctl2(enum pci_bus_speed speed)
> +{
> +	static const u16 speed_conv[] = {
> +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> +	};

Looks like this could be a u8 array to save a little bit of memory.

Also, this seems to duplicate pcie_link_speed[] defined in probe.c.


> +static int bwctrl_select_speed(struct pcie_device *srv, enum pci_bus_speed *speed)
> +{
> +	struct pci_bus *bus = srv->port->subordinate;
> +	u8 speeds, dev_speeds;
> +	int i;
> +
> +	if (*speed > PCIE_LNKCAP2_SLS2SPEED(bus->pcie_bus_speeds))
> +		return -EINVAL;
> +
> +	dev_speeds = READ_ONCE(bus->pcie_dev_speeds);

Hm, why is the compiler barrier needed?


> +	/* Only the lowest speed can be set when there are no devices */
> +	if (!dev_speeds)
> +		dev_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;

Maybe move this to patch [06/10], i.e. set dev->bus->pcie_dev_speeds to
PCI_EXP_LNKCAP2_SLS_2_5GB on removal (instead of 0).


> +	speeds = bus->pcie_bus_speeds & dev_speeds;
> +	i = BIT(fls(speeds));
> +	while (i >= PCI_EXP_LNKCAP2_SLS_2_5GB) {
> +		enum pci_bus_speed candidate;
> +
> +		if (speeds & i) {
> +			candidate = PCIE_LNKCAP2_SLS2SPEED(i);
> +			if (candidate <= *speed) {
> +				*speed = candidate;
> +				return 0;
> +			}
> +		}
> +		i >>= 1;
> +	}

Can't we just do something like

	supported_speeds = bus->pcie_bus_speeds & dev_speeds;
	desired_speeds = GEN_MASK(pcie_link_speed[*speed], 1);
	*speed = BIT(fls(supported_speeds & desired_speeds));

and thus avoid the loop altogether?


> +/**
> + * bwctrl_set_current_speed - Set downstream link speed for PCIe port
> + * @srv: PCIe port
> + * @speed: PCIe bus speed to set
> + *
> + * Attempts to set PCIe port link speed to @speed. As long as @speed is less
> + * than the maximum of what is supported by @srv, the speed is adjusted
> + * downwards to the best speed supported by both the port and device
> + * underneath it.
> + *
> + * Return:
> + * * 0 - on success
> + * * -EINVAL - @speed is higher than the maximum @srv supports
> + * * -ETIMEDOUT - changing link speed took too long
> + * * -EAGAIN - link speed was changed but @speed was not achieved
> + */

So passing a higher speed than what's supported by the Endpoint is fine
but passing a higher speed than what's supported by the Downstream Port
is not?  Why the distinction?  Maybe it would be more logical to just
pick the maximum of what either supports and use that in lieu of a
too-high speed?


> +int bwctrl_set_current_speed(struct pcie_device *srv, enum pci_bus_speed speed)
> +{
> +	struct bwctrl_service_data *data = get_service_data(srv);
> +	struct pci_dev *port = srv->port;
> +	u16 link_status;
> +	int ret;
> +
> +	if (WARN_ON_ONCE(!bwctrl_valid_pcie_speed(speed)))
> +		return -EINVAL;
> +
> +	ret = bwctrl_select_speed(srv, &speed);
> +	if (ret < 0)
> +		return ret;

How about checking here if the selected speed is equivalent to what's
being used right now and bailing out if so?  No need to retrain if
we're already at the desired speed.


> @@ -91,16 +242,32 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
>  	if (ret)
>  		return ret;
>  
> +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> +	if (!data) {
> +		ret = -ENOMEM;
> +		goto free_irq;
> +	}
> +	mutex_init(&data->set_speed_mutex);
> +	set_service_data(srv, data);
> +

I think you should move that further up so that you allocate and populate
the data struct before requesting the IRQ.  Otherwise if BIOS has already
enabled link bandwith notification for some reason, the IRQ handler might
be invoked without the data struct being allocated.


> --- /dev/null
> +++ b/include/linux/pci-bwctrl.h
> @@ -0,0 +1,17 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * PCIe bandwidth controller
> + *
> + * Copyright (C) 2023 Intel Corporation.

Another trailing period I'd remove.

Thanks,

Lukas

