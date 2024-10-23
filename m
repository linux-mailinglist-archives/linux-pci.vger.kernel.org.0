Return-Path: <linux-pci+bounces-15150-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 398BC9AD55B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 22:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEA0E2848BC
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2024 20:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080931D278A;
	Wed, 23 Oct 2024 20:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KUFEmcwq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD43614EC62;
	Wed, 23 Oct 2024 20:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729714344; cv=none; b=gaLkar9wlQBwY6jXXqcGqrecWmtCGtcrDcsrU3Fqpkd4j6MTL+zYD1S+UiilcNmKgmgCHmLGaM60d6tKpIqyOO0mjbzp8VksPd6Nd3C+QVCRZVgEGC05JPup+fG9mWVKHz0D7Ayg5FwipiGz568DNye4tEVpYWM7dK4kOmwQqu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729714344; c=relaxed/simple;
	bh=XU78OzZBYmidEegNPScpopPHVT1Q0ZqVTdr3ZQvXXNU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=otv0AlP/niPSQ/bF3u4ctF8LTEonEL5PYrd3yT8xVDpC3Si8T+5vuHHg8Oega5EJFgIsBm1A0BOaGTWveXjzhyjta9mqGabEr6lQriPWOOULTygZrDedvsZ9SGQpc1VbpHGlIKnyRTy4zUQlX2tcyaHyMZJrHRCYeASKwPisOGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KUFEmcwq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F378C4CEC6;
	Wed, 23 Oct 2024 20:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729714344;
	bh=XU78OzZBYmidEegNPScpopPHVT1Q0ZqVTdr3ZQvXXNU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=KUFEmcwqycH8VEXE+3URKrH+scZKWIKrAlB/mJ38BzhD6QpwkEC0aeYwTcSalHx0u
	 ucfRmCYcHMUXasRMiWbPYNyEpxHi5Mmca4eT2SvAj4Y4fCupDM2UgnqPacS1FtjZ0A
	 61jNd8XVgTbjMXqMai1/N80IFVBb+rxrVS0Vwr9lCxwDjrlGG9zcmTy/NAwKBHILTZ
	 ZegWP6yNzstozE1/WA8MxumoDJr3S9ebDvNVNc/+MnEzTrIwb1zBXYgMUUO6flLuVB
	 /aKw+4+B06FLQiJw7LVm+lQdb0iR/PPu22GK2PHe6fABnl3ycgArSMkh49QqOuzSKp
	 fyXNK952N50wg==
Date: Wed, 23 Oct 2024 15:12:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stefan Eichenberger <eichest@gmail.com>
Cc: hongxing.zhu@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org,
	kw@linux.com, manivannan.sadhasivam@linaro.org, robh@kernel.org,
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de,
	kernel@pengutronix.de, festevam@gmail.com,
	francesco.dolcini@toradex.com, Frank.li@nxp.com,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev, linux-kernel@vger.kernel.org,
	Stefan Eichenberger <stefan.eichenberger@toradex.com>
Subject: Re: [PATCH v3] PCI: imx6: Add suspend/resume support for i.MX6QDL
Message-ID: <20241023201221.GA926319@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxi6f3S5p8Pnto-S@eichest-laptop>

On Wed, Oct 23, 2024 at 10:57:35AM +0200, Stefan Eichenberger wrote:
> On Tue, Oct 22, 2024 at 10:53:49AM -0500, Bjorn Helgaas wrote:
> > On Mon, Oct 21, 2024 at 02:49:13PM +0200, Stefan Eichenberger wrote:
> > > From: Stefan Eichenberger <stefan.eichenberger@toradex.com>
> > > 
> > > The suspend/resume support is broken on the i.MX6QDL platform. This
> > > patch resets the link upon resuming to recover functionality. It shares
> > > most of the sequences with other i.MX devices but does not touch the
> > > critical registers, which might break PCIe. This patch addresses the
> > > same issue as the following downstream commit:
> > > https://github.com/nxp-imx/linux-imx/commit/4e92355e1f79d225ea842511fcfd42b343b32995
> > > In comparison this patch will also reset the device if possible because
> > > the downstream patch alone would still make the ath10k driver crash.
> > > Without this patch suspend/resume will not work if a PCIe device is
> > > connected. The kernel will hang on resume and print an error:
> > > ath10k_pci 0000:01:00.0: Unable to change power state from D3hot to D0, device inaccessible
> ...

> > The downstream commit log ("WARNING: this is not the official
> > workaround; user should take own risk to use it") doesn't exactly
> > inspire confidence.
> > 
> > It sounds like this resets *endpoints*?  That sounds scary and
> > unexpected in suspend/resume.
> 
> Yes, I completely agree with you, but NXP has never come up with an
> "official" workaround. Our problem is that with the current
> implementation, suspend/resume is completely broken when a PCIe device
> is connected. With this proposed patch we at least have a working device
> after resume. Even for the other i.MX devices, the driver resets the
> endpoints in the resume function (imx_pcie_resume_noir ->
> imx_pcie_host_init -> imx_pcie_assert_core_reset), we just do that now
> for the i.MX6QDL as well. If it is more appropriate to call
> imx_pcie_assert_core_reset in resume as we do for the other devices,
> that would be fine with me as well. I was thinking that if we need to
> reset the device anyway, we could put it into reset on suspend, as this
> might save some extra power.

OK, I have to admit I don't know enough about suspend/resume.  Since
we already do that for other i.MX platforms, maybe an endpoint reset
is normal for suspend.  I really don't know.  In any case, if we do it
for other i.MX platforms, I'm OK doing it for this one too.

Bjorn

