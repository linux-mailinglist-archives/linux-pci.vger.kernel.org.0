Return-Path: <linux-pci+bounces-25901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A131A89365
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 07:32:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B94E43AFE3A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 05:32:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE42019992D;
	Tue, 15 Apr 2025 05:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MSHpMjwy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2C02AEF1
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 05:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744695145; cv=none; b=lgbIPbU86PIN85JcZWK2dV0c4ct/L9+jMSVVgQDAyqu2dIIVEizR9tE4Kij3MG0bi+azJ8ObpbucI6jiPMoHjtXNusX3zHptlOQLzDL+FOuGH5S6pGQuseqRrQzg82N4QvWYUXZRMPzbbh22zUywe9B1m1LiYzBWZXE76UWDpoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744695145; c=relaxed/simple;
	bh=kSOq37P8NXFIkk79o+1Iypi8cLk30+DmlNv7LdKq0QE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kqD38EFoBDd/ATRx64athWFBB5SDEqYZ1ghNCDxQHeXz0ahY3i/NLSnDlyItU7FVc3xAKLUO4FS5vxGYGo2fPmolr9dfzZ1A3/h2+onVq0bh8nCU0F2mrZDeiSJxETM5xml/uhP7U/+0d3s7G8zKKIz9MHQBobSC4QtXEf0r6NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MSHpMjwy; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so4456613b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 22:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744695143; x=1745299943; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=eiCmHwvjD4j/IPAdFIy+Ayuaxo2551JBqloA2gvIcww=;
        b=MSHpMjwy43Fditu34330lbMjOTjyAhzjVZ5gmXdhsTcfE5W5sAmIPU4dloxahiKftZ
         JCecU3UGigmN4yDqQjyzd7sLjKKMqNkLRvdj0j2I6y32ofr7vFummd88IOudYaXR2Ied
         fI4yzA0ccr+Qq+DAgwgZarQ+qDIkWdW5C/rM2Dnk/HagzgDYjKZBzIk5mjeHPrG9Urif
         aXfG9CD4Q9K4LhxYtkmE9hQFrRAA3JjEN2TfS3XclINlm96e8+L23TBmMEmTyWpO9ewt
         3Hvd7vHGFU/swgq+PofNTpdV7xdYTehfFTjHMIPmr2XvmXD8Plxn9rMXhaOZpvLsejJv
         wJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744695143; x=1745299943;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eiCmHwvjD4j/IPAdFIy+Ayuaxo2551JBqloA2gvIcww=;
        b=BlTEsNzKUlr2scTbz0O5FkCZd7iDGGud6a6JXZQrVmg61xTOqwKbBNy/DJYc5wx6xs
         uepMlt/ofOhuYqtYq1VBbMIVXvQU+ocbGV9I2Ti9lj753SAd+P82ls3HICXNYn7iSkIy
         X6Tjqd6wHJgDHS1CiB/IsyzrWyGzONsvQ3cO8nD4UNQYBf+g959/GyFrqMgwZDcG1Ayh
         ih3F8p2odXLzHzEv/Z2sUKMspi1SLQzHUj51y61gH+TkDwB4XZ1FzIM5cY1SL2Al75DX
         nGgFyX5gkVLho9LtW/bYEdS4SNRr/8XAgzq2NGaBYQIB2wJfDHv3h8xiy+5/klhMwujo
         lNfw==
X-Forwarded-Encrypted: i=1; AJvYcCWmThPD+9lBVQ9BelkMHRKIjOIa/sgaXK4g1CltmvD2Wwx6pd+TpZbllLHov9ujBZQV8hQwTEU2RrM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwEBgei4qcpp+iDTnnN6kqFTBvl96wtYhMR/ptkRVSz/Syy+Wi
	jmGqf9uGrpXQxMGNa5y977HP30FbRqohOyyuwYNHbgEEs48pS63yL98wtgnVEQ==
