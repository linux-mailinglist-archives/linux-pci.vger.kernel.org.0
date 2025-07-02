Return-Path: <linux-pci+bounces-31218-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9717AAF0BE9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 08:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E97B3ADF5A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 06:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436B91FC0E6;
	Wed,  2 Jul 2025 06:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u/LGcijB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 151EC2AE8E;
	Wed,  2 Jul 2025 06:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751438840; cv=none; b=fQSmjBMMXnpNteNG2V4WunBINU89z6Y0gaVdrCFa5oZT+Q1SEVv8tay1po4R/5kycleZMDXnY93l0yVNd88elRxLlnbdfFtU7i4B3z04jRcV8pNph+5tqVdjp7t/8u/fOi7rnaPZrnjGk54Au0s41p01pXO0iIEJCUknqbyOO/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751438840; c=relaxed/simple;
	bh=s31Q4oV8fzNeXmOADLiOr+c25591rSyayzqcziFLGco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EfMrE36hTMHWKOew5w30YvwFKT0PtloAcPKKnnJifxeL5bJLQIqBxjvRg229WvLIJWLn2mxHUCkisfjgm+gKdlsoCec/ZPHJH6P+dKsni0bVV/nr/uUbU1rMLnCgfbTRVxus623E7NjsX5kKK5fI2HVW6rjskg5jYHiKQLnTfWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u/LGcijB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22386C4CEEE;
	Wed,  2 Jul 2025 06:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751438838;
	bh=s31Q4oV8fzNeXmOADLiOr+c25591rSyayzqcziFLGco=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u/LGcijB0TS0mZUTbXeJ60nLjcMoPbYo9jOy31IEGFUG0Lp43UWv8tvnYisyh3jaj
	 dKyTakwsa3jfMbAPuHjLkTa8W5nUh4exHQGpQJhLoWytJxpl1KSsRNY5QLdcEvFZdw
	 8NMuqpFJrJ3eGerSJA8xldXSWR5HLK/sgZyJkjD0vBiTnZBd+NNkgmiUetZqvmT67m
	 oxsLQZxPM8R6Sf/Ts39QATid+rrtPH+fc43mW6FsReFq0lTLaqShDPsXMPoo2Gp5Ks
	 W9pkX7AFZZj//eTYgovXjVLH4TEAMXUyLY0Z5G/kn6Tk+aQHI6H5iVmMUj62QY739O
	 I3bVvSErQzEog==
Date: Wed, 2 Jul 2025 12:17:00 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	bhelgaas@google.com, lukas@wunner.de, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, Jim Quinlan <james.quinlan@broadcom.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2] PCI/pwrctrl: Skip creating pwrctrl device unless
 CONFIG_PCI_PWRCTRL is enabled
Message-ID: <myhg3xn3subujf3buarctgexipvjhale6zyqkhfpnm6qwitlg6@27kjexp337aj>
References: <20250701064731.52901-1-manivannan.sadhasivam@linaro.org>
 <20250701203526.GA1849466@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250701203526.GA1849466@bhelgaas>

On Tue, Jul 01, 2025 at 03:35:26PM -0500, Bjorn Helgaas wrote:
> [+cc Bart]
> 
> On Tue, Jul 01, 2025 at 12:17:31PM +0530, Manivannan Sadhasivam wrote:
> > If devicetree describes power supplies related to a PCI device, we
> > previously created a pwrctrl device even if CONFIG_PCI_PWRCTL was
> > not enabled.
> > 
> > When pci_pwrctrl_create_device() creates and returns a pwrctrl device,
> > pci_scan_device() doesn't enumerate the PCI device. It assumes the pwrctrl
> > core will rescan the bus after turning on the power. However, if
> > CONFIG_PCI_PWRCTL is not enabled, the rescan never happens.
> 
> Separate from this patch, can we refine the comment in
> pci_scan_device() to explain *why* we should skip scanning if a
> pwrctrl device was created?  The current comment leaves me with two
> questions:
> 
>   1) How do we know the pwrctrl device is currently off?  If it is
>      already on, why should we defer enumerating the device?
> 

I believe you meant to ask "how do we know the PCI device is currently off". If
the pwrctrl device is created, then we for sure know that the pwrctrl driver
will power on the PCI device at some point (depending on when the driver gets
loaded). Even if the device was already powered on, we do not want to probe the
client driver because, we have seen race between pwrctrl driver and PCI client
driver probing in parallel. So I had imposed a devlink dependency (see
b458ff7e8176) that makes sure that the PCI client driver wouldn't get probed
until the pwrctrl driver (if the pwrctrl device was created) is probed. This
will ensure that the PCI device state is reset and initialized by the pwrctrl
driver before the client driver probes.

>   2) If the pwrctrl device is currently off, won't the Vendor ID read
>      just fail like it does for every other non-existent device?  If
>      so, why can't we just let that happen?
> 

Again, it is not the pwrctrl device that is off, it is the PCI device. If it is
not turned on, yes VID read will fail, but why do we need to read the VID in the
first place if we know that the PCI device requires pwrctrl and the pwrctrl
driver is going to be probed later.

> This behavior is from 2489eeb777af ("PCI/pwrctrl: Skip scanning for
> the device further if pwrctrl device is created"), which just says
> "there's no need to continue scanning."  Prior to 2489eeb777af, it
> looks like we *did* what try to enumerate the device even if a pwrctrl
> device was created, and 2489eeb777af doesn't mention a bug fix, so I
> assume it's just an optimization.
> 

Yes, it is indeed an optimization.

To summarize, we have imposed a dependency between the PCI client driver and
pwrctrl driver to make sure that the PCI device state is fully reset and
initialized before the client driver probes. So irrespective of whether the PCI
device is already powered on or not, it is guaranteed by devlink that the PCI
client driver will only get probed *after* the pwrctrl driver (if the device
requires it). So we skip scanning the device further if the pwrctrl device is
created (which means, the device depends on pwrctrl driver to power manage it).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

