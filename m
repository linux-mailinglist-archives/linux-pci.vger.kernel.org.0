Return-Path: <linux-pci+bounces-33102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E75DB14BF2
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 12:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B089A168DA1
	for <lists+linux-pci@lfdr.de>; Tue, 29 Jul 2025 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6962728724F;
	Tue, 29 Jul 2025 10:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HbxPeDlZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E021F7554;
	Tue, 29 Jul 2025 10:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753783874; cv=none; b=GJLg33qELnWIxTHcFVUcnQaCHdb0NEXbYqWU0XVoAdy9R7UaPG46FNCNBTxSJHK8VJef62h0ltAE8kcyaCabnLbLDJV9QSOtWt3kX0gQaAaLv1cIePetvEjK0lS00M+1zn1hPX2D8bm8UcOwh4XsrC0cvjXRQ+SzocFnULTXj9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753783874; c=relaxed/simple;
	bh=snQFRP50p3EHBOmj1SKRfP+MI/4YY4DP1xiijUu2k0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tXQJgOCppP4K9GgS64JiDhfWlSfn+bz/EobW/EaNZNVm1TCKNpqf9pML+SZVlAQMSgpLI2aOHNCtpIm3HW7fMxdWDhufh7HMjqeFeJXUbXUtKjbv1+UXgPh2bE82Gcp9aK4imAQBMWc374OwmrZZl0mozIjSXroyz/bLOw71wTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HbxPeDlZ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-23fd901c4d2so3711925ad.0;
        Tue, 29 Jul 2025 03:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753783872; x=1754388672; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snQFRP50p3EHBOmj1SKRfP+MI/4YY4DP1xiijUu2k0U=;
        b=HbxPeDlZjEC5bvbHtXAXDuOOU6Cs6ctFkBhdC8sQr0ui6E56XF9/+l5o4F6sZAXdeL
         vLme1LgXV+AkEtVi5aPmYQ/EBgfBqy2yQVgvTv1YM/dOarY2ULkcXWF/4klg0PguPQcm
         gzEzvTGgz/JBmp/YUiGs1Iv3MwTU/BNZjyCkYoZenwvjIzgiJJ8TUc3RwnOykmHbLSd6
         3euQH/7xA3G5pUSIUOWhlmVdDfk3VURGuleC/FN+jCEbSatG8HHeGtfYxPJebyHTG+Ec
         omv1Gz0qREwk7tGCJR23QP0QhVuuLAJrhH7rRUnU/8ERxOqARSUEZFWvoI2rDJVDJayd
         cEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753783872; x=1754388672;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snQFRP50p3EHBOmj1SKRfP+MI/4YY4DP1xiijUu2k0U=;
        b=holNG9wsLr77Y0JSvUW2Jx/IqGoDDQbzlQxGQofop26LUWHuiiKO+/3ncImoEMamXn
         ns+zd5qryRSWnb+xzNPq96f1tfdge75UiLodiO3zMXd3NoDy0HPRdZzasP38dPHN4FRt
         2rYShU8dC4LoG88Wnko4tBxWfiIun9bi9WjX9Jyb7gWIJFa2n4pLhbZjtENk2AWBFzVg
         a/8yNYvDjIcYK14LEy65y2zNeg9wcaNwl9EosLpeFY/soYtIxXKeCPwVo3uRZnaoxRH/
         uglR+tcPrPBZpHiVdvSCMSlG5ra513X15SgfwCJIL4Y9gVIH2fSDHmTHsNO4wB2C5q37
         xJqw==
X-Forwarded-Encrypted: i=1; AJvYcCU7kMUlDf5wAL76GBdrEN8mv9swH5ndaQEfwuQZJo0JVijBYQDd2YAYOFH1MXTJRkKeG/MBFMWSRTHcr+4=@vger.kernel.org, AJvYcCUkT1f/DERit/J/s0Y7x2CenbHtIkAvUTViofmLa9OgNmc5UjH3FG64aaLiJqvdJDHl+lSATN0ch9FeaXt086M=@vger.kernel.org, AJvYcCWtkOobMUmA3o9M6Dkys0KHGYNKOBlRijdbBgCXDRC+ejA1nWh/aMfAWONqU1eug9djh7o+p51cvzlh@vger.kernel.org
X-Gm-Message-State: AOJu0YwN41865PahKM+jGLMhRvbt4gZAl1OKRIdsboFwSB33XvAemNGl
	4H1O8sXHEsDZEUCeNZapfhxNabgR2TNqvZ+OVZQO2tBYLcg4iKxJZ+zzPzJ1eitK3Vl7127+QLB
	A9DS2YQCfk4Ka7HWPb2c2qgRa3DEq3APP/j9jeg8=
X-Gm-Gg: ASbGncsBugQNrcsZtiwfxZ3TI2ake5sG8XQzDaOoz0io7P3tz00CKDz0sAiNN49cnzA
	iWsI5lFcmPRXdaKfZ7M8QVLy9/MzN90Q+PuEj/mDoap9bmB7SiYs+uD7huF3QTwVB0rHD1WjVJB
	4H9nupAWcOYZGwqjVuCp9wNk5jI4bKcZ65CkJU3pzo4T18UsUJmVB2xt+Q7LEYyTelqroJaqOnF
	BmZ4BxL
X-Google-Smtp-Source: AGHT+IHx0GUnofdiB57+6goXGATGo/R/vo6ovtijDe50tv9vBdJgiyyT/dJhFBzyBZgP2+LgoNqWp1Jp3n7lA8T8UZE=
X-Received: by 2002:a17:90b:4b88:b0:31e:ffd4:ecdc with SMTP id
 98e67ed59e1d1-31effd4edb9mr2998838a91.7.1753783872256; Tue, 29 Jul 2025
 03:11:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250729002941.7643-1-abhinav.ogl@gmail.com> <DBOFY80IDMWJ.627ZOACP7KK5@kernel.org>
In-Reply-To: <DBOFY80IDMWJ.627ZOACP7KK5@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 29 Jul 2025 12:10:59 +0200
X-Gm-Features: Ac12FXyDvgR6WDLVoVoaas8ap-FjV1FrKXwGSr5NqDylxCmVF3795DEZpR3NP_U
Message-ID: <CANiq72nRJhhM6W4ue0KR+En1nYDk5KVS1dSuJkkw55jkrh_P8Q@mail.gmail.com>
Subject: Re: [PATCH] rust: pci: use c_* types via kernel prelude
To: Danilo Krummrich <dakr@kernel.org>
Cc: herculoxz <abhinav.ogl@gmail.com>, bhelgaas@google.com, kwilczynski@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 29, 2025 at 11:45=E2=80=AFAM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Something seems to be odd with the commit message, it seems some parts ar=
e
> missing.

The "ensures ABI correctness when interfacing with C code" should also
be changed -- it is true that we want to use the identifiers from the
prelude, but the ABI was fine here, since it was already using
`kernel::`.

i.e. otherwise, it would have been a fix.

Cheers,
Miguel

