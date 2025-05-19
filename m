Return-Path: <linux-pci+bounces-28034-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46376ABCA9B
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 00:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64501189DF8C
	for <lists+linux-pci@lfdr.de>; Mon, 19 May 2025 22:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA60202960;
	Mon, 19 May 2025 22:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fY1Ih3HJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D51DE887;
	Mon, 19 May 2025 22:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747692192; cv=none; b=XzRBdq+dawlFBNSBvOgKUQpYpb+ecMZ2tbQDgtxu7kUJY6+ngc5Odeuvr82kkxRTAHTy8JrJ9qywYU46dMirHQNCCAr35u4M2Uyk9yC98uCXLjuQBmvOsf0dg2R6tEfN1q74Skv2514Wdw7B0IZQU+p9qVIna37ztbDQWhAoYYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747692192; c=relaxed/simple;
	bh=dP8DTzm2DGeiuCXy2S920fdu9ae3F5qfO3VOTNqBlDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qN0XMSOCD+Zx6pXQGs2uhUL691f2sBbwfqlLN5XDLZ3Fj+QYqd1bx1qIU8/Sv82KmMa6oqeFoVtrRUxsMh0DG4l2Z78n3pR11qwwa0b/6EGS1YQHPYIp9/K77Mn3x+zGHF0vp1gO2ncrICGyfnp+Cj0vZCdL1407RNK2s8Cne+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fY1Ih3HJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2379C4CEE4;
	Mon, 19 May 2025 22:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747692191;
	bh=dP8DTzm2DGeiuCXy2S920fdu9ae3F5qfO3VOTNqBlDQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fY1Ih3HJDv1BXFOaah3htNOB7+kdjIfLm1whO3wWOOdiW3eWfYYLWosKGrHKP7BVx
	 LD9CD1LJtESRSDjfxmSpuVrFkne42Z9yas3F52WtjgpUcScId9doSWSDTYB06j5Xc6
	 2fTmvdGfPSvP+fqYC9Sjf3o9yKTS+NaBat7bIgYkuTDavFNAWJ278cilzD2SuYT85m
	 aGHAqyAyqTDFiT3BU2qU+CrdhVwStwurrta6JIMztmfiycDJsirpJg06pYtwuJfrEL
	 t0B9/oHhT7xiYErIZdBXySyp/gkQUaFkVp61GB1I/9eRGPWjSvwWeKakgamdW6NmXK
	 257opCzTtmGpQ==
Date: Mon, 19 May 2025 17:03:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: bhelgaas@google.com, tglx@linutronix.de, kw@linux.com,
	manivannan.sadhasivam@linaro.org, mahesh@linux.ibm.com,
	oohall@gmail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/4] pci: implement "pci=aer_panic"
Message-ID: <20250519220310.GA1258923@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516165518.125495-1-18255117159@163.com>

On Sat, May 17, 2025 at 12:55:14AM +0800, Hans Zhang wrote:
> The following series introduces a new kernel command-line option aer_panic
> to enhance error handling for PCIe Advanced Error Reporting (AER) in
> mission-critical environments. This feature ensures deterministic recover
> from fatal PCIe errors by triggering a controlled kernel panic when device
> recovery fails, avoiding indefinite system hangs.

We try very hard not to add new kernel parameters.

It sounds like part of the problem is the use of SPI interrupts rather
than the PCIe-architected INTx/MSI/MSI-X.  I'm not sure this warrants
generic upstream code changes.  This might be something you need to
maintain out-of-tree.

> Problem Statement
> In systems where unresolved PCIe errors (e.g., bus hangs) occur,
> traditional error recovery mechanisms may leave the system unresponsive
> indefinitely. This is unacceptable for high-availability environment
> requiring prompt recovery via reboot.
> 
> Solution
> The aer_panic option forces a kernel panic on unrecoverable AER errors.
> This bypasses prolonged recovery attempts and ensures immediate reboot.
> 
> Patch Summary:
> Documentation Update: Adds aer_panic to kernel-parameters.txt, explaining
> its purpose and usage.
> 
> Command-Line Handling: Implements pci=aer_panic parsing and state
> management in PCI core.
> 
> State Exposure: Introduces pci_aer_panic_enabled() to check if the panic
> mode is active.
> 
> Panic Trigger: Modifies recovery logic to panic the system when recovery
> fails and aer_panic is enabled.
> 
> Impact
> Controlled Recovery: Reduces downtime by replacing hangs with immediate
> reboots.
> 
> Optional: Enabled via pci=aer_panic; no default behavior change.
> 
> Dependency: Requires CONFIG_PCIEAER.
> 
> For example, in mobile phones and tablets, when there is a problem with
> the PCIe link and it cannot be restored, it is expected to provide an
> alternative method to make the system panic without waiting for the
> battery power to be completely exhausted before restarting the system.
> 
> ---
> For example, the sm8250 and sm8350 of qcom will panic and restart the
> system when they are linked down.
> 
> https://github.com/DOITfit/xiaomi_kernel_sm8250/blob/d42aa408e8cef14f4ec006554fac67ef80b86d0d/drivers/pci/controller/pci-msm.c#L5440
> 
> https://github.com/OnePlusOSS/android_kernel_oneplus_sm8350/blob/13ca08fdf0979fdd61d5e8991661874bb2d19150/drivers/net/wireless/cnss2/pci.c#L950
> 
> 
> Since the design schemes of each SOC manufacturer are different, the AXI
> and other buses connected by PCIe do not have a design to prevent hanging.
> Once a FATAL error occurs in the PCIe link and cannot be restored, the
> system needs to be restarted.
> 
> 
> Dear Mani,
> 
> I wonder if you know how other SoCs of qcom handle FATAL errors that occur
> in PCIe link.
> ---
> 
> Hans Zhang (4):
>   pci: implement "pci=aer_panic"
>   PCI/AER: Introduce aer_panic kernel command-line option
>   PCI/AER: Expose AER panic state via pci_aer_panic_enabled()
>   PCI/AER: Trigger kernel panic on recovery failure if aer_panic is set
> 
>  .../admin-guide/kernel-parameters.txt          |  7 +++++++
>  drivers/pci/pci.c                              |  2 ++
>  drivers/pci/pci.h                              |  4 ++++
>  drivers/pci/pcie/aer.c                         | 18 ++++++++++++++++++
>  drivers/pci/pcie/err.c                         |  8 ++++++--
>  5 files changed, 37 insertions(+), 2 deletions(-)
> 
> 
> base-commit: fee3e843b309444f48157e2188efa6818bae85cf
> prerequisite-patch-id: 299f33d3618e246cd7c04de10e591ace2d0116e6
> prerequisite-patch-id: 482ad0609459a7654a4100cdc9f9aa4b671be50b
> -- 
> 2.25.1
> 

