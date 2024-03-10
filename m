Return-Path: <linux-pci+bounces-4706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0E9877731
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 14:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C002B281426
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 13:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43512C6AA;
	Sun, 10 Mar 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cNvXKKh8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01391E504
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 13:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710078711; cv=none; b=ZPRyN0L6VPc9PnxYGx/grc9YAX45zwlqWj/xYbE9l3e1WlYZPfafA8jesE6DmauFhRF6BM/1vc/DpuffXxX3EBaAMFGIdihMhRdDZv5UAMjDHlfLZixFIKRcjroeCb/C6ggFqASl04rHTbYfR5S6NcB7Po0wMdEizdkdfFv4Q7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710078711; c=relaxed/simple;
	bh=v69+LofoUSXOGRyXkN61WsY7w8MHGFdxdxcvC3D7c+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5gv7jxnN3YcXpgSv/0gwlG20HfEsKZluTySAqG6CeLDF8Tc010NkaSscoquuXgsssd9W3yFkwKZHb3oFUda1ycW9vhXgxbcgZr5IqTeBsXjlvbWO2RmSWnpDDJ42gt384Y3Mw/J8rxv+GJiTei1On4dSaymFB1eIQ5+ICRy44U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cNvXKKh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528B0C433C7;
	Sun, 10 Mar 2024 13:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710078711;
	bh=v69+LofoUSXOGRyXkN61WsY7w8MHGFdxdxcvC3D7c+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cNvXKKh8TbJH8hsIgw8ESxq85WZtWCiFPadDf+PofV14TOwX7GDFIdNHacwtJMFKS
	 N+NsZag4YkTcq106t9ndRlpXIeqF7LTaLTG6PUjAfkPk0Pyn+25aXsZwu4Uw0TlMqb
	 eqgT5IPNM8L4wqt5CtZFBDn7J3GY+OICfXfVWH4d2pcf0oV+fu9+AvSYTKUOsmzRzd
	 6fIEoaB3DdNwKbuT+thyz5i2sUh4FEi/BWXkRnV9i4rSMpl3C39UFc3MJcsQ17+Z8O
	 Z3iS/Y51CvtYBa0xEmKyMJXxaD5to6kQTBlaurhJnlgexs86SXKIs0+Eu5bCieElAG
	 xM1g4kU5pspXA==
Date: Sun, 10 Mar 2024 19:21:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Manu Gautam <manugautam@google.com>,
	Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Joao.Pinto@synopsys.com
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240310135140.GF3390@thinkpad>
References: <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
 <Zeha9dCwyXH7C35j@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zeha9dCwyXH7C35j@google.com>

