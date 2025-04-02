Return-Path: <linux-pci+bounces-25119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCE3A788E7
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:38:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 467703AFB69
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1E0231A3F;
	Wed,  2 Apr 2025 07:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MhCfL9zQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45E0D232369
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743579529; cv=none; b=fgBJ6Bw7O3ZJLkeT2qYa13KeozJQYsloh5v1zD/gQiMoH4OeP2UX/idtaCGhSAHmZqwqx/p+F7sIGhIKjoNkcqnwNHaZslslFzNUmVNXWWn1Nfc6qh5cl5upYyx5lQ4uAKrHRl3VPmx/a476RpJPSmElpsbibb2H7pZHn8LCObA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743579529; c=relaxed/simple;
	bh=vnhfJ2+1mUkjQGwU3P5cLjHDx77RdYs7dlstrf2nlrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lQnhamBFrjfQxz6LeDxfzVkP2c1WJ8KdVIOVze/jZysQf3dz3TUIJFhQ/D0ZnVITm3z8Eo4DripKp51X84zieNSWfwozIXPY3r8Nn3WJXjJkeg8K2gSFWERBEGZAYVaGU7qtXTZK19ceYHhLvfwdwVqw2JWjgnBrFjntSIMfX6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MhCfL9zQ; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-30332dfc821so9192292a91.3
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:38:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743579526; x=1744184326; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vuhVsWURTGQqLbCa+ZsvE6k2JhaWqwZQfokIeNuPVSA=;
        b=MhCfL9zQfhaVHeD8nErAIzBvEaT44gtMcvIJ7Szt9uC4x9ttkY3042aPNBSev2pZDM
         4EV+8ammYy4YtTf0Lo73bhoENlMuhYXETLaLkYFOUCGvpAWTghDxs1WbkUoOBGJ8PjIR
         utpmAAt8VfqdTEnTD2o79IUwhdhkVR1Z8tHihCBSiY9oqdlXblumrvGnut1SFXXWujJX
         gmf6R2pntGM9ESzji9rMfYAsmtwg6Fht7L/DCTR6HR5gKgbGEPmAGhs2iaXFY4tmXgH1
         5ShMWUjbGF493Ib17yfI+HDsdKUrgMLsUuJl5XjYYfZL+MKnKwxZpHee8WqXbiIKzscq
         t3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743579526; x=1744184326;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vuhVsWURTGQqLbCa+ZsvE6k2JhaWqwZQfokIeNuPVSA=;
        b=WZV8YFEplGvk6LgDKHqQ7kq7bZjf3H8Iby2KifhmlQJVuypVsU+xX6Q6LdWBG4vH7l
         W1JWh+DYyD3dvnf86geeD0uFM2eK9IFVL886k8EuZIe4luXoKTEHT7werrr5ef2oPUJK
         slx2F0I9WCsnVuqP5xgcF4dvVxQgEdYC2qtjVYhXsRXEKesXbNClPjoPWxdMEGLkURB8
         ICijPdFwSEZknxBBX3P3bA6ihPdjQg4uomxkcX88t9vHpJ3QjaPBNhPaFhKybNaCySl7
         b0x0ZxtVkZgqbkvKCBQHwLlbp3E905EVmZaAu7/L3WxQ+ycS09xvysUrOMFguF5eRxwj
         7lmA==
X-Gm-Message-State: AOJu0YxXCiIwosjwjrRUZtXBGaGdwkOL3GPJa9bX32Bsyiwr4dmiQRsI
	9QjO4vr0lXKv3d7sdl0DrXpyrcZ23IhIamlE5sVpCuaaVINf8N8coG+KW3FveQ==
