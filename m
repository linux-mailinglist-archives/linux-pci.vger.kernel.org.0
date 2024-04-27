Return-Path: <linux-pci+bounces-6729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BB28B4553
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 11:23:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C9861C20FC4
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DA547F62;
	Sat, 27 Apr 2024 09:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X14pPsHG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4417D46424
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 09:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714209796; cv=none; b=GJd50JESvUt0bhdh0yJlEW9n9s15/FP1zaopwP0FqMdC8c/4OQmE4w9DroQWxIwFw8gtLd7TzHRcDKxPh7Pv1urxvoKxKDNcRGQnQOxzdfqmGsQY84fiHCgaKBPFS+1LYGUfnGvYTnaFUnXTn9xPOvXD13COJxcBxo/FVuqBiok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714209796; c=relaxed/simple;
	bh=ul1FhTW7c8B0pI49fHW4jc0yMuX5lzfvSpesH5uhEZs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q6gG2iohVff/iSZEYmnQYqzjJmCFvLVKDYkPsi5IwyUCRTIf6MJ2VvNH/Etxh8DW7DrxigxKAcRZycFoHrW4riL/SWZ9WNI3AqcCXjRb+Am7SLE37O+i39O5EdA9nZWDEb0Oxs+N1PkgMBNznPayu/5aUlYQAGOQYgoHysUyg8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X14pPsHG; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so28718155ad.1
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 02:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714209793; x=1714814593; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1uIcEMzayP/6fZPxv4DuexUPxwxg9JGcxelfjHeE1sI=;
        b=X14pPsHG0pDxTwWKQKhAHP6w7GCmbCjjfR+0wFvC0SQjWEucAJA1NetyomNihohWuA
         7p6Ld0/6QUuyXUIcEgMFUTXBbinIcF3kye6sxN5Ip0EFfCtVqEHSh95ID5+XyfMV+1Wv
         POrgcBSyq9yZs7p+ia8CdKFeDA+vfEm9n7X5xn1HLcx0QyCfi6SgNZmL2i9jjDy/0Kr2
         ekN39BpK2yE/JTWwL69kAax3E+Iq6k7/bARe/ucpsa+iqJR9KzL4k2JqQUlbChk6JFh1
         DvGP4JRTjjA/x4ZXnbJimokXISqXpJZEv0Mz5KjxmcKsmGyTgxniDUn3hlLtnI/2+eDa
         aSeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714209793; x=1714814593;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1uIcEMzayP/6fZPxv4DuexUPxwxg9JGcxelfjHeE1sI=;
        b=tUIUDBBP96pHMMJ3AVQs/PfhntHmDYnMh1m3+20TTtq3zP2TDJY7TwAZcktEDk9Wd/
         FKXsJQIM7Xiv/WtcJBaV7zKqKKaYoKQlu5J9EZ5pr7V/9hbAuwEVUpT36fqWQ6lvyQAa
         RrTCgroO5yPm8CAP0qjlHokw3e4CmjxWb9/kGk4WIeoH2Ykzn3UcRJilrNsW3arUHQyL
         Rou3Y5umi5ox8NM8SjdEa5MIa+g6h8l3AIdiYN07nsetli5kNjdnL8wftJ9DqRchYJ8h
         mMpqcxDkcJk/o1qk6fgOy2eA4CTu5egibDuKRJMNfjtzrQeO5o0lDtrccoqBm/eQ/tcz
         IYLA==
X-Forwarded-Encrypted: i=1; AJvYcCWAYrYe4OtM2InhyJjsA1my4IGSTMV5nVvUlAweNxJcp31HK0kn00X3NrwwuBiKmB1vqOKmOCR33ASm4+4CxU77uiF0jVEIY1AW
X-Gm-Message-State: AOJu0Yw6jYEARGn/2JD83/dISaXXbWZ/83K703AaW5QhlQubjK1zSlyZ
	017qSvnFpuPjD+rJHvOkxK/AUWl/d30AQEey9ySD56dXDtW4bEdR/KAmDXWrBA==
X-Google-Smtp-Source: AGHT+IHI9b4GXVPRNRKKViZzgQgyiBNt6NE3ezIewkxreKd8/BhI/Anp1b4JbkcwgsxxnXj43VBHCg==
X-Received: by 2002:a17:903:2445:b0:1eb:538e:6c6e with SMTP id l5-20020a170903244500b001eb538e6c6emr1443898pls.33.1714209793362;
        Sat, 27 Apr 2024 02:23:13 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id n6-20020a170903110600b001e668c1060bsm16712930plh.122.2024.04.27.02.23.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:23:12 -0700 (PDT)
Date: Sat, 27 Apr 2024 14:53:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org, Jason Liu <jason.hui.liu@nxp.com>
Subject: Re: [PATCH v3 02/11] PCI: imx6: Fix i.MX8MP PCIe EP can not trigger
 MSI
Message-ID: <20240427092303.GG1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-2-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-2-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:38AM -0400, Frank Li wrote:
> From: Richard Zhu <hongxing.zhu@nxp.com>
> 
> Fix i.MX8MP PCIe EP can't trigger MSI issue.
> There is one 64Kbytes minimal requirement on i.MX8M PCIe outbound
> region configuration.
> 
> EP uses Bar0 to set the outboud region to configure the MSI setting.

I don't understand this statement. How EP can use BAR0 for MSI? MSIs are
triggered using outbound window memory while BARs are mapped as inbound.

- Mani

> Set the page_size to "epc_features->align" to meet the requirement,
> let the MSI can be triggered successfully.
> 
> Fixes: 1bd0d43dcf3b ("PCI: imx6: Clean up addr_space retrieval code")
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Acked-by: Jason Liu <jason.hui.liu@nxp.com>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index e43eda6b33ca7..6c4d25b92225e 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -1118,6 +1118,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
>  	if (imx6_check_flag(imx6_pcie, IMX6_PCIE_FLAG_SUPPORT_64BIT))
>  		dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
>  
> +	ep->page_size = imx6_pcie->drvdata->epc_features->align;
> +
>  	ret = dw_pcie_ep_init(ep);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize endpoint\n");
> 
> -- 
> 2.34.1
> 

-- 
மணிவண்ணன் சதாசிவம்

