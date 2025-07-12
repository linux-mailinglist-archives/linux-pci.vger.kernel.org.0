Return-Path: <linux-pci+bounces-31984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A778FB0282D
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 02:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBA7A587046
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 00:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BF03EC5;
	Sat, 12 Jul 2025 00:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a46f38vT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60B52163
	for <linux-pci@vger.kernel.org>; Sat, 12 Jul 2025 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752278682; cv=none; b=mgM4oUzgrADM1azb2tntkxKwIUNhGmq+zU27ZWP5ay9cSHcAtEyxoljJKaQs0c1rzT2gCckSCi5tpMgpD53bbE9WrHY/R967sgIQdU0gLE/SGgkBWQCCle9fULoi8+nHUv3/oz9JqN/6ql8YZ08V58vEbGgm5f+3gzqKZI4n2hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752278682; c=relaxed/simple;
	bh=jafzsM0E22IV2+JJEYJYIABQiygfJD9opNAi7jFor44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UtV/S0kXTHL8tofqzz8vhqOc2WCfZHh4rTxxsZatfJRfEe7Q5P+rwVnbPLNiBNqBppxItf/bJ4yFnI9Jm8zjrFD5uhuiG8JN+0G0Fy+74rrMam4UVPJVrWy4yAqo7nbKVRF/drKgmeDOKG718fhla0fOz82BDqN4XvYsBwZY4Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a46f38vT; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-75001b1bd76so392868b3a.2
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 17:04:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752278681; x=1752883481; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sSDqxMQohw4PhZMvEXwWUzGgcSu1YJU0uLQAkTg86t8=;
        b=a46f38vTFrcv+kJSKC/Da7hT4+0o2Zwnh68tPlswgEaHzU03XkVouKWBv2KQZsCuVi
         KFHZY444lhOmj1/wQES8UYLwGExgZwEwBrLzKQmTvF6k61Xd3jQJYgwxOcD+rX2+4OQB
         GlDTf8M8cYmEMId2/YgD+QGaqNwCPSzBqv1Zs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752278681; x=1752883481;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sSDqxMQohw4PhZMvEXwWUzGgcSu1YJU0uLQAkTg86t8=;
        b=boHq+uAbHLqOTE3tY2a0nHJ2X8Gps3yIMXtzrg2hlXUbSBnCZoLAWASoHT09BBQOip
         AnheNruYaE7O9D047MgjXoR1CCvjYkcDpgby/z1A+CdxmA9hgTri/zqHwRN6mprlcvRJ
         eoQ593WqcujslBd43ie7y4TDZTJPj+yengiizjoyvQLePI560LFqfgMUkIelh4+FjUaE
         4XmZExSnUU5V4kQigswve8O4hTMrBvbvE7D3nmj9dhbvW4uNNPFiCb/5HpDE0j0ZFLWJ
         mE2Ry7MLkDw3R1AW5iR6d6ud9ZQwemVPxcKxvLagukgWbaNKVnQk+qo3NIOx2CbemhP2
         j8hw==
X-Forwarded-Encrypted: i=1; AJvYcCVBMkWXmpH7E62GD/fubULHXcRWOdPy/DhHiwYk1GCzhP2tHSggxloDu0Cf2n6NaURnHXm6xha7178=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ/uiYGZ8IqojaNJeeAZhCZTmtMd2TqpkC938IFk0Kghvn80sj
	aBo0f2xiVW1v/XzGBc5M0FN2Shsay9WFCuo6JaVki+u1qsS2d1ZEnKoUhV76NeUUbA==
