Return-Path: <linux-pci+bounces-34989-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29589B39A77
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9DD03A4EF3
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 10:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A4F30BBBF;
	Thu, 28 Aug 2025 10:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cc7mZhMK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C4230BF6C
	for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 10:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756377666; cv=none; b=VPzFp1jG/NbaSBDIOgrKFQ96uLgOOtF/9s7jYB4IiJCMOy7wpGHQnj4LZyAJcIFNtNFkqNpvS6G7Pm7t/zKWFpRMgVQZikCeFUHP7DyTRze1j5XaV19UN3dryZwvUNzDtvP3MvD3q1MuWXU5expeiXC0WX9uTYBwe6UrL05xK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756377666; c=relaxed/simple;
	bh=uw4c+i8xKaQAYP7o50jrNBNLbmBRrs7CaD4Z51npYbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JNKR2sMa5f0/cItPvXVRRSQgUAvfHXoBMOUktVmiqpKRDk6pzYZpVDNasKNDWUddhNi6blaIC2gNKnWNoo0y6w2MeNxgmhUTky4qEXg2dRVpadYa249IIbbr4o9/588vl1rGNNHkvpKAGqJF9sD0QSDrSnIeMvbJUdeMKs8ds3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cc7mZhMK; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-7e9ff3d2803so1432385a.1
        for <linux-pci@vger.kernel.org>; Thu, 28 Aug 2025 03:41:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756377664; x=1756982464; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EydVysub6WRf2f/POlpq24Sj1Yvi1ca2N5AUKs2yN74=;
        b=Cc7mZhMKuPwSUEKLYdwc2bzcK4eyCvT49wlZUSV+EVbj4wC/ZtBDwosySU/rxZvXfQ
         SmAfaP5ELpj9jiTIgafz4y2dZLlYmkiZMFtsUDXnM3JXgaIK//08kqlXuEkRHS8RfdT8
         zaZlKiP5LHh4WVv5i9ZM3VD+8snZs2hjXfEvXfCJTPNWqP5BeM5PHnpkAerkEuzout4Q
         XqbW0QDZF6hGEbcyJ7pz8dgKnAhXoOHdShZ5UfDLZ7J/QDn2Aq5MhWBCFQbsN6UXmQKD
         wZNb5xVlRV+yd+oPpWNLmeF336luLe77t/IycxvNhRbquIUmkaaQA5SINeqCK2cyzSSO
         M1DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756377664; x=1756982464;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EydVysub6WRf2f/POlpq24Sj1Yvi1ca2N5AUKs2yN74=;
        b=n9Qz7ilZMZ8q8Ea4B/i/Id7fd3dfy+vZR95XkRg/wwliJSf1VPm8Y8FNOMhgPSjyld
         ubn/icCA0N4ldgwSCHHyzgA73AfZTCdBrASF80YOwPEhCvfqH2uWyhaRjFui+doaS083
         0XkZF15owWqaN7dilZMO/sj56gEyICEELO/lJVG2co4LQGHHlyl7HQ02U+4PZa/xDW+3
         ufbqlUPGRXYr5sJqVoyshFCuDRP+Lmp9LTPJJJi22H2o08thj0J/qOyfud7mmpjm19B+
         rwu899UmPWI+qOuBTbpVv4Hl5OVNdMSbmKD5Yh56+6EZSgrZx195kjbQqm7fLBgWEW+p
         F/zA==
X-Forwarded-Encrypted: i=1; AJvYcCU1sSQP8QfBAbPY3dW0IKxK4wGxJM/rhagiyHjTA48qyLaHkDPSNLUpHYGFk2CGXk9/WGV93MwcvT4=@vger.kernel.org
X-Gm-Message-State: AOJu0YytC01ytJXD6prSJ07jHj/NpGUdXwKqE+pI3JO4mVtkH8UPhkSi
	lwUKN+/8gXoR5HTamEHK3gCI96rMxzZ0q+jUcUnhwU2/MiM+p1D+HCiW4XwGAUyjo3WftSiHCG9
	ixInxR17lQb3DZyhCzRKKul5s/1lAb7jWcmgEv8yWcw==
X-Gm-Gg: ASbGnctjy8i9v3NQRx+qWyCH/jjHt2s2XEH5/X5Txc9S8X7+3nkfLPpstwZ3XfQOmyv
	1JhMqO5czSFoSZr10Uj0JalcN7nymkwJMTCAZ7xLCpPYw9VBWYD7a9HaaJ1TmAoBdVyA3kGefjW
	YDmi+Dj+JdsXR0Es1tAzs/2qiboowZEWaw5SDlwgPArSysxY3jApiydOio9Fb3Ym1iuyglnfkJp
	itaa9IB6zlQ2Bok
X-Google-Smtp-Source: AGHT+IE4bAuEW9ouUAxu2MG7S4mY4Sa0rG4XXjaFyEoJM05F/h+YGpiGYd0qZuUP43lUZrkbFMhLhuVFPQZ3xAVR+ck=
X-Received: by 2002:a05:620a:a11c:b0:7eb:b179:cf18 with SMTP id
 af79cd13be357-7ebb179cf73mr1352900785a.0.1756377663827; Thu, 28 Aug 2025
 03:41:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com>
In-Reply-To: <CA+G9fYuysVr6qT8bjF6f08WLyCJRG7aXAeSd2F7=zTaHHd7L+Q@mail.gmail.com>
From: Anders Roxell <anders.roxell@linaro.org>
Date: Thu, 28 Aug 2025 12:40:52 +0200
X-Gm-Features: Ac12FXwg7V6NAoK1bwozm71TrmcFepHUZqBu0bygtHChH0GZxXhOVks4ofdYiC8
Message-ID: <CADYN=9+Pnw+7bYGr=QnSWqF1YBoB8CbtgkdmDqeY68DQr3CVDw@mail.gmail.com>
Subject: Re: next-20250826 gcc-8 compiler_types.h:572:38: error: call to
 '__compiletime_assert_478' declared with attribute error: FIELD_PREP: value
 too large for the field
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: open list <linux-kernel@vger.kernel.org>, PCI <linux-pci@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>, 
	Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Ben Copeland <benjamin.copeland@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Aug 2025 at 11:55, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> The following build warnings / errors noticed on arm riscv mips with
> gcc-8 toolchain but gcc-13 build pass for the following configs.
>
> Regression Analysis:
> - New regression? yes
> - Reproducibility? yes
>
> First seen on next-20250826
> Good: next-20250825
> Bad: next-20250826 to next-20250828
>
> Build regression: next-20250826 gcc-8 compiler_types.h:572:38: error:
> call to '__compiletime_assert_478' declared with attribute error:
> FIELD_PREP: value too large for the field
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
>
> arm:
>   build:
>     * gcc-8-integrator_defconfig
>     * gcc-8-omap1_defconfig
>     * gcc-8-footbridge_defconfig
>
> riscv:
>   build:
>     * gcc-8-defconfig
>     * gcc-8-lkftconfig-hardening
>
> mips:
>     * cavium_octeon_defconfig
>     * malta_defconfig
>     * defconfig
>
> ## Build log
> drivers/pci/pci.c: In function 'pcie_set_readrq':
> include/linux/compiler_types.h:572:38: error: call to
> '__compiletime_assert_478' declared with attribute error: FIELD_PREP:
> value too large for the field
>   _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
>                                       ^

Thanks for the report. This should be fixed by my patch here:
https://lore.kernel.org/lkml/20250828101237.1359212-1-anders.roxell@linaro.org/T/#u

Cheers,
Anders

