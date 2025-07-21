Return-Path: <linux-pci+bounces-32632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20825B0C05E
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70DC47AA4C6
	for <lists+linux-pci@lfdr.de>; Mon, 21 Jul 2025 09:31:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C9F28BA91;
	Mon, 21 Jul 2025 09:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZQbybIX6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4767289829;
	Mon, 21 Jul 2025 09:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090377; cv=none; b=QXMFHYZRw7SXmS7kQ33NXVRMPyjwwhS91/ehPr1EO7CLTirYQNlDdYX1WJqiMn7B2VZvODTJ8iZxjEjh/5iVdW/n8fx7ayCfMfLTO96hAwINNdiW0d1++BB7MXyRfioRyfG3gr66WtYYP8loxcthQ1MZkpmJMAExQzoM+QRduPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090377; c=relaxed/simple;
	bh=G/pV0nbnRZ4r5eBiZNsOigHUJIR41TgGEVYX+SY2ajc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQQG5ifwyFPZupGZ9rVd/JjKYM2xOZAcGqxvvX6uxOKxnZmfJe6jbcHGOq2a4H4qwDsI4go4AgazKRzP5fz7mAJoTeRrVdMRFS8EDQI/oggGd9l0sY6rh/OAuLQYSFPyAtSD+dgDxFHgqcIUScHO7GdsL+BwENUdk9/6gOy8RDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZQbybIX6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF4EC4CEED;
	Mon, 21 Jul 2025 09:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090376;
	bh=G/pV0nbnRZ4r5eBiZNsOigHUJIR41TgGEVYX+SY2ajc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZQbybIX6jwkDs2/m2WDbbfszRQTrw2c1JTgcJM3fvzRwK9CBZITl8hTSpZ2cYg03B
	 sb1iOewloCiq7NJaywpAguERZAQluBx0Z2rgj587jjswrXtyCxPEsNbKCVRwfTHdT+
	 4axTuNEzRCpXNBmse5L5T1e2wK3g3GDLC38RR9Jfvtq6J2GoSQ5jNss3wk4bfMJcJ6
	 /j1nvpL4lXnCuMFDj0IEUKxxAR8fYuPV7BKvTZqGMinAL9oSJsPaHaoSluli887hrg
	 RPcfXcZN3kytMQTltGxTcOXzyRF+a/Ju/96f56PhKQgHyiH7lSIdhpVERAT8phkVJu
	 CRW4ruxFldhOQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1udmt2-000000006sA-3x9F;
	Mon, 21 Jul 2025 11:32:45 +0200
Date: Mon, 21 Jul 2025 11:32:44 +0200
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: qcom: Switch to bus notifier for enabling ASPM
 of PCI devices
Message-ID: <aH4JPBIk_GEoAezy@hovoldconsulting.com>
References: <20250714-aspm_fix-v1-0-7d04b8c140c8@oss.qualcomm.com>
 <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250714-aspm_fix-v1-1-7d04b8c140c8@oss.qualcomm.com>

On Mon, Jul 14, 2025 at 11:31:04PM +0530, Manivannan Sadhasivam wrote:
> Commit 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0
> ops") allowed the Qcom controller driver to enable ASPM for all PCI devices
> enumerated at the time of the controller driver probe. It proved to be
> useful for devices already powered on by the bootloader as it allowed
> devices to enter ASPM without user intervention.
> 
> However, it could not enable ASPM for the hotplug capable devices i.e.,
> devices enumerated *after* the controller driver probe. This limitation
> mostly went unnoticed as the Qcom PCI controllers are not hotplug capable
> and also the bootloader has been enabling the PCI devices before Linux
> Kernel boots (mostly on the Qcom compute platforms which users use on a
> daily basis).
> 
> But with the advent of the commit b458ff7e8176 ("PCI/pwrctl: Ensure that
> pwrctl drivers are probed before PCI client drivers"), the pwrctrl driver
> started to block the PCI device enumeration until it had been probed.
> Though, the intention of the commit was to avoid race between the pwrctrl
> driver and PCI client driver, it also meant that the pwrctrl controlled PCI
> devices may get probed after the controller driver and will no longer have
> ASPM enabled. So users started noticing high runtime power consumption with
> WLAN chipsets on Qcom compute platforms like Thinkpad X13s, and Thinkpad
> T14s, etc...

Note the ASPM regression for ath11k/ath12k only happened in 6.15, so
commit b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed
before PCI client drivers") in 6.13 does not seem to be the immediate
culprit here.

Candidates from 6.15 include commits like

	957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
	2489eeb777af ("PCI/pwrctrl: Skip scanning for the device further if pwrctrl device is created")

This is probably related to the reports of these drivers sometimes
failing to probe with

	ath12k_pci 0004:01:00.0: of_irq_parse_pci: failed with rc=134

after pwrctrl was merged, and which since 6.15 should instead result in
the drivers not probing at all (as we've discussed off list).

> Obviously, it is the pwrctrl change that caused regression, but it
> ultimately uncovered a flaw in the ASPM enablement logic of the controller
> driver. So to address the actual issue, switch to the bus notifier for
> enabling ASPM of the PCI devices. The notifier will notify the controller
> driver when a PCI device is attached to the bus, thereby allowing it to
> enable ASPM more reliably. It should be noted that the
> 'pci_dev::link_state', which is required for enabling ASPM by the
> pci_enable_link_state_locked() API, is only set by the time of
> BUS_NOTIFY_BIND_DRIVER stage of the notification. So we cannot enable ASPM
> during BUS_NOTIFY_ADD_DEVICE stage.
> 
> So with this, we can also get rid of the controller driver specific
> 'qcom_pcie_ops::host_post_init' callback.
> 
> Cc: stable@vger.kernel.org # v6.7
> Fixes: 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for platforms supporting 1.9.0 ops")

So whatever form this fix ends up taking it only needs to be backported
to 6.15.

As you mention above these platforms do not support hotplug, but even if
they were, enabling ASPM for hotplugged devices is arguably more of a
new features than a bug fix.

Johan

