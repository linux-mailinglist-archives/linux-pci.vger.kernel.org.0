Return-Path: <linux-pci+bounces-45181-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9837D3AB44
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 15:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ABAAA3087132
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 14:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F187436CE0E;
	Mon, 19 Jan 2026 14:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="cREaGaRF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625A8368294
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 14:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831479; cv=none; b=MlxXt6F0eRH2Agu45DPwrKaEFeqfgRzzVdKFgCmA4/rc3us6NLLIcrJK69zpSVZ5UaARppcoTHoKOeFpyJADBFdXvZw09PU61lRWLvOxVsleLTbSrddgihKCjPlX/QC1AO1WSKKJB+U6782/mxX+9hAD2lVudulF/MJ0GFkP9EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831479; c=relaxed/simple;
	bh=m2uBx0rH9BBwtr/Uco1kTewsgSVG+SUQOTeuEoSlDOQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C3b8n8sRDWvaVYTni+ps/6rxItgLvpQWnlSz68c6DF453melzEhVfALFIdEbMMhnQuyH9SheWj2wSUh1pOPa3H0adUI4qz8+V0oUGlURHuqVFEXmyuDeWNcmuPIFpfG+p0MLC1o5M3a8dY+crwfxsUaV6SIejWxUHDimAA1Kssk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=cREaGaRF; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42fb5810d39so3452908f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 06:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768831477; x=1769436277; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=S+uiJg79CSTOd7IU+Zjr8vG48esanihoaH1GIX6WcHY=;
        b=cREaGaRFDQFI5hL97AT7ZRhouQ8ZAcoaODf9B8xIP2SiQfkWbmPLLndfGFr21SwMN4
         fYryGwaaikaOtlOtw9W/OyX2SC1vKlU7lCEZfGzmS1AA56bhj5S3dZpxmbIPgao0nIYK
         WiJb4ob6B4Q72iRlsaqHB8ekMcSdg8lk9oLDb1YZQJ6MOzbEHXmCrQNzE9FavQyI1hZD
         1ooOigIQR8Bzqul48yt68DS4j15LIGY9EImCMWyBsP/SRboorOxhXV47JrpAi6+8xNQC
         pfsZ4oVs42SbZ9k9fVUGfIwiXc2kMGhhKTOEZcO4B/YPU8d8HGLuwKFvBweYQ7wtgLTm
         2jzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831477; x=1769436277;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S+uiJg79CSTOd7IU+Zjr8vG48esanihoaH1GIX6WcHY=;
        b=giJ1UCiFg7wKJl0jSPiWJ3ab0YLeBSjX+Gwtfkv7frMWi8pX7yKnEN75gbB6z4inq0
         xjURU3CWHTH3D1PCggWQjmmPK4pwvEXfzLryq+VRYifqaBdv9cHHHzNGEw3eThozlTkn
         bNAgDCiEGpRJsoJnyolDqnIWbYUGt4LDRrN5cfuK7qyV45VuUzgk2jMVoBM0fN2burSV
         7L8y3KZSvCkZgiZ+sZaB6uLalJcjhd7CsCNH6Xe2JxYBuxnX1U1b7DRQP1hDC6+Riqjy
         Abqwlz60YFoWKeyBkeVkmD0OcegqEaL6YpSeP5qNJJy1uT9pvWik9O2gBqHQlWrx9jYS
         B5JQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvyKTXzAo4UytHTY7DBpodVcUyOBh3QrMx2aImep4LYHijmDrmJmalA5sEgzPDoRhU9rjO1EmX7Gs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBr//Su3ppBenCCbRjF689ICuG1H70cUUgS7Qo10OvR5/euzoF
	ukDQsWXin0QIpQKwPU5EGv7jBJ9FU8xM8WvSzpGtsY2S/ZsmUgSEY87jp3cPWMZUktQ=
X-Gm-Gg: AZuq6aI1zDk+6Wd82EavRYYYxHG1Mr4uNCcntzS5uH3oRMJy/RDyO+L7fAywoHTKEW4
	Bv5xn8O1DOsBX7X++KfClQr2G6BwNIA0Szf0VMT8Oyfj6ywJQv7ump6qtWOVPa13fI4Z66M5TKh
	1K30dr7bLvDztN6bq/ADKwvZrzIyQ4xfrEw5yI7q23XAlG0fntrZT5K+CKdKmxEPiU3HNLMf+jA
	oWt5TChOjGvuYvqLWci9vIMRlKmXViBsKTd2/krAr/K0OZBoMYF5jPbc1t6ZNlH+jw7VFc3oLkq
	STxBES9LjYWU/7sNzYCLP9gF1P9Lz5tq919hic16Py8UPt6vrsIDSlID6FR7plW7Amy9TPF30RN
	1ohZEjaUOjQYUUvyqGFQG6goOvDZ1Qo0nxTgkogiFCOxwtUzy/66DE2tzU8ZI1gnN9CO6AN+7Ng
	3QD6dlabGfIWFpcU7xBw==
X-Received: by 2002:a05:6000:400c:b0:430:f742:fbc7 with SMTP id ffacd0b85a97d-4356a0296e9mr13698492f8f.14.1768831476764;
        Mon, 19 Jan 2026 06:04:36 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43569921df9sm24010322f8f.3.2026.01.19.06.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:04:35 -0800 (PST)
Message-ID: <f6c7cea6-fbd0-4b3a-ab89-a3c26be11ce6@tuxon.dev>
Date: Mon, 19 Jan 2026 16:04:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/16] PCI: rzg3s-host: Fix reset handling in probe error
 path
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-2-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260114153337.46765-2-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/14/26 17:33, John Madieu wrote:
> Fix incorrect reset_control_bulk_deassert() call in the probe error
> path. When unwinding from a failed pci_host_probe(), the configuration
> resets should be asserted to restore the hardware to its initial state,
> not deasserted again.
> 
> Fixes: 7ef502fb35b2 ("PCI: rzg3s-host: Add Renesas RZ/G3S SoC host driver")

The title of the commit with SHA1 7ef502fb35b2 is "PCI: Add Renesas RZ/G3S host 
controller driver".

> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 5aa58638903f..c1053f95bc95 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1588,7 +1588,7 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   
>   host_probe_teardown:
>   	rzg3s_pcie_teardown_irqdomain(host);
> -	reset_control_bulk_deassert(host->data->num_cfg_resets,
> +	reset_control_bulk_assert(host->data->num_cfg_resets,
>   				    host->cfg_resets);
>   rpm_put:
>   	pm_runtime_put_sync(dev);


