Return-Path: <linux-pci+bounces-24940-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACDCA749DC
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 13:36:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BE1117416D
	for <lists+linux-pci@lfdr.de>; Fri, 28 Mar 2025 12:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CC63214;
	Fri, 28 Mar 2025 12:36:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D392114
	for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 12:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743165380; cv=none; b=kuaopUSUQSxV+RigMWsYdClIpXtLlwue8UOQrpJmKnpNHyogaDqfngBlqmWOj0qaUldZS1n91yY4est4IP4kqrNDDpNDraLZHrDLJiX8h+A9qs3TNcWzifkz/rUc6ezvarh7CYcOA/ChhvYlmTtT6l19Hh+yx2/Yg8RIOUZ0mrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743165380; c=relaxed/simple;
	bh=58rlVG+UafEp2amykNW/TGXIsJ0vnF8LyuTZ1I81Pgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+jR1SskLYKRanC3B8XRoR3oSf1dHy8j9VEHtseeH3FaXlgcNlyBoMzdRFfQ0zaLPguBwzXQzMz/PrMWnUk1z8SZ1tILhkNgJTbhcXT3gBFJBeS2mZpqQf/YKoHiTx9HJJaud8hrRP5qGHLkc8O8YJz4U+raGaN8xVzjlCHxvuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-301a4d5156aso3288128a91.1
        for <linux-pci@vger.kernel.org>; Fri, 28 Mar 2025 05:36:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743165377; x=1743770177;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s91gS3ZTf8YeYYH5MnclAC4ck1ph3hH5lBLldv1VsOA=;
        b=Qut+KqhZET5CvTD2RkwkL0GnjOnpsQ7lGx2tsPU6nb+Bm/FHte8XpfL7cHPwKMYrbJ
         0ma3y677GK3BClxj4P4wGu7y715V8/4hn+SlWQNDezoON0JX3GmCMejwru4KOYtMb9Yf
         jR1l6iG3w2jJlHnulk9iNxAj3qLj3UouK4ezgcWBEertoyelX/VQHcKsp5MmYDS77kzs
         tjG8JRUdSbLLGSAGW2FlcW/xU3UTwIbFQuThZR7xqQDXzgRub3KdQ+mCGFdxIt5R3PD1
         Lo7Qgxgxnj9SChDU0WoMzxRdSq14lQsgcE20dj+uPtx0uoKhP5fAy4JAiWxvxxfFrGAp
         EH2A==
X-Forwarded-Encrypted: i=1; AJvYcCUaBW7vKDlTbNMEjKrPOuDM2wISgKqLAEjAMcet/8JTqC/FERCqsc5WnZv0Aajnqiip2PTlEAooYn0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqCztYhEFFURwLzyC8i+2DwS1KbIB9JIKTI6EvFfxkhFY3ufU6
	MyLi5E/A60bvzMY2tSdne09cjFiIE9yn0EmH6YIbFgBJUAskDTVoe7IvoPdV
X-Gm-Gg: ASbGncsBNuGhv+nyBZKJ1zA8jys1e+4+ou40U5MC1y4LXy8Q5nGuHJZVw6dXtPkGsDY
	f82Zk4+3PfqMkPmRiUPnaC3K/WEb+afb4xWyJ19zRKRuGOg5DOroul6eQmMFGpsI7LiKMC425dp
	1LCeOppyqN/ZEKrJMKdea3EKnA15X8KsA3pIdNbQo3D33QtlQnHS/oX1elenfi8oeSpSpYF2LMP
	bNyaQhbjw08UMUt6u9lwBB7rTdzheQ7wQpA9y6++2IxGhuoDTrzvpKeW6BLf+ycnhKkaVomb558
	V8fzAwDB56ggTMPEINfUv7ZgB3+lLC0TxHqjxqW/o4PkdXOy+lPqsvaBa7/7ufBdNimNZjEM1L+
	zybPMu/JSyHlmEg==
X-Google-Smtp-Source: AGHT+IGlAd66FNmavdbS7CR1qNFbwkljXHkJb48mCAC2R7hMVIyBsmG47UAORbPRGzD6ZvlyCmfhIQ==
X-Received: by 2002:a17:90a:c2cb:b0:2ee:d024:e4fc with SMTP id 98e67ed59e1d1-303a8e78b3emr12478191a91.33.1743165376962;
        Fri, 28 Mar 2025 05:36:16 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with UTF8SMTPSA id 98e67ed59e1d1-30516d61686sm1690708a91.22.2025.03.28.05.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Mar 2025 05:36:16 -0700 (PDT)
Date: Fri, 28 Mar 2025 21:36:14 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] PCI: rockchip-ep: Mark RK3399 as intx_capable
Message-ID: <20250328123614.GA1188225@rocinante>
References: <20250326200115.3804380-2-cassel@kernel.org>
 <20250328122123.GA1187318@rocinante>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250328122123.GA1187318@rocinante>

Hello,

> > RK3399 can raise INTx interrupts, as can be seen by
> > rockchip_pcie_ep_send_intx_irq().
> > 
> > This is also in line with the register description of
> > PCIE_CLIENT_LEGACY_INT_CTRL, section "17.6.3 PCIe Client Detail Register
> > Description" of the RK3399 TRM.
> > 
> > Thus, mark RK3399 as intx_capable.
> 
> Replaced the following commit:
> 
>   e55c67837a8c ("PCI: dw-rockchip: Endpoint mode cannot raise INTx interrupts")
> 
> With this one directly on the "endpoint-test" branch.  This is per the
> conversation at:
> 
>   https://lore.kernel.org/linux-pci/20250318103330.1840678-6-cassel@kernel.org
> 
> Thank you!

That said, Bjorn is preparing this Pull Request, this might not make the
cut at this time.

	Krzysztof

