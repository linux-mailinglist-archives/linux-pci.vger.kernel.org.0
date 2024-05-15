Return-Path: <linux-pci+bounces-7481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15AF98C6204
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 09:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CC8C1F2204D
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2024 07:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE8B482C8;
	Wed, 15 May 2024 07:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YhS930mG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4003C4CB23
	for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759255; cv=none; b=R2ZxZ+kzuMKu40Wn1NkcCcvgUG230hzfMTQPua/srnffojFHa+29kIDzZKyVAOZ3jg3+WdZXd6/iqVpRT41jcNB2ctTBjqQcP9ARHQGu7YmhlorM7SSTcYRuDlv4QXJ8/5b8T7DXTBIH7Sh/Jq6tODc9Z7uDgl+Tzk4VlVbhHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759255; c=relaxed/simple;
	bh=oTyV7UDhXConmMQHKJKF2WY7SMvTHvxxDnYW5I4nAXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d+165hb+tP2HvTwVI2e5f/eeIWVaq02le8Xj3EzdctHn+8apLZFIuoOlZ0eO4xFLYP/DemxqT5x9+G4EuSGcrKbrMSehYfEiKMEOtLTrh6vOCznu1PjAW4VFxIs5NfXStG4P4BvH56E5A2LPtuEM9qmWyrT0zF1DsR0+FeHbpL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YhS930mG; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-34eb52bfca3so5627168f8f.0
        for <linux-pci@vger.kernel.org>; Wed, 15 May 2024 00:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715759251; x=1716364051; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fbW14bg0Wumeh9jCsijMHeGxFGLGKw9Y+IaaoUwt+VY=;
        b=YhS930mGPPsYF402D/mRTLnZQxzp3R2ZX78benJuCZj6jnGbTXDQObY0fwlb6KC2Fr
         qhcqwJEWeuymvRalYPJyGwO1OpwJX0c7P8pFCJjUpm+Y+5zkitYfSvSQ0t4kX4gvBMD1
         1RS2ITAk69NkimsM3XQ+0KG+0M4WQQWq4YxE6X1KdDgI7FqJ5E32sFOD2LYEZ/Jk6JRx
         JUn6yeXCWh5vidsgZ0QAiNzWNTh6iwJ2WjdTYYJOY7h/SuUrBQniz1Gg21DZjMiS8YBD
         y/kdZZ0BQ6YCvAThXvaqyHOCYfA2SkmUrbJJ5ZTe6LWYnr4GY+bS2YH4WoFSCzNWD+B+
         axng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715759251; x=1716364051;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fbW14bg0Wumeh9jCsijMHeGxFGLGKw9Y+IaaoUwt+VY=;
        b=eFv8HFw/pTDtMlyBh0lKno+PkMsQumQ/IQnq+VPQggq1cbZ44V+hK1YQufRQx8crW7
         phrRNqOKu1MeAN63eXye+bu70VLv4QNHJxeqxc9YH6wM9cZuAv+n4FNTgxRptTNor4xr
         G/4Nxm0FkIjRVdZqtVYp2MgLSWzTKvTtZLozcVDXIooPol7qK0+xdZVz0VBikkaWVo9C
         1Vu3IHWkcD2yubRfm5dgaFcOHcHKCWmK6cz4srxRG12027Lurb9AtbhsIZNqoKarPMSx
         fU/1HOJ302TMTfEtobq2OsVf/f9ZubrTo5Mbze9JiyatQ46mAUhTRYMpJNWd2k2bM/un
         nBrg==
X-Forwarded-Encrypted: i=1; AJvYcCU0MiAA6brRSnwpjYQkP39PSzwMf7B1jN6VTHyENhHPTyOgGp7mAc4ShJyL7OrNqGmT61aJdg4bXOGlbrjumplv2XnOFZ7E7CbC
X-Gm-Message-State: AOJu0Yz1oDU/RbcOi+oC7lQKq0h1c/s1z5RLkEcX4IFx5g2nMzcyrE22
	1cXX/pui7DwtADBAS8NuoBKcXLqsaBOUtefvxgYe1ZHvvVhzIDmVjkAvZLZAMk4=
