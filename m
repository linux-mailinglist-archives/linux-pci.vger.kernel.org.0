Return-Path: <linux-pci+bounces-4196-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D23C86B5FF
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 18:30:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1224E282DB4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Feb 2024 17:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEE23FBA2;
	Wed, 28 Feb 2024 17:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HPc0uNWj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78CEE3FBB5
	for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 17:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141401; cv=none; b=udD36lCrHrlJV18ICS63e6y7bDQ5TXAB+uMXSHw9IIlW3f7EhGBWmzKI91Xs0S+2EPF89EtJyccsGJrImcz85jyBOdcZRDpHVDiWS9WPmTOmItTLctEYKTOqP0QGmmjtz6qotae9MX8LvYnoE9XD5xN4L5qCjfJsBAFxNkpzkr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141401; c=relaxed/simple;
	bh=tvQ9+tb+YpWfBwRrMRVCmHJxdkq5vLBUNKv17OXiS/A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d89NBiZWJqi5MWQzMybpAIVpX1edXkp88lYgc8qy6xoutNXmWeoPNh0/wgZ6m8B+Ipx5OJQeRWFUYO2p6AMAXBxh5mOgfqONJXzV61/aw7anQclmrlcwa8b+i0k35u1u/XeXExONlqHJQ/qy8QJdDbrqWjRMV8fAG8CgcHGjJgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HPc0uNWj; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1dc1ff697f9so475635ad.0
        for <linux-pci@vger.kernel.org>; Wed, 28 Feb 2024 09:29:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709141399; x=1709746199; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dyM0UhAWssIxwMtD5nFa16+tuS8Yh/JlUs2FPS/Vsy0=;
        b=HPc0uNWjV+yeDhLuTUkx8/E3wArx14PyK1eD13OvGgKWIBtKiTuh4RIzrYn3onpbqY
         JPVyEP+hVcSFscNw8GCEJGWSv84aNrht4BPv9fWFRJS5E4ClAQ2fHFNmTsY8I6cg893R
         JoPzJsGBwmp1OMXS2+uY/efgqI/mtuli1Wdqph541QwSaPSEVQB18dvl9PrfsRsdBB0s
         CsSMht7zultQdsuBjGvXpWgjuB96rVrvh/6+nkqrx5I3JUSL8ec5UtSDG8KV0O60bq0R
         XZUt1A1FTAEXKnLXvrEvkkrlHf2zEHh1ebkPk4swbrvVOqzo7Be7E+L9o9zqp38GFs4H
         +3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709141399; x=1709746199;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dyM0UhAWssIxwMtD5nFa16+tuS8Yh/JlUs2FPS/Vsy0=;
        b=KuoJ49OeViXlELnrnOEX6vW/e95b6Xl3d7OevaCgRwI9I+4LhWRUlLt0NV3Hszv7Xx
         jBqB5zaVnWOmWP78vG0IbqZdAjUNiHpW4yB0+8JrQeOc2OI6NbcuRBF+/1ysPyIhKlof
         z3Ba5L7ZnwO3Hcf2azJS7y8Ts/Ld1RCPdrgP8ro/mFJuUEAKcwKcqeLlvGJXT4boSOmK
         ENuQ1q497w3250fEipoI0gXe+mp9RlTH8qzk2WEOi/5L+2tZxzZDikzQkpUE0HJHAFtQ
         72Oz0h2F9ezU5TPDVrNFFpOoScilqxhHHWWku4Q0DQAFryG+i24eZGqlZeLSH3FmMzPT
         mkRg==
X-Forwarded-Encrypted: i=1; AJvYcCW22NRtLniTZnIL4B2KLYyrv0dbPMTJsh7tvM+u+XN6NXXag3XJyB/N1QiIoqlxO3YDmGx2hsXwY6mUkii+D2tk3A/l4zbhlm1K
X-Gm-Message-State: AOJu0YyPLhMPNaLSHCNVJsDmqmIKsMJagGuLUp2P8fP4bmi5aYCyYuCu
	R54DCeaQ+SkbBuw9LcZRIq6pqIBiWClpy/f1PJW3UscAaay3XNj1rMBMsYC97Q==
