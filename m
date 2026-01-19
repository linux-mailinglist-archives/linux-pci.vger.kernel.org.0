Return-Path: <linux-pci+bounces-45201-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A55D3B54E
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 19:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BE19730161DD
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2F032ED2C;
	Mon, 19 Jan 2026 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="H/Pe/VtB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6F932E13E
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 18:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846489; cv=none; b=UpxlSvXVnqa7dE7gUPhn+eI9Jm0syvhRmi/Heol/es3gkHjQa/hoRSGhFp6ZhKZHFDSNUx+/7nX5oxETw1M12qfGM5GVfWcOLDnYPdtHYtwNy8Og7Gg8FE3oMOhR3lFmxP2H3JDYrei5WJiUkczPw9rR2T9LCgwwxO6qV68lO6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846489; c=relaxed/simple;
	bh=R62ip0d3Ah3ZHGBbnwwq68SBTIiq4tgpDhhAOV/4tbs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t4lNFmW4zpdufuBB6or+a+P1b2l9qaCvlETsD0oukJqOrlX0hZShQQzJVk64V9fphUkjMGcs/t4r5tR3PvdAsK007huIP0Na3itxmetXA/CoStkN3emNaIAjkJ1GkWTBI1mSRGnBdXqhUJ4sLiCR7CaCArTqbRekUVqlR7pysLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=H/Pe/VtB; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-b8715a4d9fdso617443966b.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 10:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768846486; x=1769451286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bQtPqL0gQRVYb0zOyJRISSCzXN2uXU8LTr7YiBj/NpQ=;
        b=H/Pe/VtBpF9Z6wR02RTuE6UXOO7wTYwFQdENmATU+QCEpgRhAcz8WZaiKPtLlAdGpP
         jD2jDM7sOJk9fT1i7hYYmb23e9gHpSC2P6l3+MvBFo0MnyhQxvOb23cVvkltS4h9BQYw
         InMyYZkXUsj4c2H7pvNoPG+PsOcPLkoqaWikr5Bi4po1B3NYJMFduuW+jgSuIfUL+ctb
         pHnvySsoLhSeU3Rdu7KDzxz7xwx9pD95ck3KHNW4YSA1zg2+3w47Sr2ULAQT08KSCl84
         XyE7zd7W7KoOagLqOYdq8lGoHapMZA9c8yyTbwF3stzSGlFlhcqlmEP2ZqxuAYQV+daI
         iWKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768846486; x=1769451286;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQtPqL0gQRVYb0zOyJRISSCzXN2uXU8LTr7YiBj/NpQ=;
        b=NpIUpfL79ftpF1+DIm8JhXz7btAijI9kcfGLiAYQDtphQL+mKsje9wS+Azwz399Afl
         1gAdvXJm3SFfFvOSNhj7rVLugTsZ31vNZ20SXGgwRcQr6vv4eRsux62JVjoo5YWKuGsa
         uDFabxUcS2yChP2DWRXNuXFo0vseh1192C6Akc/2qVVixSkXtYS1cmgzUgn+pgxPtfEW
         pT0OGuNgE+sppQhdwpchIaAB8UOiw6oPzO+nxFCHD1xeOsHvXRnosMJTIvURbQvedQkt
         moxpoVyvMcCuDouz1tAR33pgS/o4aGQoDB96Y9vMcDoejZFdnuYOdg/d4CjQi6t0e+2+
         eg8A==
X-Forwarded-Encrypted: i=1; AJvYcCVTbnrABREK7hYLKFww+xDvfbj9I1EwvE1AeOddPDutRuq8zGuRg+5gEqzIkAlnv+k9nrc87HDKib0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMwzwo1UPN73F2VOBcqdOhFQLSxXYy4ym3tgsbkKn/JnXjk3mg
	Vc/iE/cBDK3nJ6x91ZqBaddx/oi3x2ZY//5+Mav/B0RnvxzDTpSyvOdpdR130j+fzQg=
X-Gm-Gg: AY/fxX4kUA40V+t8b28as+l2rzXgJuVMm4ww+Hu9qrKX1WbQV9RRgf/2Vg091H96HO1
	3Qv8IJHyy915cQQk+pHK0bnetNSFxumPBmetIQTSx6MDpfmPjxhOF+IlGYBZxCDzaH0/RfdVK6d
	NRzVK5aLFgUWflZpDingdfJtBI5dwnkFo4N3TIfTiKfYxFEj/JZbCuPi79weXYHC2xpY0T2E5zl
	NaQwHUqI+Zn3BpiEJFYauXc71Ku+Gw8vpDYqLTuR4jvy2paZl/SGoi/0szcprG5v95aRO+gWD5G
	6x7huDwm0RvL0GYkVm5NWd0NkESq64+8fS883k+HI3cutQtyBLOiwPjyYgS4oFhk1m8UeceNN2g
	x9jvM/LWBWb/l5BV+tuB874FwBpG1Hgk6eqqHqBG8eM3wacxOLn29DdXkz+awKr0gUU2wGhtSYz
	Lz0lxAWMmLAWyissG0yg==
X-Received: by 2002:a17:907:3da8:b0:b77:1a42:d5c0 with SMTP id a640c23a62f3a-b8796b3ed8cmr936424266b.43.1768846486170;
        Mon, 19 Jan 2026 10:14:46 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-65452cdb01csm10834235a12.8.2026.01.19.10.14.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 10:14:45 -0800 (PST)
Message-ID: <724052ab-6222-4a5b-b504-334dd59a876b@tuxon.dev>
Date: Mon, 19 Jan 2026 20:14:43 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] PCI: rzg3s-host: Make configuration reset lines
 optional
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-8-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260114153337.46765-8-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/14/26 17:33, John Madieu wrote:
> Some SoC variants such as RZ/G3E handles configuration reset control
> through PCIe AXI registers instead of dedicated reset lines. Make cfg_resets
> optional by using devm_reset_control_bulk_get_optional_exclusive() to allow
> SoCs to use alternative or complementaty reset control mechanisms.
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index 44728771afa3..fcedccadecf6 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -1161,9 +1161,9 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
>   	if (ret)
>   		return ret;
>   
> -	return devm_reset_control_bulk_get_exclusive(host->dev,
> -						     data->num_cfg_resets,
> -						     host->cfg_resets);
> +	return devm_reset_control_bulk_get_optional_exclusive(host->dev,
> +							      data->num_cfg_resets,
> +							      host->cfg_resets);
>   }
>   
>   static int rzg3s_pcie_host_parse_port(struct rzg3s_pcie_host *host)


