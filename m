Return-Path: <linux-pci+bounces-27630-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5973CAB52C3
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 12:38:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E381B46BFA
	for <lists+linux-pci@lfdr.de>; Tue, 13 May 2025 10:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D058125484E;
	Tue, 13 May 2025 10:21:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA4F81EB19B;
	Tue, 13 May 2025 10:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747131679; cv=none; b=WFijC69yfdlupfnjx9QXFj7JkmizU9q5gtZf8GFh2a5kSgjVdvmIjYewBMzLGeFiMu1zaUc56pkWUHfnML/vSFfEIiVLarZ3N/I+BnXCaNBrn123HpCiUQiIEfoy7W8TrMht5fYOKAUbVSG796MVGOaNZ/YZnpGFM/xE77Dk9yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747131679; c=relaxed/simple;
	bh=5k3H8rwpLdmQL1SHziRgURu4VBLFsW+PKQaG5J6e3XE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F5wjv/2gwE+xU308lfvaSHulcSA4HgGFmsgeBzP9N17RJWuVlYG+S38mQJI98+gdi0rNgFKzk6/Ocvo+lTwuQDCbYe7Is8apMlnnYMGZ9T6RcIFNLZq1OyXp9Bxesq3K1sfRQmEsxjruj5Wz3IUXSqv77MT2kqSnQ037fm6iGAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-22fbbf9c01bso44187135ad.3;
        Tue, 13 May 2025 03:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747131677; x=1747736477;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=njM07VIPu3r+t/AQ2+dkXYP6XTyMcpVf8bqEy0SVLZ4=;
        b=aaGIts4uYA2Y6Wtv6/0BTnxKaFIkRvPH9sfozwCEYdhLlJPCB2FdEpXQNhDsvNAVN7
         0rQJtuvDB+69OrTLqm2HYmEldFegoEZVgnmw+g7/RXiVBr8buYsSyLDl3EYPAstN4OUU
         p3v5GhYI0JpwrZSdZ+fBkmO8iAB4XSohgWTu9FqUGm/twOFrJmUExgkiO9SHmbnFZCs3
         9qMDwYE4ZXyBI0/6HPBzd97QKkRugvokeM6D0AQ2o0KBx2+YUeLENM6uPfG7/IJuyrhY
         LF3INslopFl0PungRMpd/K1FPIXihnxxpcGtfEXO1CZZOVOm6YdSeSSHOQ3niYzkJDlU
         5TqA==
X-Forwarded-Encrypted: i=1; AJvYcCV0vyyN5Sy9eJ/V1My9sC7z8ZaEmPSJO/NHYWBeuacUsddi5Y8llBoJnZ9+/0CnmAsi1aNUx2feBp1a@vger.kernel.org, AJvYcCVJSKVhhdju4WRKTaLh0yrqW378bZRokbL+eMziR4PTLDswNYXgFuqoj1mlTH84f58xN3Kx2/2xI6tcE4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiVaSmHj+pdJOPnlbCvd6dhX3VC40g/zFyxV0NEo/VxGAWVI0
	OP0woy4/1Bsni8AEluHnck+8Hpv2kj0CBICrvvGAOdxuedqd8FsY
X-Gm-Gg: ASbGncswpckOZBoy1M/WZKilbKLTexlBr6VB1K6ktI7s9PowUSM9XjkIknpV9b7JfC+
	8lVcNrbhLpyC8UNeQc19saLu8JMUrLX3FmM42aqe5UAQuocF67yo1QfoIKQyke3skJ9kCNnHwZI
	aa6E3HxfSEjWRkvsAeN8ROQm5LbcmQxcimbYTN2jVViqAJxct8OSwjsxyV8rLkzNBxNMW1Z72L7
	ip7OTmori1x+98VAsxi0FfAE1IYvQHopDCRpEXg0TspY8vo/htaTpCIM/VWQtpGJ1TpAIrpYbHM
	VvfUAAPRc0uB21snJpOX7VgqUVC7G3w/0gaaf+2cmG5xyiV4xhnGq3k+htLBpWAPVH5gKtp0S29
	MVqMzci/Msg==
X-Google-Smtp-Source: AGHT+IHw0oqsi9/lZxlgy6Nx0dfe5Y1kDXC/F8TzYcgf+XHHBpKOKueHQq/VSm9ky9VEjewdCpx4vA==
X-Received: by 2002:a17:902:d4d1:b0:223:4d7e:e52c with SMTP id d9443c01a7336-22fc8b19402mr270413195ad.5.1747131676938;
        Tue, 13 May 2025 03:21:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc82bfad1sm78199535ad.250.2025.05.13.03.21.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 03:21:16 -0700 (PDT)
Date: Tue, 13 May 2025 19:21:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Hans Zhang <18255117159@163.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	manivannan.sadhasivam@linaro.org, cassel@kernel.org,
	robh@kernel.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v2 0/3] Standardize link status check to return
 bool
Message-ID: <20250513102115.GA2003346@rocinante>
References: <20250510160710.392122-1-18255117159@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250510160710.392122-1-18255117159@163.com>

> 1. PCI: dwc: Standardize link status check to return bool.
> 2. PCI: mobiveil: Refactor link status check.
> 3. PCI: cadence: Simplify j721e link status check.

Do not bother sending such cover letters.  This adds no value.

Please read the following:

  - https://www.kernel.org/doc/html/latest/process/submitting-patches.html
  - https://kernelnewbies.org/PatchSeries

> ---
> Changes for RESEND:
> - add Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Resending a patch is not a place to add new tags.

Thank you!

	Krzysztof

