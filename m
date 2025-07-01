Return-Path: <linux-pci+bounces-31162-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6AAAEF771
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 13:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 951DD188EE34
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 11:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8729127A448;
	Tue,  1 Jul 2025 11:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0JUONJrG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDB527A46E
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751370601; cv=none; b=VIz56uLri2TCyz2dJNkgekI9Su8zLf/upoQkaWjv92cmJICskza5akTkr6tgjdr9rB864g1GO3IAM+sIWY4j1+KolkSCmPiLL1qyQH0yqH0U3Amb/tZDYdaR0VJ7kCMI8e8rj/qy5t73QxlFuWjoKhbql3XFHocWPl6MRmR7dXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751370601; c=relaxed/simple;
	bh=R+rwOhIowzKwTY9h4u5eqn86gDd48p2rdXWg3ykB4X0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lYCy0SnMmd/2pd8Ba0tyIIqoYNupnQ7+s9O+M5Vc2YoGPXSyWGNlTPns94tl3HAw956lMi4iEheR1ZM7jyr7o9QEtTDfoe1DckgC5ykNCkEEx/RpGVO0Bd+bfw6pmnFvxbkVxxjcxgRHiVl/taxrQt/hQTn0wycB0Ti384/Iy3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0JUONJrG; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a50fc819f2so4011972f8f.2
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 04:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751370598; x=1751975398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0KGSBavzhT3TpQui0uI73A+Z+3UDA0xLLxmDbt54UW0=;
        b=0JUONJrGzkaw1i/zUiw+03ML/aAkfY8AGX628MberDpxPEpBMbOcvlBo2B37+WvDjE
         KdmyhJruSd1D+AMUAahBFaAcxNFpYddVLdNYsz9zqcbF5HQx8hzudHvVAwOrVZnn44Vr
         1vmmX7WWsiTNf35fnB9i4tmZezAuKiC6Ryepj/79CeQk5HetymnC7+rHM3ZXAzfOW2jd
         svPMSuF84qClbkXmj3fwCLAdmCa5zA9HRvWVCyjCMTTvGTosPu+83DpVXFcLCd8TsJpq
         JAUr5u4dpiiKRfHT/r36SG1d7jrKtfVxzIm/SHQSc+NM8xsrHo/nrH7WXRZQI0k7Ml43
         Fphg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751370598; x=1751975398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0KGSBavzhT3TpQui0uI73A+Z+3UDA0xLLxmDbt54UW0=;
        b=ihqKQ58XkrhxueLkZsO7WWXB0OFYm3H3JXx+Xr3+qALXH0j2TbRlRQQb8qJnWOHB/t
         opYOujpp6US6ZXlphqDtOcUr5o3V//c3J2XIBg/sNzRj5cVAv3rY5NOBbPz9jyk0FmwV
         2FklpzgGGq7LHBIB1Gj98p3KbqZsWD8RdexGJPBXSelDnaCxbmiYbjqDbDFtBKZFMB22
         FC33PDmXJZnK+fKg+yQIs6WI6K1Nd/h8M0bjshCO5wrhHCHgwoTqoJ3na1XYOoUL2jpL
         S8hn8dj45JS7KHibK2CVCUskLmfzHGmXJP56IP4kNnjsYzlo9Qh4QnBY8ErQdW5pXdMd
         QbjA==
X-Forwarded-Encrypted: i=1; AJvYcCXyu4TZF0yJvzfA4obrqhhRzpK2w5PyqlX3FzTC1yIpCsVtGIwsN+IuiGrtWGPBwRdUjsYiLAOmBuk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZV5KCKZU37kWIkCVV+kGag2M6ril3GmYL8s9UefxtjyhtqtQK
	WauzmjmJwwwUJGnj8NFrvh/iCXHw9UqVHpyvjWzWIGmcPTr73WZMTKE3eF/Sf+LTV7TbRyooNBW
	QVDE3qNRkwDQLT3bZunSMY2jTZFIjaGyIaXznZS+U
X-Gm-Gg: ASbGnctrXMjv4aeqRKqstZV3ycrfisRnRbnk//+FTpIpqln/8Wz8MF/hu2XPftZVUfc
	NRIYlQMhoG5FqUCHMsXtw4aCoOvCdIMdagwvefEcCms4l/bigr+4I6rFMwFx8kyVd7rB803ucFg
	Yrg9UILJLGWYjvnIrUUT3hJR8ncRq6pdP5J+cfy5dss5Fz
X-Google-Smtp-Source: AGHT+IGZXsC8mGRscscDusoREbjL9I6GGdeiYS8C2b53bnLNCJ1i8gfIkCUFcIsBDQNQAE78Y338ALuI+8cM8titd0w=
X-Received: by 2002:adf:c084:0:b0:3a4:f9e7:2796 with SMTP id
 ffacd0b85a97d-3a9176038c6mr11687442f8f.35.1751370597647; Tue, 01 Jul 2025
 04:49:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250626200054.243480-1-dakr@kernel.org> <20250626200054.243480-5-dakr@kernel.org>
In-Reply-To: <20250626200054.243480-5-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Jul 2025 13:49:45 +0200
X-Gm-Features: Ac12FXwadsx85yoxejxv-zSg2WaTwJMeTKN6Q-FEKtOdJN3NxG-K0L-aW-nbazs
Message-ID: <CAH5fLghrF84T2V_0yckusmpBEdPgS2YPRDLw9iww9rAY3_qqCg@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org, 
	tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com, 
	leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 10:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> ForeignOwnable::Target defines the payload data of a ForeignOwnable. For
> Arc<T> for instance, ForeignOwnable::Target would just be T.
>
> This is useful for cases where a trait bound is required on the target
> type of the ForeignOwnable. For instance:
>
>         fn example<P>(data: P)
>            where
>               P: ForeignOwnable,
>               P::Target: MyTrait,
>         {}
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I am skeptical about this patch. I think that most of the time, you
should just place the trait bound on `P` instead of having a Target
type like this.

Alice

