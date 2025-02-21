Return-Path: <linux-pci+bounces-22039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8F6A4022D
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 22:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C3A519E05B1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 21:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9255253B7A;
	Fri, 21 Feb 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lrqIfVBf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDD62505A0;
	Fri, 21 Feb 2025 21:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740174037; cv=none; b=eijrba0XzDcw/LwM83ZcfHcQJYcd2x2GeQbThIyFRfkZW+FVp6a5lYyciuMj3/SgiiTQLBCTFq1N8C+NVJT2cloVMOvsup9UmDC+dHoC6uRT70+vg7Tyq5Zc/DnXjdcFOX8nR9KH6sjj74nDw5TDwTKDpLKTnhSq827m0+vTeb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740174037; c=relaxed/simple;
	bh=9fvV1HXHQezyHbGraYC4O5PEEvTUXe//QLm/vAzf9a0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RhkFHM9/sY8xWg1nlCkWdr5euHFk1AXl2xeL7xdEYHYweNXJpfmHBmXMgt/R6Ckj/537ZnI5goenzw7xK4//EFBnDoIapTvfjkgZ6TIltCluMHe+A0mSCYiJoD0y773wGFC5beMtD6Io9XipwOIbiJAuCTvsQVSyRTijrzHFJ5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lrqIfVBf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CE8C4CED6;
	Fri, 21 Feb 2025 21:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740174037;
	bh=9fvV1HXHQezyHbGraYC4O5PEEvTUXe//QLm/vAzf9a0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=lrqIfVBfJONAREehMa52UNOot1th/3/B4a+NqS7b7TbT6xuGaqMSF+ZmHZCxPviuV
	 7Um77DfVykXYaoZq8gRPEqdq/uKufY0jYKWnHxvED2bVEbD4s25RcmVlRRNsBZsNCC
	 43fLjUiyeYIEAJm45P3gmC/obYuYwjvlhj5Xuv6Idpv/IByGD34GihwIyyNA9McwKI
	 vS4FhoFMR5QivgpnLAcIAnYl9KyMhH1EdIuu+jctszitd/I+xKFQyXh+tNsH8boub6
	 ucH21pL8TXW0/zv6SD+iZfBIWvyEmZQ1oZhVNsrDY4dCjtnS0c6rPkBbH75GrCDmGn
	 NJnrEjFyAjvdw==
Date: Fri, 21 Feb 2025 15:40:35 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 08/11] PCI: brcmstb: Adding a softdep to MIP
 MSI-X driver
Message-ID: <20250221214035.GA362971@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-9-svarbanov@suse.de>

On Mon, Jan 20, 2025 at 03:01:16PM +0200, Stanimir Varbanov wrote:
> In case brcmstb PCIe driver and MIP MSI-X interrupt controller
> drivers are built as modules there could be a race in probing.
> To avoid this add a softdep to MIP driver to guarantee that MIP
> driver will be load first.

Maybe this one too?  Should this be moved to after the irq_bcm2712_mip
driver is added, but before brcmstb will claim bcm2712?  I just want
to avoid bisection problems when possible, and it sounds like if we
lose the race, interrupts might not work as expected?
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v4 -> v5:
>  - New patch in the series.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 03396a9d97be..744fe1a4cf9c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1997,3 +1997,4 @@ module_platform_driver(brcm_pcie_driver);
>  MODULE_LICENSE("GPL");
>  MODULE_DESCRIPTION("Broadcom STB PCIe RC driver");
>  MODULE_AUTHOR("Broadcom");
> +MODULE_SOFTDEP("pre: irq_bcm2712_mip");
> -- 
> 2.47.0
> 

