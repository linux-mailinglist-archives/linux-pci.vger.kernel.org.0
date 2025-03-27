Return-Path: <linux-pci+bounces-24866-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF27CA73774
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 17:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C15133A519F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 16:57:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2339217670;
	Thu, 27 Mar 2025 16:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tl2kjLTy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D422213E7C
	for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 16:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094630; cv=none; b=QcdSROXDRwFHSIlK4R0gG2D2goBtO9ayfswmci5ZvbfkVFVzEaMij+79eqwOlfEp24R9uLDyMHX1CTGzjIb0eeWK2bDki8aE5Yskt95TxjscThUk0TG9DLlGjspCtQI2X42f5QujKfsufPJ27weBazv2TATQvcZoOEbOr8DBKyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094630; c=relaxed/simple;
	bh=qj8jPAUQG15kiy/2pnBbudNpRkOrU+khB9NIZvl+qoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCL6iBStZsY2hesN7+NZshzK2494C0zYACzI0DM9X/1U1qv4+ikNPKHw2AiEgkTcEKqJOSXAhvZmmERO1yxdnujNUhmqi16zSBJHWjLOzjiqX7rC073q0SuReUgoXhBCRRe4vW2l2HkdSGFB7/kljL4oatUD/H9x7jhu2zLiNzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tl2kjLTy; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-225df540edcso48236985ad.0
        for <linux-pci@vger.kernel.org>; Thu, 27 Mar 2025 09:57:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743094628; x=1743699428; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qxgqM8SruWplrfrQ7ieYBgizc+YY6It5QEvSwAgx9mQ=;
        b=Tl2kjLTyfrEyJMeC7YZTnVaP2dg2mJ3hE09FemMot0wnchu0kSZ8APlDCGEKfuLjEq
         6/+UvvYYIl3KJV6MTCT5uARqxs5c10IWlgrNL8ygiOGyntqMGw7SEBg7VbMnGT2L7irc
         0PoLGT1//Ryordx2FHkdCf3Dm3py03ai05jyDTkaX1H1Bp22f3NcWkUafBIVgl64ks5f
         ecfWdL4Qrqkub1WxvIPod3fldv/kDlLyujOqhVdRFEKxMLxh/fdg6ABoaEpgvUpvDwdP
         beGI82GFEeShNfiqrcQHvy78swyluiMzI3MCfhyRfAh2ALntoYsjWR6KT4VWFG9dYcrM
         9tzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743094628; x=1743699428;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qxgqM8SruWplrfrQ7ieYBgizc+YY6It5QEvSwAgx9mQ=;
        b=dOmy3Ks21aVXgzmx1RGPO3MnzOexIJJcqwZK+VzHANF862hUT8QCgshSPwKSeshK5g
         jUZSIrORg6Z25jPfv4WTUZEwBi1cIxkpNWPM0XsYqsgV1SztINUrB5XHUAlQ98y6uVoG
         wnZEpdjtFFZXcoi5g1+Osjp78+k4srBIGWA5NTPZ7RcQnsAp60xFgOSW9UkBpqMl1LeY
         Hm005QDDG0AjHlzAGyaz+9hGjAei8kwOb3AOjejhLGw/2RFBtdCurKeTQwNE7+jptYkU
         FkUO6WX14MnwsowNX1Ydp7XndmC7JuCEsApoz2lS16MDtg+CjwyfhThMnFJwDhHvi3z7
         ihug==
X-Forwarded-Encrypted: i=1; AJvYcCVqHtIwgxe5wIgQdA7jumvBmyySdqDBLePCjgxNCHUGUpmjcalMeYtFN1mQSNvjNqS/y3iYTt22o3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOiSy6HIRoLvEFfV2+G/SK0cHcZdp4ByARrOBO8NH+Yl+iIosg
	JNaAUgqQuY21sOG5GldwEatpTSBFsCbYWxY8PY+d3Z3Dq7ydz2Yyu4Sgqd6tCA==
