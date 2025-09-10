Return-Path: <linux-pci+bounces-35811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B61EB51939
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 16:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBDF116B6E4
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 14:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A58430F93E;
	Wed, 10 Sep 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZXqV7Y5w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7671684A4;
	Wed, 10 Sep 2025 14:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757514203; cv=none; b=ovnr9FzyPd1fCDgbwItWZasdoglbkR2N+0yv8MSHYyobZC8RcSbN2CgVCT6V7JQZCF/Tx2GBB3oc3dsZZ0ogzu3O3qY2SnLWCcDU+EsMYjSxUFPl3PkwBYDYSTP7ci8bLmbTbWwt6Wkxz9UBaPVTaAHm9yfVoV/QIcZdtO3TRRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757514203; c=relaxed/simple;
	bh=sPrb8D0bSLp1Js3/8C0uU0W0ATkZZf+fqUxj/05AtlY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PjtJO5vEWLlMFN0oOtARUpXI6O9DTtddHyYL5kprF+GTJWCUNGL/bzqgegDAP1UJgmIB8hTnLQOkr1XU527xd1A4hj4yZvzoETLk3EYUltOldsLuY36kOzPIdAX3+ZqfheOCCOjNZs/yH9FnZ20mowiAxhOJs1ODZQQwvNXim1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZXqV7Y5w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79A7FC4CEEB;
	Wed, 10 Sep 2025 14:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757514202;
	bh=sPrb8D0bSLp1Js3/8C0uU0W0ATkZZf+fqUxj/05AtlY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZXqV7Y5wyyMy8XPbh7JLpkdcpaKmaztp6Y0DwSjdEv41hAbGELyFer083foOLZxDB
	 uVTwM9d0VzXe5ApdhOhBcOigUrmCndv5r7VieWdnOyaoM19Y2rzdYnc1aoBHnuFulc
	 AqIe8dr5b831dN+Kb2n63v4Akag6nRBwY80VbL4FSiuspLylF3TddTA/6EyrER5x/B
	 DDJiWxz4rrkQ5gD0S9WprL3hWsUolUwdU5r0Q36JY+D4tTcHsNqhb229bRBfxu4z9Y
	 ZHr8s3wIy6jmv8qTiakGq+vJ6g4lTDSc0pwVl5u9S7lykALNBAxV4MmKgjiH15D5tn
	 w5RdZe7h8z7oA==
Date: Wed, 10 Sep 2025 09:23:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Chen Wang <unicornxw@gmail.com>
Cc: kwilczynski@kernel.org, u.kleine-koenig@baylibre.com,
	aou@eecs.berkeley.edu, alex@ghiti.fr, arnd@arndb.de,
	bwawrzyn@cisco.com, bhelgaas@google.com, unicorn_wang@outlook.com,
	conor+dt@kernel.org, 18255117159@163.com, inochiama@gmail.com,
	kishon@kernel.org, krzk+dt@kernel.org, lpieralisi@kernel.org,
	mani@kernel.org, palmer@dabbelt.com, paul.walmsley@sifive.com,
	robh@kernel.org, s-vadapalli@ti.com, tglx@linutronix.de,
	thomas.richard@bootlin.com, sycamoremoon376@gmail.com,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-riscv@lists.infradead.org,
	sophgo@lists.linux.dev, rabenda.cn@gmail.com, chao.wei@sophgo.com,
	xiaoguang.xing@sophgo.com, fengchun.li@sophgo.com
Subject: Re: [PATCH v2 2/7] PCI: cadence: Check pcie-ops before using it.
Message-ID: <20250910142321.GA1533672@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <18aba25b853d00caf10cc784093c0b91fdc1747d.1757467895.git.unicorn_wang@outlook.com>

Drop period at end of subject.

On Wed, Sep 10, 2025 at 10:08:16AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> ops of struct cdns_pcie may be NULL, direct use
> will result in a null pointer error.
> 
> Add checking of pcie->ops before using it for new
> driver that may not supply pcie->ops.
> 
> Signed-off-by: Chen Wang <unicorn_wang@outlook.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 2 +-
>  drivers/pci/controller/cadence/pcie-cadence.c      | 4 ++--
>  drivers/pci/controller/cadence/pcie-cadence.h      | 6 +++---
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-host.c b/drivers/pci/controller/cadence/pcie-cadence-host.c
> index 59a4631de79f..fffd63d6665e 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-host.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-host.c
> @@ -531,7 +531,7 @@ static int cdns_pcie_host_init_address_translation(struct cdns_pcie_rc *rc)
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_PCI_ADDR1(0), addr1);
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(0), desc1);
>  
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>  		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>  
>  	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(12) |
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.c b/drivers/pci/controller/cadence/pcie-cadence.c
> index 70a19573440e..61806bbd8aa3 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence.c
> @@ -92,7 +92,7 @@ void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>  	cdns_pcie_writel(pcie, CDNS_PCIE_AT_OB_REGION_DESC1(r), desc1);
>  
>  	/* Set the CPU address */
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>  		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>  
>  	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(nbits) |
> @@ -123,7 +123,7 @@ void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>  	}
>  
>  	/* Set the CPU address */
> -	if (pcie->ops->cpu_addr_fixup)
> +	if (pcie->ops && pcie->ops->cpu_addr_fixup)
>  		cpu_addr = pcie->ops->cpu_addr_fixup(pcie, cpu_addr);
>  
>  	addr0 = CDNS_PCIE_AT_OB_REGION_CPU_ADDR0_NBITS(17) |
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index 1d81c4bf6c6d..2f07ba661bda 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -468,7 +468,7 @@ static inline u32 cdns_pcie_ep_fn_readl(struct cdns_pcie *pcie, u8 fn, u32 reg)
>  
>  static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>  {
> -	if (pcie->ops->start_link)
> +	if (pcie->ops && pcie->ops->start_link)
>  		return pcie->ops->start_link(pcie);
>  
>  	return 0;
> @@ -476,13 +476,13 @@ static inline int cdns_pcie_start_link(struct cdns_pcie *pcie)
>  
>  static inline void cdns_pcie_stop_link(struct cdns_pcie *pcie)
>  {
> -	if (pcie->ops->stop_link)
> +	if (pcie->ops && pcie->ops->stop_link)
>  		pcie->ops->stop_link(pcie);
>  }
>  
>  static inline bool cdns_pcie_link_up(struct cdns_pcie *pcie)
>  {
> -	if (pcie->ops->link_up)
> +	if (pcie->ops && pcie->ops->link_up)
>  		return pcie->ops->link_up(pcie);
>  
>  	return true;
> -- 
> 2.34.1
> 

