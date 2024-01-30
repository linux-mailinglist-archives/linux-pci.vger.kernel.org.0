Return-Path: <linux-pci+bounces-2777-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F028E841E6E
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 09:53:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A74BD2886E7
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jan 2024 08:53:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C9757889;
	Tue, 30 Jan 2024 08:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v1u6GWIY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC2B59150
	for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706604795; cv=none; b=OmAYev2eMshWx405oOYhwL/HBEJwV7OacSwgi5SCz/JMsfjeOW+6bNQBFra39S7hqA40I9w7s/UxlQPvyx7DbBHXimNbwQ9Z2uxQp6lPEyqgh8lE7T4nBSd/TkNh5F59eVJZl/8sGU5BgKH6liuGlaQiL41qkYa/cRWuSFAyGIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706604795; c=relaxed/simple;
	bh=uwmEmEVy0Kx70knw/kmKnAvju629yO2leUrWM8MOq/k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MCBH79GCiYd97iSvf9N8zh/pHS62+xJso06J19E/7HFfVSz+cZ9s2deJ/MZGJmaM2rX2Izs2yHiBYTHwwYMhQh11lL5NZTYDdkOlvXA9ylGJAPPhEZ3IE8rKzI2kDzNyOgp4sZ9H71X9bWfJiG7Uxd78TMaPVSlujhNOfV1G3FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v1u6GWIY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dc6a631a90dso192929276.2
        for <linux-pci@vger.kernel.org>; Tue, 30 Jan 2024 00:53:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706604791; x=1707209591; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NWbHSmMZcbcTPFNjHs15M83nAeyP7oSVXTG00tGkv3M=;
        b=v1u6GWIYq6Hgxrk5f9TxLCFfPJHtquvT8V2pUIbrNQDu+5PHbbQhQ9XNztKl2s4E/l
         RXwASjzJz1gkPV9lI9Eaz/+lC8lrA77EGFd3srFuxcplH5vDLZ9vuJ3j71S9k9kUduus
         r1HM/Prwy1C0YiPlCVeT5cRt8uSn/6mYXoSCJtbopcKD90GTfpoIxcpD6DJxGHTW7lkB
         DdVJ89ISf6TpgmzL2nHfV21h5pkFrclavbeYMhlFF2j/otX0oRTIkZFtXFfeafaCQvrU
         twBPKwr7u291JuDdQp9y2WKK9Sw2BbT8mHCytq6w0dPmwV3uaJzETUiQMVNFoTI0/5mr
         TVWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706604791; x=1707209591;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NWbHSmMZcbcTPFNjHs15M83nAeyP7oSVXTG00tGkv3M=;
        b=J7j6veo/bcOHmfK41jiDNqpDLXSvqnErPQ4JQOuqQEF1i3yHXRxQCU4AEJfhnsaz5G
         FlJ2OxgGB7DmZftKiQkv4antQ/U7HlxV0zr1K1inpctPP9sQgVtXDw+MYom4J7XWuvch
         wS0M7DU3nYFfoouh992nWm/5X1m+0qlig9qkhUxdYE9xCMjOEX2fckCQ3k2rGdRzfRs2
         GDfHo7S9FF5mlOWnHltBFZxEuX5BJ4pFyiga0cR5GmBwxBd4eGetoPtE9ScmuyLl3bn+
         DUaRVdJ7cIz24IkSPF1RlEP8laqQBm3a0UlRaW3dVhayKpb6N2FxC9CM4dVAVRaV/g/L
         WFxg==
X-Gm-Message-State: AOJu0YyXzVLPkGY6qLVDiQ8sj3yGHdLiwF1S94fa/iMolGO7vc2U1KUf
	bIMPiB4Nk3FtjVbUJlYY7DAZWpYHAMKLpytn2zzg1gKfADAaKMowl3V8X5xhatWDc0rDzF5jEpM
	=
