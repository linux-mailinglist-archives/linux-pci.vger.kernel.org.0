Return-Path: <linux-pci+bounces-38480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E011ABE8FB8
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 15:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69F3B19A59CE
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 13:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A773827D77A;
	Fri, 17 Oct 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="srRHJW4n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753532253FF;
	Fri, 17 Oct 2025 13:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760708756; cv=none; b=h0mbgcSgD0lYuwgzEZVhurnr9XLwBMkqLVK9EUlQ9lNzgRFyPs9yVsvlVvjgsLb1F0v7iOMZsXL4e0n2NZTrcfWoZcPktImUFOXMIFjcmaH7CmvF1wHJgVZUsXwF/MBxAtBi+2fXxjqShmZViIlf677w9fBErjQVOJDVZ5SOJiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760708756; c=relaxed/simple;
	bh=tuwnSb9TH+cevkh2/f4qKgeRV6Xx5R3TxYUye1mrYXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=garJXgz0veowjdvT0QYsWYEh6MZ7qXPb/4jUfW7aFQjf4xoi4svTGnScaj331iR1Q7/jk2MH+pR7gu2VrGvj1wKUsCBt10z1Fud72L4rEs5uQG9GXCSk03KEw4kXALTTiA7uJowb2dSkhsYsh2M4Y9Ql0UwLp+QTSJEXn2sQ92g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=srRHJW4n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA58AC4CEE7;
	Fri, 17 Oct 2025 13:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760708756;
	bh=tuwnSb9TH+cevkh2/f4qKgeRV6Xx5R3TxYUye1mrYXQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=srRHJW4nQ1b0MVA9JNlW2F4ekn1+j9gKj63pFwk39saI8PUpq1ruf2WNlXSwTqumL
	 2Ex2TP2p1UFI0qI7Y3LwQ87X1aK/71pllKS3NaWNrGvd86HoT6LOCaeUkTBkHSdgYU
	 4+1bQGGUtWS2OHNWt4rw4VQDSHKfzM2AwTluewPyPZgmjoE7oqExowX+oK6V1+rPoN
	 qauXtpkyTGw/DhLAtgINBExJmMY91MXlm4WofI2FeJBmOyQYJ7o+WZnlGCcoKCmsz2
	 D719sDFnCvDXzUFXZkQzp4VIGkoKN2Sy2wm73uZ92IUPsATzOl9Zd9lT/odA3JV1iG
	 9DIXzS1EXp56A==
Date: Fri, 17 Oct 2025 08:45:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Chia-Lin Kao <acelan.kao@canonical.com>,
	Dragan Simic <dsimic@manjaro.org>,
	linux-rockchip@lists.infradead.org, regressions@lists.linux.dev,
	FUKAUMI Naoki <naoki@radxa.com>
Subject: Re: [PATCH v2 1/2] PCI/ASPM: Override the ASPM and Clock PM states
 set by BIOS for devicetree platforms
Message-ID: <20251017134554.GA1027663@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4pm5tizc2c4c75h23izalhysuljnlfzpxuawhzezmnnqic2tdf@l2rcj24rmru3>

On Fri, Oct 17, 2025 at 06:24:26PM +0530, Manivannan Sadhasivam wrote:
> On Fri, Oct 17, 2025 at 08:19:11PM +0800, Shawn Lin wrote:
> > 在 2025/10/17 星期五 18:04, Manivannan Sadhasivam 写道:
> > > On Fri, Oct 17, 2025 at 05:47:44PM +0800, Shawn Lin wrote:
> ...

> > > > While we're on the topic of ASPM, may I ask a silly question?
> > > > I saw the ASPM would only be configured once the function
> > > > driver calling pci_enable_device. So if the modular driver
> > > > hasn't been insmoded, the link will be in L0 even though there
> > > > is no transcation on-going. What is the intention behind it?
> > > 
> > > I don't see where ASPM is configured during pci_enable_device().
> > > It is currently configured for all devices during
> > > pci_scan_slot().
> > 
> > This is the dump_stack() where I observed. If I compile NVMe
> > driver as a module and never insmod it, the link is always in L0,
> > namely ASPM Disabled.
> 
> I guess this comment answers your question:
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pcie/aspm.c?h=v6.18-rc1#n1179

The comment is:

   * At this stage drivers haven't had an opportunity to change the
   * link policy setting. Enabling ASPM on broken hardware can cripple
   * it even before the driver has had a chance to disable ASPM, so
   * default to a safe level right now. If we're enabling ASPM beyond
   * the BIOS's expectation, we'll do so once pci_enable_device() is
   * called.

I don't think relying on a driver to disable ASPM to avoid broken
hardware is the right answer.  If the driver is never loaded, we waste
power.  And if the user enables ASPM via sysfs, apparently the device
may be crippled.

I think it would be better to have an enumeration-time quirk to keep
us from enabling ASPM.  We might trip over some of this broken
hardware, but I don't think there are very many drivers that fiddle
with ASPM, so we should be able to be proactive about it.

> But with the recent ASPM change, the ASPM settings for DT platforms
> will be applied before pci_enable_device(). Also, the comment is
> somewhat outdated as we generally do not want PCI client drivers to
> enable/disable ASPM nowadays. They can however do it under specific
> circumstances.

