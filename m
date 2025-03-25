Return-Path: <linux-pci+bounces-24675-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC01A70443
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F1D9F3AD968
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 14:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494B725B691;
	Tue, 25 Mar 2025 14:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b="zzqb1WC5"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73F125A34E
	for <linux-pci@vger.kernel.org>; Tue, 25 Mar 2025 14:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742914214; cv=none; b=oG6A3iYSAm4KEG91EtDjZh3Y1pLHk/O4iGCeQyIEkH5P5NcjYZ8urh7ATw8R5Ft0oAmGzyju76MCw7yKzpMW3bsfHkSv0uzNQ5qLpUvRtnpcWcNEiVmXmBRQJiZs9IZNdtsVSpWX9jFg4EWFAwok2+1gFtN8rmpkcBU36Ql62eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742914214; c=relaxed/simple;
	bh=m7HQhF5BiFf2it3+1htvmzKPX6UTZZRd8NpKtEuonqY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jp5MXLzwIabYV6qeCN6drCyzNhxckBekwTgCxYJxqhIxSBexjsWuPeRaHqzc3cR2rXWZj7GLdIjcZdbzFLxJKGBPLB3Dxk4PwfxiWFuxDWG8Ty8gANEQ7+yY/fNFj0GP7iPsMx0EONy1XsUqJSOuYwnkQg7SO1AWXUEhlYkWxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io; spf=pass smtp.mailfrom=rosenzweig.io; dkim=pass (2048-bit key) header.d=rosenzweig.io header.i=@rosenzweig.io header.b=zzqb1WC5; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rosenzweig.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rosenzweig.io
Date: Tue, 25 Mar 2025 10:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rosenzweig.io;
	s=key1; t=1742914208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gxsCj8x2vFQrcLLWFmNKJpZcqjgp3XJqcW6qauCB4FA=;
	b=zzqb1WC5mW/N93G+IA36ptJrmluUMrAolvskNckn8WdmMuDcfjMmOZ4s0L9uEMMgxny1Xi
	Rs0VEUclMgOXGoF7NG6rbDVMQSixECvz7Gatq5IUPuzBPuEy1Fos2xgr+qKDCE/35XTMAY
	/24eng98nUsPF/2WXuCjwjDY+1LTbIiADYzZr07aD+SOWFGEl+h43jWvZNBe6SwZcwEN2z
	EOE/qP8sjVd0Y7ZZ7DLjr4nCZVgG1vcdpWR5Vt9VXD8sj9nvYFlxhqthGxZgZBJOBQObV8
	aUgMD8Mo1hMeQVhBFYBlAN5BbTHVT3690SGmGjo3P97vWiQW34bJ8s+dlmOgGg==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alyssa Rosenzweig <alyssa@rosenzweig.io>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	asahi@lists.linux.dev, Janne Grunau <j@jannau.net>,
	Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 00/13] PCI: apple: Add support for t6020
Message-ID: <Z-LCm_XI22kNvFx9@blossom>
References: <20250325102610.2073863-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325102610.2073863-1-maz@kernel.org>
X-Migadu-Flow: FLOW_OUT

Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>

Thanks maz!

Everything here looks good to me aside from the dt-bindings that I
screwed up (sorry!). But I didn't do a thorough review.

Le Tue , Mar 25, 2025 at 10:25:57AM +0000, Marc Zyngier a écrit :
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
> 
> -- 
> 2.39.2
> 

