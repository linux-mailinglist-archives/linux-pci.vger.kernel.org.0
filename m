Return-Path: <linux-pci+bounces-20922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92841A2CA70
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 18:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 361AF168CA6
	for <lists+linux-pci@lfdr.de>; Fri,  7 Feb 2025 17:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF1719597F;
	Fri,  7 Feb 2025 17:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hVQq5HUg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1156318E050
	for <linux-pci@vger.kernel.org>; Fri,  7 Feb 2025 17:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738950143; cv=none; b=ryssEthMK+u01w/pynWK5pfRfcEjOuE8Pni5sq1EV5jC+k+rLTBGwZuRHHmwmoS5VO+TgdvbLnV0aVMiIr3VgZkwM2+uzJo/m35LC4/R7t4bwnZmygUNNhMi/bf3MApjujLboL1fihQKwv9YJpzvdFN6uDvQWxwZor1bRHdWu2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738950143; c=relaxed/simple;
	bh=V+TOaV5qdmU9SIRsToCl8KcD83Gtj4THu6wwGrTpqwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNan/HZjBZvPvWc6o56769jCqvdktvuRve0xj2xPVOREV6hCqYqWFNTBLCS6OfCPqzP+XjiWBMMPIr3zkrYHmwme44C2tGbEJUUXHGN7Z0yLJV60zBq39bjAIaRXrMeeeFPGMoegbAmsQH2V5HGg6rxbiPRcE8Bzr2jCVGz6q0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hVQq5HUg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2166651f752so53533585ad.3
        for <linux-pci@vger.kernel.org>; Fri, 07 Feb 2025 09:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1738950141; x=1739554941; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=m1q/NMsxfkxaHPOgWZWtDFb3oS/ioGl5xgxP5qKiYDA=;
        b=hVQq5HUgwcfAe4YXMJnU2Ebr1oEeQyDLf2nOrKcOXstCffG4+iS4NZsKCgnp9Gtv3E
         2ulhSx7ee1+52jfesBDzQ/ldPpakGaL4HBT4xvUAQtzzrQ48i1NdcZYusuDXSJnv5MFX
         pmBUMe4rNOkDKJGNca+3x0h8i3/y27eKehdCwxzM/U+HBg2Rf2s/iQ7xVWYjQ9ffLWO5
         vzU+JESGkMrOgK96p/h+do9lRHcNfug8OKEFqKmlxsIHAopw0skIhUBi1alSRK81OCJ2
         Agf09Af/maZw3CWYJHUIM+d65xzlgcb/yGaQDi7rBWsNsGb4VglYIklT4JQA7/WrCiDV
         GRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738950141; x=1739554941;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=m1q/NMsxfkxaHPOgWZWtDFb3oS/ioGl5xgxP5qKiYDA=;
        b=fpHHSzZ4ndFDQBUoJ6j0JjW12IIzzxN1WhcJ8bV5dJFHSyDqYRQE+yzTEYAgYa916U
         pJl61h86fGBkONtqRWNEUgJblPEBcCRugSE8PFqLyggwTtIZSB3pf64NHQBE6PsFX89e
         w+VoD9Rf/Zus6rxTc2OeM7KsVkDgAXVgq9eraJg11M1xE1kKAhriPN3U11S3ol2Zgy5q
         katPP5pbuPPhVCyJEFowOnlnpaM1hq0eVI/V5VCnuY9zF5AJFvxFnuf41Hfyb+c9XB5X
         4hum0TNBMbNKoBKAfbqjxnftsfzn+KtHI8eLRBr4wwZZ3xagz+9HtjjozuUHXzBiBrZs
         VkFg==
