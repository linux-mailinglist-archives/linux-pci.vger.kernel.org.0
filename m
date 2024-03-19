Return-Path: <linux-pci+bounces-4893-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62C4887FD14
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 12:42:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE981B213D1
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 11:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05BBF7EF18;
	Tue, 19 Mar 2024 11:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MY3NMmAx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1617E767;
	Tue, 19 Mar 2024 11:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710848538; cv=none; b=MFmnY1K1EMYJypURcEu8gGLcji2vBRchB7kkA814fHteWmS57jPeuSl1Zwxy56+v+l8SLk7hk1nEXU1Sc7/5iqtuKFr6hXz4FbKmXICcSUOu+BZnVSNldmcUn2G6rIk/i9mLI96fnA+vmn3AlW/kyWb4yUEQ7Vbv7EfSIEeVcww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710848538; c=relaxed/simple;
	bh=9mj4fImnckfhMvuhi27/rW5wPV2VrOkxeaCKbPhYXm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1m7J4WI6OXU7UkR0axb+RtNGyKNZX2xr92KZjol+HlZnM6PupDhWXqVYluWj9lQIpJgHKrOzTaxJjkn3lmEESVg/KUGZDg63i3LbLfUqjANHs4o6AQXilRSynDGI3ePY5JbVr4IPTZQYK3yY95byFd3eGVpIWZhvbUJRWon3co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MY3NMmAx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d228a132acso77085811fa.0;
        Tue, 19 Mar 2024 04:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710848535; x=1711453335; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=elC/J+DQMSiEL3syNo73tLIm3C8p69Tr5sKldmaLKFo=;
        b=MY3NMmAxr8rZQTPnAgJunQaB9h2UvICFML08N3A3CMq94G9Mqa5oDQTVInZYKZfwWF
         uveJ7F/7Ia/0yxFZhQHiInFekyNnUaLlStNMbTeNKa1VEOvaQMf6fw5WjSufLZpwpS3h
         agPE3CE/yg/4yXwcMW5H5+MIF5qNuNtrh5HPv8cIeDbTVMN0ZkL4AwOjGvuZGqRTOpC0
         20GCf71T/NP82DDOqzsMZg8s2qpPOGCWhqyefhMd6EKi9EYqx/ASYuQc+BgPbfx6P+Yx
         wsy5tF7G3q8EZeD5oXhtxThHamGhik6G1Jek84eayryW/ZhwGBueasl15Uh1cHYN1919
         jh2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710848535; x=1711453335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=elC/J+DQMSiEL3syNo73tLIm3C8p69Tr5sKldmaLKFo=;
        b=ktwKyYxtl5uDWPzUWLj3M+Cmlf8xH5OHOKecH9H4FBJ/hHcHCS2d8TugCRYndTzjRA
         ELjn8NfNZpwKMGLELzaPgmB2jB1A6OtFCCCAasdsxFazQ/qpWDXuEqawf2cEC4Zi/mWv
         ULWPWoXwkMK0wfsCsyGB5S5m6k0G8oganrL9JKbc8nVa8YVdZSK77OmnFJPcOgeh9+D8
         s3iHeXKn5ea7D30EY6fsphydY1OkouVzBmmIrhQjVblyS4TalwGqUDOnb81iTVqSANWy
         7oyUjIngr9v5dPO6Y8enTm5VijcgIsv3xk+uecPUux2fk4ADOAWZqhL7eUh1IWdva4Rn
         dmsg==
X-Forwarded-Encrypted: i=1; AJvYcCUO3qn1FTyeRhu1q8xlAOeRhAKSFQY5YXg/gTBdk+LX2HG5+wazVQ6aCj4TaBOv3RsE4scywiZidE56IIgZxZFpgmUR5fdwKXCUakFUZRcOiMFg1NRGhj8Gg/RDvNRlOSpy29VOiWUY6qw4bt73Irq7vMIz/yCfXzFzopzkdkuBJJYWQUrIB7CtDMgYkMTHki5ciR0H32rub1hlEES5DU2Zq3Btwx39BEbZ
X-Gm-Message-State: AOJu0YxwnZEwnrRwDSSYzL1ihq4BIhSMzvKkPXLdJDZJ0PPPDMvW5j8c
	mBbfdXd3uuQoYslDz+ZkIgfED7/BgJXDB3GPF9kjoo0ImxmAvPFH
X-Google-Smtp-Source: AGHT+IEbPtInSnoxABuprHRsFDYGfrjvEEgi/PvCR0A0PjriWs8/Fs7e5VgS8xyyf1KxtbICUZUEPw==
X-Received: by 2002:a2e:b8c2:0:b0:2d5:9bd4:4496 with SMTP id s2-20020a2eb8c2000000b002d59bd44496mr2105191ljp.50.1710848535069;
        Tue, 19 Mar 2024 04:42:15 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id b4-20020a2e8944000000b002d449d1d509sm1851199ljk.70.2024.03.19.04.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 04:42:14 -0700 (PDT)
Date: Tue, 19 Mar 2024 14:42:11 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring <robh@kernel.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Marek Vasut <marek.vasut+renesas@gmail.com>, 
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, Siddharth Vadapalli <s-vadapalli@ti.com>, 
	Frank Li <Frank.Li@nxp.com>
Subject: Re: [PATCH v5 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Message-ID: <kxcd3n4hb6c2bhksqvxql3gj6zr2my5moxx5mighk33dggspw5@wvt565ch6gm2>
References: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
 <20240318-dw-hdma-v5-1-f04c5cdde760@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240318-dw-hdma-v5-1-f04c5cdde760@linaro.org>

On Mon, Mar 18, 2024 at 11:34:25AM +0530, Manivannan Sadhasivam wrote:
> In order to add support for Hyper DMA (HDMA), let's refactor the existing
> dw_pcie_edma_find_chip() API by moving the common code to separate
> functions.
> 
> No functional change.

No more notes from my side. Thanks!
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>

-Serge(y)

> 
> Suggested-by: Serge Semin <fancer.lancer@gmail.com>
> Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 37 ++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..e591c1cd1efb 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
>  	.irq_vector = dw_pcie_edma_irq_vector,
>  };
>  
> -static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +static void dw_pcie_edma_init_data(struct dw_pcie *pci)
> +{
> +	pci->edma.dev = pci->dev;
> +
> +	if (!pci->edma.ops)
> +		pci->edma.ops = &dw_pcie_edma_ops;
> +
> +	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +}
> +
> +static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
>  {
>  	u32 val;
>  
> @@ -902,8 +912,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  
>  	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
>  		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
> -
> -		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  	} else if (val != 0xFFFFFFFF) {
>  		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
>  
> @@ -912,12 +920,14 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  		return -ENODEV;
>  	}
>  
> -	pci->edma.dev = pci->dev;
> +	return 0;
> +}
>  
> -	if (!pci->edma.ops)
> -		pci->edma.ops = &dw_pcie_edma_ops;
> +static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
> +{
> +	u32 val;
>  
> -	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
> +	val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
>  
>  	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
>  	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
> @@ -930,6 +940,19 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
>  	return 0;
>  }
>  
> +static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
> +{
> +	int ret;
> +
> +	dw_pcie_edma_init_data(pci);
> +
> +	ret = dw_pcie_edma_find_mf(pci);
> +	if (ret)
> +		return ret;
> +
> +	return dw_pcie_edma_find_channels(pci);
> +}
> +
>  static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  {
>  	struct platform_device *pdev = to_platform_device(pci->dev);
> 
> -- 
> 2.25.1
> 

