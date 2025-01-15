Return-Path: <linux-pci+bounces-19918-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 415E1A12A04
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 18:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85AB0188ADE9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FE5019922A;
	Wed, 15 Jan 2025 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMPJMehh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4161161321
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 17:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736962822; cv=none; b=DqF5SpClEMSZb6Qh+A9j7xSjXH417wB8S5YQouUnFpGKmyEwo+5kEnJoiJAvOvOkILl3ikCJJvuFWaOez/3Rm+n12eI2Z2O+jRjvsisor3YFh7cprm2WHszYUpiYSG9XUwYtZlxw7wPXSKrzCzypCay/l8itN9/ekkcyuvU07jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736962822; c=relaxed/simple;
	bh=hnJW2xxqvw9O1y9gRRJv7NL1EReH1KHCRWvku2UFNrU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=G11LuIXioCRdeVaTBctwF4QZfWwEo1C7eMj7zBFSCCFbxdyXXQAQipolQz2N9vqNDNF6WoxLf5WYVZ2kXjoEB1lo+28n2fUCi/N2Pw/3iLDIgThTXqECVPEy6GdG3Y1q8k+xbzLIX4unEolAo1b9r5n+fw8zknWnzOU+KmNIGts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMPJMehh; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2163b0c09afso132302305ad.0
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 09:40:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736962820; x=1737567620; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RSM2HZluyONZrn3gXP7oqGlR+tWUwLkG4z/EG2USxK4=;
        b=uMPJMehh1YwBIvlT92ePO3aLrA8+UDNzmJhxd53UfHghpPd93+NOYZiDzgaXH6sTVR
         QSVG0k9ys0DFmObXkSTVeLHUgmDu6ys46MjrmOiMj7tH3AZHJ27UDdbZ7H2hsekUrD26
         +h886wgyOT+8BkJFufUUvt+eNSI0Env67bdUJer099kK6jDqSldBbNWzAROL/c8pL3ua
         jstwh4YTKglrys8B2v8uqO1mtGKCrkmpc/aMvzjg1x56WbjA35P8ddECM/LnJgMNFTuH
         H6GHfBLg0AJicqkMECb6TTExQwQ1msxLIIwhpJVscFV71z4OGc90GilaVEA2EP8wN+nv
         S57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736962820; x=1737567620;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSM2HZluyONZrn3gXP7oqGlR+tWUwLkG4z/EG2USxK4=;
        b=BUoQVaou58BNkPZcBNTreMa1FsO9WzLMpTf+wtC7NK021OlhCG+n9U0qBVNF2WqpYF
         Af7FULYgdoFTjWsDLu/3DLcYP+XozEHxFd//BfeOEMIAKMXEma5AnM8PqerZ4O/I0+pR
         KJ69+wZkV3rBtZ60GYVAP4VlH8/DIcPF3vlpgYFQMFZd3pXvNi7jnCjRZ8Iel7pq5610
         MVdWpUd8E1gT4fd7vn+oohlNmyrDrK9iMY89Q24vby9SRKhuI8QEk6fuVx4jaz/badgv
         Jw+bzrfuS40ur+uia7oTWan6WsTsXxB7gMjKXX2QETXb6wFq0QKesiYRSQLMMt3hR78u
         fqsw==
X-Forwarded-Encrypted: i=1; AJvYcCWQ4CciXAQFL1tFFxLC1oRd5yZgnpe6VSdExi/QHxw8u5EUYqxLnmvNicXd/cFXdnbZKq9vC9zJdXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4OmixJlO/IIfhym3Y71noB9Ep+Yz4Kt1mh2AHYjf+m/Ja45aq
	mT/2hwgkRp0r1uP5PLsabcRO6dG996ZkaThBSDkMbMqUhLbbaQIvDlz4X0ajqA==
X-Gm-Gg: ASbGncvPpZgKAeTsQdaOeMKlj0HXXsSth6+C2BCLPU3fG3Lb9vequJ0OpuiM76faV66
	jR/YsuteVoAbBZXZmvkLSMVEiQ326SODX8pquOByRj72mwkP+NHqIHntrw0H+2M+CJAxplP54wY
	oWEZnQrNZ05K6tBFvU5skiBIaVNU5YLDED6vggHe1vP3i9hIfgrQmL/OQO2/JKt19I3g4pBuH4G
	i/3i9FVji3Llxw/CYlNKGeF+MkRJyX8PZebwTkd0OpAIkJ5UmgZHkNnuY2aetsCf0Q=
X-Google-Smtp-Source: AGHT+IGd3FfUImkbuTIHualSl03iWhPCsK272UsBzIXbKjGtmziydc6ISX0oPJIXEIB8DvlCJBFtQw==
X-Received: by 2002:a17:903:244d:b0:216:7175:41bd with SMTP id d9443c01a7336-21a83fb0b26mr432450835ad.39.1736962819934;
        Wed, 15 Jan 2025 09:40:19 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f12eaadsm85327695ad.70.2025.01.15.09.40.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 09:40:16 -0800 (PST)
Date: Wed, 15 Jan 2025 23:10:12 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Dan Carpenter <dan.carpenter@linaro.org>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH linux-next v1] PCI: rockchip: Improve error handling in
 clock return value
Message-ID: <20250115174012.bdny6nxxr4tuzyis@thinkpad>
References: <20250106153041.55267-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250106153041.55267-1-linux.amoon@gmail.com>

On Mon, Jan 06, 2025 at 09:00:38PM +0530, Anand Moon wrote:

Subject should include the word 'fix' not 'improve'

> Updates the error message to include the actual return value of

s/Updates/Update (imperative form)

> devm_clk_bulk_get_all, which provides more context for debugging
> and troubleshooting the root cause of clock retrieval failures.
> 

Btw, it is not just updating the error message, it also returns the actual error
code.

- Mani

> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/r/202501040409.SUV09R80-lkp@intel.com/
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>  drivers/pci/controller/pcie-rockchip.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index fea867c24f75..ca6163f9d2dd 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -99,7 +99,8 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  
>  	rockchip->num_clks = devm_clk_bulk_get_all(dev, &rockchip->clks);
>  	if (rockchip->num_clks < 0)
> -		return dev_err_probe(dev, err, "failed to get clocks\n");
> +		return dev_err_probe(dev, rockchip->num_clks,
> +				     "failed to get clocks\n");
>  
>  	return 0;
>  }
> -- 
> 2.47.1
> 

-- 
மணிவண்ணன் சதாசிவம்

