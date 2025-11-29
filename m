Return-Path: <linux-pci+bounces-42282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 891F3C938D7
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 08:28:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 36B584E072C
	for <lists+linux-pci@lfdr.de>; Sat, 29 Nov 2025 07:28:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0744265CA7;
	Sat, 29 Nov 2025 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NTmefG1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B3A1D8E01;
	Sat, 29 Nov 2025 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764401325; cv=none; b=Ghtp2WyptQcjG+EHsZ2pW1zJSCpdx7gjPBNNcwhH1VJL01s9TevgXFlcxL1SnHWEXVuL2GtLsOTJ6Co+KkfXpBBhTStDCff2jKb95rWk7Y9hXY7VZ7X8vRnYJpof6gcJB4AiusvZbyApG3i0KHseLdxobCK5mTlZOdUxs415OKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764401325; c=relaxed/simple;
	bh=oHArvf5IFFUhUcZ+kfT/89S9/yoeGiFA0H+i1F2XiLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOzZZA212/F8CsPv+l5HpE7wkVTp+Q1uSzhMVOd2E8xXZTXPYtRLDNYhFZXOhVDFxGM7EVIcE1QGCpWdwijokm0kSaPh2dng/yy8jy0+6CaDJryruk1fy6NcjASAR8DjoLMkCmJH3/thC/ctp16zLcqHLyaR8cNX6FbtMg1i3pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NTmefG1q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465CBC4CEF7;
	Sat, 29 Nov 2025 07:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764401324;
	bh=oHArvf5IFFUhUcZ+kfT/89S9/yoeGiFA0H+i1F2XiLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NTmefG1qES3NuCoS3/XcNz40ck+ccDehgDnrnGZZU4Pk071LGsYSGWktohwEBrKSY
	 TN+hdT/1SvuSRUnlYZYyW0cey6YZ6/pkDzJ5soNf0eHDXZJK5/taJfW0qYdzJJD6lk
	 JMrwSRzLpG1527R5fuKsDJo3yv/ZZEezmMi+1fFprNa9qhJY+uJcnSXH4O/cevkuFk
	 JoguoMuFiUjvrCX7kyy9ozjek8TPgm8eUnPuXUoSKz4XxYLDmAymdW+d9BfKLWHooT
	 xwaUuKJejBEwMmcEG1mbo/LfAVcccRhjP839W/Htn1gPRwCdD/iypdud8C9WPB8PtN
	 v+CEmlUUqCKTw==
Date: Sat, 29 Nov 2025 12:58:29 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	cros-qcom-dts-watchers@chromium.org, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Program device-id
Message-ID: <c4sfp6mr65jbt3pfjc5ozeijum3pehjjlxocaloweu4g6y4v7a@p62qqui55tu7>
References: <20251127-program-device-id-v1-0-31ad36beda2c@quicinc.com>
 <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-program-device-id-v1-1-31ad36beda2c@quicinc.com>

On Thu, Nov 27, 2025 at 09:00:51PM +0530, Sushrut Shree Trivedi wrote:
> For some controllers, HW doesn't program the correct device-id
> leading to incorrect identification in lspci. For ex, QCOM
> controller SC7280 uses same device id as SM8250.

The Device ID you are programming is for the Root Port, not for the
controller/Host bridge.

> This would
> cause issues while applying controller specific quirks.
> 

This statement is misleading and wrong. Controller specific quirks cannot be
applied using Root Port IDs. We have controller specific DT compatible propery
for that purpose.

> So, program the correct device-id after reading it from the
> devicetree.
> 

Even though the dtschema allows having these Root Port IDs in the controller
node, it is deprecated (odd that we don't mark it as such). These properties are
supposed to be added to the Root Port binding and the DWC core should parse them
and program the IDs if available.

But the DWC driver doesn't parse Root Port nodes atm. OTOH, your colleague is
working on a series that does that and once that gets submitted, please rebase
this series on top and resend.

- Mani

> Signed-off-by: Sushrut Shree Trivedi <sushrut.trivedi@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
>  drivers/pci/controller/dwc/pcie-designware.h      | 2 ++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index e92513c5bda5..e8b975044b22 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -619,6 +619,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  		}
>  	}
>  
> +	pp->device_id = 0xffff;
> +	of_property_read_u32(np, "device-id", &pp->device_id);
> +
>  	dw_pcie_version_detect(pci);
>  
>  	dw_pcie_iatu_detect(pci);
> @@ -1094,6 +1097,10 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  
>  	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
>  
> +	/* Program correct device id */
> +	if (pp->device_id != 0xffff)
> +		dw_pcie_writew_dbi(pci, PCI_DEVICE_ID, pp->device_id);
> +
>  	/* Program correct class for RC */
>  	dw_pcie_writew_dbi(pci, PCI_CLASS_DEVICE, PCI_CLASS_BRIDGE_PCI);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index e995f692a1ec..eff6da9438c4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -431,6 +431,8 @@ struct dw_pcie_rp {
>  	struct pci_config_window *cfg;
>  	bool			ecam_enabled;
>  	bool			native_ecam;
> +	u32			vendor_id;
> +	u32			device_id;
>  };
>  
>  struct dw_pcie_ep_ops {
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

