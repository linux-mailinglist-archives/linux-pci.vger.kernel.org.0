Return-Path: <linux-pci+bounces-10577-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9A47938403
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jul 2024 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93952280F22
	for <lists+linux-pci@lfdr.de>; Sun, 21 Jul 2024 08:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECA8F7D;
	Sun, 21 Jul 2024 08:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E7MSQaig"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193082F24
	for <linux-pci@vger.kernel.org>; Sun, 21 Jul 2024 08:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721550346; cv=none; b=GmyB3WSnBTmc4MtyW+2H+Fjk6VeQ2Ger1g8JfKjk/VACrtuOAYPcaVTEXnkFDBc3qcZYJTB82Si5WBu7v6fPpfoU0ENZnhqdlYSRzDUvC3lOjHuejZfPJ4P6F/B9vwQH6I8W9PXHySMWdw2piQ9UHQJHDoGIRF+Vuth9EHmOe48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721550346; c=relaxed/simple;
	bh=7mxFT5RPH8uPGTLPA8mWVIBU6Y10+Ss+XorW4DoWPXE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kJ9/ZmynEUJHdVOrf4QMZF09MkAPu5XBsYpyoVWLd7gdSfHrEKcAH1A0qepZhcjlTmPYU0hYtRG2apkpGtHf3HlYHjVvQO/KRpvT2ToNCo206A8DR2xt8vOyv4uKmqM0EFclf0Kkk8PCRJBOvB1NM2r5vqjIIy+CTu39ZeTR26I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E7MSQaig; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7fd3dbc01deso149919439f.0
        for <linux-pci@vger.kernel.org>; Sun, 21 Jul 2024 01:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721550344; x=1722155144; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NRb+ts4NCAeHX8eVfGlmxAo56K5zTcMk9tYd2zxfBD4=;
        b=E7MSQaigRkHuYFTzfZguchHmWDfl38MTAvzA1bBXWjboL9vM4geV0sBW/0wMDGsPAK
         7gOu7XGjd+MMClbuRkv1a9BkLZn+E15gFpydxBG66WhpZ39ogUMKe7DjvwNlCCj8qsjE
         7UX4/IFX4wiSFe/wm7+fJQKuTwFjz7o2zvHk1MJsznkjRkfGDkr8VLakVzDc6EuevZEn
         3C+0axVDs0TMxJ1BLOhu8CUDlrBhfRTtHbSb3yrhYNzXfnhWqBrjlI5lHdVphAC5I6b4
         czRjxY/KLPBb0hUMQjs6qLITWUpNuA8g1Ptmr0GctEjFvwtsb0GoHTchIdjXKk6UMYSP
         NURg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721550344; x=1722155144;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NRb+ts4NCAeHX8eVfGlmxAo56K5zTcMk9tYd2zxfBD4=;
        b=wAD2OmP/fkBjxNdZfyIDLY/pwn9mmBYVLMPGDgLllXJSsYzwybTxOBvFA/N2MdGudo
         qztRF5jYTLMEU3rGDpELN19YFafbZlF2XJHOzTdWGgPKxOTEMMg1BWkKKIoLDffsaRIj
         BHqRHFdyJdrV+uniUZDCIA8ECL82ZPPEDX6zZxLuTYHL/RknY3yHggk4QJItjLCv0K05
         AIRiY2pzaspANp7sesTwozjE+JEjXJXd6reefqfunkButmhWAiO6KMD+S0VyrPtzZpB0
         90BiWKQ0TOn3UWxCv5q/ZfgQbIEC0zB3K+/+4M9s4xsyvDNIEqvaKHw3vx+J0HHRI2dk
         ljmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3CWymo7VgtnJmBgCdfnSeUbeg/YDQzGZFSHHlUzjfzvXPiN/PRRu3q5UV0cBrsXEhqCZZBHJrfzBirR5uM+7BbLHy1pV6dmw7
X-Gm-Message-State: AOJu0Yw3xP6z7G/GvW+WK9BD0+xCI8jsNw9KZisgeEeI5HPoi9n61cIF
	mHaERBY9SysA2W1GK6cbYO2PyMrQNEI97+K9yAEJN3cAR+1DBt7AIxknEjj9Jw==
X-Google-Smtp-Source: AGHT+IElTOoJolfiF+bmMtTVVaiVVtUT1Qy014HteDsgb6L5kUnlFT0MfSAqpaqrfJx8vtSHjSru8g==
X-Received: by 2002:a05:6602:601b:b0:805:e2bf:f303 with SMTP id ca18e2360f4ac-81aa9cc3f73mr572267839f.8.1721550344194;
        Sun, 21 Jul 2024 01:25:44 -0700 (PDT)
Received: from thinkpad ([120.56.206.118])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f319789sm32845225ad.137.2024.07.21.01.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jul 2024 01:25:43 -0700 (PDT)
Date: Sun, 21 Jul 2024 13:55:38 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Kishon Vijay Abraham I <kishon@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Niklas Cassel <cassel@kernel.org>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Aleksandr Mishin <amishin@t-argos.ru>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Jan Kiszka <jan.kiszka@siemens.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] PCI: keystone: Fix && vs || typo
Message-ID: <20240721082538.GH1908@thinkpad>
References: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1b762a93-e1b2-4af3-8c04-c8843905c279@stanley.mountain>

On Fri, Jul 19, 2024 at 06:53:26PM -0500, Dan Carpenter wrote:
> This code accidentally uses && where || was intended.  It potentially
> results in a NULL dereference.
> 
> Fixes: 86f271f22bbb ("PCI: keystone: Add workaround for Errata #i2037 (AM65x SR 1.0)")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-keystone.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> index 52c6420ae200..95a471d6a586 100644
> --- a/drivers/pci/controller/dwc/pci-keystone.c
> +++ b/drivers/pci/controller/dwc/pci-keystone.c
> @@ -577,7 +577,7 @@ static void ks_pcie_quirk(struct pci_dev *dev)
>  	 */
>  	if (pci_match_id(am6_pci_devids, bridge)) {
>  		bridge_dev = pci_get_host_bridge_device(dev);
> -		if (!bridge_dev && !bridge_dev->parent)
> +		if (!bridge_dev || !bridge_dev->parent)
>  			return;
>  
>  		ks_pcie = dev_get_drvdata(bridge_dev->parent);
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

