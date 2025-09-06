Return-Path: <linux-pci+bounces-35594-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87423B46D8D
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 15:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36C351C21789
	for <lists+linux-pci@lfdr.de>; Sat,  6 Sep 2025 13:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B4242EDD6C;
	Sat,  6 Sep 2025 13:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="az7jYmjC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948492EDD41;
	Sat,  6 Sep 2025 13:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757164353; cv=none; b=itRKiFJmiXqQkyBzj65CPjVcFlex6ARX+t3nkC70hIzzalrYn7Va5UNs3yCVNyKHPN4cq1ldkFgdA+WtTam+FZ6gyJ5pgrhtjMKyPOLKbla+zHyl+3nAAXp1PVNRpOKYI3Z6h1M0+q18p21/ju80tqJk16gBvvjj/eLojqojby0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757164353; c=relaxed/simple;
	bh=ANiUR780QPWCsha9xD2tG4a5+/0Er5Aqx4F+tYElynI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MG1wsfr7kKgma3K6iLUSUSh6BAVCgjcP3h13XlXzX4Fyv7zsT95EGwqTjZW0LArQDZ4D0kDldrj5HN5veDn5/ETygqSCaWAr4Fx+ejFsFqSOE1PoYdUlMEQZpvyWVNk+8WXz947pPoxMrrIpF8hEeaV9poRW6pBbDhDnq7JjBBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=az7jYmjC; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-45dddd98d8aso4073345e9.3;
        Sat, 06 Sep 2025 06:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757164350; x=1757769150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bdMzQ/37w1OWKPKlDUUni9p30WwGaTGHwhS36vHdF44=;
        b=az7jYmjCETq/evloLen2oZmZrBNTkfP0y4TyjiyxPHfQxyHjSEtJOK7NyZtQxopa1J
         RCtsWd5KCgTproYzqGRhr8IZSpJxXc/76RcN/GXNH1E7anMw24LfJOrGga+aaMcXRAaH
         iwIwmkC5NHZ7OSM4gDJ4jABZn2lz2HNosbv5IO3xDhCUHhEL8u3JLn1RBERG9QvtHiTr
         7VvHrEVvln9i8DOD5SZ+AXfBpbXvjZahnbX8dUQ8DqC3FQWfG4woLuI4JSXrBPQQOKNp
         ubM6VAYWAqsgQssbUy9fPgRUPeH/O4KA928PgxoQLi7Q8PURVq/KV/f+SdYlb3zWiCgJ
         2Erw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757164350; x=1757769150;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bdMzQ/37w1OWKPKlDUUni9p30WwGaTGHwhS36vHdF44=;
        b=du+kxwNnkd+V9Xbb7On0Us0nOKdDas7Ss/jcHu/Eha+mOAwsDizfSSwj53r7xxjxVt
         ClvnTyPAK2e7pbC8LRZqi2NrDqeq+CAL2V3WDLKECW+Om55kvOgVplbVJ67J4o4KtqJ6
         2ULjBW/oQLXVnbeuj185LTy2F7bQAp+IQoQCLhZWwEaIHsiueXMyJZwHyPitISIdfabE
         Cyo+TRtzDGgkMR/dkt4G8DCrAFgV6wkF7XkeFJJTnLTVQwQgasEgCMBU9EBUVB8mmueN
         bNmzus6OwI1OzLglJxETzoWnUcFNxc6ukrbFwafQH17g3X0mqOgU/aXfP/O3CYIkONQK
         EjrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUumwbTmT/r+u8Gakw69Nl80NMYukPQjSz8GF/sEspNwgRsSOm1Zj2x5tgIQI1Ho8NpxjYlG+B6OE4q@vger.kernel.org, AJvYcCXt56s/lcHtfJtdGE7ZSetuFTHxTiguLsVmSDwi1ZVabWMEVzO89z/eLm2A3Lj4OsuwDf5Fv1cQNkEdpHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6hw5nriPJJ0A8GM/9YukQPhwNEpH7LgVIiJu6k6VoP7XsuOQt
	b7rba1wbtwEfpvuU6CXuBtSpQ8wfBFoHQ35Wc8v2Fip8KRsvsTwEXa+F3IB6lg==
