Return-Path: <linux-pci+bounces-35066-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F61B3ACD8
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 23:43:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B15FD982311
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 21:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B269C2C11C0;
	Thu, 28 Aug 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UClqFzwt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD132BEC34;
	Thu, 28 Aug 2025 21:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756417384; cv=none; b=ZV19HTCLf0/M7o/PsvX5kfpl10LNgN1FhWabuxxwaObqokjSA6wEvOEElhdki3kgHSN+F/yVvSfsFS17eoxvvRcx0JyaH9EuQQVCLfDA9mTPPmjLTDsgJI1Vks/o05SRzGXaSCWr/soJKOFxfjf/+U+ANbY2HxnDrexu84tNf/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756417384; c=relaxed/simple;
	bh=LgIHZN3qg8ENhN8nHf8+6R2L+PO544XykwdVWD06Rro=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=bYfO9CEgjuSwupEU9PaCtvfVEKhVW24leusnXOe4vb4eRwP5BLcB3sxWiTCr5NSm0Q/FfgyWDUw46i3b4OggWwNRIe1U/i19hE82lRsgIBBe/qD/TnR+0f71WOTIUdeH/w44C4DDdx9X7j7QtwvHeKvEiKBLhXV3QeMtGcoOIKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UClqFzwt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E11C4CEEB;
	Thu, 28 Aug 2025 21:43:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756417384;
	bh=LgIHZN3qg8ENhN8nHf8+6R2L+PO544XykwdVWD06Rro=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UClqFzwtdRXYQgijZAOhJNtFzQO/PGPWgPKqDIuodjKEwk6u38DsfoMzuvN1Kw6rE
	 MGgkWYbzbRpsf9hQM3n4+PezvoKR4QmL/aDNEihv2cwlm2ALDztq8lql+ilv0EDaxh
	 XFRCFeNcYgpSMIWTj50l3wsO4uUte9dNgwYi7MulK9Srj+CCbfgOpWyC4syvtmSqtW
	 URYSbtlDtzwWufGyeXvIVslcW3Z4C7Cf7xt7FCBnkkmZ6VbXJKajlZ569c9bnNirQ2
	 2TO3jgimZJzXZ/17tgmqiTg3JRPGDC2sdtkZKfRqxVsfvrtS4BsvxZNMCBPrStgF6A
	 HdFcOTA01vnWg==
Date: Thu, 28 Aug 2025 16:43:02 -0500
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
Subject: Re: [PATCH 2/5] PCI: cadence: Fix NULL pointer error for ops
Message-ID: <20250828214302.GA968773@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fca633eb6d667a90f875cdf1263fcea2bcc2c969.1756344464.git.unicorn_wang@outlook.com>

On Thu, Aug 28, 2025 at 10:17:17AM +0800, Chen Wang wrote:
> From: Chen Wang <unicorn_wang@outlook.com>
> 
> ops of struct cdns_pcie may be NULL, direct use
> will result in a null pointer error.
> 
> Add checking of pcie->ops before using it.
> 
> Fixes: 40d957e6f9eb ("PCI: cadence: Add support to start link and verify link status")

Do you observe this NULL pointer dereference with an existing driver?

If this is only to make it possible to add a new driver that doesn't
supply a pcie->ops pointer, it doesn't need a Fixes: tag because
there's not a problem with existing drivers and this change would not
need to be backported.

If it *is* a problem with an existing driver, please point out which
one.

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

