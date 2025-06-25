Return-Path: <linux-pci+bounces-30658-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A42BAE8FB7
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 22:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200203BE0C6
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 20:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94F1420B801;
	Wed, 25 Jun 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsY8MbQS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E561E9B35;
	Wed, 25 Jun 2025 20:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750885057; cv=none; b=PwewBL8oKpbJZwjyGjLczTWPkwo9QifE1K40t4GJSav2lgX/RMPNXsggBpDvr/AUOpNykLw0JYJP1X8ULJ+zZC1mpLu1Ve6g355yo4hmbv0paKAz6YwyvbNWneO4AkiAAqzle2RDA9yzd1pHq5VmsUQ8IpwvQZSOGdsZwGB1Ccc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750885057; c=relaxed/simple;
	bh=CONJvh9GTvQNHiz6RDThEGWt/rqqD1237zzZv4uI+TU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KTa2MCsFkWwkirHVfiwIqonNk2eknU9zHa7jA5fnUAOx1vz1J7a5ELFoiwpPSOcs1OkdfklnldOZS6rZx6IYv90U4Cra/GxcE2pJk8mbEI7+ztBo3Pu39ckFW+39QBblSInqm8PcY8IDqn4d/WwqoKCzAUmjsSgXHg1LXyBwtJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NsY8MbQS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16B48C4CEEA;
	Wed, 25 Jun 2025 20:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750885057;
	bh=CONJvh9GTvQNHiz6RDThEGWt/rqqD1237zzZv4uI+TU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NsY8MbQSr/FWAyLyQKy0V1OdBJdQrvtOmCxXJwTBm0iysH//ZgI+k942HearjhGNO
	 LTsLetKBXJYXNnbkcMR41zlIIPp0e+mcvgkZag0BtB12Zct8wzj1/OPfNf0xFtj79f
	 9O+fQ54QDjcH2512vrHV7bM0yaH6qKER2jFLLqo/KdFxQxJxeoqune5/Fwg0f7muvc
	 mf9xHXG+VowHFfo0lOuwJjc+9zqkb1UcK3d4ZriC/U5cAASjG8j1jmOj1G+wMDhPhI
	 56/8eBOfHJOgAs5lJmNpBwsAFsgDwcT0bWuwdfPlYQ587vzCy+rgVr5WW1cU6ea2TN
	 yW1an6uVBZpqw==
Date: Wed, 25 Jun 2025 14:57:34 -0600
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	robh@kernel.org, jingoohan1@gmail.com, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/13] PCI: tegra194: Refactor code by using
 dw_pcie_clear_and_set_dword()
Message-ID: <ci3ojmiiuajwedx3desa7vf5lkk35meaj4kdqnunf3f66knvm5@gtgxoagzl7ek>
References: <20250618152112.1010147-1-18255117159@163.com>
 <20250618152112.1010147-14-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250618152112.1010147-14-18255117159@163.com>

On Wed, Jun 18, 2025 at 11:21:12PM +0800, Hans Zhang wrote:
> Tegra194 PCIe driver contains extensive manual bit manipulation across
> interrupt handling, ASPM configuration, and controller initialization.
> The driver implements complex read-modify-write sequences with explicit
> bit masking, leading to verbose and hard-to-maintain code.
> 
> Refactor interrupt handling, ASPM setup, capability configuration, and
> controller initialization using dw_pcie_clear_and_set_dword(). Replace
> multi-step register modifications with single helper calls, eliminating
> intermediate variables and reducing code size by ~100 lines. For CDMA
> error handling, initialize the value variable to zero before setting
> status bits.
> 
> This comprehensive refactoring significantly improves code readability
> and maintainability. Standardizing on the helper ensures consistent
> register access patterns across all driver components and reduces the
> risk of bit manipulation errors in this complex controller driver.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
>  drivers/pci/controller/dwc/pcie-tegra194.c | 155 +++++++++------------
>  1 file changed, 64 insertions(+), 91 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index 4f26086f25da..c6f5c35a4be4 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -378,9 +378,8 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
>  			val |= APPL_CAR_RESET_OVRD_CYA_OVERRIDE_CORE_RST_N;
>  			appl_writel(pcie, val, APPL_CAR_RESET_OVRD);
>  
> -			val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
> -			val |= PORT_LOGIC_SPEED_CHANGE;
> -			dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
> +			dw_pcie_clear_and_set_dword(pci, PCIE_LINK_WIDTH_SPEED_CONTROL,
> +						    0, PORT_LOGIC_SPEED_CHANGE);
>  		}
>  	}
>  
> @@ -412,7 +411,7 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
>  
>  	if (status_l0 & APPL_INTR_STATUS_L0_CDM_REG_CHK_INT) {
>  		status_l1 = appl_readl(pcie, APPL_INTR_STATUS_L1_18);
> -		val = dw_pcie_readl_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS);
> +		val = 0;
>  		if (status_l1 & APPL_INTR_STATUS_L1_18_CDM_REG_CHK_CMPLT) {
>  			dev_info(pci->dev, "CDM check complete\n");
>  			val |= PCIE_PL_CHK_REG_CHK_REG_COMPLETE;
> @@ -425,7 +424,8 @@ static irqreturn_t tegra_pcie_rp_irq_handler(int irq, void *arg)
>  			dev_err(pci->dev, "CDM Logic error\n");
>  			val |= PCIE_PL_CHK_REG_CHK_REG_LOGIC_ERROR;
>  		}
> -		dw_pcie_writel_dbi(pci, PCIE_PL_CHK_REG_CONTROL_STATUS, val);
> +		dw_pcie_clear_and_set_dword(pci, PCIE_PL_CHK_REG_CONTROL_STATUS,
> +					    PORT_LOGIC_SPEED_CHANGE, val);

I don't know why you are clearing PORT_LOGIC_SPEED_CHANGE here which is not part
of PCIE_PL_CHK_REG_CONTROL_STATUS. Typo?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

