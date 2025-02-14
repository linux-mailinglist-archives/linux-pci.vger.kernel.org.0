Return-Path: <linux-pci+bounces-21487-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 516FBA363D6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:03:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A999E7A2361
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC826267AF3;
	Fri, 14 Feb 2025 17:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BurkNfgK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F10267AEA;
	Fri, 14 Feb 2025 17:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739552612; cv=none; b=VsWM4mRTalxnThXON0K04xrcAQhfeUJZckr/vosejKbYV7FOKPVJxzFw2nyEXIu/kiIuaCKPexRR3zjHM2dKbLQEqt7dYXbbzd3Ik8ryuuhyNA57KMbK+WL9FhXcnlgaFecoaP8PtCavRt9T5Y/Q9kBOWwSOcX4dg3L2ga2OZ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739552612; c=relaxed/simple;
	bh=eQv9BUPy9s4YbE7/4SzCwlxnlCvlPoKPIg/Dq5xy/5c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iUf2YWsvBgdcx2kSCMgK0VmwUcqqGRmEG180+zKdoeo46kSz/r7U6Eoh4T8tXaJifbJYnmmb/IP9BMYVKlku/LhDertZX6iJFriBKXRyes9KXgupORQbyEDyE3igNYzowcupGOrE9d8sqOsDmPjOzxYKj2Yhqzs0KiETkr8QTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BurkNfgK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD9C5C4CED1;
	Fri, 14 Feb 2025 17:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739552611;
	bh=eQv9BUPy9s4YbE7/4SzCwlxnlCvlPoKPIg/Dq5xy/5c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BurkNfgKSgiYxiUJreHOcmzvTDiua1q2hh6ZOtVl9TpZIP9B9WxrQGX79q590S1SB
	 Dcr0K6PmBr7j6PZGG5UYzvCIyuFtu6xq5Wdi5x32JRkCjBcHxH9eL9FzhmrAjdWl89
	 X9EckMeaNeSnfJCJN8lNG2hwq65TRKe1CzNJpmBZdP7hOFjHrQab/+bU3X7YL1NHYf
	 4ZZKXeR8LTk0WojnG8JAbk2vu33LK05/PgAxzMRuhx3mLApG5UjapRB3xBwX18SwvA
	 V1moAtgyVHYgdnFl7K5WcJb1RGTAJ1OnKNgZD5ru0e66Of2mLmWSGJ6WB0Z8mb36QK
	 TW/QiZJ2Ccx9w==
Date: Fri, 14 Feb 2025 22:33:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, bwawrzyn@cisco.com,
	cassel@kernel.org, wojciech.jasko-EXT@continental-corporation.com,
	a-verma1@ti.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com
Subject: Re: [v4] PCI: cadence-ep: Fix the driver to send MSG TLP for INTx
 without data payload
Message-ID: <20250214170322.efgjw56fsofrk4b6@thinkpad>
References: <20250214165724.184599-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250214165724.184599-1-18255117159@163.com>

On Sat, Feb 15, 2025 at 12:57:24AM +0800, Hans Zhang wrote:
> Cadence reference manual cdn_pcie_gen4_hpa_axi_ips_ug_v1.04.pdf, section
> 9.1.7.1 'AXI Subordinate to PCIe Address Translation' mentions that
> axi_s_awaddr bits 16 when set, corresponds to MSG with data and when not
> set, MSG without data.
> 
> But the driver is doing the opposite and due to this, INTx is never
> received on the host. So fix the driver to reflect the documentation and
> also make INTx work.
> 
> Fixes: 37dddf14f1ae ("PCI: cadence: Add EndPoint Controller driver for Cadence PCIe controller")
> Signed-off-by: Hans Zhang <18255117159@163.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes since v3:
> https://lore.kernel.org/linux-pci/20250207103923.32190-1-18255117159@163.com/
> 
> - Add Fixes: tag.
> - The patch subject and commit message were modified.
> 
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
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

