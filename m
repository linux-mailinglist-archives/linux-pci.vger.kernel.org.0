Return-Path: <linux-pci+bounces-14926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7AD9A541C
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 14:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EFB71F22352
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 12:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100B119259B;
	Sun, 20 Oct 2024 12:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Ie1r24x0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-27.smtpout.orange.fr [80.12.242.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D522DEAF1;
	Sun, 20 Oct 2024 12:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.27
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729428712; cv=none; b=MzOJc3uPPb4WDGvYaryT0/+sZC2lp/RjkhTcR92h/4Xbm9iJYfd0z3muuzczIWTU9ctMUw0WDkfFXc/LDAmePzNAfIEgW1wFc/SYOd+RXv6wCI+gAzdIc7jCiT58f8xj8J6kT8fpkvl1xd4xGCuenAcRtqOYGtxvkfu6cnmuBHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729428712; c=relaxed/simple;
	bh=JKADh7kj1lQp1aoQuZiY6EwB94qTgxyXD3rmimFM6SU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hNBwduZfAbtxu6IhfMbbuM0DxCRsoZfUdDSg6WjAH+zJtQxC7CQayebYoM7Fv7ogQ0DzuroWB8kGr+DYC9twwuglxTXO/vGhFhrz2AWgZTC9Cd/YawicLgTDhNB0VIfckCt3YiwCUSFdR4MP8/Q1R3VIx69zX3JW4kTG0I64hBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Ie1r24x0; arc=none smtp.client-ip=80.12.242.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id 2QHmtx47CqSl42QHmtsEdU; Sun, 20 Oct 2024 09:23:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1729409020;
	bh=TMmAAHQKed3UL+28kOhhlB2nfADOlaN6TyUGoxjD1dQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Ie1r24x01qWEkuD/Qx0FQAQSKlXSuVZw8nrURubilzSq6qoeJbvFDsMEYUkdFxHL3
	 yoDJbP2i+9JAcdEJ65msWctHUlW264cTvB/qtOtqQm8Sy5NB3MPIk2Lkes5TmAwtrR
	 t6cFlSMeW72ir7hedjuCZd8ciIK6n+8FNQBu6QkLS2rpVmvPAzJ5GjqbJJWMOdFR+L
	 FNEKvhFVKt4xzTe08tBjCFJ2dGk7r75hwhWUg+QHrB+rnCEg672swd84R+iOcy9rS1
	 9iB2JcUcHcYt9Gt3UVZZAhRaDQvNxIZeZ/HJO/Qqo1EMXOzUUg7tMc/v2y6m8ptHW9
	 auryByRv/vB/A==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sun, 20 Oct 2024 09:23:40 +0200
X-ME-IP: 90.11.132.44
Message-ID: <5e828a43-9365-4ac5-b411-0be7188ab8f2@wanadoo.fr>
Date: Sun, 20 Oct 2024 09:23:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] phy: core: Add missing of_node_put() in
 of_phy_provider_lookup()
To: Zijun Hu <zijun_hu@icloud.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Felipe Balbi <balbi@ti.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Lee Jones <lee@kernel.org>
Cc: stable@vger.kernel.org, linux-phy@lists.infradead.org,
 netdev@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20241020-phy_core_fix-v1-0-078062f7da71@quicinc.com>
 <20241020-phy_core_fix-v1-5-078062f7da71@quicinc.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20241020-phy_core_fix-v1-5-078062f7da71@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/10/2024 à 07:27, Zijun Hu a écrit :
> From: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> The for_each_child_of_node() macro automatically decrements the child
> refcount at the end of every iteration. On early exits, of_node_put()
> must be used to manually decrement the refcount and avoid memory leaks.
> 
> The macro called by of_phy_provider_lookup() has such early exit, but
> it does not call of_node_put() before early exit.
> 
> Fixed by adding missing of_node_put() in of_phy_provider_lookup().
> 
> Fixes: 2a4c37016ca9 ("phy: core: Fix of_phy_provider_lookup to return PHY provider for sub node")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> 
> ---
> The impact of this change is wide since of_phy_provider_lookup()
> is indirectly called by APIs phy_get(), of_phy_get(), and
> devm_of_phy_get_by_index().
> 
> The following kernel mainline commit has similar fix:
> Commit: b337cc3ce475 ("backlight: lm3509_bl: Fix early returns in for_each_child_of_node()")
> ---
>   drivers/phy/phy-core.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/phy/phy-core.c b/drivers/phy/phy-core.c
> index 967878b78797..24bd619a33dd 100644
> --- a/drivers/phy/phy-core.c
> +++ b/drivers/phy/phy-core.c
> @@ -143,10 +143,11 @@ static struct phy_provider *of_phy_provider_lookup(struct device_node *node)
>   	list_for_each_entry(phy_provider, &phy_provider_list, list) {
>   		if (phy_provider->dev->of_node == node)
>   			return phy_provider;
> -
>   		for_each_child_of_node(phy_provider->children, child)
> -			if (child == node)
> +			if (child == node) {
> +				of_node_put(child);
>   				return phy_provider;
> +			}

Hi,

Maybe for_each_child_of_node_scoped() to slightly simplify things at the 
same time?

>   	}
>   
>   	return ERR_PTR(-EPROBE_DEFER);
> 


