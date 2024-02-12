Return-Path: <linux-pci+bounces-3365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2852F851DF3
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 20:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D116B1F22237
	for <lists+linux-pci@lfdr.de>; Mon, 12 Feb 2024 19:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D414B46B8B;
	Mon, 12 Feb 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWeOW25H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31F941208;
	Mon, 12 Feb 2024 19:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707766491; cv=none; b=qGIab9FCdV0ZSOIs6V5FoxrEQlzONJPMSd2W1n1GWED6/IeY9jXIRh2NkAbW0xJUQn2o/lNuzC2TJjkQMI24fQM+uxo2GzMQiUnVT/GqzEI5VBNlZ05m0IQhK/bqW+bK77lMkLh92dhSCBb9aTI8tf+LXFoix7PBxnnIiIhxqrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707766491; c=relaxed/simple;
	bh=nF/W9im/q2B4aRyWcrrSClAFU50zTQuGi9M8O1D/k7A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=r0P9OMPVAwDoq7bbapurWYUkHnDwOQmHD7vDc3LgPNoGrmSOsJteq91sgam3WCde6M5l3oWma/Cg4kqaEgIrAyDq9Emc63twpvoa0sRVvVSt3E1VINCinx7gPbtEvqhnadPkptVhKDuyfU2JXqgHIncz9XpsOxHrXZXXdHI2XLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWeOW25H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1FA7C433C7;
	Mon, 12 Feb 2024 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707766491;
	bh=nF/W9im/q2B4aRyWcrrSClAFU50zTQuGi9M8O1D/k7A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=LWeOW25H53HICdFI6UZvcSCaQycgQwTPoIOz/IgrUsF1fE3Pj9qAahLbda13Yb94a
	 bB8FzXdPrcrf8qXXP4nFok5/Kq55TChFbJLVlUq81T2XQ7uKyeSm7tPeRCIygnNtLe
	 upBZm/EJCsFqVMsMTvEFNKW4HHcqfvwGA89iCLG80xhYhn5glk37Essoz/N6iePCc3
	 U/9QoTxXQ6eUpn3lzdZF5Ay2n/aSGv2fC2fhwYr2EtRD3XUrPwjbRijUd9yufw0VOB
	 rfXiP6hAaDYPK5/Aiafdx/35SChK+TzShzaGph2W1KTTIeZITe+wZCdDp5HPHlPPkj
	 UpvkyxG7Memxg==
Date: Mon, 12 Feb 2024 13:34:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 08/10] PCI: qcom: Add support for disabling ASPM L0s in
 devicetree
Message-ID: <20240212193449.GA1142362@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240212165043.26961-9-johan+linaro@kernel.org>

On Mon, Feb 12, 2024 at 05:50:41PM +0100, Johan Hovold wrote:
> A recent commit started enabling ASPM unconditionally when the hardware
> claims to support it. This triggers Correctable Errors for some PCIe
> devices on machines like the Lenovo ThinkPad X13s, which could indicate
> an incomplete driver ASPM implementation or that the hardware does in
> fact not support L0s.

I think it would be useful for debugging purposes to identify the
specific commit.  Maybe it's 9f4f3dfad8cf ("PCI: qcom: Enable ASPM for
platforms supporting 1.9.0 ops") ?

> Add support for disabling ASPM L0s in the devicetree when it is not
> supported on a particular machine and controller.
> 
> Note that only the 1.9.0 ops enable ASPM currently.
> 
> Fixes: a9a023c05697 ("PCI: qcom: Add support for disabling ASPM L0s in devicetree")

I don't see this SHA1 in the PCI tree; is it a stable SHA1 from
somewhere else?

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 2455decc574a..071741b81644 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -273,6 +273,25 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static void qcom_pcie_clear_aspm_l0s(struct dw_pcie *pci)
> +{
> +	u16 offset;
> +	u32 val;
> +
> +	if (!of_property_read_bool(pci->dev->of_node, "aspm-no-l0s"))
> +		return;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +
> +	dw_pcie_dbi_ro_wr_en(pci);
> +
> +	val = readl(pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +	val &= ~PCI_EXP_LNKCAP_ASPM_L0S;
> +	writel(val, pci->dbi_base + offset + PCI_EXP_LNKCAP);
> +
> +	dw_pcie_dbi_ro_wr_dis(pci);
> +}
> +
>  static void qcom_pcie_clear_hpc(struct dw_pcie *pci)
>  {
>  	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> @@ -962,6 +981,7 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
>  
>  static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
>  {
> +	qcom_pcie_clear_aspm_l0s(pcie->pci);
>  	qcom_pcie_clear_hpc(pcie->pci);
>  
>  	return 0;
> -- 
> 2.43.0
> 

