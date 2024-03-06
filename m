Return-Path: <linux-pci+bounces-4571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F618735FE
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B8C61F23B46
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 12:01:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891D7FBD1;
	Wed,  6 Mar 2024 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CHzS/8lM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7167FBA0
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 12:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709726465; cv=none; b=riPsa73aBaX2pgncd9uOSA0TBD7FB6oY9S9US2zrb7YKNJpVcZwEK3wwMBYztu0QzFfSgcQEk/0/62gEHVVneCatwrGsdEvmVpGXJpj07g/fisJ43hT30gOsE7eTmRM2ovX9sbcHyR6FX7Q3jK+B2PrCDwRVaMB6JemjAxjYA3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709726465; c=relaxed/simple;
	bh=mcB5uOLZVW/+vAa6Ps+n0Fd3CDN3/hv/4RMG78SDaHw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VQ35HCzbHqI7vVXyEn6gvW0JAwcchj3ZbpgjJw89LNbP+42imyTgjpX1F4u0gS4nUCBbtKrJQFQlsdgjQfiEjwtaX8EspQRDAt2uTCvlMw0QRufGLtPYOQT0DGDfWu94E0NubKibf6Y1Sc045wdRrQ4UNyc8aC6NDBr45km2zNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CHzS/8lM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dc29f1956cso52986455ad.0
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 04:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709726463; x=1710331263; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=R/Y3F5MyWAAdW8trOJPcs+fVeT7Y42+R3l8fn2Xw+y0=;
        b=CHzS/8lMlIG6/gkAV6qNJmJ2IDM5um6HPeANVUoEonb1BLJmGhb540ZS2BU3EKEhm+
         xgdkkQoyrsTY41oDZi7bawcOI5u9qrskvzkf+c/U8mCA3tMbtl1jW4xPZRQCmPua5Yn+
         +BooK5SG12kq7WDjcyqb3D+RFJ/5AonGNqkZjuvogwnK1h8mEISDEdlo73KD7g0ykY2P
         Z6QzLTDifTPIwIhM2DQwut6LjEQLfRYAuS9g10g3jEuF+XMhOsq7uTFed9DaNtIOccRb
         jDbR6u/vb1D5aLYLyy8KBSNsFIbN+riC5FshpcZQr8Sn/lg327BRUz72Q8QUpOhZ+hn1
         OZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709726463; x=1710331263;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R/Y3F5MyWAAdW8trOJPcs+fVeT7Y42+R3l8fn2Xw+y0=;
        b=mOWsaCCjU7icIk1yBLPsLjXJTCfNZc5BDDkr5sQRGzpw7HB054AVgp0eJXfLBZXE8W
         0KVB5M4gbRrrtGKbUxQzNRhOZsLlELBjp0jf0YMAhX/Qm+oIp7j53UlCy9NJtfC38Lhu
         5/9g7PX6VM0sbsNyy4dBaRGxgtTGgTR3zmDR3ywWatVMjp+qRijnRRnWBKoZSW2aRHWG
         to86TOBl9ixXyY757b3uI/wvjVeQt6QO/QBe08Hc+S5oN8oEAai2D422oQb/WlWw9DsT
         9sTgtRfXujo6jkFD87wXfgQN+BB+UgfhGpmJHCihkKuYnP4wERK6n4aVk4NtdRfl1HgH
         lFig==
X-Forwarded-Encrypted: i=1; AJvYcCXaKw9bvYtZTZ+70iv7yKZZxdr5a9az6TLtMz+vuf1SPs3TxAz6ntdX/6Mgvt4CfWeUKFSEq+ClmJX1QhYDyGl/1+4EGOw5xCP/
X-Gm-Message-State: AOJu0YwOAxp8chcu/nC/m6KTobJDrxej7EuA4oTCdcpCMt5su0we2ZPX
	YFDicLnGmFrhpTCcjvlHQHLPBaesUW82b9WRCLUiC3GQNfva1mBqHTvWS2rLMA==