X-Gm-Gg: ASbGnctI7bE/F8LFHrV5+7rry8o7MsnueR8cf2tkQ4SnEI9y8d74P4/Ir6tpdhBoNtd
	aob14HKGZR7wKNv6m8DXoKz0HJmp7X/F9W3341tP0MVALxxGSx2efSbM2TRg8v4ZdDEqpXZ6zC2
	BAc3vl5C7xBOyZzMhjzNZ3naq4HC4xSTOzryQVRtCSouJ2nLIh/2uUjcXFlThaUzEoQJM6Ee5UI
	TDfjxqjgnZaHDQNfBieyAaHdtcvpQ0CG/xUd62fT7J2YQ3AQ0nfK+8bf0sd43AV5FWShBBKCYEM
	Pw9xVfpNpc7rVsqkvWSTaoa8hWYI9kbQcqkcZd1hXlwZvIrZ1Q==
X-Google-Smtp-Source: AGHT+IFce4/cJdYToN86yQyneVgZwqH3FlljPaPzu537+JXKWid7iSANB7gzTxBBRjex4IDt8ACouw==
X-Received: by 2002:a05:6a21:4006:b0:1f5:64a4:aeac with SMTP id adf61e73a8af0-20179972e9fmr21282269637.33.1744695142742;
        Mon, 14 Apr 2025 22:32:22 -0700 (PDT)
Received: from thinkpad ([120.60.71.35])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a08183e2sm10179676a12.5.2025.04.14.22.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Apr 2025 22:32:22 -0700 (PDT)
Date: Tue, 15 Apr 2025 11:02:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, dmitry.baryshkov@linaro.org, 
	Tsai Sung-Fu <danielsftsai@google.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <4pwigzf7q6abyntt4opjv6lnvkdulyejr73efnud2cvltskgt2@tjs2k5tiwyvc>
References: <Z_WAKDjIeOjlghVs@google.com>
 <vfjh3xzfhwoppcaxlov5bcmkfngyf6no4zyrgexlcxpfajsw2t@o5nbfcep3auz>
 <Z_2ZNuJsDr0lDjbo@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z_2ZNuJsDr0lDjbo@google.com>

On Mon, Apr 14, 2025 at 04:24:38PM -0700, Brian Norris wrote:
> Hi Manivannan,
> 
> On Mon, Apr 14, 2025 at 04:27:35PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Apr 08, 2025 at 12:59:36PM -0700, Brian Norris wrote:
> > > TL;DR: PCIe link-up may depend on pwrctrl; however, link-startup is
> > > often run before pwrctrl gets involved. I'm exploring options to resolve
> > > this.
> > > 
> > > Hi all,
> > > 
> > > I'm currently looking at reworking how some (currently out-of-tree, but I'm
> > > hoping to change that) pcie-designware based drivers integrate power sequencing
> > > for their endpoint devices, as well as the corresponding start_link()
> > > functionality.
> > > 
> > > For power sequencing, drivers/pci/pwrctrl/ looks like a very good start at what
> > > we need, since we have various device-specific regulators, GPIOs, and
> > > sequencing requirements, which we'd prefer not to encode directly in the
> > > controller driver.
> > > 
> > 
> > The naming is a bit confusing,
> 
> +1
> 
> > but power sequencing and power control are two
> > different yet related drivers. Power sequencing drivers
> > (drivers/power/sequencing) are targeted towards devices having complex resource
> > topology and often accessed by more than one drivers. Like the WiFI + BT combo
> > PCIe cards. On the other hand, power control (drivers/pci/pwrctrl) drivers are
> > used to control power to the PCIe slots/cards having simple resource topology.
> 
> Sure, I get the difference. There can be "sequencing" in the pwrctrl
> area too though, because there can be PMICs involved even in a single
> PCIe device (i.e., non-shared, not needing "pwrseq" framework) which
> require multiple steps (e.g., 2 GPIOs) to power up. Apologies if my
> mention of "sequencing" is unclear, but I believe everything I'm
> concerned about is in pwrctrl not pwrseq.
> 

