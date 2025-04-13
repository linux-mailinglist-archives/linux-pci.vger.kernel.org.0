Return-Path: <linux-pci+bounces-25737-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A792AA872C7
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 19:04:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05FCD18951E2
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0751EA7C7;
	Sun, 13 Apr 2025 17:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="caYBOeaA"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC5B51A5B89
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 17:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744563865; cv=none; b=l7ryBiE1RW1DBAuA5lagQ/KcGAv1kVVqSb6WwVyQSjn+TdmAiUNPgWck1AmH1WVFgOBpo7ZtgYyDRWtCylC/v9ilbfxsC+9VBAXzVw/X4iUo1MBbhKg/AlgSrIQHMANoKRcHsmba+JhEogCehZcPYlgh3n3Sil0My8+OKIJW1Pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744563865; c=relaxed/simple;
	bh=yPwDn54Vac1JGWRY146dwgLEgVTLswU9aEd6LJpURUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dU1R8IzsKlc0cQn0znQwsdnp7q8EncKr4TImY/x8K1ts+u5SVRoiwz6r4DgjkE/VWtw1bjvYv2rbpHgVACcFEjaKUxY/gCUFk4uOAu31bzefEbAkwP/aeuLf6TB/pj3iDpkBlSHVk0+V8DT/620W3H/K7C8jznGqUZpQb6C2jO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=caYBOeaA; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-736a7e126c7so3023943b3a.3
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 10:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744563863; x=1745168663; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=a+u4SfCebi7qvppMaSoUa39+r8AbRqCDUq1wg5V2v3Q=;
        b=caYBOeaAV9f6eRwnKS1B/QM7guISX5BcuLQjOJnU3knJ4bfZPeH/nKTPBflc7vZbhL
         6LYrC37YWMKQFie8TOa8Jc2hSb1Y+mWD/Vhq8lQRBaUEoGGHrIAVziP89IKBk3bPFiWt
         vWMvooj6H9h6TfKnk3xQNo7plMckQE66w/6+bmhIMBV/MXsvT1kXQqJAF4lx9cUlefnT
         sShWZ71f4tAmKy8kBGE8F8xpHejWNMC6v94MQ2EjeJzCnWpHH6ZAVMVRec3mY+rvMTX+
         0GR+A50uixsmVE6f+Q6gQiAbiVhASWtmQiJP1ydf0rlYtxDL2/+2Kf5IXZaOqPfQaKCk
         M8LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744563863; x=1745168663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a+u4SfCebi7qvppMaSoUa39+r8AbRqCDUq1wg5V2v3Q=;
        b=rivL65WWMV79TTWrRXaDv5WuifZb8WRlXHGJBEUWodz351hS0Mm1LT9x9DzLtAXsIe
         I/X/fBsbmLiQqmHK1fwFezTUGC8J4zmqVGaEklWWY98M485reGPcbaV+TlA1+Kep/v4L
         jeiiSQNJhcPFMagZ7ySCNGBsA5ct0SkjgBCjARVhKLuNkBZ13qEGCstT0k1BavY39Rm5
         5HTnZKykvXqYRzTdQF2GQdWGLU7XJVMNUscoIWI6I7tnnfwm2bSTjMdO6tDCZy8KrLNl
         zQawxEvfF7WfVHffAj9TVe8TSY9hoE/JBUunSSLe/ESJEi7n02HDTG7CIvYCiEXEJtEY
         lv3g==
X-Forwarded-Encrypted: i=1; AJvYcCVSuL1KolZirStCbhzrUQsfFf8D2H2PyWllN8OGbsC0AElRwlMAn1qSkvBGPFlGqytby+Kcx9K0cWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzwq1xZBDnlvCQdNanePXHnvDnpz8lLGPJ7zZDmtoNoMCcjcVZ8
	4VssNVaEcJNg8WS33vy1tIUXlJf8KURaFAA8DUTLf35zDfezNcT6Jmtrrd1aMw==
X-Gm-Gg: ASbGnctaxm7mdXwRrbvrnpsqjPE/pkO5T+05n1fPpqp97N/qZgtAf+0vJ8e7qKQBrgp
	0HsnWQVYvEjN1q1/ikZNdEbUj4wH5ThVbWcmUwishu3B9J8lXnqOSLf+0vOQ3ZkPKZ62JEdKD4b
	8F7wceuGzSdo0I1ZAXT+BNV0tWUWqrBkw/zjdrA5E1O9GP+eH/l7OND4ubazVBGZrDdm70ECFfS
	GeBUUUE1BMh/pllwqo4pO3TMbSj94jd9m5iB3S1QbDQuLeAKN2Ucgb9j7ShKmvA6L9xZlaM9voT
	ZHcD0BQkG2xt1UubhL9FN3m0KL8N9K45QrKPCBQnZXJnFq438PGk
X-Google-Smtp-Source: AGHT+IFjyC9Nav51W8D+xJs56DEyrXe47gAj9cOlUzK/cynD/DwixHK7w/Y7LX+u7QpqEKkPzlHNBw==
X-Received: by 2002:a05:6a21:c8c:b0:1fd:f8dc:83f6 with SMTP id adf61e73a8af0-2017999735fmr16680739637.40.1744563863083;
        Sun, 13 Apr 2025 10:04:23 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2199535sm5339872b3a.14.2025.04.13.10.04.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 10:04:22 -0700 (PDT)
Date: Sun, 13 Apr 2025 22:34:16 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Marc Zyngier <maz@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, asahi@lists.linux.dev, 
	Alyssa Rosenzweig <alyssa@rosenzweig.io>, Janne Grunau <j@jannau.net>, Hector Martin <marcan@marcan.st>, 
	Sven Peter <sven@svenpeter.dev>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Mark Kettenis <mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v3 04/13] PCI: ecam: Allow cfg->priv to be pre-populated
 from the root port device
Message-ID: <5nwjlpnpwh4yto6wi4nxcwumpd7iilpq4mblpfqsvdxg2bfdsy@md6ok4btonxz>
References: <20250401091713.2765724-1-maz@kernel.org>
 <20250401091713.2765724-5-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250401091713.2765724-5-maz@kernel.org>

On Tue, Apr 01, 2025 at 10:17:04AM +0100, Marc Zyngier wrote:
> In order to decouple ecam config space creation from probing via
> pci_host_common_probe(), allow the private pointer to be populated
> via the device drvdata pointer.
> 
> Crucially, this is set before calling ops->init(), allowing that
> particular callback to have access to probe data.
> 
> This should have no impact on existing code which ignores the
> current value of cfg->priv.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Acked-by: Alyssa Rosenzweig <alyssa@rosenzweig.io>
> Tested-by: Janne Grunau <j@jannau.net>
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/ecam.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
> index 260b7de2dbd57..2c5e6446e00ee 100644
> --- a/drivers/pci/ecam.c
> +++ b/drivers/pci/ecam.c
> @@ -84,6 +84,8 @@ struct pci_config_window *pci_ecam_create(struct device *dev,
>  			goto err_exit_iomap;
>  	}
>  
> +	cfg->priv = dev_get_drvdata(dev);
> +
>  	if (ops->init) {
>  		err = ops->init(cfg);
>  		if (err)
> -- 
> 2.39.2
> 

-- 
மணிவண்ணன் சதாசிவம்

