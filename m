Return-Path: <linux-pci+bounces-18574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1C29F41C7
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 05:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7980188EEC5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 04:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46F913777E;
	Tue, 17 Dec 2024 04:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fx/m4Vv4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C901FAA
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 04:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734410953; cv=none; b=oPEG1gehFmxmnlr+s/tpUdODRSKv5wVqZSIphqnAF8LmyJ1y5kf7Df/Zk63KodOqvcTGt7U7qiD4POq2uwMvATYT3w6ctc2G3tPzP3nSDG9FySPLRTpkHRQq1dyPTU7QHFXqd2OoKe0GahZpB5SCcyqCDGgbU3bH/7AAbijYQh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734410953; c=relaxed/simple;
	bh=kQf8fn5sULg47iubH0GoIu4ADELErwE9vxk3pN2drLU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pV1GNFwEjgVApT6jBz0U+1GFf4jKAC2hcA62CMuuocLc1RoV2DT0LFAmzby6uEDGvYwTZZmiHrSEQRyVGvUhCssQnXHBIpRhc3P0X0hEP4rt0Q6R/QvgAWaR/4EPSEBusr/cj8GOlzOIz3R4ryxyHksp9Yz0t7KgH7dpeOto5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fx/m4Vv4; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-725ce7b82cbso5696664b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 16 Dec 2024 20:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734410951; x=1735015751; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y62a/yerqGW4P4XUx3wn+36YB18KFozVW5j1+ZchQHg=;
        b=Fx/m4Vv4Waq83+SbyscIQCdiCh9H0+WafCfAfycBGryZR863B8RQLM4lWuyambclMc
         lO1Ol2lj2V1u41w+sqGRRMU5Gu68cF/3R5Mj2FBm20BNFRrfoVtGp4tTI83OgTi8t0uH
         H4iPmSGwLfuV/GA1PfFFN6zquRxVcfw+/C6iAEbih2E00W4iyZTu/vccqlT74DQCyOFE
         hVtTzv8dUq1Z/4beyX5HD863ns3zrfyRV95YmCe+6yXEbl91HCM3xk0chkHcQ6zwhiJ+
         OjGdoCSCGy/15g3jhPwd9lmAwZfMbDlQJPtGbwg/0PASc/LOO6D5fuO/TJF7o5NkhJG/
         sVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734410951; x=1735015751;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y62a/yerqGW4P4XUx3wn+36YB18KFozVW5j1+ZchQHg=;
        b=u4ZVu+sqraUaAlEvm+Wr5uGHSIzaq/zfm4JDuB9B2O7eRNi4eOVlZ22FOgvQJS3KWi
         9BzAIAPq81gWKYDaQh3YY5qT8w5aVgfq2tudail7buDdCyUaIIxIpQrPvfcB6WyEaIGs
         Sq8HBlgAkIvCBKp8AXyyjA92Y5Z/NwA9VXCz9uisDzSJ9+Y888jAalybeNpkEFV8M6x7
         vZDnju5wkY1259uyJ9frL4vjbKigfNIaQWOfiSt0jrh7wacFY0KCuEloH6sJFs6a0TLu
         oZJVa8EjvYfb9peyjCnrfZzgNmrnE1CHhhMN8FgheQenZVND+IKQJIuMshx83Lkt5jLT
         d7Aw==
X-Gm-Message-State: AOJu0YxfW2lwiIfgGD+AjLo72P8vA8sFQbNO+0cweoanbmMcgCwTtkpI
	WIDXVw1Iy0QGGSA+I8QS87IkOKVNuGNAxiAITn14XR/VBsc/tUAr6iq2l+Mk7ck3N8PGxLsoAoI
	=
X-Gm-Gg: ASbGncsfpZ8WunU7oNd9AkRRIY5y3HfdPvfa7nKy0ngk44QrEckBftpD9vR1+JDhclQ
	n7ToleG+QsaxhlgK8MhooCWsiNdlQFq5Q/6cNseeF2d7lOtYMe+0ADWHRBTno1bKB0a1X4uCn7B
	d6ix4MHStKHIvh9DfUgfg4qQK9givKQaDcs2LuhHkzIEBaPp98C0kSCFjtvwlhclXiJjPJyWvG0
	Tbjo07k1VJ0StCzQ/pH2DHRlXZQxpHJtaelqz6OBYcckKLU0NLYh1TzgV+9xpK5LJYE
X-Google-Smtp-Source: AGHT+IEybdaD4Swn393ZuYmGC7UBFm6NTiLmKpyTuf4i9vvo7kaS4trQ9w+ufziLyZ9aNlAWIdVNJg==
X-Received: by 2002:a05:6a20:c99a:b0:1e1:bf32:7d3a with SMTP id adf61e73a8af0-1e1dfdabe8emr21648069637.26.1734410951475;
        Mon, 16 Dec 2024 20:49:11 -0800 (PST)
Received: from thinkpad ([120.56.200.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918bad6a8sm5630953b3a.159.2024.12.16.20.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 20:49:10 -0800 (PST)
Date: Tue, 17 Dec 2024 10:19:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v2] PCI: rockchip: Add missing fields descriptions for
 struct rockchip_pcie_ep
Message-ID: <20241217044905.g6cijdde6xqgdccn@thinkpad>
References: <20241216133404.540736-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241216133404.540736-1-dlemoal@kernel.org>

On Mon, Dec 16, 2024 at 10:34:04PM +0900, Damien Le Moal wrote:
> When compiling the rockchip endpoint driver with -W=1, gcc output the
> following warnings:
> 
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_irq' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'perst_asserted' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_up' not described in 'rockchip_pcie_ep'
> drivers/pci/controller/pcie-rockchip-ep.c:59: warning: Function parameter or struct member 'link_training' not described in 'rockchip_pcie_ep'
> 
> Avoid these warnings by adding the missing field descriptions in
> struct rockchip_pcie_ep kdoc comment.
> 
> Reported-by: Bjorn Helgaas <helgaas@kernel.org>
> Fixes: a7137cbf6bd5 ("PCI: rockchip-ep: Handle PERST# signal in EP mode")
> Fixes: bd6e61df4b2e ("PCI: rockchip-ep: Improve link training")
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> Changes from v1:
>  - Addressed Manivannan's comments
> 
>  drivers/pci/controller/pcie-rockchip-ep.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 1064b7b06cef..4f978a17fdbb 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -40,6 +40,10 @@
>   * @irq_pci_fn: the latest PCI function that has updated the mapping of
>   *		the MSI/INTX IRQ dedicated outbound region.
>   * @irq_pending: bitmask of asserted INTX IRQs.
> + * @perst_irq: IRQ used for the PERST# signal.
> + * @perst_asserted: True if the PERST# signal was asserted.
> + * @link_up: True if the PCI link is up.
> + * @link_training: Work item to execute PCI link training.
>   */
>  struct rockchip_pcie_ep {
>  	struct rockchip_pcie	rockchip;
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