Right.

> > > For link startup, pcie-designware-host.c currently
> > > (a) starts the link via platform-specific means (dw_pcie::ops::start_link()) and
> > > (b) waits for the link training to complete.
> > > 
> > > However, (b) will fail if the other end of the link is not powered up --
> > > e.g., if the appropriate pwrctrl driver has not yet loaded, or its
> > > device hasn't finished probing. Today, this can mean the designware
> > > driver will either fail to probe,
> > 
> > This is not correct.
> 
> That depends on the implementation of start_link(). But I suppose the
> intention is that start_link() only "starts" and doesn't care where
> things go from there. (IOW, my local start_link() implementation is
> probably wrong at the moment, as it performs some poll/retry steps too.)
> 

Yes, that's why I said it was incorrect. The callback is supposed to just start
the link and not wait for anything else.

> > DWC driver will start LTSSM and wait for the link to be up
> > if the platform has no way of detecting link up. But it will not fail if the
> > link doesn't come up. It will just continue hoping for the link to come up
> > later. LTSSM would be in Detect.Quiet/Active state till a link partner is found:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n558
> 
> I'd still consider logging an error a failure of sorts though, even if
> we don't fail the probe().
> 

We do print the log now. Infact it is dev_info():

"Phy link never came up"

> > > or at least waste time for a condition
> > > that we can't achieve (link up), depending on the HW/driver
> > > implementation.
> > > 
> > 
> > Unfortunately we cannot avoid this waiting time as we don't know if a device is
> > attached to the bus or not. The 1s wait time predates my involvement with DWC
> > drivers.
> 
> I don't really love that answer. It means that any DWC-based platform
> that needs pwrctrl and doesn't set use_link_irq==true will waste 1
> second per PCIe controller. While it's hard to make guarantees about old
> and/or unloved drivers, I'd like to think I can do better on new ones.
> 

Even I'd like to avoid the 1s delay. But the problem is how would you know if
the device is attached to the bus or not. The delay is to account for the fact
that the link may take up to 1s to come up post starting LTSSM. So if we do not
wait for that period, there is a chance that we would report the false negative
status and also the enumeration would fail.

> > > I'm wondering how any designware-based platforms (on which I believe pwrctrl
> > > was developed) actually support this, and how I should look to integrate
> > > additional platforms/drivers. From what I can tell, the only way things would
> > > work today would either be if:
> > > (1) a given platform uses the dw_pcie_rp::use_linkup_irq==true functionality,
> > >     which means pcie-designware-host will only start the link, but not wait for
> > >     training to succeed. (And presumably the controller will receive its
> > >     link-up IRQ after power sequencing is done, at which point both pwrctrl and
> > >     the IRQ may rescan the PCI bus.) Or:
> > > (2) pci/pwrctrl sequencing only brings up some non-critical power rails for the
> > >     device in question, so link-up can actually succeed even without
> > >     pwrctrl.
> > > 
> > 
> > Again, failing to detect link up will not fail the probe. I don't know how you
> > derived this conclusion. Even the PCIe spec itself is clear that the link should
> > stay in Detect.Quiet until it has found the link partner. So failing the probe
> > means we are introducing a dependency on the devices which would be bizarre.
> > Imagine how a controller will end up supporting hotplug.
> 
> I think you're over-fixating on my mention of probe failure. Consider
> the lesser statement that was paired along with it: always wasting 1
> second per controller polling for something that will never happen. It
> feels backwards and wasteful.
> 

Again, I do get your point. But tell me how can a controller reliably detect
that there is a device attached to the bus. Only on your android setup, you for
sure know that the device won't be there during probe. So you are considering 1s
wait as a wast of time and it is fair. But what if the same controller is used
in another platform which is not android or the endpoint device is powered on
during probe itself without replying on userspace?

> One of my key questions: if I don't have a link-up IRQ, how can I avoid
> this waste? pcie-brcmstb avoids that waste today (for the common case
> where there is, in fact, a device connected), and it would be a
> regression for it to start using pwrctrl tomorrow.
> 