X-Forwarded-Encrypted: i=1; AJvYcCXAW0HrWQKICHZRsaVJ8ziyUhvGkq35hTVi7jU+5vf1E5P7YkrYtfmh2c9d3V3TNk5CW1Im44vxI6g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxypTm35uaeFByrKG6hV41HqIDKFMOL8uAgNeWJ23jzslip7mU7
	sSCzwLSrS2rZ0+yAUjkfTr/Yudfv7jYJt3g6qv3gbMsD9ANvWSJuM10ms4rGXg==
X-Gm-Gg: ASbGncurkMu33Jva5uYtqXti4TzN86m2NJzBVMaVZ8fvMJvphFqn7doRgQHTU2GLuDB
	dFkWPXDFyDTpJkOkUVsSKiv6cEoXp1Mo3RKmCGQTOJYL1OhCj84vmW2IZromUG9tD4YulqCjsf5
	yqezOtmk6NJdC4vfZmjnwTFXuaLqlijdrWTTKr2RZxEq/LJ3HGwTGii21fegVoybZw+bo4e9BCQ
	T2cszIwPehDwTLuZ820cRn68FgqYabFbaGtjQbb4cSJ29utxpjUbZ2kQmPz5oBzAHIFAiBFJrC/
	S6NQu/edUyfyfvRyx38jYsbfvg==
X-Google-Smtp-Source: AGHT+IHKVnEp41E5iC5LME3eaGpBcGT/WyvCoALxNdXsgOqSoWBPVx/pKaTy0lP4GqNkJVL+Co/j9Q==
X-Received: by 2002:a17:902:ce8b:b0:216:7cd8:e964 with SMTP id d9443c01a7336-21f4e6dedc4mr66020495ad.22.1738950141299;
        Fri, 07 Feb 2025 09:42:21 -0800 (PST)
Received: from thinkpad ([120.60.76.168])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f3650f087sm33672085ad.6.2025.02.07.09.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 09:42:20 -0800 (PST)
Date: Fri, 7 Feb 2025 23:12:17 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jon Hunter <jonathanh@nvidia.com>, Frank Li <Frank.li@nxp.com>,
	Hans Zhang <18255117159@163.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] misc: pci_endpoint_test: Handle BAR sizes larger than
 INT_MAX
Message-ID: <20250207174217.i5sgoxf7rikwrmxq@thinkpad>
References: <20250124093300.3629624-2-cassel@kernel.org>
 <20250201160154.ih7qhpj2ovjtowcu@thinkpad>
 <Z55cNWKi8+9h9rUo@x1-carbon>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z55cNWKi8+9h9rUo@x1-carbon>

On Sat, Feb 01, 2025 at 06:39:01PM +0100, Niklas Cassel wrote:
> On Sat, Feb 01, 2025 at 09:31:54PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Jan 24, 2025 at 10:33:01AM +0100, Niklas Cassel wrote:
> > > Running 'pcitest -b 0' fails with "TEST FAILED" when the BAR0 size
> > > is e.g. 8 GB.
> > > 
> > > The return value of the pci_resource_len() macro can be larger than that
> > > of a signed integer type. Thus, when using 'pcitest' with an 8 GB BAR,
> > > the bar_size of the integer type will overflow.
> > > 
> > > Change bar_size from integer to resource_size_t to prevent integer
> > > overflow for large BAR sizes with 32-bit compilers.
> > > 
> > > In order to handle 64-bit resource_type_t on 32-bit platforms, we would
> > > have needed to use a function like div_u64() or similar. Instead, change
> > > the code to use addition instead of division. This avoids the need for
> > > div_u64() or similar, while also simplifying the code.
> > > 
> > 
> > Fixes tag?
> 
> size has been of type int since:
> 2c156ac71c6b ("misc: Add host side PCI driver for PCI test function device")
> 
> But I think a better SHA1 to use as the Fixes tag would be:
> cda370ec6d1f ("misc: pci_endpoint_test: Avoid using hard-coded BAR sizes")
> 
> Which has the one that started using pci_resource_len()
> (while still keeping size as type int).
> 
> Perhaps this can be amended while applying?
> 

Sure.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

