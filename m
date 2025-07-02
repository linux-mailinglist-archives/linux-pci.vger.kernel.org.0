Return-Path: <linux-pci+bounces-31304-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D82AF6155
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 20:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9485A16E62E
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 18:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABA6218E9F;
	Wed,  2 Jul 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nI56ny61"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC442E499A;
	Wed,  2 Jul 2025 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481055; cv=none; b=mfbEBcL5LaSpt/o10qY7fsb52wd1HQej7mwM950jGbq0nbD3NSIUllcIaY8dY8Y5E7jED/STaV+6aE2s1++sID2Q/n7CRZUw56cAp0MwwrGVhiR16UfT0u6Z0HZQHMtieswKk0cL/KwSF3UFE8bqAWn3/VOWWDxVMba/SYjoASs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481055; c=relaxed/simple;
	bh=SFXuw97PSEUrxUglhPmZ8lic5NsVXj9rz3VueJiKsvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RZFy46BdK5q/04hBT7HhcIJU/Bqjpz2DthmuI9R6c28GLDNU1XsVvlYo40jp1x9lMcMkGvnSkv2L4Jl1DJfM8HXv6HRH77yNgz2kEc+/Bx2FB5bEBzetBu4puDTTMTeG6Yp/WWF3qXxSPhFmdKRYN/fZS2CLNN/XkCxP1Lmv1DQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nI56ny61; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E47C4CEE7;
	Wed,  2 Jul 2025 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751481054;
	bh=SFXuw97PSEUrxUglhPmZ8lic5NsVXj9rz3VueJiKsvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nI56ny61V/kCAgcohER8DsmSdySYn4FMw2ExEZDUeSgF6ieZhNNn5SqM56I8VJ6I9
	 6y/KGq3/Txk47Wr6uop2fvIXT229uYkynwjIalp0c0EskFXiriC/J2zwmytIqs/wjq
	 KB4kM70iRzLTpvrjh0r3ZtjHG2CXOOq1eUZ9wMG1hVPet0RUwm/UhzO0wHNrrVnjq9
	 JDQ2owX3T96JC/uvrzTIqSIAWGPbtGHUJyVsjpPYJsVwHrXihJi2KubR5R7t6ODDCi
	 ssE+XZ1gAzoGtWTDHyiyUrf5AXlrJxUR5KRNRtXFLx45IXpF4mIkmxKmsjgf6e5zB1
	 xL0Xs3JxXs5Cw==
Date: Thu, 3 Jul 2025 00:00:43 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <ezlr2xqy5bnq6cnrrjltlim7oiorcy2xrsoclj6fnu5jcymie5@xfatlrts6vod>
References: <myhg3xn3subujf3buarctgexipvjhale6zyqkhfpnm6qwitlg6@27kjexp337aj>
 <20250702175307.GA1891739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250702175307.GA1891739@bhelgaas>

On Wed, Jul 02, 2025 at 12:53:07PM GMT, Bjorn Helgaas wrote:
> On Wed, Jul 02, 2025 at 12:17:00PM +0530, Manivannan Sadhasivam wrote:
> > On Tue, Jul 01, 2025 at 03:35:26PM -0500, Bjorn Helgaas wrote:
> > > [+cc Bart]
> > > 
> > > On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > > > If devicetree describes power supplies related to a PCI device, we
> > > > previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> > > > not enabled.
> > > > 
> > > > When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> > > > pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> > > > core will rescan the bus after turning on the power. However, if
> > > > CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> > > 
> > > Separate from this patch, can we refine the comment in
> > > pci_scan_device() to explain *why* we should skip scanning if a
> > > pwrctrl device was created?  The current comment leaves me with two
> > > questions:
> > > 
> > >   1) How do we know the pwrctrl device is currently off?  If it is
> > >      already on, why should we defer enumerating the device?
> > 
> > I believe you meant to ask "how do we know the PCI device is
> > currently off". If the pwrctrl device is created, then we for sure
> > know that the pwrctrl driver will power on the PCI device at some
> > point (depending on when the driver gets loaded). Even if the device
> > was already powered on, we do not want to probe the client driver
> > because, we have seen race between pwrctrl driver and PCI client
> > driver probing in parallel. So I had imposed a devlink dependency
> > (see b458ff7e8176) that makes sure that the PCI client driver
> > wouldn't get probed until the pwrctrl driver (if the pwrctrl device
> > was created) is probed. This will ensure that the PCI device state
> > is reset and initialized by the pwrctrl driver before the client
> > driver probes.
> 
> I'm confused about this.  Assume there is a pwrctrl device and the
> related PCI device is already powered on when Linux boots.  Apparently
> we do NOT want to enumerate the PCI device?  We want to wait for the
> pwrctrl driver to claim the pwrctrl device and do a rescan?  Even
> though the pwrctrl driver may be a loadable module and may not even be
> available at all?
> 
> It seems to me that a PCI device that is already powered on should be
> enumerated and made available.  If there's a pwrctrl device for it,
> and we decide to load pwrctrl, then we also get the ability to turn
> the PCI device off and on again as needed.  But if we *don't* load
> pwrctrl, it seems like we should still be able to use a PCI device
> that's already powered on.
> 

The problem with enumerating the PCI device which was already powered on is that
the pwrctrl driver cannot reliably know whether the device is powered on or not.
So by the time the pwrctrl driver probes, the client driver might also be
probing. For the case of WLAN chipsets, the pwrctrl driver used to sample the EN
(Enable) GPIO pin to know whether the device is powered on or not (see
a9aaf1ff88a8), but that also turned out to be racy and people were complaining.

So to simplify things, we enforced this dependency.

> > >   2) If the pwrctrl device is currently off, won't the Vendor ID read
> > >      just fail like it does for every other non-existent device?  If
> > >      so, why can't we just let that happen?
> > 
> > Again, it is not the pwrctrl device that is off, it is the PCI
> > device. If it is not turned on, yes VID read will fail, but why do
> > we need to read the VID in the first place if we know that the PCI
> > device requires pwrctrl and the pwrctrl driver is going to be probed
> > later.
> 
> I was assuming pwrctrl is only required if we want to turn the PCI
> device power on or off.  Maybe that's not true?
> 

Pretty much so, but we will also use it to do D3Cold (during system suspend) in
the near future.

> > > This behavior is from 2489eeb777af ("PCI/pwrctrl: Skip scanning for
> > > the device further if pwrctrl device is created"), which just says
> > > "there's no need to continue scanning."  Prior to 2489eeb777af, it
> > > looks like we *did* what try to enumerate the device even if a pwrctrl
> > > device was created, and 2489eeb777af doesn't mention a bug fix, so I
> > > assume it's just an optimization.
> > 
> > Yes, it is indeed an optimization.
> > 
> > To summarize, we have imposed a dependency between the PCI client
> > driver and pwrctrl driver to make sure that the PCI device state is
> > fully reset and initialized before the client driver probes.
> 
> If the PCI device is already powered on, what more should we do to
> fully reset and initialize it?  If it needed more initialization, I
> assume the platform should have left it powered off.
> 

As I mentioned above, we cannot reliably detect whether a device is already
powered on or not from the pwrctrl driver when it probes. So because of that
reason, we enforce dependency and always reset/initialize the device to POR
state. If there is a reliable way

- Mani

-- 
மணிவண்ணன் சதாசிவம்