X-Gm-Gg: ASbGncuoodEshZp1VNzmJ8QTYv16hSmn1Qigbt/GlkItbRCmVJimp08ucSs1P+RQlTy
	FYqCC797U0m3dLOTFH5rfW373yM8qyPZN2DcM/UbxUdAxOvoGCzZJnC4QssKKSOXXZm94O2cDnt
	+CGdOPIysmggLYn1pIynSOT0tBuA1Q/tgHDvtWhOCFzLxbUHcNX2n9fQnGQlvxyU0snLmxXvFdd
	ugRKiQVyCObk1bwrmO4kX4O/P05UbuvUYcCB4EMMK5zYFk2C2Pr4qMk9QmYFZ9hB+iY0AtvuTXF
	s0c6i8zSKTUyvnQSvfiHT7s5YQe6spCtG9YDRDS0bH1HPdYClLTfHsyNtplsT0/jkVfsePszCOG
	CJ60NmOs1aWNjvMSMXI6lUIsIu/WmkItVGsl0/XvvlHJquDkmrJYWk2nhUHXm
X-Google-Smtp-Source: AGHT+IG/dqGGE3VWazBJtKvKr0ye5a/Q3FLffMSzSAQFdGDBegfdLcct6HvFFwDqAqizwgV0ZrMEuw==
X-Received: by 2002:a05:6a00:3a10:b0:74b:4dcc:a150 with SMTP id d2e1a72fcca58-74ee06aeb03mr6270287b3a.6.1752278680487;
        Fri, 11 Jul 2025 17:04:40 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-74eb9f8b984sm6226108b3a.150.2025.07.11.17.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 17:04:39 -0700 (PDT)
Date: Fri, 11 Jul 2025 17:04:38 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 0/3] PCI/pwrctrl: Allow pwrctrl framework to control
 PERST# GPIO if available
Message-ID: <aHGmllch_efdWgsW@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <aG3IWdZIhnk01t2A@google.com>
 <kj6kilhjynygioxyo7iogvgwqbr7tluryir3f7vqeowk6wd6qn@sop5ubotfcug>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kj6kilhjynygioxyo7iogvgwqbr7tluryir3f7vqeowk6wd6qn@sop5ubotfcug>

Hi,

On Wed, Jul 09, 2025 at 12:18:29PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 08, 2025 at 06:39:37PM GMT, Brian Norris wrote:
> > On Mon, Jul 07, 2025 at 11:48:37PM +0530, Manivannan Sadhasivam wrote:
> > > Hi,
> > > 
> > > This series is an RFC to propose pwrctrl framework to control the PERST# GPIO
> > > instead of letting the controller drivers to do so (which is a mistake btw).
> > > 
> > > Right now, the pwrctrl framework is controlling the power supplies to the
> > > components (endpoints and such), but it is not controlling PERST#. This was
> > > pointed out by Brian during a related conversation [1]. But we cannot just move
> > > the PERST# control from controller drivers due to the following reasons:
> > > 
> > > 1. Most of the controller drivers need to assert PERST# during the controller
> > > initialization sequence. This is mostly as per their hardware reference manual
> > > and should not be changed.
> > > 
> > > 2. Controller drivers still need to toggle PERST# when pwrctrl is not used i.e.,
> > > when the power supplies are not accurately described in PCI DT node. This can
> > > happen on unsupported platforms and also for platforms with legacy DTs.
> > > 
> > > For this reason, I've kept the PERST# retrieval logic in the controller drivers
> > > and just passed the gpio descriptors (for each slot) to the pwrctrl framework.
> > 
> > How sure are we that GPIOs (and *only* GPIOs) are sufficient for this
> > feature? I've seen a few drivers that pair a GPIO with some kind of
> > "internal" reset too, and it's not always clear that they can/should be
> > operated separately.
> > 
> > For example, drivers/pci/controller/dwc/pci-imx6.c /
> > imx_pcie_{,de}assert_core_reset(), and pcie-tegra194.c's
> > APPL_PINMUX_PEX_RST. The tegra case especially seems pretty clear that
> > its non-GPIO "pex_rst" is resetting an endpoint.
> > 
> 
> Right. But GPIO is the most commonly used approach for implementing PERST# and
> it is the one supported on the platform I'm testing with. So I just went with
> that. For sure there are other methods exist and the PCIe spec itself doesn't
> define how PERST# should be implemented in a form factor. It merely defines
> PERST# as an 'auxiliary signal'. So yes, other form of PERST# can exist. But for
> the sake of keeping this proposal simple, I'm considering only GPIO based
> PERST# atm.

