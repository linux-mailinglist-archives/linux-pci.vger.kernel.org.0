Return-Path: <linux-pci+bounces-36535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD1ABB8AF0E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:37:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97C61587BCD
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B2025CC64;
	Fri, 19 Sep 2025 18:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O31sX8wv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF6525A33F;
	Fri, 19 Sep 2025 18:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307018; cv=none; b=qyz9BnwNSXPnTExhBVJPS3obOceGefkEfBX6dodxJ7V2rANTZqJNpFkk3KqhZO3Kimmyh+i+U2pEENEALO8WCJVDOcgZlrMQyvJe6mofNIUl+YT48rMMj8z3VjBng7G/5Ag+tga8zKYiEuB3guK3Imo4lIyCRQu43eYa1wvHgZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307018; c=relaxed/simple;
	bh=iywf2XUVkfJv534hhdlLGZ+yOgrjcyl7VuGSUy57e6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5DXVz6GR5nJircQUZgiY2SF9Rh5/AvHfuZOWzuZ83shCwCdxsZNDHztyAet4GwjFJmm8UJeYHcOD4GplUr5ah1qc95cTcM0aXm5yk7YxU0m3TejVO/h4Tsq4rm4nQxdmnoXX+DyiGBPw412onbWLY8HgBqQgV/3SqsTZN0zmu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O31sX8wv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C754C4CEF0;
	Fri, 19 Sep 2025 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307017;
	bh=iywf2XUVkfJv534hhdlLGZ+yOgrjcyl7VuGSUy57e6U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O31sX8wvF3L2SvcQVdppWH4aPVQzPgdarm4vEk41OAEIzdHn6RmmcE3wbWUk9Hyf1
	 fXeLwvZOpTQnkfqzyqEFWzTpB5U8X4e4LvpqgGaPPQd6+C3Hk0fJjFV6PCd+eL/lx1
	 Ot9GM/Tss29As8mZV9yBUb8QYQq+L1GiY8x9SAp/QZ+zhY0vDu5X3DYhVAx1bWMryN
	 0sikJaHrGsTd19B0xAoXKjZbtXWBI1Vk7o7YATfJbrLOqkriaIqTa29JWc5cxc/Ptg
	 89+TTti8LA/7vpEsStmmrO8VLyu0D9brkgF+wQd5DH2T2Yg04pQV4TDSrvp4t+xYJG
	 hPw9FU7GiVdmw==
Date: Sat, 20 Sep 2025 00:06:46 +0530
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
Subject: Re: [PATCH v2 09/10] PCI: keystone: Exit ks_pcie_probe() for the
 default switch-case of "mode"
Message-ID: <lo2zv3nxek57s3h4hwv2ujzophdx2ubfuam4gqmo5h77t2g4jo@447qpc7a4ub3>
References: <20250912122356.3326888-1-s-vadapalli@ti.com>
 <20250912122356.3326888-10-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912122356.3326888-10-s-vadapalli@ti.com>

On Fri, Sep 12, 2025 at 05:46:20PM +0530, Siddharth Vadapalli wrote:
> In ks_pcie_probe(), the switch-case for the "mode" is used to configure
> the PCIe Controller for either Root-Complex or Endpoint mode of operation.
> Prior to the switch-case statement for "mode" an invalid mode will result
> in probe failure only if "dw_pcie_ver_is_ge(pci, 480A)" is true, which
> is the case for the AM654 platform. On the other hand, when that is not
> the case, "ks_pcie_set_mode()" will be invoked, which does not validate
> the mode. As a result, it is possible for the switch-case statement for
> "mode" to receive an invalid mode. Currently, an error message is displayed
> in the "default" case where "mode" is neither "DW_PCIE_RC_TYPE" nor
> "DW_PCIE_EP_TYPE", but the probe succeeds. However, since the configuration
> required for Root-Complex and Endpoint mode have not been performed, the
> Controller is not operational.
> 
> Fix this by exiting "ks_pcie_probe()" with the return value of "-EINVAL"
> in addition to displaying the existing error message.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Fixes tag? And probably CC stable since the controller seems to be not
operations without this fix.

- Mani

> ---
> 
> v1: https://lore.kernel.org/r/20250903124505.365913-11-s-vadapalli@ti.com/
> No changes since v1.
> 
>  drivers/pci/controller/dwc/pci-keystone.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 2da9feaaf9ee..e85942b4f6be 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -1414,6 +1414,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
>  		break;
>  	default:
>  		dev_err(dev, "INVALID device type %d\n", mode);
> +		ret = -EINVAL;
> +		goto err_get_sync;
>  	}
>  
>  	ks_pcie_enable_error_irq(ks_pcie);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

