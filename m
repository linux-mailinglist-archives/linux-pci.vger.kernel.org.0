Return-Path: <linux-pci+bounces-45180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893ED3AB27
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 15:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9595A3007939
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 14:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B19374180;
	Mon, 19 Jan 2026 14:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="oijIVXgQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ECB9361DD9
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 14:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831433; cv=none; b=D7ge6Ys+7ziQV33GDSDcunKgfgdDGZgt8iKhe5+3SZf9hv88gzVp/1PRpcPlDhMgN1k4R9pJ34AK5heCpMojG6/J/X8M3GaiI0OFXFSBvdR1w+2ZSLKEzjuWpwRBhHbX6kG05vVc0kktnWTBehqgqv9TrlNUrKoGJrBchLeMkoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831433; c=relaxed/simple;
	bh=mTAE+Uz1BGS1b5G0yeV0TYVfbfqnRu+U7F6kK79xBH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h19swCfx9Jnd1zgIuccdWyyPy1kxcMbb3BHywUHPUUPjj9EUnSi+TLdHUUmqPKt0xxmbnTHb+9D+GejGrarMLvMvHEOrRYcVvtjFng3hajXoI/ZFWQ3n/MCmi5lxQOAbBjmpbREiP8GlZI4Sk1bTPX/kuCsnepGytpYVhXIf92o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=oijIVXgQ; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47f3b7ef761so23296565e9.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 06:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768831429; x=1769436229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qi0fMsnbGNNAqeW2KXFtzgi15jKwvRfrQtKC+NHQLH0=;
        b=oijIVXgQ4xqiS2NrmPLq6TR0f50MbnFwamEvVEThd4u5/cgjFxI8Fpocc0jELJE8Un
         wzvavK7XRcjYMvB11KowGsyzSBDjqwkxWPYeBGg3vb6zoCSfcvuvxqk4VvVngzLEblPe
         Q62S41vvzGwYYP/wqJlp2PvMr6Uq10aOT4gO+2lj39uGKOsACT3+oBnNPeH9aB+gErew
         6Km1zv/o/EhoBpzf+u273glZp17hZLZB+jjPOy/FEz2+x3P5WMpUaeehYmsWAK1SxkmZ
         YTV1PyclP+6opjHTt9Y/AsH4McuFDDSi78LsqpYdLxP6EuyYphQB1hlB245BmCzbm8zu
         gXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831429; x=1769436229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qi0fMsnbGNNAqeW2KXFtzgi15jKwvRfrQtKC+NHQLH0=;
        b=dfn59xjbCaSCGyMx9nxcazAI0s0ez5OKCJsTXTYLwbMfqvK26GBhL9bA2b3zEEnZDQ
         NBQ+ZZPydHFQz8mHfnAjT0dJGxN66BxgsJYWzP3WyI8idMJVEEyJcg2OAAUwX48/XqAG
         M7BHQRmLd9xu8klZ86I+gcxRTIIksBKa4rc0+lF3dzUeKiBwhvavD4g7ZUtUEstKchuZ
         q5xE4GPFrzV2GUhtDtdPIGq4I6Hu7qpbPxXih3OdXHjypI14pX8yxTdJTkMnv+2GvRra
         BimXfuiQtgg2U0XNhTtFdHRhxuaFX1wH7u+LniBBPG58YfeIho+gagrJ6KGO2h3fUijj
         Zwvg==
X-Forwarded-Encrypted: i=1; AJvYcCX5ADAzvDVB7skT6GGoZvwd6ClUcvrbAfnWklEEPUACOB2CNuucsgzhqiVOG6jSiqzRMfyRr0I5FHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyV1BSn/DTPDul50L8kiU7U6E+hqhNc+h1mfuBlRYstTTtGPviy
	WuuvjFC8WnXviNiEb2ZmNiMyoz4J/sdW/nyuPJbj5Cxtx4ncG+U90ddbGKtMH0j9R98=
X-Gm-Gg: AY/fxX76w4ZIDCcvqndkjnOoG8yr/SO0m/HHFQ7K3z2GL9fPzVIm5Xjq/vJkMxW3Uae
	YitZFbNkBnRz0lc38xL4QfaeA7wrZNOyqKtCFqoRgv6w/JMLgQ3gOsnhLgNOgdDh4me+pVMPSut
	oeppOl3slk7RugY6eRHyuRYwhf81eZ/soqQnW5OekKVTULU1325hGYx3AQx09xYtiSxVt4eebpq
	lA1dA9dCmYQ+uNun1VsH3EaLdykeMAqmtiz197aYXZ+WS78xQZM8HqQBwyOQ4kjc6Qcsy6zULPX
	HnLlDSjcOynVFZ58dP4qfoW4ue260qJO1ZMOmd8HSM8Kc0mz8gjrvBFPyvZgHBUrmEu/doh0B8V
	wFtnEXB8UpRN/sLOwULtpRD/FIxfJ93rJElm5fuGTRhICL/vNrllwpQLdEj4s2/i/YtKtpxSJyR
	niVItz5pQ00wH99+ZZsw==
X-Received: by 2002:a05:600c:c48e:b0:47e:e970:b4e4 with SMTP id 5b1f17b1804b1-4801e3494b7mr155374755e9.29.1768831428511;
        Mon, 19 Jan 2026 06:03:48 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f3b7a5f94sm266035795e9.0.2026.01.19.06.03.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 06:03:47 -0800 (PST)
Message-ID: <fb7ec096-372b-48f4-b6ed-e224a05d55e2@tuxon.dev>
Date: Mon, 19 Jan 2026 16:03:45 +0200
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
controller driver". With that addressed:

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

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