X-Gm-Gg: ASbGncuKFOQt6rFxuZihnh+saT1r6zv2fmkhUyf4WCZnZht0JvqPMBd+wk9xbQCxtbT
	Ng4rBOGX2RXAvCbjN6kbVlAQ1rdx8mwQv5dvHj/iLyzHdWCQQX1CBtZft8P77CIcdQNUMdXS8Af
	V7uLwggk6wXEA92DgiXbZbWYsV17Tty3oUoCNJ9Cp5FbQDO/fi34ypIatFys0ozSp4+4pI3hIY1
	yGOv3bAeH5eLxvuWhFB6u/g7Meddoo1ubjiCMB5ATmam7cMukUWI+lCkEB4UHV5xYbwv1s5Z+hO
	UR3B2GHQ3jtxtbMHLFItNuWSxCAUluJ/DyQbXrkLS8NRfF3BxmCShmr3v8bct0b3b0GJucaSPIF
	hUIUFv0ydqWi1D3A95G9qLzohAzDVJXvsGUt6Ur2hrb0zeGqUtpnU6rDSX7V4hoj+OjisnapZGy
	c=
X-Google-Smtp-Source: AGHT+IEo2rNvrWBeScCg/lH0GnUrr3MY2+ETmyRIktRPgLY59qUzJNlJswu2av2X+rRnfyTOgXsWCw==
X-Received: by 2002:a05:600c:1d29:b0:45c:b5f7:c6e1 with SMTP id 5b1f17b1804b1-45ddde0a090mr17531795e9.0.1757164349550;
        Sat, 06 Sep 2025 06:12:29 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45de16b8b58sm11022355e9.4.2025.09.06.06.12.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Sep 2025 06:12:28 -0700 (PDT)
Date: Sat, 6 Sep 2025 14:12:27 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Anders Roxell <anders.roxell@linaro.org>
Cc: bhelgaas@google.com, kees@kernel.org, ojeda@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 dan.carpenter@linaro.org, benjamin.copeland@linaro.org, Linux Kernel
 Functional Testing <lkft@linaro.org>
Subject: Re: [PATCH] drivers/pci: Fix FIELD_PREP compilation error with
 gcc-8
Message-ID: <20250906141227.6ec8a775@pumpkin>
In-Reply-To: <20250828101237.1359212-1-anders.roxell@linaro.org>
References: <20250828101237.1359212-1-anders.roxell@linaro.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Aug 2025 12:12:37 +0200
Anders Roxell <anders.roxell@linaro.org> wrote:

> Commit cbc654d18d37 ("bitops: Add __attribute_const__ to generic
> ffs()-family implementations") causes a compilation failure on ARM
> footbridge_defconfig with gcc-8:
> 
>   FIELD_PREP: value too large for the field
> 
> The error occurs in pcie_set_readrq() at:
>   v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> 
> With __attribute_const__, gcc-8 now performs wrong compile-time
> validation in FIELD_PREP and cannot guarantee that ffs(rq) - 8 will
> always produce values that fit in the 3-bit PCI_EXP_DEVCTL_READRQ field.

Which is actually quite correct - in principle pcie_get_mps() could
return a small value.

What is probably happening is that two copies of the FIELD_PREP()
are being generated for ffs(rq) and ffs(mps).
The latter might be (mps ? asm_fun(mps) + 1 : 0) leading to an extra
copy for ffs(0) - which will cause the warning in FIELD_PREP.

An alternate fix you be to move the validation of rq below the
'performance' clamp.

	David


> 
> Avoid FIELD_PREP entirely by using direct bit manipulation. Replace
> FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8) with the equivalent
> manual bit operations: ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ.
> 
> This bypasses the compile-time validation while maintaining identical
> runtime behavior and functionality.
> 
> Fixes: cbc654d18d37 ("bitops: Add __attribute_const__ to generic ffs()-family implementations")
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/linux-pci/CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com/T/#u
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
> ---
>  drivers/pci/pci.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index e698278229f2..9f9607bd9f51 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -5893,7 +5893,8 @@ int pcie_set_readrq(struct pci_dev *dev, int rq)
>  			rq = mps;
>  	}
>  
> -	v = FIELD_PREP(PCI_EXP_DEVCTL_READRQ, ffs(rq) - 8);
> +	/* Ideally we would used FIELD_PREP() but this is a work around for gcc-8 */
> +	v = ((ffs(rq) - 8) << 12) & PCI_EXP_DEVCTL_READRQ;
>  
>  	if (bridge->no_inc_mrrs) {
>  		int max_mrrs = pcie_get_readrq(dev);


