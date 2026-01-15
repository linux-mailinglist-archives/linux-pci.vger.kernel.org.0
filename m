Return-Path: <linux-pci+bounces-44997-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF38D28F55
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 23:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E922304B06F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 22:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586943168EB;
	Thu, 15 Jan 2026 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK1J4/CN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33758307AF2;
	Thu, 15 Jan 2026 22:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768515092; cv=none; b=fBqegQETnabwSv0kK6AoFn070Ev0YZiWPlxCz4ooiC55XEqWcefruaW7lUis17ZAE/4HUTHnWTLLOIYXhZjkDpxofRli5ueRWFL1qH4vlKhZE0XlN7+S+W9wxETl18/7B3j8m+GBYTZvfHbJ9NR/QDz5oIKUWuHb4XFcFIlucNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768515092; c=relaxed/simple;
	bh=0SEivEHbabil1CHBC8JpeP5x7F1OA3GPzLMXSrZWkec=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=CwtwzOob0lAxRq7R2CcFmOJV6dClaA2gY0c8F9eD3Uc/U9tupe7FOhT1ktFi6sWVW7y945kHaT2vuux3ODcUI5jgbQCnsG9WKWWAyaB6ss1b1i+peaX9TN+fHvF7QmgIeej2dfqDDQ679kZ2nB1QAS6RgISmOjaQNan6aTxXzHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK1J4/CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC537C116D0;
	Thu, 15 Jan 2026 22:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768515091;
	bh=0SEivEHbabil1CHBC8JpeP5x7F1OA3GPzLMXSrZWkec=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VK1J4/CNQCVD8FZw3E3b/VNcqldFEuoeZnmUYjlr5AXsQaB64xvFqRToWMjmFhRav
	 K+/mGFQoArrB2IDc/Cy6g/jGr1rFlDSsonYvSxylHro++kAYzriCuQFTi9MZWpRkCV
	 CwaHtV9S0EtC8DZTvQ5CJQXQqoFIuObK9Dw2KYndzdRyhd32rv+aZjq3OaAMBGdQoB
	 xZRFSa2CUkkoZD3MXH9vfeQE1becBtu0hLxESLsV4ur0WPP8VmpY0Uhr3XvXF5wo9d
	 je5anl2T87g4ekF14kooL/sGJNUIFhH8WZT8kb10Z3csBj87ODojxXA/pQnlR+k6ul
	 qbbH4C6QjZrQg==
Date: Thu, 15 Jan 2026 16:11:30 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johnny Chang <Johnny-CC.Chang@mediatek.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Project_Global_Digits_Upstream_Group@mediatek.com,
	Lukas Wunner <lukas@wunner.de>, Jason Gunthorpe <jgg@nvidia.com>,
	Alex Williamson <alex@shazbot.org>,
	Terje Bergstrom <tbergstrom@nvidia.com>
Subject: Re: [PATCH] PCI: Mark Nvidia GB10 to avoid bus reset
Message-ID: <20260115221130.GA888637@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com>

On Thu, Nov 13, 2025 at 04:44:06PM +0800, Johnny Chang wrote:
> From: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
> 
> Nvidia GB10 PCIe hosts will encounter problem occasionally
> after SBR(secondary bus reset) is applied.
> Enable NO_BUS_RESET quirk for Nvidia GB10 PCIe hosts.
> 
> Signed-off-by: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>

Applied with the commit log below to pci/virtualization for v6.20,
thanks!

  PCI: Mark Nvidia GB10 to avoid bus reset
  
  After asserting Secondary Bus Reset to downstream devices via a GB10 Root
  Port, the link may not retrain correctly, e.g., the link may retrain with a
  lower lane count or config accesses to downstream devices may fail.
  
  Prevent use of Secondary Bus Reset for devices below GB10.
  
  Signed-off-by: Johnny-CC Chang <Johnny-CC.Chang@mediatek.com>
  [bhelgaas: drop pci_ids.h update (only used once), update commit log]
  Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
  Link: https://patch.msgid.link/20251113084441.2124737-1-Johnny-CC.Chang@mediatek.com

> ---
>  drivers/pci/quirks.c    | 11 +++++++++++
>  include/linux/pci_ids.h |  2 ++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b94264cd3833..12a10fa84c8a 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3746,6 +3746,17 @@ static void quirk_no_bus_reset(struct pci_dev *dev)
>  	dev->dev_flags |= PCI_DEV_FLAGS_NO_BUS_RESET;
>  }
>  
> +/*
> + * Nvidia GB10 PCIe hosts will encounter problem occasionally
> + * after SBR (secondary bus reset) is applied.
> + * SBR needs to be prevented for these PCIe hosts.
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GB10_GEN5_X4,
> +			 quirk_no_bus_reset);
> +
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_GB10_GEN4_X1,
> +			 quirk_no_bus_reset);
> +
>  /*
>   * Some NVIDIA GPU devices do not work with bus reset, SBR needs to be
>   * prevented for those affected devices.
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 92ffc4373f6d..661dc1594213 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -1382,6 +1382,8 @@
>  #define PCI_DEVICE_ID_NVIDIA_GEFORCE_320M           0x08A0
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP79_SMBUS     0x0AA2
>  #define PCI_DEVICE_ID_NVIDIA_NFORCE_MCP89_SATA	    0x0D85
> +#define PCI_DEVICE_ID_NVIDIA_GB10_GEN5_X4           0x22CE
> +#define PCI_DEVICE_ID_NVIDIA_GB10_GEN4_X1           0x22D0
>  
>  #define PCI_VENDOR_ID_IMS		0x10e0
>  #define PCI_DEVICE_ID_IMS_TT128		0x9128
> -- 
> 2.45.2
> 

