Return-Path: <linux-pci+bounces-44045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FFD7CF5014
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 18:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBC2330CE2C1
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 17:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2092832C943;
	Mon,  5 Jan 2026 17:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKOtaPGU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC1423164C2;
	Mon,  5 Jan 2026 17:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767633975; cv=none; b=HxM7nhZS1RaXkDx+v5imAZdPTUQJDTXAbL2jinb02V3CqeHYrxg7WzAYrMoXrw5ZryIKS9WctszFIe6JM4GE7ZcKTv6AoXBf1iZH24k4VJm5fql70LTp/FkFsD7eos+6hLCmQr/aPTFurteXhtFSDmqMV0ET1eLAzSnV0Kwxpyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767633975; c=relaxed/simple;
	bh=QRhjmAuGgDI4aNSnURCOuJV5ccPObzRNDO3W9guQetA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=rFPmZ5nMBaFxIOhe0HSf6OcXPCTdKhYuQUao3oE7U+vXeCYzVvrsx0BgUwm94YW6PhsNvn19QKG5nDlDWB4cIPgL7yd51jAFeoiXmojPUuGqeOJwUBEZZmYG1SXN/3Awc5+eE/8P3jeARokNsGRaMDsAixFvO6aesv82ScuuWRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKOtaPGU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EA3C116D0;
	Mon,  5 Jan 2026 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767633974;
	bh=QRhjmAuGgDI4aNSnURCOuJV5ccPObzRNDO3W9guQetA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FKOtaPGUO2G25GOPhqyxd4OfRl7khmGTwHNfQB/l7GSxRtsRSiuBGdG73yMP4jLnI
	 penFOUDTzfWGEB7LWAgYIGod3IsPAAT2jlFiJC/0s8XUOBQKLeDAKjHmo4SwlhCYuF
	 TDuYxrk8+zUXE1afMIrSneo8Fsyv+5GsMefvxADfHuDN7FFIlZ96j/A7+4KWuAGZpJ
	 HNFVhPTDiyEGJxGKGL66d6k93ioNkDpjmWcSlhdD4fTmkSatAEzA29tDjSv15TQ/mj
	 4ZPNClHlJnXLZYWEF7BsCI7k/jUagh0KgX2SUmbpBadFFpVWzrk28rQjdDT40Z07Dm
	 ku47N3Dd4Slgw==
Date: Mon, 5 Jan 2026 11:26:13 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: linux-amlogic@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	bhelgaas@google.com, robh@kernel.org, mani@kernel.org,
	kwilczynski@kernel.org, lpieralisi@kernel.org, yue.wang@amlogic.com
Subject: Re: [PATCH] PCI: meson: Drop unused WAIT_LINKUP_TIMEOUT macro
Message-ID: <20260105172613.GA322262@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105125625.239497-1-martin.blumenstingl@googlemail.com>

On Mon, Jan 05, 2026 at 01:56:25PM +0100, Martin Blumenstingl wrote:
> Commit 113d9712f63b ("PCI: meson: Report that link is up while in ASPM
> L0s and L1 states") removed the waiting loop in meson_pcie_link_up()
> making #define WAIT_LINKUP_TIMEOUT now unused.
> 
> Drop the now unused variable to keep the driver code clean.
> 
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Squashed into 113d9712f63b (which is now on for-linus for v6.19),
thanks!

> ---
>  drivers/pci/controller/dwc/pci-meson.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index a1c389216362..0694084f612b 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -37,7 +37,6 @@
>  #define PCIE_CFG_STATUS17		0x44
>  #define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
>  
> -#define WAIT_LINKUP_TIMEOUT		4000
>  #define PORT_CLK_RATE			100000000UL
>  #define MAX_PAYLOAD_SIZE		256
>  #define MAX_READ_REQ_SIZE		256
> -- 
> 2.52.0
> 