X-Google-Smtp-Source: AGHT+IH41rK1p0JIHwOw8PHLa4vennMZAHKoBzhFcLq9LILJQmDqNIq6PeeIx9DNZyCwf1jX4ZkMZA==
X-Received: by 2002:a17:902:700b:b0:1dc:7fb4:20cb with SMTP id y11-20020a170902700b00b001dc7fb420cbmr34749plk.62.1709141398647;
        Wed, 28 Feb 2024 09:29:58 -0800 (PST)
Received: from thinkpad ([117.217.185.109])
        by smtp.gmail.com with ESMTPSA id ja13-20020a170902efcd00b001dc8db3150asm3554140plb.199.2024.02.28.09.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 09:29:58 -0800 (PST)
Date: Wed, 28 Feb 2024 22:59:51 +0530
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
Message-ID: <20240228172951.GB21858@thinkpad>
References: <20240129081254.GF2971@thinkpad>
 <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZdTikV__wg67dtn5@google.com>

On Tue, Feb 20, 2024 at 11:04:09PM +0530, Ajay Agarwal wrote:
> On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > + Joao
> > 
> > On Mon, Feb 05, 2024 at 04:30:20PM +0530, Ajay Agarwal wrote:
> > > On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > > > > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > > > > 
> > > > > > [...]
> > > > > > 
> > > > > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > > > > 
> > > > > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > > > > experience.
> > > > > > > > > > 
> > > > > > > > > > If there are any other usecases, please state them.
> > > > > > > > > > 
> > > > > > > > > > - Mani
> > > > > > > > > >
> > > > > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > > > > hence the link-up is not attempted.
> > > > > > > > 
> > > > > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > > > > I am not adding any logic/condition around calling the start_link()
> > > > > > > itself. I am only avoiding the wait for the link to be up if the
> > > > > > > controller driver has not defined start_link().
> > > > > > > 
> > > > > > 
> > > > > > I'm saying that not defining the start_link() callback itself is wrong.
> > > > > > 
> > > > > Whether the start_link() should be defined or not, is a different
> > > > > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > > > > dw-plat) which do not have start_link() defined. Waiting for the link to
> > > > > come up for the platforms using those drivers is not a good idea. And
> > > > > that is what we are trying to avoid.
> > > > > 
> > > > 
> > > > NO. The sole intention of this patch is to fix the delay observed with _your_
> > > > out-of-tree controller driver as you explicitly said before. Impact for the
> > > > existing 2 drivers are just a side effect.
> > > >
> > > Hi Mani,
> > > What is the expectation from the pcie-designware-host driver? If the
> > > .start_link() has to be defined by the vendor driver, then shouldn't the
> > > probe be failed if the vendor has not defined it? Thereby failing the
> > > probe for intel-gw and pcie-dw-plat drivers?
> > > 
> > 
> > intel-gw maintainer agreed to fix the driver [1], but I cannot really comment on
> > the other one. It is not starting the link at all, so don't know how it works.
> > I've CCed the driver author to get some idea.
> > 
> > [1] https://lore.kernel.org/linux-pci/BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com/
> > 
> > > Additionally, if the link fails to come up even after 1 sec of wait
> > > time, shouldn't the probe be failed in that case too?
> > > 
> > 
> > Why? The device can be attached at any point of time. What I'm stressing is, the
> > driver should check for the link to be up during probe and if there is no
> > device, then it should just continue and hope for the device to show up later.
> My change is still checking whether the link is up during probe.
> If yes, print the link status (negotiated speed and width).
> If no, and the .start_link() exists, then call the same and wait for 1
> second for the link to be up.
> 

There is a reason why we are wating for 1s for the device to show up during
probe. Please look at my earlier reply to Bjorn.

