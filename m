Return-Path: <linux-pci+bounces-19872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F3FEA12266
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:21:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C15CD16A8CD
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8010B248BA4;
	Wed, 15 Jan 2025 11:21:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2122B1E7C27;
	Wed, 15 Jan 2025 11:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736940082; cv=none; b=rZmbkcDlUGsEeFj1DzkLJ7UZnLiUlfkY1JRb7voNE3xbHKRXQk6gOBwYTIBFsd0kepSCqyp+bXhz18/0VBmvQ5hRyTIjxbGuAsQT6iclmrlMeixpB8SVyKEQxrgC5tYaivkZxoVMt68/6bUIrcLtnu96FHhYOXntqjrOpJWKD+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736940082; c=relaxed/simple;
	bh=8j97D77Rnuh/R2Bz2RcI0Ehb5Zxkt1oOzwCZU7vicds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uClF9kRfGbSSN5Hvxhd7IGIDWXFRGH44bZntQDrG3vjLE2svnU1bXTPs/F0iCO+rNcuMr9vXnMx77VxOffRi9n9uHJm5XCmbMURhlYRMB4BKLLaOeyn+pk7SlwiN6F0RaB4E7fS92Aa6VB2ct2/5tuwJncGGmY3JER42UyNCTx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2156e078563so97100475ad.2;
        Wed, 15 Jan 2025 03:21:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736940080; x=1737544880;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YLQuxskwftLxrUGoW37+bJoXYY1LOrhAddhCqCUbJNE=;
        b=JTZnbVfpCr+9gfBltWxcVwxzrHtqmIiqGitP4Xz4dt5/n+T0PBSSieh3TFGvJlcUqF
         45GU/XAIXxv2uPnZPgCVTxf7l/b4fZ7nv8RMQ/w73Q9wM05gq6YdWyDMquBNTY7j4VJb
         zbJ0B92vHfgxjPK6IHUDnB/mVpJeG1o2rnD4Xvld9mNgNP0zyrF94DP+jdIklB3aadPP
         /iseLXiAubmXXxEymaTLwwCeZq1Gpu2LtJ9q2ZqikmL77//knU5du6T2VTsZdgxiaxVJ
         J6qbFIsvXKxWZUTCWWTOwBEJcXRYKcLVb4g+eONptSHiRCBjka2B4BnIBQd2JLGsKDL3
         dwcA==
X-Forwarded-Encrypted: i=1; AJvYcCV0l3uBVQx9up9dBZs3ddMatLJw0DRQQpt+4fnLQiN9ghvFP0AnI0dpxLzmNRmwpGl80e2Zn2KIsLx0KK+RUhQM4lI=@vger.kernel.org, AJvYcCVwscjCv449LABtG8kRZMnJOxNM9ufHSQTw2BjrYZ5CWUhqCNH8de89G3klio110jqSvPn5h7d8xgQX9mI=@vger.kernel.org, AJvYcCXRHTY6uvtZ1srD8VIoS837AFVbEa70wRViKugof8tDEMWlrC39fdDR3yiBpRt469IxY9mLSPghb8XS@vger.kernel.org
X-Gm-Message-State: AOJu0Yzay+GD60irz1pGzdm8+HuF6/5wPtcPJwidXjZS0yiWqeHzFjc9
	OcxhuNptV1iXFTpq6K1CK/6rGH4kV/iy/5uttsL5jeRSjHMNjubN
X-Gm-Gg: ASbGncuY7l0MFscPz3RAm5Ghdg0Y2uB5gr9BAtnSSXD2N2ldgyn95BnX7BeHw1H3qtR
	kszS5jmYF8dk7rO3q9KM0vP46pFBfLkXi7Pg8YJEkDCFMsAk47aTGe7/TuFhUf9RFWTQ9ICC1cM
	8kuIs5wykjR46yXCa77yKcr0mTJOY6rpdZQtXk8YuSUZ2mmakSLaB1oHC81EeoPFhqKGCw4qGkr
	kNHFGeG49y1hGeYYIuBmDX/7Eruc4ZnGrixhSnZzXALKZgVDnQvfi52RJj6iN7Fwh9A8S5JcU+n
	1A/pdEE4EXhNHVQ=
X-Google-Smtp-Source: AGHT+IEwzU7zVbZY5nRo6Xl+F2Wzc6UhZJld7/Jc7tJXcJ3FN5Uxe2pRM/grp8xzcYKAQa9EtV9Bwg==
X-Received: by 2002:a05:6a21:3996:b0:1e7:6f82:3217 with SMTP id adf61e73a8af0-1e88d0a2973mr44261759637.3.1736940080435;
        Wed, 15 Jan 2025 03:21:20 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40549408sm8886396b3a.23.2025.01.15.03.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:21:19 -0800 (PST)
Date: Wed, 15 Jan 2025 20:21:17 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: kingdix10@qq.com
Cc: marek.vasut+renesas@gmail.com, yoshihiro.shimoda.uh@renesas.com,
	lpieralisi@kernel.org, manivannan.sadhasivam@linaro.org,
	robh@kernel.org, bhelgaas@google.com, prabhakar.csengg@gmail.com,
	biju.das.jz@bp.renesas.com, geert@linux-m68k.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] PCI: rcar-ep: Fix the issue of the name parameter
 when calling devm_request_mem_region()
Message-ID: <20250115112117.GF4176564@rocinante>
References: <tencent_DBDCC19D60F361119E76919ADAB25EC13C06@qq.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_DBDCC19D60F361119E76919ADAB25EC13C06@qq.com>

Hello,

> When using devm_request_mem_region() to request a resource and the name
> parameter is a stack string variable, it may cause errors when executing
> the command `cat /proc/iomem`. Depending on the content of the memory, the
> manifestations of errors may vary. One possible output may be as follows:
> 
> $ cat /proc/iomem
> 30000000-37ffffff :
> 38000000-3fffffff :
> 
> Another possibility is that garbage characters may appear after the colon.
> In very rare cases, if no NUL-terminator is found in memory, the system
> might crash because the string iterator may access unmapped memory above
> the stack.
> 
> Fix this by replacing outbound_name with the name of the previously
> requested resource. With the patch applied, the output is as follows:
> 
> $ cat /proc/iomem
> 30000000-37ffffff : memory2
> 38000000-3fffffff : memory3

Applied to controller/rcar-ep for v6.14, thank you!

	Krzysztof

