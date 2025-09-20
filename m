Return-Path: <linux-pci+bounces-36560-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9C1B8C0A6
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 08:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E4D281C025A9
	for <lists+linux-pci@lfdr.de>; Sat, 20 Sep 2025 06:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42D6621C163;
	Sat, 20 Sep 2025 06:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bv3OTZMM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1366C1E1E0B;
	Sat, 20 Sep 2025 06:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758349748; cv=none; b=O6CmMI98E3YzUtbeI+d/NczFzgEOrahz6WGkwmsn5ncq8mdjf+2rKVS5VSmL0KqJOV497PqMqXgC6zBRmo+XxKc8dZvCu7RcxtCkrnlRBFZRAjy9ulbb83qYrfmkdIIDb/W11dkEugRvDKDYtbnzngWUsVV4WWlagP44SpPj+M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758349748; c=relaxed/simple;
	bh=lsXrFVLVVP9m7FF0K5jKakOvUcFLx4HMxLX5PqFqHl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/ZN+D2AtfN2mAqlp4QjGmBQh99Qf+TDYbK2psPyA8bkEiPaVrpNI7xM3kDG4uI3d2cVVdkdMzX8qSNm7GDx+7nXthPcllYYtdk9na508jT4hIATseDqTOgjDq19zPZ4gzGgP/NpzVMaCvzciv7cGIW3EHRlDOlaNs/xJG+YRHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bv3OTZMM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8071DC4CEEB;
	Sat, 20 Sep 2025 06:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758349747;
	bh=lsXrFVLVVP9m7FF0K5jKakOvUcFLx4HMxLX5PqFqHl8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bv3OTZMMtf23WfTRwCojxCISILg6q3AsIaxhzSxVqz0ZbI8KEsjM0fWGmrgMBv1lJ
	 vqeD/OoS1EZXRpLRoEbtbfh53ase85/5rpaQ4uXvR6IAC8dke/eX3xxde3VodbmFqQ
	 YqgWzmEulSZZ+qrfljy0zqsXLc+jSlkd1hoqpypU/0vDV+gMb+CZwxL4vPOkwOhpwm
	 k2DWf9bBC9H6ZKRDZY5qt61NRBXrcqevMeBkmbmqScfAOtMPMRT52mGcp//WTaJm6W
	 ltCMALC9cru0HztqsISFXjepJYUrmKHm6iCsz66BfW5inV+WLlj+CwukxAUtqJiEsz
	 U3weTvQ7X4pRg==
Date: Sat, 20 Sep 2025 11:58:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, jingoohan1@gmail.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, bhelgaas@google.com, 
	shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de, 
	festevam@gmail.com, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	imx@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/6] PCI: dwc: Don't poll L2 if QUIRK_NOL2POLL_IN_PM
 is existing in suspend
Message-ID: <p4hqjnhpih2uy5hzf7llrd3ah7ov6sijkuqjecpvv5j2iqrsji@kxj5xwb7a5p4>
References: <20250902080151.3748965-1-hongxing.zhu@nxp.com>
 <20250902080151.3748965-3-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250902080151.3748965-3-hongxing.zhu@nxp.com>

On Tue, Sep 02, 2025 at 04:01:47PM +0800, Richard Zhu wrote:
> Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management State Flow
> Diagram. Both L0 and L2/L3 Ready can be transferred to LDn directly.
> 
> It's harmless to let dw_pcie_suspend_noirq() proceed suspend after the
> PME_Turn_Off is sent out, whatever the LTSSM state is in L2 or L3 after
> a recommended 10ms max wait refer to PCIe r6.0, sec 5.3.3.2.1 PME
> Synchronization.
> 
> The LTSSM states are inaccessible on i.MX6QP and i.MX7D after the
> PME_Turn_Off is sent out.
> 

This statement is not accurate. A single register read cannot cause hang AFAIK.
I'm guessing that the link down (LDn) happens after initiating PME_Turn_Off and
the access to CSR register (LTSSM) causes hang.

Is my understanding correct?

> To support this case, don't poll L2 state and apply a simple delay of
> PCIE_PME_TO_L2_TIMEOUT_US(10ms) if the QUIRK_NOL2POLL_IN_PM flag is set
> in suspend.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>

We need Fixes tag also and you do need to set the flag in relevant glue driver
in this patch itself so that it can cleanly be backported.

- Mani

> ---
>  .../pci/controller/dwc/pcie-designware-host.c | 34 +++++++++++++------
>  drivers/pci/controller/dwc/pcie-designware.h  |  4 +++
>  2 files changed, 28 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 9d46d1f0334b..57a1ba08c427 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -1016,15 +1016,29 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  			return ret;
>  	}
>  
> -	ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> -				val == DW_PCIE_LTSSM_L2_IDLE ||
> -				val <= DW_PCIE_LTSSM_DETECT_WAIT,
> -				PCIE_PME_TO_L2_TIMEOUT_US/10,
> -				PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> -	if (ret) {
> -		/* Only log message when LTSSM isn't in DETECT or POLL */
> -		dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> -		return ret;
> +	if (dwc_quirk(pci, QUIRK_NOL2POLL_IN_PM)) {
> +		/*
> +		 * Add the QUIRK_NOL2_POLL_IN_PM case to avoid the read hang,
> +		 * when LTSSM is not powered in L2/L3/LDn properly.
> +		 *
> +		 * Refer to PCIe r6.0, sec 5.2, fig 5-1 Link Power Management
> +		 * State Flow Diagram. Both L0 and L2/L3 Ready can be
> +		 * transferred to LDn directly. On the LTSSM states poll broken
> +		 * platforms, add a max 10ms delay refer to PCIe r6.0,
> +		 * sec 5.3.3.2.1 PME Synchronization.
> +		 */
> +		mdelay(PCIE_PME_TO_L2_TIMEOUT_US/1000);
> +	} else {
> +		ret = read_poll_timeout(dw_pcie_get_ltssm, val,
> +					val == DW_PCIE_LTSSM_L2_IDLE ||
> +					val <= DW_PCIE_LTSSM_DETECT_WAIT,
> +					PCIE_PME_TO_L2_TIMEOUT_US/10,
> +					PCIE_PME_TO_L2_TIMEOUT_US, false, pci);
> +		if (ret) {
> +			/* Only log message when LTSSM isn't in DETECT or POLL */
> +			dev_err(pci->dev, "Timeout waiting for L2 entry! LTSSM: 0x%x\n", val);
> +			return ret;
> +		}
>  	}
>  
>  	/*
> @@ -1040,7 +1054,7 @@ int dw_pcie_suspend_noirq(struct dw_pcie *pci)
>  
>  	pci->suspended = true;
>  
> -	return ret;
> +	return 0;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_suspend_noirq);
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 00f52d472dcd..4e5bf6cb6ce8 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -295,6 +295,9 @@
>  /* Default eDMA LLP memory size */
>  #define DMA_LLP_MEM_SIZE		PAGE_SIZE
>  
> +#define QUIRK_NOL2POLL_IN_PM		BIT(0)
> +#define dwc_quirk(pci, val)		(pci->quirk_flag & val)
> +
>  struct dw_pcie;
>  struct dw_pcie_rp;
>  struct dw_pcie_ep;
> @@ -504,6 +507,7 @@ struct dw_pcie {
>  	const struct dw_pcie_ops *ops;
>  	u32			version;
>  	u32			type;
> +	u32			quirk_flag;
>  	unsigned long		caps;
>  	int			num_lanes;
>  	int			max_link_speed;
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

