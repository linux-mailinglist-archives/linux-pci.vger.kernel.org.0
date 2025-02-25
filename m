Return-Path: <linux-pci+bounces-22350-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6F2A44390
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 15:53:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D347D188F9F2
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 14:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83EA21ABB0;
	Tue, 25 Feb 2025 14:48:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6DD21ABA2;
	Tue, 25 Feb 2025 14:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740494881; cv=none; b=ni5OBXNxh/w/va/uHjYrML7qifBPLNiPiGdjbjXnO3TbGgsC5uHE/ZGTNHCUnC6xbM6FJGY5962ZwwS+Yu6Da3DwWDCkRlqGz4jBx/4FNwQsZ4OEN9/ZUPa/a4LWmLnkeNW57Fz+g2uZrk9FHaIcF2lumaLAtLn2vULfrmOoQ90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740494881; c=relaxed/simple;
	bh=mdUuuqIXJweoUeEecxQyPPnc+0OGiJKwMkgKfyVt1BU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsqdnhZAbiQ4WmqTxPAdYx2mrRM4xUA86yuKfze8gB8Zw2pTBw/I/nQZFg3p2KolWAAO1ltU+S6Rv/xyWNRFFZNYvOpQzDHAm/rv5vsimiL2M2gCm+zJURU7Qf2K3Xhghlt+xShN1IfW5id3AZHe9u9qbuIuuePM7rR+PAZVaHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-220bfdfb3f4so14706045ad.2;
        Tue, 25 Feb 2025 06:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740494879; x=1741099679;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H9fUAMMSFfpBE9zde4jyNVpOAHmdzHBHI3cebG5cFgg=;
        b=nrNNMmDMHs5+UF/RuVqU6WDHe8CcNGAs0w/0rm3i++GAsnt0n8qOynz5PE6brjH5OH
         eVWDDCjkLtniavTQZtA+0WXbyPGfqS5wh1HDfHuJVr2uoszwwSzwDcZ9/JbfDWNgvYay
         W/KPwb+ZSu0T7lVJ/nSWES7a4C0ji7dkoM3CQ+twSuJ1fworsfhw6jYX6G98Pf4IfnFM
         VpFL2JVEPvvCM+lj2eptoz+zCCacjbnCOUOXpeU3Q1LD4wLS2aJqUa35SRTe0Uv8pSJN
         kA8fEGjhh1lUE59k1q1XTErPzZyirTMrHX/EbpQH4XEx6M2eYUVoJ7ng1mTy4W4UBXNc
         PYog==
X-Forwarded-Encrypted: i=1; AJvYcCWy7Km0UqFgWUD8D2mJugI5zrzEeMyx9cwvhNVMiBzCAsC6QQ+Uf3NTrQPYtnhZSaKOykZJa3T1vOpuwFAd/NkcuA==@vger.kernel.org, AJvYcCXAxkeqgDwR1pGR047dcktUsWA+5F6Cz8ucYxkAUJfF3ZaxOfKHdvcobsf5WVEGAqM8XedHfPUYVrU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx2yiGPiuYFkN2lyCs0Jbhr26D8TFG5HXRRQrw7iCEfCg9ZrAM
	4amircMt38W8o3P8ZKgA7ebbLOw2eXK04Czrca1Gh5VGeV65K2pI
X-Gm-Gg: ASbGncu1aQ6B2Hn4Di8kHtrjInQacCVkfSUu0Nv9MPe0Et0tAEasYGjbklg/p3hs/xZ
	Xe/JPF2pOhKVuEthUVHiBrl8RF/O9x329lGKbnhBM+V5Y/N2qQ8XRBXhlCdjUqXBr0WkVMHDdWk
	FM2T4zZgT8U4LZ2/ZhHFbOZ8UR9nZwDargrFdWtsJYmx7w2hq7XS022aqX1+NKDvgn4dzIk4zFB
	6CJThRBqnBFl/qAyp7GRfk/e/hdzZc7tNCWkEJ741Y3VjxqSE7qm3Ks/9wCHtaYgGeglph5UUbw
	h9Kd9I3BvGfq6zQd/FtlnPPmOZJASwePosk1aBjfg798qogzFIfDZltICGJ7
X-Google-Smtp-Source: AGHT+IFJlOv8carYE6+UU235OdYaIvzKkWJV3Kr/Y5yUb/0j804xN8YoKlVnPeDtE+lBocpwiZJ8YA==
X-Received: by 2002:a05:6a00:c92:b0:732:1840:8382 with SMTP id d2e1a72fcca58-73426ae9b30mr24918884b3a.0.1740494879299;
        Tue, 25 Feb 2025 06:47:59 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 41be03b00d2f7-aeda7f8538fsm1488011a12.31.2025.02.25.06.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 06:47:58 -0800 (PST)
Date: Tue, 25 Feb 2025 23:47:57 +0900
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
Subject: Re: [PATCH v7 1/5] perf/dwc_pcie: Move common DWC struct definitions
 to 'pcie-dwc.h'
Message-ID: <20250225144757.GA1660448@rocinante>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132024epcas5p13d6e617805e4ef0c081227b08119871b@epcas5p1.samsung.com>
 <20250221131548.59616-2-shradha.t@samsung.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221131548.59616-2-shradha.t@samsung.com>

Hello,

> Since these are common to all Desginware PCIe IPs, move them to a new
> header 'pcie-dwc.h', so that other drivers like debugfs, perf and sysfs
> could make use of them.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Shradha Todi <shradha.t@samsung.com>

We are still missing feedback from the perf maintainers.

Especially, as I would like to take this patch via the PCI tree, if there
is no objection.

Thank you, Niklas, for pointing this out.  Appreciated.

	Krzysztof

