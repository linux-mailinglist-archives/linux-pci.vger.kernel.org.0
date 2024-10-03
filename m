Return-Path: <linux-pci+bounces-13748-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4802598E96C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 07:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29AF1F24646
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 05:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB55238DE0;
	Thu,  3 Oct 2024 05:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EfAOFHIH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 789762232A
	for <linux-pci@vger.kernel.org>; Thu,  3 Oct 2024 05:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727933907; cv=none; b=tNhivAEUerd32X15q4I6gYn0ZLgctYC/06REmFcrLctIaZe8FcBpr5r+GCe1tDuRzJZmUWXmjd+SO0HosZQ9xW7i+l/Ml5KoE1Epj8ezCRrLpwk8ouwD+ILTOtySYYZF2VfMtAjg1XB3NqzDyYkkRQD0GJAitZ4GYlo7u0E17vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727933907; c=relaxed/simple;
	bh=OZf5T1dMlAEXY8gTRUkhfj9KW2sc8CDfqqYDFYBKrCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bt1MvjySeabBTnTo9pn7DvyNuAX4rdP3fkwns7LlG/gY709RMpZgVpu/GXQ9Cx8k8J3ZBQBvljYhiwwyFQkBLdjWqc8JdJz48V+qIsbEqnVgyeYw/Bg4lgo7Ii1SsbL5q90NGLXzPoaLciWQsA1J4Uh+iN3g5Hgkf2j1p+FIxho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EfAOFHIH; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2e0afd945d4so444865a91.0
        for <linux-pci@vger.kernel.org>; Wed, 02 Oct 2024 22:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727933906; x=1728538706; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Pd1LkdkCibllI1ORTg7Irg02FkDWiTpEyiSVdQth11o=;
        b=EfAOFHIHy61mW90b2kdWTYvOPpMC8QRvTKV6wc6LdEuBbusegTguXpnLPskCko7ep8
         9I7Vke8R9tWdwNXEZqW8jj1/1rcmBMEgUHCL55uBrGkr8/lm+mCbOMDsFh8nQcXTibko
         sfjHWHY23rhkEYOXlEFlhOSspKYmMVfu7UdRvy9vyGzi/NNgcRJORWq2gxv6gArG4gML
         wve5gy8iLw5Q8tf5NxtNzBKnzodbOnbTc54l1Oe+6/GDT/0AeV7tUM+uMK2utHgXxgiP
         j3xWNLjItUln/XkF9qVqG/dys8ic0cRNamJjBRhaqeUC2QugStHQo6MSIZMzAleyoYpO
         fUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727933906; x=1728538706;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pd1LkdkCibllI1ORTg7Irg02FkDWiTpEyiSVdQth11o=;
        b=tPdc+UVYXe7cxzBRz5gx2r1Gs4w7M9bEkj/2icM5QQZt8zDEOeGQ5OkmjYxJ3EBdZI
         fZv/h9M+x1NGIPYXoCDn7fV0aRye03tyM0SyJIpLkYfaeJa1MwOZN2XwBPytSaTV8IrW
         7TlMT31MsBasu9Zjx0/N8DJ7awtBZF5S/bTaZM5b1x1WC/o60Kk0dEqc6Ii7RdsBfkFd
         IVxO2zQM3WV3yQyIMRj9C19ChPm4edNRPLbycQeZ8KCI7qKv/MgVHIIzbKWcSM8uzdRc
         bpR2ekGDCJtVicmt1seMStmKGTH75lSCkn2tepcgERZhpdjS6JQzwjRWUfGtslSR4JdB
         EOKg==
X-Forwarded-Encrypted: i=1; AJvYcCUU67rxMkGAeDp9n8pqlIS9rqcbNXXg8hug7f3J5iOokfqmYh5DoAJUy0kUlNZ4YBvh3R/69uqfu14=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxu2FX/Lumci6iCHKwNauhRXpPdGQ/Irdnj2eJEYNxd7zvO6J91
	aOnyjsVxmXxsqWc4Ft5OURcN41hQ+p1scfkllxueDRAapPb06FHZfxap7H+XmQ==
X-Google-Smtp-Source: AGHT+IETFJQL7nnoFerivVi2DQB/Jkm21orJvAufRoGLmUdngzWZk//7FXKGWhSccYa6K7py+Gxobg==
X-Received: by 2002:a17:90b:1e42:b0:2d8:ebef:547 with SMTP id 98e67ed59e1d1-2e18496989dmr6233335a91.35.1727933905751;
        Wed, 02 Oct 2024 22:38:25 -0700 (PDT)
Received: from thinkpad ([36.255.17.222])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e182634b11sm2043389a91.0.2024.10.02.22.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 22:38:25 -0700 (PDT)
Date: Thu, 3 Oct 2024 11:08:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev
Subject: Re: [PATCH v3 1/3] of: address: Add parent_bus_addr to struct
 of_pci_range
Message-ID: <20241003053817.eycemurigrr6qy4u@thinkpad>
References: <20240930-pci_fixup_addr-v3-0-80ee70352fc7@nxp.com>
 <20240930-pci_fixup_addr-v3-1-80ee70352fc7@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930-pci_fixup_addr-v3-1-80ee70352fc7@nxp.com>

On Mon, Sep 30, 2024 at 02:44:53PM -0400, Frank Li wrote:
> Introduce field 'parent_bus_addr' in of_pci_range to retrieve untranslated
> CPU address information.
> 
> Refer to the diagram below to understand that the bus fabric in some
> systems (like i.MX8QXP) does not use a 1:1 address map between input and
> output.
> 
> Currently, many drivers use .cpu_addr_fixup() callback hardcodes that

s/drivers/controller drivers/

> translation in the code, e.g., "cpu_addr & CDNS_PLAT_CPU_TO_BUS_ADDR",
> "cpu_addr + BUS_IATU_OFFSET", etc, even though those translations *should*
> be described via DT.
> 

It'd be useful to mention which driver has the mentioned fixup as an example.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

