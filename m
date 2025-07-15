Return-Path: <linux-pci+bounces-32134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E082B055F1
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:11:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7691AA66C3
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022072D5423;
	Tue, 15 Jul 2025 09:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxebXu42"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C530526F45D;
	Tue, 15 Jul 2025 09:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752570692; cv=none; b=OpVdcjouVFmNWdQXIS1THF2uyfF/ObvCdFgmrr1mamx0h2zh8ZsxgbnqvfKO0zZ/NXZILS4XA7j7BUUQfyBBIJVnRqMEyyjVaatjeWaZ9JZcXrawxfb+uU7iDn4hRXmnwguoDFwHbEhH3wmDgDbJ7XrtLsJHNZZxMtjssL1Ds6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752570692; c=relaxed/simple;
	bh=dA3vtbmlttdZvCGMv8d9ESUIzy2yXosr7aHy1zK5CiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KonOQQZWtGSu/aDLr8numxXhbAX+0E9aYp+PY2DSW8CWArsBbUZmY3RAK+3UJYhBlrmym7mwnysJbTzC940UDIeeW3CKl8JjfacXlZ/n+bYRaeZ3YohajvagrnObHtcGkHndn5GTczGa17spbLIqBh3JlgzfQLRMACcMec0NI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxebXu42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FF63C4CEE3;
	Tue, 15 Jul 2025 09:11:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752570692;
	bh=dA3vtbmlttdZvCGMv8d9ESUIzy2yXosr7aHy1zK5CiI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IxebXu42e3BWhhhayhaKwQypECLIVDfNz7bzt+rMxXn5vd1IjB70gu+oeaX+E53XG
	 vUs9V6AX94CB2DdMzehafN/x8JDjQWKJRtxNLH/ilzY5pDwai5XdzwniJYUQT4wCdf
	 OxC0gyYTeecm7ockLqzOfuhqwFG4gBDMaZB3zL8myuTxOVUs+CCHBCXJR6xlpcGQHV
	 Pm8swbFx7m5BZ7m6m/+qDykTrscJjhpgu/SqLUZethNpdXAOINRaGrKJd/RHXDjGLn
	 DSJpiM7M3k46J2biwOVMgZqLN79ddZdjZtzF26ZKBFEQONQgpMN9Yub3TfWqlokCJO
	 vJqx/qPCeTFIw==
Date: Tue, 15 Jul 2025 14:41:23 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <yqot334mqik74bb7rmoj27kfppwfb4fvfk2ziuczwsylsff4ll@oqaozypwpwa2>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
 <aHYHzrl0DE2HV86S@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aHYHzrl0DE2HV86S@hovoldconsulting.com>

On Tue, Jul 15, 2025 at 09:48:30AM GMT, Johan Hovold wrote:
> On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:
> > Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> > ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> > enumerated at the time of the controller driver probe. It proved to be
> > useful for devices already powered on by the bootloader as it allowed
> > devices to enter ASPM without user intervention.
> > 
> > However, it could not enable ASPM for the hotplug capable devices i.e.,
> > devices enumerated *after* the controller driver probe. This limitation
> > mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> > and also the bootloader has been enabling the PCI devices before Linux
> > Kernel boots (mostly on the Qcom compute platforms which users use on a
> > daily basis).
> > 
> > But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> > pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> > started to block the PCI device enumeration until it had been probed.
> > Though, the intention of the commit was to avoid race between the pwrctrl
> > driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> > devices may get probed after the controller driver and will no longer have
> > ASPM enabled. So users started noticing high runtime power consumption with
> > WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> > T14s, etc...
> > 
> > Obviously, it is the pwrctrl change that caused regression, but it
> > ultimately uncovered a flaw in the ASPM enablement logic of the controller
> > driver. So to address the actual issue, switch to the bus notifier for
> > enabling ASPM of the PCI devices. The notifier will notify the controller
> > driver when a PCI device is attached to the bus, thereby allowing it to
> > enable ASPM more reliably. It should be noted that the
> > 'pci_dev::link_state', which is required for enabling ASPM by the
> > pci_enable_link_state_locked() API, is only set by the time of
> > BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
> > during BUS_NOTIFY_ADD_DEVICE stage.
> 
> A problem with this approach is that ASPM will never be enabled (and
> power consumption will be higher) in case an endpoint driver is missing.
> 

I'm aware of this limiation. But I don't think we should really worry about that
scenario. No one is going to run an OS intentionally with a PCI device and
without the relevant driver. If that happens, it might be due to some issue in
driver loading or the user is doing it intentionally. Such scenarios are short
lived IMO.

> I think that's something we should try to avoid.
> 

I would've fancied a bus notifier post device addition, but there is none
available and I don't see a real incentive in adding one. The other option
would be to add an ops to 'struct pci_host_bridge', but I really try not to
introduce such thing unless really manadatory.

> > So with this, we can also get rid of the controller driver specific
> > 'qcom_pcie_ops::host_post_init' callback.
> > 
> > Cc: stable@vger.kernel.org # v6.7
> > Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")
> > Reported-by: Johan Hovold <johan@kernel.org>
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> Note that the patch fails to apply to 6.16-rc6 due to changes in
> linux-next. Depending on how fast we can come up with a fix it may be
> better to target 6.16.
> 

I rebased this series on top of pci/controller/qcom branch, where we have some
dependency. But I could spin an independent fix if Bjorn is OK to take it for
the 6.16-rcS.

> > -static int qcom_pcie_enable_aspm(struct pci_dev *pdev, void *userdata)
> > -{
> > -	/*
> > -	 * Downstream devices need to be in D0 state before enabling PCI PM
> > -	 * substates.
> > -	 */
> > -	pci_set_power_state_locked(pdev, PCI_D0);
> > -	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> > -
> > -	return 0;
> > -}
> 
> I think you should consider leaving this helper in place here to keep
> the size of the diff down (e.g. as you intend to backport this).
> 

Ok.

> > +static int qcom_pcie_enable_aspm(struct pci_dev *pdev)
> > +{
> > +	/*
> > +	 * Downstream devices need to be in D0 state before enabling PCI PM
> > +	 * substates.
> > +	 */
> > +	pci_set_power_state_locked(pdev, PCI_D0);
> > +	pci_enable_link_state_locked(pdev, PCIE_LINK_STATE_ALL);
> 
> You need to use the non-locked helpers here since you no longer hold the
> bus semaphore (e.g. as reported by lockdep).
> 

Good catch!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

