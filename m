Return-Path: <linux-pci+bounces-36778-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E13B96666
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 16:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5808344391A
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 14:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01925E47D;
	Tue, 23 Sep 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nKtzcs/r"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D3B1EE7B7;
	Tue, 23 Sep 2025 14:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758638545; cv=none; b=jhAY96CfZful7EXWPFEhz7j5TEr6u9BSsPi9B9f+NWHwXpF+UgC0voLp/VegNdDjoh+WDG9GpGT+AEphe8V7pJFPwsLYFLT1hiY0jb3TWy1BZZH5gGV6Wq5y7nNcQX3RXPjDgTFTCTUfhutwpxdKhj2Gj2l97tgU4Uggu1S7RPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758638545; c=relaxed/simple;
	bh=LhjAgb6cgHNp6OL8pcGSJUCyxHEjPb4wLfpmEKTiQcA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=PV281gVUA1ryoL7x9tPtlRXzDu2u8diwWwrgJRsaW68mXA5rbB4xOMfKzF8XIhahNQwrSmZkiNfbQrdW3EHj17tV6DTHhfJwI3Oe96aaao1PThtzr1/uVeiDeeVR7orGj5FiF1aST99x0/uZvD2b3hqU4jT/kgcPeM+gDS6Tm3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nKtzcs/r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550AEC4CEF5;
	Tue, 23 Sep 2025 14:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758638545;
	bh=LhjAgb6cgHNp6OL8pcGSJUCyxHEjPb4wLfpmEKTiQcA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=nKtzcs/rDklsb7BBzw37q6GESHy8punJWjUaYFFkFxTKL3hNYgOWmFZaKEOuOVt4w
	 SxGXiCsE6P46Un9IksGHBCl4UQneYfYuNwXg4MYJNDdxU9jTfAXGEn38FRK+ly9k3o
	 vnn448Vp300VR7z4tG/XySg2wVyOq4+OwQKadoxeVBjdiLTEhw7WpV0A9T+WrTlOmy
	 GV6mLRnDyxQWlal9FAhMGmU2FC9m3ua8xZ8PrfGQUJhuMY8WWsPR9WhnSESA0U/yxY
	 weU1fSVzjyCNHwroccKHTheNdTkZ/4GPvTx/qDLncX3W8sUSFx0BrVQsiFWb3JYRjH
	 pYc8/Xu9+QzQQ==
Date: Tue, 23 Sep 2025 09:42:23 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Randolph Lin <randolph@andestech.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	jingoohan1@gmail.com, mani@kernel.org, lpieralisi@kernel.org,
	kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com,
	krzk+dt@kernel.org, conor+dt@kernel.org, alex@ghiti.fr,
	aou@eecs.berkeley.edu, palmer@dabbelt.com, paul.walmsley@sifive.com,
	ben717@andestech.com, inochiama@gmail.com,
	thippeswamy.havalige@amd.com, namcao@linutronix.de,
	shradha.t@samsung.com, randolph.sklin@gmail.com,
	tim609@andestech.com
Subject: Re: [PATCH v3 1/5] PCI: dwc: Skip failed outbound iATU and continue
Message-ID: <20250923144223.GA2032427@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250923113647.895686-2-randolph@andestech.com>

On Tue, Sep 23, 2025 at 07:36:43PM +0800, Randolph Lin wrote:
> Previously, outbound iATU programming included range checks based
> on hardware limitations. If a configuration did not meet these
> constraints, the loop would stop immediately.
> 
> This patch updates the behavior to enhance flexibility. Instead of
> stopping at the first issue, it now logs a warning with details of
> the affected window and proceeds to program the remaining iATU
> entries.
> 
> This enables partial configuration to complete in cases where some
> iATU windows may not meet requirements, improving overall
> compatibility.

It's not really clear why this is needed.  I assume it's related to
dropping qilai_pcie_outbound_atu_addr_valid().

I guess dw_pcie_prog_outbound_atu() must return an error for one of
the QiLai ranges?  Which one, and what exactly is the problem?  I
still suspect something wrong in the devicetree description.

> Signed-off-by: Randolph Lin <randolph@andestech.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 952f8594b501..91ee6b903934 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -756,7 +756,7 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  		if (resource_type(entry->res) != IORESOURCE_MEM)
>  			continue;
>  
> -		if (pci->num_ob_windows <= ++i)
> +		if (pci->num_ob_windows <= i)
>  			break;
>  
>  		atu.index = i;
> @@ -773,9 +773,10 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  
>  		ret = dw_pcie_prog_outbound_atu(pci, &atu);
>  		if (ret) {
> -			dev_err(pci->dev, "Failed to set MEM range %pr\n",
> -				entry->res);
> -			return ret;
> +			dev_warn(pci->dev, "Failed to set MEM range %pr\n",
> +				 entry->res);
> +		} else {
> +			i++;
>  		}
>  	}
>  
> -- 
> 2.34.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

