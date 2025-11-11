Return-Path: <linux-pci+bounces-40932-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B5462C4F33C
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 18:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6934EF196
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 17:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE6D3730D5;
	Tue, 11 Nov 2025 17:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VMrrB04H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E707A36C5A5;
	Tue, 11 Nov 2025 17:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762881087; cv=none; b=oyri8DOGSQx6kvAuPcn8018nKsNKBtfkAY3UMWpttR7Xf+JtuQWr9p8NnYrBtPDvQ00YVVKcmwqKFaMoXW7obP4T6WHK+NFXflS4EVf9rMqA1eg7yvskGaUvCu4+X9u2KImWV/nOsTBCC8iPmCp0O69Qt6ImVM81ZmWvza1yYLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762881087; c=relaxed/simple;
	bh=hcx3kqxeym77bbJLLtwlcnxx3jS2uIEgaTgsEvo3Xus=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=BdaGH8SlUJA0eORcLGEXmeDQqwbWXJ/Ndq1zJ2RGG7NfLJhxhy0hRv+hNS2EHz4Pk5DjMxeJNQWtbbUI3fpDzo+fdaCD43a1Hwc+V2bNlUKlVm2KRXAipQ48RdvisEoqdxUFJXOCQwQWff5Lwhn8PKZIv3wc4YnGcbB38mQASxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VMrrB04H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4CDC4CEF5;
	Tue, 11 Nov 2025 17:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762881086;
	bh=hcx3kqxeym77bbJLLtwlcnxx3jS2uIEgaTgsEvo3Xus=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VMrrB04HC6Rbdk8JBTtD67Kap0a4hAl3f71LUuqQHq9oNd9HQM/ghjkXs2HHhoAoV
	 NspHrhdvzdikKHLg03zzpy1TNfOiKnwYElpfYbkprM77UPcL4XzLld+1oFpEF8bMXG
	 wamXHjUTaMHFzLv1BjBQfvE2D230bwdPaP8PDXHQVLpUk8e7yaEbVwFQMqJL1NTP70
	 l/TAtGPfwYb3j0TUUfd1BkC+dieQc91z9maVC+QHyAjnmYS5xaSo+c8FYumLgWbsbJ
	 S6dgV/VMceHXgQ5wG/q+hgYBdzZqXu7t7fhzjtg7vPhkQ43erzX6t3XMnTjbwaVVFy
	 oWgTD+js+ojiQ==
Date: Tue, 11 Nov 2025 11:11:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: linux-pci@vger.kernel.org
Cc: Christian Zigotzky <chzigotzky@xenosoft.de>,
	Manivannan Sadhasivam <mani@kernel.org>,
	mad skateman <madskateman@gmail.com>,
	"R . T . Dickinson" <rtd2@xtra.co.nz>,
	Darren Stevens <darren@stevens-zone.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Lukas Wunner <lukas@wunner.de>,
	luigi burdo <intermediadc@hotmail.com>, Al <al@datazap.net>,
	Roland <rol7and@gmx.com>, Hongxing Zhu <hongxing.zhu@nxp.com>,
	hypexed@yahoo.com.au, linuxppc-dev@lists.ozlabs.org,
	debian-powerpc@lists.debian.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/4] PCI/ASPM: Allow quirks to avoid L0s and L1
Message-ID: <20251111171125.GA2190513@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251110222929.2140564-1-helgaas@kernel.org>

On Mon, Nov 10, 2025 at 04:22:24PM -0600, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> We enabled ASPM too aggressively in v6.18-rc1.  f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms") enabled ASPM
> L0s, L1, and (if advertised) L1 PM Substates.
> 
> df5192d9bb0e ("PCI/ASPM: Enable only L0s and L1 for devicetree platforms")
> (v6.18-rc3) backed off and omitted Clock PM and L1 Substates because we
> don't have good infrastructure to discover CLKREQ# support, and L1
> Substates may require device-specific configuration.
> 
> L0s and L1 are generically discoverable and should not require
> device-specific support, but some devices advertise them even though they
> don't work correctly.  This series is a way to add quirks avoid L0s and L1
> in this case.
> 
> 
> Bjorn Helgaas (4):
>   PCI/ASPM: Cache L0s/L1 Supported so advertised link states can be
>     overridden
>   PCI/ASPM: Add pcie_aspm_remove_cap() to override advertised link
>     states
>   PCI/ASPM: Convert quirks to override advertised link states
>   PCI/ASPM: Avoid L0s and L1 on Freescale Root Ports
> 
>  drivers/pci/pci.h       |  2 ++
>  drivers/pci/pcie/aspm.c | 25 +++++++++++++++++--------
>  drivers/pci/probe.c     |  7 +++++++
>  drivers/pci/quirks.c    | 38 +++++++++++++++++++-------------------
>  include/linux/pci.h     |  2 ++
>  5 files changed, 47 insertions(+), 27 deletions(-)

Applied to pci/for-linus, hoping for v6.18.  Thanks Shawn and Lukas
for testing and reviewing.  Any other comments and testing would be
very welcome.

I think we'll need to add a similar quirk for Christian's X1000
(https://lore.kernel.org/r/a41d2ca1-fcd9-c416-b111-a958e92e94bf@xenosoft.de),
but I don't know the device ID for it yet.

> -- 
> 
> v1: https://lore.kernel.org/r/20251106183643.1963801-1-helgaas@kernel.org
> 
> Changes between v1 and v2:
> - Cache just the two bits for L0s and L1 support, not the entire Link
>   Capabilities (Lukas)
> - Add pcie_aspm_remove_cap() to override the ASPM Support bits in Link
>   Capabilities (Lukas)
> - Convert existing quirks to use pcie_aspm_remove_cap() instead of
>   pci_disable_link_state(), and from FINAL to HEADER (Mani)