X-Google-Smtp-Source: AGHT+IFkWEI9cID3V5CUdGoq4dc1LLz6pv4GAVkkwfsUOjz7PyOVGVwlb9boqiHu4tXoVvXyKiLrmw==
X-Received: by 2002:a05:6902:10b:b0:dc2:398b:fa08 with SMTP id o11-20020a056902010b00b00dc2398bfa08mr4421170ybh.31.1706604791207;
        Tue, 30 Jan 2024 00:53:11 -0800 (PST)
Received: from thinkpad ([117.202.188.6])
        by smtp.gmail.com with ESMTPSA id r14-20020a63ec4e000000b005c19c586cb7sm7520170pgj.33.2024.01.30.00.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 00:53:10 -0800 (PST)
Date: Tue, 30 Jan 2024 14:23:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: vkoul@kernel.org, jingoohan1@gmail.com, conor+dt@kernel.org,
	konrad.dybcio@linaro.org, robh+dt@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	dmitry.baryshkov@linaro.org, quic_krichai@quicinc.com,
	quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
	quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	mhi@lists.linux.dev
Subject: Re: [PATCH v1 5/6] PCI: qcom-ep: Provide number of read/write
 channel for HDMA
Message-ID: <20240130085301.GB83288@thinkpad>
References: <1705669223-5655-1-git-send-email-quic_msarkar@quicinc.com>
 <1705669223-5655-6-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1705669223-5655-6-git-send-email-quic_msarkar@quicinc.com>

On Fri, Jan 19, 2024 at 06:30:21PM +0530, Mrinmay Sarkar wrote:
> There is no standard way to auto detect the number of available
> read/write channels in a platform. So adding this change to provide
> read/write channels count and also provide "EDMA_MF_HDMA_NATIVE"
> flag to support HDMA for 8775 platform.
> 
> 8775 has IP version 1.34.0 so intruduce a new cfg(cfg_1_34_0) for
> this platform. Add struct qcom_pcie_ep_cfg as match data. Assign
> hdma_supported flag into struct qcom_pcie_ep_cfg and set it true
> in cfg_1_34_0.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 19 ++++++++++++++++++-
>  1 file changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 45008e0..8d56435 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -149,6 +149,10 @@ enum qcom_pcie_ep_link_status {
>  	QCOM_PCIE_EP_LINK_DOWN,
>  };
>  

Add kdoc comment please as like the below struct.

> +struct qcom_pcie_ep_cfg {
> +	bool hdma_supported;
> +};
> +
>  /**
>   * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
>   * @pci: Designware PCIe controller struct
> @@ -167,6 +171,7 @@ enum qcom_pcie_ep_link_status {
>   * @num_clks: PCIe clocks count
>   * @perst_en: Flag for PERST enable
>   * @perst_sep_en: Flag for PERST separation enable
> + * @cfg: PCIe EP config struct
>   * @link_status: PCIe Link status
>   * @global_irq: Qualcomm PCIe specific Global IRQ
>   * @perst_irq: PERST# IRQ
> @@ -194,6 +199,7 @@ struct qcom_pcie_ep {
>  	u32 perst_en;
>  	u32 perst_sep_en;
>  
> +	const struct qcom_pcie_ep_cfg *cfg;
>  	enum qcom_pcie_ep_link_status link_status;
>  	int global_irq;
>  	int perst_irq;
> @@ -511,6 +517,10 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>  	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
>  }
>  
> +static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
> +	.hdma_supported = true,
> +};
> +
>  /* Common DWC controller ops */
>  static const struct dw_pcie_ops pci_ops = {
>  	.link_up = qcom_pcie_dw_link_up,
> @@ -816,6 +826,13 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	pcie_ep->pci.ops = &pci_ops;
>  	pcie_ep->pci.ep.ops = &pci_ep_ops;
>  	pcie_ep->pci.edma.nr_irqs = 1;
> +
> +	pcie_ep->cfg = of_device_get_match_data(dev);

Why do you want to cache "cfg" since it is only used in probe()?

> +	if (pcie_ep->cfg && pcie_ep->cfg->hdma_supported) {
> +		pcie_ep->pci.edma.ll_wr_cnt = 1;
> +		pcie_ep->pci.edma.ll_rd_cnt = 1;

Is the platform really has a single r/w channel?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

