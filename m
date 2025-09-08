Return-Path: <linux-pci+bounces-35704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 863C8B49C74
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 23:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 408F81652B1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 21:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093A2E2DD8;
	Mon,  8 Sep 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiDbdfAu"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A572367B3;
	Mon,  8 Sep 2025 21:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757368512; cv=none; b=QGcHzDRYu1GF6ftE8iQRV1l253keijRuioJ8nrdV+mq3VrWhet4PglV1oGXsVjm/kjmvoEiiFrEN8AHOqHxo/QFMD8pAsla4woxHSy3GehfRRLfK/bt7ow0LyVdY/Hy++uf04epXYawSWTm+oUBOKXlzHXzeHHjzWDeB1lDEWao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757368512; c=relaxed/simple;
	bh=+nYJPbuKlpnqlu3CLLJjdFbOtA1lzkZavy4yOLM+sGc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=HnhiZa9DThU19QkwL6ioGnx+Tn6a6MWXc21ofa6AOhU61+2G3Bl8L+bhKrvOhbVNWZXX1AODUy0gZOycEeM0HvAWhZphtzNFC45DL/gYUcLkSmy4qvM/faIn2JT0yd9wfictuePGZDXgk4E4L/ipeQEG1SZP0p+WW41scw5zW+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiDbdfAu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B7AC4CEF1;
	Mon,  8 Sep 2025 21:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757368511;
	bh=+nYJPbuKlpnqlu3CLLJjdFbOtA1lzkZavy4yOLM+sGc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kiDbdfAuo9J++rxAYt2nbuOgNET0a6aGGKZyM1O70K6sKUOOBtjNGuP5/jiU0a2O7
	 kgDOBgNSMfStFqgdYWCblaRMhdw7xF1V8/WBdswaXIMObwyEyCKJLFMb13dwZc07rt
	 IjUSn7k/xbQQ3go5vh6EUy5WulEkff8YPQDzVBRI8kU5AuNWVfVPKUSSmrRtP1AYuR
	 vx04Rru42xQY6+u2WSM0ZRr3xwOBqnxcctWQgasngIzjADGtKq7Iq4oQtMXlawR9kx
	 yE3u9L6fsekFx4PQ4yK6olQo65pW1Ed4I3YxMTsa2Xwpa2lAJ+vPB3bRE/Tn/bCc2e
	 nz5PYilemvA6Q==
Date: Mon, 8 Sep 2025 16:55:10 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org,
	mani@kernel.org, bhelgaas@google.com,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH v3 2/2] PCI: dwc: visconti: Remove cpu_addr_fix() after
 DTS fix ranges
Message-ID: <20250908215510.GA1467223@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1757298848-15154-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>

In subject, s/PCI: dwc: visconti:/PCI: visconti:/ to match previous
history.

On Mon, Sep 08, 2025 at 11:34:08AM +0900, Nobuhiro Iwamatsu wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Remove cpu_addr_fix() since it is no longer needed. The PCIe ranges
> property has been corrected in the DTS, and the DesignWare common code now
> handles address translation properly without requiring this workaround.

As Mani pointed out, the driver has to continue working correctly with
any old DTs in the field.

> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> Signed-off-by: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
> 
> ---
> v3:
>   Add pci->use_parent_dt_ranges fixes.
>   Update Signed-off-by address, because my company email address haschanged.
> 
> v2:
>   No Update.
> ---
>  drivers/pci/controller/dwc/pcie-visconti.c | 15 ++-------------
>  1 file changed, 2 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-visconti.c b/drivers/pci/controller/dwc/pcie-visconti.c
> index cdeac6177143c..d8765e57147af 100644
> --- a/drivers/pci/controller/dwc/pcie-visconti.c
> +++ b/drivers/pci/controller/dwc/pcie-visconti.c
> @@ -171,20 +171,7 @@ static void visconti_pcie_stop_link(struct dw_pcie *pci)
>  	visconti_mpu_writel(pcie, val | MPU_MP_EN_DISABLE, PCIE_MPU_REG_MP_EN);
>  }
>  
> -/*
> - * In this SoC specification, the CPU bus outputs the offset value from
> - * 0x40000000 to the PCIe bus, so 0x40000000 is subtracted from the CPU
> - * bus address. This 0x40000000 is also based on io_base from DT.
> - */
> -static u64 visconti_pcie_cpu_addr_fixup(struct dw_pcie *pci, u64 cpu_addr)
> -{
> -	struct dw_pcie_rp *pp = &pci->pp;
> -
> -	return cpu_addr & ~pp->io_base;
> -}
> -
>  static const struct dw_pcie_ops dw_pcie_ops = {
> -	.cpu_addr_fixup = visconti_pcie_cpu_addr_fixup,
>  	.link_up = visconti_pcie_link_up,
>  	.start_link = visconti_pcie_start_link,
>  	.stop_link = visconti_pcie_stop_link,
> @@ -310,6 +297,8 @@ static int visconti_pcie_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, pcie);
>  
> +	pci->use_parent_dt_ranges = true;
> +
>  	return visconti_add_pcie_port(pcie, pdev);
>  }
>  
> -- 
> 2.51.0
> 
> 