> > This way, the driver can detect the powered up devices during boot and also
> > detect the hotplug devices.
> >
> If the .start_link() is not defined, how will the link come up? Are you
> assuming that the bootloader might have enabled link training?
> 

Yes, something like that. But that assumption is moot in the first place.

> > > My understanding of these drivers is that the .start_link() is an
> > > OPTIONAL callback and that the dw_pcie_host_init should help setup the
> > > SW structures regardless of whether the .start_link() has been defined
> > > or not, and whether the link is up or not. The vendor should be allowed
> > > to train the link at a later point of time as well.
> > > 
> > 
> > What do you mean by later point of time? Bringing the link through debugfs? NO.
> > We cannot let each driver behave differently, unless there is a really valid
> > reason.
> > 
> pci_rescan_bus() is an exported API. I am assuming that this means that
> it is supposed to be used by modules when they know that the link is up.
> If a module wishes to bring the link up using debugfs or some other HW
> trigger, why is that a bad design? In my opinion, this is providing more
> options to the HW/product designer and the module author, in addition to
> the already existing .start_link() callback.
> 

If the driver _knows_ that the device is up, then rescanning the bus makes
sense. But here we are checking for the existence of the device.

> > > Please let me know your thoughts.
> > > > > > > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > > > > > > negligible. The reason why I'm against not calling start_link() is due to below
> > > > > > > > reasons:
> > > > > > > > 
> > > > > > > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > > > > > > that powers up the endpoints during boot, then it creates a dependency with
> > > > > > > > userspace to always start the link even though the devices were available.
> > > > > > > > That's why we should never fix the behavior of the controller drivers based on a
> > > > > > > > single platform.
> > > > > > > I wonder how the behavior is changing with this patch. Do you have an
> > > > > > > example of a platform which does not have start_link() defined but would
> > > > > > > like to still wait for a second for the link to come up?
> > > > > > > 
> > > > > > 
> > > > > > Did you went through my reply completely? I mentioned that the 1s delay would be
> > > > > > gone if you add the async flag to your driver and you are ignoring that.
> > > > > > 
> > > The async probe might not help in all the cases. Consider a situation
> > > where the PCIe is probed after the boot is already completed. The user
> > > will face the delay then. Do you agree?
> > > 
> > 
> > You mean loading the driver module post boot? If the link is still not up, yes
> > the users will see the 1sec delay.
> >
> > But again, the point I'm trying to make here is, all the drivers have to follow
> > one flow. We cannot let each driver do its way of starting the link. There could
> > be exceptions if we get a valid reason for a driver to not do so, but so far I
> > haven't come across such reason. (the existing drivers, intel-gw and
> > designware-plat are not exceptions, but they need fixing).
> > 
> > For your driver, you said that the userspace brings up the link, post boot when
> > the devices are powered on. So starting the link during probe incurs 1s delay,
> > as there would be no devices. But I suggested you to enable async probe to
> > nullify the 1s delay during probe and you confirmed that it fixes the issue for
> > you.
> > 
> There are emulation/simulation platforms in which 1 second of runtime
> can correspond to ~1 hour of real-world time. Even if PCIe is probed
> asyncronously, it will still block the next set of processes.
>

Which simulation/emulation platform? The one during pre-production stage? If
there is no endpoint connected, why would you enable the controller first place?
And how can the endpoint show up later during simulation? Why can't it be up
earlier?
 
> > Then you are again debating about not defining the start_link() callback :(
> > 
> I am not sure why you think I am debating against defining the
> .start_link() callback. It is clearly an optional pointer and I am
> choosing to not use it because of the usecase. And if it is optional and
> I am not using it, why waste 1 sec of runtime waiting for the link? Do
> we have an example in upstream of platforms where this 1 sec could prove
> useful where link training is not being started by the platform driver
> but EPs have to be detected because they are present and powered-up?
> 

Please tell me how the link is started in your case without start_link()
callback.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

