Return-Path: <linux-pci+bounces-22858-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B98A4E3AC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 16:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEA1D171305
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 15:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6F824EA8F;
	Tue,  4 Mar 2025 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gBIbM/7U"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563CB24EA96
	for <linux-pci@vger.kernel.org>; Tue,  4 Mar 2025 15:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741101506; cv=none; b=mhMjENPULNL+SVt1GEnd7/Szc4lNN73egtD32Ls6xCGFbriYY8TZ7u1D9zB75NTQFcpm8L5baTWJoudLsZU8Yk34teQZDvyNmwiitbI0iwzX+xBmMqzrQlnhitRtCexG/El2RDXQGh/xBfXT1Bkw1n4UKUZyO8E/m9zTmB6gxXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741101506; c=relaxed/simple;
	bh=Nfbb4Q2xiDkH6WLiFI7e76Q6PwRDTA9H9+XvuWdYO9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iiBg8OJ5gYp1d+jg0GTAHW7uxMgkFUK79hdbZ9+fxsrqsPCoSQNq1P9HJjNqIv5ZLM7fo/jPobIjZK535A29ZYVbTXc94zkONwRF3rjll9dc+zYDSqns08k6s0XOcqFzNM7vHSskTTi1jX//Jjrfk0fKmXnnRs2f5wPHaHW5oj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gBIbM/7U; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2239c066347so52165055ad.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741101504; x=1741706304; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KzhE+tdJAYWvPcPUwSdrS55NblQcSF6sK2zBz4cziEo=;
        b=gBIbM/7UCn3d+kG8XQQpXgjv6oo4359Az4NnhRvQG+OrZfNy37HWbUI6mXw5KqCHhH
         TN/VygfvNKNe497X57clJASH+VZQaIHPlbwaiW25ebDH9QtnXib+9HHy7Y7VFEiCJc+0
         U6ORj5nJcfQTJnuISlGSu2QKJys2DcjF9JWIjL2ZDYXn0GW5v+baNmvKmzUWgSviPKUa
         +pz2PZJPk1H6e0PFFtX+/9JS+ayLoZlPhgkvw7FqIaZ3vpHaioJX/BrbbMaNU3vxZUKi
         mA7vfCrejLi428a5pJ8iKs16cicAo9+tgbEkDiktMQHaJK8sJcird1xYiJfZFyBJh/HC
         0m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741101504; x=1741706304;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KzhE+tdJAYWvPcPUwSdrS55NblQcSF6sK2zBz4cziEo=;
        b=FTBmTpS2uisYqTmnSgILYiB8+z9Ywp64AEsbuFvetwR+fft6Ui9pw1sCTYx/xkhqT8
         /4xBDrhuNh/a4QLOrUhyoXTqf7paBZ2SdaRL8+mahait70R73iHyx5hDwoJ1X0JfCDvY
         +ZM8gLNqNfMDjawh3E4AcYQI4RUf2EU9def92qYqz7vhrbxZDxGIkxDUbO9P3Y1NhDAO
         5M3Xhhgs2JmWBzfQnL9Co8NdPeobP0j4PhHVbdFqM6yv2WOXKxWMXwAJSchT+wANvAdg
         2ETZVePjTsMsOQyPZGF2fufKLeA53pkYbC0zQA9w3fPmlbOrgJ/Wm3ytRFpDuU7OaYB+
         R4sw==
X-Forwarded-Encrypted: i=1; AJvYcCUqk7T6e0JzeYWo1VCgCagtMzRYKnPt2p5cttC8AWapZ9kYKojz5k0MXq+ZU+vJlaIbqAl5f094uRg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL12MRlehyAOWxhQujp7CfODPyC0kBXsmAEjUyTpSk0Y+4iQwM
	GSDeqxIhCh4iw/L/YEt5PmOqchipYy7VENOz/CRZ01mgdGClPedgPFliFUwFnmP/ZTniFGVvJUM
	=
X-Gm-Gg: ASbGncu7ldYmlqWnRVAyVD+lZ6lESMoZzaXlHwBLwE9pvWnv1LzY2IpltJsHQDSlyWQ
	z5ZJfB7tx2sPPjzzMiyvH4kzCTXeQ3nAmfsThzVlPJVDLxXv1EKeajR5q+N+yNr7cSKGHTyPhun
	8b4cj2NMz9ZIdGb9TJcfD/44lUoropJ4qPOCd/SdPUdOsd06c3zmhySm7Rhf7UzeVKguFWiuHY4
	u5PwpyQWL2DwTqHWaMLoPQM3drF8y1cNoMiI5JoZ3ykSpbN9G3LTcYGW6Xf1Tv5daX8huZRJVBJ
	qL6qVkkY4sH6/dumvTjEmCLn60FnTbQd7V5gJjpIx5JMyP1osSQe9dg=
