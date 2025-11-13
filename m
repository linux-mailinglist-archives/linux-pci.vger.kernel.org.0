Return-Path: <linux-pci+bounces-41136-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4568FC58FFE
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6871B35FF79
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85475334395;
	Thu, 13 Nov 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIzgUDB0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AED72FABE7;
	Thu, 13 Nov 2025 16:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763052109; cv=none; b=GunVq5dz9KrvwRanq1n+/vTbXQCAFx7LO9pycX3qDTHbxGbTcldXeQ8rtkALJ0KcjyuHmVMQcIyGo3qjiH41GuopMT9KkbAjdBu1GR51HOSWtp0Sn3qrnRADD29W26UJ7SLSK4x6zZ8kjAfLA7P1aSHmVgWbh4HH5cpLEc8H0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763052109; c=relaxed/simple;
	bh=LaRCBS/NM2UH70AYb59BDNP5EEFwL4hnOEnhhOk227U=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ESG7EmOQc1XZLvS4tH1UpFb+KInQxY1OyRwa/ptg2sy4VFYDHrAeE2Sy+Zl6h4YpFqDDcagJF4AkgNhmoTt5Y0uHzQFAtW8kr7xFIbQllmKy7S+KSy4D0CafDvbJzdGUq20ywbSNU/wbh+IhHvKEjw22QqkVtk0nZh3bqpEIMSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIzgUDB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6B8C113D0;
	Thu, 13 Nov 2025 16:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763052109;
	bh=LaRCBS/NM2UH70AYb59BDNP5EEFwL4hnOEnhhOk227U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=pIzgUDB04zVZWchKSc7agD9XxYb2HMujtHvPel3xlr/GKXvEogwuoZ+78k3+vch45
	 NbF4hBjE6nuZAdnCE6glNR+88s+s4HsysFyLiWqhpfCWgsWiuxPWKxoAsML95KzN0t
	 9PO4WOG3CVw4jPZRG+OXRHmwh8lf8CbSbxpLb5JNQ3cZ2sTkTNmd19SQ1+c3NgGuEw
	 lWsKvYO5X6HeS5ZhV5gQR8wDUflwfyG5FldD3Qo8o6g10u407JoSYExuWAUDOImCwX
	 C8X1+/CBkUc2mq0E5ujO/qLkg8/ujI123JuWWynGi+RpdWFHGDXjIO1f7JlDL7OGtM
	 mKKAm+gWnlO0g==
Date: Thu, 13 Nov 2025 10:41:47 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org,
	bhelgaas@google.com, will@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, robh@kernel.org,
	linux-arm-msm@vger.kernel.org, zhangsenchuan@eswincomputing.com,
	vincent.guittot@linaro.org
Subject: Re: [PATCH v2 2/3] PCI: qcom: Check for the presence of a device
 instead of Link up during suspend
Message-ID: <20251113164147.GA2285894@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107044319.8356-3-manivannan.sadhasivam@oss.qualcomm.com>

On Fri, Nov 07, 2025 at 10:13:18AM +0530, Manivannan Sadhasivam wrote:
> The suspend handler checks for the PCIe Link up to decide when to turn off
> the controller resources. But this check is racy as the PCIe Link can go
> down just after this check.
> 
> So use the newly introduced API, pci_root_ports_have_device() that checks
> for the presence of a device under any of the Root Ports to replace the
> Link up check.

Why is pci_root_ports_have_device() itself not racy?

> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 805edbbfe7eb..b2b89e2e4916 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -2018,6 +2018,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  static int qcom_pcie_suspend_noirq(struct device *dev)
>  {
>  	struct qcom_pcie *pcie;
> +	struct dw_pcie_rp *pp;
>  	int ret = 0;
>  
>  	pcie = dev_get_drvdata(dev);
> @@ -2053,8 +2054,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	 * powerdown state. This will affect the lifetime of the storage devices
>  	 * like NVMe.
>  	 */
> -	if (!dw_pcie_link_up(pcie->pci)) {
> -		qcom_pcie_host_deinit(&pcie->pci->pp);
> +	pp = &pcie->pci->pp;
> +	if (!pci_root_ports_have_device(pp->bridge->bus)) {
> +		qcom_pcie_host_deinit(pp);
>  		pcie->suspended = true;
>  	}
>  
> -- 
> 2.48.1
> 

