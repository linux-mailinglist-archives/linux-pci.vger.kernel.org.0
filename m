Return-Path: <linux-pci+bounces-26738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE07A9C511
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:17:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9388D171B62
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:17:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99FBF1C8600;
	Fri, 25 Apr 2025 10:17:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JVJ5ldkx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F926AC3;
	Fri, 25 Apr 2025 10:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576270; cv=none; b=hPOry2OlLHG2P9gez92D2FeByByVhLDxFzoL9BcLf+LLSVVx6R+/URIRHyM+bw3a/OYxNGkinctPqGcoBXZ23uDC5LMzpW7Aw6sld8H/tEWS7KdbrMryF2zCdXjqWXXbLoqxzzBbUb9yDSfJA3lJDve+TNHjLkEsQUSn41gzs+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576270; c=relaxed/simple;
	bh=jHetIDcoEMJE5Pmx9hfvbqtA0k/bgENuEA9snYJ/JQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aYCCRD5sXfb/DTWUTlcTARBpnJCguv0OGVA66JfB/FZ3LyeCLPyfqS3rEHO/s5R7G8kH2J8rM4Gg6bd4UB+4VTKJdAqJnDxIg2/v9A8iahRs01XThS/sTdwHC0V9dqXrUeuqK9KEezOVd5Fk7VCHhPcEZLJAIIUHxvOQj4mAViA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JVJ5ldkx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE911C4CEE4;
	Fri, 25 Apr 2025 10:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745576269;
	bh=jHetIDcoEMJE5Pmx9hfvbqtA0k/bgENuEA9snYJ/JQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JVJ5ldkx0bzzY1siTZptS8iOsMb0rh/16B4dalCRuYsdMQMrTWOtVWXpNGJYSu4bI
	 Pki4Y99cTUBsZ0ykhSfWQKuC6WO5chHnfGNNxAKOlsCCX9Tcc16vOAzY2v8YJpV3sT
	 TJAcd3su86PT9qJWA6lqkKuaZrmTuoXJVRrIE6yWwINzDi0VTnLgJv8/XAvSuBBzE3
	 uV9bkJn+JAwuW5M+NTSyH1EedQSY66k7kTs4+G5c4/EJ2THhDU8zE2LC51SXHAOqJV
	 AdVDZeBeyvk542mjAKuzcXrQWY4sSlDC94JM3lZYoL2xbnK1BS5US0haYNRtQOiHAh
	 DRR5WztJ7O4VA==
Date: Fri, 25 Apr 2025 12:17:43 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
	heiko@sntech.de, thomas.petazzoni@bootlin.com,
	manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
Message-ID: <aAthR8ZXSqfe6fzV@ryzen>
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425095708.32662-3-18255117159@163.com>

On Fri, Apr 25, 2025 at 05:57:08PM +0800, Hans Zhang wrote:
> With the PCI core now centrally configuring root port MPS to
> hardware-supported maximums (via 128 << pcie_mpss) during host probing,
> platform-specific MPS adjustments are redundant. This patch removes the
> custom the configuration of the max payload logic to align with the
> standardized initialization flow.
> 
> By eliminating redundant code, this change prevents conflicts with global
> PCIe hierarchy tuning policies and reduces maintenance overhead. The Meson
> driver now fully relies on the core PCI framework for MPS configuration,
> ensuring consistency across the PCIe topology while preserving
> hardware-specific MRRS handling.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pci-meson.c | 17 -----------------
>  drivers/pci/controller/pci-aardvark.c  |  2 --

Since you are touching two drivers (and the changes are not exactly identical),
I suggest that you do one patch per driver.


Kind regards,
Niklas