X-Gm-Gg: ASbGnctOnPwZHGHXauGVKCaFTpjgRAKkeX6qQNn0cjEY7X3U5tJ/E0k23Y5+srWRejE
	ynI2mDDFNR0+WZjZE3NzLGrhX3zvMXBK7VlXrd2PJP7fovbSiVawNuwwqACAcbd/23DqmyOtROZ
	WBgU4E3m0yxLq/nGUHvsbHQTcGsRG192QyLjF3O5fjYMPUKFS/uD0YNXdgYqAMBnxeVf64y397I
	QcN9nYm1nh34BqK4mRL4ZLvWwQFIKH7Likbdo6Rw9g/MD4AXfMkoKaGmC1LPl8/n+DEfnXajMNv
	ET6Pi1qozGcKWJYnzp98iwM8PmMcSfhbXljJCli45oI0yjMU2OgZSJc=
X-Google-Smtp-Source: AGHT+IFa8BISCQR44KkE/pAAyn25h9KnAx0099iiC8NJuHQ8ReFXl65yHnBsP9aSbAHzgngKtkgWQw==
X-Received: by 2002:a05:6a21:9986:b0:1f3:26ae:7792 with SMTP id adf61e73a8af0-1feb1b18caemr902546637.18.1743094628393;
        Thu, 27 Mar 2025 09:57:08 -0700 (PDT)
Received: from thinkpad ([120.60.71.118])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af93ba1b22bsm101854a12.77.2025.03.27.09.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Mar 2025 09:57:07 -0700 (PDT)
Date: Thu, 27 Mar 2025 22:27:03 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, jingoohan1@gmail.com, thomas.richard@bootlin.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [v6 1/5] PCI: Introduce generic capability search functions
Message-ID: <xvu4vmk5gxhf5gkftgiycm5ler3vawesgw6zirw5bhba2kqxzt@sytribs5ir6u>
References: <20250323164852.430546-1-18255117159@163.com>
 <20250323164852.430546-2-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250323164852.430546-2-18255117159@163.com>

On Mon, Mar 24, 2025 at 12:48:48AM +0800, Hans Zhang wrote:
> Existing controller drivers (e.g., DWC, custom out-of-tree drivers)
> duplicate logic for scanning PCI capability lists. This creates
> maintenance burdens and risks inconsistencies.
> 
> To resolve this:
> 
> Add pci_host_bridge_find_*capability() in pci-host-helpers.c, accepting
> controller-specific read functions and device data as parameters.
> 
> This approach:
> - Centralizes critical PCI capability scanning logic
> - Allows flexible adaptation to varied hardware access methods
> - Reduces future maintenance overhead
> - Aligns with kernel code reuse best practices
> 
> Signed-off-by: Hans Zhang <18255117159@163.com>
> ---
> Changes since v5:
> https://lore.kernel.org/linux-pci/20250321163803.391056-2-18255117159@163.com
> 
> - If you put the helpers in drivers/pci/pci.c, they unnecessarily enlarge
>   the kernel's .text section even if it's known already at compile time
>   that they're never going to be used (e.g. on x86).
> 
> - Move the API for find capabilitys to a new file called
>   pci-host-helpers.c.
> 
> Changes since v4:
> https://lore.kernel.org/linux-pci/20250321101710.371480-2-18255117159@163.com
> 
> - Resolved [v4 1/4] compilation warning.
> - The patch commit message were modified.
> ---
>  drivers/pci/controller/Kconfig            | 17 ++++
>  drivers/pci/controller/Makefile           |  1 +
>  drivers/pci/controller/pci-host-helpers.c | 98 +++++++++++++++++++++++
>  drivers/pci/pci.h                         |  7 ++
>  4 files changed, 123 insertions(+)
>  create mode 100644 drivers/pci/controller/pci-host-helpers.c
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 9800b7681054..0020a892a55b 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -132,6 +132,23 @@ config PCI_HOST_GENERIC
>  	  Say Y here if you want to support a simple generic PCI host
>  	  controller, such as the one emulated by kvmtool.
>  
> +config PCI_HOST_HELPERS
> +	bool
> +	prompt "PCI Host Controller Helper Functions" if EXPERT

User is not required to select this Kconfig option so that his driver can build.
Please make this symbol invisible to user and make it selected by the required
controller drivers only.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

