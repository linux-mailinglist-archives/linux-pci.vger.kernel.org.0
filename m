Return-Path: <linux-pci+bounces-35273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BB6CB3E5F2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 15:48:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A6731A84CFF
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 13:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661A5338F4F;
	Mon,  1 Sep 2025 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhSNrK9Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332D93D994;
	Mon,  1 Sep 2025 13:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756734507; cv=none; b=ES/5gywWr5bICy/nLG2ttJvG7Ew4T/ZfSbtan8M7f1jcSRXxWsEyXyylOH1c+k9iQr3s6iHZg/bglFyCudMGyikENqER1qJdQtp9FiHIjLcnqt2F3AhIi5+Tu9Bsfm/aUr74yZ/nNLsZvCKr/24I0dFHMM15EOPCIgY707e1qS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756734507; c=relaxed/simple;
	bh=/Pvcy4bursWi390Rpt2TJ2bXnqNX+VIc9UKr7lISbXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f672LqOSVDl5u+VK3eZAJDLN/7M+bNMNx7KYOVw1suXTRjWTm65m2Et7Fg2/lY8xDxdgT7CvJXgbabCsVfmUq2ZO2+CnkM+nVgzxofdC89erxF8L86TEZRdOJKoOxcZocdO21QfresES1OjUGtu2Bz7EBIaQMPfEMlMOx0K93Ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhSNrK9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5CE2C4CEF0;
	Mon,  1 Sep 2025 13:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756734506;
	bh=/Pvcy4bursWi390Rpt2TJ2bXnqNX+VIc9UKr7lISbXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BhSNrK9QFAfb/Z24V8KjA2fuph0gJfEIFYp9+oCX8fq70rQcCFQ6S6/29L15dKldg
	 uuiVKPfRdB7N8O6rfqRfBVkQRokF3kxF6qTZVgC2MoE3OWdMO1Iq3Bf+rutOrMrz2l
	 iZH2u5US9WbMjXN/ggl1OjvHhuWwUnIwsW7l0MJ8CnWGdpW2rSeYnh/AOaHxCpL+ut
	 O0S+MXJHIOPlEMPLXYUXFueWcdjdNSoxZxOsBneEJBXbHjRiar80/0cNkbFHbxEmwJ
	 Sagi9tZB3BN+Zpf6z9nWenOxjuDT+bGOOcKNBvfFfejzPQdBq3HaAlN2wxwMVJaWpO
	 cToyATbuL0rAw==
Date: Mon, 1 Sep 2025 19:18:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_mrana@quicinc.com, quic_vpernami@quicinc.com, mmareddy@quicinc.com
Subject: Re: [PATCH v8 2/5] PCI: dwc: Add support for ELBI resource mapping
Message-ID: <rijfzrfngdtfc2ckxarzrcyt3xx23mldmijdlx7efbkputhkxz@i4cvdsmtavge>
References: <20250828-ecam_v4-v8-0-92a30e0fa02d@oss.qualcomm.com>
 <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250828-ecam_v4-v8-2-92a30e0fa02d@oss.qualcomm.com>

On Thu, Aug 28, 2025 at 01:04:23PM GMT, Krishna Chaitanya Chundru wrote:
> External Local Bus Interface(ELBI) registers are optional registers in
> DWC IPs having vendor specific registers.
> 
> Since ELBI register space is applicable for all DWC based controllers,
> move the resource get code to DWC core and make it optional.
> 

As discussed offline, this changes also warrants switching the glue drivers to
use 'dw_pci::elbi' base instead of their own. So I've ammended this commit to
include those changes also while applying (which was straightforward).

- Mani

> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 9 +++++++++
>  drivers/pci/controller/dwc/pcie-designware.h | 1 +
>  2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 89aad5a08928cc29870ab258d33bee9ff8f83143..4684c671a81bee468f686a83cc992433b38af59d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -167,6 +167,15 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
>  		}
>  	}
>  
> +	if (!pci->elbi_base) {
> +		res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "elbi");
> +		if (res) {
> +			pci->elbi_base = devm_ioremap_resource(pci->dev, res);
> +			if (IS_ERR(pci->elbi_base))
> +				return PTR_ERR(pci->elbi_base);
> +		}
> +	}
> +
>  	/* LLDD is supposed to manually switch the clocks and resets state */
>  	if (dw_pcie_cap_is(pci, REQ_RES)) {
>  		ret = dw_pcie_get_clocks(pci);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 00f52d472dcdd794013a865ad6c4c7cc251edb48..ceb022506c3191cd8fe580411526e20cc3758fed 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -492,6 +492,7 @@ struct dw_pcie {
>  	resource_size_t		dbi_phys_addr;
>  	void __iomem		*dbi_base2;
>  	void __iomem		*atu_base;
> +	void __iomem		*elbi_base;
>  	resource_size_t		atu_phys_addr;
>  	size_t			atu_size;
>  	resource_size_t		parent_bus_offset;
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