On Wed, Mar 06, 2024 at 05:30:53PM +0530, Ajay Agarwal wrote:
> On Wed, Feb 28, 2024 at 10:59:51PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Feb 20, 2024 at 11:04:09PM +0530, Ajay Agarwal wrote:
> > > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > > + Joao
> > > > 
> > > > On Mon, Feb 05, 2024 at 04:30:20PM +0530, Ajay Agarwal wrote:
> > > > > On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > > > > > > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > > > > > > 
> > > > > > > > [...]
> > > > > > > > 
> > > > > > > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > > > > > > 
> > > > > > > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > > > > > > 
> > > > > > > > > > > > 
> > > > > > > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > > > > > > experience.
> > > > > > > > > > > > 
> > > > > > > > > > > > If there are any other usecases, please state them.
> > > > > > > > > > > > 
> > > > > > > > > > > > - Mani
> > > > > > > > > > > >
> > > > > > > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > > > > > > hence the link-up is not attempted.
> > > > > > > > > > 
> > > > > > > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > > > > > > I am not adding any logic/condition around calling the start_link()
> > > > > > > > > itself. I am only avoiding the wait for the link to be up if the
> > > > > > > > > controller driver has not defined start_link().
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > I'm saying that not defining the start_link() callback itself is wrong.
> > > > > > > > 
> > > > > > > Whether the start_link() should be defined or not, is a different
> > > > > > > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > > > > > > dw-plat) which do not have start_link() defined. Waiting for the link to
> > > > > > > come up for the platforms using those drivers is not a good idea. And
> > > > > > > that is what we are trying to avoid.
> > > > > > > 
> > > > > > 
> > > > > > NO. The sole intention of this patch is to fix the delay observed with _your_
> > > > > > out-of-tree controller driver as you explicitly said before. Impact for the
> > > > > > existing 2 drivers are just a side effect.
> > > > > >
> > > > > Hi Mani,
> > > > > What is the expectation from the pcie-designware-host driver? If the
> > > > > .start_link() has to be defined by the vendor driver, then shouldn't the
> > > > > probe be failed if the vendor has not defined it? Thereby failing the
> > > > > probe for intel-gw and pcie-dw-plat drivers?
> > > > > 
> > > > 
> > > > intel-gw maintainer agreed to fix the driver [1], but I cannot really comment on
> > > > the other one. It is not starting the link at all, so don't know how it works.
> > > > I've CCed the driver author to get some idea.
> > > > 
> > > > [1] https://lore.kernel.org/linux-pci/BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com/
> > > > 
> > > > > Additionally, if the link fails to come up even after 1 sec of wait
> > > > > time, shouldn't the probe be failed in that case too?
> > > > > 
> > > > 
> > > > Why? The device can be attached at any point of time. What I'm stressing is, the
> > > > driver should check for the link to be up during probe and if there is no
> > > > device, then it should just continue and hope for the device to show up later.
> > > My change is still checking whether the link is up during probe.
> > > If yes, print the link status (negotiated speed and width).
> > > If no, and the .start_link() exists, then call the same and wait for 1
> > > second for the link to be up.
> > > 
> > 
> > There is a reason why we are wating for 1s for the device to show up during
> > probe. Please look at my earlier reply to Bjorn.
> >
> Yes, I looked at that. I am not sure if that is the real reason behind
> this delay. The explanation that you quoted from the spec talks about
> allowing 1s delay for the EP to return a completion. Whereas the delay
> here is to wait for the link training itself to be completed.
> 

It is implied, afaiu. But the best person to comment here is Lorenzo.

> We could surely wait for Lorenzo to explain the reason behind this
> delay, but he himself approved the earlier patch [1] (which caused the
> regression and had to be reverted):
> 

This is not a valid argument.
 
>  [1] https://lore.kernel.org/all/168509076553.135117.7288121992217982937.b4-ty@kernel.org/
> 
> > > > This way, the driver can detect the powered up devices during boot and also
> > > > detect the hotplug devices.
> > > >
> > > If the .start_link() is not defined, how will the link come up? Are you
> > > assuming that the bootloader might have enabled link training?
> > > 
> > 
> > Yes, something like that. But that assumption is moot in the first place.
> > 
> Isnt it weird that a PCIe driver, which will most likely initialize all
> the resources like power, resets, clocks etc., relies on the bootloader
> to have enabled the link training?
> 

That's why I said that assumption is 'moot'.

> I think it is safe to assume that a driver should have the start_link()
> defined if it wishes to bring the link up during probe.
> 

I keep repeating this. But let me do one more time.

There should be a valid reason for a driver to defer the start_link(). In your
case, the problem is you are tying the driver with the Android usecase which is
not going to work on other platforms. What is worse is, you are forcing the
users to enable the link training post boot. It may work for you currently, as
you need to bring up the endpoint manually for various reasons, but what if some
other OEM has connected an endpoint that gets powered on during the controller
probe? Still the user has to start the link manually. Will that provide a nice
user experience? NO. Then the developers will start complaining that they cannot
see the endpoint during boot even though it got powered up properly.

Second, we cannot have different policies for different drivers to start the
link unless there is a valid reason. This will become a maintenance burden. For
sure, there are differences in the current drivers, but those should be fixed
instead of extended.

So to address your issue, I can suggest two things:

1. Wait for Lorenzo to clarify the 1s loop while waiting for link up. If that
seem to be required, then keep this patch out-of-tree. Btw, your driver is still
out-of-tree...

2. Try to bringup the endpoint during boot itself. We already have a series to
achieve that [1].

- Mani

[1] https://lore.kernel.org/linux-pci/20240216203215.40870-1-brgl@bgdev.pl/

-- 
மணிவண்ணன் சதாசிவம்

