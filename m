Return-Path: <linux-pci+bounces-35665-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C50AEB48DC4
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 14:39:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C68571C20A9A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Sep 2025 12:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7BC52FFDFA;
	Mon,  8 Sep 2025 12:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+1Jw5QJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBCCA2FFDE6;
	Mon,  8 Sep 2025 12:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757335113; cv=none; b=n7G2JuLBkPUYpALC/1AvzbXzJLHsuWOvVlfuKD2+fA1gsZVBql4Wh3Md3tdMtnVCaSusXpruSXuNDOhcBAt7RA0xPpSK9Fi6/d0XHL5Rbf/QHlmsRKMLW7cxe7OaqzQC3/lMafxa/5YOrZgWOrNsrHSxwKG9I7oiWmbOj1bYvxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757335113; c=relaxed/simple;
	bh=u/aSpq/tYI23caay5KQ+gDiq/maVvqHIQQw80mCFn3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tx/hq3BUAnP+EKSss/oCOhfU7Xwb4FzCuRAHGU9ICgpu9DWYWf1feS/xU+lBvmUnxnCZrdbHs1kG+N8BtY7NKavqC+JBdJ2y7WnOgv2kBwuGuJ3WBGSGY9LGMP5UOVRWyKIbgWhalzOse36d7vjlc1MofOisTKxh9cENeU8GEZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+1Jw5QJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BFFC4CEF1;
	Mon,  8 Sep 2025 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757335112;
	bh=u/aSpq/tYI23caay5KQ+gDiq/maVvqHIQQw80mCFn3c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p+1Jw5QJyiyJodrRlHhDg3F8S0oQOxQpM6sq+lJgHPJRsFH/9qXp37SfULYDNstZQ
	 YEjX6PgRPC/uWE5fOcUMF8gCKGHf9lnvsBHrfHs1VnIGT6pYwy7bOwb0OaqdWU/ZL2
	 n9yAvPUdlzF8zCl+Rc/LhrzAiOnTVzw09lMhDahFsQVIaD6g0mJS3gYgXf+lRld2Oe
	 ynGKPo2qqdxvQLuLpjHWMtowk43XtkB1aHtXWn5NzkYTYtL0QEpJmFFLhjO2GKp33m
	 OToNakbvsd1SVG2IFzxlN+xrC+VJYxsvApsELK2aZW8LDgZnVQ8HQuuo5eYXtPH9TX
	 ahdbbFP4y4Nxw==
Date: Mon, 8 Sep 2025 18:08:24 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Nobuhiro Iwamatsu <nobuhiro.iwamatsu.x90@mail.toshiba>
Cc: Frank.Li@nxp.com, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, lpieralisi@kernel.org, kwilczynski@kernel.org, 
	bhelgaas@google.com, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, yuji2.ishikawa@toshiba.co.jp
Subject: Re: [PATCH v3 2/2] PCI: dwc: visconti: Remove cpu_addr_fix() after
 DTS fix ranges
Message-ID: <etltxzybqmhkst3324knpofx46lyp2vju43wvfu47oovfbmo5r@4v4nniat4sx5>
References: <1757298848-15154-1-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
 <1757298848-15154-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1757298848-15154-3-git-send-email-nobuhiro.iwamatsu.x90@mail.toshiba>

On Mon, Sep 08, 2025 at 11:34:08AM GMT, Nobuhiro Iwamatsu wrote:
> From: Frank Li <Frank.Li@nxp.com>
> 
> Remove cpu_addr_fix() since it is no longer needed. The PCIe ranges
> property has been corrected in the DTS, and the DesignWare common code now
> handles address translation properly without requiring this workaround.
> 

What about the old DTs? Wouldn't this driver fail to work if you use it with old
DTs as cpu_addr_fixup() no longer exists?

- Mani

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

-- 
மணிவண்ணன் சதாசிவம்

