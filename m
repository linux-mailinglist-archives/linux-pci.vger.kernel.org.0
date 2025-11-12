Return-Path: <linux-pci+bounces-40977-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F731C51923
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05C693B174F
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 552752FE06F;
	Wed, 12 Nov 2025 09:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MytEszeF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB5B2FE579
	for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 09:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762941428; cv=none; b=e9cE7w+bQDO35Isr2zkN6wRvTf9pQozoLVJQjn/quYByiy1fl8AXpTy/HUQ6uqdUox7R+mtNaEBEqxcZCPsAj6lJPJzgtbe0AnTM/IkfTt9ryJjXS0MGg/JXiN3cZOobO2txHKHeAnxN+MmvOKnKOrtqYVIh/H/cVpfpdB7/mtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762941428; c=relaxed/simple;
	bh=CIbkZoEcvxMuArEM88rMsYIiHa3ILLozzeTvmZfTtT0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=asI9PAaDCaBk5AKmFXZ7pRUuUW85mC4Dc8bhDT6gVDzn+zs/B9ucyD9xPfWaSzyZ+bpl9OBKrijegiJC2TsER05ZlAt8aJX1/VeSbX18tEpIy/uV3+16YdTBHEY9jANQLEHJ+a6KDjD/UiiQb9ICo1yI7h0zO1Z/mj0DfJsN/Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MytEszeF; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b6a42754723so30977a12.3
        for <linux-pci@vger.kernel.org>; Wed, 12 Nov 2025 01:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762941426; x=1763546226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CIbkZoEcvxMuArEM88rMsYIiHa3ILLozzeTvmZfTtT0=;
        b=MytEszeFd0wvJ/wuqK6NxlN1QefOYVAO9HXEowT45u60+HCefw/nIrfoaXUhufX2nU
         OkHgE1D4A9iOBTlIofrniMgpiqFrKF75GddJ3Oo+JCfYBQg72HHTIBCx3dE+fGZnTvTu
         1gwrZNUsThvakhEB+6FDzD4zWq8ue6oIWN3IHfKzurWTANuMSONyGxpEec4xQbQTS2rD
         4vSFASjxFFOsB6ledt3cJT0SLeildTq4VcMUJj8cseWdQYRqiIQGqT1qIN7qyGw/SQSX
         aM9EjLnf8wl8CvXnBxun86n+eKCkZ3Ix7JJfd0GlX73XpVzpFplnvKeZ9swM5HYITGtg
         3csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762941426; x=1763546226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CIbkZoEcvxMuArEM88rMsYIiHa3ILLozzeTvmZfTtT0=;
        b=obNRqLmbde7duZQZPtlsd9dso/LjyWdqM3LqZ3MpCQ7NgTGvsmTEqrh8sRMI5zQ0w+
         wFTI4BB/tZ1HP7YoUkroEKlKQk/y0tWtW97A0DcKn7m2SrS1Etmb0tmkBZMGJ8AbUklC
         fMl5otparhkgHuDMbgzg7Xq1iN3RKHvpCMWsfWwKv15nwK6w32O7yuHOFS3/YD/7/LlH
         6xqgwSwmDijVSlLnANM3aU/EwvQNJujNkfnetWAk2X0kY/bgahltllLUUEb0DAfG+NCg
         bmNJxbLHsKkXWvoUGGx+MwOrp7RDYJ5tZYS9gtwbU4UIk7rTJuUI2VeJ9tNfk+0ubjN3
         ypYA==
X-Forwarded-Encrypted: i=1; AJvYcCWmQLL1ZufVAA+kMuq4+wWCXjI0l1n+N1rM2/gssfx/hTonbkWj6VLlQWOOekdgy9ZS1hONCcdnR8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8GyGX1SdXTw5AWEH4xQgB1TfEktuLf50CD/BH0VivMALpv+Bu
	EYX2StwVDA9l3z4G4TqfoXIzg6HJ7xWLMJoi/iyh3+SYtOnegpaJsa0QDZ9igtzGeMKGkjO7yRk
	2/FD6r0sWJnYpAdlSV1U/2hqVfZQSMgeUy+Wd
X-Gm-Gg: ASbGncvt1N77i+i1J9lPrsrmJjZUNHKRElkSWghH01jk/XutG9+XtdJXdXOxtibowT9
	1lOigEHyoz4dtgACXQqNyYZr1eVFFUCzC3t6g6Gpp94uQA0Q/Lk0mJtseXCqTjGx/Q/Chl5PqxT
	T4tdlgt1WxUmW0P7DUJEwexE3NJrrBXaw/u0Rkv/lPiDitUJZkWYbUx0DY+NvbMVK2YN/CVLfik
	5S+fpfouiNB7y9Dx5o7P/eNoPdgpnggV4X1upmgPFQ4Da0d3SL9lCWgMl/IxyEfdHV6zSkx/a3m
	AtNgeqttu4y15dFn1zkXA57j35sn2/O8H8cokKi192hpmTRFe4t3X9rWgqt70fLTqr2ZwKbpjXg
	WM7PHUyyEstLZNg==
X-Google-Smtp-Source: AGHT+IEhemJfSLH/p4Bhjk03hiHG8nPZMckQ4o1gzMhDR33YwdnDKqTg/WdwFRNF3u+gDynCToXBRDMfK6PTspqbdUQ=
X-Received: by 2002:a17:902:d4cf:b0:297:fe30:3b94 with SMTP id
 d9443c01a7336-2984ee0ca79mr17858365ad.9.1762941425924; Wed, 12 Nov 2025
 01:57:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251101214629.10718-1-mt@markoturk.info> <aRRJPZVkCv2i7kt2@vps.markoturk.info>
 <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
In-Reply-To: <CANiq72kfy3RvCwxp7Y++fKTMrviP5CqC_Zts_NjtEtNCnpU3Mg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 12 Nov 2025 10:56:53 +0100
X-Gm-Features: AWmQ_bmwDCOcARGiEKIpjIRnRae5yfDKTRIUwc3OloyDgPkRmaMpijy0lYQ_hkA
Message-ID: <CANiq72=yQ1tn0MmxNHPO4qOiGm7xZzHJAdXFsBBwmFdsC37=ZA@mail.gmail.com>
Subject: Re: [PATCH] samples: rust: fix endianness issue in rust_driver_pci
To: Marko Turk <mt@markoturk.info>, Dirk Behme <dirk.behme@de.bosch.com>
Cc: dakr@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 12, 2025 at 10:37=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Cc'ing Dirk, since he tested the sample originally.

i.e. a new Tested-by is appreciated if you have the time since you
tested with QEMU originally, even if this is a no-op in x86 (where I
think you tested).

I guess we could potentially consider something like returning a
wrapper to force us to explicitly pick either LE or BE to prevent
things like this.

Cheers,
Miguel