Why are you tying pwrctrl with this designware driver behavior? Both are
unrelated. Even if you don't use pwrctrl and use controller driver to bring up
the device, the 1s delay would be applicable (if there is no device).

pcie-brcmstb driver indeed wastes time. It is not 1s but just 100ms. But that
driver is for only one vendor. In the case of DWC, the driver has to work with
multiple vendors. But again, I do not know how this 1s delay came up. Maybe we
could try to reduce it to 500ms or so, but for that I need confirmation from
someone like Lorenzo who knows the history.

> (Side note: I also just noticed pcie-tegra194.c does the same.)
> 
> > > My guess is that (1) is the case, and specifically that the relevant folks are
> > > using the pcie-qcom.c, with its "global" IRQ used for link-up events.
> > > 
> > 
> > We only recently added support for 'Link Up' event through 'global_irq' in the
> > controller driver. And this was done to avoid waiting for link up during probe
> 
> You're kind of reinforcing my question: you don't like the waste, so
> you're adding link-up IRQ support -- is that really the only way?
> 

I don't know. But so far I haven't seen any other sensible way which is generic.

> (My initial thought: no, it's not. We know when pwrctrl has done its
> thing -- why should we bother polling for link state before that? But
> that's easier said than done, when pwrctrl is optional and highly
> abstracted away from the DWC driver...)
> 

Oh well... this is where you got it wrong. pwrctrl drivers are only probed
before enumeration because of the design (which is way after starting the link).
As of v6.15-rc1, before we try to enumerate any device, we check if there is any
device defined in DT which requires power supply. If so, we create a platform
device (or pwrctrl device) and let the pwrctrl driver to bind to it and power up
the device. In that case, we also do not proceed to scan the bus further and
skip the hierarchy. Because, the pwrctrl driver will rescan the bus once it has
finished powering up the device.

> > (which is what you/your colleagues also want to avoid I believe). But the
> > problem in your case is that you are completely skipping the LTSSM and relying
> > on custom userspace tooling to bring up the device and start LTSSM once done.
> 
> I assume you're talking about this thread:
> https://lore.kernel.org/linux-pci/20240112093006.2832105-1-ajayagarwal@google.com/
> [PATCH v5] PCI: dwc: Wait for link up only if link is started
> 

Yes!

> I'm very aware of that thread, and the userspace tooling that underlies
> it. I also am well aware that this is not how upstream should work, and
> that's really why I'm here at all -- I'm trying to rewrite how we do
> things, including our link-up and PMIC strategy.
> 

I'm really happy to hear this :)

> So yes, that thread does provide some historical context for where I am,
> but no, it doesn't really describe what I'm doing or asking about today.
> 
> > > Would it make sense to introduce some sort of pwrctrl -> start_link()
> > > dependency? For example, I see similar work done in this series [1], for
> > > slightly different reasons. In short, that series adds new
> > > pci_ops::{start,stop}_link() callbacks, and teaches a single pwrctrl driver to
> > > stop and restart the bridge link before/after powering things up.
> > > 
> > 
> > This switch has a crazy requirement for configuring it through I2C. The I2C
> > configuration has to be done before starting LTSSM. So we disable LTSSM first
> > since it was enabled way before, then do I2C config and then start LTSSM again.
> 
> OK, thanks for the notice.
> 
> > > I also see that Manivannan has a proposal out [2] to add semi-generic
> > > link-down + retraining support to core code. It treads somewhat similar
> > > ground, and I could even imagine that its pci_ops::retrain_link()
> > > callback could even be reimplemented in terms of the aforementioned
> > > pci_ops::{start,stop}_link(), or possibly vice versa.
> > > 
> > 
> > Retrain work is mostly to bring up a broken link, which is completely different
> > from what you are trying to achieve.
> 
> OK. Thanks for the clarification.
> 
> One reason I highlight these patch sets is because they add more cases
> of "PCI core" to "host bridge/controller driver" dependencies
> specifically around link management, which otherwise has very little
> precedent. I wasn't sure if that was by requirement, or simply because
> people haven't tried to support these things.
> 

