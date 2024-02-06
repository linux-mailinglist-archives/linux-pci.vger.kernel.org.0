Return-Path: <linux-pci+bounces-3172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7CB84BBA8
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 18:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8E74282624
	for <lists+linux-pci@lfdr.de>; Tue,  6 Feb 2024 17:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476E66116;
	Tue,  6 Feb 2024 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VVxbRL8z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B21AB652
	for <linux-pci@vger.kernel.org>; Tue,  6 Feb 2024 17:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707239453; cv=none; b=Dy6uBYoqClSw5NEiKDqfJKUwa9oad541RRgcCIxzgrmatWg/yjQWhhIk+10cbq5mXeR+mOmUDKhoX3q8mZPOMTsapWsWveDGf3jrz9Bj6yn8togTm3xHpEj1hl9IdiPPjWTXXeC+SO/C5jUa9e9/ce6T5V0vaeOmN6Sq0XNSGu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707239453; c=relaxed/simple;
	bh=EV68goH/lze21RDEV86RaT0o7GC4OAsf6rElMCkIhHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLtRzctO/eYIcfcMDkng1IoGBypmDutgvfXYcPoC7lxMxVdKMZih/aRcX3LPY79oam8mmkRq+1auOjd3Ui1P0DzeDRcplEI3/uUj8FBiPTiCUC/6fhhpZUZ5YhxoYLBLnbGIZsgsVeJQV2/nbe78mLrZkWCnG8BkCyVYJwk6vPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VVxbRL8z; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1d9b2400910so5915295ad.0
        for <linux-pci@vger.kernel.org>; Tue, 06 Feb 2024 09:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707239450; x=1707844250; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qTM4f7KyeHcVcu9cnb0XrnzX2YN9NImIrLOFDGzEbBo=;
        b=VVxbRL8zHNkMzAiBQLV88gWTkcGsGxuTbrcI05SsFG8VsxXiXkhGWCpgsGsEXS/qfa
         si6Nu66Wr0rSCXz7jYDnrFKh65ocx5s3P6Lnx+bBLKA43F0DXwAQ8OxoyGY/SgoryPzA
         MMPdu4g1FXRXSn7Tifo6QMUv4XkKONgw4+sk5a9hp0cZe0hOgbe3x+ftDMfdoehtSUJJ
         VlXtialmyWZTFst1oxxjO5cTNofWLQt8GkkSPTCr8170I3/Pd6TuIAk22wvUbPbwBh+M
         bcYANgiMLkU3HaGBbkgV1gQOxgYHzcVL4Ps0XhSh6nLfLmeB9UqJ3jnxrzdUHXoWqxU5
         JFTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707239450; x=1707844250;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qTM4f7KyeHcVcu9cnb0XrnzX2YN9NImIrLOFDGzEbBo=;
        b=nyyq6OEcyesm6/h2XwcT6r6X9dyzDon5gASmWmQMNS9OHwEI24EJnbNpGLdmiogout
         BTNRenj0X421Y2kLH3HzadtcvJRt398eDkdFjs4JmMe62TmVOmWyJf+Lx2OoK/nrHSbd
         KVFamC+R8+uJ92/OjxbESqw6/olDtO5Wj4bCkdJtrTErl445Cj8m91HiIess3IObtjps
         7fV2kI1P0HMd3IIdVtbLxL7YqXFMdrvZADK/yZOcs5IsFB2UalQNgO7qktOZpE3wxMya
         xQCVACQo2Iz+QbBvG+FLT5TlOL11MerbIIdPc6zHHQMboKQC0hQK1SVVYEWojyFFET61
         /zFg==
X-Gm-Message-State: AOJu0Yw8Uw191EJzHieFYWKbvttD+GJ7K1VLkW6itGl1D94+sK1fCiN7
	x0qjcvUzpkVDGHd7U1GUxLgpjZomSnFEk8bqNzdIX1LWchc/8LXh31uAee9xnQ==
