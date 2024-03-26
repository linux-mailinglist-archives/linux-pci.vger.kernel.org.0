Return-Path: <linux-pci+bounces-5166-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D3488BFB5
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 11:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C188D2E7DBA
	for <lists+linux-pci@lfdr.de>; Tue, 26 Mar 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E7E468E;
	Tue, 26 Mar 2024 10:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIOgLcin"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFFD748A;
	Tue, 26 Mar 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711449452; cv=none; b=W+/w/NyByAbk1vzJKKPIYCdzOohsMMNlOamtPIvbJ+C6i1+UmteclnM39I+2dm+qzOyZ+wo+ILFL1ldO6vZaOWwkEyXHVDIM98WltPhv2XQeMmamjzK7OxlyU4Fu1W6UjkquWhYZcIh4P5bkQybQwNSsqNO2PirYWmevQzXrzY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711449452; c=relaxed/simple;
	bh=aNOwmWd+mF/9qimz0zNFCCBFCUwOQRmpJaxlHlvMnnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8F1LhlAhtJqGoJemYA6Vaj5zv3HTbyZwtDkWmZsm9r91bhTXwWbdXeXU7ubuQuXr0VwHJXcLBmYy0+HiIcxFg8aM7oMM5jz5S+np0hp1aCXGBtBZTNMH+Am0jiZURy61/Jihw7Ady4dXrN5EhAG+9UsQwTdvpbsUTiFvw9YRAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XIOgLcin; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E18C433F1;
	Tue, 26 Mar 2024 10:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711449451;
	bh=aNOwmWd+mF/9qimz0zNFCCBFCUwOQRmpJaxlHlvMnnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XIOgLcinpEW/3DD10dKAmt20XSXw/wj2ovE7KJ+luqJH8KeQLkI4WIiONF3PbzjZM
	 kmrN0WnM2jAVQeBqDEsCS1AHiPCAuTIILET97TDFdWiqpHA5sXhijYWgM9LjRvFuK3
	 W8YaQsr+nAezIsRM/s0VEIBom9jn/rY+Ivt9UFSRsXnKPQ7mkdrj/gXQNCPpOYc5Ts
	 F06tgwJDSPfn2FxKugm6mczz/segB1UmYiSkXJvhHcGUidyMNj8eMfL9p5/S0xQ4Ij
	 05yQ1+4IWRXCDl4/E7t805EFCN7afgtUN8/W99o4ZaQOF31CKivlKVMUXO6xsfDAN6
	 TPrDcunPxK0gg==
Date: Tue, 26 Mar 2024 11:37:25 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 01/11] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Message-ID: <ZgKlZU-vbzjUhn_e@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-1-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:40PM +0530, Manivannan Sadhasivam wrote:
> All EP specific resources are enabled during PERST# deassert. As a counter
> operation, all resources should be disabled during PERST# assert. There is
> no point in skipping that if the link was not enabled.
> 
> This will also result in enablement of the resources twice if PERST# got
> deasserted again. So remove the check from qcom_pcie_perst_assert() and
> disable all the resources unconditionally.
> 
> Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 2fb8c15e7a91..50b1635e3cbb 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
> -	struct device *dev = pci->dev;
> -
> -	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
> -		dev_dbg(dev, "Link is already disabled\n");
> -		return;
> -	}
>  
>  	dw_pcie_ep_cleanup(&pci->ep);
>  	qcom_pcie_disable_resources(pcie_ep);
> 
> -- 
> 2.25.1
> 

It would be nice if you could do a similar change to pcie-tegra,
so that the drivers are in sync, as that is not strictly related:

Reviewed-by: Niklas Cassel <cassel@kernel.org>

