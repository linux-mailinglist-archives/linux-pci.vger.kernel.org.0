Return-Path: <linux-pci+bounces-39563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15FF1C163D6
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 18:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9355D4028D0
	for <lists+linux-pci@lfdr.de>; Tue, 28 Oct 2025 17:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE75F34AB04;
	Tue, 28 Oct 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NImirUq+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B07B3491C7
	for <linux-pci@vger.kernel.org>; Tue, 28 Oct 2025 17:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761673167; cv=none; b=rzxZWUgH/nvRTlrmK/8n6cU7GZTOfswBCeCYT3xkLv/PldaZjHwn/Yc2b+wlKCDNZCinY01HZaa36q2Tq7nYcZzGJ1Uh0QblIgkhJxPP3T2gullDNB2Jpn2DIfehbfgDZDOKuug+dBNky3n11qlMtnzUv/RIl6kZKD4oXgthVyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761673167; c=relaxed/simple;
	bh=43iMw79Akew6Y/DGXSUT2s4gddhbkot1XZcDv9EWZGo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=W2ffQMjALsgU8tHg79ekqgCmjEFymf8tlMwLR2VvQoVoDxGjGTtzv9GNNSXHrtCqv5Tpk2Udnt3S7qSil/BmbxOQzmJ6mWjqkgBnqr/7rt4MTXbynG5v3GZwc/iYYLLd4tFX7luKzNeb4TAzMf7w5jyFjgTf4uT8tScxwmYIvvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NImirUq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E700DC113D0;
	Tue, 28 Oct 2025 17:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761673167;
	bh=43iMw79Akew6Y/DGXSUT2s4gddhbkot1XZcDv9EWZGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NImirUq+EfQL0KI+eJQnp2hAgXypXuPAn/qNtljMrgA7VP++JvQY2HVFu8pVeRRiK
	 lEXGks5/FDcMd9uNWkUa7x3h7PMmfjwVyKtm+MbBxLgoyQgIZF3ShhvQm3V+IRN71G
	 WlnYAmmj88vTGxMVBG6c8bIX6wl8YUUn7P3FhNXCEr8Z3pg7Qg8y3OVQlCo1Z3btse
	 Kkch/nUp9STwgrJm/HZGFFKKsf8KfvDSV3PfqBLdScRZHdno/aRO93h+4ewAiGPMLp
	 jXr8Sow0woH5/MskYDXQTv3xf7pnqGEZxqMIPZ879e6A5BL480JjHTWysq/jDPITI1
	 CZ3M3AQu+UfDQ==
Date: Tue, 28 Oct 2025 12:39:25 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	jonathan.derrick@linux.dev, lpieralisi@kernel.org,
	kwilczynski@kernel.org, mani@kernel.org, robh@kernel.org,
	Dexuan Cui <decui@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Szymon Durawa <szymon.durawa@linux.intel.com>,
	Wei Liu <wei.liu@kernel.org>
Subject: Re: [PATCH v2 0/2] PCI: Unify domain emulation
Message-ID: <20251028173925.GA1521899@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251024224622.1470555-1-dan.j.williams@intel.com>

On Fri, Oct 24, 2025 at 03:46:20PM -0700, Dan Williams wrote:
> Changes since v1 [1]:
> - Rebase on v6.18-rc2
> - Support callers supplying both a hint and a range for the Hyper-V hint
>   + fallback case (Michael)
> - Add comment explaining domain number 0 vs Gen1 VMs, and domain values
>   greater than U16_MAX concerns (Michael)
> - Leave the VMD status quo comment about requesting domain numbers >
>   U16_MAX
> 
> [1]: http://lore.kernel.org/20250716160835.680486-1-dan.j.williams@intel.com
> 
> The PCI/TSM effort created a sample driver to test ABI flows
> (samples/devsec/ [2]). Suzuki observed that it only worked on x86 due to
> its dependency on CONFIG_PCI_DOMAINS_GENERIC=n. I.e. an unfortunate
> restriction for what should be an architecture agnostic test framework.
> 
> Introduce a new pci_bus_find_emul_domain_nr() helper that all "soft"
> host-bridge drivers can share and hide the CONFIG_PCI_DOMAINS_GENERIC
> details behind that helper.
> 
> [2]: https://git.kernel.org/pub/scm/linux/kernel/git/devsec/tsm.git/commit/?id=0e16ce0b9c64
> 
> Dan Williams (2):
>   PCI: Enable host bridge emulation for PCI_DOMAINS_GENERIC platforms
>   PCI: vmd: Switch to pci_bus_find_emul_domain_nr()
> 
>  include/linux/pci.h                 |  7 ++++
>  drivers/pci/controller/pci-hyperv.c | 62 +++++------------------------
>  drivers/pci/controller/vmd.c        | 40 ++++++++-----------
>  drivers/pci/pci.c                   | 24 ++++++++++-
>  drivers/pci/probe.c                 |  8 +++-
>  5 files changed, 63 insertions(+), 78 deletions(-)

Applied to pci/enumeration for v6.19, thanks, Dan!

