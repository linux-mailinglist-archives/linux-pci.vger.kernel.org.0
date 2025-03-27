Return-Path: <linux-pci+bounces-24863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3146A736FA
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:38:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BBEC1899667
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEE1991BF;
	Thu, 27 Mar 2025 16:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="glVjRJ/Z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA52E1A239A
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 16:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743093466; cv=none; b=dGJqDvg0L1mflvj/pmQO7NfLk77YC8TlPy7eESdMUg8afI8p6O69M5uKpdn4dMjyX3bSGGQu0rbeimvkZx45mTx3WnVkainrg+AVX7Gz8arxy2VU2JLmwI2yI+g5e79gjuWCIJ23gdb3qOqHjHSsxw8dqaFlCuqIwOdX4LDKEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743093466; c=relaxed/simple;
	bh=IlhSJSRYcLEAAcGfU7Byv7TgRNNf7r4Er08p3Fs31d8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKqjg0+J5o2tgC4fF5m+7okVtEY6L7DqgGuWyJGII2zNyCP4zrbzcnZ27rsCEQzy4p3j8aNVw2g5tt+HILuWlzxbXOLFKm0rM9TxrzFHFObneWCGCkIiR7oZYWzd+9T3t8i+vvP9uAGqwHLCV6yvmndEKf/DOmQLSNAwWQ67tJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=glVjRJ/Z; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22435603572so25646025ad.1
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 09:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743093464; x=1743698264; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=u6i+dua1DWnJP+F+1GqV5SNGBVtQy+N1E/4ibX74lzQ=;
        b=glVjRJ/Z++vTgYe0Zh1elZuBPZ23OshKUvpmyTKe2inpqw+oGKBEuaGJOHiDgM4pBI
         pgtnTELgFs3/VCgjPRfUOyZHa5ORIZx09IIA9hO2kHInsNLF+RgM/bwxjj5ISd4PuM8A
         090eBvQhvGcRRhh8mH1G0Ajpvi3ZJ0+b20tUmtjKPLUsgfmB49PbnAs8rvcoWpuRtt3K
         Jx+Bx/1AYwDd+19k9TzmmivbZA8fyvYzX1G9WFfDn9Z0/PMER1JcB+73OPJVnM/CKGS5
         fmiEVYz76HN4GlxW1VK0oewVIV9P/Fr/Lwv2VA5Aq/aE87YWPvUUbDr7nYr6VKTU9V2+
         UkIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743093464; x=1743698264;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u6i+dua1DWnJP+F+1GqV5SNGBVtQy+N1E/4ibX74lzQ=;
        b=k2dzk+Y7cuFPgVE48KPaSzfdXd8IKniEE7ZGCUb3QwEq0UfSeAXRy3RchYKsPDZWIX
         nhPrBrXNzAXwnOd9bMIbbRMeRd4aBfodhoo32XjcKuYiL1ahvslq/WbUwr3IIRG4FAFG
         oG0IZyMpK2iFkIrOg1/IW+BUJqqk/clohiW7jCQuObNuKy0d+Cvx0hdQjwN7AcaQglnm
         PK3hKObK2QxyL/Q6m/tbtF8IMnfdAd8rlzMdi1o06v2061WnvgHr3lcmXXX4uqk2yxsY
         3sytp+CXVg4g190YxoMvko1Zy5E/D2NMzX+X8rWCXE2gkRyZI7BStrru73w5y5e3Pa9D
         VfDA==
X-Forwarded-Encrypted: i=1; AJvYcCXFFvzELfXnt/2RaD9eyBpilc8JstaOzHSOyToVnHW6hKwsYAerx6Nbff1qYghIyZ2M8Sfq33cI5Ao=@vger.kernel.org
X-Gm-Message-State: AOJu0YzB/+UOkCAOYPBqFfFKn+aJc5Js52kFgtWG0rd6JjnHFzYN1mfR
	/bbjnFIke+YSWycjzdJLb42HnRk6Ot+XGKBEw4qwqRlE85EiLNNDZEglkcaKZGXfboS7UB9mDLU
	=
X-Gm-Gg: ASbGnctbX1azqSIccrwgFXZeaqH00QuKlGTKmSzkbZh1UXf/xOlSTykc2RujRU3w101
	orSCmEWwsJzDGwZRLZ5jdBDyScinyzAo9Z3R7+akJ+6zSxwJ6jZGS39EQtHG762nfvYJDMOWCo+
	/m8z/rhth16VkrxrDutuqC8y5WoQCHFmCLucDk2f7SipeE4zTE9vQjog8vFd/w71xayDDKA8g7S
	cq18HBEw/0bSCZSPKR0t8GoxrrYAoW3+jUzt4WSzQUXEeZcGyhciS0CoMvFwNwBBrm5EGcjF5Cz
	wdeunScFbp/UHIvcaY4cGqNW9jz+Ft+uQ++sZiQNVv6gFa0ggn5eHp8=
X-Google-Smtp-Source: AGHT+IEeybUXkRlX6IExbahc3GrdkHExpvIKd+wfMV/CdPHX2glQu/itP/sXUsc5pkDfYlioP9hSOw==
X-Received: by 2002:a17:902:f649:b0:223:33cb:335f with SMTP id d9443c01a7336-2280482a71emr59657665ad.3.1743093464103;
        Thu, 27 Mar 2025 09:37:44 -0700 (PDT)
Received: from thinkpad ([120.60.71.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2291f1cf6dcsm1592085ad.113.2025.03.27.09.37.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:37:43 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:07:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bo Sun <Bo.Sun.CN@windriver.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Vidya Sagar <vidyas@nvidia.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Kevin Hao <kexin.hao@windriver.com>
Subject: Re: [PATCH v3 2/2] PCI: of_property: Omit 'bus-range' property if no
 secondary bus
Message-ID: <st52vx7pu64o64f76demebvp54sz3ai4nhhvmhfep3ivex63jf@te234j44leiy>
References: <20250324090108.965229-1-Bo.Sun.CN@windriver.com>
 <20250324090108.965229-3-Bo.Sun.CN@windriver.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250324090108.965229-3-Bo.Sun.CN@windriver.com>

On Mon, Mar 24, 2025 at 05:01:08PM +0800, Bo Sun wrote:
> The previous implementation of of_pci_add_properties() and
> of_pci_prop_bus_range() assumed that a valid secondary bus is always
> present, which can be problematic in cases where no bus numbers are
> assigned for a secondary bus. This patch introduces a check for a valid
> secondary bus and omits the 'bus-range' property if it is not available,
> preventing dereferencing the NULL pointer.
> 
> Cc: stable@vger.kernel.org
> Fixes: 407d1a51921e ("PCI: Create device tree node for bridge")
> Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
> Signed-off-by: Bo Sun <Bo.Sun.CN@windriver.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
> v3: Add 'Fixes' tag as requested by Mani. 
> 
>  drivers/pci/of_property.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/of_property.c b/drivers/pci/of_property.c
> index 58fbafac7c6a..792b0163af45 100644
> --- a/drivers/pci/of_property.c
> +++ b/drivers/pci/of_property.c
> @@ -91,6 +91,9 @@ static int of_pci_prop_bus_range(struct pci_dev *pdev,
>  				 struct of_changeset *ocs,
>  				 struct device_node *np)
>  {
> +	if (!pdev->subordinate)
> +		return -EINVAL;
> +
>  	u32 bus_range[] = { pdev->subordinate->busn_res.start,
>  			    pdev->subordinate->busn_res.end };
>  
> -- 
> 2.49.0
> 

-- 
மணிவண்ணன் சதாசிவம்

