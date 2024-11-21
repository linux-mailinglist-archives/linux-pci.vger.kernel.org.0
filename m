Return-Path: <linux-pci+bounces-17158-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFDF09D4C85
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 13:06:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8648B2820B3
	for <lists+linux-pci@lfdr.de>; Thu, 21 Nov 2024 12:06:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9841D0E06;
	Thu, 21 Nov 2024 12:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="laCwdI/y"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64CB1CB9F9
	for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 12:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190806; cv=none; b=Q49x0Vuhcysu9o/Kfxt5MQHaHeR4vZVXdLw6xSmFkEnPOtBTMRMFLExNmdEd7kfpljH7TzTJj1hSayBEWNVuZ1whlcGJtF7ShgPdEvpQZwq4ZPSjExD5Y6XpQMfoaC0+os2/ginHroDiTRNBfjeWy/kl8qt+6VhGvcH+cIG0JWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190806; c=relaxed/simple;
	bh=jdyS7l/nToraMU8DwFUS/jMddkId5ELk7bSNl9XwrEM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxSmOui7mA0XXhoGigCmZ+vaP8wFIIZGQ7/4+US9wXVMSuv+D17o03kpb9NUfplter5h6yxrEiwi4E1cqD7vcp9y/XVrwvLtyU5clWvhSLOYHMJoKAp7xCmZnKtS88jfctwHCADk/akB+TKOHJKM91yIxYLsrhnjx6CTLBIY4Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=laCwdI/y; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7240d93fffdso676222b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Nov 2024 04:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732190804; x=1732795604; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QeJkQl4NZCb42aF1EDykjOMDqurfKMx1jJdti4mmSYI=;
        b=laCwdI/y3CDQN+7IZYs2Dp5NHh9HjE8RCWdJuGSKOwhO6AkBgFoNOnYyAnpFW5KDku
         jHojinyd/6ct1UkK0+imUUDK5B73ZHU0Wv6+BfeGu7RekaH9m1KU6+A3NMWkvP51xRsc
         gqel4l5EpLBRTghCuje0EQjsiPV8hETuCge6tTRVP4NKnEwqmsepNFJHpQps6wI4HN1F
         unfbLob1mlCSK3oHwmHN0M7u0zA7U8z+RjVsU/seiccFiQe4YkFPKBrSbjR+9HMhuJ67
         rCAlTBigarfMPWOve6RBCO/uOJuJJbmjuR+Woriv6K+ygk7yYbYM6m1hGLVkpvVZPToI
         +dHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732190804; x=1732795604;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QeJkQl4NZCb42aF1EDykjOMDqurfKMx1jJdti4mmSYI=;
        b=OyHoz+LQ/g13Xk5p4JFgeF4LOwVYV3K7z/E5wehwLmROncdcsV2tVPlIHisrt2aS/z
         J0slxLhyOXfHoV6AVF7voNqV98Ihk6WZb7g6TGt88JuZGHPL3Hs9nnTRf+b4x7+5E+bQ
         2mlhyMSQDHjcT1hQi3y0x3Qhtr2H9Q12xdiA7a4k9wmdTa5N0ea3yasrFP8UCqqsH70i
         yvNekraZxrmwfKkn54kFo+VKALz0Q7ROOG0JUrJvFl65v0EG0UH6tbyI24j/T+S+3J38
         JEyHzwJ1FZZAXzzIdthFmV8tvDfsXJX7RxdtHuQ2KCbJcrXB0muDQmoQexJ5dxhX81rF
         tkiw==
X-Forwarded-Encrypted: i=1; AJvYcCX64hzqXfvq14l7gekzjVPzXt3Aqn/rTnLIcfSeAQqKXo9XevaXvv3vI46I338UQ+ukA9BoDOmkhu4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrqzh8PqDMGO/yjUKqz+wRUjWL1msUYf5u8UmzzPkgHJHnR188
	m2s/mjFVLPHdik1d15+/R7YMOPCGX1p0jE67uukQtGcpc8x97mhhpTl+viczZg==
X-Google-Smtp-Source: AGHT+IFJrKxqS/drFBULdAcXuufWwk/0qbcFmu12EETGZqfH/I2ea8PwOKdoyNwUd6BRtkdHSGeCZw==
X-Received: by 2002:a05:6a00:c87:b0:71e:7604:a76 with SMTP id d2e1a72fcca58-724bec8a716mr8148779b3a.1.1732190804093;
        Thu, 21 Nov 2024 04:06:44 -0800 (PST)
Received: from thinkpad ([120.60.55.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724befac2c6sm3450562b3a.150.2024.11.21.04.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 04:06:43 -0800 (PST)
Date: Thu, 21 Nov 2024 17:36:37 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Chen-Yu Tsai <wenst@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Klara Modin <klarasmodin@gmail.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	stable+noautosel@kernel.org
Subject: Re: [PATCH] PCI/pwrctl: Do not assume device node presence
Message-ID: <20241121120637.76ircbsfayjebdvr@thinkpad>
References: <20241121094020.3679787-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241121094020.3679787-1-wenst@chromium.org>

On Thu, Nov 21, 2024 at 05:40:19PM +0800, Chen-Yu Tsai wrote:
> A PCI device normally does not have a device node, since the bus is
> fully enumerable. Assuming that a device node is presence is likely
> bad.
> 

I missed the fact that NULL ptr check is removed from of_pci_supply_present().

> The newly added pwrctl code assumes such and crashes with a NULL
> pointer dereference. Besides that, of_find_device_by_node(NULL)
> is likely going to return some random device.
> 

Yeah, good catch.

> Reported-by: Klara Modin <klarasmodin@gmail.com>
> Closes: https://lore.kernel.org/linux-pci/a7b8f84d-efa6-490c-8594-84c1de9a7031@gmail.com/
> Fixes: cc70852b0962 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers")
> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Cc: Krzysztof Wilczyński <kwilczynski@kernel.org>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Cc: stable+noautosel@kernel.org         # Depends on power supply check
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Thanks for the fix!

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/bus.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 98910bc0fcc4..eca72e0c3b6c 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -405,7 +405,7 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 * before PCI client drivers.
>  	 */
>  	pdev = of_find_device_by_node(dn);
> -	if (pdev && of_pci_supply_present(dn)) {
> +	if (dn && pdev && of_pci_supply_present(dn)) {
>  		if (!device_link_add(&dev->dev, &pdev->dev,
>  				     DL_FLAG_AUTOREMOVE_CONSUMER))
>  			pci_err(dev, "failed to add device link to power control device %s\n",
> -- 
> 2.47.0.338.g60cca15819-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

