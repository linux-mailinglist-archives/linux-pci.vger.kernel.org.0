Return-Path: <linux-pci+bounces-22941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 505B8A4F6BD
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E28716F0D8
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467511D2F42;
	Wed,  5 Mar 2025 05:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YowY+Wsx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B584C43AB7
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 05:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154262; cv=none; b=HyCLT0e5dRg6oAxoMHr6Db0UuX6GFVNyiomegvDHDq8OJhgIb2QeN0vUq8Xa0QwZAahUQipPKDAESvhBkl/A/aA63Bp0hP3Bf82XUjMVHitWoOuzcqZynmRNIY9M9mTOdQIbh6Or9Q5bvdLXlgjKIIgC6RzBlg3JX1qTVwz/DiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154262; c=relaxed/simple;
	bh=hFeYMdWnSHtiWE5MQ5BSTvT73z2i7ZQZW1B6NLx7FPM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PMUDMzVF/sHrgCpIRGSJ8bXPeCqa/ill+/hcgP+eCYCzObCYqqGfCpAK8kqgrWRdev/ZrnLGzgmI35hrZoF4Y7IGbFPltNbeKl4/4BXr/9NGCL3k6PHABZukBR4TIkvT6PPtMlBQRN3BWjgrzEw0XmKn+ci9IzUVtfWhX6IjYZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YowY+Wsx; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2239aa5da08so56516525ad.3
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 21:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741154260; x=1741759060; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=DOwzzYJQOdG0WI0rLxpfa0qjcc3zCe9/VPVDSgNZPbU=;
        b=YowY+WsxvqcH2KIG9pNMII/jTlgDdpCFtC7qTH02cIripdu1L0V3814baLEGv101QH
         m2O3TwwjO4gyYsQWm6DLBMDuLZe1bQirKrPlE2hkClvRi+vJOxipoH8YnJGBvE0D7JVt
         DND8njYbOSuAiNrZs3/DCsq54Y/F9KSZZkLcJaMMtluGBvBNt7nuYgG5dB8fRzp6LJ8D
         3WQNb9PHbeE1+EQgsxBjmlMgwKmZuIRZebfB1ZY1Teq76rqY/UaH+yu7C4aJ4Zv4yclp
         74G/8Rdmyb1I4BBM8CwBzfOHwdRFQX69+O4z/qP8tm8kq/qqZcHRi9SFxsTKrwVOUcik
         730A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154260; x=1741759060;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DOwzzYJQOdG0WI0rLxpfa0qjcc3zCe9/VPVDSgNZPbU=;
        b=pZkQ8VA7nK2F/mV/DbmBbwhVbx19To0Hx40dL7VqCVeB/wiim3kLrhePyOpvhVEQc0
         FK99D7OR9Y+0lBzGmE5GIQt/jyRoyA0EIJio+Y3qSQJBOmfUBEEWeQTgZbXQOPq6FPo/
         Hvru09qhy0dkdpnxrxnUvrYpiJKpwnUFTfe+A2U4PNAolf2ywLiIy6PZIKSQz3wMkuf6
         28hw0JiITaR1x++5vouje3TlTjZuQ9O7Ta9PnUM3ny7S4Rn94aYpugNspSpCwIKVVt8g
         Q+rs/3PY9kXi/G4XipjOXdzWJEoOm0hI1V5hAQnuhmMWQlvRAHjjxQDglhFPn+9G31aB
         lSCg==
X-Forwarded-Encrypted: i=1; AJvYcCWZaBaZW7iPvpneNMzQttn/B/z3ZzpEpExCaCb/qvm0vUNs+s511UChdwOh/HYJxWS/spsCaSPOQvg=@vger.kernel.org
X-Gm-Message-State: AOJu0YytSawoYqGn4mdcWtGhoRi1G+h9GevdnNqLQgcj19zpzqcXpXpV
	J908XuKDjB7KSWjMf0LuYb/PU1tqDhPZb1ELeHReVOmVw7LQwnTzPAdYE/U+lg==
X-Gm-Gg: ASbGncvRtrHJqVlUbxcp27slsBzfxTudVkq6ifthsPzKG0n/cTl7W1ovolDbOIJ/oYF
	BDjdebiz3HaPV0uR15IRWtHmJp4XbUM/L9gi6U11W7HV33BSvlLF+Xa/eR4crpREqFlIZylyoG/
	PAy6CJoQpzstLMLSH6g+3V5d6VCJM4VnIoQI7AnICR51X+sUitaEWczJpIa76acnLgK6RtQFtuo
	neItG67+76LdIzxApv62KceD4LkGmC0+IztZR+gDAJQ6rY0qoHp1ZueV6PA0LXT+XXBrjqQnOy/
	nyQKjQGbNXqoGrmj91fNsuKb5oZhtvtlGYifckQ3H/py+TxBmV77Ga0Z
X-Google-Smtp-Source: AGHT+IHJ+E7cxLp3UL1E2lM9yka+FDKJffqchLvQqu50BLnEcbW5jPX5uSliRc3msTubI0hA63bDNA==
X-Received: by 2002:a05:6a00:cc7:b0:736:5725:59b4 with SMTP id d2e1a72fcca58-73682b5a0b6mr3190684b3a.3.1741154259844;
        Tue, 04 Mar 2025 21:57:39 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-736290957f1sm9578841b3a.67.2025.03.04.21.57.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:57:39 -0800 (PST)
Date: Wed, 5 Mar 2025 11:27:32 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com,
	Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v3 5/6] PCI: apple: Use helper function
 for_each_child_of_node_scoped()
Message-ID: <20250305055732.l72uqohsdq5x57xm@thinkpad>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-6-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831040413.126417-6-zhangzekun11@huawei.com>

On Sat, Aug 31, 2024 at 12:04:12PM +0800, Zhang Zekun wrote:
> for_each_child_of_node_scoped() provides a scope-based cleanup
> functionality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the
> use of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2: Fix spelling error in commit message.
> 
>  drivers/pci/controller/pcie-apple.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-apple.c b/drivers/pci/controller/pcie-apple.c
> index fefab2758a06..f1bd20a64b67 100644
> --- a/drivers/pci/controller/pcie-apple.c
> +++ b/drivers/pci/controller/pcie-apple.c
> @@ -764,7 +764,6 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  {
>  	struct device *dev = cfg->parent;
>  	struct platform_device *platform = to_platform_device(dev);
> -	struct device_node *of_port;
>  	struct apple_pcie *pcie;
>  	int ret;
>  
> @@ -787,11 +786,10 @@ static int apple_pcie_init(struct pci_config_window *cfg)
>  	if (ret)
>  		return ret;
>  
> -	for_each_child_of_node(dev->of_node, of_port) {
> +	for_each_child_of_node_scoped(dev->of_node, of_port) {
>  		ret = apple_pcie_setup_port(pcie, of_port);
>  		if (ret) {
>  			dev_err(pcie->dev, "Port %pOF setup fail: %d\n", of_port, ret);
> -			of_node_put(of_port);
>  			return ret;
>  		}
>  	}
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

