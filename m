Return-Path: <linux-pci+bounces-31988-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2AB0298A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 08:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F51F1BC37B0
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 06:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CFF200BA1;
	Sat, 12 Jul 2025 06:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k5gyPcv4"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639E92A8C1;
	Sat, 12 Jul 2025 06:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752300410; cv=none; b=VRFdtUqcDFSYOP09tdoBsfz3W7LORE0jMaFqF8YK8DhbMaVnJ4pkMfQTV7oJmpw4siF5D7LwFUtFWtDSS7tzypajaINPWD8ifponsFY9wc5hk6B6J/WkRTocm3UObLbdGWX1H6aCvlxmpYodqiAdYTBUg3TvA31LIT6JlmAi9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752300410; c=relaxed/simple;
	bh=Pj2+Mf6ySJm9B6A0tlW9JzZnu0lIjQkDWpiuO8IR1fo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTcl/53c316DO//YIpGql8t5EkPJcVdbB9v7pzmS8bJkSxdTwzd28UgDZ99Qz2QRD/YEmETkp533NfeRGKeRD+am7LsFKfCYKLYwJ8zDuHzndGJ/aHX9t7G8Mnm4CK7nft/9X/6FFtTpUGmCtWr0up4R+wbJFzTSrsskx1b4t/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k5gyPcv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7BC1C4CEEF;
	Sat, 12 Jul 2025 06:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752300409;
	bh=Pj2+Mf6ySJm9B6A0tlW9JzZnu0lIjQkDWpiuO8IR1fo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k5gyPcv4D7BsHC5mVFyOp/kw3AZQ4vsfYywRBT2K0j+MJhQdhZtk4cAGkMNYX0k8z
	 Ln+hOdGnPdB7l30BUNJqJwwdVS56o/AhEsRN88W6jxrY7L+ZtPyyJ72Lu2tMhb4eBu
	 jkFRyZrx+pZMSbpm8QMcn42AY/lmBMnEh9lbw9M7fJvQwKZ4E+fG+xDMijr6GXXvvh
	 RHL89kt/cIdWkgsN2AhCzaTMPR3KlO2VCnb8oYYbyjbnBGNLfXB07IWbYrbK3ZGnqg
	 7f3Ia80ttTaKNV/kOWIFvk9vtBEn6S6c0yFE+XavHMPaqYJjo6z6SfFPDHHgWMOLGM
	 G/U1yi3kvD95w==
Date: Sat, 12 Jul 2025 11:36:40 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Brian Norris <briannorris@chromium.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 0/3] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# GPIO if available
Message-ID: <ga3jrhlgjiyhbxu75ockavatday3fcmfckybqeqqxljt4pevxk@wiwyvfwh7kgc>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <aG3IWdZIhnk01t2A@google.com>
 <kj6kilhjynygioxyo7iogvgwqbr7tluryir3f7vqeowk6wd6qn@sop5ubotfcug>
 <aHGmllch_efdWgsW@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHGmllch_efdWgsW@google.com>

On Fri, Jul 11, 2025 at 05:04:38PM GMT, Brian Norris wrote:
> Hi,
> 
> On Wed, Jul 09, 2025 at 12:18:29PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jul 08, 2025 at 06:39:37PM GMT, Brian Norris wrote:
> > > On Mon, Jul 07, 2025 at 11:48:37PM +0530, Manivannan Sadhasivam wrote:
> > > > Hi,
> > > > 
> > > > This series is an RFC to propose pwrctrl framework to control the PERST# GPIO
> > > > instead of letting the controller drivers to do so (which is a mistake btw).
> > > > 
> > > > Right now, the pwrctrl framework is controlling the power supplies to the
> > > > components (endpoints and such), but it is not controlling PERST#. This was
> > > > pointed out by Brian during a related conversation [1]. But we cannot just move
> > > > the PERST# control from controller drivers due to the following reasons:
> > > > 
> > > > 1. Most of the controller drivers need to assert PERST# during the controller
> > > > initialization sequence. This is mostly as per their hardware reference manual
> > > > and should not be changed.
> > > > 
> > > > 2. Controller drivers still need to toggle PERST# when pwrctrl is not used i.e.,
> > > > when the power supplies are not accurately described in PCI DT node. This can
> > > > happen on unsupported platforms and also for platforms with legacy DTs.
> > > > 
> > > > For this reason, I've kept the PERST# retrieval logic in the controller drivers
> > > > and just passed the gpio descriptors (for each slot) to the pwrctrl framework.
> > > 
> > > How sure are we that GPIOs (and *only* GPIOs) are sufficient for this
> > > feature? I've seen a few drivers that pair a GPIO with some kind of
> > > "internal" reset too, and it's not always clear that they can/should be
> > > operated separately.
> > > 
> > > For example, drivers/pci/controller/dwc/pci-imx6.c /
> > > imx_pcie_{,de}assert_core_reset(), and pcie-tegra194.c's
> > > APPL_PINMUX_PEX_RST. The tegra case especially seems pretty clear that
> > > its non-GPIO "pex_rst" is resetting an endpoint.
> > > 
> > 
> > Right. But GPIO is the most commonly used approach for implementing PERST# and
> > it is the one supported on the platform I'm testing with. So I just went with
> > that. For sure there are other methods exist and the PCIe spec itself doesn't
> > define how PERST# should be implemented in a form factor. It merely defines
> > PERST# as an 'auxiliary signal'. So yes, other form of PERST# can exist. But for
> > the sake of keeping this proposal simple, I'm considering only GPIO based
> > PERST# atm.
> 
> Hmm, OK. A simple start is fine, but I'm pointing out this will quickly
> show its limitations.
> 