The callbacks are introduced only because of the hardware requirements of the
switch.

> > > Any thoughts here? Sorry for a lot of text and no patch, but I didn't just want
> > > to start off by throwing a 3rd set of patches on top of the existing ones that
> > > tread similar ground[1][2].
> > > 
> > 
> > No problem. If you want to use pwrctrl in your platform and get rid of the
> > custom userspace tooling, I'm all in for it. But for that, I need to understand
> > your controller design first. All I heard so far is, "we want to skip LTSSM and
> > let our tool take care of it".
> 
> Please consider that last sentence "dead" or "totally not any plan of
> record." It may be how we do things privately today, but it's not
> anything I expect the upstream community to even think about. (Feel free
> to CC me if it comes up again. It's hard for me to speak for everyone at
> my employer, but I can probably convince them it's a bad idea if
> needed.)
> 

Sure thing. Thanks for understanding. The thread kept coming once in a while and
I had to repeat everytime why the idea is so bad and won't scale. Finally
someone understood it.

> Regarding the controller design: frankly, I don't think my controller
> does anything all that revolutionary in this space [0]. All of my
> questions today can be asked (from what I can tell) of existing upstream
> controller drivers. I'm mostly trying to understand the expected driver
> design here, and that includes teasing apart what is "stuff done in
> 'old' drivers, but isn't recommended", and "what is currently
> unimplemented in new stuff" (like pwrctrl [1]), and where do my
> expectations fit in between that.
> 
> For instance, poking around a bit I come up with this question: when
> using pci/pwrctrl, how does one ensure timing requirements around, e.g.,
> power stability vs PERST# deassertion are met? When looking at a pwrctrl
> driver like drivers/pci/pwrctrl/slot.c, the process looks too simple:
> 
> (0) host bridge probably already started its LTSSM, deasserted PERST#
> (1) slot.c powers the slot
> (2) pci_pwrctrl_device_set_ready() -> rescan_work_func() rescans the bus
> 
> Notably, there's no enforced delay between (1) and (2).
> 
> Reading the PCIe CEM, it seems we're violating some specification bits,
> like:
> 
>   2.2. PERST# Signal
>   [...] On power-up, the de-assertion of PERST# is delayed 100 ms
>   (TPVPERL) from the power rails achieving specified operating limits.
>   [...]
> 
> There are references to this in various implementations (e.g.,
> tegra_pcie_enable_slot_regulators() and brcm_pcie_start_link() --
> although I suspect the latter is applying the wrong ordering).
> 
> Additionaly, CEM also seems to suggest we have PERST# ordering wrong. It
> should also come between (1) and (2), not at (0).
> 

You are absolutely right! Currently, we follow the timing requirement while
deasserting the PERST# in the controller drivers. But once we power on the slot,
we do not touch PERST# and it just happen to work.

We may need to introduce another callback that toggles PERST# so that we can use
it while powering up the device.

> And finally (for now), I don't understand how we have any guarantee that
> step (2) is useful. Even if we've already started the LTSSM in (0), we
> have no idea if the link is actually Active by the time we hit (2), and
> so rescanning may not actually discover the device. And if that scan
> fails ... then when do we trigger another pci_rescan_bus()? Only if the
> implementation has a "link-up" IRQ?
> 

As I said above, we do not enumerate the device if it has devicetree node with
supplies. So that's why we need (2). Otherwise, the device won't be enumerated
at all, unless userspace does the rescan (which defeats the purpose of pwrctrl).

> Unless I'm misunderstanding, these concerns all suggest we need some
> host-bridge hook in between (1) and (2), and existing pwrctrl users are
> operating somewhat outside the specification, or are relying on
> something more subtle that I'm missing.
> 

Yes, feel free to submit patches for toggling PERST#. Or let me know otherwise,
I'll do it.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