X-Gm-Gg: ASbGncsae8Eu/0v4iKK65LIK8SJfc5wHfIR10nSS5IlgFjXaf0khsdrr1i23RBT95/8
	BbN+wmUMQhMohUfwzj0UA0RByH3fNLP6ughT9qeTM/g9fjVCNgpOJ+ZiJj4nZU0WfKYxqBFBUxC
	hgRNeDXk3G/Q6G2y/A9cDwiD0EPLuHQKWwKiv0+dzBoj3+tp7vGQ3m6DFH/AiI0tcXto/Xog/yz
	VYopzaE3FsHc7G97f7h13W/ijt+9tDenvOFoH0x5WcvZn1v53HDuxO78HelonUic/vmpM6wf8aJ
	jXCEa/ZH3u0EIsO8JRJPoB4lYva3XgRCwigPjdQrbf/6rXPowCgeF+sA
X-Google-Smtp-Source: AGHT+IF/7JLOnTBt7sTuUCzKIzyp13ILW7ME93j7xy76GBcFDkBNPwoJUw6bHXzPuMt5qY2XMOErwg==
X-Received: by 2002:a17:90b:33cb:b0:2ff:5e4e:864 with SMTP id 98e67ed59e1d1-3053215db23mr23337578a91.25.1743579526389;
        Wed, 02 Apr 2025 00:38:46 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3056f83c9bcsm875695a91.17.2025.04.02.00.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:38:45 -0700 (PDT)
Date: Wed, 2 Apr 2025 13:08:40 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Mike Looijmans <mike.looijmans@topic.nl>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Michal Simek <michal.simek@amd.com>, 
	Rob Herring <robh@kernel.org>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] pcie-xilinx: Support reset GPIO for PERST#
Message-ID: <mf376dulqqzvyqgdakeglc7ol4r2dmsr4hiafvdwve42qfkauj@vcyuf4k3fbmz>
References: <20250325071832.21229-1-mike.looijmans@topic.nl>
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.f2f40822-7953-4b0b-896f-3a325392c185@emailsignatures365.codetwo.com>
 <20250325071832.21229-3-mike.looijmans@topic.nl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250325071832.21229-3-mike.looijmans@topic.nl>

On Tue, Mar 25, 2025 at 08:18:27AM +0100, Mike Looijmans wrote:
> Support providing the PERST# reset signal through a devicetree binding.
> Thus the system no longer relies on external components to perform the
> bus reset.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
> Changes in v2:
> Split into "reset GPIO" and "wait for link" patches
> Handle GPIO defer and/or errors
> 
>  drivers/pci/controller/pcie-xilinx.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-xilinx.c b/drivers/pci/controller/pcie-xilinx.c
> index 2e59b91f43e0..e191ab95d669 100644
> --- a/drivers/pci/controller/pcie-xilinx.c
> +++ b/drivers/pci/controller/pcie-xilinx.c
> @@ -18,6 +18,7 @@
>  #include <linux/iopoll.h>
>  #include <linux/msi.h>
>  #include <linux/of_address.h>
> +#include <linux/of_gpio.h>

Correct header is:

#include <linux/gpio/consumer.h>

>  #include <linux/of_pci.h>
>  #include <linux/of_platform.h>
>  #include <linux/of_irq.h>
> @@ -577,11 +578,17 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	struct xilinx_pcie *pcie;
>  	struct pci_host_bridge *bridge;
> +	struct gpio_desc *perst_gpio;
>  	int err;
>  
>  	if (!dev->of_node)
>  		return -ENODEV;
>  
> +	perst_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(perst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(perst_gpio),
> +				     "reset-gpios request failed\n");

'Failed to request reset GPIO'

> +
>  	bridge = devm_pci_alloc_host_bridge(dev, sizeof(*pcie));
>  	if (!bridge)
>  		return -ENODEV;
> @@ -596,6 +603,13 @@ static int xilinx_pcie_probe(struct platform_device *pdev)
>  		return err;
>  	}
>  
> +	if (perst_gpio) {
> +		usleep_range(10, 20); /* Assert the reset for ~10 us */

Delay should be PCIE_T_PVPERL_MS.

> +		gpiod_set_value_cansleep(perst_gpio, 0);
> +		/* Initial delay to provide endpoint time to restart */

s/restart/initialize

- Mani

-- 
மணிவண்ணன் சதாசிவம்