X-Google-Smtp-Source: AGHT+IHmaRtuPkHEU3ZdEMHWzwyTAdmX1dsBQT6Dg6PUnn3o4jBoBl2CdxtnQPYUziece9tePPD9BQ==
X-Received: by 2002:a17:903:48d:b0:1db:a94f:903d with SMTP id jj13-20020a170903048d00b001dba94f903dmr4116786plb.36.1709726461657;
        Wed, 06 Mar 2024 04:01:01 -0800 (PST)
Received: from google.com (122.235.124.34.bc.googleusercontent.com. [34.124.235.122])
        by smtp.gmail.com with ESMTPSA id i11-20020a170902c94b00b001dcdf24e336sm11619157pla.47.2024.03.06.04.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 04:01:01 -0800 (PST)
Date: Wed, 6 Mar 2024 17:30:53 +0530
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
Message-ID: <Zeha9dCwyXH7C35j@google.com>
References: <ZbengMb5zrigs_2Z@google.com>
 <20240130064555.GC32821@thinkpad>
 <Zbi6q1aigV35yy9b@google.com>
 <20240130122906.GE83288@thinkpad>
 <Zbkvg92pb-bqEwy2@google.com>
 <20240130183626.GE4218@thinkpad>
 <ZcC_xMhKdpK2G_AS@google.com>
 <20240206171043.GE8333@thinkpad>
 <ZdTikV__wg67dtn5@google.com>
 <20240228172951.GB21858@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240228172951.GB21858@thinkpad>

On Wed, Feb 28, 2024 at 10:59:51PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Feb 20, 2024 at 11:04:09PM +0530, Ajay Agarwal wrote:
> > On Tue, Feb 06, 2024 at 10:40:43PM +0530, Manivannan Sadhasivam wrote:
> > > + Joao
> > > 
> > > On Mon, Feb 05, 2024 at 04:30:20PM +0530, Ajay Agarwal wrote:
> > > > On Wed, Jan 31, 2024 at 12:06:26AM +0530, Manivannan Sadhasivam wrote:
> > > > > On Tue, Jan 30, 2024 at 10:48:59PM +0530, Ajay Agarwal wrote:
> > > > > > On Tue, Jan 30, 2024 at 05:59:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Tue, Jan 30, 2024 at 02:30:27PM +0530, Ajay Agarwal wrote:
> > > > > > > 
> > > > > > > [...]
> > > > > > > 
> > > > > > > > > > > > > If that's the case with your driver, when are you starting the link training?
> > > > > > > > > > > > > 
> > > > > > > > > > > > The link training starts later based on a userspace/debugfs trigger.
> > > > > > > > > > > > 
> > > > > > > > > > > 
> > > > > > > > > > > Why does it happen as such? What's the problem in starting the link during
> > > > > > > > > > > probe? Keep it in mind that if you rely on the userspace for starting the link
> > > > > > > > > > > based on a platform (like Android), then if the same SoC or peripheral instance
> > > > > > > > > > > get reused in other platform (non-android), the it won't be a seamless user
> > > > > > > > > > > experience.
> > > > > > > > > > > 
> > > > > > > > > > > If there are any other usecases, please state them.
> > > > > > > > > > > 
> > > > > > > > > > > - Mani
> > > > > > > > > > >
> > > > > > > > > > This SoC is targeted for an android phone usecase and the endpoints
> > > > > > > > > > being enumerated need to go through an appropriate and device specific
> > > > > > > > > > power sequence which gets triggered only when the userspace is up. The
> > > > > > > > > > PCIe probe cannot assume that the EPs have been powered up already and
> > > > > > > > > > hence the link-up is not attempted.
> > > > > > > > > 
> > > > > > > > > Still, I do not see the necessity to not call start_link() during probe. If you
> > > > > > > > I am not adding any logic/condition around calling the start_link()
> > > > > > > > itself. I am only avoiding the wait for the link to be up if the
> > > > > > > > controller driver has not defined start_link().
> > > > > > > > 
> > > > > > > 
> > > > > > > I'm saying that not defining the start_link() callback itself is wrong.
> > > > > > > 
> > > > > > Whether the start_link() should be defined or not, is a different
> > > > > > design discussion. We currently have 2 drivers in upstream (intel-gw and
> > > > > > dw-plat) which do not have start_link() defined. Waiting for the link to
> > > > > > come up for the platforms using those drivers is not a good idea. And
> > > > > > that is what we are trying to avoid.
> > > > > > 
> > > > > 
> > > > > NO. The sole intention of this patch is to fix the delay observed with _your_
> > > > > out-of-tree controller driver as you explicitly said before. Impact for the
> > > > > existing 2 drivers are just a side effect.
> > > > >
> > > > Hi Mani,
> > > > What is the expectation from the pcie-designware-host driver? If the
> > > > .start_link() has to be defined by the vendor driver, then shouldn't the
> > > > probe be failed if the vendor has not defined it? Thereby failing the
> > > > probe for intel-gw and pcie-dw-plat drivers?
> > > > 
> > > 
> > > intel-gw maintainer agreed to fix the driver [1], but I cannot really comment on
> > > the other one. It is not starting the link at all, so don't know how it works.
> > > I've CCed the driver author to get some idea.
> > > 
> > > [1] https://lore.kernel.org/linux-pci/BY3PR19MB50764E90F107B3256189804CBD432@BY3PR19MB5076.namprd19.prod.outlook.com/
> > > 
> > > > Additionally, if the link fails to come up even after 1 sec of wait
> > > > time, shouldn't the probe be failed in that case too?
> > > > 
> > > 
> > > Why? The device can be attached at any point of time. What I'm stressing is, the
> > > driver should check for the link to be up during probe and if there is no
> > > device, then it should just continue and hope for the device to show up later.
> > My change is still checking whether the link is up during probe.
> > If yes, print the link status (negotiated speed and width).
> > If no, and the .start_link() exists, then call the same and wait for 1
> > second for the link to be up.
> > 
> 
> There is a reason why we are wating for 1s for the device to show up during
> probe. Please look at my earlier reply to Bjorn.
>
Yes, I looked at that. I am not sure if that is the real reason behind
this delay. The explanation that you quoted from the spec talks about
allowing 1s delay for the EP to return a completion. Whereas the delay
here is to wait for the link training itself to be completed.

