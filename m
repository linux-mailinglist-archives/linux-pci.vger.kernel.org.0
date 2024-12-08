Return-Path: <linux-pci+bounces-17892-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39FC99E8511
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 13:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28BC7165039
	for <lists+linux-pci@lfdr.de>; Sun,  8 Dec 2024 12:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E2F149DFA;
	Sun,  8 Dec 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ij84obFk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E963B149C54
	for <linux-pci@vger.kernel.org>; Sun,  8 Dec 2024 12:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733661884; cv=none; b=jDFTSfGj/0NBhbqxvX2IQ9yyAzd2Vkwrqw590TbSwUfWiXVokkFJIdEv4png6ZI4pHt5Xx/viuYAW+nWSyZBDEl3nqVbALHUmV+PQJCAsLGp4N9BNrBNHgU3PRgR2s1J3KH3v/0a6i15ht14yQ6rtrPAbEsVQ6NR3j+uOzlOp9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733661884; c=relaxed/simple;
	bh=pFIGxvFPsv5hV0g3ScDxxRxCjlmfbMjHw/GW2NH5Nbg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W6wkoiStUe1SY3Rywr+hRlUB5PQuSufzaoPg9BCsN5Nxyi/wziu+ziH+PFiSja3fOYd9SQ849Xwc653WEv5bq7hE1FDxHq+Ok9FHjlxtposk7GsXB5/GAzihLWnsmUe1yw+GEnN10bg4mHZsgFNExauRSgIcCcs7a0scsyInS40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Ij84obFk; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2156e078563so26583855ad.2
        for <linux-pci@vger.kernel.org>; Sun, 08 Dec 2024 04:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733661882; x=1734266682; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ObzuBtRvdTYYc5ZI72EO8xxEXcCsf9XtGeinrNeixuA=;
        b=Ij84obFk02xlqNvUtEpru4/h3dwDOu4zP1LWgByzo0GR3/YmHY5qwBTHzNfbV9Y6gk
         9PJPzHFNunXpmqJ4rxKtxhpMcN7UJkDD2dOoDJuw4Xg6SlIWDJ6auWpN3DXIqVJQ1ZeN
         Dt3o7azh/lq5rFijtE4n0hI/wbzwC7bBOqlgzRVGidGAZXakKtQxtO4xK2pkFR/5jtgM
         +jO2RAL1i+emM8zT/rszl+w/YL18lJyv7akJju3pp7Y2BIbKe52gzdYgQUMQ/9isdLU2
         VAHRNVfwexmqFYbYAkB6xiQxCm8spJcr71DrlIk3Z6IYCfocmBDxrGRG40q/2KzvHKo2
         7H/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733661882; x=1734266682;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ObzuBtRvdTYYc5ZI72EO8xxEXcCsf9XtGeinrNeixuA=;
        b=tmDSY4QXVIuqZ6Bhacf/bF1EjhvbvLunIcxTw2T8U9a5RtO+Xf5g0Oh0irshnkMel5
         u47qBdqSCH5XEH8cNQZM42lkiF+xX1aDLj3W8FaTUEu0BdyDxg320ftsqd+fEsCz7U2t
         zKXg9Y1vZv0Fult9H/XXJme1Wqd0FtAJLmkNbM5yAm0WM3LqJtPta9eqNxub9qBZLEdg
         J4XK8ks22HUJ1rzDQjm/VNtOOZPRJDZa1ZtNfOcim2gqUUBO2XTaqQs1Mr+q11X9JzZp
         eWxbKXh1grpL7vtr3LAGZKVp0YAQn3zKrZ/bIoQWnHxX0F2Dkn0WB/JpqHuOSdyzP/jt
         PfLg==
X-Forwarded-Encrypted: i=1; AJvYcCWzi7j0EFnyUPkoQIZjUVOapWE0IaUm2DpQDXNJi9F2Ss5KZ0ViX2igJ16guJNrxayto/SI5YHnyL8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxqqdd35RlU4+D5jDCuY4+iAH20VUSfCJ3vABA0ZwrOenDFWSPj
	IGj9Y5rS+eVsqq4F2WiQUx18folQPmpKhSdNj2uJHaFQNy53q0sZUgEonUZ55Q==
X-Gm-Gg: ASbGncuK3nMT7Z7TYvCgL3d/PWkE4nUwDATiPvT/mUzPunQ4W7/6eg9Z7HQkooRR1x1
	sMjCohesO3FAJ4CyHaICfAaSpJ7Ja862xRoHxRLqAYNbfsGauveZSRGx7oiKtciEiwKKdfE9vvo
	YaYzkdAMVR6k4j+uuRTpUHk2fN+YtIZ+8n1SUWB9A7UoZgs8VvPu4M7onuM4LDm8P4nP5Uyk2Fi
	CnJtOLj3800Pj8/IQl1i4k6ejnZ1kP1PZJFsdXPrE47tKFzGRzoPrzm4HI=
X-Google-Smtp-Source: AGHT+IFWStgtABEgXeuwa+0us5wTIZE6ArS1wlJLYxBQNATuRowJR77uhfkJK4Vk9aSU1pZvjciMaw==
X-Received: by 2002:a17:902:e5cd:b0:215:9a73:6c45 with SMTP id d9443c01a7336-21614d45334mr158926955ad.22.1733661882268;
        Sun, 08 Dec 2024 04:44:42 -0800 (PST)
Received: from thinkpad ([36.255.19.23])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21617531ba7sm39465845ad.106.2024.12.08.04.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 04:44:41 -0800 (PST)
Date: Sun, 8 Dec 2024 18:14:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] PCI: rockchip-ep: Fix error code in
 rockchip_pcie_ep_init_ob_mem()
Message-ID: <20241208124436.vicbi72xyomahp3s@thinkpad>
References: <Z014ylYz_xrrgI4W@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z014ylYz_xrrgI4W@stanley.mountain>

On Mon, Dec 02, 2024 at 12:07:22PM +0300, Dan Carpenter wrote:
> Return -ENOMEM if pci_epc_mem_alloc_addr() fails.  Don't return success.
> 
> Fixes: 945648019466 ("PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
> ---
> v2: Update the git hash for the Fixes tag because the tree was rebased I guess.
> 
>  drivers/pci/controller/pcie-rockchip-ep.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c b/drivers/pci/controller/pcie-rockchip-ep.c
> index 1064b7b06cef..34162ca14093 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -784,6 +784,7 @@ static int rockchip_pcie_ep_init_ob_mem(struct rockchip_pcie_ep *ep)
>  						  SZ_1M);
>  	if (!ep->irq_cpu_addr) {
>  		dev_err(dev, "failed to reserve memory space for MSI\n");
> +		err = -ENOMEM;
>  		goto err_epc_mem_exit;
>  	}
>  
> -- 
> 2.45.2
> 

-- 
மணிவண்ணன் சதாசிவம்

