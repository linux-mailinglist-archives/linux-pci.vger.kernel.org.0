Return-Path: <linux-pci+bounces-29648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E689AD8347
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 08:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 434721883B2C
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 06:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED527257459;
	Fri, 13 Jun 2025 06:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pv7YBXXO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDB6521B19D;
	Fri, 13 Jun 2025 06:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749796724; cv=none; b=akPyjVVemZmL1HfxDB7Toolg33x8bhDUi78BKIcdlZe/tBl1VPLnfVzEXHMrAAncScLTsfNCuaryWwxYaZmpMw1N1l384zRQHp6RhUyMbhzB6halyPhxvwgT5mqoOl++nzVXml9AslUsbWUoAXsF/t9t77ZWFC8r9XlfOFebD/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749796724; c=relaxed/simple;
	bh=tROfEO8euW7h0JprdW23sw/j5uJHnALwGHFYIu1qnIc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+Gm7nDbdKj9VT9nRIO/roYF/Dzqu/zg0EOghpGKFJ15OimeJ9PYccAOFcrX74k6DD1SmknNEXSZsF65kw3RPcyJKsvncag6FS2GC8mVDsZiZaZDsqmgOuoSpem2Fup3orc/ZQ0Zfpf2dXTneVjG+D6S+pF5+giqHozdbxUN/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pv7YBXXO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A305C4CEE3;
	Fri, 13 Jun 2025 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749796722;
	bh=tROfEO8euW7h0JprdW23sw/j5uJHnALwGHFYIu1qnIc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pv7YBXXOJmQxXTV4jr0t1k2py0pGy6WO1Uo1f3lcTcLD9104WQCKyIgfI35DgY/9p
	 rfjfU30z4XBKgfl6pUeyzHKm+HtNj5lL5aWGofUPsuBPfLL5+9yRtIPFtjlcZPStd/
	 y8xYDdlOne5pTOMq3uyVKb1zYRb6gOo0wkGCj/RKGDWDtF1aNUaDDIi4Nvl64R2s6O
	 d3QcUqlqGQeLCbj7m4Z89cesssF+y7i368gvbMXyTWB9F1sFWF71x2ODjBjjtgUxXx
	 8iHbINVDEoozAApgAAxxS/WpQamaZCxwPLmHp7NQv/iZR0G92fP8OGeqjzE3ySTbcm
	 W8GU9Yk0CGgIw==
Date: Fri, 13 Jun 2025 12:08:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com, 
	heiko@sntech.de, manivannan.sadhasivam@linaro.org, yue.wang@amlogic.com, 
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com, 
	khilman@baylibre.com, jbrunet@baylibre.com, martin.blumenstingl@googlemail.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-amlogic@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v4 1/2] PCI: Configure root port MPS during host probing
Message-ID: <co2q55j4mk2ux7af4sj6snnfomditwizg5jevg6oilo3luby5z@6beqtbn3l432>
References: <20250510155607.390687-1-18255117159@163.com>
 <20250510155607.390687-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250510155607.390687-2-18255117159@163.com>

On Sat, May 10, 2025 at 11:56:06PM +0800, Hans Zhang wrote:
> Current PCIe initialization logic may leave root ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, root port MPS values
> inherited from firmware or hardware defaults might not utilize the full
> capabilities supported by the controller hardware. This can result is
> uboptimal data transfer efficiency across the PCIe hierarchy.
> 
> During host controller probing phase, when PCIe bus tuning is enabled,
> the implementation now configures root port MPS settings to their
> hardware-supported maximum values. By iterating through bridge devices
> under the root bus and identifying PCIe root ports, each port's MPS is
> set to 128 << pcie_mpss to match the device's maximum supported payload
> size.

I don't think the above statement is accurate. This patch is not iterating
through the bridges and you cannot identify root ports using that. What this
patch does is, it checks whether the device is root port or not and if it is,
then it sets the MPS to MPSS (hw maximum) if PCIE_BUS_TUNE_OFF is not set.

> The Max Read Request Size (MRRS) is subsequently adjusted through
> existing companion logic to maintain compatibility with PCIe
> specifications.
> 
> Explicit initialization at host probing stage ensures consistent PCIe
> topology configuration before downstream devices perform their own MPS
> negotiations. This proactive approach addresses platform-specific
> requirements where controller drivers depend on properly initialized
> root port settings, while maintaining backward compatibility through
> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> utilized without altering existing device negotiation behaviors.
> 
> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/probe.c | 72 ++++++++++++++++++++++++++-------------------
>  1 file changed, 41 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..1f67c03d170a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2149,6 +2149,37 @@ int pci_setup_device(struct pci_dev *dev)
>  	return 0;
>  }
>  
> +static void pcie_write_mps(struct pci_dev *dev, int mps)
> +{
> +	int rc;
> +
> +	if (pcie_bus_config == PCIE_BUS_PERFORMANCE) {
> +		mps = 128 << dev->pcie_mpss;
> +
> +		if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT &&
> +		    dev->bus->self)
> +
> +			/*
> +			 * For "Performance", the assumption is made that
> +			 * downstream communication will never be larger than
> +			 * the MRRS.  So, the MPS only needs to be configured
> +			 * for the upstream communication.  This being the case,
> +			 * walk from the top down and set the MPS of the child
> +			 * to that of the parent bus.
> +			 *
> +			 * Configure the device MPS with the smaller of the
> +			 * device MPSS or the bridge MPS (which is assumed to be
> +			 * properly configured at this point to the largest
> +			 * allowable MPS based on its parent bus).
> +			 */
> +			mps = min(mps, pcie_get_mps(dev->bus->self));
> +	}
> +
> +	rc = pcie_set_mps(dev, mps);
> +	if (rc)
> +		pci_err(dev, "Failed attempting to set the MPS\n");
> +}
> +
>  static void pci_configure_mps(struct pci_dev *dev)
>  {
>  	struct pci_dev *bridge = pci_upstream_bridge(dev);
> @@ -2178,6 +2209,16 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
>  	}
>  
> +	/*
> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
> +	 * start off by setting root ports' MPS to MPSS. Depending on the MPS
> +	 * strategy, and the MPSS of the devices below the root port, the MPS
> +	 * of the root port might get overridden later.
> +	 */
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +		pcie_write_mps(dev, 128 << dev->pcie_mpss);

I believe you can just use "pcie_set_mps(dev, 128 << dev->pcie_mpss)" directly
and avoid moving pcie_write_mps() around.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

