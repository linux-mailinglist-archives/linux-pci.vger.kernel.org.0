Return-Path: <linux-pci+bounces-7614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C078C8584
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 13:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40ECF1F20F0E
	for <lists+linux-pci@lfdr.de>; Fri, 17 May 2024 11:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0F33D0A3;
	Fri, 17 May 2024 11:22:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ED7F3E471;
	Fri, 17 May 2024 11:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715944964; cv=none; b=RcjGYAV4ZCaeDCownT50d9+kW9+pgtg8OoFXsRaD/9vR6jjNnGhlZz18wAVnLQIMDtSNK+F/m/FkDCFFPYLMm26uRYacXvPmKZRzXonZVP8nO9hVtJmDnm+jWsudawkHrg847sCEf9Um8i6BTKiL3drjBhzKNVawh54D+G1mdXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715944964; c=relaxed/simple;
	bh=y0gcdIWx2hhNx3bFhbLmbTGSbZSCvWEtpHIYYuD4/kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d4dLTEplHhbzEMTvXi0ou95OxNEc5cLl/GGm8YWkuj/HknycitGUKqzzBFmkl963Es3fxZdDoq8KJmFge+ynbB3c4q18KPZpXI1zJIPRDRebiEimWqoeAps2B43ZU5OzmJ2B+V3LOLrn3JZqTRyCQ5cLXaci3p+J9plSpSqeBdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1ee954e0aa6so5335625ad.3;
        Fri, 17 May 2024 04:22:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715944962; x=1716549762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G2dvI+vZE8pCZhViJyMM66y2U5LdOWJJxNSUxl+PGww=;
        b=qjgQhaHlpR5vdGbDrkEPpCSJbiC0HBPxv/dzpDVHXzjPdcrERGVJsSpFDOl6FVQgr9
         XOPe94WSqOeRMcZtONKovA4U1ZBp5Kl6E8nfuFiMoFRrE9uRolKUxW9ui6xmTDbkhvf1
         Ry4/RqLpMyFvM/JZJWU1Mq93GTFmTrXa+WEFOyuRmfRHLlkIBj67NQfV6rkq1WVWmDnN
         cYTldETgJiVBDY2dm3e/KxX1ASiazC+6kaWapiI1g1TOHlOULfpdf3Ra1ENZpKzGfYaU
         dgrU3cPCv4NVh2YQtudi1qUEKXJqZg8lXabtPIX8KshcEDVaN8ryt/n/0/TIG1B9jakM
         3jvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHIPlDS8XTUc6niwc7yyoolDm6sIjWq8JjdXrBK0nM9oBnhaHT4dk74kOqSmJl50L8GcabAMoTFN+Iwxho3GSk72nzUzoG8QLQyHTo8r6M1AGMmjRT+FoSiiOjNKe8tSF+
X-Gm-Message-State: AOJu0YxHwtF4SpSz4MQEtmqXeCXyUoetff1PSHFpR+nm9njxpxT07mQz
	H6vblsHbZGD4yMnYE3hLYEINJDyT++JaLIgzAdRQTYcBz6MGPCnF
X-Google-Smtp-Source: AGHT+IHeIMz2gvttVbu8YvoQNX0R+DpY+pIkhaL/+tyli1VVIoZ7xusCcFeOVbaL7QVaVkzkH6ZC4g==
X-Received: by 2002:a17:903:245:b0:1e4:4ade:f504 with SMTP id d9443c01a7336-1ef44161e45mr231310545ad.46.1715944962575;
        Fri, 17 May 2024 04:22:42 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ef0bad9d22sm155932115ad.72.2024.05.17.04.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 May 2024 04:22:41 -0700 (PDT)
Date: Fri, 17 May 2024 20:22:39 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jianfeng Liu <liujianfeng1994@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	stable@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Fix initial PERST# GPIO value
Message-ID: <20240517112239.GU202520@rocinante>
References: <20240417164227.398901-1-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240417164227.398901-1-cassel@kernel.org>

Hello,

> PERST# is active low according to the PCIe specification.
> 
> However, the existing pcie-dw-rockchip.c driver does:
> gpiod_set_value(..., 0); msleep(100); gpiod_set_value(..., 1);
> When asserting + deasserting PERST#.
> 
> This is of course wrong, but because all the device trees for this
> compatible string have also incorrectly marked this GPIO as ACTIVE_HIGH:
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3568*
> $ git grep -B 10 reset-gpios arch/arm64/boot/dts/rockchip/rk3588*
> 
> The actual toggling of PERST# is correct.
> (And we cannot change it anyway, since that would break device tree
> compatibility.)
> 
> However, this driver does request the GPIO to be initialized as
> GPIOD_OUT_HIGH, which does cause a silly sequence where PERST# gets
> toggled back and forth for no good reason.
> 
> Fix this by requesting the GPIO to be initialized as GPIOD_OUT_LOW
> (which for this driver means PERST# asserted).
> 
> This will avoid an unnecessary signal change where PERST# gets deasserted
> (by devm_gpiod_get_optional()) and then gets asserted
> (by rockchip_pcie_start_link()) just a few instructions later.
> 
> Before patch, debug prints on EP side, when booting RC:
> [  845.606810] pci: PERST# asserted by host!
> [  852.483985] pci: PERST# de-asserted by host!
> [  852.503041] pci: PERST# asserted by host!
> [  852.610318] pci: PERST# de-asserted by host!
> 
> After patch, debug prints on EP side, when booting RC:
> [  125.107921] pci: PERST# asserted by host!
> [  132.111429] pci: PERST# de-asserted by host!
> 
> This extra, very short, PERST# assertion + deassertion has been reported
> to cause issues with certain WLAN controllers, e.g. RTL8822CE.

Applied to controller/rockchip, thank you!

[1/1] PCI: dw-rockchip: Fix initial PERST# GPIO value
      https://git.kernel.org/pci/pci/c/b00c483a1075

	Krzysztof

