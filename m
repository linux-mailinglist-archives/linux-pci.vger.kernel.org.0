Return-Path: <linux-pci+bounces-44389-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E74FBD0B47E
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 17:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B4C96302823B
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 16:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BA631ED91;
	Fri,  9 Jan 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rd/6O3iq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FF127A904;
	Fri,  9 Jan 2026 16:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767976127; cv=none; b=QgddkHHMB5gFBb6CLfUXLnDbO0N9jTatIcRv4rtlJiC3qKcUeDnHhSm4d9+a0KanzpjRmlov5iiKtkLrF/uZ/18vYy+nGjLVxAIskYJAaRww81IMCFjhv7OJTiSPGVa1rb36JtdDskZxPDtpdDjq/kg92dYRB3xCDStNq9snhy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767976127; c=relaxed/simple;
	bh=5EYyQvUdDiPXqo3mITlehZLIE2J318Q/2DwhGObWHUw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TGg7RZdlhC0yyK0p716yTyKrQKXQbuyr50ZuTZR+IIE6ACBxuXXeDmjVcQFG+So2j5TV7mQ11514x7zZk0+N6gQrDI+To2bBetBMOTamMuG+50JIRT45hopn/rqVVD+4KnYi/uAANaulf4J07oU9sQ7PZR0sJpfXozrBrvcoSDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rd/6O3iq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3D61C19423;
	Fri,  9 Jan 2026 16:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767976126;
	bh=5EYyQvUdDiPXqo3mITlehZLIE2J318Q/2DwhGObWHUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rd/6O3iqDL5eI4pT5KoUU16+rnovgcdRbLGctlbarvYkmoZV1pf9kjCudmzeGGKeL
	 60aH+MWGo70f9uKEO+Pe49nxLu+/z02/eQ/UAd6yYQ92Bmoe1llIU+s6ZjIXavz4Zd
	 izGlvydEILnQqmWUS24YlqgteYUMyAR2rmFzuugLOyic77osHsk9m40MGvxuKjCOax
	 +QjYj9qy9gICGSYGo1OH8g2XSt6DRj/JpcJNhfIPQW5aWskTpGLy8RgHPSjJOm4k2Z
	 hpbDprfKXQfZVzqisD0J2zA6fxMYss1U9GVwOOGBiyG6VYNWE24RdH4WLQxwGfMCvu
	 EMOLMViXtVJug==
Date: Fri, 9 Jan 2026 10:28:45 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Alex Williamson <alex.williamson@nvidia.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, alex@shazbot.org,
	Patrick Bianchi <patrick.w.bianchi@gmail.com>
Subject: Re: [PATCH] PCI: Disable bus reset for ASM1164 SATA controller
Message-ID: <20260109162845.GA548877@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109000211.398300-1-alex.williamson@nvidia.com>

On Thu, Jan 08, 2026 at 05:02:08PM -0700, Alex Williamson wrote:
> User forums report issues when assigning ASM1164 SATA controllers to
> VMs, especially in configurations with multiple controllers.  Logs
> show the device fails to retrain after bus reset.  Reports suggest
> this is an issue across multiple platforms.  The device indicates
> support for PM reset, therefore the device still has a viable function
> level reset mechanism.  The reporting user confirms the device is well
> behaved in this use case with bus reset disabled.
> 
> Reported-by: Patrick Bianchi <patrick.w.bianchi@gmail.com>
> Link: https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-identical-devices.149003/
> Signed-off-by: Alex Williamson <alex.williamson@nvidia.com>

Applied to pci/virtualization for v6.20, thanks!

> ---
>  drivers/pci/quirks.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index b9c252aa6fe0..3a8d5622ee2b 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -3791,6 +3791,16 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_CAVIUM, 0xa100, quirk_no_bus_reset);
>   */
>  DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_TI, 0xb005, quirk_no_bus_reset);
>  
> +/*
> + * Reports from users making use of PCI device assignment with ASM1164
> + * controllers indicate an issue with bus reset where the device fails to
> + * retrain.  The issue appears more common in configurations with multiple
> + * controllers.  The device does indicate PM reset support (NoSoftRst-),
> + * therefore this still leaves a viable reset method.
> + * https://forum.proxmox.com/threads/problems-with-pcie-passthrough-with-two-identical-devices.149003/
> + */
> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_ASMEDIA, 0x1164, quirk_no_bus_reset);
> +
>  static void quirk_no_pm_reset(struct pci_dev *dev)
>  {
>  	/*
> -- 
> 2.51.0
> 