We could surely wait for Lorenzo to explain the reason behind this
delay, but he himself approved the earlier patch [1] (which caused the
regression and had to be reverted):
 
 [1] https://lore.kernel.org/all/168509076553.135117.7288121992217982937.b4-ty@kernel.org/

> > > This way, the driver can detect the powered up devices during boot and also
> > > detect the hotplug devices.
> > >
> > If the .start_link() is not defined, how will the link come up? Are you
> > assuming that the bootloader might have enabled link training?
> > 
> 
> Yes, something like that. But that assumption is moot in the first place.
> 
Isnt it weird that a PCIe driver, which will most likely initialize all
the resources like power, resets, clocks etc., relies on the bootloader
to have enabled the link training?

I think it is safe to assume that a driver should have the start_link()
defined if it wishes to bring the link up during probe.

> > > > My understanding of these drivers is that the .start_link() is an
> > > > OPTIONAL callback and that the dw_pcie_host_init should help setup the
> > > > SW structures regardless of whether the .start_link() has been defined
> > > > or not, and whether the link is up or not. The vendor should be allowed
> > > > to train the link at a later point of time as well.
> > > > 
> > > 
> > > What do you mean by later point of time? Bringing the link through debugfs? NO.
> > > We cannot let each driver behave differently, unless there is a really valid
> > > reason.
> > > 
> > pci_rescan_bus() is an exported API. I am assuming that this means that
> > it is supposed to be used by modules when they know that the link is up.
> > If a module wishes to bring the link up using debugfs or some other HW
> > trigger, why is that a bad design? In my opinion, this is providing more
> > options to the HW/product designer and the module author, in addition to
> > the already existing .start_link() callback.
> > 
> 
> If the driver _knows_ that the device is up, then rescanning the bus makes
> sense. But here we are checking for the existence of the device.
> 
Yeah, so the driver could _know_ that the device is up later in the
game, right? And then re-scan the bus? Why wait for 1 sec here?

