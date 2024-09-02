Return-Path: <linux-pci+bounces-12632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EA63968E89
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 21:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CFBACB21F7C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 19:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 828C019CC1E;
	Mon,  2 Sep 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PBAP/dxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A1D13AA3E;
	Mon,  2 Sep 2024 19:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725306412; cv=none; b=jitRJSfBLtcLdRgg2QLR6+8kesSDKKat0//gO4/ez0+Zwo/mnrB04DVHfUyqxx7wLCF0e2bAkRtYHhFkZ27CuKGychtdr8Hhmb6nRoASTxLoOfta/cqk8iNvJu5M9BufpPunsKQGRlhG0qj+CHXzbuAfdW7JSoi/bxohwDNx3eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725306412; c=relaxed/simple;
	bh=vdkiPzrYmE5RUCC9GcrISY44Jm6tRQ85m3k0DgjEVqM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=pw+Prsyfl9cfzp4olWU65xBd/6stgO8ZOtVfuZR2S72sJTtF/RaKVi0xTIOFarqdwH1dyGBjltDUFfMJTFQdxDJmKauWTf6WTmVxBRka21Q746tADWnqnH4/66eoOQ2iIJr4DYJlVKsTrkgPqLEH+GN3IYi+fkVjh0mk5GLFkME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PBAP/dxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7D8C4CEC2;
	Mon,  2 Sep 2024 19:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725306411;
	bh=vdkiPzrYmE5RUCC9GcrISY44Jm6tRQ85m3k0DgjEVqM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PBAP/dxI/1mlNP11Qd9ptptG7K6TLp+p6QjLpf8Z0EbHWeJGspD1/hFfyy1tE696C
	 NnSgSqLwJhfRkPkSdfh5vur6cxH3M/j5y6dSSMRQGfTz1c9NaZM7m+UxXF3H9p/HAz
	 ifDBg++zhUJVBCHJynZUt0wYMkOeUSn0pdMz8OoULBFZPoyl2ye7erNOBR4bVy4yLJ
	 hWMaW6tCjkdMPgWdJz7K/2Aa8BUaT/pEzwqXyNsa60+2U54BpGio4j8WdDTT9EjfvI
	 N1myy2FSDRlhLro3IMYXCiJrsbCaei9DbyFY8heZFbdKeUYQNuocdejpGJwWDo3Irf
	 IskSg0j3RnoKA==
Date: Mon, 2 Sep 2024 14:46:49 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 07/13] PCI: brcmstb: PCI: brcmstb: Make HARD_DEBUG,
 INTR2_CPU_BASE offsets SoC-specific
Message-ID: <20240902194649.GA224705@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240815225731.40276-8-james.quinlan@broadcom.com>

On Thu, Aug 15, 2024 at 06:57:20PM -0400, Jim Quinlan wrote:
> Do prepatory work for the 7712 SoC, which is introduced in a future commit.
> Our HW design has changed two register offsets for the 7712, where
> previously it was a common value for all Broadcom SOCs with PCIe cores.
> Specifically, the two offsets are to the registers HARD_DEBUG and
> INTR2_CPU_BASE.

> @@ -1499,12 +1502,16 @@ static const int pcie_offsets[] = {
>  	[RGR1_SW_INIT_1] = 0x9210,
>  	[EXT_CFG_INDEX]  = 0x9000,
>  	[EXT_CFG_DATA]   = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
>  static const int pcie_offsets_bmips_7425[] = {
>  	[RGR1_SW_INIT_1] = 0x8010,
>  	[EXT_CFG_INDEX]  = 0x8300,
>  	[EXT_CFG_DATA]   = 0x8304,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };
>  
>  static const struct pcie_cfg_data generic_cfg = {
> @@ -1539,6 +1546,8 @@ static const int pcie_offset_bcm7278[] = {
>  	[RGR1_SW_INIT_1] = 0xc010,
>  	[EXT_CFG_INDEX] = 0x9000,
>  	[EXT_CFG_DATA] = 0x9004,
> +	[PCIE_HARD_DEBUG] = 0x4204,
> +	[PCIE_INTR2_CPU_BASE] = 0x4300,
>  };

What's the organization scheme here?  We now have:

  static const int pcie_offsets[] = { ... };
  static const int pcie_offsets_bmips_7425[] = { ... };
  static const int pcie_offset_bcm7712[] = { ... };

  static const struct pcie_cfg_data generic_cfg = { ... };
  static const struct pcie_cfg_data bcm7425_cfg = { ... };
  static const struct pcie_cfg_data bcm7435_cfg = { ... };
  static const struct pcie_cfg_data bcm4908_cfg = { ... };

  static const int pcie_offset_bcm7278[] = { ... };

  static const struct pcie_cfg_data bcm7278_cfg = { ... };
  static const struct pcie_cfg_data bcm2711_cfg = { ... };
  static const struct pcie_cfg_data bcm7216_cfg = { ... };
  static const struct pcie_cfg_data bcm7712_cfg = { ... };

So we have pcie_offsets_bmips_7425[] and pcie_offset_bcm7712[] (with
gratuituously different "offset" vs "offsets") which are all together
before the pcie_cfg_data.

Then we have pcie_offset_bcm7278[] (again gratuitously different
"offset") separately, next to bcm7278_cfg.

It would be nice to pick one scheme and stick to it.

Also a seemingly random order of the pcie_cfg_data structs and
.compatible strings.

Also a little confusing to have "bmips_7425" and "bcm7425" associated
with the same chip.  I suppose there's historical reason for it, but I
don't think it's helpful in this usage.

>  static const struct pcie_cfg_data bcm7278_cfg = {
> -- 
> 2.17.1
> 

