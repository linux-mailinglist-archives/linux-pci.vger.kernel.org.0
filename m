Return-Path: <linux-pci+bounces-25893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46CAEA89022
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 01:24:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 750267A8509
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 23:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB0F11FAC34;
	Mon, 14 Apr 2025 23:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iJ5U/Ach"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99341DE3BB
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 23:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744673084; cv=none; b=HAPuvVWqQdmOAGmn0NpsQEKwQSGG7xHWDW2yfC0Bwt1fq5Me2p0iZD8e8nBipRjC61wBzpPdD2avIJKLyeZ4wMD9C7y2OID8vLQtYEeGAw9IjPFBWXmRfWSmS7pDDdXbL17Tk2B9A8mtOMmjM/rpJaknY7sCOu5DxyX/sbjMdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744673084; c=relaxed/simple;
	bh=DrK5sCN0Djm7yYzGeu8GBMoAVw0bKeH9pnhbd8Jhi+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H3ZW87G4wOZvNa+eVfUR7/SfAyPbpt1ooLA3fVy17+ll/zFcTuELRgGgsNzy2Gj4pVgf9vb0VtMw0K6J9qh5nK8VSm55yqfuF/blktJSJFzEVSxgx+Wzg8sXE9sJfXk4WLNzY9KgsFdi4q8oRBBeKls58cwJ02s/zetzMrnoCv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iJ5U/Ach; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7376dd56f60so3300324b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 16:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1744673081; x=1745277881; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CnRjpXKt5up+IzlTcWQL0PBVW3Sar0P9RT7q5iNBMeE=;
        b=iJ5U/AchbBYKr6PIJpWdw72smQGOmLtNiz6pMxHJyKiyLJdjGa1P7HcN1Urupj1nRO
         3yMiDtKLVOfelv1/qTRfEAxyqQSvXDXLkr4wG5wPO9tk/v4JLDWJv0iqCXnCGDoDiFu8
         Rvexa+nySvFxsAHLV1lskJ+76eCQRL1gzuDrI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744673081; x=1745277881;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CnRjpXKt5up+IzlTcWQL0PBVW3Sar0P9RT7q5iNBMeE=;
        b=XmkZqAECxFewxM05hYZjf670dzwKcozKs41d9IMyE2+4UQ4ErCJTVlbFBr9IP7JYNM
         RpyZT2KaAdMBRbdLJb9xWyrPB8Czyy0GEowzhjzP1yhiaWOci0Zj5LxiXi03syrOGsmx
         vVclCmm8LFplGOlTppVE8Hdz/cNWvS9/EXBfYnlXTZahQ1n5xU9zwJzAXsusjinG9Dfq
         SY6/ExeXTylsyW2c+FCuQdr8s5dWCZvWx8PL7wzB3GiX4wLudYUtKgUvpHH9R6LiRsQ6
         unBFv7YdWQpURN/HVU39+dIh6nykpMslq0aFaKCiWKW3y3iWT+jAYwaQig6V+zr0BJxy
         zrxw==
X-Forwarded-Encrypted: i=1; AJvYcCWE3+TxZPfxkGJmO4xBzIpbj8AuZW1OnrDNZSocHe0CUg41AjKI/MOPY6W+jIZlTaZvr0xGREDDjrY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzi43Jxf562P7H1xWZ2qfXVcRnmJ5Lt5QVPTg8g32+2Zdg7boPs
	VpKuJku+GuMIWkBP8VX996FAtMRbgWp1ib0Sy+DCkdOiMFK3vmej2qOwCx5jOg==
X-Gm-Gg: ASbGncvdYkMjxm3SkS7dB5446HITOoOgQ+REycj/pwIJgzotf9m2sl2GexBX3VAQW40
	MORYaE1mdxwHjy/sQHcSbawRmyfH2Tn9zl/BsfGfEa+Qm/d6rLQPv25fN6mFERO0CrK0+E8s3ch
	PTcP8ZyyPIoz2PyOaxzcBTYhMm/RHqh5GqB5F2DR4146JZfk8uSgaYaGOzQvapr30vKB+0To/TA
	VxKrzn/mplO7r4VpzqXyEcpdjsRdVd12D9/ap2wx90+SsZqVYQORe9Uie0m0BJJa4t8NBYwZYHr
	BEuCYspqqCxFOgQxpmL2RHmDugvEBRBJqNU03I8u67FCL1wuJe+xbJQE1p1TE8yoLb7k8e8noyD
	m0A==
