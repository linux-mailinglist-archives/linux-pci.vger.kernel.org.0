Return-Path: <linux-pci+bounces-21479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2988FA362B2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:06:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6F521892033
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 16:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82898266EE3;
	Fri, 14 Feb 2025 16:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic7Fe/Ku"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5723822F165;
	Fri, 14 Feb 2025 16:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739549201; cv=none; b=q/At4+WMwdzWeHHb3EhuRc4zm7e4a1KD7XKpLkOMoHpweDCYZ9HI2xz958Ef/RmbFEpNIjb7pf+fEPUB25kNN2f3xi3VA89lf3kDStmWzc+DhCQ870JvOMuOAclJ2e3fGJt8V885Oucbtx1KvmM4YyFOePAg694C83atblansSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739549201; c=relaxed/simple;
	bh=V6vmFc+uBjzAPQIGxrV3kgp6ssq5TYM+J9C8A/QYXPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s0Bsfe9eBZiIuZjah4roSGB58PsEgA0m8vOMUv6071AGHzZcWd/+5swXD1fcljp81NeVwPcGhsbcHUM/2tNV5UhIlxHmXR7VeDW6BZJ6JmsL2ZBtJpCMeB4J11pS7j2FWtydqNLRPOD6R68vxbOJAf13K2rTbgCSqLJEGcb+puU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic7Fe/Ku; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 908B4C4CEDF;
	Fri, 14 Feb 2025 16:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739549200;
	bh=V6vmFc+uBjzAPQIGxrV3kgp6ssq5TYM+J9C8A/QYXPw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ic7Fe/Ku/JBVhKJKs6/1fZOSQm9kVvwaUSySsGMlBdF1Qpo8/e5v7Jsp4SyBVXMDa
	 pToOQQed7NkWmKOk9Uw4nGaqBqi7rr+HlAvzdV2+g5cmFI+CWm4a7fKG43u0WcWFBA
	 ts6qs7YBkjI+j81xU5/plnCeSJJMKU/BUwvENiC4HG0SSCOr89B2DC+yQV5mfR2UBA
	 JUDjt029VSiYvF6YeCItc941TUDFB/ldQ8KAkzXAQCyT4jiRIHMfqeheHL11p50Igx
	 RrgC7pHb01/YTOoFO3IgV5qMeVvs4OcWSRMbgcRN52NfEbsXw2SKwZqQa46e1PYzUT
	 HhJj7pODAPtlQ==
Date: Fri, 14 Feb 2025 21:36:30 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v3] PCI: cadence: Fix sending message with data or without data
Message-ID: <20250214160630.i3vbyl3e3a73onfa@thinkpad>
References: <20250207103923.32190-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250207103923.32190-1-18255117159@163.com>

On Fri, Feb 07, 2025 at 06:39:23PM +0800, Hans Zhang wrote:

Subject should be changed as:

PCI: cadence-ep: Fix the driver to send MSG TLP for INTx without data payload

> View from cdns document cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf.
> In section 9.1.7.1 AXI Subordinate to PCIe Address Translation
> Registers below:
> 
> axi_s_awaddr bits 16 is 1 for MSG with data and 0 for MSG without data.
> 

How about,

Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
set, MSG without data.

But the driver is doing the opposite and due to this, INTx is never
received on the host. So fix the driver to reflect the documentation and
also make INTx work.

> Signed-off-by: hans.zhang <18255117159@163.com>

Please add the Fixes tag also.

- Mani

> ---
> Changes since v1-v2:
> - Change email number and Signed-off-by
> ---
>  drivers/pci/controller/cadence/pcie-cadence-ep.c | 3 +--
>  drivers/pci/controller/cadence/pcie-cadence.h    | 2 +-
>  2 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index e0cc4560dfde..0bf4cde34f51 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -352,8 +352,7 @@ static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn, u8 intx,
>  	spin_unlock_irqrestore(&ep->lock, flags);
>  
>  	offset = CDNS_PCIE_NORMAL_MSG_ROUTING(MSG_ROUTING_LOCAL) |
> -		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code) |
> -		 CDNS_PCIE_MSG_NO_DATA;
> +		 CDNS_PCIE_NORMAL_MSG_CODE(msg_code);
>  	writel(0, ep->irq_cpu_addr + offset);
>  }
>  
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index f5eeff834ec1..39ee9945c903 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -246,7 +246,7 @@ struct cdns_pcie_rp_ib_bar {
>  #define CDNS_PCIE_NORMAL_MSG_CODE_MASK		GENMASK(15, 8)
>  #define CDNS_PCIE_NORMAL_MSG_CODE(code) \
>  	(((code) << 8) & CDNS_PCIE_NORMAL_MSG_CODE_MASK)
> -#define CDNS_PCIE_MSG_NO_DATA			BIT(16)
> +#define CDNS_PCIE_MSG_DATA			BIT(16)
>  
>  struct cdns_pcie;
>  
> 
> base-commit: bb066fe812d6fb3a9d01c073d9f1e2fd5a63403b
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

