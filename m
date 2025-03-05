Return-Path: <linux-pci+bounces-22952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FAE1A4F82F
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 08:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61DA016CE3E
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 07:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357651F3D30;
	Wed,  5 Mar 2025 07:44:52 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E651F03D2;
	Wed,  5 Mar 2025 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741160692; cv=none; b=YNimkBcJeKsmASv202Z09dQyeR2Ny1EHRLhTYVWe8MJmjNR/UbgbIr7HXXQRyvB6grDbgoRe6jT75Wj2LyeyUJWX7/bhveo5dDFLEFx0a4w5zFV0Xr5DPpYQvj/AmC+KTAV4aH2zfRy90N0orvx8nc3TDn/4vtJt3nXJsw2zAHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741160692; c=relaxed/simple;
	bh=0dEcLmlYtdtIaBCfzqrBq2Ae4dODzcrZobeRn4yhLFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GF2QzSuvsCwDViQ3+zNQ6ylrDIIdFRaNUzOTokAfRjeXMr2jaEWa86BuYh6ByTnjiG+RQn+AodlKnPM4CnSWy9JxUNsr/Uw1uL8dnsqY5BM8W+L4AhEYFIy1ntlvmLNzl5Lq/nSwJrdI3Slsy6KdWArGN1/jZkHzdMYhU5AgRLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2237cf6a45dso65606935ad.2;
        Tue, 04 Mar 2025 23:44:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741160690; x=1741765490;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ViTLKygErdiplFKeTsB+hgfn7l7mcJeHlaXg11bXs0I=;
        b=ICnVA/lI15SR0GYd53vYgStM//mchS4Tf5MQFSNEHDJd9jGGXegecutAub9nxklcTY
         nPemPuhTg7A/zYw5dUpLqkBmyM+sesz43csIs9uVM0/jm1hOBhZJPAUv1W86AH8Ra0Ya
         8+Z1x+/5wTw1B/MZ9K35QJtfkuQ0bg3EQ7uZ8ZIw1JYMfgYxTmNIGOOMwbF2qc5SZhkd
         uAGGvhA8z+Gcv6UNa/ki3CKWEOJzK0zsQ8B6TJN9BNq5K0c8E0oG9n/WNW74CDZScaYM
         i1Ma998cq20KFCgzkNI02LjWijZ39d8e/O9wzX7Dyi7jhXgOhvlNfG0LjD8dsoHphgTP
         9GCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVhezIr7hROfkYJRL8nqBJGnU6z+sOfBDNkik+jdIIpg9aLklD5NPFg75uqgTZd4OWCxhVuTGWvnpYs@vger.kernel.org, AJvYcCW8ejponUAColE/HAtl2SqLifIwQo/QapfYaBg3SGvaY5bW1+ApJN8K6W0X82Ao3qtSZxpvOmBEbFIZ2seXJRKCiVc=@vger.kernel.org, AJvYcCWvOwG3RRmsDS/EHQye7bYNpDNKyEIvqXbhbOAOaZMnxJwuu8OCTNYBn4JoChGFwfuv0ADFgPaFWJ1ibrY=@vger.kernel.org, AJvYcCXDTuGJZ27AfMKoB7RyeY/aA4VXO9+BGbDBhh13HUWcHDCfU6XHg4SM/K366/xoDagzvKmR4etoeAwmrcrJWLXWTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHK7Zk9KTPKK3e+RrvrzcceVgEdmAoSJSrFz6o7FySb82Oithb
	naYeAVBQHJHw7M02rQbXT7RGt0nFMj4eZzkbCQol6IqGrtk+Xl4E
X-Gm-Gg: ASbGncvuMv5sFn4PUvcrEQ77fhlbJnCzdC5+0iBLcN+yTwjYwmPVoDthjTCDed8tPyD
	uLkU4LphHprGuOAYn2RqQRXiHVa+TAlk71FzaFL4f8rqnnWmkXzUJSf1PzioZietlW+yp8PGOyS
	mQR+QjHsQOi48pDjRy6XUfstgxO5tiyPpgJm9P8q9TLeiPiBSYtJKZKpxFyUhpWW+RgAuBAFwlm
	c7uSqBNxeIXE7gjR1JQGZQMv/G3HEVOBYpFe0fRE7FLkGZM1S7t+H8J6LY8A+Lw/pO/NnhzxUKW
	J+xjAuk2dmLMf7v+Ucg4AoV19WD9Lbg9Ijn05lNoW+Yd3z/4iiuvWBgJciXfq5fr1vrzNQ0MknJ
	8hmU=
X-Google-Smtp-Source: AGHT+IFkECmzs4mja49rj6DCPMiWTzRluzyzBjPs7V57SQJNUYO0IDGjrEZGfcUcPpPyncsq8K2mSA==
X-Received: by 2002:a17:902:f548:b0:220:f5d7:6405 with SMTP id d9443c01a7336-223f1c80b35mr33650085ad.16.1741160689723;
        Tue, 04 Mar 2025 23:44:49 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-223504c7efcsm107522695ad.154.2025.03.04.23.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 23:44:49 -0800 (PST)
Date: Wed, 5 Mar 2025 16:44:47 +0900
From: 'Krzysztof =?utf-8?Q?Wilczy=C5=84ski'?= <kw@linux.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: 'Geert Uytterhoeven' <geert@linux-m68k.org>,
	'Fan Ni' <nifan.cxl@gmail.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	a.manzanares@samsung.com, pankaj.dubey@samsung.com,
	cassel@kernel.org, 18255117159@163.com, xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com, will@kernel.org, mark.rutland@arm.com,
	'Yoshihiro Shimoda' <yoshihiro.shimoda.uh@renesas.com>,
	'Linux-Renesas' <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250305074447.GC847772@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
 <CAMuHMdWens9ZZrjNH1Bd2AN3PJEP1KSUGdiJcBCt0uPGH_GiiA@mail.gmail.com>
 <20250304154638.GB2310180@rocinante>
 <061201db8d25$dd1e2bd0$975a8370$@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <061201db8d25$dd1e2bd0$975a8370$@samsung.com>

Hello,

> I think we shouldn't move the log level to be a WARN. I believe many
> controllers might not support RAS DES feature in their design and giving
> a warn dump would draw unnecessary attention.

There will be no backtrack printed with neither dev_err() nor dev_warn(),
which is what we were using here.  Using dev_WARN() or the WARN() macro
directly would be an overkill in this case, indeed.

> My opinion is to silently let it fail unless the user is actually
> interested in getting the RAS DES feature up.

I think, what we have there now is fine.  We don't error on the lack of RAS
DES capability when the platform does not support it, and only return an
error following a memory allocation failure, which should ideally never
happen.

That said, have a look at the following:

  https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/log/?h=controller/dwc

This is how the code looks like at the moment.

We can still move it to dev_dbg(), so basically suppress any errors or
warnings from being printed outside of the debug log level, if you think
it would be better.

Thank you!

	Krzysztof

