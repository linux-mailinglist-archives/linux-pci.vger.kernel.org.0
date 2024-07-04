Return-Path: <linux-pci+bounces-9814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBE392795D
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 16:57:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 376EA1F21A08
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jul 2024 14:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A66301B1413;
	Thu,  4 Jul 2024 14:57:32 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D6D1B140E;
	Thu,  4 Jul 2024 14:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720105052; cv=none; b=dpDQ6ASGYMvBfQ57JXBED7lD5YhoJXp3OP8X7Bu6rHnwkN+6IP4y7e7/dNWMD1mBRC3Qg8YDKLHIRKk2AGChBqshZnNFwmxyJdZ5bIQIXvOsDohlfx9FT7viNPy2R7ywKI8edbPFf8SNdaoriHbVmbcTG97LXzcUoqXFgHXQoUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720105052; c=relaxed/simple;
	bh=wXM+lJtWqpCmqArY5lzSjLj6RYQU+kkOlea0ctvZMa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=egL51UDIRUTJr2btoulI/bm9mjLEyOzIjhMB6R7wO9KbsMrYGrvZ1KmlK5W8vqvq+SHoSDZlAjBAZ8++Hg4bq2x4iig7r7hDIXeHhyUAB2LnPUt8n0jmpEPc6kfAYNFAs4fGnj3SH7/ES2qrBy/hNjNJGZ5wu/SOgMzgQRC9loo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb3cf78ff3so3567085ad.0;
        Thu, 04 Jul 2024 07:57:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720105050; x=1720709850;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5DuG8BbNPK7ojcgHp1GrfarVfxf/VgJ2PLuBOxAwREc=;
        b=e5GCrdQyQOoP8qImxD3X5vmgJloS3H3+FIX6A5kc0nF/l0h0X3rIWi8rA68mqH+qJn
         fqAFT3UV3OJ14LacTO5T9P4WahTO6BNZvbuYFEIdx+UUGfWCDeV9YUM43s3VfOCotVPM
         y7FLlJCDMH2jxXNcvNGzii/HuHNflpJ1iMqHKPLj9Ksr56vbcZrnxsgBQhrG2/oJB5N+
         KyB1bk1jYD4OTUz/GrYAyBOIrmM2aKBj6l+l0dto9X9/PD6gF9HbXF6omsfdi7nvoryU
         /HNh/89qljQ61BWyCgJwE3QlXvQUtb46hedrokMfFPBYyHczbrv/OUhewNdUPkRb1fkk
         1saA==
X-Forwarded-Encrypted: i=1; AJvYcCVKNvJae4rsebOqgzyX/lmHvQfSXoG4ZEEHiX3HB6JYAOnBtHplCUt81LScdXSRJM2W/zeKWzlxmGMSAZaBz096fm6RO0A18POfbGnEi0utJwtLgVMQl+RKgkH5u7crjYBDkxfLsG3y
X-Gm-Message-State: AOJu0YxCZ6X37x/SSQNNQFGuAUGFsqbWu/tWKPG/mohC/lNYe5FFDfeZ
	6mPlth1AiPEqPS0v0k49nPBKRo8H+hDeq7GZRmzONw/y+K/WuJMF8JbwIZvINZw=
X-Google-Smtp-Source: AGHT+IHk5PkhvF9EcZ3zJ6njIbJGTp/esa3YKK4JMSn2BQdtg/TkdHRJSLj1ooKN9HxkK4SpokV7yA==
X-Received: by 2002:a17:902:f688:b0:1fb:2ba3:2f7d with SMTP id d9443c01a7336-1fb33efe3cfmr16243485ad.45.1720105050293;
        Thu, 04 Jul 2024 07:57:30 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1598cfbsm123832235ad.250.2024.07.04.07.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jul 2024 07:57:29 -0700 (PDT)
Date: Thu, 4 Jul 2024 23:57:27 +0900
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
Message-ID: <20240704145727.GC1215610@rocinante>
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
 <7a8d4e4d-4e2b-48a6-b8e2-d23460154777@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a8d4e4d-4e2b-48a6-b8e2-d23460154777@gmail.com>

Hello,

[...]
> Hi, has this patch been applied anywhere? I couldn't find it in
> linux-next and pci/next.

No, not yet.  It's on my TODO list.  You can always have a peek at our
Patchwork to see how are things progressing.

Meanwhile, there are always patches to be reviewed, if you feel particularly
restless, so feel free.

Thank you!

	Krzysztof