X-Google-Smtp-Source: AGHT+IEvnVP59BXuKQI6FEom+2qVwz80oGIq0KRPOTQ1u7+ypWxWVkcsX7qw8fSjcwcyyGre4bIIiA==
X-Received: by 2002:a05:6a00:3901:b0:736:4d44:8b77 with SMTP id d2e1a72fcca58-73bd11e210emr22785720b3a.8.1744673080820;
        Mon, 14 Apr 2025 16:24:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:cfd0:cb73:1c0:728a])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-73bd230ddaasm7404870b3a.138.2025.04.14.16.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Apr 2025 16:24:40 -0700 (PDT)
Date: Mon, 14 Apr 2025 16:24:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	dmitry.baryshkov@linaro.org, Tsai Sung-Fu <danielsftsai@google.com>
Subject: Re: [RFC] PCI: pwrctrl and link-up dependencies
Message-ID: <Z_2ZNuJsDr0lDjbo@google.com>
References: <Z_WAKDjIeOjlghVs@google.com>
 <vfjh3xzfhwoppcaxlov5bcmkfngyf6no4zyrgexlcxpfajsw2t@o5nbfcep3auz>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <vfjh3xzfhwoppcaxlov5bcmkfngyf6no4zyrgexlcxpfajsw2t@o5nbfcep3auz>

Hi Manivannan,

On Mon, Apr 14, 2025 at 04:27:35PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Apr 08, 2025 at 12:59:36PM -0700, Brian Norris wrote:
> > TL;DR: PCIe link-up may depend on pwrctrl; however, link-startup is
> > often run before pwrctrl gets involved. I'm exploring options to resolve
> > this.
> > 
> > Hi all,
> > 
> > I'm currently looking at reworking how some (currently out-of-tree, but I'm
> > hoping to change that) pcie-designware based drivers integrate power sequencing
> > for their endpoint devices, as well as the corresponding start_link()
> > functionality.
> > 
> > For power sequencing, drivers/pci/pwrctrl/ looks like a very good start at what
> > we need, since we have various device-specific regulators, GPIOs, and
> > sequencing requirements, which we'd prefer not to encode directly in the
> > controller driver.
> > 
> 
> The naming is a bit confusing,

+1

> but power sequencing and power control are two
> different yet related drivers. Power sequencing drivers
> (drivers/power/sequencing) are targeted towards devices having complex resource
> topology and often accessed by more than one drivers. Like the WiFI + BT combo
> PCIe cards. On the other hand, power control (drivers/pci/pwrctrl) drivers are
> used to control power to the PCIe slots/cards having simple resource topology.

Sure, I get the difference. There can be "sequencing" in the pwrctrl
area too though, because there can be PMICs involved even in a single
PCIe device (i.e., non-shared, not needing "pwrseq" framework) which
require multiple steps (e.g., 2 GPIOs) to power up. Apologies if my
mention of "sequencing" is unclear, but I believe everything I'm
concerned about is in pwrctrl not pwrseq.

> > For link startup, pcie-designware-host.c currently
> > (a) starts the link via platform-specific means (dw_pcie::ops::start_link()) and
> > (b) waits for the link training to complete.
> > 
> > However, (b) will fail if the other end of the link is not powered up --
> > e.g., if the appropriate pwrctrl driver has not yet loaded, or its
> > device hasn't finished probing. Today, this can mean the designware
> > driver will either fail to probe,
> 
> This is not correct.

That depends on the implementation of start_link(). But I suppose the
intention is that start_link() only "starts" and doesn't care where
things go from there. (IOW, my local start_link() implementation is
probably wrong at the moment, as it performs some poll/retry steps too.)

