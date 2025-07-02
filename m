Return-Path: <linux-pci+bounces-31298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF35DAF606A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 19:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5C701754F8
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 17:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350E8309A71;
	Wed,  2 Jul 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oZr9U1kt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD6C2F50B7;
	Wed,  2 Jul 2025 17:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751478789; cv=none; b=PIyTBqkmXOC95ypLxlDuIvNmgVuSniwIiPd+WItQRzzN2qni8wJS0W47wig3zuvKGrO1LifbjG6ZdvXLe8CF4+iGaLfELu1rUnEgB4vsHwCYbwAEcBNQq6dwFIvnUxVZU8jvDLutJuJs5IOWrElPNOKcz3biY5zol76q4m5TQhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751478789; c=relaxed/simple;
	bh=7s8fD9aiiXQ1A+aTfaJo538HFe4NxvZ8L1nKHQOXX54=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oIxDF9+KJ3oSlS0lETm9bPwvaU71Q2+bazBqXwJrq8YvRw+5T2RIkEKDyD9zpkJDAt/woWTy+uFPTg66NAJKO8sEwFsuvEW7LPYEXuA5RxqaC6RbpS7KFz8Wfn1K1KgvPSaoLZ2kz8xxnrHwMUPM/RNCYgxVg9EngNB8t3SPbhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oZr9U1kt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEED1C4CEE7;
	Wed,  2 Jul 2025 17:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751478788;
	bh=7s8fD9aiiXQ1A+aTfaJo538HFe4NxvZ8L1nKHQOXX54=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=oZr9U1ktTKVcqr3ZrC67+dfmJIMX0LAoxMaQ+QzhgevkBU+EdsCTDD0jgVMmZNUbJ
	 EM30hjPCjSC28g+uEQ7UsGhfto0VlL397f/R0q8DqK5L37WlXgKsJMKfbZ3SEWnbRa
	 pxEf6sSnCmERhoOkyRAr5kQ9X0So9wP+ttWaeAs2JvlR+7lsct+xJuzvuVuEOnhuLt
	 wIlNOEHin2nq+xeuFM7v/4ZOcBJaIiR2VBvOqLSwiP8byuitIg7ezIQ8vPdKvbxcph
	 05Y1owVmxLHPnZjFMzZxKr1l20WIwH11KAAHS2oxppqmDrkXejfQQh7eyvOdTOWZiU
	 MUXKRdlPS7JRg==
Date: Wed, 2 Jul 2025 12:53:07 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Jim Quinlan <james.quinlan@broadcom.com>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <20250702175307.GA1891739@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <myhg3xn3subujf3buarctgexipvjhale6zyqkhfpnm6qwitlg6@27kjexp337aj>

On Wed, Jul 02, 2025 at 12:17:00PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 01, 2025 at 03:35:26PM -0500, Bjorn Helgaas wrote:
> > [+cc Bart]
> > 
> > On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > > If devicetree describes power supplies related to a PCI device, we
> > > previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> > > not enabled.
> > > 
> > > When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> > > pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> > > core will rescan the bus after turning on the power. However, if
> > > CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> > 
> > Separate from this patch, can we refine the comment in
> > pci_scan_device() to explain *why* we should skip scanning if a
> > pwrctrl device was created?  The current comment leaves me with two
> > questions:
> > 
> >   1) How do we know the pwrctrl device is currently off?  If it is
> >      already on, why should we defer enumerating the device?
> 
> I believe you meant to ask "how do we know the PCI device is
> currently off". If the pwrctrl device is created, then we for sure
> know that the pwrctrl driver will power on the PCI device at some
> point (depending on when the driver gets loaded). Even if the device
> was already powered on, we do not want to probe the client driver
> because, we have seen race between pwrctrl driver and PCI client
> driver probing in parallel. So I had imposed a devlink dependency
> (see b458ff7e8176) that makes sure that the PCI client driver
> wouldn't get probed until the pwrctrl driver (if the pwrctrl device
> was created) is probed. This will ensure that the PCI device state
> is reset and initialized by the pwrctrl driver before the client
> driver probes.

I'm confused about this.  Assume there is a pwrctrl device and the
related PCI device is already powered on when Linux boots.  Apparently
we do NOT want to enumerate the PCI device?  We want to wait for the
pwrctrl driver to claim the pwrctrl device and do a rescan?  Even
though the pwrctrl driver may be a loadable module and may not even be
available at all?

It seems to me that a PCI device that is already powered on should be
enumerated and made available.  If there's a pwrctrl device for it,
and we decide to load pwrctrl, then we also get the ability to turn
the PCI device off and on again as needed.  But if we *don't* load
pwrctrl, it seems like we should still be able to use a PCI device
that's already powered on.

> >   2) If the pwrctrl device is currently off, won't the Vendor ID read
> >      just fail like it does for every other non-existent device?  If
> >      so, why can't we just let that happen?
> 
> Again, it is not the pwrctrl device that is off, it is the PCI
> device. If it is not turned on, yes VID read will fail, but why do
> we need to read the VID in the first place if we know that the PCI
> device requires pwrctrl and the pwrctrl driver is going to be probed
> later.

I was assuming pwrctrl is only required if we want to turn the PCI
device power on or off.  Maybe that's not true?

> > This behavior is from 2489eeb777af ("PCI/pwrctrl: Skip scanning for
> > the device further if pwrctrl device is created"), which just says
> > "there's no need to continue scanning."  Prior to 2489eeb777af, it
> > looks like we *did* what try to enumerate the device even if a pwrctrl
> > device was created, and 2489eeb777af doesn't mention a bug fix, so I
> > assume it's just an optimization.
> 
> Yes, it is indeed an optimization.
> 
> To summarize, we have imposed a dependency between the PCI client
> driver and pwrctrl driver to make sure that the PCI device state is
> fully reset and initialized before the client driver probes.

If the PCI device is already powered on, what more should we do to
fully reset and initialize it?  If it needed more initialization, I
assume the platform should have left it powered off.

> So irrespective of whether the PCI device is already powered on or
> not, it is guaranteed by devlink that the PCI client driver will
> only get probed *after* the pwrctrl driver (if the device requires
> it). So we skip scanning the device further if the pwrctrl device is
> created (which means, the device depends on pwrctrl driver to power
> manage it).

I'm just as confused as I was before.  I'm assuming pwrctrl basically
gives us a way to control the main power rails to the PCI device, and 
the device only depends on pwrctrl in the sense that pwrctrl can
remove main power and put the device in D3cold, and then restore main
power so the device can return to D0uninitialized.

Bjorn

