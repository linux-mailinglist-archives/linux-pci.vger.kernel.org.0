Return-Path: <linux-pci+bounces-19909-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C00CA12948
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 17:58:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 061DF3A4528
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76365199244;
	Wed, 15 Jan 2025 16:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O7ovaSwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC16818C939
	for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 16:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960296; cv=none; b=UTUosCSoxPqqtEI9/keQoif4JLwFn8D38jHLXC60jjS4TV1UMVMLOKWpggXQ5F00a1S0lSuVB6FN+hJJK1N3fTqxTh5eiHIOTD4z0Ol7oNoQ1iEMHOHiF6cLEbhTmAFXrHalTxpgPaJsBHkW1M1XWKoC5IdI8s0gd3wXeAqhGXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960296; c=relaxed/simple;
	bh=fEGQwbl9hUJ6oQnBoI7Ucx7qUB0iJoPU6Lu4Sa+32HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RXWxmD0VOY9SL+dij+6U6/e+BaFFp2VRuqmC/c3q+h71ENnTtJZU0L78oXFRI14bTLcVCRdW5VLt6RGmESJxmIHhkz8kbVR1T4digZu+fvKqft5wFB5mtUbThlpbOoM5ItOEoXsEo63Sd9VOPS9lOGFqgKKn3HPzoZhM3bhhleo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O7ovaSwk; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2161eb94cceso87094365ad.2
        for <linux-pci@vger.kernel.org>; Wed, 15 Jan 2025 08:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736960294; x=1737565094; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FrsWxlPvPjKU4BaFHbiKk5qakR6RAoiFFc2vFZEWfTk=;
        b=O7ovaSwk5NjNfa2RcBgw11N98IflHlTER5MqV3SEsNbb07yKZCYJ3FSKYTIm45xz0Q
         G1EntYnkPmWqfYA3VfyGM7cvc1+N5WbgaSS3FamOIM42CST8k8dZ3LVMhf4K1Rrd01GF
         PIosyBoAgi1+U6a6IG4GMpAMMy/eYi+0RWAHOXkRURPO3Z8INo3yhJTjYmHI/FDu8s1D
         xgYPSKrmpdg3lfyNR8MuotFzUnZUTOGg4bhRV6eFFCKOnfztjCyTinf5FHnSwWyklHkc
         JziTc1f6DNjoTg+lR2qPP8Zew2axopDlDcSDNUnx1ogwHMuL2Z+A6zQTS4zuBE9WMJ0D
         0XBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736960294; x=1737565094;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FrsWxlPvPjKU4BaFHbiKk5qakR6RAoiFFc2vFZEWfTk=;
        b=VVXx5tMVq8hb7zCJ0gyOJLzqbOj3p3wqLo7t4RSwZAaL5vx2gv1SyL7WU3k8H4GrLU
         SeGbic5meWK3Qo/Ssm155yGf52bg+X3SjE5S57xTUiWMdgRxVxS6HfDYIjQfuyXKMvka
         1z5wu+zEpPtAVptmYBEBeg55oUbAuPNI1OQtepFvy5SHFuqr8aY0Ju5n58S3SMjm5X1v
         a1ssPdl0/36yxTN/Yppp5dcguW6Efn8WGgL9NYCp8iiVePfzgWm0DLdAtoRe2FRylVKU
         vEgyCCvVznBj3+9oa2jIinIRRICiLXcHRG80NPtwHHrOaGvazIMPybGtSV4zAJ1schUE
         a4+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXOi08o3x26ogWJB+AaF2etaPuJiXa1G9dUvlrxzmIaGGFdluRP3RGax3vC/ta9lsxecSowfQ6uQsU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbGtgJQ1t5IZvijMlZEXERtgaaVm9Od4QuY/eXjSrdRiRxzuHX
	XRuIqrMfZOccu+DqiqLUkesJgKFEnFlS2bs58e1cm1jSGV0s8Mzk0S+p12GxuQ==
X-Gm-Gg: ASbGncuX6L6+JtPRmH+3HnuDXKXB0le4VC0Xo67enFHrPmmr2YVlfhM6EHVkb0OBF24
	jJuL7v09iTPJFnR9POH2m48YMXpgmQ05QHo2nRp+5dIxqJLfbuGEfB6PHo30npnkD8kz06WUy1t
	6odInc/SVr9ISIa54qScTM7CwJELAxowyV8TOag1Vy94ZrIoM5jZ3GFVHuupLL7I1OrSZZsc3Uz
	uEeRnVojGRQqHLE22gs0Z32QMMr6SP87yn8mMV/Shrs24VtYv9/7PvYb7c6srVW88I=
X-Google-Smtp-Source: AGHT+IErOGMGOBTDhoMb5sMI+tbIZM8OnhY8rY5ymngydpcsjHDnNoB1f38C+XkxGmBFsWOdKynIMw==
X-Received: by 2002:a05:6a00:944a:b0:725:ef4b:de28 with SMTP id d2e1a72fcca58-72d22049137mr36477290b3a.17.1736960294303;
        Wed, 15 Jan 2025 08:58:14 -0800 (PST)
Received: from thinkpad ([120.60.139.68])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a5a32sm9790093b3a.173.2025.01.15.08.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 08:58:12 -0800 (PST)
Date: Wed, 15 Jan 2025 22:28:07 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: kw@linux.com, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, rockswang7@gmail.com,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [v11 1/2] misc: pci_endpoint_test: Remove the "remainder" code
Message-ID: <20250115165807.4m6y7p3arjmooh7y@thinkpad>
References: <20250109094556.1724663-1-18255117159@163.com>
 <20250109094556.1724663-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250109094556.1724663-2-18255117159@163.com>

On Thu, Jan 09, 2025 at 05:45:55PM +0800, Hans Zhang wrote:
> A BAR size is always a power of two. buf_size = min(SZ_1M, bar_size);
> If the BAR size is <= 1MB, there will be 1 iteration, no remainder. If
> the BAR size is > 1MB, there will be more than one iteration, but the
> size will always be evenly divisible by 1MB, so no remainder.
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v9-v10:
> https://lore.kernel.org/linux-pci/20250108072504.1696532-2-18255117159@163.com
> 
> - Remove the remain variable declaration.
> ---
>  drivers/misc/pci_endpoint_test.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 3aaaf47fa4ee..f78c7540c52c 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -280,7 +280,7 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
>  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  				  enum pci_barno barno)
>  {
> -	int j, bar_size, buf_size, iters, remain;
> +	int j, bar_size, buf_size, iters;
>  	void *write_buf __free(kfree) = NULL;
>  	void *read_buf __free(kfree) = NULL;
>  	struct pci_dev *pdev = test->pdev;
> @@ -313,12 +313,6 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>  						 write_buf, read_buf, buf_size))
>  			return false;
>  
> -	remain = bar_size % buf_size;
> -	if (remain)
> -		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
> -						 write_buf, read_buf, remain))
> -			return false;
> -
>  	return true;
>  }
>  
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

