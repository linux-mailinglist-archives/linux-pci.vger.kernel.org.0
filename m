Return-Path: <linux-pci+bounces-20622-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 309A9A24A05
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 16:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 945EA164AC4
	for <lists+linux-pci@lfdr.de>; Sat,  1 Feb 2025 15:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D01A841F;
	Sat,  1 Feb 2025 15:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vfGWYQQP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BA8182
	for <linux-pci@vger.kernel.org>; Sat,  1 Feb 2025 15:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738424850; cv=none; b=u9EDaQebvlm92Yc/KB7//fus/VHrSK1mNFEV8aKFF30PKTfuy8Up+tprDapZBQCaYOb2BBb7WbjdQBPu+W0YFB4iV6Rhu2NN/IwPSP7gAhIBwHNA2fygXo2J8Fr98c7UHA8f2K7EpnEnUKEmTi5yt1zApOHM0vOYY9NfDMMNbUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738424850; c=relaxed/simple;
	bh=j9pV33HFQovXN91OAFEixInYuagPj2/S+7gNKJ4nsLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aczHKt4amHpsPvqBRpAD0k5YkrwHNWPMJty9IioHSfcEmxnLN49F+eZYS4C/ZUecfpBvpUqFcNbqbOTIf36VNz25a+bBCd4MG1bk5GbTxKRipG5YooZSNqF34Fmvc+Oeny/I56zJ/1XzmTGIS7QrbPl2adoWbR7BLti5Do7KOmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vfGWYQQP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-216426b0865so51971385ad.0
        for <linux-pci@vger.kernel.org>; Sat, 01 Feb 2025 07:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738424848; x=1739029648; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1QK56/PAdG4m7oXURaJScaRmHn8HuLDVLY19o571DJI=;
        b=vfGWYQQPeQMvpJYanCPdIGKaqItrQq0baN5hzABT7nXTcjZo0qteAaxbAMpnQ2jbY+
         /HGPoEFZ6ZJlMSXRHDEDKaHbg24wiBKH3P5IuOIURYTEr1wYbDImwyMfGDyp/lF6nN88
         be+XQL/sCmR7r8zhsaXV1kNLLBihSUOco+5m9+e9ykBOnKzO9TcqYqVCmWwWSjVZ5/69
         9p9EYs+wcgPXiCbLxaKvlsWn/HUUgwGYD1GSPdoMJrcmm8A5IhSuWSbrHzR8sPujol4c
         Yt8/jlwsX3o7BtqoE1feG3I1ZJdufBhqJ2b+QO5bLh5GWe0uzN4R7Ogx2yTsZN70IvvJ
         ULeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738424848; x=1739029648;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1QK56/PAdG4m7oXURaJScaRmHn8HuLDVLY19o571DJI=;
        b=HnhB1cRdsf/nv2BGZ9lYFH00MFNI7QsTXaflW/JxEQk1QfFtBaXpRoD+JUgnDvERh8
         mSJjB18KdQkPjXsBouGNc5huek/eO+21QRg3mJ4VKd9nURpqBRNcLw17D8y6V0BwswP0
         EY12KAQFDHo8OLfEpDA3QtKXBsSv0hQl0DmCF7Au8tYc/9U8VBfguFqoZmeCSfhzu6OE
         Gj8kuMp+3AD3tpC0kFPJjX6SFcc2RT/Tz9ult+aGlpxhqEHPH1yFd6wMNP1akWa2+HIS
         w6BnIBkwZUoFhOlvO51QSRRXg7Eg84B6B2+FnXEhDzB6JuZL7deX/8E1plOvUN75nDtl
         FAAA==
X-Forwarded-Encrypted: i=1; AJvYcCWxI0U+vBpm0sAWXhVf1j2IcKdTguu7BlXdNJuaoDxSV0PVN3kM8El2f+SMjRUsi+Bh4s2j0UUVb6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjynVQYC+ZP1Ss6r5gXaoakRVsyfUq11u5Mu1BEfWUqNsLlFTg
	zxMeNtC2WZqPX0S0S8byBogTVA4P0OcRPMf4LCRBZYa7XxUaYwGZRu/Y9mZwLQ==
X-Gm-Gg: ASbGncuUp61PMvoiM5WZHA1CD+IF8AdJjzPcW3xZReYv1QXAhMz6lrUQVevTeEwCmAc
	SgqjInj5xIGPwkOOwuGinURkccP7n6hLPno715w6/BvLLqXI4KS5IpHy6paOqRwHbUjW5Sr9hrn
	EU99VG4rqKBrf5ECH7MmET3iiFjwx+oJL3SIPVL8cWfU6VzFczNxL44yXRmyscrUx4LluhifyRY
	Zb2Ex1j7BY/qEZxVcHQsM+hc1m27qzqkuM0EUfI/CcfXxO5Xx0eQA1O64PxNoiulXFPEXjYksRn
	GYcwJDHfOv24efphTNmmktskOro=
X-Google-Smtp-Source: AGHT+IEgXWUai8OMRAHRZfiJhTT6D8Zh6lptCLsZ9jfeJ5xsmZKPbJQctEqm5P1XGyyWRh713pXvyA==
X-Received: by 2002:a17:903:41c3:b0:215:827e:3a6 with SMTP id d9443c01a7336-21dd7deefdcmr249470005ad.40.1738424848137;
        Sat, 01 Feb 2025 07:47:28 -0800 (PST)
Received: from thinkpad ([120.56.202.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21de32edd7esm46840345ad.144.2025.02.01.07.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 07:47:27 -0800 (PST)
Date: Sat, 1 Feb 2025 21:17:22 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix potential truncation in
 pci_endpoint_test_probe()
Message-ID: <20250201154722.q34olz5lxoyxex73@thinkpad>
References: <20250123103127.3581432-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250123103127.3581432-2-cassel@kernel.org>

On Thu, Jan 23, 2025 at 11:31:28AM +0100, Niklas Cassel wrote:
> Increase the size of the string buffer to avoid potential truncation in
> pci_endpoint_test_probe().
> 
> This fixes the following build warning when compiling with W=1:
> 
> drivers/misc/pci_endpoint_test.c:29:49: note: directive argument in the range [0, 2147483647]
>    29 | #define DRV_MODULE_NAME                         "pci-endpoint-test"
>       |                                                 ^~~~~~~~~~~~~~~~~~~
> drivers/misc/pci_endpoint_test.c:998:38: note: in expansion of macro ‘DRV_MODULE_NAME’
>   998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>       |                                      ^~~~~~~~~~~~~~~
> drivers/misc/pci_endpoint_test.c:998:9: note: ‘snprintf’ output between 20 and 29 bytes into a destination of size 24
>   998 |         snprintf(name, sizeof(name), DRV_MODULE_NAME ".%d", id);
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8e48a15100f1..b0db94161d31 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -912,7 +912,7 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
>  {
>  	int ret;
>  	int id;
> -	char name[24];
> +	char name[29];
>  	enum pci_barno bar;
>  	void __iomem *base;
>  	struct device *dev = &pdev->dev;
> -- 
> 2.48.1
> 

-- 
மணிவண்ணன் சதாசிவம்

