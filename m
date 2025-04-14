Return-Path: <linux-pci+bounces-25769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D95EDA8759F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 03:58:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32B06188F758
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 01:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40BD33FD;
	Mon, 14 Apr 2025 01:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="E+vyk1Dc"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F572BCF5
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 01:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744595935; cv=none; b=NkIqZn2FjLjU7J8/RPiOGhgDYlgpHDvATMNvUeAaziDn9jM3hzwRjSorPzjagsVJmjGd3rKeaFDERuaUh0BE+wxxKiFaHNl92wbYCTPmXtghrwnAgNp+Utj2CMO2xpJI4yQMWMZ3/uUiS13txR0Xl89IbGTLSAicgq7a1GhYtlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744595935; c=relaxed/simple;
	bh=VIgGkrtao18zGKUD0sqT+S1db/n4PWwVwn579HCZwfo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pSBmwtk2vQviGd0qwO/qGtcnaSlfwm8nVG6GmhdN/LiO/xpS5UG6ecdCBk8FYwj/ktii6nYkr6b7f4I1O7B0XexRbOUmqf14Jot+MR42WuPd8VR8CF3fEaZSqZPCfwe0FDbdZek7nQEWoDbeLnpZfvj6BKMq78J/+yOaVZk4Aio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=E+vyk1Dc; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=IknIofkYAPPnaT4jxsRbA6Ab4/BzxkAm5YE9R71Rekc=;
	b=E+vyk1DcodOe6+vPnkSVb5ufFok5sHQbXz6RS5q5DibIlaaJewl0mcwGVZ3xe3
	Ht+eO5lm9opMLoIJhifew5L0iL1UX84Om7NhUMJ7THH47ccr88Mkr6b5s1cc4Hfj
	+o2Y/M6IDxUJE3ubW0qH+kpEBUCqIbkmIhHXuBUo/Dolg=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wAH4xmqa_xnYhZIGA--.539S2;
	Mon, 14 Apr 2025 09:58:04 +0800 (CST)
Message-ID: <d5ab2b1e-576a-43c0-b3be-b3fb9753498b@163.com>
Date: Mon, 14 Apr 2025 09:58:01 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] PCI: dw-rockchip: Move
 rockchip_pcie_ep_hide_broken_ats_cap_rk3588() to .init()
To: Shawn Lin <shawn.lin@rock-chips.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org
References: <1744594051-209255-1-git-send-email-shawn.lin@rock-chips.com>
 <1744594109-209312-1-git-send-email-shawn.lin@rock-chips.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <1744594109-209312-1-git-send-email-shawn.lin@rock-chips.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wAH4xmqa_xnYhZIGA--.539S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1Dtr1fXw1DJr4xXFW5KFg_yoW8Ar17p3
	yUZryjyF4rWr4SganrAFZxZryqyFn0kFWUJ3s7Ka4IvFnF9w15t3WUKr93try7trWjvFy5
	Cw1Ut348WF43CFUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRWmh7UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgUuo2f70gbT4AABsI



On 2025/4/14 09:28, Shawn Lin wrote:
> Iif there is a core reset, _init() is called again, but _pre_init() is
> not.
> 

Hi Shawn,

Iif ---> If  ?  The spelling is wrong.

Best regards,
Hans

> Suggested-by: Niklas Cassel <cassel@kernel.org>
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> ---
> 
> Changes in v3: None
> Changes in v2: None
> 
>   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 7 +------
>   1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 922aff0..b45af18 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -278,17 +278,13 @@ static void rockchip_pcie_ep_hide_broken_ats_cap_rk3588(struct dw_pcie_ep *ep)
>   		dev_err(dev, "failed to hide ATS capability\n");
>   }
>   
> -static void rockchip_pcie_ep_pre_init(struct dw_pcie_ep *ep)
> -{
> -	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
> -}
> -
>   static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>   {
>   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>   	enum pci_barno bar;
>   
>   	rockchip_pcie_enable_l0s(pci);
> +	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>   
>   	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
>   		dw_pcie_ep_reset_bar(pci, bar);
> @@ -359,7 +355,6 @@ rockchip_pcie_get_features(struct dw_pcie_ep *ep)
>   
>   static const struct dw_pcie_ep_ops rockchip_pcie_ep_ops = {
>   	.init = rockchip_pcie_ep_init,
> -	.pre_init = rockchip_pcie_ep_pre_init,
>   	.raise_irq = rockchip_pcie_raise_irq,
>   	.get_features = rockchip_pcie_get_features,
>   };


