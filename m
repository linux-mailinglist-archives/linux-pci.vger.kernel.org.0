Return-Path: <linux-pci+bounces-32645-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D40BB0C468
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 14:49:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91A6116793D
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 12:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CBBC2D46C2;
	Mon, 21 Jul 2025 12:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kGkvWwlF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D420F2D46AE;
	Mon, 21 Jul 2025 12:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102166; cv=none; b=nbk3uBrh188UPOE3D3ymNSVpdA+F6QjiARvAIaWWoShLRWBTEdXwY/bjmcTPw2wKr63Fm38fFE2gexVgfueaDgnX4BGMkM3Q9z8GDZCbjxd4kXNGpMDZaFSBMObZcQ9JlJeFwiCyG31M5AW+YZKKU2qn/fJTTSOWJgNzt8mLWiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102166; c=relaxed/simple;
	bh=ohPHgBghu6f1fO7+k+hBTWWYaerI/ppVg0Kx1KUtBO0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rF1OAkc/l0bjVqCBbfL+Rdp64NNGPhdAqI+KoO7hfmn1GyWowDGRgBe906XtszD+de9p1N90HA5IU+jDRigfM8+PUA/hFrmPrpxtqdlb7cnDM+YXNqFwjyisCe+qACwTKDt6SrfwqcKQO6qpnh5Kgp658xe26IUe3GUzWTs/6Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kGkvWwlF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 652E3C4CEF7;
	Mon, 21 Jul 2025 12:49:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753102166;
	bh=ohPHgBghu6f1fO7+k+hBTWWYaerI/ppVg0Kx1KUtBO0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kGkvWwlFd+DoY2STa58QgwK1FhyrZQBvUZQS4nlPmJs1YqknObFumP3LWwXtRTkaB
	 DcNibY+5rsS+g140aekdJ/OaX/2rOcXmlLm8P8nyR5kioU7P5ZAVv4LsqzB3rX8dpA
	 FwQFrQF6wzfDcZQg6N2gD6r0xffj6lNH6Yk2BiEAA+EoTIdrThYKumAwjScZRk5s4i
	 RADw0bcKYNylyCMedR0iH5ByudY/jB6RooWapd7QRUv1aH1Yd06Kfqh+YQ+z/RzhWm
	 HgVNwXVhn6xv4HVCxQhaMEszjkDgW5OtSlIxyhU1LZMYDBMzkPaNQCXvzRobLMcpi1
	 E2tSYiyFsNh4g==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1udpxC-000000007uL-2QXv;
	Mon, 21 Jul 2025 14:49:15 +0200
Date: Mon, 21 Jul 2025 14:49:14 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <aH43Sm3LWoipx5Yn@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
 <aH4JPBIk_GEoAezy@hovoldconsulting.com>
 <rmltahsjvllae3or7jjk5kwvdkcqohj4bbjsfv4mnfbuq7376s@wtsha4zorf2p>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <rmltahsjvllae3or7jjk5kwvdkcqohj4bbjsfv4mnfbuq7376s@wtsha4zorf2p>

On Mon, Jul 21, 2025 at 04:26:41PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Jul 21, 2025 at 11:32:44AM GMT, Johan Hovold wrote:
> > On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:
> > > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> > > ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> > > enumerated at the time of the controller driver probe. It proved to be
> > > useful for devices already powered on by the bootloader as it allowed
> > > devices to enter ASPM without user intervention.
> > > 
> > > However, it could not enable ASPM for the hotplug capable devices i.e.,
> > > devices enumerated *after* the controller driver probe. This limitation
> > > mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> > > and also the bootloader has been enabling the PCI devices before Linux
> > > Kernel boots (mostly on the Qcom compute platforms which users use on a
> > > daily basis).
> > > 
> > > But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> > > pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> > > started to block the PCI device enumeration until it had been probed.
> > > Though, the intention of the commit was to avoid race between the pwrctrl
> > > driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> > > devices may get probed after the controller driver and will no longer have
> > > ASPM enabled. So users started noticing high runtime power consumption with
> > > WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> > > T14s, etc...
> > 
> > Note the ASPM regression for ath11k/ath12k only happened in 6.15, so
> > commit b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed
> > before PCI client drivers") in 6.13 does not seem to be the immediate
> > culprit here.
> 
> This series was intented to fix the ASPM issue which exist even before the
> introduction of pwrctrl framework.

But this limitation of the ASPM enable implementation wasn't really an
issue before pwrctrl since, as you point out above, these controllers
are not hotplug capable.

> But I also agree that the below commits made
> the issue more visible and caused regression on platforms where WLAN used to
> work.
> 
> > Candidates from 6.15 include commits like
> > 
> > 	957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> > 	2489eeb777af ("PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created")
> > 
> > This is probably related to the reports of these drivers sometimes
> > failing to probe with
> > 
> > 	ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134
> > 
> > after pwrctrl was merged, and which since 6.15 should instead result in
> > the drivers not probing at all (as we've discussed off list).
> 
> We discussed about the ASPM issue IIRC. The above mentioned of_irq_parse_pci
> could also be related to the fact that we are turning off the supplies after
> pci_dev destruction. For this issue, I guess the patch from Brian could be the
> fix:
> 
> https://lore.kernel.org/linux-pci/20250711174332.1.I623f788178c1e4c5b1a41dbfc8c7fa55966373c0@changeid/

We've also discussed the rc=134 issue, which appears to be due to some
pwrctrl race. IIRC, you thought it may be the bluetooth driver powering
down the bt/wlan controller before the wlan bit has had a chance to
(complete its) probe. Not sure if that was fully confirmed, but I
remember you saying that the rc=134 symptom would no longer be visible
since 6.15 and instead wlan would never even probe at all if we hit this
issue...

The patch you link to above only appears to relate to drivers being
manually unbound. I hope we're not also hitting such issues during
regular boot?

> > > Obviously, it is the pwrctrl change that caused regression, but it
> > > ultimately uncovered a flaw in the ASPM enablement logic of the controller
> > > driver. So to address the actual issue, switch to the bus notifier for
> > > enabling ASPM of the PCI devices. The notifier will notify the controller
> > > driver when a PCI device is attached to the bus, thereby allowing it to
> > > enable ASPM more reliably. It should be noted that the
> > > 'pci_dev::link_state', which is required for enabling ASPM by the
> > > pci_enable_link_state_locked() API, is only set by the time of
> > > BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
> > > during BUS_NOTIFY_ADD_DEVICE stage.
> > > 
> > > So with this, we can also get rid of the controller driver specific
> > > 'qcom_pcie_ops::host_post_init' callback.
> > > 
> > > Cc: stable@vger.kernel.org # v6.7
> > > Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> > 
> > So whatever form this fix ends up taking it only needs to be backported
> > to 6.15.
> > 
> > As you mention above these platforms do not support hotplug, but even if
> > they were, enabling ASPM for hotplugged devices is arguably more of a
> > new features than a bug fix.
> 
> FYI, I'm going to drop this series in favor this (with one yet-to-be-submitted
> patch on top):
> https://lore.kernel.org/linux-pci/20250720190140.2639200-1-david.e.box@linux.intel.com/

Sounds good. Thanks.

Johan

