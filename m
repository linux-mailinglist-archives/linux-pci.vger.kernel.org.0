Return-Path: <linux-pci+bounces-36565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFF10B8C0CD
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AC891C05AB7
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:35:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B382D543E;
	Sat, 20 Sep 2025 06:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9OgdNF6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4965722069E;
	Sat, 20 Sep 2025 06:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758350109; cv=none; b=MXjLXsoWDoCFKx2lSuV6JB6qsCz/OjVjeJpe27Hm3VtjO0WEITiCSzpiN1IFdu/8YxgfYqudtoPrf1A0T+ilGK5BIPeR6/JJJddhdQre5ap9a7bL3hqWMQBGGe6n/4tWGdYJMpe3P+N6M4zaO/m6RHOOZSL3kiX073hOVvxCjek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758350109; c=relaxed/simple;
	bh=kwd//CRsPpYonPR8lPo9/P6DkUgi8kn1wjpddW4+60c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZbJ3Kqlb0mHGesuOQnPFglTFUwfhQRN9wUIXPUJ55p0WVsc2U4dLD3bNKqVqZ5UGJlEmxgXqYjklF/pd55bzUsIphgXHiuunHQ0sMZdkXt5LCfRYCTuhwHLWdRjZq1VtETfIc4mktqaNBOEqACy0Njm9NkDlvbw5t2Cke9HhqG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9OgdNF6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6057C4CEEB;
	Sat, 20 Sep 2025 06:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758350108;
	bh=kwd//CRsPpYonPR8lPo9/P6DkUgi8kn1wjpddW4+60c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D9OgdNF6cJgOC++kArIJCVA7PmzZXs1OTytQ8fwdI7sisUC5uYFZgmlOrHYhcjT7Q
	 RTUU8jggbblvCQYof8Gw06UanMTuh6SpluvLbDbp8Gxon5Gib1EGSPyPtSOEU+hZyu
	 Ajcj9oZlLNr8JW7Un/TlPsoJgA0r/4xQKHi51MRW/ZaPIvyYEZNPAbzMTfdNV/3qHG
	 qJwrdcgDidlWaFisbEGu0lJYROt++27+6BTHhC/O5EZRjcJPjTwBUYGA7j2spILZKn
	 eLIyAr3OZE28hx7N9imBKG+j93NbJUP4i0jUF1ZtfvmdLyKev1g4YDKQonlhdaWpRT
	 EZ/T7KKNY454A==
Date: Sat, 20 Sep 2025 12:04:59 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 6/6] PCI: dwc: Don't return error when wait for link
 up in dw_pcie_resume_noirq()
Message-ID: <lbmeboonxcvviqfc72ozrtnzqsblnv7qdt2owyxs7tcjkc6vmt@e7oe6jtssj36>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-7-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902080151.3748965-7-hongxing.zhu@nxp.com>

On Tue, Sep 02, 2025 at 04:01:51PM +0800, Richard Zhu wrote:
> When waiting for the PCIe link to come up, both link up and link down
> are valid results depending on the device state.
> 
> Since the link may come up later and to get rid of the following
> mis-reported PM errors. Do not return an -ETIMEDOUT error, as the
> outcome has already been reported in dw_pcie_wait_for_link().
> 
> PM error logs introduced by the -ETIMEDOUT error return.
> imx6q-pcie 33800000.pcie: Phy link never came up
> imx6q-pcie 33800000.pcie: PM: dpm_run_callback(): genpd_resume_noirq returns -110
> imx6q-pcie 33800000.pcie: PM: failed to resume noirq: error -110
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Again, Fixes tag is needed. Also CC stable list since this should be backported.

- Mani

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index b303a74b0fd7..c4386be38a07 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1084,10 +1084,9 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
>  	if (ret)
>  		return ret;
>  
> -	ret = dw_pcie_wait_for_link(pci);
> -	if (ret)
> -		return ret;
> +	/* Ignore errors, the link may come up later */
> +	dw_pcie_wait_for_link(pci);
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

