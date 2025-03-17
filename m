Return-Path: <linux-pci+bounces-23927-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAEB5A64CE4
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 12:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 433413B1918
	for <lists+linux-pci@lfdr.de>; Mon, 17 Mar 2025 11:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3E0E2376EC;
	Mon, 17 Mar 2025 11:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFI7J1o3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1A237180;
	Mon, 17 Mar 2025 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211396; cv=none; b=k3wKffh08CvfR6uXUhyYDYQsz+mPFzYHvEru/HrPpkmtuzcFYlLx9v4pcp1NMhc2012YAgEjwRRuBMDodWchUSnWDJEycMhgMXhUsM7NiTmrTdhZRHqAT59hvBeJSGzjQt8pW0LPg7ekTuJ8HpHvjdaPzLqjHy5Y4sNRUQbh/SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211396; c=relaxed/simple;
	bh=UPKa7wiKNJ4NEmUO8InLKxXfcJGuNHIW7cyYlKij5nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dbyXxNRloBU/iNOpkrBwckyrmtXnmZZtYAgqhFSpaOVP/qWD9C+WnpwsIIt7LyOLKjyMudh0i084WpGb27QDipQGH9QhoelOGX+XASvXw+U0Vg+4NXjUc8sqvL5t60rnx9UTZvw+/mMUkZJxddJzEKONs4C3Qro5k8IEP23k1VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFI7J1o3; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-54954fa61c8so4277826e87.1;
        Mon, 17 Mar 2025 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742211392; x=1742816192; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q26ZKpH76gWldlWfJMlBYwp9Cc8xJFkwA1QjjgV34Lk=;
        b=gFI7J1o3N9phsdYWJkSSMgSVQVH4PJRAOaNP2TVskJ6GUfkFiVjzZec9pUFX7NuLK1
         HNVI8hKxWauz4kUA55mg3Zl1nMY3iqHhoV+xCP7BvGAa0Udu1ykrl2p/v9USGMZ7lb7b
         LTdbU3n53EyBDoHGW9D/ZlyxGh4N3CdJXmSJuPOF+oe2RG7YLQwGHzw1TNNrhUqIcqG+
         sKlXsrfe+t0UT7HJBH501UobukOvmtGQ0J/k3nHCzg+KgIf1a6YQIzukwfCP99TEyXAv
         InG7nwbLxXz8xL4yUa2ADp8/d3WVaad/1yyJ64yBCEVVoPwJ1OJHJgTEOn5C8mrVmyoS
         6HyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211392; x=1742816192;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q26ZKpH76gWldlWfJMlBYwp9Cc8xJFkwA1QjjgV34Lk=;
        b=OhifFdIQxFwDAZPyPmVTMTSYICOzSJU4T3HjzvSa+FaJ+tZIdvgPfD/5Tze2/xHKsZ
         OxJYyXiIxWFda4aa508h0T4RHXVOPFypBOHjdXAHrIa1cq7FUZajxG08zeARay3JM4uM
         aMObHyi1Wfdhu8sVXJWfKmnc/6jiCchOj6ELwLa9wi+UKN0IHMcPtbtGyClfW6ITm/DJ
         fLXuDhg9zo7zo9Tw6rO60egpljuEuhdJUvrahYHqQPY6ckxNFuFwfOOx5KwYg7lOO6NO
         CXojLH+89PlB2evj1yWz5O2mcHS65twwgc3rny/gkFwmlY+5BGyFG8m7vknffGuczTxl
         Laow==
X-Forwarded-Encrypted: i=1; AJvYcCUA46/C2OZ6S+6/zdR8UzIQFMSi4tXEuJcFzoFNuJsoE3Fn+kcx5rQC+noaoTy6RqwvFFoWQ7VWsIrd9JY=@vger.kernel.org, AJvYcCVO4Oy1QbG1BR1Y0x4uaqX4i7th7Gjd/E3xNSoogQnH6ANqXpIXhsr2noL+5xEYfO3F1SvIIP0S9qEb@vger.kernel.org, AJvYcCX7w8FnFjH8e0ZE0leOl0djxDlzQPWzBqyMFIQU6KEtwQSIbRyplZfJuptrvDWKORd7SjLZyDO1q1FFLaX56jM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4dl1FtXjR8SFywlTJZaTxs2izx3LsPL7nYmS8Vt2TAviIYS7I
	ytHTugi0ZehkUIukJhSgm4OnfeCn9u8pMIAKdRl0QqxXLwIAStELsqUsUNkDwWuAxrUDtf5c9go
	HulWRzqAyRW/xPwR9EfcIdQ296XNi80xI/heHLg==
X-Gm-Gg: ASbGncuJ9vbZe29Z3AobpafnjxVJPBHwIpTeHhOlq4fA3EjjR8wkSUwJaspOohO+WL3
	oBfZQ9EISTCl7bW4fOr+qBPntRlB5Q0Kt0JtmQ/Ssnj3vKowb5i3QOM25DxF0VB6gymSOGYDO2w
	ktSoT/RPu8EuuLMjyFagTTVQy9FxyjKQ1AV2OMGcpLOpMib+SN4FdEtfQ/bGbO
X-Google-Smtp-Source: AGHT+IHKqFv0QNgyNezjaUTh1jqs1i1u4D5VOcfc/jBhkheVjMTPqz7Xk+BLw3dKO3MCJO8k+5okzMXlhyMs80nnbh4=
X-Received: by 2002:a05:6512:696:b0:549:8b24:9896 with SMTP id
 2adb3069b0e04-549c360f4a4mr6772488e87.0.1742211392331; Mon, 17 Mar 2025
 04:36:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com>
 <20250307-no-offset-v1-2-0c728f63b69c@gmail.com> <Z9gIvLY1uubS6OX-@google.com>
In-Reply-To: <Z9gIvLY1uubS6OX-@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Mon, 17 Mar 2025 07:35:55 -0400
X-Gm-Features: AQ5f1JpZP3thvWGP6w51ph9dB-EdEsYxhhkkDjeOo_BaONfdRSLst3QLx0ZAYPo
Message-ID: <CAJ-ks9njZbqRFVXTFkG1ms2UxsHtym+gP6Od-Hz+=sj+VeTX3g@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
To: Alice Ryhl <aliceryhl@google.com>
Cc: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 7:34=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Fri, Mar 07, 2025 at 04:58:49PM -0500, Tamir Duberstein wrote:
> > Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> > the interface of `HasWork` and replacing pointer arithmetic with
> > `container_of!`. Remove the provided implementation of
> > `HasWork::get_work_offset` without replacement; an implementation is
> > already generated in `impl_has_work!`. Remove the `Self: Sized` bound o=
n
> > `HasWork::work_container_of` which was apparently necessary to access
> > `OFFSET` as `OFFSET` no longer exists.
> >
> > A similar API change was discussed on the hrtimer series[1].
> >
> > Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5b=
d3bf0ce6cc@kernel.org/ [1]
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
>
> Overall looks good to me, but please CC the WORKQUEUE maintainers on the
> next version.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
>
> Rust Binder still builds with this change:
>
> Tested-by: Alice Ryhl <aliceryhl@google.com>
>
> > -    where
> > -        Self: Sized,
>
> I did have trait object support in mind when I wrote these abstractions,
> but I don't actually need it and I don't think I actually got it working
> with trait objects.
>
> Alice

Thanks! Does there need to be another version? No changes have been request=
ed.

