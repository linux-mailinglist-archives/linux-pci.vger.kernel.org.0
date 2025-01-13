Return-Path: <linux-pci+bounces-19680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67409A0BDDD
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 17:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D3B168973
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328FC14A614;
	Mon, 13 Jan 2025 16:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="MCpNbqHd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68783191F89
	for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 16:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736786726; cv=none; b=WBOnsBO9jsT8/BhQcib71ZSIu3OyMP7scS6DS+TV2e9vbaveVBKsQjGa/YVxL4upP26NnfnC8a0tX04m3chfy9bPJoo3kMPjXWB40dE7QToQVO6Ki/V1RD7JISg3NZVGninzEpDdq6V20Srlm7qe0VzFNpepJH18TEqUTj6KvvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736786726; c=relaxed/simple;
	bh=GAumeAf2+5C5qoijHbeVYUKRwZ2rzp2M5Lyz6dn4AUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n2ONvCpKGVdxRleY+iTUHVRPy27TpL1S3smBL+mWTeHLpds7Npiqt1M7vVZgEL6BCqj+WnyptlDVjuo8Fbfpr4QZ9ftlt2FNC9iMr3jEyNYB3eFCs2l6V7qJ0JoUTN5MGKABsWIO4PBZV/li/LyYR5qwue9Ujf2R6zW5PJvZpy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=MCpNbqHd; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5d8c1950da7so7801021a12.3
        for <linux-pci@vger.kernel.org>; Mon, 13 Jan 2025 08:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736786723; x=1737391523; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cQhL2mF6OQLPil4TM0uc1EA1az0dYWSLTPiDCCkoP+M=;
        b=MCpNbqHd9hadeDYcTXWWibrJQaQttjwQj9o7Q7lE2DgZnRuVol1y4rWG7BodUjFcbP
         NDWdFOHZSS7ZBotvj1owuUhQlAVa/YGMQKlRcAA126Kt+3zN+Sf3gyUmsydoFZ87Ys1B
         mMd8ehlughErHYPJxbvu4VZXVkRCsgyk0htqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736786723; x=1737391523;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cQhL2mF6OQLPil4TM0uc1EA1az0dYWSLTPiDCCkoP+M=;
        b=H0sUswDmfJmOrW5SXz2xaMlqWxujRf1u/crr+uLJIDJ/UY1+32MKBoHDVZUZneE1RU
         3Sk/3uXKHU27bHzInazTzgnd5Wo9HkYCmGRXln/yHtX5HB93T9G8Pa4JDU95JtUV3+di
         ONKj0V+63ExDDKo6rJ90WhtQe7XswSfO8yZe08zDdcb4jZOKs6yhVFWqaGGw10awrlF2
         HzAu5mNl0/dAKMz/6fdbhAOKAeAKKLObQRCjFQf+6ovLuIADPGuLSZnMC0+NzZpfdrIt
         yhO8CN2YaQUoshXJaQewxWMtNSR/qd1VuHWMv3YZc3fp17andFbSjRIfG//OMtr1WnbV
         kyDw==
X-Forwarded-Encrypted: i=1; AJvYcCUa5ApbAYE2fhWUrWvRKzv0ufujwlY1UbkspMF8d60sXVMrJicmMXwloXPh2ANwFwcFgIZ5CNCyR+4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3XbeGqsU79nCXyHzPB9IoZ1ynVNvo6DNvvALVZQhWfR+ym07
	ZBVvfcROfSP7INC4xAGQF8iUV95Tl6yzRhSKwbokiPOF9yFsRQB7SpGSeNCp5E0=
X-Gm-Gg: ASbGncsm88dKbD30OsGcyWG6AG9CC7jjLaUmdunouKopl4Ti7OB1wemi6QKIvD/StqY
	GsEinpxa1nm189ACyLnu8BhzvAf1tifHIJsouBMcwDMFAZ2dJYFbVgkagd/1dLuYj5D9ZCVswsO
	a+zFnJatRRxsIuFulSf6G9O3rvPbi+MC5/ylBLjubJbZTk8kGXd+JQDjJSoGUB5vKUC/Kh232lu
	NgPvMABG5r31LelAyyAjmnCSUcD1lLvZlA5BqxZAd1RdLRnyWZvEiq/tUX+mC1FEBQ=
X-Google-Smtp-Source: AGHT+IHboldTatC3Kvev2XggrqHCZW62HtgtMcXWz1/Gh1eCBct54o6sVYa7J7MMTTePNV00zm0xNQ==
X-Received: by 2002:a17:906:6a26:b0:aaf:73e4:e872 with SMTP id a640c23a62f3a-ab2ab16a9bbmr1562074266b.3.1736786722622;
        Mon, 13 Jan 2025 08:45:22 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95624c1sm524597166b.131.2025.01.13.08.45.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jan 2025 08:45:21 -0800 (PST)
Date: Mon, 13 Jan 2025 17:45:20 +0100
From: Roger Pau =?utf-8?B?TW9ubsOp?= <roger.pau@citrix.com>
To: Keith Busch <kbusch@kernel.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C2=B4nski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <Z4VDIPorOWD-FY-9@macbook.local>
References: <20250110140152.27624-3-roger.pau@citrix.com>
 <20250110222525.GA318386@bhelgaas>
 <Z4TlDhBNn8TMipdB@macbook.local>
 <Z4UtF737b3QFGnY0@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4UtF737b3QFGnY0@kbusch-mbp>

On Mon, Jan 13, 2025 at 08:11:19AM -0700, Keith Busch wrote:
> On Mon, Jan 13, 2025 at 11:03:58AM +0100, Roger Pau Monné wrote:
> > 
> > Hm, OK, but isn't the limit 80 columns according to the kernel coding
> > style (Documentation/process/coding-style.rst)?
> 
> That's the coding style. The commit message style is described in a
> different doc:
> 
>   https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

It's quite confusing to have different line length for code vs commit
messages, but my fault for not reading those. Will adjust to 75
columns them.

Regards, Roger.

