Return-Path: <linux-pci+bounces-9865-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68694929043
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B3A1F21A74
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F92C8E1;
	Sat,  6 Jul 2024 03:18:49 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com [209.85.166.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF017E9;
	Sat,  6 Jul 2024 03:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235929; cv=none; b=o733QJmVQm56xmUcrH1iHcAQHlgeXS8CRNQ4fUIzVAvPpkEnj9/C2mM1AidQ832FAd03MKBfO2CuCYE6dcIxq9AJ7JqHG9etV65n7opVYJC1ri6M+MXsysQQ99gSzxxPYJZf0VbjlHGjFX9elfZxviSgdwaiVqF20y5oEwRnS+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235929; c=relaxed/simple;
	bh=h4cizqFn9O5/3mOnJZcaMOUS/vBBzZSS4hf7lGIrHls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6bq9iZ7cMBWb2WFLA4q96tG989KGd01qYIEjCjwgMNUNHp1ewniUs1s6ygY3pIR8KRsHNBaYz19oSaR29whw6CRBYg4zCw1yimd/CMihARKgFBHtLK3IPbdUwAhPy1+6/wYBhQy0U9kro49m5ZeKGQNBawizySHxPQxGGREpww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.166.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f181.google.com with SMTP id e9e14a558f8ab-380bfd7cdbfso9507435ab.1;
        Fri, 05 Jul 2024 20:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720235927; x=1720840727;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QHCKZwNXX6o4qojW5WLqWg5Rp/GNOhYaBfPmywNutV4=;
        b=wdfaENv5nR6Wkwm2ALRPjV+PTPZzevPQL2iCQm0uUXm9vL1UNAmPUbDqTwj6uBntxu
         H3ZDkvRHhpRUg2I+v/UhpeNKVwgCKfhxBqWOxoDSm5HeAo+r9amiIBW+5aasqmN7zD8x
         vo+qFAeKEyeIQkJ+EiuYT2oDxNfOA4PFMdobydhHVbOWmxijUPs9GP0ymVhvJQR6hSZ0
         egsBU9LxTqESXe7fI8voezq0mVtnejUB/f+WMaTzYwHVmytrnVv/Zd7mLQsZVsLVId62
         NInXSin8oFnp/hw9NLaWostQ7soy0ZCWE6JOG4WgXTPK31PKg76vwgXTbziKYVzc8+5t
         dCyg==
X-Forwarded-Encrypted: i=1; AJvYcCVOX3IlgTuIJkcNjYs2eF97LUgzegxpClQw/LgFQUPmTawNFI9M5UW20kvVD+SH9O9RIHoiozrltIdrOm10W4JmbjsfXr1rdpwhIcVbesaW6IoMx5LHPuPdGynCwDDEltmVA5HBkYL+
X-Gm-Message-State: AOJu0Yxmdp7e3ZXRXiL4NBQI1pRo/hNqn6FCYteh/l9PVJd1ud8mGAyM
	cQXiLKITspvFNsrpeXkV4s19RzXPG22VAqiwiGA4Ei/jgeFE3dIA
X-Google-Smtp-Source: AGHT+IFI4v4tQbVNgf5MeO6mGbSHK2YJUJ8IxrueBe6/1/bu9OMy5eSgTeufmptKEHxdE9ReuxsGxw==
X-Received: by 2002:a05:6e02:2142:b0:383:5ada:7a65 with SMTP id e9e14a558f8ab-3839a7edcdamr82962405ab.26.1720235927077;
        Fri, 05 Jul 2024 20:18:47 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2ea7sm147928275ad.81.2024.07.05.20.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:18:46 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:18:45 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH -next v2] misc: pci_endpoint_test: Remove some unused
 functions
Message-ID: <20240706031845.GE1195499@rocinante>
References: <20240704023227.87039-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704023227.87039-1-jiapeng.chong@linux.alibaba.com>

Hello,

> These functions are defined in the pci_endpoint_test.c file, but not
> called elsewhere, so delete these unused functions.
> 
> drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.

Applied to misc, thank you!

[1/1] misc: pci_endpoint_test: Remove unused pci_endpoint_test_bar_{readl,writel} functions
      https://git.kernel.org/pci/pci/c/c22359447a19

	Krzysztof

