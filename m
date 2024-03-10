Return-Path: <linux-pci+bounces-4702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F518776E2
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0E0F1C20850
	for <lists+linux-pci@lfdr.de>; Sun, 10 Mar 2024 12:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A10F28389;
	Sun, 10 Mar 2024 12:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ltibB2Nu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1EC324B34
	for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 12:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710075431; cv=none; b=gEywxGklPyzGaQ/f5DotWC6faDl9Ov1Jn1nwOFM78WCi/cDvYAlLMpHnHuah51AnxqWA8YhVScqwuthCnqfWDIjqHbMrV5jmvWHECi22xMuMvTKOCmUkCvxNdYEZVpP7kgetEyaW1barGZUe+x7oG4TA++4yG8SC65Sa9G1ilV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710075431; c=relaxed/simple;
	bh=EMHaB7kya4ZC3sb4psj74LR+97AWjwtndWgN3WEQLB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YxxLrlD8I56kzXDEAGbT+gRV5yoHcPpLlQU9RMETILMTZPXF6VF5rxJVIF2iovavSEAAgZQgQHV7ccJSKob6Vt+e0vkbd/PjTCcDcxFcsVq5MBABq9lBZGSPurQ8Hf9g2wC0r+KmyF2nKW8/dTTruTBEnESrSNW2vRblIv6/ZVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ltibB2Nu; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dbae7b8ff2so25322445ad.3
        for <linux-pci@vger.kernel.org>; Sun, 10 Mar 2024 05:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710075429; x=1710680229; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SDEApdbuJJn3rW0aTX84J2O9wswnhpQO0GgGjO9ubd4=;
        b=ltibB2NuzYrM5Nn8MLZ9201ojY7SZlQtlTEh8WqHIPFXl4X0Eos05uc8NbgtF7U6Vr
         s9W82k80DcWW/rZtm3gksLTPGtuxxTXKr/4/vYi3b+Rzkbvdv2WgIWKRHfGOSQZjjkg8
         hZSZeCvIDOVp4MVLtlA6amKBi41GB+sVF9jpf/wWqV7jJUXj8cj4JoxO6vtxtoSTc8pi
         I/4WMCUAfJFqETW4M82HPD56GV2A2bar0yWqp1UPTohAQ2KoALzNnI/Toi4GnshiwQ4C
         13pXWzVTx2XMBhPjVeDzverXexCMhCTiSE/49U9NiDLQ26YErzyaItvHT4zGCJsNdOjp
         3fyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710075429; x=1710680229;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SDEApdbuJJn3rW0aTX84J2O9wswnhpQO0GgGjO9ubd4=;
        b=eMbCtdLcRTQIcpdf7ETRicHjuUZ5CQ0Z5Kk2RcKpToWERVMyAqjAUwfTtqGmxyefDy
         yanT5hxbIHHOvCL/3ijH1TAimY5fiimOIjac601Drkr/woZllrNDVJKsAD/2BW69Y9jn
         pwdp65+sMgeAGVYJUTL0tPBx15obQeLzDy2a7tvw4l5itaeSHF7QPNbHmZrnvYqA0rNK
         25DNMTZkm9J+/obvRQDW+81MbJUsWYJgZmU8x/hhwIXFb8e81ECItk6ss+crIyfrg2j0
         0Mo0GzK7oZSxnt+Tjyb6l3yLpUdmxdxmshUPR4YozJce1EwH0wITh6DwaplkRbk5DTbp
         WHng==
X-Forwarded-Encrypted: i=1; AJvYcCXgPSNf1oFNa/n/+4SOkMw6DP3fYYHqYYwm028IB37uYEm7KEK+jMPVhYidVvdJjZ81RWjpkhQTEarWBnIimawn3tM/LHtHTszR
X-Gm-Message-State: AOJu0YxAf4O6Wh3h+W8UnP2KtsqCDkXnf22gSCN2J8iP0EyWt1s9fiLC
	Z2aAxLfHaP9teXYjkX5+czfhnD1VL0wiox//YpQXEIHKbkko17xheiWNyU8THg==
X-Google-Smtp-Source: AGHT+IE7tbrdR9qGK2v5knmmRKIn3Ohdwz+WB659BTiT5oKrcB4vLeWqkY1AWO4iub4hNB7pKtCqqw==
X-Received: by 2002:a17:902:e5cd:b0:1dd:88d5:bf17 with SMTP id u13-20020a170902e5cd00b001dd88d5bf17mr2013611plf.54.1710075428913;
        Sun, 10 Mar 2024 05:57:08 -0700 (PDT)
Received: from thinkpad ([120.138.12.86])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001db40866e09sm2644799plb.260.2024.03.10.05.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:57:08 -0700 (PDT)
Date: Sun, 10 Mar 2024 18:27:00 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Cc: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org,
	quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
	quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
	quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
	quic_schintav@quicinc.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v6 2/3] PCI: qcom-ep: Override NO_SNOOP attribute for
 SA8775P EP