X-Google-Smtp-Source: AGHT+IE5m+vrO6nNhOZDvuax+Cu982tB5v2FtygKBkyOtqqZSXWNrXN1iB/dSPoQj7bI+IrEJ3ckng==
X-Received: by 2002:a17:902:e752:b0:21f:45d:21fb with SMTP id d9443c01a7336-22368f61965mr234071745ad.3.1741101503081;
        Tue, 04 Mar 2025 07:18:23 -0800 (PST)
Received: from thinkpad ([120.60.51.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223504db7a6sm95889145ad.160.2025.03.04.07.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 07:18:22 -0800 (PST)
Date: Tue, 4 Mar 2025 20:48:14 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Fan Ni <nifan.cxl@gmail.com>,
	Shradha Todi <shradha.t@samsung.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-perf-users@vger.kernel.org, lpieralisi@kernel.org,
	robh@kernel.org, bhelgaas@google.com, jingoohan1@gmail.com,
	Jonathan.Cameron@huawei.com, a.manzanares@samsung.com,
	pankaj.dubey@samsung.com, cassel@kernel.org, 18255117159@163.com,
	xueshuai@linux.alibaba.com, renyu.zj@linux.alibaba.com,
	will@kernel.org, mark.rutland@arm.com
Subject: Re: [PATCH v7 3/5] Add debugfs based silicon debug support in DWC
Message-ID: <20250304151814.6xu7cbpwpqrvcad5@thinkpad>
References: <20250221131548.59616-1-shradha.t@samsung.com>
 <CGME20250221132035epcas5p47221a5198df9bf86020abcefdfded789@epcas5p4.samsung.com>
 <20250221131548.59616-4-shradha.t@samsung.com>
 <Z8XrYxP_pZr6tFU8@debian>
 <20250303194647.GC1552306@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250303194647.GC1552306@rocinante>

+ Geert (who reported the regression in -next)

On Tue, Mar 04, 2025 at 04:46:47AM +0900, Krzysztof Wilczyński wrote:
> Hello,
> 
> [...]
> > > +int dwc_pcie_debugfs_init(struct dw_pcie *pci)
> > > +{
> > > +	char dirname[DWC_DEBUGFS_BUF_MAX];
> > > +	struct device *dev = pci->dev;
> > > +	struct debugfs_info *debugfs;
> > > +	struct dentry *dir;
> > > +	int ret;
> > > +
> > > +	/* Create main directory for each platform driver */
> > > +	snprintf(dirname, DWC_DEBUGFS_BUF_MAX, "dwc_pcie_%s", dev_name(dev));
> > > +	dir = debugfs_create_dir(dirname, NULL);
> > > +	debugfs = devm_kzalloc(dev, sizeof(*debugfs), GFP_KERNEL);
> > > +	if (!debugfs)
> > > +		return -ENOMEM;
> > > +
> > > +	debugfs->debug_dir = dir;
> > > +	pci->debugfs = debugfs;
> > > +	ret = dwc_pcie_rasdes_debugfs_init(pci, dir);
> > > +	if (ret)
> > > +		dev_dbg(dev, "RASDES debugfs init failed\n");
> > 
> > What will happen if ret != 0? still return 0? 
> 
> Given that callers of dwc_pcie_debugfs_init() check for errors,
> this probably should correctly bubble up any failure coming from
> dwc_pcie_rasdes_debugfs_init().
> 
> I made updates to the code directly on the current branch, have a look:
> 
>   https://web.git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/dwc&id=1ff54f4cbaed9ec6994844967c36cf7ada4cbe5e
> 
> Let me know if this is OK with you.
> 

If the SoC has no RASDES capability, then this call is bound to fail (which will
break existing platforms). I'd propose to return 0 if
dw_pcie_find_rasdes_capability() fails in addition to this change:

diff --git a/drivers/pci/controller/dwc/pcie-designware-debugfs.c b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
index dca1e9999113..7277a21e30d5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-debugfs.c
+++ b/drivers/pci/controller/dwc/pcie-designware-debugfs.c
@@ -471,7 +471,7 @@ static int dwc_pcie_rasdes_debugfs_init(struct dw_pcie *pci, struct dentry *dir)
        ras_cap = dw_pcie_find_rasdes_capability(pci);
        if (!ras_cap) {
                dev_dbg(dev, "no RASDES capability available\n");
-               return -ENODEV;
+               return 0;
        }
 
        rasdes_info = devm_kzalloc(dev, sizeof(*rasdes_info), GFP_KERNEL);

This will fix the regressions like the one reported by Geert:

https://lore.kernel.org/linux-pci/CAMuHMdWuCJAd-mCpCoseThureCKnnep4T-Z0h1_WJ1BOf2ZeDg@mail.gmail.com/

- Mani

-- 
மணிவண்ணன் சதாசிவம்