I don't disagree :)

> > Also, Tegra platforms are not converted to use pwrctrl framework and I don't
> > know if the platform maintainers are interested in it or not. But if they start
> > using it, we can tackle this situation by introducing a callback that
> > asserts/deasserts PERST# (yes, callbacks are evil, but I don't know any other
> > sensible way to support vendor specific PERST# implementations).
> 
> IMO, it's pretty fair game to at least account for things people are
> doing in upstream drivers today, even if they aren't wholly ready to
> adopt the new thing. It's harder to gain new users when you actively
> don't support things you know the users need.
> 
> > Oh and do take a look at pcie-brcmstb driver, which I promised to move to
> > pwrctrl framework for another reason. It uses multiple callbacks per SoC
> > revisions for toggling PERST#. So for these usecases, having a callback in
> > 'struct pci_host_bridge' would be a good fit and I may introduce it after this
> > series gets in.
> 
> Sure. I think there are plenty of drivers that will need it. And that's
> why I brought it up.
> 
> But if that's a "phase 2" thing, so be it.
> 
> > > > This will allow both the controller drivers and pwrctrl framework to share the
> > > > PERST# (which is ugly but can't be avoided). But care must be taken to ensure
> > > > that the controller drivers only assert PERST# and not deassert when pwrctrl is
> > > > used. I've added the change for the Qcom driver as a reference. The Qcom driver
> > > > is a slight mess because, it now has to support both new DT binding (PERST# and
> > > > PHY in Root Port node) and legacy (both in Host Bridge node). So I've allowed
> > > > the PERST# control only for the new binding (which is always going to use
> > > > pwrctrl framework to control the component supplies).
> > > > 
> > > > Testing
> > > > =======
> > > > 
> > > > This series is tested on Lenovo Thinkpad T14s laptop (with out-of-tree patch
> > > > enabling PCIe WLAN card) and on RB3 Gen2 with TC9563 switch (also with the not
> > > > yet merged series [2]). A big take away from this series is that, it is now
> > > > possible to get rid of the controversial {start/stop}_link() callback proposed
> > > > in the above mentioned switch pwrctrl driver [3].
> > > 
> > > This is a tiny bit tangential to the PERST# discussion, but I believe
> > > there are other controller driver features that don't fit into the
> > > sequence model of:
> > > 
> > > 1. start LTSSM (controller driver)
> > > 2. pwrctrl eventually turns on power + delay per spec
> > > 3. pwrctrl deasserts PERST#
> > > 4. pwrctrl delays a fixed amount of time, per the CEM spec
> > > 5. pwrctrl rescans bus
> > > 
> > > For example, tegra_pcie_dw_start_link() notes some cases where it needs
> > > to take action and retry when the link doesn't come up. Similarly, I've
> > > seen drivers with retry loops for cases where the link comes up, but not
> > > at the expected link rate. None of this is possible if the controller
> > > driver only gets to take care of #1, and has no involvement in between
> > > #3 and #5.
> > > 
> > 
> > Having this back and forth communication would make the pwrctrl driver a lot
> > messier. But I believe, we could teach pwrctrl driver to detect link up (similar
> > to dw_pcie_wait_for_link()) and if link didn't come up, it could do retry and
> > other steps with help from controller drivers. But these things should be
> > implemented only when platforms like Tegra start to show some love towards
> > pwrctrl.
> 
> Never mind the lack of love you feel here :)
> But I'm actively looking at drivers that don't yet fit into what pwrctrl
> supports, and I'd like them to use pwrctrl someday instead of
> reinventing the wheel.
> 

I'm not against supporting these controller drivers/platforms in pwrctrl. It's
just that I do not want to implement solutions now without having users. But I'm
glad that you are bringing these up. I'm adding these to my pwrctrl/todo list.

> You're arguing against more callbacks, and start_link()-like
> functionality, but I'm pretty sure some of these things are necessities,
> if you're trying to abstract power control away from controller drivers.
> 

Well, that's my personal preference. These days I feel (mostly after spending my
time as a maintainer of PCI controller drivers) that callbacks are evil and they
pay way for 'midlayers'. But having said that, I myself implemented callbacks
whereever I felt that no other options were possible. And here also, I'm just
claiming that this series avoids the '{start/stop}_link' callbacks which was
hated by many (including me) as it ties the Qcom switch driver implementing
these callbacks to be tied to a specific platform.

> Again, maybe this is a problem to be solved later. But I think you're
> kidding yourself that pwrctrl is ready as-is, and that you can avoid
> these kinds of callbacks.
> 

No, I never claimed that pwrctrl is perfect and it would solve all the PCI power
issues. But I'm happy that it atleast solves a couple of issues and allows me to
address the rest of them. We had been talking about a framework like this for
several years without any upstream solution. But now we finally have one and I'm
merely trying to make use of it to address issues.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

