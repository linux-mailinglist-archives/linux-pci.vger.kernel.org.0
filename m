Return-Path: <linux-pci+bounces-44484-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E01D11630
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 10:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92082304577D
	for <lists+linux-pci@lfdr.de>; Mon, 12 Jan 2026 09:02:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5B5346AF2;
	Mon, 12 Jan 2026 09:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8cHfpOX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F288A30FC1D;
	Mon, 12 Jan 2026 09:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208542; cv=none; b=KAKKeIjeUb24ZIyE0T33P6KR8C356XThswaPOwwi1x6xLpw1uEfTKXVhVjWEjEjLtfbC4VOT2LUmJzfWJMXAbYKPWMjnXxU5zxQ7DO7fwdhCZwzwzXYC0YoNrbiVwYZSybrbIb0Z9IEaZw24810bfRz7jWa4zhE+4Rnp0ENtVHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208542; c=relaxed/simple;
	bh=qj7f8OVKymqpaGteRJaSiKYCtCRP7TJCNDokvj7EXck=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uk/mnp15k438goDtCgKskbr+iIpGD83Hk21wld6twmzgzvfNC4oNpQLfX88I/xLBpCUHkqQiEXtF8S0gvMe8UhWJnxgHZXbz5Q8Tg977fpzmDLnjnGzSUnzm/qONhXUp1eCC97KG2Vkf8QoiUimo2OYAywk8OJZKICRusclF/2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8cHfpOX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BD38C116D0;
	Mon, 12 Jan 2026 09:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768208541;
	bh=qj7f8OVKymqpaGteRJaSiKYCtCRP7TJCNDokvj7EXck=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a8cHfpOXYmjDpTJf0FP9hfGwW608GKXGMUaKLc4npoU5hNjgSuhe0YHISlZspwBPs
	 apiAizX4PipAxtigEkm9mt+lq7HwnJTSlZAX6vxTS3bCjXA1iqf/FWPzRxyzJD1nIh
	 lL+M+8Je+EJR9SLQjburw2C10PmrohWL7p/P1VPZJY5mbDUc6+sOeiiRmiV/Ya2ZSj
	 c4zHxaOlQAeyi4eKS85vOTXZGFf/Ma/CO24IoDLSb0cHkIGdcz+mgsbPSTPpiL1V+I
	 v6C17+HdnDkpgMwQhViQtYkW1VgGpzhkLFiKacPrJ0AhcIk1GxbQcPcJr5Tk/tflei
	 OnAmF//T6Cafg==
Date: Mon, 12 Jan 2026 14:32:04 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	manivannan.sadhasivam@oss.qualcomm.com, Rob Herring <robh@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas.schier@linux.dev>, 
	Hans de Goede <hansg@kernel.org>, Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, 
	Mark Pearson <mpearson-lenovo@squebb.ca>, "Derek J. Clark" <derekjohn.clark@gmail.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, Sakari Ailus <sakari.ailus@linux.intel.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org, 
	linux-pm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, linux-acpi@vger.kernel.org, 
	Sui Jingfeng <sui.jingfeng@linux.dev>
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
Message-ID: <6peb6afhpm4l7opxbdt3b5sx32longevwds5c3dlqji2hr5dlh@kxuvj55jkqgi>
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
 <6l3rs5pv6xnrbygpvqrdxqoqtybjyefsltk5bl4336q56rfoza@ejo3sxuufghe>
 <aWSwgRiEkT9unYw9@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aWSwgRiEkT9unYw9@smile.fi.intel.com>

On Mon, Jan 12, 2026 at 10:27:45AM +0200, Andy Shevchenko wrote:
> On Mon, Jan 12, 2026 at 01:49:54PM +0530, Manivannan Sadhasivam wrote:
> > + Dmitry Torokhov (who was against this patch previously)
> > 
> > On Mon, Jan 12, 2026 at 09:56:06AM +0200, Andy Shevchenko wrote:
> > > On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > > 
> > > > Because the software node backend of the fwnode API framework lacks an
> > > > implementation for the .device_get_match_data function callback.
> > > 
> > > Maybe this is done on purpose. Have you thought about this aspect?
> > 
> > IMO, software nodes were introduced to add sub-properties to the existing
> > firmware nodes, but it has usecase/potential to go beyond that. More below.
> 
> Potential doesn't mean the necessity.
> 
> > > > This makes it difficult to use(and/or test) a few drivers that originates
> > > > from DT world on the non-DT platform.
> > > 
> > > How difficult? DSA implementation went to the way of taking DT overlay
> > > approach. Why that one can't be applied here?
> > 
> > Sometimes you do not have any DT node at all.
> 
> Yes, that is exactly the case I have referred to. The PCI core (in Linux)
> is able to create DT subtree on non-OF based platforms.
> 

Maybe I should look into creating dynamic DT node for the device and insert it
to the uart node. Theoretically it should work.

> > For example, in this series, the
> > M.2 pwrseq driver creates the serdev software device for the M.2 BT card to
> > match it with the existing OF based BT driver (for non-M2 device). From the
> > driver's point of view, a BT device attached to the M.2 slot and over custom
> > connectors are both the same. Only difference is that, in the case of custom
> > connectors, the bluetooth DT node will have the BT device described and in the
> > case of M.2, the device won't get described, but just the connector [1].
> 
> So, what's the problem to add such a description? (Assuming you want a customisation
> it can be done at run-time, correct?)
> 
> > But for the driver to identify the device (since it cannot enumerate it),
> > either it has to rely on DT/ACPI or some other means.
> 
> Yes.
> 
> > In the previous version of this series [2], I used the serdev ID based on the
> > product name for creating the serdev device and added a new id_table for serdev
> > driver to match with the device [3]. This almost duplicated the existing OF
> > match logic.
> 
> That's how we do when we want to add a board file, but thing is that we do not
> want board files (only in the cases when other ways are impossible or make less
> sense).
> 
> > Then Bartosz suggested to use swnode approach [4], to get rid of
> > the custom serdev ID based matching. When I prototyped, it mostly worked well,
> 
> I know that Bart is fan of swnodes, but it should not be used as a silver
> bullet, really.
> 
> > except that swnode needed to have its own .device_get_match_data(), match() and
> > uevent/modalias functions. And if the swnode reused the existing DT compatible
> > string, it can work with the existing BT driver without modifications. And this
> > approach can also be extended to devices instantiated from the board specific
> > drivers.
> 
> DT overlay should work without even modifications done to swnode code, right?
> 

Not from the overlay binaries (.dtbo), but adding dynamic BT node for the device
based on the enumerated PCI device should work.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

