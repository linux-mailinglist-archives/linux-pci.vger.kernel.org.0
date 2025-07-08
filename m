Return-Path: <linux-pci+bounces-31701-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A838AFD52F
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 19:19:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02FC17BA04
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 17:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F912E5B3C;
	Tue,  8 Jul 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YupQ0fRi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CE22DAFAE;
	Tue,  8 Jul 2025 17:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751995164; cv=none; b=e7NpciY1c+cG90rh8szPKO9Z/hW/k0q8P+yg3MupSQNwdY/2xJA7LCyBYafTodrwHSjJmZt30Z37CrScQ3CZe+jYZbzf0HEwm8LhxDzP0ljvXrsGMP++x8h7Pz7+Ou/O5FQEQOEDN8aVb9Ox+V02mEQcJrV7K8KRGLcXs99q1Xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751995164; c=relaxed/simple;
	bh=YjcSIKwzWx+y59NsLqb2Sq1rlWrfeyHEI74U75VzYhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9bFKy3HbHSaZWBEyHEQNMaHXPy/cuZzWfWouiDsgHubxNLyaUyM1s7pChVKdQh0EfiRqRAKKbRqRxIqgX81bsviTRrSD/l2BEt7yTYbibVWou4bYpOem4oEjBNPVhv3I/U9JakRKboOZn7FbYWF8esGb/cpCvqUjLTLNOlH/oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YupQ0fRi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95A3EC4CEED;
	Tue,  8 Jul 2025 17:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751995163;
	bh=YjcSIKwzWx+y59NsLqb2Sq1rlWrfeyHEI74U75VzYhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YupQ0fRi/jd248RnYSxckJ3rI2Hf7dDwKl1r73wmizS7K7KfOLHWYV504AV1bbsNh
	 w8LiJveWIkC/BLUH4MAsjSnm0ku09bjxacHWEdv6YD9vLsGTgMDRRtWWQe1MpmJLjS
	 2Xj9hic0l4Xue5wlumPmdDCaFntf1fO/6uJ9rtug0M4IX36ByRwDgnrXO0xBJDbPW9
	 bSIfOvMsR8eoBFSFTGVACrrxIk9zrCPTIe0KKgP870B7qeBSoELObNltlqY9xq3b98
	 GS4axDNb2GGyG1a1wbJlC01tnZlrCgbtgiXpw0xujDEiqvkkY9u8ztDuqRH5vd4fHV
	 2fo64+sL6QOqw==
Date: Tue, 8 Jul 2025 22:49:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Jingoo Han <jingoohan1@gmail.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, qiang.yu@oss.qualcomm.com, quic_vbadigan@quicinc.com, 
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com, 
	Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v4 08/11] PCI: qcom: Add support for PCIe
 pre/post_link_speed_change()
Message-ID: <6awuzg6leintuqmbrn2hztjmimtvbokpiivui3lfzlscx33odu@mkh5jtfszi5r>
References: <20250609-mhi_bw_up-v4-0-3faa8fe92b05@qti.qualcomm.com>
 <20250609-mhi_bw_up-v4-8-3faa8fe92b05@qti.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609-mhi_bw_up-v4-8-3faa8fe92b05@qti.qualcomm.com>

On Mon, Jun 09, 2025 at 04:21:29PM GMT, Krishna Chaitanya Chundru wrote:
> QCOM PCIe controllers need to disable ASPM before initiating link
> re-train. So as part of pre_link_speed_change() disable ASPM and as
> part of post_link_speed_change() enable ASPM back.
> 
> As the driver needs to enable the ASPM states that are enabled
> by the system, save PCI ASPM states before disabling them and
> in post_link_speed_change() use the saved ASPM states to enable
> back the ASPM.
> 
> Update ICC & OPP votes based on the requested speed so that RPMh votes
> get updated based on the speed.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 63 ++++++++++++++++++++++++++++++++++
>  1 file changed, 63 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 02643579707f45fc7279023feb7dbc903e69822d..c4aa193bbdcc928603ae50e8d7029b152d62f977 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -276,10 +276,16 @@ struct qcom_pcie {
>  	struct dentry *debugfs;
>  	bool suspended;
>  	bool use_pm_opp;
> +	int aspm_state; /* Store ASPM state used in pre & post link speed change */
>  };
>  
>  #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
>  
> +static void qcom_pcie_post_link_speed_change(struct pci_host_bridge *bridge,
> +					     struct pci_dev *pdev, int current_speed);
> +static int qcom_pcie_pre_link_speed_change(struct pci_host_bridge *bridge,
> +					   struct pci_dev *pdev, int current_speed);
> +
>  static void qcom_ep_reset_assert(struct qcom_pcie *pcie)
>  {
>  	gpiod_set_value_cansleep(pcie->reset, 1);
> @@ -1263,6 +1269,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
>  			goto err_assert_reset;
>  	}
>  
> +	pp->bridge->pre_link_speed_change = qcom_pcie_pre_link_speed_change;
> +	pp->bridge->post_link_speed_change = qcom_pcie_post_link_speed_change;
>  	return 0;
>  
>  err_assert_reset:
> @@ -1328,6 +1336,61 @@ static int qcom_pcie_set_icc_opp(struct qcom_pcie *pcie, int speed, int width)
>  	return ret;
>  }
>  
> +static int qcom_pcie_scale_bw(struct dw_pcie_rp *pp, int speed)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 offset, status, width;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +
> +	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
> +
> +	return qcom_pcie_set_icc_opp(pcie, speed, width);
> +}
> +
> +static void qcom_pcie_post_link_speed_change(struct pci_host_bridge *bridge,
> +					     struct pci_dev *pdev, int current_speed)

pdev is the 'port' isn't it?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

