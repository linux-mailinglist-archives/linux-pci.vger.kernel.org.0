Return-Path: <linux-pci+bounces-25629-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0269AA84616
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 16:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC85189BC03
	for <lists+linux-pci@lfdr.de>; Thu, 10 Apr 2025 14:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A3912853FA;
	Thu, 10 Apr 2025 14:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gS4nQLJK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81C921CC6A;
	Thu, 10 Apr 2025 14:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744294594; cv=none; b=Rr9uFLRB2czwGLigFPZtAyXB4gD7zFwIASQ6P0scQ17njHtJZIHSdmBcutH3wfmu6OBX0xKBZzu6im3mo8Kx91zWBWSFCB7YywxcJw4xP4pyonkTYETenKLMwYdDrS9zzteImthJ4hVQ5iFdwfOWUHqSZjKFRrV+ZuZV2rzR9S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744294594; c=relaxed/simple;
	bh=wpnB+mY98/YzeerltwfWpXe/v1r9KQTMtXB8eBWKulE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e3NG+sKSNcv3NhF3pXFimLRbcYGi2X+kMeBHeQ8lqnJG7ywNNCc72PIRW417up7j5r0G8AReYY3/QZ2XkWljMMGRHQ9OdqQmTfdlLXZ2KmrhcVIOiYRqJY4ag1BNuamxQoDrm1Z8w2brbeChtRos6vyZ7GQWKsXMsdhBfOjldII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gS4nQLJK; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30eef9ce7feso8409401fa.0;
        Thu, 10 Apr 2025 07:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744294590; x=1744899390; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/LuqIm7oDS3cJFB5A2Gy16/wM9hH8Ae4bhB21+gT2cY=;
        b=gS4nQLJKh6V7lenem95flPd8uiBi8qFNTDVHZvMleCrRzRQwVsTIUuXcQb3YhNEGpB
         ij1dIjOUokVrpVNKpyAqf4DRAhKnvga9ec8M2KAmTGzM4M9gLsIZxah8hzc3maST5c9S
         3+rgq2B3R8QQ1U1342L5KMKMhk7WsJbWx1NZKSRS9Y6VY1YkNuXsEV/WkWpz02fGNSqk
         2yurk1TkM76LOu0JrXNSw6RRlvFuft1P/V0iDxl6oTEZujTiAqTl2QgsRc+OYi+wsw6J
         p0V6G7fvVGi1/VI1vAuZoqHibxIQaTjuY0UsUyPjKtKwxyf9HbC1n8Ot/TlWjV5CLu0E
         E6yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744294590; x=1744899390;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/LuqIm7oDS3cJFB5A2Gy16/wM9hH8Ae4bhB21+gT2cY=;
        b=fSkkP1PVQMomCHPOYp+Bg1lQ/qNUMsbuY8bqRz0wkM53RQjD4/DHm71qs8O19QsvOy
         PPtJgJJlmvUWS4tpg4NLA4Y7Q+J/RvYENhMzfG8I5OLfkEusW9v2E1QlITMPIMdo73pi
         54XiN4nBkLhQgf1GFwB2Rdritq3lCNYBX7yynyjlhvNbcjLlK++ON2z4oy3FLwbUyA0L
         VuKpg1U49/7kto32uuuesfrSBQIgpm9MzOX+/ih3ofzrsKlwqyfOLhCyji2RVn57zAop
         6FJLS+R4YFxjm9mzF0eL2TOfU+eJtnfb/T1jYF6bSlYdW8ecF4MSvJicyvpuWZlNtJYx
         ri1A==
