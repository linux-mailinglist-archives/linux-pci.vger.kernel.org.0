Return-Path: <linux-pci+bounces-39893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4A9C23626
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 07:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21EB81882613
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 06:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26D522F1FF1;
	Fri, 31 Oct 2025 06:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tGP4zMww"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4522E6CDC;
	Fri, 31 Oct 2025 06:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761891711; cv=none; b=kfYWmdBMzj98nqaP1Onxj5b+P6/YOdFhXVZi3u/3lhssrc3IL9crFlANVD5kvDPe1Gl/qJ1IaMnpD8tpArgubrWj+3p8B6E/yVezmNLMFVgQRo1A3bhhVwnayfV+CUaC6Q8YCbXbEDkg1r9+/733ZJUeodbHASwrtgUgbV2SUPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761891711; c=relaxed/simple;
	bh=qV6uFxqSSQYthCHvksnPhXB8B47dV+DjfShOnQoDrtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R4AbromIJE6Y6SY5HmXBpJvaqqXj1uLx3ky0R2MBGm2983Hq0AF4NAkKvER8FRK9UdroFYTuT5BXuLu7Ms4v7/RBQPuXjWtXQux4rqOpsTjGUxLAmbc8goEr6VLRg8BsD1q+5roR0birkhv1MoM0U7TGjodU5Ix/MTwNqA0l/Rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tGP4zMww; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D004C4CEF1;
	Fri, 31 Oct 2025 06:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891710;
	bh=qV6uFxqSSQYthCHvksnPhXB8B47dV+DjfShOnQoDrtU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGP4zMww9hNL4QxtqCMsdf1R8Ftkkpg7q/cByv/0FvS8d7I0eidWHaMI70IimwG99
	 aY6WnMrRpCUqD18sYZEFSgogpia1W1t22OQbEZZSxp8w6zjbF1rTsd4eHIPqZC9XT0
	 pC3LgxQ45CoXg5yt1a4eUw9IeRGTxaH2dJL5PNC7hSfCTsNqZtip/2/BpgpWSww1v/
	 A1Gc60K2qNLfnSW1veDmIfrdapFZppXytWL9eSAhqA2kP1+URNcTN8DRpM2NBzawxI
	 dM0vTVa3O3FtuaJxhdEyqYkxcEJlChQmb0W/yITx24CSSyYTiw5Vzn2EiyX3T+whuB
	 eTn4/imgBHv4g==
Date: Fri, 31 Oct 2025 11:51:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Niklas Cassel <cassel@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	"David E. Box" <david.e.box@linux.intel.com>, Kai-Heng Feng <kai.heng.feng@canonical.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Chia-Lin Kao <acelan.kao@canonical.com>, Dragan Simic <dsimic@manjaro.org>, 
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev, FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <sttsqedadw4cdozfrjkl7jlqk2jtwkaniukczfwm5e7ymdtsh3@jkq3unz2ez2k>
References: <4pm5tizc2c4c75h23izalhysuljnlfzpxuawhzezmnnqic2tdf@l2rcj24rmru3>
 <20251017134554.GA1027663@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251017134554.GA1027663@bhelgaas>

On Fri, Oct 17, 2025 at 08:45:54AM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 17, 2025 at 06:24:26PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Oct 17, 2025 at 08:19:11PM +0800, Shawn Lin wrote:
> > > 在 2025/10/17 星期五 18:04, Manivannan Sadhasivam 写道:
> > > > On Fri, Oct 17, 2025 at 05:47:44PM +0800, Shawn Lin wrote:
> > ...
> 
> > > > > While we're on the topic of ASPM, may I ask a silly question?
> > > > > I saw the ASPM would only be configured once the function
> > > > > driver calling pci_enable_device. So if the modular driver
> > > > > hasn't been insmoded, the link will be in L0 even though there
> > > > > is no transcation on-going. What is the intention behind it?
> > > > 
> > > > I don't see where ASPM is configured during pci_enable_device().
> > > > It is currently configured for all devices during
> > > > pci_scan_slot().
> > > 
> > > This is the dump_stack() where I observed. If I compile NVMe
> > > driver as a module and never insmod it, the link is always in L0,
> > > namely ASPM Disabled.
> > 
> > I guess this comment answers your question:
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aspm.c?h=v6.18-rc1#n1179
> 
> The comment is:
> 
>    * At this stage drivers haven't had an opportunity to change the
>    * link policy setting. Enabling ASPM on broken hardware can cripple
>    * it even before the driver has had a chance to disable ASPM, so
>    * default to a safe level right now. If we're enabling ASPM beyond
>    * the BIOS's expectation, we'll do so once pci_enable_device() is
>    * called.
> 
> I don't think relying on a driver to disable ASPM to avoid broken
> hardware is the right answer.  If the driver is never loaded, we waste
> power.  And if the user enables ASPM via sysfs, apparently the device
> may be crippled.
> 
> I think it would be better to have an enumeration-time quirk to keep
> us from enabling ASPM.  We might trip over some of this broken
> hardware, but I don't think there are very many drivers that fiddle
> with ASPM, so we should be able to be proactive about it.
> 

There are quite a bit of drivers fiddling with ASPM states:

git grep -l PCI_EXP_LNKCTL_ASPMC drivers/ | wc -l

16

- Mani

-- 
மணிவண்ணன் சதாசிவம்