> DWC driver will start LTSSM and wait for the link to be up
> if the platform has no way of detecting link up. But it will not fail if the
> link doesn't come up. It will just continue hoping for the link to come up
> later. LTSSM would be in Detect.Quiet/Active state till a link partner is found:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-designware-host.c#n558

I'd still consider logging an error a failure of sorts though, even if
we don't fail the probe().

> > or at least waste time for a condition
> > that we can't achieve (link up), depending on the HW/driver
> > implementation.
> > 
> 
> Unfortunately we cannot avoid this waiting time as we don't know if a device is
> attached to the bus or not. The 1s wait time predates my involvement with DWC
> drivers.

I don't really love that answer. It means that any DWC-based platform
that needs pwrctrl and doesn't set use_link_irq==true will waste 1
second per PCIe controller. While it's hard to make guarantees about old
and/or unloved drivers, I'd like to think I can do better on new ones.

> > I'm wondering how any designware-based platforms (on which I believe pwrctrl
> > was developed) actually support this, and how I should look to integrate
> > additional platforms/drivers. From what I can tell, the only way things would
> > work today would either be if:
> > (1) a given platform uses the dw_pcie_rp::use_linkup_irq==true functionality,
> >     which means pcie-designware-host will only start the link, but not wait for
> >     training to succeed. (And presumably the controller will receive its
> >     link-up IRQ after power sequencing is done, at which point both pwrctrl and
> >     the IRQ may rescan the PCI bus.) Or:
> > (2) pci/pwrctrl sequencing only brings up some non-critical power rails for the
> >     device in question, so link-up can actually succeed even without
> >     pwrctrl.
> > 
> 
> Again, failing to detect link up will not fail the probe. I don't know how you
> derived this conclusion. Even the PCIe spec itself is clear that the link should
> stay in Detect.Quiet until it has found the link partner. So failing the probe
> means we are introducing a dependency on the devices which would be bizarre.
> Imagine how a controller will end up supporting hotplug.

I think you're over-fixating on my mention of probe failure. Consider
the lesser statement that was paired along with it: always wasting 1
second per controller polling for something that will never happen. It
feels backwards and wasteful.

One of my key questions: if I don't have a link-up IRQ, how can I avoid
this waste? pcie-brcmstb avoids that waste today (for the common case
where there is, in fact, a device connected), and it would be a
regression for it to start using pwrctrl tomorrow.

(Side note: I also just noticed pcie-tegra194.c does the same.)

> > My guess is that (1) is the case, and specifically that the relevant folks are
> > using the pcie-qcom.c, with its "global" IRQ used for link-up events.
> > 
> 
> We only recently added support for 'Link Up' event through 'global_irq' in the
> controller driver. And this was done to avoid waiting for link up during probe

You're kind of reinforcing my question: you don't like the waste, so
you're adding link-up IRQ support -- is that really the only way?

(My initial thought: no, it's not. We know when pwrctrl has done its
thing -- why should we bother polling for link state before that? But
that's easier said than done, when pwrctrl is optional and highly
abstracted away from the DWC driver...)

> (which is what you/your colleagues also want to avoid I believe). But the
> problem in your case is that you are completely skipping the LTSSM and relying
> on custom userspace tooling to bring up the device and start LTSSM once done.

I assume you're talking about this thread:
https://lore.kernel.org/linux-pci/20240112093006.2832105-1-ajayagarwal@google.com/
[PATCH v5] PCI: dwc: Wait for link up only if link is started

I'm very aware of that thread, and the userspace tooling that underlies
it. I also am well aware that this is not how upstream should work, and
that's really why I'm here at all -- I'm trying to rewrite how we do
things, including our link-up and PMIC strategy.

So yes, that thread does provide some historical context for where I am,
but no, it doesn't really describe what I'm doing or asking about today.

> > Would it make sense to introduce some sort of pwrctrl -> start_link()
> > dependency? For example, I see similar work done in this series [1], for
> > slightly different reasons. In short, that series adds new
> > pci_ops::{start,stop}_link() callbacks, and teaches a single pwrctrl driver to
> > stop and restart the bridge link before/after powering things up.
> > 
> 
> This switch has a crazy requirement for configuring it through I2C. The I2C
> configuration has to be done before starting LTSSM. So we disable LTSSM first
> since it was enabled way before, then do I2C config and then start LTSSM again.