X-Google-Smtp-Source: AGHT+IHMagoScq7U99hdVHkw1NBdhpBlZdJTQg/2XG8xtYlCfMWMq7GIe724Va2TIIkHo5+SH6EweQ==
X-Received: by 2002:adf:eb49:0:b0:34c:f4c8:3af9 with SMTP id ffacd0b85a97d-3504aa63147mr12280225f8f.58.1715759250689;
        Wed, 15 May 2024 00:47:30 -0700 (PDT)
Received: from [10.91.0.75] ([149.14.240.163])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3502b79bd7asm15561313f8f.17.2024.05.15.00.47.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 May 2024 00:47:30 -0700 (PDT)
Message-ID: <ea9ce984-8a07-47a8-9533-a6cea5b318b5@linaro.org>
Date: Wed, 15 May 2024 09:47:28 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] drivers/hv/vmbus: Get the irq number from
 DeviceTree
To: Roman Kisel <romank@linux.microsoft.com>, arnd@arndb.de,
 bhelgaas@google.com, bp@alien8.de, catalin.marinas@arm.com,
 dave.hansen@linux.intel.com, decui@microsoft.com, haiyangz@microsoft.com,
 hpa@zytor.com, kw@linux.com, kys@microsoft.com, lenb@kernel.org,
 lpieralisi@kernel.org, mingo@redhat.com, mhklinux@outlook.com,
 rafael@kernel.org, robh@kernel.org, tglx@linutronix.de, wei.liu@kernel.org,
 will@kernel.org, linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, x86@kernel.org
Cc: ssengar@microsoft.com, sunilmut@microsoft.com, vdso@hexbites.dev
References: <20240514224508.212318-1-romank@linux.microsoft.com>
 <20240514224508.212318-6-romank@linux.microsoft.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240514224508.212318-6-romank@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/05/2024 00:43, Roman Kisel wrote:
> The vmbus driver uses ACPI for interrupt assignment on
> arm64 hence it won't function in the VTL mode where only
> DeviceTree can be used.
> 
> Update the vmbus driver to discover interrupt configuration
> via DeviceTree.
> 
> Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
> ---
>  drivers/hv/vmbus_drv.c | 37 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
> index e25223cee3ab..52f01bd1c947 100644
> --- a/drivers/hv/vmbus_drv.c
> +++ b/drivers/hv/vmbus_drv.c
> @@ -36,6 +36,7 @@
>  #include <linux/syscore_ops.h>
>  #include <linux/dma-map-ops.h>
>  #include <linux/pci.h>
> +#include <linux/of_irq.h>
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/mshyperv.h>
>  #include "hyperv_vmbus.h"
> @@ -2316,6 +2317,34 @@ static int vmbus_acpi_add(struct platform_device *pdev)
>  }
>  #endif
>  
> +static int __maybe_unused vmbus_of_set_irq(struct device_node *np)
> +{
> +	struct irq_desc *desc;
> +	int irq;
> +
> +	irq = of_irq_get(np, 0);

Where is the binding for this?

> +	if (irq == 0) {
> +		pr_err("VMBus interrupt mapping failure\n");
> +		return -EINVAL;
> +	}
> +	if (irq < 0) {
> +		pr_err("VMBus interrupt data can't be read from DeviceTree, error %d\n", irq);
> +		return irq;
> +	}
> +
> +	desc = irq_to_desc(irq);
> +	if (!desc) {
> +		pr_err("VMBus interrupt description can't be found for virq %d\n", irq);
> +		return -ENODEV;
> +	}
> +
> +	vmbus_irq = irq;
> +	vmbus_interrupt = desc->irq_data.hwirq;
> +	pr_debug("VMBus virq %d, hwirq %d\n", vmbus_irq, vmbus_interrupt);
> +
> +	return 0;
> +}
> +
>  static int vmbus_device_add(struct platform_device *pdev)
>  {
>  	struct resource **cur_res = &hyperv_mmio;
> @@ -2324,12 +2353,20 @@ static int vmbus_device_add(struct platform_device *pdev)
>  	struct device_node *np = pdev->dev.of_node;
>  	int ret;
>  
> +	pr_debug("VMBus is present in DeviceTree\n");

Not related and not really helpful. Simple entry/exit tracking is
provided already by tracing.


Best regards,
Krzysztof


