Return-Path: <linux-pci+bounces-41032-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD4DC5535A
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 02:12:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152513AB1AD
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 01:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1E419ABDE;
	Thu, 13 Nov 2025 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Su1epdLT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA02741C71
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 01:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762996157; cv=none; b=fAIFKCBiO7Xp3wN1ENgaRG5LtE4/MacPzoeBer0qliRNLiR341ycTImD/MYhf6IKCRfQ1a3PcMiY8Z3DhkTWbDjV6L+pr6fMFvwMfiyDvnFMXiIdf/KtJzs9pxcVBCLwPdYAHSCCSQgebEzFrl3WlufTfntIwEswXgQT5PdjWDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762996157; c=relaxed/simple;
	bh=2MIM4SOE2aXVCsyeWH0rZQhLjKK+RGyznQHrldLD4fI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HTWFkiDwpFZFBKMepjKEWLgPVR/Co/k3E0hFoumtPuUE2XXU9RbKFoy5cCBfWtaT7A1LapdSrkxv5LvK/qUQ5/u633eKAAK4zD8r/ejfBF7/EAiACQN1kEjr106seaLpoKZXaoHW3jWrOLt5dDR3uSuBWvXxPvdJAqNTmzFSR+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Su1epdLT; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7a9c64dfa6eso171878b3a.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 17:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762996155; x=1763600955; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HUp9XSelBvHam5yKb7kd4Uyi0l9skDUn0FSAP36J340=;
        b=Su1epdLTawvl+O5gu/fALQTsoIE8br9nkOLJtdGrCmegI8m+dxM4XSX+4mRf7/rR7J
         Yvxk2vL9ePPBboV4gvFE4tG35zlc0eyuKyI2I8fv7rhp42d76BWcQ5VHSSOejjayj+f8
         ARz02w4SfgqM8H5lHm6SwG7OEx2FLA9OvEE63/3gpBZqFFqWcuu45houAAKkD1BgdNxp
         L+v/RjiAiZ9p444IpXfXUDd2GiJMXKCDQWix9aorOJORNhg/3eIxRBQ5Y1lt9nBw64Zt
         Z3Rm+UZZJgyls58EvI+s2oj1Et9El0k5UtmNYaZr0fKKyZdlCrGas+P5JuBrNELMMEAc
         759A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762996155; x=1763600955;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HUp9XSelBvHam5yKb7kd4Uyi0l9skDUn0FSAP36J340=;
        b=nE13//d81nlrny1G+chkmxBljx4IkXJ4mXRo+tvOGyMZxs8yFiSIBLe7uNKmTlL8wH
         5VuXGIds7HyFV8vUrq8wuVlfhiN8U8l0OmwDuDFn3s2fMyQUEqbwLcZ7UI/AvMikYIEp
         2a5O6cN8nqCJFPWfGc5+4u6EJSO7V5usOcnKpuSD5z9f7F5ut8HVLZQI/oVel4hf3puc
         obPP9YORcIC4wjX4JYaKZOBVUA+g5ecbvIJJtLkxsUIZXBFVLewh1z4+AP89mJX6nbMw
         WDwW3HpuA7DPBsP6Ae6lTTBOsjPm8ekpLc6Pdbxx0LuvSGn4xae646N7PdzTbLAlXZ/a
         R7KA==
X-Forwarded-Encrypted: i=1; AJvYcCW1BOoc/mSrUQwoXykfonwSylQXdNTEdtXB/AwJoETbSiv4eWf0l+bGs+0n0GypADSzEYhxForBeNg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxnja3gbVuRS4QMgt8jZFCSbSgndpRua51Ah93N6SBzNgqrH1DK
	a5DKxFTHslbMBzgdGmydca44KmSqcgp8DVaoYbLobzQ9fY263cTLLKoB
X-Gm-Gg: ASbGncurgwUAW75c4yjO6D/cptLyfCxGidJVfCznAlEXBwUzY+rykLF+U4PFWOvea6D
	8GVT8MNsbxaSdA69EldtbXgCdH3KVQQyumCNDzi1xpORN5LHkq1AqoCSzsPT9fKyiW8lPREmZrO
	zesi72+xQg7eTLGqSnkrLCJWEuHZ0jVw04ocVdzHlMgl1KxA1BP2mnwHFZrYi3VqshjBS/CdGR7
	ZGHTJqI8cM/XsPr/bRZCNu1+7q5nFe5//kwE1zFgg4A1TmXNeFuEgg5CPXDk1XeDSGqYKjYr6R+
	6YUfZXXr5ia20YG+FDayNU0I7Fqk4uRqDGU+PBRkBJytObU0Wfrud+X6cNs5l71po7mMeEbqpYr
	OmRXcDTDyZrTnjwkYhO7GivFP8SsblPrfG8rp8ee2BcdAWMsXhY3E
X-Google-Smtp-Source: AGHT+IG6mp0E78VSvu/3qqFMgI1T8YiQOF856a+2bF57H7GUKPTtbD8FuO+l8D99yBgWDvvJxeroug==
X-Received: by 2002:a05:6a20:7f92:b0:344:97a7:8c68 with SMTP id adf61e73a8af0-3590bb147d7mr5734286637.54.1762996154814;
        Wed, 12 Nov 2025 17:09:14 -0800 (PST)
