Return-Path: <linux-pci+bounces-38561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E42BBEC969
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BDCA4350016
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC84B25A33A;
	Sat, 18 Oct 2025 07:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="qY7iUt1y"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-79.smtpout.orange.fr [80.12.242.79])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F4B223DE7;
	Sat, 18 Oct 2025 07:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760772792; cv=none; b=tWCfqPDx1WeycIfu/YOrZoQHyYUI2rLJXVPuQ7XBoRcWity+0MpLHbH+5j6iukceAu0nLY4RAhJixgrCBx4HOtSWiuWGqN/5iCiuAhtlzqHs8kEyczJpPVNH2hokNRKI3FDW5M1MFH0YQcxJX4WIHiHMWPaXBE2bEKpSAnrX0FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760772792; c=relaxed/simple;
	bh=gKRNo/lGcP3rxqn+Y75RwQzJwMAzEr8utTHHHv66UYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HYkeFyRebLIKDu6oB+7hUSp4Hl/3gY34JO3GhloOyN/2GI0CdHsEuhLwlQWLtJa2GYgP6C55WcmqudlanBa0OB71PP1Gy2Wx5VjkmHaTCpZWrJ4FvV658M01owRIACptF9G7W2aVRPLPqMUsvWasjAQ8GJYUL/40gvdixy1YGUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=qY7iUt1y; arc=none smtp.client-ip=80.12.242.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id A1PxvuM9HzfhZA1PyvV5ig; Sat, 18 Oct 2025 09:31:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1760772718;
	bh=UxcBbJ6YMzfQMi2FRgFj82GAPoH1xTAModlkPdJlf40=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=qY7iUt1y2CTvTLb3/2fqCoqn5G5uKAmuNYUAlc6kswFephljGgpFqAhTzm7QInsGH
	 cVNWGk/45kwoeB38Ydnh8vU2KjBVaR5zJIiyCuSPFylTwv/mNaYiLlYvYQQvoOzY/h
	 RVsTPCpX+LRntK3PbT2Xdjlccg5LUykxiUGHWXxnsDw+fPdFjwDg6dsaqDQOCJHAAE
	 +JAzH4q7WLjGPFKhQk5t8Mzvnu2IO/bsRpyXwwm4JCjs2WtWK8wthVwcZQlNWip3o2
	 VuUi7ramC1n7RbCRlGPjl3NUE6lbm4NXkIiCxwLEaBa9FbBSUrXO/OxATN1noC8J+d
	 pGC4dludAo25g==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 18 Oct 2025 09:31:58 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <7b153f5f-fbec-4434-8d07-155b0f1161b3@wanadoo.fr>
Date: Sat, 18 Oct 2025 09:31:57 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] PCI/pwrctrl: Propagate dev_err_probe return value
To: Anand Moon <linux.amoon@gmail.com>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Bjorn Helgaas <bhelgaas@google.com>,
 "open list:PCI POWER CONTROL" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20251018070221.7872-1-linux.amoon@gmail.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20251018070221.7872-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/10/2025 à 09:02, Anand Moon a écrit :
> Ensure that the return value from dev_err_probe() is consistently assigned
> back to return in all error paths within pci_pwrctrl_slot_probe()
> function. This ensures the original error code are propagation for
> debugging.
> 
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
>   drivers/pci/pwrctrl/slot.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/pwrctrl/slot.c b/drivers/pci/pwrctrl/slot.c
> index 3320494b62d89..36a6282fd222d 100644
> --- a/drivers/pci/pwrctrl/slot.c
> +++ b/drivers/pci/pwrctrl/slot.c
> @@ -41,14 +41,13 @@ static int pci_pwrctrl_slot_probe(struct platform_device *pdev)
>   	ret = of_regulator_bulk_get_all(dev, dev_of_node(dev),
>   					&slot->supplies);
>   	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to get slot regulators\n");
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to get slot regulators\n");
>   	}

Extra {} are now unneeded.

>   
>   	slot->num_supplies = ret;
>   	ret = regulator_bulk_enable(slot->num_supplies, slot->supplies);
>   	if (ret < 0) {
> -		dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
> +		ret = dev_err_probe(dev, ret, "Failed to enable slot regulators\n");
>   		regulator_bulk_free(slot->num_supplies, slot->supplies);
>   		return ret;

Doing:
    		regulator_bulk_free(slot->num_supplies, slot->supplies);
    		return dev_err_probe(dev, ret, "Failed to enable slot regulators\n");

Would be more consistent.

CJ


>   	}
> 
> base-commit: f406055cb18c6e299c4a783fc1effeb16be41803


