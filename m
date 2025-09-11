Return-Path: <linux-pci+bounces-35910-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7EC0B533C9
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 15:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C2B83BBA5F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 13:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3A0286340;
	Thu, 11 Sep 2025 13:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zl6KKGMb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776AF1EA84
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 13:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757597438; cv=none; b=j+5d+izRN9xtjF67/uGriAE7Ic4z/I8EoS/NhpjiDmY/aKte1a6IstO7oxvWA992hy7IP8RGil8hPxSriNScnSYLNZM80NheEce2LUwF4u399B5EOSbaoE/FMu+Qm0VdeepJPT6oTo2LLxJ9mSZYsigCwy35TAZRYVGfA4aVUuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757597438; c=relaxed/simple;
	bh=8OuQtt7V8ba3/rLiXSIsouSLa7cHo3GYgs6zin4n8ag=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=NscUl/oUW2V3kV80uGdb+MjimIXR+QPLLKU+hKGkoCgIK14CjEuFUpR9uM+ngAyYYeIZ1IVJVK2BnEWdcjB1iYUi+hacUCksgEY2kqrEm8ypg5CkMhIACGAD8k9hxgKvwz1eav2bkJ0YzFnNrd6SUv1qLaALaFSjXj+DWw4/Ogk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zl6KKGMb; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b54a2ab01ffso445903a12.2
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 06:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757597437; x=1758202237; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aQlqSojSlf46BQjiH3sjU/ACFvA22QBgGPmMDQkag0Y=;
        b=Zl6KKGMbBSQJ48vrCSrfhLy+j8EJijwzixXO9lZrYWaNSfjzekPxFIu/3s5XqEEFo/
         e4rBFB436TcdfG+o98+Otcs+dyNmAb6IL9UgxQTPVratrBDc0BQG+S7aHHAfkiEFEFWb
         sot2SeLJ/orW2hNsKNfoPlgiwr6QZ5eov4pecqwJfSYzi0+zxTmhmokNRnSU/JoYjoUA
         fJk/hRIM0/ve1yMhVq+SrvNZRAo3vO+oM0GX0CeYMunzAZHf+98fN2AE7J+xPE+yWEVe
         lUPPdaI41hEkgWWIZB/vAoxmbUTiuHNXzkcNrJuUL8mrxRHMwJXPueXxdFG8wH0O6lAz
         znqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757597437; x=1758202237;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aQlqSojSlf46BQjiH3sjU/ACFvA22QBgGPmMDQkag0Y=;
        b=n8V+8Gn0HdrBvos0dSs3To7/yYmAJtYsYZr2uv3S+9Z8aDrP2rgEClQKPngudDJADI
         lATuadPrL0jDLpTfOdaK1tHvflJeeKo+ddzgpH0erorqoOde87m/Pl5rWdujvH0cx+bP
         WPdQk4kMU2fs3PyZgn3lRAsaeH+Jcj/br8jCrvZ+gLMDryuiWjrwrC20TnUz2nE6Bsnh
         68O9DQP/iQ8togAYcE5queVvN43RUnB4wx2UzBscYfPn2HWtAI6jrhZ2sk/+kCCYahCW
         R8UMT5N9vIC8wKh1fAmCPvbcxU3lzN5iwA1kGw4iUmJhDH18y2aJrIXIC5ckD3WCGbn9
         ZBNQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoOu8oXdsoTkRUzkZypdfVwb6ABzTajGCLMQqQwfXSCW1JmP1nuWzmVKHN0+Yn9WT+x0dQ7U5cPZg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEdxn20U3aXhA4qk/ulxUdijE2acrDHiImwSe8gizztr+O5Nvs
	zN4qLTmZe3ccXrVgIGrPfAmOwQzLra1FyJ/5ccDJfkikHQuqzI5sEzGP
X-Gm-Gg: ASbGncse/gViDHzDGNtOLcmhnrrgoHOvS4mfb04SlIzmIUBIN/Vos5C8H6m6XBavZt1
	/p0Rr+XGzCjwuWiGz9AnE+eg2jfqRq85kupsNDiW/SQXsRYugln8QnQuppbUwhsV6m2Wy0Yr6Sm
	7zIwF9XGFJ5JC2zo5IOf+M6sMtVTiurCe4KJkxxSwwk4rowoRGlJJpFzZKiP4IT3FcxpFVlpKCR
	GwgG92txGaG3jJmGid+VwrfpPcjqGjc23NwYUBhGGltpNE7JzYP9Y/9Nc7qQzaPTfZIodYi3NBH
	elNvN9KCY8BWW+Sow2dUNohU9zQnS5uD4U/JVfI+0+HZoc8g/1wSxDVqMhexXsAeHOkeIRKrxRw
	JG6bkwXTonB+dKSD3JrR1YcfgMB9R4Aq841/q9VvjFBFoEcj764MP9wJ/UH4eQy88y0CUd10kG1
	Ks6Sfy7Brp2dnG+vquFFURZZUJKZsAw1ZRxg==
X-Google-Smtp-Source: AGHT+IEvq1Wxj+yFs910EdFrhvXlDsCmNs8TvQolpRuRoaPAKsaZEGIySdytgcl1djatf0VUcxyO9A==
X-Received: by 2002:a17:902:e886:b0:25c:a9a0:ea60 with SMTP id d9443c01a7336-25ca9a0ee09mr9586555ad.42.1757597436331;
        Thu, 11 Sep 2025 06:30:36 -0700 (PDT)
Received: from smtpclient.apple (n058152022194.netvigator.com. [58.152.22.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25c3a84a772sm19067405ad.70.2025.09.11.06.30.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Sep 2025 06:30:35 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH] PCI/AER: Fix NULL pointer access by aer_info
From: Vernon Yang <vernon2gm@gmail.com>
In-Reply-To: <20250904182527.67371-1-vernon2gm@gmail.com>
Date: Thu, 11 Sep 2025 21:30:22 +0800
Cc: Vernon Yang <vernon2gm@gmail.com>,
 linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Vernon Yang <yanglincheng@kylinos.cn>
Content-Transfer-Encoding: 7bit
Message-Id: <3CCB9A4F-3DEB-4E68-BF04-7063AC2E9614@gmail.com>
References: <20250904182527.67371-1-vernon2gm@gmail.com>
To: mahesh@linux.ibm.com,
 bhelgaas@google.com,
 oohall@gmail.com
X-Mailer: Apple Mail (2.3826.700.81)

Friendly ping.

> On Sep 5, 2025, at 02:25, Vernon Yang <vernon2gm@gmail.com> wrote:
> 
> From: Vernon Yang <yanglincheng@kylinos.cn>
> 
> The kzalloc(GFP_KERNEL) may return NULL, so all accesses to
> aer_info->xxx will result in kernel panic. Fix it.
> 
> Signed-off-by: Vernon Yang <yanglincheng@kylinos.cn>
> ---
> drivers/pci/pcie/aer.c | 4 ++++
> 1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e286c197d716..aeb2534f50dd 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -383,6 +383,10 @@ void pci_aer_init(struct pci_dev *dev)
> return;
> 
> dev->aer_info = kzalloc(sizeof(*dev->aer_info), GFP_KERNEL);
> + if (!dev->aer_info) {
> + dev->aer_cap = 0;
> + return;
> + }
> 
> ratelimit_state_init(&dev->aer_info->correctable_ratelimit,
>     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> -- 
> 2.51.0
> 


