Return-Path: <linux-pci+bounces-27506-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D2AAB143F
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 15:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 924513A8D2E
	for <lists+linux-pci@lfdr.de>; Fri,  9 May 2025 13:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC4828EA40;
	Fri,  9 May 2025 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hc0YNYDd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBA28D8FD;
	Fri,  9 May 2025 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746795670; cv=none; b=S5V4iprUtq8x9PJIW3NqasL9Twtujotty8s6UoU/27nuyIilxkN06uPW7RunWV9RjQQG08V6s+HGPuFsXibeR4GsnAuJ0+wgpP3x7vmPhWiy1350389H5V1gxIlmKex5OWPLLoCBhHwLZfMGphrwb1LQ4pga7HQ9vIOIbWk6yCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746795670; c=relaxed/simple;
	bh=9MZHj+GCA6WVB4FMrptSj25S8jGsj6thQNlGMW0sbAc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VvMOVsll/TGNVbgSPLx0OLLe4KoLOQ6r1NknCPMiQBSlzypopdwnCO7hNTPNeTmAn0y74gM/7YeRt6HeS7cLExck4PXf5yjtSFMoUpX4c+e1GJGW7F2TLZ1N1WHuDfqhm3VDsCucpow4bbFvdpbxXL2ndykd7VjyXD9HQNbXat0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hc0YNYDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17993C4CEF2;
	Fri,  9 May 2025 13:01:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746795669;
	bh=9MZHj+GCA6WVB4FMrptSj25S8jGsj6thQNlGMW0sbAc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Hc0YNYDdQxYj+hGWtJuWaFjmmumS2+YfNwPs0H+/caivA9zWJrCknFwa2UjtG+b0Z
	 f1MsNn1WrEZwNv76YzlYSkiY27TZNTRfm0KE94QRh5UCsHADIrVawAelQYKDyUlzIq
	 JLJYwL5jjomH09DlXd3GM+zVbaV/ZrZQwfdxKWhsrpsb+/r/8w4BSghc74FOOMbzO6
	 L+aH2wFboVFc45Gazhp/Qdc+VAUHWZ8nWx18ZNfwHfY2jkbsUF/N6Ef6eTjvcbtp7p
	 eCSj1fFF0MiEovmWIfm6ulfJrjwwF+6fteyY55aHjJR3oipX6ykcgxvJqdRF19EbLx
	 V46RSjf1E4x8Q==
Date: Fri, 9 May 2025 15:01:03 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair@alistair23.me>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Add support for slot reset on link
 down event
Message-ID: <aB38j9p9nyrpL7HI@ryzen>
References: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509-b4-pci_dwc_reset_support-v3-1-37e96b4692e7@wdc.com>

On Fri, May 09, 2025 at 12:30:12PM +1000, Wilfred Mallawa wrote:
> From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> 
> The PCIe link may go down in cases like firmware crashes or unstable
> connections. When this occurs, the PCIe slot must be reset to restore
> functionality. However, the current driver lacks link down handling,
> forcing users to reboot the system to recover.
> 
> This patch implements the `reset_slot` callback for link down handling
> for DWC PCIe host controller. In which, the RC is reset, reconfigured
> and link training initiated to recover from the link down event.
> 
> This patch by extension fixes issues with sysfs initiated bus resets.
> In that, currently, when a sysfs initiated bus reset is issued, the
> endpoint device is non-functional after (may link up with downgraded link
> status). With this patch adding support for link down recovery, a sysfs
> initiated bus reset works as intended. Testing conducted on a ROCK5B board
> with an M.2 NVMe drive.
> 
> Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> ---

Looks good to me:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

