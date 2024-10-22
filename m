Return-Path: <linux-pci+bounces-14967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B34C59A96F5
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 05:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB47B1C2326C
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 03:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B942D1487D1;
	Tue, 22 Oct 2024 03:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BrCecYDD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3E913B5B7
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 03:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567268; cv=none; b=neoRcSjFaTHPxX9jVuDctIlPdR9SjfaSHx0gYBShy7Zn9fKea0U0jgzhLynWfsx8TtSfujzGnpw5/2fM6itg04bfFU6kmv7ZAp+Bo1lIYfO+s3sUC2OPUgTRB+7BypH3QiEAeLhsgxNvrmTlRsehS5mGx0PGud90nl1phPgZM/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567268; c=relaxed/simple;
	bh=770ZEK5ncIdutFyIwrT3MVJNBgshk/QdmNZVcv73xCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AqEQ94swfeAS6tznU7lm319kIrxo9xhmupbxuz/b2gZGFYjDnThGTwtgWSyrrOqJikVpTFk5ANDstu3nJnDEWZvtjAemK6Cq3oTvM5vwMJVskzGS2Obej7vTSJ5PUGIArJPWE254fdZTe3yJAdhIpEY31oJeXOqhWnE/bHtXoy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BrCecYDD; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e5f9712991so2533566b6e.2
        for <linux-pci@vger.kernel.org>; Mon, 21 Oct 2024 20:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1729567266; x=1730172066; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7XvZPdmTG0ler+vxRghAOOFoH2oBNerspqqs5iSkVdo=;
        b=BrCecYDDlkCWX9sxhdpx4sE9aXzL+bTcS0kC4zpH4Y4dIQ+2DaxmaViSw2uG9+hlbE
         CII/M9OPFFh8E6D3hurVRIVQadgn3bASkLQxCc8j8i5NYmcWEEE4Scr8Hw/wxuVijSTC
         ZKQUDGMaA3hj+BPvIqOXVHJeZT5/08AxpPQK+4hoU9MeneOhUtZB/xBRK9HTB2olUVtY
         e2wnMuJtmqi7VzbExkK97ahwOTXoy5xcn0dO+flXz/ENWOUUwFwtIdy2mDgu8+lybz6a
         g1BQN9skSLZzlxW1X0skvu8PAQOlngwO0P9e7xLcUHuUOQEMYGEd9fXNeX3kYXKGNjgv
         NP/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729567266; x=1730172066;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XvZPdmTG0ler+vxRghAOOFoH2oBNerspqqs5iSkVdo=;
        b=jURnC6uw0ic8lYGpm8IkWQE1VIdXEG0r3lUrMgX/PROspRDEIq3qXGPLGSnnciSnvg
         IZwcEWaEjZIjiYS2Lo2sBIPSMZGCrfZN2azAzN5IwZSiFVtO9y1QcqVh4lMnUzYZodlJ
         uZcGksHKtnSfJZaT6aQwBXiXZsRvNuOOgaBL9pTQySDrJ34P16LrrK6ReWT/2uFAiDpo
         lWO1Rfmev6mnJ15hMYt+lKeiFi/4EpXUOdZszx6H9WWSooYWRaAMmd0q4FDuQqiRjc05
         7TBNUYVbSy47fDQqhR3NKB3DmsuU9vWB5eNnVQaSG7GcDChBMQKuWtpI2cbUWTVX69JP
         Op5w==
X-Forwarded-Encrypted: i=1; AJvYcCUoE/55Ib7jwHIely6utjOQf8rByWNC5sw9KCGufOLpummHKtH8YKtZFrJVzrY0hLhF5yeZYf+9Sq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdDBGkHx4G/O73zPgMmGqYCZrQRyknEdQYmdR8ToyJkDmKiveV
	Ku+XxMxGKt0BsbrgisJyMuIW2ck09rpd7Dtc2lrxRzNCVn7jaOHTPZ1mnq0ZeinInCTg1z1ERC8
	=
X-Google-Smtp-Source: AGHT+IHbK1kiECcqqBWogf15dfefFB5dAgvNZxYVnraRZrkSkUH5HFrKFhiSbrIDxVQnChxF71bu2w==
X-Received: by 2002:a05:6808:1818:b0:3e5:ff3c:eea with SMTP id 5614622812f47-3e602dc2300mr9485217b6e.43.1729567266060;
        Mon, 21 Oct 2024 20:21:06 -0700 (PDT)
Received: from thinkpad ([36.255.17.216])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab1e5f1sm3948887a12.30.2024.10.21.20.21.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 20:21:05 -0700 (PDT)
Date: Tue, 22 Oct 2024 08:51:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: PCI endpoint: pci-epf-test is broken on big-endian
Message-ID: <20241022032102.otcwtzshyeyrnd3p@thinkpad>
References: <ZxYHoi4mv-4eg0TK@ryzen.lan>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZxYHoi4mv-4eg0TK@ryzen.lan>

On Mon, Oct 21, 2024 at 09:49:54AM +0200, Niklas Cassel wrote:
> Hello PCI endpoint maintainers,
> 
> 
> While looking at the pci-epf-test.c driver, I noticed that
> pci-epf-test is completely broken with regards to endianness.
> 
> As you probably know, PCI devices are inherently little-endian,
> and the data stored in the PCI BARs should be in little-endian.
> 
> However, pci-epf-test does no conversion before storing the data
> to backing memory, and no conversion after reading the data from
> backing memory.
> 
> For the data backing test_reg BAR (usually BAR0), which has the
> format as defined by struct pci_epf_test_reg, is simply stored
> to memory using e.g.:
> reg->status = STATUS_WRITE_SUCCESS;
> 
> Surely, this should be:
> reg->status = cpu_to_le32(STATUS_WRITE_SUCCESS);
> 
> 
> Likewise the src and dst address is accessed simply by
> reg->dst_addr and reg->src_addr.
> 
> Surely, this should be accessed using:
> dst_addr = le64_to_cpu(reg->dst_addr);
> src_addr = le64_to_cpu(reg->src_addr);
> 
> So bottom line, pci-epf-test will currently not behave correctly
> on big-endian.
> 
> 
> 
> Looking at pci-endpoint-test however, it does all its accesses using
> readl() and writel(), and if you look at the implementations of
> readl()/writel():
> https://github.com/torvalds/linux/blob/v6.12-rc4/include/asm-generic/io.h#L181-L184
> 
> They convert to CPU native after reading, and convert to little-endian
> before writing, so pci-endpoint-test (RC side driver) is okay, it is
> just pci-epf-test (EP side driver) that is broken.
> 
> I'm not planning on spending time on this, but I thought that I ought to at
> least report it, such that maintainers/developers/users are aware of it.
> 

Hi Niklas,

Thanks a lot for reporting. Yes, I acknowledge the issue on the ep side. Will
try to spare some cycle to fix it asap.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

