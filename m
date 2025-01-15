Return-Path: <linux-pci+bounces-19887-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DB7BA12354
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 12:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68B3B189010F
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 11:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFA912475C7;
	Wed, 15 Jan 2025 11:56:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C48C2475C8;
	Wed, 15 Jan 2025 11:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736942187; cv=none; b=ssHY4RtsQEedknbQ1z3R6YrB1bR/eAsWSiL+E1xxJDz3sPkMFKJ5odAG7ECcCcKNQCBOKwzgbFbwma4SY99Xn9H+1b7HDg7TqK/0FnzrUHCCHjeGznH0iNPlO3Qam0Qp/yDFr2JnynJRxvjGL5lfSXvrgoweL603OZgslzpUzcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736942187; c=relaxed/simple;
	bh=bPKkbglN5IOrJEkKH2aiBVa1zCxPdTYV0S4HSPJDVsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gZn30ac6Kdffx3T7LJ4vpLczjRO4Z7iMcmqCeK9L/bpKeTO/3SZwoT4mRroNJtOnxsceumjITevXWN2vFbyGyMbSH+sVNbjO8bN/Y2RNVyVLPK+BVLoWhloyRsppYMiAdy7iAvLwgF+uQFBlqLyk0bDy3ZA+A7yc0usqWPyw5I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2161eb95317so118082895ad.1;
        Wed, 15 Jan 2025 03:56:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736942185; x=1737546985;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZwSn5CwOdXrmBRaQodpd66KCBjpNGMiMLdXQRCJEtak=;
        b=eNdZ4i7yoAzqYMg1Kaju+g0nAKNXJX2POcPgCUW21ttuzuGXduW4ezAsxCL4uGrq69
         PcDySWFQmOMNtk9pSg6oRQp1vy7n8Lfq93KvpOXeUjsh73jMIxjNJWhoOI3lswKavwn9
         5tEzJjg+zcvAZ80L1s9Aa+zt7FILM66+PcehzHOSiD/Ha1NRoREufmYfvSzCfpBj/Qzy
         G7jPVyAAlTV1aCRpYxwEdc0QpQud6UWrWH98/2y+XzT5wZEXvUkR3IrNbm9o3+CSwvo0
         GbvYiYhz3De1txa7rDqD/PvgoJnQgY40hElZ04/VazcwjcwuESD88q9uj96HjwhCc/nb
         iIDg==
X-Forwarded-Encrypted: i=1; AJvYcCVTbtPfwRZUaYANzmlCVYw9G3iSIarEkyN0/Ch22z4RZOoJD2jgpRQaK8V1HHqUPOX0KzCZOGm5TNyoiLA=@vger.kernel.org, AJvYcCVk75Y0KFZ9951wRQtlJqeh/4O5bfEdItOk74hlx0BYki+13dvvxWQ6R6QGljS85oJ0vBuxosDHE/kE@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5rb2j07UJdo+fGKkCuCMm9vjFi4deO0KorRvHQ+/unvTWyjmj
	1a43IxZfPRdUNpWGH6YCw/WLgu03vROYPFyKYa25WLKojCHHsZ/R7b2HEAtn
X-Gm-Gg: ASbGnctyEyZYn5MrnsF7R22HzvhOEmF/NOOO1oBHWUclCNtiepQkcrRBcjDyhKQg2HQ
	8mJ5sJ+uEfyLWSdlThAeuZ8RkhEYe0Fy8eQ26dzZdKF7+EkY2Z8XKkc4CWnztQmCXX1VnaV8Hkj
	+TU6tBhAIgb3X67G5m5PS7t3C4iPlzu2tyBBGK4ENFPSX1qxVWN9bC+tjNKdcq77RvBgW2Gm8uV
	AxILm/RmP1r04LYqGlfj2TZyRwCQBLJD1WydLlRniiRIIj0DnxlpAcxDYVa0ZJMWceJgKf+HZdV
	u2h2ERzKd5rFwos=
X-Google-Smtp-Source: AGHT+IH7x4qslQr1Z5vhmDDvNjPOWa82Ip74bjMY78Ky9AsxOvHjHZ1EUEW1ty4u2Uod8BczPTYG7w==
X-Received: by 2002:a05:6a21:78a0:b0:1e1:e2d9:44d9 with SMTP id adf61e73a8af0-1e88cfd3cccmr40111796637.27.1736942185462;
        Wed, 15 Jan 2025 03:56:25 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4054890bsm9302631b3a.17.2025.01.15.03.56.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 03:56:24 -0800 (PST)
Date: Wed, 15 Jan 2025 20:56:23 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] PCI/sysfs: move to sysfs funcs to pci-sysfs.c & do
 small tweaks
Message-ID: <20250115115623.GA303591@rocinante>
References: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028174046.1736-1-ilpo.jarvinen@linux.intel.com>

Hello,

> This series moves reset related sysfs functions into the correct file
> and does small style related improvements.
> 
> This series is based on top of commit 2985b1844f3f ("PCI: Fix
> reset_method_store() memory leak") in pci/misc branch to avoid
> conflict with the code move.

Applied to pci-sysfs for v6.14, thank you!

	Krzysztof

