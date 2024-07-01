Return-Path: <linux-pci+bounces-9502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C4791D9B2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 10:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC3491F20F89
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 08:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A79897D095;
	Mon,  1 Jul 2024 08:10:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2858881AB4;
	Mon,  1 Jul 2024 08:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719821432; cv=none; b=oP2B5vv441EzVUGnhh2ZuHsfosEkZexr6kyohpnFZLOruoEfpUvE/xV9X/vx1KNIu3lRirA8vQ/IRydGd5T6SLrG+vfeZ630kvUrFl4JcqG/wzj/MKsDJpqPVtPPLWz5Rwahuun38MJE0ixdTNtvgDheN19GWP3FtQr1XvZ512s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719821432; c=relaxed/simple;
	bh=wrliNvaB7WNZoEVe45hopQEZZ3ZXy9IoZeYgQ0J/6QM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NTZ2Rg0TOH7lRVYk+GZM+W+aIewA3CTLUpLC80TCVWMoz26XrEy3mEaI7xoSnMMdZY8CafZ9OlrjqO6VD0YJZqe5yh1Z2uvTy8rHljRIaScXeasYBi7scaQVB+bV7ugNSB/j/v0/zfG9EqvfumAVAOMoWn9003y9cW/tWayMo2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1fab03d2f23so17994515ad.0;
        Mon, 01 Jul 2024 01:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719821430; x=1720426230;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b109jZvSI9enMLj/a9Azw6t61SkYdoZr57mQw+e9Y80=;
        b=Ot0iu+505j/H+SidDc262S21wjfunUobw1tHSS01H2hqew8f4Q9t5MNR/N//6aSxHZ
         4jwsFMXpnJ0vipDE2T2is1Q+E/BzS7AAZ6MHVbks0HwAZZ+Cc36eEqbMT35fbuIg87ZJ
         RakotGpmijD4Jezs0eqISnm9jNkGzaKTwtuqIF/oGwHF8T421Zfu56l3X2aaprr9gjRs
         moFVnldlOX6A01U9gcxxhiXu45Um3WzCilRqcHJ7RMf8k453XMrXSfmI4psioG4wGJQX
         TxasaBPlFw3mXTnqkihSOvQU4PA48Hym2z5+I/8W6V2uJmzrgkc4vTDZLb6BsaqkyNgA
         UTnw==
X-Forwarded-Encrypted: i=1; AJvYcCWreEO7RdVhcMgT8dUkYqJ0XhMooxZeYW82rfk7WuaA3Z25NlwHGDMSYiigSlG2G+MSmBFtgw5Nq+dFCKMWsHPFJjl7epKwedJWiGrheioFEOaLlM9PlXO150rA3jgXki2P2QakS+kt
X-Gm-Message-State: AOJu0YymVqw+Gfaf1uWdv6SC0rZ8Uw5M7etMaxRTtPr5YvzI+421mxWE
	UPavwrk5HiPDkEoCdLtrA/Xnd/WrToMaeIc41/npmyANgv8J8xanrhal7oqT
X-Google-Smtp-Source: AGHT+IFEluso38K5Kxda1/buzHviB4ehPtjvlF6Gj2Uz801GLttJxFqt1LFadAU32WwafSRurW8L9A==
X-Received: by 2002:a17:902:784c:b0:1f7:2091:978 with SMTP id d9443c01a7336-1fadbcaaf4dmr16151215ad.37.1719821430325;
        Mon, 01 Jul 2024 01:10:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1596675sm58092125ad.249.2024.07.01.01.10.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:10:29 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:10:28 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: manivannan.sadhasivam@linaro.org, kishon@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] misc: pci_endpoint_test: Remove some unused functions
Message-ID: <20240701081028.GA2509636@rocinante>
References: <20240516083654.44087-1-jiapeng.chong@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240516083654.44087-1-jiapeng.chong@linux.alibaba.com>

Hello,

> These functions are defined in the pci_endpoint_test.c file, but not
> called elsewhere, so delete these unused functions.
> 
> drivers/misc/pci_endpoint_test.c:144:19: warning: unused function 'pci_endpoint_test_bar_readl'.
> drivers/misc/pci_endpoint_test.c:150:20: warning: unused function 'pci_endpoint_test_bar_writel'.

Are you sure these aren't used?

Index File                             Line Content
    0 drivers/misc/pci_endpoint_test.c  143 static inline u32 pci_endpoint_test_bar_readl(struct pci_endpoint_test *test,
    1 drivers/misc/pci_endpoint_test.c  296 val = pci_endpoint_test_bar_readl(test, barno, j);

Index File                             Line Content
    0 drivers/misc/pci_endpoint_test.c  149 static inline void pci_endpoint_test_bar_writel(struct pci_endpoint_test *test,
    1 drivers/misc/pci_endpoint_test.c  292 pci_endpoint_test_bar_writel(test, barno, j,

	Krzysztof

