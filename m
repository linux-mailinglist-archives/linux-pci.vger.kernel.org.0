Return-Path: <linux-pci+bounces-7732-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF34D8CB5EE
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2024 00:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 69F112825BC
	for <lists+linux-pci@lfdr.de>; Tue, 21 May 2024 22:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A3E14A09B;
	Tue, 21 May 2024 22:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbknFbOr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E01865A;
	Tue, 21 May 2024 22:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716330084; cv=none; b=j9nqCnZYN8gjoq5iHIcdrFZIMoSl5v7s4ps94NuPIuJ9mNQz6A8urpFJAxFeUO3vFcw6nAqsGQLQpEeQyZ6LQyi7l9WwXb2Med8/3s/sQgfv//uh0PSqJ8Pv8madc3UXh92xKMerGMbZaDKwfp48yVL6GD8518WF2j6Lzpmv60U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716330084; c=relaxed/simple;
	bh=eTuD8TkoSJENTwFBMEinJkrb+PTHkp3uq6sPx3UUzN0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=JfEV1148BwD0Z3xOzPekwo5oYQN5+xmhqLfEGmILCoqDTCJhWk7iEWP8zNRBhRGNVGwadK2dwUZB1ehpVjoFJoODCR4OKxJgumFASn1R/3iBC3xgEPsJkDLfIhh4axaWGZEtyQjRjfYD/bLomYA8GeeLlooVGuTJECpcflHfYGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbknFbOr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AF01C2BD11;
	Tue, 21 May 2024 22:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716330083;
	bh=eTuD8TkoSJENTwFBMEinJkrb+PTHkp3uq6sPx3UUzN0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cbknFbOrlq2asl7flaBNs5fBtXasvCVpbovNe1xwvZHA8ibl/wvjz6ialnpg5lH3C
	 OYZfHlDpi0x0d0WhqKOTT+MImfiymKZIpYgT41eKKMYbDvn/YjEGaFYtzr4Z7rM0VD
	 XhDjusLnYZK4vbQZdBwdz4NbOPXjejZ4lRZJ7dCyvuYnh/aXwK06d4j6U48nT6Gwz3
	 BNwC/CEyamHdqbrHMyKSUESNxuZXLqKgcFpEQ9sqvyyewxisaIzi26J8zj24xr5GSz
	 SuPC8GVpd1YtEgKvmsP9pki406qPwQHVVIHgiWQbVchwSWHiQVPWrkIZvJBBiDjsMS
	 ft7+VW0CcMoOA==
Date: Tue, 21 May 2024 17:21:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org, linux-pci@vger.kernel.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Mason Huo <mason.huo@starfivetech.com>,
	Leyfoon Tan <leyfoon.tan@starfivetech.com>,
	Kevin Xie <kevin.xie@starfivetech.com>
Subject: Re: [PATCH v16 08/22] PCI: microchip: Change the argument of
 plda_pcie_setup_iomems()
Message-ID: <20240521222121.GA51329@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240328091835.14797-9-minda.chen@starfivetech.com>

The patch is OK, but the subject line is not very informative.  It
should be useful all by itself even without the commit log.  "Change
the argument of X" doesn't say anything about why we would want to do
that.

On Thu, Mar 28, 2024 at 05:18:21PM +0800, Minda Chen wrote:
> If other vendor do not select PCI_HOST_COMMON, the driver data is not
> struct pci_host_bridge.

Also, I don't think this is the real problem.  Your
PCIE_MICROCHIP_HOST Kconfig selects PCI_HOST_COMMON, and the driver
calls pci_host_common_probe(), so the driver wouldn't even build
without PCI_HOST_COMMON.

This patch is already applied and ready to go, but if you can tell us
what's really going on here, I'd like to update the commit log.

> Move calling platform_get_drvdata() to mc_platform_init().
> 
> Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
>  drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
> index 9b367927cd32..805870aed61d 100644
> --- a/drivers/pci/controller/plda/pcie-microchip-host.c
> +++ b/drivers/pci/controller/plda/pcie-microchip-host.c
> @@ -876,11 +876,10 @@ static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
>  	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
>  }
>  
> -static int plda_pcie_setup_iomems(struct platform_device *pdev,
> +static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
>  				  struct plda_pcie_rp *port)
>  {
>  	void __iomem *bridge_base_addr = port->bridge_addr;
> -	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>  	struct resource_entry *entry;
>  	u64 pci_addr;
>  	u32 index = 1;
> @@ -1018,6 +1017,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
>  	struct platform_device *pdev = to_platform_device(dev);
> +	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
>  	void __iomem *bridge_base_addr =
>  		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
>  	int ret;
> @@ -1031,7 +1031,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
>  	mc_pcie_enable_msi(port, cfg->win);
>  
>  	/* Configure non-config space outbound ranges */
> -	ret = plda_pcie_setup_iomems(pdev, &port->plda);
> +	ret = plda_pcie_setup_iomems(bridge, &port->plda);
>  	if (ret)
>  		return ret;
>  
> -- 
> 2.17.1
> 