X-Google-Smtp-Source: AGHT+IHi/L7AHgD06gpAXQvPS+ie7mGrjZqvFd6tDJnuYEUDRubH1PBNHPwf2vvhR7UuFxiFRHuhmg==
X-Received: by 2002:a17:902:ec86:b0:1d9:30e3:ea84 with SMTP id x6-20020a170902ec8600b001d930e3ea84mr3471664plg.2.1707239450460;
        Tue, 06 Feb 2024 09:10:50 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVtXdw1EauiJGESh9RlwRkExNszl+kAiyqBlhuzP6gM6eSkNkatF0P49qeMAUqqs2Q9E7cRwm3skx/LAUZEE7YojXGkQY37MEsmnF91wyRV5S++lFdQo7YU6718eSyj9dtxz3mK41M2jyM7438XWb8FDkaLlidFgmL+xlB0qUkgPx5D+0aw+qoJBbjEeUfthLe4ghPOVpHXjFtYkFYTBNlK5bEj8k8xAFAvFfnMaOTAN2KcCFHy6s4NK8tixzaX8eUEOv0L1Rj4qaDJDBlN1V1NjB6sDw34HjODOz4IXWvBy2uPnrur10r8GN6fnXbhs6Gn+mmatd2ONYHk5SyfscLEvVLtSZQb5joEjQbHrEnJXRUf0zQS6f9TmuG0WZDZ1rXhvYC05uVE/i6S1RBEfUax7mH+oNU4Ev1ed7okCeFZo1Qi0FgKQslljf+Vow==
Received: from thinkpad ([120.138.12.111])
        by smtp.gmail.com with ESMTPSA id lo11-20020a170903434b00b001d91b608a9csm2091202plb.279.2024.02.06.09.10.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Feb 2024 09:10:50 -0800 (PST)
Date: Tue, 6 Feb 2024 22:40:43 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
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
Message-ID: <20240206171043.GE8333@thinkpad>
References: <20240129071025.GE2971@thinkpad>
 <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZcC_xMhKdpK2G_AS@google.com>

+ Joao

On Mon, Feb 05, 2024 at 04:30:20PM +0530, Ajay Agarwal wrote:
> On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > > 
> > > > [...]
> > > > 
> > > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > > 
> > > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > > 
> > > > > > > > 
> > > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > > experience.
> > > > > > > > 
> > > > > > > > If there are any other usecases, please state them.
> > > > > > > > 
> > > > > > > > - Mani
> > > > > > > >
> > > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > > hence the link-up is not attempted.
> > > > > > 
> > > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > > I am not adding any logic/condition around calling the start_link()
> > > > > itself. I am only avoiding the wait for the link to be up if the
> > > > > controller driver has not defined start_link().
> > > > > 
> > > > 
> > > > I'm saying that not defining the start_link() callback itself is wrong.
> > > > 
> > > Whether the start_link() should be defined or not, is a different
> > > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > > dw-plat) which do not have start_link() defined. Waiting for the link to
> > > come up for the platforms using those drivers is not a good idea. And
> > > that is what we are trying to avoid.
> > > 
> > 
> > NO. The sole intention of this patch is to fix the delay observed with _your_
> > out-of-tree controller driver as you explicitly said before. Impact for the
> > existing 2 drivers are just a side effect.
> >
> Hi Mani,
> What is the expectation from the pcie-designware-host driver? If the
> .start_link() has to be defined by the vendor driver, then shouldn't the
> probe be failed if the vendor has not defined it? Thereby failing the
> probe for intel-gw and pcie-dw-plat drivers?
> 

intel-gw maintainer agreed to fix the driver [1], but I cannot really comment on
the other one. It is not starting the link at all, so don't know how it works.
I've CCed the driver author to get some idea.

[1] https://lore.kernel.org/linux-pci/BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com/

> Additionally, if the link fails to come up even after 1 sec of wait
> time, shouldn't the probe be failed in that case too?
> 

