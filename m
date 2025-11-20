Return-Path: <linux-pci+bounces-41786-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F8EC741AB
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 14:13:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8F08A4E51EF
	for <lists+linux-pci@lfdr.de>; Thu, 20 Nov 2025 13:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CD232BF4B;
	Thu, 20 Nov 2025 13:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="lTo6nfIu"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17AB2FABF0
	for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 13:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763644376; cv=none; b=fZUtuhUh82TOBoJax0PH64R4vbDsKsf/kwUz9LBoTJ3uvfRi3vHpixexMAVtbot/wzHlcfa87rwhWyrXtiAcDGVf+AqUfvGfpV09E3xl8Aq8J8cb3BOSd3IZf3mqaFiTWs2EBxWnHXeN7KCrHh4c+qhwvmZ1vN/TZHisFZpq4/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763644376; c=relaxed/simple;
	bh=6FjdDokRMUQGzvfhHtcUA/tTikcrIp8D8rPLOTC15mM=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=segKcLEH1MIr6oP/A0uZVCXu4G2O1wr5AxLrUaGwmk7gOxM5xmtUI18eGV3r538h2e/oFunmT8O/xdHDgw4hBk0S7f5zq3pXPe0yj630+gOdPJ1oXf39GIPR9VVwsyoHy0jNoNIHv8ehXbb8JNH2r4cDyWpufo/t2f8n1r9XDvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=lTo6nfIu; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7b9387df58cso1365809b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 20 Nov 2025 05:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1763644374; x=1764249174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbkH+QspLqRtZlYBSocalj7+pPU/MOWFfuQLpjJkjZE=;
        b=lTo6nfIuh0P/FwtZHHnErzGJs72l2QpzUiRqFKQLJEfDnJWTNCI/90gdSK24Ali364
         r2KhJlS80CnJ+jmZbPBujAgZ/IlajaKlh3VcEBjIQW8h//TCu6V9nvwX5bylVnclkt7D
         DJEQVxM0/7UFshzfhYOTNTrnIDyi3n8UZPRiwjpfaREXi8k6W577eqR8Gku0WQfrJTvH
         WbX+1G2ASHC60AFK4kdI5thRM4lD2i/63H9kXTGq/x1pXapXpGQiO3TYy2ICD0m/5cgm
         z/cc2BRIL360E3K1XW2eAZUeUT8rfzC/0QgRY/8Y/tucwZ55cDxZIbr7fZBFeF/cw+fj
         nqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763644374; x=1764249174;
        h=cc:to:subject:message-id:date:references:mime-version:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbkH+QspLqRtZlYBSocalj7+pPU/MOWFfuQLpjJkjZE=;
        b=iFacccWCaFa9halO73dtevL5yn+cbwhqkas0TiCSM4D6OtFAKjyP5Xe4gVg17f2PBN
         D4DorKFEynaNFllMmlQI7txek12U7xYMYiqhovndyVXufZMGYvxbCcfW/0nwSnpJhlFj
         O9ZqaKtsc+oerZqP05DEnJvSZ8mPxMFIkIlD2GYiSBETepVCQvD/q7LBmSmVyZLwBa+G
         9Q3hiRR4BwzHzywAs1wQvIoNHtsQfpM0YGMXWjRV3OjH6RXe1ExBW2fmBurCtY1/W0br
         0D0j8aff9QL37XVK6cBYcAf0b6AfQKsD/dwaVSsW8zLFl96l1Ni2/9WZOZKUHIVJ1WV+
         Fo0A==
X-Forwarded-Encrypted: i=1; AJvYcCVEfwAswl1nYXMip03+b4P/Co1jhzyc+E2TtADFOpLb6GW0dcOmVJCricphIChqm4hJMgWHQc66SMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/5WF0Vm97ayReAtzeIx/wpfGeWM3IUHk9nWlA7M6C0unYOgOZ
	aWDiOTpA7h5fRw/h729TiFWbWE5JZ8k01XLgl5xbfXS2kh06mwPyebsu3xO7M5IDBW9041Qt38u
	sDZW9hoxrIEYfVDBjN8G9XdUSETCMZ60y+wnbfgRFXA==
