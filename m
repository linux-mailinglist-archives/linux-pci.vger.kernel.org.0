Return-Path: <linux-pci+bounces-42011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5B3C836C8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 06:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 59E573467D8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 05:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B56D8286417;
	Tue, 25 Nov 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vEr0CqiO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8488228507B;
	Tue, 25 Nov 2025 05:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764050145; cv=none; b=fbmAsw6ljV927fu844T8IR7rCO9b399eBxlb8NlX/bgx30NlX1fehdzNvJzpctXZpx+GbVdMemjUTvD2lgI/y6g+q+HUGlQHuEwD6h7yJDikirbB9IGwedPAehjNvUtPywminuoeqazEo4immVuehEsg92livs7XtiJuFRrxNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764050145; c=relaxed/simple;
	bh=48ErKjGaEtb7aXQCMfQrk3VwREcMQsySK/d0DWH6IOY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lrt+9yC2+Pk/7JM8YIK6IoCmtqoX5NGeyRF9Q1SQBnW14C3GaEsaSHfH5aWwbswIldCh+S5Iqa3N1zF0yv7d9WrZujToBTs1UvHnx5moAnoM4A3fil/fJ01gWLxLuuG9HxeP7iql89QHeFuiLgH0pBKbyfbF0bHzHhOzCPtVZeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vEr0CqiO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A1D4C19421;
	Tue, 25 Nov 2025 05:55:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764050145;
	bh=48ErKjGaEtb7aXQCMfQrk3VwREcMQsySK/d0DWH6IOY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vEr0CqiOkp+00ddSKxjuHvXNEPSWKxw5m9NTB6PrKbyuZcqpeohbw7XZ26eJVVfGf
	 Bz/HV3PKcDk1Nd4RRxF7OVoaa1jEB6B63j0neAMDmKlSlelgnZ1PKd2jXVVrGAuMpz
	 YsYjrPXJdGl2LgxhlaQGWONafPRE/3K3VOBxm235ZAwQmZfFURDag1N8Rp6lj/ihv0
	 HuTkCgCDAHrwwGgxefClavytlYh/y4OgY0cxoltRGePqexrCbDb6Qmi8SBOLOroEnS
	 mptcNCgXVNU44YzON/AX6GTi55OzaFofq5k0QgcDkAvvMz9dlfUX1rbFegcvYz7Zx8
	 X3qXn15FZDlpA==
Date: Tue, 25 Nov 2025 11:25:32 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Claudiu <claudiu.beznea@tuxon.dev>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, geert+renesas@glider.be, 
	magnus.damm@gmail.com, p.zabel@pengutronix.de, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: Re: [PATCH v8 6/6] arm64: defconfig: Enable PCIe for the Renesas
 RZ/G3S SoC
Message-ID: <c24nuqtczt2jxekl67boramlgullnxftwjfjlwcjjnyv47ykwc@tlpojiyzdk6r>
References: <20251119143523.977085-1-claudiu.beznea.uj@bp.renesas.com>
 <20251119143523.977085-7-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119143523.977085-7-claudiu.beznea.uj@bp.renesas.com>

On Wed, Nov 19, 2025 at 04:35:23PM +0200, Claudiu wrote:
> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> 
> Enable PCIe for the Renesas RZ/G3S SoC.
> 
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Acked-by: Manivannan Sadhasivam <mani@kernel.org>

- Mani

> ---
> 
> Changes in v8:
> - none
> 
> Changes in v7:
> - rebased on top of v6.18-rc1
> 
> Changes in v6:
> - collected tags
> 
> Changes in v5:
> - dropped Tb tag
> 
> Changes in v4:
> - made it builtin
> 
> Changes in v3:
> - collected tags
> 
> Changes in v2:
> - none
> 
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index e3a2d37bd104..54fd09317edf 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -230,6 +230,7 @@ CONFIG_PCIE_MEDIATEK_GEN3=m
>  CONFIG_PCI_TEGRA=y
>  CONFIG_PCIE_RCAR_HOST=y
>  CONFIG_PCIE_RCAR_EP=y
> +CONFIG_PCIE_RENESAS_RZG3S_HOST=y
>  CONFIG_PCIE_ROCKCHIP_HOST=m
>  CONFIG_PCI_XGENE=y
>  CONFIG_PCI_IMX6_HOST=y
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

