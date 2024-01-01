Return-Path: <linux-pci+bounces-1585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275D38214EA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 19:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A53B1C20C9A
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jan 2024 18:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4363C140;
	Mon,  1 Jan 2024 18:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmwUdS1r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0618BA43;
	Mon,  1 Jan 2024 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704132771; x=1735668771;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xaOMzq2s3eMU8oWUt36+JE+ktUuXJd1kcZHmLKD8vJI=;
  b=BmwUdS1rM8IZ6hUsmxrZmb7FKZC+9XHUt5exe1WT7UQNEHEJ1qKlzPwm
   VnKxoPB3eIsdK9bo7Y30KVXVURRRkz5h80Ap9GRD0/JLPUCYLFKUEuZ5X
   IM0g/VVjY964UZ0nRhvSA1a0qLTU6Z1Pz5VfYDOFoMkHqVB5lv/P//XSv
   VTZMGge0sIPA26B1IbmPFVSwko9PdOC4u8jKCv8eUtCylLTzpTM8lF0+U
   uSdNwqgwifBX35kPAm3gFgGVamoy8MGLECbqRX3weWAs4eikMhj6Hei7O
   9xtST45XkGXzihSMIS6MJJS4Fw3qMZ8hyeGymAPTv9HFywSxa0f2PvaH4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="3626573"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="3626573"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 10:12:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10940"; a="870035694"
X-IronPort-AV: E=Sophos;i="6.04,322,1695711600"; 
   d="scan'208";a="870035694"
Received: from amazouz-mobl.ger.corp.intel.com ([10.251.210.158])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jan 2024 10:12:45 -0800
Date: Mon, 1 Jan 2024 20:12:43 +0200 (EET)
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
Subject: Re: [PATCH v3 08/10] PCI/bwctrl: Add "controller" part into PCIe
 bwctrl
In-Reply-To: <20231230184905.GA6104@wunner.de>
Message-ID: <b56bb460-7876-272a-23ce-83d1dab212b2@linux.intel.com>
References: <20230929115723.7864-1-ilpo.jarvinen@linux.intel.com> <20230929115723.7864-9-ilpo.jarvinen@linux.intel.com> <20231230184905.GA6104@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-900971598-1704132769=:7866"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-900971598-1704132769=:7866
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

On Sat, 30 Dec 2023, Lukas Wunner wrote:

> On Fri, Sep 29, 2023 at 02:57:21PM +0300, Ilpo Järvinen wrote:
> 
> 
> > --- a/drivers/pci/pcie/bwctrl.c

> > +static u16 speed2lnkctl2(enum pci_bus_speed speed)
> > +{
> > +	static const u16 speed_conv[] = {
> > +		[PCIE_SPEED_2_5GT] = PCI_EXP_LNKCTL2_TLS_2_5GT,
> > +		[PCIE_SPEED_5_0GT] = PCI_EXP_LNKCTL2_TLS_5_0GT,
> > +		[PCIE_SPEED_8_0GT] = PCI_EXP_LNKCTL2_TLS_8_0GT,
> > +		[PCIE_SPEED_16_0GT] = PCI_EXP_LNKCTL2_TLS_16_0GT,
> > +		[PCIE_SPEED_32_0GT] = PCI_EXP_LNKCTL2_TLS_32_0GT,
> > +		[PCIE_SPEED_64_0GT] = PCI_EXP_LNKCTL2_TLS_64_0GT,
> > +	};
> 
> Looks like this could be a u8 array to save a little bit of memory.
> 
> Also, this seems to duplicate pcie_link_speed[] defined in probe.c.

It's not the same. pcie_link_speed[] is indexed by a different thing 
unless you also suggest I should do index minus a number? There are 
plenty of arithmetics possible when converting between the types but
the existing converions functions don't seem to take advantage of those
properties so I've been a bit hesitant to add such assumptions myself.

I suppose I used u16 because the reg is u16 but you're of course correct 
that the values don't take up more than u8.

> > +static int bwctrl_select_speed(struct pcie_device *srv, enum pci_bus_speed *speed)
> > +{
> > +	struct pci_bus *bus = srv->port->subordinate;
> > +	u8 speeds, dev_speeds;
> > +	int i;
> > +
> > +	if (*speed > PCIE_LNKCAP2_SLS2SPEED(bus->pcie_bus_speeds))
> > +		return -EINVAL;
> > +
> > +	dev_speeds = READ_ONCE(bus->pcie_dev_speeds);
> 
> Hm, why is the compiler barrier needed?

It's probably an overkill but there could be a checker which finds this 
read is not protected by anything while the value could get updated 
concurrectly (there's probably already such checker as I've seen patches 
to data races found with some tool). I suppose the alternative would be to 
mark the data race being harmless (because if endpoint removal clears 
pcie_dev_speeds, bwctrl will be pretty moot). I just chose to use 
READ_ONCE() that prevents rereading the same value later in this function 
making the function behave consistently regardless of what occurs parallel 
to it with the endpoints.

If the value selected cannot be set because of endpoint no longer being 
there, the other parts of the code will detect that.

So if I just add a comment to this line why there's the data race and keep 
it as is?

> > +	/* Only the lowest speed can be set when there are no devices */
> > +	if (!dev_speeds)
> > +		dev_speeds = PCI_EXP_LNKCAP2_SLS_2_5GB;
> 
> Maybe move this to patch [06/10], i.e. set dev->bus->pcie_dev_speeds to
> PCI_EXP_LNKCAP2_SLS_2_5GB on removal (instead of 0).

Okay, I'll set it to 2_5GB on init and removal.

> > +	speeds = bus->pcie_bus_speeds & dev_speeds;
> > +	i = BIT(fls(speeds));
> > +	while (i >= PCI_EXP_LNKCAP2_SLS_2_5GB) {
> > +		enum pci_bus_speed candidate;
> > +
> > +		if (speeds & i) {
> > +			candidate = PCIE_LNKCAP2_SLS2SPEED(i);
> > +			if (candidate <= *speed) {
> > +				*speed = candidate;
> > +				return 0;
> > +			}
> > +		}
> > +		i >>= 1;
> > +	}
> 
> Can't we just do something like
> 
> 	supported_speeds = bus->pcie_bus_speeds & dev_speeds;
> 	desired_speeds = GEN_MASK(pcie_link_speed[*speed], 1);
> 	*speed = BIT(fls(supported_speeds & desired_speeds));
> 
> and thus avoid the loop altogether?

Yes, I can change to loopless version.

I'll try to create functions for the speed format conversions though 
rather than open coding them into the logic.

> > @@ -91,16 +242,32 @@ static int pcie_bandwidth_notification_probe(struct pcie_device *srv)
> >  	if (ret)
> >  		return ret;
> >  
> > +	data = kzalloc(sizeof(*data), GFP_KERNEL);
> > +	if (!data) {
> > +		ret = -ENOMEM;
> > +		goto free_irq;
> > +	}
> > +	mutex_init(&data->set_speed_mutex);
> > +	set_service_data(srv, data);
> > +
> 
> I think you should move that further up so that you allocate and populate
> the data struct before requesting the IRQ.  Otherwise if BIOS has already
> enabled link bandwith notification for some reason, the IRQ handler might
> be invoked without the data struct being allocated.

Sure, I don't know why I missed that possibility.


-- 
 i.

--8323329-900971598-1704132769=:7866--