> > > > Please let me know your thoughts.
> > > > > > > > > add PROBE_PREFER_ASYNCHRONOUS to your controller driver, this delay would become
> > > > > > > > > negligible. The reason why I'm against not calling start_link() is due to below
> > > > > > > > > reasons:
> > > > > > > > > 
> > > > > > > > > 1. If the same SoC gets reused for other platforms, even other android phones
> > > > > > > > > that powers up the endpoints during boot, then it creates a dependency with
> > > > > > > > > userspace to always start the link even though the devices were available.
> > > > > > > > > That's why we should never fix the behavior of the controller drivers based on a
> > > > > > > > > single platform.
> > > > > > > > I wonder how the behavior is changing with this patch. Do you have an
> > > > > > > > example of a platform which does not have start_link() defined but would
> > > > > > > > like to still wait for a second for the link to come up?
> > > > > > > > 
> > > > > > > 
> > > > > > > Did you went through my reply completely? I mentioned that the 1s delay would be
> > > > > > > gone if you add the async flag to your driver and you are ignoring that.
> > > > > > > 
> > > > The async probe might not help in all the cases. Consider a situation
> > > > where the PCIe is probed after the boot is already completed. The user
> > > > will face the delay then. Do you agree?
> > > > 
> > > 
> > > You mean loading the driver module post boot? If the link is still not up, yes
> > > the users will see the 1sec delay.
> > >
> > > But again, the point I'm trying to make here is, all the drivers have to follow
> > > one flow. We cannot let each driver do its way of starting the link. There could
> > > be exceptions if we get a valid reason for a driver to not do so, but so far I
> > > haven't come across such reason. (the existing drivers, intel-gw and
> > > designware-plat are not exceptions, but they need fixing).
> > > 
> > > For your driver, you said that the userspace brings up the link, post boot when
> > > the devices are powered on. So starting the link during probe incurs 1s delay,
> > > as there would be no devices. But I suggested you to enable async probe to
> > > nullify the 1s delay during probe and you confirmed that it fixes the issue for
> > > you.
> > > 
> > There are emulation/simulation platforms in which 1 second of runtime
> > can correspond to ~1 hour of real-world time. Even if PCIe is probed
> > asyncronously, it will still block the next set of processes.
> >
> 
> Which simulation/emulation platform? The one during pre-production stage? If
Yes, the pre-production stage emulation platform.

> there is no endpoint connected, why would you enable the controller first place?
The endpoint is connected. But my usecase requires me to not bring it up
by default. Rather, I start the link training later using debugfs. So I
want to test my driver probe without attempting link training and
thereby, I face the 1 sec delay. I want to avoid it.

> And how can the endpoint show up later during simulation? Why can't it be up
> earlier?
> 
As explained above, I use debugfs to bring the link up later. The logic
for that is present in my platform driver. Once the link is up, I call
pci_rescan_bus() to enumerate the EP.

> > > Then you are again debating about not defining the start_link() callback :(
> > > 
> > I am not sure why you think I am debating against defining the
> > .start_link() callback. It is clearly an optional pointer and I am
> > choosing to not use it because of the usecase. And if it is optional and
> > I am not using it, why waste 1 sec of runtime waiting for the link? Do
> > we have an example in upstream of platforms where this 1 sec could prove
> > useful where link training is not being started by the platform driver
> > but EPs have to be detected because they are present and powered-up?
> > 
> 
> Please tell me how the link is started in your case without start_link()
> callback.
> 
As explained above, one method is to use debugfs to start the link
training. The actual usecase is for the userspace to start the link
training based on certain GPIO events from the endpoint.

> - Mani
> 
> -- 
> மணிவண்ணன் சதாசிவம்