OK, thanks for the notice.

> > I also see that Manivannan has a proposal out [2] to add semi-generic
> > link-down + retraining support to core code. It treads somewhat similar
> > ground, and I could even imagine that its pci_ops::retrain_link()
> > callback could even be reimplemented in terms of the aforementioned
> > pci_ops::{start,stop}_link(), or possibly vice versa.
> > 
> 
> Retrain work is mostly to bring up a broken link, which is completely different
> from what you are trying to achieve.

OK. Thanks for the clarification.

One reason I highlight these patch sets is because they add more cases
of "PCI core" to "host bridge/controller driver" dependencies
specifically around link management, which otherwise has very little
precedent. I wasn't sure if that was by requirement, or simply because
people haven't tried to support these things.

> > Any thoughts here? Sorry for a lot of text and no patch, but I didn't just want
> > to start off by throwing a 3rd set of patches on top of the existing ones that
> > tread similar ground[1][2].
> > 
> 
> No problem. If you want to use pwrctrl in your platform and get rid of the
> custom userspace tooling, I'm all in for it. But for that, I need to understand
> your controller design first. All I heard so far is, "we want to skip LTSSM and
> let our tool take care of it".

Please consider that last sentence "dead" or "totally not any plan of
record." It may be how we do things privately today, but it's not
anything I expect the upstream community to even think about. (Feel free
to CC me if it comes up again. It's hard for me to speak for everyone at
my employer, but I can probably convince them it's a bad idea if
needed.)

Regarding the controller design: frankly, I don't think my controller
does anything all that revolutionary in this space [0]. All of my
questions today can be asked (from what I can tell) of existing upstream
controller drivers. I'm mostly trying to understand the expected driver
design here, and that includes teasing apart what is "stuff done in
'old' drivers, but isn't recommended", and "what is currently
unimplemented in new stuff" (like pwrctrl [1]), and where do my
expectations fit in between that.

For instance, poking around a bit I come up with this question: when
using pci/pwrctrl, how does one ensure timing requirements around, e.g.,
power stability vs PERST# deassertion are met? When looking at a pwrctrl
driver like drivers/pci/pwrctrl/slot.c, the process looks too simple:

(0) host bridge probably already started its LTSSM, deasserted PERST#
(1) slot.c powers the slot
(2) pci_pwrctrl_device_set_ready() -> rescan_work_func() rescans the bus

Notably, there's no enforced delay between (1) and (2).

Reading the PCIe CEM, it seems we're violating some specification bits,
like:

  2.2. PERST# Signal
  [...] On power-up, the de-assertion of PERST# is delayed 100 ms
  (TPVPERL) from the power rails achieving specified operating limits.
  [...]

There are references to this in various implementations (e.g.,
tegra_pcie_enable_slot_regulators() and brcm_pcie_start_link() --
although I suspect the latter is applying the wrong ordering).

Additionaly, CEM also seems to suggest we have PERST# ordering wrong. It
should also come between (1) and (2), not at (0).

And finally (for now), I don't understand how we have any guarantee that
step (2) is useful. Even if we've already started the LTSSM in (0), we
have no idea if the link is actually Active by the time we hit (2), and
so rescanning may not actually discover the device. And if that scan
fails ... then when do we trigger another pci_rescan_bus()? Only if the
implementation has a "link-up" IRQ?

Unless I'm misunderstanding, these concerns all suggest we need some
host-bridge hook in between (1) and (2), and existing pwrctrl users are
operating somewhat outside the specification, or are relying on
something more subtle that I'm missing.

Regards,
Brian

[0] That's not to dodge your question. I can try to describe relevant
    details if they would help. But I don't think they would right now.

[1] And if I were to propose my driver upstream eventually, I bet you
    wouldn't want me reimplementing pwrctrl in my driver, just because
    pwrctrl is missing features AFAICT.