X-Gm-Gg: ASbGncsplOTSLCc4XZgW8tsdpjzAaOfCx/cqysgIMam9yCX+FHbEcbref56yaSP5zt6
	UVjpnFIMtlVos9qFT9IRc6OqC71vru+Ndd44Clq0EwQuoq7tCa6xvpDqBNeqNKcE8F9LRKvK7BD
	u3zpuDGP9Mjo8jAl+48LXoSgAqtmyXmtfDqxN2YyacBuHPR+hVZJ5cwCvLGYmLjnlO/WbCs1zgv
	kAXa6gCBsLQ3aadFuMiuzslhS3kH2MSLI4fhYl7jZEVIrcXg/YEmOJygCXI1Z/nuDp3vlSrXIzQ
	ArjxpLxWmN/Akj9Wujf9dmL+jA==
X-Google-Smtp-Source: AGHT+IGdRfE7niYC5laOLHyUHGXkeN199CP+cMdQJsEDByQRRxTLzHERaeMZHlGW49hm1e+RVUU3ocVnJdyz4AboXvI=
X-Received: by 2002:a05:7022:eac9:b0:119:e56b:c73d with SMTP id
 a92af1059eb24-11c937f64bemr1364991c88.2.1763644373881; Thu, 20 Nov 2025
 05:12:53 -0800 (PST)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Nov 2025 07:12:50 -0600
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 20 Nov 2025 07:12:50 -0600
From: Bartosz Golaszewski <brgl@bgdev.pl>
In-Reply-To: <20251120065116.13647-2-mani@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120065116.13647-1-mani@kernel.org> <20251120065116.13647-2-mani@kernel.org>
Date: Thu, 20 Nov 2025 07:12:50 -0600
X-Gm-Features: AWmQ_bmw_8Z7Oy6sjDE6Ur_LHTucLw8kErxRyTKUrLkAu7yN7m3Q3QjdhC_R9g0
Message-ID: <CAMRc=MeaGx6MR1wEo4ia7ovDRcJMH3H3sjyXQEN_cxoJ5q+dXQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI/pwrctrl: tc9563: Enforce I2C dependency
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, brgl@bgdev.pl, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, krishna.chundru@oss.qualcomm.com, 
	Manivannan Sadhasivam <mani@kernel.org>, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"

On Thu, 20 Nov 2025 07:51:15 +0100, Manivannan Sadhasivam
<manivannan.sadhasivam@oss.qualcomm.com> said:
> This driver depends on the I2C interface to configure the switch. So
> enforce the dependency in Kconfig so that the I2C interface is selected
> appropriately. This also avoids the build issues like the one reported by
> the LKP bot:
>
>    alpha-linux-ld: alpha-linux-ld: DWARF error: could not find abbrev number 14070
>    drivers/pci/pwrctrl/pci-pwrctrl-tc9563.o: in function `tc9563_pwrctrl_remove':
>>> (.text+0x4c): undefined reference to `i2c_unregister_device'
>>> alpha-linux-ld: (.text+0x50): undefined reference to `i2c_unregister_device'
>>> alpha-linux-ld: (.text+0x60): undefined reference to `i2c_put_adapter'
>    alpha-linux-ld: (.text+0x64): undefined reference to `i2c_put_adapter'
>
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202511200555.M4TX84jK-lkp@intel.com
> Signed-off-by: Manivannan Sadhasivam <mani@kernel.org>
> ---
>  drivers/pci/pwrctrl/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/pci/pwrctrl/Kconfig b/drivers/pci/pwrctrl/Kconfig
> index b43fdf052d37..e0f999f299bb 100644
> --- a/drivers/pci/pwrctrl/Kconfig
> +++ b/drivers/pci/pwrctrl/Kconfig
> @@ -26,6 +26,7 @@ config PCI_PWRCTRL_TC9563
>  	tristate "PCI Power Control driver for TC9563 PCIe switch"
>  	select PCI_PWRCTRL
>  	default m if ARCH_QCOM
> +	depends on I2C
>  	help
>  	  Say Y here to enable the PCI Power Control driver of TC9563 PCIe
>  	  switch.
> --
> 2.48.1
>
>

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

