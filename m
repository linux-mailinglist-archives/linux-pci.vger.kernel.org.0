Return-Path: <linux-pci+bounces-3791-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D53EA85C2C3
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 18:34:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 646AA1F21BC1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 17:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E6676C6D;
	Tue, 20 Feb 2024 17:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uYYPea4/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C4216BB3C
	for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 17:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708450461; cv=none; b=ooZ+F6iCsRvUnmHVFnZqtJTPqJwy3hQAm0JSVC+1YymqTOHpt9xBCUzsI+GcMEHgSAAz2LPMAhKotLfDVHVTISPdwU8Bhhc/D3XcPYMy46xVCRyeCYqlWEcDxmNquyUR6fKJ2NP54fZcRqO5RDGHBqi8UBjETSylRny4KKOVeXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708450461; c=relaxed/simple;
	bh=f0LnEQ7iCIBaQeMNiFr0GR9LYQoiBOyqglmr5IwOqok=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ieQC1xQpQ/PCBvDLtRxt8rvHzPJ8n6MbHejaPCD1HUPXuw3PE3k581aj7RQRlMaeHX4suuEbOsgy1zxltNkrhZONYZ3gVRhYjiQjdzL0o+AOd/qTN3gSUDqf2fjtCXfxiFcadv72Yg/gUa52+O8q9GIRfFcOCfDxkMwI9PTVPeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uYYPea4/; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1db6e0996ceso42052245ad.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 09:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708450459; x=1709055259; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=05lyVQcThCGcpEdODy1mE9JKkGft79P598r4hliifBE=;
        b=uYYPea4/TrNY2h+mcn/2l2Kbz9bouZJOu3Tu5b4EuRgajf+6dq3DatBaQ5/YI8lduB
         ap3fJHoWwseh7chpcdvvqwjfQ5Iaik/9BjuGGpBdyEn4KwMbxq5P+K7K/3FsNrKjZyTQ
         eO/7Knbl5Hi3gjZXVlD267qvGZjPeU+0xZkWHb8itbX8/wdjO8UQDVZeTOcKQlDvAahq
         0rHJAVQUpgG8jLIBVnnMhVSX3pzFS1ukP8+Bf5sXTwFHRG9048Kcy31fCM3OdC+5fmK+
         5TywCo9AGYf0xnrZt05H3Mb6nu4dxT264OFV+zXkzXGiu8Ga32wIIdV1KyHCZj8fmw0m
         x7kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708450459; x=1709055259;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=05lyVQcThCGcpEdODy1mE9JKkGft79P598r4hliifBE=;
        b=g0j+UU5gb2QObLjRj58c1x2EMHGIZHbkMsMR9EGA5m4tRwlvC3WpXecvfDdriGt1dF
         BZqOxKuMg5MfHNyGQo5zMOEDjbj8p44MyuGA0FY3I4dhELXBco1EESUGC1ypfSbbDELC
         J8aMN+k0Gqwvk8kaOmuHBWairYvW20GsAn3kWheXVyXADxQP3RLGLxeSYx1+vBt3ZMMB
         l4rc6CQMX9N89QsQEIQku3RArXWuHjFXfFEv0vjGffEWNNMEPtWpG67ajYBRiK2FfCCs
         xEAFbfeMjCGOP9f923pafaI9wNIMpP4cHXxQSbt/qKZCD+CpwJD2RbnYXVGnVH7B/cQe
         SIMA==
X-Forwarded-Encrypted: i=1; AJvYcCVLeuCWqZzR/yVvkZhR2ydaAs30tcrAKqQDnIT6muwCnJ7bSnGk+O7GrG0qwiSo579wyCn07nh2okf59btIDn300OhpYgAGYrar
X-Gm-Message-State: AOJu0YyGwRrnsZgkwW0vkVMeXMtIME3RCE70q264iXNbSJHVIFgWgJWK
	tA8WY4OLrLKf0/3kXASQ8aJ+D4ZoCguWr17sgvc+yCeh4u4r8S4vNBsypX0FjQ==