Hmm, OK. A simple start is fine, but I'm pointing out this will quickly
show its limitations.

> Also, Tegra platforms are not converted to use pwrctrl framework and I don't
> know if the platform maintainers are interested in it or not. But if they start
> using it, we can tackle this situation by introducing a callback that
> asserts/deasserts PERST# (yes, callbacks are evil, but I don't know any other
> sensible way to support vendor specific PERST# implementations).

IMO, it's pretty fair game to at least account for things people are
doing in upstream drivers today, even if they aren't wholly ready to
adopt the new thing. It's harder to gain new users when you actively
don't support things you know the users need.

> Oh and do take a look at pcie-brcmstb driver, which I promised to move to
> pwrctrl framework for another reason. It uses multiple callbacks per SoC
> revisions for toggling PERST#. So for these usecases, having a callback in
> 'struct pci_host_bridge' would be a good fit and I may introduce it after this
> series gets in.

Sure. I think there are plenty of drivers that will need it. And that's
why I brought it up.

But if that's a "phase 2" thing, so be it.

> > > This will allow both the controller drivers and pwrctrl framework to share the
> > > PERST# (which is ugly but can't be avoided). But care must be taken to ensure
> > > that the controller drivers only assert PERST# and not deassert when pwrctrl is
> > > used. I've added the change for the Qcom driver as a reference. The Qcom driver
> > > is a slight mess because, it now has to support both new DT binding (PERST# and
> > > PHY in Root Port node) and legacy (both in Host Bridge node). So I've allowed
> > > the PERST# control only for the new binding (which is always going to use
> > > pwrctrl framework to control the component supplies).
> > > 
> > > Testing
> > > =======
> > > 
> > > This series is tested on Lenovo Thinkpad T14s laptop (with out-of-tree patch
> > > enabling PCIe WLAN card) and on RB3 Gen2 with TC9563 switch (also with the not
> > > yet merged series [2]). A big take away from this series is that, it is now
> > > possible to get rid of the controversial {start/stop}_link() callback proposed
> > > in the above mentioned switch pwrctrl driver [3].
> > 
> > This is a tiny bit tangential to the PERST# discussion, but I believe
> > there are other controller driver features that don't fit into the
> > sequence model of:
> > 
> > 1. start LTSSM (controller driver)
> > 2. pwrctrl eventually turns on power + delay per spec
> > 3. pwrctrl deasserts PERST#
> > 4. pwrctrl delays a fixed amount of time, per the CEM spec
> > 5. pwrctrl rescans bus
> > 
> > For example, tegra_pcie_dw_start_link() notes some cases where it needs
> > to take action and retry when the link doesn't come up. Similarly, I've
> > seen drivers with retry loops for cases where the link comes up, but not
> > at the expected link rate. None of this is possible if the controller
> > driver only gets to take care of #1, and has no involvement in between
> > #3 and #5.
> > 
> 
> Having this back and forth communication would make the pwrctrl driver a lot
> messier. But I believe, we could teach pwrctrl driver to detect link up (similar
> to dw_pcie_wait_for_link()) and if link didn't come up, it could do retry and
> other steps with help from controller drivers. But these things should be
> implemented only when platforms like Tegra start to show some love towards
> pwrctrl.

Never mind the lack of love you feel here :)
But I'm actively looking at drivers that don't yet fit into what pwrctrl
supports, and I'd like them to use pwrctrl someday instead of
reinventing the wheel.

You're arguing against more callbacks, and start_link()-like
functionality, but I'm pretty sure some of these things are necessities,
if you're trying to abstract power control away from controller drivers.

Again, maybe this is a problem to be solved later. But I think you're
kidding yourself that pwrctrl is ready as-is, and that you can avoid
these kinds of callbacks.

Regards,
Brian

