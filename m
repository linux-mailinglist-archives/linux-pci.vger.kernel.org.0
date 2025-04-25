Return-Path: <linux-pci+bounces-26739-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4203A9C553
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 12:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7959016174E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Apr 2025 10:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00AF023A995;
	Fri, 25 Apr 2025 10:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rH84NfFd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C915322F769;
	Fri, 25 Apr 2025 10:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745576600; cv=none; b=cU3hYksPJLG4AX7bxx38uwjF8OW1VjWr/yMHbbHpxmFhUZS+sz3XYHq1PX8KvCmIFBJ3JpnZKXWQwsNuUEgsL+8SqYfOqBSDdfgbRX7sht66+XZCMjpJaMEmJ0AHSKyyU+urfLpoRQMTzvqwwwOkoNBjZHid/t4kvHnB/tB3nNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745576600; c=relaxed/simple;
	bh=gADYdVRlTedtCvztmIJXcTmZi2Paf3CILRLCGSYZMlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PBaCG4chxGqnQiIluqS84T7Z+qqAn1yLNFXD81tsdI1IaX3ce4fZ5teOSzun8exBQJf1iDTr5rxWR/yliWlW1AS3CHs8lXC6vC6KjIzXxqvjVE7PxMj2zl+VL3ZJQ6blMetUTqmfLVNgNl8BVdyFCdXubCrq9Vw4r0PBwJ8qG8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rH84NfFd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E63DC4CEE4;
	Fri, 25 Apr 2025 10:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745576598;
	bh=gADYdVRlTedtCvztmIJXcTmZi2Paf3CILRLCGSYZMlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rH84NfFdudOaN325xEfK5AzM51x1HjdnMFP4ugILf+mRs51A40wGY1q0K5ZiBJNjq
	 HYX5nWAbLLY7t0ctfyuMRalpk81pv5iAWNe0bQfuEsgeC+7t2oQQxvv24ehUFtmGZS
	 kxPrVZ1OFGciFAGfv4dqQeo6285b1Y6R/IZf7ed9MkUD9oFOBealWK4B5iIMIlMP7h
	 bRITLkwoCfrBj9ENyMXtrsXQPxFY3YZQdrkgQRxUAQHBsLNvZ9tbsw2c16h7pR/3gS
	 dVSm8Uifhaa4x2FBCxxE+V9ND5wTMudCTn7HnPdj+D9MRXyGWJR7diOUonJds9bJR3
	 oOkSnVeLy46eg==
Date: Fri, 25 Apr 2025 12:23:12 +0200
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
Subject: Re: [PATCH v2 1/2] PCI: Configure root port MPS to hardware maximum
 during host probing
Message-ID: <aAtikPOYlGeJCsiA@ryzen>
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250425095708.32662-2-18255117159@163.com>

On Fri, Apr 25, 2025 at 05:57:07PM +0800, Hans Zhang wrote:
> Current PCIe initialization logic may leave root ports operating with
> non-optimal Maximum Payload Size (MPS) settings. While downstream device
> configuration is handled during bus enumeration, root port MPS values
> inherited from firmware or hardware defaults might not utilize the full
> capabilities supported by the controller hardware. This can result in
> suboptimal data transfer efficiency across the PCIe hierarchy.
> 
> During host controller probing phase, when PCIe bus tuning is enabled,
> the implementation now configures root port MPS settings to their
> hardware-supported maximum values. By iterating through bridge devices
> under the root bus and identifying PCIe root ports, each port's MPS is set
> to 128 << pcie_mpss to match the device's maximum supported payload size.
> The Max Read Request Size (MRRS) is subsequently adjusted through existing
> companion logic to maintain compatibility with PCIe specifications.
> 
> Explicit initialization at host probing stage ensures consistent PCIe
> topology configuration before downstream devices perform their own MPS
> negotiations. This proactive approach addresses platform-specific
> requirements where controller drivers depend on properly initialized root
> port settings, while maintaining backward compatibility through
> PCIE_BUS_TUNE_OFF conditional checks. Hardware capabilities are fully
> utilized without altering existing device negotiation behaviors.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Perhaps Mani deserves a Suggested-by tag?


> ---
>  drivers/pci/probe.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 364fa2a514f8..3973c593fdcf 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3206,6 +3206,7 @@ EXPORT_SYMBOL_GPL(pci_create_root_bus);
>  int pci_host_probe(struct pci_host_bridge *bridge)
>  {
>  	struct pci_bus *bus, *child;
> +	struct pci_dev *dev;
>  	int ret;
>  
>  	pci_lock_rescan_remove();
> @@ -3228,6 +3229,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
>  	 */
>  	pci_assign_unassigned_root_bus_resources(bus);
>  
> +	if (pcie_bus_config != PCIE_BUS_TUNE_OFF) {
> +		/* Configure root ports MPS to be MPSS by default */
> +		for_each_pci_bridge(dev, bus) {
> +			if (pci_pcie_type(dev) != PCI_EXP_TYPE_ROOT_PORT)
> +				continue;
> +
> +			pcie_write_mps(dev, 128 << dev->pcie_mpss);
> +			pcie_write_mrrs(dev);

The comment says configure MPS, but the code also calls pcie_write_mrrs().

Should we update the comment or should we remove the call to pcie_write_mrrs()?

Note that even when calling pcie_write_mrrs(), it will not update MRRS for the
common case (pcie_bus_config == PCIE_BUS_DEFAULT).


Kind regards,
Niklas

