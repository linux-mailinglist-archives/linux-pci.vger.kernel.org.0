Return-Path: <linux-pci+bounces-21511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D85E3A364E5
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED47518965AE
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A37D267B0D;
	Fri, 14 Feb 2025 17:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XVBWQZ8T"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AB4267B11
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554971; cv=none; b=seS4UYHMxeMfc4lOvllg3LKZtLvGK6CULaqOgewY4CRlfSQzvL//urO94zQUo9mUqxzcfCXrZzTODpAQu3iCgA5UjklGqjwm/mkcvZwUTzs9hWhwQ+jcMA+rf59GzbZ2wd/N2E25bBf+E1ThmD3judX63n/TK1B3O3KheVtj/cU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554971; c=relaxed/simple;
	bh=/ymiZOUY9ORSTPXKt1ZNTWsHlubF2CeRjFYgQFPGc2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DmjtazY3lvqlFYyvDo36gOauyeEqPzuDwXM66OhAjTm79AUOIB2c5BeztScYy77Zp0yzEi/+l4sglkeMWVSywBmrqpPUC8uv/2XqFazUpnDWsXi94sUVCzW+8tze1MbOkzBTTh+Xl1vE9nwD96oGKrJz2+JydAmrIlBTG/vv2uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XVBWQZ8T; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2f42992f608so3812740a91.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:42:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554969; x=1740159769; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XBwFdz8o1N3nJCjb2V1Fwqg9orFJvPM16MYAOtFfhHE=;
        b=XVBWQZ8TY83RoKrBWboDhEXhCbPELdCjAwPbT9PBZ8193ZJzxjxU71MYX8xWVnp+5f
         Des8s565RaZF3Fpnb/65hBlhePWeYaK9MEGh+naPxfDDTfAcn8Owi1rwbCpYG6Y1Tezo
         cy+Gh0Vo/7fHLXElBVCkaSPwHikJVZWxE3SSP3s1b39rodOGvyHd0jd3h7j56kwgLhOw
         o2YJYXuSpDaUUur6MS8QUFx0Emnt0ZtwLGUnZ2vJOrkJ/pacvliqj72rT3Ikl4aB/qaO
         Nupfx2q6bzdYModjKJFcaTvtgGAm/+ETlX1fcyUfjD3LSFZ7PYNCtEX0n6MKMCTgXW7d
         aT5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554969; x=1740159769;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBwFdz8o1N3nJCjb2V1Fwqg9orFJvPM16MYAOtFfhHE=;
        b=JK0sA8x45xc4Q1RUS3hf4odS96CZZVj5eMLfCdXjDRat82k6BBVU0IYjRtY5Nxk5St
         G5r0UpQ5Ru70npRFaGUrO2juEJhSy7H6YJ0ddvarreIKNl/6ZV793UC99uD98G59kurG
         3K1sUAy17ndArPNUI9yJLsaRmMq4SO/vp7/5sYpyUYQ5MMtNdBcYJF5l2Hj9+1H4W80s
         jGCKprbzlp+psox4oOu1LPut58hYTPsQ+DXG3t/YWBvXxzNL1ZqHtUIvRnKVh6U3ZNXG
         JYmbieiSi8gexTsPM5XO2EA7bES1eKU0ybtpiboG50As2/6lHiGlZV53AjEIV9alWUQP
         iIvw==
X-Forwarded-Encrypted: i=1; AJvYcCVnEEXQKmtfLlK1VvJdG34WEOCLlX6L88c3qAPQAgAfBGDy6TKDyLS0YJAi5Lw5DOqTwAXUCAr4VNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7It5bJVvUoDNuvCXPY558ZggY/9+Sxk+CgwILesCgdUF76LRU
	NQ2WQA2xE+ZEgrdhPtKPy2+5BafRs2qrAm78ufEYkBczNbIeVDqHNI34BYyMkw==
X-Gm-Gg: ASbGnctr29VrWTckfoHNDIeDGLmRuq+jlYKHP8n1ChhLwDgqG99fBbycPB/1sU9vSiV
	qbAWxrxXhDqslNvZSuj+/3Wc22wGJJBIEdZ4lmb9kAZHDeUTZlYlQZ96T5ykczeAYj7+1WIC8it
	UDx0347HBbGRTLyFAiApUBJFQsFtqwtkuuct3Il4o5j91EPHjFeZ8UhmPc1HgrXq+N3F5tlqux+
	sUZdk6RXw/scDplFQakw6rqgn7Zxn32eDAzwXTU6JjIc6CMsfR6f6rqKLtq8MOGub5naBhxqq4V
	lIGtUVnvdwrhF/qytS31O51pRwg=
X-Google-Smtp-Source: AGHT+IFwlsunpuMjX/d1aKypFFMNs39qFkwdbYlbdBr70XsnPQn3e/XNa75mGopRCVBPunXplK/iDQ==
X-Received: by 2002:a17:90b:1b0d:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-2fc0dfc8d31mr11198310a91.6.1739554969066;
        Fri, 14 Feb 2025 09:42:49 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fbf98b3310sm5404297a91.9.2025.02.14.09.42.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:42:48 -0800 (PST)
Date: Fri, 14 Feb 2025 23:12:45 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Fix potential truncation in
 pci_endpoint_test_probe()
Message-ID: <20250214174245.ctrzbp7bcd5v4xdt@thinkpad>
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

Applied to pci/endpoint!

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

