Return-Path: <linux-pci+bounces-17712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 779099E4877
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 00:11:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EA3D1880522
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 23:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F8F1F543E;
	Wed,  4 Dec 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YT0nZoWG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4E91917D7;
	Wed,  4 Dec 2024 23:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733353859; cv=none; b=b/vlm+4BMhPkQAvU71MLp9Pt7ZPK/dqKGW6JNzY8aO8r5XEoDr4TBEOVqjgmZGPSxHxronkCiExW0gifYDxqMZ0pscWXKAks6QkbSNF6JMNSCnwK3/DT9RGdKxC2L+FWnlTPD2EUIJS0Tm/ujjdYhwyt9VBKn88hTD1L3snGvgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733353859; c=relaxed/simple;
	bh=7XpoUhfG8MJEb4Fmy8iGPH/58klFSTC5STKYSZRdPQ4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=UtzD4Hu8sSL/8ZgxaCQk4phASol2w72vC09M2DFQ57yxnDfbaBHy/o4DyqisNPSGVMphEr/6OMKEESIWfXjVvrbHIlR0Iyj2GHZzTZ/ujC1oVBFiTKrmE13BGDWStG1rI50m5sdfcSF9gd7ovQ4yQZcOU94a6OyXZABA/QOh120=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YT0nZoWG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CD4C4CECD;
	Wed,  4 Dec 2024 23:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733353858;
	bh=7XpoUhfG8MJEb4Fmy8iGPH/58klFSTC5STKYSZRdPQ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YT0nZoWGHpepu2vQiyPAF527lbR3ZNU77EGCUanhHJ0GR2NX7HGuJ2Zcb2mUNzvN9
	 F0vxJRbNdB7uch7LnST0dlKcrNVXV2rRPnX5/pjMkYHsQwObfG416NeTW+IBsCQqPg
	 FniktmAElhIppocLFaR7yyGbgV7qYGKzQdCvHK6ZyRCbMMwBmFKYWcKbGc5s+TCi4d
	 zPcdCptwyvqZBi5y7YdqUYIiIT4OCGmLc5hQpZdZXHLrq2V32fvtkAp/jYIe4iiYp/
	 BO9vfBmSMRdZiJh9024capOJ3W+pTRtag30efwd9yB8ccNh3mb592XD2iyNJKwHaUK
	 teATnJWy4pbJQ==
Date: Wed, 4 Dec 2024 17:10:57 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Varadarajan Narayanan <quic_varada@quicinc.com>
Cc: lpieralisi@kernel.org, kw@linux.com, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
	andersson@kernel.org, konradybcio@kernel.org,
	p.zabel@pengutronix.de, quic_nsekar@quicinc.com,
	dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	Praveenkumar I <quic_ipkumar@quicinc.com>
Subject: Re: [PATCH v2 4/6] pci: qcom: Add support for IPQ5332
Message-ID: <20241204231057.GA3026683@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204113329.3195627-5-quic_varada@quicinc.com>

On Wed, Dec 04, 2024 at 05:03:27PM +0530, Varadarajan Narayanan wrote:
> From: Praveenkumar I <quic_ipkumar@quicinc.com>
> 
> The Qualcomm IPQ5332 PCIe controller instances are based on
> SNPS core 5.90a with Gen3 Single-lane and Dual-lane support.
> The Qualcomm IP can be handled by the 2.9.0 ops, hence using
> that for IPQ5332.

If you have occasion to update this series, please update the subject
to follow the drivers/pci convention (use "git log --oneline
drivers/pci/controller/dwc/pcie-qcom.c" and match the capitalization
style):

  PCI: qcom: Add IPQ5332 support

> Signed-off-by: Praveenkumar I <quic_ipkumar@quicinc.com>
> Signed-off-by: Varadarajan Narayanan <quic_varada@quicinc.com>
> ---
> v2: Removed dependency on [1]
> 
> 1. https://lore.kernel.org/all/20230519090219.15925-1-quic_devipriy@quicinc.com/
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index dc102d8bd58c..68e6f97535db 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1835,6 +1835,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-apq8084", .data = &cfg_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq4019", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-ipq5332", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-ipq6018", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
> -- 
> 2.34.1
> 
> 
> -- 
> linux-phy mailing list
> linux-phy@lists.infradead.org
> https://lists.infradead.org/mailman/listinfo/linux-phy