X-Forwarded-Encrypted: i=1; AJvYcCV22peE0oAvnc30q4vbp81LUmk3wbaK3CB3WesfhHwOFiwAatZhJa9T4egC8/5uZjMZlsTwIsnpHTg6LWM=@vger.kernel.org, AJvYcCVan8rjnKruSWpjM6wiwu9dJ8r8ydwZoP4VL5a0upwKgUXAyt0RZdhmbt4mBeEmykr6+Rrnz16ITdur@vger.kernel.org, AJvYcCWp4BPKkzhfsniCIL096QoSYLtHWqDpuawn2DD8KlibVrQ5rsDs2ebbM9fqlYWimmAXg3c7Qt+luRMX7mNq5GE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4M8aJDpXwxH8XRjliwC4VMlyDQnLhLHpSzY8FKEKihZudS78H
	j6vfMrw5WipKFnVglOBEhhiWZQBlbFhSB6xl41l/+EzINE7CI8Tg2AqHvl9geROANj57xSdViXo
	wtJq0uw4/hgqfdEtx5NiZwPwCgIc=
X-Gm-Gg: ASbGncvv3gwMcVPP/tCVjEEadxUjPXlD3U+V6gAiH6toTbWBgaExUtRaqn5Z8zcPmAO
	tghYFvpIaDgOuAfZoZk5mExLyJiSI9vQ9pTWEiyNLheQ0i9ETD+yGhOeCjAUBiFjNumw5+WYF6O
	AqxD7XMRr0D0aaVxWLAdQFxFhPr2gfwEN+yI6iRg==
X-Google-Smtp-Source: AGHT+IEKYFsCJw05RuYVwzcEOx6C4Kdg0vX7NCgG95ngBstS4sq7EDxb6p4TkKQLd/5jeOhcyilGdhzUG5optTokoLU=
X-Received: by 2002:a05:651c:515:b0:308:e8d3:7578 with SMTP id
 38308e7fff4ca-30faccc2c3dmr9320731fa.35.1744294589559; Thu, 10 Apr 2025
 07:16:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250409-no-offset-v2-0-dda8e141a909@gmail.com>
 <20250409-no-offset-v2-2-dda8e141a909@gmail.com> <Z_eMe7y0ixrBrHaz@google.com>
In-Reply-To: <Z_eMe7y0ixrBrHaz@google.com>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 10 Apr 2025 10:15:53 -0400
X-Gm-Features: ATxdqUG2ZcipzfhLY0pg0ohs4AsJQbvOEHI9iiCmTdCNpeZTeZnJKPrpt4cauq4
Message-ID: <CAJ-ks9kms_jFEAHX9MnW1pUOyTeuFuyWwXk-A+qhCPQQNfJdAw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] rust: workqueue: remove HasWork::OFFSET
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 10, 2025 at 5:16=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> On Wed, Apr 09, 2025 at 06:03:22AM -0400, Tamir Duberstein wrote:
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
> > Reviewed-by: Benno Lossin <benno.lossin@proton.me>
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> > Tested-by: Alice Ryhl <aliceryhl@google.com>
> > Signed-off-by: Tamir Duberstein <tamird@gmail.com>
> > ---
> >  rust/kernel/workqueue.rs | 45 ++++++++++++----------------------------=
-----
> >  1 file changed, 12 insertions(+), 33 deletions(-)
> >
> > diff --git a/rust/kernel/workqueue.rs b/rust/kernel/workqueue.rs
> > index f98bd02b838f..1d640dbdc6ad 100644
> > --- a/rust/kernel/workqueue.rs
> > +++ b/rust/kernel/workqueue.rs
> > @@ -429,51 +429,23 @@ pub unsafe fn raw_get(ptr: *const Self) -> *mut b=
indings::work_struct {
> >  ///
> >  /// # Safety
> >  ///
> > -/// The [`OFFSET`] constant must be the offset of a field in `Self` of=
 type [`Work<T, ID>`]. The
> > -/// methods on this trait must have exactly the behavior that the defi=
nitions given below have.
> > +/// The methods on this trait must have exactly the behavior that the =
definitions given below have.
>
> This wording probably needs to be rephrased. You got rid of the
> definitions that sentence refers to.

I don't follow. What definitions was it referring to? I interpreted it
as having referred to all the items: constants *and* methods.

Could you propose an alternate phrasing?

