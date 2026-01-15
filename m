Return-Path: <linux-pci+bounces-44941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8A1D24B01
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 14:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 14E1030158EE
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jan 2026 13:13:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4680D39E6DF;
	Thu, 15 Jan 2026 13:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="e8KMlEet"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7C239E6CC
	for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 13:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768482807; cv=none; b=ngJvu4oRarGzQGnx3N38I03hGbZCXffMJQvd1wR1jDF701opzru29G5/h3ymOwJnaCQYq6SFmWXlokT3BOUcAl96uTr7ZLsZIJ2myz16KQGixuwAGtx/KplXbAHLQUIWb2sP7I0Zb2Q8k0rN4MiDaqZrgw0kOJ49zDyNSpcm9J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768482807; c=relaxed/simple;
	bh=oGBIY8OHbiaA6AKM7iezNk4OT2UqUM41E+jU3AXFh04=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XLouGyyHFUmG/aKxKRbNZ5m87iW5oavUh4P6B7lxw0VNgbOIQZSrF7hyOeQVffw6fLQwrM4H0lC/hNW3MfcFq3ZLJHxiXh+ySmNR8NPayEYiRbIJPtd99Xda11codfrEkOEeUEHQ7kjE9IZpVmGubOE3rSh8j90uhgtw+26xLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=e8KMlEet; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b87693c981fso172473366b.1
        for <linux-pci@vger.kernel.org>; Thu, 15 Jan 2026 05:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768482803; x=1769087603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OcKT38A0UUvdoSzqayVq/UaeSYTimcTVzwN0DmjbeBE=;
        b=e8KMlEetorsdjlDu4nCOoTy3aocLVWJp4SGBuk7cPT/nyqbs17/jVUSlljjAcH0029
         YjJoNxfiJo5dWfbNVhiiFRZDoPxNpNAe4olDxz1YnU84kktRng7PUK+VuLwzBWrmrgMv
         Pm/GaxLWAJN4ulMJAvrmwnpg2E7P3NQHa0L4IwkeO8THc7G2QGJSgEOVwxWMBy6D3wtF
         RuFbc1t53DtFvVMIAxL/9TM8eTH8nJvXULwWBrWe+87wfngBJ7tvd50bi4gS4z7Qcctn
         SYx+sBMVhLtdc83/I20p+/2zFWwYP8AUCpr9hbFV7QSQyl3gk6i7jjHGKFvko6GrY0Ge
         8Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768482803; x=1769087603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OcKT38A0UUvdoSzqayVq/UaeSYTimcTVzwN0DmjbeBE=;
        b=q+OXZ8/YHOOyJy9kpai/KCoomt8T6tLP/aqBEUX3I4iQ5Wfo1DYAnVAh4ggEAvs3Vv
         z7HZziLSa5lo5fnBs9nG5rQ8THt6v5u+SqUEtyB3XZAjNY0uZDQQ9Lc0rglIl2HfNBOR
         NoObBA6zRiEMURq25J5lo8v1Mt3MgAv3Ek0AHj6WiUh1Ff3mlIKyf3vKWEw9wxa6OcQ0
         Zesu270jN3N0K908WK+y0b/dt5OxHS2qw4HRotoLuyIUSMpFJl+bVJ+2/r6XYj6iTnEk
         JqJ2wgqNZ79rKBY6E7V032JVveod0wk7hz6XVJT9Hqq4K1sLzIFazkce5ofz62btUWq8
         vY/A==
X-Forwarded-Encrypted: i=1; AJvYcCUvyUKLwetN6PQvWGYu1OYYnTpQmTFaLelivLNhqOegAisbdDNSgiwfr3jhfoCwgbimRZ4s7eSbjUE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxop2SYO5XBZd+5Cxi/yFtVsaXyjRIHxN32Wtbg+qb9C3Ddeyh6
	GGkcJ9s805F8S82UfavqcwXoBIcOA2WKs/w1xqDvcyVt/djor2yupsvLeJg86SHKumc=
X-Gm-Gg: AY/fxX6ggnaT7og3bCIM1z91oJWFKST11hetF5NJDP2xZMK9/gU+REVIs5RGsFACm2+
	iOpFmXjvTxO1tL/F0MJP+nDaupDP9w377v8Qs2G39VPEh/x8l0S4EOOvlefm6y/HLA6JhwkQ6jP
	uEGTcCZeBbt8T8QoPJXhvHHZ+jifZ2Y1WwyFDhDZ08PGH8yYjV4lDanGin9xbFJkmAdbo9b9kqy
	bPl60RN/FfsBA64RxPEziN6HsAV0U13MVm1LT+DgVKkX/ye0oSGl2kDrDT/NCsm4rbqrVW/unVm
	5JiXNJ9rYWryYELN4h8JRrrMKXav0qUYwNc8IlBtlFW6Lp+kiMszJPwyGGR2bDbIwmnNeab3zrQ
	VRtaV5fDNXAdOQbNglhizo8puPrredAhLb0z9wMvJWjz0o2MhIkGTjNXhZ9UOoY9GitX9gYH07v
	//Z8UBDKqFSz3NfkgtRG+sJXEjjT27lA==
X-Received: by 2002:a17:907:72c6:b0:b87:5d59:8661 with SMTP id a640c23a62f3a-b87677a7930mr370290966b.42.1768482802627;
        Thu, 15 Jan 2026 05:13:22 -0800 (PST)
Received: from [10.78.104.246] ([46.97.176.64])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-654118772e5sm2534012a12.4.2026.01.15.05.13.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Jan 2026 05:13:21 -0800 (PST)
Message-ID: <2e05a458-b055-44d0-91d5-63091b9eab91@tuxon.dev>
Date: Thu, 15 Jan 2026 15:13:18 +0200
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
From: claudiu beznea <claudiu.beznea@tuxon.dev>
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

This now fits on an 80 chars line, could you please update it like:

	reset_control_bulk_assert(host->data->num_cfg_resets, host->cfg_resets);

Thank you,
Claudiu