Why? The device can be attached at any point of time. What I'm stressing is, the
driver should check for the link to be up during probe and if there is no
device, then it should just continue and hope for the device to show up later.
This way, the driver can detect the powered up devices during boot and also
detect the hotplug devices.

> My understanding of these drivers is that the .start_link() is an
> OPTIONAL callback and that the dw_pcie_host_init should help setup the
> SW structures regardless of whether the .start_link() has been defined
> or not, and whether the link is up or not. The vendor should be allowed
> to train the link at a later point of time as well.
> 

What do you mean by later point of time? Bringing the link through debugfs? NO.
We cannot let each driver behave differently, unless there is a really valid
reason.

> Please let me know your thoughts.
> > > > > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > > > > negligible. The reason why I'm against not calling start_link() is due to below
> > > > > > reasons:
> > > > > > 
> > > > > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > > > > that powers up the endpoints during boot, then it creates a dependency with
> > > > > > userspace to always start the link even though the devices were available.
> > > > > > That's why we should never fix the behavior of the controller drivers based on a
> > > > > > single platform.
> > > > > I wonder how the behavior is changing with this patch. Do you have an
> > > > > example of a platform which does not have start_link() defined but would
> > > > > like to still wait for a second for the link to come up?
> > > > > 
> > > > 
> > > > Did you went through my reply completely? I mentioned that the 1s delay would be
> > > > gone if you add the async flag to your driver and you are ignoring that.
> > > > 
> The async probe might not help in all the cases. Consider a situation
> where the PCIe is probed after the boot is already completed. The user
> will face the delay then. Do you agree?
> 

You mean loading the driver module post boot? If the link is still not up, yes
the users will see the 1sec delay.

But again, the point I'm trying to make here is, all the drivers have to follow
one flow. We cannot let each driver do its way of starting the link. There could
be exceptions if we get a valid reason for a driver to not do so, but so far I
haven't come across such reason. (the existing drivers, intel-gw and
designware-plat are not exceptions, but they need fixing).

For your driver, you said that the userspace brings up the link, post boot when
the devices are powered on. So starting the link during probe incurs 1s delay,
as there would be no devices. But I suggested you to enable async probe to
nullify the 1s delay during probe and you confirmed that it fixes the issue for
you.

Then you are again debating about not defining the start_link() callback :(

I've made by point clear, please do not take inspiration from those drivers,
they really need fixing. And for your usecase, allowing the controller driver
to start the link post boot just because a device on your Pixel phone comes up
later is not a good argument. You _should_not_ define the behavior of a
controller driver based on one platform, it is really a bad design.

- Mani

> > > Yes, I did go through your suggestion of async probe and that might
> > > solve my problem of the 1 sec delay. But I would like to fix the problem
> > > at the core.
> > > 
> > 
> > There is no problem at the core. The problem is with some controller drivers.
> > Please do not try to fix a problem which is not there. There are no _special_
> > reasons for those 2 drivers to not define start_link() callback. I'm trying to
> > point you in the right path, but you are always chosing the other one.
> > 
> > > > But again, I'm saying that not defining start_link() itself is wrong and I've
> > > > already mentioned the reasons.
> > > > 
> > > > > For example, consider the intel-gw driver. The 1 sec wait time in its
> > > > > probe path is also a waste because it explicitly starts link training
> > > > > later in time.
> > > > > 
> > > > 
> > > > I previously mentioned that the intel-gw needs fixing since there is no point in
> > > > starting the link and waiting for it to come up in its probe() if the DWC core
> > > > is already doing that.
> > > > 
> > > > - Mani
> > > > 
> > > > -- 
> > > > மணிவண்ணன் சதாசிவம்
> > > I think we are at a dead-end in terms of agreeing to a policy. I would
> > > like the maintainers to pitch in here with their views.
> > 
> > I'm the maintainer of the DWC drivers that you are proposing the patch for. If
> > you happen to spin future revision of this series, please carry:
> > 
> > Nacked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > - Mani
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்

