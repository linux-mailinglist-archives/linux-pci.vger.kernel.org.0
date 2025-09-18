Return-Path: <linux-pci+bounces-36441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3224B86EF7
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 22:44:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A59EE580A06
	for <lists+linux-pci@lfdr.de>; Thu, 18 Sep 2025 20:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04B2F3606;
	Thu, 18 Sep 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AbD6tLzW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44402F2910;
	Thu, 18 Sep 2025 20:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758228258; cv=none; b=ZDEZleCyGlR1CnRrDuvx0VEJog6cLEkjXTdelH51ZgK6ih4YIDN4XZKxjKTYbQPl+bT4W0dZRkTNBSS66XGjZOyxjdFX83mlBbEJerJrSOJwYXopXxC4quKkpVvcSSDy/P6MBiuSYeI3Z8ctn/O3g08Fb65FCnd9Qt24dn4YPlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758228258; c=relaxed/simple;
	bh=3DvsgSYKmplnu+QJjzABbKmcsHRC4ki65kCstmjqeYc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eBh7dpSwnXtOStYUStGwf8W0OSJ8e7ThWUxJNO5ZmzFj7NYK0VqZks8IPdtcY16lc3yhVSt7A/3NAzJwRTT5l9X8p2Hf07R9iNMj/8fBgI9EfNWA1K+NvjhYH5yjRtHGncPbbJDdCluV877Y74IyGPoR8bzq7PpZAlmeMGbUt2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AbD6tLzW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F915C4CEE7;
	Thu, 18 Sep 2025 20:44:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758228258;
	bh=3DvsgSYKmplnu+QJjzABbKmcsHRC4ki65kCstmjqeYc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=AbD6tLzWeaEzZvY0CwpKmFiqrK7Ojp+pGi3tn1gxVz7xocZ5BId4BiL439LTq0MtU
	 G5ZFJP7GIZtlJg4dJGJJpH5fSd+xfPD+Jw6IILYO3yQYYW+AvcFo09Kcm60OGbFfuv
	 ZXnYjUTvcEjiY7HTi5Z63mQ5CB9b0Olvnqhwx/amz2RIve+GRu4F/4CbtlpADC8udj
	 cbX7VKreXu5Tz+i9oemG8iKd3wCF50oO5lmz7Pt/WIIpWHjIKUuOyZyxlmIo0L2Bg3
	 HwFQQANp3yvdBlrCi/xVMHeu+vw5QeJiRPPOLC9UxC3JB0gC93V38mFCzAR+bQg+Eq
	 qEWf7lTG2iHRw==
Date: Thu, 18 Sep 2025 15:44:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Marek Vasut <marek.vasut@mailbox.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>,
	linux-pci@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Magnus Damm <magnus.damm@gmail.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar-gen4: Add missing 1ms delay after PWR reset
 assertion
Message-ID: <20250918204416.GA1921028@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2a739ab-e59f-491b-bb94-b7554266712d@mailbox.org>

On Thu, Sep 18, 2025 at 10:35:08PM +0200, Marek Vasut wrote:
> On 9/18/25 10:04 PM, Bjorn Helgaas wrote:
> > On Thu, Sep 18, 2025 at 05:00:26AM +0200, Marek Vasut wrote:
> > > R-Car V4H Reference Manual R19UH0186EJ0130 Rev.1.30 Apr. 21, 2025 page 585
> > > Figure 9.3.2 Software Reset flow (B) indicates that for peripherals in HSC
> > > domain, after reset has been asserted by writing a matching reset bit into
> > > register SRCR, it is mandatory to wait 1ms.
> > 
> > > @@ -182,8 +182,10 @@ static int rcar_gen4_pcie_common_init(struct rcar_gen4_pcie *rcar)
> > >   		return ret;
> > >   	}
> > > -	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc))
> > > +	if (!reset_control_status(dw->core_rsts[DW_PCIE_PWR_RST].rstc)) {
> > >   		reset_control_assert(dw->core_rsts[DW_PCIE_PWR_RST].rstc);
> > > +		usleep_range(1000, 2000);
> > 
> > What would you think of "fsleep(1000)"?
> > 
> > I know there's controvery about fsleep(), but while the 1000 usec
> > lower bound is important, I think the selection of the 2000 usec upper
> > bound is pretty arbitrary and doesn't really justify spelling it out.
>
> The upper bound is arbitrary.
> 
> My reasoning for picking up usleep_range() is to give the kernel
> sufficient space to pick the best fitting delay in that 1..2 ms
> range, without constraining the timers too much. In other words, let
> the kernel pick the next easy to use timer tick which guarantees at
> least 1ms delay.

Right, basically the same motivation as fsleep().

> As far as I can tell, fsleep() in this case would add a bit of
> auto-detection overhead, and then select equivalent of
> usleep_range(1000, 1250) , wouldn't it ?
> 
> So I think using fsleep() here would add overhead, but not yield any
> actual benefit. Is my understanding and conclusions correct ?

I think you're right that fsleep() will pick usleep_range(1000, 1250),
so it's less optimal in that sense, but I think optimization like that
would be better done inside fsleep() instead of everybody doing it ad
hoc at the call site.

I don't think fsleep() should add any overhead since it's inlined and
all the delays are constants.  But I haven't actually looked at the
generated code.

