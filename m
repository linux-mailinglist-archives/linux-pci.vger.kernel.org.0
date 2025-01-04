Return-Path: <linux-pci+bounces-19274-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 212DFA01241
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 05:29:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00304160FB6
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jan 2025 04:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F2912B73;
	Sat,  4 Jan 2025 04:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ryKqy5EX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4994A4683
	for <linux-pci@vger.kernel.org>; Sat,  4 Jan 2025 04:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735964950; cv=none; b=PJVvaHh6mpZ3+f9ZBdU7GD8e1TC6GgREmC24mmGWafwAcebd4eQ+oI0OaqLXcs1DlqilwXir94nUFOQTt5HL9uaAYlnM1r7LMX3S/USoS/Pe2T3U//nkukZ2X+/16naFgQch4ICeC6NJ40kGyojTGrgxuW5Mq5W3HE2P1/Ex6TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735964950; c=relaxed/simple;
	bh=+RC80lzFCIrnzHV62+k6Bi+T0SwjhnWoYL/Z5mlzE5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sODMn6EnwLoeSA5TIPiJN7wXjPchrJx82nSvVvTUJGKrVWvAqZOTGqCJIG4/dboispvTU4fpieuMlhJNCnr5DpQw2ej5Ky5ApIgbxofnCs+QmuxPQkVboI8qP7NSlEKRFdrAXTWDYrzFIUSw/Jq6YF7BRxJ8YpWCp7vlatkzHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ryKqy5EX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2166022c5caso158762955ad.2
        for <linux-pci@vger.kernel.org>; Fri, 03 Jan 2025 20:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735964948; x=1736569748; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QpFxrE9QHiJZ8ARrbLgzhuo35um2ENu3XHVspBVHDAE=;
        b=ryKqy5EX36TP7ub3AHaOyMmll1fW8tYznlCrUzM5zcICih6ma9mHEZbrg6B8wAgGAP
         aCzgXnGFR5wQnPyUSvHyoQ1AdWS03BJfkZ87kSiVOdx4iifyeuLQIsIbWITHOWbkmdlN
         sTfD6aguJdaOx/G7fnuqqXmofN4tb5zbZIkEI0joHdindtelNTrTOzStOrmAuu8h0hhR
         4xhHWP5ENKyfdxOCO7lCikKxjEMnD8nr0e4ClVjuoznBFnuslrIE8wcTVPh9hdAHTGxa
         ApXnD6sVHoxQsYqTsnbjyVBDYP3fOG3SZCU5BKcQQoVfsk1yy21VllXxudZakkOxyL2P
         3Uhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735964948; x=1736569748;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QpFxrE9QHiJZ8ARrbLgzhuo35um2ENu3XHVspBVHDAE=;
        b=Xd1oW+jnmQgyrz6Wp6BKro2RzdW9SOcbF6rG61pG50cH1EcF8lk4HMbvwlVuqQDBT4
         HQbHYeiegCE/fusl3MhLcFGGgrberRy40FL5MhSWkfxpdqmKnQyJONX8JoN23qVETpcG
         5CIbyfAw3vo/MXQ98BYKppzj5e2UW0se0LFEfLgGQQ+y9gG2uYgt5KaFi9ksVlL4AurI
         eceJ2a3gnkrewli5KQCMPK+8vc743URU5kVB8EyipUEPfBiNoP3GvUs1gvA6Djeccwk3
         49ip2B7cq8lUhPJFf5BIFcfW/5LQgZY8xbRfVZjxWM8WuAWxm5/LZSqsDl1UQhVPDKFL
         Acnw==
X-Forwarded-Encrypted: i=1; AJvYcCXcrqfA79oUlRqstugC+SrKvZC0BtTNSLOOykBkYgOcQBkW3yagavagctkb7TGht6U5d3p0zBhBhW8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4aFFBqfuG/BJmVheDySqyaOxB26lb1e0z9W4Em+7uG8/hzw5y
	7T8JfCOkdfQNLTo5sCtWOpI8fwWlwISIk7wX5+PgXTSfCzioh0t0EjV04PDyCw==
X-Gm-Gg: ASbGncsWVTShgEWDi7EpzVuQaH0Is6vyYinuli2INnMrUxLi+SP4LAtlimGVHTBRk6N
	xMB9DDUoPd2OCeMc8At695g1rGcVLgKxuvlTmNdDr7vRk663VzMQ/NzY/4YXgbiKVqg2DB/DINa
	z7Fql2o0drtGAkpHFbzBvVZd3yR0uWunuu/7mo6Pf4+jLvZgtyETBNMIRulJuoks/pzHQJOM37o
	l8cT4B7NUahhKSGDMJ0PTPM4I/rwz1Q7nfrUV4xIkVWRlCvvGAKWqpom4/GyRu/QxpEBA==
X-Google-Smtp-Source: AGHT+IGfzEcsWbc9nAW7/IHUxzJP6Z16VwtbJoaCcuWNY7q2FFdCCI3tmjmBPoXHJOP+5w3MHWmeSg==
X-Received: by 2002:a17:903:2cc:b0:216:3dc5:1240 with SMTP id d9443c01a7336-219e6f2ea27mr694228575ad.45.1735964948473;
        Fri, 03 Jan 2025 20:29:08 -0800 (PST)
Received: from thinkpad ([117.213.100.243])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-92587c62eacsm6930100a12.21.2025.01.03.20.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 20:29:07 -0800 (PST)
Date: Sat, 4 Jan 2025 09:59:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v3] PCI: dwc: Fix potential truncation in
 dw_pcie_edma_irq_verify()
Message-ID: <20250104042901.47qx5iiez3gkdtrt@thinkpad>
References: <20250104002119.2681246-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250104002119.2681246-2-cassel@kernel.org>

On Sat, Jan 04, 2025 at 01:21:20AM +0100, Niklas Cassel wrote:
> Increase the size of the string buffer to avoid potential truncation in
> dw_pcie_edma_irq_verify().
> 
> This fixes the following build warning when compiling with W=1:
> 
> drivers/pci/controller/dwc/pcie-designware.c: In function ‘dw_pcie_edma_detect’:
> drivers/pci/controller/dwc/pcie-designware.c:989:50: warning: ‘%d’ directive output may be truncated writing between 1 and 11 bytes into a region of size 3 [-Wformat-truncation=]
>   989 |                 snprintf(name, sizeof(name), "dma%d", pci->edma.nr_irqs);
>       |                                                  ^~
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2:
> -Simply increase the size of the string buffer instead of chaning the
>  print format specifier.
> 
>  drivers/pci/controller/dwc/pcie-designware.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 3c683b6119c3..145e7f579072 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -971,7 +971,7 @@ static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
>  {
>  	struct platform_device *pdev = to_platform_device(pci->dev);
>  	u16 ch_cnt = pci->edma.ll_wr_cnt + pci->edma.ll_rd_cnt;
> -	char name[6];
> +	char name[15];

Isn't 14 big enough to hold INT_MAX + 'dma'? Not a big deal, but asking just for
the sake of correctness.

- Mani

>  	int ret;
>  
>  	if (pci->edma.nr_irqs == 1)
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

