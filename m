Return-Path: <linux-pci+bounces-36532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B60B5B8AEB4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86EE81B23687
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56836211A28;
	Fri, 19 Sep 2025 18:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qiTCts8I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EBA560B8A;
	Fri, 19 Sep 2025 18:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758306660; cv=none; b=EYy8zRiqVk8eUK4NLXsvaRdxnZeaQuuIpwR05JkVzaxo9Yd6DxChCeYjAIiiniPAexvMs+By8ZqaaTQXmPjNjH6VVGSoGk11uPVg97V9a5+i14UZEA4TRNAzEyeO4ITbbbIcclKp+haBakhLAK+f5M/uwwSz70072pDXq2gIq18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758306660; c=relaxed/simple;
	bh=VqGaXrsnHDB0BUTkmiNdMkMLAZVWdKAH/20+GH3zJ4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PZcPf3e15cP0n1IFDBQVQa4jiFLc9rl5gWSmCsuFECxusOAsH3SwEEVfUyzo+ebGymTE1rgVMlba8jaA91GFv/9GzqI0NYWDQ9yOHu6wIojvk0tfcdsowdu69b1TDtxHIhGoxnv+2r3gwLdaLqw3aezYdI0t73J4SXcGUYVc1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qiTCts8I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F83C4CEF0;
	Fri, 19 Sep 2025 18:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758306658;
	bh=VqGaXrsnHDB0BUTkmiNdMkMLAZVWdKAH/20+GH3zJ4c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qiTCts8ITuKje9k20xuiq9n+85M+xbls4wD13KoIdMwCL9Af3TTOit6LevDtelBCQ
	 y8KdVdq5c+gWclkluTbPyEpvsfM2EYFiOjal41dTJUahi1kwuEuudZDJNY0aBqotrI
	 Zo4YXug1FwXnGQYx8MRgXLUoxrwMmk4AnmvobngvYR05B/yFwWtXzL6Qj1v3iZR+bK
	 XhenwT9qvFeYVMkz504Pnxj/C4IFhwWT+tgrWYeZLJyipVJzrTLY6GvGBqhO8jS+8Q
	 qb7zUON53XmUNdIjypNaIdYWpKiSlUs9C/lxU5BXUW7gvpbT3rOexT3jQr4V7CTMUl
	 UGUs33Pih9wsA==
Date: Sat, 20 Sep 2025 00:00:47 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, christian.bruel@foss.st.com, 
	qiang.yu@oss.qualcomm.com, mayank.rana@oss.qualcomm.com, thippeswamy.havalige@amd.com, 
	shradha.t@samsung.com, quic_schintav@quicinc.com, inochiama@gmail.com, 
	cassel@kernel.org, kishon@kernel.org, sergio.paracuellos@gmail.com, 
	18255117159@163.com, rongqianfeng@vivo.com, jirislaby@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH v2 04/10] PCI: dwc: ep: Export
 dw_pcie_ep_raise_msix_irq() for pci-keystone
Message-ID: <kb6jxzyihyuhd4qfvdtgxgopzgyymhsflqmheb3fribovdck23@ahswbufb23sv>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-5-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912122356.3326888-5-s-vadapalli@ti.com>

On Fri, Sep 12, 2025 at 05:46:15PM +0530, Siddharth Vadapalli wrote:
> The pci-keystone.c driver uses the 'dw_pcie_ep_raise_msix_irq()' helper.
> In preparation for enabling the pci-keystone.c driver to be built as a
> loadable module, export 'dw_pcie_ep_raise_msix_irq()'.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

This patch could be merged with patch 2.

- Mani

> ---
> 
> v1: https://lore.kernel.org/r/20250903124505.365913-5-s-vadapalli@ti.com/
> No changes since v1.
> 
>  drivers/pci/controller/dwc/pcie-designware-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 7f2112c2fb21..19571ac2b961 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -797,6 +797,7 @@ int dw_pcie_ep_raise_msix_irq(struct dw_pcie_ep *ep, u8 func_no,
>  
>  	return 0;
>  }
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_raise_msix_irq);
>  
>  /**
>   * dw_pcie_ep_cleanup - Cleanup DWC EP resources after fundamental reset
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

