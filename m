Return-Path: <linux-pci+bounces-16623-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DECC89C6ADE
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 09:49:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D204B21ED3
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 08:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7E7185936;
	Wed, 13 Nov 2024 08:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mZUDjZ3A"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751E188706;
	Wed, 13 Nov 2024 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731487758; cv=none; b=LpgyFjZ8j4AJALqbmX9cTr/yRB8Z5xS4DKO0JXGXBb7RQ6Xxtum6nuKmncLkbdN1gYb8zyGlUeX2FMuV8kcKV/huQiEVnt7enO9i5rWwBtDAaDLDmea5dbLfLiVjMKN3hkaPltWU+IHqVcvbz1vfDK/qGxUWK0hnfmlvzhsVwiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731487758; c=relaxed/simple;
	bh=jSmParmBON0VgUFC+Mx/yo9mY1y/AlAIgrDz1AJ5hSw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lwP5B0dILClejkhHaoEpzXsG7YC69JwY2FeY8xwzlz4peJV7WbJbN19vPGyCEn1VlgY1HsL4PxYHRJKmCoRHvc7zkfD5wmPuQvpxGUu1+UDo38lVLG/5eoK2yDgme323PCTGj9t+ZPfm0uVZxNrc5e5lg0chgMXevQmSAsHWVLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mZUDjZ3A; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1731487755;
	bh=jSmParmBON0VgUFC+Mx/yo9mY1y/AlAIgrDz1AJ5hSw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mZUDjZ3AmomdyDvJ4r5PVRRRNhRCKWV6nCFN3WTbLIzKeLbeWAWWrYz2+A+xzwL/3
	 x8hSDVeuxFd0tbMq4TiP9ypb/mmiynaKGX/T5iHSDuHcVoJOCRXm+E8GAsCwfr/izi
	 PhICQ+oMRoklrhxETnUsijNTF/DbJDhIPj0fNXYZT8lLoHN4Cn+oucd8U/I7TC7kq/
	 D8AvoiD8EsqMtljqGWw5hjymtHAgKf4ezFM9vAYZkZHD/e0ba44cMVKxGcfdkI2IAC
	 eewotvWbtWFvuJqBUJ4OHMOWVAhUaj5UdRiUTax6LOrAkicDSyHse7YmhKjlqAXYlf
	 xpZEe041g3kyA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B31E817E1395;
	Wed, 13 Nov 2024 09:49:14 +0100 (CET)
Message-ID: <d5215862-2e46-48d2-9b12-2f59b78e0c59@collabora.com>
Date: Wed, 13 Nov 2024 09:49:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next] PCI: mediatek-gen3: Remove unneeded semicolon
To: Yang Li <yang.lee@linux.alibaba.com>, matthias.bgg@gmail.com, kw@linux.com
Cc: linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Abaci Robot <abaci@linux.alibaba.com>
References: <20241111010935.20208-1-yang.lee@linux.alibaba.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241111010935.20208-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 11/11/24 02:09, Yang Li ha scritto:
> This patch removes an redundant semicolon.
> 
> ./drivers/pci/controller/pcie-mediatek-gen3.c:414:2-3: Unneeded
> semicolon
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=11789
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
>   drivers/pci/controller/pcie-mediatek-gen3.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index f333afb92a21..be52e3a123ab 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -411,7 +411,7 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>   		if (pcie->num_lanes > 1)
>   			val |= FIELD_PREP(PCIE_SETTING_LINK_WIDTH,
>   					  GENMASK(fls(pcie->num_lanes >> 2), 0));
> -	};
> +	}
>   	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>   
>   	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */



