Return-Path: <linux-pci+bounces-6049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45CEC89FDD6
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 19:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9916EB2F718
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 17:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECDF817BB3D;
	Wed, 10 Apr 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jSuLV6q1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C192917BB3B;
	Wed, 10 Apr 2024 17:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712769070; cv=none; b=VN82xyWvdvttzt/kAbbPQtEMvQP+xrzBaJqXEIk/0ImBXpR4vm/6Q8ZskuzDMiGKHNxNbhoK37B/KbjG3fuck0cElIdoiSPYpICW7E9HizLXJVQjCApAOuTDyGunNOmHaK9tyf1BuWtRmUZhjPQfmjnJptcJV3x9it5FnvdQlZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712769070; c=relaxed/simple;
	bh=pg+bgNQLyz5NOFla7/NCdVINpMYIxiAX3SWhPOzVjmA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mZhafVdZa0qKe2/r1bPr6wpa9LM+J5e8g812YYb0AzNQjNAXLozVPjaQOO3Evhhm4uUgAJwbDbSZyKEWR7lRlZR0CALniOw2e1kpfpdsmhmgz+7B4Tn38wbqhaIFgOVtXng+bXo4jbpcpJsi45JZs5pYqPhuLMno0TQiPByROVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jSuLV6q1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB771C433C7;
	Wed, 10 Apr 2024 17:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712769070;
	bh=pg+bgNQLyz5NOFla7/NCdVINpMYIxiAX3SWhPOzVjmA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jSuLV6q1BcVaVMYegTdWTa8o5YcsmL0hXJH/2oR3U7f72MJAxRrpZqvj7bJksbBPg
	 8k/G9p0/6yWdg0Zel0UQ8TSPSwtmJzC+Zfimt3pifXVRulvxUjhiDHqV6MDd139rcj
	 IgVgGWFL+cDgwz8DQ4bNslNLsmd5tntlfy8PNSydwpyNceEfypGzGqpcdiFsTUphMF
	 e3j2O//PGA+B7vLH7Wq4XFE3CG7QDtCv7ZdtfDk4qJK20Qi7afxAncChjFkpujjRid
	 wtjqNv1FQmNT0YlcRSJNtWvfNXznOpHWvkeoHi0ILvnxhaHWaqtM8Fw04P6H6yJbHd
	 nncB/fPDK9tnQ==
Date: Wed, 10 Apr 2024 22:41:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v6 3/7] PCI: dwc: Add PCIE_PORT_{FORCE,LANE_SKEW} macros
Message-ID: <20240410171102.GA16629@thinkpad>
References: <20240410004832.3726922-1-yoshihiro.shimoda.uh@renesas.com>
 <20240410004832.3726922-4-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240410004832.3726922-4-yoshihiro.shimoda.uh@renesas.com>

On Wed, Apr 10, 2024 at 09:48:28AM +0900, Yoshihiro Shimoda wrote:
> R-Car Gen4 PCIe controller needs to use the Synopsys-specific PCIe
> configuration registers. So, add the macros.
> 
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pcie-designware.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 26dae4837462..aa4db6eaf02a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -71,6 +71,9 @@
>  #define LINK_WAIT_IATU			9
>  
>  /* Synopsys-specific PCIe configuration registers */
> +#define PCIE_PORT_FORCE			0x708
> +#define PORT_FORCE_DO_DESKEW_FOR_SRIS	BIT(23)
> +
>  #define PCIE_PORT_AFR			0x70C
>  #define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
>  #define PORT_AFR_N_FTS(n)		FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
> @@ -92,6 +95,9 @@
>  #define PORT_LINK_MODE_4_LANES		PORT_LINK_MODE(0x7)
>  #define PORT_LINK_MODE_8_LANES		PORT_LINK_MODE(0xf)
>  
> +#define PCIE_PORT_LANE_SKEW		0x714
> +#define PORT_LANE_SKEW_INSERT_MASK	GENMASK(23, 0)
> +
>  #define PCIE_PORT_DEBUG0		0x728
>  #define PORT_LOGIC_LTSSM_STATE_MASK	0x1f
>  #define PORT_LOGIC_LTSSM_STATE_L0	0x11
> -- 
> 2.25.1
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

