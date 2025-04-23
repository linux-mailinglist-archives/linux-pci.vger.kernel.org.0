Return-Path: <linux-pci+bounces-26606-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73A74A99801
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 20:36:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C427E7AB756
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7243628EA5B;
	Wed, 23 Apr 2025 18:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jTFnRXCs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5CB28D843
	for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745433372; cv=none; b=LjTXWU7CR3gL8eyQ8bbcmV8VI0TPpcGcyNiLCCFuFGnYP1y5V/zb80MV0kmwCQNOIiVCsBmQ6NpnC+DJdJHEBJIDhXAuaQb2jfzzd1rrPLusC2fC1ubyXtcApLAJMxKM/sJwKIIaeLEepgeVLzYVg1rg+BmKUeq/NKYf9DOdi1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745433372; c=relaxed/simple;
	bh=CQxwBsqxOevm8XyRK++9ix/s14GbRhhSVJJKe5IIdUE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p1NDrR4vzHcf5CuEzW4CESvyx2XE6+KvabgQNobgnRRCXlpbXdrdJKCz77Bnx2WYezTI0nYrTVI/w/RGyHQHVa88hO8fmh3j0nHpdNwkwk6wee//Ye0W5oy6zhO1H3UACuHkiNMzVvGSXyCeIz7NAuFgDujEJSg/hOu5COcablg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jTFnRXCs; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-30beedb99c9so1962161fa.3
        for <linux-pci@vger.kernel.org>; Wed, 23 Apr 2025 11:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1745433368; x=1746038168; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CQxwBsqxOevm8XyRK++9ix/s14GbRhhSVJJKe5IIdUE=;
        b=jTFnRXCsW8zrOKUSQHGTcbT2G7+l9u7h6kHoUgyfwDlJ2v7lKWIhJDa4LqSyIGfWhF
         NMcxGj9bfw6PxBVX/YyEjGEPk+TNS4HvgI/sz+zIOwv0/8oDxuKYt36jmbms9giekp6l
         sDAHn5sw3tS1vN5gXmiN/GDiA8+fmjYsSK1xOXvSYWcQELz2K58O/EJePhvGO17bWzdA
         BBtAw6jeI2mx8Etr/OOntYdOEvP7NZ+5RKWID5klvFj3CZIbQEZlDvbdwEFjGxf+uMux
         PS4FsfX1TmJnZq9jakQfExB2b9po6YUVIEgGd8tHPWAWUgGaNTYZCrm1CsBqLyZrX0OM
         GcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745433368; x=1746038168;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CQxwBsqxOevm8XyRK++9ix/s14GbRhhSVJJKe5IIdUE=;
        b=ezfgbskJPRElkqfctheGn7eq800rOIycYFTaLq4IWcHuAyAcMnqA1W8YFU8nJMYsa7
         Iunvay2ahotl1I9sBPWxRQOxaBj2h+9yl7bBOLyLDPGZZPa7jWmIKc38HtXVJXE6uXAY
         rIvy3n7yylvEa0LjPx9cWKLP0cxr7acBpFUIMi5IrruZX7dSitEore6vOkAlokqsyQbk
         9xJPBdwTBC6xpdY5Y7mApnu/G9i6Es52nbg0rIUZigLDMPtXs0LT39xOGkDluNXHaAoU
         K5d77LcM+lggYARcf5h7t1ZU8MrcyIQQBiSBkjPuc9R37Yac9U37Yq+3VGk5RGNbnBtm
         S/Vw==
X-Forwarded-Encrypted: i=1; AJvYcCXHBaEH/c75Bgim7a03730OQcdbr2B3RauQ7gbe4cbrzQ8V2zZvmWj8b6X2GF0a6GLrtO+iC3Q8JEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0fOp6/lOag5RpHrenYyCo45rdadihuSBrfctoSOoJ7ots9qhs
	qTyhLAPxb3T7khinD5Gtb3surlT/fMW80eYpTWKBKwXS62xQDUp8snpzlIxgCIDHiM+1qO4bT1m
	oDudtSMSDsbXipygJbELdyV+VphZaWPE9K25K1g==
X-Gm-Gg: ASbGncuRofJQeMA9lqDPxiMii4rvvmWkjas2hWlsq5Ll4Tpkaf30aT6e80D2ygLdieY
	WDaColnc51VwNZjX87BhOdaUIoZfidUGBRoXNDi8QWVlEmedf3L7U3Re88gcW6jTRuNyFyCJnlk
	4pSNVa+KC2I9eJQIj7QXYYSxHZJwa5RzUEDgjz/3HoxwQj/LmKxeEiVA==
X-Google-Smtp-Source: AGHT+IEymM2ho6uHtG1Zdu07Wqud8fmld1N+xT1EeRnMqI1j8xJFCO2sGEl3h4YmgUWZYqeXGNDm3XEnhX+HJ+s+S9s=
X-Received: by 2002:a2e:bc84:0:b0:30b:b987:b676 with SMTP id
 38308e7fff4ca-3179e0e739fmr246971fa.2.1745433368448; Wed, 23 Apr 2025
 11:36:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409115313.1.Ia319526ed4ef06bec3180378c9a008340cec9658@changeid>
In-Reply-To: <20250409115313.1.Ia319526ed4ef06bec3180378c9a008340cec9658@changeid>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 23 Apr 2025 20:35:57 +0200
X-Gm-Features: ATxdqUFDGFpMo4aaci34Zse_W5zMkzP72gRHA5kbQNTJZvoubqTPc2GMnWhswtM
Message-ID: <CAMRc=Mc67rALxbFu3KJBT7k0oMwjLchyackknXbgRD04v1Xaqw@mail.gmail.com>
Subject: Re: [PATCH] PCI/pwrctrl: Cancel outstanding rescan work when unregistering
To: Brian Norris <briannorris@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Brian Norris <briannorris@google.com>, 
	Konrad Dybcio <konradybcio@kernel.org>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 9, 2025 at 8:54=E2=80=AFPM Brian Norris <briannorris@chromium.o=
rg> wrote:
>
> From: Brian Norris <briannorris@google.com>
>
> It's possible to trigger use-after-free here by:
> (a) forcing rescan_work_func() to take a long time and
> (b) utilizing a pwrctrl driver that may be unloaded for some reason.
>
> I'm unlucky to trigger both of these in development. It's likely much
> more difficult to hit this in practice.
>
> Anyway, we should ensure our work is finished before we allow our data
> structures to be cleaned up.
>
> Fixes: 8f62819aaace ("PCI/pwrctl: Rescan bus on a separate thread")
> Cc: Konrad Dybcio <konradybcio@kernel.org>
> Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Brian Norris <briannorris@google.com>
> Signed-off-by: Brian Norris <briannorris@chromium.org>
> ---
>

Sorry, it fell off my radar.

Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

