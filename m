Return-Path: <linux-pci+bounces-25972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4932DA8AFEC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 07:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51241441521
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 05:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0044522AE5D;
	Wed, 16 Apr 2025 05:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AAYp1GsE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CFD2DFA2D
	for <linux-pci@vger.kernel.org>; Wed, 16 Apr 2025 05:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744783183; cv=none; b=PyVpRsxs2StYLOz+1aGvZS/FxeKsTXg/Z0w0Hp84f5LaAmHZ6Afg+Dk9smUiC1gt8HCq/GQijxNrR+Qr7p1B9f2aYWa1vxCupSeUUEhO518mOgJh2HoHvq2rGmtOa6C8RTTg83SySqrURXAHci9nDxYU7QIxNayf12xEEGW1IS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744783183; c=relaxed/simple;
	bh=U0BjZL4Lx7TO7Xhd131sGNjl4AWfE8NP9ccnKt852DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nkef8Ccwl1zejt7WmA1JLYwyUVtPkNqWletw1VGR9AcxRrxdK3GXlFT0yQmmsQmBpNn+1+e4GB6K7Z/DOOnNKhR91/7ipxL806v2Cw7hTmfuLYC/i0QIcrqh0UVn3b35c9Y0incp55TnvFVnpQ3zieOvBUwV9WABaEpwnpZaEjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AAYp1GsE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22c33e5013aso3395785ad.0
        for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 22:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744783181; x=1745387981; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Fc4YlDA22v/lFPB3l07JRGNK8a8BJ9H0GRMCzm0Tp7o=;
        b=AAYp1GsEKLKv9y87RvQVEYTOgPLKY9evSgq74Z1wDIgHtu+YpuiyNJ/++UjjIGvQiu
         fQkV9kn7rQtJ8JDXbdO4N4qNnIanD0WaV0CTxHFWs2PL6Oi47NJVFY32NheGlnxam7lU
         C4klDyUmO8MGq/BsTPYshVg1srUjc7BHSdkGUZH3MuokTvRrpYU0h2LOCWnRszYIkvu6
         5ZticBJ5UH47yLPJcd7OpHvwX4Z94fFqxeR8XlP4ziwA9EWs23g2y5PPIVhcQM9Fii2U
         +IIisAL1Kp3sxmZqXkLp0xZUc64YG/3EvW5ff40aATN5z9H6Hn7riax5BhAZvgviA0Am
         D0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744783181; x=1745387981;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fc4YlDA22v/lFPB3l07JRGNK8a8BJ9H0GRMCzm0Tp7o=;
        b=P3B56ijarOU/RtuKNBFraNBluxLFloU/IfxgmXggiJ8aqxktnvBt89NreH1OGf0zl2
         ZlcyflMHLfChrvptpC+ch8LgKYjZiSjioxn8ziZZX+Z9NBYBKOcL5UcXK9n7fXEm4K1f
         LxNH5Q7Hu3/BHGsqZ1txjUtfVb59ZbqiY9H+wx656gPReVf5pAI2TnjPJQLVsN92Q0wl
         Vet7afLp+zr6qLYlKfVsN0lKdJvi6pSL8iDaWWQOw+xFoxoShrY4mt+LbJoCZE0HysyT
         SghgX0MgIon+kbs7xdc8qRqa0ZDGzJPqG4rCyiQzPq6CEmju3S4nPR0GExe25FwW3oUT
         SZIQ==
X-Forwarded-Encrypted: i=1; AJvYcCXC+NUSGW4R477JLG8fB9l8cZSGYdaNKfWrBYxr8QVRLGYph0kWOPe09Qi8DCvggHtxieN/+zlJtZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHy0lovf8bqnPrJC005SqSFVYqtevhWTEZSsOqcDfch+Nw3ouf
	C58v5CcHpGEiew/CaCEwp8MmcGaDtB9i2zaBbOt98EDOoKtwV4mQ4hCriNssUg==
X-Gm-Gg: ASbGncuqcPJNwdgUhzMVGD4X8yusGKsCtetrVSmXuJ4L5nHGGBme5pbSh2wG2zq5YMq
	PfLdP6pYV+E0ZFH2txJXCIWu9gwq2yeyrjMIyagLvLKjQ8HmLpyULGRiSl5/dzhBk43hiclG8Sp
	QeoDxjFC8EWLONQDrUhNA5i8EyvoyGzrEXfBN6dhjAS1w7+n45E8Idwyh1udi+Zd+LmOM6PglZY
	2HG4sNbo5uRAxpKr+luBZZ2YuGmlw5NrERNwtchquZPr/114fV0nQNv285S9JKhKMhB/p2W3TPg
	KvJzuk3B+spm4MsgDFEIIYGjiX9kw2VLvSFClwaCNsmppd1z9m8=
