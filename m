Return-Path: <linux-pci+bounces-24667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98C88A70241
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 14:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22A9E19A1C8D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 13:36:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9C9225C710;
	Tue, 25 Mar 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C/hJF1Wq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F611DE8B4;
	Tue, 25 Mar 2025 13:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742909497; cv=none; b=THF0C8qoaIrvRu7fjFYWISrP9UdHOUf/zlt9OEy56tezezigtQsjan7anpZy/FhmxVuABlmsSWpfAb0BGWpxiwqlj4qJ3qPqC9Cd1xaD8mEFPbNI0oB5KSgyae+NJX3laQ8hqEDfQwoGCqTUT8U3pTHfpg7kIyKAHdlHV3qjpi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742909497; c=relaxed/simple;
	bh=GQ0OSrkpXzh86AWjzuws2IWSbtpMjCSYAmwHhrKpEKs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U68vYp5o/k6MpHQ8A3caAwZ7mRadfEa1s3BmX/FVjPBKx1fedVvXmXcK9exLHTY3Q8p2VEzl9wvLwPZ445jU+iMi9WBASAZP8d0XSRX2Wyjh3ZDhSbQaBEW0l/Qo04MwKvuWKsF/51eFW6ZIcYZGsVJxcjmEtHObkjP5QywJJ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C/hJF1Wq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04CAC4CEE4;
	Tue, 25 Mar 2025 13:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742909496;
	bh=GQ0OSrkpXzh86AWjzuws2IWSbtpMjCSYAmwHhrKpEKs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C/hJF1Wq2qMQCh1xCP+ds2qNFt0FUdt8os2fzl9sKpawHLMgTMbrNJLqjnwsNiBBJ
	 iT7ruZgeCbxf3H8k9+vXz/s8aF+zEufqtLseKxsgRHzBrpuVB70HA+Mhp9mZRGYB43
	 ZOmVybQ4HbNrkexYjkkKWO4xqBkThLJ8sCVasLVRLkzW5Cmqt9jCza0wV2iOwccxjR
	 nCN0p39F157IBcc69OySumhd+ysZuh9w4xIcQhr5M8n54Evbbt+Zlpy7SgUunFYnbF
	 jnecHXidiRMZMKkWuBF+QKO9XKNYTo/9qo3CTk+XvPBOHyxLygtT26aduvdQCe9FjK
	 NqVApGeTkJvww==
Date: Tue, 25 Mar 2025 08:31:35 -0500
From: Rob Herring <robh@kernel.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Alyssa Rosenzweig <alyssa@rosenzweig.io>,
	Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>,
	Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 00/13] PCI: apple: Add support for t6020
Message-ID: <20250325133135.GB1717731-robh@kernel.org>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>

On Tue, Mar 25, 2025 at 10:25:57AM +0000, Marc Zyngier wrote:
> As Alyssa didn't have the bandwidth to deal with this series, I have
> taken it over. All bugs are therefore mine.
> 
> The initial series [1] stated:
> 
> "This series adds T6020 support to the Apple PCIe controller. Mostly
>  Apple shuffled registers around (presumably to accommodate the larger
>  configurations on those machines). So there's a bit of churn here but
>  not too much in the way of functional changes."
> 
> The biggest change is affecting the ECAM layer, allowing an ECAM
> driver to provide its own probe function instead of relying on the
> .init() callback to do the work. The ECAM layer can therefore be used
> as a library instead of a convoluted driver.
> 
> The rest is a mix of bug fixes, cleanups, and required abstraction.
> 
> This has been tested on T6020 (M2-Pro mini) and T8102 (M1 mini).
> 
> * From v1[1]:
> 
>   - Described the PHY registers in the DT binding
> 
>   - Extracted a ecam bridge creation helper from the host-common layer
> 
>   - Moved probing into its own function instead of pci_host_common_probe()
>     
>   - Moved host-specific data to the of_device_id[] table
> 
>   - Added dynamic allocation of the RID/SID bitmap
> 
>   - Fixed latent bug in RC-generated interrupts
> 
>   - Renamed reg_info to hw_info
> 
>   - Dropped useless max_msimap
> 
>   - Dropped code being moved around without justification
> 
>   - Re-split some of the patches to follow a more logical progression
> 
>   - General cleanup to fit my own taste
> 
> [1] https://lore.kernel.org/r/20250211-pcie-t6-v1-0-b60e6d2501bb@rosenzweig.io
> 
> Alyssa Rosenzweig (1):
>   dt-bindings: pci: apple,pcie: Add t6020 compatible string
> 
> Hector Martin (6):
>   PCI: apple: Fix missing OF node reference in apple_pcie_setup_port
>   PCI: apple: Move port PHY registers to their own reg items
>   PCI: apple: Drop poll for CORE_RC_PHYIF_STAT_REFCLK
>   PCI: apple: Use gpiod_set_value_cansleep in probe flow
>   PCI: apple: Abstract register offsets via a SoC-specific structure
>   PCI: apple: Add T602x PCIe support
> 
> Janne Grunau (1):
>   PCI: apple: Set only available ports up
> 
> Marc Zyngier (5):
>   PCI: host-generic: Extract an ecam bridge creation helper from
>     pci_host_common_probe()
>   PCI: ecam: Allow cfg->priv to be pre-populated from the root port
>     device
>   PCI: apple: Move over to standalone probing
>   PCI: apple: Dynamically allocate RID-to_SID bitmap
>   PCI: apple: Move away from INTMSK{SET,CLR} for INTx and private
>     interrupts
> 
>  .../devicetree/bindings/pci/apple,pcie.yaml   |  11 +-
>  drivers/pci/controller/pci-host-common.c      |  24 +-
>  drivers/pci/controller/pcie-apple.c           | 241 +++++++++++++-----
>  drivers/pci/ecam.c                            |   2 +
>  include/linux/pci-ecam.h                      |   2 +
>  5 files changed, 204 insertions(+), 76 deletions(-)

For the series,

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