Received: from geday ([2804:7f2:8082:3106::1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b927826dc9sm303318b3a.53.2025.11.12.17.09.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 17:09:14 -0800 (PST)
Date: Wed, 12 Nov 2025 22:09:03 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: =?utf-8?B?5byg54Oo?= <ye.zhang@rock-chips.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	linux-pci <linux-pci@vger.kernel.org>,
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	devicetree <devicetree@vger.kernel.org>,
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>,
	linux-rockchip <linux-rockchip@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: rockchip: align bindings to PCIe spec
Message-ID: <aRUvr0UggTYkkCZ_@geday>
References: <4b5ffcccfef2a61838aa563521672a171acb27b2.1762321976.git.geraldogabriel@gmail.com>
 <ba120577-42da-424d-8102-9d085c1494c8@rock-chips.com>
 <aQsIXcQzeYop6a0B@geday>
 <67b605b0-7046-448a-bc9b-d3ac56333809@rock-chips.com>
 <aQ1c7ZDycxiOIy8Y@geday>
 <d9e257bd-806c-48b4-bb22-f1342e9fc15a@rock-chips.com>
 <aRLEbfsmXnGwyigS@geday>
 <AGsAmwCFJj0ZQ4vKzrqC84rs.3.1762847224180.Hmail.ye.zhang@rock-chips.com>
 <aRQ_R90S8T82th45@geday>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aRQ_R90S8T82th45@geday>

On Wed, Nov 12, 2025 at 05:03:32AM -0300, Geraldo Nascimento wrote:
> On Tue, Nov 11, 2025 at 03:47:04PM +0800, 张烨 wrote:
> > Hi Geraldo,
> > 
> > In standard GPIO operations, the typical practice is to set the output level first before configuring the direction as output. This approach helps avoid outputting an uncertain voltage level at the instant when the direction switches from input to output.
> 
> Thanks for the explanation Ye Zhang, it makes sense to me. It avoids the
> pin to not be floating so to speak. I kept hammering at this problem, by
> the way is PCIe PERST# side-band signal refusing to co-operate and
> failing PCIe initial link-training.
> 
> You're not going to like this:
> 
> diff --git a/drivers/gpio/gpio-rockchip.c b/drivers/gpio/gpio-rockchip.c
> index 47174eb3ba76..fea2c55992e8 100644
> --- a/drivers/gpio/gpio-rockchip.c
> +++ b/drivers/gpio/gpio-rockchip.c
> @@ -183,11 +183,13 @@ static int rockchip_gpio_set(struct gpio_chip *gc, unsigned int offset,
>  	struct rockchip_pin_bank *bank = gpiochip_get_data(gc);
>  	unsigned long flags;
>  
> +	rockchip_gpio_set_direction(gc, offset, true);
> +
>  	raw_spin_lock_irqsave(&bank->slock, flags);
>  	rockchip_gpio_writel_bit(bank, offset, value, bank->gpio_regs->port_dr);
>  	raw_spin_unlock_irqrestore(&bank->slock, flags);
>  
> -	return 0;
> +	return rockchip_gpio_set_direction(gc, offset, false);
>  }
>  
>  static int rockchip_gpio_get(struct gpio_chip *gc, unsigned int offset)
> 
> By setting direction INPUT, then writing out, then setting OUTPUT again
> miraculously it doesn't fail initial link training, with no other
> changes that already have been rejected by PCI folks and Shawn Lin.

Hi Ye, Shawn,

Here's more contained workaround without resorting to clearing DDR to
INPUT for every GPIO:

diff --git a/drivers/pci/controller/pcie-rockchip-host.c b/drivers/pci/controller/pcie-rockchip-host.c
index ee1822ca01db..1d89131ec6ac 100644
--- a/drivers/pci/controller/pcie-rockchip-host.c
+++ b/drivers/pci/controller/pcie-rockchip-host.c
@@ -315,7 +315,8 @@ static int rockchip_pcie_host_init_port(struct rockchip_pcie *rockchip)
 			    PCIE_CLIENT_CONFIG);
 
 	msleep(PCIE_T_PVPERL_MS);
-	gpiod_set_value_cansleep(rockchip->perst_gpio, 1);
+	gpiod_direction_input(rockchip->perst_gpio);
+	gpiod_direction_output(rockchip->perst_gpio, 1);
 
 	msleep(PCIE_RESET_CONFIG_WAIT_MS);
 
This results in working PCIe for me, pass initial link training.

I think I need to provide more details:

GPIO in question is GPIO0-12 / GPIO0-PB4. On RK3399PRO VMARC schematic
it's called PCIE_PERST#_3.3V and it's in the PMUIO1 domain.

Without workaround I have about 6 milliseconds, from driver probe and
parsing of DT that sets initial value 0 for GPIO, to deassert PERST#
by setting it high. Which is why just removing msleep(PCIE_T_PVPERL_MS)
produced working PCIe for me.

After the ~6 ms it becomes necessary to hack direction to input then
setting direction to output to properly deassert PERST# and proceed
with initial link training - which is why, again, hacking PERST# as
either open-drain with pull-up or open-source with pull-down worked:
gpiolib hacks that by setting direction INPUT.

Thanks,
Geraldo Nascimento

