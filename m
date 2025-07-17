Return-Path: <linux-pci+bounces-32468-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0DDB097DF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Jul 2025 01:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9BB51A618A7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Jul 2025 23:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FA4525229D;
	Thu, 17 Jul 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fV2uaaF/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DF3246333;
	Thu, 17 Jul 2025 23:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752794874; cv=none; b=u1ze5fCBWUlVVTl+jp1KjOBQYEl+JStm40AB5kqBB38dPyX4d8bk/lwZykaJow0zVpxYuPVeHzVSopNBclGzZk4QtomlNiz7SIu8R77/qsf5IHUFTv6RqJPFfaUk+BH0qPcJYSDcp53xnp+HQF6nmjonb4SnMswJ5Ph25dYdCro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752794874; c=relaxed/simple;
	bh=gUcGYfzCeZmmt4ywQvW8HSqnd9GF3VugZdhGeqSei0A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=G2lhevz4Wx1TJ58UPocwb1K3uL8Z8hxleG6963GFaE+1EDjZM+C2M+yHqlG4ndjEtgAsS8TAaC8j4zeWKZ2SzQRejitPJyY0lmLPcDh+MuBf/jv3vuM6URPZ/7B0lqr/CsMs4xAeZV3Z67c/YKQhyYGJvMpguJJ/L8yThDjhCAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fV2uaaF/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F58C4CEE3;
	Thu, 17 Jul 2025 23:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752794873;
	bh=gUcGYfzCeZmmt4ywQvW8HSqnd9GF3VugZdhGeqSei0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fV2uaaF/rmEO416KIQxD5hyt4Fpd5Gs637LHx6NBRs3u/MLMNgzUOu+oi1uUwfnh3
	 zTlJg5y/DoOjQor8B7wM3pSYR8nL458QpLQBtFNzJ2PdZKpsQvpv6RBPMu4S4I2WwB
	 d56VzB7Uzs0k4wABIO/C3nX8MDwOWQp1rh59mm1NqwbGUtWn4C+hVZDkA2tbSOMbJR
	 TjfPQrGFevj8angJFrC2Tl9hh4ZN3yACVr1SGjJvlaeNe5IEfUSe+f06RgldmYPEDL
	 xrO0gMljRS6LpGm3yiT04Lv4WGx+PLHhWc3bBpC/Dt7iX1TyAgw+jh3Oy8W9swFInt
	 5lnmKj4/ydB7Q==
Date: Thu, 17 Jul 2025 18:27:52 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH v3 0/6] PowerNV PCIe Hotplug Driver Fixes
Message-ID: <20250717232752.GA2662535@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1268570622.1359844.1752615109932.JavaMail.zimbra@raptorengineeringinc.com>

On Tue, Jul 15, 2025 at 04:31:49PM -0500, Timothy Pearson wrote:
> Hello all,
> 
> This series includes several fixes for bugs in the PowerNV PCIe hotplug
> driver that were discovered in testing with a Microsemi Switchtec PM8533
> PFX 48xG3 PCIe switch on a PowerNV system, as well as one workaround for
> PCIe switches that don't correctly implement slot presence detection
> such as the aforementioned one. Without the workaround, the switch works
> and downstream devices can be hot-unplugged, but the devices never come
> back online after being plugged in again until the system is rebooted.
> Other hotplug drivers (like pciehp_hpc) use a similar workaround.
> 
> Also included are fixes for the EEH driver to make it hotplug safe,
> and a small patch to enable all three attention indicator states per
> the PCIe specification.
> 
> Thanks,
> 
> Shawn Anastasio (2):
>   PCI: pnv_php: Properly clean up allocated IRQs on unplug
>   PCI: pnv_php: Work around switches with broken presence detection
> 
> Timothy Pearson (4):
>   powerpc/eeh: Export eeh_unfreeze_pe()
>   powerpc/eeh: Make EEH driver device hotplug safe
>   PCI: pnv_php: Fix surprise plug detection and recovery
>   PCI: pnv_php: Enable third attention indicator state
> 
>  arch/powerpc/kernel/eeh.c         |   1 +
>  arch/powerpc/kernel/eeh_driver.c  |  48 ++++--
>  arch/powerpc/kernel/eeh_pe.c      |  10 +-
>  arch/powerpc/kernel/pci-hotplug.c |   3 +
>  drivers/pci/hotplug/pnv_php.c     | 244 +++++++++++++++++++++++++++---
>  5 files changed, 263 insertions(+), 43 deletions(-)

I'm OK with this from a PCI perspective, and I optimistically put it
on pci/hotplug.

I'm happy to merge via the PCI tree, but would need acks from the
powerpc folks for the arch/powerpc parts.

Alternatively it could be merged via powerpc with my ack on the
drivers/pci patches:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

If you do merge via powerpc, I made some comment formatting and commit
log tweaks that I would like reflected in the drivers/pci part.  These
are on
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=hotplug

Bjorn

