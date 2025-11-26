Return-Path: <linux-pci+bounces-42174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B350C8C636
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 00:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D44834E26F3
	for <lists+linux-pci@lfdr.de>; Wed, 26 Nov 2025 23:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A5392E0B71;
	Wed, 26 Nov 2025 23:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQCfpfeZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DE26A0DB;
	Wed, 26 Nov 2025 23:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764201274; cv=none; b=lsERUQsJU2bVT5wSOC8ovilihGiidWIYwEdVnzHztR2cWwRgzN2tQmlx9Az9N87k9p1ZEGyb06NoEUsiudGaNMJ/ud2e92U+rgkZgtbAO+oxYhm0JAQS57eJ2A72tNjgj7ygE5rfv8ERmYLn0cZWNFjqPE0CBmu/dweBIltUYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764201274; c=relaxed/simple;
	bh=g9nM4cO2Nu/TJJjgqtJ77MJB0fTDSxhxd0RQ+LzrMi4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=SASIGtRfrLe3gJ7PS0GQniRKXxdc0YNiaY0o/NxK45V8aCAMo6e/Vq7j725ZncpYbS0q4LZvjLNToWaQvhfbqKDgCOp65LhDxYjECLoUUs809OMbNHQNgIFTQjXMwEaxuhGGy+I7yTNnV/fIZM5GQkke9FqfujYXMqi3rariEQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQCfpfeZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5A68C4CEF7;
	Wed, 26 Nov 2025 23:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764201273;
	bh=g9nM4cO2Nu/TJJjgqtJ77MJB0fTDSxhxd0RQ+LzrMi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=RQCfpfeZnsMlL2sUCsmFtjvqUATIhGbpQyu2dIi70gm8+BkN4dpSOM8JiXvAM5ZkP
	 BoBfquJLzroZc5wGIAhoeSIkCUnY0qS/5icO4JnicFJ0PPsD5DfEBBC7hBmvplQj5F
	 ri2lDTXygjlNAnWYiAyrbQd22ZR9ML4QDBiPfJIqcB9nPwDfqKnpAU2yVmhPKxrPRg
	 2EumjNk/YuuXvFGVk84zVWHzVu4QY6ZGevOp5ULfj/A+7wtKaM0W8Gbch+y00woMe/
	 yBcP4f8YtTSAWZMVLl6ZP0I+y/MtkKXo+hfPfxFy9bKI4FmbV42CSLYgrYvTEV6ahp
	 pmVD44qu7aO0w==
Date: Wed, 26 Nov 2025 17:54:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
	heiko@sntech.de, mani@kernel.org, yue.wang@amlogic.com,
	pali@kernel.org, neil.armstrong@linaro.org, robh@kernel.org,
	jingoohan1@gmail.com, khilman@baylibre.com, jbrunet@baylibre.com,
	martin.blumenstingl@googlemail.com, cassel@kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v6 1/2] PCI: Configure Root Port MPS during host probing
Message-ID: <20251126235432.GA2726707@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104165125.174168-2-18255117159@163.com>

On Wed, Nov 05, 2025 at 12:51:24AM +0800, Hans Zhang wrote:
> Current PCIe initialization logic may leave Root Ports (root bridges)
> operating with non-optimal Maximum Payload Size (MPS) settings. Existing
> code in pci_configure_mps() returns early for devices without an upstream
> bridge (!bridge) which includes Root Ports, so their MPS values remain
> at firmware/hardware defaults. This fails to utilize the controller's full
> capabilities, leading to suboptimal data transfer efficiency across the
> PCIe hierarchy.
> 
> With this patch, during the host controller probing phase:
> - When PCIe bus tuning is enabled (not PCIE_BUS_TUNE_OFF), and
> - The device is a Root Port without an upstream bridge (!bridge),
> The Root Port's MPS is set to its hardware-supported maximum value
> (128 << dev->pcie_mpss).
> 
> Note that this initial maximum MPS setting may be reduced later, during
> downstream device enumeration, if any downstream device does not suppor
> the Root Port's maximum MPS.
> 
> This change ensures Root Ports are properly initialized before downstream
> devices negotiate MPS, while maintaining backward compatibility via the
> PCIE_BUS_TUNE_OFF check.

"Properly" is sort of a junk word for me because all it really says is
we were stupid before, and we're smarter now, but it doesn't explain
exactly *what* was wrong and why this new thing is "proper."

It's obvious that the Max_Payload_Size power-on default (128 bytes) is
suboptimal in some situations, so you don't even need to say that.
And I think 128 bytes *is* optimal in the PCIE_BUS_PEER2PEER case.

s/Root Ports (root bridges)/Root Ports/
s/bridge (!bridge)/bridge/     # a couple times
s/hardware-supported//         # unnecessary
s/(128 << dev->pcie_mpss)//    # we can read the spec
s/suppor/support/

> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Suggested-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/probe.c | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 0ce98e18b5a8..2459def3af9b 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2196,6 +2196,18 @@ static void pci_configure_mps(struct pci_dev *dev)
>  		return;
>  	}
>  
> +	/*
> +	 * Unless MPS strategy is PCIE_BUS_TUNE_OFF (don't touch MPS at all),
> +	 * start off by setting Root Ports' MPS to MPSS. This only applies to
> +	 * Root Ports without an upstream bridge (root bridges), as other Root
> +	 * Ports will have downstream bridges.

I can't parse this sentence.  *No* Root Port has an upstream bridge.
So I don't know what "other Root Ports" would be or why they would
have downstream bridges (any Root Port is likely to have downstream
endpoints or bridges).

> +	   ... Depending on the MPS strategy
> +	 * and MPSS of downstream devices, the Root Port's MPS may be
> +	 * overridden later.
> +	 */
> +	if (!bridge && pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT &&
> +	    pcie_bus_config != PCIE_BUS_TUNE_OFF)
> +		pcie_set_mps(dev, 128 << dev->pcie_mpss);
> +
>  	if (!bridge || !pci_is_pcie(bridge))
>  		return;
>  
> -- 
> 2.34.1
> 

