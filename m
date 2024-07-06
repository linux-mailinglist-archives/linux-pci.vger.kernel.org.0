Return-Path: <linux-pci+bounces-9862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FF47929022
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0EAC1F21E83
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:09:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23551C8F6;
	Sat,  6 Jul 2024 03:09:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E11F510;
	Sat,  6 Jul 2024 03:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235356; cv=none; b=V2iRROhRN7ibAawNONdHuXAp2jLibYvendsrUtOcLee8EqoJfIqF5VqR0UEb52XcnhO+2I9/hwc5xr3gUQX/tNpsi0wD1oxsQOjZFYbxdPoBw7lalUz+U5i8tpBqlKSERNzI3zAjIk+TohPa1yUwoFH1RVwtdanGt/pJFhCRK/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235356; c=relaxed/simple;
	bh=YVBjjprOI2xN33VT5dkz2cNQKrzfiFjoEDt9NETrVek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B14XcCFifhMfNBNVCQzBOTS6gwBVwon12fO3ttWjUWzIidWMUCqLwqM6YZaxqB2g/PriRB5KkORrz5i5dIrt5MpcBUFLEW/LVaPHuYykQYtCmJXpFxG5LO4L1dsNbps8IgU8LPv0BBLRmMODu8p+cmDewadNSJv3NZSKLnGjKKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fb3b7d0d3aso11266665ad.2;
        Fri, 05 Jul 2024 20:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720235354; x=1720840154;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Njx7jV29iUxIccP/qrNmG9YqstueqET0NeTsZ82ouCI=;
        b=hRZcHP16vegFjsfv5w8gPYhPHgaJgV6jtRirzq2wgpXTOPd2IAKMxJz4XC4Z2pRrmY
         amxUZ5VzDx30S4VXGiZ5F8RtYadng2eHmXne5YlWODdW5mnQcWl0+83ZX2rWfjcZpvmK
         iSggmWjy/qiA6Wo1bYSBHi3XvBetookS14Im83Jokvyrpwau54EzMEL/+jzWHQcvOwNc
         G8Mjd8CK0IG+PjNbB27TKQV2qFoq10B2dbtaDqfsUYrXWRa5zqYEGyxgPxJ/d/Ayc/+I
         0+9u+u5tk2pS2Akt1++kJjHpWq5/CZtrY2hW1Or/2Ua9DiikQ7bYBoBYVKHeEXTgw47g
         EQwA==
X-Forwarded-Encrypted: i=1; AJvYcCXTLuT6fSMX4wgvL2XBibtmslDiK5VWp88dv7/vD6wUsSQoxT2JUTsnNRupfXCUymUt5WIU9kSTHa7teBaSz1koOcJJiXJIyaBXNYEBnR1Q4gIGQjI1f8BcRdRNoeUEhgYu
X-Gm-Message-State: AOJu0YymyRklNg31KZfQipkbW1RGZ3e4BG3e+Z2nLxqahk+86g1maad3
	yBI5XpygZCjRVaTYxZzhSNd7Y0tVj+Ww53Pn3oRoa6OS4mEDwYDKYzPboSkN
X-Google-Smtp-Source: AGHT+IGcDp+dFpomnwwA2WkDNbKq6tzzgQoPrEo3M2dS/9iUAaSmF23V3PEf2UXEvF7/E+Q4PVbBFQ==
X-Received: by 2002:a17:902:ce0a:b0:1fb:1b16:eb7b with SMTP id d9443c01a7336-1fb33e0f058mr65953775ad.16.1720235353981;
        Fri, 05 Jul 2024 20:09:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb2b1b5b79sm44081715ad.204.2024.07.05.20.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:09:13 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:09:12 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>, loongarch@lists.linux.dev,
	linux-pci@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org,
	Sheng Wu <wusheng@loongson.cn>
Subject: Re: [PATCH] PCI: loongson: Add LS7A MSI enablement quirk
Message-ID: <20240706030912.GB1195499@rocinante>
References: <20240612065315.2048110-1-chenhuacai@loongson.cn>
 <20240706030701.GA1195499@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706030701.GA1195499@rocinante>

Hello,

[...]
> [1/1] PCI/DPC: Fix use-after-free on concurrent DPC and hot-removal
>       https://git.kernel.org/pci/pci/c/b69d24a763b

Sorry, this should be:

[1/1] PCI: loongson: Add LS7A MSI enablement quirk
      https://git.kernel.org/pci/pci/c/b69d24a763b

	Krzysztof

