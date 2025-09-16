Return-Path: <linux-pci+bounces-36285-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C1CB59F27
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 19:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3612B46365B
	for <lists+linux-pci@lfdr.de>; Tue, 16 Sep 2025 17:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989FE253B67;
	Tue, 16 Sep 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbtS+8sJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6963B247281;
	Tue, 16 Sep 2025 17:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758043278; cv=none; b=DaAt40B0Q/qrc7vRJHjdIAMO1uG2nZNirpQzI7BZH3VJ8p6TmXxuPvN+vX86zvvlrJY62XgmKThnOD9NYvyRrSWd57z8AgZINKvjRAW3pAw/FVWYmfjj5hoqGtMrEy2CKVF7iJLdWcKHXu8cBZBe50CUQvJN/eLIRfC3PkVlBh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758043278; c=relaxed/simple;
	bh=v9PZrVZhFy0HSlGw35h9CD/JQawJe2ljdG3SUb0+F4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ZucIP/jVSP8SkvOVOJ00BY0Y9L0APo7w06rYMkRPZgo/m9CwYnUDob04wENG1cHOROjkGubn2kjPnGX/A31kO9a38kaL08Yz1W4SQc70HubRyPpHJN5i3NCcENMGDg5WMPizR5jgeVF8B9QRTx2w9+o0pi48TpUa57Gi1orOi6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbtS+8sJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A5BC4CEEB;
	Tue, 16 Sep 2025 17:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758043278;
	bh=v9PZrVZhFy0HSlGw35h9CD/JQawJe2ljdG3SUb0+F4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=MbtS+8sJp3hz64X9CM9moepnjqS4AC4oqLhYkLH0OtClenOBgBUeHpLKZqeS4nAy2
	 GANHYdVSGZPliYt3KKE8VyFLMEdmQGrhSHf0xBBdgnk4mK6MF0H52pMK1ZclSlRIrd
	 5glKDSYi0xRaLTaaZOuACs5Q+2EK8xleQC6eTbzHWNwWRcnapmuMtcYsqmOp6X223r
	 KAXwFb7zrMQgfzAr+qPvpasRzJSY20aQS5Qy4UKIC2qMkMhUHsjpSeiTtp/23Yr5Sn
	 xURFMs8sq7a3TAZ0sJplqy2yMk9x4Eqnwey8SXxJ3rtwMKXCRtyDdAAigKHlULG0E5
	 G9mTPlJ2586YA==
Date: Tue, 16 Sep 2025 12:21:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: manivannan.sadhasivam@oss.qualcomm.com
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	"David E. Box" <david.e.box@linux.intel.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] PCI/ASPM: Enable ASPM and Clock PM by default on
 devicetree platforms
Message-ID: <20250916172116.GA1808269@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com>

[+cc Kai-Heng, Rafael; thread at
https://lore.kernel.org/r/20250916-pci-dt-aspm-v1-0-778fe907c9ad@oss.qualcomm.com]

On Tue, Sep 16, 2025 at 09:42:51PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> Hi,
> 
> This series is one of the 'let's bite the bullet' kind, where we have decided to
> enable all ASPM and Clock PM states by default on devicetree platforms [1]. The
> reason why devicetree platforms were chosen because, it will be of minimal
> impact compared to the ACPI platforms. So seemed ideal to test the waters.
> 
> Problem Statement
> =================
> 
> Historically, PCI subsystem relied on the BIOS to enable ASPM and Clock PM
> states for PCI devices before the kernel boot. This was done to avoid enabling
> ASPM for the buggy devices that are known to create issues with ASPM (even
> though they advertise the ASPM capability). But BIOS is not at all a thing on
> most of the non-x86 platforms. For instance, the majority of the Embedded and
> Compute ARM based platforms using devicetree have something called bootloader,
> which is not anyway near the standard BIOS used in x86 based platforms. And
> these bootloaders wouldn't touch PCIe at all, unless they boot using PCIe
> storage, even then there would be no guarantee that the ASPM states will get
> enabled. Another example is the Intel's VMD domain that is not at all configured
> by the BIOS. But, this series is not enabling ASPM/Clock PM for VMD domain. I
> hope it will be done similarly in the future patches.
> 
> Solution
> ========
> 
> So to avoid relying on BIOS, it was agreed [2] that the PCI subsystem has to
> enable ASPM and Clock PM states based on the device capability. If any devices
> misbehave, then they should be quirked accordingly.
> 
> First patch of this series introduces two helper functions to enable all ASPM
> and Clock PM states if CONFIG_OF is enabled. Second patch drops the custom ASPM
> enablement code from the pcie-qcom driver as it is no longer needed.
> 
> Testing
> =======
> 
> This series is tested on Lenovo Thinkpad T14s based on Snapdragon X1 SoC. All
> supported ASPM states are getting enabled for both the NVMe and WLAN devices by
> default.
> 
> [1] https://lore.kernel.org/linux-pci/a47sg5ahflhvzyzqnfxvpk3dw4clkhqlhznjxzwqpf4nyjx5dk@bcghz5o6zolk
> [2] https://lore.kernel.org/linux-pci/20250828204345.GA958461@bhelgaas
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
> Manivannan Sadhasivam (2):
>       PCI/ASPM: Override the ASPM and Clock PM states set by BIOS for devicetree platforms
>       PCI: qcom: Remove the custom ASPM enablement code
> 
>  drivers/pci/controller/dwc/pcie-qcom.c | 32 -----------------------
>  drivers/pci/pcie/aspm.c                | 48 ++++++++++++++++++++++++++++++----
>  2 files changed, 43 insertions(+), 37 deletions(-)
> ---
> base-commit: 8f5ae30d69d7543eee0d70083daf4de8fe15d585
> change-id: 20250916-pci-dt-aspm-8b3a7e8d2cf1
> 
> Best regards,
> -- 
> Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> 
> 