X-Google-Smtp-Source: AGHT+IGQjGq7cqzrYytPFwlThRBufSaoVkTjFgPiEzk6XQwhxMef/Kf5BE/7uvVenMokHMtZj09eJA==
X-Received: by 2002:a17:902:db01:b0:1db:f952:eebf with SMTP id m1-20020a170902db0100b001dbf952eebfmr6069791plx.44.1708450459257;
        Tue, 20 Feb 2024 09:34:19 -0800 (PST)
Received: from google.com (223.253.124.34.bc.googleusercontent.com. [34.124.253.223])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001dbbcff0b5bsm6454306plb.232.2024.02.20.09.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 09:34:18 -0800 (PST)
Date: Tue, 20 Feb 2024 23:04:09 +0530
From: Ajay Agarwal <ajayagarwal@google.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
Message-ID: <ZdTikV__wg67dtn5@google.com>
References: <ZbdcJDWcZG3Y3efJ@google.com>
 <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240206171043.GE8333@thinkpad>

On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> + Joao
> 
> On Mon, Feb 05, 2024 at 04:30:20PM +0530, Ajay Agarwal wrote:
> > On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> > > On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > > > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > > > 
> > > > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > > > 
> > > > > > > > > 
> > > > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > > > experience.
> > > > > > > > > 
> > > > > > > > > If there are any other usecases, please state them.
> > > > > > > > > 
> > > > > > > > > - Mani
> > > > > > > > >
> > > > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > > > hence the link-up is not attempted.
> > > > > > > 
> > > > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > > > I am not adding any logic/condition around calling the start_link()
> > > > > > itself. I am only avoiding the wait for the link to be up if the
> > > > > > controller driver has not defined start_link().
> > > > > > 
> > > > > 
> > > > > I'm saying that not defining the start_link() callback itself is wrong.
> > > > > 
> > > > Whether the start_link() should be defined or not, is a different
> > > > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > > > dw-plat) which do not have start_link() defined. Waiting for the link to
> > > > come up for the platforms using those drivers is not a good idea. And
> > > > that is what we are trying to avoid.
> > > > 
> > > 
> > > NO. The sole intention of this patch is to fix the delay observed with _your_
> > > out-of-tree controller driver as you explicitly said before. Impact for the
> > > existing 2 drivers are just a side effect.
> > >
> > Hi Mani,
> > What is the expectation from the pcie-designware-host driver? If the
> > .start_link() has to be defined by the vendor driver, then shouldn't the
> > probe be failed if the vendor has not defined it? Thereby failing the
> > probe for intel-gw and pcie-dw-plat drivers?
> > 
> 
> intel-gw maintainer agreed to fix the driver [1], but I cannot really comment on
> the other one. It is not starting the link at all, so don't know how it works.
> I've CCed the driver author to get some idea.
> 
> [1] https://lore.kernel.org/linux-pci/BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com/
> 
> > Additionally, if the link fails to come up even after 1 sec of wait
> > time, shouldn't the probe be failed in that case too?
> > 
> 
> Why? The device can be attached at any point of time. What I'm stressing is, the
> driver should check for the link to be up during probe and if there is no
> device, then it should just continue and hope for the device to show up later.
My change is still checking whether the link is up during probe.
If yes, print the link status (negotiated speed and width).
If no, and the .start_link() exists, then call the same and wait for 1
second for the link to be up.

> This way, the driver can detect the powered up devices during boot and also
> detect the hotplug devices.
>
If the .start_link() is not defined, how will the link come up? Are you
assuming that the bootloader might have enabled link training?

> > My understanding of these drivers is that the .start_link() is an
> > OPTIONAL callback and that the dw_pcie_host_init should help setup the
> > SW structures regardless of whether the .start_link() has been defined
> > or not, and whether the link is up or not. The vendor should be allowed
> > to train the link at a later point of time as well.
> > 
> 
> What do you mean by later point of time? Bringing the link through debugfs? NO.
> We cannot let each driver behave differently, unless there is a really valid
> reason.
> 
pci_rescan_bus() is an exported API. I am assuming that this means that
it is supposed to be used by modules when they know that the link is up.
If a module wishes to bring the link up using debugfs or some other HW
trigger, why is that a bad design? In my opinion, this is providing more
options to the HW/product designer and the module author, in addition to
the already existing .start_link() callback.

