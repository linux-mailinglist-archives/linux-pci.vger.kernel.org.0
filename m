Return-Path: <linux-pci+bounces-21495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E82BA36492
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06F5D3AA6B1
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B423E267F54;
	Fri, 14 Feb 2025 17:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTQTHXQa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200422673B9
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554184; cv=none; b=dh/YNKk9qPrOwaSq/7TeOQ9MjB71wGeQFmfo8PbDbSKO8KBBnkn8mlzIl/t7109pgAsnUE1cmItOxl3tA1VOHITRKq/paslDGGjRMQzlZ3DzisJuLk0Vs5cgqnAbH8qpqBowZzdOuNsu5PqJc8BiaNzzD7g1KAAkjKhaar0q2ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554184; c=relaxed/simple;
	bh=LWxIuFXSX9m8GW5L588vDhQDC6zRy0K40LKOopQ0mpc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJ7OWo0UQ+WWgmiyuRc92P21oIuz4qp/CsZlylg0FKA4WBPqVKemLOp7uyjvdIdRhFP6L0TdaenlYFQYgLt4ugIVAo27LPRbj74Uap5RRCxdhfSl9phhM4VS9gNuWAbdKVu0wue1M7+6seEn4xksk1jhWNiIe2EiZRZq2VigxOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CTQTHXQa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21f818a980cso37915295ad.3
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:29:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739554182; x=1740158982; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ELI/xEjw1uh6b74BcnUgTJCqcnXwKg8w1E10nnathDE=;
        b=CTQTHXQaehlxaItgsw2MpQPNJBMlRbBRg4/XIkB13GIS7y5RQdx8UYe2I8GVYaPcoK
         ror6nNlGThAfpUsSDlQe2hQu365ndVsX1XJXHDrbLuMo/x26CuPPmh20qf/WKqVs78E+
         FLwGsJ1GVzBeF4Jd937BTWJTvyMJACvtEu9CM1KLFY60BeGGRSdp6DetlhnFM9Uk9pbi
         VDUUiSLsp3PJxvdQDMq2IAn4ObJfcQWfPlET9dA2TROcsjddxmveVT9xJz16NKEPjnHU
         SaROsuQ2glk/5IZq7LzFewACY3jUI2W6PaBzwKakqIZfAyJGXHTmKBsLzBaYGDnSIuGo
         dcdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554182; x=1740158982;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ELI/xEjw1uh6b74BcnUgTJCqcnXwKg8w1E10nnathDE=;
        b=EPnVjGAbQH6FZEIpO/l57pL/tdlNOUjuatHjt8nUIufz5mEL6UoBj3KkU+WlibVMCM
         k8Vt/N2iT8znpL+bTRmOG/AG4CNwQQF6yV6raqfxb3k3VqScee8E/RsWSgAiRMMOlqKU
         FV6cPIWRem3Ok2KJD1mxfPZZrS7w9Ai126P61WRnhnzETQHUyIg3UYhSpxC8b3pzhvAC
         grXbyOYwJZercFprxvbDh/oagDGXsMC+3wNlWf1naxWNyt558k1QTqKVJrtZm5UkJcsO
         /pZjOZAg+KrxdClozd4hwXW5FkWtc6jP4XdctLvyF8PM5aIO6qMh97qQa66oKJUN3ret
         eFJQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhvemHV0EuAo3jT7D5GxKPx4ZDiwYUsDTiid7/ohm4eUhKnqlxCCu/4+hr1RhUwB5Usl326rUOGvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiD17JOmk/dmZ05ClqtwVRwcyXbnrFxd7U1HLYjGMEC9KbzkYR
	XuEPRI7roJtSa6VfYh1Yy7Tqb1i8uRF9dlSp7B8e0EtG0VNhjP9S7B7GFvyo0g==
X-Gm-Gg: ASbGncugqpq4VxUJ5hE9n5dtjzfK7IDh8+OtKhim9zmgFAc/gstuESB5CMQUUzOlg0x
	Nl/x/IWwz+WGLeJKTW1c+Ml7xv3ok3hBl+/59hI30+A5xsPM8zH+yKKk0+NsTQJcAQjlsyB17F+
	+jcwE5fg5m/LpgEhvwJ+VJecSCdbgv0vYNGbFXaZM6jYCx90njNtoiTN9Sprln4GGrnfo5Y3lAF
	yydV87fH4iw71eD5qClKSMexia6NKqC9mTYEe/Z/LmKParGcQLRhjfblTYHuB1DZ2mGjMk/VkLZ
	bc9M5Dd/TWs82RS3d2t6vd/iXBs=
X-Google-Smtp-Source: AGHT+IHNABlhUNAWdSjcRb/hYy/2fshtO9XklLTg0TKpN+C9Gr2+9CK/PpINy5rWODndFowOuADONg==
X-Received: by 2002:a17:902:e5d0:b0:216:3c2b:a5d0 with SMTP id d9443c01a7336-221040a4d45mr522085ad.51.1739554181042;
        Fri, 14 Feb 2025 09:29:41 -0800 (PST)
Received: from thinkpad ([120.60.134.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d556dc4bsm31421075ad.188.2025.02.14.09.29.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:29:40 -0800 (PST)
Date: Fri, 14 Feb 2025 22:59:36 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Krzysztof Wilczynski <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] misc: pci_endpoint_test: Do not use managed irq
 functions
Message-ID: <20250214172936.4l24mwry2efm6dyy@thinkpad>
References: <20250210075812.3900646-1-hayashi.kunihiko@socionext.com>
 <20250210075812.3900646-6-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250210075812.3900646-6-hayashi.kunihiko@socionext.com>

On Mon, Feb 10, 2025 at 04:58:12PM +0900, Kunihiko Hayashi wrote:
> The pci_endpoint_test_request_irq() and pci_endpoint_test_release_irq()
> are called repeatedly by the users through pci_endpoint_test_set_irq().
> So using the managed version of IRQ functions within these functions
> has no effect.
> 
> Suggested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/misc/pci_endpoint_test.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> index 8d98cd18634d..9465d2ab259a 100644
> --- a/drivers/misc/pci_endpoint_test.c
> +++ b/drivers/misc/pci_endpoint_test.c
> @@ -212,10 +212,9 @@ static void pci_endpoint_test_release_irq(struct pci_endpoint_test *test)
>  {
>  	int i;
>  	struct pci_dev *pdev = test->pdev;
> -	struct device *dev = &pdev->dev;
>  
>  	for (i = 0; i < test->num_irqs; i++)
> -		devm_free_irq(dev, pci_irq_vector(pdev, i), test);
> +		free_irq(pci_irq_vector(pdev, i), test);
>  
>  	test->num_irqs = 0;
>  }
> @@ -228,9 +227,9 @@ static int pci_endpoint_test_request_irq(struct pci_endpoint_test *test)
>  	struct device *dev = &pdev->dev;
>  
>  	for (i = 0; i < test->num_irqs; i++) {
> -		ret = devm_request_irq(dev, pci_irq_vector(pdev, i),
> -				       pci_endpoint_test_irqhandler,
> -				       IRQF_SHARED, test->name, test);
> +		ret = request_irq(pci_irq_vector(pdev, i),
> +				  pci_endpoint_test_irqhandler, IRQF_SHARED,
> +				  test->name, test);
>  		if (ret)
>  			goto fail;
>  	}
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்

