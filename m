Return-Path: <linux-pci+bounces-10010-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD8E92C118
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 18:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23755281AEC
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC1E91A4F14;
	Tue,  9 Jul 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDBLvmZB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13D01A4F07;
	Tue,  9 Jul 2024 16:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720542378; cv=none; b=seG3k32gfkFOUR74rpVtH+w3Z/aEKkMJ/C7qmKMYVmXwpIOSx6iFT3kz7ocMrC+heoNt/i+Y7tf7MRcgBCvEPV4Nftas3QhQG9wPrmDpkgveg5WRPL6nFqV9JG8+kgMMgcfKqoGE/NSCyFbUKAELisY+BkdJwo6nRh5yw2dMayo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720542378; c=relaxed/simple;
	bh=+bZLGqWY1DDBcyTEH10hsAqp0+mebKEECO2I2Lb/wl8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cKTYgS6+0y02D5Agn+k8Q3TCAyJX8LGBys+E+wOSZo2sb92ayoG9Unz9RARG+kCLu0C4iAa6RBiYDJVnhdwb9qXTKjU6UEAqq6f5C9YFB5tJ99/+ySwNMP0wShIA8+Q6ep/eTAq+Oi3jQ0Hbh4lwy3ycXHIQ/ZRdvWkLkJPFavI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDBLvmZB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03FCBC3277B;
	Tue,  9 Jul 2024 16:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542378;
	bh=+bZLGqWY1DDBcyTEH10hsAqp0+mebKEECO2I2Lb/wl8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=IDBLvmZBCCFufsM+sPjL6bm0hoX51V5WbYI6jjJCmWNdXwhUXuEWUtbmUAVlSVtaY
	 7VUq0dOWOd5vPkGKLT6vEIzv94XAWqZLNJ0yNkJYm9G7wTSvtjbe/j+RIa4fNLaHvQ
	 eVe67BFLUV9sbdO/iuphzr8kwE/ZExgNxGeTcHa1LKQV0Ig+5Py1irT1nVCktdT/xt
	 N7Gzb3U01PW2GVllWF9hXRL3FDHxBhuSbtnJ/BDkR6J0GhrLKlgbTEUzCh9k32nLVb
	 90Ve4y/HS6L+EKvDda1dkV+pYt8E0xyUFicvcX9xixXBZ+tIDg/VWptNhM+M8k5Yl0
	 /RqOzI/LgAMVQ==
Date: Tue, 9 Jul 2024 11:26:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kernel@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] PCI: qcom: Add support for QCS9100 SoC
Message-ID: <20240709162616.GA175928@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709-add_qcs9100_pcie_compatible-v2-2-04f1e85c8a48@quicinc.com>

On Tue, Jul 09, 2024 at 10:59:30PM +0800, Tengfei Fan wrote:
> Add support for QCS9100 SoC that uses controller version 5.90
> reusing the 1.9.0 config.

Add blank line here if this is a paragraph break.

> QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
> platform use non-SCMI resource. In the future, the SA8775p platform will
> move to use SCMI resources and it will have new sa8775p-related device
> tree. Consequently, introduce "qcom,pcie-qcs9100" to the PCIe device
> match table.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 26405fcfa499..ea3fddc74498 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1722,6 +1722,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
> +	{ .compatible = "qcom,pcie-qcs9100", .data = &cfg_sc8280xp },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
>  	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
>  	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
> 
> -- 
> 2.25.1
> 

