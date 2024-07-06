Return-Path: <linux-pci+bounces-9863-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733C692903E
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 05:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AD781F21F4B
	for <lists+linux-pci@lfdr.de>; Sat,  6 Jul 2024 03:13:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB5DDF5B;
	Sat,  6 Jul 2024 03:13:43 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691455258;
	Sat,  6 Jul 2024 03:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720235623; cv=none; b=Ifkx8GabnlkjORIEyKFlTud3bCxmqCpzCU9ziPeFXnwYwKfoVV35ycx5RROPDE1LEfE7QF8C7060f0l1Td2JZNvGYOm4Fn/PYcsa7pfYiECYIA2aPkxPVuSkobqIFI74bufJAUY7YW0PW0r+7g1zSM+UgOf9JHuZtx5htHbmncI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720235623; c=relaxed/simple;
	bh=8r6e5VdsGSvAd/EOvHwlztu1maR/ucNt/V2Vf0VeKu8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z57i9sjMnTqKKumNGP3csHzxd8SHKrY1az854SGFGKcC2V3oyYaFvY0wnm7QUgZ7jWgWpUvZgW1y/e9JwxVBbF19NXG5cbNkUys8LNRLQQBm6hondhgVa/QiCbsVt4c2qxVcEizO+DaKDqj6Fis2a2sW4wwEZyby7dH1RzOAC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-70b04cb28acso1413984b3a.0;
        Fri, 05 Jul 2024 20:13:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720235622; x=1720840422;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l//qXY+2WrChoYJwXqVw+b5XyYvR2kjLJUxRjyCvlcQ=;
        b=Zaj0AY5JOTwOobaM2IIx4NhU8HjJ+89EI4n0nEBn+fA7MAgeZzb61yh2Tm64OSctJZ
         7GE2vZZe0mJTXx/5XzwP3hPi0dKw60X3+IY3z1mWVkMmd1y1X77tYBKw2fhsHu/aIZtC
         qvOJKP3LliOJUBcRkU6/sfJuO8pEKSbsJgCi+gwYFxlZRdYOzIruXAuHqTPruStGq4Kn
         I6pRjFqUgr5VysUr2z7TkLZZ9f/02NKinrf9SV97FH36CtS/Da+muZGOsOuq2Ih7x2G6
         Q2lbcLJ75KjfsWksFDrz0pZ8tQYc5HE1TXHwLZauZkpSD1AhaNncbT8twtrV9Sz2AF6n
         /3Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXFVJHT/2cjyGXnMFTlspAknb8gqhkYO/xaTlFvRzLBHlPm3p+MOaH7PATQY3aL2YPtoYOre1HpSe86+PuA080E0CwyNByd0uQb08KAsn2WmQ/FtDucB8j2iKNbRtyyehI9e+VDSq0z
X-Gm-Message-State: AOJu0Yyl+rmcAE1tt3WErAejWD9MDlizvmNXb+fdL3YvzgzvN/SYI8CP
	wtOQdEbPCEAX7zc2JtZEkGDwWP2MZPJfHZeap2Twqu0hVeWcJVWu
X-Google-Smtp-Source: AGHT+IEDrW1MqoaS5xkn+MIqPNA9xRfaWDarioF/FdHAR3ugt1rckOZqRsfS5mvG9NvB+TO8gU97cg==
X-Received: by 2002:a05:6a00:4694:b0:704:2516:8d17 with SMTP id d2e1a72fcca58-70b01abb578mr7757750b3a.8.1720235621612;
        Fri, 05 Jul 2024 20:13:41 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b044bdac4sm3350226b3a.192.2024.07.05.20.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 20:13:41 -0700 (PDT)
Date: Sat, 6 Jul 2024 12:13:40 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Message-ID: <20240706031340.GC1195499@rocinante>
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>

> The conversion of this file to use the agnostic GPIO API has introduced
> a new early return where the refcounts of two device nodes (parent and
> child) are not decremented.
> 
> Given that the device nodes are not required outside the loops where
> they are used, and to avoid potential bugs every time a new error path
> is introduced to the loop, the _scoped() versions of the macros have
> been applied. The bug was introduced recently, and the fix is not
> relevant for old stable kernels that might not support the scoped()
> variant.

Applied to controller/kirin, thank you!

[1/1] PCI: kirin: Fix memory leak in kirin_pcie_parse_port()
      https://git.kernel.org/pci/pci/c/1a164371b362

	Krzysztof