X-Google-Smtp-Source: AGHT+IH1ojTXGCrrmtBExy4tvdDSQdbsHr5aYiYtBcK8bXma6HvoTfk8IJ/PnSd8lWMp2Eq3fGw0JQ==
X-Received: by 2002:a17:902:e98d:b0:227:e7c7:d451 with SMTP id d9443c01a7336-22c35912243mr8382485ad.29.1744783180872;
        Tue, 15 Apr 2025 22:59:40 -0700 (PDT)
Received: from thinkpad ([120.60.130.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22c3584306bsm3560475ad.47.2025.04.15.22.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 22:59:40 -0700 (PDT)
Date: Wed, 16 Apr 2025 11:29:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	Tsai Sung-Fu <danielsftsai@google.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <eix65qdwtk5ocd7lj6sw2lslidivauzyn6h5cc4mc2nnci52im@qfmbmwy2zjbe>
References: <Z_WAKDjIeOjlghVs@google.com>
 <vfjh3xzfhwoppcaxlov5bcmkfngyf6no4zyrgexlcxpfajsw2t@o5nbfcep3auz>
 <Z_2ZNuJsDr0lDjbo@google.com>
 <4pwigzf7q6abyntt4opjv6lnvkdulyejr73efnud2cvltskgt2@tjs2k5tiwyvc>
 <Z_6kZ7x7gnoH-P7x@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_6kZ7x7gnoH-P7x@google.com>

On Tue, Apr 15, 2025 at 11:24:39AM -0700, Brian Norris wrote:
> Hi,
> 
> On Tue, Apr 15, 2025 at 11:02:14AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Apr 14, 2025 at 04:24:38PM -0700, Brian Norris wrote:
> > > On Mon, Apr 14, 2025 at 04:27:35PM +0530, Manivannan Sadhasivam wrote:
> > > > On Tue, Apr 08, 2025 at 12:59:36PM -0700, Brian Norris wrote:
> > > > > For link startup, pcie-designware-host.c currently
> > > > > (a) starts the link via platform-specific means (dw_pcie::ops::start_link()) and
> > > > > (b) waits for the link training to complete.
> > > > > 
> > > > > However, (b) will fail if the other end of the link is not powered up --
> > > > > e.g., if the appropriate pwrctrl driver has not yet loaded, or its
> > > > > device hasn't finished probing. Today, this can mean the designware
> > > > > driver will either fail to probe,
> > > > 
> > > > This is not correct.
> > > 
> > > That depends on the implementation of start_link(). But I suppose the
> > > intention is that start_link() only "starts" and doesn't care where
> > > things go from there. (IOW, my local start_link() implementation is
> > > probably wrong at the moment, as it performs some poll/retry steps too.)
> > > 
> > 
> > The callback is supposed to just start
> > the link and not wait for anything else.
> 
> Ack, thanks. I've learned something.
> 
> > > > > or at least waste time for a condition
> > > > > that we can't achieve (link up), depending on the HW/driver
> > > > > implementation.
> > > > > 
> > > > 
> > > > Unfortunately we cannot avoid this waiting time as we don't know if a device is
> > > > attached to the bus or not. The 1s wait time predates my involvement with DWC
> > > > drivers.
> > > 
> > > I don't really love that answer. It means that any DWC-based platform
> > > that needs pwrctrl and doesn't set use_link_irq==true will waste 1
> > > second per PCIe controller. While it's hard to make guarantees about old
> > > and/or unloved drivers, I'd like to think I can do better on new ones.
> > > 
> > 
> > Even I'd like to avoid the 1s delay. But the problem is how would you know if
> > the device is attached to the bus or not. The delay is to account for the fact
> > that the link may take up to 1s to come up post starting LTSSM. So if we do not
> > wait for that period, there is a chance that we would report the false negative
> > status and also the enumeration would fail.
> 
> I understand there are cases we won't know, if we don't have a
> hotplug/presence-detect wiring. But for cases we know, I think it's
> cop-out to say "we can't handle it." See below.
> 
> > > Consider
> > > the lesser statement that was paired along with it: always wasting 1
> > > second per controller polling for something that will never happen. It
> > > feels backwards and wasteful.
> > > 
> > 
> > Again, I do get your point. But tell me how can a controller reliably detect
> > that there is a device attached to the bus. Only on your android setup, you for
> > sure know that the device won't be there during probe. So you are considering 1s
> > wait as a wast of time and it is fair. But what if the same controller is used
> > in another platform which is not android or the endpoint device is powered on
> > during probe itself without replying on userspace?
> 
> This has nothing to do with Android.
> 
> IMO, we have 3 main categories of setups that we should primarily care
> about:
> 
> (1) hotplug is supported, and PRSNT1#/PRSNT2# are wired
> (2) hotplug is not supported, but a device is present and is already
>     powered.
> (3) hotplug is not supported, but a device is present. the device
>     requires external power (i.e., pwrctrl / "subdevice regulators" /
>     etc., should be involved)
> 
> AFAICT, we don't have much of (1). But if we did, we should also be able
> to avoid initial delays, as we can reliably detect presence, and only
> wait for training when we know it should succeed. (Or even better,
> handle it async via an interrupt.)
> 
> For (2), we're also OK. The initial polling delay is likely to be much
> less than 1 second.
> 
> For (3) ... all non-pwrctrl drivers (pcie-brcmstb.c, pcie-tegra.c,
> pcie-tegra194.c, pcie-rockchip-host.c, ...) power things up before they
> configure ports, start LTSSM, and have any expectation of detecting a
> link. If a device is there, they again should commonly find it in much
> less than 1 second.
> 
> However, when *using* pwrctrl, we have the ordering all wrong (IMO), and
> so we eat needless delay. We *will not* successfully bring the link up,
> and we *won't* find the device. This smells like a design problem, where
> we have failed to plumb the information we already have available.
> 

I don't disagree :)

> I think you're too worried about a case (4): that hotplug is not
> supported, and a device is not present.
> 
> IMO, (4) should mostly be handled by simply disabling the unused
> controller in device tree, or living with the timeouts. If a platform
> doesn't support hotplug, then you can't expect optimal behavior for
> unplugged devices.
> 
> I'm not complaining about (4). I'm complaining about (3) with pwrctrl.
> 

Ok!

> > > One of my key questions: if I don't have a link-up IRQ, how can I avoid
> > > this waste? pcie-brcmstb avoids that waste today (for the common case
> > > where there is, in fact, a device connected), and it would be a
> > > regression for it to start using pwrctrl tomorrow.
> > > 
> > 
> > Why are you tying pwrctrl with this designware driver behavior? Both are
> > unrelated. Even if you don't use pwrctrl and use controller driver to bring up
> > the device, the 1s delay would be applicable (if there is no device).
> 
> We might be talking past each other. Per above, I think we can do better
> with (1)-(3). But you're bringing up (4). Problem (3) exists for all
> drivers, although it's more acute with DWC, and I happen to be using it.
> I also think it's indicative of larger design and ordering problems in
> pwrctrl.
> 

Now I get what you are saying.

> > pcie-brcmstb driver indeed wastes time. It is not 1s but just 100ms. But that
> > driver is for only one vendor. In the case of DWC, the driver has to work with
> > multiple vendors. But again, I do not know how this 1s delay came up. Maybe we
> > could try to reduce it to 500ms or so, but for that I need confirmation from
> > someone like Lorenzo who knows the history.
> > 
> > > (Side note: I also just noticed pcie-tegra194.c does the same.)
> > > 
> > > > > My guess is that (1) is the case, and specifically that the relevant folks are
> > > > > using the pcie-qcom.c, with its "global" IRQ used for link-up events.
> > > > > 
> > > > 
> > > > We only recently added support for 'Link Up' event through 'global_irq' in the
> > > > controller driver. And this was done to avoid waiting for link up during probe
> > > 
> > > You're kind of reinforcing my question: you don't like the waste, so
> > > you're adding link-up IRQ support -- is that really the only way?
> > > 
> > 
> > I don't know. But so far I haven't seen any other sensible way which is generic.
> > 
> > > (My initial thought: no, it's not. We know when pwrctrl has done its
> > > thing -- why should we bother polling for link state before that? But
> > > that's easier said than done, when pwrctrl is optional and highly
> > > abstracted away from the DWC driver...)
> > > 
> > 
> > Oh well... this is where you got it wrong. pwrctrl drivers are only probed
> > before enumeration because of the design (which is way after starting the link).
> > As of v6.15-rc1, before we try to enumerate any device, we check if there is any
> > device defined in DT which requires power supply. If so, we create a platform
> > device (or pwrctrl device) and let the pwrctrl driver to bind to it and power up
> > the device. In that case, we also do not proceed to scan the bus further and
> > skip the hierarchy. Because, the pwrctrl driver will rescan the bus once it has
> > finished powering up the device.
> 
> It sounds like you're saying "it's the way that it is, because of the
> way that it is." I understand how it is currently structured, but I'm
> saying that I think pwrctrl is placed at the wrong place. It looks cute
> and clean, but it has the ordering wrong.
> 
> IMO, we should allow pwrctrl to power things up earlier, so that
> controller drivers have a better chance of hitting the optimal cases
> (case (3) above) properly. (That's also how every pre-pwrctrl driver
> does things, and I think it's for good reason.)
> 
> That would also resolve my PERST# and other timing questions, because
> the controller driver would better know when pwrctrl is finished, and so
> can better handle PERST# and any necessary delays.
> 
> I agree this might be more difficult to do in a "generic" way (per your
> above language), depending on your definition of generic. But IMO, it's
> important to prioritize doing things correctly, even if it's slightly
> less cute.
> 
> As an example less-cute way of doing pwrctrl: expose a wrapped version
> of pci_pwrctrl_create_device() such that drivers can call it earlier. If
> there is a pwrctrl device created, that means a driver should not yet
> wait for link-up -- it should defer that until the relevant pwrctrl is
> marked "ready". (There are likely other problems to solve in here too,
> but this is just an initial sketch. And to be clear, I suspect this
> doesn't fit your notion of "generic", because it requires each driver to
> adapt to it.)
> 

This is what I initially had in my mind, but then I opted for a solution which
allowed the pwrctrl devices to be created in the PCI core itself without any
modifications in the controller drivers.

But I totally agree with you that now we don't have any control over PERST# and
that should be fixed.

> > > Regarding the controller design: frankly, I don't think my controller
> > > does anything all that revolutionary in this space [0]. All of my
> > > questions today can be asked (from what I can tell) of existing upstream
> > > controller drivers. I'm mostly trying to understand the expected driver
> > > design here, and that includes teasing apart what is "stuff done in
> > > 'old' drivers, but isn't recommended", and "what is currently
> > > unimplemented in new stuff" (like pwrctrl [1]), and where do my
> > > expectations fit in between that.
> > > 
> > > For instance, poking around a bit I come up with this question: when
> > > using pci/pwrctrl, how does one ensure timing requirements around, e.g.,
> > > power stability vs PERST# deassertion are met? When looking at a pwrctrl
> > > driver like drivers/pci/pwrctrl/slot.c, the process looks too simple:
> > > 
> > > (0) host bridge probably already started its LTSSM, deasserted PERST#
> > > (1) slot.c powers the slot
> > > (2) pci_pwrctrl_device_set_ready() -> rescan_work_func() rescans the bus
> > > 
> > > Notably, there's no enforced delay between (1) and (2).
> > > 
> > > Reading the PCIe CEM, it seems we're violating some specification bits,
> > > like:
> > > 
> > >   2.2. PERST# Signal
> > >   [...] On power-up, the de-assertion of PERST# is delayed 100 ms
> > >   (TPVPERL) from the power rails achieving specified operating limits.
> > >   [...]
> > > 
> > > There are references to this in various implementations (e.g.,
> > > tegra_pcie_enable_slot_regulators() and brcm_pcie_start_link() --
> > > although I suspect the latter is applying the wrong ordering).
> > > 
> > > Additionaly, CEM also seems to suggest we have PERST# ordering wrong. It
> > > should also come between (1) and (2), not at (0).
> > > 
> > 
> > You are absolutely right! Currently, we follow the timing requirement while
> > deasserting the PERST# in the controller drivers. But once we power on the slot,
> > we do not touch PERST# and it just happen to work.
> > 
> > We may need to introduce another callback that toggles PERST# so that we can use
> > it while powering up the device.
> > 
> > > And finally (for now), I don't understand how we have any guarantee that
> > > step (2) is useful. Even if we've already started the LTSSM in (0), we
> > > have no idea if the link is actually Active by the time we hit (2), and
> > > so rescanning may not actually discover the device. And if that scan
> > > fails ... then when do we trigger another pci_rescan_bus()? Only if the
> > > implementation has a "link-up" IRQ?
> > > 
> > 
> > As I said above, we do not enumerate the device if it has devicetree node with
> > supplies. So that's why we need (2). Otherwise, the device won't be enumerated
> > at all, unless userspace does the rescan (which defeats the purpose of pwrctrl).
> 
> But you haven't addressed one of the concerns in my paragraph: how do we
> know the link is up by the time we hit the pwrctrl-initiated
> pci_rescan_bus()? We haven't gone back to ask the host bridge if it's up
> yet. We're just hoping we get lucky.
> 
> IOW, the pwrctl sequence should be something like:
> 
>  (1) power up the slot
>  (1)(a) delay, per spec
>  (1)(b) deassert PERST#
>  (1)(c) wait for link up
>  (2) rescan bus
> 
> Currently, we skip all of (1)(a)-(c). We're probably lucky that (1)(b)'s
> ordering doesn't matter all the time, as long as we did it earlier. And
> we're lucky that there are natural delays in software such that lack of
> (1)(a) and (1)(c) aren't significant.
> 

Let me go back to the drawing board and come up with a proposal. There are
atleast a couple of ways to fix this issue and I need to pick a less intrusive
one.

Thanks for reporting it, appreciated!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