Message-ID: <20240310125700.GB3390@thinkpad>
References: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
 <1709730673-6699-3-git-send-email-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1709730673-6699-3-git-send-email-quic_msarkar@quicinc.com>

On Wed, Mar 06, 2024 at 06:41:11PM +0530, Mrinmay Sarkar wrote:
> Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
> in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
> the requester is indicating that no cache coherency issues exist for
> the addressed memory on the host i.e., memory is not cached. But in
> reality, requester cannot assume this unless there is a complete
> control/visibility over the addressed memory on the host.
> 
> And worst case, if the memory is cached on the host, it may lead to
> memory corruption issues. It should be noted that the caching of memory
> on the host is not solely dependent on the NO_SNOOP attribute in TLP.
> 
> So to avoid the corruption, this patch overrides the NO_SNOOP attribute
> by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
> needed for other upstream supported platforms since they do not set
> NO_SNOOP attribute by default.
> 
> Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>

Same nit as previous patch. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 89d06a3..aa8e979 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -47,6 +47,7 @@
>  #define PARF_DBI_BASE_ADDR_HI			0x354
>  #define PARF_SLV_ADDR_SPACE_SIZE		0x358
>  #define PARF_SLV_ADDR_SPACE_SIZE_HI		0x35c
> +#define PARF_NO_SNOOP_OVERIDE			0x3d4
>  #define PARF_ATU_BASE_ADDR			0x634
>  #define PARF_ATU_BASE_ADDR_HI			0x638
>  #define PARF_SRIS_MODE				0x644
> @@ -86,6 +87,10 @@
>  #define PARF_DEBUG_INT_CFG_BUS_MASTER_EN	BIT(2)
>  #define PARF_DEBUG_INT_RADM_PM_TURNOFF		BIT(3)
>  
> +/* PARF_NO_SNOOP_OVERIDE register fields */
> +#define WR_NO_SNOOP_OVERIDE_EN                 BIT(1)
> +#define RD_NO_SNOOP_OVERIDE_EN                 BIT(3)
> +
>  /* PARF_DEVICE_TYPE register fields */
>  #define PARF_DEVICE_TYPE_EP			0x0
>  
> @@ -152,9 +157,11 @@ enum qcom_pcie_ep_link_status {
>  /**
>   * struct qcom_pcie_ep_cfg - Per SoC config struct
>   * @hdma_support: HDMA support on this SoC
> + * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
>   */
>  struct qcom_pcie_ep_cfg {
>  	bool hdma_support;
> +	bool override_no_snoop;
>  };
>  
>  /**
> @@ -175,6 +182,7 @@ struct qcom_pcie_ep_cfg {
>   * @num_clks: PCIe clocks count
>   * @perst_en: Flag for PERST enable
>   * @perst_sep_en: Flag for PERST separation enable
> + * @cfg: PCIe EP config struct
>   * @link_status: PCIe Link status
>   * @global_irq: Qualcomm PCIe specific Global IRQ
>   * @perst_irq: PERST# IRQ
> @@ -202,6 +210,7 @@ struct qcom_pcie_ep {
>  	u32 perst_en;
>  	u32 perst_sep_en;
>  
> +	const struct qcom_pcie_ep_cfg *cfg;
>  	enum qcom_pcie_ep_link_status link_status;
>  	int global_irq;
>  	int perst_irq;
> @@ -497,6 +506,11 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
>  	val |= BIT(8);
>  	writel_relaxed(val, pcie_ep->parf + PARF_LTSSM);
>  
> +	/* Override NO_SNOOP attribute in TLP to enable cache snooping */

Same comment as previous patch.

- Mani

> +	if (pcie_ep->cfg && pcie_ep->cfg->override_no_snoop)
> +		writel_relaxed(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
> +				pcie_ep->parf + PARF_NO_SNOOP_OVERIDE);
> +
>  	return 0;
>  
>  err_disable_resources:
> @@ -811,7 +825,6 @@ static const struct dw_pcie_ep_ops pci_ep_ops = {
>  
>  static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  {
> -	const struct qcom_pcie_ep_cfg *cfg;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_pcie_ep *pcie_ep;
>  	char *name;
> @@ -826,8 +839,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
>  	pcie_ep->pci.ep.ops = &pci_ep_ops;
>  	pcie_ep->pci.edma.nr_irqs = 1;
>  
> -	cfg = of_device_get_match_data(dev);
> -	if (cfg && cfg->hdma_support) {
> +	pcie_ep->cfg = of_device_get_match_data(dev);
> +	if (pcie_ep->cfg && pcie_ep->cfg->hdma_support) {
>  		pcie_ep->pci.edma.ll_wr_cnt = 8;
>  		pcie_ep->pci.edma.ll_rd_cnt = 8;
>  		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
> @@ -893,6 +906,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
>  
>  static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
>  	.hdma_support = true,
> +	.override_no_snoop = true,
>  };
>  
>  static const struct of_device_id qcom_pcie_ep_match[] = {
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்