> > Please let me know your thoughts.
> > > > > > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > > > > > negligible. The reason why I'm against not calling start_link() is due to below
> > > > > > > reasons:
> > > > > > > 
> > > > > > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > > > > > that powers up the endpoints during boot, then it creates a dependency with
> > > > > > > userspace to always start the link even though the devices were available.
> > > > > > > That's why we should never fix the behavior of the controller drivers based on a
> > > > > > > single platform.
> > > > > > I wonder how the behavior is changing with this patch. Do you have an
> > > > > > example of a platform which does not have start_link() defined but would
> > > > > > like to still wait for a second for the link to come up?
> > > > > > 
> > > > > 
> > > > > Did you went through my reply completely? I mentioned that the 1s delay would be
> > > > > gone if you add the async flag to your driver and you are ignoring that.
> > > > > 
> > The async probe might not help in all the cases. Consider a situation
> > where the PCIe is probed after the boot is already completed. The user
> > will face the delay then. Do you agree?
> > 
> 
> You mean loading the driver module post boot? If the link is still not up, yes
> the users will see the 1sec delay.
>
> But again, the point I'm trying to make here is, all the drivers have to follow
> one flow. We cannot let each driver do its way of starting the link. There could
> be exceptions if we get a valid reason for a driver to not do so, but so far I
> haven't come across such reason. (the existing drivers, intel-gw and
> designware-plat are not exceptions, but they need fixing).
> 
> For your driver, you said that the userspace brings up the link, post boot when
> the devices are powered on. So starting the link during probe incurs 1s delay,
> as there would be no devices. But I suggested you to enable async probe to
> nullify the 1s delay during probe and you confirmed that it fixes the issue for
> you.
> 
There are emulation/simulation platforms in which 1 second of runtime
can correspond to ~1 hour of real-world time. Even if PCIe is probed
asyncronously, it will still block the next set of processes.

> Then you are again debating about not defining the start_link() callback :(
> 
I am not sure why you think I am debating against defining the
.start_link() callback. It is clearly an optional pointer and I am
choosing to not use it because of the usecase. And if it is optional and
I am not using it, why waste 1 sec of runtime waiting for the link? Do
we have an example in upstream of platforms where this 1 sec could prove
useful where link training is not being started by the platform driver
but EPs have to be detected because they are present and powered-up?

> I've made by point clear, please do not take inspiration from those drivers,
> they really need fixing. And for your usecase, allowing the controller driver
> to start the link post boot just because a device on your Pixel phone comes up
> later is not a good argument. You _should_not_ define the behavior of a
> controller driver based on one platform, it is really a bad design.
> 
> - Mani
> 
> > > > Yes, I did go through your suggestion of async probe and that might
> > > > solve my problem of the 1 sec delay. But I would like to fix the problem
> > > > at the core.
> > > > 
> > > 
> > > There is no problem at the core. The problem is with some controller drivers.
> > > Please do not try to fix a problem which is not there. There are no _special_
> > > reasons for those 2 drivers to not define start_link() callback. I'm trying to
> > > point you in the right path, but you are always chosing the other one.
> > > 
> > > > > But again, I'm saying that not defining start_link() itself is wrong and I've
> > > > > already mentioned the reasons.
> > > > > 
> > > > > > For example, consider the intel-gw driver. The 1 sec wait time in its
> > > > > > probe path is also a waste because it explicitly starts link training
> > > > > > later in time.
> > > > > > 
> > > > > 
> > > > > I previously mentioned that the intel-gw needs fixing since there is no point in
> > > > > starting the link and waiting for it to come up in its probe() if the DWC core
> > > > > is already doing that.
> > > > > 
> > > > > - Mani
> > > > > 
> > > > > -- 
> > > > > மணிவண்ணன் சதாசிவம்
> > > > I think we are at a dead-end in terms of agreeing to a policy. I would
> > > > like the maintainers to pitch in here with their views.
> > > 
> > > I'm the maintainer of the DWC drivers that you are proposing the patch for. If
> > > you happen to spin future revision of this series, please carry:
> > > 
> > > Nacked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > - Mani
> > > 
> > > -- 
> > > மணிவண்ணன் சதாசிவம்
> 
> -- 
> மணிவண்ணன் சதாசிவம்

