Return-Path: <linux-pci+bounces-22783-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AAA4CC3C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 20:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A44174709
	for <lists+linux-pci@lfdr.de>; Mon,  3 Mar 2025 19:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DE322356A7;
	Mon,  3 Mar 2025 19:51:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A705F1FFC60;
	Mon,  3 Mar 2025 19:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741031514; cv=none; b=nWJrYu08cfxLEOJ7WSP4ZYLsUM+pX+tYkSBhWwOU/Ue9uTm0NZu8V97KLNSR0WyUmhChjBsNGwggQeuBO3CXgN+1Eylxj+USfq1B+4ngEsmBPTks+9gJ4i3oAb742uQ1+2Qzwm2blDCw86I8QlAT3Sx3i20hNpqdqY2IF3sAs90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741031514; c=relaxed/simple;
	bh=rS4tGKwmmJxA0t9e576pQhZJ6lWPHUT5n/rffY7QZyM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fPpjUG3EpLiwPRuJYy6r/FvZ//Hx5u4QKBDnSCluvYZ30WP4e8kFd27BUNw9/l8KPe5oh8HEn5BRp3U/QCktvhs1iPGm+KvCcwM2xqSNg3ChxPQrdwn7l8/VVRJxa79L7YQjAx2jb5NeHLHoR6u5deVQMch7MMmPXLPhUl9XOaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-22334203781so92984545ad.0;
        Mon, 03 Mar 2025 11:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741031512; x=1741636312;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k2CKI4zBybc+xDXiR4bNdoML7mcL6qio7NNqVOxcVnU=;
        b=YBY6uSrroRnFDto9V3jZItZB8Cl/DpFUSIUNJ1HwKeJBAjcAoyfp5k1S0zMScn7z7T
         B7fMXiv8pmUuIYadAvO2henoaFOFQct9cbUUUxDotyKwVuQoU/hqr5R2esRrSqkLvQSn
         fXpT76UbxFgziwAdfIDpkchgyFFmQfbfn9Bmino/VGXEPQnG/TbrbIp3KniRG3x4CWgE
         enH831orz1GAyxecxBbox5OmftKsNCGVMVVB0tpdgt6vPE4enGnbvtaiI2qqU7Jy4RkC
         /e1tn/LENEdLprmGYQvkF8MjNUF/4wx+JToBvIqXdpeEZ+/YMYQO6ayVFOvksNsPi0AA
         dvQQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRepblAPwVg9JuMG3almlZKVLOpiIKDg1yAtqxz/9OUms9mzZO2fBuWrpB+XC/zEb+wx29DNYJWag=@vger.kernel.org, AJvYcCXb/ie4xuvTuLBBGAgJMvtyqEg7W7WPwsadZ0g0Jeu2NGUS/FjFC5WvMCc14NXMwFIKhhdnorMAKkqoSuBymadHrg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx2xHjq5VU568agwTiymo98P0OFq1VRf27QV+BQ8fzOMoFRl7F
	2YezwuUIdUZvd9qFnrID9IHKygwui0s/S/wpjRhb5hCKq+7MpaYIhamJqEz46rk=
X-Gm-Gg: ASbGnctmRKRHbyspxchzjT7VYF9PWX7X8wDswexSnZZVLPrtLkGU/Rk2tLIoZHHd2Ij
	mP6r/sqnN6rlFti9VE102s5ar/i1BvMV5TUF/jqdAC9Tcp30u8dAgsJI55eBz6tEUNzM99uKXP2
	qVXUKUZq1sJArkIJijqLA/6Vc0oXRgmmzXJPBM+PkUlI9DPZ2W1q3p3slaVyJHM1BpWSleWZ6RP
	yWEa3L3UBYj7GiHLyNOG9ktMD849OOs9ALR176K5Vy5FGNQXPeJHOlLl9jrMROqslUPUmZ0VrOG
	j1hoTr4gDHQ1JQ01sJUYJxsjhY6iAUyAt2LwYNoyjWjljUspFGaMmASxLE4MyHKburqr/0D8Gx2
	FQiY=
X-Google-Smtp-Source: AGHT+IH+EFbEps/Env/viwecJzf7dRRJVQvIfNTlMDSlf181d0a4uYVPYlR1DNAdfEAQSeUvTmrcqA==
X-Received: by 2002:a05:6a00:4b10:b0:736:47d3:b2f2 with SMTP id d2e1a72fcca58-7366e6414a5mr863083b3a.12.1741031511942;
        Mon, 03 Mar 2025 11:51:51 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-734a00255d8sm9272490b3a.88.2025.03.03.11.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 11:51:51 -0800 (PST)
Date: Tue, 4 Mar 2025 04:51:49 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Shradha Todi <shradha.t@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, manivannan.sadhasivam@linaro.org,
	lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, Jonathan.Cameron@huawei.com,
	fan.ni@samsung.com, nifan.cxl@gmail.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 0/5] Add support for debugfs based RAS DES feature in
 PCIe DW
Message-ID: <20250303195149.GA1814481@rocinante>
References: <CGME20250221132011epcas5p4dea1e9ae5c09afaabcd1822f3a7d15c5@epcas5p4.samsung.com>
 <20250221131548.59616-1-shradha.t@samsung.com>
 <20250225143001.GA1556729@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225143001.GA1556729@rocinante>

Hello,

[...]
> Applied to controller/dwc, thank you!

Updated the current branch with a few missing "Reviewed-by" tags from Fan Ni.

Thank you!

	Krzysztof

